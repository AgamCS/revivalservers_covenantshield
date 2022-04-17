local PLAYER = FindMetaTable("Player")

PLAYER.covShields = {}

hook.Add("PlayerDisconnected", "covShield_cleanup", function(ply)
    for k, v in pairs(ply.covShields) do
        SafeRemoveEntity(v)
    end
end)

