CoD.RankUtility = {}
CoD.RankUtility.ForceStreamedRankIcons = {}
CoD.RankUtility.RankInfoTable = nil
CoD.RankUtility.MAX_PARAGON_RANK = 999
CoD.RankUtility.RankMode = {
	None = Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE],
	Multiplayer = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
	Warzone = Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
	Zombies = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
	Arena = Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] + 1,
}
CoD.RankUtility.GetRankCap = function(f1_arg0)
	if not f1_arg0 then
		f1_arg0 = Engine[0x3EAC408F958FF05]()
	end
	return Engine[0xEAF2F2348AFD70B](f1_arg0)
end
CoD.RankUtility.GetParagonRankCap = function(f2_arg0)
	if not f2_arg0 then
		f2_arg0 = Engine[0x3EAC408F958FF05]()
	end
	if f2_arg0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or f2_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.RankUtility.MAX_PARAGON_RANK
	else
		return 0
	end
end
CoD.RankUtility.ForceStreamRankIcons = function(f3_arg0)
	if not (f3_arg0 ~= Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] or not LuaUtils.OnlineOnlyDemo()) or LuaUtils.OfflineOnlyDemo() then
		f3_arg0 = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	end
	local f3_local0 = {}
	if LuaUtils.GetDisplayNameForEMode(f3_arg0) ~= 0x0 then
		local f3_local1 = Engine[0xEEBB2C36368176E](f3_arg0)
		if f3_local1 then
			for f3_local5, f3_local6 in ipairs(f3_local1) do
				f3_local0[f3_local6] = true
			end
		end
	end
	CoD.RankUtility.ForceStreamedRankIcons = CoD.BaseUtility.ForceStreamHelper(CoD.RankUtility.ForceStreamedRankIcons, f3_local0)
end
CoD.RankUtility.GetRankInfoTable = function()
	if CoD.RankUtility.RankInfoTable == nil or IsOnlineGame() and #CoD.RankUtility.RankInfoTable <= 0 then
		CoD.RankUtility.RankInfoTable = Engine[0x6CFA8EF5EE3D88F]()
	end
	return CoD.RankUtility.RankInfoTable
end
CoD.RankUtility.GetRankInfoField = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	local f5_local0 = CoD.RankUtility.GetRankInfoTable()
	if f5_local0[f5_arg0] and f5_local0[f5_arg0][f5_arg1] then
		local f5_local1 = f5_local0[f5_arg0][f5_arg1]
		local f5_local2
		if f5_local1 then
			f5_local2 = f5_local1[f5_arg2]
			if not f5_local2 then
			else
				return f5_local2
			end
		end
		f5_local2 = f5_arg3
	else
		return f5_arg3
	end
end
CoD.RankUtility.GetRankIcons = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	local f6_local0 = {}
	if f6_arg3 then
		local f6_local1 = f6_arg3
	end
	local f6_local2 = f6_local1 or CoD.PrestigeUtility.GetCurrentPLevel(f6_arg0, f6_arg1)
	local f6_local3 = IsGameModeParagonCapable(f6_arg1)
	if f6_local3 then
		f6_local3 = f6_local2 == CoD.PrestigeUtility.GetPrestigeCap(f6_arg1)
	end
	if f6_local3 then
		local f6_local4 = Engine[0xA6C26EBACD7322D](f6_arg0, CoD.STATS_LOCATION_NORMAL, f6_arg1)
		local f6_local5 = f6_local4.playerstatslist.paragon_icon_id.statvalue
		if f6_local5 then
			local f6_local6 = f6_local5:get()
		end
		f6_local5 = f6_local6 or CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID
		if f6_local5 ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
			local f6_local7 = Engine[0x1F74502056A1D82](f6_arg1, f6_local5)
			f6_local0.icon = f6_local7.iconName
			f6_local0.iconLarge = f6_local7.iconNameLarge
			return f6_local0
		end
	end
	f6_local0.icon = Engine[0x9C6922557618920](f6_arg2, f6_local2, f6_arg1)
	f6_local0.iconLarge = Engine[0x1F63E4E0932DCCF](f6_arg2, f6_local2, f6_arg1)
	return f6_local0
