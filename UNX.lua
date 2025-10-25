--[[IF UR HERE FOR THE SOURCE CODE; CHECK GAMES FOLDER!UNX LOADER]]

if getgenv().unxshared and getgenv().unxshared.isloaded == true then
warn("UNXHub is already loaded. Skipping initialization.")
return
end
local a = game:GetService("Players")
local b = a.LocalPlayer
local c = game:GetService("CoreGui")
local d = Instance.new("ScreenGui")
d.Name = "UNXLoader"
d.ResetOnSpawn = false
d.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
d.Parent = c
local e = Instance.new("Frame")
e.Size = UDim2.new(0, 400, 0, 320)
e.Position = UDim2.new(0.5, -200, 0.5, -160)
e.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
e.BorderSizePixel = 0
e.Parent = d
local f = Instance.new("UICorner")
f.CornerRadius = UDim.new(0, 12)
f.Parent = e
local dragToggle = nil
local dragSpeed = 0
local dragInput = nil
local dragStart = nil
local startPos = nil
local function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService("TweenService"):Create(e, TweenInfo.new(dragSpeed), {Position = position}):Play()
end
e.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragToggle = true
		dragStart = input.Position
		startPos = e.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)
e.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragToggle then
		updateInput(input)
	end
end)
local g = Instance.new("TextLabel")
g.Size = UDim2.new(1, -40, 0, 50)
g.Position = UDim2.new(0, 20, 0, 20)
g.BackgroundTransparency = 1
g.Text = "UNXHub Loader"
g.TextColor3 = Color3.fromRGB(255, 255, 255)
g.TextSize = 24
g.Font = Enum.Font.GothamBold
g.TextXAlignment = Enum.TextXAlignment.Left
g.Parent = e
local h = Instance.new("TextLabel")
h.Size = UDim2.new(1, -40, 0, 30)
h.Position = UDim2.new(0, 20, 0, 80)
h.BackgroundTransparency = 1
h.Text = "Initializing..."
h.TextColor3 = Color3.fromRGB(200, 200, 200)
h.TextSize = 16
h.Font = Enum.Font.Gotham
h.TextXAlignment = Enum.TextXAlignment.Left
h.Parent = e
local consoleFrame = Instance.new("ScrollingFrame")
consoleFrame.Size = UDim2.new(1, -40, 0, 120)
consoleFrame.Position = UDim2.new(0, 20, 0, 120)
consoleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
consoleFrame.BorderSizePixel = 0
consoleFrame.ScrollBarThickness = 4
consoleFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
consoleFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
consoleFrame.Parent = e
local consoleCorner = Instance.new("UICorner")
consoleCorner.CornerRadius = UDim.new(0, 6)
consoleCorner.Parent = consoleFrame
local consoleLayout = Instance.new("UIListLayout")
consoleLayout.Padding = UDim.new(0, 4)
consoleLayout.SortOrder = Enum.SortOrder.LayoutOrder
consoleLayout.Parent = consoleFrame
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 80, 0, 28)
copyButton.Position = UDim2.new(1, -100, 0, 120)
copyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
copyButton.BorderSizePixel = 0
copyButton.Text = "Copy"
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.TextSize = 14
copyButton.Font = Enum.Font.GothamBold
copyButton.Parent = e
local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 6)
copyCorner.Parent = copyButton
local consoleMessages = {}
local function addConsoleMessage(message)
	table.insert(consoleMessages, message)
	local messageLabel = Instance.new("TextLabel")
	messageLabel.Size = UDim2.new(1, -10, 0, 20)
	messageLabel.BackgroundTransparency = 1
	messageLabel.Text = "> " .. message
	messageLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
	messageLabel.TextSize = 12
	messageLabel.Font = Enum.Font.Code
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.TextYAlignment = Enum.TextYAlignment.Top
	messageLabel.TextWrapped = true
	messageLabel.Parent = consoleFrame
	messageLabel.Size = UDim2.new(1, -10, 0, messageLabel.TextBounds.Y)
	consoleFrame.CanvasSize = UDim2.new(0, 0, 0, consoleLayout.AbsoluteContentSize.Y)
	consoleFrame.CanvasPosition = Vector2.new(0, consoleLayout.AbsoluteContentSize.Y)
