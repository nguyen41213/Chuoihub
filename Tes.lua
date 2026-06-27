local Players=game:GetService("Players")
local UIS=game:GetService("UserInputService")
local RunService=game:GetService("RunService")

local Player=Players.LocalPlayer
local Camera=workspace.CurrentCamera

pcall(function()
local old=
Player.PlayerGui:
FindFirstChild(
"BananaHub"
)

if old then
old:Destroy()
end

end)


---

-- GUI

local gui=Instance.new("ScreenGui")
gui.Name="BananaHub"
gui.Parent=Player.PlayerGui
gui.ResetOnSpawn=false

local MENU=Color3.fromRGB(255,255,255)
local BORDER=Color3.fromRGB(57,255,20)


---

-- FRAME

local frame=Instance.new("Frame")

frame.Parent=gui

frame.Size=
UDim2.new(
0,
186,
0,
255
)

frame.Position=
UDim2.new(
.5,
-93,
.5,
-127
)

frame.BackgroundColor3=MENU
frame.BackgroundTransparency=.5

Instance.new(
"UICorner",
frame
).CornerRadius=
UDim.new(
0,
18
)

local stroke=
Instance.new(
"UIStroke"
)

stroke.Parent=frame
stroke.Color=BORDER
stroke.Thickness=2


---

-- SCROLL

local scroll=
Instance.new(
"ScrollingFrame"
)

scroll.Parent=frame

scroll.Size=
UDim2.new(
1,
0,
1,
-25
)

scroll.Position=
UDim2.new(
0,
0,
0,
25
)

scroll.BackgroundTransparency=1
scroll.BorderSizePixel=0
scroll.ScrollBarThickness=4

scroll.CanvasSize=
UDim2.new(
0,
0,
0,
360
)


---

-- DRAG VIỀN

local drag=false
local start
local pos

frame.InputBegan:Connect(function(i)

local p=i.Position

local edge=

p.X-frame.AbsolutePosition.X<18
or

frame.AbsolutePosition.X+
frame.AbsoluteSize.X-
p.X<18

or

p.Y-frame.AbsolutePosition.Y<18
or

frame.AbsolutePosition.Y+
frame.AbsoluteSize.Y-
p.Y<18

if edge and (
i.UserInputType==
Enum.UserInputType.Touch
or
i.UserInputType==
Enum.UserInputType.MouseButton1
) then

drag=true    

start=i.Position    
pos=frame.Position

end

end)

UIS.InputChanged:Connect(function(i)

if drag and (

i.UserInputType==
Enum.UserInputType.Touch

or

i.UserInputType==
Enum.UserInputType.MouseMovement

) then

local d=    
i.Position-start    

frame.Position=    
UDim2.new(    

pos.X.Scale,    
pos.X.Offset+d.X,    

pos.Y.Scale,    
pos.Y.Offset+d.Y    

)

end

end)

UIS.InputEnded:Connect(function()
drag=false
end)


---

-- TITLE

local title=
Instance.new(
"TextLabel"
)

title.Parent=frame

title.Size=
UDim2.new(
1,
0,
0,
30
)

title.BackgroundTransparency=1

title.Text=
"🍌 Banana Hub"

title.TextSize=18

title.Font=
Enum.Font.GothamBold


---

-- BUTTON

local function make(text,y)

local b=
Instance.new(
"TextButton"
)

b.Parent=scroll

b.Size=
UDim2.new(
.8,
0,
0,
30
)

b.Position=
UDim2.new(
.1,
0,
0,
y
)

b.Text=text

b.BackgroundTransparency=.25

b.BackgroundColor3=
Color3.fromRGB(
240,
240,
240
)

Instance.new(
"UICorner",
b
)

return b

end


---

-- ESP

local ESP=false

local esp=
make(
"ESP : OFF",
15
)

local function updateESP()

for _,p in ipairs(
Players:GetPlayers()
) do

if p~=Player    
and p.Character then    

	local old=    
	p.Character:    
	FindFirstChild(    
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
		0    
		)    

		h.FillTransparency=.7    

		h.Parent=    
		p.Character    

	end    

end

end

end

esp.MouseButton1Click:Connect(function()

ESP=not ESP

esp.Text=
ESP and
"ESP : ON"
or
"ESP : OFF"

updateESP()

end)


---

-- JUMP

local inf=false

local jump=
make(
"Jump : OFF",
60
)

jump.MouseButton1Click:Connect(function()

inf=not inf

jump.Text=
inf and
"Jump : ON"
or
"Jump : OFF"

end)

UIS.JumpRequest:Connect(function()

if inf then

local h=    
Player.Character    
and    
Player.Character:    
FindFirstChildOfClass(    
"Humanoid"    
)    

if h then    

	h:ChangeState(    
	Enum.HumanoidStateType.Jumping    
	)    

end

end

end)