end
CoD.RankUtility.UpdateRanksForNewRankMode = function()
	local f7_local0 = CoD.RankUtility.CachedRankFieldForRankMode[CoD.RankUtility.GetCurrentRankMode()]
	if not f7_local0 then
		return
	end
	for f7_local4, f7_local5 in pairs(CoD.RankUtility.CachedRankInfo) do
		if f7_local4 ~= Engine[0x5065E759595C457](LuaDefine.INVALID_XUID_X64) and f7_local5[f7_local0] then
			CoD.RankUtility.CreateOrUpdateRankInfoModel(f7_local4, f7_local0, f7_local5[f7_local0])
		end
	end
end
CoD.RankUtility.UpdateRankModeModel = function(f8_arg0, f8_arg1)
	local f8_local0 = Engine[0x8DF2E5447F384B9]()
	f8_local0 = f8_local0.lobbyRoot.rankMode
	local f8_local1 = false
	if f8_arg0 == Enum[0x8409AA0F01B5DBC][0xD42D003CEEA3F87] then
		f8_local1 = f8_local0:set(CoD.RankUtility.RankMode.Arena)
	elseif f8_arg0 == Enum[0x89C1455C5032969][0xD5FBB8D74AC6D62] then
		f8_local1 = f8_local0:set(CoD.RankUtility.RankMode.None)
	else
		f8_local1 = f8_local0:set(LuaUtils.GetEModeForLobbyMainMode(f8_arg1))
	end
	if f8_local1 then
		CoD.RankUtility.UpdateRanksForNewRankMode()
	end
end
CoD.RankUtility.GetCurrentRankMode = function()
	local f9_local0 = Engine[0x8DF2E5447F384B9]()
	return f9_local0.lobbyRoot.rankMode:get()
end
CoD.RankUtility.ConvertCurrentRankModeToString = function(f10_arg0)
	local f10_local0 = CoD.RankUtility.GetCurrentRankMode()
	if f10_local0 == CoD.RankUtility.RankMode.None then
		return 0x2C79EA24AB1A2BA
	elseif f10_local0 == CoD.RankUtility.RankMode.Arena then
		return 0x7D527CD96A3419
	else
		return CoD.DirectorUtility.ConvertEModeToModeString(f10_local0)
	end
end
CoD.RankUtility.ToggleRankMode = function()
	local f11_local0 = Engine[0x8DF2E5447F384B9]()
	f11_local0 = f11_local0.lobbyRoot.rankMode
	local f11_local1 = f11_local0:get()
	if f11_local1 == CoD.RankUtility.RankMode.Multiplayer then
		f11_local0:set(CoD.RankUtility.RankMode.Arena)
	elseif f11_local1 == CoD.RankUtility.RankMode.Arena then
		f11_local0:set(CoD.RankUtility.RankMode.Warzone)
	elseif f11_local1 == CoD.RankUtility.RankMode.Warzone then
		f11_local0:set(CoD.RankUtility.RankMode.Zombies)
	else
		f11_local0:set(CoD.RankUtility.RankMode.Multiplayer)
	end
	CoD.RankUtility.UpdateRanksForNewRankMode()
end
CoD.RankUtility.RestoreRankMode = function()
	local f12_local0 = Engine[0x8DF2E5447F384B9]()
	f12_local0 = f12_local0.lobbyRoot
	CoD.RankUtility.UpdateRankModeModel(f12_local0.lobbyMode:get(), f12_local0.lobbyMainMode:get())
end
CoD.RankUtility.IsCurrentRankModeEqualTo = function(f13_arg0)
	return CoD.RankUtility.GetCurrentRankMode() == f13_arg0
