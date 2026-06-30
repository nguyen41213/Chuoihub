local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Xóa GUI cũ để tránh trùng lặp khi chạy lại script
pcall(function()
    local old = Player.PlayerGui:FindFirstChild("BananaHub")
    if old then
        old:Destroy()
    end
end)

---
-- KHỞI TẠO GUI CHÍNH
local gui = Instance.new("ScreenGui")
gui.Name = "BananaHub"
gui.Parent = Player.PlayerGui
gui.ResetOnSpawn = false

local MENU = Color3.fromRGB(255, 255, 255)
local BORDER = Color3.fromRGB(57, 255, 20)

---
-- GIAO DIỆN BẢNG ĐIỀU KHIỂN (FRAME)
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 186, 0, 275)
frame.Position = UDim2.new(0.5, -93, 0.5, -127)
frame.BackgroundColor3 = MENU
frame.BackgroundTransparency = 0.5

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke")
stroke.Parent = frame
stroke.Color = BORDER
stroke.Thickness = 2

---
-- TIÊU ĐỀ MENU VÀ TÁC GIẢ (TITLE & CREDIT)
local titleFrame = Instance.new("Frame")
titleFrame.Parent = frame
titleFrame.Size = UDim2.new(1, 0, 0, 45)
titleFrame.BackgroundTransparency = 1

local title = Instance.new("TextLabel")
title.Parent = titleFrame
title.Size = UDim2.new(1, 0, 0, 25)
title.Position = UDim2.new(0, 0, 0, 4)
title.BackgroundTransparency = 1
title.Text = "🍌 Banana Hub"
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Dòng chữ tác giả đổi màu RGB tự động, in đậm
local credit = Instance.new("TextLabel")
credit.Parent = titleFrame
credit.Size = UDim2.new(1, 0, 0, 15)
credit.Position = UDim2.new(0, 0, 0, 26)
credit.BackgroundTransparency = 1
credit.Text = "By @n_g_uy_e_n"
credit.TextSize = 12
credit.Font = Enum.Font.GothamBold

-- Thêm viền đen mỏng cho chữ tác giả
local creditStroke = Instance.new("UIStroke")
creditStroke.Parent = credit
creditStroke.Color = Color3.fromRGB(0, 0, 0)
creditStroke.Thickness = 1
creditStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

---
-- KHUNG CUỘN (SCROLLING FRAME)
local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.Size = UDim2.new(1, 0, 1, -55)
scroll.Position = UDim2.new(0, 0, 0, 50)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local layout = Instance.new("UIListLayout")
layout.Parent = scroll
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0, 8)

---
-- TÍNH NĂNG KÉO THẢ CHO VIỀN FRAME CHÍNH
local drag = false
local start
local pos

frame.InputBegan:Connect(function(i)
    local p = i.Position
    local edge = p.X - frame.AbsolutePosition.X < 18 or
                 frame.AbsolutePosition.X + frame.AbsoluteSize.X - p.X < 18 or
                 p.Y - frame.AbsolutePosition.Y < 18 or
                 frame.AbsolutePosition.Y + frame.AbsoluteSize.Y - p.Y < 18

    if edge and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1) then
        drag = true    
        start = i.Position    
        pos = frame.Position
    end
end)

UIS.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local d = i.Position - start    
        frame.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
    end
end)

UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = false
    end
end)

---
-- HÀM TẠO NÚT BẤM TRONG SCROLL FRAME
local function make(text, order)
    local b = Instance.new("TextButton")
    b.Parent = scroll
    b.Size = UDim2.new(0.85, 0, 0, 32)
    b.Text = text
    b.BackgroundTransparency = 0.25
    b.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    b.LayoutOrder = order
    Instance.new("UICorner", b)
    return b
end

---
-- CHỨC NĂNG ESP BOX 2D
local ESP = false
local esp = make("ESP : OFF", 0.5)

local function updateESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and p.Character then
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            local old = p.Character:FindFirstChild("BananaESP_Box")
            
            if ESP and root then
                if not old then
                    local bGui = Instance.new("BillboardGui")
                    bGui.Name = "BananaESP_Box"
                    bGui.AlwaysOnTop = true
                    bGui.Size = UDim2.new(4.5, 0, 6, 0)
                    bGui.Adornee = root
                    bGui.Parent = p.Character
                    
                    local boxFrame = Instance.new("Frame")
                    boxFrame.Size = UDim2.new(1, 0, 1, 0)
                    boxFrame.BackgroundTransparency = 1
                    boxFrame.Parent = bGui
                    
                    local boxStroke = Instance.new("UIStroke")
                    boxStroke.Name = "BoxStroke"
                    boxStroke.Color = Color3.fromRGB(0, 255, 0)
                    boxStroke.Thickness = 2
                    boxStroke.Parent = boxFrame
                end
            else
                if old then old:Destroy() end
            end
        end
    end
end

