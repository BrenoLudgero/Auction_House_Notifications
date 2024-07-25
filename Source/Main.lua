local _, ahn = ...

-- Runs the functions below when one of the registered in-game events occur
ahn.frame:SetScript("OnEvent", function(_, event, ...)
    ahn.handleAddonLoaded(event, ...)
    ahn.handleAuctionHouse(event)
    ahn.handleAuctionUpdates(event, ...)
end)
