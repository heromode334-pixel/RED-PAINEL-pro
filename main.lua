-- =========================================
-- 🔴 RED PAINEL 👺 | AIM HOLD (HEAD LOCK) + ESP FIXO
-- =========================================

-- ========= CONFIG =========
local SETTINGS = {
	AimEnabled = true,
	FOV = 140,
	Smoothness = 0.35
}

-- ========= THEME =========
local THEME = {
	RedMain = Color3.fromRGB(170, 30, 30),
	RedLight = Color3.fromRGB(220, 70, 70),
	RedDark = Color3.fromRGB(90, 15, 15),
	Black = Color3.fromRGB(12, 12, 12),
	BlackSoft = Color3.fromRGB(22, 22, 22),
	Text = Color3.fromRGB(255,255,255)
}

-- ========= SERVICES =========
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ========= HOLD =========
local HoldingFire = false

UserInputService.InputBegan:Connect(function(i,gp)
	if gp then return end
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		HoldingFire = true
	end
end)

UserInputService.InputEnded:Connect(function(i,gp)
	if gp then return end
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		HoldingFire = false
	end
end)

UserInputService.TouchStarted:Connect(function()
	HoldingFire = true
end)

UserInputService.TouchEnded:Connect(function()
	HoldingFire = false
end)

-- ========= GUI =========
local gui = Instance.new("ScreenGui")
gui.Name = "RedPanel"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- ========= 🟥 QUADRADO FLUTUANTE =========
local float = Instance.new("Frame", gui)
float.Size = UDim2.new(0,55,0,55)
float.Position = UDim2.new(0.1,0,0.4,0)
float.BackgroundColor3 = THEME.RedMain
float.Active = true
float.ZIndex = 1000

Instance.new("UICorner", float).CornerRadius = UDim.new(0,10)

local floatStroke = Instance.new("UIStroke", float)
floatStroke.Color = THEME.RedLight
floatStroke.Thickness = 2
floatStroke.Transparency = 0.15

-- 👺 EMOJI NO QUADRADO
local floatIcon = Instance.new("TextLabel", float)
floatIcon.Size = UDim2.new(1,0,1,0)
floatIcon.BackgroundTransparency = 1
floatIcon.Text = "👺"
floatIcon.TextScaled = true
floatIcon.Font = Enum.Font.GothamBold
floatIcon.TextColor3 = THEME.Text
floatIcon.ZIndex = 1001

local floatBtn = Instance.new("TextButton", float)
floatBtn.Size = UDim2.new(1,0,1,0)
floatBtn.BackgroundTransparency = 1
floatBtn.Text = ""
floatBtn.ZIndex = 1002

-- ========= DRAG =========
local dragging = false
local dragStart
local startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	float.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

float.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = float.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

float.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		updateDrag(input)
	end
end)

-- ========= PAINEL =========
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0,230,0,200)
panel.Position = UDim2.new(0.25,0,0.3,0)
panel.BackgroundColor3 = THEME.Black
panel.Visible = false
panel.Active = true
panel.ZIndex = 900

Instance.new("UICorner", panel).CornerRadius = UDim.new(0,12)

local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = THEME.RedMain
panelStroke.Thickness = 2
panelStroke.Transparency = 0.15

floatBtn.MouseButton1Click:Connect(function()
	panel.Visible = not panel.Visible
end)

-- ========= TÍTULO =========
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1,0,0,32)
title.BackgroundColor3 = THEME.RedDark
title.Text = "🔴 RED PAINEL 👺"
title.TextColor3 = THEME.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.ZIndex = 901

Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

-- ========= BOTÕES =========
local function btn(txt,y)
	local b = Instance.new("TextButton", panel)
	b.Size = UDim2.new(1,-30,0,32)
	b.Position = UDim2.new(0,15,0,y)
	b.BackgroundColor3 = THEME.BlackSoft
	b.TextColor3 = THEME.Text
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.ZIndex = 902
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

	local s = Instance.new("UIStroke", b)
	s.Color = THEME.RedMain
	s.Thickness = 1
	s.Transparency = 0.2

	return b
