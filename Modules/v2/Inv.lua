-- JOIN https://discord.gg/zpaMS8qUfB

local a=game:GetService("TweenService")
local b=game:GetService("UserInputService")
local c=game:GetService("Players")
local d=c.LocalPlayer
local e=d:GetMouse()
local f=gethui and gethui()
if isfile and isfile("dontshowagain.unx")then return end
local g=Instance.new("ScreenGui")
g.Name="UNXInvite"
g.ResetOnSpawn=false
g.Parent=f
local h=Instance.new("Frame")
h.Name="Main"
h.Size=UDim2.fromScale(0,0)
h.Position=UDim2.fromScale(0.5,0.5)
h.AnchorPoint=Vector2.new(0.5,0.5)
h.BackgroundColor3=Color3.fromRGB(255,255,255)
h.BorderSizePixel=0
h.Parent=g
local i=Instance.new("UIGradient")
i.Color=ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(25,25,25)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(50,50,50))
}
i.Rotation=45
i.Parent=h
local j=Instance.new("UIAspectRatioConstraint")
j.AspectRatio=0.75
j.Parent=h
local k=Instance.new("UICorner")
k.CornerRadius=UDim.new(0,16)
k.Parent=h
local l=Instance.new("Frame")
l.Size=UDim2.fromScale(0.9,0.9)
l.Position=UDim2.fromScale(0.05,0.05)
l.BackgroundTransparency=1
l.Parent=h
local m=Instance.new("ImageLabel")
m.Size=UDim2.fromScale(0.25,0.25)
m.Position=UDim2.fromScale(0.375,0.04)
m.BackgroundTransparency=1
m.Image="rbxassetid://17350161674"
m.Parent=l
local n=Instance.new("UICorner")
n.CornerRadius=UDim.new(0,12)
n.Parent=m
local o=Instance.new("TextLabel")
o.Size=UDim2.fromScale(0.9,0.12)
o.Position=UDim2.fromScale(0.05,0.32)
o.BackgroundTransparency=1
o.Text="UNX Community"
o.TextColor3=Color3.fromRGB(255,255,255)
o.Font=Enum.Font.Gotham
o.TextScaled=true
o.Parent=l
local p=Instance.new("TextLabel")
p.Size=UDim2.fromScale(0.9,0.12)
p.Position=UDim2.fromScale(0.05,0.44)
p.BackgroundTransparency=1
p.Text="Official UNXHub Server!"
p.TextColor3=Color3.fromRGB(255,255,255)
p.Font=Enum.Font.Gotham
p.TextScaled=true
p.Parent=l
local q=Instance.new("Frame")
q.Size=UDim2.fromScale(0.9,0.38)
q.Position=UDim2.fromScale(0.05,0.58)
q.BackgroundTransparency=1
q.Parent=l
local r=Instance.new("UIListLayout")
r.FillDirection=Enum.FillDirection.Vertical
r.HorizontalAlignment=Enum.HorizontalAlignment.Center
r.VerticalAlignment=Enum.VerticalAlignment.Center
r.Padding=UDim.new(0.07,0)
r.SortOrder=Enum.SortOrder.LayoutOrder
r.Parent=q
local function s(t,u,v,w)
	local y=Instance.new("TextButton")
	y.Size=UDim2.fromScale(1,0.28)
	y.BackgroundColor3=t
	y.Text=u
	y.TextColor3=Color3.fromRGB(255,255,255)
	y.Font=Enum.Font.Gotham
	y.TextScaled=true
	y.AutoButtonColor=false
	y.LayoutOrder=v
	y.Parent=q
	local z=Instance.new("UICorner")
	z.CornerRadius=UDim.new(0,12)
	z.Parent=y
	y.MouseButton1Click:Connect(w)
	return y
end
local t
t=s(Color3.fromRGB(0,110,255),"Accept Invite",1,function()
	if setclipboard then setclipboard("https://discord.gg/zpaMS8qUfB")end
	local function u(v,w,x)
		t.Text=""
		for y=1,#v do
			t.Text=t.Text..v:sub(y,y)
			task.wait(w)
		end
		if x then x()end
	end
	a:Create(t,TweenInfo.new(0.5,Enum.EasingStyle.Quad),{BackgroundColor3=Color3.fromRGB(50,205,50)}):Play()
	task.wait(0.5)
	u("Copied To Clipboard",0.05)
	task.wait(5)
	u("Accept Invite",0.05,function()
		a:Create(t,TweenInfo.new(0.5,Enum.EasingStyle.Quad),{BackgroundColor3=Color3.fromRGB(0,110,255)}):Play()
	end)
end)
s(Color3.fromRGB(70,70,70),"No, Thanks",2,function()
	a:Create(h,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.fromScale(0,0)}):Play()
	task.delay(0.3,function()g:Destroy()end)
end)
s(Color3.fromRGB(70,70,70),"No Thanks, Never",3,function()
	if writefile then writefile("dontshowagain.unx","")end
	a:Create(h,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.fromScale(0,0)}):Play()
	task.delay(0.3,function()g:Destroy()end)
end)
local B,C,D,E,F,G=false,false,nil,nil,nil,nil
local H=workspace.CurrentCamera.ViewportSize
h.MouseEnter:Connect(function()B=true end)
h.MouseLeave:Connect(function()B=false end)
b.InputBegan:Connect(function(I)
	if I.UserInputType==Enum.UserInputType.MouseButton1 or I.UserInputType==Enum.UserInputType.Touch then
		if B then
			C=true
			D=e.X
			E=e.Y
			F=h.Position
			G=e.Move:Connect(function()
				if not C then if G then G:Disconnect()G=nil end return end
				local J=(D-e.X)
				local K=(E-e.Y)
				local L=F-UDim2.new(J/H.X,0,K/H.Y,0)
				local M=h.Size.X.Scale/2
				local N=h.Size.Y.Scale/2
				h.Position=UDim2.new(math.clamp(L.X.Scale,M,1-M),0,math.clamp(L.Y.Scale,N,1-N),0)
			end)
		end
	end
end)
b.InputEnded:Connect(function(I)
	if I.UserInputType==Enum.UserInputType.MouseButton1 or I.UserInputType==Enum.UserInputType.Touch then
		C=false
		if G then G:Disconnect()G=nil end
	end
end)
a:Create(h,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.fromScale(0.6,0.8)}):Play()
