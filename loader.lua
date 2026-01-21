-- Wrapper pour corriger et exécuter le loader
local success, scriptContent = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/hmm46569-wq/DVVVVSCRIPT/refs/heads/main/loader.lua")
end)

if not success then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Solix Hub",
        Text = "Failed to download script",
        Duration = 5
    })
    return
end

-- Corrections possibles
if scriptContent then
    -- Remplacer les appels problématiques
    scriptContent = scriptContent:gsub('loadstring%(', 'loadstring(')
    scriptContent = scriptContent:gsub('game:HttpGet%(', 'game:HttpGet(')
    
    -- Essayer d'exécuter
    local loadSuccess, loadFunc = pcall(loadstring, scriptContent)
    
    if loadSuccess and loadFunc then
        local execSuccess, execError = pcall(loadFunc)
        if not execSuccess then
            warn("Execution error:", execError)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Solix Hub",
                Text = "Script error: " .. tostring(execError),
                Duration = 7
            })
        end
    else
        warn("Load error:", loadFunc)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Solix Hub",
            Text = "Failed to load script",
            Duration = 5
        })
    end
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Solix Hub",
        Text = "Empty script content",
        Duration = 5
    })
end
