repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")

-- Supprimer les GUI de vérification
pcall(function()
    if CoreGui:FindFirstChild("System") then
        CoreGui.System:Destroy()
    end
end)

-- Liste des scripts par jeu
local Scripts = {
    ["3808223175"] = "https://raw.githubusercontent.com/YOUR_REPO/jujutsu-infinite.lua", -- Jujutsu Infinite
    ["994732206"] = "https://raw.githubusercontent.com/YOUR_REPO/blox-fruits.lua", -- Blox Fruits
    ["1650291138"] = "https://raw.githubusercontent.com/YOUR_REPO/demon-fall.lua", -- Demon Fall
    ["5750914919"] = "https://raw.githubusercontent.com/YOUR_REPO/fisch.lua", -- Fisch
    ["3317771874"] = "https://raw.githubusercontent.com/YOUR_REPO/pet-sim-99.lua", -- Pet Simulator 99
    ["1511883870"] = "https://raw.githubusercontent.com/YOUR_REPO/shindo-life.lua", -- Shindo Life
    ["6035872082"] = "https://raw.githubusercontent.com/YOUR_REPO/rivals.lua", -- Rivals
    ["245662005"] = "https://raw.githubusercontent.com/YOUR_REPO/jailbreak.lua", -- Jailbreak
    ["7018190066"] = "https://raw.githubusercontent.com/YOUR_REPO/dead-rails.lua", -- Dead Rails
    ["7074860883"] = "https://raw.githubusercontent.com/YOUR_REPO/arise-crossover.lua", -- Arise Crossover
    ["7436755782"] = "https://raw.githubusercontent.com/YOUR_REPO/grow-garden.lua", -- Grow a Garden
    ["7326934954"] = "https://raw.githubusercontent.com/YOUR_REPO/99-nights.lua", -- 99 Nights in the Forest
    ["8316902627"] = "https://raw.githubusercontent.com/YOUR_REPO/plants-brainrot.lua", -- Plants vs Brainrot
    ["8321616508"] = "https://raw.githubusercontent.com/YOUR_REPO/rogue-piece.lua", -- Rogue Piece
    ["3457700596"] = "https://raw.githubusercontent.com/YOUR_REPO/fruit-battlegrounds.lua", -- Fruit Battlegrounds
    ["7671049560"] = "https://raw.githubusercontent.com/YOUR_REPO/the-forge.lua", -- The Forge
    ["6760085372"] = "https://raw.githubusercontent.com/YOUR_REPO/jujutsu-zero.lua", -- Jujutsu: Zero
    ["9266873836"] = "https://raw.githubusercontent.com/YOUR_REPO/anime-fighting.lua", -- Anime Fighting Simulator
    ["9363735110"] = "https://raw.githubusercontent.com/YOUR_REPO/escape-tsunami.lua", -- Escape Tsunami
}

local GameId = tostring(game.GameId)

-- Vérifier si le jeu est supporté
if not Scripts[GameId] then
    StarterGui:SetCore("SendNotification", {
        Title = "Solix Hub",
        Text = "Game not supported!",
        Duration = 5
    })
    return
end

-- Notification de chargement
StarterGui:SetCore("SendNotification", {
    Title = "Solix Hub",
    Text = "Loading script...",
    Icon = "rbxassetid://102391696721436",
    Duration = 3
})

-- Charger le script du jeu
local success, err = pcall(function()
    local scriptUrl = Scripts[GameId]
    local scriptContent = game:HttpGet(scriptUrl)
    loadstring(scriptContent)()
end)

if success then
    StarterGui:SetCore("SendNotification", {
        Title = "Solix Hub",
        Text = "Script loaded successfully!",
        Icon = "rbxassetid://102391696721436",
        Duration = 5
    })
else
    StarterGui:SetCore("SendNotification", {
        Title = "Solix Hub",
        Text = "Failed to load: " .. tostring(err),
        Duration = 7
    })
    warn("Error:", err)
end
