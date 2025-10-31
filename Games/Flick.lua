-- yep, another game!

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
    Title = "UNXHub",
    Footer = "Version: " .. (getgenv().unxshared and getgenv().unxshared.version or "Unknown") .. ", Game: " .. (getgenv().unxshared and getgenv().unxshared.gamename or "Unknown"),
    Icon = 123333102279908,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

Library:Notify({ Title = "Welcome To UNXHub!", Description = "Script loaded successfully", Time = 5 })

local Tabs = {
	Main = Window:AddTab("Main", "user"),
	Visuals = Window:AddTab("Visuals", "eye"),
	Features = Window:AddTab("Features", "bug"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Stats = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local currentwalkspeed = 16
local xrayenabled = false
local xraytransparency = 0.6
local originaltransparencies = {}
local noVelocityEnabled = false
local noVelocityConnection = nil

local fullbrightenabled = false
local nofogenabled = false
local antillagenabled = false
local originalsettings = {}
local originaltextures = {}
local originalmaterials = {}

local originallighting = {
	Brightness = game.Lighting.Brightness,
	Ambient = game.Lighting.Ambient,
	OutdoorAmbient = game.Lighting.OutdoorAmbient,
	FogEnd = game.Lighting.FogEnd,
	FogStart = game.Lighting.FogStart
}

local espenabled = false
local outlineenabled = false
local tracersenabled = false
local skeletonenabled = false

local espconfig = {
	espcolor = Color3.fromRGB(255, 255, 255),
	outlinecolor = Color3.fromRGB(255, 255, 255),
	outlinefillcolor = Color3.fromRGB(255, 255, 255),
	tracercolor = Color3.fromRGB(255, 255, 255),
	skeletoncolor = Color3.fromRGB(255, 255, 255),
	espsize = 16,
	tracersize = 2,
	outlinetransparency = 0,
	outlinefilltransparency = 1,
	rainbowesp = false,
	rainbowoutline = false,
	rainbowtracers = false,
	rainbowskeleton = false,
	rainbowspeed = 5,
}

local rainbowhue = 0
local lastupdate = 0
local espobjects = {}
local activehighlights = {}
local playerconnections = {}
local tracerlines = {}
local skeletonlines = {}

local aimlockenabled = false
local smoothaimlock = false
local aimlocktype = "Nearest Player"
local fovenabled = false
local showfov = false
local fovsize = 100
local fovcolor = Color3.fromRGB(255, 255, 255)
local fovgui = nil
local fovframe = nil
local fovstroke = nil
local fovstrokethickness = 2
local nearestplayerdistance = 1000
local nearestmousedistance = 500
local fovlockdistance = 1000
local rainbowfov = false
local aimlockcertainplayer = false
local selectedplayer = nil
local ignoredplayers = {}
local wallcheckenabled = false
local lerpalpha = 1 / 5  -- Default speed: 5 → lerpalpha = 0.2

local aimlockOffsetX = 0
local aimlockOffsetY = 0

local statusGroup = Tabs.Main:AddRightGroupbox("Status", "info")
local healthLabel = statusGroup:AddLabel("Health: 0")
local versionLabel = statusGroup:AddLabel("Version: Unknown")
local fpsLabel = statusGroup:AddLabel("FPS: 0")
local pingLabel = statusGroup:AddLabel("Ping: 0")

local knifeCloseEnabled = false
local knifeRange = 10
local showKnifeRange = false
local knifeRangeColor = Color3.fromRGB(255, 255, 255)
local knifeRangeTransparency = 0.5
local rangeSphere = nil
local knifeConnection = nil

local SwapWeapon = ReplicatedStorage.SignalManager.SignalEvents.SwapWeapon

local function GetLocalHRP()
	if not LocalPlayer.Character then return nil end
	return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function getrainbowcolor()
	local currenttime = tick()
	local speedmultiplier = 11 - espconfig.rainbowspeed
	local increment = 0.001 * speedmultiplier
	if currenttime - lastupdate >= 0.1 then
		rainbowhue = (rainbowhue + increment) % 1
		lastupdate = currenttime
	end
	return Color3.fromHSV(rainbowhue, 1, 1)
end

local function createesp(player)
	if player == LocalPlayer or espobjects[player] then return end
	local nametext = Drawing.new("Text")
	nametext.Size = espconfig.espsize
	nametext.Center = true
	nametext.Outline = true
	nametext.Color = espconfig.espcolor
	espobjects[player] = { Name = nametext }
end

local function removeesp(player)
	if espobjects[player] then
		espobjects[player].Name:Remove()
		espobjects[player] = nil
	end
end

local function updateesp()
	for player, esp in pairs(espobjects) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character.HumanoidRootPart
			local pos, onscreen = Camera:WorldToViewportPoint(hrp.Position)
			local color = espconfig.rainbowesp and getrainbowcolor() or espconfig.espcolor
			esp.Name.Color = color
			esp.Name.Size = espconfig.espsize
			if onscreen then
				local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
				esp.Name.Position = Vector2.new(pos.X, pos.Y - 20)
				esp.Name.Text = player.Name .. " [STUDS: " .. math.floor(distance) .. "]"
				esp.Name.Visible = true
			else
				esp.Name.Visible = false
			end
		else
			esp.Name.Visible = false
		end
	end
end

local function applyhighlighttocharacter(player, character)
	local userid = player.UserId
	if activehighlights[userid] then activehighlights[userid]:Destroy() end
	local highlighter = Instance.new("Highlight")
	highlighter.FillTransparency = espconfig.outlinefilltransparency
	highlighter.OutlineTransparency = espconfig.outlinetransparency
	highlighter.OutlineColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinecolor
	highlighter.FillColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinefillcolor
	highlighter.Adornee = character
	highlighter.Parent = character
	activehighlights[userid] = highlighter
end

local function setupplayerhighlight(player)
	local userid = player.UserId
	playerconnections[userid] = playerconnections[userid] or {}
	local function oncharacteradded(character)
		local humanoid = character:WaitForChild("Humanoid")
		if outlineenabled then applyhighlighttocharacter(player, character) end
		table.insert(playerconnections[userid], player:GetPropertyChangedSignal("TeamColor"):Connect(function()
			local highlight = activehighlights[userid]
			if highlight then
				highlight.OutlineColor = espconfig.rainbowoutline and getrainbowcolor() or (player.TeamColor and player.TeamColor.Color) or espconfig.outlinecolor
			end
		end))
		table.insert(playerconnections[userid], humanoid.Died:Connect(function() removehighlight(player) end))
	end
	local charaddedconn = player.CharacterAdded:Connect(oncharacteradded)
	table.insert(playerconnections[userid], charaddedconn)
	if player.Character then oncharacteradded(player.Character) end
end

function removehighlight(player)
	local userid = player.UserId
	if activehighlights[userid] then activehighlights[userid]:Destroy() activehighlights[userid] = nil end
	if playerconnections[userid] then
		for _, conn in pairs(playerconnections[userid]) do conn:Disconnect() end
		playerconnections[userid] = nil
	end
end

local function toggletracers()
	if tracersenabled then
		RunService:BindToRenderStep("Tracers", Enum.RenderPriority.Camera.Value + 1, function()
			for _, line in ipairs(tracerlines) do line:Destroy() end
			tracerlines = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local root = player.Character.HumanoidRootPart
					local screenpos, onscreen = Camera:WorldToViewportPoint(root.Position)
					if onscreen then
						local line = Drawing.new("Line")
						line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
						line.To = Vector2.new(screenpos.X, screenpos.Y)
						line.Color = espconfig.rainbowtracers and getrainbowcolor() or espconfig.tracercolor
						line.Thickness = espconfig.tracersize
						line.Transparency = 1
						line.Visible = true
						table.insert(tracerlines, line)
					end
				end
			end
		end)
	else
		RunService:UnbindFromRenderStep("Tracers")
		for _, line in ipairs(tracerlines) do line:Destroy() end
		tracerlines = {}
	end
end

local function toggleskeleton()
	if skeletonenabled then
		RunService:BindToRenderStep("SkeletonESP", Enum.RenderPriority.Camera.Value + 1, function()
			for _, line in ipairs(skeletonlines) do line:Destroy() end
			skeletonlines = {}
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character then
					local char = player.Character
					local parts = {
						Head = char:FindFirstChild("Head"),
						Torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"),
						Hip = char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso"),
						LeftArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm"),
						RightArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"),
						LeftLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg"),
						RightLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
					}
					local color = espconfig.rainbowskeleton and getrainbowcolor() or espconfig.skeletoncolor
					local function getscreen(part) if part then local pos, visible = Camera:WorldToViewportPoint(part.Position) if visible then return Vector2.new(pos.X, pos.Y) end end end
					local function drawline(p1, p2) if p1 and p2 then local line = Drawing.new("Line") line.From = p1 line.To = p2 line.Color = color line.Thickness = 2 line.Transparency = 1 line.Visible = true table.insert(skeletonlines, line) end end
					local head = getscreen(parts.Head)
					local torso = getscreen(parts.Torso)
					local hip = getscreen(parts.Hip)
					local la = getscreen(parts.LeftArm)
					local ra = getscreen(parts.RightArm)
					local ll = getscreen(parts.LeftLeg)
					local rl = getscreen(parts.RightLeg)
					drawline(head, torso)
					drawline(torso, hip)
					drawline(torso, la)
					drawline(torso, ra)
					drawline(hip, ll)
					drawline(hip, rl)
				end
			end
		end)
	else
		RunService:UnbindFromRenderStep("SkeletonESP")
		for _, line in ipairs(skeletonlines) do line:Destroy() end
		skeletonlines = {}
	end
end

local function getclosestplayer()
	local localHRP = GetLocalHRP()
	if not localHRP then return nil end

	local playerlist = {}
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and not ignoredplayers[player.Name] and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (localHRP.Position - player.Character.HumanoidRootPart.Position).Magnitude
			if aimlocktype == "Nearest Player" and distance < nearestplayerdistance then
				table.insert(playerlist, {player = player, distance = distance})
			elseif aimlocktype == "Nearest Mouse" and distance < nearestmousedistance then
				local screenpos, onscreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
				if onscreen then
					local mousedistance = (Vector2.new(screenpos.X, screenpos.Y) - Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)).Magnitude
					table.insert(playerlist, {player = player, distance = mousedistance})
				end
			end
		end
	end
	table.sort(playerlist, function(a, b) return a.distance < b.distance end)
	for _, entry in ipairs(playerlist) do
		local player = entry.player
		local passedFOVCheck = true
		local passedWallCheck = true
		if fovenabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local screenpos, onscreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
			if onscreen then
				local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
				local distance = (Vector2.new(screenpos.X, screenpos.Y) - center).Magnitude
				local worlddistance = (localHRP.Position - player.Character.HumanoidRootPart.Position).Magnitude
				if distance > fovsize / 2 or worlddistance > fovlockdistance then passedFOVCheck = false end
			else passedFOVCheck = false end
		end
		if wallcheckenabled and player.Character and player.Character:FindFirstChild("Head") and localHRP then
			local origin = localHRP.Parent:FindFirstChild("Head") and localHRP.Parent.Head.Position or localHRP.Position
			local direction = (player.Character.Head.Position - origin).Unit * (player.Character.Head.Position - origin).Magnitude
			local raycastParams = RaycastParams.new()
			raycastParams.FilterDescendantsInstances = {LocalPlayer.Character, player.Character}
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
			raycastParams.IgnoreWater = true
			local raycastResult = workspace:Raycast(origin, direction, raycastParams)
			if raycastResult then passedWallCheck = false end
		end
		if passedFOVCheck and passedWallCheck then return player end
	end
	return nil
end

local function updateaimlock()
	if not aimlockenabled then return end
	local localHRP = GetLocalHRP()
	if not localHRP then return end

	local targetplayer = aimlockcertainplayer and selectedplayer or getclosestplayer()
	if targetplayer and targetplayer.Character and targetplayer.Character:FindFirstChild("Head") then
		local targetposition = targetplayer.Character.Head.Position + Vector3.new(aimlockOffsetX, aimlockOffsetY, 0)
		local lookdirection = (targetposition - Camera.CFrame.Position).Unit
		if smoothaimlock then
			local targetcframe = CFrame.lookAt(Camera.CFrame.Position, Camera.CFrame.Position + lookdirection)
			Camera.CFrame = Camera.CFrame:Lerp(targetcframe, lerpalpha)
		else
			Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, Camera.CFrame.Position + lookdirection)
		end
	end
