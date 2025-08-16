-- hey

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles

local version = "1.2.0"
local gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local Window = Library:CreateWindow({
	Title = "UNXHub",
	Footer = "Version: " .. version .. ", Game: " .. gamename,
	Icon = 137779536741206,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

Library:Notify({
	Title = "Welcome To UNXHub " .. game.Players.LocalPlayer.Name .. "!",
	Description = "Script loaded successfully",
	Time = 5,
})

local Tabs = {
	Main = Window:AddTab("Main", "user"),
	Visuals = Window:AddTab("Visuals", "eye"),
	Features = Window:AddTab("Features", "bug"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

-- Fixed Roblox service capitalization
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local Stats = game:GetService("Stats")

local originalwalkspeed = 16
local originaljumppower = 50
local originalgravity = workspace.Gravity
local originallighting = {}
local noclipenabled = false
local infinitejumpenabled = false
local antiflingenabled = false
local antiafkenabled = false
local antivoidenabled = false
local antikickenabled = false
local antillagenabled = false
local fullbrightenabled = false
local nofogenabled = false
local noaccelerationenabled = false
local antiflingconnections = {}
local antiafkconnection = nil
local antivoidconnection = nil
local antikickconnections = {}
local originaltextures = {}
local lastposition = nil
local originalsettings = {}

originallighting.Brightness = game.Lighting.Brightness
originallighting.Ambient = game.Lighting.Ambient
originallighting.OutdoorAmbient = game.Lighting.OutdoorAmbient
originallighting.FogEnd = game.Lighting.FogEnd
originallighting.FogStart = game.Lighting.FogStart

local espenabled = false
local outlineenabled = false
local tracersenabled = false
local skeletonenabled = false

local espconfig = {
	showname = true,
	showdistance = true,
	espcolor = Color3.fromRGB(255, 255, 255),
	outlinecolor = Color3.fromRGB(255, 255, 255),
	outlinefillcolor = Color3.fromRGB(255, 255, 255),
	tracercolor = Color3.fromRGB(255, 255, 255),
	skeletoncolor = Color3.fromRGB(255, 255, 255),
	espsize = 16,
	tracersize = 2,
	esptransparency = 1,
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
local aimlocktype = "Nearest Player"
local fovenabled = false
local showfov = false
local fovsize = {X = 100, Y = 100}
local fovcolor = Color3.fromRGB(255, 255, 255)
local fovcircle = nil
local nearestplayerdistance = 1000
local nearestmousedistance = 500
local fovlockdistance = 1000
local rainbowfov = false
local aimlockcertainplayer = false
local selectedplayer = nil

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

local function getplayercolor(player)
	if player.Team then
		return player.TeamColor.Color
	else
		return Color3.new(1, 1, 1)
	end
end

local function createesp(player)
	if player == LocalPlayer then return end
	if espobjects[player] then return end
	
	local nametext = Drawing.new("Text")
	nametext.Size = espconfig.espsize
	nametext.Center = true
	nametext.Outline = true
	nametext.Color = espconfig.espcolor
	
	local infotext = Drawing.new("Text")
	infotext.Size = espconfig.espsize - 4
	infotext.Center = true
	infotext.Outline = true
	infotext.Color = espconfig.espcolor
	
	espobjects[player] = {
		Name = nametext,
		Info = infotext
	}
end

local function removeesp(player)
	if espobjects[player] then
		espobjects[player].Name:Remove()
		espobjects[player].Info:Remove()
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
			esp.Info.Color = color
			esp.Name.Size = espconfig.espsize
			esp.Info.Size = espconfig.espsize - 4
			
			if onscreen then
				local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				local health = humanoid and math.floor(humanoid.Health) or 0
				
				esp.Name.Position = Vector2.new(pos.X, pos.Y - 20)
				esp.Name.Text = espconfig.showname and player.Name or ""
				esp.Name.Visible = espconfig.showname
				
				esp.Info.Position = Vector2.new(pos.X, pos.Y - 7)
				esp.Info.Text = espconfig.showdistance and ("[Distance " .. math.floor(distance) .. "]") or ""
				esp.Info.Visible = espconfig.showdistance
			else
				esp.Name.Visible = false
				esp.Info.Visible = false
			end
		else
			removeesp(player)
		end
	end
end

local function applyhighlighttocharacter(player, character)
	local userid = player.UserId
	if activehighlights[userid] then
		activehighlights[userid]:Destroy()
	end
	
	local highlighter = Instance.new("Highlight")
	highlighter.Name = "PlayerHighlight"
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
		if outlineenabled then
			applyhighlighttocharacter(player, character)
		end
		
		table.insert(playerconnections[userid], player:GetPropertyChangedSignal("TeamColor"):Connect(function()
			local highlight = activehighlights[userid]
			if highlight then
				highlight.OutlineColor = espconfig.rainbowoutline and getrainbowcolor() or (player.TeamColor and player.TeamColor.Color) or espconfig.outlinecolor
			end
		end))
		
		table.insert(playerconnections[userid], humanoid.Died:Connect(function()
			removehighlight(player)
		end))
	end
	
	local charaddedconn = player.CharacterAdded:Connect(oncharacteradded)
	table.insert(playerconnections[userid], charaddedconn)
	
	if player.Character then
		oncharacteradded(player.Character)
	end
end

function removehighlight(player)
	local userid = player.UserId
	if activehighlights[userid] then
		activehighlights[userid]:Destroy()
		activehighlights[userid] = nil
	end
	
	if playerconnections[userid] then
		for _, conn in pairs(playerconnections[userid]) do
			conn:Disconnect()
		end
		playerconnections[userid] = nil
	end
end

local function toggletracers()
	if tracersenabled then
		RunService:BindToRenderStep("Tracers", Enum.RenderPriority.Camera.Value + 1, function()
			for _, line in ipairs(tracerlines) do
				line:Destroy()
			end
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
		for _, line in ipairs(tracerlines) do
			line:Destroy()
		end
		tracerlines = {}
	end
end

local function toggleskeleton()
	if skeletonenabled then
		RunService:BindToRenderStep("SkeletonESP", Enum.RenderPriority.Camera.Value + 1, function()
			for _, line in ipairs(skeletonlines) do
				line:Destroy()
			end
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
					
					local function getscreen(part)
						if part then
							local pos, visible = Camera:WorldToViewportPoint(part.Position)
							if visible then return Vector2.new(pos.X, pos.Y) end
						end
						return nil
					end
					
					local function drawline(p1, p2)
						if p1 and p2 then
							local line = Drawing.new("Line")
							line.From = p1
							line.To = p2
							line.Color = color
							line.Thickness = 2
							line.Transparency = 1
							line.Visible = true
							table.insert(skeletonlines, line)
						end
					end
					
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
		for _, line in ipairs(skeletonlines) do
			line:Destroy()
		end
		skeletonlines = {}
	end
end

local function getclosestplayer()
	local closestplayer = nil
	local shortestdistance = math.huge
	
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
			
			if aimlocktype == "Nearest Player" and distance < nearestplayerdistance and distance < shortestdistance then
				closestplayer = player
				shortestdistance = distance
			elseif aimlocktype == "Nearest Mouse" and distance < nearestmousedistance then
				local screenpos, onscreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
				if onscreen then
					local mousedistance = (Vector2.new(screenpos.X, screenpos.Y) - Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)).Magnitude
					if mousedistance < shortestdistance then
						closestplayer = player
						shortestdistance = mousedistance
					end
				end
			end
		end
	end
	
	if fovenabled and closestplayer then
		local screenpos, onscreen = Camera:WorldToViewportPoint(closestplayer.Character.HumanoidRootPart.Position)
		if onscreen then
			local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
			local distance = (Vector2.new(screenpos.X, screenpos.Y) - center).Magnitude
			local worlddistance = (LocalPlayer.Character.HumanoidRootPart.Position - closestplayer.Character.HumanoidRootPart.Position).Magnitude
			
			if distance > math.min(fovsize.X, fovsize.Y) / 2 or worlddistance > fovlockdistance then
				return nil
			end
		end
	end
	
	return closestplayer
end

local function updateaimlock()
	if not aimlockenabled then return end
	
	local targetplayer = nil
	
	if aimlockcertainplayer and selectedplayer then
		targetplayer = selectedplayer
	else
		targetplayer = getclosestplayer()
	end
	
	if targetplayer and targetplayer.Character and targetplayer.Character:FindFirstChild("Head") then
		local targetposition = targetplayer.Character.Head.Position
		local lookdirection = (targetposition - Camera.CFrame.Position).Unit
		Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, Camera.CFrame.Position + lookdirection)
	end
end

local function updatefovcircle()
	if showfov and fovcircle then
		fovcircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
		fovcircle.Radius = math.min(fovsize.X, fovsize.Y) / 2
		fovcircle.Color = rainbowfov and getrainbowcolor() or fovcolor
		fovcircle.Visible = true
	end
end

local function setupantifling()
	if antiflingenabled then
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				for _, part in pairs(player.Character:GetChildren()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end
		
		antiflingconnections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
			player.CharacterAdded:Connect(function(character)
				if antiflingenabled then
					for _, part in pairs(character:GetChildren()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)
		end)
		
		antiflingconnections.CharacterAdded = {}
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer then
				antiflingconnections.CharacterAdded[player] = player.CharacterAdded:Connect(function(character)
					if antiflingenabled then
						for _, part in pairs(character:GetChildren()) do
							if part:IsA("BasePart") then
								part.CanCollide = false
							end
						end
					end
				end)
			end
		end
	else
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				for _, part in pairs(player.Character:GetChildren()) do
					if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
						part.CanCollide = true
					end
				end
			end
		end
		
		for _, connection in pairs(antiflingconnections) do
			if typeof(connection) == "RBXScriptConnection" then
				connection:Disconnect()
			elseif typeof(connection) == "table" then
				for _, conn in pairs(connection) do
					conn:Disconnect()
				end
			end
		end
		antiflingconnections = {}
	end
end

local playergroup = Tabs.Main:AddLeftGroupbox("Player", "user")

-- Added variables to track slider values and continuous application
local currentwalkspeed = 16
local currentjumppower = 50
local currentgravity = 196.2

playergroup:AddSlider("WalkSpeed", {
	Text = "WalkSpeed",
	Default = 16,
	Min = 0,
	Max = 100,
	Rounding = 1,
	Callback = function(Value)
		currentwalkspeed = Value
	end,
})

playergroup:AddSlider("JumpPower", {
	Text = "JumpPower",
	Default = 50,
	Min = 0,
	Max = 200,
	Rounding = 1,
	Callback = function(Value)
		currentjumppower = Value
	end,
})

playergroup:AddSlider("Gravity", {
	Text = "Gravity",
	Default = 196.2,
	Min = 0,
	Max = 500,
	Rounding = 1,
	Callback = function(Value)
		currentgravity = Value
	end,
})

playergroup:AddCheckbox("NoAcceleration", {
	Text = "No Acceleration",
	Default = false,
	Callback = function(Value)
		noaccelerationenabled = Value
		local character = LocalPlayer.Character
		if character and character:FindFirstChild("Humanoid") then
			if Value then
				character.Humanoid.WalkSpeed = character.Humanoid.WalkSpeed
				character.Humanoid.JumpPower = character.Humanoid.JumpPower
			else
				character.Humanoid.WalkSpeed = originalwalkspeed
				character.Humanoid.JumpPower = originaljumppower
			end
		end
	end,
})

playergroup:AddDivider()

playergroup:AddCheckbox("AntiFling", {
	Text = "Anti-Fling",
	Default = false,
	Callback = function(Value)
		antiflingenabled = Value
		setupantifling()
	end,
})

playergroup:AddCheckbox("AntiAFK", {
	Text = "Anti-AFK",
	Default = false,
	Callback = function(Value)
		antiafkenabled = Value
		if Value then
			antiafkconnection = RunService.Heartbeat:Connect(function()
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local currentpos = LocalPlayer.Character.HumanoidRootPart.Position
					if not lastposition then
						lastposition = currentpos
					end
					
					if (currentpos - lastposition).Magnitude < 0.1 then
						LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 0.1, 0)
						wait(0.1)
						LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame - Vector3.new(0, 0.1, 0)
					end
					lastposition = currentpos
				end
			end)
		else
			if antiafkconnection then
				antiafkconnection:Disconnect()
				antiafkconnection = nil
			end
		end
	end,
})

playergroup:AddCheckbox("AntiVoid", {
	Text = "Anti-Void",
	Default = false,
	Callback = function(Value)
		antivoidenabled = Value
		if Value then
			antivoidconnection = RunService.Heartbeat:Connect(function()
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					if LocalPlayer.Character.HumanoidRootPart.Position.Y < -100 then
						LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
					end
				end
			end)
		else
			if antivoidconnection then
				antivoidconnection:Disconnect()
				antivoidconnection = nil
			end
		end
	end,
})

playergroup:AddCheckbox("AntiKick", {
	Text = "Anti-Kick",
	Default = false,
	Callback = function(Value)
		antikickenabled = Value
		if Value then
			local mt = getrawmetatable(game)
			local oldnamecall = mt.__namecall
			setreadonly(mt, false)
			
			mt.__namecall = function(self, ...)
				local method = getnamecallmethod()
				if method == "Kick" then
					return
				end
				return oldnamecall(self, ...)
			end
			
			setreadonly(mt, true)
		end
	end,
})

playergroup:AddDivider()

playergroup:AddCheckbox("Noclip", {
	Text = "Noclip",
	Default = false,
	Callback = function(Value)
		noclipenabled = Value
		local character = LocalPlayer.Character
		if character then
			for _, part in pairs(character:GetChildren()) do
				if part:IsA("BasePart") then
					part.CanCollide = not Value
				end
			end
		end
	end,
}):AddKeyPicker("NoclipKey", {
	Default = "N",
	Text = "Noclip",
	Callback = function()
		Toggles.Noclip:SetValue(not Toggles.Noclip.Value)
	end,
})

playergroup:AddCheckbox("InfiniteJump", {
	Text = "Infinite Jump",
	Default = false,
	Callback = function(Value)
		infinitejumpenabled = Value
	end,
}):AddKeyPicker("InfiniteJumpKey", {
	Default = "J",
	Text = "Infinite Jump",
	Callback = function()
		Toggles.InfiniteJump:SetValue(not Toggles.InfiniteJump.Value)
	end,
})

local statusgroup = Tabs.Main:AddLeftGroupbox("Status", "activity")

local fpslabel = statusgroup:AddLabel("FPS: 0")
local pinglabel = statusgroup:AddLabel("PING: 0")
local versionlabel = statusgroup:AddLabel("UNXHub Ver.: " .. version)

statusgroup:AddDivider()

local pinglabel2 = statusgroup:AddLabel("PING: 0")

spawn(function()
	while true do
		local fps = math.floor(1 / RunService.Heartbeat:Wait())
		fpslabel:SetText("FPS: " .. fps)
		wait(1)
	end
end)

spawn(function()
	while true do
		local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
		pinglabel:SetText("PING: " .. ping)
		pinglabel2:SetText("PING: " .. ping)
		wait(0.001)
	end
end)

local othergroup = Tabs.Main:AddRightGroupbox("Other", "more-horizontal")

othergroup:AddButton({
	Text = "Reset",
	Func = function()
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			LocalPlayer.Character.Humanoid.Health = 0
		end
	end,
})

othergroup:AddButton({
	Text = "Rejoin",
	Func = function()
		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end,
})

-- Added divider and reset buttons
othergroup:AddDivider()

othergroup:AddButton({
	Text = "Reset WalkSpeed",
	Func = function()
		currentwalkspeed = 16
		Options.WalkSpeed:SetValue(16)
	end,
})

othergroup:AddButton({
	Text = "Reset JumpPower",
	Func = function()
		currentjumppower = 50
		Options.JumpPower:SetValue(50)
	end,
})

othergroup:AddButton({
	Text = "Reset Gravity",
	Func = function()
		currentgravity = 196.2
		Options.Gravity:SetValue(196.2)
	end,
})

local esptabbox = Tabs.Visuals:AddLeftTabbox()
local esptab = esptabbox:AddTab("ESP")
local configtab = esptabbox:AddTab("Configurations")

esptab:AddCheckbox("ESP", {
	Text = "ESP",
	Default = false,
	Callback = function(Value)
		espenabled = Value
		if Value then
			for _, player in pairs(Players:GetPlayers()) do
				createesp(player)
			end
		else
			for player, _ in pairs(espobjects) do
				removeesp(player)
			end
		end
	end,
}):AddColorPicker("ESPColor", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "ESP Color",
	Callback = function(Value)
		espconfig.espcolor = Value
	end,
})

esptab:AddCheckbox("Outline", {
	Text = "Outline",
	Default = false,
	Callback = function(Value)
		outlineenabled = Value
		if Value then
			for _, player in pairs(Players:GetPlayers()) do
				playerconnections[player.UserId] = {}
				setupplayerhighlight(player)
			end
		else
			for _, player in pairs(Players:GetPlayers()) do
				removehighlight(player)
			end
		end
	end,
}):AddColorPicker("OutlineColor", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "Outline Color",
	Callback = function(Value)
		espconfig.outlinecolor = Value
	end,
}):AddColorPicker("OutlineFillColor", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "Fill Color",
	Callback = function(Value)
		espconfig.outlinefillcolor = Value
	end,
})

esptab:AddCheckbox("Tracers", {
	Text = "Tracers",
	Default = false,
	Callback = function(Value)
		tracersenabled = Value
		toggletracers()
	end,
}):AddColorPicker("TracerColor", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "Tracer Color",
	Callback = function(Value)
		espconfig.tracercolor = Value
	end,
})

esptab:AddCheckbox("SkeletonESP", {
	Text = "Skeleton ESP",
	Default = false,
	Callback = function(Value)
		skeletonenabled = Value
		toggleskeleton()
	end,
}):AddColorPicker("SkeletonColor", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "Skeleton Color",
	Callback = function(Value)
		espconfig.skeletoncolor = Value
	end,
})

