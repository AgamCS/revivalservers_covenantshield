SWEP.PrintName = "Covenant Shield"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Weight = 5
SWEP.SlotPos = 2
SWEP.Slot = 4
SWEP.DrawAmmo = false
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"


SWEP.throwVelocity = 60

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false



SWEP.HoldType = "slam"

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
    self.throwVelocity = revivalservers_covShield.cfg.throwVelocity
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire( CurTime() + 3 )	
    self:throwShield()
end

function SWEP:throwShield()
    if !IsValid(self.Owner) then return end

    if CLIENT then return end
    local ent = ents.Create("cov_shield")
    if !ent:IsValid() then return end
    ent:SetOwner(self.Owner)
    local aimvec = self.Owner:GetAimVector()
	local pos = aimvec * 16
	pos:Add(self.Owner:EyePos())
    
    ent:SetPos(pos)
    ent:SetAngles(self.Owner:EyeAngles())
    ent:Spawn()

    local phys = ent:GetPhysicsObject()
    if not phys:IsValid() then ent:Remove() return end
    aimvec:Mul(self.throwVelocity)
    aimvec:Add(VectorRand(-10, 10))
    phys:AddForceCenter(aimvec)
    self.Owner:StripWeapon("weapon_covShield")
end