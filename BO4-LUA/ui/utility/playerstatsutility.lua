CoD.PlayerStatsUtility = {}
CoD.PlayerStatsUtility.WZGameModeDisplayType = {
	ALL = 1,
	SOLO = 2,
	DUOS = 3,
	QUADS = 4,
	LTM = 5,
}
CoD.PlayerStatsUtility.WZGameModeFilterNameTable = {
	[CoD.PlayerStatsUtility.WZGameModeDisplayType.ALL] = @"menu/all",
	[CoD.PlayerStatsUtility.WZGameModeDisplayType.SOLO] = @"mpui/solo",
	[CoD.PlayerStatsUtility.WZGameModeDisplayType.DUOS] = @"mpui/duos",
	[CoD.PlayerStatsUtility.WZGameModeDisplayType.QUADS] = @"mpui/quads",
	[CoD.PlayerStatsUtility.WZGameModeDisplayType.LTM] = @"hash_3968DB13DF95101A",
}
CoD.PlayerStatsUtility.WZGameModeInfoTable = nil
CoD.PlayerStatsUtility.WZDistanceTraveledStats = {
	@"distance_traveled_foot",
	@"distance_traveled_vehicle_air",
	@"distance_traveled_vehicle_land",
	@"distance_traveled_vehicle_water",
}
CoD.PlayerStatsUtility.ZMGameModeTable = {
	@"zclassic",
	@"zstandard",
}
CoD.PlayerStatsUtility.ZMMaps = {
	@"zm_escape",
	@"zm_mansion",
	@"zm_office",
	@"zm_red",
	@"zm_towers",
	@"zm_zodt8",
	@"zm_white",
	@"zm_orange",
}
CoD.PlayerStatsUtility.FeaturedMedalScriptRef = "headshot"
CoD.PlayerStatsUtility.MultiKillMedalScriptRefs = {
	"killstreak_more_than_30",
	"killstreak_30",
	"killstreak_25",
	"killstreak_20",
	"killstreak_15",
	"killstreak_10",
	"killstreak_5",
}
CoD.PlayerStatsUtility.KillStreakMedalScriptRefs = {
	"multikill_more_than_7",
	"multikill_7",
	"multikill_6",
	"multikill_5",
	"multikill_4",
	"multikill_3",
	"multikill_2",
}
CoD.PlayerStatsUtility.GetWZModeInfoTable = function()
	if CoD.PlayerStatsUtility.WZGameModeInfoTable == nil then
		CoD.PlayerStatsUtility.WZGameModeInfoTable = {
			[CoD.PlayerStatsUtility.WZGameModeDisplayType.ALL] = {
				filterName = @"menu/all",
				statPathName = CoD.GameTypeUtility.GetAllGameModes(Enum[@"emodes"][@"mode_warzone"]),
			},
			[CoD.PlayerStatsUtility.WZGameModeDisplayType.SOLO] = {
				filterName = @"mpui/solo",
				statPathName = @"warzone_solo",
			},
			[CoD.PlayerStatsUtility.WZGameModeDisplayType.DUOS] = {
				filterName = @"mpui/duos",
				statPathName = @"warzone_duo",
			},
			[CoD.PlayerStatsUtility.WZGameModeDisplayType.QUADS] = {
				filterName = @"mpui/quads",
				statPathName = @"warzone_quad",
			},
			[CoD.PlayerStatsUtility.WZGameModeDisplayType.LTM] = {
				filterName = @"hash_3968DB13DF95101A",
				statPathName = CoD.GameTypeUtility.GetLimitedTimeModes(Enum[@"emodes"][@"mode_warzone"]),
			},
		}
	end
	return CoD.PlayerStatsUtility.WZGameModeInfoTable
end
CoD.PlayerStatsUtility.HashStorageLookup = function(f2_arg0, f2_arg1, f2_arg2)
	if f2_arg0 == nil or type(f2_arg1) ~= "table" then
		return
	end
	local f2_local0 = LUI.getTableFromFieldList(f2_arg1, f2_arg0)
	if not f2_local0 then
		return
	end
	local f2_local1 = f2_local0[@"statvalue"]
	if not f2_local1 then
		return f2_local0:get()
	elseif IsArenaMode() then
		local f2_local2 = f2_local0[@"arenavalue"]
		if f2_local2 then
			return f2_local2:get()
		end
	elseif f2_arg2 == nil or f2_arg2 then
		local f2_local2 = f2_local0[@"arenavalue"]
		if f2_local2 then
			return f2_local1:get() - f2_local2:get()
		end
	end
	return f2_local1:get()
end
CoD.PlayerStatsUtility.HashStorageLookupForMenu = function(f3_arg0, f3_arg1)
	return CoD.PlayerStatsUtility.HashStorageLookup(CoD.BaseUtility.GetMenuStorageBuffer(f3_arg0), f3_arg1)
end
CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu = function(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.BaseUtility.GetMenuStorageBuffer(f4_arg0)
	if not f4_arg1 then
		f4_arg1 = {
			@"playerstatslist",
		}
	end
	if type(f4_arg2) == "table" then
		for f4_local4, f4_local5 in ipairs(f4_arg2) do
			table.insert(f4_arg1, f4_local5)
		end
	else
		table.insert(f4_arg1, f4_arg2)
	end
	return CoD.PlayerStatsUtility.HashStorageLookup(f4_local0, f4_arg1)
end
CoD.PlayerStatsUtility.HashPlayerStatsStorageNoCombinedLookupForMenu = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = CoD.BaseUtility.GetMenuStorageBuffer(f5_arg0)
	if not f5_arg1 then
		f5_arg1 = {
			@"playerstatslist",
		}
	end
	if type(f5_arg2) == "table" then
		for f5_local4, f5_local5 in ipairs(f5_arg2) do
			table.insert(f5_arg1, f5_local5)
		end
	else
		table.insert(f5_arg1, f5_arg2)
	end
	return CoD.PlayerStatsUtility.HashStorageLookup(f5_local0, f5_arg1, false)
end
CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer = function(f6_arg0)
	return CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f6_arg0, nil, @"rank") or 0, CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f6_arg0, nil, @"plevel") or 0
end
CoD.PlayerStatsUtility.GetCurrentRankAndXPFromMenuStorageBuffer = function(f7_arg0)
	return CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f7_arg0, nil, @"rank") or 0, CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f7_arg0, nil, @"rankxp") or 0
end
CoD.PlayerStatsUtility.GetWZGameModeTableValue = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = CoD.PlayerStatsUtility.GetWZModeInfoTable()
	if f8_arg0 < 0 or #f8_local0 < f8_arg0 then
		return f8_arg2
	elseif f8_local0[f8_arg0] and f8_local0[f8_arg0][f8_arg1] then
		return f8_local0[f8_arg0][f8_arg1]
	else
		return f8_arg2
	end
