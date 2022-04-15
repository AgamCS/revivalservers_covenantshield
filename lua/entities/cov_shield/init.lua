
include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

local cfg = revivalservers_covSheild.cfg

function ENT:Initialize()
    self:SetModel("models/hawksshield/hawksshield.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self.raidus = cfg.shieldRadius * cfg.shieldRadius
    self.unstableColor = cfg.unstableColor
    self.state = "stable"

    local phys = self:GetPhysicsObject()
    print(phys:IsValid())
    if phys:IsValid() then
        phys:Wake()
    end
    
end

function ENT:Use(activator, caller)
    local owner = self:GetOwner()
    if activator != owner then return end 
    self:SetisGettingPickedup(true)
    revivalservers_covSheild.UseShield(self, owner)
end

function ENT:OnTakeDamage( dmginfo )
	if ( not self.m_bApplyingDamage ) then
		self.m_bApplyingDamage = true
		self:TakeDamageInfo( dmginfo )
		self.m_bApplyingDamage = false
        if self:Health() >= self:GetMaxHealth() * 0.25 then
            self:SetColor(self.unstableColor)
        end
	end
end

function ENT:SetupDataTables()
    self:NetworkVar( "Int", cfg.pickupTime, "PickupTime" )
    self:NetworkVar("Bool", false, "isGettingPickedup")
end

function ENT:Think()
    if self:GetOwner():GetPos():DistToSqr(self:GetPos()) > self.raidus then
        SafeRemoveEntity(self)
    end
end