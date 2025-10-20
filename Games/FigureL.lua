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

local Assets = workspace:WaitForChild("Map"):WaitForChild("Assets")

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
    )}

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
    BookshelfESPConnection = nil,
    MultiEntityESPConnection = nil,
    MultiEntityTrackingConnection = nil,
    WalkSpeedConnection = nil,
    NoclipConnection = nil,
    FOVConnection = nil,
    BookshelfHighlights = {},
    BookshelfBillboards = {},
    EntityHighlights = {},
    EntityBillboards = {},
    BookshelfESPColor = Color3.fromRGB(170, 0, 255),
    FigureESPColor = Color3.fromRGB(255, 0, 0),
    DrakobloxxerESPColor = Color3.fromRGB(255, 165, 0),
    SCP939ESPColor = Color3.fromRGB(128, 0, 128),
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
    SafePositionIndex = 1
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
        
        State.BookshelfESPConnection = RunService.RenderStepped:Connect(function()
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
    local entityCounts = {Figure = 0, Drakobloxxer = 0, SCP939 = 0}
    
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
    
    if totalCount > 0 then
        State.MultiEntityESPActive = true
        
        State.MultiEntityESPConnection = RunService.RenderStepped:Connect(function()
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
        
        local message = string.format("Multi-Entity ESP Enabled - Figures: %d, Drakos: %d, SCP-939s: %d",
            entityCounts.Figure, entityCounts.Drakobloxxer, entityCounts.SCP939)
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
    
    return true, "Multi-Entity tracking started (Figure/Drako/SCP-939)"
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
    local success, err = pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
    end)
    
    if success then
        return true, "Anti Lag Enabled"
    else
        return false, "Failed to enable Anti Lag: " .. tostring(err)
    end
end

local function DisableAntiLag()
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
    Default = "F",
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

Library.ToggleKeybind = Options.MenuKeybind

Library:OnUnload(function()
    if State.BookshelfESPActive then DisableBookshelfESP() end
    if State.MultiEntityESPActive then DisableMultiEntityESP() end
    if State.MultiEntityTrackingActive then DisableMultiEntityTracking() end
    if State.FullBrightActive then DisableFullBright() end
    if State.NoFogActive then DisableNoFog() end
    if State.NoclipActive then DisableNoclip() end
    if State.CustomWalkSpeedActive then ResetWalkSpeed() end
    if State.CustomFOVActive then ResetFOV() end
end)

SaveManager:LoadAutoloadConfig()