end
CoD.PlayerStatsUtility.GetMedalsListTable = function()
	local f9_local0
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		f9_local0 = CoD.ScoreInfoTable.BaseWZTable
		if not f9_local0 then
		else
			if not CoD.PlayerStatsUtility.MedalsListTable then
				CoD.PlayerStatsUtility.MedalsListTable = {}
				local f9_local1 = Engine[@"gettablerowcount"](f9_local0)
				for f9_local2 = 1, f9_local1, 1 do
					local f9_local5 = Engine[@"hash_4C6F8EC444864600"](f9_local0, f9_local2 - 1, CoD.ScoreInfoTable.ScriptRefCol)
					local f9_local6 = Engine[@"hash_4C6F8EC444864600"](f9_local0, f9_local2 - 1, CoD.ScoreInfoTable.MedalCategoryCol)
					local f9_local7 = Engine[@"hash_4C6F8EC444864600"](f9_local0, f9_local2 - 1, CoD.ScoreInfoTable.MedalRefCol)
					local f9_local8 = Engine[@"hash_4C6F8EC444864600"](f9_local0, f9_local2 - 1, CoD.ScoreInfoTable.MedalAssetCol)
					local f9_local9 = tonumber(Engine[@"hash_25DC2BA4A99CE43E"](f9_local0, f9_local2 - 1, CoD.ScoreInfoTable.MedalXPCol)) or 0
					local f9_local10 = Engine[@"hash_2E00B2F29271C60B"](f9_local8)
					if f9_local10 and f9_local5 and f9_local7 and f9_local7 ~= 0x0 then
						CoD.PlayerStatsUtility.MedalsListTable[f9_local5] = {
							name = f9_local10[@"stringref"] or @"hash_0",
							description = f9_local10[@"description"] or @"hash_0",
							iconSmall = f9_local10[@"iconsmall"],
							iconLarge = f9_local10[@"iconlarge"],
							timesEarned = 0,
							medalReference = f9_local7,
							medalCategory = f9_local6,
							baseMedalXP = f9_local9,
						}
					end
				end
			end
			return CoD.PlayerStatsUtility.MedalsListTable
		end
	end
	f9_local0 = CoD.ScoreInfoTable.BaseMPTable
end
CoD.PlayerStatsUtility.GetEarnedMedalsListTable = function(f10_arg0)
	if not CoD.PlayerStatsUtility.EarnedMedalsListTable then
		CoD.PlayerStatsUtility.EarnedMedalsListTable = {}
		for f10_local4, f10_local5 in pairs(CoD.PlayerStatsUtility.GetMedalsListTable()) do
			local f10_local6 = f10_local5.medalReference
			if f10_local6 then
				local f10_local3 = 0
				if LuaUtils.IsArenaMode() then
					f10_local3 = f10_arg0[f10_local6].arenaValue:get()
				else
					f10_local3 = f10_arg0[f10_local6].statValue:get()
				end
				if f10_local3 > 0 then
					if not CoD.PlayerStatsUtility.EarnedMedalsListTable[f10_local6] then
						CoD.PlayerStatsUtility.EarnedMedalsListTable[f10_local6] = f10_local3
					else
						CoD.PlayerStatsUtility.EarnedMedalsListTable[f10_local6] = CoD.PlayerStatsUtility.EarnedMedalsListTable[f10_local6] + f10_local3
					end
				end
			end
		end
	end
	return CoD.PlayerStatsUtility.EarnedMedalsListTable
end
CoD.PlayerStatsUtility.IsPrestigeMasterForMenu = function(f11_arg0, f11_arg1)
	return IsGameModeParagonCapable(f11_arg0) and Engine[@"getprestigecap"](f11_arg0) <= f11_local1
end
CoD.PlayerStatsUtility.MedalsTabChanged = function(f12_arg0)
	if f12_arg0.MedalsGrid then
		f12_arg0.MedalsGrid:updateDataSource()
	end
end
CoD.PlayerStatsUtility.SetCombatRecordXUID = function(f13_arg0)
	CoD.PlayerStatsUtility.CombatRecordXUID = Engine[@"getxuid64"]()
	CoD.PlayerStatsUtility.CombatRecordOtherPlayerStats = false
end
CoD.PlayerStatsUtility.SetCombatRecordXUIDForSelectedPlayer = function(f14_arg0)
	local f14_local0 = Engine[@"getmodelforcontroller"](f14_arg0)
	local f14_local1 = f14_local0["Social.selectedFriendXUID"]
	if f14_local1 then
		CoD.PlayerStatsUtility.CombatRecordXUID = f14_local1:get()
		CoD.PlayerStatsUtility.CombatRecordOtherPlayerStats = true
	end
end
CoD.PlayerStatsUtility.GetStorageBufferForPlayer = function(f15_arg0)
	if CoD.PlayerStatsUtility.CombatRecordOtherPlayerStats then
		return Engine[@"getotherplayerstatsbuffer"]()
	else
		local f15_local0 = Engine[@"currentsessionmode"]()
		if f15_local0 == Enum[@"emodes"][@"mode_zombies"] then
			return Engine[@"storagegetbuffer"](f15_arg0, Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"])
		elseif f15_local0 == Enum[@"emodes"][@"mode_warzone"] then
			return Engine[@"storagegetbuffer"](f15_arg0, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"])
		else
			return Engine[@"storagegetbuffer"](f15_arg0, Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"])
		end
	end
end
CoD.PlayerStatsUtility.GetStorageBufferEnumForPlayer = function(f16_arg0)
	if CoD.PlayerStatsUtility.CombatRecordOtherPlayerStats then
		return nil
	else
		local f16_local0 = Engine[@"currentsessionmode"]()
		if f16_local0 == Enum[@"emodes"][@"mode_zombies"] then
			return Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"]
		elseif f16_local0 == Enum[@"emodes"][@"mode_warzone"] then
			return Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"]
		else
			return Enum[@"storagefiletype"][@"hash_5D5A7695E03A7A90"]
		end
	end
end
CoD.PlayerStatsUtility.SetShowcaseMedal = function(f17_arg0, f17_arg1)
	local f17_local0 = f17_arg1:getModel()
	if f17_local0 and f17_local0.name then
		local f17_local1 = f17_local0.medalStatName:get()
		if f17_local1 then
			Engine[@"hash_4D43FF04BA67F511"](f17_arg0, f17_local1)
			DataSources.PlayerShowcase.updateShowcaseMedal(f17_arg0)
		end
	end
end
CoD.PlayerStatsUtility.GetShowcaseMedal = function(f18_arg0, f18_arg1)
	local f18_local0 = nil
	if f18_arg0 then
		f18_local0 = CoD.InspectionUtility.GetXUIDForMenu(f18_arg0)
	end
	if not f18_local0 then
		f18_local0 = Engine[@"getxuid64"](f18_arg1)
	end
	if f18_local0 then
		return Engine[@"hash_11FDB8C006BC46BE"](f18_local0)
	else
	end
end
CoD.PlayerStatsUtility.SetNextPrestigeCallingCard = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0, f19_local1 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f19_arg0)
	CoD.ChallengesUtility.SetCallingCardForWidget(f19_arg2, CoD.PrestigeUtility.GetBackgroundIdByPLevel(f19_arg1, math.min(f19_local1, CoD.PrestigeUtility.GetPrestigeCap()) + 1, Engine[@"currentsessionmode"]()), f19_arg0.id)
end
CoD.PlayerStatsUtility.UpdateWZStatsFilter = function(f20_arg0)
	local f20_local0 = DataSources.PlayerBarracksStats.getModel(f20_arg0)
	f20_local0 = f20_local0.currentFilter
	if f20_local0 then
		f20_local0:set(f20_local0:get() % #CoD.PlayerStatsUtility.GetWZModeInfoTable() + 1)
	end
end
CoD.PlayerStatsUtility.GetWZGameModeFilterNameForType = function(f21_arg0)
	return CoD.PlayerStatsUtility.GetWZGameModeTableValue(f21_arg0, "filterName", 0x0)
end
CoD.PlayerStatsUtility.GetPlayerStorageStat = function(f22_arg0, f22_arg1, f22_arg2)
	return CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f22_arg0, nil, f22_arg1)
end
CoD.PlayerStatsUtility.GetPlayerStorageStatNoCombined = function(f23_arg0, f23_arg1, f23_arg2)
	return CoD.PlayerStatsUtility.HashPlayerStatsStorageNoCombinedLookupForMenu(f23_arg0, nil, f23_arg1)
end
CoD.PlayerStatsUtility.GetPlayerStorageStatRatio = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
	return CoD.GetDisplayRatioFromTwoStats(CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f24_arg0, nil, f24_arg1) or 0, CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f24_arg0, nil, f24_arg2) or 0)
