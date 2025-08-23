local modules = {
	colors = {
		green = "0,255,0",
		red = "255,0,0",
		blue = "0,0,255",
		yellow = "255,255,0",
		cyan = "0,255,255",
		magenta = "255,0,255",
		white = "255,255,255",
		black = "0,0,0",
		orange = "255,165,0",
		purple = "128,0,128",
		pink = "255,192,203",
		gray = "128,128,128",
		brown = "165,42,42",
		lime = "0,255,0",
		navy = "0,0,128",
		maroon = "128,0,0",
		olive = "128,128,0",
		teal = "0,128,128",
		silver = "192,192,192",
		gold = "255,215,0",
		turquoise = "64,224,208",
		violet = "238,130,238",
		indigo = "75,0,130",
		coral = "255,127,80",
		salmon = "250,128,114"
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
