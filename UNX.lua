loadstring(game:HttpGet("https://apigetunx.vercel.app/Modules/v2/Inv.lua",true))()

if getgenv().unxshared and getgenv().unxshared.isloaded == true then
	warn("UNXHub is already loaded. Skipping initialization.")
	return
end

local a=game:GetService("TweenService")
local b=game:GetService("Players")
local c=game:GetService("CoreGui")
local d=b.LocalPlayer
local e={Background=Color3.fromRGB(26,26,26),BackgroundLight=Color3.fromRGB(35,35,35),BackgroundDark=Color3.fromRGB(20,20,20),Text=Color3.fromRGB(255,255,255),TextDim=Color3.fromRGB(180,180,180),Border=Color3.fromRGB(50,50,50),Accent=Color3.fromRGB(0,127,255),Success=Color3.fromRGB(40,200,100),Error=Color3.fromRGB(255,80,80),Traffic={Red=Color3.fromRGB(255,95,87),Yellow=Color3.fromRGB(255,189,46),Green=Color3.fromRGB(40,201,64)}}
local f=Instance.new("ScreenGui",c)
f.Name="UNXLoaderUI"
f.ResetOnSpawn=false
f.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local g=Instance.new("Frame")
g.Size=UDim2.new(0.65,0,0.65,0)
g.Position=UDim2.new(0.175,0,0.175,0)
g.BackgroundColor3=e.Background
g.Active=true
g.Draggable=true
g.BorderSizePixel=0
g.ClipsDescendants=true
g.ZIndex=2
g.Parent=f
local h=Instance.new("UICorner",g)
h.CornerRadius=UDim.new(0,12)
local i=Instance.new("UIStroke",g)
i.Color=e.Border
i.Thickness=1
i.Transparency=0.3
i.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
local j=Instance.new("Frame")
j.Size=UDim2.new(1,0,0,40)
j.BackgroundColor3=e.BackgroundLight
j.BorderSizePixel=0
j.ZIndex=3
j.Parent=g
local k=Instance.new("UICorner",j)
k.CornerRadius=UDim.new(0,12)
local l=Instance.new("Frame")
l.Size=UDim2.new(1,0,0,12)
l.Position=UDim2.new(0,0,1,-12)
l.BackgroundColor3=e.BackgroundLight
l.BorderSizePixel=0
l.ZIndex=3
l.Parent=j
local m=Instance.new("Frame")
m.Size=UDim2.new(1,0,0,1)
m.Position=UDim2.new(0,0,1,0)
m.BackgroundColor3=e.Border
m.BorderSizePixel=0
m.ZIndex=4
m.Parent=j
local n=Instance.new("Frame")
n.Size=UDim2.new(0,60,0,14)
n.Position=UDim2.new(0,12,0.5,0)
n.AnchorPoint=Vector2.new(0,0.5)
n.BackgroundTransparency=1
n.ZIndex=4
n.Parent=j
local o=Instance.new("UIListLayout")
o.FillDirection=Enum.FillDirection.Horizontal
o.HorizontalAlignment=Enum.HorizontalAlignment.Left
o.VerticalAlignment=Enum.VerticalAlignment.Center
o.Padding=UDim.new(0,6)
o.SortOrder=Enum.SortOrder.LayoutOrder
o.Parent=n
local function p(q,r)
	local s=Instance.new("TextButton")
	s.Size=UDim2.new(0,12,0,12)
	s.BackgroundColor3=q
	s.Text=""
	s.AutoButtonColor=false
	s.BorderSizePixel=0
	s.ZIndex=5
	s.LayoutOrder=r
	s.Parent=n
	local t=Instance.new("UICorner")
	t.CornerRadius=UDim.new(1,0)
	t.Parent=s
	return s