end
CoD.PlayerStatsUtility.GetPlayerStorageStatRatioRounded = function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
	local f25_local0 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f25_arg0, nil, f25_arg1) or 0
	local f25_local1 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f25_arg0, nil, f25_arg2) or 0
	local f25_local2 = nil
	if f25_local1 == 0 then
		f25_local2 = 0
	else
		f25_local2 = f25_local0 / f25_local1
	end
	return math.floor(f25_local2 + 0.5)
end
CoD.PlayerStatsUtility.GetPlayerStorageStatPerMinute = function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
	return math.floor((CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f26_arg0, nil, f26_arg1) or 0) / math.max(1, (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f26_arg0, nil, f26_arg2) or 0) / 60) + 0.5)
end
CoD.PlayerStatsUtility.GetPlayerStorageStatsSum = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
	return (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f27_arg0, nil, f27_arg1) or 0) + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f27_arg0, nil, f27_arg2) or 0)
end
CoD.PlayerStatsUtility.GetArenaBarracksStat = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
	return CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f28_arg0, {
		"arenaBest",
		f28_arg1,
		f28_arg2,
	}, nil) or 0
end
CoD.PlayerStatsUtility.GetFirestreakIcon = function(f29_arg0, f29_arg1)
	return CoD.ArenaLeaguePlayUtility.GetFirestreak(CoD.PlayerStatsUtility.GetArenaBarracksStat(f29_arg0, @"leagueplaystats", @"points", nil), CoD.PlayerStatsUtility.GetArenaBarracksStat(f29_arg0, @"leagueplaystats", @"firstsubdivisionrankstreak", nil))
end
CoD.PlayerStatsUtility.GetGameModePlayerStorageStat = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3, f30_arg4)
	local f30_local0 = f30_arg2
	local f30_local1 = 0
	if type(f30_local0) == "table" then
		for f30_local5, f30_local6 in ipairs(f30_local0) do
			f30_local1 = f30_local1 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f30_arg1, {
				@"playerstatsbygametype",
				f30_local6,
			}, f30_arg3) or 0)
		end
	else
		f30_local1 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f30_arg1, {
			@"playerstatsbygametype",
			f30_local0,
		}, f30_arg3) or 0
	end
	return f30_local1
end
CoD.PlayerStatsUtility.GetWZGameModePlayerStorageStat = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
	local f31_local0 = DataSources.PlayerBarracksStats.getModel(f31_arg0)
	f31_local0 = f31_local0.currentFilter
	if f31_local0 then
		local f31_local1 = CoD.PlayerStatsUtility.GetWZGameModeTableValue(f31_local0:get(), "statPathName", 0x0)
		local f31_local2 = 0
		if type(f31_local1) == "table" then
			for f31_local6, f31_local7 in ipairs(f31_local1) do
				f31_local2 = f31_local2 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f31_arg1, {
					@"playerstatsbygametype",
					f31_local7,
				}, f31_arg2) or 0)
			end
		else
			f31_local2 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f31_arg1, {
				@"playerstatsbygametype",
				f31_local1,
			}, f31_arg2) or 0
		end
		return f31_local2
	else
		return 0
	end
end
CoD.PlayerStatsUtility.GetWZGameModeAveragePlayerStorageStatRatio = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3, f32_arg4)
	local f32_local0 = DataSources.PlayerBarracksStats.getModel(f32_arg0)
	f32_local0 = f32_local0.currentFilter
	if f32_local0 then
		local f32_local1 = CoD.PlayerStatsUtility.GetWZGameModeTableValue(f32_local0:get(), "statPathName", 0x0)
		local f32_local2 = 0
		local f32_local3 = 0
		if type(f32_local1) == "table" then
			for f32_local7, f32_local8 in ipairs(f32_local1) do
				f32_local2 = f32_local2 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f32_arg1, {
					@"playerstatsbygametype",
					f32_local8,
				}, f32_arg2) or 0)
				f32_local3 = f32_local3 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f32_arg1, {
					@"playerstatsbygametype",
					f32_local8,
				}, f32_arg3) or 0)
			end
		else
			f32_local2 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f32_arg1, {
				@"playerstatsbygametype",
				f32_local1,
			}, f32_arg2) or 0
			f32_local3 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f32_arg1, {
				@"playerstatsbygametype",
				f32_local1,
			}, f32_arg3) or 0
		end
		return CoD.GetDisplayRatioFromTwoStats(f32_local2, f32_local3)
	else
		return 0
	end
end
CoD.PlayerStatsUtility.GetWZCleanUpsPerGame = function(f33_arg0, f33_arg1, f33_arg2)
	local f33_local0 = DataSources.PlayerBarracksStats.getModel(f33_arg0)
	f33_local0 = f33_local0.currentFilter
	if f33_local0 then
		local f33_local1 = CoD.PlayerStatsUtility.GetWZGameModeTableValue(f33_local0:get(), "statPathName", 0x0)
		local f33_local2 = 0
		local f33_local3 = 0
		if type(f33_local1) == "table" then
			for f33_local7, f33_local8 in ipairs(f33_local1) do
				f33_local2 = f33_local2 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f33_arg1, {
					@"playerstatsbygametype",
					f33_local8,
				}, @"downs_eliminated") or 0) + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f33_arg1, {
					@"playerstatsbygametype",
					f33_local8,
				}, @"downs_eliminated_team") or 0) + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f33_arg1, {
					@"playerstatsbygametype",
					f33_local8,
				}, @"kills_eliminated") or 0)
				f33_local3 = f33_local3 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f33_arg1, {
					@"playerstatsbygametype",
					f33_local8,
				}, @"total_games_played") or 0)
			end
		else
			f33_local2 = f33_local2 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f33_arg1, {
				@"playerstatsbygametype",
				f33_local1,
			}, @"downs_eliminated") or 0) + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f33_arg1, {
				@"playerstatsbygametype",
				f33_local1,
			}, @"downs_eliminated_team") or 0) + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f33_arg1, {
				@"playerstatsbygametype",
				f33_local1,
			}, @"kills_eliminated") or 0)
			f33_local3 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f33_arg1, {
				@"playerstatsbygametype",
				f33_local1,
			}, @"total_games_played") or 0
		end
		return CoD.GetDisplayRatioFromTwoStats(f33_local2, f33_local3)
	else
		return 0
	end
end
CoD.PlayerStatsUtility.GetWZGameModeHighestPlayerStorageStat = function(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
	local f34_local0 = DataSources.PlayerBarracksStats.getModel(f34_arg0)
	f34_local0 = f34_local0.currentFilter
	if f34_local0 then
		local f34_local1 = CoD.PlayerStatsUtility.GetWZGameModeTableValue(f34_local0:get(), "statPathName", 0x0)
		local f34_local2 = 0
		if type(f34_local1) == "table" then
			for f34_local6, f34_local7 in ipairs(f34_local1) do
				local f34_local8 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f34_arg1, {
					@"playerstatsbygametype",
					f34_local7,
				}, f34_arg2)
				if f34_local8 ~= nil and f34_local2 < f34_local8 then
					f34_local2 = f34_local8
				end
			end
		else
			f34_local2 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f34_arg1, {
				@"playerstatsbygametype",
				f34_local1,
			}, f34_arg2) or 0
		end
		return f34_local2
	else
		return 0
	end
