local a = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
local b = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
local c = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
local d = a.Options
local e = a.Toggles
a.ForceCheckbox = true
a.ShowToggleFrameInKeybinds = true
local f = game:GetService("Players")
local g = game:GetService("RunService")
local h = game:GetService("Workspace")
local i = game:GetService("Lighting")
local j = f.LocalPlayer
local k = h.CurrentCamera
local l = nil
local m = nil
local n = nil
local o = nil
local p = h:WaitForChild("enemies", 5)
local q = h:WaitForChild("Powerups", 5)
local r = h:WaitForChild("BossFolder", 5)
if not p then warn("[Script] Warning: 'enemies' folder not found in Workspace!") end
if not q then warn("[Script] Warning: 'Powerups' folder not found in Workspace!") end
if not r then warn("[Script] Warning: 'BossFolder' not found in Workspace!") end
local s = nil
local t = {}
local u = {}
local v = {}
local w = {}
local x = {}
local y = {}
local z = {}
local aa = {}
local ab = nil
local ac = Instance.new("Part")
ac.Name = "SafePlatform"
ac.Anchored = true
ac.CanCollide = true
ac.Size = Vector3.new(5, 1, 5)
ac.Color = Color3.new(1, 1, 1)
ac.Material = Enum.Material.ForceField
ac.Transparency = 0.5
ac.Position = Vector3.new(0, -50, 0)
ac.Parent = h
local ad = {
ae = i.Brightness, af = i.Ambient, ag = i.FogEnd, ah = i.Technology, ai = {}, aj = h.Gravity, ak = j.CameraMaxZoomDistance, al = k.FieldOfView}
for _, am in pairs(h:GetDescendants()) do
	if am:IsA("MeshPart") and am.TextureID ~= "" then
		ad.ai[am] = am.TextureID
	end
end
local an = 0
local ao = -1.5
local ap = 0
local aq = 0
local ar = false
local as = -0.01
local at = 0
local au = 0
local av = 0
local aw = 20
local ax = 1
local ay = 16
local az = 50
local ba = "Middle"
local bb = 1
local bc = 0
local bd = 1
local be = 70
local bf = 400
local bg = 0
local bh = nil
local bi = getgenv().unxshared and getgenv().unxshared.gamename or game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or "Unknown Game"
local hc = getgenv().unxshared and getgenv().unxshared.version or "Unknown"
local bj = a:CreateWindow({
	Title = "UNXHub",
	Footer = "Version: " .. hc .. ", Game: " .. bi,
	Icon = 123333102279908,
	NotifySide = "Right",
	ShowCustomCursor = true})
