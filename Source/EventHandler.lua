local addonName, ahn = ...

ahn.frame:RegisterEvent("ADDON_LOADED")
ahn.frame:RegisterEvent("PLAYER_LOGIN")
ahn.frame:RegisterEvent("AUCTION_HOUSE_SHOW")
ahn.frame:RegisterEvent("AUCTION_HOUSE_CLOSED")

if ahn.isVanilla() then
    ahn.frame:RegisterEvent("CHAT_MSG_SYSTEM")
    ahn.frame:RegisterEvent("AUCTION_OWNED_LIST_UPDATE")
else
    ahn.frame:RegisterEvent("OWNED_AUCTIONS_UPDATED")
    ahn.frame:RegisterEvent("AUCTION_HOUSE_AUCTION_CREATED")
    ahn.frame:RegisterEvent("AUCTION_HOUSE_PURCHASE_COMPLETED")
    ahn.frame:RegisterEvent("AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION")
end

-- Defines the method to handle auction events based on the game version
-- and plays the appropriate sound according to the auction type
function ahn.handleAuctionUpdates(event, type)
    local auctionType
    if event == "CHAT_MSG_SYSTEM" then
        auctionType = ahn.determineVanillaAuctionType(type)
    elseif event == "AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION" then
        auctionType = ahn.determineNonVanillaAuctionType(type)
    elseif event == "AUCTION_HOUSE_PURCHASE_COMPLETED" then
        auctionType = "successful"
    end
    
    if auctionType then
        ahn.playAppropriateAuctionSound(auctionType)
    end
end

-- Scans and starts tracking new auctions; sweeps removed or expired auctions
function ahn.handleOwnedAuctionsUpdated(event, ...)
    if event == "AUCTION_HOUSE_AUCTION_CREATED" then
        -- Force OWNED_AUCTIONS_UPDATED to fire, otherwise the auction
        -- won't be immediately tracked for some unknown reason
        C_AuctionHouse.QueryOwnedAuctions({})
    elseif event == "OWNED_AUCTIONS_UPDATED"
    or event == "AUCTION_OWNED_LIST_UPDATE" then
        ahn.scanAndTrackNewAuctions()
        ahn.sweepRemovedAuctions()
    elseif event == "CHAT_MSG_SYSTEM" then
        ahn.handleVanillaExpiredAuction(...)
    end
end

-- Toggles ahIsOpen based on its current status
function ahn.handleAuctionHouseStatus(event)
    if event == "AUCTION_HOUSE_SHOW" then
        ahn.ahIsOpen = true
    elseif event == "AUCTION_HOUSE_CLOSED" then
        ahn.ahIsOpen = false
    end
end

-- Starts the auction tracker and checks for any auctions that expired while offline
function ahn.handlePlayerLogin(event)
    if event == "PLAYER_LOGIN" then
        ahn.cacheTrackedAuctionsItemNames()
        ahn.startAuctionTracker()
        ahn.frame:UnregisterEvent("PLAYER_LOGIN")
    end
end

-- Once AuctionHouseNotifications loads, updates SavedVariables and interface options
function ahn.handleAddonLoaded(event, addon)
    if event == "ADDON_LOADED" and addon == addonName then
        ahn.createSavedVariables()
        ahn.initializeInterface()
        ahn.createChatCommand()
        ahn.updateInterfaceOptions()
        ahn.showGreetingMessage()
        ahn.frame:UnregisterEvent("ADDON_LOADED")
    end
end
