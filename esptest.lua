local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Box Settings
local BoxSettings = {
    BoxEnabled = true,
    BoxColor = Color3.fromRGB(0, 255, 0),
    BoxTransparency = 0.5,
    BoxThickness = 0.05, -- Adjust this value to control the thickness of the box
    Margin = 2, -- Margin percentage to add around the player
}

-- Function to create or update box for a player
local function createOrUpdateBox(player)
    pcall(function()
        if player.Character and player.Character:IsDescendantOf(game.Workspace) then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local head = player.Character:FindFirstChild("Head")
                local torso = player.Character:FindFirstChild("UpperTorso") or player.Character:FindFirstChild("Torso")
                if head and torso then
                    local torsoPos = torso.Position
                    local headPos = head.Position
                    local direction = (headPos - torsoPos).unit
                    local distance = (headPos - torsoPos).magnitude
                    local margin = distance * BoxSettings.Margin
                    local boxSize = Vector3.new(distance + margin, distance * 2 + margin, BoxSettings.BoxThickness)
                    
                    local box = player.Character:FindFirstChild("Box")
                    if not box then
                        box = Instance.new("BoxHandleAdornment")
                        box.Name = "Box"
                        box.Adornee = player.Character
                        box.Size = boxSize
                        box.AlwaysOnTop = true
                        box.ZIndex = 5
                        box.Color3 = BoxSettings.BoxColor
                        box.Transparency = BoxSettings.BoxTransparency
                        box.Visible = true
                        box.Parent = player.Character
                    else
                        box.Size = boxSize
                    end
                end
            else
                removeBox(player)
            end
        else
            removeBox(player)
        end
    end)
end

-- Function to remove box for a player
local function removeBox(player)
    pcall(function()
        local box = player.Character and player.Character:FindFirstChild("Box")
        if box then
            box:Destroy()
        end
    end)
end

-- Toggle Box functionality
local function toggleBox()
    BoxSettings.BoxEnabled = not BoxSettings.BoxEnabled
    if not BoxSettings.BoxEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                removeBox(player)
            end
        end
    end
end

-- Connect input to toggle Box
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.E then
        toggleBox()
    end
end)

-- Main loop to update Box
RunService.Heartbeat:Connect(function()
    if BoxSettings.BoxEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                createOrUpdateBox(player)
            end
        end
    end
end)