end
CoD.PlayerStatsUtility.GetWZGameModeAggregatePlayerStorageStats = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
	local f35_local0 = DataSources.PlayerBarracksStats.getModel(f35_arg0)
	f35_local0 = f35_local0.currentFilter
	if f35_local0 then
		local f35_local1 = CoD.PlayerStatsUtility.GetWZGameModeTableValue(f35_local0:get(), "statPathName", 0x0)
		local f35_local2 = 0
		if type(f35_local1) == "table" then
			for f35_local9, f35_local10 in ipairs(f35_local1) do
				for f35_local6, f35_local7 in ipairs(f35_arg2) do
					f35_local2 = f35_local2 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f35_arg1, {
						@"playerstatsbygametype",
						f35_local10,
					}, f35_local7) or 0)
				end
			end
		else
			for f35_local9, f35_local10 in ipairs(f35_arg2) do
				f35_local2 = f35_local2 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f35_arg1, {
					@"playerstatsbygametype",
					f35_local1,
				}, f35_local10) or 0)
			end
		end
		return f35_local2
	else
		return 0
	end
end
CoD.PlayerStatsUtility.GetWZTopPlacements = function(f36_arg0, f36_arg1, f36_arg2)
	return 0 + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f36_arg1, {
		@"playerstatsbygametype",
		CoD.PlayerStatsUtility.GetWZGameModeTableValue(CoD.PlayerStatsUtility.WZGameModeDisplayType.SOLO, "statPathName", 0x0),
	}, @"hash_6429D1FCCDEF2C9") or 0) + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f36_arg1, {
		@"playerstatsbygametype",
		CoD.PlayerStatsUtility.GetWZGameModeTableValue(CoD.PlayerStatsUtility.WZGameModeDisplayType.DUOS, "statPathName", 0x0),
	}, @"hash_7B8D2C77874A1C24") or 0) + (CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f36_arg1, {
		@"playerstatsbygametype",
		CoD.PlayerStatsUtility.GetWZGameModeTableValue(CoD.PlayerStatsUtility.WZGameModeDisplayType.QUADS, "statPathName", 0x0),
	}, @"hash_5E9A745460A10F80") or 0)
end
CoD.PlayerStatsUtility.GetRank = function(f37_arg0, f37_arg1)
	local f37_local0, f37_local1 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f37_arg0)
	local f37_local2 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f37_arg0, nil, @"paragon_rank") or 0
	local f37_local3 = Engine[@"currentsessionmode"]()
	if f37_local3 == Enum[@"emodes"][@"mode_warzone"] then
		return CoD.WZUtility.GetDecoratedStringForRank(f37_local0, f37_local2, f37_local1)
	elseif CoD.PlayerStatsUtility.IsPrestigeMasterForMenu(f37_local3, f37_arg0) then
		return Engine[@"getparagonrankdisplaylevel"](f37_local2, f37_local3)
	else
		return Engine[@"getrankdisplaylevel"](f37_local0)
	end
end
CoD.PlayerStatsUtility.GetRankColor = function(f38_arg0, f38_arg1)
	local f38_local0, f38_local1 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f38_arg0)
	local f38_local2 = Engine[@"currentsessionmode"]()
	if f38_local2 == Enum[@"emodes"][@"mode_warzone"] and IsGameModeParagonCapable(f38_local2) and Engine[@"getprestigecap"](f38_local2) <= f38_local1 then
		return CoD.ColorUtility.ConvertTableToRGB(ColorSet.PlayerParagonOrange)
	else
		return CoD.ColorUtility.ConvertTableToRGB(ColorSet.T8__BEIGE__HEADER)
	end
end
CoD.PlayerStatsUtility.GetRankIcon = function(f39_arg0, f39_arg1)
	local f39_local0 = Engine[@"currentsessionmode"]()
	if f39_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return @"blacktransparent"
	else
		local f39_local1, f39_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f39_arg0)
		if f39_local2 > 0 then
			return Engine[@"hash_6E21763E1EB756F8"](f39_local2, f39_local0)
		else
			return CoD.RankUtility.GetRankInfoField(f39_local0, f39_local1, @"icon", @"blacktransparent")
		end
	end
end
CoD.PlayerStatsUtility.GetRankIconLarge = function(f40_arg0, f40_arg1, f40_arg2)
	local f40_local0 = Engine[@"currentsessionmode"]()
	if f40_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return @"blacktransparent"
	else
		local f40_local1, f40_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f40_arg0)
		if CoD.PrestigeUtility.GetPrestigeCap(f40_local0) <= f40_local2 then
			local f40_local3 = CoD.CustomizePrestigeIconUtility.GetCurrentParagonIconId(f40_arg1, f40_local0)
			if not f40_local3 or f40_local3 == 0 then
				return Engine[@"hash_2FC100C7712C1987"](f40_local2, f40_local0)
			else
				return Engine[@"hash_2C8206CA556C230"](f40_local3, f40_local0)
			end
		elseif f40_local2 > 0 then
			return Engine[@"hash_2FC100C7712C1987"](f40_local2, f40_local0)
		else
			return CoD.RankUtility.GetRankInfoField(f40_local0, f40_local1, @"iconlarge", @"blacktransparent")
		end
	end
end
CoD.PlayerStatsUtility.GetRankTitle = function(f41_arg0, f41_arg1)
	local f41_local0 = Engine[@"currentsessionmode"]()
	if f41_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return 0x0
	else
		local f41_local1, f41_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f41_arg0)
		return CoD.GetRankName(f41_local1, f41_local2, f41_local0)
	end
end
CoD.PlayerStatsUtility.GetLevelString = function(f42_arg0, f42_arg1)
	local f42_local0, f42_local1 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f42_arg0)
	local f42_local2 = Engine[@"currentsessionmode"]()
	if f42_local2 == Enum[@"emodes"][@"mode_invalid"] then
		return 0x0
	elseif IsGameModeParagonCapable(f42_local2) and Engine[@"getprestigecap"](f42_local2) <= f42_local1 then
		return Engine[@"hash_4F9F1239CFD921FE"](
			@"hash_621235EA457AB637",
			Engine[@"getparagonrankdisplaylevel"](
				CoD.PlayerStatsUtility.HashStorageLookupForMenu(f42_arg0, {
					@"playerstatslist",
					@"paragon_rank",
				}),
				f42_local2
			)
		)
	elseif f42_local2 == Enum[@"emodes"][@"mode_warzone"] then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_2294790D215078A9", CoD.WZUtility.GetWZLevel(CoD.RankUtility.GetRankInfoField(f42_local2, f42_local0, @"level", 1)))
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_621235EA457AB637", CoD.RankUtility.GetRankInfoField(f42_local2, f42_local0, @"level", 1))
	end
end
CoD.PlayerStatsUtility.GetCurrentXPForRank = function(f43_arg0, f43_arg1)
	local f43_local0 = Engine[@"currentsessionmode"]()
	if f43_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return 0
	else
		return Engine[@"hash_7330C6B74568245D"](f43_arg0.m_ownerController, f43_local0, false)
	end
end
CoD.PlayerStatsUtility.GetXPToNextRank = function(f44_arg0, f44_arg1)
	local f44_local0 = Engine[@"currentsessionmode"]()
	if f44_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return 0
	else
		return Engine[@"hash_7330C6B74568245D"](f44_arg0.m_ownerController, f44_local0, true)
	end
end
CoD.PlayerStatsUtility.GetCurrentXPOverNextRankXP = function(f45_arg0, f45_arg1)
	local f45_local0 = Engine[@"currentsessionmode"]()
	if f45_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return ""
	end
	local f45_local1, f45_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndXPFromMenuStorageBuffer(f45_arg0)
	local f45_local3 = CoD.PlayerStatsUtility.IsPrestigeMasterForMenu(f45_local0, f45_arg0)
	if f45_local3 then
		f45_local1 = CoD.PlayerStatsUtility.HashStorageLookupForMenu(f45_arg0, {
			@"playerstatslist",
			@"paragon_rank",
		})
		f45_local2 = CoD.PlayerStatsUtility.GetPrestigeMasterAbsoluteXP(
			f45_local0,
			CoD.PlayerStatsUtility.HashStorageLookupForMenu(f45_arg0, {
				@"playerstatslist",
				@"paragon_rankxp",
			})
		)
	end
	local f45_local4
	if f45_local3 then
		f45_local4 = Engine[@"hash_5E7C7AB06A7E4905"](f45_local1, f45_local0)
		if not f45_local4 then
		else
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7309AC35888034C2", f45_local2, f45_local4)
		end
	end
	f45_local4 = CoD.RankUtility.GetRankInfoField(f45_local0, f45_local1, @"maxxp", 0)
