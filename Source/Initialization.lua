local addonName, ahn = ...
-- ahn: Globals within Auction House Notifications (variables and functions)
ahn.locale = GetLocale()
ahn.L = {} -- Localized text
ahn.L.title = C_AddOns.GetAddOnMetadata(addonName, "Title")
ahn.frame = CreateFrame("Frame")
ahn.version = C_AddOns.GetAddOnMetadata(addonName, "Version")
ahn.author = C_AddOns.GetAddOnMetadata(addonName, "Author")
ahn.locale = GetLocale()
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
    enableExpired = true
}

-- Displays the add-on in Options -> AddOns
function ahn.initializeInterface()
    ahn.frame.name = ahn.L.title
    ahn.category = Settings.RegisterCanvasLayoutCategory(ahn.frame, ahn.frame.name)
    Settings.RegisterAddOnCategory(ahn.category)
end

-- Creates the chat command /ahn that opens the AHN options interface
function ahn.createChatCommand()
    SLASH_AUCTIONHOUSENOTIFICATIONS1 = "/ahn"
    SlashCmdList["AUCTIONHOUSENOTIFICATIONS"] = function()
        Settings.OpenToCategory(ahn.category:GetID())
    end
end

-- Creates a new table to store the user's preferences in SavedVariables
function ahn.createSavedVariables()
    if not AHNPreferences then
        AHNPreferences = defaultPreferences
    end
end
