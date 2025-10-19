local a = game:GetService("Players")
local b = a.LocalPlayer
local c = game:GetService("CoreGui")
local d = Instance.new("ScreenGui")
d.Name = "LoaderUI"
d.ResetOnSpawn = false
d.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
d.Parent = c
local e = Instance.new("Frame")
e.Size = UDim2.new(0, 400, 0, 200)
e.Position = UDim2.new(0.5, -200, 0.5, -100)
e.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
e.BorderSizePixel = 0
e.Parent = d
local f = Instance.new("UICorner")
f.CornerRadius = UDim.new(0, 12)
f.Parent = e
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
h.Text = "Creating Global Variables..."
h.TextColor3 = Color3.fromRGB(200, 200, 200)
h.TextSize = 16
h.Font = Enum.Font.Gotham
h.TextXAlignment = Enum.TextXAlignment.Left
h.Parent = e
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
local s = game:GetService("RunService")
local t = s.Heartbeat:Connect(function()
	local u = tick() % 5 / 5
	k.BackgroundColor3 = Color3.fromHSV(u, 1, 1)
end)
local m = game:GetService("TweenService")
local n = TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local o = m:Create(k, n, {Position = UDim2.new(1, -80, 0, 0)})
o:Play()
local function p(q)
	h.Text = q
end
p("Creating Global Variables...")
task.wait(0.5)
getgenv().unxshared = {
	version = "2.1.0",
	gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
	issupported = false,
	playername = b.Name,
	playerid = b.UserId
}
p("Checking Game ID...")
task.wait(0.5)
local r = game.PlaceId
if r == 1240123653 then
	getgenv().unxshared.issupported = true
else
	getgenv().unxshared.issupported = false
end
p("Loading Script...")
task.wait(0.5)
local v, w
if getgenv().unxshared.issupported and r == 1240123653 then
	v, w = pcall(function()
		loadstring(game:HttpGet("https://github.com/not-gato/UNX/raw/refs/heads/main/Games/ZombieAttack.lua"))()
	end)
else
	v, w = pcall(function()
		loadstring(game:HttpGet("https://github.com/not-gato/UNX/raw/refs/heads/main/Games/Universal.lua"))()
	end)
end
if v then
	p("Complete!")
else
	p("Error: " .. tostring(w))
	warn("UNXHub Loader Error:", w)
	pcall(function()
		setclipboard(tostring(w))
	end)
end
t:Disconnect()
task.wait(1)
d:Destroy()
