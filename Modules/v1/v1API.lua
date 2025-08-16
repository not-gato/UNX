-- Old UNXHub "API"

local plr = game.Players.LocalPlayer
local KickService = loadstring(game:HttpGet("https://raw.githubusercontent.com/uHeyCaf/UNX/refs/heads/main/Modules/v1/KickService.lua"))()

local BannedUsers = {
    {UserId = 1, Reason = "Hi Roblox Big Fan"},
}

local BannedGames = {
    {PlaceId = 4924922222, Reason = "Please get your stinky Brookhaven out of here."}
}

for _, banInfo in ipairs(BannedUsers) do
    if plr.UserId == banInfo.UserId then
        pcall(function() game.CoreGui.UNXHubUI:Destroy() end)
        print("[API]: User is banned from using UNXHub. Reason: " .. banInfo.Reason)
        KickService:CallKick("UNXHub | Banned", "Sorry, but you are banned from using the main loadstring.\nReason: " .. banInfo.Reason, "1")
        return
    end
end

for _, banInfo in ipairs(BannedGames) do
    if game.PlaceId == banInfo.PlaceId then
        pcall(function() game.CoreGui.UNXHubUI:Destroy() end)
        print("[API]: Game is banned from using UNXHub. Reason: " .. banInfo.Reason)
        KickService:CallKick("UNXHub | Game Blocked", "Sorry, but the game you are playing is banned from using UNXHub.\nReason: " .. banInfo.Reason, "2")
        return
    end
end

print("[API]: All checks done. User is not banned and the game is not restricted.")
