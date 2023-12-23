local dropdownWidth = 126
local dropdownButtonWidth = 140
local buttonWidth = 120
local buttonHeight = 32

-- All "text" comes from Localization.lua

-- Creates a string and positions it in the options interface
function createText(description, font, text, xPosition, yPosition)
    local fontString = frame:CreateFontString(description, "ARTWORK", font)
    fontString:SetText(text)
    fontString:SetPoint("TOPLEFT", xPosition, yPosition)
    fontString:SetJustifyH("LEFT")
    return fontString
end

-- Creates a Button or CheckButton and assigns a function to it
function createButton(kind, description, text, xPosition, yPosition, onClick)
    if kind == "CheckButton" then
        button = CreateFrame(kind, description, frame, "InterfaceOptionsCheckButtonTemplate")
        button.Text:SetText(text)
    elseif kind == "Button" then
        button = CreateFrame(kind, description, frame, "UIPanelButtonTemplate")
        button:SetSize(buttonWidth, buttonHeight)
        button:SetText(text)
    end
    button:SetPoint("TOPLEFT", xPosition, yPosition)
    button:SetScript("OnClick", onClick)
    return button
end

function createDropdown(xPosition, yPosition)
    local dropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", xPosition, yPosition)
    UIDropDownMenu_SetWidth(dropdown, dropdownWidth) -- Sets the visible width of the dropdown rectangle
    UIDropDownMenu_SetButtonWidth(dropdown, dropdownButtonWidth) -- Sets the clickable width of the dropdown arrow
    return dropdown
end

local function checkDropdownOption(kind, info, key)
    if kind == "successfulSoundCategories" then
        info.checked = (preferences.chosenSounds.successful == key)
    elseif kind == "failedSoundCategories" then
        info.checked = (preferences.chosenSounds.failed == key)
    elseif kind == "expiredSoundCategories" then
        info.checked = (preferences.chosenSounds.expired == key)
    elseif kind == "soundChannels" then
        info.checked = (preferences.chosenChannel == key)
    end
end

-- Dropdown choice is saved directly to SavedVariables
local function setAndSaveDropdownOption(dropdown, kind, info, key)
    if kind == "successfulSoundCategories" then
        preferences.chosenSounds.successful = key
    elseif kind == "failedSoundCategories" then
        preferences.chosenSounds.failed = key
    elseif kind == "expiredSoundCategories" then
        preferences.chosenSounds.expired = key
    elseif kind == "soundChannels" then
        preferences.chosenChannel = key
    end
    UIDropDownMenu_SetSelectedValue(dropdown, key)
end

function createDropdownMenu(dropdown, kind, namesTable)
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
function createTooltip(item, anchor, tooltip)
    item:SetScript("OnEnter", function(self)
        -- Positions the tooltip relative to the item
        GameTooltip:SetOwner(self, anchor)
        GameTooltip:SetText(tooltip)
        GameTooltip:Show()
    end)
    item:SetScript("OnLeave", function(self)
        GameTooltip:Hide()
    end)
end
