frame.name = addonTitle
InterfaceOptions_AddCategory(frame) -- Displays the addOn in Options -> AddOns

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
if locale == "ruRU" then
    expiredCheckX = 236
elseif locale == "deDE" then
    expiredCheckX = 275
    dropdownColumn2X = 330
    dropdownColumn2LabelX = 499
end

-------------------------------------  TITLES  ----------------------------------------
local titleText = createText("Title", "GameFontNormalLarge", addonTitle, titlesTextX, -15)
local subtitleText = createText("Subtitle", "GameFontHighlight", subtitle, titlesTextX, -35)
local soundPreferencesText = createText("SoundPreferences", "GameFontNormalMed1", soundPreferences, titlesTextX, -85)
local testSoundsText = createText("Test", "GameFontNormalMed1", testSounds, titlesTextX, -235)
local miscellaneousText = createText("Miscellaneous", "GameFontNormalMed1", miscellaneous, titlesTextX, -306)

----------------------------------  CHECKBUTTONS  -------------------------------------
local enableInAHCheckButton = createButton("CheckButton", "EnableInAH", enableInAHText, 25, -110,
    function(self) 
        preferences.enableInAH = self:GetChecked()
    end
)
local enableExpiredCheckButton = createButton("CheckButton", "EnableExpired", enableExpired, expiredCheckX, -110, 
    function(self) 
        preferences.enableExpired = self:GetChecked()
    end
)
createTooltip(enableInAHCheckButton, enableInAHTooltip)
local showGreetingCheckButton = createButton("CheckButton", "ShowGreeting", showGreetingMessage, 27, -331, function(self)
    preferences.showGreeting = self:GetChecked()
    end
)

-------------------------------------  BUTTONS  ---------------------------------------
local testSuccessfulButton = createButton("Button", "testSuccessfulSound", successfulText, 26, buttonY, 
    function(self)
        PlaySoundFile(preferences.chosenSounds.successful, preferences.chosenChannel)
    end
)
local testFailedButton = createButton("Button", "testFailedSound", failedText, 169, buttonY, 
    function(self)
        PlaySoundFile(preferences.chosenSounds.failed, preferences.chosenChannel)
    end
)
local testExpiredButton = createButton("Button", "testExpiredSound", expiredText, 312, buttonY, 
    function(self)
        PlaySound(preferences.chosenSounds.expired, preferences.chosenChannel, true)
    end
)

---------------------------------  DROPDOWN LABELS  -----------------------------------
local successfulSoundLabel = createText("SuccessfulSound", "GameFontHighlight", successfulSoundText, dropdownColumn1LabelX, dropdownRow1LabelY)
local failedSoundLabel = createText("FailedSound", "GameFontHighlight", failedSoundText, dropdownColumn1LabelX, dropdownRow2LabelY)
local expiredSoundLabel = createText("ExpiredSound", "GameFontHighlight", expiredSoundText, dropdownColumn2LabelX, dropdownRow1LabelY)
local soundChannelLabel = createText("SoundChannel", "GameFontHighlight", soundChannelText, dropdownColumn2LabelX, dropdownRow2LabelY)

------------------------------------  DROPDOWNS  --------------------------------------
local successfulSoundDropdown = createDropdown(dropdownColumn1X, dropdownRow1Y)
successfulSoundDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local successfulSoundCategories = {
        [successfulSounds.coins] = soundCategoryNames[1],
        [successfulSounds.female] = soundCategoryNames[2],
        [successfulSounds.fireworks] = soundCategoryNames[3],
        [successfulSounds.impact] = soundCategoryNames[4],
        [successfulSounds.quests] = soundCategoryNames[5]
    }
    createDropdownMenu(self, "successfulSoundCategories", successfulSoundCategories)
end

local failedSoundDropdown = createDropdown(dropdownColumn1X, dropdownRow2Y)
failedSoundDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local failedSoundCategories = {
        [failedSounds.coins] = soundCategoryNames[1],
        [failedSounds.female] = soundCategoryNames[2],
        [failedSounds.fireworks] = soundCategoryNames[3],
        [failedSounds.impact] = soundCategoryNames[4],
        [failedSounds.quests] = soundCategoryNames[5]
    }
    createDropdownMenu(self, "failedSoundCategories", failedSoundCategories)
end

local expiredSoundDropdown = createDropdown(dropdownColumn2X, dropdownRow1Y)
expiredSoundDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local expiredSoundCategories = {
        [expiredSounds.sheep] = soundCategoryNames[6],
        [expiredSounds.thunder] = soundCategoryNames[7],
        [expiredSounds.what] = soundCategoryNames[8],
        [expiredSounds.growl] = soundCategoryNames[9],
        [expiredSounds.chicken] = soundCategoryNames[10]
    }
    createDropdownMenu(self, "expiredSoundCategories", expiredSoundCategories)
end

local soundChannelDropdown = createDropdown(dropdownColumn2X, dropdownRow2Y)
soundChannelDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local soundChannels = {
        ["Master"] = soundChannelNames[1],
        ["Sound"] = soundChannelNames[2],
        ["Music"] = soundChannelNames[3],
        ["Ambience"] = soundChannelNames[4],
        ["Dialog"] = soundChannelNames[5]
    }
    createDropdownMenu(self, "soundChannels", soundChannels)
end
createTooltip(soundChannelDropdown, soundChannelTooltip)

-- Checks the interface options based on the user's preferences when the addOn loads (AuctionHouseNotifications.lua)
function checkInterfaceOptions()
    enableInAHCheckButton:SetChecked(preferences.enableInAH)
    enableExpiredCheckButton:SetChecked(preferences.enableExpired)
    showGreetingCheckButton:SetChecked(preferences.showGreeting)
    UIDropDownMenu_Initialize(successfulSoundDropdown, successfulSoundDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(successfulSoundDropdown, preferences.chosenSounds.successful)
    UIDropDownMenu_Initialize(failedSoundDropdown, failedSoundDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(failedSoundDropdown, preferences.chosenSounds.failed)
    UIDropDownMenu_Initialize(expiredSoundDropdown, expiredSoundDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(expiredSoundDropdown, preferences.chosenSounds.expired)
    UIDropDownMenu_Initialize(soundChannelDropdown, soundChannelDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(soundChannelDropdown, preferences.chosenChannel)
end