configtab:AddCheckbox("ShowName", {
	Text = "Show Name",
	Default = true,
	Callback = function(Value)
		espconfig.showname = Value
	end,
})

configtab:AddCheckbox("ShowDistance", {
	Text = "Show Distance",
	Default = true,
	Callback = function(Value)
		espconfig.showdistance = Value
	end,
})

configtab:AddCheckbox("RainbowESP", {
	Text = "Rainbow ESP",
	Default = false,
	Callback = function(Value)
		espconfig.rainbowesp = Value
	end,
})

configtab:AddCheckbox("RainbowOutline", {
	Text = "Rainbow Outline",
	Default = false,
	Callback = function(Value)
		espconfig.rainbowoutline = Value
	end,
})

configtab:AddCheckbox("RainbowTracers", {
	Text = "Rainbow Tracers",
	Default = false,
	Callback = function(Value)
		espconfig.rainbowtracers = Value
	end,
})

configtab:AddCheckbox("RainbowSkeleton", {
	Text = "Rainbow Skeleton ESP",
	Default = false,
	Callback = function(Value)
		espconfig.rainbowskeleton = Value
	end,
})

configtab:AddSlider("ESPSize", {
	Text = "ESP Size",
	Default = 16,
	Min = 16,
	Max = 48,
	Rounding = 1,
	Callback = function(Value)
		espconfig.espsize = Value
	end,
})

