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
local settingsTitle = frame:CreateFontString(nil, nil, "GameFontNormalLarge")  -- Creates a text panel inside Auction House Notification options
settingsTitle:SetPoint("TOPLEFT", 15, -15)                                     -- Sets the panel position
settingsTitle:SetText(titles[locale])                                          -- Defines the text content of the panel

-- Subtitle
local settingsSubtitle = frame:CreateFontString(nil, nil, "GameFontHighlight")
settingsSubtitle:SetPoint("TOPLEFT", 15, -35)
settingsSubtitle:SetText("Created by Breno Ludgero\nVersion " ..GetAddOnMetadata("AuctionHouseNotifications", "Version"))
settingsSubtitle:SetJustifyH("LEFT")   -- Justify the text horizontally

-- Test Checkbutton
local enableAndDisable = CreateFrame("CheckButton", "MyAddonCheckButton", frame, "InterfaceOptionsCheckButtonTemplate")
enableAndDisable:SetPoint("TOPLEFT", 22, -95)         -- Set the position of the checkbutton
enableAndDisable.Text:SetText("Debug")                -- Defines the label of the checkbutton
enableAndDisable:SetScript("OnClick", function(self)  -- Handles instruction for when the checkbutton is checked

    local isChecked = self:GetChecked()               -- If the checkbutton is checked, returns true
        
    if isChecked then                                 -- If isChecked is true:
        preferences.chosenSounds = sounds.coins
        preferences.chosenChannel = "Master"
        preferences.enableInAH = true
        preferences.showGreeting = true
        print("Checked")

    else
        preferences.chosenSounds = sounds.female
        preferences.chosenChannel = "Master"
        preferences.enableInAH = false
        preferences.showGreeting = false
        print("Unchecked")
    end

end)

-- Subtitle
local settingsSubtitle = frame:CreateFontString(nil, nil, "GameFontHighlight")
settingsSubtitle:SetPoint("LEFT", 15, 35)
settingsSubtitle:SetText("All changes require a UI Reload")