end
copyButton.MouseButton1Click:Connect(function()
	local fullLog = table.concat(consoleMessages, "\n")
	pcall(function()
		setclipboard(fullLog)
	end)
	copyButton.Text = "Copied!"
	copyButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
	task.wait(1)
	copyButton.Text = "Copy"
	copyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
local i = Instance.new("Frame")
i.Size = UDim2.new(0, 360, 0, 4)
i.Position = UDim2.new(0, 20, 1, -30)
i.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
i.BorderSizePixel = 0
i.Parent = e
local j = Instance.new("UICorner")
j.CornerRadius = UDim.new(0, 2)
j.Parent = i
local k = Instance.new("Frame")
k.Size = UDim2.new(0, 80, 1, 0)
k.Position = UDim2.new(0, 0, 0, 0)
k.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
k.BorderSizePixel = 0
k.Parent = i
local l = Instance.new("UICorner")
l.CornerRadius = UDim.new(0, 2)
l.Parent = k
local m = game:GetService("RunService")
local n = m.Heartbeat:Connect(function()
	local o = tick() % 5 / 5
	k.BackgroundColor3 = Color3.fromHSV(o, 1, 1)
end)
local p = game:GetService("TweenService")
local q = TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local r = p:Create(k, q, {Position = UDim2.new(1, -80, 0, 0)})
r:Play()
local function s(t)
	h.Text = t
	addConsoleMessage(t)
end
s("UNXHub Loader v2.1.0 initialized")
task.wait(0.3)
s("Creating global variables...")
task.wait(0.4)
getgenv().unxshared = {
	version = "2.1.0a",
	gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
	issupported = false,
	playername = b.Name,
	playerid = b.UserId,
	isloaded = false,
	devnote = "ues - luiz"
}

-- ✅ changed from GitHub to your custom API:
loadstring(game:HttpGet("https://apigetunx.vercel.app/Modules/v2/Log.lua", true))()

s("Player: " .. b.Name .. " (ID: " .. b.UserId .. ")")
task.wait(0.3)
s("Game: " .. getgenv().unxshared.gamename)
task.wait(0.3)
s("Checking game compatibility...")
task.wait(0.4)
local u = game.PlaceId
s("Game ID: " .. tostring(u))
task.wait(0.3)
local v = {
	[1240123653] = "https://apigetunx.vercel.app/Games/ZombieAttack.lua",
	[1632210982] = "https://apigetunx.vercel.app/Games/ZombieAttack.lua",
	[12240122896] = "https://apigetunx.vercel.app/Games/FigureL.lua"
}
local w, x
if v[u] then
	getgenv().unxshared.issupported = true
	s("Game verified, loading " .. getgenv().unxshared.gamename .." | Dev Note: ".. getgenv().unxshared.devnote)
	task.wait(0.4)
	s("Fetching game-specific script...")
	task.wait(0.3)
	w, x = pcall(function()
		loadstring(game:HttpGet(v[u]))()
	end)
else
	getgenv().unxshared.issupported = false
	s("Game not supported, loading universal")
	task.wait(0.4)
	s("Fetching universal script...")
	task.wait(0.3)
	w, x = pcall(function()
		loadstring(game:HttpGet("https://apigetunx.vercel.app/Games/Universal.lua"))()
	end)
end

if w then
	getgenv().unxshared.isloaded = true
	s("Script loaded successfully")
	task.wait(0.2)
	s("Initialization complete!")
	n:Disconnect()
	task.wait(0.5)
	d:Destroy()
else
	getgenv().unxshared.isloaded = false
	local errorMsg = "Error: " .. tostring(x)
	s("Script failed to load")
	task.wait(0.2)
	s(errorMsg)
	task.wait(0.2)
	s("<====> PLAYER INFORMATION <====>")
	s("Player Name: " .. b.Name)
	s("Display Name: " .. b.DisplayName)
	s("User ID: " .. tostring(b.UserId))
	s("Current Time: " .. os.date("%Y-%m-%d %H:%M:%S"))
	local fps = math.floor(1 / m.RenderStepped:Wait())
	s("FPS: " .. tostring(fps))
	local ping = math.floor(b:GetNetworkPing() * 1000)
	s("Ping: " .. tostring(ping) .. "ms | Server: Hidden For Privacy Porpueses.")
	task.wait(0.2)
	s("UI will remain open for debugging")
	s("Please Click 'Copy' Button And Report This To The Owner.")
	warn("UNXHub Loader Error:", x)
	pcall(function()
		setclipboard(tostring(x))
	end)
	n:Disconnect()
end
