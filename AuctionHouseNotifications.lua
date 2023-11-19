local ahIsOpen = false  -- Toggles if the Auction House window is open or not
-- Saves the current status of last auction update
local successfulAuction = false
local failedAuction = false
local expiredAuction = false

-- [Structure] Sound category = {file data ID for a successful auction, file data ID for a failed auction}
-- File data IDs and their names: https://wow.tools/dbc/?dbc=filedata&build=6.0.1.18179#page=1
sounds = {                        -- Creates a table with the sounds that the user can choose for alerts
    coins = {567483, 567501},     -- iMoneyDialogOpen, iMoneyDialogClose
    female = {540628, 540560},    -- HumanFemaleCheer01, HumanFemale_err_lootdidntkill06
    fireworks = {567011, 565499}, -- G_FireworkBoomGeneral5, G_BarrelExplodeCustom0
    impact = {567946, 567821},    -- BullWhipHit2, 2hMaceMetalHitMetalShieldCrit
    quests = {567516, 567459}     -- iQuestUpdate, igQuestFailed
}

-- User's preferences (Defaults. Variables used come from SavedVariables)
chosenSounds = sounds.coins -- The alert sound category to be used
chosenChannel = "Master"    -- The sound channel that alerts will use
enableInAH = false          -- Toggles if the addOn will play successful auction alerts when the Auction House window is open
showGreeting = true         -- Toggles if the greeting message will be printed in the chat when the addOn loads
enableExpired = true        -- Toggles if expired auction alert should play

-- Variable "frame" defined in Interface.lua
frame:RegisterEvent("ADDON_LOADED")          
frame:RegisterEvent("AUCTION_HOUSE_SHOW")
frame:RegisterEvent("AUCTION_HOUSE_CLOSED")
frame:RegisterEvent("CHAT_MSG_SYSTEM")

-- Creates the preferences table in SavedVariables
local function createSavedVariables()
    preferences = {}
    preferences.chosenSounds = chosenSounds
    preferences.chosenChannel = chosenChannel
    preferences.enableInAH = enableInAH
    preferences.showGreeting = showGreeting
    preferences.enableExpired = enableExpired
end

local function updateSavedVariables()
    -- Creates user preferences table in SavedVariables if absent
    if preferences == nil then
        createSavedVariables()
    end
    -- Creates options not found in SavedVariables (new option after update)
    for key, value in pairs(preferences) do
        if preferences[key] == nil then
            preferences[key] = value
        end
    end
end

local function showGreetingMessage()
    if preferences.showGreeting then
        print(greetingMessages[locale])
    end
end

-- Detects when AuctionHouseNotifications loads then updates SavedVariables and sets interface options
local function handleAddonLoaded(event, addOnName) 
    if event == "ADDON_LOADED" and addOnName == "AuctionHouseNotifications" then
        updateSavedVariables()
        checkPreferencesInInterfaceOptions()
        showGreetingMessage()
    end
    -- Stops listening to ADDON_LOADED events
    frame:UnregisterEvent("ADDON_LOADED")
end

-- Searches for auction messages (Localization.lua)
local function messageWasFound(messageList, message)
    for _, pattern in ipairs(messageList) do
        if string.find(message, pattern) then
            return true
        end
    end
end

-- Sets the last auction status if CHAT_MSG_SYSTEM matches an auction message
local function handleSystemMessages(event, message)
    if event == "CHAT_MSG_SYSTEM" then
        successfulAuction = messageWasFound(successfulAuctionMessages, message)
        failedAuction = messageWasFound(failedAuctionMessages, message)
        expiredAuction = messageWasFound(expiredAuctionMessages, message)
    end
end

-- Toggles ahIsOpen based on it's current status
local function handleAuctionHouse(event, ...)
    if event == "AUCTION_HOUSE_SHOW" then
        ahIsOpen = true
    elseif event == "AUCTION_HOUSE_CLOSED" then
        ahIsOpen = false
    end
end

local function playSounds()
    -- Plays the chosen sound file data ID the chosen sound channel
    if successfulAuction and (preferences.enableInAH or not ahIsOpen) then
        PlaySoundFile(preferences.chosenSounds[1], preferences.chosenChannel)
    elseif failedAuction then
        PlaySoundFile(preferences.chosenSounds[2], preferences.chosenChannel)
    -- Plays a unique sound file SoundKitId (polymorphtarget) for an expired auction
    elseif preferences.enableExpired and expiredAuction then
        PlaySound(1372, preferences.chosenChannel, true)
    end
end

-- Reverts the values to false so the sounds can be played again
local function resetVariables()
    successfulAuction = false
    failedAuction = false
    expiredAuction = false
end

-- Runs the functions below when one of the registered in-game events occur
frame:SetScript("OnEvent", function(_, event, ...)
    handleAddonLoaded(event, ...)
    handleSystemMessages(event, ...)
    handleAuctionHouse(event, ...)
    playSounds()
    resetVariables()
end)
