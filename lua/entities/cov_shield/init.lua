
include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

function ENT:Initialize()
    self:SetModel("models/hawksshield/hawksshield.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_BBOX)
    self:SetUseType(SIMPLE_USE)
    self.raidus = revivalservers_covShield.config.shieldRadius * revivalservers_covShield.config.shieldRadius
    self.unstableColor = revivalservers_covShield.config.unstableColor
    self.state = "stable"
    self.nextRecharge = 0

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
        print(self:GetCollisionBounds())
    end
    
end

function ENT:SetupDataTables()
    self:NetworkVar( "Int", 0, "PickupTime" )
    self:NetworkVar("Bool", 0, "isGettingPickedup")
    self:SetPickupTime(revivalservers_covShield.config.pickupTime)
    self:SetisGettingPickedup(false)
end

function ENT:Use(activator, caller)
    
    local owner = self:GetOwner()
    if activator != owner then return end 
    if activator:KeyDown(IN_WALK) then return end
    revivalservers_covShield.UseShield(owner, self)
end

function ENT:OnTakeDamage( dmginfo )
	if self.m_bApplyingDamage then return end
    local health, maxhealth = self:Health(), self:GetMaxHealth()
    self.m_bApplyingDamage = true
    self:TakeDamageInfo( dmginfo )
    self.m_bApplyingDamage = false
    if !revivalservers_covShield.config.unstableColor then return end
    self:SetColor(LerpColor(health/maxhealth, self:GetColor(), revivalservers_covShield.config.unstableColor))
	self.nextRecharge = CurTime() + revivalservers_covShield.config.rechargeTime
end



function ENT:Think()
    if !self:IsValid() then return end
    local health = self:checkForRecharge()
    if health then
        self:SetHealth(health)
    end
    if self:GetOwner():GetPos():DistToSqr(self:GetPos()) > self.raidus then
        SafeRemoveEntity(self)
    end
end

function ENT:checkForRecharge()
    if self.nextRecharge > CurTime() then return false end
    local health = Lerp(revivalservers_covShield.config.rechargeTime / FrameTime(), self:Health(), self:GetMaxHealth())
    return health
end

local function LerpColor(frac,from,to)
	local col = Color(
		Lerp(frac,from.r,to.r),
		Lerp(frac,from.g,to.g),
		Lerp(frac,from.b,to.b),
		Lerp(frac,from.a,to.a)
	)
    print(col)
	return col
end