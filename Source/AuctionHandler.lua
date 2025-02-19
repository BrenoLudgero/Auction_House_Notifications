local _, ahn = ...

-- Saves the status of the last auction update
local auctionSuccessful = false
local auctionFailed = false
local auctionExpired = false

-- Type of auction update (updated in Main.lua)
local soldAuction
local wonAuction
local outbidAuction
local expiredAuction

if ahn.isVanilla then
    soldAuction = string.gsub(ERR_AUCTION_SOLD_S, "%%s", "(.+)")
    wonAuction = string.gsub(ERR_AUCTION_WON_S, "%%s", "(.+)")
    outbidAuction = string.gsub(ERR_AUCTION_OUTBID_S, "%%s", "(.+)")
    expiredAuction = string.gsub(ERR_AUCTION_EXPIRED_S, "%%s", "(.+)")
else
    soldAuction = Enum.AuctionHouseNotification.AuctionSold
    wonAuction = Enum.AuctionHouseNotification.AuctionWon
    outbidAuction = Enum.AuctionHouseNotification.AuctionOutbid
    expiredAuction = Enum.AuctionHouseNotification.AuctionExpired
end

function ahn.updateVanillaAuctionStatus(updateType)
    auctionSuccessful = string.find(updateType, soldAuction) or string.find(updateType, wonAuction)
    auctionFailed = string.find(updateType, outbidAuction)
    auctionExpired = string.find(updateType, expiredAuction)
end

function ahn.updateOthersAuctionStatus(event, updateType)
    auctionSuccessful = 
        (event == "AUCTION_HOUSE_PURCHASE_COMPLETED") 
        or (updateType == soldAuction) 
        or (updateType == wonAuction)
    auctionFailed = (updateType == outbidAuction)
    auctionExpired = (updateType == expiredAuction)
end

-- Plays the chosen FileDataID in the chosen sound channel
-- PlaySoundFile plays overlaping sounds and PlaySound doesn't (when 'true')
function ahn.playSound()
    if auctionSuccessful and (AHNPreferences.enableInAH or not ahn.ahIsOpen) then
        PlaySoundFile(AHNPreferences.chosenSounds.successful, AHNPreferences.chosenChannel)
    elseif auctionFailed then
        PlaySoundFile(AHNPreferences.chosenSounds.failed, AHNPreferences.chosenChannel)
    elseif AHNPreferences.enableExpired and auctionExpired then
        PlaySound(AHNPreferences.chosenSounds.expired, AHNPreferences.chosenChannel, true)
    end
end

-- Reverts the values to false so the sounds can be played again
function ahn.resetAuctionStatus()
    auctionSuccessful = false
    auctionFailed = false
    auctionExpired = false
end
