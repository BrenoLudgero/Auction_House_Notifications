local frame = CreateFrame("FRAME")


frame:RegisterEvent("CHAT_MSG_SYSTEM")
frame:RegisterEvent("ADDON_LOADED")


successfulAuctionMessages = {"Your auction of (.+) sold%.", "You won an auction for (.+)", 
"Has vendido (.+) en la subasta%.", "Has ganado una puja por (.+)", "Tu (.+) se ha vendido%.", 
"Vente de votre (.+) réussie", "Vous avez gagné les enchères pour (.+)"}

failedAuctionMessages = {"Your auction of (.+) has expired%.", "You have been outbid on (.+)%.",
"Tu subasta de (.+) ha caducado%.", "Alguien ha superado tu puja por (.+)%.", "Alguien ha pujado por tu (.+)%.",
"Votre vente aux enchères de (.+) est terminée", "Vous n'êtes plus le plus offrant pour (.+)%."}


frame:SetScript("OnEvent", function(self, event, ...)

    local message = ...

    if event == "ADDON_LOADED" then

        local addOnName = ...

        if addOnName == "AH_Notifications" then
            print("Auction House Notifications loaded successfully! (Version 0.5)")
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

        for _, pattern in ipairs(failedAuctionMessages) do              -- TEST
            if string.find(message, pattern) then                       -- TEST
                failedAuction = true                                    -- TEST
                break                                                   -- TEST
            end
        end

        if successfulAuction then
            PlaySound(891, "Master")
            successfulAuction = false

        elseif failedAuction then
            PlaySound(892, "Master")
            failedAuction = false
        end

    end

end)