local bk = {
bl = bj:AddTab("Main", 10734950309), 
bm = bj:AddTab("Visuals", 10723434711), 
bn = bj:AddTab("Attack", 10723407389), 
bo = bj:AddTab("UI Settings", 10734949856)}
local bp = bk.bl:AddLeftGroupbox("Local Player")
bp:AddSlider("bq", {Text = "Walk Speed", Default = ay, Min = 0, Max = 100, Rounding = 0, Callback = function(br)
	local bs = j.Character
	if bs then
		local bt = bs:FindFirstChild("Humanoid")
		if bt then
			bt.WalkSpeed = br
		end
	end
end})
bp:AddSlider("bu", {Text = "Jump Power", Default = 50, Min = 0, Max = 200, Rounding = 0, Callback = function(br)
	local bs = j.Character
	if bs then
		local bt = bs:FindFirstChild("Humanoid")
		if bt then
			bt.JumpPower = br
		end
	end
end})
bp:AddSlider("bv", {Text = "Max Zoom", Default = bf, Min = 50, Max = 1000, Rounding = 0, Callback = function(br)
	j.CameraMaxZoomDistance = br
end})
bp:AddToggle("bw", {Text = "No Acceleration", Default = false, Callback = function(br)
	h.Gravity = br and 0 or ad.aj
end})
local bx = bk.bl:AddRightGroupbox("Game")
bx:AddToggle("by", {Text = "Auto Pickup Powerup", Default = false, Callback = function(bz)
	if bz then
		if not q then
			a:Notify("Powerups folder not found!", 3)
			e.by:SetValue(false)
			return
		end
		t = {}
		u = {}
		n = g.Heartbeat:Connect(function()
			local ca = tick()
			local cb = q:GetChildren()
			for cc, _ in pairs(t) do
				if not cc.Parent then
					t[cc] = nil
					u[cc] = nil
				end
			end
			if #cb > 0 then
				local bs = j.Character
				local cd = bs and bs:FindFirstChild("HumanoidRootPart")
				if cd then
					local ce = nil
					local cf = math.huge
					for _, cc in ipairs(cb) do
						if not u[cc] then
							local cg, ch = pcall(function()
								return cc:GetBoundingBox()
							end)
							if cg and ch then
								local ci = (ch.Position - cd.Position).Magnitude
								if ci < cf then
									cf = ci
									ce = cc
								end
							end
						end
					end
				end
				if ce then
					if not t[ce] then
						t[ce] = ca
					end
					local cj = ca - t[ce]
					if cj > 3 then
						u[ce] = true
						a:Notify("Powerup timeout - ignoring: " .. ce.Name, 2)
						return
					end
					local ck = e.cl and e.cl.Value
					local cm = e.cn and e.cn.Value
					if ck then
						e.cl:SetValue(false)
					end
					if cm then
						e.cn:SetValue(false)
					end
					local co = cd.CFrame
					local cg, ch = pcall(function()
						return ce:GetBoundingBox()
					end)
					if cg and ch then
						cd.CFrame = CFrame.new(ch.Position + Vector3.new(0, 2, 0))
						task.wait(0.1)
						cd.CFrame = co
						if not ce.Parent then
							t[ce] = nil
							u[ce] = nil
						end
					end
					if ck then
						e.cl:SetValue(true)
					end
					if cm then
						e.cn:SetValue(true)
					end
				end
			end
		end)
	else
		if n then
			n:Disconnect()
			n = nil
		end
		t = {}
		u = {}
	end
end})
bx:AddToggle("cp", {Text = "Teleport To Safe When Low Health", Default = false, Callback = function(bz)
	if bz then
		o = g.Heartbeat:Connect(function()
			local bs = j.Character
			local bt = bs and bs:FindFirstChild("Humanoid")
			local cd = bs and bs:FindFirstChild("HumanoidRootPart")
			if bt and cd and bt.Health > 0 and bt.Health < 10 then
				cd.CFrame = CFrame.new(ac.Position + Vector3.new(0, 3, 0))
			end
		end)
	else
		if o then
			o:Disconnect()
			o = nil
		end
	end
end})
local cq = bk.bm:AddLeftGroupbox("ESP")
cq:AddToggle("cr", {Text = "Monster ESP", Default = false})
cq:AddToggle("cs", {Text = "Monster Tracers", Default = false})
cq:AddToggle("ct", {Text = "Monster Outline", Default = false})
cq:AddToggle("cu", {Text = "Powerup ESP", Default = false})
cq:AddToggle("cv", {Text = "Powerup Tracers", Default = false})
cq:AddToggle("cw", {Text = "Powerup Outline", Default = false})
local cx = bk.bm:AddLeftTabbox()
local cy = cx:AddTab("ESP Config")
cy:AddSlider("cz", {Text = "Text Size", Default = 16, Min = 10, Max = 30, Rounding = 0, Callback = function(br)
	for _, da in pairs(v) do
		if da then
			da.Size = br
		end
	end
	for _, da in pairs(y) do
		if da then
			da.Size = br
		end
	end
end})
cy:AddDropdown("db", {Values = {"UI", "System", "Plex", "Monospace"}, Default = "Plex", Text = "Text Font", Callback = function(br)
	local dc = ({UI = 0, System = 1, Plex = 2, Monospace = 3})[br] or 2
	for _, da in pairs(v) do
		if da then
			da.Font = dc
		end
	end
	for _, da in pairs(y) do
		if da then
			da.Font = dc
		end
	end
end})
cy:AddDropdown("dd", {Values = {"Bottom", "Middle", "Up"}, Default = ba, Text = "Tracer Position", Callback = function(br)
end})
cy:AddSlider("de", {Text = "Tracer Thickness", Default = bb, Min = 1, Max = 5, Rounding = 0, Callback = function(br)
	for _, df in pairs(w) do
		if df then
			df.Thickness = br
		end
	end
	for _, df in pairs(z) do
		if df then
			df.Thickness = br
		end
	end
end})
cy:AddSlider("dg", {Text = "Outline Line Transparency", Default = bc, Min = 0, Max = 1, Rounding = 2, Callback = function(br)
	for _, dh in pairs(x) do
		if dh then
			dh.OutlineTransparency = br
		end
	end
	for _, dh in pairs(aa) do
		if dh then
			dh.OutlineTransparency = br
		end
	end
end})
cy:AddSlider("di", {Text = "Outline Fill Transparency", Default = bd, Min = 0, Max = 1, Rounding = 2, Callback = function(br)
	for _, dj in pairs(x) do
		if dj then
			dj.FillTransparency = br
		end
	end
	for _, dj in pairs(aa) do
		if dj then
			dj.FillTransparency = br
		end
	end
end})
local dk = bk.bm:AddRightGroupbox("Camera")
dk:AddSlider("dl", {Text = "Field of View", Default = be, Min = 30, Max = 120, Rounding = 0, Callback = function(br)
	k.FieldOfView = br
end})
dk:AddToggle("dm", {Text = "Full Bright", Default = false, Callback = function(bz)
	if bz then
		i.Brightness = 2
		i.Ambient = Color3.new(1, 1, 1)
	else
		i.Brightness = ad.ae
		i.Ambient = ad.af
	end
end})
dk:AddToggle("dn", {Text = "No Fog", Default = false, Callback = function(bz)
	if bz then
		i.FogEnd = 1000000
	else
		i.FogEnd = ad.ag
	end
end})
dk:AddToggle("dp", {Text = "Anti-Lag", Default = false, Callback = function(bz)
	if bz then
		for _, dq in pairs(h:GetDescendants()) do
			if dq:IsA("BasePart") and dq.Material ~= Enum.Material.SmoothPlastic then
				if dq:IsA("MeshPart") and dq.TextureID ~= "" then
					ad.ai[dq] = dq.TextureID
					dq.TextureID = ""
				end
				dq.Material = Enum.Material.SmoothPlastic
			end
		end
		i.Technology = Enum.Technology.Voxel
	else
		for dq, dr in pairs(ad.ai) do
			if dq.Parent and dq:IsA("MeshPart") then
				dq.TextureID = dr
			end
		end
		i.Technology = ad.ah
	end
end})
local ds = bk.bn:AddLeftGroupbox("Aimlock")
ds:AddToggle("cl", {Text = "Aimlock", Default = false, Callback = function(bz)
	if bz then
		if not p and not r then
			a:Notify("No enemy folders found!", 3)
			e.cl:SetValue(false)
			return
		end
		bg = 0
		bh = nil
		l = g.Heartbeat:Connect(function()
			local ca = tick()
			local bs = j.Character
			if not bs then
				return
			end
			local cd = bs:FindFirstChild("HumanoidRootPart")
			if not cd then
				return
			end
			local dt = d.du.Value or an
			local dv = d.dw.Value or ao
			local dx = d.dy.Value or ap
			local dz = d.ea.Value or aq
			local eb = e.ec and e.ec.Value or ar
			local ed = d.ee.Value or as
			if dz <= 0 or (ca - bg) >= dz then
				bg = ca
				local ef = {}
				if p then
					for _, eg in ipairs(p:GetChildren()) do
						table.insert(ef, eg)
					end
				end
				if r then
					for _, eh in ipairs(r:GetChildren()) do
						table.insert(ef, eh)
					end
				end
				local cf = math.huge
				local ei = nil
				for _, eg in ipairs(ef) do
					if eg and eg.Parent then
						local ej = eg:FindFirstChild("Head")
						if ej and ej:IsA("BasePart") then
							local ci = (ej.Position - cd.Position).Magnitude
							if ci < cf then
								cf = ci
								ei = ej
							end
						end
					end
				end
				if ei then
					local ek = dv + (cf * ed)
					local el = Vector3.new(dt, ek, dx)
					local em = ei.Position + el
					bh = CFrame.lookAt(k.CFrame.Position, em)
				else
					bh = nil
				end
			end
			if bh then
				if eb then
					k.CFrame = k.CFrame:Lerp(bh, 0.2)
				else
					k.CFrame = bh
				end
			end
		end)
	else
		if l then
			l:Disconnect()
			l = nil
		end
		bh = nil
	end
end})
local en = bk.bn:AddLeftTabbox()
local eo = en:AddTab("Aimlock Config")
eo:AddSlider("du", {Text = "Offset X", Default = an, Min = -10, Max = 10, Rounding = 1})
eo:AddSlider("dw", {Text = "Offset Y", Default = ao, Min = -10, Max = 10, Rounding = 1})
eo:AddSlider("dy", {Text = "Offset Z", Default = ap, Min = -10, Max = 10, Rounding = 1})
eo:AddSlider("ea", {Text = "Aimlock Interval", Default = aq, Min = 0, Max = 10, Rounding = 2})
eo:AddSlider("ee", {Text = "Distance Y Multiplier", Default = as, Min = -0.1, Max = 0, Rounding = 3})
eo:AddToggle("ec", {Text = "Smooth Aimbot", Default = ar})
local ep = bk.bn:AddRightGroupbox("Orbit")
ep:AddToggle("cn", {Text = "Orbit", Default = false, Callback = function(bz)
	if bz then
		if not p and not r then
			a:Notify("No enemy folders found!", 3)
			e.cn:SetValue(false)
			return
		end
		local function eq()
			local ef = {}
			if p then
				for _, eg in ipairs(p:GetChildren()) do
					table.insert(ef, eg)
				end
			end
			if r then
				for _, eh in ipairs(r:GetChildren()) do
					table.insert(ef, eh)
				end
			end
			local er = {}
			for _, eg in ipairs(ef) do
				if eg and eg.Parent then
					local ej = eg:FindFirstChild("Head")
					local es = eg:FindFirstChild("HumanoidRootPart")
					local bt = eg:FindFirstChild("Humanoid")
					if ej and ej:IsA("BasePart") and es and bt and bt.Health > 0.01 then
						table.insert(er, eg)
					end
				end
			end
			return #er > 0 and er[math.random(1, #er)] or nil
		end
		s = eq()
		if not s then
			a:Notify("No valid enemies found!", 3)
			e.cn:SetValue(false)
			return
		end
		m = g.Heartbeat:Connect(function()
			if not s or not s.Parent then
				s = eq()
				if not s then
					a:Notify("No more valid enemies!", 3)
					e.cn:SetValue(false)
					if m then
						m:Disconnect()
						m = nil
					end
					return
				end
				a:Notify("Switched to new orbit target!", 2)
			end
			local ej = s:FindFirstChild("Head")
			local es = s:FindFirstChild("HumanoidRootPart")
			local bt = s:FindFirstChild("Humanoid")
			if not ej or not ej:IsA("BasePart") or not es or not bt or bt.Health <= 0.01 then
				s = eq()
				if s then
					a:Notify("Switched to new orbit target!", 2)
				else
					a:Notify("No more valid enemies!", 3)
					e.cn:SetValue(false)
					if m then
						m:Disconnect()
						m = nil
					end
					s = nil
					return
				end
			end
			local bs = j.Character
			if not bs then
				return
			end
			local cd = bs:FindFirstChild("HumanoidRootPart")
			if not cd then
				return
			end
			if not s or not s:FindFirstChild("HumanoidRootPart") then
				return
			end
			local et = d.eu.Value or at
			local ev = d.ew.Value or au
			local ex = d.ey.Value or av
			local ez = d.fa.Value or aw
			local fb = d.fc.Value or ax
			local fd = e.fe and e.fe.Value or false
			local dt = d.du.Value or an
			local dv = d.dw.Value or ao
			local dx = d.dy.Value or ap
			local ed = d.ee.Value or as
			local ff = tick()
			local fg = (ff * fb) % (2 * math.pi)
			local fh = s.HumanoidRootPart.Position
			local fi = fh + Vector3.new(et, ev, ex)
			local fj = Vector3.new(math.cos(fg) * ez, 0, math.sin(fg) * ez)
			local fk = fi + fj
			cd.CFrame = CFrame.lookAt(fk, fi)
			if fd then
				local ci = (fh - cd.Position).Magnitude
				local ek = dv + (ci * ed)
				local fl = s.Head.Position + Vector3.new(dt, ek, dx)
				k.CFrame = CFrame.lookAt(cd.Position, fl)
			end
		end)
	else
		if m then
			m:Disconnect()
			m = nil
		end
		s = nil
	end
end})
local fm = bk.bn:AddRightTabbox()
local fn = fm:AddTab("Orbit Config")
fn:AddSlider("eu", {Text = "Orbit X", Default = at, Min = -20, Max = 20, Rounding = 1})
fn:AddSlider("ew", {Text = "Orbit Y", Default = au, Min = -20, Max = 20, Rounding = 1})
fn:AddSlider("ey", {Text = "Orbit Z", Default = av, Min = -20, Max = 20, Rounding = 1})
fn:AddSlider("fa", {Text = "Orbit Distance", Default = aw, Min = 1, Max = 100, Rounding = 0})
fn:AddSlider("fc", {Text = "Orbit Speed", Default = ax, Min = 0.1, Max = 10, Rounding = 2})
fn:AddToggle("fe", {Text = "Aimlock On Orbit", Default = false})
local function fo(fp)
	return ({UI = 0, System = 1, Plex = 2, Monospace = 3})[fp] or 2