end

local aimBtn = btn("🎯 AIM: ON",45)

local fovTxt = Instance.new("TextLabel", panel)
fovTxt.Size = UDim2.new(1,-30,0,24)
fovTxt.Position = UDim2.new(0,15,0,85)
fovTxt.Text = "👁️ FOV: "..SETTINGS.FOV
fovTxt.TextColor3 = THEME.Text
fovTxt.BackgroundTransparency = 1
fovTxt.Font = Enum.Font.GothamBold
fovTxt.TextSize = 13
fovTxt.ZIndex = 902

local fovPlus = btn("➕ FOV",115)
local fovMinus = btn("➖ FOV",155)

aimBtn.MouseButton1Click:Connect(function()
	SETTINGS.AimEnabled = not SETTINGS.AimEnabled
	aimBtn.Text = SETTINGS.AimEnabled and "🎯 AIM: ON" or "🚫 AIM: OFF"
end)

fovPlus.MouseButton1Click:Connect(function()
	SETTINGS.FOV = math.clamp(SETTINGS.FOV + 10, 50, 500)
	fovTxt.Text = "👁️ FOV: "..SETTINGS.FOV
end)

fovMinus.MouseButton1Click:Connect(function()
	SETTINGS.FOV = math.clamp(SETTINGS.FOV - 10, 50, 500)
	fovTxt.Text = "👁️ FOV: "..SETTINGS.FOV
end)

-- ========= FOV VISUAL =========
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Color = THEME.RedLight
FOVCircle.Transparency = 1
FOVCircle.Filled = false

RunService.RenderStepped:Connect(function()
	local vp = Camera.ViewportSize
	FOVCircle.Position = Vector2.new(vp.X/2, vp.Y/2)
	FOVCircle.Radius = SETTINGS.FOV
	FOVCircle.Visible = SETTINGS.AimEnabled
end)

-- ========= ESP =========
local ESP = {}

local function CreateESP(player,char)
	if player == LocalPlayer then return end
	if ESP[player] then ESP[player]:Destroy() end

	local hl = Instance.new("Highlight")
	hl.Adornee = char
	hl.FillColor = THEME.RedMain
	hl.OutlineColor = Color3.new(1,1,1)
	hl.FillTransparency = 0.5
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = char

	ESP[player] = hl
end

for _,p in ipairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		if p.Character then CreateESP(p,p.Character) end
		p.CharacterAdded:Connect(function(c)
			task.wait(0.3)
			CreateESP(p,c)
		end)
	end
end

-- ========= AIM =========
local function GetTarget()
	local vp = Camera.ViewportSize
	local center = Vector2.new(vp.X/2, vp.Y/2)

	local best,dist = nil, math.huge

	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
			local head = p.Character.Head
			local pos,on = Camera:WorldToViewportPoint(head.Position)
			if on then
				local d = (Vector2.new(pos.X,pos.Y)-center).Magnitude
				if d <= SETTINGS.FOV then
					local mag = (Camera.CFrame.Position-head.Position).Magnitude
					if mag < dist then
						dist = mag
						best = head
					end
				end
			end
		end
	end
	return best
end

RunService.RenderStepped:Connect(function()
	if not SETTINGS.AimEnabled or not HoldingFire then return end

	local target = GetTarget()
	if not target then return end

	local camPos = Camera.CFrame.Position
	local dir = (target.Position - camPos).Unit
	local dot = Camera.CFrame.LookVector:Dot(dir)

	if dot > 0.7 then
		local cf = CFrame.new(camPos, target.Position)
		Camera.CFrame = Camera.CFrame:Lerp(cf, SETTINGS.Smoothness * dot)
	end
end)

-- ========= MENSAGEM AO EXECUTAR =========
pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "🔴 RED PAINEL 👺",
		Text = "RED PAINEL ATIVADO 🔥",
		Duration = 5
	})
end)

warn("🔴👺 RED PAINEL CARREGADO 👺🔴")
