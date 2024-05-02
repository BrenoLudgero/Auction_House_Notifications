local _, ahn = ...
local L = ahn.L

ahn.frame.name = L.title
InterfaceOptions_AddCategory(ahn.frame) -- Displays the addOn in Options -> AddOns

local titlesTextX = 15
local expiredCheckX = 315
local buttonY = -261
local dropdownColumn1X = 11
local dropdownColumn2X = 300
local dropdownRow1Y = -148
local dropdownRow2Y = -190
local dropdownColumn1LabelX = 180
local dropdownColumn2LabelX = 469
local dropdownRow1LabelY = -154
local dropdownRow2LabelY = -196
if ahn.locale == "ptBR" or ahn.locale == "frFR" then
    expiredCheckX = 325
    dropdownColumn2X = 310
    dropdownColumn2LabelX = 479
elseif ahn.locale == "deDE" then
    expiredCheckX = 265
    dropdownColumn2X = 330
    dropdownColumn2LabelX = 499
elseif ahn.locale == "ruRU" then
    expiredCheckX = 236
    dropdownColumn2X = 335
    dropdownColumn2LabelX = 504
end

-------------------------------------  TITLES  ----------------------------------------
local titleText = ahn.createText("GameFontNormalLarge", L.title, titlesTextX, -15)
local subtitleText = ahn.createText("GameFontHighlight", L.subtitle, titlesTextX, -35)
local soundPreferencesText = ahn.createText("GameFontNormalMed1", L.soundPreferences, titlesTextX, -85)
local testSoundsText = ahn.createText("GameFontNormalMed1", L.testSounds, titlesTextX, -235)
local miscellaneousText = ahn.createText("GameFontNormalMed1", L.miscellaneous, titlesTextX, -306)

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
local showGreetingCheckButton = ahn.createButton("CheckButton", L.showGreetingMessage, 27, -331, function(self)
    AHNPreferences.showGreeting = self:GetChecked()
    end
)

-------------------------------------  BUTTONS  ---------------------------------------
local testSuccessfulButton = ahn.createButton("Button", L.successfulText, 26, buttonY, 
    function(self)
        PlaySoundFile(AHNPreferences.chosenSounds.successful, AHNPreferences.chosenChannel)
    end
)
local testFailedButton = ahn.createButton("Button", L.failedText, 169, buttonY, 
    function(self)
        PlaySoundFile(AHNPreferences.chosenSounds.failed, AHNPreferences.chosenChannel)
    end
)
local testExpiredButton = ahn.createButton("Button", L.expiredText, 312, buttonY, 
    function(self)
        PlaySound(AHNPreferences.chosenSounds.expired, AHNPreferences.chosenChannel, true)
    end
)

---------------------------------  DROPDOWN LABELS  -----------------------------------
local successfulSoundLabel = ahn.createText("GameFontHighlight", L.successfulSoundText, dropdownColumn1LabelX, dropdownRow1LabelY)
local failedSoundLabel = ahn.createText("GameFontHighlight", L.failedSoundText, dropdownColumn1LabelX, dropdownRow2LabelY)
local expiredSoundLabel = ahn.createText("GameFontHighlight", L.expiredSoundText, dropdownColumn2LabelX, dropdownRow1LabelY)
local soundChannelLabel = ahn.createText("GameFontHighlight", L.soundChannelText, dropdownColumn2LabelX, dropdownRow2LabelY)

------------------------------------  DROPDOWNS  --------------------------------------
local successfulSoundDropdown = ahn.createDropdown(dropdownColumn1X, dropdownRow1Y)
successfulSoundDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local successfulSoundCategories = {
        [ahn.successfulSounds.coins] = L.soundCategoryNames[1],
        [ahn.successfulSounds.female] = L.soundCategoryNames[2],
        [ahn.successfulSounds.fireworks] = L.soundCategoryNames[3],
        [ahn.successfulSounds.impact] = L.soundCategoryNames[4],
        [ahn.successfulSounds.quests] = L.soundCategoryNames[5]
    }
    ahn.createDropdownMenu(self, "successfulSoundCategories", successfulSoundCategories)
end

local failedSoundDropdown = ahn.createDropdown(dropdownColumn1X, dropdownRow2Y)
failedSoundDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local failedSoundCategories = {
        [ahn.failedSounds.coins] = L.soundCategoryNames[1],
        [ahn.failedSounds.female] = L.soundCategoryNames[2],
        [ahn.failedSounds.fireworks] = L.soundCategoryNames[3],
        [ahn.failedSounds.impact] = L.soundCategoryNames[4],
        [ahn.failedSounds.quests] = L.soundCategoryNames[5]
    }
    ahn.createDropdownMenu(self, "failedSoundCategories", failedSoundCategories)
end

local expiredSoundDropdown = ahn.createDropdown(dropdownColumn2X, dropdownRow1Y)
expiredSoundDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local expiredSoundCategories = {
        [ahn.expiredSounds.sheep] = L.soundCategoryNames[6],
        [ahn.expiredSounds.thunder] = L.soundCategoryNames[7],
        [ahn.expiredSounds.what] = L.soundCategoryNames[8],
        [ahn.expiredSounds.growl] = L.soundCategoryNames[9],
        [ahn.expiredSounds.chicken] = L.soundCategoryNames[10]
    }
    ahn.createDropdownMenu(self, "expiredSoundCategories", expiredSoundCategories)
end

local soundChannelDropdown = ahn.createDropdown(dropdownColumn2X, dropdownRow2Y)
soundChannelDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local soundChannels = {
        ["Master"] = L.soundChannelNames[1],
        ["Sound"] = L.soundChannelNames[2],
        ["Music"] = L.soundChannelNames[3],
        ["Ambience"] = L.soundChannelNames[4],
        ["Dialog"] = L.soundChannelNames[5]
    }
    ahn.createDropdownMenu(self, "soundChannels", soundChannels)
end
ahn.createTooltip(soundChannelDropdown, "ANCHOR_TOP", L.soundChannelTooltip)

-- Checks the interface options based on the user's preferences when the addOn loads (AuctionHouseNotifications.lua)
function ahn.updateInterfaceOptions()
    enableInAHCheckButton:SetChecked(AHNPreferences.enableInAH)
    enableExpiredCheckButton:SetChecked(AHNPreferences.enableExpired)
    showGreetingCheckButton:SetChecked(AHNPreferences.showGreeting)
    UIDropDownMenu_Initialize(successfulSoundDropdown, successfulSoundDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(successfulSoundDropdown, AHNPreferences.chosenSounds.successful)
    UIDropDownMenu_Initialize(failedSoundDropdown, failedSoundDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(failedSoundDropdown, AHNPreferences.chosenSounds.failed)
    UIDropDownMenu_Initialize(expiredSoundDropdown, expiredSoundDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(expiredSoundDropdown, AHNPreferences.chosenSounds.expired)
    UIDropDownMenu_Initialize(soundChannelDropdown, soundChannelDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(soundChannelDropdown, AHNPreferences.chosenChannel)
end

ahn.createText = nil
ahn.createButton = nil
ahn.createDropdown = nil
ahn.createTooltip = nil
