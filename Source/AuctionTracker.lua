local _, ahn = ...
local L = ahn.L

local currentCharacterName = UnitName("player")
local currentRealmName = GetRealmName()
local currentCharacterKey = currentCharacterName.."-"..currentRealmName
local auctionTrackerTickerSeconds = 5
local maxTrackedAuctionAge = 30 * 86400 -- 30 days
local classicMaxAuctionTimes = {
    [1] = 1800,    -- 30 min
    [2] = 7200,    -- 2 hours
    [3] = 43200,   -- 12 hours
    [4] = 172800,  -- 48 hours
}

-- Session-only set of auctionIDs already in AHNSavedData; prevents re-adding on
-- every OWNED_AUCTIONS_UPDATED without persisting a redundant lookup structure
local knownAuctionIDs = {}

local function getItemName(itemID)
    return C_Item.GetItemInfo(itemID) or "Item #"..tostring(itemID)
end

local function getClassicAuctionInfo(auctionIndex)
    local _, _, count, _, _, _, _, minBid, _, buyoutPrice, bidAmount, _, _, _, _, saleStatus, itemId =
        GetAuctionItemInfo("owner", auctionIndex)
    return count, minBid, buyoutPrice, saleStatus, bidAmount, itemId
end

-- Uses itemId+count+minBid+buyoutPrice as a pseudo-ID since Classic 
-- has no per-auction unique identifier like the modern auctionID
local function getVanillaActiveAuctions(numAuctions)
    local auctions = {}
    for i = 1, numAuctions do
        local count, minBid, buyoutPrice, saleStatus, bidAmount, itemID = getClassicAuctionInfo(i)
        local auctionIsActive = saleStatus == 0
        local auctionHasBid = bidAmount and bidAmount > 0
        local timeLeft = GetAuctionItemTimeLeft("owner", i)
        if itemID and itemID ~= 0 
        and timeLeft and timeLeft ~= 0 
        and auctionIsActive 
        and not auctionHasBid then
            local auctionID = itemID.."_"..(count or 0).."_"..(minBid or 0).."_"..(buyoutPrice or 0)
            auctions[auctionID] = { itemID = itemID, timeLeft = classicMaxAuctionTimes[timeLeft] }
        end
    end
    return auctions
end

-- Builds a lookup of every auction ID currently active on the server (modern API)
local function getModernActiveAuctions(numAuctions)
    local auctions = {}
    for i = 1, numAuctions do
        local info = C_AuctionHouse.GetOwnedAuctionInfo(i)
        if info then
            local itemID = info.itemKey and info.itemKey.itemID
            local auctionIsActive = info.status == Enum.AuctionStatus.Active
            local auctionHasBid = info.bidAmount and info.bidAmount > 0
            local timeLeft = info.timeLeftSeconds
            if itemID and itemID ~= 0 
            and timeLeft and timeLeft ~= 0 
            and auctionIsActive
            and not auctionHasBid then
                auctions[info.auctionID] = { itemID = itemID, timeLeft = timeLeft }
            end
        end
    end
    return auctions
end

local function trackNewActiveAuctions(currentTime, auctions)
    for auctionID, info in pairs(auctions) do
        if not knownAuctionIDs[auctionID] then
            table.insert(AHNSavedData.trackedAuctions, {
                auctionID = auctionID,
                charKey   = currentCharacterKey,
                character = currentCharacterName,
                itemID    = info.itemID,
                expiresAt = currentTime + info.timeLeft,
            })
            knownAuctionIDs[auctionID] = true
        end
    end
end

local function sweepAuctions(activeAuctions)
    local auctionsToKeep = {}
    for _, auction in ipairs(AHNSavedData.trackedAuctions) do
        local auctionID = auction.auctionID
        if auction.charKey == currentCharacterKey 
        and not activeAuctions[auctionID] then
            knownAuctionIDs[auctionID] = nil
        else
            table.insert(auctionsToKeep, auction)
        end
    end
    AHNSavedData.trackedAuctions = auctionsToKeep
end

function ahn.scanAndTrackNewAuctions()
    local currentTime = time()
    local activeAuctions
    if ahn.isVanilla() then
        local numAuctions = GetNumAuctionItems("owner")
        if numAuctions == 0 then
            return
        end
        activeAuctions = getVanillaActiveAuctions(numAuctions)
    else
        local numAuctions = C_AuctionHouse.GetNumOwnedAuctions()
        if numAuctions == 0 then
            return
        end
        activeAuctions = getModernActiveAuctions(numAuctions)
    end
    trackNewActiveAuctions(currentTime, activeAuctions)