end
CoD.RankUtility.InitRankModeIfSetToNone = function(f14_arg0)
	if CoD.RankUtility.GetCurrentRankMode() == CoD.RankUtility.RankMode.None then
		local f14_local0 = Engine[0x8DF2E5447F384B9]()
		f14_local0 = f14_local0.lobbyRoot.rankMode
		local f14_local1 = Engine[0x19A789A53E7F2F](f14_arg0)
		if f14_local1 then
			if f14_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
				f14_local1 = CoD.RankUtility.RankMode.Multiplayer
			elseif f14_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
				f14_local1 = CoD.RankUtility.RankMode.Zombies
			elseif f14_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
				f14_local1 = CoD.RankUtility.RankMode.Warzone
			elseif f14_local1 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
				f14_local1 = CoD.RankUtility.RankMode.Multiplayer
			end
		else
			f14_local1 = CoD.RankUtility.RankMode.Multiplayer
		end
		f14_local0:set(f14_local1)
	end
end
CoD.RankUtility.HasElementByXUIDEverPlayedMode = function(f15_arg0, f15_arg1)
	if f15_arg1 == Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
		return false
	else
		local f15_local0 = f15_arg0:getModel()
		if not (f15_local0 and f15_local0.xuid) then
			return false
		else
			local f15_local1 = Engine[0x19FAC7D9E55031E]
			local f15_local2 = f15_arg0:getModel()
			f15_local1 = f15_local1(f15_local2.xuid:get(), f15_arg1)
			return f15_local1.played
		end
	end
end
CoD.RankUtility.HasElementByXUIDEverPlayedCurrentMode = function(f16_arg0)
	return CoD.RankUtility.HasElementByXUIDEverPlayedMode(f16_arg0, Engine[0x3EAC408F958FF05]())
end
CoD.RankUtility.GetXUIDRankNumberForMode = function(f17_arg0, f17_arg1)
	if f17_arg0 == Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
		return 0
	else
		local f17_local0 = Engine[0x19FAC7D9E55031E](f17_arg1, f17_arg0)
		return f17_local0.rank or 0
	end
end
CoD.RankUtility.GetXUIDRankNumberForCurrentMode = function(f18_arg0)
	return CoD.RankUtility.GetXUIDRankNumberForMode(Engine[0x3EAC408F958FF05](), f18_arg0)
end
CoD.RankUtility.GetXUIDRankNumberForModeForLocString = function(f19_arg0, f19_arg1)
	return CoD.RankUtility.GetXUIDRankForMode(Engine[0x3EAC408F958FF05](), f19_arg1)
end
CoD.RankUtility.GetXUIDRankNumberForCurrentModeForLocString = function(f20_arg0)
	return CoD.RankUtility.GetXUIDRankNumberForCurrentMode(f20_arg0)
end
CoD.RankUtility.GetXUIDRankNumberForModeForRawString = function(f21_arg0, f21_arg1)
	return CoD.RankUtility.GetXUIDRankForMode(Engine[0x3EAC408F958FF05](), f21_arg1)
end
CoD.RankUtility.GetXUIDRankNumberForCurrentModeForRawString = function(f22_arg0)
	return CoD.RankUtility.GetXUIDRankNumberForCurrentMode(f22_arg0)
end
CoD.RankUtility.GetXUIDRankNumberForModeForColor = function(f23_arg0, f23_arg1)
	return CoD.RankUtility.GetXUIDRankForMode(Engine[0x3EAC408F958FF05](), f23_arg1), 0, 0
end
CoD.RankUtility.GetXUIDRankNumberForCurrentModeForColor = function(f24_arg0)
	return CoD.RankUtility.GetXUIDRankNumberForCurrentMode(f24_arg0), 0, 0
end
CoD.RankUtility.GetXUIDRankStringForMode = function(f25_arg0, f25_arg1)
	if f25_arg0 == Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
		return ""
	else
		local f25_local0 = Engine[0x19FAC7D9E55031E](f25_arg1, f25_arg0)
		return CoD.GetRankName(f25_local0.rank or 0, f25_local0.prestige or 0, f25_arg0)
	end