esp.MouseButton1Click:Connect(function()
    ESP = not ESP
    esp.Text = ESP and "ESP : ON" or "ESP : OFF"
    updateESP()
end)

task.spawn(function()
    while task.wait(1) do
        if ESP then updateESP() end
    end
end)

---
-- CHỨC NĂNG JUMP (NHẢY VÔ HẠN)
local inf = false
local jump = make("Jump : OFF", 2)

jump.MouseButton1Click:Connect(function()
    inf = not inf
    jump.Text = inf and "Jump : ON" or "Jump : OFF"
end)

UIS.JumpRequest:Connect(function()
    if inf then
        local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")    
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

---
-- CHỨC NĂNG SPEED (TỐC ĐỘ CHẠY)
local speed = 16
local speedOn = false
local speedBtn = make("Speed : OFF", 3)

local speedControlFrame = Instance.new("Frame")
speedControlFrame.Parent = scroll
speedControlFrame.Size = UDim2.new(0.85, 0, 0, 32)
speedControlFrame.BackgroundTransparency = 1
speedControlFrame.LayoutOrder = 4
speedControlFrame.Visible = false 

local box = Instance.new("TextBox")
box.Parent = speedControlFrame
box.Size = UDim2.new(0.4, 0, 1, 0)
box.Text = "16"
Instance.new("UICorner", box)

local function apply()
    local h = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = speedOn and speed or 16 end
end

box.FocusLost:Connect(function()
    local n = tonumber(box.Text)
    if n then
        speed = math.max(0, n)
        box.Text = tostring(speed)
        apply()
    end
end)

local plus = Instance.new("TextButton")
plus.Parent = speedControlFrame
plus.Size = UDim2.new(0.25, 0, 1, 0)
plus.Position = UDim2.new(0.45, 0, 0, 0)
plus.Text = "+"
plus.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
plus.BackgroundTransparency = 0.25
Instance.new("UICorner", plus)

plus.MouseButton1Click:Connect(function()
    speed += 5
    box.Text = tostring(speed)
    apply()
end)

local minus = Instance.new("TextButton")
minus.Parent = speedControlFrame
minus.Size = UDim2.new(0.25, 0, 1, 0)
minus.Position = UDim2.new(0.75, 0, 0, 0)
minus.Text = "-"
minus.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
minus.BackgroundTransparency = 0.25
Instance.new("UICorner", minus)

minus.MouseButton1Click:Connect(function()
    speed = math.max(0, speed - 5)
    box.Text = tostring(speed)
    apply()
end)

speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    speedControlFrame.Visible = speedOn 
    speedBtn.Text = speedOn and "Speed : ON" or "Speed : OFF"
    apply()
end)

---
-- CHỨC NĂNG AIMBOT VÀ ĐIỀU CHỈNH ĐỘ RỘNG FOV
local aim = false
local target = nil
local FOV = 150

local aimBtn = make("Aimbot : OFF", 5)

local circle = Instance.new("Frame")
circle.Parent = gui
circle.Size = UDim2.new(0, FOV * 2, 0, FOV * 2)
circle.AnchorPoint = Vector2.new(0.5, 0.5)
circle.Position = UDim2.new(0.5, 0, 0.5, 0)
circle.BackgroundTransparency = 1
circle.Visible = false

local fs = Instance.new("UIStroke")
fs.Parent = circle
fs.Thickness = 1.5

Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

local fovControlFrame = Instance.new("Frame")
fovControlFrame.Parent = scroll
fovControlFrame.Size = UDim2.new(0.85, 0, 0, 32)
fovControlFrame.BackgroundTransparency = 1
fovControlFrame.LayoutOrder = 6
fovControlFrame.Visible = false 

local fovBox = Instance.new("TextBox")
fovBox.Parent = fovControlFrame
fovBox.Size = UDim2.new(0.4, 0, 1, 0)
fovBox.Text = tostring(FOV)
Instance.new("UICorner", fovBox)

local function updateFOVSize()
    circle.Size = UDim2.new(0, FOV * 2, 0, FOV * 2)
end

fovBox.FocusLost:Connect(function()
    local n = tonumber(fovBox.Text)
    if n then
        FOV = math.max(10, n)
        fovBox.Text = tostring(FOV)
        updateFOVSize()
    end
end)

local fovPlus = Instance.new("TextButton")
fovPlus.Parent = fovControlFrame
fovPlus.Size = UDim2.new(0.25, 0, 1, 0)
fovPlus.Position = UDim2.new(0.45, 0, 0, 0)
fovPlus.Text = "+"
fovPlus.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
fovPlus.BackgroundTransparency = 0.25
Instance.new("UICorner", fovPlus)

fovPlus.MouseButton1Click:Connect(function()
    FOV += 10
    fovBox.Text = tostring(FOV)
    updateFOVSize()
end)

