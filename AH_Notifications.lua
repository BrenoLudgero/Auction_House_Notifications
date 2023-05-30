local frame = CreateFrame("FRAME")


frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:RegisterEvent("ADDON_LOADED")


frame:SetScript("OnEvent", function(self, event, ...)
    local message = ...

    if event == "ADDON_LOADED" then

        local addOnName = ...

        if addOnName == "AH_Notifications" then
            print("Auction House Notifications loaded successfully! (Version 0.3)")
        end

    elseif event == "CHAT_MSG_SYSTEM" then

        if string.find(message, "Your auction of (.+) sold%.") or
        string.find(message, "You won an auction for (.+)") then
            PlaySound(891, "Master")

        elseif string.find(message, "Your auction of (.+) has expired%.") or
        string.find(message, "You have been outbid on (.+)%.") then
            PlaySound(892, "Master")
        end

    end

end)
