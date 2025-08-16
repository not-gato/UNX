-- p.s.: will be updated soon.

local plr = game.Players.LocalPlayer

local function KickPlayer(title, reason)
    pcall(function()
        if game.CoreGui:FindFirstChild("UNXHubUI") then
            game.CoreGui.UNXHubUI:Destroy()
        end
    end)
    print("[API]: " .. reason)
    plr:Kick(title .. "\n\n" .. reason)
end

local BannedUsers = {
    {UserId = 1, Reason = "Hi Roblox Big Fan"},
}

local BannedGames = {
    {PlaceId = 4924922222, Reason = "Please get your stinky Brookhaven out of here."}
}

for _, banInfo in ipairs(BannedUsers) do
    if plr.UserId == banInfo.UserId then
        KickPlayer("UNXHub | Banned",
            "Sorry, but you are banned from using the main loadstring.\nReason: " .. banInfo.Reason)
        return
    end
end

for _, banInfo in ipairs(BannedGames) do
    if game.PlaceId == banInfo.PlaceId then
        KickPlayer("UNXHub | Game Blocked",
            "Sorry, but the game you are playing is banned from using UNXHub.\nReason: " .. banInfo.Reason)
        return
    end
end

print("[API]: All checks done. User is not banned and the game is not restricted.")
