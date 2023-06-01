local frame = CreateFrame("FRAME")


local sounds = {                    -- https://wow.tools/dbc/?dbc=filedata&build=6.0.1.18179#page=1
    coins = {567483, 567501},       -- iMoneyDialogOpen, iMoneyDialogClose
    female = {540628, 540560},      -- HumanFemaleCheer01, HumanFemale_err_lootdidntkill06
    fireworks = {567011, 565499},   -- G_FireworkBoomGeneral5, G_BarrelExplodeCustom0
    impact = {567912, 568128}       -- m2hSwordHitMetalShieldCrit, BlizzardImpact1f
}


local chosenSound = sounds.coins


frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:RegisterEvent("ADDON_LOADED")


-- Split into multiple functions
frame:SetScript("OnEvent", function(self, event, ...)

    local message = ...

    if event == "ADDON_LOADED" then

        local addOnName = ...

        if addOnName == "AH_Notifications" then
            print("Auction House Notifications loaded successfully! (Version 0.7)") -- Get from .toc
        end

    elseif event == "CHAT_MSG_SYSTEM" then

        local successfulAuction = false
        local failedAuction = false

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

        if successfulAuction then
            PlaySoundFile(chosenSound[1], "Master")
            successfulAuction = false

        elseif failedAuction then
            PlaySoundFile(chosenSound[2], "Master")
            failedAuction = false
        end

    end

end)
