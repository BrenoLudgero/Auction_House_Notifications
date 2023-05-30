local frame = CreateFrame("FRAME")

frame:RegisterEvent("CHAT_MSG_SYSTEM")

print("Auction House Notifications loaded.")

frame:SetScript("OnEvent", function(self, event, ...)
    local message = ...

    if string.find(message, "Your auction of (.+) sold%.") then
        local soundPath = "Interface\\AddOns\\AH_Notifications\\Sounds\\iMoneyDialogClose.ogg"
        PlaySoundFile(soundPath, "Master")
    end
end)