end

local function updatefovcircle()
	if fovframe and fovstroke then
		if showfov then
			fovstroke.Color = rainbowfov and Color3.fromHSV(tick() % 5 / 5, 1, 1) or fovcolor
			fovframe.Visible = true
		else
			fovframe.Visible = false
		end
	end
end

local function toggleNoVelocity()
	if noVelocityEnabled then
		noVelocityConnection = RunService.Heartbeat:Connect(function()
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local hrp = player.Character.HumanoidRootPart
					hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
				end
			end
		end)
	else
		if noVelocityConnection then noVelocityConnection:Disconnect() noVelocityConnection = nil end
	end
end

local function updateKnifeRangeSphere()
	if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		if rangeSphere then rangeSphere.Transparency = 1 end
		return
	end
	local root = LocalPlayer.Character.HumanoidRootPart
	if showKnifeRange then
		if not rangeSphere then
			rangeSphere = Instance.new("Part")
			rangeSphere.Name = "KnifeRangeSphere"
			rangeSphere.Shape = Enum.PartType.Ball
			rangeSphere.Material = Enum.Material.ForceField
			rangeSphere.CanCollide = false
			rangeSphere.Anchored = true
			rangeSphere.CastShadow = false
			rangeSphere.Parent = workspace
		end
		rangeSphere.Size = Vector3.new(knifeRange * 2, knifeRange * 2, knifeRange * 2)
		rangeSphere.CFrame = root.CFrame
		rangeSphere.Color = knifeRangeColor
		rangeSphere.Transparency = knifeRangeTransparency
	else
		if rangeSphere then rangeSphere:Destroy() rangeSphere = nil end
	end
