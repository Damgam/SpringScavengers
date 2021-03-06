function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- special tablemerge:
-- converts value string 'nil' to an actual nil
-- normally an empty table as value will be ignored when merging, but not here, it will overwrite what it had with an empty table
function tableMergeSpecial(t1, t2)
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if next(v) == nil then
                t1[k] = v
            else
                if type(t1[k] or false) == "table" then
                    tableMergeSpecial(t1[k] or {}, t2[k] or {})
                else
                    t1[k] = v
                end
            end
        else
            t1[k] = v
        end
    end
    return t1
end


-- create scavenger units
VFS.Include("gamedata/scavengers/unitdef_changes.lua")
local scavengerUnitDefs = {}

for name,uDef in pairs(UnitDefs) do
	local faction = string.sub(name, 1, 3)
	if not string.find(name, '_scav') then
		if customDefs[name] ~= nil then
			scavengerUnitDefs[name..'_scav'] = tableMergeSpecial(deepcopy(uDef), deepcopy(customDefs[name]))
		else
			scavengerUnitDefs[name..'_scav'] = deepcopy(uDef)
		end
	end
end
for name,ud in pairs(scavengerUnitDefs) do
	UnitDefs[name] = ud
end