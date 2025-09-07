-- Executor / LocalScript
-- Fixed: first image deleted exactly at 21s; timer lasts exactly 21 real seconds and accelerates.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Assets
local mp3Url = "https://github.com/not-gato/Stuff/raw/refs/heads/main/Files/a3e6e16a2794160b73418f151043202c.mp3"
local mp3File = "scawwy.mp3"

-- Image stack (order = visible top -> bottom when stacked; we show Image21s first)
local images = {
    Image21s = "rbxassetid://103442365143253",  -- shown for 21s, then deleted
    Image1s  = "rbxassetid://76952432851258",   -- shown for 1s, then deleted
    Image01s = "rbxassetid://95253976488560"    -- final image (do NOT delete)
}
local loopSoundId = "rbxassetid://6896112317"

-- Write local MP3 (executor)
writefile(mp3File, game:HttpGet(mp3Url))

-- Build UI
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Black full-screen background
local blackFrame = Instance.new("Frame")
blackFrame.Size = UDim2.fromScale(1, 1)
blackFrame.Position = UDim2.new(0, 0, 0, 0)
blackFrame.BackgroundColor3 = Color3.new(0, 0, 0)
blackFrame.ZIndex = 0
blackFrame.Parent = screenGui

-- Preload / Stack images (all full screen). Visible will be controlled.
local stacked = {}
for key, id in pairs(images) do
    local img = Instance.new("ImageLabel")
    img.Size = UDim2.fromScale(1, 1)
    img.Position = UDim2.new(0, 0, 0, 0)
    img.BackgroundTransparency = 1
    img.Image = id
    img.ZIndex = 1
    img.Visible = false
    img.Parent = screenGui
    stacked[key] = img
end

-- Show the 21s image first (it must remain until the 21s mark)
stacked.Image21s.Visible = true

-- Timer label above the images
local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0.3, 0, 0.3, 0)
timerLabel.Position = UDim2.new(0.7, 0, 0.7, 0) -- bottom-right region above image
timerLabel.BackgroundColor3 = Color3.new(0, 0, 0)
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.TextScaled = true
timerLabel.Text = ":30.00"
timerLabel.ZIndex = 2
timerLabel.Parent = screenGui

-- Prepare and play initial local sound
local localSound = Instance.new("Sound")
localSound.SoundId = getcustomasset(mp3File)
localSound.Volume = 1
localSound.Looped = false
localSound.Parent = PlayerGui
localSound:Play()

-- Countdown parameters
local totalRealTime = 21        -- exact real seconds the timer runs
local displayTime = 30         -- the visual countdown range (30 -> 0)
local accelPower = 3           -- cubic curve (s^3). Increase for stronger acceleration.

-- Start timer (use same startTick referenced by the timeline below)
local startTick = tick()
local timerRunning = true

spawn(function()
    while timerRunning do
        local elapsed = tick() - startTick
        local s = math.clamp(elapsed / totalRealTime, 0, 1) -- normalized 0..1
        -- use an accelerating curve: h(s) = s^accelPower (slow early, fast late)
        local h = s^accelPower
        local visualRemaining = displayTime * (1 - h) -- 30 -> 0 over totalRealTime
        if visualRemaining < 0 then visualRemaining = 0 end
        timerLabel.Text = string.format(":%05.2f", visualRemaining)
        if elapsed >= totalRealTime then
            timerLabel.Text = "YOuR Not SaFE.. "..player.Name.." ..!"
            timerRunning = false
            break
        end
        task.wait(0.01)
    end
end)

-- TIMELINE: exactly aligned to totalRealTime = 21s real time
-- Wait the exact 21 real seconds before switching images
task.wait(totalRealTime)

-- At 21s mark: delete the 21s image to reveal the 1s image
if stacked.Image21s and stacked.Image21s.Parent then
    stacked.Image21s:Destroy()
end
stacked.Image1s.Visible = true

-- Switch sound to the looped Roblox audio and play loop
localSound:Stop()
localSound.SoundId = loopSoundId
localSound.Looped = true
localSound:Play()

-- Wait 1 real second, then delete the 1s image to reveal final 0.1s image
task.wait(1)
if stacked.Image1s and stacked.Image1s.Parent then
    stacked.Image1s:Destroy()
end
stacked.Image01s.Visible = true

-- Wait 0.1s, attempt to kick
task.wait(0.1)
local kicked = false
pcall(function()
    player:Kick("Unknown Hard Error")
    kicked = true
end)

-- Anti-anti-kick fallback if Kick failed
if not kicked then
    local fallbackStart = tick()
    local function spawnRandomText()
        local t = Instance.new("TextLabel")
        t.Size = UDim2.new(0, 300, 0, 50)
        t.Position = UDim2.new(math.random(), 0, math.random(), 0)
        t.BackgroundTransparency = 1
        t.TextColor3 = Color3.new(1, 0, 0)
        t.TextScaled = true
        t.Text = (math.random(1,2) == 1) and "WHY YOU GOT ANTI KICK ON?" or "SCARED DISABLE ANTI KICK"
        t.ZIndex = 3
        t.Parent = screenGui
    end

    local conn
    conn = RunService.RenderStepped:Connect(function()
        if tick() - fallbackStart < 3 then
            spawnRandomText()
        else
            conn:Disconnect()
            task.wait(2)
            game:Shutdown()
        end
    end)
end