configtab:AddSlider("TracerSize", {
	Text = "Tracer Size",
	Default = 2,
	Min = 0.5,
	Max = 2,
	Rounding = 0.1,
	Callback = function(Value)
		espconfig.tracersize = Value
	end,
})

configtab:AddSlider("OutlineTransparency", {
	Text = "Outline Transparency",
	Default = 0,
	Min = 0,
	Max = 1,
	Rounding = 0.1,
	Callback = function(Value)
		espconfig.outlinetransparency = Value
	end,
})

configtab:AddSlider("OutlineFillTransparency", {
	Text = "Outline Fill Transparency",
	Default = 1,
	Min = 0,
	Max = 1,
	Rounding = 0.1,
	Callback = function(Value)
		espconfig.outlinefilltransparency = Value
	end,
})

configtab:AddSlider("RainbowSpeed", {
	Text = "Rainbow Speed",
	Default = 5,
	Min = 1,
	Max = 10,
	Rounding = 1,
	Callback = function(Value)
		espconfig.rainbowspeed = Value
	end,
})

local gamegroup = Tabs.Visuals:AddRightGroupbox("Game", "gamepad-2")

-- Added Field of View slider above Full Bright
gamegroup:AddSlider("FieldOfView", {
	Text = "Field of View",
	Default = 70,
	Min = 60,
	Max = 120,
	Rounding = 1,
	Callback = function(Value)
		workspace.CurrentCamera.FieldOfView = Value
	end,
})

