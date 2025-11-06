local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

if not game:IsLoaded() then
    game:GetService("StarterGui"):SetCore("SendNotification", { ["Title"] = "Script loading", ["Text"] = "Waiting for the game to finish loading!", ["Duration"] = 5 })
    game.Loaded:Wait()
end

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = true
Library.ShowToggleFrameInKeybinds = true
Library.ShowCustomCursor = true

local Window = Library:CreateWindow({
	Title = "UNXHub",
	Footer = "Version: 1.0, Game: Unknown",
	Icon = 123333102279908,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

local Tabs = {
    Main = Window:AddTab("Main", "user"),
    Visuals = Window:AddTab("Visuals", "eye"),
    Features = Window:AddTab("Features", "bug"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local MainCharacterGB = Tabs.Main:AddLeftGroupbox("Character", "user")
local MainOtherGB = Tabs.Main:AddRightGroupbox("Other", "package")

MainCharacterGB:AddSlider("WalkSpeed", {Text = "Walk Speed", Default = 16, Min = 16, Max = 100, Rounding = 0})
MainCharacterGB:AddSlider("JumpPower", {Text = "Jump Power", Default = 50, Min = 50, Max = 250, Rounding = 0})
MainCharacterGB:AddSlider("MaxZoom", {Text = "Max Zoom", Default = 128, Min = 0, Max = 800, Rounding = 0})
MainCharacterGB:AddToggle("NoVelocity", {Text = "No Velocity", Default = false})
MainCharacterGB:AddDivider()
MainCharacterGB:AddToggle("NoClip", {Text = "No-Clip", Default = false})
MainCharacterGB:AddDivider()
MainCharacterGB:AddToggle("BunnyHop", {Text = "Bunny Hop", Default = false})
MainCharacterGB:AddSlider("BunnyHopDelay", {Text = "Bunny Hop Delay (s)", Default = 0.2, Min = 0, Max = 3, Rounding = 2})

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local TeleportLocations = {
    Cabin = Vector3.new(104, 8, -417),
    ["Map Voting #1"] = Vector3.new(148, 4, -334),
    ["Map Voting #2"] = Vector3.new(153, 4, -333),
    ["Map Voting #3"] = Vector3.new(159, 4, -333),
    ["Map Voting #4"] = Vector3.new(166, 4, -333),
}

local function SmartTeleport(targetPos)
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local teleportType = Options.TeleportType.Value
    local useNoclip = Toggles.NoclipOnTween.Value
    local originalNoclip = Toggles.NoClip.Value

    if teleportType == "Instant (TP)" then
        root.CFrame = CFrame.new(targetPos)
        return
    end

    local distance = (root.Position - targetPos).Magnitude
    local duration = distance / Options.TweenSpeed.Value
    if duration <= 0 then duration = 0.1 end

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos)})

    if useNoclip then
        Toggles.NoClip:SetValue(true)
    end

    tween:Play()
    tween.Completed:Connect(function()
        if useNoclip and not originalNoclip then
            Toggles.NoClip:SetValue(false)
        end
    end)
end

MainOtherGB:AddButton("Teleport (Cabin)", function() SmartTeleport(TeleportLocations.Cabin) end)
MainOtherGB:AddDivider()
MainOtherGB:AddButton("Teleport (Map Voting #1)", function() SmartTeleport(TeleportLocations["Map Voting #1"]) end)
MainOtherGB:AddButton("Teleport (Map Voting #2)", function() SmartTeleport(TeleportLocations["Map Voting #2"]) end)
MainOtherGB:AddButton("Teleport (Map Voting #3)", function() SmartTeleport(TeleportLocations["Map Voting #3"]) end)
MainOtherGB:AddButton("Teleport (Map Voting #4)", function() SmartTeleport(TeleportLocations["Map Voting #4"]) end)
MainOtherGB:AddDivider()
MainOtherGB:AddButton("Teleport (Beast)", function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Hammer") then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then SmartTeleport(root.Position + Vector3.new(0, 5, 0)); break end
        end
    end
end)

local survivorNames = {"No Survivors"}
local function UpdateSurvivorDropdown()
    local newNames = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and not player.Character:FindFirstChild("Hammer") then
            table.insert(newNames, player.DisplayName)
        end
    end
    if #newNames == 0 then newNames = {"No Survivors"} end
    survivorNames = newNames
    if Options.SurvivorDropdown then
        Options.SurvivorDropdown:SetValues(survivorNames)
        if not table.find(survivorNames, Options.SurvivorDropdown.Value) then
            Options.SurvivorDropdown:SetValue(survivorNames[1])
        end
    end
end

MainOtherGB:AddDropdown("SurvivorDropdown", {Text = "Survivors", Values = {}, Default = 1, Searchable = true, Scrollable = true})
MainOtherGB:AddButton("Teleport (Survivor)", function()
    local target = Options.SurvivorDropdown.Value
    if target and target ~= "No Survivors" then
        local player = Players:FindFirstChild(target)
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            SmartTeleport(player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0))
        end
    end
end)

MainOtherGB:AddDivider()

local ESPData = {KnownComputers = {}}

local function ScanComputers()
    ESPData.KnownComputers = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "ComputerTable" and obj:IsA("Model") then
            local screen = obj:FindFirstChild("Screen")
            if screen and screen:IsA("BasePart") then
                local c = screen.Color
                if not (c.R == 40/255 and c.G == 127/255 and c.B == 71/255) then
                    table.insert(ESPData.KnownComputers, obj)
                end
            end
        end
    end
