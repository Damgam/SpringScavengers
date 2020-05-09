function UnitDef_Post(name, uDef)
	if string.find(name, '_scav') then
		VFS.Include("gamedata/scavengers/unitdef_post.lua")
		uDef = scav_Udef_Post(name, uDef)
	end
end

function WeaponDef_Post(name, wDef)
	if string.find(name, '_scav') then
		VFS.Include("gamedata/scavengers/weapondef_post.lua")
		wDef = scav_Wdef_Post(name, wDef)
	end
end

