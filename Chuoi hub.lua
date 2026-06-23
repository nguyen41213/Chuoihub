local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui=Instance.new("ScreenGui")
gui.Name="BananaHub"
gui.Parent=Player:WaitForChild("PlayerGui")
gui.ResetOnSpawn=false

--------------------------------------------------
-- COLOR
--------------------------------------------------

local MENU=Color3.fromRGB(255,255,255)
local BORDER=Color3.fromRGB(255,236,150)

--------------------------------------------------
-- DRAG
--------------------------------------------------

local function drag(obj)

	local hold=false
	local start
	local pos

	obj.InputBegan:Connect(function(i)

		if i.UserInputType==Enum.UserInputType.MouseButton1
		or i.UserInputType==Enum.UserInputType.Touch then

			hold=true
			start=i.Position
			pos=obj.Position

		end

	end)

	obj.InputEnded:Connect(function()

		hold=false

	end)

	UIS.InputChanged:Connect(function(i)

		if hold and (
			i.UserInputType==Enum.UserInputType.MouseMovement
			or i.UserInputType==Enum.UserInputType.Touch
		) then

			local d=i.Position-start

			obj.Position=
			UDim2.new(
				pos.X.Scale,
				pos.X.Offset+d.X,
				pos.Y.Scale,
				pos.Y.Offset+d.Y
			)

		end

	end)

end

--------------------------------------------------
-- FRAME
--------------------------------------------------

local frame=Instance.new("Frame")

frame.Parent=gui
frame.Size=UDim2.new(0,266,0,364)
frame.Position=UDim2.new(.5,-133,.5,-182)

frame.BackgroundColor3=MENU
frame.BackgroundTransparency=.5

Instance.new("UICorner",frame).CornerRadius=
UDim.new(0,24)

local stroke=
Instance.new("UIStroke")

stroke.Parent=frame
stroke.Color=BORDER
stroke.Thickness=3

drag(frame)

--------------------------------------------------
-- TITLE
--------------------------------------------------

local title=
Instance.new("TextLabel")

title.Parent=frame
title.Size=UDim2.new(1,0,0,40)
title.Position=UDim2.new(0,0,0,5)

title.BackgroundTransparency=1
title.Text="🍌 Banana Hub"

title.TextScaled=true
title.Font=Enum.Font.GothamBold
title.TextColor3=Color3.new()

--------------------------------------------------
-- CREDIT
--------------------------------------------------

local credit=
Instance.new("TextLabel")

credit.Parent=frame

credit.Size=
UDim2.new(
1,
0,
0,
20
)

credit.Position=
UDim2.new(
0,
0,
1,
-26
)

credit.BackgroundTransparency=1

credit.Text=
"By n_g_u_y_e_n"

credit.TextColor3=
Color3.fromRGB(
150,
220,
255
)

credit.TextSize=13

credit.Font=
Enum.Font.GothamBold

credit.TextStrokeColor3=
Color3.fromRGB(
0,
0,
0
)

credit.TextStrokeTransparency=
0.65

--------------------------------------------------
-- BUTTON
--------------------------------------------------

local function make(text,y)

	local b=
	Instance.new(
	"TextButton"
	)

	b.Parent=frame

	b.Size=
	UDim2.new(
	0.8,
	0,
	0,
	35
	)

	b.Position=
	UDim2.new(
	0.1,
	0,
	0,
	y
	)

	b.Text=text

	b.BackgroundColor3=
	Color3.fromRGB(
	240,
	240,
	240
	)

	b.BackgroundTransparency=.25

	Instance.new(
	"UICorner",
	b
	).CornerRadius=
	UDim.new(
	0,
	12
	)

	return b

end

--------------------------------------------------
-- ESP
--------------------------------------------------

local ESP=false

local esp=
make(
"ESP : OFF",
75
)

