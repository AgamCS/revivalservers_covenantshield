local cfg = revivalservers_covShield.config
net.Receive("cov_shield_action", function()
    local ent = net.ReadEntity()
    timer.Create("cov_shieldPickup", cfg.pickupTime, 1, function() hook.Remove("HUDPaint", "coventantShield_pickupTimer") timer.Remove("cov_shieldPickup") end)
    local startTime = CurTime()
    hook.Add("HUDPaint", "coventantShield_pickupTimer", function()
        local time = startTime + cfg.pickupTime - startTime
        local curtime = CurTime() - startTime
        local timeleft = math.Round( timer.TimeLeft( ("cov_shieldPickup"), 1) )
        local endtime = cfg.pickupTime - timeleft
        local scrw, scrh = ScrW(), ScrH()
        local x, y, width, height = scrw * 0.5 - scrw * 0.15, scrh * 0.8 - scrh * 0.05, scrw * 0.3, scrh * 0.07
        local status = math.Clamp(curtime / time, 0, 1)
        local barWidth = status * width - 16
        draw.RoundedBox(0, x, y, width, height, cfg.backgroundBarColor)
        draw.RoundedBox(0, x + 8, y + 7, barWidth, height * 0.2, cfg.foregroundBarColor )
        draw.SimpleText("PICKING UP SHIELD", "covShield_font", scrw * 0.5 , scrh * 0.8 - 20, color_white, 1, 1)
        draw.SimpleText(timeleft, "covShield_font", scrw * 0.5 , scrh * 0.8, color_white, 1, 1)
    end)
end)

net.Receive("cov_shield_cancelAction", function()
    hook.Remove("HUDPaint", "coventantShield_pickupTimer")
    if timer.Exists("cov_shieldPickup") then
        timer.Remove("cov_shieldPickup")
    end
end)

concommand.Add("getentpos", function(ply)
    local tr = ply:GetEyeTrace()
    if !tr.Entity then return end
    print(tr.Entity:GetClass())
    print(tr.Entity:GetLocalPos())

end)

concommand.Add("bullshit", function(ply)

    ply:EmitSound( "sound/covenantshieldsounds/shieldactivate.wav", 100, 1)
end)