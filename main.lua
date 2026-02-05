-- =========================================
-- 🔴 RED PAINEL 👺 1.0 | AIMBOT (HEAD LOCK) + ESP FIXO
-- =========================================

-- ========= CONFIG =========
local SETTINGS = {
	AimEnabled = true,
	FOV = 140,
	Smoothness = 0.6
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

-- ========= PAINEL CENTRALIZADO =========
local panel = Instance.new("Frame", gui)
panel.Size = UDim2.new(0,260,0,300)
panel.Position = UDim2.new(0.5,-130,0.5,-150)
panel.BackgroundColor3 = THEME.Black
panel.Visible = false
panel.Active = true
panel.ZIndex = 900
Instance.new("UICorner", panel).CornerRadius = UDim.new(0,12)

local panelStroke = Instance.new("UIStroke", panel)
panelStroke.Color = THEME.RedMain
panelStroke.Thickness = 2
panelStroke.Transparency = 0.15

-- ========= DRAG FUNCIONAL COM CLIQUE =========
local dragging = false
local dragStart
local startPos
local clickThreshold = 5 -- Pixels mínimos para considerar arraste

float.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = float.Position
	end
end)

float.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		if delta.Magnitude > clickThreshold then
			float.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

float.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local delta = (input.Position - dragStart).Magnitude
		if delta < clickThreshold then
			panel.Visible = not panel.Visible
		end
		dragging = false
	end
end)

-- ========= TÍTULO =========
local title = Instance.new("TextLabel", panel)
title.Size = UDim2.new(1,0,0,36)
title.BackgroundColor3 = THEME.RedDark
title.Text = "🔴 RED PAINEL 👺 1.0"
title.TextColor3 = THEME.Text
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.ZIndex = 901
Instance.new("UICorner", title).CornerRadius = UDim.new(0,12)

-- ========= BOTÕES =========
local function btn(txt,y)
	local b = Instance.new("TextLabel", panel)
	b.Size = UDim2.new(1,-30,0,32)
	b.Position = UDim2.new(0,15,0,y)
	b.BackgroundColor3 = THEME.BlackSoft
	b.TextColor3 = THEME.Text
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.ZIndex = 902
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

-- AIMBOT
local aimBtnLbl = btn("🎯 AIMBOT", 45)
local toggle = Instance.new("Frame", panel)
toggle.Size = UDim2.new(0,40,0,20)
local textCenterY = aimBtnLbl.Position.Y.Offset + (aimBtnLbl.Size.Y.Offset/2) - (toggle.Size.Y.Offset/2)
toggle.Position = UDim2.new(0,180,0,textCenterY)
toggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
toggle.ZIndex = 903
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0,10)

local circle = Instance.new("Frame", toggle)
circle.Size = UDim2.new(0,18,0,18)
circle.Position = UDim2.new(0,1,0,1)
circle.BackgroundColor3 = THEME.RedMain
circle.ZIndex = 904
Instance.new("UICorner", circle).CornerRadius = UDim.new(1,9)

local function UpdateToggle()
	if SETTINGS.AimEnabled then
		circle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		toggle.BackgroundColor3 = THEME.RedLight
	else
		circle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		toggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
	end
end

toggle.InputBegan:Connect(function()
	SETTINGS.AimEnabled = not SETTINGS.AimEnabled
	UpdateToggle()
end)

UpdateToggle()

-- TEAM CHECK
local teamBtnLbl = btn("🛡️ TEAM CHECK", 85)
local teamToggle = Instance.new("Frame", panel)
teamToggle.Size = UDim2.new(0,40,0,20)
local teamCenterY = teamBtnLbl.Position.Y.Offset + (teamBtnLbl.Size.Y.Offset/2) - (teamToggle.Size.Y.Offset/2)
teamToggle.Position = UDim2.new(0,180,0,teamCenterY)
teamToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
teamToggle.ZIndex = 903
Instance.new("UICorner", teamToggle).CornerRadius = UDim.new(0,10)

local teamCircle = Instance.new("Frame", teamToggle)
teamCircle.Size = UDim2.new(0,18,0,18)
teamCircle.Position = UDim2.new(0,1,0,1)
teamCircle.BackgroundColor3 = THEME.RedMain
teamCircle.ZIndex = 904
Instance.new("UICorner", teamCircle).CornerRadius = UDim.new(1,9)

local TeamCheckEnabled = true
local function UpdateTeamToggle()
	if TeamCheckEnabled then
		teamCircle:TweenPosition(UDim2.new(1,-19,0,1),"Out","Sine",0.2,true)
		teamToggle.BackgroundColor3 = THEME.RedLight
	else
		teamCircle:TweenPosition(UDim2.new(0,1,0,1),"Out","Sine",0.2,true)
		teamToggle.BackgroundColor3 = Color3.fromRGB(100,20,20)
	end
end

teamToggle.InputBegan:Connect(function()
	TeamCheckEnabled = not TeamCheckEnabled
	UpdateTeamToggle()
end)

UpdateTeamToggle()

-- ========= FOV =========
local fovTxt = Instance.new("TextLabel", panel)
fovTxt.Size = UDim2.new(1,-30,0,24)
fovTxt.Position = UDim2.new(0,15,0,125)
fovTxt.Text = "👁️ FOV: "..SETTINGS.FOV
fovTxt.TextColor3 = THEME.Text
fovTxt.BackgroundTransparency = 1
fovTxt.Font = Enum.Font.GothamBold
fovTxt.TextSize = 13
fovTxt.ZIndex = 902

local fovPlus = btn("➕ FOV",165)
local fovMinus = btn("➖ FOV",205)

fovPlus.InputBegan:Connect(function()
	SETTINGS.FOV = math.clamp(SETTINGS.FOV + 10, 50, 500)
	fovTxt.Text = "👁️ FOV: "..SETTINGS.FOV
end)

fovMinus.InputBegan:Connect(function()
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

-- ========= AIMBOT AUTOMÁTICO =========
local function GetTarget()
	local vp = Camera.ViewportSize
	local center = Vector2.new(vp.X/2, vp.Y/2)

	local best,dist = nil, math.huge

	for _,p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
			if TeamCheckEnabled and p.Team == LocalPlayer.Team then
				continue
			end
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
	if not SETTINGS.AimEnabled then return end
	local target = GetTarget()
	if not target then return end

	local camPos = Camera.CFrame.Position
	local dir = (target.Position - camPos).Unit
	local dot = Camera.CFrame.LookVector:Dot(dir)

	if dot > 0.3 then
		local cf = CFrame.new(camPos, target.Position)
		Camera.CFrame = Camera.CFrame:Lerp(cf, SETTINGS.Smoothness)
	end
end)

-- ========= MENSAGEM AO EXECUTAR =========
pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "🔴 RED PAINEL 👺 1.0",
		Text = "RED PAINEL ATIVADO 🔥",
		Duration = 5
	})
end)

warn("🔴👺 RED PAINEL 1.0 CARREGADO 👺🔴")
