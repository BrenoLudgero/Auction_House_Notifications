frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("AUCTION_HOUSE_SHOW")
frame:RegisterEvent("AUCTION_HOUSE_CLOSED")

if isMainline then
    frame:RegisterEvent("AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION")
else
    frame:RegisterEvent("CHAT_MSG_SYSTEM")
end

local function handleMainlineUpdates(event, updateType)
    if event == "AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION" then
        auctionSuccessful = (updateType == soldAuction) or (updateType == wonAuction)
        auctionFailed = (updateType == outbidAuction)
        auctionExpired = (updateType == expiredAuction)
    end
end

local function handleClassicUpdates(event, updateType)
    if event == "CHAT_MSG_SYSTEM" then
        auctionSuccessful = string.find(updateType, soldAuction) or string.find(updateType, wonAuction)
        auctionFailed = string.find(updateType, outbidAuction)
        auctionExpired = string.find(updateType, expiredAuction)
    end
end

-- Defines the method to handle auction updates based on the game version
function handleAuctionUpdates(event, updateType)
    if isMainline then
        handleMainlineUpdates(event, updateType)
    else
        handleClassicUpdates(event, updateType)
    end
end

-- Toggles ahIsOpen based on its current status
function handleAuctionHouse(event)
    if event == "AUCTION_HOUSE_SHOW" then
        ahIsOpen = true
    elseif event == "AUCTION_HOUSE_CLOSED" then
        ahIsOpen = false
    end
end

-- Once AuctionHouseNotifications loads, updates SavedVariables and checks interface options
function handleAddonLoaded(event, addOnName) 
    if event == "ADDON_LOADED" and addOnName == "AuctionHouseNotifications" then
        createSavedVariables()
        createNewOptions()
        checkInterfaceOptions()
        showGreetingMessage()
        frame:UnregisterEvent("ADDON_LOADED")
    end
end
