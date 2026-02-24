-- PhantomHax - 1.9v FINAL
-- Dodano: Fling Player (wpisz nick → Fling → wyleci w powietrze)
-- Auto Collect Cash (zbiera po kolei stojąc w miejscu), Anti-AFK, Prefixy, Fly, NoClip, Speed, God

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("PhantomHax") then
    CoreGui.PhantomHax:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhantomHax"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Główna ramka
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 460, 0, 540)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -270)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(130, 0, 255)
MainStroke.Thickness = 2.5
MainStroke.Parent = MainFrame

-- Pasek tytułu
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
TitleBar.Parent = MainFrame

local Icon = Instance.new("TextLabel")
Icon.Text = "👻"
Icon.TextColor3 = Color3.fromRGB(130, 0, 255)
Icon.TextSize = 28
Icon.BackgroundTransparency = 1
Icon.Position = UDim2.new(0, 14, 0.5, -14)
Icon.Size = UDim2.new(0, 28, 0, 28)
Icon.Font = Enum.Font.Gotham
Icon.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Text = "PhantomHax - 1.9v"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 52, 0, 0)
Title.Size = UDim2.new(1, -140, 1, 0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Minimalizacja i zamknięcie
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -78, 0.5, -13)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 20
MinimizeBtn.Parent = TitleBar
Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 8)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(210, 40, 40)
CloseBtn.Size = UDim2.new(0, 30, 0, 26)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -13)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Tabs
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 40)
TabFrame.Position = UDim2.new(0, 0, 0, 42)
TabFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
TabFrame.Parent = MainFrame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.Padding = UDim.new(0, 10)
TabLayout.Parent = TabFrame

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, 0, 1, -82)
ContentArea.Position = UDim2.new(0, 0, 0, 82)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Tworzenie tabów
local function createTab(name, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Text = name
    btn.TextColor3 = color or Color3.fromRGB(200, 200, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 16
    btn.Parent = TabFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.ScrollBarThickness = 4
    content.ScrollBarImageColor3 = Color3.fromRGB(130, 0, 255)
    content.Visible = false
    content.Parent = ContentArea

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 12)
    layout.Parent = content

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 20)
    pad.PaddingRight = UDim.new(0, 20)
    pad.PaddingTop = UDim.new(0, 15)
    pad.PaddingBottom = UDim.new(0, 15)
    pad.Parent = content

    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(ContentArea:GetChildren()) do
            if f:IsA("ScrollingFrame") then f.Visible = false end
        end
        content.Visible = true
    end)

    return content
end

local MovementTab = createTab("Movement", Color3.fromRGB(130, 0, 255))
local SurvivalTab = createTab("Survival", Color3.fromRGB(0, 200, 100))
local RenderTab = createTab("Render", Color3.fromRGB(255, 150, 50))

-- Zmienne
local flyEnabled = false
local noclipEnabled = false
local speedEnabled = false
local godEnabled = false
local autoCollectEnabled = false
local antiAFKEnabled = false
local flingTarget = ""
local flySpeed = 70
local noclipSpeed = 50
local customWalkSpeed = 100
local connections = {}
local safetyPlatform = nil
local currentPrefix = nil
local prefixBillboard = nil

-- Klocek pod nogi
local function createSafetyPlatform()
    if safetyPlatform then safetyPlatform:Destroy() end
    safetyPlatform = Instance.new("Part")
    safetyPlatform.Size = Vector3.new(6, 0.8, 6)
    safetyPlatform.Transparency = 1
    safetyPlatform.CanCollide = true
    safetyPlatform.Anchored = true
    safetyPlatform.Parent = Workspace
end

local function updateSafetyPlatform()
    if not safetyPlatform then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        safetyPlatform.CFrame = hrp.CFrame * CFrame.new(0, -3.3, 0)
    end
end

