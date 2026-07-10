CoD.CustomizePrestigeIconUtility = {}
CoD.CustomizePrestigeIconUtility.EnumToTitleOfOriginReference = {
	[Enum[@"hash_79FC886F1051643D"][@"hash_5FF5BE10FB81F955"]] = @"hash_53084C0B4B7FA50E",
	[Enum[@"hash_79FC886F1051643D"][@"hash_6CBFFF10B9836E8A"]] = @"hash_365F335C6AD9ECBF",
	[Enum[@"hash_79FC886F1051643D"][@"hash_6CBFFE10B9836CD7"]] = @"hash_726BB081E7478964",
	[Enum[@"hash_79FC886F1051643D"][@"hash_6CBFFD10B9836B24"]] = 0x11466A69356809,
	[Enum[@"hash_79FC886F1051643D"][@"hash_6CBFFC10B9836971"]] = @"hash_2A305FE1CC49405E",
}
CoD.CustomizePrestigeIconUtility.RankToRankRequirementString = function(f1_arg0)
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_477FA9225157D3F4", f1_arg0)
end
CoD.CustomizePrestigeIconUtility.EnumToTitleOfOriginString = function(f2_arg0)
	local f2_local0 = CoD.CustomizePrestigeIconUtility.EnumToTitleOfOriginReference[f2_arg0]
	local f2_local1
	if f2_local0 then
		f2_local1 = Engine[@"hash_4F9F1239CFD921FE"](f2_local0)
		if not f2_local1 then
		else
			return f2_local1
		end
	end
	f2_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2C79EA24AB1A2BA")
end
CoD.CustomizePrestigeIconUtility.IsIconUnlockedByWins = function(f3_arg0, f3_arg1)
	local f3_local0
	if f3_arg1 and f3_arg1 > f3_arg0 then
		f3_local0 = false
	else
		f3_local0 = true
	end
	return f3_local0
end
CoD.CustomizePrestigeIconUtility.IsIconUnlockedByLevel = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	if f4_arg4 == Enum[@"emodes"][@"mode_warzone"] then
		return f4_arg0 and f4_arg2 <= f4_arg1 + 1
	end
	local f4_local0 = f4_arg0
	local f4_local1
	if f4_arg2 > f4_arg1 + 1 and f4_arg3 ~= Enum[@"hash_79FC886F1051643D"][@"hash_6CBFFC10B9836971"] then
		f4_local1 = false
	else
		f4_local1 = f4_local0 and true
	end
	return f4_local1
end
CoD.CustomizePrestigeIconUtility.GetCurrentWins = function(f5_arg0, f5_arg1)
	local f5_local0 = 0
	if f5_arg1 == Enum[@"emodes"][@"mode_warzone"] then
		local f5_local1 = CoD.GetCurrentPlayerStats(f5_arg0)
		if f5_local1 then
			for f5_local5, f5_local6 in pairs(CoD.GameTypeUtility.GetAllGameModes(Enum[@"emodes"][@"mode_warzone"])) do
				local f5_local7 = f5_local1.PlayerStatsByGameType[f5_local6].WINS.StatValue:get()
				if f5_local0 < f5_local7 then
					f5_local0 = f5_local7
				end
			end
		end
	end
	return f5_local0
end
CoD.CustomizePrestigeIconUtility.IsIconUnlocked = function(f6_arg0, f6_arg1)
	return CoD.CustomizePrestigeIconUtility.IsIconUnlockedByLevel(f6_local3, f6_local2, f6_local1.unlockLevel, f6_local1.titleOfOrigin) and CoD.CustomizePrestigeIconUtility.IsIconUnlockedByWins(f6_local4, f6_local1.winsRequired)