end

local function toggleKnifeSwitch()
	if knifeCloseEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		knifeConnection = RunService.Heartbeat:Connect(function()
			if not knifeCloseEnabled or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
			local root = LocalPlayer.Character.HumanoidRootPart
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local distance = (root.Position - player.Character.HumanoidRootPart.Position).Magnitude
					if distance <= knifeRange then
						SwapWeapon:Fire()
						break
					end
				end
			end
		end)
	else
		if knifeConnection then knifeConnection:Disconnect() knifeConnection = nil end
	end
end

local characterGroup = Tabs.Main:AddLeftGroupbox("Character", "user")
characterGroup:AddSlider("WalkSpeed", { Text = "WalkSpeed", Default = 16, Min = 16, Max = 27, Rounding = 1, Callback = function(v) currentwalkspeed = v end })
characterGroup:AddCheckbox("NoVelocity", { Text = "No Velocity", Default = false, Callback = function(v) noVelocityEnabled = v toggleNoVelocity() end })
characterGroup:AddDivider()
characterGroup:AddCheckbox("XRay", { Text = "X-Ray", Default = false, Callback = function(v) xrayenabled = v if v then for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then originaltransparencies[obj] = obj.Transparency obj.Transparency = xraytransparency end end else for obj, t in pairs(originaltransparencies) do if obj and obj.Parent then obj.Transparency = t end end originaltransparencies = {} end end })
characterGroup:AddSlider("XRayTransparency", { Text = "X-Ray Transparency", Default = 0.6, Min = 0, Max = 1, Rounding = 0.05, Callback = function(v) xraytransparency = v if xrayenabled then for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) and originaltransparencies[obj] then obj.Transparency = v end end end end })

