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
	["3808223175"] = { id = "4fe2dfc202115670b1813277df916ab2", keyless = true }, -- Jujutsu Infinite
	["994732206"]  = { id = "e2718ddebf562c5c4080dfce26b09398", keyless = true }, -- Blox Fruits
	["1650291138"] = { id = "9b64d07193c7c2aef970d57aeb286e70", keyless = true }, -- Demon Fall
	["5750914919"] = { id = "8bbc8a7c4e023bc0c80799fec3233162", keyless = true }, -- Fisch
	["3317771874"] = { id = "e95ef6f27596e636a7d706375c040de4", keyless = true }, -- Pet Simulator 99
	["1511883870"] = { id = "fefdf5088c44beb34ef52ed6b520507c", keyless = true }, -- Shindo Life
	["6035872082"] = { id = "3bb7969a9ecb9e317b0a24681327c2e2", keyless = true }, -- Rivals
	["245662005"]  = { id = "21ad7f491e4658e9dc9529a60c887c6e", keyless = true }, -- Jailbreak
	["7018190066"] = { id = "98f5c64a0a9ecca29517078597bbcbdb", keyless = true }, -- Dead Rails
	["7074860883"] = { id = "0c8fdf9bb25a6a7071731b72a90e3c69", keyless = true }, -- Arise Crossover
	["7436755782"] = { id = "e4ea33e9eaf0ae943d59ea98f2444ebe", keyless = true }, -- Grow a Garden
	["7326934954"] = { id = "00e140acb477c5ecde501c1d448df6f9", keyless = true }, -- 99 Nights in the Forest
	["8316902627"] = { id = "641e8d02ffba666d731614a32c08eacf", keyless = true }, -- Plants vs Brainrot
	["8321616508"] = { id = "2cd0668c5caf66913e7314cdb6d1eb9b", keyless = true }, -- Rogue Piece
	["3457700596"] = { id = "639c0b275001182cca67ac85f5bd529f", keyless = true }, -- Fruit Battlegrounds
	["7671049560"] = { id = "c0b41e859f576fb70183206224d4a75f", keyless = true }, -- The Forge
	["6760085372"] = { id = "e380382a05647eabda3a9892f95952c6", keyless = true }, -- Jujutsu: Zero
	["9266873836"] = { id = "3f9d315017ec895ded5c3350fd6e45a0", keyless = true }, -- Anime Fighting Simulator
	["9363735110"] = { id = "4948419832e0bd4aa588e628c45b6f8d", keyless = true }, -- Escape Tsunami For Brainrots!
}

-- ===================== GAME RESOLUTION =====================
local executor_name = getexecutorname():match("^%s*(.-)%s*$") or "unknown"
local game_id = tostring(game.GameId)
local game_cfg = ListGame[game_id]

if not game_cfg then
	Players.LocalPlayer:Kick("This game is not supported.")
end

local script_id = game_cfg.id

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

function Task()
	local status, res1, res2 = pcall(function()
		local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()

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
			color = color or Color3.fromRGB(255, 188, 254)

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

		-- Keyless mode - Load script directly
		api.script_id = script_id
		
		NotifyCustom("SolixHub", "Loading script (Keyless Mode)...", 3)
		
		pcall(function()
			api.load_script()
		end)
		
		NotifyCustom("Success", "Script loaded successfully!", 5)
	end)
	
	if not status then
		warn("Script loading error: " .. tostring(res1))
		StarterGui:SetCore("SendNotification", {
			Title = "SolixHub",
			Text = "Failed to load script",
			Duration = 5
		})
	end
	
	return res1, res2
end

-- Execute main task
Task()

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

-- Load loading screen
loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/Solixreworkkeysystem/refs/heads/main/Loading%20Screen"))()
