repeat wait() until game:IsLoaded()

-- ===================== CONFIGURATION =====================
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- ===================== SUPPRESSION DES PROTECTIONS =====================
-- Supprimer toutes les interfaces de vérification existantes
for _, gui in pairs(CoreGui:GetChildren()) do
	if gui.Name == "System" or gui.Name:match("Luarmor") or gui.Name:match("Auth") then
		gui:Destroy()
	end
end

for _, gui in pairs(Players.LocalPlayer.PlayerGui:GetChildren()) do
	if gui.Name == "System" or gui.Name:match("Luarmor") or gui.Name:match("Auth") then
		gui:Destroy()
	end
end

-- ===================== NOTIFICATION =====================
StarterGui:SetCore("SendNotification", {
	Title = "Solix Hub",
	Text = "Loading script (No Auth)...",
	Icon = "rbxassetid://102391696721436",
	Duration = 5
})

-- ===================== BYPASS HOOKS =====================
-- Hook les fonctions de vérification communes
local old_require = require
local old_loadstring = loadstring

-- Override require pour bypasser les modules de vérification
getgenv().require = function(module)
	local success, result = pcall(old_require, module)
	if not success then
		return function() end -- Retourne une fonction vide si le module échoue
	end
	return result
end

-- Override loadstring pour bypasser les vérifications
getgenv().loadstring = function(source)
	-- Supprimer les vérifications communes dans le code source
	if type(source) == "string" then
		source = source:gsub("script_key", "")
		source = source:gsub("auth_key", "")
		source = source:gsub("check_key", "")
		source = source:gsub("verify_key", "")
		source = source:gsub("KEY_VALID", "")
		source = source:gsub("AUTH_ERROR", "")
	end
	return old_loadstring(source)
end

-- ===================== VARIABLES GLOBALES DE BYPASS =====================
getgenv().script_key = "BYPASSED"
getgenv().auth_key = "BYPASSED"
getgenv().keyless = true
getgenv().authenticated = true
getgenv().premium = true
getgenv().key_valid = true

-- Mock API pour bypasser Luarmor
getgenv().luarmor_api = {
	script_id = "bypassed",
	check_key = function() 
		return {
			code = "KEY_VALID",
			data = {
				auth_expire = os.time() + 999999999
			}
		}
	end,
	load_script = function()
		-- Charge le script réel ici
		local success, err = pcall(function()
			loadstring(game:HttpGet("https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua"))()
		end)
		
		if not success then
			warn("Error loading main script:", err)
		end
	end
}

-- ===================== CHARGEMENT =====================
wait(0.5)

-- Essayer de charger le script principal
local success, error_msg = pcall(function()
	-- Méthode 1: Chargement direct
	local script_content = game:HttpGet("https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua")
	
	-- Supprimer toutes les vérifications de clé du script
	script_content = script_content:gsub('if%s+not%s+script_key.-end', '')
	script_content = script_content:gsub('if%s+not%s+auth.-end', '')
	script_content = script_content:gsub('Players%.LocalPlayer:Kick%(.-%)','')
	script_content = script_content:gsub('return%s+nil', '')
	script_content = script_content:gsub('game_cfg%.keyless%s*=%s*false', 'game_cfg.keyless = true')
	script_content = script_content:gsub('keyless%s*=%s*false', 'keyless = true')
	
	-- Charger le script modifié
	loadstring(script_content)()
end)

if success then
	StarterGui:SetCore("SendNotification", {
		Title = "Solix Hub",
		Text = "Script loaded successfully!",
		Icon = "rbxassetid://102391696721436",
		Duration = 5
	})
else
	-- Si la première méthode échoue, essayer une approche alternative
	warn("Primary loading method failed:", error_msg)
	
	-- Méthode 2: Chargement direct sans modification
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua"))()
	end)
	
	StarterGui:SetCore("SendNotification", {
		Title = "Solix Hub",
		Text = "Attempting alternative loading...",
		Icon = "rbxassetid://102391696721436",
		Duration = 5
	})
end

-- ===================== PROTECTION CONTINUE =====================
-- Surveiller et détruire les nouveaux GUI de vérification
task.spawn(function()
	while wait(1) do
		for _, gui in pairs(CoreGui:GetChildren()) do
			if gui.Name == "System" or gui.Name:match("Luarmor") or gui.Name:match("Auth") then
				gui:Destroy()
			end
		end
		
		for _, gui in pairs(Players.LocalPlayer.PlayerGui:GetChildren()) do
			if gui.Name == "System" or gui.Name:match("Luarmor") or gui.Name:match("Auth") then
				gui:Destroy()
			end
		end
	end
end)
