surface.CreateFont( "covShield_font", {
	font = "Trebuchet24",
	size = ScreenScale(6),
	antialias = true,
} )



// shield entity settings
revivalservers_covSheild.cfg.health = 400 // How much damage the shield asborbs before deactivating
revivalservers_covSheild.cfg.pickupTime = 5 // How long, in seconds, it takes to pickup the shield
revivalservers_covSheild.cfg.shieldRadius = 150 // Raidus the owner needs to stay to keep the shield active
revivalservers_covSheild.cfg.unstableColor = Color(255, 180, 212) // Color to set the entity to when it goes unstable. Set to nil to disable changing colors
revivalservers_covShield.cfg.cancelActionVel = 50 // The velocity the player needs to reach to cancel picking up the shield

revivalservers_covShield.cfg.throwVelocity = 10 // The velocity at which the player throws the shield entity

// hud settings
revivalservers_covShield.cfg.backgroundBarColor = Color(0, 0, 0, 200) // Color of the background bar that shows up when your picking up the shield
revivalservers_covShield.cfg.foregroundBarColor = Color(97, 97, 97, 200) // Color of the background bar that shows up when your picking up the shield