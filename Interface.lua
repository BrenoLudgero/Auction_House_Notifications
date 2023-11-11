frame = CreateFrame("FRAME")                -- Attributes CreateFrame() to a global variable for ease of use
locale = GetLocale()                        -- Checks the user's client language and saves it to a global variable
local localizedTitle = addonTitles[locale]  -- Attributes the localized addOn title (Localization.lua) to a variable
frame.name = localizedTitle                 -- Defines what localized name will be displayed for the addOn
InterfaceOptions_AddCategory(frame)         -- Displays the addOn in Interface Options -> AddOns

SLASH_AHN1 = "/ahn"                               -- Creates the chat command /ahn
SlashCmdList["AHN"] = function()                  -- Assings the chat command instructions to:
    Settings.OpenToCategory(addonTitles[locale])  -- Open the Auction House Notifications options interface
end

local function tableContains(table, val)  -- Responsible for searching a specific value in a table
    for _, value in ipairs(table) do 
        if value == val then
            return true
        end
    end
    return false  -- If the value was not found
end

local function createAndSetInterfaceText(description, font, textValue, xPosition, yPosition)  -- Responsible for creating and positioning a string inside inside AHN's options interface
    local fontString = frame:CreateFontString(description, "ARTWORK", font)  -- Creates a string with the variable description and font specifed in the parameters
    fontString:SetText(textValue)                         -- Defines the string value specified in the parameters
    fontString:SetPoint("TOPLEFT", xPosition, yPosition)  -- Sets the X and Y positions specified in the parameters
    fontString:SetJustifyH("LEFT")                        -- Justify the string horizontally
    return fontString
end

local function createAndSetCheckButtons(description, label, xPosition, yPosition)  -- Responsible for creating and positioning a checkbox inside inside AHN's options interface
    local checkButton = CreateFrame("CheckButton", description, frame, "InterfaceOptionsCheckButtonTemplate")  -- Creates a checkbox with the variable description specifed in the parameters
    checkButton.Text:SetText(label)                        -- Defines the checkbox's label specified in the parameters
    checkButton:SetPoint("TOPLEFT", xPosition, yPosition)  -- Sets the X and Y positions specified in the parameters
    return checkButton                                     -- Returns the checkbutton so it can be assigned to a variable
end

local function createAndSetDropdowns(xPosition, yPosition)  -- Responsible for creating and positioning a dropdown inside inside AHN's options interface
    local dropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")  -- Creates a dropdown with the variable description specifed in the parameters
    dropdown:SetPoint("TOPLEFT", xPosition, yPosition)  -- Sets the X and Y positions specified in the parameters
    return dropdown                                     -- Returns the dropdown so it can be assigned to a variable
end

local function createSetAndReziseButtons(description, width, height, textValue, xPosition, yPosition)  -- Responsible for creating and positioning a button inside inside AHN's options interface
    local button = CreateFrame("Button", description, frame, "UIPanelButtonTemplate")  -- Creates a button with the variable description specifed in the parameters
    button:SetSize(width, height)                     -- Defines the width and height specified in the parameters
    button:SetPoint("TOPLEFT", xPosition, yPosition)  -- Sets the X and Y positions specified in the parameters
    button:SetText(textValue)                         -- Defines the string value shown inside the button
    return button                                     -- Returns the button so it can be assigned to a variable
end

local function createShowAndHideTooltip(item, tooltip)  -- Responsible for creating, showing and hiding tooltips for the interface's options
    item:SetScript("OnEnter", function(self)        -- When the mouse pointer hovers the "item" (checkbox, dropdown):
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")  -- The position where the tooltip will be shown relative to the item
        GameTooltip:SetText(tooltip)                -- The parameter "tooltip" will define the text content of the tooltip
        GameTooltip:Show()                          -- The tooltip is shown
    end)
    item:SetScript("OnLeave", function(self)  -- When the mouse pointer leaves the item:
        GameTooltip:Hide()                    -- The tooltip is hidden
    end)
end

local title = createAndSetInterfaceText("Title", "GameFontNormalLarge", addonTitles[locale], 15, -15)  -- Creates a new interface text and assigns it to a variable for possible future modifications
local subtitle = createAndSetInterfaceText("Subtitle", "GameFontHighlight", subtitleText[locale], 15, -35)  -- Uses localized values from Lozalization.lua

local soundPreferencesText = createAndSetInterfaceText("SoundPreferences", "GameFontNormalMed1", soundPreferencesTexts[locale], 15, -85)
local enableInAHCheckButton = createAndSetCheckButtons("EnableInAH", enableInAHLabels[locale], 25, -110)  -- Creates a new checkbox and assigns it to a variable
local enableExpiredCheckButton = createAndSetCheckButtons("EnableExpired", enableExpired[locale], 255, -110)  -- Creates a new checkbox and assigns it to a variable
createShowAndHideTooltip(enableInAHCheckButton, enableInAHTooltips[locale])  -- Creates a tooltip for enableInAHCheckButton with the localized value from enableInAHTooltips
enableInAHCheckButton:SetScript("OnClick", function(self)  -- When the checkbutton is clicked:
    preferences.enableInAH = self:GetChecked()             -- Assign the checked state directly to preferences.enableInAH
end)
enableExpiredCheckButton:SetScript("OnClick", function(self)
    preferences.enableExpired = self:GetChecked()
end)