end
local function fq(fr)
	if not fr or not fr.Parent then
		return nil
	end
	local fs = d.dd.Value or ba
	local ej = fr:FindFirstChild("Head")
	local es = fr:FindFirstChild("HumanoidRootPart") or ej
	if not ej or not es then
		return nil
	end
	local ft = ej.Position
	local fu = es.Position
	if fs == "Bottom" then
		return fu
	end
	if fs == "Middle" then
		return (ft + fu) / 2
	end
	if fs == "Up" then
		return ft
	end
	return (ft + fu) / 2
end
local function fv(fw)
	if v[fw] or not fw:IsA("Model") then
		return
	end
	local fx = fw:FindFirstChild("Torso") or fw:FindFirstChild("Head") or fw:FindFirstChild("UpperTorso")
	if not fx or not fx:IsA("BasePart") then
		return
	end
	local fy = fx.Color
	local fz = Drawing.new("Text")
	fz.Color = fy
	fz.Size = d.cz.Value or 16
	fz.Font = fo(d.db.Value or "Plex")
	fz.Outline = true
	fz.Center = true
	fz.Visible = false
	v[fw] = fz
	fw.AncestryChanged:Connect(function()
		if v[fw] then
			v[fw]:Remove()
			v[fw] = nil
		end
	end)
