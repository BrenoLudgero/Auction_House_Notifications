local _, ahn = ...
local L = ahn.L

local dropdownWidth = 126
local dropdownButtonWidth = 140
local buttonWidth = 120
local buttonHeight = 32

-- Every "text" come from Localization.lua

-- Creates a string and places it in the options interface
function ahn.createText(font, text, xPosition, yPosition)
    local fontString = ahn.frame:CreateFontString(nil, "ARTWORK", font)
    fontString:SetText(text)
    fontString:SetPoint("TOPLEFT", xPosition, yPosition)
    fontString:SetJustifyH("LEFT")
    return fontString
end

-- Creates a Button or CheckButton and assigns a function to it
function ahn.createButton(kind, text, xPosition, yPosition, onClick)
    if kind == "CheckButton" then
        button = CreateFrame(kind, nil, ahn.frame, "InterfaceOptionsCheckButtonTemplate")
        button.Text:SetText(text)
    elseif kind == "Button" then
        button = CreateFrame(kind, nil, ahn.frame, "UIPanelButtonTemplate")
        button:SetSize(buttonWidth, buttonHeight)
        button:SetText(text)
    end
    button:SetPoint("TOPLEFT", xPosition, yPosition)
    button:SetScript("OnClick", onClick)
    return button
end

function ahn.createDropdown(xPosition, yPosition)
    local dropdown = CreateFrame("Frame", nil, ahn.frame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", xPosition, yPosition)
    UIDropDownMenu_SetWidth(dropdown, dropdownWidth) -- Sets the visible width of the dropdown rectangle
    UIDropDownMenu_SetButtonWidth(dropdown, dropdownButtonWidth) -- Sets the clickable width of the dropdown arrow
    return dropdown
end

local function checkDropdownOption(kind, info, key)
    if kind == "successfulSoundCategories" then
        info.checked = (AHNPreferences.chosenSounds.successful == key)
    elseif kind == "failedSoundCategories" then
        info.checked = (AHNPreferences.chosenSounds.failed == key)
    elseif kind == "expiredSoundCategories" then
        info.checked = (AHNPreferences.chosenSounds.expired == key)
    elseif kind == "soundChannels" then
        info.checked = (AHNPreferences.chosenChannel == key)
    end
end

-- Dropdown choice is saved directly to SavedVariables
local function setAndSaveDropdownOption(dropdown, kind, info, key)
    if kind == "successfulSoundCategories" then
        AHNPreferences.chosenSounds.successful = key
    elseif kind == "failedSoundCategories" then
        AHNPreferences.chosenSounds.failed = key
    elseif kind == "expiredSoundCategories" then
        AHNPreferences.chosenSounds.expired = key
    elseif kind == "soundChannels" then
        AHNPreferences.chosenChannel = key
    end
    UIDropDownMenu_SetSelectedValue(dropdown, key)
end

function ahn.createDropdownMenu(dropdown, kind, namesTable)
    local info = UIDropDownMenu_CreateInfo()
    info.minWidth = dropdownWidth
    for key, name in pairs(namesTable) do
        info.text = name
        info.value = key
        checkDropdownOption(kind, info, key)
        info.func = function()
            setAndSaveDropdownOption(dropdown, kind, info, key)
        end
        UIDropDownMenu_AddButton(info)
    end
end

-- Creates and shows tooltips on mouse hover
function ahn.createTooltip(item, anchor, tooltip)
    item:SetScript("OnEnter", function(self)
        -- Places the tooltip relative to the item
        GameTooltip:SetOwner(self, anchor)
        GameTooltip:SetText(tooltip)
        GameTooltip:Show()
    end)
    item:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
end

function ahn.showGreetingMessage()
    if AHNPreferences.showGreeting then
        print(L.greetingMessage)
    end
end