local fovMinus = Instance.new("TextButton")
fovMinus.Parent = fovControlFrame
fovMinus.Size = UDim2.new(0.25, 0, 1, 0)
fovMinus.Position = UDim2.new(0.75, 0, 0, 0)
fovMinus.Text = "-"
fovMinus.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
fovMinus.BackgroundTransparency = 0.25
Instance.new("UICorner", fovMinus)

fovMinus.MouseButton1Click:Connect(function()
    FOV = math.max(10, FOV - 10)
    fovBox.Text = tostring(FOV)
    updateFOVSize()
end)

local function alive(p)
    local c = p and p.Character
    local h = c and c:FindFirstChild("Humanoid")
    return h and h.Health > 0 and c:FindFirstChild("Head")
end

local function isVisible(targetChar)
    if not Player.Character or not Player.Character:FindFirstChild("Head") then return false end
    if not targetChar:FindFirstChild("Head") then return false end
    
    local startPos = Camera.CFrame.Position
    local endPos = targetChar.Head.Position
    local direction = (endPos - startPos).Unit * (endPos - startPos).Magnitude
    
    local ray = Ray.new(startPos, direction)
    local hit, pos = workspace:FindPartOnRayWithIgnoreList(ray, {Player.Character, Camera})
    
    if hit and hit:IsDescendantOf(targetChar) then return true end
    return false
end

local function findNearestTarget()
    local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local best = nil
    local dist = FOV

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= Player and alive(p) then
            local isEnemy = true
            if Player.Team and p.Team and Player.Team == p.Team then isEnemy = false end
            
            if isEnemy then
                local pos, on = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if on then
                    local d = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                    if d < dist and isVisible(p.Character) then
                        best = p
                        dist = d
                    end
                end
            end
        end
    end
    return best
end

aimBtn.MouseButton1Click:Connect(function()
    aim = not aim
    circle.Visible = aim
    fovControlFrame.Visible = aim 
    aimBtn.Text = aim and "Aimbot : ON" or "Aimbot : OFF"
    
    if aim then target = findNearestTarget() else target = nil end
end)

RunService.RenderStepped:Connect(function()
    if not aim then return end
    if not target or not alive(target) or not isVisible(target.Character) then
        target = findNearestTarget()
    end
    if target and target.Character and target.Character:FindFirstChild("Head") then
        Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Character.Head.Position)
    end
end)

---
-- NÚT BẬT/TẮT MENU BANANA (KÉO THẢ ĐƯỢC)
local menu = Instance.new("TextButton")
menu.Parent = gui
menu.Size = UDim2.new(0, 42, 0, 42)
menu.Position = UDim2.new(0, 20, 0.5, -21)
menu.Text = "🍌"
menu.TextSize = 20
menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
menu.BackgroundTransparency = 0.5
menu.TextTransparency = 0.2
Instance.new("UICorner", menu)

local ms = Instance.new("UIStroke")
ms.Parent = menu
ms.Thickness = 2
ms.Transparency = 0

local menuDragging = false
local menuDragInput
local menuDragStart
local menuStartPos

menu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        menuDragging = true
        menuDragStart = input.Position
        menuStartPos = menu.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                menuDragging = false
            end
        end)
    end
end)

menu.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        menuDragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == menuDragInput and menuDragging then
        local delta = input.Position - menuDragStart
        menu.Position = UDim2.new(
            menuStartPos.X.Scale, 
            menuStartPos.X.Offset + delta.X, 
            menuStartPos.Y.Scale, 
            menuStartPos.Y.Offset + delta.Y
        )
    end
end)

menu.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

---
-- 🔴 VÒNG LẶP RGB CHÍNH (ĐẶT Ở CUỐI CÙNG ĐỂ ĐỒNG BỘ 100% TẤT CẢ VIỀN KHÔNG BỊ LỖI)
task.spawn(function()
    local hue = 0
    while true do
        hue = hue + (1/360)
        if hue > 1 then hue = 0 end
        local rainbowColor = Color3.fromHSV(hue, 1, 1)
        
        -- 1. Đổi màu chữ tác giả và viền menu chính
        credit.TextColor3 = rainbowColor
        stroke.Color = rainbowColor
        
        -- 2. Đổi màu viền nút tắt/mở quả chuối nhỏ
        if ms then ms.Color = rainbowColor end
        
        -- 3. Đổi màu vòng tròn FOV Aimbot
        if fs then fs.Color = rainbowColor end
        
        -- 4. Đổi màu luôn cho cả viền khung ESP Box 2D (Nếu đang bật)
        if ESP then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player and p.Character then
                    local box = p.Character:FindFirstChild("BananaESP_Box")
                    local bFrame = box and box:FindFirstChildOfClass("Frame")
                    local bStroke = bFrame and bFrame:FindFirstChild("BoxStroke")
                    if bStroke then
                        bStroke.Color = rainbowColor
                    end
                end
            end
        end
        
        task.wait(1/60) -- Chạy siêu mượt 60 FPS
    end
end)