end
local u=p(e.Traffic.Red,1)
local v=p(e.Traffic.Yellow,2)
local w=p(e.Traffic.Green,3)
local x=Instance.new("TextLabel")
x.Size=UDim2.new(0,200,1,0)
x.Position=UDim2.new(0.5,0,0,0)
x.AnchorPoint=Vector2.new(0.5,0)
x.BackgroundTransparency=1
x.Text="UNXLoader"
x.TextColor3=e.Text
x.Font=Enum.Font.Gotham
x.TextSize=14
x.ZIndex=4
x.Parent=j
local y=Instance.new("Frame")
y.Parent=g
y.Size=UDim2.new(0.9,0,0.6,0)
y.Position=UDim2.new(0.05,0,0,50)
y.BackgroundColor3=e.BackgroundDark
y.BorderSizePixel=0
y.ZIndex=3
local z=Instance.new("UICorner",y)
z.CornerRadius=UDim.new(0,8)
local aa=Instance.new("UIStroke",y)
aa.Color=e.Border
aa.Thickness=1
aa.Transparency=0.5
aa.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
local ab=Instance.new("TextLabel")
ab.Parent=y
ab.Size=UDim2.new(1,-30,0,32)
ab.Position=UDim2.new(0,12,0,0)
ab.BackgroundTransparency=1
ab.Text="Output"
ab.Font=Enum.Font.Gotham
ab.TextColor3=e.Text
ab.TextSize=13
ab.TextXAlignment=Enum.TextXAlignment.Left
ab.ZIndex=4
local ac=Instance.new("ScrollingFrame")
ac.Parent=y
ac.Size=UDim2.new(1,-24,1,-44)
ac.Position=UDim2.new(0,12,0,36)
ac.BackgroundTransparency=1
ac.BorderSizePixel=0
ac.CanvasSize=UDim2.new(0,0,0,0)
ac.ScrollBarThickness=4
ac.ScrollBarImageColor3=e.Border
ac.ZIndex=4
local ad=Instance.new("UIListLayout")
ad.Padding=UDim.new(0,4)
ad.SortOrder=Enum.SortOrder.LayoutOrder
ad.Parent=ac
local ae=Instance.new("ImageButton")
ae.Parent=y
ae.Size=UDim2.new(0,18,0,18)
ae.AnchorPoint=Vector2.new(1,0)
ae.Position=UDim2.new(1,-12,0,7)
ae.BackgroundTransparency=1
ae.Image="rbxassetid://90434151822042"
ae.ImageColor3=e.TextDim
ae.ZIndex=5
local af=Instance.new("Frame")
af.Parent=g
af.Size=UDim2.new(0.8,0,0,6)
af.Position=UDim2.new(0.1,0,0.88,0)
af.BackgroundColor3=e.BackgroundLight
af.BorderSizePixel=0
af.ZIndex=3
local ag=Instance.new("UICorner",af)
ag.CornerRadius=UDim.new(1,0)
local ah=Instance.new("UIStroke",af)
ah.Color=e.Border
ah.Thickness=1
ah.Transparency=0.6
ah.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
local ai=Instance.new("Frame")
ai.Parent=af
ai.Size=UDim2.new(0.25,0,1,0)
ai.BackgroundColor3=Color3.fromRGB(255,0,0)
ai.BorderSizePixel=0
ai.ZIndex=4
local aj=Instance.new("UICorner",ai)
aj.CornerRadius=UDim.new(1,0)
task.spawn(function()
	local ak=0
	while ai and ai.Parent do
		ak=(ak+0.002)%1
		ai.BackgroundColor3=Color3.fromHSV(ak,1,1)
		task.wait(0.05)
	end
end)
task.spawn(function()
	while ai and ai.Parent do
		a:Create(ai,TweenInfo.new(2.4,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Position=UDim2.new(0.75,0,0,0)}):Play()
		task.wait(2.4)
		a:Create(ai,TweenInfo.new(2.4,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Position=UDim2.new(0,0,0,0)}):Play()
		task.wait(2.4)
	end
end)
local al={}
local function am(an)
	table.insert(al,an)
	local ao=Instance.new("TextLabel")
	ao.Size=UDim2.new(1,-10,0,0)
	ao.BackgroundTransparency=1
	ao.Text="> "..an
	ao.TextColor3=e.TextDim
	ao.TextSize=12
	ao.Font=Enum.Font.Code
	ao.TextXAlignment=Enum.TextXAlignment.Left
	ao.TextYAlignment=Enum.TextYAlignment.Top
	ao.TextWrapped=true
	ao.ZIndex=5
	ao.Parent=ac
	task.wait()
	ao.Size=UDim2.new(1,-10,0,ao.TextBounds.Y)
	ac.CanvasSize=UDim2.new(0,0,0,ad.AbsoluteContentSize.Y+10)
	ac.CanvasPosition=Vector2.new(0,ad.AbsoluteContentSize.Y-ac.AbsoluteSize.Y)
