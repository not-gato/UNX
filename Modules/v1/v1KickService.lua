return {
	CallKick = function(_, title, description, errorCode)
		local CoreGui = game:GetService("CoreGui")
		local Players = game:GetService("Players")
		local TweenService = game:GetService("TweenService")
		local RunService = game:GetService("RunService")
		local Lighting = game:GetService("Lighting")

		local PromptOverlay = CoreGui:WaitForChild("RobloxPromptGui"):WaitForChild("promptOverlay")
		local Camera = workspace.CurrentCamera
		local Player = Players.LocalPlayer

		for _, gui in ipairs(CoreGui:GetChildren()) do
			if gui ~= CoreGui:FindFirstChild("RobloxPromptGui") then
				pcall(function() gui:Destroy() end)
			end
		end

		local playerGui = Player:FindFirstChild("PlayerGui")
		if playerGui then
			for _, ui in ipairs(playerGui:GetChildren()) do
				pcall(function() ui:Destroy() end)
			end
		end

		RunService.RenderStepped:Wait()

		pcall(function()
			Camera.CameraType = Enum.CameraType.Scriptable
			Camera.CFrame = CFrame.new(1e9, 1e9, 1e9)
		end)

		pcall(function()
			PromptOverlay:FindFirstChild("UNXKickFrame"):Destroy()
			PromptOverlay:FindFirstChild("UNXInputBlocker"):Destroy()
		end)

		if Lighting:FindFirstChild("UNXBlur") then
			Lighting.UNXBlur:Destroy()
		end

		local blur = Instance.new("BlurEffect")
		blur.Name = "UNXBlur"
		blur.Size = 24
		blur.Parent = Lighting

		local blocker = Instance.new("TextButton")
		blocker.Name = "UNXInputBlocker"
		blocker.Size = UDim2.new(1, 0, 1, 0)
		blocker.Position = UDim2.new(0, 0, 0, 0)
		blocker.BackgroundTransparency = 1
		blocker.Text = ""
		blocker.AutoButtonColor = false
		blocker.ZIndex = 1
		blocker.Parent = PromptOverlay

		local frame = Instance.new("Frame")
		frame.Name = "UNXKickFrame"
		frame.Size = UDim2.new(0.6, 0, 0.58, 0)
		frame.Position = UDim2.new(0.5, 0, 0.5, 0)
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
		frame.BorderSizePixel = 0
		frame.ZIndex = 2
		frame.ClipsDescendants = true
		frame.Parent = PromptOverlay

		local scale = Instance.new("UIScale")
		scale.Scale = 0
		scale.Parent = frame

		TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Scale = 1
		}):Play()

		local layout = Instance.new("UIListLayout")
		layout.Padding = UDim.new(0, 10)
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.VerticalAlignment = Enum.VerticalAlignment.Center
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Parent = frame

		local titleLabel = Instance.new("TextLabel")
		titleLabel.Text = title or "UNXHub | Disconnected"
		titleLabel.Size = UDim2.new(1, -40, 0, 40)
		titleLabel.BackgroundTransparency = 1
		titleLabel.TextColor3 = Color3.new(1, 1, 1)
		titleLabel.Font = Enum.Font.SourceSansBold
		titleLabel.TextScaled = true
		titleLabel.ZIndex = 3
		titleLabel.LayoutOrder = 1
		titleLabel.Parent = frame

		local divider = Instance.new("Frame")
		divider.Size = UDim2.new(1, -40, 0, 1)
		divider.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
		divider.BorderSizePixel = 0
		divider.ZIndex = 3
		divider.LayoutOrder = 2
		divider.Parent = frame

		local message = Instance.new("TextLabel")
		message.Text = (description or "You got kicked") .. "\n(Error Code: " .. tostring(errorCode or "0") .. ")"
		message.Size = UDim2.new(1, -40, 0, 70)
		message.BackgroundTransparency = 1
		message.TextColor3 = Color3.new(1, 1, 1)
		message.TextWrapped = true
		message.TextYAlignment = Enum.TextYAlignment.Center
		message.TextXAlignment = Enum.TextXAlignment.Center
		message.Font = Enum.Font.SourceSansLight
		message.TextScaled = true
		message.ZIndex = 3
		message.LayoutOrder = 3
		message.Parent = frame

		local quit = Instance.new("TextButton")
		quit.Size = UDim2.new(0.5, 0, 0, 40)
		quit.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
		quit.Text = "Quit"
		quit.TextColor3 = Color3.new(1, 1, 1)
		quit.Font = Enum.Font.SourceSansLight
		quit.TextScaled = true
		quit.ZIndex = 3
		quit.LayoutOrder = 4
		quit.Parent = frame

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 8)
		corner.Parent = quit

		quit.MouseButton1Click:Connect(function()
			game:Shutdown()
		end)
	end
}
