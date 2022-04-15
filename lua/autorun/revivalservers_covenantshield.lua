
revivalservers_covShield = revivalservers_covShield or {
}

local function addDir(path)
    local files, folders = file.Find(path .. "*", "LUA")
        for k, v in pairs(files) do
            print(path .. v)
            if string.StartWith(v, "sh_") then
                if SERVER then
                    AddCSLuaFile(path .. v)
                end
                include(path .. v)
            elseif string.StartWith(v, "sv_") then
                include(path .. v)
            elseif  string.StartWith(v, "cl_") then
                if SERVER then
                    AddCSLuaFile(path .. v)
                elseif CLIENT then
                    include(path .. v)
                end
            end
        end
end

addDir("revivalservers_covenantshield/")

if CLIENT then
    resource.AddFile("models/hawksshield/hawksshield.mdl")
end