gamegroup:AddCheckbox("FullBright", {
	Text = "Full Bright",
	Default = false,
	Callback = function(Value)
		fullbrightenabled = Value
		if Value then
			game.Lighting.Brightness = 2
			game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
			game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
		else
			game.Lighting.Brightness = originallighting.Brightness
			game.Lighting.Ambient = originallighting.Ambient
			game.Lighting.OutdoorAmbient = originallighting.OutdoorAmbient
		end
	end,
})

gamegroup:AddCheckbox("NoFog", {
	Text = "No Fog",
	Default = false,
	Callback = function(Value)
		nofogenabled = Value
		if Value then
			game.Lighting.FogEnd = 100000
			game.Lighting.FogStart = 0
		else
			game.Lighting.FogEnd = originallighting.FogEnd
			game.Lighting.FogStart = originallighting.FogStart
		end
	end,
})

gamegroup:AddCheckbox("AntiLag", {
	Text = "Anti Lag",
	Default = false,
	Callback = function(Value)
		antillagenabled = Value
		if Value then
			originalsettings.RenderDistance = workspace.CurrentCamera.RenderDistance
			originalsettings.QualityLevel = settings().Rendering.QualityLevel
			
			workspace.CurrentCamera.RenderDistance = 50
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
			
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("Texture") or obj:IsA("Decal") then
					originaltextures[obj] = obj.Texture
					obj.Texture = ""
				elseif obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
					obj.Enabled = false
				end
			end
		else
			if originalsettings.RenderDistance then
				workspace.CurrentCamera.RenderDistance = originalsettings.RenderDistance
			end
			if originalsettings.QualityLevel then
				settings().Rendering.QualityLevel = originalsettings.QualityLevel
			end
			
			for obj, texture in pairs(originaltextures) do
				if obj and obj.Parent then
					obj.Texture = texture
				end
			end
			originaltextures = {}
			
			for _, obj in pairs(workspace:GetDescendants()) do
				if obj:IsA("ParticleEmitter") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
					obj.Enabled = true
				end
			end
		end
	end,
})