end
CoD.RankUtility.GetRankStringForModeFromRank = function(f26_arg0, f26_arg1)
	if f26_arg0 == Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
		return ""
	else
		return CoD.GetRankName(f26_arg1 or 0, 0, f26_arg0)
	end
end
CoD.RankUtility.GetXUIDRankStringForCurrentMode = function(f27_arg0)
	return CoD.RankUtility.GetXUIDRankStringForMode(Engine[0x3EAC408F958FF05](), f27_arg0)
end
CoD.RankUtility.GetXUIDRankIconForMode = function(f28_arg0, f28_arg1)
	if f28_arg0 == Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
		return 0x7615068F50B3D66
	else
		local f28_local0 = Engine[0x19FAC7D9E55031E](f28_arg1, f28_arg0)
		if f28_local0.paragonIcon and f28_local0.paragonIcon ~= 0x0 then
			return f28_local0.paragonIcon
		else
			return f28_local0.rankIcon or 0x7615068F50B3D66
		end
	end
end
CoD.RankUtility.GetXUIDRankIconForCurrentMode = function(f29_arg0)
	return CoD.RankUtility.GetXUIDRankIconForMode(Engine[0x3EAC408F958FF05](), f29_arg0)
end
CoD.RankUtility.GetUpdatedLevelNumericValue = function(f30_arg0)
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return CoD.PrestigeUtility.LocalizeIfMaxRank(0x4008CE61FE52DCD, f30_arg0)
	else
		return f30_arg0
	end
end
CoD.RankUtility.GetNextRankXPString = function(f31_arg0, f31_arg1)
	local f31_local0 = CoD.PlayerStatsUtility.GetXPToNextRank(f31_arg0, f31_arg1)
	if f31_local0 == nil or f31_local0 < 0 then
		return ""
	else
		return ConvertToUpperString(LocalizeIntoString(0xB916F8FB1E495C7, f31_local0))
	end
end
CoD.RankUtility.GetNextRankXPStringLong = function(f32_arg0)
	local f32_local0 = f32_arg0
	if f32_local0 == nil or f32_local0 < 0 then
		return ""
	else
		return ConvertToUpperString(LocalizeIntoString(0x2B924F206C5B4D8, f32_local0))
	end
end
CoD.RankUtility.GetInGameColorForRankTextByRank = function(f33_arg0)
	if (tonumber(f33_arg0) or 0) > CoD.RankUtility.GetRankCap() + 1 then
		return CoD.ColorUtility.ConvertTableToRGB(ColorSet.PlayerParagonOrange)
	else
		return CoD.ColorUtility.ConvertTableToRGB(ColorSet.White)
	end
end
CoD.RankUtility.GetInGameColorForRankTextByNextRank = function(f34_arg0)
	return CoD.RankUtility.GetInGameColorForRankTextByRank((tonumber(f34_arg0) or 0) - 1)
end
CoD.RankUtility.GetWZRankAndCallingCards = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = Engine[0xA6C26EBACD7322D](f35_arg0, CoD.STATS_LOCATION_NORMAL, f35_arg1)
	local f35_local1 = f35_local0 and LUI.getTableFromFieldList({
		0xD59E8BFAC78A33B,
		0xDB3201FD1EB3847,
		0x3BF77799B56C06C,
	}, f35_local0)
	local f35_local2
	if f35_local1 then
		f35_local2 = f35_local1:get()
		if not f35_local2 then
		else
			return f35_local2, {
				{
					rank = 19,
					icon = 491,
					title = 0x288B888A042968,
					desc = 0xD4D5B1E368B30B0,
				},
				{
					rank = 39,
					icon = 492,
					title = 0x3C8F888A14D93E,
					desc = 0x77B9D8C1CCFC88E,
				},
				{
					rank = 59,
					icon = 493,
					title = 0x3603888A0F7FAC,
					desc = 0xB6B871AB5495C54,
				},
				{
					rank = 79,
					icon = 494,
					title = 0x14078889F2A012,
					desc = 0x83CE3876CB33942,
				},
			}
		end
	end
	f35_local2 = 0
