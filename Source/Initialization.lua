-- Creates the chat command /ahn that opens the AHN options interface
SLASH_AHN1 = "/ahn"
SlashCmdList["AHN"] = function()
    Settings.OpenToCategory(addonTitle)
end

local defaultPreferences = {
    chosenSounds = {
        successful = successfulSounds.coins,
        failed = failedSounds.coins,
        expired = expiredSounds.chicken
    },
    chosenChannel = "Master",
    enableInAH = false,
    showGreeting = true,
    enableExpired = true
}

-- Creates the user's preferences table to be stored in SavedVariables
function createSavedVariables()
    if not preferences then
        preferences = {}
        for key, value in pairs(defaultPreferences) do
            preferences[key] = value
        end
    end
end

local function removeOldOptions()
    local chosenSounds = preferences["chosenSounds"]
    if type(chosenSounds[1]) == "number" and type(chosenSounds[2]) == "number" then
        table.remove(chosenSounds, 1)
        table.remove(chosenSounds, 1)
        print("|cFFFFFF00Auction House Notifications|r: Your preferences may have been reset. Please, /ahn")
    end
end

-- Updates chosenSounds to use the new method (1.3.0 -> 2.0.0)
local function updateChosenSounds(chosenSounds)
    removeOldOptions()
    for soundType, sound in pairs(chosenSounds) do
        if preferences["chosenSounds"][soundType] == nil then
            preferences["chosenSounds"][soundType] = sound
        end
    end
end

-- Creates preferences not found in SavedVariables (new option after update)
function createNewOptions()
    for preference, value in pairs(defaultPreferences) do
        if preferences[preference] == nil then
            preferences[preference] = value
        end
        if type(value) == "table" then
            updateChosenSounds(value)
        end
    end
end

function showGreetingMessage()
    if preferences.showGreeting then
        print(greetingMessage)
    end
end
