util.AddNetworkString("cov_shield_action")
util.AddNetworkString("cov_shield_cancelAction")

local cfg = revivalservers_covShield.config

function revivalservers_covShield.useShield(ply, entity)
    if !ply:IsValid() || !entity:IsValid() then return end
    local steamid = ply:SteamID64()
    entity:SetisGettingPickedup(true)
    net.Start("cov_shield_action")
        net.WriteEntity(entity)
    net.Send(ply)
    timer.Create(steamid .. " cov_shieldPickup", entity:GetPickupTime(), 1, function()
        timer.Remove(steamid .. " cov_shieldPickup")
        hook.Remove(covShield_cancelAction)
        SafeRemoveEntity(entity)
        ply:Give("weapon_covShield")
    end)
end

function revivalservers_covShield.cancelShield(ply)
    if !ply:IsValid() then return end
    local steamid = ply:SteamID64()
    net.Start("cov_shield_cancelAction")
    net.Send(ply)
    if timer.Exists(steamid .. " cov_shieldPickup") then
        timer.Remove(steamid .. " cov_shieldPickup")
    end
end

