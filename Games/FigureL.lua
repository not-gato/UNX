local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- Updated Assets detection to use CurrentRooms instead of Map
local function FindAssetsFolder()
    local currentRooms = workspace:FindFirstChild("CurrentRooms")
    if currentRooms then
        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Model") then
                local assetsFolder = room:FindFirstChild("Assets")
                if assetsFolder then
                    return assetsFolder
                end
            end
        end
    end
    
    -- Fallback to old method if CurrentRooms fails
    warn("[UNXHub] CurrentRooms not found or no Assets in rooms, trying fallback method")
    local mapFolder = workspace:FindFirstChild("Map")
    if mapFolder then
        local assetsFolder = mapFolder:FindFirstChild("Assets")
        if assetsFolder then
            warn("[UNXHub] Using fallback Assets folder from workspace.Map.Assets")
            return assetsFolder
        end
    end
    
    warn("[UNXHub] No Assets folder found in CurrentRooms or Map")
    return nil
end

local BOOKSHELF_NAME = "Super Cool Bookshelf With Hint Book"
local DOOR_CFRAME = CFrame.new(
    0.88565439, 19.2949562, -109.371742,
    -0.998881638, 0.00240474031, -0.0472193025,
    -7.93140771e-08, 0.998705626, 0.0508628227,
    0.0472804941, 0.0508059449, -0.997588754)

local BPAPER_CFRAME = CFrame.new(
    -53.6578979, 11.3413105, -21.9969749,
    0.423553586, -0.90396452, -0.0587408952,
    0.1525819, 0.00727360509, 0.988264024,
    -0.892928481, -0.427545547, 0.141009375)

local SAFE_POSITIONS = {
    CFrame.new(
        -53.4432106, 14.2561035, 40.7111435,
        0.856820285, 7.64594255e-09, -0.515615106,
        -7.48528883e-09, 1, 2.39014608e-09,
        0.515615106, 1.81160231e-09, 0.856820285
    ),
    CFrame.new(
        54.5029144, 14.2513294, 43.7026443,
        0.940911651, 1.41327362e-07, -0.338652134,
        -1.34159876e-07, 1, 4.45730777e-08,
        0.338652134, 3.49420026e-09, 0.940911651
    )
}

local State = {
    BookshelfESPActive = false,
    MultiEntityESPActive = false,
    MultiEntityTrackingActive = false,
    FullBrightActive = false,
    NoFogActive = false,
    NoclipActive = false,
    CustomWalkSpeedActive = false,
    WalkSpeedValue = 16,
    CustomFOVActive = false,
    FOVValue = 70,
    FlyActive = false,
    FlySpeed = 1,
    FlyConnection = nil,
    FlyBodyGyro = nil,
    FlyBodyVelocity = nil,
    FlyTpWalking = false,
    BreakVelocityActive = false,
    BreakVelocityConnection = nil,
    
    BookshelfESPConnection = nil,
    MultiEntityESPConnection = nil,
    MultiEntityTrackingConnection = nil,
    WalkSpeedConnection = nil,
    NoclipConnection = nil,
    FOVConnection = nil,
    PeriodicRecheckConnection = nil,
    AntiLagActive = false,
    AntiLagConnection = nil,
    
    BookshelfHighlights = {},
    BookshelfBillboards = {},
    EntityHighlights = {},
    EntityBillboards = {},
    
    BookshelfESPColor = Color3.fromRGB(170, 0, 255),
    FigureESPColor = Color3.fromRGB(255, 0, 0),
    DrakobloxxerESPColor = Color3.fromRGB(255, 165, 0),
    SCP939ESPColor = Color3.fromRGB(128, 0, 128),
    AmongUsESPColor = Color3.fromRGB(255, 0, 255),
    FullBrightColor = Color3.fromRGB(255, 255, 255),
    
    OriginalLighting = {
        Brightness = Lighting.Brightness,
        Ambient = Lighting.Ambient,
        ColorShift_Bottom = Lighting.ColorShift_Bottom,
        ColorShift_Top = Lighting.ColorShift_Top,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        ShadowSoftness = Lighting.ShadowSoftness,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart
    },
    
    OriginalFOV = 70,
    SafePositionIndex = 1,
    CurrentAssetsFolder = nil,
    LastESPUpdate = 0,
}

local function GetEntityPosition(entity)
    if entity:IsA("Model") then
        local hrp = entity:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp.Position end
        
        local torso = entity:FindFirstChild("Torso")
        if torso then return torso.Position end
        
        for _, part in ipairs(entity:GetDescendants()) do
            if part:IsA("BasePart") then
                return part.Position
            end
        end
    elseif entity:IsA("BasePart") then
        return entity.Position
    end
    return nil
end

local function GetEntityPrimaryPart(entity)
    if entity:IsA("Model") then
        if entity.PrimaryPart then return entity.PrimaryPart end
        
        local hrp = entity:FindFirstChild("HumanoidRootPart")
        if hrp then return hrp end
        
        local torso = entity:FindFirstChild("Torso")
        if torso then return torso end
        
        for _, part in ipairs(entity:GetDescendants()) do
            if part:IsA("BasePart") then
                return part
            end
        end
    elseif entity:IsA("BasePart") then
        return entity
    end
    return nil
end

local function CheckSafePositionsBlocked(entities)
    local character = LocalPlayer.Character
    if not character then return false end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local blockedCount = 0
    
    for _, safePos in ipairs(SAFE_POSITIONS) do
        local safePosVector = safePos.Position
        
        for _, entityData in pairs(entities) do
            local entityPos = GetEntityPosition(entityData.entity)
            if entityPos then
                local distance = (safePosVector - entityPos).Magnitude
                if distance <= 25 then
                    blockedCount = blockedCount + 1
                    break
                end
            end
        end
    end
    
    return blockedCount >= 2
end


