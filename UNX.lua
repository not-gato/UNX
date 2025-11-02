loadstring(game:HttpGet("https://apigetunx.vercel.app/Modules/v2/Inv.lua",true))()
if getgenv().unxshared and getgenv().unxshared.isloaded == true then
warn("UNXHub is already loaded. Skipping initialization.")
return
end
local a = game:GetService("TweenService")
local b = game:GetService("Players").LocalPlayer
local c = game:GetService("CoreGui")
local d = Instance.new("ScreenGui", c)
d.Name = "UNXLoaderUI"
d.ResetOnSpawn = false
local e = Instance.new("Frame")
e.Size = UDim2.new(0.65, 0, 0.65, 0)
e.Position = UDim2.new(0.175, 0, 0.175, 0)
e.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
e.Active = true
e.Draggable = true
e.BorderSizePixel = 0
e.Parent = d
Instance.new("UICorner", e).CornerRadius = UDim.new(0, 14)
local f = Instance.new("Frame")
f.Size = UDim2.new(1, 0, 0, 32)
f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
f.BorderSizePixel = 0
f.Parent = e
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)
local g = Instance.new("TextLabel")
g.Parent = f
g.Size = UDim2.new(1, 0, 1, 0)
g.BackgroundTransparency = 1
g.Text = "UNXLoader"
g.TextColor3 = Color3.fromRGB(255, 255, 255)
g.Font = Enum.Font.SourceSans
g.TextSize = 16
g.TextYAlignment = Enum.TextYAlignment.Center
g.TextXAlignment = Enum.TextXAlignment.Center
local function h(i, j)
	local k = Instance.new("TextButton")
	k.Size = UDim2.new(0, 14, 0, 14)
	k.Position = UDim2.new(0, j, 0.5, -7)
	k.BackgroundColor3 = i
	k.BorderSizePixel = 0
	k.Text = ""
	k.AutoButtonColor = false
	k.Parent = f
	Instance.new("UICorner", k).CornerRadius = UDim.new(1, 0)
	return k
end
local l = h(Color3.fromRGB(255, 95, 87), 10)
local m = h(Color3.fromRGB(39, 201, 63), 32)
local n = Instance.new("Frame")
n.Parent = e
n.Size = UDim2.new(0.9, 0, 0.6, 0)
n.Position = UDim2.new(0.05, 0, 0.2, 0)
n.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
n.BorderSizePixel = 0
Instance.new("UICorner", n).CornerRadius = UDim.new(0, 12)
local o = Instance.new("TextLabel")
o.Parent = n
o.Size = UDim2.new(1, -30, 0, 26)
o.Position = UDim2.new(0, 10, 0, 0)
o.BackgroundTransparency = 1
o.Text = "Output"
o.Font = Enum.Font.SourceSans
o.TextColor3 = Color3.fromRGB(255, 255, 255)
o.TextSize = 14
o.TextXAlignment = Enum.TextXAlignment.Left
local p = Instance.new("ScrollingFrame")
p.Parent = n
p.Size = UDim2.new(1, -20, 1, -35)
p.Position = UDim2.new(0, 10, 0, 28)
p.BackgroundTransparency = 1
p.BorderSizePixel = 0
p.CanvasSize = UDim2.new(0, 0, 0, 0)
p.ScrollBarThickness = 6
local q = Instance.new("UIListLayout")
q.Padding = UDim.new(0, 4)
q.SortOrder = Enum.SortOrder.LayoutOrder
q.Parent = p
local r = Instance.new("ImageButton")
r.Parent = n
r.Size = UDim2.new(0, 16, 0, 16)
r.AnchorPoint = Vector2.new(1, 0)
r.Position = UDim2.new(1, -10, 0, 6)
r.BackgroundTransparency = 1
r.Image = "rbxassetid://90434151822042"
r.ImageColor3 = Color3.fromRGB(200, 200, 200)
local s = Instance.new("Frame")
s.Parent = e
s.Size = UDim2.new(0.8, 0, 0.05, 0)
s.Position = UDim2.new(0.1, 0, 0.85, 0)
s.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
s.BorderSizePixel = 0
Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
local t = Instance.new("Frame")
t.Parent = s
t.Size = UDim2.new(0.25, 0, 1, 0)
t.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
t.BorderSizePixel = 0
Instance.new("UICorner", t).CornerRadius = UDim.new(1, 0)
task.spawn(function()
	local u = 0
	while true do
		u = (u + 0.002) % 1
		t.BackgroundColor3 = Color3.fromHSV(u, 1, 1)
		task.wait(0.05)
	end
end)
task.spawn(function()
	while true do
		a:Create(t, TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0.75, 0, 0, 0)}):Play()
		task.wait(2.4)
		a:Create(t, TweenInfo.new(2.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0, 0)}):Play()
		task.wait(2.4)
	end