local teleportgroup = Tabs.Features:AddLeftGroupbox("Teleport", "zap")

local playerlist = {}

local function updateplayerlist()
	playerlist = {}
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			table.insert(playerlist, player.Name)
		end
	end
	Options.TeleportPlayer:SetValues(playerlist)
end

teleportgroup:AddDropdown("TeleportPlayer", {
	Values = playerlist,
	Default = 1,
	Text = "Select Player",
	Callback = function(Value)
	end,
})

teleportgroup:AddButton({
	Text = "Teleport To",
	Func = function()
		local selectedplayername = Options.TeleportPlayer.Value
		local targetplayer = Players:FindFirstChild(selectedplayername)
		
		if targetplayer and targetplayer.Character and targetplayer.Character:FindFirstChild("HumanoidRootPart") then
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = targetplayer.Character.HumanoidRootPart.CFrame
			end
		end
	end,
})

local autochatgroup = Tabs.Features:AddLeftGroupbox("Auto Chat", "message-circle")

autochatgroup:AddCheckbox("AutoChat", {
	Text = "Auto Chat",
	Default = false,
	Callback = function(Value)
	end,
})

autochatgroup:AddInput("AutoChatMessage", {
	Default = "Hello World!",
	Text = "Chat Message",
	Callback = function(Value)
	end,
})