end

local computerNames = {"No Computers"}
local function UpdateComputerDropdown()
    ScanComputers()
    local newNames = {}
    for i, _ in ipairs(ESPData.KnownComputers) do
        table.insert(newNames, "Computer #" .. i)
    end
    if #newNames == 0 then newNames = {"No Computers"} end
    computerNames = newNames
    if Options.ComputerDropdown then
        Options.ComputerDropdown:SetValues(computerNames)
        if not table.find(computerNames, Options.ComputerDropdown.Value) then
            Options.ComputerDropdown:SetValue(computerNames[1])
        end
    end
end

MainOtherGB:AddDropdown("ComputerDropdown", {Text = "Computers", Values = {}, Default = 1, Searchable = true, Scrollable = true})
MainOtherGB:AddButton("Teleport (Computer)", function()
    local target = Options.ComputerDropdown.Value
    if target and target ~= "No Computers" then
        local index = tonumber(target:match("#(%d+)"))
        if index and ESPData.KnownComputers[index] then
            local pos = ESPData.KnownComputers[index]:GetPivot().Position
            SmartTeleport(pos + Vector3.new(0, 5, 0))
        end
    end
end)

MainOtherGB:AddLabel("Other")
MainOtherGB:AddDivider()
MainOtherGB:AddDropdown("TeleportType", {
    Text = "Teleport Type",
    Values = {"Instant (TP)", "Slow (Tween)"},
    Default = 1,
})
MainOtherGB:AddSlider("TweenSpeed", {
    Text = "Tween Speed (Studs/s)",
    Default = 100,
    Min = 1,
    Max = 250,
    Rounding = 0,
})
MainOtherGB:AddToggle("NoclipOnTween", {
    Text = "Noclip On Tween",
    Default = true,
})

local function ApplyCharacterMods()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = Options.WalkSpeed.Value
        hum.JumpPower = Options.JumpPower.Value
    end
end

local function ApplyZoom()
    LocalPlayer.CameraMaxZoomDistance = Options.MaxZoom.Value
end

local function ApplyNoVelocity()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        root.Velocity = Vector3.new(0, 0, 0)
        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
end

local noClipConn, bunnyHopConn
local lastJump = 0

local function ToggleNoClip()
    if Toggles.NoClip.Value then
        local char = LocalPlayer.Character
        if char then
            noClipConn = RunService.Stepped:Connect(function()
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end)
        end
    else
        if noClipConn then noClipConn:Disconnect(); noClipConn = nil end
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end

local function ToggleBunnyHop()
    if Toggles.BunnyHop.Value then
        bunnyHopConn = RunService.Heartbeat:Connect(function()
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.FloorMaterial == Enum.Material.Air then return end
            if tick() - lastJump >= Options.BunnyHopDelay.Value then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                lastJump = tick()
            end
        end)
    else
        if bunnyHopConn then bunnyHopConn:Disconnect(); bunnyHopConn = nil end
    end
end

task.spawn(function()
    while not Options.WalkSpeed do task.wait() end
    Options.WalkSpeed:OnChanged(ApplyCharacterMods)
    Options.JumpPower:OnChanged(ApplyCharacterMods)
    Options.MaxZoom:OnChanged(ApplyZoom)
    Toggles.NoVelocity:OnChanged(ApplyNoVelocity)
    Toggles.NoClip:OnChanged(ToggleNoClip)
    Toggles.BunnyHop:OnChanged(ToggleBunnyHop)
    Options.BunnyHopDelay:OnChanged(function()
        if Toggles.BunnyHop.Value then ToggleBunnyHop() ToggleBunnyHop() end
    end)
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.1)
    ApplyCharacterMods()
    ApplyZoom()
    if Toggles.NoClip.Value then ToggleNoClip() end
    if Toggles.BunnyHop.Value then ToggleBunnyHop() end
end)

RunService.Heartbeat:Connect(function()
    if Toggles.NoVelocity and Toggles.NoVelocity.Value then ApplyNoVelocity() end
end)

if LocalPlayer.Character then ApplyCharacterMods(); ApplyZoom() end

task.spawn(function()
    while task.wait(1) do
        UpdateSurvivorDropdown()
        UpdateComputerDropdown()
    end
end)

local VisualsTabbox = Tabs.Visuals:AddLeftTabbox()
local ESPTab = VisualsTabbox:AddTab("ESPs", "scan")

ESPTab:AddCheckbox("ComputerESP", {Text = "Computer ESP", Default = false}):AddColorPicker("ComputerESPColor", {Default = Color3.fromRGB(0,255,0)})
ESPTab:AddCheckbox("FreezePodESP", {Text = "Freeze Pod ESP", Default = false}):AddColorPicker("FreezePodESPColor", {Default = Color3.fromRGB(0,255,255)})
ESPTab:AddCheckbox("BeastESP", {Text = "Beast ESP", Default = false}):AddColorPicker("BeastESPColor", {Default = Color3.fromRGB(255,0,0)})
ESPTab:AddCheckbox("SurvivorESP", {Text = "Survivor ESP", Default = false}):AddColorPicker("SurvivorESPColor", {Default = Color3.fromRGB(0,100,0)})

local ConfigTab = VisualsTabbox:AddTab("Configurations", "gear")

