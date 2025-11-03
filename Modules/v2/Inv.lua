local a=game:GetService("TweenService")
local b=game:GetService("UserInputService")
local c=game:GetService("Players")
local d=c.LocalPlayer
local e=d:GetMouse()
local f=gethui and gethui()or game:GetService("CoreGui")
if isfile and isfile("dontshowagain.unx")then return end
local g={Background=Color3.fromRGB(26,26,26),BackgroundLight=Color3.fromRGB(35,35,35),Text=Color3.fromRGB(255,255,255),TextDim=Color3.fromRGB(180,180,180),Border=Color3.fromRGB(50,50,50),Button=Color3.fromRGB(0,127,255),ButtonHover=Color3.fromRGB(30,147,255),Success=Color3.fromRGB(40,200,100),Secondary=Color3.fromRGB(70,70,70),Traffic={Red=Color3.fromRGB(255,95,87),Yellow=Color3.fromRGB(255,189,46),Green=Color3.fromRGB(40,201,64)}}
local h=Instance.new("ScreenGui")
h.Name="UNXInvite"
h.ResetOnSpawn=false
h.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
h.Parent=f
local i=Instance.new("Frame")
i.Name="Main"
i.Size=UDim2.fromScale(0,0)
i.Position=UDim2.fromScale(0.5,0.5)
i.AnchorPoint=Vector2.new(0.5,0.5)
i.BackgroundColor3=g.Background
i.BorderSizePixel=0
i.ClipsDescendants=true
i.ZIndex=2
i.Parent=h
local j=Instance.new("UICorner")
j.CornerRadius=UDim.new(0,12)
j.Parent=i
local k=Instance.new("UIStroke")
k.Color=g.Border
k.Thickness=1
k.Transparency=0.3
k.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
k.Parent=i
local l=Instance.new("UIAspectRatioConstraint")
l.AspectRatio=0.75
l.Parent=i
local m=Instance.new("Frame")
m.Name="TitleBar"
m.Size=UDim2.new(1,0,0,40)
m.BackgroundColor3=g.BackgroundLight
m.BorderSizePixel=0
m.ZIndex=3
m.Parent=i
local n=Instance.new("UICorner")
n.CornerRadius=UDim.new(0,12)
n.Parent=m
local o=Instance.new("Frame")
o.Size=UDim2.new(1,0,0,12)
o.Position=UDim2.new(0,0,1,-12)
o.BackgroundColor3=g.BackgroundLight
o.BorderSizePixel=0
o.ZIndex=3
o.Parent=m
local p=Instance.new("Frame")
p.Size=UDim2.new(1,0,0,1)
p.Position=UDim2.new(0,0,1,0)
p.BackgroundColor3=g.Border
p.BorderSizePixel=0
p.ZIndex=4
p.Parent=m
local q=Instance.new("Frame")
q.Size=UDim2.new(0,60,0,14)
q.Position=UDim2.new(0,12,0.5,0)
q.AnchorPoint=Vector2.new(0,0.5)
q.BackgroundTransparency=1
q.ZIndex=4
q.Parent=m
local r=Instance.new("UIListLayout")
r.FillDirection=Enum.FillDirection.Horizontal
r.HorizontalAlignment=Enum.HorizontalAlignment.Left
r.VerticalAlignment=Enum.VerticalAlignment.Center
r.Padding=UDim.new(0,6)
r.SortOrder=Enum.SortOrder.LayoutOrder
r.Parent=q
local function s(t,u)
	local v=Instance.new("TextButton")
	v.Size=UDim2.new(0,12,0,12)
	v.BackgroundColor3=t
	v.Text=""
	v.AutoButtonColor=false
	v.BorderSizePixel=0
	v.ZIndex=5
	v.LayoutOrder=u
	v.Parent=q
	local w=Instance.new("UICorner")
	w.CornerRadius=UDim.new(1,0)
	w.Parent=v
	return v
