-- PLEASE DO NOT USE THIS IF YOU WANT UPDATES OR NEW FEATURES, I WONT MAINTANIN THIS!!!!
-- this version is deprecated!!!!

local player = game.Players.LocalPlayer
local exec = (type(identifyexecutor) == "function" and identifyexecutor()) or "Not Possible To Fetch Executor Name, Your Executor Probably Dont Support identifyexecutor()"
version = "1.1.4b"

print([[

 _   _ _   _ __   __ _   _       _      
| | | | \ | |\ \ / /| | | |     | |     
| | | |  \| | \ V / | |_| |_   _| |__   
| | | | . ` | /   \ |  _  | | | | '_ \  
| |_| | |\  |/ /^\ \| | | | |_| | |_) | 
 \___/\_| \_/\/   \/\_| |_/\__,_|_.__/  

]])
print("UNXHub ".. version .." :D")
print("Player Name: " .. player.Name)
print("Display Name: " .. player.DisplayName)
print("UserID: " .. player.UserId)
print("Local Executor: " .. exec)
print("Local Executor Level:")
printidentity()
print("-------------- UXNHub Debugger Info --------------")

-- DebugMode Usage: Find Errors In Script.
debugmode = false

if debugmode == true then
	print("[DEBUG]: Creating Variables For The UI, Please Wait")
end

local jobID = game.JobId
local placeID = game.PlaceId
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local UNXHubUI = Instance.new("ScreenGui")
local OpenUNX = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")
local TabsFrame = Instance.new("Frame")
local ButtonSafeArea = Instance.new("Frame")
local OtherTab3 = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")
local FastButtonTab4 = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local ESPTab2 = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local LocalPlayerTab1 = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local UICorner_6 = Instance.new("UICorner")
local ConfigTab5 = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local Bar = Instance.new("Frame")
local Minimize = Instance.new("TextButton")
local UICorner_8 = Instance.new("UICorner")
local UICorner_9 = Instance.new("UICorner")
local UICorner_10 = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local Tab4 = Instance.new("Frame")
local RejFF = Instance.new("TextButton")
local UICorner_11 = Instance.new("UICorner")
local AimLockFF = Instance.new("TextButton")
local UICorner_12 = Instance.new("UICorner")
local InfjumpFF = Instance.new("TextButton")
local UICorner_13 = Instance.new("UICorner")
local NoclipFF = Instance.new("TextButton")
local UICorner_14 = Instance.new("UICorner")
local Tab2 = Instance.new("Frame")
local EnableBox = Instance.new("TextButton")
local UICorner_15 = Instance.new("UICorner")
local EnableTrcs = Instance.new("TextButton")
local UICorner_16 = Instance.new("UICorner")
local EnableESP = Instance.new("TextButton")
local UICorner_17 = Instance.new("UICorner")
local EnableSkel = Instance.new("TextButton")
local UICorner_18 = Instance.new("UICorner")
local EnableOut = Instance.new("TextButton")
local UICorner_19 = Instance.new("UICorner")
local Tab1 = Instance.new("Frame")
local ApplyZoom = Instance.new("TextButton")
local UICorner_20 = Instance.new("UICorner")
local ZoomTextBox = Instance.new("TextBox")
local UICorner_21 = Instance.new("UICorner")
local ApplyJP = Instance.new("TextButton")
local JPTextBox = Instance.new("TextBox")
local UICorner_22 = Instance.new("UICorner")
local UICorner_23 = Instance.new("UICorner")
local ApplyWS = Instance.new("TextButton")
local WSTextBox = Instance.new("TextBox")
local UICorner_24 = Instance.new("UICorner")
local UICorner_25 = Instance.new("UICorner")
local ApplyGrav = Instance.new("TextButton")
local UICorner_26 = Instance.new("UICorner")
local ZoomTextBox_2 = Instance.new("TextBox")
local UICorner_27 = Instance.new("UICorner")
local InfJumpB = Instance.new("TextButton")
local UICorner_28 = Instance.new("UICorner")
local UICorner_29 = Instance.new("UICorner")
local Bar2 = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local logo = Instance.new("ImageLabel")
local UICorner_30 = Instance.new("UICorner")
local Tab3 = Instance.new("Frame")
local ApplyFPS = Instance.new("TextButton")
local UICorner_31 = Instance.new("UICorner")
local FPSTextBox = Instance.new("TextBox")
local UICorner_32 = Instance.new("UICorner")
local CopyJobID = Instance.new("TextButton")
local UICorner_33 = Instance.new("UICorner")
local ExecScript = Instance.new("TextButton")
local UICorner_34 = Instance.new("UICorner")
local JoinJobID = Instance.new("TextButton")
local JobIDTextBox = Instance.new("TextBox")
local UICorner_35 = Instance.new("UICorner")
local UICorner_36 = Instance.new("UICorner")
local LoadIy = Instance.new("TextButton")
local UICorner_37 = Instance.new("UICorner")
local OverdriveH = Instance.new("TextButton")
local UICorner_38 = Instance.new("UICorner")
local RejServer = Instance.new("TextButton")
local UICorner_39 = Instance.new("UICorner")
local AimLock = Instance.new("TextButton")
local UICorner_40 = Instance.new("UICorner")
local Tab5 = Instance.new("Frame")
local ScaleUI = Instance.new("TextButton")
local ScaleTxT = Instance.new("TextBox")
local UICorner_41 = Instance.new("UICorner")
local UICorner_42 = Instance.new("UICorner")
local FlyFrame = Instance.new("Frame")
local UICorner_43 = Instance.new("UICorner")
local Title_2 = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")
local UICorner_44 = Instance.new("UICorner")
local FlySpeedTXT = Instance.new("TextBox")
local UICorner_45 = Instance.new("UICorner")
local FastButton = Instance.new("Frame")
local NoclipFastButton = Instance.new("TextButton")
local UICorner_46 = Instance.new("UICorner")
local InfJumpFastButton = Instance.new("TextButton")
local UICorner_47 = Instance.new("UICorner")
local AimLockFastButton = Instance.new("TextButton")
local UICorner_48 = Instance.new("UICorner")
local RejoinFastButton = Instance.new("TextButton")
local UICorner_49 = Instance.new("UICorner")
local UIScale = Instance.new("UIScale")
local UIScale_2 = Instance.new("UIScale")
local UIScale_3 = Instance.new("UIScale")
local btnsfx = Instance.new("Sound")
local UICorner_39F = Instance.new("UICorner")
local UICorner_40F = Instance.new("UICorner")
local sfxfldr = Instance.new("Folder")
if debugmode == true then
	print("[DEBUG]: All Variables Created, Setting Up UI...")
end

print("[SUCESS]: Variables Set, Step (1/3) Complete.")

sfxfldr.Name = "sfxfldr"
sfxfldr.Parent = workspace

btnsfx.Name = "btnsfx"
btnsfx.SoundId = "rbxassetid://139800881181209"
btnsfx.Parent = sfxfldr

UNXHubUI.Name = "UNXHubUI"
UNXHubUI.Parent = game.CoreGui
UNXHubUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if debugmode == true then
	print("[DEBUG]: Calling Ban API, Please Wait...")
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/uHeyCaf/UNX/refs/heads/main/Modules/v1/API.lua",true))()

OpenUNX.Name = "OpenUNX"
OpenUNX.Parent = UNXHubUI
OpenUNX.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
OpenUNX.BorderColor3 = Color3.fromRGB(0, 0, 0)
OpenUNX.BorderSizePixel = 0
OpenUNX.Position = UDim2.new(0.00691881916, 0, 0.0139082056, 0)
OpenUNX.Size = UDim2.new(0.1, 0, 0.1, 0)
OpenUNX.Visible = false
OpenUNX.ZIndex = 999999999
OpenUNX.Image = "rbxassetid://137779536741206"
OpenUNX.ImageColor3 = Color3.new(1, 1, 1)
OpenUNX.ScaleType = Enum.ScaleType.Fit

local aspect = Instance.new("UIAspectRatioConstraint")
aspect.AspectRatio = 1
aspect.Parent = OpenUNX

UICorner.CornerRadius = UDim.new(99, 99)
UICorner.Parent = OpenUNX

TabsFrame.Name = "TabsFrame"
TabsFrame.Parent = UNXHubUI
TabsFrame.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
TabsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
TabsFrame.BorderSizePixel = 0
TabsFrame.Position = UDim2.new(0.191420659, 0, 0.206884563, 0)
TabsFrame.Size = UDim2.new(0.114544891, 0, 0.578929067, 0)
TabsFrame.ZIndex = 999999999

ButtonSafeArea.Name = "ButtonSafeArea"
ButtonSafeArea.Parent = TabsFrame
ButtonSafeArea.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
ButtonSafeArea.BorderColor3 = Color3.fromRGB(0, 0, 0)
ButtonSafeArea.BorderSizePixel = 0
ButtonSafeArea.Position = UDim2.new(0, 0, 0.0960960984, 0)
ButtonSafeArea.Size = UDim2.new(1, 0, 0.9009009, 0)

OtherTab3.Name = "OtherTab3"
OtherTab3.Parent = ButtonSafeArea
OtherTab3.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
OtherTab3.BorderColor3 = Color3.fromRGB(0, 0, 0)
OtherTab3.BorderSizePixel = 0
OtherTab3.Position = UDim2.new(0.0469798669, 0, 0.25, 0)
OtherTab3.Size = UDim2.new(0.906040251, 0, 0.100000001, 0)
OtherTab3.Font = Enum.Font.SourceSansLight
OtherTab3.Text = "Other Stuff"
OtherTab3.TextColor3 = Color3.fromRGB(255, 255, 255)
OtherTab3.TextSize = 18.000
OtherTab3.TextWrapped = true

UICorner_2.Parent = OtherTab3

FastButtonTab4.Name = "FastButtonTab4"
FastButtonTab4.Parent = ButtonSafeArea
FastButtonTab4.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
FastButtonTab4.BorderColor3 = Color3.fromRGB(0, 0, 0)
FastButtonTab4.BorderSizePixel = 0
FastButtonTab4.Position = UDim2.new(0.0469798818, 0, 0.383333325, 0)
FastButtonTab4.Size = UDim2.new(0.906040251, 0, 0.100000001, 0)
FastButtonTab4.Font = Enum.Font.SourceSansLight
FastButtonTab4.Text = "Fast Buttons"
FastButtonTab4.TextColor3 = Color3.fromRGB(255, 255, 255)
FastButtonTab4.TextSize = 18.000
FastButtonTab4.TextWrapped = true

UICorner_3.Parent = FastButtonTab4

ESPTab2.Name = "ESPTab2"
ESPTab2.Parent = ButtonSafeArea
ESPTab2.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ESPTab2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ESPTab2.BorderSizePixel = 0
ESPTab2.Position = UDim2.new(0.0469798669, 0, 0.123333335, 0)
ESPTab2.Size = UDim2.new(0.906040251, 0, 0.100000001, 0)
ESPTab2.Font = Enum.Font.SourceSansLight
ESPTab2.Text = "Visuals"
ESPTab2.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPTab2.TextSize = 18.000
ESPTab2.TextWrapped = true

UICorner_4.Parent = ESPTab2

LocalPlayerTab1.Name = "LocalPlayerTab1"
LocalPlayerTab1.Parent = ButtonSafeArea
LocalPlayerTab1.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
LocalPlayerTab1.BorderColor3 = Color3.fromRGB(0, 0, 0)
LocalPlayerTab1.BorderSizePixel = 0
LocalPlayerTab1.Position = UDim2.new(0.0469798669, 0, 0, 0)
LocalPlayerTab1.Size = UDim2.new(0.906040251, 0, 0.100000001, 0)
LocalPlayerTab1.Font = Enum.Font.SourceSansLight
LocalPlayerTab1.Text = "Character"
LocalPlayerTab1.TextColor3 = Color3.fromRGB(255, 255, 255)
LocalPlayerTab1.TextSize = 18.000
LocalPlayerTab1.TextWrapped = true

UICorner_5.Parent = LocalPlayerTab1

UICorner_6.Parent = ButtonSafeArea

ConfigTab5.Name = "ConfigTab5"
ConfigTab5.Parent = ButtonSafeArea
ConfigTab5.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ConfigTab5.BorderColor3 = Color3.fromRGB(0, 0, 0)
ConfigTab5.BorderSizePixel = 0
ConfigTab5.Position = UDim2.new(0.0469797812, 0, 0.513333321, 0)
ConfigTab5.Size = UDim2.new(0.906040251, 0, 0.100000001, 0)
ConfigTab5.Font = Enum.Font.SourceSansLight
ConfigTab5.Text = "UNX Config"
ConfigTab5.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfigTab5.TextSize = 18.000
ConfigTab5.TextWrapped = true

UICorner_7.Parent = ConfigTab5

Bar.Name = "Bar"
Bar.Parent = TabsFrame
Bar.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Bar.BorderSizePixel = 0
Bar.Size = UDim2.new(1, 0, 0.0840840861, 0)

Minimize.Name = "Minimize"
Minimize.Parent = Bar
Minimize.BackgroundColor3 = Color3.fromRGB(255, 238, 0)
Minimize.BorderColor3 = Color3.fromRGB(0, 0, 0)
Minimize.BorderSizePixel = 0
Minimize.Position = UDim2.new(0.0671140924, 0, 0.285714298, 0)
Minimize.Size = UDim2.new(0.127516776, 0, 0.535714269, 0)
Minimize.Font = Enum.Font.Unknown
Minimize.Text = "-"
Minimize.TextColor3 = Color3.fromRGB(255, 255, 0)
Minimize.TextSize = 14.000
Minimize.TextWrapped = true

UICorner_8.CornerRadius = UDim.new(0, 999)
UICorner_8.Parent = Minimize

UICorner_9.Parent = Bar

UICorner_10.Parent = TabsFrame

MainFrame.Name = "MainFrame"
MainFrame.Parent = UNXHubUI
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.315190643, 0, 0.206884563, 0)
MainFrame.Size = UDim2.new(0.492004901, 0, 0.578929067, 0)
MainFrame.ZIndex = 999999999

Tab4.Name = "Tab4"
Tab4.Parent = MainFrame
Tab4.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
Tab4.BackgroundTransparency = 1.000
Tab4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab4.BorderSizePixel = 0
Tab4.Position = UDim2.new(0, 0, 0.0690690726, 0)
Tab4.Size = UDim2.new(1, 0, 0.92492491, 0)

RejFF.Name = "RejFF"
RejFF.Parent = Tab4
RejFF.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
RejFF.BorderColor3 = Color3.fromRGB(0, 0, 0)
RejFF.BorderSizePixel = 0
RejFF.Position = UDim2.new(0.0343750007, 0, 0.350649357, 0)
RejFF.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
RejFF.Font = Enum.Font.SourceSansLight
RejFF.Text = "Rejoin Fast Button"
RejFF.TextColor3 = Color3.fromRGB(255, 255, 255)
RejFF.TextSize = 18.000
RejFF.TextWrapped = true

UICorner_11.Parent = RejFF

AimLockFF.Name = "AimLockFF"
AimLockFF.Parent = Tab4
AimLockFF.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
AimLockFF.BorderColor3 = Color3.fromRGB(0, 0, 0)
AimLockFF.BorderSizePixel = 0
AimLockFF.Position = UDim2.new(0.0343750007, 0, 0.0649350658, 0)
AimLockFF.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
AimLockFF.Font = Enum.Font.SourceSansLight
AimLockFF.Text = "Aimlock Fast Button"
AimLockFF.TextColor3 = Color3.fromRGB(255, 255, 255)
AimLockFF.TextSize = 18.000
AimLockFF.TextWrapped = true

UICorner_12.Parent = AimLockFF

InfjumpFF.Name = "InfjumpFF"
InfjumpFF.Parent = Tab4
InfjumpFF.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
InfjumpFF.BorderColor3 = Color3.fromRGB(0, 0, 0)
InfjumpFF.BorderSizePixel = 0
InfjumpFF.Position = UDim2.new(0.0343750007, 0, 0.204545453, 0)
InfjumpFF.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
InfjumpFF.Font = Enum.Font.SourceSansLight
InfjumpFF.Text = "Inf Jump Fast Button"
InfjumpFF.TextColor3 = Color3.fromRGB(255, 255, 255)
InfjumpFF.TextSize = 18.000
InfjumpFF.TextWrapped = true

UICorner_13.Parent = InfjumpFF

NoclipFF.Name = "NoclipFF"
NoclipFF.Parent = Tab4
NoclipFF.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
NoclipFF.BorderColor3 = Color3.fromRGB(0, 0, 0)
NoclipFF.BorderSizePixel = 0
NoclipFF.Position = UDim2.new(0.0343750007, 0, 0.487012982, 0)
NoclipFF.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
NoclipFF.Font = Enum.Font.SourceSansLight
NoclipFF.Text = "Noclip Fast Button"
NoclipFF.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipFF.TextSize = 18.000
NoclipFF.TextWrapped = true

UICorner_14.Parent = NoclipFF

Tab2.Name = "Tab2"
Tab2.Parent = MainFrame
Tab2.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
Tab2.BackgroundTransparency = 1.000
Tab2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab2.BorderSizePixel = 0
Tab2.Position = UDim2.new(0, 0, 0.0690690726, 0)
Tab2.Size = UDim2.new(1, 0, 0.92492491, 0)
Tab2.Visible = false

EnableBox.Name = "EnableBox"
EnableBox.Parent = Tab2
EnableBox.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
EnableBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
EnableBox.BorderSizePixel = 0
EnableBox.Position = UDim2.new(0.0343750007, 0, 0.626623392, 0)
EnableBox.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
EnableBox.Font = Enum.Font.SourceSansLight
EnableBox.Text = "Toggle Box ESP"
EnableBox.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableBox.TextSize = 18.000
EnableBox.TextWrapped = true

UICorner_15.Parent = EnableBox

EnableTrcs.Name = "EnableTrcs"
EnableTrcs.Parent = Tab2
EnableTrcs.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
EnableTrcs.BorderColor3 = Color3.fromRGB(0, 0, 0)
EnableTrcs.BorderSizePixel = 0
EnableTrcs.Position = UDim2.new(0.0343750007, 0, 0.350649357, 0)
EnableTrcs.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
EnableTrcs.Font = Enum.Font.SourceSansLight
EnableTrcs.Text = "Toggle Tracers"
EnableTrcs.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableTrcs.TextSize = 18.000
EnableTrcs.TextWrapped = true

UICorner_16.Parent = EnableTrcs

EnableESP.Name = "EnableESP"
EnableESP.Parent = Tab2
EnableESP.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
EnableESP.BorderColor3 = Color3.fromRGB(0, 0, 0)
EnableESP.BorderSizePixel = 0
EnableESP.Position = UDim2.new(0.0343750007, 0, 0.0649350658, 0)
EnableESP.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
EnableESP.Font = Enum.Font.SourceSansLight
EnableESP.Text = "Toggle ESP"
EnableESP.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableESP.TextSize = 18.000
EnableESP.TextWrapped = true

UICorner_17.Parent = EnableESP

EnableSkel.Name = "EnableSkel"
EnableSkel.Parent = Tab2
EnableSkel.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
EnableSkel.BorderColor3 = Color3.fromRGB(0, 0, 0)
EnableSkel.BorderSizePixel = 0
EnableSkel.Position = UDim2.new(0.0343750007, 0, 0.487012982, 0)
EnableSkel.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
EnableSkel.Font = Enum.Font.SourceSansLight
EnableSkel.Text = "Toggle Skeleton ESP"
EnableSkel.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableSkel.TextSize = 18.000
EnableSkel.TextWrapped = true

UICorner_18.Parent = EnableSkel

EnableOut.Name = "EnableOut"
EnableOut.Parent = Tab2
EnableOut.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
EnableOut.BorderColor3 = Color3.fromRGB(0, 0, 0)
EnableOut.BorderSizePixel = 0
EnableOut.Position = UDim2.new(0.0343750007, 0, 0.204545453, 0)
EnableOut.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
EnableOut.Font = Enum.Font.SourceSansLight
EnableOut.Text = "Toggle Outline"
EnableOut.TextColor3 = Color3.fromRGB(255, 255, 255)
EnableOut.TextSize = 18.000
EnableOut.TextWrapped = true

UICorner_19.Parent = EnableOut

Tab1.Name = "Tab1"
Tab1.Parent = MainFrame
Tab1.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
Tab1.BackgroundTransparency = 1.000
Tab1.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab1.BorderSizePixel = 0
Tab1.Position = UDim2.new(0, 0, 0.0690690726, 0)
Tab1.Size = UDim2.new(1, 0, 0.92492491, 0)
Tab1.Visible = false

if debugmode == true then
	print("[DEBUG]: All Tabs Crated Sucessfully.")
end

ApplyZoom.Name = "ApplyZoom"
ApplyZoom.Parent = Tab1
ApplyZoom.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ApplyZoom.BorderColor3 = Color3.fromRGB(0, 0, 0)
ApplyZoom.BorderSizePixel = 0
ApplyZoom.Position = UDim2.new(0.0343750007, 0, 0.350649357, 0)
ApplyZoom.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
ApplyZoom.Font = Enum.Font.SourceSansLight
ApplyZoom.Text = "Apply Max Zoom"
ApplyZoom.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyZoom.TextSize = 18.000
ApplyZoom.TextWrapped = true

UICorner_20.Parent = ApplyZoom

ZoomTextBox.Name = "ZoomTextBox"
ZoomTextBox.Parent = ApplyZoom
ZoomTextBox.BackgroundColor3 = Color3.fromRGB(22, 0, 109)
ZoomTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
ZoomTextBox.BorderSizePixel = 0
ZoomTextBox.Position = UDim2.new(0.860269368, 0, 0.125, 0)
ZoomTextBox.Size = UDim2.new(0.12626262, 0, 0.6875, 0)
ZoomTextBox.Font = Enum.Font.SourceSansLight
ZoomTextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
ZoomTextBox.PlaceholderText = "MaxZoom"
ZoomTextBox.Text = ""
ZoomTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ZoomTextBox.TextSize = 14.000
ZoomTextBox.TextWrapped = true

UICorner_21.Parent = ZoomTextBox

ApplyJP.Name = "ApplyJP"
ApplyJP.Parent = Tab1
ApplyJP.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ApplyJP.BorderColor3 = Color3.fromRGB(0, 0, 0)
ApplyJP.BorderSizePixel = 0
ApplyJP.Position = UDim2.new(0.0343750007, 0, 0.204545453, 0)
ApplyJP.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
ApplyJP.Font = Enum.Font.SourceSansLight
ApplyJP.Text = "Apply JumpPower"
ApplyJP.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyJP.TextSize = 18.000
ApplyJP.TextWrapped = true

JPTextBox.Name = "JPTextBox"
JPTextBox.Parent = ApplyJP
JPTextBox.BackgroundColor3 = Color3.fromRGB(22, 0, 109)
JPTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
JPTextBox.BorderSizePixel = 0
JPTextBox.Position = UDim2.new(0.860269368, 0, 0.125, 0)
JPTextBox.Size = UDim2.new(0.12626262, 0, 0.6875, 0)
JPTextBox.Font = Enum.Font.SourceSansLight
JPTextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
JPTextBox.PlaceholderText = "JumpPower"
JPTextBox.Text = ""
JPTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JPTextBox.TextSize = 14.000
JPTextBox.TextWrapped = true

UICorner_22.Parent = JPTextBox

UICorner_23.Parent = ApplyJP

ApplyWS.Name = "ApplyWS"
ApplyWS.Parent = Tab1
ApplyWS.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ApplyWS.BorderColor3 = Color3.fromRGB(0, 0, 0)
ApplyWS.BorderSizePixel = 0
ApplyWS.Position = UDim2.new(0.0343750007, 0, 0.0649350658, 0)
ApplyWS.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
ApplyWS.Font = Enum.Font.SourceSansLight
ApplyWS.Text = "Apply WalkSpeed"
ApplyWS.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyWS.TextSize = 18.000
ApplyWS.TextWrapped = true

WSTextBox.Name = "WSTextBox"
WSTextBox.Parent = ApplyWS
WSTextBox.BackgroundColor3 = Color3.fromRGB(22, 0, 109)
WSTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
WSTextBox.BorderSizePixel = 0
WSTextBox.Position = UDim2.new(0.860269368, 0, 0.125, 0)
WSTextBox.Size = UDim2.new(0.12626262, 0, 0.6875, 0)
WSTextBox.Font = Enum.Font.SourceSansLight
WSTextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
WSTextBox.PlaceholderText = "WalkSpeed"
WSTextBox.Text = ""
WSTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
WSTextBox.TextSize = 14.000
WSTextBox.TextWrapped = true

UICorner_24.Parent = WSTextBox

UICorner_25.Parent = ApplyWS

ApplyGrav.Name = "ApplyGrav"
ApplyGrav.Parent = Tab1
ApplyGrav.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ApplyGrav.BorderColor3 = Color3.fromRGB(0, 0, 0)
ApplyGrav.BorderSizePixel = 0
ApplyGrav.Position = UDim2.new(0.0343750007, 0, 0.487012982, 0)
ApplyGrav.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
ApplyGrav.Font = Enum.Font.SourceSansLight
ApplyGrav.Text = "Apply Gravity"
ApplyGrav.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyGrav.TextSize = 18.000
ApplyGrav.TextWrapped = true

UICorner_26.Parent = ApplyGrav

ZoomTextBox_2.Name = "ZoomTextBox"
ZoomTextBox_2.Parent = ApplyGrav
ZoomTextBox_2.BackgroundColor3 = Color3.fromRGB(22, 0, 109)
ZoomTextBox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ZoomTextBox_2.BorderSizePixel = 0
ZoomTextBox_2.Position = UDim2.new(0.860269368, 0, 0.125, 0)
ZoomTextBox_2.Size = UDim2.new(0.12626262, 0, 0.6875, 0)
ZoomTextBox_2.Font = Enum.Font.SourceSansLight
ZoomTextBox_2.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
ZoomTextBox_2.PlaceholderText = "Gravity"
ZoomTextBox_2.Text = ""
ZoomTextBox_2.TextColor3 = Color3.fromRGB(255, 255, 255)
ZoomTextBox_2.TextSize = 14.000
ZoomTextBox_2.TextWrapped = true

UICorner_27.Parent = ZoomTextBox_2

InfJumpB.Name = "InfJumpB"
InfJumpB.Parent = Tab1
InfJumpB.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
InfJumpB.BorderColor3 = Color3.fromRGB(0, 0, 0)
InfJumpB.BorderSizePixel = 0
InfJumpB.Position = UDim2.new(0.0343750007, 0, 0.626623392, 0)
InfJumpB.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
InfJumpB.Font = Enum.Font.SourceSansLight
InfJumpB.Text = "Toggle Infinite Jump"
InfJumpB.TextColor3 = Color3.fromRGB(255, 255, 255)
InfJumpB.TextSize = 18.000
InfJumpB.TextWrapped = true

UICorner_28.Parent = InfJumpB

UICorner_29.Parent = MainFrame

if debugmode == true then
	print("[DEBUG]: Tab 1 Completed Sucessfuly!")
end

Bar2.Name = "Bar2"
Bar2.Parent = MainFrame
Bar2.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
Bar2.BackgroundTransparency = 1.000
Bar2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Bar2.BorderSizePixel = 0
Bar2.Size = UDim2.new(1, 0, 0.0840840861, 0)

Title.Name = "Title"
Title.Parent = Bar2
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0.785714269, 0)
Title.Font = Enum.Font.SourceSansLight
Title.Text = "UNXHub (".. version ..")"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18.000
Title.TextWrapped = true

logo.Name = "logo"
logo.Parent = Bar2
logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
logo.BackgroundTransparency = 1.000
logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
logo.BorderSizePixel = 0
logo.Position = UDim2.new(0.00625000009, 0, 0.142857149, 0)
logo.Size = UDim2.new(0.0296874978, 0, 0.678571403, 0)
logo.Image = "rbxassetid://137779536741206"
logo.ScaleType = Enum.ScaleType.Crop

UICorner_30.Parent = logo

Tab3.Name = "Tab3"
Tab3.Parent = MainFrame
Tab3.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
Tab3.BackgroundTransparency = 1.000
Tab3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab3.BorderSizePixel = 0
Tab3.Position = UDim2.new(0, 0, 0.0690690726, 0)
Tab3.Size = UDim2.new(1, 0, 0.92492491, 0)
Tab3.Visible = false

ApplyFPS.Name = "ApplyFPS"
ApplyFPS.Parent = Tab3
ApplyFPS.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ApplyFPS.BorderColor3 = Color3.fromRGB(0, 0, 0)
ApplyFPS.BorderSizePixel = 0
ApplyFPS.Position = UDim2.new(0.0343750007, 0, 0.0292207785, 0)
ApplyFPS.Size = UDim2.new(0.928125024, 0, 0.0909090936, 0)
ApplyFPS.Font = Enum.Font.SourceSansLight
ApplyFPS.Text = "Set FPS Cap"
ApplyFPS.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyFPS.TextSize = 18.000
ApplyFPS.TextWrapped = true

UICorner_31.Parent = ApplyFPS

FPSTextBox.Name = "FPSTextBox"
FPSTextBox.Parent = ApplyFPS
FPSTextBox.BackgroundColor3 = Color3.fromRGB(22, 0, 109)
FPSTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
FPSTextBox.BorderSizePixel = 0
FPSTextBox.Position = UDim2.new(0.860269368, 0, 0.107142858, 0)
FPSTextBox.Size = UDim2.new(0.12626262, 0, 0.678571403, 0)
FPSTextBox.Font = Enum.Font.SourceSansLight
FPSTextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
FPSTextBox.PlaceholderText = "FPS"
FPSTextBox.Text = ""
FPSTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
FPSTextBox.TextSize = 14.000
FPSTextBox.TextWrapped = true

UICorner_32.Parent = FPSTextBox

CopyJobID.Name = "CopyJobID"
CopyJobID.Parent = Tab3
CopyJobID.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
CopyJobID.BorderColor3 = Color3.fromRGB(0, 0, 0)
CopyJobID.BorderSizePixel = 0
CopyJobID.Position = UDim2.new(0.0343750007, 0, 0.564935088, 0)
CopyJobID.Size = UDim2.new(0.928125024, 0, 0.0909090936, 0)
CopyJobID.Font = Enum.Font.SourceSansLight
CopyJobID.Text = "Copy Current Server JobID"
CopyJobID.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyJobID.TextSize = 18.000
CopyJobID.TextWrapped = true

UICorner_33.Parent = CopyJobID

ExecScript.Name = "ExecScript"
ExecScript.Parent = Tab3
ExecScript.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ExecScript.BorderColor3 = Color3.fromRGB(0, 0, 0)
ExecScript.BorderSizePixel = 0
ExecScript.Position = UDim2.new(0.0343750007, 0, 0.165584415, 0)
ExecScript.Size = UDim2.new(0.928125024, 0, 0.0909090936, 0)
ExecScript.Font = Enum.Font.SourceSansLight
ExecScript.Text = "Fly (BETA)"
ExecScript.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecScript.TextSize = 18.000
ExecScript.TextWrapped = true

UICorner_34.Parent = ExecScript

JoinJobID.Name = "JoinJobID"
JoinJobID.Parent = Tab3
JoinJobID.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
JoinJobID.BorderColor3 = Color3.fromRGB(0, 0, 0)
JoinJobID.BorderSizePixel = 0
JoinJobID.Position = UDim2.new(0.0343750007, 0, 0.438311696, 0)
JoinJobID.Size = UDim2.new(0.928125024, 0, 0.0909090936, 0)
JoinJobID.Font = Enum.Font.SourceSansLight
JoinJobID.Text = "Join Server (Needs JobID!)"
JoinJobID.TextColor3 = Color3.fromRGB(255, 255, 255)
JoinJobID.TextSize = 18.000
JoinJobID.TextWrapped = true

JobIDTextBox.Name = "JobIDTextBox"
JobIDTextBox.Parent = JoinJobID
JobIDTextBox.BackgroundColor3 = Color3.fromRGB(22, 0, 109)
JobIDTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
JobIDTextBox.BorderSizePixel = 0
JobIDTextBox.Position = UDim2.new(0.860269368, 0, 0.107142858, 0)
JobIDTextBox.Size = UDim2.new(0.12626262, 0, 0.678571403, 0)
JobIDTextBox.Font = Enum.Font.SourceSansLight
JobIDTextBox.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
JobIDTextBox.PlaceholderText = "JobID"
JobIDTextBox.Text = ""
JobIDTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JobIDTextBox.TextSize = 14.000
JobIDTextBox.TextWrapped = true

UICorner_35.Parent = JobIDTextBox

UICorner_36.Parent = JoinJobID

LoadIy.Name = "LoadIy"
LoadIy.Parent = Tab3
LoadIy.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
LoadIy.BorderColor3 = Color3.fromRGB(0, 0, 0)
LoadIy.BorderSizePixel = 0
LoadIy.Position = UDim2.new(0.495312512, 0, 0.305194795, 0)
LoadIy.Size = UDim2.new(0.465624988, 0, 0.0909090936, 0)
LoadIy.Font = Enum.Font.SourceSansLight
LoadIy.Text = "Infinite Yield (Universal)"
LoadIy.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadIy.TextSize = 18.000
LoadIy.TextWrapped = true

UICorner_37.Parent = LoadIy

OverdriveH.Name = "OverdriveH"
OverdriveH.Parent = Tab3
OverdriveH.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
OverdriveH.BorderColor3 = Color3.fromRGB(0, 0, 0)
OverdriveH.BorderSizePixel = 0
OverdriveH.Position = UDim2.new(0.0343750007, 0, 0.305194795, 0)
OverdriveH.Size = UDim2.new(0.442187458, 0, 0.0909090936, 0)
OverdriveH.Font = Enum.Font.SourceSansLight
OverdriveH.Text = "Overdrive H (MM2, Blade Ball, Dead Rails, Fisch)"
OverdriveH.TextColor3 = Color3.fromRGB(255, 255, 255)
OverdriveH.TextSize = 18.000
OverdriveH.TextWrapped = true

UICorner_38.Parent = OverdriveH

RejServer.Name = "RejServer"
RejServer.Parent = Tab3
RejServer.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
RejServer.BorderColor3 = Color3.fromRGB(0, 0, 0)
RejServer.BorderSizePixel = 0
RejServer.Position = UDim2.new(0.0343750007, 0, 0.694805205, 0)
RejServer.Size = UDim2.new(0.928125024, 0, 0.0909090936, 0)
RejServer.Font = Enum.Font.SourceSansLight
RejServer.Text = "Re-Join Server"
RejServer.TextColor3 = Color3.fromRGB(255, 255, 255)
RejServer.TextSize = 18.000
RejServer.TextWrapped = true

UICorner_39.Parent = RejServer

AimLock.Name = "AimLock"
AimLock.Parent = Tab3
AimLock.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
AimLock.BorderColor3 = Color3.fromRGB(0, 0, 0)
AimLock.BorderSizePixel = 0
AimLock.Position = UDim2.new(0.0343750007, 0, 0.824675322, 0)
AimLock.Size = UDim2.new(0.928125024, 0, 0.0909090936, 0)
AimLock.Font = Enum.Font.SourceSansLight
AimLock.Text = "AimLock Nearest Player (Ignores Team Players)"
AimLock.TextColor3 = Color3.fromRGB(255, 255, 255)
AimLock.TextSize = 18.000
AimLock.TextWrapped = true


if debugmode == true then
	print("[DEBUG]: Tab 3 Completed Sucessfuly!")
end

UICorner_40.Parent = AimLock

Tab5.Name = "Tab5"
Tab5.Parent = MainFrame
Tab5.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
Tab5.BackgroundTransparency = 1.000
Tab5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Tab5.BorderSizePixel = 0
Tab5.Position = UDim2.new(0, 0, 0.0690690726, 0)
Tab5.Size = UDim2.new(1, 0, 0.92492491, 0)
Tab5.Visible = false

ScaleUI.Name = "ScaleUI"
ScaleUI.Parent = Tab5
ScaleUI.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
ScaleUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScaleUI.BorderSizePixel = 0
ScaleUI.Position = UDim2.new(0.0343750007, 0, 0.0649350658, 0)
ScaleUI.Size = UDim2.new(0.928125024, 0, 0.103896104, 0)
ScaleUI.Font = Enum.Font.SourceSansLight
ScaleUI.Text = "UI Scale"
ScaleUI.TextColor3 = Color3.fromRGB(255, 255, 255)
ScaleUI.TextSize = 18.000
ScaleUI.TextWrapped = true

ScaleTxT.Name = "ScaleTxT"
ScaleTxT.Parent = ScaleUI
ScaleTxT.BackgroundColor3 = Color3.fromRGB(22, 0, 109)
ScaleTxT.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScaleTxT.BorderSizePixel = 0
ScaleTxT.Position = UDim2.new(0.860269368, 0, 0.125, 0)
ScaleTxT.Size = UDim2.new(0.12626262, 0, 0.6875, 0)
ScaleTxT.Font = Enum.Font.SourceSansLight
ScaleTxT.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
ScaleTxT.PlaceholderText = "UI Scale"
ScaleTxT.Text = ""
ScaleTxT.TextColor3 = Color3.fromRGB(255, 255, 255)
ScaleTxT.TextSize = 14.000
ScaleTxT.TextWrapped = true

if debugmode == true then
	print("[DEBUG]: Tab 5 Completed Sucessfuly!")
end

UICorner_41.Parent = ScaleTxT

UICorner_42.Parent = ScaleUI

FlyFrame.Name = "FlyFrame"
FlyFrame.Parent = UNXHubUI
FlyFrame.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
FlyFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
FlyFrame.BorderSizePixel = 0
FlyFrame.Position = UDim2.new(0.00999384932, 0, 0.0191237833, 0)
FlyFrame.Size = UDim2.new(0.180658042, 0, 0.175591096, 0)
FlyFrame.Visible = false
FlyFrame.ZIndex = 999999999

UICorner_43.Parent = FlyFrame

Title_2.Name = "Title"
Title_2.Parent = FlyFrame
Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_2.BackgroundTransparency = 1.000
Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_2.BorderSizePixel = 0
Title_2.Size = UDim2.new(0.995744765, 0, 0.188118815, 0)
Title_2.Font = Enum.Font.SourceSansLight
Title_2.Text = "UNXFly UI"
Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title_2.TextScaled = true
Title_2.TextSize = 14.000
Title_2.TextWrapped = true

FlyButton.Name = "FlyButton"
FlyButton.Parent = FlyFrame
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
FlyButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
FlyButton.BorderSizePixel = 0
FlyButton.Position = UDim2.new(0.0595744736, 0, 0.326732665, 0)
FlyButton.Size = UDim2.new(0.421276659, 0, 0.485148519, 0)
FlyButton.Font = Enum.Font.SourceSansLight
FlyButton.Text = "Fly"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextScaled = true
FlyButton.TextSize = 24.000
FlyButton.TextWrapped = true

UICorner_44.Parent = FlyButton

FlySpeedTXT.Name = "FlySpeedTXT"
FlySpeedTXT.Parent = FlyFrame
FlySpeedTXT.BackgroundColor3 = Color3.fromRGB(22, 0, 109)
FlySpeedTXT.BorderColor3 = Color3.fromRGB(0, 0, 0)
FlySpeedTXT.BorderSizePixel = 0
FlySpeedTXT.Position = UDim2.new(0.536170244, 0, 0.326732665, 0)
FlySpeedTXT.Size = UDim2.new(0.391489387, 0, 0.485148519, 0)
FlySpeedTXT.Font = Enum.Font.SourceSansLight
FlySpeedTXT.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedTXT.PlaceholderText = "Speed"
FlySpeedTXT.Text = ""
FlySpeedTXT.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedTXT.TextScaled = true
FlySpeedTXT.TextSize = 24.000
FlySpeedTXT.TextWrapped = true


if debugmode == true then
	print("[DEBUG]: Fly UI Completed Sucessfuly!")
end

UICorner_45.Parent = FlySpeedTXT

FastButton.Name = "FastButton"
FastButton.Parent = UNXHubUI
FastButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FastButton.BackgroundTransparency = 1.000
FastButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
FastButton.BorderSizePixel = 0
FastButton.Size = UDim2.new(1, 0, 1, 0)
FastButton.ZIndex = 999999998

NoclipFastButton.Name = "NoclipFastButton"
NoclipFastButton.Parent = FastButton
NoclipFastButton.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
NoclipFastButton.BackgroundTransparency = 0.500
NoclipFastButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
NoclipFastButton.BorderSizePixel = 0
NoclipFastButton.ClipsDescendants = true
NoclipFastButton.Position = UDim2.new(0.0984615386, 0, 0.0139082056, 0)
NoclipFastButton.Size = UDim2.new(0.0307692308, 0, 0.0556328222, 0)
NoclipFastButton.Visible = false
NoclipFastButton.Font = Enum.Font.SourceSansLight
NoclipFastButton.Text = "Noclip"
NoclipFastButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipFastButton.TextScaled = true
NoclipFastButton.TextSize = 14.000
NoclipFastButton.TextWrapped = true

UICorner_46.Parent = NoclipFastButton

InfJumpFastButton.Name = "InfJumpFastButton"
InfJumpFastButton.Parent = FastButton
InfJumpFastButton.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
InfJumpFastButton.BackgroundTransparency = 0.500
InfJumpFastButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
InfJumpFastButton.BorderSizePixel = 0
InfJumpFastButton.ClipsDescendants = true
InfJumpFastButton.Position = UDim2.new(0.140910193, 0, 0.0139082056, 0)
InfJumpFastButton.Size = UDim2.new(0.0307692308, 0, 0.0556328222, 0)
InfJumpFastButton.Visible = false
InfJumpFastButton.Font = Enum.Font.SourceSansLight
InfJumpFastButton.Text = "InfJump"
InfJumpFastButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InfJumpFastButton.TextScaled = true
InfJumpFastButton.TextSize = 14.000
InfJumpFastButton.TextWrapped = true

UICorner_47.Parent = InfJumpFastButton

if debugmode == true then
	warn("[DEBUG]: Call Line 1000")
end
AimLockFastButton.Name = "AimLockFastButton"
AimLockFastButton.Parent = FastButton
AimLockFastButton.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
AimLockFastButton.BackgroundTransparency = 0.500
AimLockFastButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
AimLockFastButton.BorderSizePixel = 0
AimLockFastButton.ClipsDescendants = true
AimLockFastButton.Position = UDim2.new(0.099313356, 0, 0.0886648074, 0)
AimLockFastButton.Size = UDim2.new(0.0307692308, 0, 0.0556328222, 0)
AimLockFastButton.Visible = false
AimLockFastButton.Font = Enum.Font.SourceSansLight
AimLockFastButton.Text = "Aimlock"
AimLockFastButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AimLockFastButton.TextScaled = true
AimLockFastButton.TextSize = 14.000
AimLockFastButton.TextWrapped = true

UICorner_48.Parent = AimLockFastButton

RejoinFastButton.Name = "RejoinFastButton"
RejoinFastButton.Parent = FastButton
RejoinFastButton.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
RejoinFastButton.BackgroundTransparency = 0.500
RejoinFastButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
RejoinFastButton.BorderSizePixel = 0
RejoinFastButton.ClipsDescendants = true
RejoinFastButton.Position = UDim2.new(0.140851811, 0, 0.0886648074, 0)
RejoinFastButton.Size = UDim2.new(0.0307692308, 0, 0.0556328222, 0)
RejoinFastButton.Visible = false
RejoinFastButton.Font = Enum.Font.SourceSansLight
RejoinFastButton.Text = "Rejoin"
RejoinFastButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RejoinFastButton.TextScaled = true
RejoinFastButton.TextSize = 14.000
RejoinFastButton.TextWrapped = true


if debugmode == true then
	print("[DEBUG]: Tab 4 Completed Sucessfuly!")
end

UICorner_49.Parent = RejoinFastButton

-- Fixes 

UIScale.Parent = MainFrame
UIScale_2.Parent = TabsFrame
UIScale_3.Parent = FlyFrame

ButtonSafeArea.BackgroundTransparency = 1


if debugmode == true then
	print("[DEBUG]: All UI Setup Completed Sucessfuly!")
end

print("[SUCESS]: UX Created Sucessfully, Step (2/3) Done.")

local ActiveNotifications = {}

local function CreateTween(Object, Goal, Duration)
	local Tween = TweenService:Create(Object, TweenInfo.new(Duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = Goal
	})
	Tween:Play()
end

local aa = game:GetService("TweenService")
local ab = game:GetService("UserInputService")
local ac = game:GetService("ContextActionService")
local ad = game.CoreGui
local ae = game:GetService("Lighting")

function errCall(af, ag, ah, ai, aj)
    local ak = Instance.new("Sound", ad)
    ak.SoundId = "rbxassetid://91660275693179"
    ak:Play()
    ak.Pitch = 0.39998
	
    local al = Instance.new("Sound", ad)
    al.SoundId = "rbxassetid://139800881181209"

    local am = Instance.new("Sound", ad)
    am.SoundId = "rbxassetid://6042053626"
    am.Looped = true
    am.Volume = 0
    am.Pitch = 0.5
    am.PlaybackSpeed = 2
    am:Play()

    local an = Instance.new("BlurEffect")
    an.Size = 0
    an.Parent = ae
    aa:Create(an, TweenInfo.new(0.3), {Size = 15}):Play()

    local ao = Instance.new("ScreenGui")
    ao.Name = "UNXErrorUI"
    ao.IgnoreGuiInset = true
    ao.ResetOnSpawn = false
    ao.Parent = ad

    local ap = Instance.new("Frame")
    ap.Size = UDim2.fromOffset(200, 125)
    ap.Position = UDim2.fromScale(0.5, 0.5) - UDim2.fromOffset(100, 62.5)
    ap.BackgroundColor3 = Color3.new(0, 0, 0)
    ap.BackgroundTransparency = 0.75
    ap.ZIndex = 0
    ap.Parent = ao
    Instance.new("UICorner", ap).CornerRadius = UDim.new(0, 8)

    local aq = Instance.new("Frame")
    aq.Size = UDim2.fromOffset(200, 125)
    aq.Position = ap.Position
    aq.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
    aq.BorderSizePixel = 0
    aq.ZIndex = 1
    aq.Parent = ao
    Instance.new("UICorner", aq).CornerRadius = UDim.new(0, 8)

    local ar = Instance.new("Frame")
    ar.Size = UDim2.new(1, 0, 0, 35)
    ar.BackgroundColor3 = Color3.fromRGB(0, 2, 39)
    ar.BorderSizePixel = 0
    ar.ZIndex = 2
    ar.Parent = aq
    Instance.new("UICorner", ar).CornerRadius = UDim.new(0, 8)

    local as = Instance.new("ImageLabel")
    as.Size = UDim2.fromOffset(26, 26)
    as.Position = UDim2.new(0, 8, 0.5, -13)
    as.BackgroundTransparency = 1
    as.Image = "rbxassetid://137779536741206"
    as.ZIndex = 3
    as.Parent = ar
    Instance.new("UICorner", as).CornerRadius = UDim.new(0, 6)

    local at = Instance.new("TextLabel")
    at.Size = UDim2.new(1, -50, 1, 0)
    at.Position = UDim2.fromOffset(40, 0)
    at.BackgroundTransparency = 1
    at.Text = af or "Unlisted Error"
    at.Font = Enum.Font.SourceSansLight
    at.TextSize = 20
    at.TextColor3 = Color3.new(1, 1, 1)
    at.TextXAlignment = Enum.TextXAlignment.Left
    at.ZIndex = 3
    at.Parent = ar

    local av = Instance.new("TextLabel")
    av.Size = UDim2.new(1, -40, 0, 45)
    av.Position = UDim2.fromOffset(20, 40)
    av.BackgroundTransparency = 1
    av.Text = ag or "Unlisted Error Occured, Please Press /console For More Information."
    av.Font = Enum.Font.SourceSansLight
    av.TextSize = 17
    av.TextWrapped = true
    av.TextYAlignment = Enum.TextYAlignment.Top
    av.TextXAlignment = Enum.TextXAlignment.Left
    av.TextColor3 = Color3.new(1,1,1)
    av.ZIndex = 2
    av.Parent = aq

    local aw = Instance.new("TextButton")
    aw.Size = UDim2.new(0.4, 0, 0, 35)
    aw.Position = aj and UDim2.new(0.08, 0, 1, -45) or UDim2.new(0.3, 0, 1, -45)
    aw.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
    aw.Text = ah or "OK"
    aw.Font = Enum.Font.SourceSansLight
    aw.TextSize = 17
    aw.TextColor3 = Color3.new(1,1,1)
    aw.ZIndex = 3
    aw.Parent = aq
    Instance.new("UICorner", aw).CornerRadius = UDim.new(0,6)
    if debugmode == true then
		print("[DEBUG]: Called Notification, Title = ".. af  ..", Message = ".. ag .."!")	
    end
    local ax
    if aj then
        ax = Instance.new("TextButton")
        ax.Size = UDim2.new(0.4, 0, 0, 35)
        ax.Position = UDim2.new(0.52, 0, 1, -45)
        ax.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
        ax.Text = ai or "Cancel"
        ax.Font = Enum.Font.SourceSansLight
        ax.TextSize = 17
        ax.TextColor3 = Color3.new(1,1,1)
        ax.ZIndex = 3
        ax.Parent = aq
        Instance.new("UICorner", ax).CornerRadius = UDim.new(0,6)
    end

    local ay = Instance.new("Frame")
    ay.Size = UDim2.fromOffset(20, 20)
    ay.Position = UDim2.new(1, -20, 1, -20)
    ay.BackgroundColor3 = Color3.fromRGB(5, 8, 70)
    ay.BorderSizePixel = 0
    ay.ZIndex = 3
    ay.Parent = aq
    Instance.new("UICorner", ay).CornerRadius = UDim.new(0,4)

    local az, ba, bb = false, nil, nil
    local bc, bd, be = false, nil, nil
    local bf = Color3.fromRGB(5, 8, 70)
    local bg = Color3.fromRGB(3, 6, 50)
    
    local bh = {}

    bh[#bh + 1] = ar.InputBegan:Connect(function(bi)
        if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
            az = true
            ba = bi.Position
            bb = aq.Position
        end
    end)

    bh[#bh + 1] = ar.InputEnded:Connect(function(bi)
        if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
            az = false
        end
    end)

    bh[#bh + 1] = ay.InputBegan:Connect(function(bi)
        if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
            bc = true
            bd = bi.Position
            be = aq.Size
            aa:Create(ay, TweenInfo.new(0.15), {BackgroundColor3 = bg}):Play()
            am.Volume = 0.3
        end
    end)

    bh[#bh + 1] = ay.InputEnded:Connect(function(bi)
        if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
            bc = false
            aa:Create(ay, TweenInfo.new(0.15), {BackgroundColor3 = bf}):Play()
            am.Volume = 0
        end
    end)

    bh[#bh + 1] = ab.InputChanged:Connect(function(bi)
        if bi.UserInputType == Enum.UserInputType.MouseMovement or bi.UserInputType == Enum.UserInputType.Touch then
            if az and ba then
                local bj = bi.Position - ba
                aq.Position = UDim2.new(
                    bb.X.Scale, bb.X.Offset + bj.X,
                    bb.Y.Scale, bb.Y.Offset + bj.Y
                )
                ap.Position = aq.Position
            elseif bc and bd then
                local bj = bi.Position - bd
                local bk = math.clamp(be.X.Offset + bj.X, 200, 800)
                local bl = math.clamp(be.Y.Offset + bj.Y, 125, 600)
                aq.Size = UDim2.fromOffset(bk, bl)
                ap.Size = aq.Size
            end
        end
    end)

    bh[#bh + 1] = ab.InputEnded:Connect(function(bi)
        if bi.UserInputType == Enum.UserInputType.MouseButton1 or bi.UserInputType == Enum.UserInputType.Touch then
            if az then
                az = false
            end
            if bc then
                bc = false
                aa:Create(ay, TweenInfo.new(0.15), {BackgroundColor3 = bf}):Play()
                am.Volume = 0
            end
        end
    end)

    local function bm(bn)
        for _, bo in pairs(bh) do
            bo:Disconnect()
        end
        
        local bp = bn.AbsolutePosition
        local bq = bn.AbsoluteSize
        local br = bp + bq/2
        al:Play()
        aa:Create(an, TweenInfo.new(0.3), {Size = 0}):Play()
        local bs = {Size = UDim2.fromOffset(0,0), Position = UDim2.fromOffset(br.X, br.Y)}
        local bt = aa:Create(aq, TweenInfo.new(0.2), bs)
        local bu = aa:Create(ap, TweenInfo.new(0.2), bs)
        bt:Play(); bu:Play(); bt.Completed:Wait()
        ao:Destroy(); an:Destroy(); ak:Destroy(); al:Destroy(); am:Destroy()
    end
	
    aw.MouseButton1Click:Connect(function() bm(aw) end)
    if ax then
        ax.MouseButton1Click:Connect(function() bm(ax) end)
    end
end

if debugmode == true then
	print("[DEBUG]: Notification System Completed Sucessfuly!")
end

local TweenService = game:GetService("TweenService")
local frames = {MainFrame, TabsFrame}
local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function fade(targetTransparency)
	for _, frame in ipairs(frames) do
		local goal = {BackgroundTransparency = targetTransparency}
		local tween = TweenService:Create(frame, tweenInfo, goal)
		tween:Play()
	end
end

function SwitchTab1()
	btnsfx:Play()
	Tab1.Visible = true
	Tab2.Visible = false
	Tab3.Visible = false
	Tab4.Visible = false
	Tab5.Visible = false
end


if debugmode == true then
	print("[DEBUG]: Tab 1 Linked To SwitchTab Sucessfuly!")
end

function SwitchTab2()
	btnsfx:Play()
	Tab1.Visible = false
	Tab2.Visible = true
	Tab3.Visible = false
	Tab4.Visible = false
	Tab5.Visible = false
end


if debugmode == true then
	print("[DEBUG]: Tab 2 Linked To SwitchTab Sucessfuly!")
end

function SwitchTab3()
	btnsfx:Play()
	Tab1.Visible = false
	Tab2.Visible = false
	Tab3.Visible = true
	Tab4.Visible = false
	Tab5.Visible = false
end


if debugmode == true then
	print("[DEBUG]: Tab 3 Linked To SwitchTab Sucessfuly!")
end

function SwitchTab4()
	btnsfx:Play()
	Tab1.Visible = false
	Tab2.Visible = false
	Tab3.Visible = false
	Tab4.Visible = true
	Tab5.Visible = false
end


if debugmode == true then
	print("[DEBUG]: Tab 4 Linked To SwitchTab Sucessfuly!")
end

function SwitchTab5()
	btnsfx:Play()
	Tab1.Visible = false
	Tab2.Visible = false
	Tab3.Visible = false
	Tab4.Visible = false
	Tab5.Visible = true
end


if debugmode == true then
	print("[DEBUG]: Tab 5 Linked To SwitchTab Sucessfuly!")
end

function FF1()
	if NoclipFastButton.Visible == true then
		NoclipFastButton.Visible = false
	else
		NoclipFastButton.Visible = true
	end
end

function FF2()
	if RejoinFastButton.Visible == true then
		RejoinFastButton.Visible = false
	else
		RejoinFastButton.Visible = true
	end
end

function FF3()
	if AimLockFastButton.Visible == true then
		AimLockFastButton.Visible = false
	else
		AimLockFastButton.Visible = true
	end
end

function FF4()
	if InfJumpFastButton.Visible == true then
		InfJumpFastButton.Visible = false
	else
		InfJumpFastButton.Visible = true
	end
end

local function MinimizeUI()
	btnsfx:Play()
	if debugmode == true then
		print("[DEBUG]: UI Hidden.")
	end
	fade(1)
	MainFrame.Visible = false
	TabsFrame.Visible = false
	OpenUNX.Visible = true
end

local noclip = false
local con

function ToggleNoclip()
	noclip = not noclip

	if noclip then
		if debugmode == true then
			print("[DEBUG]: Noclip Is Now Activated")
		end
		con = game:GetService("RunService").Stepped:Connect(function()
			local char = game:GetService("Players").LocalPlayer.Character
			if char then
				for _, p in pairs(char:GetDescendants()) do
					if p:IsA("BasePart") then
						p.CanCollide = false
					end
				end
			end
		end)
	else
		print("[DEBUG]: Noclip Is Now Off.")
		if con then con:Disconnect() con = nil end

		local char = game:GetService("Players").LocalPlayer.Character
		if char then
			for _, p in pairs(char:GetDescendants()) do
				if p:IsA("BasePart") then
					p.CanCollide = true
				end
			end
		end
	end
end

local player = Players.LocalPlayer

local EnableFly = FlyButton
local FlySpeed = FlySpeedTXT
local flySpeed = 1
local isFlying = false
local teleportWalking = false
local animationTracks = {}

local function freezeCharacter()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local animate = character:FindFirstChild("Animate")
	if animate then
		animate.Disabled = true
	end

	animationTracks = {}
	for i, track in pairs(humanoid:GetPlayingAnimationTracks()) do
		table.insert(animationTracks, track)
		track:Stop()
	end

	humanoid.PlatformStand = true

	if humanoid.RigType == Enum.HumanoidRigType.R15 then
		local function freezeLimb(limbName, targetCFrame)
			local limb = character:FindFirstChild(limbName)
			if limb then
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = character.UpperTorso
				weld.Part1 = limb
				weld.Parent = character.UpperTorso
				limb.CFrame = character.UpperTorso.CFrame * targetCFrame
			end
		end

		wait(0.1)
		if character:FindFirstChild("UpperTorso") then
			freezeLimb("LeftUpperArm", CFrame.new(-1.5, 0.5, 0))
			freezeLimb("RightUpperArm", CFrame.new(1.5, 0.5, 0))
			freezeLimb("LeftUpperLeg", CFrame.new(-0.5, -1, 0))
			freezeLimb("RightUpperLeg", CFrame.new(0.5, -1, 0))
		end
	end
end

local function unfreezeCharacter()
	local character = player.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local animate = character:FindFirstChild("Animate")
	if animate then
		animate.Disabled = false
	end

	for _, part in pairs(character:GetChildren()) do
		if part:IsA("BasePart") then
			for _, constraint in pairs(part:GetChildren()) do
				if constraint:IsA("WeldConstraint") and constraint.Name ~= "AccessoryWeld" then
					constraint:Destroy()
				end
			end
		end
	end

	humanoid.PlatformStand = false
end

FlySpeed.FocusLost:Connect(function()
	local newSpeed = tonumber(FlySpeed.Text)
	if newSpeed and newSpeed >= 1 then
		flySpeed = newSpeed
	else
		FlySpeed.Text = flySpeed
	end

	if isFlying == true then
		teleportWalking = false
		for i = 1, flySpeed do
			spawn(function()
				local heartbeat = RunService.Heartbeat	
				teleportWalking = true
				local character = player.Character
				local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
				while teleportWalking and heartbeat:Wait() and character and humanoid and humanoid.Parent do
					if humanoid.MoveDirection.Magnitude > 0 then
						character:TranslateBy(humanoid.MoveDirection)
					end
				end
			end)
		end
	end
end)

EnableFly.MouseButton1Down:connect(function()
	if isFlying == true then
		isFlying = false
		teleportWalking = false

		if debugmode == true then
			print("[DEBUG]: Fly Toggle Turned Off.")
		end

		unfreezeCharacter()

		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
	else 
		isFlying = true

		freezeCharacter()

		if debugmode == true then
			print("[DEBUG]: Fly Toggle Turned On.")
		end

		for i = 1, flySpeed do
			spawn(function()
				local heartbeat = RunService.Heartbeat	
				teleportWalking = true
				local character = player.Character
				local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
				while teleportWalking and heartbeat:Wait() and character and humanoid and humanoid.Parent do
					if humanoid.MoveDirection.Magnitude > 0 then
						character:TranslateBy(humanoid.MoveDirection)
					end
				end
			end)
		end

		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end

	if player.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
		local torso = player.Character.Torso
		local controls = {forward = 0, backward = 0, left = 0, right = 0}
		local lastControls = {forward = 0, backward = 0, left = 0, right = 0}
		local maxSpeed = 50
		local currentSpeed = 0

		local bodyGyro = Instance.new("BodyGyro", torso)
		bodyGyro.P = 9e4
		bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.cframe = torso.CFrame
		local bodyVelocity = Instance.new("BodyVelocity", torso)
		bodyVelocity.velocity = Vector3.new(0,0.1,0)
		bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

		while isFlying == true or player.Character.Humanoid.Health == 0 do
			RunService.RenderStepped:Wait()

			if controls.left + controls.right ~= 0 or controls.forward + controls.backward ~= 0 then
				currentSpeed = currentSpeed+.5+(currentSpeed/maxSpeed)
				if currentSpeed > maxSpeed then
					currentSpeed = maxSpeed
				end
			elseif not (controls.left + controls.right ~= 0 or controls.forward + controls.backward ~= 0) and currentSpeed ~= 0 then
				currentSpeed = currentSpeed-1
				if currentSpeed < 0 then
					currentSpeed = 0
				end
			end

			if (controls.left + controls.right) ~= 0 or (controls.forward + controls.backward) ~= 0 then
				bodyVelocity.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (controls.forward+controls.backward)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(controls.left+controls.right,(controls.forward+controls.backward)*.2,0).p) - workspace.CurrentCamera.CoordinateFrame.p))*currentSpeed
				lastControls = {forward = controls.forward, backward = controls.backward, left = controls.left, right = controls.right}
			elseif (controls.left + controls.right) == 0 and (controls.forward + controls.backward) == 0 and currentSpeed ~= 0 then
				bodyVelocity.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lastControls.forward+lastControls.backward)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastControls.left+lastControls.right,(lastControls.forward+lastControls.backward)*.2,0).p) - workspace.CurrentCamera.CoordinateFrame.p))*currentSpeed
			else
				bodyVelocity.velocity = Vector3.new(0,0,0)
			end

			bodyGyro.cframe = workspace.CurrentCamera.CoordinateFrame
		end

		controls = {forward = 0, backward = 0, left = 0, right = 0}
		lastControls = {forward = 0, backward = 0, left = 0, right = 0}
		currentSpeed = 0
		bodyGyro:Destroy()
		bodyVelocity:Destroy()
		teleportWalking = false
	else
		local upperTorso = player.Character.UpperTorso
		local controls = {forward = 0, backward = 0, left = 0, right = 0}
		local lastControls = {forward = 0, backward = 0, left = 0, right = 0}
		local maxSpeed = 50
		local currentSpeed = 0

		local bodyGyro = Instance.new("BodyGyro", upperTorso)
		bodyGyro.P = 9e4
		bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bodyGyro.cframe = upperTorso.CFrame
		local bodyVelocity = Instance.new("BodyVelocity", upperTorso)
		bodyVelocity.velocity = Vector3.new(0,0.1,0)
		bodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)

		while isFlying == true or player.Character.Humanoid.Health == 0 do
			wait()

			if controls.left + controls.right ~= 0 or controls.forward + controls.backward ~= 0 then
				currentSpeed = currentSpeed+.5+(currentSpeed/maxSpeed)
				if currentSpeed > maxSpeed then
					currentSpeed = maxSpeed
				end
			elseif not (controls.left + controls.right ~= 0 or controls.forward + controls.backward ~= 0) and currentSpeed ~= 0 then
				currentSpeed = currentSpeed-1
				if currentSpeed < 0 then
					currentSpeed = 0
				end
			end

			if (controls.left + controls.right) ~= 0 or (controls.forward + controls.backward) ~= 0 then
				bodyVelocity.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (controls.forward+controls.backward)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(controls.left+controls.right,(controls.forward+controls.backward)*.2,0).p) - workspace.CurrentCamera.CoordinateFrame.p))*currentSpeed
				lastControls = {forward = controls.forward, backward = controls.backward, left = controls.left, right = controls.right}
			elseif (controls.left + controls.right) == 0 and (controls.forward + controls.backward) == 0 and currentSpeed ~= 0 then
				bodyVelocity.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lastControls.forward+lastControls.backward)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastControls.left+lastControls.right,(lastControls.forward+lastControls.backward)*.2,0).p) - workspace.CurrentCamera.CoordinateFrame.p))*currentSpeed
			else
				bodyVelocity.velocity = Vector3.new(0,0,0)
			end

			bodyGyro.cframe = workspace.CurrentCamera.CoordinateFrame
		end

		controls = {forward = 0, backward = 0, left = 0, right = 0}
		lastControls = {forward = 0, backward = 0, left = 0, right = 0}
		currentSpeed = 0
		bodyGyro:Destroy()
		bodyVelocity:Destroy()
		teleportWalking = false
	end
end)

player.CharacterAdded:Connect(function(character)
	wait(0.7)
	unfreezeCharacter()
	isFlying = false
	teleportWalking = false
end)

local function OpenUNX1()
	if debugmode == true then
		print("[DEBUG]: UI Visible")
	end
	btnsfx:Play()	
	fade(0)
	OpenUNX.Visible = false
	TabsFrame.Visible = true
	MainFrame.Visible = true
end

local function ChangePWS()
	local Value = WSTextBox.Text
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	if WSTextBox.Text == "" then
		WSTextBox.Text = "Input A Number!"
		wait(1)
		WSTextBox.Text = ""
	elseif WSTextBox.Text == " " then
		WSTextBox.Text = "Input A Number!"
		wait(1)
		WSTextBox.Text = ""
	else
		local Value = WSTextBox.Text
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end
end


local function ChangeScale()
	local value = ScaleTxT.Text

	if value >= "2.000000000000000000001" then
		errCall(
			"Wild Error Found!",
			"Please, Input The Scale Range In This Range: 0.5-2",
			"OK",
			":D",
			false
		)
		ScaleTxT.Text = "Please, Set Scale In This Range: 2-0.5"
		wait(1)
		ScaleTxT.Text = ""
	elseif value <= "0.49999999999999999" then
		errCall(
			"Wild Error Found!",
			"Please, Input The Scale Range In This Range: 0.5-2",
			"OK",
			":D",
			false
		)
		ScaleTxT.Text = "Please, Set Scale In This Range: 2-0.5"
		wait(1)
		ScaleTxT.Text = ""
	else
		UIScale.Scale = value
		UIScale_2.Scale = value
		UIScale_3.Scale = value
	end
end

-- Hello :> - Gato

local function JoinJobID1()
	local tpservice = game:GetService("TeleportService")

	tpservice:TeleportToPlaceInstance(placeID, jobID, game.Players.LocalPlayer)
end

local function CopyJobID1()

	if setclipboard then
		setclipboard(jobID)
		print("[SUCESS]: JobID: ".. jobID	.." Copied To Clipboard.")
	elseif toclipboard then
		toclipboard(jobID)
		print("[SUCESS]: JobID: ".. jobID	.." Copied To Clipboard.")
	else
		errCall(
			"Wild Error Found!",
			"Your Executor: ".. exec .." Does Not Support: toclipboard() or setclipboard().",
			"OK",
			":D",
			false
		)
		warn("[ERROR]: Your Executor: ".. exec .." Does Not Support: toclipboard() or setclipboard(). ")
	end
end

local function ChangePJP()
	local Value = JPTextBox.Text
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	if JPTextBox.Text == "" then
		JPTextBox.Text = "Input A Number!"
		wait(1)
		JPTextBox.Text = ""
	elseif JPTextBox.Text == " " then
		JPTextBox.Text = "Input A Number!"
		wait(1)
		JPTextBox.Text = ""
	else
		local Value = JPTextBox.Text
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end
end

local function ChangePZoom()
	local Value = WSTextBox.Text
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	if ZoomTextBox.Text == "" then
		ZoomTextBox.Text = "Input A Number!"
		wait(1)
		ZoomTextBox.Text = ""
	elseif ZoomTextBox.Text == " " then
		ZoomTextBox.Text = "Input A Number!"
		wait(1)
		ZoomTextBox.Text = ""
	else
		local Value = ZoomTextBox.Text
		game.Players.LocalPlayer.CameraMaxZoomDistance = Value
	end
end

local function GravityFC()
	local Value = ZoomTextBox_2.Text
	game.Workspace.Gravity = Value
	if ZoomTextBox_2.Text == "" then
		ZoomTextBox_2.Text = "Input A Number!"
		wait(1)
		ZoomTextBox_2.Text = ""
	elseif ZoomTextBox_2.Text == " " then
		ZoomTextBox_2.Text = "Input A Number!"
		wait(1)
		ZoomTextBox_2.Text = ""
	else
		local Value = ZoomTextBox_2.Text
		game.Workspace.Gravity = Value
	end
end

local InfJumpEnabled = false

function InfJumpF()
	local humanoid = LocalPlayer.Character:WaitForChild("Humanoid")

	game:GetService("UserInputService").JumpRequest:Connect(function()
		if InfJumpEnabled then
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end

InfJumpF()

InfJumpB.MouseButton1Click:Connect(function()
	InfJumpEnabled = not InfJumpEnabled
	if InfJumpEnabled then
		InfJumpB.BackgroundColor3 = Color3.fromRGB(0, 121, 0)
	else
		InfJumpB.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
	end
end)

InfJumpFastButton.MouseButton1Click:Connect(function()
	InfJumpEnabled = not InfJumpEnabled
	if InfJumpEnabled then
		InfJumpB.BackgroundColor3 = Color3.fromRGB(0, 121, 0)
	else
		InfJumpB.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
	end
end)

local Aiming = false
local IgnoreSameTeam = true

function GetNearestPlayer()
	if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return nil end
	local myPos = LocalPlayer.Character.HumanoidRootPart.Position
	local closest, dist = nil, math.huge
	local hasTeam = LocalPlayer.Team ~= nil

	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			if hasTeam and IgnoreSameTeam and v.Team == LocalPlayer.Team then
				continue
			end
			local d = (myPos - v.Character.HumanoidRootPart.Position).Magnitude
			if d < dist then
				dist = d
				closest = v
			end
		end
	end

	return closest
end

function AimToTarget()
	local target = GetNearestPlayer()
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		local camPos = Camera.CFrame.Position
		local tgtPos = target.Character.HumanoidRootPart.Position
		Camera.CFrame = CFrame.new(camPos, tgtPos)
	end
end

function ToggleAim()
	Aiming = not Aiming
	if Aiming then
		AimLock.BackgroundColor3 = Color3.fromRGB(0, 121, 0)
	else
		AimLock.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
		ToggleAim()
	end
end)

AimLock.MouseButton1Click:Connect(function()
	ToggleAim()
end)

AimLockFastButton.MouseButton1Click:Connect(function()
	ToggleAim()
end)

RunService.RenderStepped:Connect(function()
	if Aiming then
		AimToTarget()
	end
end)

function FlyFC()
	if FlyFrame.Visible == false then
		ExecScript.BackgroundColor3 = Color3.fromRGB(0, 121, 0)
		FlyFrame.Visible = true
	else
		ExecScript.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
		FlyFrame.Visible = false
	end
end

local function Rejoin()
	local tpservice = game:GetService("TeleportService")
	local jobID = game.JobId
	local placeID = game.PlaceId

	if debugmode == true then
		print("[DEBUG]: Rejoining...")
	end
	tpservice:TeleportToPlaceInstance(placeID, jobID, game.Players.LocalPlayer)
end

local function fpscap()
	local valueoffps = tonumber(FPSTextBox.Text)
	if valueoffps then
		setfpscap(valueoffps)
	else
	        errCall(
       
			"Wild Error Found!",
			"Unknown FPS Value Found: ".. tostring(FPSTextBox.Text) .."!",
			"OK",
			":D",
			false
		)
		warn("[ERROR]: Invalid FPS value: " .. tostring(FPSTextBox.Text))
	end
end

function RunODH()
	loadstring(game:HttpGet("https://api.overdrivehub.xyz/v1/auth"))()
end

function RunIY()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end

local Players = game:GetService("Players")

local HighlightsEnabled = false
local ActiveHighlights = {}
local PlayerConnections = {}

local function ApplyHighlightToCharacter(Player, Character)
	local UserId = Player.UserId

	if ActiveHighlights[UserId] then
		ActiveHighlights[UserId]:Destroy()
	end

	local Highlighter = Instance.new("Highlight")
	Highlighter.Name = "PlayerHighlight"
	Highlighter.FillTransparency = 1
	Highlighter.OutlineColor = (Player.TeamColor and Player.TeamColor.Color) or Color3.fromRGB(255, 48, 51)
	Highlighter.Adornee = Character
	Highlighter.Parent = Character

	ActiveHighlights[UserId] = Highlighter
end

local function SetupPlayerHighlight(Player)
	local UserId = Player.UserId

	local function OnCharacterAdded(Character)
		local Humanoid = Character:WaitForChild("Humanoid")

		if HighlightsEnabled then
			ApplyHighlightToCharacter(Player, Character)
		end

		table.insert(PlayerConnections[UserId], Player:GetPropertyChangedSignal("TeamColor"):Connect(function()
			local Highlight = ActiveHighlights[UserId]
			if Highlight then
				Highlight.OutlineColor = (Player.TeamColor and Player.TeamColor.Color) or Color3.fromRGB(255, 48, 51)
			end
		end))

		table.insert(PlayerConnections[UserId], Humanoid.Died:Connect(function()
			RemoveHighlight(Player)
		end))
	end

	local charAddedConn = Player.CharacterAdded:Connect(OnCharacterAdded)
	table.insert(PlayerConnections[UserId], charAddedConn)

	if Player.Character then
		OnCharacterAdded(Player.Character)
	end
end

function RemoveHighlight(Player)
	local UserId = Player.UserId

	if ActiveHighlights[UserId] then
		ActiveHighlights[UserId]:Destroy()
		ActiveHighlights[UserId] = nil
	end

	if PlayerConnections[UserId] then
		for _, conn in pairs(PlayerConnections[UserId]) do
			conn:Disconnect()
		end
		PlayerConnections[UserId] = nil
	end
end


function ToggleHighlights()
	if HighlightsEnabled then
		EnableOut.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
		HighlightsEnabled = false
		for _, player in pairs(Players:GetPlayers()) do
			RemoveHighlight(player)
		end
	else
		EnableOut.BackgroundColor3 = Color3.fromRGB(0, 121, 0)
		HighlightsEnabled = true
		for _, player in pairs(Players:GetPlayers()) do
			PlayerConnections[player.UserId] = {}
			SetupPlayerHighlight(player)
		end
	end
end

EnableOut.MouseButton1Click:Connect(ToggleHighlights)

Players.PlayerAdded:Connect(function(player)
	if HighlightsEnabled then
		PlayerConnections[player.UserId] = {}
		SetupPlayerHighlight(player)
	end
end)

Players.PlayerRemoving:Connect(RemoveHighlight)

local button = EnableESP
local ESPEnabledFunction = false

local ESPObjects = {}

local function getPlayerColor(player)
	if player.Team then
		return player.TeamColor.Color
	else
		return Color3.new(1, 1, 1) -- White
	end
end

local function createESP(player)
	if player == LocalPlayer then return end
	if ESPObjects[player] then return end

	local nameText = Drawing.new("Text")
	nameText.Size = 13
	nameText.Center = true
	nameText.Outline = true

	local infoText = Drawing.new("Text")
	infoText.Size = 12
	infoText.Center = true
	infoText.Outline = true

	ESPObjects[player] = {
		Name = nameText,
		Info = infoText
	}
end

local function removeESP(player)
	if ESPObjects[player] then
		ESPObjects[player].Name:Remove()
		ESPObjects[player].Info:Remove()
		ESPObjects[player] = nil
	end
end
if debugmode == true then
	warn("[DEBUG]: Call Line 2000.")
end
local function updateESP()
	for player, esp in pairs(ESPObjects) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character.HumanoidRootPart
			local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)

			local color = getPlayerColor(player)
			esp.Name.Color = color
			esp.Info.Color = color

			if onScreen then
				local distance = (Camera.CFrame.Position - hrp.Position).Magnitude
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				local health = humanoid and math.floor(humanoid.Health) or 0

				esp.Name.Position = Vector2.new(pos.X, pos.Y - 20)
				esp.Name.Text = player.Name
				esp.Name.Visible = true

				esp.Info.Position = Vector2.new(pos.X, pos.Y - 7)
				esp.Info.Text = "HP: "..health.." | "..math.floor(distance).."m"
				esp.Info.Visible = true
			else
				esp.Name.Visible = false
				esp.Info.Visible = false
			end
		else
			removeESP(player)
		end
	end
end

button.MouseButton1Click:Connect(function()
	ESPEnabledFunction = not ESPEnabledFunction
	if ESPEnabledFunction then
		for _, player in ipairs(Players:GetPlayers()) do
			createESP(player)
		end

		EnableESP.BackgroundColor3 = Color3.fromRGB(0, 121, 0)
	else
		for player, _ in pairs(ESPObjects) do
			removeESP(player)
		end

		EnableESP.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
	end
end)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if ESPEnabledFunction then
			createESP(player)
		end
	end)
end)

RunService.RenderStepped:Connect(function()
	if ESPEnabledFunction then
		updateESP()
	end
end)

local tracersOn = false
local tracerLines = {}
local button = EnableTrcs

function toggleTracers()
	tracersOn = not tracersOn

	if tracersOn then
		button.BackgroundColor3 = Color3.fromRGB(0, 121, 0)
	else
		button.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
	end

	if tracersOn then
		RunService:BindToRenderStep("Tracers", Enum.RenderPriority.Camera.Value + 1, function()
			for _, line in ipairs(tracerLines) do
				line:Destroy()
			end
			tracerLines = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local root = player.Character.HumanoidRootPart
					local screenPos, onScreen = Camera:WorldToViewportPoint(root.Position)

					if onScreen then
						local line = Drawing.new("Line")
						line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
						line.To = Vector2.new(screenPos.X, screenPos.Y)
						line.Color = player.TeamColor.Color
						line.Thickness = 2
						line.Transparency = 1
						line.Visible = true
						table.insert(tracerLines, line)
					end
				end
			end
		end)
	else
		RunService:UnbindFromRenderStep("Tracers")
		for _, line in ipairs(tracerLines) do
			line:Destroy()
		end
		tracerLines = {}
	end
end

local skelOn = false
local skeletonLines = {}

function drawLine(p1, p2, color)
	local line = Drawing.new("Line")
	line.From = p1
	line.To = p2
	line.Color = color
	line.Thickness = 2
	line.Transparency = 1
	line.Visible = true
	return line
end

function toggleSkeleton()
	skelOn = not skelOn
	EnableSkel.BackgroundColor3 = skelOn and Color3.fromRGB(0, 121, 0) or Color3.fromRGB(0, 4, 67)

	if skelOn then
		RunService:BindToRenderStep("SkeletonESP", Enum.RenderPriority.Camera.Value + 1, function()
			for _, line in ipairs(skeletonLines) do
				line:Destroy()
			end
			skeletonLines = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character then
					local char = player.Character
					local parts = {
						Head = char:FindFirstChild("Head"),
						Torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"),
						Hip = char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso"),
						LeftArm = char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm"),
						RightArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"),
						LeftLeg = char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg"),
						RightLeg = char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")
					}

					local color = player.TeamColor.Color
					local function getScreen(part)
						if part then
							local pos, visible = Camera:WorldToViewportPoint(part.Position)
							if visible then return Vector2.new(pos.X, pos.Y) end
						end
						return nil
					end

					local head = getScreen(parts.Head)
					local torso = getScreen(parts.Torso)
					local hip = getScreen(parts.Hip)
					local la = getScreen(parts.LeftArm)
					local ra = getScreen(parts.RightArm)
					local ll = getScreen(parts.LeftLeg)
					local rl = getScreen(parts.RightLeg)

					if head and torso then table.insert(skeletonLines, drawLine(head, torso, color)) end
					if torso and hip then table.insert(skeletonLines, drawLine(torso, hip, color)) end
					if torso and la then table.insert(skeletonLines, drawLine(torso, la, color)) end
					if torso and ra then table.insert(skeletonLines, drawLine(torso, ra, color)) end
					if hip and ll then table.insert(skeletonLines, drawLine(hip, ll, color)) end
					if hip and rl then table.insert(skeletonLines, drawLine(hip, rl, color)) end
				end
			end
		end)
	else
		RunService:UnbindFromRenderStep("SkeletonESP")
		for _, line in ipairs(skeletonLines) do
			line:Destroy()
		end
		skeletonLines = {}
	end
end

local boxESPEnabled = false
local boxESPConnections = {}
local newPlayerConnection

function TurnOnBoxESP()
	EnableBox.MouseButton1Click:Connect(function()
		boxESPEnabled = not boxESPEnabled

		if boxESPEnabled then
			EnableBox.BackgroundColor3 = Color3.fromRGB(0, 121, 0)
			local function addBox(char, player)
				local hrp = char:FindFirstChild("HumanoidRootPart")
				if hrp and not hrp:FindFirstChild("ESPBox") then
					local box = Instance.new("BoxHandleAdornment")
					box.Name = "ESPBox"
					box.Adornee = hrp
					box.Size = Vector3.new(4, 6, 4)
					box.Color3 = player.TeamColor.Color
					box.AlwaysOnTop = true
					box.ZIndex = 5
					box.Transparency = 0.5
					box.Parent = hrp
				end
			end

			local function setupPlayer(player)
				if player ~= game.Players.LocalPlayer then
					if player.Character then
						addBox(player.Character, player)
					end
					boxESPConnections[player] = player.CharacterAdded:Connect(function(char)
						addBox(char, player)
					end)
				end
			end

			for _, player in pairs(game.Players:GetPlayers()) do
				setupPlayer(player)
			end

			newPlayerConnection = game.Players.PlayerAdded:Connect(function(player)
				setupPlayer(player)
			end)

		else
			EnableBox.BackgroundColor3 = Color3.fromRGB(0, 4, 67)
			for _, player in pairs(game.Players:GetPlayers()) do
				if player ~= game.Players.LocalPlayer then
					local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						local box = hrp:FindFirstChild("ESPBox")
						if box then
							box:Destroy()
						end
					end
					if boxESPConnections[player] then
						boxESPConnections[player]:Disconnect()
						boxESPConnections[player] = nil
					end
				end
			end

			if newPlayerConnection then
				newPlayerConnection:Disconnect()
				newPlayerConnection = nil
			end
		end
	end)
end


if debugmode == true then
	print("[DEBUG]: All Functions Created Sucessfully.")
end

-- local function soi()
--	while true do
--		-- soi soi soi soi 
--		task.wait("")
-- 		print("soi")
--	end
-- end

-- gotta use deprecated function or the fucking entire script would break!!!11!!1 :(

MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Selectable = true

TabsFrame.Active = true
TabsFrame.Draggable = true
TabsFrame.Selectable = true

FlyFrame.Active = true
FlyFrame.Draggable = true
FlyFrame.Selectable = true

InfJumpFastButton.Active = true
InfJumpFastButton.Draggable = true
InfJumpFastButton.Selectable = true

AimLockFastButton.Active = true
AimLockFastButton.Draggable = true
AimLockFastButton.Selectable = true

RejoinFastButton.Active = true
RejoinFastButton.Draggable = true
RejoinFastButton.Selectable = true

NoclipFastButton.Active = true
NoclipFastButton.Draggable = true
NoclipFastButton.Selectable = true

OpenUNX.Active = true
OpenUNX.Draggable = true
OpenUNX.Selectable = true

UNXHubUI.ResetOnSpawn = false -- DO NOT MESS WITH IT.


if debugmode == true then
	print("[DEBUG]: UI Should Be Draggable Now.")
end

ApplyFPS.MouseButton1Click:Connect(fpscap)
InfJumpB.MouseButton1Click:Connect(InfJumpF)
OverdriveH.MouseButton1Click:Connect(RunODH)
LoadIy.MouseButton1Click:Connect(RunIY)
RejServer.MouseButton1Click:Connect(Rejoin)
ExecScript.MouseButton1Click:Connect(FlyFC)
JoinJobID.MouseButton1Click:Connect(JoinJobID1)
CopyJobID.MouseButton1Click:Connect(CopyJobID1)
ApplyZoom.MouseButton1Click:Connect(ChangePZoom)
ApplyJP.MouseButton1Click:Connect(ChangePJP)
ApplyWS.MouseButton1Click:Connect(ChangePWS)
ApplyGrav.MouseButton1Click:Connect(GravityFC)
Minimize.MouseButton1Click:Connect(MinimizeUI)
OpenUNX.MouseButton1Click:Connect(OpenUNX1)
LocalPlayerTab1.MouseButton1Click:Connect(SwitchTab1)
ESPTab2.MouseButton1Click:Connect(SwitchTab2)
OtherTab3.MouseButton1Click:Connect(SwitchTab3)
FastButtonTab4.MouseButton1Click:Connect(SwitchTab4)
ConfigTab5.MouseButton1Click:Connect(SwitchTab5)
button.MouseButton1Click:Connect(toggleTracers)
EnableSkel.MouseButton1Click:Connect(toggleSkeleton)
ScaleUI.MouseButton1Click:Connect(ChangeScale)
NoclipFF.MouseButton1Click:Connect(FF1)
RejFF.MouseButton1Click:Connect(FF2)
AimLockFF.MouseButton1Click:Connect(FF3)
InfjumpFF.MouseButton1Click:Connect(FF4)
RejoinFastButton.MouseButton1Click:Connect(Rejoin)
NoclipFastButton.MouseButton1Click:Connect(ToggleNoclip)

TurnOnBoxESP()


if debugmode == true then
	print("[DEBUG]: Linked All Buttons To Function.")
end

print("[SUCESS]: All Functions & Buttons Done, Step (3/3) Done.")


local phrases = {
	"UNXHub Loaded Without Any Errors!, Maybe",
	"Let Him Cook",
	"Let Me Cook",
	"UNXHub Is Now Done Loading",
	"UNXHub :0000 Is Gud",
	"UNXHUB Loaded",
	"All Loaded Up!, Good Exploiting",
	"Let me check if it loaded... yea it did",
	"<<<UNXHub>>> UNXHub Loaded Sucessfully.",
	"How Did I Even Make This?",
	"Basically: UNXHub Is Loaded",
	"Solara Also Steals Your Malware..., Wise Words...",
	"Developer why UNXHub No Work?",
	"The Current Time Is: ".. os.time() ..", Iam Lazy To Format It",
	"Hello :)",
	"Hi :), Thanks For Using UNXHub!",
	"From 1-10 i Choose: ".. math.random(1,10) .."!",
	"Also Try InfiniteYield (If You Havent)",
	"NEW FEATURES!1!!1!",
	"ERM, ACTUALLY 🤓☝️",
	"Should i Create a Discord Server?",
  "helloworld(print)",
  "h",
  "Hey Bro!",
  "Developer When UNXHub Update?",
  "Developer Why UNXHub No Work?, idk ask sterling",
  "Sometimes I Do Beta Tests At: GitHub/uHeyCaf/ArrayField/BetaUNX.lua!",
  "Hey Twin ✌️",
  "Idk Nobody Asked But The Current Version Is: ".. version ..", We Started At 3.0.0 [BETA]"
}

print("[NEUTRAL]: ".. phrases[math.random(#phrases)])

errCall(
    "Welcome",
    "Welcome To UNXHub ".. game.Players.LocalPlayer.Name .."!",
    "Thanks!",
    "Continue",
    true
)

if debugmode == true then
	errCall(
		"Debug Mode",
		"Warning, DebugMode Is Active.",
		"OK",
		":D",
		false
	)
	print("[DEBUG]: Testing Notification System Completed Sucessfuly!")
	print("[DEBUG]: Current Version: ".. version .."!")
end
 
