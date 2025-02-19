local addonName, ahn = ...
-- ahn: Globals within Auction House Notifications (variables and functions)
ahn.locale = GetLocale()
ahn.L = {} -- Localized text
ahn.L.title = C_AddOns.GetAddOnMetadata(addonName, "Title")
ahn.frame = CreateFrame("Frame")
ahn.version = C_AddOns.GetAddOnMetadata(addonName, "Version")
ahn.author = C_AddOns.GetAddOnMetadata(addonName, "Author")
ahn.locale = GetLocale()
ahn.isMainline = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
ahn.ahIsOpen = false

-- FileDataIDs: https://wago.tools/files?search=sound/
ahn.successfulSounds = {
    coins = 567483,     -- iMoneyDialogOpen
    female = 540628,    -- HumanFemaleCheer01
    fireworks = 567011, -- G_FireworkBoomGeneral5
    impact = 567946,    -- BullWhipHit2
    quests = 567516     -- iQuestUpdate
}
ahn.failedSounds = {
    coins = 567501,     -- iMoneyDialogClose
    female = 540560,    -- HumanFemale_err_lootdidntkill06
    fireworks = 565499, -- G_BarrelExplodeCustom0
    impact = 567821,    -- 2hMaceMetalHitMetalShieldCrit
    quests = 567459     -- igQuestFailed
}
ahn.expiredSounds = {
    sheep = 1372,       -- PolyMorphTarget
    thunder = 13006,    -- Shaman_Thunder
    what = 6289,        -- PeasentWhat4
    growl = 3960,       -- mBearAttackD
    chicken = 1024      -- ChickenDeathA
}

local defaultPreferences = {
    chosenSounds = {
        successful = ahn.successfulSounds.coins,
        failed = ahn.failedSounds.coins,
        expired = ahn.expiredSounds.chicken
    },
    chosenChannel = "Master",
    enableInAH = false,
    showGreeting = true,
    enableExpired = true
}

-- Creates the chat command /ahn that opens the AHN options interface
SLASH_AUCTIONHOUSENOTIFICATIONS1 = "/ahn"
SlashCmdList["AUCTIONHOUSENOTIFICATIONS"] = function()
    Settings.OpenToCategory(ahn.frame.name)
end

-- Creates a new table to store the user's preferences in SavedVariables
function ahn.createSavedVariables()
    if not AHNPreferences then
        AHNPreferences = defaultPreferences
    end
end
