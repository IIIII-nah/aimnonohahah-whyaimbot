local svcs = {
    Players = game:GetService("Players"), 
    UIS = game:GetService("UserInputService"), 
    RS = game:GetService("RunService")
} 

local plr, cam = svcs.Players.LocalPlayer, workspace.CurrentCamera
local scrGui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", scrGui)
frame.Size = UDim2.new(0, 120, 0, 100)
frame.Position = UDim2.new(0.5, -60, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Draggable = true
frame.Active = true

local btnAimlock = Instance.new("TextButton", frame)
btnAimlock.Size = UDim2.new(0, 100, 0, 30)
btnAimlock.Position = UDim2.new(0, 10, 0, 10)
btnAimlock.Text = "Aimlock"
btnAimlock.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
btnAimlock.TextColor3 = Color3.fromRGB(255, 255, 255)

local btnTeamCheck = Instance.new("TextButton", frame)
btnTeamCheck.Size = UDim2.new(0, 100, 0, 30)
btnTeamCheck.Position = UDim2.new(0, 10, 0, 45)
btnTeamCheck.Text = "Team Check: ON"
btnTeamCheck.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
btnTeamCheck.TextColor3 = Color3.fromRGB(255, 255, 255)

local locked, teamCheck = false, true
local target = nil

local function getClosest()
    local closest, dist = nil, math.huge
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local plrPos = plr.Character.HumanoidRootPart.Position
        for _, v in pairs(svcs.Players:GetPlayers()) do
            if v ~= plr and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
                if teamCheck and v.Team == plr.Team then continue end
                local hrp = v.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local mag = (plrPos - hrp.Position).Magnitude
                    if mag < dist then
                        closest = v
                        dist = mag
                    end
                end
            end
        end
    end
    return closest
end

local function lockAim()
    svcs.RS:BindToRenderStep("Aimlock", Enum.RenderPriority.Camera.Value, function()
        if not locked then return end
        target = getClosest()
        if target and target.Character and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 0 then
            local hrp = target.Character:FindFirstChild("HumanoidRootPart")
            local plrHRP = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp and plrHRP then
                local direction = (hrp.Position - plrHRP.Position).unit
                local newCFrame = CFrame.new(cam.CFrame.Position, hrp.Position)
                cam.CFrame = newCFrame:Lerp(CFrame.new(plrHRP.Position + Vector3.new(0, 2, -5), hrp.Position), 0.15)
            end
        end
    end)
end

local function toggleLock()
    locked = not locked
    btnAimlock.BackgroundColor3 = locked and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    if locked then lockAim() else svcs.RS:UnbindFromRenderStep("Aimlock") end
end

local function toggleTeamCheck()
    teamCheck = not teamCheck
    btnTeamCheck.Text = "Team Check: " .. (teamCheck and "ON" or "OFF")
    btnTeamCheck.BackgroundColor3 = teamCheck and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end

btnAimlock.MouseButton1Click:Connect(toggleLock)
btnTeamCheck.MouseButton1Click:Connect(toggleTeamCheck)

svcs.UIS.InputBegan:Connect(function(input, gpe) 
    if not gpe and input.KeyCode == Enum.KeyCode.E then toggleLock() end 
end)

