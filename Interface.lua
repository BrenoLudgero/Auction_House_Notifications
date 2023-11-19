frame = CreateFrame("FRAME")               -- Attributes CreateFrame() to a global variable for ease of use
locale = GetLocale()                       -- Saves the user's client language
local localizedTitle = addonTitles[locale] -- Gets the localized addOn title (Localization.lua)
frame.name = localizedTitle                -- Defines what localized name will be displayed for the addOn
InterfaceOptions_AddCategory(frame)        -- Displays the addOn in Interface Options -> AddOns

-- Creates the chat command /ahn that opens the Auction House Notifications options interface
SLASH_AHN1 = "/ahn"
SlashCmdList["AHN"] = function()
    Settings.OpenToCategory(addonTitles[locale])
end

-- Searches for a specific value in a table
local function tableContains(table, val)
    for _, value in ipairs(table) do 
        if value == val then
            return true
        end
    end
    return false
end

-- Creates a string with a description and positions it in the options interface
local function createInterfaceText(description, font, textValue, xPosition, yPosition)
    local fontString = frame:CreateFontString(description, "ARTWORK", font)
    fontString:SetText(textValue)
    fontString:SetPoint("TOPLEFT", xPosition, yPosition)
    fontString:SetJustifyH("LEFT")
    return fontString -- Returns the string so it can be assigned to a variable
end

local function createCheckButton(description, label, xPosition, yPosition, onClick)
    local checkButton = CreateFrame("CheckButton", description, frame, "InterfaceOptionsCheckButtonTemplate")
    checkButton.Text:SetText(label)
    checkButton:SetPoint("TOPLEFT", xPosition, yPosition)
    -- Assigns a function to the button
    checkButton:SetScript("OnClick", onClick)
    return checkButton
end

local function createDropdown(xPosition, yPosition, width, buttonWidth)
    local dropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", xPosition, yPosition)
    UIDropDownMenu_SetWidth(dropdown, width) -- Sets the visible width of the dropdown rectangle
    UIDropDownMenu_SetButtonWidth(dropdown, buttonWidth) -- Sets the clickable width of the dropdown arrow
    return dropdown
end

local function createButton(description, width, height, textValue, xPosition, yPosition, onClick)
    local button = CreateFrame("Button", description, frame, "UIPanelButtonTemplate")
    button:SetSize(width, height)
    button:SetPoint("TOPLEFT", xPosition, yPosition)
    button:SetText(textValue)
    button:SetScript("OnClick", onClick)
    return button
end

-- Creates and shows tooltips on hover
local function createTooltip(item, tooltip)
    item:SetScript("OnEnter", function(self) -- Mouse pointer reaches the item
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT") -- The position where the tooltip will be shown relative to the item
        GameTooltip:SetText(tooltip)
        GameTooltip:Show()
    end)
    item:SetScript("OnLeave", function(self) -- Mouse pointer leaves the item
        GameTooltip:Hide()
    end)
end

local title = createInterfaceText("Title", "GameFontNormalLarge", addonTitles[locale], 15, -15)
local subtitle = createInterfaceText("Subtitle", "GameFontHighlight", subtitleText[locale], 15, -35)

local soundPreferencesText = createInterfaceText("SoundPreferences", "GameFontNormalMed1", soundPreferencesTexts[locale], 15, -85)
local enableInAHCheckButton = createCheckButton("EnableInAH", enableInAHLabels[locale], 25, -110, function(self)
    preferences.enableInAH = self:GetChecked()
end)
local enableExpiredCheckButton = createCheckButton("EnableExpired", enableExpired[locale], 255, -110, function(self)
    preferences.enableExpired = self:GetChecked()
end)
createTooltip(enableInAHCheckButton, enableInAHTooltips[locale])

local soundCategoryText = createInterfaceText("SoundCategory", "GameFontHighlight", soundCategoryTexts[locale], 180, -154)
local soundCategoryDropdown = createDropdown(12, -148, 126, 140)
soundCategoryDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    local soundCategories = {
        [sounds.coins] = soundCategoryNames[locale][1],
        [sounds.female] = soundCategoryNames[locale][2],
        [sounds.fireworks] = soundCategoryNames[locale][3],
        [sounds.impact] = soundCategoryNames[locale][4],
        [sounds.quests] = soundCategoryNames[locale][5]
    }
    -- Finds wich sound category was chosen by the user and checks the appropriate dropdown item
    for soundKey, soundCategoryName in pairs(soundCategories) do
        info.text = soundCategoryName
        info.value = soundKey[1] -- Assings the value of the items according to the appropriate sound fom the soundCategoryNames table
        info.checked = tableContains(preferences.chosenSounds, soundKey[1])
        info.func = function()
            preferences.chosenSounds = soundKey -- Changes the chosen sound in SavedVariables once an option is clicked
            UIDropDownMenu_SetSelectedValue(soundCategoryDropdown, soundKey[1])
        end
        UIDropDownMenu_AddButton(info) -- Creates all soundCategoryDropdown items
    end
end

local soundChannelText = createInterfaceText("SoundChannel", "GameFontHighlight", soundChannelTexts[locale], 180, -196)
local soundChannelDropdown = createDropdown(12, -190, 126, 140)
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
createTooltip(soundChannelDropdown, soundChannelTooltips[locale])

local testSoundsText = createInterfaceText("test", "GameFontNormalMed1", testSoundsTexts[locale], 15, -235)
local testSuccessfulButton = createButton("testSuccessfulSound", 31, 31, "O", 30, -260, function(self)
    PlaySoundFile(preferences.chosenSounds[1], preferences.chosenChannel)
end)
local testFailedButton = createButton("testFailedSound", 31, 31, "X", 65, -260, function(self)
    PlaySoundFile(preferences.chosenSounds[2], preferences.chosenChannel) 
end)

local miscellaneousText = createInterfaceText("Miscellaneous", "GameFontNormalMed1", miscellaneousTexts[locale], 15, -306)
local showGreetingCheckButton = createCheckButton("ShowGreetings", showGreetingMessageTexts[locale], 25, -331, function(self)
    preferences.showGreeting = self:GetChecked()
end)

-- Updates user's preferences on the options interface when the addOn loads (AuctionHouseNotifications.lua)
function checkPreferencesInInterfaceOptions()
    -- Checks or unchecks the checkboxes based on user's preference
    enableInAHCheckButton:SetChecked(preferences.enableInAH)
    enableExpiredCheckButton:SetChecked(preferences.enableExpired)
    showGreetingCheckButton:SetChecked(preferences.showGreeting)
    -- Initializes the dropdown and changes it's displayed value based on the user's preference
    UIDropDownMenu_Initialize(soundCategoryDropdown, soundCategoryDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(soundCategoryDropdown, preferences.chosenSounds[1])
    UIDropDownMenu_Initialize(soundChannelDropdown, soundChannelDropdown.initialize)
    UIDropDownMenu_SetSelectedValue(soundChannelDropdown, preferences.chosenChannel)
end
