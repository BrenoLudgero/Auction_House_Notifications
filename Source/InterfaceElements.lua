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
if locale == "ptBR" or locale == "frFR" then
    expiredCheckX = 325
    dropdownColumn2X = 310
    dropdownColumn2LabelX = 479
elseif locale == "deDE" then
    expiredCheckX = 265
    dropdownColumn2X = 330
    dropdownColumn2LabelX = 499
elseif locale == "ruRU" then
    expiredCheckX = 236
    dropdownColumn2X = 335
    dropdownColumn2LabelX = 504
end

-------------------------------------  TITLES  ----------------------------------------
local titleText = createText("GameFontNormalLarge", addonTitle, titlesTextX, -15)
local subtitleText = createText("GameFontHighlight", subtitle, titlesTextX, -35)
local soundPreferencesText = createText("GameFontNormalMed1", soundPreferences, titlesTextX, -85)
local testSoundsText = createText("GameFontNormalMed1", testSounds, titlesTextX, -235)
local miscellaneousText = createText("GameFontNormalMed1", miscellaneous, titlesTextX, -306)

----------------------------------  CHECKBUTTONS  -------------------------------------
local enableInAHCheckButton = createButton("CheckButton", enableInAHText, 25, -110,
    function(self) 
        preferences.enableInAH = self:GetChecked()
    end
)
local enableExpiredCheckButton = createButton("CheckButton", enableExpired, expiredCheckX, -110, 
    function(self) 
        preferences.enableExpired = self:GetChecked()
    end
)
createTooltip(enableInAHCheckButton, "ANCHOR_RIGHT", enableInAHTooltip)
local showGreetingCheckButton = createButton("CheckButton", showGreetingMessage, 27, -331, function(self)
    preferences.showGreeting = self:GetChecked()
    end
)

-------------------------------------  BUTTONS  ---------------------------------------
local testSuccessfulButton = createButton("Button", successfulText, 26, buttonY, 
    function(self)
        PlaySoundFile(preferences.chosenSounds.successful, preferences.chosenChannel)
    end
)
local testFailedButton = createButton("Button", failedText, 169, buttonY, 
    function(self)
        PlaySoundFile(preferences.chosenSounds.failed, preferences.chosenChannel)
    end
)
local testExpiredButton = createButton("Button", expiredText, 312, buttonY, 
    function(self)
        PlaySound(preferences.chosenSounds.expired, preferences.chosenChannel, true)
    end
)

---------------------------------  DROPDOWN LABELS  -----------------------------------
local successfulSoundLabel = createText("GameFontHighlight", successfulSoundText, dropdownColumn1LabelX, dropdownRow1LabelY)
local failedSoundLabel = createText("GameFontHighlight", failedSoundText, dropdownColumn1LabelX, dropdownRow2LabelY)
local expiredSoundLabel = createText("GameFontHighlight", expiredSoundText, dropdownColumn2LabelX, dropdownRow1LabelY)
local soundChannelLabel = createText("GameFontHighlight", soundChannelText, dropdownColumn2LabelX, dropdownRow2LabelY)

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
createTooltip(soundChannelDropdown, "ANCHOR_TOP", soundChannelTooltip)

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
