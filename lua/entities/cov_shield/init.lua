
include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

function ENT:Initialize()
    self:SetModel("models/hawksshield/hawksshield.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    --self.raidus = revivalservers_covShield.config.shieldRadius * revivalservers_covShield.config.shieldRadius
    --self.unstableColor = revivalservers_covShield.config.unstableColor
    self.state = "stable"
    --print(self.radius)
    local phys = self:GetPhysicsObject()
    print("phys" .. tostring(phys:IsValid()))
    PrintTable(revivalservers_covShield)
    if phys:IsValid() then
        phys:Wake()
    end
    
end

function ENT:Use(activator, caller)
    
    local owner = self:GetOwner()
    if activator != owner then return end 
    if activator:KeyDown(IN_WALK) then return end
    self:SetisGettingPickedup(true)
    revivalservers_covShield.UseShield(self, owner)
end

function ENT:OnTakeDamage( dmginfo )
	if self.m_bApplyingDamage then return end
    local health, maxhealth = self:Health(), self:GetMaxHealth()
    self.m_bApplyingDamage = true
    self:TakeDamageInfo( dmginfo )
    self.m_bApplyingDamage = false
    if !revivalservers_covShield.config.unstableColor then return end
    self:SetColor(LerpColor(health/maxhealth, self:GetColor(), revivalservers_covShield.config.unstableColor)

	
end

function ENT:SetupDataTables()
    self:NetworkVar( "Int", revivalservers_covShield.config.pickupTime, "PickupTime" )
    self:NetworkVar("Bool", false, "isGettingPickedup")
end

function ENT:Think()
    --print( self:GetOwner():GetPos():DistToSqr(self:GetPos()) )
    --[[if self:GetOwner():GetPos():DistToSqr(self:GetPos()) > self.raidus then
        SafeRemoveEntity(self)
    end--]]
end

local function LerpColor(frac,from,to)
	local col = Color(
		Lerp(frac,from.r,to.r),
		Lerp(frac,from.g,to.g),
		Lerp(frac,from.b,to.b),
		Lerp(frac,from.a,to.a)
	)
	return col
end