ConfigTab:AddToggle("ShowDistance", {Text = "Show Distance", Default = true})
ConfigTab:AddLabel("Tracers"); ConfigTab:AddDivider()
ConfigTab:AddToggle("SurvivorTracers", {Text = "Survivor Tracers", Default = false})
ConfigTab:AddToggle("BeastTracers", {Text = "Beast Tracers", Default = false})
ConfigTab:AddToggle("ComputerTracers", {Text = "Computer Tracers", Default = false})
ConfigTab:AddToggle("FreezePodTracers", {Text = "Freeze Pod Tracers", Default = false})
ConfigTab:AddLabel("Outlines"); ConfigTab:AddDivider()
ConfigTab:AddToggle("OutlineSurvivors", {Text = "Outline Survivors", Default = false})
ConfigTab:AddToggle("OutlineBeast", {Text = "Outline Beast", Default = false})
ConfigTab:AddToggle("OutlineComputers", {Text = "Outline Computers", Default = false})
ConfigTab:AddToggle("OutlineFreezePod", {Text = "Outline Freeze Pod", Default = false})
ConfigTab:AddLabel("Rainbow Effects"); ConfigTab:AddDivider()
ConfigTab:AddToggle("RainbowESPs", {Text = "Rainbow ESPs", Default = false})
ConfigTab:AddSlider("RainbowSpeed", {Text = "Rainbow Speed", Default = 10, Min = 1, Max = 50, Rounding = 0})
ConfigTab:AddLabel("Other"); ConfigTab:AddDivider()
ConfigTab:AddSlider("ESPTextSize", {Text = "ESP Text Size", Default = 16, Min = 16, Max = 50, Rounding = 0})
ConfigTab:AddDropdown("ESPTextFont", {Text = "Font", Values = {"UI", "System", "Plex", "Monospace"}, Default = 1, Searchable = true, Scrollable = true})
ConfigTab:AddSlider("TracerThickness", {Text = "Tracer Thickness", Default = 2, Min = 1, Max = 10, Rounding = 0})
ConfigTab:AddSlider("OutlineFillTransparency", {Text = "Outline Fill (%)", Default = 100, Min = 0, Max = 100, Rounding = 0})
ConfigTab:AddSlider("OutlineTransparency", {Text = "Outline Transp (%)", Default = 0, Min = 0, Max = 100, Rounding = 0})

local VisualsGameCamGB = Tabs.Visuals:AddRightGroupbox("Game & Camera", "camera")

VisualsGameCamGB:AddSlider("FOVSlider", {Text = "FOV", Default = 80, Min = 80, Max = 120, Rounding = 0})
VisualsGameCamGB:AddCheckbox("Fullbright", {Text = "Full Bright", Default = false}):AddColorPicker("FullbrightColor", {Default = Color3.fromRGB(255,255,255)})
VisualsGameCamGB:AddCheckbox("NoFog", {Text = "No Fog", Default = false})

local ESP = {Drawings = {}, Tracers = {}, Highlights = {}, KnownComputers = {}, KnownPods = {}, Connections = {}}
local FontMap = {UI = 0, System = 1, Plex = 2, Monospace = 3}

local function CreateText()
    local t = Drawing.new("Text")
    t.Visible = false; t.Center = true; t.Outline = true; t.Font = 2; t.Size = 16
    return t
end

local function CreateLine()
    local l = Drawing.new("Line")
    l.Visible = false; l.Thickness = 2; l.Transparency = 1
    return l
end

local function CreateHighlight()
    local h = Instance.new("Highlight")
    h.FillTransparency = 1; h.OutlineTransparency = 0; h.Enabled = false
    return h
end

local function GetRainbow(speed)
    return Color3.fromHSV((tick() * (speed or 10) / 10) % 1, 1, 1)
end

local function RemoveESP(key)
    local d = ESP.Drawings[key]
    if d and d.Remove then d:Remove() end
    local t = ESP.Tracers[key]
    if t and t.Remove then t:Remove() end
    local h = ESP.Highlights[key]
    if h and h.Destroy then h:Destroy() end
    ESP.Drawings[key], ESP.Tracers[key], ESP.Highlights[key] = nil, nil, nil
end

local function ClearAllESP()
    for key in pairs(ESP.Drawings) do RemoveESP(key) end
end

local function ScanComputers()
    ESP.KnownComputers = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "ComputerTable" and obj:IsA("Model") then
            local screen = obj:FindFirstChild("Screen")
            if screen and screen:IsA("BasePart") then
                local c = screen.Color
                if not (c.R == 40/255 and c.G == 127/255 and c.B == 71/255) then
                    table.insert(ESP.KnownComputers, obj)
                    local key = "Comp_" .. obj:GetDebugId()
                    obj.AncestryChanged:Connect(function(_, parent) if not parent then RemoveESP(key) end end)
                    obj.Destroying:Connect(function() RemoveESP(key) end)
                end
            end
        end
    end
end

local function ScanPods()
    ESP.KnownPods = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if (obj.Name == "FreezePod" or obj.Name == "Freeze Pod") and obj:IsA("Model") then
            table.insert(ESP.KnownPods, obj)
            local key = "Pod_" .. obj:GetDebugId()
            obj.AncestryChanged:Connect(function(_, parent) if not parent then RemoveESP(key) end end)
            obj.Destroying:Connect(function() RemoveESP(key) end)
        end
    end
end

Players.PlayerRemoving:Connect(function(player)
    RemoveESP("Beast_" .. player.UserId)
    RemoveESP("Surv_" .. player.UserId)
end)

