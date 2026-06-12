local addonName, ahn = ...
-- ahn: Globals within Auction House Notifications (variables and functions)
local L = ahn.L
ahn.frame = CreateFrame("Frame")
ahn.isVanilla = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC 
ahn.isBurningCrusade = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC
ahn.ahIsOpen = false

local defaultPreferences = {
    chosenSounds = {
        successful = 567483, -- iMoneyDialogOpen
        failed = 567501,     -- iMoneyDialogClose
        expired = 1372       -- PolyMorphTarget
    },
    chosenChannel = "Master",
    enableInAH = false,
    showGreeting = true,
    enableExpired = true,
    playSounds = true,
}

-- Displays the add-on in Options -> AddOns
function ahn.initializeInterface()
    ahn.frame.name = ahn.L.title
    ahn.category = Settings.RegisterCanvasLayoutCategory(ahn.frame, ahn.frame.name)
    Settings.RegisterAddOnCategory(ahn.category)
end

local function toggleNotificationSounds()
    local notificationsAreEnabled = AHNPreferences["playSounds"]
    AHNPreferences["playSounds"] = not notificationsAreEnabled
    if notificationsAreEnabled then
        print(L.disabledMessage)
    else
        print(L.enabledMessage)
    end
end

-- Creates the chat command /ahn that opens the AHN options interface
function ahn.createChatCommand()
    SLASH_AUCTIONHOUSENOTIFICATIONS1 = "/ahn"
    SlashCmdList["AUCTIONHOUSENOTIFICATIONS"] = function(cmd)
        local command = strlower(cmd)
        if command == "" or command == nil then
            toggleNotificationSounds()
            ahn.updateInterfaceOptions()
        elseif command == "options" or command == "o" then
            Settings.OpenToCategory(ahn.category:GetID())
        end
    end
end

local function createNewSavedVariablesFields()
    for key, option in pairs(defaultPreferences) do
        if AHNPreferences[key] == nil then
            AHNPreferences[key] = option
        end
    end
end

-- Creates or updates the user's preferences in SavedVariables
function ahn.createSavedVariables()
    if not AHNPreferences then
        AHNPreferences = defaultPreferences
    end
    createNewSavedVariablesFields()
end
