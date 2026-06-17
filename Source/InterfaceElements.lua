local _, ahn = ...
local L = ahn.L

local titlesTextX = 13
local expiredCheckX = 315
local buttonsY = -296
local dropdownColumn1X = 28
local dropdownColumn2X = 318
local dropdownRow1Y = -173
local dropdownRow2Y = -215
if ahn.locale == "ptBR" or ahn.locale == "frFR" then
    expiredCheckX = 325
    dropdownColumn2X = 330
elseif ahn.locale == "deDE" then
    expiredCheckX = 243
    dropdownColumn2X = 352
end

-------------------------------------  TITLES  ----------------------------------------
local titleText = ahn.createText("GameFontNormalLarge", L.title, titlesTextX, -15)
local subtitleText = ahn.createText("GameFontHighlight", L.subtitle, titlesTextX, -35)
local soundPreferencesText = ahn.createText("GameFontNormalMed1", L.soundPreferences, titlesTextX, -85)
local testSoundsText = ahn.createText("GameFontNormalMed1", L.testSounds, titlesTextX, -270)
local miscellaneousText = ahn.createText("GameFontNormalMed1", L.miscellaneous, titlesTextX, -356)

----------------------------------  CHECKBUTTONS  -------------------------------------
local playSoundsCheckButton = ahn.createButton("CheckButton", L.enableSounds, 25, -110,
    function(self)
        AHNPreferences.playSounds = self:GetChecked()
    end
)

local enableInAHCheckButton = ahn.createButton("CheckButton", L.enableInAHText, 25, -135,
    function(self)
        AHNPreferences.enableInAH = self:GetChecked()
    end
)
ahn.createTooltip(enableInAHCheckButton, "ANCHOR_RIGHT", L.enableInAHTooltip)

local enableExpiredCheckButton = ahn.createButton("CheckButton", L.enableExpired, expiredCheckX, -110,
    function(self)
        AHNPreferences.enableExpired = self:GetChecked()
    end
)

local enableCrossCharacterExpiredCheckButton = ahn.createButton("CheckButton", L.enableCrossCharacterExpired, expiredCheckX, -135,
    function(self)
        AHNPreferences.enableCrossCharacterExpired = self:GetChecked()
    end
)
ahn.createTooltip(enableCrossCharacterExpiredCheckButton, "ANCHOR_RIGHT", L.crossCharacterExpiredTooltip)

local showGreetingCheckButton = ahn.createButton("CheckButton", L.showGreetingMessage, 27, -381,
    function(self)
        AHNPreferences.showGreeting = self:GetChecked()
    end
)

-------------------------------------  BUTTONS  ---------------------------------------
local testSuccessfulButton = ahn.createButton("Button", L.successfulText, 26, buttonsY,
    function(self) ahn.playSound(AHNPreferences.chosenSounds.successful, "successful") end
)

local testFailedButton = ahn.createButton("Button", L.failedText, 169, buttonsY,
    function(self) ahn.playSound(AHNPreferences.chosenSounds.failed, "failed") end
)

local testExpiredButton = ahn.createButton("Button", L.expiredText, 312, buttonsY,
    function(self) ahn.playSound(AHNPreferences.chosenSounds.expired, "expired") end
)

------------------------------------  DROPDOWNS  --------------------------------------
local successfulSoundDropdown = ahn.createDropdown(
    dropdownColumn1X, 
    dropdownRow1Y, 
    "successfulSounds", 
    ahn.successfulSounds
)
ahn.createDropdownLabel(successfulSoundDropdown, L.successfulSoundText)

local failedSoundDropdown = ahn.createDropdown(
    dropdownColumn1X, 
    dropdownRow2Y, 
    "failedSounds", 
    ahn.failedSounds
)
ahn.createDropdownLabel(failedSoundDropdown, L.failedSoundText)

local expiredSoundDropdown = ahn.createDropdown(
    dropdownColumn2X, 
    dropdownRow1Y, 
    "expiredSounds",
    ahn.expiredSounds
)
ahn.createDropdownLabel(expiredSoundDropdown, L.expiredSoundText)

local soundChannelDropdown = ahn.createDropdown(
    dropdownColumn2X, 
    dropdownRow2Y, 
    "soundChannels", 
    ahn.soundChannels
)
ahn.createDropdownLabel(soundChannelDropdown, L.soundChannel)
ahn.createTooltip(soundChannelDropdown, "ANCHOR_TOP", L.soundChannelTooltip)

-- Checks the interface options based on the user's preferences when the addOn loads
function ahn.updateInterfaceOptions()
    playSoundsCheckButton:SetChecked(AHNPreferences.playSounds)
    enableInAHCheckButton:SetChecked(AHNPreferences.enableInAH)
    enableExpiredCheckButton:SetChecked(AHNPreferences.enableExpired)
    showGreetingCheckButton:SetChecked(AHNPreferences.showGreeting)
    enableCrossCharacterExpiredCheckButton:SetChecked(AHNPreferences.enableCrossCharacterExpired)
    ahn.setInitialDropdownText(successfulSoundDropdown, ahn.successfulSounds)
    ahn.setInitialDropdownText(failedSoundDropdown, ahn.failedSounds)
    ahn.setInitialDropdownText(expiredSoundDropdown, ahn.expiredSounds)
    ahn.setInitialDropdownText(soundChannelDropdown, ahn.soundChannels)
end
