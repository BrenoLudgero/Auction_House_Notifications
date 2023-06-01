local frame = CreateFrame("FRAME")   -- Attributes CreateFrame() to a variable for ease of use

local sounds = {                        -- Sound Category = {sound for successful auction, Sound for failed auction}
    coins = {567483, 567501},           -- iMoneyDialogOpen, iMoneyDialogClose
    female = {540628, 540560},          -- HumanFemaleCheer01, HumanFemale_err_lootdidntkill06
    fireworks = {567011, 565499},       -- G_FireworkBoomGeneral5, G_BarrelExplodeCustom0
    impact = {567912, 568128}           -- m2hSwordHitMetalShieldCrit, BlizzardImpact1f
}

local chosenSound = sounds.female       -- Defines the alert preference chosen by the user

local successfulAuction = false         -- Creates a variable to identify if the auction was successful
local failedAuction = false             -- Creates a variable to identify if the auction failed


frame:RegisterEvent("CHAT_MSG_SYSTEM")  -- Starts listening to the in-game CHAT_MSG_SYSTEM events
frame:RegisterEvent("ADDON_LOADED")     -- Starts listening to the in-game ADDON_LOADED events


local function handleAddonLoaded(event, addonName)  -- All ADDON_LOADED events are handled here

    if event == "ADDON_LOADED" and addonName == "Auction_House_Notifications" then  -- If the ADDON_LOADED event was for Auction_House_Notifications:
        local locale = GetLocale()                                                  -- Checks what is the client language
        local message = greetingMessages[locale]                                    -- Defines the appropriate message from the greetingMessages list in Localization.lua
        print(message)                                                              -- Prints the message
    end
    
end


local function handleSystemMessages(event, message)  -- All CHAT_MSG_SYSTEM events are handled here

    if event == "CHAT_MSG_SYSTEM" then                          -- IF a CHAT_MSG_SYSTEM occur:

        for _, pattern in ipairs(successfulAuctionMessages) do  -- Search for successful auction messages from Localization.lua in the last CHAT_MSG_SYSTEM event
            if string.find(message, pattern) then               -- If the result is a match:
                successfulAuction = true                        -- The auction was successful
                break
            end
        end

        for _, pattern in ipairs(failedAuctionMessages) do      -- Search for failed auction messages from Localization.lua in the last CHAT_MSG_SYSTEM event
            if string.find(message, pattern) then               -- If the result is a match:
                failedAuction = true                            -- The auction failed
                break
            end
        end

    end

end


local function playSounds()  -- Responsible for playing sounds

        if successfulAuction then                   -- If the auction was successful:
            PlaySoundFile(chosenSound[1], "Master") -- Play the chosenSound file for a successful auction
        
        elseif failedAuction then                   -- If the auction failed:
            PlaySoundFile(chosenSound[2], "Master") -- Play the chosenSound file for a failed auction
        end

    successfulAuction = false                       -- Returns the values to false so the process can be repeated
    failedAuction = false

end


frame:SetScript("OnEvent", function(_, event, ...)  -- Runs the functions below when one of the in-game events registered occur

    handleAddonLoaded(event, ...)
    handleSystemMessages(event, ...)
    playSounds()

end)
