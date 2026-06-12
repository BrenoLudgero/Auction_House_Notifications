local _, ahn = ...
local L = ahn.L

local customSoundsPath = "Interface\\AddOns\\AuctionHouseNotifications\\Custom Sounds\\"
local activeSounds = {} -- Tracks sounds being played by type (successful, failed, expired)

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

local function isCustomSoundFormatSupported(fileName)
    local fileExtension = fileName:match("^.+%.(.+)$")
    if not fileExtension then
        return false
    end
    fileExtension = fileExtension:lower()
    return fileExtension == "mp3" or fileExtension == "ogg"
end

local function isCustomSoundFilePresent(filePath)
    local willPlay, soundHandle = PlaySoundFile(filePath, "Master")
    if soundHandle then 
        StopSound(soundHandle) 
    end
    return willPlay
end

local function removeExtensionFromFileName(fileName)
    return fileName:match("(.+)%..+$") or fileName
end

local function addCustomSoundAsOption(soundEntry)
    table.insert(ahn.successfulSounds, soundEntry)
    table.insert(ahn.failedSounds, soundEntry)
    table.insert(ahn.expiredSounds, soundEntry)
end

local function addSupportedCustomSoundsAsOptions()
    for _, fileName in ipairs(ahn.customSounds or {}) do
        local filePath = customSoundsPath..fileName
        if isCustomSoundFormatSupported(fileName) 
        and isCustomSoundFilePresent(filePath) then
            local customSound = {
                value = filePath, 
                label = removeExtensionFromFileName(fileName)
            }
            addCustomSoundAsOption(customSound)
        end
    end
end

local function stopCategorySound(auctionType)
    local activeChannel = activeSounds[auctionType]
    if activeChannel then
        StopSound(activeChannel)
        activeSounds[auctionType] = nil
    end
end

-- Allows for one of each auctionType sound to be played at the same time with no overlap
function ahn.playSound(sound, auctionType)
    stopCategorySound(auctionType)
    local willPlay, soundHandle
    -- FileDataIDs below 100,000 are soundKits and won't be played by PlaySoundFile
    if type(sound) == "number" and sound < 100000 then
        willPlay, soundHandle = PlaySound(sound, AHNPreferences.chosenChannel)
    else
        willPlay, soundHandle = PlaySoundFile(sound, AHNPreferences.chosenChannel)
    end
    if willPlay then
        activeSounds[auctionType] = soundHandle
    end
end

function ahn.playAppropriateAuctionSound(auctionType)
    if not AHNPreferences["playSounds"] then
        return
    end
    if auctionType == "successful" and (AHNPreferences.enableInAH or not ahn.ahIsOpen) then
        ahn.playSound(AHNPreferences.chosenSounds.successful, auctionType)
    elseif auctionType == "failed" then
        ahn.playSound(AHNPreferences.chosenSounds.failed, auctionType)
    elseif auctionType == "expired" and AHNPreferences.enableExpired then
        ahn.playSound(AHNPreferences.chosenSounds.expired, auctionType)
    end
end

addSupportedCustomSoundsAsOptions()
