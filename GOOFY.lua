-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- Create the button
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local AimlockButton = Instance.new("TextButton")

AimlockButton.Parent = ScreenGui
AimlockButton.Size = UDim2.new(0, 100, 0, 50)
AimlockButton.Position = UDim2.new(0.5, -50, 0.5, -25)
AimlockButton.Text = "Aimlock"
AimlockButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
AimlockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimlockButton.Draggable = true
AimlockButton.Active = true
AimlockButton.Selectable = true

local aimlocking = false
local currentTarget = nil

-- Function to find nearest player
local function getNearestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local targetPos = player.Character.HumanoidRootPart.Position
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - targetPos).Magnitude
            
            if distance < shortestDistance then
                shortestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

-- Aimlock function
local function aimlock()
    RunService:BindToRenderStep("Aimlock", Enum.RenderPriority.Camera.Value, function()
        local target = getNearestPlayer()
        if target and target.Character then
            local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetHRP.Position)
                currentTarget = target
            end
        end
    end)
end

-- Button click function
AimlockButton.MouseButton1Click:Connect(function()
    aimlocking = not aimlocking
    AimlockButton.BackgroundColor3 = aimlocking and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    
    if aimlocking then
        aimlock()
    else
        RunService:UnbindFromRenderStep("Aimlock")
    end
end)