end
CoD.PlayerStatsUtility.GetNextRank = function(f46_arg0, f46_arg1)
	local f46_local0 = CoD.BaseUtility.GetMenuSessionMode(f46_arg0)
	if f46_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return 0
	else
		return CoD.RankUtility.GetRankInfoField(f46_local0, CoD.PlayerStatsUtility.GetCurrentRankAndXPFromMenuStorageBuffer(f46_arg0) + 1, @"level", 1)
	end
end
CoD.PlayerStatsUtility.GetCurrentRankProgress = function(f47_arg0, f47_arg1, f47_arg2, f47_arg3, f47_arg4)
	local f47_local0 = Engine[@"currentsessionmode"]()
	if f47_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return 0
	end
	local f47_local1, f47_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndXPFromMenuStorageBuffer(f47_arg0)
	local f47_local3 = CoD.PlayerStatsUtility.IsPrestigeMasterForMenu(f47_local0, f47_arg0)
	if not f47_local3 or not Engine[@"hash_109F8F1C5A3513B"](f47_local1, f47_local0) then
		local f47_local4 = CoD.RankUtility.GetRankInfoField(f47_local0, f47_local1, @"minxp", 0)
	end
	if not f47_local3 or not Engine[@"hash_5E7C7AB06A7E4905"](f47_local1, f47_local0) then
		local f47_local5 = CoD.RankUtility.GetRankInfoField(f47_local0, f47_local1, @"maxxp", 0)
	end
	if f47_local3 then
		f47_local1 = CoD.PlayerStatsUtility.HashStorageLookupForMenu(f47_arg0, {
			@"playerstatslist",
			@"paragon_rank",
		})
		f47_local2 = CoD.PlayerStatsUtility.GetPrestigeMasterAbsoluteXP(
			f47_local0,
			CoD.PlayerStatsUtility.HashStorageLookupForMenu(f47_arg0, {
				@"playerstatslist",
				@"paragon_rankxp",
			})
		)
		local f47_local4 = Engine[@"hash_109F8F1C5A3513B"](f47_local1, f47_local0)
		local f47_local5 = Engine[@"hash_5E7C7AB06A7E4905"](f47_local1, f47_local0)
	end
	return (f47_local2 - f47_local4) / math.max(1, f47_local5 - f47_local4) or 0, 0, 0, 0
end
CoD.PlayerStatsUtility.GetNextRankIcon = function(f48_arg0, f48_arg1)
	local f48_local0 = Engine[@"currentsessionmode"]()
	if f48_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return @"blacktransparent"
	end
	local f48_local1, f48_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f48_arg0)
	local f48_local3 = CoD.PlayerStatsUtility.IsPrestigeMasterForMenu(f48_local0, f48_arg0)
	local f48_local4 = f48_local1 + 1
	if f48_local4 > CoD.RankUtility.GetRankCap() and not f48_local3 then
		f48_local4 = f48_local1
	end
	return Engine[@"getrankicon"](f48_local4, f48_local2, f48_local0) or @"blacktransparent"
end
CoD.PlayerStatsUtility.GetNextPrestigeTitle = function(f49_arg0, f49_arg1)
	local f49_local0 = Engine[@"currentsessionmode"]()
	if f49_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return 0x0
	else
		local f49_local1, f49_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f49_arg0)
		return CoD.GetRankName(f49_local1, math.min(f49_local2 + 1, CoD.PrestigeUtility.GetPrestigeCap()), f49_local0)
	end
end
CoD.PlayerStatsUtility.GetNextPrestigeIcon = function(f50_arg0, f50_arg1, f50_arg2)
	local f50_local0 = Engine[@"currentsessionmode"]()
	if f50_local0 == Enum[@"emodes"][@"mode_invalid"] then
		return @"blacktransparent"
	else
		local f50_local1, f50_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f50_arg0)
		local f50_local3 = math.min(f50_local2 + 1, CoD.PrestigeUtility.GetPrestigeCap())
		if f50_arg1 then
			return Engine[@"hash_2FC100C7712C1987"](f50_local3, f50_local0)
		else
			return Engine[@"hash_6E21763E1EB756F8"](f50_local3, f50_local0)
		end
	end
end
CoD.PlayerStatsUtility.GetPrestigeProgress = function(f51_arg0, f51_arg1, f51_arg2, f51_arg3, f51_arg4)
	local f51_local0 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f51_arg0, nil, @"rank") or 0
	local f51_local1 = CoD.RankUtility.GetRankCap()
	if CoD.PlayerStatsUtility.IsPrestigeMasterForMenu(CoD.BaseUtility.GetMenuSessionMode(f51_arg0), f51_arg0) then
		f51_local0 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f51_arg0, nil, @"paragon_rank") or 0
		f51_local1 = CoD.RankUtility.MAX_PARAGON_RANK
	end
	return f51_local0 / math.max(1, f51_local1), 0, 0, 0
end
CoD.PlayerStatsUtility.GetPrestigeProgressFractionString = function(f52_arg0, f52_arg1)
	local f52_local0 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f52_arg0, nil, @"rank") or 0
	local f52_local1 = CoD.RankUtility.GetRankCap()
	local f52_local2 = CoD.BaseUtility.GetMenuSessionMode(f52_arg0)
	if CoD.PlayerStatsUtility.IsPrestigeMasterForMenu(f52_local2, f52_arg0) then
		f52_local0 = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f52_arg0, nil, @"paragon_rank") or 0
		f52_local1 = CoD.RankUtility.MAX_PARAGON_RANK
	end
	if f52_local2 == Enum[@"emodes"][@"mode_warzone"] and not CoD.PlayerStatsUtility.IsPrestigeMasterForMenu(f52_local2, f52_arg0) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f52_local0 + 1, @"hash_54008CE61FE52DCD")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_631CF0F51CCA3A27", f52_local0 + 1, math.max(1, f52_local1 + 1))
	end
end
CoD.PlayerStatsUtility.GetPrestigeRequirementString = function(f53_arg0, f53_arg1)
	local f53_local0 = CoD.BaseUtility.GetMenuSessionMode(f53_arg0)
	if f53_local0 == Enum[@"emodes"][@"mode_warzone"] and not CoD.PlayerStatsUtility.IsPrestigeMasterForMenu(f53_local0, f53_arg0) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E84CE29A8B160AD", @"hash_54008CE61FE52DCD")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E84CE29A8B160AD", math.max(1, CoD.RankUtility.GetRankCap() + 1))
	end
end
CoD.PlayerStatsUtility.GetPrestigeRewardsString = function(f54_arg0, f54_arg1)
	local f54_local0 = CoD.BaseUtility.GetMenuSessionMode(f54_arg0)
	local f54_local1, f54_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f54_arg0)
	local f54_local3 = math.min(f54_local2 + 1, CoD.PrestigeUtility.GetPrestigeCap())
	if CoD.RankUtility.GetRankCap() <= f54_local1 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"menu/prestige_rewards", f54_local3)
	else
		return CoD.GetRankName(0, f54_local3, f54_local0)
	end
