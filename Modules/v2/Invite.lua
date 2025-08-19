local Tweenservice = game:GetService("TweenService")

if isfile and isfile("UNXHub/nsdig_true") then return end

local gui = Instance.new("ScreenGui")
gui.Name = "UNXHubInviteUI"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 360, 0, 230)
main.Position = UDim2.new(0.5, -180, 0.5, -115)
main.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.BackgroundTransparency = 1
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = main

local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 60, 0, 60)
icon.Position = UDim2.new(0, 20, 0, 25)
icon.BackgroundColor3 = Color3.fromRGB(35, 37, 42)
icon.Image = "rbxassetid://"..123333102279908
icon.Parent = main

local iconcorner = Instance.new("UICorner")
iconcorner.CornerRadius = UDim.new(0, 14)
iconcorner.Parent = icon

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -100, 0, 60)
title.Position = UDim2.new(0, 95, 0, 35)
title.BackgroundTransparency = 1
title.Text = "Join our Discord!"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextWrapped = true
title.Parent = main

local holder = Instance.new("Frame")
holder.Size = UDim2.new(1, -40, 0, 110)
holder.Position = UDim2.new(0, 20, 1, -140)
holder.BackgroundTransparency = 1
holder.Parent = main

local list = Instance.new("UIListLayout")
list.FillDirection = Enum.FillDirection.Vertical
list.HorizontalAlignment = Enum.HorizontalAlignment.Center
list.Padding = UDim.new(0, 8)
list.Parent = holder

local function createbutton(text, color)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.95, 0, 0, 40)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	btn.TextColor3 = Color3.fromRGB(255,255,255)

	local btncorner = Instance.new("UICorner")
	btncorner.CornerRadius = UDim.new(0, 8)
	btncorner.Parent = btn

	btn.MouseEnter:Connect(function()
		Tweenservice:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color:lerp(Color3.new(1,1,1),0.15)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		Tweenservice:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
	end)

	return btn
end

local acceptbtn = createbutton("Accept Invite", Color3.fromRGB(88, 101, 242))
acceptbtn.Parent = holder

local rejectbtn = createbutton("Reject Invite", Color3.fromRGB(114, 118, 125))
rejectbtn.Parent = holder

local checkboxframe = Instance.new("Frame")
checkboxframe.Size = UDim2.new(0.95, 0, 0, 30)
checkboxframe.BackgroundTransparency = 1
checkboxframe.Parent = holder

local cb = Instance.new("TextButton")
cb.Size = UDim2.new(0, 24, 0, 24)
cb.Position = UDim2.new(0, 0, 0, 3)
cb.BackgroundColor3 = Color3.fromRGB(60, 63, 70)
cb.Text = ""
cb.AutoButtonColor = false
cb.Parent = checkboxframe

local cbcorner = Instance.new("UICorner")
cbcorner.CornerRadius = UDim.new(0, 6)
cbcorner.Parent = cb

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -30, 1, 0)
label.Position = UDim2.new(0, 30, 0, 0)
label.BackgroundTransparency = 1
label.Text = "Never Ask Again"
label.Font = Enum.Font.Gotham
label.TextSize = 16
label.TextColor3 = Color3.fromRGB(200,200,200)
label.TextXAlignment = Enum.TextXAlignment.Left
label.Parent = checkboxframe

local tick = Instance.new("TextLabel")
tick.Size = UDim2.new(1, 0, 1, 0)
tick.BackgroundTransparency = 1
tick.Text = "✓"
tick.TextSize = 20
tick.TextColor3 = Color3.fromRGB(255,255,255)
tick.Visible = false
tick.Parent = cb

local neverask = false
cb.MouseButton1Click:Connect(function()
	neverask = not neverask
	tick.Visible = neverask
end)

main.Position = UDim2.new(0.5, -180, 0.5, -95)
Tweenservice:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	BackgroundTransparency = 0,
	Position = UDim2.new(0.5, -180, 0.5, -115)
}):Play()

local function fadeoutanddestroy()
	if neverask and writefile then
		writefile("UNXHub/nsdig_true", "true")
	end
	local tween = Tweenservice:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, -180, 0.5, -95)
	})
	tween:Play()
	tween.Completed:Wait()
	gui:Destroy()
end

acceptbtn.MouseButton1Click:Connect(function()
	if setclipboard then setclipboard("https://discord.gg/3Dd3ZxvAgs") end
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Discord";
		Text = "Invite link copied!";
		Duration = 3;
	})
	fadeoutanddestroy()
end)

rejectbtn.MouseButton1Click:Connect(function()
	fadeoutanddestroy()
end)
