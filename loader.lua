repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- Nettoyer les GUI existants
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name:match("System") or gui.Name:match("Auth") then
        pcall(function() gui:Destroy() end)
    end
end

-- Définir des variables globales pour bypasser les vérifications
getgenv().keyless = true
getgenv().authenticated = true
getgenv().key_valid = true

-- URLs à essayer dans l'ordre
local LoaderURLs = {
    "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua",
    "https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/main/loader.lua",
}

local function Notify(text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = "Solix Hub",
        Text = text,
        Icon = "rbxassetid://102391696721436",
        Duration = duration or 5
    })
end

Notify("Initializing...", 2)

-- Fonction pour nettoyer le code source des vérifications
local function CleanScript(source)
    if not source or type(source) ~= "string" then
        return source
    end
    
    -- Remplacer les vérifications communes
    source = source:gsub('keyless%s*=%s*false', 'keyless = true')
    source = source:gsub('if%s+not%s+game_cfg%.keyless.-then', 'if false then')
    source = source:gsub('Players%.LocalPlayer:Kick', '-- Players.LocalPlayer:Kick')
    
    return source
end

-- Essayer de charger depuis les différentes URLs
local loaded = false
for i, url in ipairs(LoaderURLs) do
    if loaded then break end
    
    Notify("Trying method " .. i .. "...", 2)
    
    local success, result = pcall(function()
        local source = game:HttpGet(url)
        source = CleanScript(source)
        return loadstring(source)
    end)
    
    if success and result then
        local execSuccess, execError = pcall(result)
        if execSuccess then
            loaded = true
            Notify("Script loaded successfully!", 5)
            break
        else
            warn("Execution error:", execError)
        end
    else
        warn("Loading error for URL " .. i .. ":", result)
    end
    
    wait(0.5)
end

if not loaded then
    Notify("All loading methods failed. Check console for details.", 10)
    warn("Could not load script from any source")
end

-- Protection continue contre les popups d'auth
task.spawn(function()
    while true do
        wait(0.5)
        for _, gui in pairs(CoreGui:GetChildren()) do
            if gui.Name:match("System") or gui.Name:match("Auth") or gui.Name:match("Luarmor") then
                pcall(function() gui:Destroy() end)
            end
        end
        
        for _, gui in pairs(Players.LocalPlayer.PlayerGui:GetChildren()) do
            if gui.Name:match("System") or gui.Name:match("Auth") or gui.Name:match("Luarmor") then
                pcall(function() gui:Destroy() end)
            end
        end
    end
end)
