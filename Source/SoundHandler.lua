local _, ahn = ...
local L = ahn.L

local customSoundsPath = "Interface\\AddOns\\AuctionHouseNotifications\\Custom Sounds\\"

-- FileDataIDs: https://wago.tools/files?search=sound/
ahn.successfulSounds = {
    { value = 567483, label = L.soundCategoryCoins },     -- iMoneyDialogOpen
    { value = 540628, label = L.soundCategoryFemale },    -- HumanFemaleCheer01
    { value = 567011, label = L.soundCategoryFireworks }, -- G_FireworkBoomGeneral5
    { value = 567946, label = L.soundCategoryImpact },    -- BullWhipHit2
    { value = 567516, label = L.soundCategoryQuests },    -- iQuestUpdate
}

ahn.failedSounds = {
    { value = 567501, label = L.soundCategoryCoins },     -- iMoneyDialogClose
    { value = 540560, label = L.soundCategoryFemale },    -- HumanFemale_err_lootdidntkill06
    { value = 565499, label = L.soundCategoryFireworks }, -- G_BarrelExplodeCustom0
    { value = 567821, label = L.soundCategoryImpact },    -- 2hMaceMetalHitMetalShieldCrit
    { value = 567459, label = L.soundCategoryQuests },    -- igQuestFailed
}

ahn.expiredSounds = {
    { value = 1372,  label = L.soundCategorySheep },   -- PolyMorphTarget
    { value = 13006, label = L.soundCategoryThunder }, -- Shaman_Thunder
    { value = 6289,  label = L.soundCategoryWhat },    -- PeasentWhat4
    { value = 3960,  label = L.soundCategoryGrowl },   -- mBearAttackD
    { value = 1024,  label = L.soundCategoryChicken }, -- ChickenDeathA
}

ahn.soundChannels = {
    { value = "Master",   label = L.soundChannelMaster },
    { value = "Effects",  label = L.soundChannelEffects },
    { value = "Music",    label = L.soundChannelMusic },
    { value = "Ambience", label = L.soundChannelAmbience },
    { value = "Dialog",   label = L.soundChannelDialog }
}

local function removeExtensionFromFileName(fileName)
    return fileName:match("(.+)%..+$") or fileName
end

local function addCustomSoundAsOption(soundEntry)
    table.insert(ahn.successfulSounds, soundEntry)
    table.insert(ahn.failedSounds, soundEntry)
    table.insert(ahn.expiredSounds, soundEntry)
end

-- IGNORE FILES WITH UNSUPPORTED EXTENSIONS
local function addSupportedCustomSoundsAsOptions()
    for _, fileName in ipairs(ahn.customSounds or {}) do
        local customSound = {
            value = customSoundsPath..fileName, 
            label = removeExtensionFromFileName(fileName)
        }
        addCustomSoundAsOption(customSound)
    end
end

function ahn.playOverlappingSound(sound)
    PlaySoundFile(sound, AHNPreferences.chosenChannel)
end

function ahn.playNonOverlappingSound(sound)
    local forceNoDuplicates = true
    PlaySound(sound, AHNPreferences.chosenChannel, forceNoDuplicates)
end

-- IMPLEMENT CUSTOM NON-OVERLAPING MECHANISM
function ahn.playAppropriateAuctionSound(auctionType)
    if auctionType == "successful" and (AHNPreferences.enableInAH or not ahn.ahIsOpen) then
        ahn.playOverlappingSound(AHNPreferences.chosenSounds.successful)
    elseif auctionType == "failed" then
        ahn.playOverlappingSound(AHNPreferences.chosenSounds.failed)
    elseif auctionType == "expired" and AHNPreferences.enableExpired then
        local sound = AHNPreferences.chosenSounds.expired
        if type(sound) == "string" then -- Custom sound
            ahn.playOverlappingSound(sound)
        else
            ahn.playNonOverlappingSound(sound)
        end
    end
end

addSupportedCustomSoundsAsOptions()
