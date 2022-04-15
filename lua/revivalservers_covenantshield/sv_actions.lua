util.AddNetworkString("cov_shield_action")
util.AddNetworkString("cov_shield_cancelAction")
function revivalservers_covShield.UseShield(ply, entity)
    if !IsValid(ply) || !entity:IsValid() then return end
    net.Start("cov_shield_action")
        net.WriteEntity(entity)
    net.Send(ply)
    timer.Create(ply:SteamID64() .. " cov_shieldPickup", entity:GetPickupTime(), 1, function()
        ply.isPickingUpShield = false
        SafeRemoveEntity(entity)
        ply:Give("weapon_covShield")
        timer.Remove(ply:SteamID64() .. " cov_shieldPickup")
    end)
    --[[hook.Add("Move", "covShield_cancelAction", function(pl, mv)
        if pl != ply || !entiy:GetisGettingPickedup() then return end
        if  ( ( mv:GetVelocity() > revivalservers_covShield.config.cancelActionVel ) || ( pl:GetPos():DistToSqr(entity:GetPos()) > entity.raidus ) ) && ( timer.Exists(ply:SteamID64() .. " cov_shieldPickup") ) then
            timer.Remove(ply:SteamID64() .. " cov_shieldPickup")
            net.Start("cov_shield_cancelAction")
            net.Send(ply)
        end
    end)--]]    
end