local _, ahn = ...

-- Type of auction event
local soldAuction
local wonAuction
local outbidAuction
local expiredAuction

if ahn.isVanilla or ahn.isBurningCrusade then
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

function ahn.determineVanillaAuctionType(auctionType)
    if string.find(auctionType, soldAuction) 
    or string.find(auctionType, wonAuction) then
        return "successful"
    elseif string.find(auctionType, outbidAuction) then
        return "failed"
    elseif string.find(auctionType, expiredAuction) then
        return "expired"
    end
end

function ahn.determineNonVanillaAuctionType(auctionType)
    if auctionType == soldAuction 
    or auctionType == wonAuction then
        return "successful"
    elseif auctionType == outbidAuction then
        return "failed"
    elseif auctionType == expiredAuction then
        return "expired"
    end
end
