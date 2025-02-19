local addonName, ahn = ...

ahn.frame:RegisterEvent("ADDON_LOADED")
ahn.frame:RegisterEvent("AUCTION_HOUSE_SHOW")
ahn.frame:RegisterEvent("AUCTION_HOUSE_CLOSED")

if ahn.isVanilla then
    ahn.frame:RegisterEvent("CHAT_MSG_SYSTEM")
else
    ahn.frame:RegisterEvent("AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION")
end

-- Defines the method to handle auction updates based on the game version
function ahn.handleAuctionUpdates(event, updateType)
    if event == "CHAT_MSG_SYSTEM" then
        ahn.updateVanillaAuctionStatus(updateType)
    elseif event == "AUCTION_HOUSE_SHOW_FORMATTED_NOTIFICATION" then
        ahn.updateOthersAuctionStatus(updateType)
    end
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
