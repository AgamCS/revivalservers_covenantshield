ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Covenant Shield"

ENT.Spawnable = true
ENT.AdminSpawnable = true 
function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "PickupTime" )
    self:NetworkVar("Bool", 0, "isGettingPickedup")
    self:SetPickupTime(revivalservers_covShield.config.pickupTime)
    self:SetisGettingPickedup(false)
end

ENT.deactivateSounds = revivalservers_covShield.config.deactiveSounds
ENT.activateSounds = revivalservers_covShield.config.activateSounds