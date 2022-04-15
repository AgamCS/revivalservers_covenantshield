revivalservers_covShield.config = revivalservers_covShield.config or {}

if CLIENT then
    surface.CreateFont( "covShield_font", {
        font = "Trebuchet24",
        size = ScreenScale(6),
        antialias = true,
    } )
end


// shield entity settings
revivalservers_covShield.config.health = 400 // How much damage the shield asborbs before deactivating
revivalservers_covShield.config.pickupTime = 5 // How long, in seconds, it takes to pickup the shield
revivalservers_covShield.config.shieldRadius = 150 // Raidus the owner needs to stay to keep the shield active
revivalservers_covShield.config.unstableColor = Color(255, 180, 212) // Color to set the entity the closer it reaches unstable. Set to nil to disable changing color
revivalservers_covShield.config.cancelActionVel = 50 // The velocity the player needs to reach to cancel picking up the shield
revivalservers_covShield.config.rechargeDelay = 8 // Time in seconds, for the shield to start recharging back to stable
revivalservers_covShield.config.rechargeTime = 9 // Time in seconds, for the shield to recharge from deactivated to stable
revivalservers_covShield.config.throwVelocity = 10 // The velocity at which the player throws the shield entity


if CLIENT then
    // hud settings
    revivalservers_covShield.config.backgroundBarColor = Color(0, 0, 0, 200) // Color of the background bar that shows up when your picking up the shield
    revivalservers_covShield.config.foregroundBarColor = Color(97, 97, 97, 200) // Color of the background bar that shows up when your picking up the shield
end