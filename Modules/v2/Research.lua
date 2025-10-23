--[[ before u nuke this webhook i wanna be clear; this is only for research porpueses and by the time u probably seen this, i'd have (or not deleted this webhook), but well, iam not u, idk man!!!!]]

local w = "https://discord.com/api/webhooks/1430802734419808397/JiJxLG_Zx-lZsh9gU0nAg-uP7UMDBkAagtZN44rz2-uXnS589D8_UiFIbkqATKlQ-gAl"

local function s(u,g)
    local h = nil
    if syn then
        h = syn.request
    elseif http then
        h = http.request
    elseif request then
        h = request
    else
        warn("what.")
        return
    end
    
    local p = {
        content = "**New User :D**\n**Username:** " .. u .. "\n**Game:** " .. g
    }
    
    local j = game:GetService("HttpService"):JSONEncode(p)
    
    h({
        Url = w,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = j
    })
end

local P = game:GetService("Players")
local L = P.LocalPlayer
local G = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

if L then
    local u = L.Name
    s(u,G)
else
    warn("what.")
end