end
local function ga(fw)
	if w[fw] or not fw:IsA("Model") then
		return
	end
	local fx = fw:FindFirstChild("Torso") or fw:FindFirstChild("Head") or fw:FindFirstChild("UpperTorso")
	if not fx or not fx:IsA("BasePart") then
		return
	end
	local fy = fx.Color
	local gb = Drawing.new("Line")
	gb.Color = fy
	gb.Thickness = d.de.Value or bb
	gb.Transparency = 1
	gb.Visible = false
	w[fw] = gb
	fw.AncestryChanged:Connect(function()
		if w[fw] then
			w[fw]:Remove()
			w[fw] = nil
		end
	end)
end
local function gc(fw)
	if x[fw] or not fw:IsA("Model") then
		return
	end
	local fx = fw:FindFirstChild("Torso") or fw:FindFirstChild("Head") or fw:FindFirstChild("UpperTorso")
	if not fx or not fx:IsA("BasePart") then
		return
	end
	local fy = fx.Color
	local gd = Instance.new("Highlight")
	gd.Parent = fw
	gd.FillTransparency = d.di.Value or bd
	gd.OutlineTransparency = d.dg.Value or bc
	gd.OutlineColor = fy
	gd.Enabled = false
	x[fw] = gd
	fw.AncestryChanged:Connect(function()
		if x[fw] then
			x[fw]:Destroy()
			x[fw] = nil
		end
	end)
