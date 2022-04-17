include("shared.lua")
game.AddParticles("particles/covshieldspark.pcf")
PrecacheParticleSystem("covShieldSparks")

function ENT:Draw()
    self:DrawModel() 
end