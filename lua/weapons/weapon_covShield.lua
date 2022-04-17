SWEP.PrintName = "Covenant Shield"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Weight = 5
SWEP.SlotPos = 2
SWEP.Slot = 4
SWEP.DrawAmmo = false
SWEP.ViewModel = "models/hawksshield/weapons/c_covshield.mdl"
SWEP.WorldModel = "models/hawksshield/weapons/c_covshield.mdl"
SWEP.UseHands = true

SWEP.throwForce = 300
SWEP.movementVelocityMod = 150

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false



SWEP.HoldType = "pistol"

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
    self:SetDeploySpeed(self:SequenceDuration(1))
    self.throwForce = revivalservers_covShield.config.throwForce or self.throwForce
    self.movementVelocityMod = revivalservers_covShield.config.movementVelocityMod or self.movementVelocityMod
end

function SWEP:Deploy()
    self:SendWeaponAnim(ACT_VM_DRAW)
    self:SetSequence(1)
    print("dick" .. self:SequenceDuration(1))
    self:ResetSequence(1)
end

function SWEP:Equip()
    
end

function SWEP:PrimaryAttack()
    
    if !self:IsSequenceFinished() then return end
    self:throwShield()
end

function SWEP:throwShield()
    if !IsValid(self.Owner) then return end
    self:ResetSequence(2)
    self.Owner:SetAnimation( PLAYER_ATTACK1 )
    self:SetSequence(2) // fucked up sequence naming during model compile
    local seq = self:GetSequence()
    self:SendWeaponAnim(ACT_VM_RELOAD)// fucked up assigned the acts too
    if CLIENT then return end
    timer.Simple(self:SequenceDuration(seq), function()
        self:Deploy()
        local ent = ents.Create("cov_shield")
        if !ent:IsValid() then return end
        local eyeAng = self.Owner:EyeAngles()
        ent:SetPos(self.Owner:GetShootPos() + eyeAng:Forward() * 30)
        ent:SetAngles(eyeAng)
        ent.owner = self.Owner // Set owner in a variable since using the SetOwner function causes the spawned entity to have no collision
        ent:Spawn()
        ent:Activate()
        local phys = ent:GetPhysicsObject()
        if phys:IsValid() then
            phys:SetVelocity(self:getThrowVelocity(self.Owner, ent))
            //phys:AddAngleVelocity(Vector(-200, -200, -200))
        end
        //self.Owner:StripWeapon("weapon_covShield")
    end)
end

function SWEP:getThrowVelocity(player, throwable)
    local forward = player:EyeAngles():Forward()
    local runMod = math.Clamp(player:GetVelocity():Length() / player:GetRunSpeed(), 0, 1)

    local velocity = forward * self.throwForce
    local velNorm = player:GetVelocity():GetNormal()
    velocity = velocity + velNorm * self.movementVelocityMod * runMod
    velocity.z = 0
    return velocity
end