end
CoD.RankUtility.GetWLRankAndCallingCards = function(f36_arg0, f36_arg1, f36_arg2)
	return CoD.ArenaLeaguePlayUtility.GetRankAndRankData(CoD.ArenaLeaguePlayUtility.GetPoints(f36_arg0)), {
		{
			rank = 5,
			icon = 662,
			title = 0x84962EA52F18F64,
			desc = Engine[0xF9F1239CFD921FE](0x752377F44F1411C, 5),
		},
		{
			rank = 10,
			icon = 663,
			title = 0x738EAF585D864A6,
			desc = Engine[0xF9F1239CFD921FE](0x752377F44F1411C, 10),
		},
		{
			rank = 15,
			icon = 664,
			title = 0x6D30ACBCDAE4C43,
			desc = Engine[0xF9F1239CFD921FE](0x752377F44F1411C, 15),
		},
		{
			rank = 20,
			icon = 665,
			title = 0x902E680A2D39DB7,
			desc = Engine[0xF9F1239CFD921FE](0x752377F44F1411C, 20),
		},
		{
			rank = 25,
			icon = 666,
			title = 0xA32F6689586A8E2,
			desc = Engine[0xF9F1239CFD921FE](0x752377F44F1411C, 25),
		},
		{
			rank = 30,
			icon = 667,
			title = 0x61DD28BADA5047C,
			desc = Engine[0xF9F1239CFD921FE](0x752377F44F1411C, 30),
		},
	}
end
CoD.RankUtility.AddRankCallingCards = function(f37_arg0, f37_arg1, f37_arg2)
	if type(f37_arg2) ~= "table" then
		return
	end
	local f37_local0, f37_local1 = nil
	if f37_arg1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f37_local1, f37_local0 = CoD.RankUtility.GetWZRankAndCallingCards(f37_arg0, f37_arg1, f37_arg2)
	elseif f37_arg1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f37_local1, f37_local0 = CoD.RankUtility.GetWLRankAndCallingCards(f37_arg0, f37_arg1, f37_arg2)
	end
	local f37_local2 = false
	if f37_arg1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and CoD.PrestigeUtility.GetCurrentPLevel(f37_arg0, f37_arg1) > 0 then
		f37_local2 = true
	end
	if f37_local0 then
		for f37_local6, f37_local7 in ipairs(f37_local0) do
			if f37_local7.rank <= f37_local1 or f37_local2 then
				table.insert(f37_arg2, {
					models = {
						title = CoD.BaseUtility.LocalizeIfXHash(f37_local7.title),
						description = CoD.BaseUtility.LocalizeIfXHash(f37_local7.desc),
						iconId = f37_local7.icon,
						icon = CoD.ChallengesUtility.GetBackgroundByID(f37_local7.icon),
						maxTier = 0,
						currentTier = 0,
						statPercent = 1,
						xp = 0,
						percentComplete = 1,
						isLocked = false,
					},
					properties = {
						isRank = true,
					},
				})
			end
		end
	end