end
local function ge(gf)
	if y[gf] or not gf:IsA("Model") then
		return
	end
	local fy = Color3.new(1, 1, 0)
	local fz = Drawing.new("Text")
	fz.Color = fy
	fz.Size = d.cz.Value or 16
	fz.Font = fo(d.db.Value or "Plex")
	fz.Outline = true
	fz.Center = true
	fz.Visible = false
	y[gf] = fz
	gf.AncestryChanged:Connect(function()
		if y[gf] then
			y[gf]:Remove()
			y[gf] = nil
		end
	end)
end
local function gg(gf)
	if z[gf] or not gf:IsA("Model") then
		return
	end
	local fy = Color3.new(1, 1, 0)
	local gb = Drawing.new("Line")
	gb.Color = fy
	gb.Thickness = d.de.Value or bb
	gb.Transparency = 1
	gb.Visible = false
	z[gf] = gb
	gf.AncestryChanged:Connect(function()
		if z[gf] then
			z[gf]:Remove()
			z[gf] = nil
		end
	end)
end
local function gh(gf)
	if aa[gf] or not gf:IsA("Model") then
		return
	end
	local fy = Color3.new(1, 1, 0)
	local gd = Instance.new("Highlight")
	gd.Parent = gf
	gd.FillTransparency = d.di.Value or bd
	gd.OutlineTransparency = d.dg.Value or bc
	gd.OutlineColor = fy
	gd.Enabled = false
	aa[gf] = gd
	gf.AncestryChanged:Connect(function()
		if aa[gf] then
			aa[gf]:Destroy()
			aa[gf] = nil
		end
	end)