autochatgroup:AddSlider("AutoChatDelay", {
	Text = "Auto Chat Delay",
	Default = 1,
	Min = 0.1,
	Max = 5,
	Rounding = 0.1,
	Callback = function(Value)
	end,
})

local servergroup = Tabs.Features:AddRightGroupbox("Server Options", "server")

servergroup:AddButton({
	Text = "Copy Server JobID",
	Func = function()
		setclipboard(game.JobId)
		Library:Notify("Server JobID copied to clipboard!", 3)
	end,
})

servergroup:AddInput("ServerJobID", {
	Default = "",
	Text = "Server JobID",
	Callback = function(Value)
	end,
})

servergroup:AddButton({
	Text = "Join Server",
	Func = function()
		local jobid = Options.ServerJobID.Value
		if jobid and jobid ~= "" then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, jobid, LocalPlayer)
		end
	end,
})

local fpsgroup = Tabs.Features:AddRightGroupbox("FPS Control", "gauge")

fpsgroup:AddSlider("FPSCap", {
	Text = "FPS Cap",
	Default = 60,
	Min = 1,
	Max = 520,
	Rounding = 1,
	Callback = function(Value)
		setfpscap(Value)
	end,
})

fpsgroup:AddDropdown("FPSPresets", {
	Values = {"24", "30", "60", "120", "240", "460", "520"},
	Default = 3,
	Text = "FPS Presets",
	Callback = function(Value)
		local fps = tonumber(Value)
		if fps then
			setfpscap(fps)
			Options.FPSCap:SetValue(fps)
		end
	end,
})

