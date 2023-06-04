frame = CreateFrame("FRAME")           -- Attributes CreateFrame() to a global variable for ease of use

local localizedTitle = titles[locale]  -- Attributes the localized addon title (Localization.lua) to a variable

frame.name = localizedTitle            -- Defines what name for the addon will be displayed
InterfaceOptions_AddCategory(frame)    -- Displays the addon in Interface Options -> AddOns

SLASH_AHN1 = "/ahn"                    -- Creates the slash command /ahn

SlashCmdList["AHN"] = function()                          -- Gives the slash command instructions to:
    InterfaceOptionsFrame_Show()                          -- Open the addons panel (mandatory)
    InterfaceOptionsFrame_OpenToCategory(titles[locale])  -- Open the Auction House Notifications panel
end


-- Title
local settingsTitle = frame:CreateFontString(nil, "Title", "GameFontNormalLarge")  -- Creates a string inside Auction House Notification options
settingsTitle:SetPoint("TOPLEFT", 15, -15)                                         -- Sets the string position
settingsTitle:SetText(titles[locale])                                              -- Defines the string content

-- Subtitle
local settingsSubtitle = frame:CreateFontString(nil, "Subtitle", "GameFontHighlight")
settingsSubtitle:SetPoint("TOPLEFT", 15, -35)
settingsSubtitle:SetText("Created by Breno Ludgero\nVersion " ..GetAddOnMetadata("AuctionHouseNotifications", "Version"))
settingsSubtitle:SetJustifyH("LEFT")  -- Justify the string horizontally



-- Sound Preferences Text
local settingsTitle = frame:CreateFontString(nil, "SoundPreferences", "GameFontNormalMed1")
settingsTitle:SetPoint("TOPLEFT", 15, -95)
settingsTitle:SetText("Sound Preferences")


-- Enable in Auction House CheckButton
local enableInAHCheckButton = CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
enableInAHCheckButton:SetPoint("TOPLEFT", 15, -120)
enableInAHCheckButton.Text:SetText("Enable in Auction House")

enableInAHCheckButton:SetScript("OnClick", function(self)

    preferences.enableInAH = self:GetChecked()  -- Assign the checked state directly to preferences.enableInAH

end)


-- Sound Category Text
local soundCategoryText = frame:CreateFontString(nil, "SoundCategory", "GameFontHighlight")
soundCategoryText:SetPoint("TOPLEFT", 29, -158)
soundCategoryText:SetText("Sound Category")


-- Sound Category Dropdown
local soundCategoryDropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
soundCategoryDropdown:SetPoint("TOPLEFT", 2, -180)
soundCategoryDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    
    local soundCategories = {
        [sounds.coins] = "Coins",
        [sounds.female] = "Female Human",
        [sounds.fireworks] = "Fireworks",
        [sounds.impact] = "Impact"
    }
    
    for sound, soundCategory in pairs(soundCategories) do
        info.text = soundCategory
        info.checked = (preferences.chosenSounds == sounds)  -- Not working
        info.func = function()
            preferences.chosenSounds = sound
            UIDropDownMenu_SetSelectedValue(soundCategoryDropdown, soundCategory)

        end

        UIDropDownMenu_AddButton(info)

    end

end

UIDropDownMenu_SetWidth(soundCategoryDropdown, 108)
UIDropDownMenu_SetButtonWidth(soundCategoryDropdown, 20)
UIDropDownMenu_JustifyText(soundCategoryDropdown, "LEFT")


-- Sound Channel Text
local soundChannelText = frame:CreateFontString(nil, "SoundChannel", "GameFontHighlight")
soundChannelText:SetPoint("TOPLEFT", 196, -158)
soundChannelText:SetText("Sound Channel")


-- Sound Channel Dropdown
local soundChannelDropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
soundChannelDropdown:SetPoint("TOPLEFT", 175, -180)
soundChannelDropdown.initialize = function(self)
    local info = UIDropDownMenu_CreateInfo()
    
    local soundChannels = {
        "Master",
        "Sound",
        "Music",
        "Ambience",
        "Dialog"
    }
    
    for _, channel in ipairs(soundChannels) do
        info.text = channel
        info.checked = (preferences.chosenChannel == channel)
        info.func = function()
            preferences.chosenChannel = channel
            UIDropDownMenu_SetSelectedValue(soundChannelDropdown, channel)

        end

        UIDropDownMenu_AddButton(info)

    end

end

UIDropDownMenu_SetWidth(soundChannelDropdown, 84)
UIDropDownMenu_SetButtonWidth(soundChannelDropdown, 20)
UIDropDownMenu_JustifyText(soundChannelDropdown, "LEFT")



-- Miscellaneous Text
local miscellaneousText = frame:CreateFontString(nil, "Miscellaneous", "GameFontNormalMed1")
miscellaneousText:SetPoint("TOPLEFT", 15, -245)
miscellaneousText:SetText("Miscellaneous")


-- Show Greeting Message CheckButton
local showGreetingCheckButton = CreateFrame("CheckButton", nil, frame, "InterfaceOptionsCheckButtonTemplate")
showGreetingCheckButton:SetPoint("TOPLEFT", 15, -270)
showGreetingCheckButton.Text:SetText("Show Greeting Message")

showGreetingCheckButton:SetScript("OnClick", function(self)

    preferences.showGreeting = self:GetChecked()
    
end)
