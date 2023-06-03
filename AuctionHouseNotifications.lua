frame = CreateFrame("FRAME")        -- Attributes CreateFrame() to a global variable for ease of use

local ahIsOpen = false              -- Creates a variable to identify if the Auction House frame is open or not
local successfulAuction = false     -- Creates a variable to identify if the auction was successful
local failedAuction = false         -- Creates a variable to identify if the auction failed

sounds = {                          -- [Structure] Sound category = {file data ID for successful auction, file data ID for failed auction}
    coins = {567483, 567501},       -- iMoneyDialogOpen, iMoneyDialogClose
    female = {540628, 540560},      -- HumanFemaleCheer01, HumanFemale_err_lootdidntkill06
    fireworks = {567011, 565499},   -- G_FireworkBoomGeneral5, G_BarrelExplodeCustom0
    impact = {567912, 568128}       -- m2hSwordHitMetalShieldCrit, BlizzardImpact1f
}

-- User's preferences (defaults)
chosenSounds = sounds.coins         -- The alert sound category to be used
chosenChannel = "Master"            -- The sound channel that alerts will use
enableAddon = true                  -- Toggles the addon on or off
enableInAH = true                   -- Toggles if the addon will play sounds when the Auction House frame is open
showGreeting = true                 -- Toggles if the greeting message will be printed in the chat


frame:RegisterEvent("ADDON_LOADED")         -- Starts listening to the in-game ADDON_LOADED events
frame:RegisterEvent("AUCTION_HOUSE_SHOW")   -- Starts listening to the in-game AUCTION_HOUSE_SHOW event
frame:RegisterEvent("AUCTION_HOUSE_CLOSED") -- Starts listening to the in-game AUCTION_HOUSE_CLOSED event
frame:RegisterEvent("CHAT_MSG_SYSTEM")      -- Starts listening to the in-game CHAT_MSG_SYSTEM events
frame:RegisterEvent("PLAYER_LOGOUT")        -- Starts listening to the in-game PLAYER_LOGOUT event


local function updateSavedVariables()       -- Responsible for updating user's preferences in SavedVariables
    preferences.chosenSounds = chosenSounds
    preferences.chosenChannel = chosenChannel
    preferences.enableAddon = enableAddon
    preferences.enableInAH = enableInAH
    preferences.showGreeting = showGreeting
end


local function handleAddonLoaded(event, addOnName)  -- All ADDON_LOADED events are handled here

    if event == "ADDON_LOADED" and addOnName == "AuctionHouseNotifications" then  -- If an addon is loaded and is called AuctionHouseNotifications:

        if preferences == nil then  -- If user preferences are absent from SavedVariables
            preferences = {}        -- Creates a table for user preferences
            updateSavedVariables()  -- Saves the default values
        end

        local greetingMessage = greetingMessages[locale]  -- Defines the appropriate message from greetingMessages (Localization.lua)
        
        if showGreeting then                              -- If the message should be printed:
            print(greetingMessage ..GetAddOnMetadata("AuctionHouseNotifications", "Version").. ")")  -- Prints the message in the chat and the version number
        end
    end
    
end


local function handleSystemMessages(event, message)  -- All CHAT_MSG_SYSTEM events are handled here

    if event == "CHAT_MSG_SYSTEM" then                          -- If a system message occur:
        for _, pattern in ipairs(successfulAuctionMessages) do  -- Search for successful auction messages (Localization.lua) in the last CHAT_MSG_SYSTEM event
            if string.find(message, pattern) then               -- If the message matches one of the auction messages:
                successfulAuction = true                        -- The auction was successful
                break
            end
        end

        for _, pattern in ipairs(failedAuctionMessages) do      -- Search for failed auction messages (Localization.lua) in the last CHAT_MSG_SYSTEM event
            if string.find(message, pattern) then               -- If the message matches one of the auction messages:
                failedAuction = true                            -- The auction failed
                break
            end
        end

    end

end


local function handleAuctionHouse(event, ...)   -- Handles AUCTION_HOUSE_SHOW and AUCTION_HOUSE_CLOSED events

    if event == "AUCTION_HOUSE_SHOW" then       -- If the Auction House frame is opened:
        ahIsOpen = true                         -- Saves the current frame state as open

    elseif event == "AUCTION_HOUSE_CLOSED" then -- If the Auction House frame is closed:
        ahIsOpen = false                        -- Saves the current frame state as closed
    end

end


local function handlePlayerLogout(event, ...)  -- Handles the PLAYER_LOGOUT event

    if event == "PLAYER_LOGOUT" then           -- Once the user logs out:
        updateSavedVariables()                 -- Saves the current user's preferences
    end

end


local function playSounds()  -- Responsible for playing sounds

    if successfulAuction then                              -- If the auction was successful,
        if enableInAH and ahIsOpen then                    -- and sounds should play when the Auction House is open:
            PlaySoundFile(chosenSounds[1], chosenChannel)  -- Play the chosen sound file on the chosen sound channel for a successful auction

        elseif not ahIsOpen then                           -- Or if sounds should not play when the Auction House is open and the AH is closed
            PlaySoundFile(chosenSounds[1], chosenChannel)
        end

    elseif failedAuction then                              -- If the auction failed,
        if enableInAH and ahIsOpen then                    -- and sounds should play when the Auction House is open:
            PlaySoundFile(chosenSounds[2], chosenChannel)  -- Play the chosen sound file on the chosen sound channel for a failed auction

        elseif not ahIsOpen then                           -- Or if sounds should not play when the Auction House is open and the AH is closed
            PlaySoundFile(chosenSounds[2], chosenChannel)
        end

    end

    successfulAuction = false  -- Reverts the values to false so the process can be repeated
    failedAuction = false

end


if enableAddon then                                     -- If user has enabled the addon:

    frame:SetScript("OnEvent", function(_, event, ...)  -- Runs the functions below when one of the registered in-game events occur
        handleAddonLoaded(event, ...)
        handleSystemMessages(event, ...)
        handleAuctionHouse(event, ...)
        playSounds()
        handlePlayerLogout(event, ...)
    end)

end