local esptabbox = Tabs.Visuals:AddLeftTabbox()
local esptab = esptabbox:AddTab("ESP")
local configtab = esptabbox:AddTab("Configurations")

esptab:AddCheckbox("ESP", { Text = "ESP", Default = false, Callback = function(v) espenabled = v if v then for _, p in pairs(Players:GetPlayers()) do createesp(p) end else for p, _ in pairs(espobjects) do removeesp(p) end end end }):AddColorPicker("ESPColor", { Default = Color3.fromRGB(255,255,255), Title = "ESP Color", Callback = function(v) espconfig.espcolor = v end })
esptab:AddCheckbox("Outline", { Text = "Outline", Default = false, Callback = function(v) outlineenabled = v if v then for _, p in pairs(Players:GetPlayers()) do playerconnections[p.UserId] = {} setupplayerhighlight(p) end else for _, p in pairs(Players:GetPlayers()) do removehighlight(p) end end end }):AddColorPicker("OutlineColor", { Default = Color3.fromRGB(255,255,255), Title = "Outline Color", Callback = function(v) espconfig.outlinecolor = v end }):AddColorPicker("OutlineFillColor", { Default = Color3.fromRGB(255,255,255), Title = "Fill Color", Callback = function(v) espconfig.outlinefillcolor = v end })
esptab:AddCheckbox("Tracers", { Text = "Tracers", Default = false, Callback = function(v) tracersenabled = v toggletracers() end }):AddColorPicker("TracerColor", { Default = Color3.fromRGB(255,255,255), Title = "Tracer Color", Callback = function(v) espconfig.tracercolor = v end })
esptab:AddCheckbox("SkeletonESP", { Text = "Skeleton ESP", Default = false, Callback = function(v) skeletonenabled = v toggleskeleton() end }):AddColorPicker("SkeletonColor", { Default = Color3.fromRGB(255,255,255), Title = "Skeleton Color", Callback = function(v) espconfig.skeletoncolor = v end })