-- Prefix nad głową
local function setPrefix(prefix, color)
    if prefixBillboard then prefixBillboard:Destroy() end
    currentPrefix = prefix

    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("Head") then return end

    prefixBillboard = Instance.new("BillboardGui")
    prefixBillboard.Adornee = char.Head
    prefixBillboard.Size = UDim2.new(0, 200, 0, 50)
    prefixBillboard.StudsOffset = Vector3.new(0, 3.5, 0)
    prefixBillboard.AlwaysOnTop = true
    prefixBillboard.Parent = char

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.Text = prefix
    text.TextColor3 = color
    text.TextStrokeTransparency = 0.6
    text.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 24
    text.TextScaled = true
    text.Parent = prefixBillboard
end

local function removePrefix()
    if prefixBillboard then prefixBillboard:Destroy() prefixBillboard = nil end
    currentPrefix = nil
end

-- Auto Collect Cash / Coins
local function toggleAutoCollect(enabled)
    autoCollectEnabled = enabled
    if enabled then
        connections.AutoCollect = {}
        table.insert(connections.AutoCollect, RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (
                    obj.Name:lower():find("coin") or
                    obj.Name:lower():find("cash") or
                    obj.Name:lower():find("money") or
                    obj.Name:lower():find("collect") or
                    obj.Name:lower():find("gem") or
                    obj.Name:lower():find("drop")
                ) then
                    local dist = (obj.Position - hrp.Position).Magnitude
                    if dist < 35 then
                        hrp.CFrame = CFrame.new(obj.Position + Vector3.new(0, 2.5, 0))
                        task.wait(0.04)
                        firetouchinterest(hrp, obj, 0)
                        task.wait(0.04)
                        firetouchinterest(hrp, obj, 1)
                    end
                end

                if obj:IsA("ProximityPrompt") and obj.Enabled then
                    local dist = (obj.Parent.Position - hrp.Position).Magnitude
                    if dist < 20 then
                        pcall(function()
                            fireproximityprompt(obj, 0)
                        end)
                    end
                end
            end
        end))
    else
        if connections.AutoCollect then
            for _, c in ipairs(connections.AutoCollect) do pcall(function() c:Disconnect() end) end
            connections.AutoCollect = nil
        end
    end
end

-- Anti-AFK
local function toggleAntiAFK(enabled)
    antiAFKEnabled = enabled
    if enabled then
        connections.AntiAFK = {}
        table.insert(connections.AntiAFK, RunService.Heartbeat:Connect(function()
            if tick() % 30 < 1 then
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    local hum = char.Humanoid
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    task.wait(0.1)
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end
        end))
    else
        if connections.AntiAFK then
            for _, c in ipairs(connections.AntiAFK) do pcall(function() c:Disconnect() end) end
            connections.AntiAFK = nil
        end
    end
end

-- Fling Player
local function flingPlayer(targetName)
    local target = Players:FindFirstChild(targetName)
    if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
        print("Gracz " .. targetName .. " nie znaleziony lub bez postaci")
        return
    end

    local targetHRP = target.Character.HumanoidRootPart
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
    local myHRP = myChar.HumanoidRootPart

    -- Fling – duża siła w górę + losowy kierunek
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(math.random(-200,200), 500 + math.random(200,400), math.random(-200,200))
    bodyVelocity.Parent = targetHRP

    task.delay(0.4, function()
        if bodyVelocity then bodyVelocity:Destroy() end
    end)

    print("Flingnięto gracza: " .. targetName .. "!")
end

-- Czyszczenie
local function cleanupCheat(name)
    if connections[name] then
        for _, c in ipairs(connections[name]) do pcall(function() c:Disconnect() end) end
        connections[name] = nil
    end

    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildWhichIsA("Humanoid")

    if (name == "Fly" or name == "NoClip") and hrp then
        hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 0, hrp.AssemblyLinearVelocity.Z)
        hrp.CFrame += Vector3.new(0, 0.6, 0)

        task.spawn(function()
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    task.wait(0.01)
                    pcall(function() p.CanCollide = true end)
                end
            end
        end)

        if hum then
            task.delay(0.1, function()
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
            end)
        end
    end

    if name == "Speed" and hum then pcall(function() hum.WalkSpeed = 16 end) end
    if name == "God" and hum then
        pcall(function()
            hum.MaxHealth = 100
            hum.Health = 100
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
        end)
    end

    if safetyPlatform and (name == "Fly" or name == "NoClip") then
        safetyPlatform:Destroy()
        safetyPlatform = nil
    end
