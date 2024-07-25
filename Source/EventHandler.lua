local addonName, ahn = ...

ahn.frame:RegisterEvent("ADDON_LOADED")
ahn.frame:RegisterEvent("AUCTION_HOUSE_SHOW")
ahn.frame:RegisterEvent("AUCTION_HOUSE_CLOSED")

if ahn.isMainline then
    ahn.frame:RegisterEvent("AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION")
else
    ahn.frame:RegisterEvent("CHAT_MSG_SYSTEM")
end

local function handleMainlineUpdates(event, updateType)
    if event == "AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION" then
        ahn.updateMainlineAuctionStatus(event, updateType)
    end
end

local function handleClassicUpdates(event, updateType)
    if event == "CHAT_MSG_SYSTEM" then
        ahn.updateClassicAuctionStatus(event, updateType)
    end
end

-- Defines the method to handle auction updates based on the game version
function ahn.handleAuctionUpdates(event, updateType)
    handleMainlineUpdates(event, updateType)
    handleClassicUpdates(event, updateType)
    ahn.playSound()
    ahn.resetAuctionStatus()
end

-- Toggles ahIsOpen based on its current status
function ahn.handleAuctionHouse(event)
    if event == "AUCTION_HOUSE_SHOW" then
        ahn.ahIsOpen = true
    elseif event == "AUCTION_HOUSE_CLOSED" then
        ahn.ahIsOpen = false
    end
end

-- Once AuctionHouseNotifications loads, updates SavedVariables and interface options
function ahn.handleAddonLoaded(event, addon) 
    if event == "ADDON_LOADED" and addon == addonName then
        ahn.createSavedVariables()
        ahn.updateInterfaceOptions()
        ahn.showGreetingMessage()
        ahn.frame:UnregisterEvent("ADDON_LOADED")
    end
end