end
local function ap()
	local aq=table.concat(al,"\n")
	setclipboard(aq)
	local ar=a:Create(ae,TweenInfo.new(0.2),{ImageTransparency=1})
	ar:Play()
	ar.Completed:Wait()
	ae.Image="rbxassetid://14203226653"
	ae.ImageColor3=e.Success
	local as=a:Create(ae,TweenInfo.new(0.2),{ImageTransparency=0})
	as:Play()
	task.wait(1)
	local at=a:Create(ae,TweenInfo.new(0.2),{ImageTransparency=1})
	at:Play()
	at.Completed:Wait()
	ae.Image="rbxassetid://90434151822042"
	ae.ImageColor3=e.TextDim
	a:Create(ae,TweenInfo.new(0.2),{ImageTransparency=0}):Play()
end
ae.MouseButton1Click:Connect(ap)
for _,au in pairs({u,v,w})do
	au.MouseEnter:Connect(function()
		a:Create(au,TweenInfo.new(0.15,Enum.EasingStyle.Quad),{Size=UDim2.new(0,14,0,14)}):Play()
	end)
	au.MouseLeave:Connect(function()
		a:Create(au,TweenInfo.new(0.15,Enum.EasingStyle.Quad),{Size=UDim2.new(0,12,0,12)}):Play()
	end)
end
u.MouseButton1Click:Connect(function()
	local av=TweenInfo.new(0.25)
	for _,aw in ipairs(f:GetDescendants())do
		if aw:IsA("GuiObject")then
			local ax={}
			if aw:IsA("Frame")or aw:IsA("ImageLabel")or aw:IsA("ImageButton")or aw:IsA("ViewportFrame")or aw:IsA("ScrollingFrame")then
				ax.BackgroundTransparency=1
			end
			if aw:IsA("TextLabel")or aw:IsA("TextButton")or aw:IsA("TextBox")then
				ax.TextTransparency=1
			end
			if aw:IsA("ImageLabel")or aw:IsA("ImageButton")then
				ax.ImageTransparency=1
			end
			if next(ax)then
				a:Create(aw,av,ax):Play()
			end
		end
	end
	task.wait(0.3)
	f:Destroy()
end)
w.MouseButton1Click:Connect(function()
	local ay=TweenInfo.new(0.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
	if g.Size~=UDim2.new(1,0,1,0)then
		a:Create(g,ay,{Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0)}):Play()
		a:Create(y,ay,{Size=UDim2.new(0.9,0,0.7,0),Position=UDim2.new(0.05,0,0,50)}):Play()
		a:Create(af,ay,{Position=UDim2.new(0.1,0,0.92,0)}):Play()
	else
		a:Create(g,ay,{Size=UDim2.new(0.65,0,0.65,0),Position=UDim2.new(0.175,0,0.175,0)}):Play()
		a:Create(y,ay,{Size=UDim2.new(0.9,0,0.6,0),Position=UDim2.new(0.05,0,0,50)}):Play()
		a:Create(af,ay,{Position=UDim2.new(0.1,0,0.88,0)}):Play()
	end
end)
local az=game:GetService("MarketplaceService")
local ba=game:GetService("RunService")
local bb=game:GetService("Stats")
am("UNXHub Loader v2.1.0 initialized")
am("[WARNING]: By executing UNXHub you accept our Terms Of Service")
am("[WARNING]: Learn more on http://getunx.vercel.app/tos.html")
am("[WARNING]: PLEASE READ THE MESSAGE ABOVE!!!!!")
task.wait(0.1)
am("Creating global variables...")
task.wait(0.05)
getgenv().unxshared={version="2.2.0 (Patch 3)",gamename=az:GetProductInfo(game.PlaceId).Name,issupported=false,playername=d.Name,playerid=d.UserId,isloaded=false,devnote="https://discord.gg/zpaMS8qUfB"}
loadstring(game:HttpGet("https://apigetunx.vercel.app/Modules/v2/Log.lua",true))()

