local svcs = {Players = game:GetService("Players"), UIS = game:GetService("UserInputService"), RS = game:GetService("RunService")} 
local plr, cam = svcs.Players.LocalPlayer, workspace.CurrentCamera
local scrGui, btn = Instance.new("ScreenGui", game.CoreGui), Instance.new("TextButton")
btn.Parent, btn.Size, btn.Position, btn.Text = scrGui, UDim2.new(0, 100, 0, 50), UDim2.new(0.5, -50, 0.5, -25), "Aimlock"
btn.BackgroundColor3, btn.TextColor3, btn.Draggable, btn.Active, btn.Selectable = Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 255), true, true, true
local locked, target = false, nil

local function getClosest()
    local closest, dist = nil, math.huge
    for _, v in pairs(svcs.Players:GetPlayers()) do
        if v ~= plr and v.Team ~= plr.Team and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local mag = (plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if mag < dist then closest, dist = v, mag end
        end
    end
    return closest
end

local function lockAim()
    svcs.RS:BindToRenderStep("Aimlock", Enum.RenderPriority.Camera.Value, function()
        local newTarget = getClosest()
        if newTarget and newTarget.Character then
            local hrp = newTarget.Character:FindFirstChild("HumanoidRootPart")
            if hrp then cam.CFrame = CFrame.new(cam.CFrame.Position, hrp.Position) target = newTarget end
        end
    end)
end

local function toggleLock()
    locked = not locked
    btn.BackgroundColor3 = locked and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    if locked then lockAim() else svcs.RS:UnbindFromRenderStep("Aimlock") end
end

btn.MouseButton1Click:Connect(toggleLock)
svcs.UIS.InputBegan:Connect(function(input, gpe) if not gpe and input.KeyCode == Enum.KeyCode.E then toggleLock() end end)
