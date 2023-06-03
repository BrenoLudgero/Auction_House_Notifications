local localizedTitle = titles[locale]  -- Attributes the localized addon title (Localization.lua) to a variable

frame.name = localizedTitle            -- Defines what name for the addon will be displayed
InterfaceOptions_AddCategory(frame)    -- Displays the addon in Interface Options -> Addon

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
local settingsSubitle = frame:CreateFontString(nil, nil, "GameFontHighlight")
settingsSubitle:SetPoint("TOPLEFT", 15, -35)
settingsSubitle:SetText("Created by Breno Ludgero\nVersion " ..GetAddOnMetadata("AuctionHouseNotifications", "Version"))
settingsSubitle:SetJustifyH("LEFT")   -- Justify the text horizontally
