
revivalservers_covShield = revivalservers_covShield or {
    cfg = {}
}

local function addDir(path)
    local files, folders = file.Find(path .. "*", "LUA")
        for k, v in pairs(files) do
            if string.StartWith(v, "sh_") then
                if SERVER then
                    AddCSLuaFile(v)
                end
                include(v)
            elseif string.StartWith(v, "sv_") then
                include(v)
            elseif  string.StartWith(v, "cl_") then
                if SERVER then
                    AddCSLuaFile(v)
                elseif CLIENT then
                    include(v)
                end
            end
        end
end

addDir("revivalservers_covenantshield")

if CLIENT then
    resource.AddFile("models/hawksshield/hawksshield.mdl")
end