configtab:AddCheckbox("RainbowESP", { Text = "Rainbow ESP", Default = false, Callback = function(v) espconfig.rainbowesp = v end })
configtab:AddCheckbox("RainbowOutline", { Text = "Rainbow Outline", Default = false, Callback = function(v) espconfig.rainbowoutline = v end })
configtab:AddCheckbox("RainbowTracers", { Text = "Rainbow Tracers", Default = false, Callback = function(v) espconfig.rainbowtracers = v end })
configtab:AddCheckbox("RainbowSkeleton", { Text = "Rainbow Skeleton ESP", Default = false, Callback = function(v) espconfig.rainbowskeleton = v end })
configtab:AddSlider("ESPSize", { Text = "ESP Size", Default = 16, Min = 16, Max = 48, Rounding = 1, Callback = function(v) espconfig.espsize = v end })
configtab:AddSlider("TracerSize", { Text = "Tracer Size", Default = 2, Min = 0.5, Max = 2, Rounding = 0.1, Callback = function(v) espconfig.tracersize = v end })
configtab:AddSlider("OutlineTransparency", { Text = "Outline Transparency", Default = 0, Min = 0, Max = 1, Rounding = 0.1, Callback = function(v) espconfig.outlinetransparency = v end })
configtab:AddSlider("OutlineFillTransparency", { Text = "Outline Fill Transparency", Default = 1, Min = 0, Max = 1, Rounding = 0.1, Callback = function(v) espconfig.outlinefilltransparency = v end })
configtab:AddSlider("RainbowSpeed", { Text = "Rainbow Speed", Default = 5, Min = 1, Max = 10, Rounding = 1, Callback = function(v) espconfig.rainbowspeed = v end })

local gamegroup = Tabs.Visuals:AddRightGroupbox("Game", "gamepad-2")
gamegroup:AddSlider("FieldOfView", { Text = "Field of View", Default = 70, Min = 60, Max = 120, Rounding = 1, Callback = function(v) Camera.FieldOfView = v end })
gamegroup:AddCheckbox("FullBright", { Text = "Full Bright", Default = false, Callback = function(v) fullbrightenabled = v if v then game.Lighting.Brightness = 2 game.Lighting.Ambient = Color3.fromRGB(255,255,255) game.Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255) else game.Lighting.Brightness = originallighting.Brightness game.Lighting.Ambient = originallighting.Ambient game.Lighting.OutdoorAmbient = originallighting.OutdoorAmbient end end })
gamegroup:AddCheckbox("NoFog", { Text = "No Fog", Default = false, Callback = function(v) nofogenabled = v if v then game.Lighting.FogEnd = 100000 game.Lighting.FogStart = 0 else game.Lighting.FogEnd = originallighting.FogEnd game.Lighting.FogStart = originallighting.FogStart end end })
gamegroup:AddCheckbox("AntiLag", { Text = "Anti Lag", Default = false, Callback = function(v) antillagenabled = v if v then originalsettings.QualityLevel = settings().Rendering.QualityLevel settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 setfpscap(999) for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("Texture") or obj:IsA("Decal") then originaltextures[obj] = obj.Texture obj.Texture = "" elseif obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then obj.Enabled = false elseif obj:IsA("BasePart") then originalmaterials[obj] = obj.Material obj.Material = Enum.Material.Plastic end end workspace.DescendantAdded:Connect(function(obj) if antillagenabled then if obj:IsA("Texture") or obj:IsA("Decal") then obj.Texture = "" elseif obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then obj.Enabled = false elseif obj:IsA("BasePart") then obj.Material = Enum.Material.Plastic end end end) else if originalsettings.QualityLevel then settings().Rendering.QualityLevel = originalsettings.QualityLevel end setfpscap(60) for obj, t in pairs(originaltextures) do if obj and obj.Parent then obj.Texture = t end end originaltextures = {} for obj, m in pairs(originalmaterials) do if obj and obj.Parent then obj.Material = m end end originalmaterials = {} for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then obj.Enabled = true end end end end })

