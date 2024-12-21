local _, ahn = ...
local L = ahn.L

local dropdownWidth = 145
local buttonWidth = 120
local buttonHeight = 32
if ahn.locale == "deDE" then
    dropdownWidth = 150
end

-- Creates a string and places it in the options interface
function ahn.createText(font, text, xPosition, yPosition)
    local fontString = ahn.frame:CreateFontString(nil, "ARTWORK", font)
    fontString:SetText(text)
    fontString:SetJustifyH("LEFT")
    if xPosition and yPosition then
        fontString:SetPoint("TOPLEFT", xPosition, yPosition)
    end
    return fontString
end

-- Creates a Button or CheckButton and assigns a function to it
function ahn.createButton(kind, text, xPosition, yPosition, onClick)
    local button
    if kind == "CheckButton" then
        button = CreateFrame(kind, nil, ahn.frame, "InterfaceOptionsCheckButtonTemplate")
        local label = ahn.createText("GameFontHighlight", text)
        label:SetParent(button)
        label:SetPoint("LEFT", button, "RIGHT", 4, 1)
    elseif kind == "Button" then
        button = CreateFrame(kind, nil, ahn.frame, "UIPanelButtonTemplate")
        button:SetSize(buttonWidth, buttonHeight)
        button:SetText(text)
    end
    button:SetPoint("TOPLEFT", xPosition, yPosition)
    button:SetScript("OnClick", onClick)
    return button
end

local dropdownActions = {
    successfulSounds = {
        getPreference = function() return AHNPreferences.chosenSounds.successful end,
        savePreference = function(sound) AHNPreferences.chosenSounds.successful = sound end
    },
    failedSounds = {
        getPreference = function() return AHNPreferences.chosenSounds.failed end,
        savePreference = function(sound) AHNPreferences.chosenSounds.failed = sound end
    },
    expiredSounds = {
        getPreference = function() return AHNPreferences.chosenSounds.expired end,
        savePreference = function(sound) AHNPreferences.chosenSounds.expired = sound end
    },
    soundChannels = {
        getPreference = function() return AHNPreferences.chosenChannel end,
        savePreference = function(sound) AHNPreferences.chosenChannel = sound end
    }
}

-- Dropdown choice is saved directly to SavedVariables
local function saveDropdownOption(kind, sound)
    local actions = dropdownActions[kind]
    actions.savePreference(sound)
end

local function createDropdownOptions(dropdown, soundsTable)
    dropdown:SetupMenu(function(dropdown, rootDescription)
        for _, item in ipairs(soundsTable) do
            local sound = item[1]
            local name = item[2]
            rootDescription:CreateButton(name, function()
                saveDropdownOption(dropdown.kind, sound)
                dropdown:SetDefaultText(name)
            end)
        end
    end)
end

function ahn.createDropdown(xPosition, yPosition, kind, soundsTable)
    local dropdown = CreateFrame("DropdownButton", nil, ahn.frame, "WowStyle1DropdownTemplate")
    dropdown.kind = kind
    dropdown:SetPoint("CENTER")
    dropdown:SetPoint("TOPLEFT", xPosition, yPosition)
    dropdown:SetWidth(dropdownWidth)
    createDropdownOptions(dropdown, soundsTable)
    return dropdown
end

function ahn.createDropdownLabel(dropdown, text)
    local label = ahn.createText("GameFontHighlight", L.successfulSoundText)
    label:SetPoint("TOPLEFT", dropdown, "TOPRIGHT")
    label:SetPoint("BOTTOMLEFT", dropdown, "BOTTOMRIGHT")
    label:AdjustPointsOffset(10, 0)
end

function ahn.setInitialDropdownText(dropdown, soundsTable)
    local actions = dropdownActions[dropdown.kind]
    local preference = actions.getPreference()
    for _, item in ipairs(soundsTable) do
        local sound = item[1]
        local name = item[2]
        if sound == preference then
            dropdown:SetDefaultText(name)
            return
        end
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
