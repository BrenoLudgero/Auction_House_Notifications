local frame = CreateFrame("FRAME")

local sounds = {                    -- https://wow.tools/dbc/?dbc=filedata&build=6.0.1.18179#page=1
    coins = {567483, 567501},       -- iMoneyDialogOpen, iMoneyDialogClose
    female = {540628, 540560},      -- HumanFemaleCheer01, HumanFemale_err_lootdidntkill06
    fireworks = {567011, 565499},   -- G_FireworkBoomGeneral5, G_BarrelExplodeCustom0
    impact = {567912, 568128}       -- m2hSwordHitMetalShieldCrit, BlizzardImpact1f
}

local chosenSound = sounds.coins

local successfulAuction = false
local failedAuction = false


frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:RegisterEvent("ADDON_LOADED")


local function handleAddonLoaded(event, addonName)

    if event == "ADDON_LOADED" and addonName == "AH_Notifications" then
        print("Auction House Notifications loaded successfully! (Version 0.7a)") -- Get from .toc
    end
    
end


local function handleSystemMessages(event, message)

    if event == "CHAT_MSG_SYSTEM" then

        for _, pattern in ipairs(successfulAuctionMessages) do
            if string.find(message, pattern) then
                successfulAuction = true
                break
            end
        end

        for _, pattern in ipairs(failedAuctionMessages) do
            if string.find(message, pattern) then
                failedAuction = true
                break
            end
        end

    end

end


local function playSounds()

    if successfulAuction then
        PlaySoundFile(chosenSound[1], "Master")
        successfulAuction = false

    elseif failedAuction then
        PlaySoundFile(chosenSound[2], "Master")
        failedAuction = false
    end

end


frame:SetScript("OnEvent", function(_, event, ...)

    handleAddonLoaded(event, ...)
    handleSystemMessages(event, ...)
    playSounds()

end)