end
local x=s(g.Traffic.Red,1)
local y=s(g.Traffic.Yellow,2)
local z=s(g.Traffic.Green,3)
local aa=Instance.new("TextLabel")
aa.Size=UDim2.new(0,200,1,0)
aa.Position=UDim2.new(0.5,0,0,0)
aa.AnchorPoint=Vector2.new(0.5,0)
aa.BackgroundTransparency=1
aa.Text="Invite"
aa.TextColor3=g.Text
aa.Font=Enum.Font.Gotham
aa.TextSize=14
aa.ZIndex=4
aa.Parent=m
local ab=Instance.new("Frame")
ab.Size=UDim2.new(1,0,1,-40)
ab.Position=UDim2.new(0,0,0,40)
ab.BackgroundTransparency=1
ab.ZIndex=3
ab.Parent=i
local ac=Instance.new("Frame")
ac.Size=UDim2.fromScale(0.9,0.9)
ac.Position=UDim2.fromScale(0.05,0.05)
ac.BackgroundTransparency=1
ac.ZIndex=3
ac.Parent=ab
local ad=Instance.new("ImageLabel")
ad.Size=UDim2.fromScale(0.28,0.28)
ad.Position=UDim2.fromScale(0.36,0.02)
ad.BackgroundTransparency=1
ad.Image="rbxassetid://17350161674"
ad.ZIndex=4
ad.Parent=ac
local ae=Instance.new("UICorner")
ae.CornerRadius=UDim.new(0,12)
ae.Parent=ad
local af=Instance.new("TextLabel")
af.Size=UDim2.fromScale(0.9,0.12)
af.Position=UDim2.fromScale(0.05,0.32)
af.BackgroundTransparency=1
af.Text="UNX Community"
af.TextColor3=g.Text
af.Font=Enum.Font.Gotham
af.TextScaled=true
af.ZIndex=4
af.Parent=ac
local ag=Instance.new("TextLabel")
ag.Size=UDim2.fromScale(0.9,0.1)
ag.Position=UDim2.fromScale(0.05,0.44)
ag.BackgroundTransparency=1
ag.Text="Official UNXHub Server!"
ag.TextColor3=g.TextDim
ag.Font=Enum.Font.Gotham
ag.TextScaled=true
ag.ZIndex=4
ag.Parent=ac
local ah=Instance.new("Frame")
ah.Size=UDim2.fromScale(0.9,0.38)
ah.Position=UDim2.fromScale(0.05,0.58)
ah.BackgroundTransparency=1
ah.ZIndex=3
ah.Parent=ac
local ai=Instance.new("UIListLayout")
ai.FillDirection=Enum.FillDirection.Vertical
ai.HorizontalAlignment=Enum.HorizontalAlignment.Center
ai.VerticalAlignment=Enum.VerticalAlignment.Center
ai.Padding=UDim.new(0.06,0)
ai.SortOrder=Enum.SortOrder.LayoutOrder
ai.Parent=ah
local function aj(ak,al,am,an)
	local ao=Instance.new("TextButton")
	ao.Size=UDim2.fromScale(1,0.26)
	ao.BackgroundColor3=ak
	ao.Text=al
	ao.TextColor3=g.Text
	ao.Font=Enum.Font.Gotham
	ao.TextScaled=true
	ao.AutoButtonColor=false
	ao.BorderSizePixel=0
	ao.LayoutOrder=am
	ao.ZIndex=5
	ao.Parent=ah
	local ap=Instance.new("UICorner")
	ap.CornerRadius=UDim.new(0,8)
	ap.Parent=ao
	local aq=Instance.new("UIStroke")
	aq.Color=g.Border
	aq.Thickness=1
	aq.Transparency=0.5
	aq.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
	aq.Parent=ao
	ao.MouseButton1Click:Connect(an)
	return ao
end
local ar=aj(g.Button,"Accept Invite",1,function()
	if setclipboard then setclipboard("https://discord.gg/zpaMS8qUfB")end
	local function as(at,au,av)
		ar.Text=""
		for aw=1,#at do
			ar.Text=ar.Text..at:sub(aw,aw)
			task.wait(au)
		end
		if av then av()end
	end
	a:Create(ar,TweenInfo.new(0.5,Enum.EasingStyle.Quad),{BackgroundColor3=g.Success}):Play()
	task.wait(0.5)
	as("Copied To Clipboard",0.05)
	task.wait(5)
	as("Accept Invite",0.05,function()
		a:Create(ar,TweenInfo.new(0.5,Enum.EasingStyle.Quad),{BackgroundColor3=g.Button}):Play()
	end)
end)
local ax=aj(g.Secondary,"No, Thanks",2,function()
	a:Create(i,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.fromScale(0,0)}):Play()
	task.delay(0.3,function()h:Destroy()end)
end)
local ay=aj(g.Secondary,"No Thanks, Never",3,function()
	if writefile then writefile("dontshowagain.unx","")end
	a:Create(i,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.fromScale(0,0)}):Play()
	task.delay(0.3,function()h:Destroy()end)
end)
for _,az in pairs({x,y,z})do
	az.MouseEnter:Connect(function()
		a:Create(az,TweenInfo.new(0.15,Enum.EasingStyle.Quad),{Size=UDim2.new(0,14,0,14)}):Play()
	end)
	az.MouseLeave:Connect(function()
		a:Create(az,TweenInfo.new(0.15,Enum.EasingStyle.Quad),{Size=UDim2.new(0,12,0,12)}):Play()
	end)
end
x.MouseButton1Click:Connect(function()
	a:Create(i,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.fromScale(0,0)}):Play()
	task.delay(0.3,function()h:Destroy()end)
end)
local ba,bb,bc,bd,be,bf=false,false,nil,nil,nil,nil
local bg=workspace.CurrentCamera.ViewportSize
i.MouseEnter:Connect(function()ba=true end)
i.MouseLeave:Connect(function()ba=false end)
b.InputBegan:Connect(function(bh)
	if bh.UserInputType==Enum.UserInputType.MouseButton1 or bh.UserInputType==Enum.UserInputType.Touch then
		if ba then
			bb=true
			bc=e.X
			bd=e.Y
			be=i.Position
			bf=e.Move:Connect(function()
				if not bb then if bf then bf:Disconnect()bf=nil end return end
				local bi=(bc-e.X)
				local bj=(bd-e.Y)
				local bk=be-UDim2.new(bi/bg.X,0,bj/bg.Y,0)
				local bl=i.Size.X.Scale/2
				local bm=i.Size.Y.Scale/2
				i.Position=UDim2.new(math.clamp(bk.X.Scale,bl,1-bl),0,math.clamp(bk.Y.Scale,bm,1-bm),0)
			end)
		end
	end
end)
b.InputEnded:Connect(function(bn)
	if bn.UserInputType==Enum.UserInputType.MouseButton1 or bn.UserInputType==Enum.UserInputType.Touch then
		bb=false
		if bf then bf:Disconnect()bf=nil end
	end
end)
a:Create(i,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.fromScale(0.6,0.8)}):Play()