local aimlocktabbox = Tabs.Features:AddLeftTabbox()
local aimlocktab = aimlocktabbox:AddTab("AimLock")
local aimlockconfigtab = aimlocktabbox:AddTab("Configurations")

aimlocktab:AddCheckbox("AimLock", { Text = "Activate Aimlock", Default = false, Callback = function(v) aimlockenabled = v end })
aimlocktab:AddDropdown("AimLockType", { Values = {"Nearest Player", "Nearest Mouse"}, Default = 1, Text = "Aimlock Type", Callback = function(v) aimlocktype = v end })
aimlocktab:AddCheckbox("WallCheck", { Text = "Wall Check", Default = false, Callback = function(v) wallcheckenabled = v end })
aimlocktab:AddCheckbox("AimLockCertainPlayer", { Text = "Aimlock Certain Player", Default = false, Callback = function(v) aimlockcertainplayer = v end })
aimlocktab:AddDropdown("AimLockPlayerSelect", { SpecialType = "Player", ExcludeLocalPlayer = true, Text = "Select Player", Callback = function(v) selectedplayer = v end })

aimlocktab:AddCheckbox("EnableFOV", { Text = "Enable FOV", Default = false, Callback = function(v) fovenabled = v if v then Options.AimLockType.Disabled = true else Options.AimLockType.Disabled = false end end }):AddColorPicker("FOVColor", { Default = Color3.fromRGB(255,255,255), Title = "FOV Color", Callback = function(v) fovcolor = v end })
aimlocktab:AddCheckbox("ShowFOV", { Text = "Show FOV", Default = false, Callback = function(v) showfov = v if v then if not fovgui then fovgui = Instance.new("ScreenGui") fovgui.Name = "FOVCircle" fovgui.IgnoreGuiInset = true fovgui.Parent = game:GetService("CoreGui") fovframe = Instance.new("Frame") fovframe.Name = "Circle" fovframe.AnchorPoint = Vector2.new(0.5, 0.5) fovframe.Position = UDim2.new(0.5, 0, 0.5, 0) fovframe.BackgroundTransparency = 1 fovframe.BorderSizePixel = 0 fovframe.Parent = fovgui local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(1, 0) corner.Parent = fovframe fovstroke = Instance.new("UIStroke") fovstroke.Color = Color3.fromRGB(255,255,255) fovstroke.Thickness = fovstrokethickness fovstroke.Parent = fovframe fovframe.Size = UDim2.new(0, fovsize, 0, fovsize) end fovframe.Visible = true else if fovframe then fovframe.Visible = false end end end })

