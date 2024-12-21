local _, ahn = ...
local L = ahn.L

ahn.frame.name = L.title

-- Displays the add-on in Options -> AddOns
local category = Settings.RegisterCanvasLayoutCategory(ahn.frame, ahn.frame.name)
category.ID = ahn.frame.name
Settings.RegisterAddOnCategory(category)

local titlesTextX = 13
local expiredCheckX = 315
local buttonsY = -271
local dropdownColumn1X = 28
local dropdownColumn2X = 318
local dropdownRow1Y = -148
local dropdownRow2Y = -190
if ahn.locale == "ptBR" or ahn.locale == "frFR" then
    expiredCheckX = 325
    dropdownColumn2X = 330
elseif ahn.locale == "deDE" then
    expiredCheckX = 265
    dropdownColumn2X = 352
elseif ahn.locale == "ruRU" then
    expiredCheckX = 236
    dropdownColumn2X = 353
end

-------------------------------------  TITLES  ----------------------------------------
local titleText = ahn.createText("GameFontNormalLarge", L.title, titlesTextX, -15)
local subtitleText = ahn.createText("GameFontHighlight", L.subtitle, titlesTextX, -35)
local soundPreferencesText = ahn.createText("GameFontNormalMed1", L.soundPreferences, titlesTextX, -85)
local testSoundsText = ahn.createText("GameFontNormalMed1", L.testSounds, titlesTextX, -245)
local miscellaneousText = ahn.createText("GameFontNormalMed1", L.miscellaneous, titlesTextX, -331)

----------------------------------  CHECKBUTTONS  -------------------------------------
local enableInAHCheckButton = ahn.createButton("CheckButton", L.enableInAHText, 25, -110,
    function(self) 
        AHNPreferences.enableInAH = self:GetChecked()
    end
)
local enableExpiredCheckButton = ahn.createButton("CheckButton", L.enableExpired, expiredCheckX, -110, 
    function(self) 
        AHNPreferences.enableExpired = self:GetChecked()
    end
)
ahn.createTooltip(enableInAHCheckButton, "ANCHOR_RIGHT", L.enableInAHTooltip)
local showGreetingCheckButton = ahn.createButton("CheckButton", L.showGreetingMessage, 27, -356, 
    function(self)
        AHNPreferences.showGreeting = self:GetChecked()
    end
)

-------------------------------------  BUTTONS  ---------------------------------------
local testSuccessfulButton = ahn.createButton("Button", L.successfulText, 26, buttonsY, 
    function(self)
        PlaySoundFile(AHNPreferences.chosenSounds.successful, AHNPreferences.chosenChannel)
    end
)
local testFailedButton = ahn.createButton("Button", L.failedText, 169, buttonsY, 
    function(self)
        PlaySoundFile(AHNPreferences.chosenSounds.failed, AHNPreferences.chosenChannel)
    end
)
local testExpiredButton = ahn.createButton("Button", L.expiredText, 312, buttonsY, 
    function(self)
        PlaySound(AHNPreferences.chosenSounds.expired, AHNPreferences.chosenChannel, true)
    end
)

------------------------------------  DROPDOWNS  --------------------------------------
local successfulSoundCategories = {
    [ahn.successfulSounds.coins] = L.soundCategoryNames[1],
    [ahn.successfulSounds.female] = L.soundCategoryNames[2],
    [ahn.successfulSounds.fireworks] = L.soundCategoryNames[3],
    [ahn.successfulSounds.impact] = L.soundCategoryNames[4],
    [ahn.successfulSounds.quests] = L.soundCategoryNames[5]
}
local successfulSoundDropdown = ahn.createDropdown(
    dropdownColumn1X, 
    dropdownRow1Y, 
    "successfulSounds", 
    successfulSoundCategories
)
ahn.createDropdownLabel(successfulSoundDropdown, L.successfulSoundText)

local failedSoundCategories = {
    [ahn.failedSounds.coins] = L.soundCategoryNames[1],
    [ahn.failedSounds.female] = L.soundCategoryNames[2],
    [ahn.failedSounds.fireworks] = L.soundCategoryNames[3],
    [ahn.failedSounds.impact] = L.soundCategoryNames[4],
    [ahn.failedSounds.quests] = L.soundCategoryNames[5]
}
local failedSoundDropdown = ahn.createDropdown(
    dropdownColumn1X, 
    dropdownRow2Y, 
    "failedSounds", 
    failedSoundCategories
)
ahn.createDropdownLabel(failedSoundDropdown, L.failedSoundText)

local expiredSoundCategories = {
    [ahn.expiredSounds.sheep] = L.soundCategoryNames[6],
    [ahn.expiredSounds.thunder] = L.soundCategoryNames[7],
    [ahn.expiredSounds.what] = L.soundCategoryNames[8],
    [ahn.expiredSounds.growl] = L.soundCategoryNames[9],
    [ahn.expiredSounds.chicken] = L.soundCategoryNames[10]
}
local expiredSoundDropdown = ahn.createDropdown(
    dropdownColumn2X, 
    dropdownRow1Y, 
    "expiredSounds",
    expiredSoundCategories
)
ahn.createDropdownLabel(expiredSoundDropdown, L.expiredSoundText)

local soundChannels = {
    ["Master"] = L.soundChannelNames[1],
    ["Sound"] = L.soundChannelNames[2],
    ["Music"] = L.soundChannelNames[3],
    ["Ambience"] = L.soundChannelNames[4],
    ["Dialog"] = L.soundChannelNames[5]
}
local soundChannelDropdown = ahn.createDropdown(
    dropdownColumn2X, 
    dropdownRow2Y, 
    "soundChannels", 
    soundChannels
)
ahn.createDropdownLabel(soundChannelDropdown, L.soundChannelText)
ahn.createTooltip(soundChannelDropdown, "ANCHOR_TOP", L.soundChannelTooltip)

-- Checks the interface options based on the user's preferences when the addOn loads
function ahn.updateInterfaceOptions()
    enableInAHCheckButton:SetChecked(AHNPreferences.enableInAH)
    enableExpiredCheckButton:SetChecked(AHNPreferences.enableExpired)
    showGreetingCheckButton:SetChecked(AHNPreferences.showGreeting)
    ahn.setInitialDropdownText(successfulSoundDropdown, successfulSoundCategories)
    ahn.setInitialDropdownText(failedSoundDropdown, failedSoundCategories)
    ahn.setInitialDropdownText(expiredSoundDropdown, expiredSoundCategories)
    ahn.setInitialDropdownText(soundChannelDropdown, soundChannels)
end