end)
local v = Color3.fromRGB(200, 200, 200)
local w = Color3.fromRGB(50, 255, 50)
local x = {}
local function y(z)
	table.insert(x, z)
	local aa = Instance.new("TextLabel")
	aa.Size = UDim2.new(1, -10, 0, 0)
	aa.BackgroundTransparency = 1
	aa.Text = "> " .. z
	aa.TextColor3 = Color3.fromRGB(220, 220, 220)
	aa.TextSize = 12
	aa.Font = Enum.Font.Code
	aa.TextXAlignment = Enum.TextXAlignment.Left
	aa.TextYAlignment = Enum.TextYAlignment.Top
	aa.TextWrapped = true
	aa.Parent = p
	task.wait()
	aa.Size = UDim2.new(1, -10, 0, aa.TextBounds.Y)
	p.CanvasSize = UDim2.new(0, 0, 0, q.AbsoluteContentSize.Y + 10)
	p.CanvasPosition = Vector2.new(0, q.AbsoluteContentSize.Y - p.AbsoluteSize.Y)
end
local function ab()
	local ac = table.concat(x, "\n")
	setclipboard(ac)
	local ad = a:Create(r, TweenInfo.new(0.2), {ImageTransparency = 1})
	ad:Play()
	ad.Completed:Wait()
	r.Image = "rbxassetid://14203226653"
	r.ImageColor3 = w
	local ae = a:Create(r, TweenInfo.new(0.2), {ImageTransparency = 0})
	ae:Play()
	task.wait(1)
	local af = a:Create(r, TweenInfo.new(0.2), {ImageTransparency = 1})
	af:Play()
	af.Completed:Wait()
	r.Image = "rbxassetid://90434151822042"
	r.ImageColor3 = v
	a:Create(r, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
end
r.MouseButton1Click:Connect(ab)
l.MouseButton1Click:Connect(function()
	local ag = TweenInfo.new(0.25)
	for _, ah in ipairs(d:GetDescendants()) do
		if ah:IsA("GuiObject") then
			local ai = {}
			if ah:IsA("Frame") or ah:IsA("ImageLabel") or ah:IsA("ImageButton") or ah:IsA("ViewportFrame") or ah:IsA("ScrollingFrame") then
				ai.BackgroundTransparency = 1
			end
			if ah:IsA("TextLabel") or ah:IsA("TextButton") or ah:IsA("TextBox") then
				ai.TextTransparency = 1
			end
			if ah:IsA("ImageLabel") or ah:IsA("ImageButton") then
				ai.ImageTransparency = 1
			end
			if next(ai) then
				a:Create(ah, ag, ai):Play()
			end
		end
	end
	task.wait(0.3)
	d:Destroy()
end)
m.MouseButton1Click:Connect(function()
	local aj = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
	if e.Size ~= UDim2.new(1, 0, 1, 0) then
		a:Create(e, aj, {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}):Play()
		a:Create(n, aj, {Size = UDim2.new(0.9, 0, 0.7, 0), Position = UDim2.new(0.05, 0, 0.15, 0)}):Play()
		a:Create(s, aj, {Position = UDim2.new(0.1, 0, 0.9, 0)}):Play()
	else
		a:Create(e, aj, {Size = UDim2.new(0.65, 0, 0.65, 0), Position = UDim2.new(0.175, 0, 0.175, 0)}):Play()
		a:Create(n, aj, {Size = UDim2.new(0.9, 0, 0.6, 0), Position = UDim2.new(0.05, 0, 0.2, 0)}):Play()
		a:Create(s, aj, {Position = UDim2.new(0.1, 0, 0.85, 0)}):Play()
	end
end)
local ak = game:GetService("MarketplaceService")
local al = game:GetService("RunService")
local am = game:GetService("Stats")
y("UNXHub Loader v2.1.0 initialized")
y("[WARNING]: By executing UNXHub you accept our Terms Of Service")
y("[WARNING]: Learn more on http://getunx.vercel.app/tos.html")
y("[WARNING]: PLEASE READ THE MESSAGE ABOVE!!!!!")
task.wait(0.1)
y("Creating global variables...")
task.wait(0.05)
getgenv().unxshared = {
	version = "2.2.0 (Mega Patch 2)",
	gamename = ak:GetProductInfo(game.PlaceId).Name,
	issupported = false,
	playername = b.Name,
	playerid = b.UserId,
	isloaded = false,
	devnote = "https://discord.gg/zpaMS8qUfB"
}
loadstring(game:HttpGet("https://apigetunx.vercel.app/Modules/v2/Log.lua", true))()
y("Player: " .. b.Name .. " (ID: " .. b.UserId .. ")")
task.wait(0.05)
y("Game: " .. getgenv().unxshared.gamename)
task.wait(0.14)
y("Checking game compatibility...")
task.wait(0.02)
local an = game.PlaceId
y("Game ID: " .. tostring(an))
task.wait(0.12)
local ao = {
	[1240123653] = "https://apigetunx.vercel.app/Games/ZombieAttack.lua",
	[1632210982] = "https://apigetunx.vercel.app/Games/ZombieAttack.lua",
	[12240122896] = "https://apigetunx.vercel.app/Games/FigureL.lua",
	[136801880565837] = "https://apigetunx.vercel.app/Games/Flick.lua"
}
local ap, aq
if ao[an] then
	getgenv().unxshared.issupported = true
	y("Game verified, loading " .. getgenv().unxshared.gamename .." | Dev Note: ".. getgenv().unxshared.devnote)
	task.wait(0.05)
	y("Fetching game-specific script...")
	task.wait(0.01)
	ap, aq = pcall(function()
		loadstring(game:HttpGet(ao[an]))()
	end)
else
	getgenv().unxshared.issupported = false
	y("Game not supported, loading universal")
	task.wait(0.03)
	y("Fetching universal script...")
	task.wait(0.1)
	ap, aq = pcall(function()
		loadstring(game:HttpGet("https://apigetunx.vercel.app/Games/Universal.lua"))()
	end)
end
if ap then
	getgenv().unxshared.isloaded = true
	y("Script loaded successfully")
	task.wait(0.05)
	y("Initialization complete!")
	task.wait(0.7)
	local ar = TweenInfo.new(0.25)
	for _, as in ipairs(d:GetDescendants()) do
		if as:IsA("GuiObject") then
			local at = {}
			if as:IsA("Frame") or as:IsA("ImageLabel") or as:IsA("ImageButton") or as:IsA("ViewportFrame") or as:IsA("ScrollingFrame") then
				at.BackgroundTransparency = 1
			end
			if as:IsA("TextLabel") or as:IsA("TextButton") or as:IsA("TextBox") then
				at.TextTransparency = 1
			end
			if as:IsA("ImageLabel") or as:IsA("ImageButton") then
				at.ImageTransparency = 1
			end
			if next(at) then
				a:Create(as, ar, at):Play()
			end
		end
	end
	task.wait(0.3)
	d:Destroy()
else
	getgenv().unxshared.isloaded = false
	local au = "Error: " .. tostring(aq)
	y("Script failed to load")
	task.wait(0.2)
	y(au)
	task.wait(0.2)
	y("<====> PLAYER INFORMATION <====>")
	y("Player Name: " .. b.Name)
	y("Display Name: " .. b.DisplayName)
	y("User ID: " .. tostring(b.UserId))
	y("Current Time: " .. os.date("%Y-%m-%d %H:%M:%S"))
	local av = math.floor(1 / al.RenderStepped:Wait())
	y("FPS: " .. tostring(av))
	local aw = math.floor(am.Network.ServerStatsItem["Data Ping"]:GetValue())
	y("Ping: " .. tostring(aw) .. "ms | Server: Hidden For Privacy Porpueses.")
	task.wait(0.2)
	y("UI will remain open for debugging")
	y("Please Click 'Copy' Button And Report This To The Owner.")
	warn("UNXHub Loader Error:", aq)
	pcall(setclipboard, tostring(aq))
end
