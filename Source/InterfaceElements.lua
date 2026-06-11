local _, ahn = ...
local L = ahn.L

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
    expiredCheckX = 243
    dropdownColumn2X = 352
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
ahn.createTooltip(enableInAHCheckButton, "ANCHOR_RIGHT", L.enableInAHTooltip)

local enableExpiredCheckButton = ahn.createButton("CheckButton", L.enableExpired, expiredCheckX, -110, 
    function(self) 
        AHNPreferences.enableExpired = self:GetChecked()
    end
)

local showGreetingCheckButton = ahn.createButton("CheckButton", L.showGreetingMessage, 27, -356, 
    function(self)
        AHNPreferences.showGreeting = self:GetChecked()
    end
)

-------------------------------------  BUTTONS  ---------------------------------------
local testSuccessfulButton = ahn.createButton("Button", L.successfulText, 26, buttonsY, 
    function(self) ahn.playOverlappingSound(AHNPreferences.chosenSounds.successful) end
)

local testFailedButton = ahn.createButton("Button", L.failedText, 169, buttonsY, 
    function(self) ahn.playOverlappingSound(AHNPreferences.chosenSounds.failed) end
)

local testExpiredButton = ahn.createButton("Button", L.expiredText, 312, buttonsY, 
    function(self)
        local sound = AHNPreferences.chosenSounds.expired
        if type(sound) == "string" then -- Custom sound
            ahn.playOverlappingSound(sound)
        else
            ahn.playNonOverlappingSound(sound)
        end
    end
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
    enableInAHCheckButton:SetChecked(AHNPreferences.enableInAH)
    enableExpiredCheckButton:SetChecked(AHNPreferences.enableExpired)
    showGreetingCheckButton:SetChecked(AHNPreferences.showGreeting)
    ahn.setInitialDropdownText(successfulSoundDropdown, ahn.successfulSounds)
    ahn.setInitialDropdownText(failedSoundDropdown, ahn.failedSounds)
    ahn.setInitialDropdownText(expiredSoundDropdown, ahn.expiredSounds)
    ahn.setInitialDropdownText(soundChannelDropdown, ahn.soundChannels)
end
