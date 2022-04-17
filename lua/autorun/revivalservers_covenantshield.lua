
revivalservers_covShield = revivalservers_covShield or {
}

local function addDir(path)
    local files, folders = file.Find(path .. "*", "LUA")
        for k, v in pairs(files) do
            if string.StartWith(v, "sh_") then
                if SERVER then
                    AddCSLuaFile(path .. v)
                    print("Added CS File:" .. path..v)
                end
                include(path .. v)
            elseif string.StartWith(v, "sv_") then
                include(path .. v)
                print("Added SV File:" .. path..v)
            elseif  string.StartWith(v, "cl_") then
                if SERVER then
                    AddCSLuaFile(path .. v)
                    print("Added CS File:" .. path..v)
                elseif CLIENT then
                    include(path .. v)
                    print("Added SV File:" .. path..v)
                end
            end
        end
end

addDir("revivalservers_covenantshield/config/")
addDir("revivalservers_covenantshield/cleanup/")
addDir("revivalservers_covenantshield/actions/")


resource.AddFile("models/hawksshield/hawksshield.mdl")
resource.AddFile("models/hawksshield/hawksshieldgib.mdl")
resource.AddFile("sound/covenantshieldsounds/shieldactivate.mp3")
resource.AddFile("sound/covenantshieldsounds/shielddeactivate1.mp3")
resource.AddFile("sound/covenantshieldsounds/shielddeactivate2.mp3")
resource.AddFile("sound/covenantshieldsounds/shielddeactivate3.mp3")