local soundCategoryText = createAndSetInterfaceText("SoundCategory", "GameFontHighlight", soundCategoryTexts[locale], 180, -154)
local soundCategoryDropdown = createAndSetDropdowns(12, -148)  -- Creates a new dropdown and assigns it to a variable
UIDropDownMenu_SetWidth(soundCategoryDropdown, 126)            -- Sets the (visible) width of the dropdown rectangle
UIDropDownMenu_SetButtonWidth(soundCategoryDropdown, 140)      -- Sets the (clickable) width of the dropdown arrow
soundCategoryDropdown.initialize = function(self)  -- Assigns an interface function to the dropdown
    local info = UIDropDownMenu_CreateInfo()       -- Assings the creation of a dropdown item to a variable
    local soundCategories = {                      -- Creates a table with the AuctionHouseNotifications.lua variables and their respective category names
        [sounds.coins] = soundCategoryNames[locale][1],
        [sounds.female] = soundCategoryNames[locale][2],
        [sounds.fireworks] = soundCategoryNames[locale][3],
        [sounds.impact] = soundCategoryNames[locale][4],
        [sounds.quests] = soundCategoryNames[locale][5]
    }
    for soundKey, soundCategoryName in pairs(soundCategories) do             -- For every sound category in soundCategories:
        info.text = soundCategoryName                                        -- Assigns the dropdown items their respective name
        info.value = soundKey[1]                                             -- Assings the value of the items according to the appropriate sound fom the soundCategoryNames table
        info.checked = tableContains(preferences.chosenSounds, soundKey[1])  -- Finds wich sound category was chosen by the user and checks the appropriate dropdown item
        info.func = function()                                                   -- Assigns a function for when the dropdown items are clicked
            preferences.chosenSounds = soundKey                                  -- Changes the chosen sound in SavedVariables
            UIDropDownMenu_SetSelectedValue(soundCategoryDropdown, soundKey[1])  -- Shows the selected category on the dropdown rectangle
        end
        UIDropDownMenu_AddButton(info)  -- Creates all soundCategoryDropdown items
    end
end

local soundChannelText = createAndSetInterfaceText("SoundChannel", "GameFontHighlight", soundChannelTexts[locale], 180, -196)
local soundChannelDropdown = createAndSetDropdowns(12, -190)
UIDropDownMenu_SetWidth(soundChannelDropdown, 126)
UIDropDownMenu_SetButtonWidth(soundChannelDropdown, 140)
createShowAndHideTooltip(soundChannelDropdown, soundChannelTooltips[locale])
soundChannelDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local soundChannels = {
        ["Master"] = soundChannelNames[locale][1],
        ["Sound"] = soundChannelNames[locale][2],
        ["Music"] = soundChannelNames[locale][3],
        ["Ambience"] = soundChannelNames[locale][4],
        ["Dialog"] = soundChannelNames[locale][5]
    }
    for channelKey, channelName in pairs(soundChannels) do
        info.text = channelName
        info.value = channelKey
        info.checked = (preferences.chosenChannel == channelKey)
        info.func = function()
            preferences.chosenChannel = channelKey
            UIDropDownMenu_SetSelectedValue(soundChannelDropdown, channelKey)
        end
        UIDropDownMenu_AddButton(info)
    end
end

local testSoundsText = createAndSetInterfaceText("test", "GameFontNormalMed1", testSoundsTexts[locale], 15, -235)
local testSuccessfulButton = createSetAndReziseButtons("testSuccessfulSound", 31, 31, "O", 30, -260)  -- Creates a new button and assigns it to a variable
testSuccessfulButton:SetScript("OnClick", function(self)  -- When the button is clicked:
    PlaySoundFile(preferences.chosenSounds[1], preferences.chosenChannel)  -- Plays the chosen successful sound in the chosen channel
end)
local testFailedButton = createSetAndReziseButtons("testFailedSound", 31, 31, "X", 65, -260)
testFailedButton:SetScript("OnClick", function(self)
    PlaySoundFile(preferences.chosenSounds[2], preferences.chosenChannel)  -- Plays the chosen failed sound in the chosen channel
end)

local miscellaneousText = createAndSetInterfaceText("Miscellaneous", "GameFontNormalMed1", miscellaneousTexts[locale], 15, -306)
local showGreetingCheckButton = createAndSetCheckButtons("ShowGreetings", showGreetingMessageTexts[locale], 25, -331)
showGreetingCheckButton:SetScript("OnClick", function(self)
    preferences.showGreeting = self:GetChecked()
end)

function checkPreferencesInInterfaceOptions()  -- Responsible for updating user's preferences on the options interface when the addOn loads
    enableInAHCheckButton:SetChecked(preferences.enableInAH)                             -- Checks or unchecks the checkboxes based on user's preference
    enableExpiredCheckButton:SetChecked(preferences.enableExpired)
    showGreetingCheckButton:SetChecked(preferences.showGreeting)
    UIDropDownMenu_Initialize(soundCategoryDropdown, soundCategoryDropdown.initialize)   -- Initializes the dropdown so the value can be displayed
    UIDropDownMenu_SetSelectedValue(soundCategoryDropdown, preferences.chosenSounds[1])  -- Changes the display value of the dropdown based on the user's preference
    UIDropDownMenu_Initialize(soundChannelDropdown, soundChannelDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(soundChannelDropdown, preferences.chosenChannel)
end
