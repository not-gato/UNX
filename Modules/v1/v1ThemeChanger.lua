-- ANYTHING ABOVE 1.1.4b BREAKS THIS!, DO NOT USE ON 1.2.0 AND NEWER!

local a = game:GetService("CoreGui")
local b = game:GetService("StarterGui")
local c = "rbxassetid://139800881181209"

if not a:FindFirstChild("UNXHubUI") then
	b:SetCore("SendNotification", {
		Title = "Warning",
		Text = "UNXHubUI was not found.",
		Duration = 5
	})
	warn("[ERROR]: UNXHubUI was not found.")
	print("UNXHubUI was not found.")
	return
end

if a:FindFirstChild("UNXHubTheme") then
	a.UNXHubTheme.Enabled = true
	return
end

print("")
print([[

 _   _ _   _ __   __ _   _       _      
| | | | \ | |\ \ / /| | | |     | |     
| | | |  \| | \ V / | |_| |_   _| |__   
| | | | . ` | /   \ |  _  | | | | '_ \  
| |_| | |\  |/ /^\ \| | | | |_| | |_) | 
 \___/\_| \_/\/   \/\_| |_/\__,_|_.__/  

]])
print("UNXHub Module: Theme Changer")
print("UNXHub Module Version: 1.0")
print("")
print("-------------- UXNHub Debugger Info --------------")

local d = {
	Default = {Frame = Color3.fromRGB(0, 2, 39), Button = Color3.fromRGB(0, 4, 67), TextBox = Color3.fromRGB(22, 0, 109), TextColor = Color3.fromRGB(255, 255, 255)},
	Red = {Frame = Color3.fromRGB(105, 1, 1), Button = Color3.fromRGB(130, 3, 3), TextBox = Color3.fromRGB(173, 3, 3), TextColor = Color3.fromRGB(255, 255, 255)},
	Sunshine = {Frame = Color3.fromRGB(255, 240, 0), Button = Color3.fromRGB(255, 246, 107), TextBox = Color3.fromRGB(255, 250, 171), TextColor = Color3.fromRGB(0, 0, 0)},
	Green = {Frame = Color3.fromRGB(1, 105, 15), Button = Color3.fromRGB(3, 130, 24), TextBox = Color3.fromRGB(43, 173, 3), TextColor = Color3.fromRGB(255, 255, 255)},
	Emerald = {Frame = Color3.fromRGB(3, 252, 140), Button = Color3.fromRGB(10, 194, 111), TextBox = Color3.fromRGB(8, 163, 93), TextColor = Color3.fromRGB(0, 0, 0)},
	Cyan = {Frame = Color3.fromRGB(1, 69, 69), Button = Color3.fromRGB(1, 105, 100), TextBox = Color3.fromRGB(5, 117, 117), TextColor = Color3.fromRGB(255, 255, 255)},
	Blue = {Frame = Color3.fromRGB(0, 0, 128), Button = Color3.fromRGB(0, 0, 170), TextBox = Color3.fromRGB(0, 0, 255), TextColor = Color3.fromRGB(255, 255, 255)},
	DeepSeaBlue = {Frame = Color3.fromRGB(1, 1, 99), Button = Color3.fromRGB(2, 2, 66), TextBox = Color3.fromRGB(3, 3, 43), TextColor = Color3.fromRGB(255, 255, 255)},
	Purple = {Frame = Color3.fromRGB(60, 1, 105), Button = Color3.fromRGB(69, 3, 130), TextBox = Color3.fromRGB(88, 3, 173), TextColor = Color3.fromRGB(255, 255, 255)},
	Pink = {Frame = Color3.fromRGB(233, 2, 245), Button = Color3.fromRGB(177, 2, 186), TextBox = Color3.fromRGB(124, 1, 130), TextColor = Color3.fromRGB(255, 255, 255)},
	Wooden = {Frame = Color3.fromRGB(133, 84, 49), Button = Color3.fromRGB(110, 76, 52), TextBox = Color3.fromRGB(94, 70, 53), TextColor = Color3.fromRGB(255, 255, 255)},
	White = {Frame = Color3.fromRGB(255, 255, 255), Button = Color3.fromRGB(230, 232, 232), TextBox = Color3.fromRGB(204, 204, 204), TextColor = Color3.fromRGB(0, 0, 0)},
	Gray = {Frame = Color3.fromRGB(38, 38, 38), Button = Color3.fromRGB(46, 46, 46), TextBox = Color3.fromRGB(61, 61, 61), TextColor = Color3.fromRGB(255, 255, 255)},
	Black = {Frame = Color3.fromRGB(0, 0, 0), Button = Color3.fromRGB(15, 15, 15), TextBox = Color3.fromRGB(18, 18, 18), TextColor = Color3.fromRGB(255, 255, 255)},
	RedishOrange = {Frame = Color3.fromRGB(255, 78, 3), Button = Color3.fromRGB(189, 58, 2), TextBox = Color3.fromRGB(148, 46, 3), TextColor = Color3.fromRGB(255, 255, 255)},
	Orange = {Frame = Color3.fromRGB(255, 119, 8), Button = Color3.fromRGB(201, 98, 14), TextBox = Color3.fromRGB(135, 65, 8), TextColor = Color3.fromRGB(255, 255, 255)}
}

local e = {
	"Default", "Red", "RedishOrange", "Orange", "Wooden", "Sunshine", "Green", "Emerald", "Cyan", "Blue", "DeepSeaBlue",
	"Purple", "Pink", "White", "Gray", "Black", "Rainbow", "Randomizer", "Close"
}

local f, g, h, i, j = "Default", "", nil, false, 0
local k = Instance.new("ScreenGui", a)
k.Name = "UNXHubTheme"
k.IgnoreGuiInset = true
k.ResetOnSpawn = false

local l = Instance.new("Frame", k)
l.Name = "ThemeSelector"
l.Size = UDim2.new(0.13, 0, 0.45, 0)
l.Position = UDim2.new(0, 20, 0.5, 0)
l.AnchorPoint = Vector2.new(0, 0.5)
l.BackgroundColor3 = d.Default.Frame

Instance.new("UICorner", l).CornerRadius = UDim.new(0, 12)

local m = Instance.new("ScrollingFrame", l)
m.Size = UDim2.new(1, -10, 1, -10)
m.Position = UDim2.new(0, 5, 0, 5)
m.CanvasSize = UDim2.new(0, 0, 0, 0)
m.ScrollBarThickness = 6
m.BackgroundTransparency = 1
m.BorderSizePixel = 0

local n = Instance.new("UIListLayout", m)
n.Padding = UDim.new(0, 5)
n.SortOrder = Enum.SortOrder.LayoutOrder

local o = {}

local function p(q)
	for _, r in {"UNXHubUI", "UNXErrorUI", "UNXHubTheme"} do
		local s = a:FindFirstChild(r)
		if s then
			for _, t in ipairs(s:GetDescendants()) do
				if t:IsA("TextButton") then
					if t.Name:lower() == "minimize" or t.BackgroundColor3 == Color3.fromRGB(0, 121, 0) then continue end
					t.BackgroundColor3 = q.Button
					t.TextColor3 = q.TextColor
					t.Font = Enum.Font.SourceSansLight
				elseif t:IsA("TextBox") then
					t.BackgroundColor3 = q.TextBox
					t.TextColor3 = q.TextColor
					t.PlaceholderColor3 = q.TextColor
					t.Font = Enum.Font.SourceSansLight
				elseif t:IsA("TextLabel") then
					t.TextColor3 = q.TextColor
					t.Font = Enum.Font.SourceSansLight
				elseif t:IsA("Frame") then
					t.BackgroundColor3 = q.Frame
				end
			end
		end
	end

	l.BackgroundColor3 = q.Frame
	for _, u in ipairs(o) do
		u.BackgroundColor3 = u.Name == "Close" and Color3.fromRGB(130, 3, 3) or q.Button
		u.TextColor3 = q.TextColor
	end
end

local function v(w)
	local x = Instance.new("TextButton", m)
	x.Name = w
	x.Size = UDim2.new(1, -10, 0, 30)
	x.Text = w
	x.BackgroundColor3 = d.Default.Button
	x.TextColor3 = Color3.fromRGB(255, 255, 255)
	x.Font = Enum.Font.SourceSansLight
	x.TextScaled = true
	Instance.new("UICorner", x).CornerRadius = UDim.new(0, 8)

	x.MouseButton1Click:Connect(function()
		local y = Instance.new("Sound", x)
		y.SoundId = c
		y.Volume = 0.5
		y:Play()
		game.Debris:AddItem(y, 2)

		if w == "Close" then
			k.Enabled = false
		elseif w == "Randomizer" then
			i = false
			f = "Randomizer"
			h = true
		elseif w == "Rainbow" then
			i = true
			f = "Rainbow"
		else
			i = false
			f = w
		end
	end)

	table.insert(o, x)
end

for _, z in ipairs(e) do
	v(z)
end

m.CanvasSize = UDim2.new(0, 0, 0, n.AbsoluteContentSize.Y)

while true do
	if f == "Rainbow" then
		j = (j + 0.01) % 1
		local aa = {
			Frame = Color3.fromHSV(j, 1, 1),
			Button = Color3.fromHSV(j, 1, 0.8),
			TextBox = Color3.fromHSV(j, 1, 0.6),
			TextColor = Color3.fromRGB(255, 255, 255)
		}
		p(aa)
		g = "Rainbow"
	elseif f == "Randomizer" then
		if h or g ~= "Randomizer" then
			d.Random = {
				Frame = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)),
				Button = Color3.fromRGB(math.random(0, 200), math.random(0, 200), math.random(0, 200)),
				TextBox = Color3.fromRGB(math.random(0, 150), math.random(0, 150), math.random(0, 150)),
				TextColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
			}
			h = false
			g = "Randomizer"
		end
		p(d.Random)
	elseif f == "Default" then
		if g ~= "Default" then
			p(d.Default)
			g = "Default"
		end
	elseif d[f] then
		p(d[f])
		g = f
	end
	task.wait(0.1)
end