end
local function gi()
	local fs = d.dd.Value or ba
	local gj = d.de.Value or bb
	if e.cr and e.cr.Value then
		for fw, da in pairs(v) do
			if fw and fw.Parent and fw:FindFirstChild("Head") then
				local ej = fw.Head
				local bt = fw:FindFirstChild("Humanoid")
				local gk, gl = k:WorldToViewportPoint(ej.Position)
				local ci = (ej.Position - k.CFrame.Position).Magnitude
				local gm = bt and (bt.Health <= 0.01 and "DEAD" or tostring(math.floor(bt.Health))) or "N/A"
				local gn = fw.Name .. " | STUDS: " .. math.floor(ci) .. " | HEALTH: " .. gm
				da.Text = gn
				da.Position = Vector2.new(gk.X, gk.Y - 20)
				da.Size = d.cz.Value or 16
				da.Font = fo(d.db.Value or "Plex")
				da.Visible = gl
			else
				da.Visible = false
			end
		end
	end
	if e.cs and e.cs.Value then
		local go
		if fs == "Bottom" then
			go = Vector2.new(k.ViewportSize.X / 2, k.ViewportSize.Y)
		elseif fs == "Up" then
			go = Vector2.new(k.ViewportSize.X / 2, 0)
		else
			go = Vector2.new(k.ViewportSize.X / 2, k.ViewportSize.Y / 2)
		end
		for fw, gb in pairs(w) do
			if fw and fw.Parent and fw:FindFirstChild("Head") then
				local gp = fq(fw)
				if gp then
					local gk, gl = k:WorldToViewportPoint(gp)
					gb.From = go
					gb.To = Vector2.new(gk.X, gk.Y)
					gb.Thickness = gj
					gb.Visible = gl
				else
					gb.Visible = false
				end
			else
				gb.Visible = false
			end
		end
	end
	if e.ct and e.ct.Value then
		for fw, dh in pairs(x) do
			if fw and fw.Parent then
				dh.OutlineTransparency = d.dg.Value or bc
				dh.FillTransparency = d.di.Value or bd
				dh.Enabled = true
			else
				dh.Enabled = false
			end
		end
	else
		for _, dh in pairs(x) do
			dh.Enabled = false
		end
	end
	if e.cu and e.cu.Value then
		for gf, da in pairs(y) do
			if gf and gf.Parent then
				local cg, ch = pcall(function()
					return gf:GetBoundingBox()
				end)
				if cg and ch then
					local gk, gl = k:WorldToViewportPoint(ch.Position)
					local ci = (ch.Position - k.CFrame.Position).Magnitude
					local gn = gf.Name .. " | STUDS: " .. math.floor(ci)
					da.Text = gn
					da.Position = Vector2.new(gk.X, gk.Y - 20)
					da.Size = d.cz.Value or 16
					da.Font = fo(d.db.Value or "Plex")
					da.Visible = gl
				else
					da.Visible = false
				end
			else
				da.Visible = false
			end
		end
	end
	if e.cv and e.cv.Value then
		local go
		if fs == "Bottom" then
			go = Vector2.new(k.ViewportSize.X / 2, k.ViewportSize.Y)
		elseif fs == "Up" then
			go = Vector2.new(k.ViewportSize.X / 2, 0)
		else
			go = Vector2.new(k.ViewportSize.X / 2, k.ViewportSize.Y / 2)
		end
		for gf, gb in pairs(z) do
			if gf and gf.Parent then
				local cg, ch = pcall(function()
					return gf:GetBoundingBox()
				end)
				if cg and ch then
					local gk, gl = k:WorldToViewportPoint(ch.Position)
					gb.From = go
					gb.To = Vector2.new(gk.X, gk.Y)
					gb.Thickness = gj
					gb.Visible = gl
				else
					gb.Visible = false
				end
			else
				gb.Visible = false
			end
		end
	end
	if e.cw and e.cw.Value then
		for gf, dh in pairs(aa) do
			if gf and gf.Parent then
				dh.OutlineTransparency = d.dg.Value or bc
				dh.FillTransparency = d.di.Value or bd
				dh.Enabled = true
			else
				dh.Enabled = false
			end
		end
	else
		for _, dh in pairs(aa) do
			dh.Enabled = false
		end
	end
end
local function gq()
	if ab then
		return
	end
	ab = g.Heartbeat:Connect(gi)
end
local function gr()
	if ab then
		ab:Disconnect()
		ab = nil
	end
