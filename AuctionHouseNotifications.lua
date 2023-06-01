local enableAddon = true    -- (User) Toggles the addon on or off
local enableInAH = true     -- (User) Toggles if the addon will play sounds if the Auction House frame is open
local ahIsOpen = false      -- Creates a variable to identify and save if the Auction House frame is open or not

local frame = CreateFrame("FRAME")  -- Attributes CreateFrame() to a variable for ease of use

local sounds = {                        -- [Structure] Sound category = {file data ID successful auction, file data ID for failed auction}
    coins = {567483, 567501},           -- iMoneyDialogOpen, iMoneyDialogClose
    female = {540628, 540560},          -- HumanFemaleCheer01, HumanFemale_err_lootdidntkill06
    fireworks = {567011, 565499},       -- G_FireworkBoomGeneral5, G_BarrelExplodeCustom0
    impact = {567912, 568128}           -- m2hSwordHitMetalShieldCrit, BlizzardImpact1f
}

local chosenSound = sounds.female       -- (User) The alert sound to be used
local chosenChannel = "Master"          -- (User) The sound channel that alerts will use

local successfulAuction = false         -- Creates a variable to identify if the auction was successful
local failedAuction = false             -- Creates a variable to identify if the auction failed


frame:RegisterEvent("CHAT_MSG_SYSTEM")      -- Starts listening to the in-game CHAT_MSG_SYSTEM events
frame:RegisterEvent("ADDON_LOADED")         -- Starts listening to the in-game ADDON_LOADED events
frame:RegisterEvent("AUCTION_HOUSE_SHOW")   -- Starts listening to the in-game AUCTION_HOUSE_SHOW event
frame:RegisterEvent("AUCTION_HOUSE_CLOSED") -- Starts listening to the in-game AUCTION_HOUSE_CLOSED event


local function handleAddonLoaded(event, addonName)  -- All ADDON_LOADED events are handled here

    if event == "ADDON_LOADED" and addonName == "AuctionHouseNotifications" then  -- If an addon is loaded and its AuctionHouseNotifications:
        local locale = GetLocale()                                                -- Checks the user client language
        local message = greetingMessages[locale]                                  -- Defines the appropriate message from the greetingMessages (Localization.lua)
        print(message)                                                            -- Prints the message
    end
    
end


local function handleSystemMessages(event, message)  -- All CHAT_MSG_SYSTEM events are handled here

    if event == "CHAT_MSG_SYSTEM" then                          -- If a system message occur:
        for _, pattern in ipairs(successfulAuctionMessages) do  -- Search for successful auction messages from Localization.lua in the last CHAT_MSG_SYSTEM event
            if string.find(message, pattern) then               -- If the message matches one of the auction messages:
                successfulAuction = true                        -- The auction was successful
                break
            end
        end

        for _, pattern in ipairs(failedAuctionMessages) do      -- Search for failed auction messages from Localization.lua in the last CHAT_MSG_SYSTEM event
            if string.find(message, pattern) then               -- If the message matches one of the auction messages:
                failedAuction = true                            -- The auction failed
                break
            end
        end

    end

end


local function handleAuctionHouse(event, ...)   -- Handleds AUCTION_HOUSE_SHOW and AUCTION_HOUSE_CLOSED events

    if event == "AUCTION_HOUSE_SHOW" then       -- If the Auction House frame is opened:
        ahIsOpen = true                         -- Saves the current frame state as open

    elseif event == "AUCTION_HOUSE_CLOSED" then -- If the Auction House frame is closed:
        ahIsOpen = false                        -- Saves the current frame state as not open
    end

end


local function playSounds()  -- Responsible for playing sounds

    if successfulAuction then                               -- If the auction was successful,
        if enableInAH and ahIsOpen then                     -- and sounds should play when the Auction House is open:
            PlaySoundFile(chosenSound[1], chosenChannel)    -- Play the chosen sound file on the chosen sound channel for a successful auction

        elseif not nableInAH and not ahIsOpen then          -- Or if sounds should not play if the Auction House is open and the AH is closed
            PlaySoundFile(chosenSound[1], chosenChannel)
        end

    elseif failedAuction then                               -- If the auction failed,
        if enableInAH and ahIsOpen then                     -- and sounds should play when the Auction House is open:
            PlaySoundFile(chosenSound[2], chosenChannel)    -- Play the chosen sound file on the chosen sound channel for a failed auction

        elseif not nableInAH and not ahIsOpen then          -- Or if sounds should not play if the Auction House is open and the AH is closed
            PlaySoundFile(chosenSound[2], chosenChannel)
        end

    end

    successfulAuction = false  -- Returns the values to false so the process can be repeated
    failedAuction = false

end


if enableAddon then                                     -- If user has enabled the addon:

    frame:SetScript("OnEvent", function(_, event, ...)  -- Runs the functions below when one of the registered in-game events occur if:
        handleAddonLoaded(event, ...)
        handleSystemMessages(event, ...)
        handleAuctionHouse(event, ...)
        playSounds()
    end)

end
