-- Script de débogage pour identifier le problème
local StarterGui = game:GetService("StarterGui")

local function Notify(text)
    StarterGui:SetCore("SendNotification", {
        Title = "Debug",
        Text = text,
        Duration = 10
    })
end

Notify("Downloading script...")

local success, content = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua")
end)

if not success then
    Notify("Download failed: " .. tostring(content))
    warn("Download error:", content)
    return
end

if not content or content == "" then
    Notify("Script is empty")
    warn("Empty content")
    return
end

Notify("Script downloaded. Length: " .. #content)
warn("First 500 chars:", content:sub(1, 500))

-- Vérifier si c'est du Lua valide
local loadSuccess, loadResult = pcall(loadstring, content)

if not loadSuccess then
    Notify("Invalid Lua: " .. tostring(loadResult))
    warn("Loadstring error:", loadResult)
    warn("Full content:", content)
    return
end

Notify("Script is valid Lua. Executing...")

-- Essayer d'exécuter
local execSuccess, execError = pcall(loadResult)

if execSuccess then
    Notify("Script executed successfully!")
else
    Notify("Execution failed: " .. tostring(execError))
    warn("Execution error:", execError)
end
