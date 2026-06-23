local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--------------------------------------------------
-- COLOR (MÀU GIỐNG ẢNH)
--------------------------------------------------

local MENU_COLOR =
Color3.fromRGB(
136,
219,
131
)

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui =
Instance.new("ScreenGui")

gui.Parent =
Player:WaitForChild(
"PlayerGui"
)

gui.ResetOnSpawn =
false

--------------------------------------------------
-- DRAG
--------------------------------------------------

local function drag(obj)

local holding=false
local start
local pos

obj.InputBegan:Connect(function(i)

if i.UserInputType==
Enum.UserInputType.Touch
or
i.UserInputType==
Enum.UserInputType.MouseButton1 then

holding=true

start=
i.Position

pos=
obj.Position

end

end)

obj.InputEnded:Connect(function()

holding=false

end)

UIS.InputChanged:Connect(function(i)

if holding then

local d=
i.Position-start

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
-- MENU IMAGE BUTTON
--------------------------------------------------

local menu =
Instance.new(
"ImageButton"
)

menu.Parent =
gui

menu.Size =
UDim2.new(
0,
80,
0,
80
)

menu.Position =
UDim2.new(
0,
20,
0.5,
-40
)

menu.Image =
"rbxassetid://138132473369776"

menu.BackgroundTransparency =
1

menu.ScaleType =
Enum.ScaleType.Fit

local corner =
Instance.new(
"UICorner"
)

corner.Parent =
menu

corner.CornerRadius =
UDim.new(
0,
18
)

drag(menu)

--------------------------------------------------
-- FRAME
--------------------------------------------------

local frame=
Instance.new(
"Frame"
)

frame.Parent=
gui

frame.Size=
UDim2.new(
0,
260,
0,
350
)

frame.Position=
UDim2.new(
.5,
-130,
.5,
-175
)

frame.Visible=
false

frame.BackgroundColor3=
MENU_COLOR

frame.BackgroundTransparency=
0.8

drag(frame)

menu.MouseButton1Click:Connect(function()

frame.Visible=
not frame.Visible

end)

--------------------------------------------------
-- TITLE
--------------------------------------------------

local title=
Instance.new(
"TextLabel"
)

title.Parent=
frame

title.Size=
UDim2.new(
1,
0,
0,
40
)

title.Text=
"Menu"

title.TextSize=
18

title.TextColor3=
Color3.new(
0,
0,
0
)

title.BackgroundTransparency=
1

--------------------------------------------------
-- CREATE BUTTON
--------------------------------------------------

local function make(text,y)

local b=
Instance.new(
"TextButton"
)

b.Parent=
frame

b.Size=
UDim2.new(
.8,
0,
0,
35
)

b.Position=
UDim2.new(
.1,
0,
0,
y
)

b.Text=text

b.TextSize=
15

b.BackgroundColor3=
MENU_COLOR

b.BackgroundTransparency=
0.35

b.TextColor3=
Color3.new(
0,
0,
0
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
50
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
"DevDebug"
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
"DevDebug"

h.FillColor=
Color3.new(
0,
1,
0
)

h.FillTransparency=
0.8

h.DepthMode=
Enum.HighlightDepthMode
.AlwaysOnTop

h.Parent=
p.Character

end

end

end

end

esp.MouseButton1Click:Connect(function()

ESP=
not ESP

esp.Text=
ESP
and
"ESP : ON"
or
"ESP : OFF"

updateESP()

end)

--------------------------------------------------
-- INFINITE JUMP
--------------------------------------------------

local inf=false

local jump=
make(
"Infinite Jump : OFF",
95
)

jump.MouseButton1Click:Connect(function()

inf=
not inf

jump.Text=
inf
and
"Infinite Jump : ON"
or
"Infinite Jump : OFF"

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
Enum.HumanoidStateType
.Jumping
)

end

end

end)

--------------------------------------------------
-- SPEED
--------------------------------------------------

local speed=16
local enabled=false

local speedBtn=
make(
"Speed : OFF",
140
)

local function updateSpeed()

local h=
Player.Character
and
Player.Character:
FindFirstChildOfClass(
"Humanoid"
)

if h then

h.WalkSpeed=
enabled
and
speed
or
16

end

end

speedBtn.MouseButton1Click:Connect(function()

enabled=
not enabled

speedBtn.Text=
enabled
and
"Speed : ON"
or
"Speed : OFF"

updateSpeed()

end)

--------------------------------------------------
-- VALUE
--------------------------------------------------

local value=
Instance.new(
"TextBox"
)

value.Parent=
frame

value.Size=
UDim2.new(
.8,
0,
0,
35
)

value.Position=
UDim2.new(
.1,
0,
0,
190
)

value.Text=
"16"

value.TextSize=
15

value.TextColor3=
Color3.new(
0,
0,
0
)

value.BackgroundColor3=
MENU_COLOR

value.BackgroundTransparency=
0.35

value.PlaceholderText=
"Speed Value"

value.FocusLost:Connect(function()

local n=
tonumber(
value.Text
)

if n then

speed=
math.max(
n,
0
)

value.Text=
tostring(
speed
)

updateSpeed()

else

value.Text=
tostring(
speed
)

end

end)

--------------------------------------------------
-- +
--------------------------------------------------

local plus=
make(
"+",
240
)

plus.Size=
UDim2.new(
.35,
0,
0,
35
)

plus.MouseButton1Click:Connect(function()

speed=
speed+5

value.Text=
speed

updateSpeed()

end)

--------------------------------------------------
-- -
--------------------------------------------------

local minus=
make(
"-",
240
)

minus.Position=
UDim2.new(
.55,
0,
0,
240
)

minus.Size=
UDim2.new(
.35,
0,
0,
35
)

minus.MouseButton1Click:Connect(function()

speed=
math.max(
speed-5,
0
)

value.Text=
speed

updateSpeed()

end)

Player.CharacterAdded:Connect(function()

task.wait(1)

updateSpeed()

updateESP()

end)