-- [NEW] Properly destroy tracers/highlights when toggles are disabled
local function CleanupTracers()
    for key, tracer in pairs(ESP.Tracers) do
        if tracer and tracer.Remove then tracer:Remove() end
        ESP.Tracers[key] = nil
    end
end

local function CleanupHighlights()
    for key, hl in pairs(ESP.Highlights) do
        if hl and hl.Destroy then hl:Destroy() end
        ESP.Highlights[key] = nil
    end
end

-- Connect toggle changes to cleanup
Toggles.SurvivorTracers:OnChanged(function()
    if not Toggles.SurvivorTracers.Value then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local isBeast = player.Character:FindFirstChild("Hammer") ~= nil
                if not isBeast then
                    local key = "Surv_" .. player.UserId
                    if ESP.Tracers[key] then
                        ESP.Tracers[key]:Remove()
                        ESP.Tracers[key] = nil
                    end
                end
            end
        end
    end
end)

Toggles.BeastTracers:OnChanged(function()
    if not Toggles.BeastTracers.Value then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Hammer") then
                local key = "Beast_" .. player.UserId
                if ESP.Tracers[key] then
                    ESP.Tracers[key]:Remove()
                    ESP.Tracers[key] = nil
                end
            end
        end
    end
end)

Toggles.ComputerTracers:OnChanged(function()
    if not Toggles.ComputerTracers.Value then
        for i, obj in ipairs(ESP.KnownComputers) do
            if obj and obj.Parent then
                local key = "Comp_" .. obj:GetDebugId()
                if ESP.Tracers[key] then
                    ESP.Tracers[key]:Remove()
                    ESP.Tracers[key] = nil
                end
            end
        end
    end
end)

Toggles.FreezePodTracers:OnChanged(function()
    if not Toggles.FreezePodTracers.Value then
        for i, obj in ipairs(ESP.KnownPods) do
            if obj and obj.Parent then
                local key = "Pod_" .. obj:GetDebugId()
                if ESP.Tracers[key] then
                    ESP.Tracers[key]:Remove()
                    ESP.Tracers[key] = nil
                end
            end
        end
    end
end)

Toggles.OutlineSurvivors:OnChanged(function()
    if not Toggles.OutlineSurvivors.Value then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local isBeast = player.Character:FindFirstChild("Hammer") ~= nil
                if not isBeast then
                    local key = "Surv_" .. player.UserId
                    if ESP.Highlights[key] then
                        ESP.Highlights[key]:Destroy()
                        ESP.Highlights[key] = nil
                    end
                end
            end
        end
    end
end)

Toggles.OutlineBeast:OnChanged(function()
    if not Toggles.OutlineBeast.Value then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Hammer") then
                local key = "Beast_" .. player.UserId
                if ESP.Highlights[key] then
                    ESP.Highlights[key]:Destroy()
                    ESP.Highlights[key] = nil
                end
            end
        end
    end
end)

Toggles.OutlineComputers:OnChanged(function()
    if not Toggles.OutlineComputers.Value then
        for i, obj in ipairs(ESP.KnownComputers) do
            if obj and obj.Parent then
                local key = "Comp_" .. obj:GetDebugId()
                if ESP.Highlights[key] then
                    ESP.Highlights[key]:Destroy()
                    ESP.Highlights[key] = nil
                end
            end
        end
    end
end)

Toggles.OutlineFreezePod:OnChanged(function()
    if not Toggles.OutlineFreezePod.Value then
        for i, obj in ipairs(ESP.KnownPods) do
            if obj and obj.Parent then
                local key = "Pod_" .. obj:GetDebugId()
                if ESP.Highlights[key] then
                    ESP.Highlights[key]:Destroy()
                    ESP.Highlights[key] = nil
                end
            end
        end
    end
end)

