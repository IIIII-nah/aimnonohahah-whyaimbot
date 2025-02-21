local _0x3D35 = game:GetService("Players")
local _0x5D23 = _0x3D35.LocalPlayer
local _0x10F5 = _0x5D23:GetMouse()
local _0x29A9 = workspace.CurrentCamera
local _0x5E0D = Instance.new("ScreenGui", game.CoreGui)
local _0x65F2 = Instance.new("TextButton")
_0x65F2.Parent = _0x5E0D
_0x65F2.Size = UDim2.new(0, 100, 0, 50)
_0x65F2.Position = UDim2.new(0.5, -50, 0.5, -25)
_0x65F2.Text = "Aimlock"
_0x65F2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
_0x65F2.TextColor3 = Color3.fromRGB(255, 255, 255)
_0x65F2.Draggable = true
_0x65F2.Active = true
_0x65F2.Selectable = true

local _0x47B4 = false
local _0x4136 = nil
local _0x44B6 = game:GetService("RunService")

local function _0x3F76()
    local _0x2C8F = nil
    local _0x5834 = math.huge
    for _, _0x271F in pairs(_0x3D35:GetPlayers()) do
        if _0x271F ~= _0x5D23 and _0x271F.Character and _0x271F.Character:FindFirstChild("HumanoidRootPart") then
            local _0x2D2A = _0x271F.Character.HumanoidRootPart.Position
            local _0x5D43 = (_0x5D23.Character.HumanoidRootPart.Position - _0x2D2A).Magnitude
            if _0x5D43 < _0x5834 then
                _0x5834 = _0x5D43
                _0x2C8F = _0x271F
            end
        end
    end
    return _0x2C8F
end

local function _0x46B2()
    _0x44B6:BindToRenderStep("Aimlock", Enum.RenderPriority.Camera.Value, function()
        local _0x1D8F = _0x3F76()
        if _0x1D8F and _0x1D8F.Character then
            local _0x3B8D = _0x1D8F.Character:FindFirstChild("HumanoidRootPart")
            if _0x3B8D then
                _0x29A9.CFrame = CFrame.new(_0x29A9.CFrame.Position, _0x3B8D.Position)
                _0x4136 = _0x1D8F
            end
        end
    end)
end

_0x65F2.MouseButton1Click:Connect(function()
    _0x47B4 = not _0x47B4
    _0x65F2.BackgroundColor3 = _0x47B4 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    if _0x47B4 then
        _0x46B2()
    else
        _0x44B6:UnbindFromRenderStep("Aimlock")
    end
end)
