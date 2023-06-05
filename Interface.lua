frame = CreateFrame("FRAME")           -- Attributes CreateFrame() to a global variable for ease of use

local localizedTitle = titles[locale]  -- Attributes the localized addon title (Localization.lua) to a variable

frame.name = localizedTitle            -- Defines what localized name will be displayed for the addon
InterfaceOptions_AddCategory(frame)    -- Displays the addon in Interface Options -> AddOns

SLASH_AHN1 = "/ahn"                    -- Creates the slash command /ahn

SlashCmdList["AHN"] = function()                          -- Gives the slash command instructions to:
    InterfaceOptionsFrame_Show()                          -- Open the addons interface (mandatory)
    InterfaceOptionsFrame_OpenToCategory(titles[locale])  -- Open the Auction House Notifications options interface
end


function tableContains(table, val)    -- Responsible for comparing a table and a specific value

    for _, value in ipairs(table) do  -- For the specific value in each element of the table:
        if value == val then          -- If the value specified as a parameter is found in the table specified as a parameter:
            return true               -- Returns true
        end

    end

    return false                      -- If the value is not found, returns false

end



-- LOCAL FUNCTIONS TO CREATE AND MOVE FontStrings AND CHECKBUTTONS



local function createShowAndHideTooltip(item, tooltip)    -- Responsible for creating, showing and hiding tooltips for the interface's options

    item:SetScript("OnEnter", function(self)              -- When the mouse hovers the item (checkbox, dropdown):

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")        -- The position where the tooltip will be shown relative to the mouse pointer
        GameTooltip:SetText(tooltip)                      -- The parameter "tooltip" will define the text content of the tooltip
        GameTooltip:Show()                                -- The tooltip is shown

    end)

    item:SetScript("OnLeave", function(self)  -- When the mouse leaves the item:

        GameTooltip:Hide()                    -- The tooltip is hidden
    
    end)

end




-- Title
local settingsTitle = frame:CreateFontString(nil, "Title", "GameFontNormalLarge")  -- Creates a string inside inside AHN's options interface
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
enableInAHCheckButton = CreateFrame("CheckButton", "EnableInAH", frame, "InterfaceOptionsCheckButtonTemplate")  -- Creates a checkbox inside AHN's options interface
enableInAHCheckButton:SetPoint("TOPLEFT", 15, -120)
enableInAHCheckButton.Text:SetText("Enable in AH")                                                                               -- Assigns a label to the checkbox
createShowAndHideTooltip(enableInAHCheckButton, "Enable or disable alerts for successful\nauctions when the AH window is open")  -- Creates a tooltip for the checkbox


-- Sound Category Text
local soundCategoryText = frame:CreateFontString(nil, "SoundCategory", "GameFontHighlight")
soundCategoryText:SetPoint("TOPLEFT", 29, -158)
soundCategoryText:SetText("Sound Category")


-- Sound Category Dropdown
soundCategoryDropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")  -- Creates a dropdown rectangle inside AHN's options interface
soundCategoryDropdown:SetPoint("TOPLEFT", 2, -180)

soundCategoryDropdown.initialize = function(self)                                   -- Binds a menu function to the dropdown

    local info = UIDropDownMenu_CreateInfo()                                        -- Assings the creation of a dropdown item to a variable

    local soundCategoryNames = {                                                    -- Creates a table with the sounds (AuctionHouseNotifications.lua) and their respective category names
        [sounds.coins] = "Coins",
        [sounds.female] = "Female Human",
        [sounds.fireworks] = "Fireworks",
        [sounds.impact] = "Impact"
    }

    for sound, soundCategoryName in pairs(soundCategoryNames) do              -- For every sound categories in soundCategoryNames:
        info.text = soundCategoryName                                         -- Assigns the dropdown items their respective name
        info.value = sound[1]                                                 -- Assings the value of the items according to the appropriate sound fom the soundCategoryNames table
        info.checked = tableContains(preferences.chosenSounds, sound[1])      -- Finds the appropriate dropdown item and checks it once the user's preference is found in soundCategoryNames
        info.func = function()                                                -- Function to be called when the dropdown items are clicked

            preferences.chosenSounds = sound                                  -- Changes the chosen sound in SavedVariables
            UIDropDownMenu_SetSelectedValue(soundCategoryDropdown, sound[1])  -- Shows the selected category on the dropdown rectangle

        end

        UIDropDownMenu_AddButton(info)                                        -- Creates all dropdown items

    end

end

UIDropDownMenu_SetWidth(soundCategoryDropdown, 108)        -- Sets the width of the dropdown rectangle
UIDropDownMenu_SetButtonWidth(soundCategoryDropdown, 124)  -- Sets the horizontal (clickable) width of the dropdown arrow


-- Sound Channel Text
local soundChannelText = frame:CreateFontString(nil, "SoundChannel", "GameFontHighlight")
soundChannelText:SetPoint("TOPLEFT", 194, -158)
soundChannelText:SetText("Sound Channel")


-- Sound Channel Dropdown
soundChannelDropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
soundChannelDropdown:SetPoint("TOPLEFT", 175, -180)

soundChannelDropdown.initialize = function(self)

    local info = UIDropDownMenu_CreateInfo()

    local soundChannels = {  -- Creates an array with all possible sound channels
        "Master",
        "Sound",
        "Music",
        "Ambience",
        "Dialog"
    }

    for _, channel in ipairs(soundChannels) do                 -- For every sound channel in soundChannels:
        info.text = channel                                    -- Assigns the dropdown items their respective name
        info.checked = (preferences.chosenChannel == channel)  -- Checks the appropriate dropdown based on user's preference

        info.func = function()

            preferences.chosenChannel = channel
            UIDropDownMenu_SetSelectedValue(soundChannelDropdown, channel)

        end

        UIDropDownMenu_AddButton(info)

    end

end

UIDropDownMenu_SetWidth(soundChannelDropdown, 84)
UIDropDownMenu_SetButtonWidth(soundChannelDropdown, 102)
createShowAndHideTooltip(soundChannelDropdown, "The sound channel to be used by alerts")




-- Miscellaneous Text
local miscellaneousText = frame:CreateFontString(nil, "Miscellaneous", "GameFontNormalMed1")
miscellaneousText:SetPoint("TOPLEFT", 15, -245)
miscellaneousText:SetText("Miscellaneous")


-- Show Greeting Message CheckButton
showGreetingCheckButton = CreateFrame("CheckButton", "ShowGreetings", frame, "InterfaceOptionsCheckButtonTemplate")
showGreetingCheckButton:SetPoint("TOPLEFT", 15, -270)
showGreetingCheckButton.Text:SetText("Show Greeting Message")

showGreetingCheckButton:SetScript("OnClick", function(self)

    preferences.showGreeting = self:GetChecked()

end)