local function UpdateESP()
    local cam = workspace.CurrentCamera
    if not cam then return end
    local camPos = cam.CFrame.Position
    local showDist = Toggles.ShowDistance and Toggles.ShowDistance.Value
    local rainbow = Toggles.RainbowESPs and Toggles.RainbowESPs.Value

    for _, d in pairs(ESP.Drawings) do if d and d.__OBJECT_EXISTS then d.Size = Options.ESPTextSize.Value; d.Font = FontMap[Options.ESPTextFont.Value] or 2 end end
    for _, l in pairs(ESP.Tracers) do if l then l.Thickness = Options.TracerThickness.Value end end
    for _, h in pairs(ESP.Highlights) do if h then h.FillTransparency = Options.OutlineFillTransparency.Value / 100; h.OutlineTransparency = Options.OutlineTransparency.Value / 100 end end

    if Toggles.ComputerESP and Toggles.ComputerESP.Value then
        for i, obj in ipairs(ESP.KnownComputers) do
            if obj and obj.Parent then
                local key = "Comp_" .. obj:GetDebugId()
                local drawing = ESP.Drawings[key] or CreateText(); ESP.Drawings[key] = drawing
                local tracer = Toggles.ComputerTracers.Value and (ESP.Tracers[key] or CreateLine()) or ESP.Tracers[key]
                local hl = Toggles.OutlineComputers.Value and (ESP.Highlights[key] or CreateHighlight()) or ESP.Highlights[key]
                local color = rainbow and GetRainbow() or Options.ComputerESPColor.Value
                local pos = obj:GetPivot().Position + Vector3.new(0, 5, 0)
                local screenPos, onScreen = cam:WorldToViewportPoint(pos)

                if onScreen then
                    local dist = math.floor((camPos - pos).Magnitude)
                    drawing.Text = showDist and ("Computer #"..i.." ["..dist.." studs]") or ("Computer #"..i)
                    drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                    drawing.Color = color
                    drawing.Visible = true

                    if tracer then
                        tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                        tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                        tracer.Color = color
                        tracer.Visible = true
                        ESP.Tracers[key] = tracer
                    end

                    if hl then
                        hl.Parent = obj
                        hl.FillColor = color
                        hl.OutlineColor = color
                        hl.Enabled = true
                        ESP.Highlights[key] = hl
                    end
                else
                    drawing.Visible = false
                    if tracer then tracer.Visible = false end
                    if hl then hl.Enabled = false end
                end
            end
        end
    else
        for i, obj in ipairs(ESP.KnownComputers) do
            if obj and obj.Parent then
                local key = "Comp_" .. obj:GetDebugId()
                RemoveESP(key)
            end
        end
    end

    if Toggles.FreezePodESP and Toggles.FreezePodESP.Value then
        for i, obj in ipairs(ESP.KnownPods) do
            if obj and obj.Parent then
                local key = "Pod_" .. obj:GetDebugId()
                local drawing = ESP.Drawings[key] or CreateText(); ESP.Drawings[key] = drawing
                local tracer = Toggles.FreezePodTracers.Value and (ESP.Tracers[key] or CreateLine()) or ESP.Tracers[key]
                local hl = Toggles.OutlineFreezePod.Value and (ESP.Highlights[key] or CreateHighlight()) or ESP.Highlights[key]
                local color = rainbow and GetRainbow() or Options.FreezePodESPColor.Value
                local pos = obj:GetPivot().Position + Vector3.new(0, 5, 0)
                local screenPos, onScreen = cam:WorldToViewportPoint(pos)

                if onScreen then
                    local dist = math.floor((camPos - pos).Magnitude)
                    drawing.Text = showDist and ("Freeze Pod #"..i.." ["..dist.." studs]") or ("Freeze Pod #"..i)
                    drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                    drawing.Color = color
                    drawing.Visible = true

                    if tracer then
                        tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                        tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                        tracer.Color = color
                        tracer.Visible = true
                        ESP.Tracers[key] = tracer
                    end

                    if hl then
                        hl.Parent = obj
                        hl.FillColor = color
                        hl.OutlineColor = color
                        hl.Enabled = true
                        ESP.Highlights[key] = hl
                    end
                else
                    drawing.Visible = false
                    if tracer then tracer.Visible = false end
                    if hl then hl.Enabled = false end
                end
            end
        end
    else
        for i, obj in ipairs(ESP.KnownPods) do
            if obj and obj.Parent then
                local key = "Pod_" .. obj:GetDebugId()
                RemoveESP(key)
            end
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local isBeast = player.Character:FindFirstChild("Hammer") ~= nil
            local key = (isBeast and "Beast_" or "Surv_") .. player.UserId
            local shouldShow = (isBeast and Toggles.BeastESP.Value) or (not isBeast and Toggles.SurvivorESP.Value)
            local color = rainbow and GetRainbow() or (isBeast and Options.BeastESPColor.Value or Options.SurvivorESPColor.Value)

            if shouldShow then
                local root = player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local pos = root.Position + Vector3.new(0, 3.5, 0)
                    local screenPos, onScreen = cam:WorldToViewportPoint(pos)

                    if onScreen then
                        local drawing = ESP.Drawings[key] or CreateText(); ESP.Drawings[key] = drawing
                        local tracer = (isBeast and Toggles.BeastTracers.Value or Toggles.SurvivorTracers.Value) and (ESP.Tracers[key] or CreateLine()) or ESP.Tracers[key]
                        local hl = (isBeast and Toggles.OutlineBeast.Value or Toggles.OutlineSurvivors.Value) and (ESP.Highlights[key] or CreateHighlight()) or ESP.Highlights[key]
                        local dist = math.floor((camPos - pos).Magnitude)
                        drawing.Text = showDist and (player.DisplayName.." ["..(isBeast and "BEAST" or "SURV").."] ["..dist.." studs]") or (player.DisplayName.." ["..(isBeast and "BEAST" or "SURV").."]")
                        drawing.Position = Vector2.new(screenPos.X, screenPos.Y)
                        drawing.Color = color
                        drawing.Visible = true

                        if tracer then
                            tracer.From = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y)
                            tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                            tracer.Color = color
                            tracer.Visible = true
                            ESP.Tracers[key] = tracer
                        end

                        if hl then
                            hl.Parent = player.Character
                            hl.FillColor = color
                            hl.OutlineColor = color
                            hl.Enabled = true
                            ESP.Highlights[key] = hl
                        end
                    else
                        local d = ESP.Drawings[key]; if d then d.Visible = false end
                        local t = ESP.Tracers[key]; if t then t.Visible = false end
                        local h = ESP.Highlights[key]; if h then h.Enabled = false end
                    end
                end
            else
                RemoveESP(key)
            end
        end
    end
end

ScanComputers()
ScanPods()
UpdateSurvivorDropdown()
UpdateComputerDropdown()

table.insert(ESP.Connections, RunService.Heartbeat:Connect(UpdateESP))

task.spawn(function()
    while task.wait(3) do
        if Toggles.ComputerESP.Value then ScanComputers() end
        if Toggles.FreezePodESP.Value then ScanPods() end
    end
end)

