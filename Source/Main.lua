local _, ahn = ...

-- Runs the functions below when one of the registered in-game events occur
ahn.frame:SetScript("OnEvent", function(_, event, ...)
    if ahn.handleAddonLoaded then
        ahn.handleAddonLoaded(event, ...)
        ahn.handleAddonLoaded = nil
    end
    ahn.handleAuctionHouse(event)
    ahn.handleAuctionUpdates(event, ...)
end)