end
CoD.RankUtility.GetRankMasterCard = function(f38_arg0, f38_arg1)
	local f38_local0 = Engine[0xA6C26EBACD7322D](f38_arg0, CoD.STATS_LOCATION_NORMAL, f38_arg1)
	local f38_local1 = f38_local0 and LUI.getTableFromFieldList({
		0xD59E8BFAC78A33B,
		0xDB3201FD1EB3847,
		0x3BF77799B56C06C,
	}, f38_local0)
	local f38_local2
	if f38_local1 then
		f38_local2 = f38_local1:get()
		if not f38_local2 then
		else
			local f38_local3 = CoD.RankUtility.GetRankCap(f38_arg1)
			local f38_local4 = false
			if f38_arg1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and CoD.PrestigeUtility.GetCurrentPLevel(f38_arg0, f38_arg1) > 0 then
				f38_local4 = true
			end
			if f38_local2 ~= f38_local3 and not f38_local4 then
				return nil
			else
				return {
					models = {
						title = Engine[0xF9F1239CFD921FE](0xA8EACFC7218E6F8),
						description = Engine[0xF9F1239CFD921FE](0x4CAE68EF156D20),
						iconId = 495,
						icon = CoD.ChallengesUtility.GetBackgroundByID(495),
						maxTier = 0,
						currentTier = 0,
						statPercent = 1,
						xp = 0,
						percentComplete = 1,
						isLocked = false,
					},
					properties = {
						isRank = true,
					},
				}
			end
		end
	end
	f38_local2 = 0
end
CoD.RankUtility.CachedRankInfo = {
	[Engine[0x5065E759595C457](LuaDefine.INVALID_XUID_X64)] = {
		mp = 0,
		wz = 0,
		zm = 0,
		arena = 0,
		mpIcon = 0x7615068F50B3D66,
		wzIcon = 0x7615068F50B3D66,
		zmIcon = 0x7615068F50B3D66,
		arenaIcon = 0x7615068F50B3D66,
		arenaSkillDivisionIcon = 0x7615068F50B3D66,
	},
}
CoD.RankUtility.CachedRankFieldForRankMode = {
	[CoD.RankUtility.RankMode.Multiplayer] = "mp",
	[CoD.RankUtility.RankMode.Warzone] = "wz",
	[CoD.RankUtility.RankMode.Zombies] = "zm",
	[CoD.RankUtility.RankMode.Arena] = "arena",
}
CoD.RankUtility.GetClientRankInfoModel = function(f39_arg0)
	local f39_local0 = DataSources.ClientsRankInfo.getModel()
	return f39_local0[Engine[0x5065E759595C457](f39_arg0)]
end
CoD.RankUtility.CreateClientRankInfoModel = function(f40_arg0)
	local f40_local0 = DataSources.ClientsRankInfo.getModel()
	return f40_local0:create(Engine[0x5065E759595C457](f40_arg0))
end
CoD.RankUtility.CreateOrUpdateRankInfoModel = function(f41_arg0, f41_arg1, f41_arg2)
	CoD.RankUtility.CachedRankInfo[f41_arg0].current = f41_arg1
	local f41_local0 = DataSources.ClientsRankInfo.getModel()
	local f41_local1 = f41_local0[f41_arg0]
	if not f41_local1 then
		f41_local1 = f41_local0:create(f41_arg0)
		f41_local1:create("displayRank")
		f41_local1:create("rankIcon")
		f41_local1:create("rankTitle")
		f41_local1:create("isParagon")
		f41_local1:create("arenaWinStreak")
		f41_local1:create("arenaLeaguePlayFirstSubdivisionRankStreak")
		f41_local1:create("arenaLeaguePlayPoints")
		f41_local1:create("skillDivisionIcon")
	end
	for f41_local5, f41_local6 in pairs(f41_arg2) do
		f41_local1[f41_local5]:set(f41_local6)
	end
end
CoD.RankUtility.UpdateRankForClientCommon = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4, f42_arg5)
	local f42_local0 = CoD.RankUtility.CachedRankInfo[f42_arg0]
	local f42_local1 = f42_local0 and f42_local0[f42_arg1]
	local f42_local2 = true
	if f42_local1 then
		if f42_local0.current == f42_arg1 and f42_local1.displayRank == f42_arg2 and f42_local1.rankIcon == f42_arg3 and f42_local1.rankTitle == f42_arg4 and f42_local1.isParagon == f42_arg5 then
			f42_local2 = false
		end
	else
		if not f42_local0 then
			CoD.RankUtility.CachedRankInfo[f42_arg0] = {}
			f42_local0 = CoD.RankUtility.CachedRankInfo[f42_arg0]
		end
		f42_local0[f42_arg1] = {}
		f42_local1 = f42_local0[f42_arg1]
	end
	if f42_local2 then
		f42_local1.displayRank = f42_arg2
		f42_local1.rankIcon = f42_arg3
		f42_local1.rankTitle = f42_arg4
		f42_local1.isParagon = f42_arg5
	end
	return f42_local1, f42_local2