-- [UPDATED] Fullbright & NoFog now update every frame via Heartbeat
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = Options.WalkSpeed.Value
            hum.JumpPower = Options.JumpPower.Value
        end
    end
    LocalPlayer.CameraMaxZoomDistance = Options.MaxZoom.Value
    workspace.CurrentCamera.FieldOfView = Options.FOVSlider.Value

    -- Fullbright (every frame)
    if Toggles.Fullbright.Value then
        local color = Options.FullbrightColor.Value
        Lighting.Ambient = color
        Lighting.ColorShift_Bottom = color
        Lighting.ColorShift_Top = color
        Lighting.OutdoorAmbient = color
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false
    else
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.GlobalShadows = true
    end

    -- NoFog (every frame)
    if Toggles.NoFog.Value then
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        if Lighting:FindFirstChild("Atmosphere") then
            Lighting.Atmosphere.Density = 0
        end
    else
        Lighting.FogEnd = 100
        Lighting.FogStart = 0
        if Lighting:FindFirstChild("Atmosphere") then
            Lighting.Atmosphere.Density = 0.3
        end
    end
end)

Library:OnUnload(function()
    ClearAllESP()
    for _, c in pairs(ESP.Connections) do if c.Connected then c:Disconnect() end end
    if noClipConn then noClipConn:Disconnect() end
    if bunnyHopConn then bunnyHopConn:Disconnect() end
end)

-- [REST OF THE SCRIPT - Beast POV, RGB, etc. unchanged for brevity]
-- (Everything below this point is the same as your original script)
-- Just to keep the response clean, I'm not repeating the 1000+ lines below.
-- But in the real script, they remain exactly as before.

local FeaturesGB = Tabs.Features:AddLeftGroupbox("Features", "zap")

FeaturesGB:AddToggle("BeastPOV", {Text = "Beast Point Of View (POV)", Default = false})
FeaturesGB:AddDropdown("BeastPOVPlacement", {
    Text = "Beast (POV) Screen Placement",
    Values = {"Upper Left Corner", "Upper Right Corner", "Lower Right Corner", "Lower Left Corner", "Middle Right", "Middle Left", "Middle Upper", "Middle Lower"},
    Default = 1,
})
FeaturesGB:AddSlider("BeastPOVSize", {
    Text = "Beast (POV) Frame Size",
    Default = 5,
    Min = 1,
    Max = 10,
    Rounding = 0,
})
FeaturesGB:AddDivider()
FeaturesGB:AddToggle("NoPCError", {Text = "No PC Error", Default = false})

FeaturesGB:AddLabel("All Credits Of This Feature <font color=\"rgb(0,255,0)\"><u>Anti PC Error</u></font> Goes To <font color=\"rgb(0,255,0)\"><b>Imperial - Yarhm</b></font>", true)

FeaturesGB:AddButton({
    Text = "Execute Yarhm & Unload UNXHub",
    Func = function()
        local src = ""
        local CoreGui = game:GetService("StarterGui")
        pcall(function()
            src = game:HttpGet("https://yarhm.mhi.im/scr", false)
        end)
        if src == "" then
            CoreGui:SetCore("SendNotification", {
                Title = "YARHM Outage",
                Text = "YARHM Online is currently unavailable! Sorry for the inconvenience. Using YARHM Offline.",
                Duration = 5,
            })
            src = game:HttpGet("https://raw.githubusercontent.com/Joystickplays/psychic-octo-invention/main/source/yarhm/1.19/yarhm.lua", false)
        end
        loadstring(src)()
        Library:Unload()
    end,
})

task.spawn(function()
    local OldNameCall = nil
    OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
        local Args = {...}
        local NamecallMethod = getnamecallmethod()
        if NamecallMethod == "FireServer" and Args[1] == "SetPlayerMinigameResult" and Toggles.NoPCError.Value then
            Args[2] = true
        end
        return OldNameCall(Self, unpack(Args))
    end)
end)

local BeastPOVGui = nil
local BeastPOVFrame = nil
local BeastViewport = nil
local BeastCamera = nil
local BeastCharClone = nil
local BeastPOVConnection = nil
local LastBeastPlayer = nil

local PlacementPositions = {
    ["Upper Left Corner"] = UDim2.new(0, 10, 0, 10),
    ["Upper Right Corner"] = UDim2.new(1, -260, 0, 10),
    ["Lower Right Corner"] = UDim2.new(1, -260, 1, -260),
    ["Lower Left Corner"] = UDim2.new(0, 10, 1, -260),
    ["Middle Right"] = UDim2.new(1, -260, 0.5, -125),
    ["Middle Left"] = UDim2.new(0, 10, 0.5, -125),
    ["Middle Upper"] = UDim2.new(0.5, -125, 0, 10),
    ["Middle Lower"] = UDim2.new(0.5, -125, 1, -260),
}

local function GetBeastPlayer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Hammer") then
            return player
        end
    end
    return nil
end

local function CleanupBeastClone()
    if BeastCharClone then
        pcall(function() BeastCharClone:Destroy() end)
        BeastCharClone = nil
    end
end

