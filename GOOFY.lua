local function encode(str)
    local encoded = ""
    for i = 1, #str do
        encoded = encoded .. "\\" .. string.byte(str, i)
    end
    return encoded
end

local _Gx1 = game:GetService("Players")
local _Gx2 = game:GetService("UserInputService")
local _Gx3 = game:GetService("RunService")
local _Gx4 = _Gx1.LocalPlayer
local _Gx5 = _Gx4:GetMouse()
local _Gx6 = workspace.CurrentCamera

local _Gx7 = Instance.new("ScreenGui", game.CoreGui)
local _Gx8 = Instance.new("TextButton")

_Gx8.Parent = _Gx7
_Gx8.Size = UDim2.new(0, 100, 0, 50)
_Gx8.Position = UDim2.new(0.5, -50, 0.5, -25)
_Gx8.Text = ("A" .. "i" .. "m" .. "l" .. "o" .. "c" .. "k")
_Gx8.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
_Gx8.TextColor3 = Color3.fromRGB(255, 255, 255)
_Gx8.Draggable = true
_Gx8.Active = true
_Gx8.Selectable = true

local _Gx9 = false
local _Gx10 = nil

local function _Gx11()
    local _Gx12 = nil
    local _Gx13 = math.huge
    
    for _, _Gx14 in pairs(_Gx1:GetPlayers()) do
        if _Gx14 ~= _Gx4 and _Gx14.Character and _Gx14.Character:FindFirstChild(encode("HumanoidRootPart")) then
            local _Gx15 = _Gx14.Character.HumanoidRootPart.Position
            local _Gx16 = (_Gx4.Character.HumanoidRootPart.Position - _Gx15).Magnitude
            
            if _Gx16 < _Gx13 then
                _Gx13 = _Gx16
                _Gx12 = _Gx14
            end
        end
    end
    return _Gx12
end

local function _Gx17()
    _Gx3:BindToRenderStep(encode("Aimlock"), Enum.RenderPriority.Camera.Value, function()
        local _Gx18 = _Gx11()
        if _Gx18 and _Gx18.Character then
            local _Gx19 = _Gx18.Character:FindFirstChild(encode("HumanoidRootPart"))
            if _Gx19 then
                _Gx6.CFrame = CFrame.new(_Gx6.CFrame.Position, _Gx19.Position)
                _Gx10 = _Gx18
            end
        end
    end)
end

_Gx8.MouseButton1Click:Connect(function()
    _Gx9 = not _Gx9
    _Gx8.BackgroundColor3 = _Gx9 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    
    if _Gx9 then
        _Gx17()
    else
        _Gx3:UnbindFromRenderStep(encode("Aimlock"))
    end
end)
