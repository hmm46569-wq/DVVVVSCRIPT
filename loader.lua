repeat wait() until game:IsLoaded()

local cloneref = cloneref or function(o) return o end
local wait = task.wait
local spawn = task.spawn

local CoreGui = cloneref(game:GetService("CoreGui"))
local HttpService = cloneref(game:GetService("HttpService"))
local Players = cloneref(game:GetService("Players"))
local PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
local RunService = cloneref(game:GetService("RunService"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local TweenService = cloneref(game:GetService("TweenService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Workspace = cloneref(game:GetService("Workspace"))

local BindableFunction = Instance.new("BindableFunction")

-- ===================== GAME LIST =====================
local ListGame = {
	["3808223175"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Jujutsu Infinite
	["994732206"]  = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Blox Fruits
	["1650291138"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Demon Fall
	["5750914919"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Fisch
	["3317771874"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Pet Simulator 99
	["1511883870"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Shindo Life
	["6035872082"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Rivals
	["245662005"]  = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Jailbreak
	["7018190066"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Dead Rails
	["7074860883"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Arise Crossover
	["7436755782"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Grow a Garden
	["7326934954"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- 99 Nights in the Forest
	["8316902627"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Plants vs Brainrot
	["8321616508"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Rogue Piece
	["3457700596"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Fruit Battlegrounds
	["7671049560"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- The Forge
	["6760085372"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Jujutsu: Zero
	["9266873836"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Anime Fighting Simulator
	["9363735110"] = { url = "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua" }, -- Escape Tsunami For Brainrots!
}

-- ===================== GAME RESOLUTION =====================
local executor_name = getexecutorname():match("^%s*(.-)%s*$") or "unknown"
local game_id = tostring(game.GameId)
local game_cfg = ListGame[game_id]

if not game_cfg then
	Players.LocalPlayer:Kick("This game is not supported.")
	return
end

if CoreGui:FindFirstChild("System") then
	CoreGui.System:Destroy()
end

for _, exec in ipairs({"Xeno", "Solara"}) do
	if string.find(executor_name, exec) then
		workspace:SetAttribute("low", true)
		break
	end
end

function DeleteAll(path)
	for _, v in ipairs(listfiles(path)) do
		if isfile(v) then
			delfile(v)
		elseif isfolder(v) then
			DeleteAll(v)
			delfolder(v)
		end
	end
end

-- Notification System
local NotificationGUI = PlayerGui:FindFirstChild("Notifications") or Instance.new("ScreenGui")
NotificationGUI.Name = "Notifications"
NotificationGUI.Parent = PlayerGui

local Container = NotificationGUI:FindFirstChild("Container") or Instance.new("Frame")
Container.Name = "Container"
Container.AnchorPoint = Vector2.new(1, 0)
Container.Position = UDim2.new(1, -25, 0, 25)
Container.BackgroundTransparency = 1
Container.Size = UDim2.fromOffset(350, 600)
Container.Parent = NotificationGUI

if not Container:FindFirstChild("UIListLayout") then
	local Layout = Instance.new("UIListLayout")
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.Padding = UDim.new(0, 8)
	Layout.VerticalAlignment = Enum.VerticalAlignment.Top
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Layout.Parent = Container
end

local function NotifyCustom(title, content, duration)
	duration = duration or 5
	local color = Color3.fromRGB(255, 188, 254)

	local Notification = Instance.new("Frame")
	Notification.Name = "Notification"
	Notification.BackgroundTransparency = 0.06
	Notification.AutomaticSize = Enum.AutomaticSize.Y
	Notification.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
	Notification.BorderSizePixel = 0
	Notification.Size = UDim2.fromOffset(320, 70)
	Notification.Parent = Container

	local NotifCorner = Instance.new("UICorner")
	NotifCorner.CornerRadius = UDim.new(0, 8)
	NotifCorner.Parent = Notification

	local NotifStroke = Instance.new("UIStroke")
	NotifStroke.Color = Color3.fromRGB(158, 114, 158)
	NotifStroke.Transparency = 0.8
	NotifStroke.Parent = Notification

	local TitleText = Instance.new("TextLabel")
	TitleText.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
	TitleText.Text = title
	TitleText.TextColor3 = Color3.fromRGB(199, 199, 203)
	TitleText.TextSize = 16
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.BackgroundTransparency = 1
	TitleText.Size = UDim2.new(1, -20, 0, 20)
	TitleText.Position = UDim2.fromOffset(10, 6)
	TitleText.Parent = Notification

	local ContentText = Instance.new("TextLabel")
	ContentText.FontFace = Font.new("rbxassetid://12187365364")
	ContentText.Text = content
	ContentText.TextColor3 = Color3.fromRGB(180, 180, 185)
	ContentText.TextSize = 14
	ContentText.TextXAlignment = Enum.TextXAlignment.Left
	ContentText.TextYAlignment = Enum.TextYAlignment.Top
	ContentText.BackgroundTransparency = 1
	ContentText.AutomaticSize = Enum.AutomaticSize.Y
	ContentText.TextWrapped = true
	ContentText.Size = UDim2.new(1, -20, 0, 0)
	ContentText.Position = UDim2.fromOffset(10, 28)
	ContentText.Parent = Notification

	local ProgressBar = Instance.new("Frame")
	ProgressBar.BackgroundColor3 = Color3.fromRGB(44, 38, 44)
	ProgressBar.BorderSizePixel = 0
	ProgressBar.Size = UDim2.new(1, -20, 0, 6)
	ProgressBar.Position = UDim2.new(0, 10, 1, -12)
	ProgressBar.Parent = Notification

	local ProgressFill = Instance.new("Frame")
	ProgressFill.BackgroundColor3 = color
	ProgressFill.BorderSizePixel = 0
	ProgressFill.Size = UDim2.fromScale(1, 1)
	ProgressFill.Parent = ProgressBar

	local ProgressFillCorner = Instance.new("UICorner")
	ProgressFillCorner.Parent = ProgressFill

	TweenService:Create(ProgressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()

	task.delay(duration, function()
		TweenService:Create(Notification, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
		wait(0.3)
		Notification:Destroy()
	end)

	return Notification
end

-- Load script directly without any authentication
NotifyCustom("SolixHub", "Loading script (Keyless Mode)...", 3)

local success, err = pcall(function()
	loadstring(game:HttpGet(game_cfg.url))()
end)

if success then
	NotifyCustom("Success", "Script loaded successfully!", 5)
else
	NotifyCustom("Error", "Failed to load script: " .. tostring(err), 7)
	warn("Script loading error:", err)
end

-- File cleanup prompt
BindableFunction.OnInvoke = function(v)
	if v == "Yes" then
		DeleteAll("")
		wait(0.3)
		Players.LocalPlayer:Kick("Files deleted successfully, please rejoin.")
	end
end

StarterGui:SetCore("SendNotification", {
	Title = "Solix Hub",
	Text = "Delete workspace files?",
	Icon = "rbxassetid://102391696721436",
	Duration = 13,
	Button1 = "Yes",
	Button2 = "No",
	Callback = BindableFunction
})

-- Load loading screen (optional)
pcall(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/Loading%20Screen"))()
end)