local function EnableBookshelfESP()
    if State.BookshelfESPActive then
        return false, "Bookshelf ESP is already active!"
    end
    
    for _, highlight in pairs(State.BookshelfHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    State.BookshelfHighlights = {}
    
    for _, billboard in pairs(State.BookshelfBillboards) do
        if billboard.billboard and billboard.billboard.Parent then
            billboard.billboard:Destroy()
        end
    end
    State.BookshelfBillboards = {}
    
    local Assets = FindAssetsFolder()
    if not Assets then
        return false, "Assets folder not found!"
    end
    
    local count = 0
    for _, obj in ipairs(Assets:GetChildren()) do
        if obj.Name == BOOKSHELF_NAME and not obj:FindFirstChildOfClass("Humanoid") then
            count = count + 1
            
            local primaryPart = GetEntityPrimaryPart(obj)
            if primaryPart then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = obj
                highlight.FillTransparency = 1
                highlight.OutlineTransparency = 0
                highlight.OutlineColor = State.BookshelfESPColor
                highlight.Parent = obj
                State.BookshelfHighlights[obj] = highlight
                
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = primaryPart
                billboard.Size = UDim2.fromOffset(120, 30)
                billboard.StudsOffset = Vector3.new(0, primaryPart.Size.Y + 1, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = primaryPart
                
                local textLabel = Instance.new("TextLabel")
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = State.BookshelfESPColor
                textLabel.TextStrokeTransparency = 0.5
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.SourceSans
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Text = "Hint Bookshelf #" .. count
                textLabel.Parent = billboard
                
                State.BookshelfBillboards[obj] = {
                    billboard = billboard,
                    textLabel = textLabel,
                    index = count
                }
            end
        end
    end
    
    if count > 0 then
        State.BookshelfESPActive = true
        
        State.BookshelfESPConnection = RunService.Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - State.LastESPUpdate < 0.1 then return end
            State.LastESPUpdate = currentTime
            
            local character = LocalPlayer.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            for entity, data in pairs(State.BookshelfBillboards) do
                if entity.Parent and data.billboard.Parent then
                    local adornee = data.billboard.Adornee
                    if adornee then
                        local distance = math.floor((hrp.Position - adornee.Position).Magnitude + 0.5)
                        data.textLabel.Text = string.format("Hint Bookshelf #%d [Distance: %d studs]", data.index, distance)
                    end
                else
                    if State.BookshelfHighlights[entity] then
                        State.BookshelfHighlights[entity]:Destroy()
                        State.BookshelfHighlights[entity] = nil
                    end
                    State.BookshelfBillboards[entity] = nil
                end
            end
        end)
        
        return true, "Bookshelf ESP Enabled - Found: " .. count
    else
        return false, "No bookshelves found!"
    end
end


local function EnableFly()
    if State.FlyActive then
        return false, "Fly is already active!"
    end
    
    State.FlyActive = true
    
    local character = LocalPlayer.Character
    if not character then 
        State.FlyActive = false
        return false, "Character not found!"
    end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then 
        State.FlyActive = false
        return false, "Humanoid not found!"
    end
    
    State.FlyTpWalking = true
    task.spawn(function()
        while State.FlyTpWalking do
            task.wait()
            local chr = LocalPlayer.Character
            local hum = chr and chr:FindFirstChildOfClass("Humanoid")
            if chr and hum and hum.Parent and hum.MoveDirection.Magnitude > 0 then
                chr:TranslateBy(hum.MoveDirection * State.FlySpeed)
            end
        end
    end)
    
    if character:FindFirstChild("Animate") then
        character.Animate.Disabled = true
    end
    
    for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
        track:AdjustSpeed(0)
    end
    
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
    humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
    humanoid.PlatformStand = true
    
    local rootPart = character.HumanoidRootPart
    local attachPart = (humanoid.RigType == Enum.HumanoidRigType.R6) and character.Torso or character.UpperTorso
    
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = rootPart.CFrame
    bodyGyro.Parent = attachPart
    State.FlyBodyGyro = bodyGyro
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
    bodyVelocity.Parent = attachPart
    State.FlyBodyVelocity = bodyVelocity
    
    State.FlyConnection = RunService.RenderStepped:Connect(function()
        if not State.FlyActive then return end
        
        local char = LocalPlayer.Character
        if not char then return end
        
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then
            DisableFly()
            return
        end
        
        local cam = workspace.CurrentCamera
        local moveDir = hum.MoveDirection
        
        if moveDir.Magnitude > 0 then
            local vel = (cam.CFrame.LookVector * -moveDir.Z + cam.CFrame.RightVector * moveDir.X) * State.FlySpeed
            if State.FlyBodyVelocity then
                State.FlyBodyVelocity.Velocity = vel + Vector3.new(0, 0.1, 0)
            end
        else
            if State.FlyBodyVelocity then
                State.FlyBodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
            end
        end
        
        if State.FlyBodyGyro then
            State.FlyBodyGyro.CFrame = cam.CFrame
        end
    end)
    
    return true, "Fly Enabled"
end

local function DisableFly()
    if not State.FlyActive then
        return false, "Fly is not active!"
    end
    
    State.FlyActive = false
    State.FlyTpWalking = false
    
    if State.FlyConnection then
        State.FlyConnection:Disconnect()
        State.FlyConnection = nil
    end
    
    if State.FlyBodyGyro then
        State.FlyBodyGyro:Destroy()
        State.FlyBodyGyro = nil
    end
    
    if State.FlyBodyVelocity then
        State.FlyBodyVelocity:Destroy()
        State.FlyBodyVelocity = nil
    end
    
    local character = LocalPlayer.Character
    if not character then return true, "Fly Disabled" end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.PlatformStand = false
        
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
        humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
    end
    
    if character:FindFirstChild("Animate") then
        character.Animate.Disabled = false
    end
    
    return true, "Fly Disabled"
end

local function SetFlySpeed(speed)
    local speedNum = tonumber(speed)
    if not speedNum then
        return false, "Invalid Fly Speed value!"
    end
    
    State.FlySpeed = speedNum
    return true, "Fly Speed set to " .. speedNum
end

local function DisableBookshelfESP()
    if not State.BookshelfESPActive then
        return false, "Bookshelf ESP is not active!"
    end
    
    State.BookshelfESPActive = false
    
    if State.BookshelfESPConnection then
        State.BookshelfESPConnection:Disconnect()
        State.BookshelfESPConnection = nil
    end
    
    for _, highlight in pairs(State.BookshelfHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    State.BookshelfHighlights = {}
    
    for _, data in pairs(State.BookshelfBillboards) do
        if data.billboard and data.billboard.Parent then
            data.billboard:Destroy()
        end
    end
    State.BookshelfBillboards = {}
    
    return true, "Bookshelf ESP Disabled"
end

local function EnableMultiEntityESP()
    if State.MultiEntityESPActive then
        return false, "Multi-Entity ESP is already active!"
    end
    
    for _, highlight in pairs(State.EntityHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    State.EntityHighlights = {}
    
    for _, data in pairs(State.EntityBillboards) do
        if data.billboard and data.billboard.Parent then
            data.billboard:Destroy()
        end
    end
    State.EntityBillboards = {}
    
    local totalCount = 0
    local entityCounts = {Figure = 0, Drakobloxxer = 0, SCP939 = 0, AmongUs = 0}
    
    local mapFolder = workspace:FindFirstChild("Map")
    if mapFolder then
        for _, obj in ipairs(mapFolder:GetChildren()) do
            if obj.Name == "FigureSetup" then
                local figureRagdoll = obj:FindFirstChild("FigureRagdoll")
                if figureRagdoll then
                    totalCount = totalCount + 1
                    entityCounts.Figure = entityCounts.Figure + 1
                    
                    local primaryPart = GetEntityPrimaryPart(figureRagdoll)
                    if primaryPart then
                        local highlight = Instance.new("Highlight")
                        highlight.FillColor = Color3.new(1, 1, 1)
                        highlight.FillTransparency = 1
                        highlight.OutlineColor = State.FigureESPColor
                        highlight.OutlineTransparency = 0
                        highlight.Parent = figureRagdoll
                        State.EntityHighlights[figureRagdoll] = highlight
                        
                        local billboard = Instance.new("BillboardGui")
                        billboard.Adornee = primaryPart
                        billboard.Size = UDim2.fromOffset(120, 30)
                        billboard.StudsOffset = Vector3.new(0, primaryPart.Size.Y + 2, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = primaryPart
                        
                        local textLabel = Instance.new("TextLabel")
                        textLabel.BackgroundTransparency = 1
                        textLabel.TextColor3 = State.FigureESPColor
                        textLabel.TextStrokeTransparency = 0.5
                        textLabel.TextScaled = true
                        textLabel.Font = Enum.Font.SourceSansBold
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.Text = "Figure #" .. entityCounts.Figure
                        textLabel.Parent = billboard
                        
                        State.EntityBillboards[figureRagdoll] = {
                            billboard = billboard,
                            textLabel = textLabel,
                            entity = figureRagdoll,
                            entityType = "Figure",
                            index = entityCounts.Figure
                        }
                    end
                end
            end
        end
    end
    
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name == "Drakobloxxer" then
            totalCount = totalCount + 1
            entityCounts.Drakobloxxer = entityCounts.Drakobloxxer + 1
            
            local primaryPart = GetEntityPrimaryPart(obj)
            if primaryPart then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 1, 1)
                highlight.FillTransparency = 1
                highlight.OutlineColor = State.DrakobloxxerESPColor
                highlight.OutlineTransparency = 0
                highlight.Parent = obj
                State.EntityHighlights[obj] = highlight
                
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = primaryPart
                billboard.Size = UDim2.fromOffset(120, 30)
                billboard.StudsOffset = Vector3.new(0, primaryPart.Size.Y + 2, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = primaryPart
                
                local textLabel = Instance.new("TextLabel")
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = State.DrakobloxxerESPColor
                textLabel.TextStrokeTransparency = 0.5
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Text = "Drakobloxxer #" .. entityCounts.Drakobloxxer
                textLabel.Parent = billboard
                
                State.EntityBillboards[obj] = {
                    billboard = billboard,
                    textLabel = textLabel,
                    entity = obj,
                    entityType = "Drakobloxxer",
                    index = entityCounts.Drakobloxxer
                }
            end
        end
    end
    
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name == "939Original" then
            totalCount = totalCount + 1
            entityCounts.SCP939 = entityCounts.SCP939 + 1
            
            local primaryPart = GetEntityPrimaryPart(obj)
            if primaryPart then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 1, 1)
                highlight.FillTransparency = 1
                highlight.OutlineColor = State.SCP939ESPColor
                highlight.OutlineTransparency = 0
                highlight.Parent = obj
                State.EntityHighlights[obj] = highlight
                
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = primaryPart
                billboard.Size = UDim2.fromOffset(120, 30)
                billboard.StudsOffset = Vector3.new(0, primaryPart.Size.Y + 2, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = primaryPart
                
                local textLabel = Instance.new("TextLabel")
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = State.SCP939ESPColor
                textLabel.TextStrokeTransparency = 0.5
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Text = "SCP-939 #" .. entityCounts.SCP939
                textLabel.Parent = billboard
                
                State.EntityBillboards[obj] = {
                    billboard = billboard,
                    textLabel = textLabel,
                    entity = obj,
                    entityType = "SCP-939",
                    index = entityCounts.SCP939
                }
            end
        end
    end

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj.Name == "AmongUs" then
            totalCount = totalCount + 1
            entityCounts.AmongUs = entityCounts.AmongUs + 1
            
            local primaryPart = GetEntityPrimaryPart(obj)
            if primaryPart then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 1, 1)
                highlight.FillTransparency = 1
                highlight.OutlineColor = State.AmongUsESPColor
                highlight.OutlineTransparency = 0
                highlight.Parent = obj
                State.EntityHighlights[obj] = highlight
                
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = primaryPart
                billboard.Size = UDim2.fromOffset(120, 30)
                billboard.StudsOffset = Vector3.new(0, primaryPart.Size.Y + 2, 0)
                billboard.AlwaysOnTop = true
                billboard.Parent = primaryPart
                
                local textLabel = Instance.new("TextLabel")
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = State.AmongUsESPColor
                textLabel.TextStrokeTransparency = 0.5
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.SourceSansBold
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.Text = "AmongUs #" .. entityCounts.AmongUs
                textLabel.Parent = billboard
                
                State.EntityBillboards[obj] = {
                    billboard = billboard,
                    textLabel = textLabel,
                    entity = obj,
                    entityType = "AmongUs",
                    index = entityCounts.AmongUs
                }
            end
        end
    end
    
    if totalCount > 0 then
        State.MultiEntityESPActive = true
        
        State.MultiEntityESPConnection = RunService.Heartbeat:Connect(function()
            local currentTime = tick()
            if currentTime - State.LastESPUpdate < 0.1 then return end
            State.LastESPUpdate = currentTime
            
            local character = LocalPlayer.Character
            local hrp = character and character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            for entity, data in pairs(State.EntityBillboards) do
                if entity.Parent and data.billboard.Parent then
                    local entityPos = GetEntityPosition(entity)
                    if entityPos then
                        local distance = math.floor((hrp.Position - entityPos).Magnitude + 0.5)
                        data.textLabel.Text = string.format("%s #%d [Distance: %d studs]", data.entityType, data.index, distance)
                    end
                else
                    if State.EntityHighlights[entity] then
                        State.EntityHighlights[entity]:Destroy()
                        State.EntityHighlights[entity] = nil
                    end
                    State.EntityBillboards[entity] = nil
                end
            end
        end)
        
        local message = string.format("Multi-Entity ESP Enabled - Figures: %d, Drakos: %d, SCP-939s: %d, AmongUs: %d",
            entityCounts.Figure, entityCounts.Drakobloxxer, entityCounts.SCP939, entityCounts.AmongUs)
        return true, message
    else
        return false, "No entities found!"
    end
end

local function DisableMultiEntityESP()
    if not State.MultiEntityESPActive then
        return false, "Multi-Entity ESP is not active!"
    end
    
    State.MultiEntityESPActive = false
    
    if State.MultiEntityESPConnection then
        State.MultiEntityESPConnection:Disconnect()
        State.MultiEntityESPConnection = nil
    end
    
    for _, highlight in pairs(State.EntityHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    State.EntityHighlights = {}
    
    for _, data in pairs(State.EntityBillboards) do
        if data.billboard and data.billboard.Parent then
            data.billboard:Destroy()
        end
    end
    State.EntityBillboards = {}
    
    return true, "Multi-Entity ESP Disabled"
end

local function EnableMultiEntityTracking()
    if State.MultiEntityTrackingActive then
        return false, "Multi-Entity tracking is already active!"
    end
    
    State.MultiEntityTrackingActive = true
    
    State.MultiEntityTrackingConnection = RunService.Heartbeat:Connect(function()
        local success, err = pcall(function()
            local character = LocalPlayer.Character
            if not character then return end
            
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local nearbyEntities = {}
            local closestDistance = math.huge
            
            for _, obj in ipairs(workspace:GetChildren()) do
                if obj.Name == "Drakobloxxer" then
                    local pos = GetEntityPosition(obj)
                    if pos then
                        local distance = (hrp.Position - pos).Magnitude
                        table.insert(nearbyEntities, {entity = obj, position = pos, distance = distance, type = "Drakobloxxer"})
                        
                        if distance <= 20 then
                            closestDistance = math.min(closestDistance, distance)
                        end
                    end
                end
            end
            
            for _, obj in ipairs(workspace:GetChildren()) do
                if obj.Name == "939Original" then
                    local pos = GetEntityPosition(obj)
                    if pos then
                        local distance = (hrp.Position - pos).Magnitude
                        table.insert(nearbyEntities, {entity = obj, position = pos, distance = distance, type = "SCP-939"})
                        
                        if distance <= 20 then
                            closestDistance = math.min(closestDistance, distance)
                        end
                    end
                end
            end

            for _, obj in ipairs(workspace:GetChildren()) do
                if obj.Name == "AmongUs" then
                    local pos = GetEntityPosition(obj)
                    if pos then
                        local distance = (hrp.Position - pos).Magnitude
                        table.insert(nearbyEntities, {entity = obj, position = pos, distance = distance, type = "AmongUs"})
                        
                        if distance <= 20 then
                            closestDistance = math.min(closestDistance, distance)
                        end
                    end
                end
            end
            
            local mapFolder = workspace:FindFirstChild("Map")
            if mapFolder then
                for _, obj in ipairs(mapFolder:GetChildren()) do
                    if obj.Name == "FigureSetup" then
                        local figureRagdoll = obj:FindFirstChild("FigureRagdoll")
                        if figureRagdoll then
                            local pos = GetEntityPosition(figureRagdoll)
                            if pos then
                                local distance = (hrp.Position - pos).Magnitude
                                table.insert(nearbyEntities, {entity = figureRagdoll, position = pos, distance = distance, type = "Figure"})
                                
                                if distance <= 20 then
                                    closestDistance = math.min(closestDistance, distance)
                                end
                            end
                        end
                    end
                end
            end
            
            if closestDistance <= 20 then
                if CheckSafePositionsBlocked(nearbyEntities) then
                    hrp.CFrame = DOOR_CFRAME
                    return
                end
                
                local bestPosition = nil
                local bestDistance = 0
                
                for _, safePos in ipairs(SAFE_POSITIONS) do
                    local minEntityDistance = math.huge
                    
                    for _, entityData in ipairs(nearbyEntities) do
                        if entityData.distance <= 25 then
                            local distToSafe = (safePos.Position - entityData.position).Magnitude
                            minEntityDistance = math.min(minEntityDistance, distToSafe)
                        end
                    end
                    
                    if minEntityDistance > bestDistance then
                        bestDistance = minEntityDistance
                        bestPosition = safePos
                    end
                end
                
                if bestPosition then
                    hrp.CFrame = bestPosition
                end
            end
            
            if mapFolder then
                for _, obj in ipairs(mapFolder:GetChildren()) do
                    if obj.Name == "FigureSetup" then
                        local figureRagdoll = obj:FindFirstChild("FigureRagdoll")
                        if figureRagdoll then
                            local torso = figureRagdoll:FindFirstChild("Torso")
                            if torso then
                                local distance = (hrp.Position - torso.Position).Magnitude
                                
                                if distance >= 15 and distance <= 20 then
                                    State.SafePositionIndex = State.SafePositionIndex == 1 and 2 or 1
                                    hrp.CFrame = SAFE_POSITIONS[State.SafePositionIndex]
                                elseif distance < 15 then
                                    State.SafePositionIndex = State.SafePositionIndex == 1 and 2 or 1
                                    hrp.CFrame = SAFE_POSITIONS[State.SafePositionIndex]
                                end
                                break
                            end
                        end
                    end
                end
            end
        end)
    end)
    
    return true, "Multi-Entity tracking started (Figure/Drako/SCP-939/AmongUs)"
end

local function DisableMultiEntityTracking()
    if not State.MultiEntityTrackingActive then
        return false, "Multi-Entity tracking is not active!"
    end
    
    State.MultiEntityTrackingActive = false
    
    if State.MultiEntityTrackingConnection then
        State.MultiEntityTrackingConnection:Disconnect()
        State.MultiEntityTrackingConnection = nil
    end
    
    return true, "Multi-Entity tracking stopped"
end

local function EnableFullBright()
    if State.FullBrightActive then
        return false, "Full Bright is already active!"
    end
    
    State.FullBrightActive = true
    
    Lighting.Brightness = 2
    Lighting.Ambient = State.FullBrightColor
    Lighting.ColorShift_Bottom = State.FullBrightColor
    Lighting.ColorShift_Top = State.FullBrightColor
    Lighting.OutdoorAmbient = State.FullBrightColor
    Lighting.ShadowSoftness = 0
    
    return true, "Full Bright Enabled"
end

local function DisableFullBright()
    if not State.FullBrightActive then
        return false, "Full Bright is not active!"
    end
    
    State.FullBrightActive = false
    
    Lighting.Brightness = State.OriginalLighting.Brightness
    Lighting.Ambient = State.OriginalLighting.Ambient
    Lighting.ColorShift_Bottom = State.OriginalLighting.ColorShift_Bottom
    Lighting.ColorShift_Top = State.OriginalLighting.ColorShift_Top
    Lighting.OutdoorAmbient = State.OriginalLighting.OutdoorAmbient
    Lighting.ShadowSoftness = State.OriginalLighting.ShadowSoftness
    
    return true, "Full Bright Disabled"
end

local function EnableNoFog()
    if State.NoFogActive then
        return false, "No Fog is already active!"
    end
    
    State.NoFogActive = true
    
    Lighting.FogEnd = 100000
    Lighting.FogStart = 0
    
    return true, "No Fog Enabled"
end

local function DisableNoFog()
    if not State.NoFogActive then
        return false, "No Fog is not active!"
    end
    
    State.NoFogActive = false
    
    Lighting.FogEnd = State.OriginalLighting.FogEnd
    Lighting.FogStart = State.OriginalLighting.FogStart
    
    return true, "No Fog Disabled"
end

local function EnableAntiLag()
    if State.AntiLagActive then
        return false, "Anti Lag is already active!"
    end
    
    State.AntiLagActive = true
    
    local success, err = pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
    end)
    
    if not success then
        State.AntiLagActive = false
        return false, "Failed to enable Anti Lag: " .. tostring(err)
    end
    
    task.spawn(function()
        local textureRemovalRate = 500
        local interval = 1 / textureRemovalRate
        local texturesRemoved = 0
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if not State.AntiLagActive then break end
            
            if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") then
                pcall(function()
                    obj:Destroy()
                    texturesRemoved = texturesRemoved + 1
                end)
                
                if texturesRemoved % textureRemovalRate == 0 then
                    task.wait(1)
                end
                
                task.wait(interval)
            elseif obj:IsA("BasePart") then
                pcall(function()
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                end)
            end
        end
        
        warn("[UNXHub] Anti-Lag texture removal complete. Removed " .. texturesRemoved .. " textures.")
    end)
    
    return true, "Anti Lag Enabled (Removing textures at 500/s)"
end

local function DisableAntiLag()
    if not State.AntiLagActive then
        return false, "Anti Lag is not active!"
    end
    
    State.AntiLagActive = false
    
    local success, err = pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = true
            end
        end
    end)
    
    if success then
        return true, "Anti Lag Disabled"
    else
        return false, "Failed to disable Anti Lag: " .. tostring(err)
    end
end

local function SetFOV(fov)
    local fovNum = tonumber(fov)
    if not fovNum then
        return false, "Invalid FOV value!"
    end
    
    State.FOVValue = fovNum
    State.CustomFOVActive = true
    
    if State.FOVConnection then
        State.FOVConnection:Disconnect()
    end
    
    State.FOVConnection = RunService.RenderStepped:Connect(function()
        if State.CustomFOVActive and workspace.CurrentCamera then
            workspace.CurrentCamera.FieldOfView = State.FOVValue
        end
    end)
    
    return true, "FOV set to " .. fovNum
end

local function ResetFOV()
    State.CustomFOVActive = false
    
    if State.FOVConnection then
        State.FOVConnection:Disconnect()
        State.FOVConnection = nil
    end
    
    if workspace.CurrentCamera then
        workspace.CurrentCamera.FieldOfView = State.OriginalFOV
    end
    
    return true, "FOV reset to " .. State.OriginalFOV
end

local function UpdateBookshelfESPColor(color)
    State.BookshelfESPColor = color
    
    for _, highlight in pairs(State.BookshelfHighlights) do
        if highlight and highlight.Parent then
            highlight.OutlineColor = color
        end
    end
    
    for _, data in pairs(State.BookshelfBillboards) do
        if data.textLabel and data.textLabel.Parent then
            data.textLabel.TextColor3 = color
        end
    end
end

local function UpdateEntityESPColors()
    for entity, data in pairs(State.EntityBillboards) do
        local color
        if data.entityType == "Figure" then
            color = State.FigureESPColor
        elseif data.entityType == "Drakobloxxer" then
            color = State.DrakobloxxerESPColor
        elseif data.entityType == "SCP-939" then
            color = State.SCP939ESPColor
        elseif data.entityType == "AmongUs" then
            color = State.AmongUsESPColor
        end
        
        if color then
            if State.EntityHighlights[entity] and State.EntityHighlights[entity].Parent then
                State.EntityHighlights[entity].OutlineColor = color
            end
            
            if data.textLabel and data.textLabel.Parent then
                data.textLabel.TextColor3 = color
            end
        end
    end
end

-- Completely rewrote periodic recheck to use task.spawn instead of Heartbeat
local function StartPeriodicRecheck()
    if State.PeriodicRecheckConnection then
        State.PeriodicRecheckConnection = false
    end
    
    State.PeriodicRecheckConnection = true
    
    task.spawn(function()
        while State.PeriodicRecheckConnection do
            task.wait(10)
            
            if not State.PeriodicRecheckConnection then break end
            
            pcall(function()
                -- Recheck Assets folder
                local newAssetsFolder = FindAssetsFolder()
                if newAssetsFolder ~= State.CurrentAssetsFolder then
                    State.CurrentAssetsFolder = newAssetsFolder
                    
                    -- Refresh Bookshelf ESP if active
                    if State.BookshelfESPActive then
                        DisableBookshelfESP()
                        task.wait(0.1)
                        EnableBookshelfESP()
                    end
                end
                
                -- Refresh Multi-Entity ESP if active
                if State.MultiEntityESPActive then
                    DisableMultiEntityESP()
                    task.wait(0.1)
                    EnableMultiEntityESP()
                end
                
                -- Update bookshelf dropdown
                if Options and Options.BookshelfDropdown then
                    UpdateBookshelfDropdown()
                end
                
                -- Reapply Full Bright if active
                if State.FullBrightActive then
                    Lighting.Brightness = 2
                    Lighting.Ambient = State.FullBrightColor
                    Lighting.ColorShift_Bottom = State.FullBrightColor
                    Lighting.ColorShift_Top = State.FullBrightColor
                    Lighting.OutdoorAmbient = State.FullBrightColor
                    Lighting.ShadowSoftness = 0
                end
                
                -- Reapply No Fog if active
                if State.NoFogActive then
                    Lighting.FogEnd = 100000
                    Lighting.FogStart = 0
                end
            end)
        end
    end)
end

local function StopPeriodicRecheck()
    State.PeriodicRecheckConnection = false
end

local function EnableNoclip()
    if State.NoclipActive then
        return false, "Noclip is already active!"
    end
    
    State.NoclipActive = true
    
    State.NoclipConnection = RunService.Stepped:Connect(function()
        if State.NoclipActive and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
    
    return true, "Noclip Enabled"
end

local function DisableNoclip()
    if not State.NoclipActive then
        return false, "Noclip is not active!"
    end
    
    State.NoclipActive = false
    
    if State.NoclipConnection then
        State.NoclipConnection:Disconnect()
        State.NoclipConnection = nil
    end
    
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
    
    return true, "Noclip Disabled"
end

local function SetWalkSpeed(speed)
    local speedNum = tonumber(speed)
    if not speedNum then
        return false, "Invalid WalkSpeed value!"
    end
    
    if State.WalkSpeedConnection then
        State.WalkSpeedConnection:Disconnect()
        State.WalkSpeedConnection = nil
    end
    
    State.WalkSpeedValue = speedNum
    State.CustomWalkSpeedActive = true
    
    State.WalkSpeedConnection = RunService.RenderStepped:Connect(function()
        if State.CustomWalkSpeedActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = State.WalkSpeedValue
        end
    end)
    
    return true, "WalkSpeed set to " .. speedNum
end

local function ResetWalkSpeed()
    State.CustomWalkSpeedActive = false
    
    if State.WalkSpeedConnection then
        State.WalkSpeedConnection:Disconnect()
        State.WalkSpeedConnection = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
    
    return true, "WalkSpeed reset to 16"
end

local function BreakVelocity()
    local character = LocalPlayer.Character
    if not character then
        return false, "Character not found!"
    end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return false, "HumanoidRootPart not found!"
    end
    
    local success, err = pcall(function()
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        
        if hrp.Velocity then
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
        
        for _, obj in pairs(hrp:GetChildren()) do
            if obj:IsA("BodyVelocity") or obj:IsA("BodyPosition") or obj:IsA("BodyAngularVelocity") or obj:IsA("BodyThrust") or obj:IsA("BodyForce") then
                obj:Destroy()
            end
        end
    end)
    
    if success then
        return true, "Player velocity broken!"
    else
        return false, "Failed to break velocity: " .. tostring(err)
    end
end

local function TeleportToDoor()
    local character = LocalPlayer.Character
    if not character then
        return false, "Character not found!"
    end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return false, "HumanoidRootPart not found!"
    end
    
    hrp.CFrame = DOOR_CFRAME
    return true, "Teleported to Door"
end

local function TeleportToBPaper()
    local character = LocalPlayer.Character
    if not character then
        return false, "Character not found!"
    end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return false, "HumanoidRootPart not found!"
    end
    
    hrp.CFrame = BPAPER_CFRAME
    return true, "Teleported to BPaper"
end

-- Added function to get all bookshelves
local function GetAllBookshelves()
    local bookshelves = {}
    local Assets = FindAssetsFolder()
    
    if not Assets then
        return bookshelves
    end
    
    local count = 0
    for _, obj in ipairs(Assets:GetChildren()) do
        if obj.Name == BOOKSHELF_NAME and not obj:FindFirstChildOfClass("Humanoid") then
            count = count + 1
            local primaryPart = GetEntityPrimaryPart(obj)
            if primaryPart then
                table.insert(bookshelves, {
                    name = "Hint Bookshelf #" .. count,
                    object = obj,
                    position = primaryPart.CFrame
                })
            end
        end
    end
    
    return bookshelves
end

-- Added function to update bookshelf dropdown
local function UpdateBookshelfDropdown()
    State.BookshelfList = GetAllBookshelves()
    
    if not Options or not Options.BookshelfDropdown then
        return false, "Dropdown not initialized yet"
    end
    
    local bookshelfNames = {}
    for _, bookshelf in ipairs(State.BookshelfList) do
        table.insert(bookshelfNames, bookshelf.name)
    end
    
    if #bookshelfNames > 0 then
        Options.BookshelfDropdown:SetValues(bookshelfNames)
        Options.BookshelfDropdown:SetValue(bookshelfNames[1])
        return true, "Found " .. #bookshelfNames .. " bookshelves"
    else
        Options.BookshelfDropdown:SetValues({"No bookshelves found"})
        Options.BookshelfDropdown:SetValue("No bookshelves found")
        return false, "No bookshelves found"
    end
end

-- Added function to teleport to selected bookshelf
local function TeleportToBookshelf(bookshelfName)
    local character = LocalPlayer.Character
    if not character then
        return false, "Character not found!"
    end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        return false, "HumanoidRootPart not found!"
    end
    
    for _, bookshelf in ipairs(State.BookshelfList) do
        if bookshelf.name == bookshelfName then
            hrp.CFrame = bookshelf.position
            return true, "Teleported to " .. bookshelfName
        end
    end
    
    return false, "Bookshelf not found!"
end

local function Revive()
    local character = LocalPlayer.Character
    if not character then
        return false, "Character not found!"
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health > 0 then
        return false, "Already alive!"
    end
    
    local success, err = pcall(function()
        ReplicatedStorage:WaitForChild("Bricks"):WaitForChild("Revive"):FireServer()
    end)
    
    if success then
        return true, "Revive request sent!"
    else
        return false, "Failed to revive: " .. tostring(err)
    end
end

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ToggleKeybind = Enum.KeyCode.U
Library.ForceCheckbox = true

local Window = Library:CreateWindow({
    Title = "UNXHub",
    Footer = "Version: " .. (getgenv().unxshared and getgenv().unxshared.version or "Unknown") .. ", Game: " .. (getgenv().unxshared and getgenv().unxshared.gamename or "Unknown"),
    Icon = 123333102279908,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

local Tabs = {
    Main = Window:AddTab("Main", "home"),
    Visuals = Window:AddTab("Visuals", "eye"),
    Settings = Window:AddTab("UI Settings", "settings"),
}

local LocalPlayerGroup = Tabs.Main:AddLeftGroupbox("Local-Player", "user")

LocalPlayerGroup:AddSlider("WalkSpeedSlider", {
    Text = "WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        SetWalkSpeed(value)
    end,
})

LocalPlayerGroup:AddLabel("WalkSpeed Keybind"):AddKeyPicker("CustomWalkSpeedKey", {
    Default = "V",
    Text = "Custom WalkSpeed",
    Mode = "Toggle",
    Callback = function()
        if State.CustomWalkSpeedActive then
            ResetWalkSpeed()
        else
            SetWalkSpeed(Options.WalkSpeedSlider.Value)
        end
    end,
})

LocalPlayerGroup:AddDivider()

LocalPlayerGroup:AddToggle("Noclip", {
    Text = "Enable Noclip",
    Tooltip = "Walk through walls",
    Default = false,
    Callback = function(value)
        if value then
            EnableNoclip()
        else
            DisableNoclip()
        end
    end,
})

LocalPlayerGroup:AddLabel("Noclip Keybind"):AddKeyPicker("NoclipKey", {
    Default = "N",
    Text = "Noclip",
    Mode = "Toggle",
    Callback = function()
        Toggles.Noclip:SetValue(not Toggles.Noclip.Value)
    end,
})

LocalPlayerGroup:AddDivider()

LocalPlayerGroup:AddButton({
    Text = "Break Velocity",
    Tooltip = "Stops all momentum instantly",
    Func = function()
        BreakVelocity()
    end,
})

LocalPlayerGroup:AddLabel("Break Velocity Keybind"):AddKeyPicker("BreakVelocityKey", {
    Default = "X",
    Text = "Break Velocity",
    Mode = "Press",
    Callback = function()
        BreakVelocity()
    end,
})

local FeaturesGroup = Tabs.Main:AddLeftGroupbox("Features", "shield")

FeaturesGroup:AddToggle("MultiEntityTracking", {
    Text = "Auto-Dodge Entities",
    Tooltip = "Automatically teleports you away from nearby entities",
    Default = false,
    Callback = function(value)
        if value then
            EnableMultiEntityTracking()
        else
            DisableMultiEntityTracking()
        end
    end,
})

FeaturesGroup:AddLabel("Auto-Dodge Keybind"):AddKeyPicker("MultiEntityTrackingKey", {
    Default = "T",
    Text = "Auto-Dodge",
    Mode = "Toggle",
    Callback = function()
        Toggles.MultiEntityTracking:SetValue(not Toggles.MultiEntityTracking.Value)
    end,
})

local UtilityGroup = Tabs.Main:AddRightGroupbox("Utility", "wrench")

UtilityGroup:AddSlider("FlySpeedSlider", {
    Text = "Fly Speed",
    Default = 1,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        SetFlySpeed(value)
    end,
})

UtilityGroup:AddToggle("Fly", {
    Text = "Enable Fly",
    Tooltip = "Fly around the map",
    Default = false,
    Callback = function(value)
        if value then
            EnableFly()
        else
            DisableFly()
        end
    end,
})

UtilityGroup:AddLabel("Fly Keybind"):AddKeyPicker("FlyKey", {
    Default = "F",
    Text = "Fly",
    Mode = "Toggle",
    Callback = function()
        Toggles.Fly:SetValue(not Toggles.Fly.Value)
    end,
})

UtilityGroup:AddLabel("<font color='rgb(255,0,0)'><u>WARNING!</u></font> This Fly May Be <u>Patched Or Detected</u> On The Future!", true)

UtilityGroup:AddDivider()

UtilityGroup:AddButton({
    Text = "Revive",
    Tooltip = "Attempts to revive your character",
    Func = function()
        Revive()
    end,
})

UtilityGroup:AddLabel("Revive Keybind"):AddKeyPicker("ReviveKey", {
    Default = "R",
    Text = "Revive",
    Mode = "Press",
    Callback = function()
        Revive()
    end,
})

UtilityGroup:AddDivider()

UtilityGroup:AddButton({
    Text = "Teleport to Door",
    Tooltip = "Teleports you to the exit door",
    Func = function()
        TeleportToDoor()
    end,
})

UtilityGroup:AddLabel("TP Door Keybind"):AddKeyPicker("TeleportDoorKey", {
    Default = "F1",
    Text = "TP to Door",
    Mode = "Press",
    Callback = function()
        TeleportToDoor()
    end,
})

UtilityGroup:AddButton({
    Text = "Teleport to BPaper",
    Tooltip = "Teleports you to the BPaper location",
    Func = function()
        TeleportToBPaper()
    end,
})

UtilityGroup:AddLabel("TP BPaper Keybind"):AddKeyPicker("TeleportBPaperKey", {
    Default = "F2",
    Text = "TP to BPaper",
    Mode = "Press",
    Callback = function()
        TeleportToBPaper()
    end,
})

-- Added Teleport to Bookshelf dropdown and update button
UtilityGroup:AddDivider()

UtilityGroup:AddDropdown("BookshelfDropdown", {
    Values = {"Loading..."},
    Default = 1,
    Multi = false,
    Text = "Teleport to Bookshelf",
    Tooltip = "Select a bookshelf to teleport to",
    Callback = function(value)
        TeleportToBookshelf(value)
    end,
})

UtilityGroup:AddButton({
    Text = "Update Dropdown",
    Tooltip = "Manually refresh the bookshelf list",
    Func = function()
        local success, message = UpdateBookshelfDropdown()
        if success then
            Library:Notify(message, 3)
        else
            Library:Notify(message, 3)
        end
    end,
})

local ESPGroup = Tabs.Visuals:AddLeftGroupbox("ESP", "eye")

ESPGroup:AddLabel("Bookshelf ESP")

ESPGroup:AddToggle("BookshelfESP", {
    Text = "Enable Bookshelf ESP",
    Tooltip = "Shows all hint bookshelves with distance",
    Default = false,
    Callback = function(value)
        if value then
            EnableBookshelfESP()
        else
            DisableBookshelfESP()
        end
    end,
})

ESPGroup:AddLabel("Bookshelf ESP Keybind"):AddKeyPicker("BookshelfESPKey", {
    Default = "B",
    Text = "Bookshelf ESP",
    Mode = "Toggle",
    Callback = function()
        Toggles.BookshelfESP:SetValue(not Toggles.BookshelfESP.Value)
    end,
})

ESPGroup:AddLabel("Bookshelf ESP Color"):AddColorPicker("BookshelfESPColor", {
    Default = Color3.fromRGB(170, 0, 255),
    Title = "Bookshelf ESP Color",
    Callback = function(value)
        UpdateBookshelfESPColor(value)
    end,
})

ESPGroup:AddDivider()

ESPGroup:AddLabel("Monster ESP")

ESPGroup:AddToggle("MultiEntityESP", {
    Text = "Enable Monster ESP",
    Tooltip = "Shows Figure, Drakobloxxer, and SCP-939 with distance",
    Default = false,
    Callback = function(value)
        if value then
            EnableMultiEntityESP()
        else
            DisableMultiEntityESP()
        end
    end,
})

ESPGroup:AddLabel("Monster ESP Keybind"):AddKeyPicker("MultiEntityESPKey", {
    Default = "E",
    Text = "Monster ESP",
    Mode = "Toggle",
    Callback = function()
        Toggles.MultiEntityESP:SetValue(not Toggles.MultiEntityESP.Value)
    end,
})

ESPGroup:AddLabel("Figure ESP Color"):AddColorPicker("FigureESPColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Figure ESP Color",
    Callback = function(value)
        State.FigureESPColor = value
        UpdateEntityESPColors()
    end,
})

ESPGroup:AddLabel("Drakobloxxer ESP Color"):AddColorPicker("DrakobloxxerESPColor", {
    Default = Color3.fromRGB(255, 165, 0),
    Title = "Drakobloxxer ESP Color",
    Callback = function(value)
        State.DrakobloxxerESPColor = value
        UpdateEntityESPColors()
    end,
})

ESPGroup:AddLabel("SCP-939 ESP Color"):AddColorPicker("SCP939ESPColor", {
    Default = Color3.fromRGB(128, 0, 128),
    Title = "SCP-939 ESP Color",
    Callback = function(value)
        State.SCP939ESPColor = value
        UpdateEntityESPColors()
    end,
})

ESPGroup:AddLabel("AmongUs ESP Color"):AddColorPicker("AmongUsESPColor", {
    Default = Color3.fromRGB(255, 0, 255),
    Title = "AmongUs ESP Color",
    Callback = function(value)
        State.AmongUsESPColor = value
        UpdateEntityESPColors()
    end,
})

local CameraGroup = Tabs.Visuals:AddRightGroupbox("Camera", "camera")

CameraGroup:AddSlider("FOVSlider", {
    Text = "Field Of View",
    Default = 70,
    Min = 30,
    Max = 120,
    Rounding = 0,
    Compact = false,
    Callback = function(value)
        SetFOV(value)
    end,
})

CameraGroup:AddLabel("FOV Keybind"):AddKeyPicker("FOVKey", {
    Default = "G",
    Text = "Toggle FOV",
    Mode = "Toggle",
    Callback = function()
        if State.CustomFOVActive then
            ResetFOV()
        else
            SetFOV(Options.FOVSlider.Value)
        end
    end,
})

CameraGroup:AddDivider()

CameraGroup:AddToggle("FullBright", {
    Text = "Full Bright",
    Tooltip = "Makes everything bright and visible",
    Default = false,
    Callback = function(value)
        if value then
            EnableFullBright()
        else
            DisableFullBright()
        end
    end,
})

CameraGroup:AddLabel("Full Bright Keybind"):AddKeyPicker("FullBrightKey", {
    Default = "L",
    Text = "Full Bright",
    Mode = "Toggle",
    Callback = function()
        Toggles.FullBright:SetValue(not Toggles.FullBright.Value)
    end,
})

CameraGroup:AddLabel("Full Bright Color"):AddColorPicker("FullBrightColor", {
    Default = Color3.fromRGB(255, 255, 255),
    Title = "Full Bright Color",
    Callback = function(value)
        State.FullBrightColor = value
        if State.FullBrightActive then
            Lighting.Ambient = value
            Lighting.ColorShift_Bottom = value
            Lighting.ColorShift_Top = value
            Lighting.OutdoorAmbient = value
        end
    end,
})

CameraGroup:AddDivider()

CameraGroup:AddToggle("NoFog", {
    Text = "No Fog",
    Tooltip = "Removes fog for better visibility",
    Default = false,
    Callback = function(value)
        if value then
            EnableNoFog()
        else
            DisableNoFog()
        end
    end,
})

CameraGroup:AddDivider()

CameraGroup:AddToggle("AntiLag", {
    Text = "Anti Lag",
    Tooltip = "Reduces lag by disabling visual effects",
    Default = false,
    Callback = function(value)
        if value then
            EnableAntiLag()
        else
            DisableAntiLag()
        end
    end,
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})

ThemeManager:SetFolder("UNXHub")
SaveManager:SetFolder("UNXHub/configs")

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

local MenuGroup = Tabs.Settings:AddLeftGroupbox("Menu", "settings")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(value)
        Library.ShowCustomCursor = value
    end,
})

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu keybind"
})