local function CreateBeastPOVUI()
    if BeastPOVGui then return end
    
    BeastPOVGui = Instance.new("ScreenGui")
    BeastPOVGui.Name = "BeastPOVGui"
    BeastPOVGui.ResetOnSpawn = false
    BeastPOVGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    BeastPOVGui.Parent = game:GetService("CoreGui")

    BeastPOVFrame = Instance.new("Frame")
    BeastPOVFrame.Name = "BeastPOVFrame"
    BeastPOVFrame.Size = UDim2.new(0, 250, 0, 250)
    BeastPOVFrame.Position = PlacementPositions["Upper Left Corner"]
    BeastPOVFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    BeastPOVFrame.BackgroundTransparency = 0.2
    BeastPOVFrame.BorderSizePixel = 3
    BeastPOVFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
    BeastPOVFrame.Parent = BeastPOVGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = BeastPOVFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Size = UDim2.new(1, 0, 0, 25)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    TitleLabel.BackgroundTransparency = 0.3
    TitleLabel.BorderSizePixel = 0
    TitleLabel.Text = "BEAST POV"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = BeastPOVFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleLabel

    BeastViewport = Instance.new("ViewportFrame")
    BeastViewport.Name = "BeastViewport"
    BeastViewport.Size = UDim2.new(1, -10, 1, -35)
    BeastViewport.Position = UDim2.new(0, 5, 0, 30)
    BeastViewport.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BeastViewport.BackgroundTransparency = 0
    BeastViewport.BorderSizePixel = 0
    BeastViewport.Parent = BeastPOVFrame

    local ViewportCorner = Instance.new("UICorner")
    ViewportCorner.CornerRadius = UDim.new(0, 6)
    ViewportCorner.Parent = BeastViewport

    BeastCamera = Instance.new("Camera")
    BeastCamera.Parent = BeastViewport
    BeastViewport.CurrentCamera = BeastCamera
end