fpsgroup:AddButton({
	Text = "Unlimited FPS",
	Func = function()
		setfpscap(9999)
		Options.FPSCap:SetValue(520)
	end,
})

-- Added AimLock UI elements after FPS Control group
local aimlocktabbox = Tabs.Features:AddLeftTabbox()
local aimlocktab = aimlocktabbox:AddTab("AimLock")
local aimlockconfigtab = aimlocktabbox:AddTab("Configurations")

aimlocktab:AddCheckbox("AimLock", {
	Text = "Activate Aimlock",
	Default = false,
	Callback = function(Value)
		aimlockenabled = Value
	end,
})

aimlocktab:AddDropdown("AimLockType", {
	Values = {"Nearest Player", "Nearest Mouse"},
	Default = 1,
	Text = "Aimlock Type",
	Callback = function(Value)
		aimlocktype = Value
	end,
})

aimlocktab:AddCheckbox("AimLockCertainPlayer", {
	Text = "Aimlock Certain Player",
	Default = false,
	Callback = function(Value)
		aimlockcertainplayer = Value
	end,
})

local aimlockplayerlist = {}
local function updateaimlockplayerlist()
	aimlockplayerlist = {}
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			table.insert(aimlockplayerlist, player.Name)
		end
	end
	Options.AimLockPlayerSelect:SetValues(aimlockplayerlist)
end

aimlocktab:AddDropdown("AimLockPlayerSelect", {
	Values = aimlockplayerlist,
	Default = 1,
	Text = "Select Player",
	Callback = function(Value)
		selectedplayer = Players:FindFirstChild(Value)
	end,
})

aimlocktab:AddCheckbox("EnableFOV", {
	Text = "Enable FOV",
	Default = false,
	Callback = function(Value)
		fovenabled = Value
		if Value then
			Options.AimLockType.Disabled = true
		else
			Options.AimLockType.Disabled = false
		end
	end,
})

aimlocktab:AddCheckbox("ShowFOV", {
	Text = "Show FOV (Feature Is Broken)",
	Default = false,
	Tooltip = "Feature Is Broken",
	Callback = function(Value)
		showfov = false
	end,
}):AddColorPicker("FOVColor", {
	Default = Color3.fromRGB(255, 255, 255),
	Title = "FOV Color",
	Callback = function(Value)
		fovcolor = Value
	end,
})

-- Fixed nil reference by checking if Options.ShowFOV exists before setting Disabled
if Options.ShowFOV then
	Options.ShowFOV.Disabled = true
end

aimlockconfigtab:AddSlider("NearestPlayerDistance", {
	Text = "Nearest Player Lock Distance (Studs)",
	Default = 1000,
	Min = 10,
	Max = 5000,
	Rounding = 1,
	Callback = function(Value)
		nearestplayerdistance = Value
	end,
})

aimlockconfigtab:AddSlider("NearestMouseDistance", {
	Text = "Nearest Mouse Lock Distance (Studs)",
	Default = 500,
	Min = 10,
	Max = 5000,
	Rounding = 1,
	Callback = function(Value)
		nearestmousedistance = Value
	end,
})

aimlockconfigtab:AddSlider("FOVLockDistance", {
	Text = "FOV Lock Distance (Studs)",
	Default = 1000,
	Min = 50,
	Max = 5000,
	Rounding = 1,
	Callback = function(Value)
		fovlockdistance = Value
	end,
})

