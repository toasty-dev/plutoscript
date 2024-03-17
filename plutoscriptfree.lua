local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Plutoscript BETA", HidePremium = false, SaveConfig = true, ConfigFolder = "plutoscriptarsenal", IntroText="Pluto Script"})

OrionLib:MakeNotification({
	Name = "PlutoScript BETA",
	Content = "Thank you for testing the beta version of plutoscript <3",
	Image = "rbxassetid://4483345998",
	Time = 5
})

--Aimbot

local AimbotTab = Window:MakeTab({
	Name = "Aimbot",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = AimbotTab:AddSection({
	Name = "Aimbot"
})

AimbotTab:AddToggle({
	Name = "Aimbot",
	Default = false,
	Callback = function(Value)
		local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Holding = false


--AIMBOT SETTINGS

_G.TeamCheck = teamcheck
_G.AimbotEnabled = Value
_G.AimPart = "Head"
_G.Sensitivity = 0.05

--FCIRCLE SETTINGS

_G.CircleSides = 24
_G.CircleColor = Color3.fromRGB(255,255,255)
_G.CircleTransparency = 0.7
_G.CircleRadius = 80
_G.CircleFilled = true
_G.CircleVisible = Value
_G.CircleThickness = 0

local FCircle = Drawing.new("Circle")
FCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FCircle.Radius = _G.CircleRadius
FCircle.Filled = _G.CircleFilled
FCircle.Color = _G.CircleColor
FCircle.Visible = _G.CircleVisible
FCircle.Transparency = _G.CircleTransparency
FCircle.NumSides = _G.CircleSides
FCircle.Thickness = _G.CircleThickness

local function GetClosestPlayer()
    local MaximumDistance = _G.CircleRadius
    local Target = nil

    for _, v in next, Players:GetPlayers() do
        if v.Name ~= LocalPlayer.Name then
            if _G.TeamCheck == true then
                if v.Team ~= LocalPlayer.Team then
                    if v.Character ~= nil then
                        if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                            if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                                local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                                local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude

                                if VectorDistance < MaximumDistance then
                                    Target = v
                                end
                            end
                        end
                    end
                end
            else
                 if v.Character ~= nil then
                    if v.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                        if v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                            local ScreenPoint = Camera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart", math.huge).Position)
                            local VectorDistance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude
            
                            if VectorDistance < MaximumDistance then
                            Target = v
                            end
                        end
                    end
                end
            end
        end
    end

    return Target
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

RunService.RenderStepped:Connect(function()
    FCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    FCircle.Radius = _G.CircleRadius
    FCircle.Filled = _G.CircleFilled
    FCircle.Color = _G.CircleColor
    FCircle.Visible = _G.CircleVisible
    FCircle.Transparency = _G.CircleTransparency
    FCircle.NumSides = _G.CircleSides
    FCircle.Thickness = _G.CircleThickness
    if Holding == true and _G.AimbotEnabled == true then
        TweenService:Create(Camera, TweenInfo.new(_G.Sensitivity, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(Camera.CFrame.Position, GetClosestPlayer().Character[_G.AimPart].Position)}):Play()
    end
end)
	end    
})

AimbotTab:AddToggle({
	Name = "TeamCheck",
	Default = false,
	Callback = function(teamcheck)
		_G.TeamCheck = teamcheck
	end    
})

AimbotTab:AddDropdown({
	Name = "HitPart",
	Default = "Head",
	Options = {"Head", "HumanoidRootPart"},
	Callback = function(hitpartdd)
		_G.AimPart = hitpartdd
	end    
})

AimbotTab:AddSlider({
	Name = "Smoothness",
	Min = 0,
	Max = 0.1,
	Default = 0.05,
	Color = Color3.fromRGB(255,255,255),
	Increment = 0.01,
	ValueName = "Sensitivity",
	Callback = function(smooth)
		_G.Smoothness = smooth
	end    
})

AimbotTab:AddSlider({
	Name = "FOVCircle Sides",
	Min = 6,
	Max = 64,
	Default = 24,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Sides",
	Callback = function(sides)
		_G.CircleSides = sides
	end    
})

AimbotTab:AddSlider({
	Name = "FOV",
	Min = 30,
	Max = 500,
	Default = 80,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Radius",
	Callback = function(radius)
		_G.CircleRadius = radius
	end    
})

--ESP
local ESP = Window:MakeTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = ESP:AddSection({
    Name = "ESP"
})

ESP:AddToggle({
    Name = "ESP Enabled",
    Default = false,
    Callback = function(enabledtggl)
			-- Roblox Services
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		
		-- Chams Settings
		local ChamsSettings = {
		    ChamsEnabled = false,
		    ChamsColor = Color3.fromRGB(0, 255, 0),
		    ChamsTransparency = 0.5,
		}
		
		-- Function to create or update chams for a player's torso
		local function createOrUpdateChams(player)
		    local character = player.Character
		    if character then
		        local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
		        if torso then
		            local chams = torso:FindFirstChild("Chams")
		            if ChamsSettings.ChamsEnabled then
		                if not chams then
		                    chams = Instance.new("BoxHandleAdornment")
		                    chams.Name = "Chams"
		                    chams.Size = torso.Size
		                    chams.Adornee = torso
		                    chams.AlwaysOnTop = true
		                    chams.ZIndex = 5
		                    chams.Color3 = ChamsSettings.ChamsColor
		                    chams.Transparency = ChamsSettings.ChamsTransparency
		                    chams.Visible = true
		                    chams.Parent = torso
		                else
		                    chams.Visible = true
		                end
		            else
		                if chams then
		                    chams.Visible = false
		                end
		            end
		        end
		    end
		end
		
		-- Toggle Chams functionality
		local function toggleChams(enabled)
		    ChamsSettings.ChamsEnabled = enabled
		    if not ChamsSettings.ChamsEnabled then
		        -- Disable chams
		        for _, player in ipairs(Players:GetPlayers()) do
		            local character = player.Character
		            if character then
		                local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
		                if torso then
		                    local chams = torso:FindFirstChild("Chams")
		                    if chams then
		                        chams.Visible = false
		                    end
		                end
		            end
		        end
		    end
		end
		
		-- Main loop to update Chams
		RunService.RenderStepped:Connect(function()
		    if ChamsSettings.ChamsEnabled then
		        for _, player in ipairs(Players:GetPlayers()) do
		            createOrUpdateChams(player)
		        end
		    end
		end)
		
		-- Example of how to toggle chams using a callback function
		toggleChams(enabledtggl) -- Initially enable chams
	end
})
--Gun Mods
local Gunmods = Window:MakeTab({
	Name = "Gun Mods",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Gunmods:AddSection({
	Name = "Gun Mods"
})

Gunmods:AddButton({
	Name = "Instant reload",
	Callback = function()
		for _,v in pairs(game.ReplicatedStorage.Weapons:GetChildren())do
                v.ReloadTime.Value=0.01
        end
    end
})

Gunmods:AddButton({
	Name = "Instant Equip",
	Callback = function()
		for _,v in pairs(game.ReplicatedStorage.Weapons:GetChildren())do
				v.EquipTime.Value=0.01
		end
  	end    
})

Gunmods:AddButton({
	Name = "No Recoil",
	Callback = function()
		getsenv(game.Players.LocalPlayer.PlayerGui.GUI.Client.Functions.Weapons).recoil = 0
  	end    
})

Gunmods:AddButton({
	Name = "Always Automatic",
	Callback = function()
		if game.Players.LocalPlayer.Character:FindFirstChild('Spawned')then
			game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
			task.wait(.001)
			game:GetService("VirtualUser"):Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
		end
  	end    
})




--INIT
OrionLib:Init()