end
CoD.PlayerStatsUtility.GetNextPrestigeString = function(f55_arg0, f55_arg1)
	local f55_local0 = CoD.BaseUtility.GetMenuSessionMode(f55_arg0)
	local f55_local1, f55_local2 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f55_arg0)
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_39E3050512D6C49B", math.min(f55_local2 + 1, CoD.PrestigeUtility.GetPrestigeCap()))
end
CoD.PlayerStatsUtility.GetNextPrestigeFanfareText = function(f56_arg0, f56_arg1)
	local f56_local0, f56_local1 = CoD.PlayerStatsUtility.GetCurrentRankAndPrestigeFromMenuStorageBuffer(f56_arg0)
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_2157400D2DF93470", math.min(f56_local1 + 1, CoD.PrestigeUtility.GetPrestigeCap()))
end
CoD.PlayerStatsUtility.GetPrestigeMasterAbsoluteXP = function(f57_arg0, f57_arg1)
	return Engine[@"hash_109F8F1C5A3513B"](CoD.RankUtility.GetRankCap(f57_arg0) + 1, f57_arg0) + f57_arg1
end
CoD.PlayerStatsUtility.UpdateZMHighestStats = function(f58_arg0, f58_arg1)
	DataSources.PlayerBarracksStats.updateZMHighestStats(f58_arg0, f58_arg1)
