local modules = {
	colors = {
		green = "0,255,0",
		red = "255,0,0"
	}
}

modules.changecolor = function()
	local runservice = game:GetService("RunService")
	runservice.Heartbeat:Connect(function()
		local coregui = game:GetService("CoreGui")
		local console = coregui:FindFirstChild("DevConsoleMaster")
		if console then
			for _, v in pairs(console:GetDescendants()) do
				if v:IsA("TextLabel") then
					v.RichText = true
				end
			end
		end
	end)
end

modules.print = function(color, text, size)
	if not modules.colors[color] then
		warn("Color was not found!")
		return
	end

	local output = '<font color="rgb(' .. modules.colors[color] .. ')"'
	if size then
		output = output .. ' size="' .. tostring(size) .. '"'
	end
	output = output .. '>' .. tostring(text) .. '</font>'
	print(output)
end

modules.changecolor()

return modules