end
e.cr:OnChanged(function(bz)
	if bz then
		if p then
			for _, fw in pairs(p:GetChildren()) do
				fv(fw)
			end
		end
		if r then
			for _, eh in pairs(r:GetChildren()) do
				fv(eh)
			end
		end
		gq()
	else
		for gs, da in pairs(v) do
			if da then
				da:Remove()
			end
		end
		v = {}
		if not (e.cs.Value or e.ct.Value or e.cu.Value or e.cv.Value or e.cw.Value) then
			gr()
		end
	end
end)
if p then
	p.ChildAdded:Connect(function(fw)
		if e.cr.Value then
			task.wait(0.1)
			fv(fw)
			gq()
		end
	end)
end
if r then
	r.ChildAdded:Connect(function(eh)
		if e.cr.Value then
			task.wait(0.1)
			fv(eh)
			gq()
		end
	end)
end
e.cs:OnChanged(function(bz)
	if bz then
		if p then
			for _, fw in pairs(p:GetChildren()) do
				ga(fw)
			end
		end
		if r then
			for _, eh in pairs(r:GetChildren()) do
				ga(eh)
			end
		end
		gq()
	else
		for gs, gb in pairs(w) do
			if gb then
				gb:Remove()
			end
		end
		w = {}
		if not (e.cr.Value or e.ct.Value or e.cu.Value or e.cv.Value or e.cw.Value) then
			gr()
		end
	end
end)
if p then
	p.ChildAdded:Connect(function(fw)
		if e.cs.Value then
			task.wait(0.1)
			ga(fw)
			gq()
		end
	end)
end
if r then
	r.ChildAdded:Connect(function(eh)
		if e.cs.Value then
			task.wait(0.1)
			ga(eh)
			gq()
		end
	end)
end
e.ct:OnChanged(function(bz)
	if bz then
		if p then
			for _, fw in pairs(p:GetChildren()) do
				gc(fw)
			end
		end
		if r then
			for _, eh in pairs(r:GetChildren()) do
				gc(eh)
			end
		end
		gq()
	else
		for gs, dh in pairs(x) do
			if dh then
				dh.Enabled = false
			end
		end
		if not (e.cr.Value or e.cs.Value or e.cu.Value or e.cv.Value or e.cw.Value) then
			gr()
		end
	end
end)
if p then
	p.ChildAdded:Connect(function(fw)
		if e.ct.Value then
			task.wait(0.1)
			gc(fw)
			gq()
		end
	end)
end
if r then
	r.ChildAdded:Connect(function(eh)
		if e.ct.Value then
			task.wait(0.1)
			gc(eh)
			gq()
		end
	end)
end
e.cu:OnChanged(function(bz)
	if bz then
		if q then
			for _, gf in pairs(q:GetChildren()) do
				ge(gf)
			end
			gq()
		end
	else
		for gt, da in pairs(y) do
			if da then
				da:Remove()
			end
		end
		y = {}
		if not (e.cr.Value or e.cs.Value or e.ct.Value or e.cv.Value or e.cw.Value) then
			gr()
		end
	end
end)
if q then
	q.ChildAdded:Connect(function(gf)
		if e.cu.Value then
			task.wait(0.1)
			ge(gf)
			gq()
		end
	end)
end
e.cv:OnChanged(function(bz)
	if bz then
		if q then
			for _, gf in pairs(q:GetChildren()) do
				gg(gf)
			end
			gq()
		end
	else
		for gt, gb in pairs(z) do
			if gb then
				gb:Remove()
			end
		end
		z = {}
		if not (e.cr.Value or e.cs.Value or e.ct.Value or e.cu.Value or e.cw.Value) then
			gr()
		end
	end
end)
if q then
	q.ChildAdded:Connect(function(gf)
		if e.cv.Value then
			task.wait(0.1)
			gg(gf)
			gq()
		end
	end)
end
e.cw:OnChanged(function(bz)
	if bz then
		if q then
			for _, gf in pairs(q:GetChildren()) do
				gh(gf)
			end
			gq()
		end
	else
		for gt, dh in pairs(aa) do
			if dh then
				dh.Enabled = false
			end
		end
		if not (e.cr.Value or e.cs.Value or e.ct.Value or e.cu.Value or e.cv.Value) then
			gr()
		end
	end
end)
if q then
	q.ChildAdded:Connect(function(gf)
		if e.cw.Value then
			task.wait(0.1)
			gh(gf)
			gq()
		end
	end)