end

local function fullCleanup()
    for n in pairs({Fly=true, NoClip=true, Speed=true, God=true, AutoCollect=true, AntiAFK=true}) do
        cleanupCheat(n)
    end
    removePrefix()
end

-- Fly
local function toggleFly(enabled)
    flyEnabled = enabled
    cleanupCheat("Fly")
    if enabled then
        createSafetyPlatform()
        connections.Fly = {}
        table.insert(connections.Fly, RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
            updateSafetyPlatform()

            local move = Vector3.new()
            local cam = Workspace.CurrentCamera
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end

            if move.Magnitude > 0 then
                hrp.AssemblyLinearVelocity = move.Unit * flySpeed
            else
                hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
            end
        end))
    end
end

-- NoClip
local function toggleNoClip(enabled)
    noclipEnabled = enabled
    cleanupCheat("NoClip")
    if enabled and not flyEnabled then
        createSafetyPlatform()
        connections.NoClip = {}
        table.insert(connections.NoClip, RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            for _, p in pairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
            updateSafetyPlatform()

            local hum = char:FindFirstChildWhichIsA("Humanoid")
            if hum then hum.WalkSpeed = noclipSpeed end
        end))
    end
end

-- Speed
local function toggleSpeed(enabled)
    speedEnabled = enabled
    cleanupCheat("Speed")
    if enabled then
        connections.Speed = {}
        table.insert(connections.Speed, RunService.Heartbeat:Connect(function()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            if hum then hum.WalkSpeed = customWalkSpeed end
        end))
    end
end

-- God Mode
local function toggleGod(enabled)
    godEnabled = enabled
    cleanupCheat("God")
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if not hum then return end
    if enabled then
        connections.God = {}
        pcall(function()
            hum.MaxHealth = math.huge
            hum.Health = math.huge
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        end)
        table.insert(connections.God, RunService.Heartbeat:Connect(function()
            if hum.Health < hum.MaxHealth and hum.Health > 0 then
                pcall(function() hum.Health = hum.MaxHealth end)
            end
        end))
    end
end

-- Respawn fix
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.8)
    if flyEnabled then toggleFly(true) end
    if noclipEnabled and not flyEnabled then toggleNoClip(true) end
    if speedEnabled then toggleSpeed(true) end
    if godEnabled then toggleGod(true) end
    if autoCollectEnabled then toggleAutoCollect(true) end
    if antiAFKEnabled then toggleAntiAFK(true) end
    if currentPrefix then
        task.delay(0.5, function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Head") then
                setPrefix(currentPrefix, currentPrefix == "[ADMIN]" and Color3.fromRGB(255, 80, 80) or
                    currentPrefix == "[CEO]" and Color3.fromRGB(180, 0, 0) or
                    Color3.fromRGB(0, 255, 100))
            end
        end)
    end
end)

-- Dodawanie toggle do tabów
local function addToggle(tab, name, callback)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1,0,0,40)
    row.BackgroundTransparency = 1
    row.Parent = tab

    local label = Instance.new("TextLabel")
    label.Text = name
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1,-90,1,0)
    label.Parent = row

    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0,52,0,26)
    toggleFrame.Position = UDim2.new(1,-65,0.5,-13)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(50,50,60)
    toggleFrame.Parent = row
    Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0,13)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0,20,0,20)
    circle.Position = UDim2.new(0,3,0.5,-10)
    circle.BackgroundColor3 = Color3.fromRGB(120,120,130)
    circle.Parent = toggleFrame
    Instance.new("UICorner", circle).CornerRadius = UDim.new(0,10)

    local enabled = false
    local function updateUI()
        local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quart)
        if enabled then
            TweenService:Create(toggleFrame, ti, {BackgroundColor3 = Color3.fromRGB(130,0,255)}):Play()
            TweenService:Create(circle, ti, {Position = UDim2.new(1,-23,0.5,-10), BackgroundColor3 = Color3.fromRGB(255,255,255)}):Play()
        else
            TweenService:Create(toggleFrame, ti, {BackgroundColor3 = Color3.fromRGB(50,50,60)}):Play()
            TweenService:Create(circle, ti, {Position = UDim2.new(0,3,0.5,-10), BackgroundColor3 = Color3.fromRGB(120,120,130)}):Play()
        end
    end

    toggleFrame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            enabled = not enabled
            updateUI()
            callback(enabled)
        end
    end)
    updateUI()
