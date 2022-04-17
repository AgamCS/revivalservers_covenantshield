revivalservers_covShield.config = revivalservers_covShield.config or {}

if CLIENT then
    surface.CreateFont( "covShield_font", {
        font = "Trebuchet24",
        size = ScreenScale(8),
        antialias = true,
    } )
end


// shield entity settings
revivalservers_covShield.config.health = 800 // How much damage the shield asborbs before deactivating
revivalservers_covShield.config.activateDelay = 3 // How many seconds it takes for the shield to activate once it hits the ground. SHOULD ALWAYS BE GREATER THAN 0
revivalservers_covShield.config.pickupTime = 5 // How long, in seconds, it takes to pickup the shield
revivalservers_covShield.config.shieldRadius = 1500 // Raidus the owner needs to stay to keep the shield active
revivalservers_covShield.config.unstableColor = Color(255, 180, 212) // Color to set the entity the closer it reaches unstable. Set to nil to disable changing color
revivalservers_covShield.config.cancelActionVel = 50 // The velocity the player needs to reach to cancel picking up the shield
revivalservers_covShield.config.rechargeDelay = 8 // Time in seconds, for the shield to start recharging back to stable
revivalservers_covShield.config.rechargeTime = 9 // Time in seconds, for the shield to recharge from deactivated to stable

revivalservers_covShield.config.deactiveSounds = {
    "covenantshieldsounds/shielddeactivate1.wav",
    "covenantshieldsounds/shielddeactivate2.wav",
}

revivalservers_covShield.config.activateSounds = {
    "covenantshieldsounds/shieldactivate.wav",
}

for k, v in pairs(revivalservers_covShield.config.deactiveSounds) do
    util.PrecacheSound(v)
end
for k, v in pairs(revivalservers_covShield.config.activateSounds) do
    util.PrecacheSound(v)
end

// SWEP settings
revivalservers_covShield.config.throwForce = 300 // The force at which the player throws the shield entity
revivalservers_covShield.config.movementVelocityMod = 400 // How much addtional velocity the swep gets based on movement 


if CLIENT then
    // hud settings
    revivalservers_covShield.config.backgroundBarColor = Color(0, 0, 0, 200) // Color of the background bar that shows up when your picking up the shield
    revivalservers_covShield.config.foregroundBarColor = Color(145, 145, 145, 200) // Color of the background bar that shows up when your picking up the shield
end

if SERVER then
    resource.AddWorkshop(2795598871)
end