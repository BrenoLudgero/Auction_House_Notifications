local ahIsOpen = false           -- Creates a variable to identify if the Auction House window is open or not
local successfulAuction = false  -- Creates a variable to identify if the auction was successful
local failedAuction = false      -- Creates a variable to identify if the auction failed
local expiredAuction = false      -- Creates a variable to identify if the auction expired

-- [Structure] Sound category = {file data ID for a successful auction, file data ID for a failed auction}
-- File data IDs and their names: https://wow.tools/dbc/?dbc=filedata&build=6.0.1.18179#page=1
sounds = {                         -- Creates a table with the sounds that the user can use for alerts
    coins = {567483, 567501},      -- iMoneyDialogOpen, iMoneyDialogClose
    female = {540628, 540560},     -- HumanFemaleCheer01, HumanFemale_err_lootdidntkill06
    fireworks = {567011, 565499},  -- G_FireworkBoomGeneral5, G_BarrelExplodeCustom0
    impact = {567946, 567821},     -- BullWhipHit2, 2hMaceMetalHitMetalShieldCrit
    quests = {567516, 567459}      -- iQuestUpdate, igQuestFailed
}

-- User's preferences (defaults, variables used below will come from user's preferences contained in SavedValues)
chosenSounds = sounds.coins  -- The alert sound category to be used
chosenChannel = "Master"     -- The sound channel that alerts will use
enableInAH = false           -- Toggles if the addon will play successful auction alerts when the Auction House window is open
showGreeting = true          -- Toggles if the greeting message will be printed in the chat when the addon loads

-- Variable "frame" defined in Interface.lua
frame:RegisterEvent("ADDON_LOADED")          -- Starts listening to the in-game ADDON_LOADED events
frame:RegisterEvent("AUCTION_HOUSE_SHOW")    -- Starts listening to the in-game AUCTION_HOUSE_SHOW event
frame:RegisterEvent("AUCTION_HOUSE_CLOSED")  -- Starts listening to the in-game AUCTION_HOUSE_CLOSED event
frame:RegisterEvent("CHAT_MSG_SYSTEM")       -- Starts listening to the in-game CHAT_MSG_SYSTEM events

local function createSavedVariables()  -- Responsible for creating the preferences table in SavedVariables (first login)
    preferences = {}                         -- Creates an array for user preferences
    preferences.chosenSounds = chosenSounds  -- Saves the default values
    preferences.chosenChannel = chosenChannel
    preferences.enableInAH = enableInAH
    preferences.showGreeting = showGreeting
end

local function handleAddonLoaded(event, addOnName)  -- All ADDON_LOADED events are handled here
    if event == "ADDON_LOADED" and addOnName == "AuctionHouseNotifications" then  -- If an addon loads and is called AuctionHouseNotifications:
        if preferences == nil then            -- If user's preferences are absent from SavedVariables:
            createSavedVariables()            -- Creates the table for user's preferences
        end
        checkPreferencesInInterfaceOptions()  -- Updates options interface with user's preferences (Interface.lua)
        if preferences.showGreeting then      -- If the greeting message should be printed:
            print(greetingMessages[locale])   -- Prints the localized message in the chat (Interface.lua)
        end
    end
    frame:UnregisterEvent("ADDON_LOADED")  -- Stops listening to ADDON_LOADED events
end

local function handleSystemMessages(event, message)  -- All CHAT_MSG_SYSTEM events are handled here
    if event == "CHAT_MSG_SYSTEM" then                          -- If a system message is displayed:
        for _, pattern in ipairs(successfulAuctionMessages) do  -- Searches for successful auction messages (Localization.lua) in the system message
            if string.find(message, pattern) then               -- If the message matches one of the messages:
                successfulAuction = true                        -- The auction was successful
                break
            end
        end
        for _, pattern in ipairs(failedAuctionMessages) do      -- Searches for failed auction messages (Localization.lua) in the system message
            if string.find(message, pattern) then               -- If the message matches one of the messages:
                failedAuction = true                            -- The auction failed
                break
            end
        end
        for _, pattern in ipairs(expiredAuctionMessages) do     -- Searches for expired auction messages (Localization.lua) in the system message
            if string.find(message, pattern) then               -- If the message matches one of the messages:
                expiredAuction = true                            -- The auction expired
                break
            end
        end
    end
end

local function handleAuctionHouse(event, ...)  -- Handles AUCTION_HOUSE_SHOW and AUCTION_HOUSE_CLOSED events
    if event == "AUCTION_HOUSE_SHOW" then        -- If the Auction House window is opened:
        ahIsOpen = true                          -- Saves the current window state as open
    elseif event == "AUCTION_HOUSE_CLOSED" then  -- If the Auction House window is closed:
        ahIsOpen = false                         -- Saves the current window state as closed
    end
end

local function playSounds()  -- Responsible for playing sounds
    if successfulAuction then                                                      -- If the auction was successful,
        if preferences.enableInAH and ahIsOpen then                                -- and successful auction alerts should play when the Auction House is open:
            PlaySoundFile(preferences.chosenSounds[1], preferences.chosenChannel)  -- Plays the chosen sound file data ID for a successful auction on the chosen sound channel
        elseif not ahIsOpen then                                                   -- Or if successful auction alerts should not play when the Auction House is open and the AH is closed
            PlaySoundFile(preferences.chosenSounds[1], preferences.chosenChannel)
        end
    elseif failedAuction then                                                      -- Or if the auction failed:
        PlaySoundFile(preferences.chosenSounds[2], preferences.chosenChannel)      -- Plays the chosen sound file data ID for a failed auction on the chosen sound channel
    elseif expiredAuction then                                                     -- Or if the auction expired:
        PlaySound(1372, preferences.chosenChannel, true)  -- Plays an unique sound file SoundKitId (polymorphtarget) for an expired auction on the chosen sound channel
    end
    successfulAuction = false  -- Reverts the values to false so the process can be repeated
    failedAuction = false
    expiredAuction = false
end

frame:SetScript("OnEvent", function(_, event, ...)  -- Runs the functions below when one of the registered in-game events occur
    handleAddonLoaded(event, ...)
    handleSystemMessages(event, ...)
    handleAuctionHouse(event, ...)
    playSounds()
end)