aimlockconfigtab:AddSlider("NearestPlayerDistance", { Text = "Nearest Player Lock Distance (Studs)", Default = 1000, Min = 10, Max = 5000, Rounding = 1, Callback = function(v) nearestplayerdistance = v end })
aimlockconfigtab:AddSlider("NearestMouseDistance", { Text = "Nearest Mouse Lock Distance (Studs)", Default = 500, Min = 10, Max = 5000, Rounding = 1, Callback = function(v) nearestmousedistance = v end })
aimlockconfigtab:AddSlider("FOVLockDistance", { Text = "FOV Lock Distance (Studs)", Default = 1000, Min = 50, Max = 5000, Rounding = 1, Callback = function(v) fovlockdistance = v end })
aimlockconfigtab:AddCheckbox("SmoothAimlock", { Text = "Smooth Aimlock", Default = false, Callback = function(v) smoothaimlock = v end })
aimlockconfigtab:AddSlider("SmoothAimlockSpeed", { Text = "Smooth Aimlock Speed", Default = 5, Min = 1, Max = 100, Rounding = 1, Callback = function(v) lerpalpha = 1 / v end })
aimlockconfigtab:AddCheckbox("RainbowFOV", { Text = "Rainbow FOV", Default = false, Callback = function(v) rainbowfov = v end })
aimlockconfigtab:AddSlider("FOVSize", { Text = "FOV Size", Default = 100, Min = 1, Max = 750, Rounding = 1, Callback = function(v) fovsize = v if fovframe then fovframe.Size = UDim2.new(0, v, 0, v) end end })
aimlockconfigtab:AddSlider("FOVStrokeThickness", { Text = "FOV Stroke Thickness", Default = 2, Min = 1, Max = 10, Rounding = 1, Callback = function(v) fovstrokethickness = v if fovstroke then fovstroke.Thickness = v end end })
aimlockconfigtab:AddDivider()
aimlockconfigtab:AddDropdown("IgnorePlayers", { SpecialType = "Player", ExcludeLocalPlayer = true, Multi = true, Text = "Ignore Players", Callback = function(v) ignoredplayers = {} for p, s in pairs(v) do if s then ignoredplayers[p.Name] = true end end end })

aimlockconfigtab:AddDivider()
aimlockconfigtab:AddLabel("Advanced Configurations")
aimlockconfigtab:AddSlider("AimlockOffsetY", { Text = "Aimlock Offset (Y)", Default = 0, Min = -100, Max = 100, Rounding = 1, Callback = function(v) aimlockOffsetY = v end })
aimlockconfigtab:AddSlider("AimlockOffsetX", { Text = "Aimlock Offset (X)", Default = 0, Min = -100, Max = 100, Rounding = 1, Callback = function(v) aimlockOffsetX = v end })

local featuresGroup = Tabs.Features:AddRightGroupbox("Features", "zap")
featuresGroup:AddToggle("KnifeCloseToggle", { Text = "Switch To Knife When Close To Player", Default = false, Callback = function(v) knifeCloseEnabled = v toggleKnifeSwitch() end })
featuresGroup:AddSlider("KnifeRange", { Text = "S.T.K.W.C.T.P. Range", Default = 10, Min = 1, Max = 50, Rounding = 1, Suffix = " studs", Callback = function(v) knifeRange = v updateKnifeRangeSphere() end })
featuresGroup:AddToggle("ShowKnifeRange", { Text = "Show S.T.K.W.C.T.P. Range", Default = false, Callback = function(v) showKnifeRange = v updateKnifeRangeSphere() end }):AddColorPicker("KnifeRangeColor", { Default = Color3.fromRGB(255,255,255), Title = "Range Color", Transparency = 0.5, Callback = function(v, t) knifeRangeColor = v knifeRangeTransparency = t or 0.5 updateKnifeRangeSphere() end })

local menugroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "settings")
menugroup:AddInput("DPIScale", { Default = "100", Text = "DPI Scale", Callback = function(v) local dpi = tonumber(v) if dpi then Library:SetDPIScale(dpi) end end })
menugroup:AddCheckbox("KeybindMenuOpen", { Default = Library.KeybindFrame.Visible, Text = "Open Keybind Menu", Callback = function(v) Library.KeybindFrame.Visible = v end })
menugroup:AddCheckbox("ShowCustomCursor", { Text = "Custom Cursor", Default = true, Callback = function(v) Library.ShowCustomCursor = v end })
menugroup:AddDropdown("NotificationSide", { Values = { "Left", "Right" }, Default = "Right", Text = "Notification Side", Callback = function(v) Library:SetNotifySide(v) end })
menugroup:AddDropdown("DPIDropdown", { Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" }, Default = "100%", Text = "DPI Scale", Callback = function(v) v = v:gsub("%%", "") local dpi = tonumber(v) Library:SetDPIScale(dpi) end })
menugroup:AddDivider()
menugroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { NoUI = true, Text = "Menu keybind" })
menugroup:AddButton("Unload", function() Library:Unload() end)
menugroup:AddLabel("<font color='rgb(255,0,0)'><u>DISCLAIMER</u></font>: We Use This To See How Many Users We Get, <u>We Do Not Share This Information With Any Third Partys</u>.", true)
menugroup:AddCheckbox("OptOutLog", { Text = "Opt-Out Log", Default = isfile("optout.unx"), Callback = function(v) if v then writefile("optout.unx", "") Library:Notify("Opt-Out Log Enabled", 3) else if isfile("optout.unx") then delfile("optout.unx") end Library:Notify("Opt-Out Log Disabled", 3) end end })

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

Players.PlayerAdded:Connect(function(p)
	if espenabled then createesp(p) end
	if outlineenabled then playerconnections[p.UserId] = {} setupplayerhighlight(p) end
	p.CharacterAdded:Connect(function(c)
		if espenabled then task.wait(0.1) if not espobjects[p] then createesp(p) end end
		if outlineenabled then task.wait(0.1) applyhighlighttocharacter(p, c) end
	end)
end)

for _, p in pairs(Players:GetPlayers()) do
	if p ~= LocalPlayer then
		p.CharacterAdded:Connect(function(c)
			if espenabled then task.wait(0.1) if not espobjects[p] then createesp(p) end end
			if outlineenabled then task.wait(0.1) applyhighlighttocharacter(p, c) end
		end)
	end
end

local lastFPS = 0
local lastPing = 0
local version = getgenv().unxshared and getgenv().unxshared.version or "Unknown"

RunService.RenderStepped:Connect(function(dt)
	lastFPS = math.floor(1 / dt)
	fpsLabel:SetText("FPS: " .. lastFPS)
	lastPing = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
	pingLabel:SetText("Ping: " .. lastPing .. "ms")
	versionLabel:SetText("Version: " .. version)
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		healthLabel:SetText("Health: " .. math.floor(char.Humanoid.Health))
	else
		healthLabel:SetText("Health: 0")
	end
	updateKnifeRangeSphere()
	updateaimlock()
end)

Library:OnUnload(function()
	for p, _ in pairs(espobjects) do removeesp(p) end
	for _, p in pairs(Players:GetPlayers()) do removehighlight(p) end
	RunService:UnbindFromRenderStep("Tracers")
	RunService:UnbindFromRenderStep("SkeletonESP")
	if fovgui then fovgui:Destroy() end
	for _, l in ipairs(tracerlines) do l:Destroy() end
	for _, l in ipairs(skeletonlines) do l:Destroy() end
	if noVelocityConnection then noVelocityConnection:Disconnect() end
	if knifeConnection then knifeConnection:Disconnect() end
	if rangeSphere then rangeSphere:Destroy() end
	for obj, t in pairs(originaltransparencies) do if obj and obj.Parent then obj.Transparency = t end end originaltransparencies = {}
	if fullbrightenabled then game.Lighting.Brightness = originallighting.Brightness game.Lighting.Ambient = originallighting.Ambient game.Lighting.OutdoorAmbient = originallighting.OutdoorAmbient end
	if nofogenabled then game.Lighting.FogEnd = originallighting.FogEnd game.Lighting.FogStart = originallighting.FogStart end
	if antillagenabled then if originalsettings.QualityLevel then settings().Rendering.QualityLevel = originalsettings.QualityLevel end setfpscap(60) for obj, t in pairs(originaltextures) do if obj and obj.Parent then obj.Texture = t end end originaltextures = {} for obj, m in pairs(originalmaterials) do if obj and obj.Parent then obj.Material = m end end originalmaterials = {} for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then obj.Enabled = true end end end
end)

task.spawn(function()
	while true do
		task.wait()
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			LocalPlayer.Character.Humanoid.WalkSpeed = currentwalkspeed
		end
	end
end)

RunService.Heartbeat:Connect(function()
	if xrayenabled then
		for _, obj in pairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
				if not originaltransparencies[obj] then originaltransparencies[obj] = obj.Transparency end
				obj.Transparency = xraytransparency
			end
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if espenabled then updateesp() end
	if outlineenabled then
		for _, h in pairs(activehighlights) do
			if h then
				h.OutlineColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinecolor
				h.FillColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinefillcolor
			end
		end
	end
	updatefovcircle()
end)

Library.ToggleKeybind = Options.MenuKeybind