local function updateESP()

	for _,p in ipairs(
	Players:GetPlayers()
	) do

		if p~=Player and p.Character then

			local old=
			p.Character:FindFirstChild(
			"BananaESP"
			)

			if old then
				old:Destroy()
			end

			if ESP then

				local h=
				Instance.new(
				"Highlight"
				)

				h.Name=
				"BananaESP"

				h.FillColor=
				Color3.fromRGB(
				0,
				255,
				120
				)

				h.FillTransparency=.7

				h.OutlineColor=
				Color3.fromRGB(
				0,
				255,
				120
				)

				h.Parent=
				p.Character

			end

		end

	end

end

esp.MouseButton1Click:Connect(function()

	ESP=not ESP

	esp.Text=
	ESP
	and "ESP : ON"
	or "ESP : OFF"

	updateESP()

end)

--------------------------------------------------
-- JUMP
--------------------------------------------------

local inf=false

local jump=
make(
"Jump : OFF",
120
)

jump.MouseButton1Click:Connect(function()

	inf=not inf

	jump.Text=
	inf
	and "Jump : ON"
	or "Jump : OFF"

end)

UIS.JumpRequest:Connect(function()

	if inf then

		local h=
		Player.Character
		and
		Player.Character:FindFirstChildOfClass(
		"Humanoid"
		)

		if h then

			h:ChangeState(
			Enum.HumanoidStateType.Jumping
			)

		end

	end

end)

--------------------------------------------------
-- SPEED
--------------------------------------------------

local speed=16
local speedOn=false

local speedBtn=
make(
"Speed : OFF",
165
)

local function applySpeed()

	local h=
	Player.Character
	and
	Player.Character:FindFirstChildOfClass(
	"Humanoid"
	)

	if h then

		h.WalkSpeed=
		speedOn
		and speed
		or 16

	end

end

speedBtn.MouseButton1Click:Connect(function()

	speedOn=
	not speedOn

	speedBtn.Text=
	speedOn
	and "Speed : ON"
	or "Speed : OFF"

	applySpeed()

end)

--------------------------------------------------
-- SPEED BOX
--------------------------------------------------

local box=
Instance.new(
"TextBox"
)

box.Parent=frame

box.Size=
UDim2.new(
.8,
0,
0,
35
)

box.Position=
UDim2.new(
.1,
0,
0,
210
)

box.Text="16"

Instance.new(
"UICorner",
box
)

box.FocusLost:Connect(function()

	local n=
	tonumber(
	box.Text
	)

	if n then

		speed=n

		applySpeed()

	end

end)

--------------------------------------------------
-- + -
--------------------------------------------------

local plus=
make("+",260)

plus.Size=
UDim2.new(.35,0,0,35)

plus.MouseButton1Click:Connect(function()

	speed+=5
	box.Text=speed
	applySpeed()

end)

local minus=
make("-",260)

minus.Size=
UDim2.new(.35,0,0,35)

minus.Position=
UDim2.new(.55,0,0,260)

minus.MouseButton1Click:Connect(function()

	speed=
	math.max(
	0,
	speed-5
	)

	box.Text=speed

	applySpeed()

end)

--------------------------------------------------
-- MENU BUTTON
--------------------------------------------------

local menu=
Instance.new(
"TextButton"
)

menu.Parent=gui

menu.Size=
UDim2.new(
0,
60,
0,
60
)

menu.Position=
UDim2.new(
0,
20,
.5,
-30
)

menu.BackgroundColor3=
Color3.fromRGB(
255,
255,
255
)

menu.BackgroundTransparency=.15

menu.Text="🍌"

menu.TextScaled=true

menu.Font=
Enum.Font.GothamBold

menu.TextColor3=
Color3.new()

Instance.new(
"UICorner",
menu
).CornerRadius=
UDim.new(
0,
16
)

local ms=
Instance.new(
"UIStroke"
)

ms.Parent=menu

ms.Color=
Color3.fromRGB(
57,
255,
20
)

ms.Thickness=4

drag(menu)

menu.MouseButton1Click:Connect(function()

	frame.Visible=
	not frame.Visible

end)

--------------------------------------------------
-- RESPAWN
--------------------------------------------------

Player.CharacterAdded:Connect(function()

	task.wait(1)

	applySpeed()

	updateESP()

end)
