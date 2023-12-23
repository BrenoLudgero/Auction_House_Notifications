ahIsOpen = false
locale = GetLocale()
frame = CreateFrame("FRAME")
isMainline = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

-- Saves the status of the last auction update
auctionSuccessful, auctionFailed, auctionExpired = false

-- Type of auction update
soldAuction, wonAuction, outbidAuction, expiredAuction = nil

-- FileDataIDs: https://wow.tools/dbc/?dbc=filedata&build=6.0.1.18179#page=1
successfulSounds = {
    coins = 567483,     -- iMoneyDialogOpen
    female = 540628,    -- HumanFemaleCheer01
    fireworks = 567011, -- G_FireworkBoomGeneral5
    impact = 567946,    -- BullWhipHit2
    quests = 567516     -- iQuestUpdate
}
failedSounds = {
    coins = 567501,     -- iMoneyDialogClose
    female = 540560,    -- HumanFemale_err_lootdidntkill06
    fireworks = 565499, -- G_BarrelExplodeCustom0
    impact = 567821,    -- 2hMaceMetalHitMetalShieldCrit
    quests = 567459     -- igQuestFailed
}
expiredSounds = {
    sheep = 1372,       -- PolyMorphTarget
    thunder = 13006,    -- Shaman_Thunder
    what = 6289,        -- PeasentWhat4
    growl = 3960,       -- mBearAttackD
    chicken = 1024      -- ChickenDeathA
}