aimlockconfigtab:AddCheckbox("RainbowFOV", {
	Text = "Rainbow FOV",
	Default = false,
	Callback = function(Value)
		rainbowfov = Value
	end,
})

aimlockconfigtab:AddSlider("FOVSizeX", {
	Text = "FOV Size (X)",
	Default = 100,
	Min = 50,
	Max = 500,
	Rounding = 1,
	Callback = function(Value)
		fovsize.X = Value
		if fovcircle then
			fovcircle.Radius = math.min(fovsize.X, fovsize.Y) / 2
		end
	end,
})

aimlockconfigtab:AddSlider("FOVSizeY", {
	Text = "FOV Size (Y)",
	Default = 100,
	Min = 50,
	Max = 500,
	Rounding = 1,
	Callback = function(Value)
		fovsize.Y = Value
		if fovcircle then
			fovcircle.Radius = math.min(fovsize.X, fovsize.Y) / 2
		end
	end,
})

local menugroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "settings")

menugroup:AddCheckbox("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "Open Keybind Menu",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
	end,
})

menugroup:AddCheckbox("ShowCustomCursor", {
	Text = "Custom Cursor",
	Default = true,
	Callback = function(Value)
		Library.ShowCustomCursor = Value
	end,
})

menugroup:AddDropdown("NotificationSide", {
	Values = { "Left", "Right" },
	Default = "Right",
	Text = "Notification Side",
	Callback = function(Value)
		Library:SetNotifySide(Value)
	end,
})

menugroup:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",
	Text = "DPI Scale",
	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local dpi = tonumber(Value)
		Library:SetDPIScale(dpi)
	end,
})

menugroup:AddDivider()

menugroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

menugroup:AddButton("Unload", function()
	Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")

SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

SaveManager:LoadAutoloadConfig()

-- Added AimLock player list updates in the player events section
Players.PlayerAdded:Connect(function(player)
	if espenabled then
		createesp(player)
	end
	if outlineenabled then
		playerconnections[player.UserId] = {}
		setupplayerhighlight(player)
	end
	updateplayerlist()
	updateaimlockplayerlist()
end)

Players.PlayerRemoving:Connect(function(player)
	removeesp(player)
	removehighlight(player)
	updateplayerlist()
	updateaimlockplayerlist()
end)

spawn(function()
	while true do
		task.wait()
		updateplayerlist()
		updateaimlockplayerlist()
	end
end)

-- Added AimLock update call in the main render loop
RunService.RenderStepped:Connect(function()
	if espenabled then
		updateesp()
	end
	
	if outlineenabled then
		for userid, highlight in pairs(activehighlights) do
			if highlight then
				highlight.OutlineColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinecolor
				highlight.FillColor = espconfig.rainbowoutline and getrainbowcolor() or espconfig.outlinefillcolor
				highlight.OutlineTransparency = espconfig.outlinetransparency
				highlight.FillTransparency = espconfig.outlinefilltransparency
			end
		end
	end
	
	updateaimlock()
	
	if showfov then
		if not fovcircle then
			fovcircle = Drawing.new("Circle")
			fovcircle.Thickness = 1
			fovcircle.NumSides = 100
			fovcircle.Filled = false
		end
		updatefovcircle()
	else
		if fovcircle then
			fovcircle:Remove()
			fovcircle = nil
		end
	end
end)

-- Added continuous application loop at the end of the script before Library:OnUnload
task.spawn(function()
	while true do
		task.wait()
		local character = LocalPlayer.Character
		if character and character:FindFirstChild("Humanoid") then
			character.Humanoid.WalkSpeed = currentwalkspeed
			character.Humanoid.JumpPower = currentjumppower
		end
		workspace.Gravity = currentgravity
	end
end)

Library:OnUnload(function()
	for player, _ in pairs(espobjects) do
		removeesp(player)
	end
	
	for _, player in pairs(Players:GetPlayers()) do
		removehighlight(player)
	end
	
	RunService:UnbindFromRenderStep("Tracers")
	RunService:UnbindFromRenderStep("SkeletonESP")
	
	if fovcircle then
		fovcircle:Remove()
	end
	
	for _, line in ipairs(tracerlines) do
		line:Destroy()
	end
	
	for _, line in ipairs(skeletonlines) do
		line:Destroy()
	end
end)
