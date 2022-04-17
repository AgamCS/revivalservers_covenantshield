AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

game.AddParticles("particles/covshieldspark.pcf")
PrecacheParticleSystem("covShieldSpark")

function ENT:Initialize()
    self:SetModel("models/hawksshield/hawkshieldgib.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:SetUseType(SIMPLE_USE)
    self:SetMaxHealth(revivalservers_covShield.config.health)
    self:SetHealth(revivalservers_covShield.config.health)
    self.raidus = revivalservers_covShield.config.shieldRadius * revivalservers_covShield.config.shieldRadius
    self.unstableColor = revivalservers_covShield.config.unstableColor
    self.rechargeDelay = revivalservers_covShield.config.rechargeDelay
    self.rechargeTime = revivalservers_covShield.config.rechargeTime
    self.nextRecharge = 0
    table.insert(self.owner.covShields, self)
    self:delayResetAngles(1)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    
    if activator != self.owner then return end 
    if activator:KeyDown(IN_WALK) then return end
    revivalservers_covShield.useShield(self.owner, self)
end

function ENT:OnTakeDamage( dmginfo )
    self:SetHealth(self:Health() - dmginfo:GetDamage())
    if !self.unstableColor then return end
    local newCol = LerpColor(1 - self:Health()/self:GetMaxHealth(), self:GetColor(), self.unstableColor)
    self:SetColor(newCol)
	self.nextRecharge = CurTime() + self.rechargeDelay
    if self:Health() <= 0 then
        ParticleEffect("covShieldSparks", self:GetPos(), self:GetAngles(), self)
        local bug = self.deactivateSounds[math.random(1, #self.deactivateSounds)]
        self:EmitSound(bug, 100, 100, 1)
        print(bug)
        self:SetModel("models/hawksshield/hawkshieldgib.mdl")
        SafeRemoveEntityDelayed(self, 60)
    end
end

function ENT:Think()
    if !self:IsValid() then return end
    local recharge = self:checkForRecharge()
    
    if recharge then
        local healamount = math.Clamp(self:Health() + recharge, 0, self:GetMaxHealth())
        self:SetHealth(healamount)
        local clr = LerpColor(self:Health()/self:GetMaxHealth(), self:GetColor(), color_white)
        self:SetColor(clr)
    end
    if !self.owner then return end
    local vel = self.owner:GetVelocity()
    if (vel.x > 50 || vel.y > 50) && (self:GetisGettingPickedup()) then
        revivalservers_covShield.cancelShield(self.owner, self)
    end
    if self.owner:GetPos():DistToSqr(self:GetPos()) > self.raidus then
        SafeRemoveEntity(self)
    end
end

function ENT:checkForRecharge()
    if self.nextRecharge > CurTime() then return false end
    local health = self:GetMaxHealth() / self.rechargeTime
    
    return health
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

function ENT:delayResetAngles(delay)
    local endTime = CurTime() + delay
    local forward = self.owner:EyeAngles()
    hook.Add("Think", self:EntIndex() .. "covShieldUpRightTime", function()
        if !self:IsValid() then hook.Remove("Think", self:EntIndex() .. "covShieldUpRightTime") return end
        if CurTime() < endTime then return end
        local vel = self:GetVelocity()
        if vel.x > 0 || vel.y > 0 || vel.z > 0 then return end
        self:SetCollisionGroup(COLLISION_GROUP_NONE)
        self:SetAngles(Angle(0, forward.y, 0))
        self:SetModel("models/hawksshield/hawksshield.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:EmitSound(self.activateSounds[math.random(1, #self.activateSounds)], 100, 100, 1)
        hook.Remove("Think", self:EntIndex() .. "covShieldUpRightTime")
    end)
end

scripted_ents.Register( ENT, "cov_shield" )