end

-- Movement Tab
addToggle(MovementTab, "Fly", toggleFly)
addToggle(MovementTab, "NoClip + klock pod nogi", toggleNoClip)
addToggle(MovementTab, "Normal Speed Hack", toggleSpeed)
addToggle(MovementTab, "God Mode", toggleGod)

-- Survival Tab
addToggle(SurvivalTab, "[ADMIN] jasny czerwony", function(enabled)
    if enabled then
        setPrefix("[ADMIN]", Color3.fromRGB(255, 80, 80))
    else
        removePrefix()
    end
end)

addToggle(SurvivalTab, "[CEO] ciemny czerwony", function(enabled)
    if enabled then
        setPrefix("[CEO]", Color3.fromRGB(180, 0, 0))
    else
        removePrefix()
    end
end)

addToggle(SurvivalTab, "[MOD] zielony", function(enabled)
    if enabled then
        setPrefix("[MOD]", Color3.fromRGB(0, 255, 100))
    else
        removePrefix()
    end
end)

addToggle(SurvivalTab, "Auto Collect Cash / Coins", toggleAutoCollect)
addToggle(SurvivalTab, "Anti-AFK", toggleAntiAFK)

-- Fling Player (dodaj w Survival lub nowej zakładce Combat)
local flingRow = Instance.new("Frame")
flingRow.Size = UDim2.new(1,0,0,40)
flingRow.BackgroundTransparency = 1
flingRow.Parent = SurvivalTab

local flingLabel = Instance.new("TextLabel")
flingLabel.Text = "Fling Player:"
flingLabel.TextColor3 = Color3.fromRGB(255,255,255)
flingLabel.Size = UDim2.new(0.4,0,1,0)
flingLabel.BackgroundTransparency = 1
flingLabel.TextXAlignment = Enum.TextXAlignment.Left
flingLabel.Parent = flingRow

local flingInput = Instance.new("TextBox")
flingInput.PlaceholderText = "Wpisz nick gracza"
flingInput.BackgroundColor3 = Color3.fromRGB(35,35,45)
flingInput.Size = UDim2.new(0.4,0,1,0)
flingInput.Position = UDim2.new(0.4,0,0,0)
flingInput.Font = Enum.Font.Gotham
flingInput.TextColor3 = Color3.fromRGB(255,255,255)
flingInput.TextSize = 15
flingInput.Parent = flingRow
Instance.new("UICorner", flingInput).CornerRadius = UDim.new(0,8)

local flingBtn = Instance.new("TextButton")
flingBtn.Text = "Fling!"
flingBtn.BackgroundColor3 = Color3.fromRGB(210, 40, 40)
flingBtn.TextColor3 = Color3.fromRGB(255,255,255)
flingBtn.Size = UDim2.new(0.18,0,1,0)
flingBtn.Position = UDim2.new(0.82,0,0,0)
flingBtn.Font = Enum.Font.GothamBold
flingBtn.TextSize = 15
flingBtn.Parent = flingRow
Instance.new("UICorner", flingBtn).CornerRadius = UDim.new(0,8)

flingBtn.MouseButton1Click:Connect(function()
    local nick = flingInput.Text
    if nick == "" then return end
    flingPlayer(nick)
end)

flingInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local nick = flingInput.Text
        if nick ~= "" then
            flingPlayer(nick)
        end
    end
end)

-- Fly Speed
local flyRow = Instance.new("Frame")
flyRow.Size = UDim2.new(1,0,0,40)
flyRow.BackgroundTransparency = 1
flyRow.Parent = MovementTab

local flyLabel = Instance.new("TextLabel")
flyLabel.Text = "Fly Speed:"
flyLabel.TextColor3 = Color3.fromRGB(255,255,255)
flyLabel.Size = UDim2.new(0.5,0,1,0)
flyLabel.BackgroundTransparency = 1
flyLabel.TextXAlignment = Enum.TextXAlignment.Left
flyLabel.Parent = flyRow

local flyBox = Instance.new("TextBox")
flyBox.Text = tostring(flySpeed)
flyBox.BackgroundColor3 = Color3.fromRGB(35,35,45)
flyBox.Size = UDim2.new(0,90,1,0)
flyBox.Position = UDim2.new(0.5,0,0,0)
flyBox.Font = Enum.Font.GothamSemibold
flyBox.TextColor3 = Color3.fromRGB(255,255,255)
flyBox.TextSize = 15
flyBox.Parent = flyRow
Instance.new("UICorner", flyBox).CornerRadius = UDim.new(0,8)

flyBox.FocusLost:Connect(function()
    local num = tonumber(flyBox.Text)
    if num then
        flySpeed = math.clamp(num, 20, 400)
        flyBox.Text = tostring(flySpeed)
    end
end)

-- NoClip Speed
local noclipRow = Instance.new("Frame")
noclipRow.Size = UDim2.new(1,0,0,40)
noclipRow.BackgroundTransparency = 1
noclipRow.Parent = MovementTab

local noclipLabel = Instance.new("TextLabel")
noclipLabel.Text = "NoClip Speed:"
noclipLabel.TextColor3 = Color3.fromRGB(255,255,255)
noclipLabel.Size = UDim2.new(0.5,0,1,0)
noclipLabel.BackgroundTransparency = 1
noclipLabel.TextXAlignment = Enum.TextXAlignment.Left
noclipLabel.Parent = noclipRow

local noclipBox = Instance.new("TextBox")
noclipBox.Text = tostring(noclipSpeed)
noclipBox.BackgroundColor3 = Color3.fromRGB(35,35,45)
noclipBox.Size = UDim2.new(0,90,1,0)
noclipBox.Position = UDim2.new(0.5,0,0,0)
noclipBox.Font = Enum.Font.GothamSemibold
noclipBox.TextColor3 = Color3.fromRGB(255,255,255)
noclipBox.TextSize = 15
noclipBox.Parent = noclipRow
Instance.new("UICorner", noclipBox).CornerRadius = UDim.new(0,8)

noclipBox.FocusLost:Connect(function()
    local num = tonumber(noclipBox.Text)
    if num then
        noclipSpeed = math.clamp(num, 20, 200)
        noclipBox.Text = tostring(noclipSpeed)
    end
end)

-- Render Tab – Fullbright
addToggle(RenderTab, "Fullbright", function(enabled)
    if enabled then
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9999
    else
        Lighting.Brightness = 1
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 100000
    end
end)

-- Minimalizacja
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = UDim2.new(0,460,0,42)
        ContentArea.Visible = false
        TabFrame.Visible = false
        MinimizeBtn.Text = "+"
    else
        MainFrame.Size = UDim2.new(0,460,0,540)
        ContentArea.Visible = true
        TabFrame.Visible = true
        MinimizeBtn.Text = "−"
    end
end)

-- Zamknięcie
CloseBtn.MouseButton1Click:Connect(function()
    fullCleanup()
    ScreenGui:Destroy()
end)

-- Drag okna
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Domyślny tab
MovementTab.Visible = true

print("PhantomHax 1.9v załadowany!")
print("Fling Player w zakładce Survival – wpisz nick i kliknij Fling!")
print("Auto Collect i Anti-AFK też w Survival")