end
if p then
	p.ChildRemoved:Connect(function(gu)
		if v[gu] then
			v[gu]:Remove()
			v[gu] = nil
		end
		if w[gu] then
			w[gu]:Remove()
			w[gu] = nil
		end
		if x[gu] then
			x[gu]:Destroy()
			x[gu] = nil
		end
	end)
end
if r then
	r.ChildRemoved:Connect(function(eh)
		if v[eh] then
			v[eh]:Remove()
			v[eh] = nil
		end
		if w[eh] then
			w[eh]:Remove()
			w[eh] = nil
		end
		if x[eh] then
			x[eh]:Destroy()
			x[eh] = nil
		end
	end)
end
if q then
	q.ChildRemoved:Connect(function(gf)
		if y[gf] then
			y[gf]:Remove()
			y[gf] = nil
		end
		if z[gf] then
			z[gf]:Remove()
			z[gf] = nil
		end
		if aa[gf] then
			aa[gf]:Destroy()
			aa[gf] = nil
		end
		t[gf] = nil
		u[gf] = nil
	end)
end
local gv = bk.bo:AddLeftGroupbox("Menu")
gv:AddToggle("gw", {Default = a.KeybindFrame.Visible, Text = "Open Keybind Menu", Callback = function(bz)
	a.KeybindFrame.Visible = bz
end})
gv:AddToggle("gx", {Text = "Custom Cursor", Default = true, Callback = function(bz)
	a.ShowCustomCursor = bz
end})
gv:AddDropdown("gy", {Values = {"Left", "Right"}, Default = "Right", Text = "Notification Side", Callback = function(br)
	a:SetNotifySide(br)
end})
gv:AddDropdown("gz", {Values = {"50%", "75%", "100%", "125%", "150%", "175%", "200%"}, Default = "100%", Text = "DPI Scale", Callback = function(br)
	br = br:gsub("%%", "")
	local ha = tonumber(br)
	a:SetDPIScale(ha)
end})
gv:AddDivider()
gv:AddLabel("Menu bind"):AddKeyPicker("hb", {Default = "RightShift", NoUI = true, Text = "Menu keybind"})
gv:AddButton("Unload", function()
	a:Unload()
end)
gv:AddLabel("<font color='rgb(255,0,0)'><u>DISCLAIMER</u></font>: We Use This To See How Many Users We Get, <u>We Do Not Share This Information With Any Third Partys</u>.", true)
gv:AddToggle("OptOutLog", {
	Text = "Opt-Out Log",
	Default = isfile("optout.unx"),
	Callback = function(bz)
		if bz then
			writefile("optout.unx", "")
			a:Notify("Opt-Out Log Enabled", 3)
		else
			if isfile("optout.unx") then
				delfile("optout.unx")
			end
			a:Notify("Opt-Out Log Disabled", 3)
		end
	end
})
a.ToggleKeybind = d.hb
b:SetLibrary(a)
c:SetLibrary(a)
c:IgnoreThemeSettings()
c:SetIgnoreIndexes({"hb"})
b:SetFolder("UNXHub")
c:SetFolder("UNXHub")
c:BuildConfigSection(bk.bo)
b:ApplyToTab(bk.bo)
c:LoadAutoloadConfig()
a:OnUnload(function()
	if l then
		l:Disconnect()
	end
	if m then
		m:Disconnect()
	end
	if n then
		n:Disconnect()
	end
	if o then
		o:Disconnect()
	end
	if ab then
		ab:Disconnect()
	end
	k.FieldOfView = ad.al
	i.Brightness = ad.ae
	i.Ambient = ad.af
	i.FogEnd = ad.ag
	i.Technology = ad.ah
	h.Gravity = ad.aj
	j.CameraMaxZoomDistance = ad.ak
	for dq, dr in pairs(ad.ai) do
		if dq.Parent and dq:IsA("MeshPart") then
			dq.TextureID = dr
		end
	end
	for _, da in pairs(v) do
		if da then
			da:Remove()
		end
	end
	for _, gb in pairs(w) do
		if gb then
			gb:Remove()
		end
	end
	for _, dh in pairs(x) do
		if dh then
			dh:Destroy()
		end
	end
	for _, da in pairs(y) do
		if da then
			da:Remove()
		end
	end
	for _, gb in pairs(z) do
		if gb then
			gb:Remove()
		end
	end
	for _, dh in pairs(aa) do
		if dh then
			dh:Destroy()
		end
	end
	if ac then
		ac:Destroy()
	end
	getgenv().unxshared.isloaded = false
end)
