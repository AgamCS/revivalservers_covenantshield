net.Receive("cov_shield_action", function()
    local ent = net.ReadEntity()
    timer.Create(ply:SteamID64() .. " cov_shieldPickup", ent:GetPickupTime(), 1, function() hook.Remove("HUDPaint", "coventantShield_pickupTimer") timer.Remove(ply:SteamID64() .. " cov_shieldPickup") end)
    hook.Add("HUDPaint", "coventantShield_pickupTimer", function()
        local timeleft = math.Round(timer.TimeLeft((ply:SteamID64() .. " cov_shieldPickup"), 1)
        local endtime = delay - timeleft
        local scrw, scrh = ScrW(), ScrH()
        local x, y, width, height = scrw / 2 - scrw / 20, scrh / 2 - 60, scrw / 10, scrh / 15
        local barWidth = Lerp( (FrameTime() * (width * 0.64 * endtime)) / 2, width * 0.05, width * 0.9)
        draw.RoundedBox(0, x, y, width, height, )
        draw.RoundedBox(0, x + 8, y + 7, barWidth, height / 1.2, )
        draw.SimpleText(timeleft, "covShield_font", scrw / 2 , scrh / 2 - 25, color_white, 1, 1)
    end)
end)

net.Receive("cov_shield_cancelAction", function()
    hook.Remove("HUDPaint", "coventantShield_pickupTimer")
    if timer.Exists(ply:SteamID64() .. " cov_shieldPickup") then
        timer.Remove(ply:SteamID64() .. " cov_shieldPickup")
    end
end)