---

-- SPEED

local speed=16
local speedOn=false

local speedBtn=
make(
"Speed : OFF",
105
)

local function apply()

local h=
Player.Character
and
Player.Character:
FindFirstChildOfClass(
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
speedOn and
"Speed : ON"
or
"Speed : OFF"

apply()

end)

local box=
Instance.new(
"TextBox"
)

box.Parent=scroll

box.Size=
UDim2.new(
.8,
0,
0,
30
)

box.Position=
UDim2.new(
.1,
0,
0,
150
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

apply()

end

end)

local plus=
make("+",195)

plus.Size=
UDim2.new(
.35,
0,
0,
30
)

plus.MouseButton1Click:Connect(function()

speed+=5

box.Text=speed

apply()

end)

local minus=
make("-",195)

minus.Size=
UDim2.new(
.35,
0,
0,
30
)

minus.Position=
UDim2.new(
.55,
0,
0,
195
)

minus.MouseButton1Click:Connect(function()

speed=
math.max(
0,
speed-5
)

box.Text=speed

apply()

end)


---

-- AIM

local aim=false
local target=nil
local FOV=150

local aimBtn=
make(
"Aimbot : OFF",
245
)

local circle=
Instance.new(
"Frame"
)

circle.Parent=gui

circle.Size=
UDim2.new(
0,
FOV*2,
0,
FOV*2
)

circle.AnchorPoint=
Vector2.new(
.5,
.5
)

circle.Position=
UDim2.new(
.5,
0,
.5,
0
)

circle.BackgroundTransparency=1
circle.Visible=false

local fs=
Instance.new(
"UIStroke"
)

fs.Parent=circle
fs.Color=BORDER

Instance.new(
"UICorner",
circle
).CornerRadius=
UDim.new(
1,
0
)

local function alive(p)

local c=
p and p.Character

local h=
c and
c:FindFirstChild(
"Humanoid"
)

return h
and
h.Health>0
and
c:FindFirstChild(
"Head"
)

end

local function find()

local center=
Vector2.new(

Camera.ViewportSize.X/2,

Camera.ViewportSize.Y/2

)

local best
local dist=FOV

for _,p in ipairs(
Players:GetPlayers()
) do

if    

p~=Player    

and    

alive(p)    

then    

	local pos,on=    
	Camera:    
	WorldToViewportPoint(    

	p.Character.Head.Position    

	)    

	if on then    

		local d=    

		(    
		Vector2.new(    
		pos.X,    
		pos.Y    
		)    

		-    
		center    

		).Magnitude    

		if d<dist then    

			best=p    
			dist=d    

		end    

	end    

end

end

return best

end

aimBtn.MouseButton1Click:Connect(function()

aim=
not aim

circle.Visible=
aim

aimBtn.Text=
aim and
"Aimbot : ON"
or
"Aimbot : OFF"

end)

RunService.RenderStepped:Connect(function()

if not aim then
return
end

if
not target
or
not alive(
target
)

then

target=    
find()

end

if target then

Camera.CFrame=    
CFrame.lookAt(    

Camera.CFrame.Position,    

target.Character    
.Head    
.Position    

)

end

end)


---

-- MENU BUTTON

local menu=
Instance.new(
"TextButton"
)

menu.Parent=gui

menu.Size=
UDim2.new(
0,
42,
0,
42
)

menu.Position=
UDim2.new(
0,
20,
.5,
-21
)

menu.Text="🍌"

Instance.new(
"UICorner",
menu
)

local ms=
Instance.new(
"UIStroke"
)

ms.Parent=menu

ms.Color=BORDER
ms.Thickness=3
--------------------------------------------------
-- MENU BUTTON + DRAG 🍌
--------------------------------------------------

local dragging=false
local moved=false
local dragStart
local startPos

menu.InputBegan:Connect(function(input)

	if input.UserInputType==Enum.UserInputType.MouseButton1
	or input.UserInputType==Enum.UserInputType.Touch then

		dragging=true
		moved=false
		dragStart=input.Position
		startPos=menu.Position

	end

end)

UIS.InputChanged:Connect(function(input)

	if dragging and (
		input.UserInputType==Enum.UserInputType.MouseMovement
		or
		input.UserInputType==Enum.UserInputType.Touch
	) then

		local delta=input.Position-dragStart

		if delta.Magnitude>8 then
			moved=true
		end

		menu.Position=UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset+delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset+delta.Y
		)

	end

end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType==Enum.UserInputType.MouseButton1
	or input.UserInputType==Enum.UserInputType.Touch then

		dragging=false

		if not moved then
			frame.Visible=not frame.Visible
		end

	end

end)
