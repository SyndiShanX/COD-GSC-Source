CoD.DeathCamUtility = {}
CoD.DeathCamUtility.SetKilledByPlayerVisuals = function(f1_arg0, f1_arg1)
	local f1_local0 = Engine[@"getmodelforcontroller"](f1_arg1)
	local f1_local1 = Engine[@"hash_5AE220DAFBDFDE77"](f1_arg1, f1_local0.hudItems.killedByEntNum:get())
	if f1_local1 ~= nil then
		local f1_local2 = f1_local1.xuid
		local f1_local3 = f1_local1.bgName
		if f1_arg0.CallingCardImage and f1_local3 and f1_arg0.CallingCardImage.CardIcon then
			f1_arg0.CallingCardImage.CardIcon:setImage(RegisterImage(f1_local3))
		end
		if f1_arg0.PlayerEmblem then
			f1_arg0.PlayerEmblem:setupPlayerEmblemByXUID(f1_local2)
		end
	end
end
CoD.DeathCamUtility.KilledByMODToDeathType = function(f2_arg0)
	if f2_arg0 == Enum[@"meansofdeath_t"][@"mod_suicide"] then
		return @"hash_3D0E5B5C9D0495F7"
	elseif f2_arg0 == Enum[@"meansofdeath_t"][@"mod_unknown"] then
		return @"hash_76CFB04CB56063A"
	else
		return @"hash_5384588C2F4949A5"
	end
end
CoD.DeathCamUtility.KilledByMOD_UnkownToAlpha = function(f3_arg0)
	if f3_arg0 == Enum[@"meansofdeath_t"][@"mod_unknown"] then
		return 0
	else
		return 1
	end
end
CoD.DeathCamUtility.KilledByMODToAlphaInSpawnSelect = function(f4_arg0)
	if f4_arg0 == Enum[@"meansofdeath_t"][@"mod_unknown"] or f4_arg0 == Enum[@"meansofdeath_t"][@"mod_suicide"] or f4_arg0 == Enum[@"meansofdeath_t"][@"mod_meta"] then
		return 1
	else
		return 0
	end
end
CoD.DeathCamUtility.InDeathCamShouldHidePlayerCard = function(f5_arg0)
	local f5_local0 = Engine[@"getmodelforcontroller"](f5_arg0)
	local f5_local1 = f5_local0.hudItems.killedByMOD:get()
	local f5_local2
	if f5_local1 ~= Enum[@"meansofdeath_t"][@"mod_unknown"] and f5_local1 ~= Enum[@"meansofdeath_t"][@"mod_suicide"] then
		f5_local2 = false
	else
		f5_local2 = true
	end
	if f5_local2 then
		return true
	else
		return false
	end
end
