local frame = CreateFrame("FRAME")

frame:RegisterEvent("CHAT_MSG_SYSTEM")

print("Auction House Notifications loaded.")

frame:SetScript("OnEvent", function(self, event, ...)
    local message = ...

    if string.find(message, "Your auction of (.+) sold%.") then
        PlaySound(891)
    elseif string.find(message, "Your auction of (.+) has expired%.") then
        PlaySound(892)
    end

end)