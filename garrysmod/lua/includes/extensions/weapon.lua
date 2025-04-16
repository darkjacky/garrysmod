
AddCSLuaFile()

local meta		= FindMetaTable( "Weapon" )
local entity	= FindMetaTable( "Entity" )

-- Return if there's nothing to add on to
if ( !meta ) then return end

--
-- Cache entity.GetTable for even faster access
--
local WeaponTable = setmetatable( {}, {
	__index = function( tab, wep )
		local var = entity.GetTable( wep )
		tab[ wep ] = var
		return var
	end,
	__mode = "k"
} )

--
-- Entity index accessor. This used to be done in engine, but it's done in Lua now because it's faster
--
function meta:__index( key )
	return meta[ key ] or entity[ key ] or (key == "Owner" and entity.GetOwner( self )) or WeaponTable[ self ][ key ]
end