end

function ahn.sweepRemovedAuctions()
    if ahn.isVanilla() then
        local numAuctions = GetNumAuctionItems("owner")
        if numAuctions == 0 then
            return
        end
        sweepAuctions(getVanillaActiveAuctions(numAuctions))
    else
        local numAuctions = C_AuctionHouse.GetNumOwnedAuctions()
        if numAuctions == 0 then
            return
        end
        sweepAuctions(getModernActiveAuctions(numAuctions))
    end
end

function ahn.handleVanillaExpiredAuction(message)
    local itemName = ahn.extractItemNameFromVanillaExpiredAuctionMessage(message)
    if not itemName then
        return
    end
    if ahn.ahIsOpen then
        ahn.sweepRemovedAuctions()
        return
    end
    -- AH is closed: can't query the live list, so mark matching auctions with
    -- expiresAt=0 so the next ticker pass silently drops them (no false notification
    -- fires because currentTime - 0 > maxTrackedAuctionAge)
    for _, auction in ipairs(AHNSavedData.trackedAuctions) do
        if auction.charKey == currentCharacterKey 
        and getItemName(auction.itemID) == itemName then
            auction.expiresAt = 0
            knownAuctionIDs[auction.auctionID] = nil
        end
    end
end

local function getExpiredAuctionMessage(auctionGroup, auction)
    local itemName = getItemName(auction.itemID)
    local coloredItemName = "|cFFFEE15C"..itemName.."|r"
    local coloredCharName = "|cFFFF8000"..auction.character.."|r"
    if auctionGroup.count > 1 then
        return string.format(L.crossCharacterExpiredMultiple, coloredCharName, auctionGroup.count, coloredItemName)
    else
        return string.format(L.crossCharacterExpiredSingle, coloredCharName, coloredItemName)
    end
end

local function notifyExpiredAuctions(expiredAuctions)
    -- Group by (charKey:itemID) so posting X of the same item produces one message, not X messages
    local groups = {}
    local order  = {}
    for _, auction in ipairs(expiredAuctions) do
        local key = auction.charKey..":"..tostring(auction.itemID)
        if not groups[key] then
            groups[key] = {auction = auction, count = 0}
            table.insert(order, key)
        end
        groups[key].count = groups[key].count + 1
    end

    for _, key in ipairs(order) do
        local group = groups[key]
        local auction = group.auction
        if auction.charKey ~= currentCharacterKey then
            local message = getExpiredAuctionMessage(group, auction)
            if AHNPreferences.playSounds 
            and AHNPreferences.enableCrossCharacterExpired then
                ahn.playSound(AHNPreferences.chosenSounds.expired, "expired")
                print("|cFFFFFF00"..L.title.."|r: "..message)
            elseif not AHNPreferences.enableCrossCharacterExpired
            and AHNPreferences.showMessageWhenCrossCharacterExpiredIsDisabled then
                print("|cFFFFFF00"..L.title.."|r: "..message)
            end
        end
    end
end

local function scanExpiredTrackedAuctions()
    local currentTime = time()
    local expiredAuctions = {}
    local activeAuctions = {}
    for _, auction in ipairs(AHNSavedData.trackedAuctions) do
        if currentTime >= auction.expiresAt - auctionTrackerTickerSeconds then
            -- Silently discards old records
            if currentTime - auction.expiresAt <= maxTrackedAuctionAge then
                table.insert(expiredAuctions, auction)
            end
        else
            table.insert(activeAuctions, auction)
        end
    end
    AHNSavedData.trackedAuctions = activeAuctions
    if #expiredAuctions > 0 then
        notifyExpiredAuctions(expiredAuctions)
    end
end

function ahn.startAuctionTracker()
    -- Rebuild session cache from persisted records so scans don't re-add
    -- auctions already tracked from a previous session
    for _, auction in ipairs(AHNSavedData.trackedAuctions) do
        if auction.auctionID then
            knownAuctionIDs[auction.auctionID] = true
        end
    end
    C_Timer.NewTicker(auctionTrackerTickerSeconds, function()
        scanExpiredTrackedAuctions()
    end)
end

function ahn.cacheTrackedAuctionsItemNames()
    for _, auction in ipairs(AHNSavedData.trackedAuctions) do
        getItemName(auction.itemID)
    end
end