end
CoD.RankUtility.UpdateMPRankForClient = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4, f43_arg5)
	local f43_local0 = Engine[0x5065E759595C457](f43_arg0)
	local f43_local1, f43_local2 = CoD.RankUtility.UpdateRankForClientCommon(f43_local0, "mp", tostring(f43_arg1), f43_arg2, f43_arg3, f43_arg4)
	if f43_arg5 and f43_local2 then
		CoD.RankUtility.CreateOrUpdateRankInfoModel(f43_local0, "mp", f43_local1)
	end
end
CoD.RankUtility.UpdateWZRankForClient = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4, f44_arg5)
	local f44_local0 = Engine[0x5065E759595C457](f44_arg0)
	local f44_local1, f44_local2 = CoD.RankUtility.UpdateRankForClientCommon(f44_local0, "wz", f44_arg1, f44_arg2, f44_arg3, f44_arg4)
	if f44_arg5 and f44_local2 then
		CoD.RankUtility.CreateOrUpdateRankInfoModel(f44_local0, "wz", f44_local1)
	end
end
CoD.RankUtility.UpdateZMRankForClient = function(f45_arg0, f45_arg1, f45_arg2, f45_arg3, f45_arg4, f45_arg5)
	local f45_local0 = Engine[0x5065E759595C457](f45_arg0)
	local f45_local1, f45_local2 = CoD.RankUtility.UpdateRankForClientCommon(f45_local0, "zm", tostring(f45_arg1), f45_arg2, f45_arg3, f45_arg4)
	if f45_arg5 and f45_local2 then
		CoD.RankUtility.CreateOrUpdateRankInfoModel(f45_local0, "zm", f45_local1)
	end
end
CoD.RankUtility.UpdateArenaRankForClient = function(f46_arg0, f46_arg1, f46_arg2, f46_arg3, f46_arg4, f46_arg5, f46_arg6, f46_arg7, f46_arg8, f46_arg9)
	local f46_local0 = Engine[0x5065E759595C457](f46_arg0)
	local f46_local1, f46_local2 = CoD.RankUtility.UpdateRankForClientCommon(f46_local0, "arena", tostring(f46_arg1), f46_arg2, f46_arg3, f46_arg4)
	if f46_local1.arenaWinStreak ~= f46_arg5 or f46_local1.arenaLeaguePlayFirstSubdivisionRankStreak ~= f46_arg6 or f46_local1.arenaLeaguePlayPoints ~= f46_arg7 or f46_local1.skillDivisionIcon ~= f46_arg8 then
		f46_local2 = true
		f46_local1.arenaWinStreak = f46_arg5
		f46_local1.arenaLeaguePlayFirstSubdivisionRankStreak = f46_arg6
		f46_local1.arenaLeaguePlayPoints = f46_arg7
		f46_local1.skillDivisionIcon = f46_arg8
	end
	if f46_arg9 and f46_local2 then
		CoD.RankUtility.CreateOrUpdateRankInfoModel(f46_local0, "arena", f46_local1)
	end
end
DataSourceHelpers.GlobalDataSourceSetup("ClientsRankInfo", "ClientsRankInfo", function(f47_arg0, f47_arg1)
	local f47_local0 = {}
	CoD.RankUtility.CreateOrUpdateRankInfoModel(Engine[0x5065E759595C457](LuaDefine.INVALID_XUID_X64), "none", {
		displayRank = "",
		rankIcon = 0x7615068F50B3D66,
		arenaLeaguePlayFirstSubdivisionRankStreak = 0,
	})
end, false)
