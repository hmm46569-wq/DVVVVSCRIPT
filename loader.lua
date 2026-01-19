repeat task.wait() until game:IsLoaded()

-- ================== SERVICES ==================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local Player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- ================== CONFIG ==================

-- 🔑 CLÉS DÉJÀ INTÉGRÉES
local VALID_KEYS = {
    "SOLIX-DEV-ACCESS",
    "SOLIX-OWNER-2026",
    "SOLIX-PREMIUM-LIFETIME",
    "SOLIX-ADMIN-ROOT",

    "SOLIX-USER-A1F9",
    "SOLIX-USER-B7K2",
    "SOLIX-USER-ZX93",
    "SOLIX-USER-MN44",
    "SOLIX-USER-QP88",

    "SOLIX-TEST-001",
    "SOLIX-TEST-002",
    "SOLIX-DEBUG-KEY"
}

-- 🎮 SCRIPTS PAR JEU
local GAME_SCRIPTS = {
    ["3808223175"] = "https://tonscript.com/jujutsu.lua",
    ["994732206"]  = "https://tonscript.com/bloxfruits.lua",
    ["1511883870"] = "https://tonscript.com/shindo.lua",
}

local SAVE_FILE = "solixhub_key.txt"

-- ================== FUNCTIONS ==================
local function isValidKey(key)
    for _, v in ipairs(VALID_KEYS) do
        if v == key then
            return true
        end
    end
    return false
end

local function loadGameScript()
    local gameId = tostring(game.GameId)
    local url = GAME_SCRIPTS[gameId]

    if not url then
        Player:Kick("❌ Jeu non supporté par SolixHub.")
        return
    end

    loadstring(game:HttpGet(url))()
end

-- ================== UI ==================
pcall(function()
    if CoreGui:FindFirstChild("SolixHub") then
        CoreGui.SolixHub:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SolixHub"
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.fromOffset(340, 180)
Frame.Position = UDim2.fromScale(0.5, 0.5)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Frame.BorderSizePixel = 0

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "SolixHub – Key System"
Title.TextColor3 = Color3.fromRGB(200, 160, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.fromOffset(300, 40)
Box.Position = UDim2.fromOffset(20, 60)
Box.PlaceholderText = "Enter your key"
Box.Text = ""
Box.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
Box.TextColor3 = Color3.fromRGB(255, 255, 255)
Box.Font = Enum.Font.Gotham
Box.TextSize = 14
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.fromOffset(300, 40)
Button.Position = UDim2.fromOffset(20, 115)
Button.Text = "VALIDATE"
Button.BackgroundColor3 = Color3.fromRGB(120, 60, 200)
Button.TextColor3 = Color3.fromRGB(255,255,255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 14
Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

-- ================== LOGIC ==================
Button.MouseButton1Click:Connect(function()
    local key = Box.Text:gsub("%s+", "")

    if not isValidKey(key) then
        Box.Text = "❌ INVALID KEY"
        Box.TextColor3 = Color3.fromRGB(255, 80, 80)
        return
    end

    -- Save key
    pcall(function()
        writefile(SAVE_FILE, key)
    end)

    ScreenGui:Destroy()
    loadGameScript()
end)

-- ================== AUTO LOGIN ==================
task.spawn(function()
    if isfile(SAVE_FILE) then
        local savedKey = readfile(SAVE_FILE)
        if isValidKey(savedKey) then
            ScreenGui:Destroy()
            loadGameScript()
        end
    end
end)