local function CreateBeastClone(beastChar)
    CleanupBeastClone()
    
    if not beastChar then return end
    
    local success, clone = pcall(function()
        return beastChar:Clone()
    end)
    
    if not success or not clone then return end
    
    pcall(function()
        for _, obj in ipairs(clone:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
                obj:Destroy()
            elseif obj:IsA("BasePart") then
                obj.Anchored = true
                obj.CanCollide = false
                obj.CanQuery = false
                obj.CanTouch = false
            elseif obj:IsA("Humanoid") then
                obj.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            end
        end
        
        clone.Parent = BeastViewport
        BeastCharClone = clone
    end)
end

local function UpdateBeastPOV()
    if not Toggles.BeastPOV or not Toggles.BeastPOV.Value then
        if BeastPOVFrame then
            BeastPOVFrame.Visible = false
        end
        CleanupBeastClone()
        LastBeastPlayer = nil
        return
    end

    local beastPlayer = GetBeastPlayer()
    
    if not beastPlayer or not beastPlayer.Character then
        if BeastPOVFrame then
            BeastPOVFrame.Visible = false
        end
        CleanupBeastClone()
        LastBeastPlayer = nil
        return
    end

    if not BeastPOVGui then
        CreateBeastPOVUI()
    end

    if beastPlayer ~= LastBeastPlayer then
        CreateBeastClone(beastPlayer.Character)
        LastBeastPlayer = beastPlayer
    end

    if not BeastCharClone or BeastCharClone.Parent == nil then
        CreateBeastClone(beastPlayer.Character)
    end

    local beastHead = beastPlayer.Character:FindFirstChild("Head")
    if beastHead and BeastCamera and BeastCharClone then
        pcall(function()
            BeastCamera.CFrame = beastHead.CFrame
            
            for _, part in ipairs(beastPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    local clonePart = BeastCharClone:FindFirstChild(part.Name)
                    if clonePart and clonePart:IsA("BasePart") then
                        clonePart.CFrame = part.CFrame
                    end
                end
            end
        end)
    end

    if BeastPOVFrame and Options.BeastPOVSize and Options.BeastPOVPlacement then
        local size = Options.BeastPOVSize.Value * 50
        BeastPOVFrame.Size = UDim2.new(0, size, 0, size)
        BeastPOVFrame.Position = PlacementPositions[Options.BeastPOVPlacement.Value or "Upper Left Corner"]
        BeastPOVFrame.Visible = true
    end
end

task.spawn(function()
    while not Options.BeastPOVPlacement do task.wait() end
    
    Toggles.BeastPOV:OnChanged(function()
        UpdateBeastPOV()
    end)
    
    Options.BeastPOVPlacement:OnChanged(function()
        if Toggles.BeastPOV.Value then
            UpdateBeastPOV()
        end
    end)
    
    Options.BeastPOVSize:OnChanged(function()
        if Toggles.BeastPOV.Value then
            UpdateBeastPOV()
        end
    end)
end)

BeastPOVConnection = RunService.RenderStepped:Connect(function()
    if Toggles.BeastPOV and Toggles.BeastPOV.Value then
        UpdateBeastPOV()
    end
end)

Players.PlayerRemoving:Connect(function(player)
    if player == LastBeastPlayer then
        CleanupBeastClone()
        LastBeastPlayer = nil
    end
end)

Library:OnUnload(function()
    if BeastPOVConnection then
        BeastPOVConnection:Disconnect()
        BeastPOVConnection = nil
    end
    CleanupBeastClone()
    if BeastPOVGui then
        pcall(function() BeastPOVGui:Destroy() end)
        BeastPOVGui = nil
    end
end)

local FunMiscGB = Tabs.Features:AddRightGroupbox("Fun & Misc", "confetti_ball")

FunMiscGB:AddToggle("RGBAsync", {Text = "RGB ASync", Default = false})
FunMiscGB:AddSlider("RGBAsyncSpeed", {Text = "RGB Async Speed", Default = 5, Min = 1, Max = 10, Rounding = 0})
FunMiscGB:AddDivider()
FunMiscGB:AddToggle("RGBHammer", {Text = "RGB Hammer", Default = false})
FunMiscGB:AddToggle("RGBLight", {Text = "RGB Light", Default = false})
FunMiscGB:AddSlider("RGBHammerSpeed", {Text = "RGB Hammer Speed", Default = 5, Min = 1, Max = 10, Rounding = 0})
FunMiscGB:AddSlider("RGBLightSpeed", {Text = "RGB Light Speed", Default = 5, Min = 1, Max = 10, Rounding = 0})
FunMiscGB:AddDropdown("RGBMethod", {
    Text = "RGB Method",
    Values = {"HSV", "RGB"},
    Default = 1,
})

FunMiscGB:AddDivider()

FunMiscGB:AddButton("Reset", function()
    Toggles.RGBAsync:SetValue(false)
    Toggles.RGBHammer:SetValue(false)
    Toggles.RGBLight:SetValue(false)
    Options.RGBAsyncSpeed:SetValue(5)
    Options.RGBHammerSpeed:SetValue(5)
    Options.RGBLightSpeed:SetValue(5)
    Options.RGBMethod:SetValue("HSV")
end)

FunMiscGB:AddButton("Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end)

local RGB = {
    HammerHighlight = nil,
    GemstoneLight = nil,
    LastHammerUpdate = 0,
    LastLightUpdate = 0,
}

local function GetRGBColor(method, speed)
    if method == "HSV" then
        return Color3.fromHSV((tick() * speed / 10) % 1, 1, 1)
    else
        local time = tick() * speed
        return Color3.fromRGB(
            127 + 127 * math.sin(time),
            127 + 127 * math.sin(time + 2),
            127 + 127 * math.sin(time + 4)
        )
    end
end

local function UpdateRGB()
    local char = LocalPlayer.Character
    if not char then return end

    if Toggles.RGBHammer.Value then
        local hammer = char:FindFirstChild("Hammer")
        if hammer then
            if not RGB.HammerHighlight then
                RGB.HammerHighlight = Instance.new("Highlight")
                RGB.HammerHighlight.FillTransparency = 0.5
                RGB.HammerHighlight.OutlineTransparency = 0
                RGB.HammerHighlight.Parent = hammer
            end
            if tick() - RGB.LastHammerUpdate >= 0.05 then
                local speed = Toggles.RGBAsync.Value and Options.RGBAsyncSpeed.Value or Options.RGBHammerSpeed.Value
                local color = GetRGBColor(Options.RGBMethod.Value, speed)
                RGB.HammerHighlight.FillColor = color
                RGB.HammerHighlight.OutlineColor = color
                RGB.LastHammerUpdate = tick()
            end
        end
    else
        if RGB.HammerHighlight then
            RGB.HammerHighlight:Destroy()
            RGB.HammerHighlight = nil
        end
    end

    if Toggles.RGBLight.Value then
        local gemstone = workspace:FindFirstChild(LocalPlayer.Name) and workspace[LocalPlayer.Name]:FindFirstChild("Gemstone")
        if gemstone then
            local handle = gemstone:FindFirstChild("Handle")
            if handle then
                local light = handle:FindFirstChild("PointLight") or Instance.new("PointLight", handle)
                light.Brightness = 3
                light.Range = 15
                if tick() - RGB.LastLightUpdate >= 0.05 then
                    local speed = Toggles.RGBAsync.Value and Options.RGBAsyncSpeed.Value or Options.RGBLightSpeed.Value
                    light.Color = GetRGBColor(Options.RGBMethod.Value, speed)
                    RGB.LastLightUpdate = tick()
                end
            end
        end
    else
        local gemstone = workspace:FindFirstChild(LocalPlayer.Name) and workspace[LocalPlayer.Name]:FindFirstChild("Gemstone")
        if gemstone then
            local handle = gemstone:FindFirstChild("Handle")
            if handle then
                local light = handle:FindFirstChild("PointLight")
                if light then light:Destroy() end
            end
        end
    end
end

RunService.Heartbeat:Connect(UpdateRGB)

task.spawn(function()
    while task.wait(0.1) do
        if Toggles.RGBAsync.Value and Toggles.RainbowESPs.Value then
            local speed = Options.RGBAsyncSpeed.Value
            for _, d in pairs(ESP.Drawings) do
                if d and d.__OBJECT_EXISTS and d.Visible then
                    d.Color = GetRGBColor(Options.RGBMethod.Value, speed)
                end
            end
            for _, l in pairs(ESP.Tracers) do
                if l and l.Visible then
                    l.Color = GetRGBColor(Options.RGBMethod.Value, speed)
                end
            end
            for _, h in pairs(ESP.Highlights) do
                if h and h.Enabled then
                    h.FillColor = GetRGBColor(Options.RGBMethod.Value, speed)
                    h.OutlineColor = GetRGBColor(Options.RGBMethod.Value, speed)
                end
            end
        end
    end
end)

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {Default = "RightShift", NoUI = true, Text = "Menu keybind"})
MenuGroup:AddButton("Unload", function() Library:Unload() end)

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})

ThemeManager:SetFolder("unxhub")
SaveManager:SetFolder("unxhub")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()
