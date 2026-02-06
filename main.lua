-- =====================================
-- SCRIPT DESATIVADO / AVISO OFICIAL
-- =====================================

-- Serviços
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AvisoScriptGui"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Frame principal
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 360, 0, 180)
frame.Position = UDim2.new(0.5, -180, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Bordas arredondadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Botão fechar (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = frame
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -38, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Título
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, -20, 0, 32)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Text = "⚠️ AVISO IMPORTANTE"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

-- Texto do aviso
local text = Instance.new("TextLabel")
text.Parent = frame
text.Size = UDim2.new(1, -20, 1, -60)
text.Position = UDim2.new(0, 10, 0, 50)
text.BackgroundTransparency = 1
text.TextWrapped = true
text.TextYAlignment = Enum.TextYAlignment.Top
text.TextXAlignment = Enum.TextXAlignment.Left
text.Font = Enum.Font.Gotham
text.TextSize = 13
text.TextColor3 = Color3.fromRGB(220, 220, 220)

text.Text = [[
Este script foi DESATIVADO.

Algumas funções foram removidas ou atualizadas
e esta versão não é mais suportada.

Para obter a NOVA VERSÃO,
entre em contato com o criador do script.

Obrigado pela compreensão.
]]