MenuGroup:AddButton("Unload", function()
    Library:Unload()
end)

MenuGroup:AddLabel("<font color='rgb(255,0,0)'><u>DISCLAIMER</u></font>: We Use This To See How Many Users We Get, <u>We Do Not Share This Information With Any Third Partys</u>.", true)

MenuGroup:AddToggle("OptOutLog", {
    Text = "Opt-Out Log",
    Default = isfile("optout.unx"),
    Callback = function(value)
        if value then
            writefile("optout.unx", "")
            Library:Notify("Opt-Out Log Enabled", 3)
        else
            if isfile("optout.unx") then
                delfile("optout.unx")
            end
            Library:Notify("Opt-Out Log Disabled", 3)
        end
    end
})

Library:OnUnload(function()
    if State.BookshelfESPActive then DisableBookshelfESP() end
    if State.MultiEntityESPActive then DisableMultiEntityESP() end
    if State.MultiEntityTrackingActive then DisableMultiEntityTracking() end
    if State.FullBrightActive then DisableFullBright() end
    if State.NoFogActive then DisableNoFog() end
    if State.NoclipActive then DisableNoclip() end
    if State.CustomWalkSpeedActive then ResetWalkSpeed() end
    if State.CustomFOVActive then ResetFOV() end
    if State.FlyActive then DisableFly() end
    if State.AntiLagActive then DisableAntiLag() end
    StopPeriodicRecheck()
    
    getgenv().unxshared.isloaded = false
end)

SaveManager:LoadAutoloadConfig()