am("Player: "..d.Name.." (ID: "..d.UserId..")")
task.wait(0.05)
am("Game: "..getgenv().unxshared.gamename)
task.wait(0.14)
am("Checking game compatibility...")
task.wait(0.02)
local bc=game.PlaceId
am("Game ID: "..tostring(bc))
task.wait(0.12)
local bd={[1240123653]="https://apigetunx.vercel.app/Games/ZombieAttack.lua",[1632210982]="https://apigetunx.vercel.app/Games/ZombieAttack.lua",[12240122896]="https://apigetunx.vercel.app/Games/FigureL.lua",[136801880565837]="https://apigetunx.vercel.app/Games/Flick.lua"}
local be,bf
if bd[bc]then
	getgenv().unxshared.issupported=true
	am("Game verified, loading "..getgenv().unxshared.gamename.." | Dev Note: "..getgenv().unxshared.devnote)
	task.wait(0.05)
	am("Fetching game-specific script...")
	task.wait(0.01)
	be,bf=pcall(function()
		loadstring(game:HttpGet(bd[bc]))()
	end)
else
	getgenv().unxshared.issupported=false
	am("Game not supported, loading universal")
	task.wait(0.03)
	am("Fetching universal script...")
	task.wait(0.1)
	be,bf=pcall(function()
		loadstring(game:HttpGet("https://apigetunx.vercel.app/Games/Universal.lua"))()
	end)
end
if be then
	getgenv().unxshared.isloaded=true
	am("Script loaded successfully")
	task.wait(0.05)
	am("Initialization complete!")
	task.wait(0.7)
	local bg=TweenInfo.new(0.25)
	for _,bh in ipairs(f:GetDescendants())do
		if bh:IsA("GuiObject")then
			local bi={}
			if bh:IsA("Frame")or bh:IsA("ImageLabel")or bh:IsA("ImageButton")or bh:IsA("ViewportFrame")or bh:IsA("ScrollingFrame")then
				bi.BackgroundTransparency=1
			end
			if bh:IsA("TextLabel")or bh:IsA("TextButton")or bh:IsA("TextBox")then
				bi.TextTransparency=1
			end
			if bh:IsA("ImageLabel")or bh:IsA("ImageButton")then
				bi.ImageTransparency=1
			end
			if next(bi)then
				a:Create(bh,bg,bi):Play()
			end
		end
	end
	task.wait(0.3)
	f:Destroy()
else
	getgenv().unxshared.isloaded=false
	local bj="Error: "..tostring(bf)
	am("Script failed to load")
	task.wait(0.2)
	am(bj)
	task.wait(0.2)
	am("<====> PLAYER INFORMATION <====>")
	am("Player Name: "..d.Name)
	am("Display Name: "..d.DisplayName)
	am("User ID: "..tostring(d.UserId))
	am("Current Time: "..os.date("%Y-%m-%d %H:%M:%S"))
	local bk=math.floor(1/ba.RenderStepped:Wait())
	am("FPS: "..tostring(bk))
	local bl=math.floor(bb.Network.ServerStatsItem["Data Ping"]:GetValue())
	am("Ping: "..tostring(bl).."ms | Server: Hidden For Privacy Purposes.")
	task.wait(0.2)
	am("UI will remain open for debugging")
	am("Please Click 'Copy' Button And Report This To The Owner.")
	warn("UNXHub Loader Error:",bf)
	pcall(setclipboard,tostring(bf))
end