end
DataSourceHelpers.PerControllerDataSourceSetup(
	"PlayerBarracksStats",
	"PlayerBarracksStats",
	function(f59_arg0, f59_arg1)
		local f59_local0 = f59_arg0:create("currentFilter")
		f59_local0:set(CoD.PlayerStatsUtility.WZGameModeDisplayType.ALL)
		f59_arg0:create("zmHighestRound1")
		f59_arg0:create("zmHighestRound1Map")
		f59_arg0:create("zmHighestRound2")
		f59_arg0:create("zmHighestRound2Map")
		f59_arg0:create("zmHighestRound3")
		f59_arg0:create("zmHighestRound3Map")
		f59_arg0:create("zmHighestScore1")
		f59_arg0:create("zmHighestScore1Map")
		f59_arg0:create("zmHighestScore2")
		f59_arg0:create("zmHighestScore2Map")
		f59_arg0:create("zmHighestScore3")
		f59_arg0:create("zmHighestScore3Map")
	end,
	false,
	{
		updateZMHighestStats = function(f60_arg0, f60_arg1)
			local f60_local0 = DataSources.PlayerBarracksStats.getModel(f60_arg1)
			local f60_local1 = {}
			local f60_local2 = {}
			for f60_local6, f60_local7 in ipairs(CoD.PlayerStatsUtility.ZMMaps) do
				table.insert(f60_local1, {
					mapName = f60_local7,
					highestRoundReached = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f60_arg0, {
						@"playerstatsbymap",
						f60_local7,
						@"hash_74E26CA9652802FB",
						@"zclassic",
						@"stats",
					}, @"highest_round_reached") or 0,
				})
				table.insert(f60_local2, {
					mapName = f60_local7,
					highestScore = CoD.PlayerStatsUtility.HashPlayerStatsStorageLookupForMenu(f60_arg0, {
						@"playerstatsbymap",
						f60_local7,
						@"hash_74E26CA9652802FB",
						@"zstandard",
						@"stats",
					}, @"highest_score") or 0,
				})
			end
			if f60_local1 then
				table.sort(f60_local1, function(f61_arg0, f61_arg1)
					return f61_arg1.highestRoundReached < f61_arg0.highestRoundReached
				end)
				if f60_local1[1] then
					f60_local0.zmHighestRound1:set(f60_local1[1].highestRoundReached)
					f60_local0.zmHighestRound1Map:set(CoD.MapUtility.GetMapValue(f60_local1[1].mapName, "mapName", 0x0))
				end
				if f60_local1[2] then
					f60_local0.zmHighestRound2:set(f60_local1[2].highestRoundReached)
					f60_local0.zmHighestRound2Map:set(CoD.MapUtility.GetMapValue(f60_local1[2].mapName, "mapName", 0x0))
				end
				if f60_local1[3] then
					f60_local0.zmHighestRound3:set(f60_local1[3].highestRoundReached)
					f60_local0.zmHighestRound3Map:set(CoD.MapUtility.GetMapValue(f60_local1[3].mapName, "mapName", 0x0))
				end
			end
			if f60_local2 then
				table.sort(f60_local2, function(f62_arg0, f62_arg1)
					return f62_arg1.highestScore < f62_arg0.highestScore
				end)
				if f60_local2[1] then
					f60_local0.zmHighestScore1:set(f60_local2[1].highestScore)
					f60_local0.zmHighestScore1Map:set(CoD.MapUtility.GetMapValue(f60_local2[1].mapName, "mapName", 0x0))
				end
				if f60_local2[2] then
					f60_local0.zmHighestScore2:set(f60_local2[2].highestScore)
					f60_local0.zmHighestScore2Map:set(CoD.MapUtility.GetMapValue(f60_local2[2].mapName, "mapName", 0x0))
				end
				if f60_local2[3] then
					f60_local0.zmHighestScore3:set(f60_local2[3].highestScore)
					f60_local0.zmHighestScore3Map:set(CoD.MapUtility.GetMapValue(f60_local2[3].mapName, "mapName", 0x0))
				end
			end
		end,
	}
)
DataSourceHelpers.PerControllerDataSourceSetup("PlayerBarracksMerits", "PlayerBarracksMerits", function(f63_arg0, f63_arg1)
	local f63_local0 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer(f63_arg1)
	local f63_local1 = CoD.PlayerStatsUtility.HashStorageLookup(f63_local0, {
		@"playerstatslist",
		@"killxp",
	})
	local f63_local2 = f63_arg0:create("kills")
	local f63_local3 = f63_local2:create("statMerits")
	f63_local3:set(f63_local1)
	f63_local3 = CoD.PlayerStatsUtility.HashStorageLookup(f63_local0, {
		@"playerstatslist",
		@"placementxp",
	})
	local f63_local4 = f63_arg0:create("top5")
	local f63_local5 = f63_local4:create("statMerits")
	f63_local5:set(f63_local3)
	f63_local5 = CoD.PlayerStatsUtility.HashStorageLookup(f63_local0, {
		@"playerstatslist",
		@"winxp",
	})
	local f63_local6 = f63_arg0:create("wins")
	local f63_local7 = f63_local6:create("statMerits")
	f63_local7:set(f63_local5)
	f63_local7 = CoD.PlayerStatsUtility.HashStorageLookup(f63_local0, {
		@"playerstatslist",
		@"challengexp",
	})
	local f63_local8 = f63_arg0:create("challenges")
	local f63_local9 = f63_local8:create("statMerits")
	f63_local9:set(f63_local7)
	f63_local9 = CoD.PlayerStatsUtility.HashStorageLookup(f63_local0, {
		@"playerstatslist",
		@"contractxp",
	})
	local f63_local10 = f63_arg0:create("contracts")
	local f63_local11 = f63_local10:create("statMerits")
	f63_local11:set(f63_local9)
	f63_local11 = CoD.PlayerStatsUtility.HashStorageLookup(f63_local0, {
		@"playerstatslist",
		@"medalxp",
	})
	local f63_local12 = f63_arg0:create("medals")
	local f63_local13 = f63_local12:create("statMerits")
	f63_local13:set(f63_local11)
end)
DataSources.MPMedalTabs = ListHelper_SetupDataSource("MPMedalTabs", function(f64_arg0)
	if IsWarzone() then
		return {}
	else
		local f64_local0 = function(f65_arg0, f65_arg1)
			return f65_arg1.models.timesEarned < f65_arg0.models.timesEarned
		end
		local f64_local1 = function(f66_arg0, f66_arg1)
			return f66_arg0.models.timesEarned < f66_arg1.models.timesEarned
		end
		local f64_local2 = {}
		table.insert(f64_local2, {
			models = {
				name = @"hash_211443FB63782639",
			},
			properties = {
				category = @"combat",
				sortFunc = f64_local1,
			},
		})
		table.insert(f64_local2, {
			models = {
				name = @"hash_18B0D8B4A861BBC5",
			},
			properties = {
				category = @"specialist",
				sortFunc = f64_local0,
			},
		})
		table.insert(f64_local2, {
			models = {
				name = @"hash_2EB1D30BFD69C119",
			},
			properties = {
				category = @"antispecialist",
				sortFunc = f64_local0,
			},
		})
		table.insert(f64_local2, {
			models = {
				name = @"hash_2D17CC7D16033AEA",
			},
			properties = {
				category = @"scorestreak",
				sortFunc = f64_local0,
			},
		})
		table.insert(f64_local2, {
			models = {
				name = 0x79C859C8600D9E,
			},
			properties = {
				category = @"antiscorestreak",
				sortFunc = f64_local0,
			},
		})
		table.insert(f64_local2, {
			models = {
				name = @"hash_5ED2FACC41C9E672",
			},
			properties = {
				category = @"gamemode",
				sortFunc = f64_local0,
			},
		})
		return f64_local2
	end
end)
DataSources.MedalsList = ListHelper_SetupDataSource("MedalsList", function(f67_arg0, f67_arg1)
	local f67_local0 = {}
	local f67_local1 = nil
	local f67_local2 = CoD.BaseUtility.GetMenuStorageBuffer(f67_arg1.menu)
	if f67_local2 then
		f67_local1 = f67_local2.PlayerStatsList
	end
	local f67_local3 = CoD.PlayerStatsUtility.GetMedalsListTable()
	local f67_local4 = CoD.PlayerStatsUtility.GetEarnedMedalsListTable(f67_local1)
	if f67_local4 then
		local f67_local5 = nil
		for f67_local11, f67_local12 in pairs(f67_local3) do
			local f67_local13 = f67_local4[f67_local12.medalReference]
			local f67_local9
			if (not f67_arg1.menu._category or f67_arg1.menu._category ~= f67_local12.medalCategory) and Engine[@"currentsessionmode"]() ~= Enum[@"emodes"][@"mode_warzone"] then
				f67_local9 = false
			else
				f67_local9 = true
			end
			if f67_local13 and f67_local13 > 0 and f67_local9 then
				local f67_local10 = nil
				if not IsWarzone() then
					f67_local10 = Engine[@"hash_4F9F1239CFD921FE"](@"rank/xp", f67_local12.baseMedalXP * f67_local13)
				else
					f67_local10 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1BCE3D9B07DE63B7", f67_local12.baseMedalXP * f67_local13)
				end
				if f67_local5 and f67_local12.name == @"medal/shutdown" then
					f67_local5.timesEarned = f67_local5.timesEarned + f67_local13
				end
				table.insert(f67_local0, {
					models = {
						name = f67_local12.name,
						medalStatName = f67_local12.medalReference,
						description = f67_local12.description,
						timesEarned = f67_local13,
						iconSmall = f67_local12.iconSmall,
						iconLarge = f67_local12.iconLarge,
						xpValue = f67_local10,
					},
				})
				if f67_local12.name == @"medal/shutdown" then
					f67_local5 = f67_local0[#f67_local0].models
				end
			end
		end
		if f67_arg1.menu._sortFunc then
			table.sort(f67_local0, f67_arg1.menu._sortFunc)
		end
	end
	return f67_local0
end, true)
DataSources.FeaturedMedals = {
	preparedForController = {},
	preparedForArenaPerController = {},
	getHighestValueEarnedMedal = function(f68_arg0, f68_arg1, f68_arg2)
		for f68_local7, f68_local8 in ipairs(f68_arg2) do
			if f68_local7 == #f68_arg2 then
				return f68_local8
			end
			local f68_local3 = Engine[@"tablefindrows"](DataSources.FeaturedMedals.MedalTable, CoD.ScoreInfoTable.ScriptRefCol, f68_local8)
			local f68_local4 = f68_local3 and f68_local3[1]
			if f68_local4 then
				local f68_local5 = Engine[@"hash_4C6F8EC444864600"](DataSources.FeaturedMedals.MedalTable, f68_local4, CoD.ScoreInfoTable.MedalRefCol)
				if f68_arg1 and f68_arg1[f68_local5] then
					local f68_local6 = 0
					if LuaUtils.IsArenaMode() then
						f68_local6 = f68_arg1[f68_local5].arenaValue:get()
					else
						f68_local6 = f68_arg1[f68_local5].statValue:get()
					end
					if f68_local6 and f68_local6 > 0 then
						return f68_local8
					end
				end
			end
		end
		return nil
	end,
	getHighestValueWZMedals = function(f69_arg0, f69_arg1)
		local f69_local0 = CoD.PlayerStatsUtility.GetMedalsListTable()
		local f69_local1 = {}
		local f69_local2, f69_local3 = nil
		f69_local1[1] = nil
		f69_local1[2] = f69_local2
		f69_local1[3] = f69_local3
		local f69_local4 = {
			0,
			0,
			0,
		}
		for f69_local7, f69_local8 in pairs(f69_local0) do
			local f69_local9 = f69_local8.medalReference
			if f69_arg1 and f69_arg1[f69_local9] then
				local f69_local6 = f69_arg1[f69_local9].statValue:get()
				if f69_local6 then
					if f69_local4[1] <= f69_local6 then
						f69_local4[3] = f69_local4[2]
						f69_local4[2] = f69_local4[1]
						f69_local1[3] = f69_local1[2]
						f69_local1[2] = f69_local1[1]
						f69_local4[1] = f69_local6
						f69_local1[1] = f69_local7
					end
					if f69_local4[2] <= f69_local6 then
						f69_local4[3] = f69_local4[2]
						f69_local1[3] = f69_local1[2]
						f69_local4[2] = f69_local6
						f69_local1[2] = f69_local7
					end
					if f69_local4[3] <= f69_local6 then
						f69_local4[3] = f69_local6
						f69_local1[3] = f69_local7
					end
				end
			end
		end
		return f69_local1[1], f69_local1[2], f69_local1[3]
	end,
	createModelsFn = function(f70_arg0, f70_arg1, f70_arg2, f70_arg3)
		local f70_local0 = {}
		local f70_local1 = Engine[@"tablefindrows"](DataSources.FeaturedMedals.MedalTable, CoD.ScoreInfoTable.ScriptRefCol, f70_arg3)
		local f70_local2 = f70_local1 and f70_local1[1]
		if f70_local2 then
			local f70_local3 = Engine[@"hash_4C6F8EC444864600"](DataSources.FeaturedMedals.MedalTable, f70_local2, CoD.ScoreInfoTable.MedalRefCol)
			local f70_local4 = Engine[@"hash_2E00B2F29271C60B"](Engine[@"hash_4C6F8EC444864600"](DataSources.FeaturedMedals.MedalTable, f70_local2, CoD.ScoreInfoTable.MedalAssetCol))
			local f70_local5 = 0
			if f70_arg1 and f70_arg1[f70_local3] then
				if LuaUtils.IsArenaMode() then
					f70_local5 = f70_arg1[f70_local3].arenaValue:get()
				else
					f70_local5 = f70_arg1[f70_local3].statValue:get()
				end
			end
			if f70_local4 and f70_local3 and f70_local3 ~= 0x0 then
				f70_local0 = {
					name = f70_local4[@"stringref"] or @"hash_0",
					iconSmall = f70_local4[@"iconsmall"],
					timesEarned = f70_local5,
					medalReference = f70_local3,
				}
			end
		end
		local f70_local3 = Engine[@"getmodelforcontroller"](f70_arg0)
		f70_local3 = f70_local3:create("FeaturedMedals")
		f70_local3 = f70_local3:create(f70_arg2)
		for f70_local7, f70_local8 in pairs(f70_local0) do
			local f70_local9 = f70_local3:create(f70_local7)
			f70_local9:set(f70_local8)
		end
	end,
	prepare = function(f71_arg0)
		if not DataSources.FeaturedMedals.preparedForController then
			DataSources.FeaturedMedals.preparedForController = {}
		end
		if not DataSources.FeaturedMedals.preparedForArenaPerController then
			DataSources.FeaturedMedals.preparedForArenaPerController = {}
		end
		DataSources.FeaturedMedals.preparedForController[f71_arg0] = true
		DataSources.FeaturedMedals.preparedForArenaPerController[f71_arg0] = LuaUtils.IsArenaMode()
		local f71_local0 = nil
		local f71_local1 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer(f71_arg0)
		if f71_local1 then
			f71_local0 = f71_local1.PlayerStatsList
		end
		if Engine[@"currentsessionmode"]() ~= Enum[@"emodes"][@"mode_warzone"] then
			DataSources.FeaturedMedals.createModelsFn(f71_arg0, f71_local0, "FeaturedMedal", CoD.PlayerStatsUtility.FeaturedMedalScriptRef)
			DataSources.FeaturedMedals.createModelsFn(f71_arg0, f71_local0, "MultiKillMedal", DataSources.FeaturedMedals.getHighestValueEarnedMedal(f71_arg0, f71_local0, CoD.PlayerStatsUtility.MultiKillMedalScriptRefs))
			DataSources.FeaturedMedals.createModelsFn(f71_arg0, f71_local0, "KillStreakMedal", DataSources.FeaturedMedals.getHighestValueEarnedMedal(f71_arg0, f71_local0, CoD.PlayerStatsUtility.KillStreakMedalScriptRefs))
		else
			local f71_local2, f71_local3, f71_local4 = DataSources.FeaturedMedals.getHighestValueWZMedals(f71_arg0, f71_local0)
			DataSources.FeaturedMedals.createModelsFn(f71_arg0, f71_local0, "FeaturedMedal", f71_local2)
			DataSources.FeaturedMedals.createModelsFn(f71_arg0, f71_local0, "MultiKillMedal", f71_local3)
			DataSources.FeaturedMedals.createModelsFn(f71_arg0, f71_local0, "KillStreakMedal", f71_local4)
		end
	end,
	getModel = function(f72_arg0)
		local f72_local0 = Engine[@"currentsessionmode"]()
		local f72_local1 = f72_local0 ~= DataSources.FeaturedMedals.mode
		DataSources.FeaturedMedals.mode = f72_local0
		if f72_local0 == Enum[@"emodes"][@"mode_warzone"] then
			DataSources.FeaturedMedals.MedalTable = CoD.ScoreInfoTable.BaseWZTable
		else
			DataSources.FeaturedMedals.MedalTable = CoD.ScoreInfoTable.BaseMPTable
		end
		if f72_local1 or not DataSources.FeaturedMedals.preparedForController or not DataSources.FeaturedMedals.preparedForController[f72_arg0] or not DataSources.FeaturedMedals.preparedForArenaPerController or DataSources.FeaturedMedals.preparedForArenaPerController[f72_arg0] ~= LuaUtils.IsArenaMode() then
			DataSources.FeaturedMedals.prepare(f72_arg0)
		end
		local f72_local2 = Engine[@"getmodelforcontroller"](f72_arg0)
		return f72_local2:create("FeaturedMedals")
	end,
}
DataSources.BarrackWinsWZ = {
	preparedForController = {},
	prepare = function(f73_arg0)
		if not DataSources.BarrackWinsWZ.preparedForController then
			DataSources.BarrackWinsWZ.preparedForController = {}
		end
		DataSources.BarrackWinsWZ.preparedForController[f73_arg0] = true
		local f73_local0 = Engine[@"getmodelforcontroller"](f73_arg0)
		f73_local0 = f73_local0:create("BarrackWinsWZ")
		local f73_local1 = CoD.GetCurrentPlayerStats(f73_arg0)
		if f73_local1 then
			local f73_local2 = f73_local1.PlayerStatsByGameType.warzone_solo.WINS.StatValue:get()
			local f73_local3 = f73_local0:create("soloWins")
			f73_local3:set(f73_local2)
			f73_local3 = f73_local1.PlayerStatsByGameType.warzone_duo.WINS.StatValue:get()
			local f73_local4 = f73_local0:create("duoWins")
			f73_local4:set(f73_local3)
			f73_local4 = f73_local1.PlayerStatsByGameType.warzone_quad.WINS.StatValue:get()
			local f73_local5 = f73_local0:create("quadWins")
			f73_local5:set(f73_local4)
			f73_local5 = f73_local1.PlayerStatsByGameType.warzone_dbno.WINS.StatValue:get()
			local f73_local6 = f73_local0:create("dbnoWins")
			f73_local6:set(f73_local5)
		end
	end,
	getModel = function(f74_arg0)
		if not DataSources.BarrackWinsWZ.preparedForController or not DataSources.BarrackWinsWZ.preparedForController[f74_arg0] then
			DataSources.BarrackWinsWZ.prepare(f74_arg0)
		end
		local f74_local0 = Engine[@"getmodelforcontroller"](f74_arg0)
		return f74_local0:create("BarrackWinsWZ")
	end,
}
DataSources.PlayerShowcase = {
	getModel = function(f75_arg0)
		local f75_local0 = Engine[@"getmodelforcontroller"](f75_arg0)
		f75_local0 = f75_local0:create("PlayerShowcase")
		f75_local0:create("callingcards")
		f75_local0:create("medal")
		DataSources.PlayerShowcase.updateShowcaseMedal(f75_arg0)
		return f75_local0
	end,
	updateShowcaseMedal = function(f76_arg0)
		local f76_local0 = Engine[@"getmodelforcontroller"](f76_arg0)
		f76_local0 = f76_local0:create("PlayerShowcase")
		f76_local0 = f76_local0.medal
		local f76_local1 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer(f76_arg0)
		local f76_local2 = nil
		if f76_local1 then
			f76_local2 = f76_local1.PlayerStatsList
		end
		local f76_local3 = 0x0
		local f76_local4 = @"blacktransparent"
		local f76_local5 = 0
		local f76_local6 = CoD.PlayerStatsUtility.GetShowcaseMedal(nil, f76_arg0)
		if not f76_local6 or f76_local6 == 0x0 then
			f76_local6 = @"stats_headshot"
		end
		local f76_local7 = Engine[@"tablelookup"](CoD.ScoreInfoTable.BaseMPTable, CoD.ScoreInfoTable.MedalAssetCol, CoD.ScoreInfoTable.MedalRefCol, f76_local6)
		if f76_local7 and f76_local7 ~= 0x0 then
			local f76_local8 = Engine[@"hash_2E00B2F29271C60B"](f76_local7)
			if f76_local8 then
				f76_local3 = f76_local8[@"stringref"] or 0x0
				f76_local4 = f76_local8[@"iconsmall"]
			end
			if f76_local2 and f76_local2[f76_local6] then
				if LuaUtils.IsArenaMode() then
					f76_local5 = f76_local2[f76_local6].arenaValue:get()
				else
					f76_local5 = f76_local2[f76_local6].statValue:get()
				end
			end
		end
		local f76_local8 = f76_local0:create("name")
		f76_local8:set(f76_local3)
		f76_local8 = f76_local0:create("iconSmall")
		f76_local8:set(f76_local4)
		f76_local8 = f76_local0:create("timesEarned")
		f76_local8:set(f76_local5)
	end,
}