end
CoD.CustomizePrestigeIconUtility.GetCurrentParagonIconId = function(f7_arg0, f7_arg1)
	if f7_arg1 == Enum[@"emodes"][@"mode_multiplayer"] then
		local f7_local0 = Engine[@"storagegetbuffer"](f7_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		if f7_local0 and f7_local0.prestige_icon_id then
			return f7_local0.prestige_icon_id:get()
		end
	elseif f7_arg1 == Enum[@"emodes"][@"mode_zombies"] then
		local f7_local0 = Engine[@"storagegetbuffer"](f7_arg0, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
		if f7_local0 and f7_local0.prestige_icon_id then
			return f7_local0.prestige_icon_id:get()
		end
	elseif f7_arg1 == Enum[@"emodes"][@"mode_warzone"] then
		local f7_local0 = Engine[@"storagegetbuffer"](f7_arg0, Enum[@"storagefiletype"][@"storage_wz_stats_online"])
		if f7_local0 and f7_local0.prestige_icon_id then
			return f7_local0.prestige_icon_id:get()
		end
	end
	return nil
end
CoD.CustomizePrestigeIconUtility.InitializeCustomizePrestigeIconMenu = function(f8_arg0, f8_arg1, f8_arg2) end
CoD.CustomizePrestigeIconUtility.PrestigeIconSelected = function(f9_arg0, f9_arg1, f9_arg2)
	local f9_local0 = f9_arg1:getModel()
	f9_local0 = f9_local0:create("iconId")
	f9_local0 = f9_local0:get()
	if f9_local0 and CoD.CustomizePrestigeIconUtility.IsIconUnlocked(f9_arg2, f9_local0) then
		PlaySoundAlias("cac_equipment_add")
		local f9_local1 = CoD.PrestigeUtility.GetPrestigeGameMode()
		local f9_local2 = nil
		if f9_local1 == Enum[@"emodes"][@"mode_multiplayer"] then
			f9_local2 = Enum[@"storagefiletype"][@"storage_mp_stats_online"]
		elseif f9_local1 == Enum[@"emodes"][@"mode_zombies"] then
			f9_local2 = Enum[@"storagefiletype"][@"storage_zm_stats_online"]
		elseif f9_local1 == Enum[@"emodes"][@"mode_warzone"] then
			f9_local2 = Enum[@"storagefiletype"][@"storage_wz_stats_online"]
		end
		if f9_local2 ~= nil then
			local f9_local3 = Engine[@"storagegetbuffer"](f9_arg2, f9_local2)
			if f9_local3 and f9_local3.prestige_icon_id then
				f9_local3.prestige_icon_id:set(f9_local0)
				Engine[@"storagewrite"](f9_arg2, f9_local2)
				local f9_local4 = DataSources.PrestigeMenuInfo.getModel(f9_arg2)
				f9_local4.hasPrestiged:set(true)
			end
		end
	end
end
CoD.CustomizePrestigeIconUtility.GetCustomizePrestigeIconMenuTitleString = function(f10_arg0)
	if CoD.PrestigeUtility.GetPrestigeGameMode() == Enum[@"emodes"][@"mode_warzone"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_23E0FFE995FC055D")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7754A8D073F00C06")
	end
end
DataSources.PrestigeIcon = ListHelper_SetupDataSource("PrestigeIcon", function(f11_arg0)
	local f11_local0 = {}
	local f11_local1 = CoD.PrestigeUtility.GetPrestigeGameMode()
	local f11_local2 = Engine[@"getparagonicontable"](f11_local1)
	local f11_local3 = CoD.PrestigeUtility.GetCurrentLevel(f11_arg0, f11_local1)
	local f11_local4 = CoD.PrestigeUtility.GetPrestigeCap(f11_local1) <= CoD.PrestigeUtility.GetCurrentPLevel(f11_arg0, f11_local1)
	local f11_local5 = CoD.CustomizePrestigeIconUtility.GetCurrentWins(f11_arg0, f11_local1)
	local f11_local6 = CoD.CustomizePrestigeIconUtility.GetCurrentParagonIconId(f11_arg0, f11_local1)
	if f11_local2 and f11_local2.icons and #f11_local2.icons > 0 then
		for f11_local11, f11_local12 in ipairs(f11_local2.icons) do
			local f11_local13 = table.insert
			local f11_local14 = f11_local0
			local f11_local15 = {}
			local f11_local16 = {
				iconId = f11_local12.iconId,
				iconImage = f11_local12.iconNameLarge,
				iconName = f11_local12.displayName,
				iconOriginString = CoD.CustomizePrestigeIconUtility.EnumToTitleOfOriginString(f11_local12.titleOfOrigin),
				rankRequirementString = CoD.CustomizePrestigeIconUtility.RankToRankRequirementString(f11_local12.unlockLevel),
			}
			local f11_local10
			if CoD.CustomizePrestigeIconUtility.IsIconUnlockedByLevel(f11_local4, f11_local3, f11_local12.unlockLevel, f11_local1) then
				f11_local10 = not CoD.CustomizePrestigeIconUtility.IsIconUnlockedByWins(f11_local5, f11_local12.winsRequired)
			else
				f11_local10 = true
			end
			f11_local16.isLocked = f11_local10
			f11_local16.isEquipped = f11_local6 == f11_local12.iconId
			f11_local16.isLockedByWins = not CoD.CustomizePrestigeIconUtility.IsIconUnlockedByWins(f11_local5, f11_local12.winsRequired)
			f11_local15.models = f11_local16
			f11_local13(f11_local14, f11_local15)
		end
	end
	return f11_local0
end, true)
