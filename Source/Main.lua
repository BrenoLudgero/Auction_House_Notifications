-- © 2023 Breno Ludgero. All Rights Reserved.

if isMainline then
    soldAuction = Enum.AuctionHouseNotification.AuctionSold
    wonAuction = Enum.AuctionHouseNotification.AuctionWon
    outbidAuction = Enum.AuctionHouseNotification.AuctionOutbid
    expiredAuction = Enum.AuctionHouseNotification.AuctionExpired
else
    soldAuction = string.gsub(ERR_AUCTION_SOLD_S, "%%s", "(.+)")
    wonAuction = string.gsub(ERR_AUCTION_WON_S, "%%s", "(.+)")
    outbidAuction = string.gsub(ERR_AUCTION_OUTBID_S, "%%s", "(.+)")
    expiredAuction = string.gsub(ERR_AUCTION_EXPIRED_S, "%%s", "(.+)")
end

-- Plays the chosen FileDataID in the chosen sound channel
-- PlaySoundFile plays overlaping sounds and PlaySound doesn't (when 'true')
local function playSounds()
    if auctionSuccessful and (preferences.enableInAH or not ahIsOpen) then
        PlaySoundFile(preferences.chosenSounds.successful, preferences.chosenChannel)
    elseif auctionFailed then
        PlaySoundFile(preferences.chosenSounds.failed, preferences.chosenChannel)
    elseif preferences.enableExpired and auctionExpired then
        PlaySound(preferences.chosenSounds.expired, preferences.chosenChannel, true)
    end
end

-- Reverts the values to false so the sounds can be played again
local function resetVariables()
    auctionSuccessful = false
    auctionFailed = false
    auctionExpired = false
end

-- Runs the functions below when one of the registered in-game events occur
frame:SetScript("OnEvent", function(_, event, ...)
    handleAddonLoaded(event, ...)
    handleAuctionHouse(event)
    handleAuctionUpdates(event, ...)
    playSounds()
    resetVariables()
end)
