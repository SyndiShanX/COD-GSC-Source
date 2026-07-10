require("x64:53e8db3768fb02a")
Lobby.Stats = {}
Lobby.Stats.WritePlayerStatToMissionStat = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	f1_arg1.PlayerStatsByMap[f1_arg2].currentStats[f1_arg3]:set(f1_arg1.PlayerStatsList[f1_arg3].statValue:get())
end
Lobby.Stats.WriteMissionStats = function(f2_arg0, f2_arg1, f2_arg2)
	if not f2_arg1.PlayerStatsByMap[f2_arg2] then
		return
	end
	statNames = {
		"SCORE",
		"KILLS",
		"INCAPS",
		"ASSISTS",
		"REVIVES",
	}
	for f2_local3, f2_local4 in pairs(statNames) do
		Lobby.Stats.WritePlayerStatToMissionStat(f2_arg0, f2_arg1, f2_arg2, f2_local4)
	end
	for f2_local0 = 0, 5, 1 do
		f2_arg1.PlayerStatsByMap[f2_arg2].previousCompletedDifficulties[f2_local0]:set(f2_arg1.PlayerStatsByMap[f2_arg2].completedDifficulties[f2_local0]:get())
		f2_arg1.PlayerStatsByMap[f2_arg2].previousReceivedXPForDifficulty[f2_local0]:set(f2_arg1.PlayerStatsByMap[f2_arg2].receivedXPForDifficulty[f2_local0]:get())
	end
end
Lobby.Stats.WriteCurrentDecorations = function(f3_arg0, f3_arg1)
	for f3_local0 = 0, 19, 1 do
		f3_arg1.currentPlayerCPDecorations[f3_local0]:set(f3_arg1.PlayerCPDecorations[f3_local0]:get())
	end
end
Lobby.Stats.WriteCurrentRankXP = function(f4_arg0, f4_arg1)
	f4_arg1.currentRankXP:set(f4_arg1.PlayerStatsList.RANKXP.statValue:get())
end
Lobby.Stats.WriteCurrentWeaponLevels = function(f5_arg0, f5_arg1)
	for f5_local0 = 1, 58, 1 do
		f5_arg1.currentWeaponLevels[f5_local0]:set(Engine[@"getguncurrentrank"](f5_arg0, f5_local0))
	end
end
Lobby.Stats.WriteCurrentCPStats = function(f6_arg0, f6_arg1)
	if f6_arg1 == nil then
		f6_arg1 = Engine[@"lobbygetmap"]()
	end
	local f6_local0 = LuaUtils.GetMapsTable()
	f6_local0 = f6_local0[f6_arg1]
	if f6_local0 ~= nil and f6_local0.rootMapName ~= nil then
		local f6_local1 = Engine[@"getplayerstats"](f6_arg0)
		Lobby.Stats.WriteCurrentWeaponLevels(f6_arg0, f6_local1)
		Lobby.Stats.WriteCurrentRankXP(f6_arg0, f6_local1)
		Lobby.Stats.WriteCurrentDecorations(f6_arg0, f6_local1)
		Lobby.Stats.WriteMissionStats(f6_arg0, f6_local1, f6_local0.rootMapName)
		Engine[@"exec"](f6_arg0, "uploadstats")
		Engine[@"exec"](f6_arg0, "savegamerprofilestats")
	end
end
Lobby.Stats.PreMatchValidateStats = function(f7_arg0, f7_arg1) end
Lobby.Stats.OnMatchStart = function(f8_arg0)
	Engine[@"exec"](nil, "sv_ae_init")
	local f8_local0 = Engine[@"getprimarycontroller"]()
	if f8_local0 ~= nil then
		Lobby.BlackMarket.ClearTierSkips(f8_local0)
		local f8_local1 = Engine[@"getmodelforcontroller"](f8_local0)
		if f8_local1 ~= nil then
			local f8_local2 = f8_local1:create("AARPreMatch", true)
			if f8_local2 ~= nil then
				local f8_local3 = f8_local2:create("currentSeasonTiers", true)
				if f8_local3 ~= nil then
					local f8_local4 = CoDShared.Loot.GetCurrentSeason()
					if f8_local4 ~= nil then
						f8_local3:set(Engine[@"hash_6159D7050715A2C3"](f8_local0, f8_local4))
					end
				end
			end
		end
	end
	if Engine[@"iscampaigngame"]() then
		local f8_local1 = Engine[@"getprimarycontroller"]()
		if Engine[@"getsavedmap"]() ~= Engine[@"lobbygetmap"]() then
			Lobby.Stats.WriteCurrentCPStats(f8_local1)
		end
		local f8_local3 = LuaUtils.GetMapsTable()
		f8_local3 = f8_local3[mapName]
		if f8_local3 ~= nil and f8_local3.rootMapName ~= nil then
			Engine[@"setupfieldopskitloadouts"](f8_local3.rootMapName)
		end
	end
end
Lobby.Stats.OnWarzoneMatchStart = function(f9_arg0)
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		for f9_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
			local f9_local3 = Engine[@"getplayerstats"](f9_local0, Engine[0x8E494FC6037B54]())
			if f9_local3 then
				f9_local3[@"afteractionreportstats"][@"gametype"]:set(Engine[@"lobbygetgametype"]())
				f9_local3[@"afteractionreportstats"][@"characterindex"]:set(Engine[@"getcharacterindexforclientnum"](f9_local0, Engine[@"getclientnum"](f9_local0)))
			end
		end
	end
end
Lobby.Stats.OnUILoad = function(f10_arg0)
	if f10_arg0.init == true or f10_arg0.frontend == false then
		return
	elseif Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		for f10_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
			local f10_local3 = Engine[@"getplayerstats"](f10_local0, Engine[@"hash_4E038E13929C6347"]())
			local f10_local4 = Engine[@"getplayerstats"](f10_local0, Engine[0x8E494FC6037B54]())
			if f10_local3 and f10_local4 then
				local f10_local5 = f10_local4[@"afteractionreportstats"]
				local f10_local6 = f10_local5[@"gametype"]:get()
				if f10_local6 ~= "" then
					local f10_local7 = Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](f10_local6))
					local f10_local8 = f10_local4[@"playerstatsbygametype"][f10_local7]
					local f10_local9 = f10_local3[@"playerstatsbygametype"][f10_local7]
					local f10_local10 = (f10_local8[@"prevscoreindex"]:get() + 1) % 10
					f10_local8[@"prevscoreindex"]:set(f10_local10)
					local f10_local11 = f10_local8[@"prevscores"][f10_local10]
					local f10_local12 = function(f11_arg0)
						return f10_local8[f11_arg0].statValue:get()
					end
					local f10_local13 = function(f12_arg0, f12_arg1)
						f10_local8[f12_arg0].statValue:set(f12_arg1)
					end
					local f10_local14 = function(f13_arg0)
						return f10_local8[f13_arg0].statValue:get() - f10_local9[f13_arg0].statValue:get()
					end
					local f10_local15 = f10_local14(@"total_damage")
					f10_local11[@"damage"]:set(f10_local15)
					if f10_local12(@"hash_15B27DF39A4715A3") < f10_local15 then
						f10_local13(@"hash_15B27DF39A4715A3", f10_local15)
					end
					local f10_local16 = f10_local14(@"kills")
					f10_local11[@"kills"]:set(f10_local16)
					if f10_local12(@"hash_6E4E1EB9512BA7B5") < f10_local16 then
						f10_local13(@"hash_6E4E1EB9512BA7B5", f10_local16)
					end
					f10_local11[@"score"]:set(0)
					f10_local11[@"timeplayed"]:set(f10_local14(@"time_played_total"))
					f10_local11[@"ekia"]:set(f10_local14(@"ekia"))
					f10_local11[@"deaths"]:set(f10_local14(@"deaths"))
					f10_local11[@"placement_player"]:set(f10_local5[@"placement_player"]:get())
					f10_local11[@"placement_team"]:set(f10_local5[@"placement_team"]:get())
					f10_local11[@"valid"]:set(1)
					Engine[@"storagewrite"](f10_local0, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"])
				end
			end
		end
	end
end
Lobby.Stats.OnMatchLaunchClient = function(f14_arg0)
	if Engine[@"iscampaigngame"]() then
		Lobby.Stats.WriteCurrentCPStats(Engine[@"getprimarycontroller"]())
	end
end
Lobby.Stats.OnMatchChangeMap = function(f15_arg0)
	if Engine[@"iscampaigngame"]() then
		local f15_local0 = Engine[@"getprimarycontroller"]()
		local f15_local1, f15_local2 = nil
		if f15_arg0.currentMap ~= nil and f15_arg0.currentMap ~= "" then
			local f15_local3 = LuaUtils.GetMapsTable()
			f15_local1 = f15_local3[f15_arg0.currentMap]
		end
		if f15_arg0.nextMap ~= nil and f15_arg0.nextMap ~= "" then
			local f15_local3 = LuaUtils.GetMapsTable()
			f15_local2 = f15_local3[f15_arg0.nextMap]
		end
		if f15_local2 == nil then
			return
		elseif f15_local1 ~= nil and f15_local1.isSafeHouse then
			Lobby.Stats.WriteCurrentCPStats(f15_local0, f15_arg0.nextMap)
			return
		end
	end
end
Lobby.Stats.ClearValidationEvent = function(f16_arg0)
	if f16_arg0 ~= nil and f16_arg0.validationEvent:get() ~= "" then
		f16_arg0.validationEvent:set("")
	end
end
Lobby.Stats.SpecialistErrorDetected = function(f17_arg0, f17_arg1, f17_arg2)
	f17_arg2.cacloadouts.charactercontext.characterindex:set(0)
	f17_arg2.cacloadouts.herogadget:set(0)
	f17_arg2.cacloadouts.heroweapon:set(113)
end
Lobby.Stats.IsWeaponValid = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	return true
end
Lobby.Stats.LoadoutErrorDetected = function(f19_arg0, f19_arg1)
	LuaUtils.ClearDDLKeysAndArrays(f19_arg1, {
		structArrays = {
			primary = {
				keys = {
					"itemIndex",
				},
				arrays = {
					"attachment",
				},
			},
			secondary = {
				keys = {
					"itemIndex",
				},
				arrays = {
					"attachment",
				},
			},
		},
	})
end
Lobby.Stats.KillstreakErrorDetected = function(f20_arg0, f20_arg1)
	f20_arg1:set(0)
end
Lobby.Stats.GetDefaultSprayGestures = function()
	if not Lobby.Stats.DefaultSprayGesturesTable then
		Lobby.Stats.DefaultSprayGesturesTable = {}
		for f21_local3, f21_local4 in ipairs(Engine[@"hash_2B2E4CCC119597B0"]()) do
			if f21_local4[@"isdefault"] and f21_local4[@"isdefault"] == 1 then
				table.insert(Lobby.Stats.DefaultSprayGesturesTable, f21_local3)
			end
		end
	end
	return Lobby.Stats.DefaultSprayGesturesTable
end
Lobby.Stats.ValidateCharacterOutfits = function(f22_arg0, f22_arg1)
	if f22_arg0 then
		for f22_local16, f22_local17 in ipairs(Engine[@"hash_31657A284F55F9CD"](f22_arg1)) do
			local f22_local18 = f22_local17.bodyIndex
			local f22_local19 = f22_arg0[f22_local18]
			if f22_local19 then
				local f22_local3 = function(f23_arg0, f23_arg1)
					local f23_local0 = f23_arg1:get()
					if not f23_arg0 or not f23_arg0[f23_local0 + 1] or not f23_arg0[f23_local0 + 1].isValid then
						f23_arg1:set(0)
					end
				end
				local f22_local4 = Engine[@"hash_55284767BCC0915E"](f22_arg1, f22_local18)
				f22_local3(f22_local4.outfits, f22_local19[@"selectedoutfit"])
				f22_local3(f22_local4.outfits, f22_local19[@"hash_4D9FCEAC8FF24CBD"])
				for f22_local13, f22_local14 in ipairs(f22_local4.outfits) do
					local f22_local15 = f22_local19[@"hash_E5C77948998E49"][f22_local13 - 1]
					if f22_local15 then
						for f22_local11, f22_local12 in ipairs(CoDLoadoutsShared.characterCustomizationRegions) do
							f22_local3(f22_local14[f22_local12.name], f22_local15[@"hash_212BCDFA518CC913"][f22_local12.stat])
						end
					end
				end
			end
		end
	end
end
Lobby.Stats.FixupCAC = function(f24_arg0, f24_arg1)
	local f24_local0 = function(f25_arg0, f25_arg1)
		local f25_local0 = f25_arg0[@"itemindex"]:get()
		local f25_local1 = Engine[@"getnumattachments"](f25_local0, f25_arg1)
		for f25_local2 = 0, #f25_arg0[@"attachment"] - 1, 1 do
			attachmentIndex = f25_arg0[@"attachment"][f25_local2]:get()
			attachmentRef = Engine[@"getattachmentref"](f25_local0, attachmentIndex, f25_arg1)
			if f25_local1 <= attachmentIndex and attachmentRef ~= "clantag" and attachmentRef ~= "killcounter" and attachmentRef ~= "custom2" then
				f25_arg0[@"attachment"][f25_local2]:set(0)
			end
		end
		local f25_local2 = f25_arg0[@"weaponmodelslot"]:get()
		if f25_local2 > 0 then
			local f25_local3 = Engine[@"hash_7B98952F69D937F9"](f25_local0)
			if f25_local3 ~= 0x0 then
				local f25_local4 = Engine[@"hash_79F0BB7D52A7A978"](f25_local3)
				local f25_local5 = false
				for f25_local9, f25_local10 in ipairs(f25_local4) do
					if f25_local10[@"index"] == f25_local2 then
						f25_local5 = true
						break
					end
				end
				if not f25_local5 then
					f25_arg0[@"weaponmodelslot"]:set(0)
				end
			end
		end
	end
	if f24_arg0 then
		for f24_local1 = 0, #f24_arg0[@"customclass"] - 1, 1 do
			local f24_local4 = f24_arg0[@"customclass"][f24_local1]
			f24_local0(f24_local4[@"primary"], f24_arg1)
			f24_local0(f24_local4[@"secondary"], f24_arg1)
		end
	end
end
Lobby.Stats.OnMPLoadoutsDownloaded = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = Enum[@"emodes"][@"mode_multiplayer"]
	local f26_local1 = Engine[@"getherolist"](f26_local0)
	local f26_local2 = Engine[@"storagegetbuffer"](f26_arg0, f26_arg1)
	if f26_local2 ~= nil then
		local f26_local3 = f26_local2[f26_arg2]
		if f26_local3 then
			local f26_local4 = function(f27_arg0, f27_arg1)
				if f27_arg1 and f27_arg0[@"requireddvar"] and f27_arg0[@"requireddvar"] ~= 0x0 then
					return false
				elseif (f26_arg1 == Enum[@"storagefiletype"][0x67DF1879D992E] or f26_arg1 == Enum[@"storagefiletype"][@"hash_CEBE62E27709AD0"]) and CoDLoadoutsShared.ArenaHiddenPositionRoles[Engine[@"hash_682C5756563934AE"](f26_local0, f27_arg0.bodyIndex)] then
					return false
				else
					local f27_local0 = Engine[@"getrolecategoryforhero"](f26_local0, f27_arg0.bodyIndex)
					return f27_local0 and f27_local0[@"enabled"] ~= 0
				end
			end
			if f26_arg1 == Enum[@"storagefiletype"][@"storage_mp_loadouts"] then
				local f26_local5 = f26_local3.characterContext.characterIndex
				local f26_local6 = nil
				for f26_local10, f26_local11 in ipairs(f26_local1) do
					if f26_local11.bodyIndex == f26_local5:get() then
						f26_local6 = f26_local11
						break
					end
				end
				if not f26_local6 or not f26_local4(f26_local6, false) then
					f26_local7 = {}
					for f26_local11, f26_local12 in ipairs(f26_local1) do
						if f26_local4(f26_local12, true) then
							table.insert(f26_local7, f26_local12.bodyIndex)
						end
					end
					if #f26_local7 > 0 then
						f26_local5:set(math.random(#f26_local7))
					end
				end
				for f26_local10, f26_local11 in ipairs(Lobby.Stats.GetDefaultSprayGestures()) do
					f26_local3[@"hash_F48E22CED35E56D"][f26_local11]:set(1)
				end
				for f26_local10, f26_local11 in ipairs(f26_local1) do
					local f26_local12 = f26_local11.bodyIndex
					if f26_local3[@"characters"] and f26_local3[@"characters"][f26_local12] and f26_local3[@"characters"][f26_local12][@"outfit_breadcrumbs"] then
						f26_local3[@"characters"][f26_local12][@"outfit_breadcrumbs"][0][@"hash_63930AAFA5D6AC7B"][0]:set(1)
						for f26_local19, f26_local20 in DDLUtils.ipairs(f26_local3[@"characters"][f26_local12][@"outfit_breadcrumbs"]) do
							for f26_local16, f26_local17 in DDLUtils.pairs(f26_local20[@"parts"]) do
								f26_local17[@"hash_3D834AEE4BD18D13"][0]:set(1)
							end
						end
					end
				end
				Lobby.Stats.ValidateCharacterOutfits(f26_local3[@"characters"], f26_local0)
			end
			Lobby.Stats.FixupCAC(f26_local3, f26_local0)
			Engine[@"storagewrite"](f26_arg0, f26_arg1)
		end
	end
end
Lobby.Stats.GetPrestigePermanentUnlocks = function(f28_arg0)
	local f28_local0 = 0
	for f28_local1 = 0, 19, 1 do
		if f28_arg0.prestigeTokens[f28_local1].tokenSpent:get() == 1 and 0 < f28_arg0.prestigeTokens[f28_local1].itemunlocked:get() then
			f28_local0 = f28_local0 + 1
		end
	end
	return f28_local0
end
Lobby.Stats.OnMPStatsDownloaded = function(f29_arg0)
	if not Engine[@"storageisfileready"](f29_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"]) then
		return
	else
		Lobby.Stats.ClearValidationEvent(Engine[@"storagegetbuffer"](f29_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"]))
	end
end
Lobby.Stats.OnMPStatsUploaded = function(f30_arg0)
	Lobby.Stats.ClearValidationEvent(Engine[@"storagegetbuffer"](f30_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"]))
end
Lobby.Stats.OnMPOnlineStatsDownloaded = function(f31_arg0)
	local f31_local0 = Engine[@"storagegetbuffer"](f31_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	local f31_local1 = 381
	for f31_local2 = 0, f31_local1, 1 do
		if f31_local0[@"icon_owned"] then
			f31_local0[@"icon_owned"][f31_local2]:set(CoDLootShared.ItemOwnedValue)
		end
		if f31_local0[@"hash_42799A890D40252F"][f31_local2] then
			f31_local0[@"hash_42799A890D40252F"][f31_local2]:set(CoDLootShared.ItemNewValue)
		end
	end
	for f31_local6, f31_local7 in ipairs({
		383,
		384,
		391,
		392,
	}) do
		if f31_local0[@"icon_owned"] then
			f31_local0[@"icon_owned"][f31_local7]:set(CoDLootShared.ItemOwnedValue)
		end
		if f31_local0[@"hash_42799A890D40252F"] then
			f31_local0[@"hash_42799A890D40252F"][f31_local7]:set(CoDLootShared.ItemNewValue)
		end
	end
	f31_local3 = 10
	for f31_local4 = 0, f31_local1, 1 do
		if f31_local0[@"hash_58BB06B8B337E385"] then
			f31_local0[@"hash_58BB06B8B337E385"][f31_local4]:set(CoDLootShared.ItemOwnedValue)
		end
		if f31_local0[@"hash_1D45B221DEE76EE4"] then
			f31_local0[@"hash_1D45B221DEE76EE4"][f31_local4]:set(CoDLootShared.ItemNewValue)
		end
	end
	for f31_local8, f31_local9 in ipairs({
		407,
		408,
		409,
		410,
		411,
	}) do
		if f31_local0[@"hash_58BB06B8B337E385"] then
			f31_local0[@"hash_58BB06B8B337E385"][f31_local9]:set(CoDLootShared.ItemOwnedValue)
		end
		if f31_local0[@"hash_1D45B221DEE76EE4"] then
			f31_local0[@"hash_1D45B221DEE76EE4"][f31_local9]:set(CoDLootShared.ItemNewValue)
		end
	end
	Engine[@"storagewrite"](f31_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
end
Lobby.Stats.OnZMOnlineStatsDownloaded = function(f32_arg0) end
Lobby.Stats.OnCPOnlineLoadoutsDownloaded = function(f33_arg0)
	local f33_local0 = Engine[@"storagegetbuffer"](f33_arg0, Enum[@"storagefiletype"][@"storage_cp_loadouts"])
	if f33_local0 then
		local f33_local1 = f33_local0.cacLoadouts
		if f33_local1 then
			local f33_local2 = Engine[@"getherolist"](Enum[@"emodes"][@"mode_campaign"])
			for f33_local3 = 0, #f33_local2 - 1, 1 do
				if f33_local1.characters[f33_local3].itemList then
					f33_local1.characters[f33_local3].itemList.body.items[0].markedOld:set(1)
					f33_local1.characters[f33_local3].itemList.helmet.items[0].markedOld:set(1)
					f33_local1.characters[f33_local3].itemList.helmet.items[1].markedOld:set(1)
				end
			end
			Engine[@"storagewrite"](f33_arg0, Enum[@"storagefiletype"][@"storage_cp_loadouts"])
		end
	end
end
Lobby.Stats.UpdateWZStatsCheck = function(f34_arg0)
	if not Engine[@"storageisfileready"](f34_arg0.controller, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"]) then
		return
	elseif f34_arg0.fromVersion == nil or f34_arg0.toVersion == nil or f34_arg0.fromVersion >= 103 then
		return
	end
	local f34_local0 = Engine[@"storagegetbuffer"](f34_arg0.controller, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"])
	local f34_local1 = f34_local0[@"hash_3426CDF8D9F44EB8"]
	if f34_local1 ~= nil and f34_local1:get() == 0 then
		local f34_local2 = {
			[@"user_id"] = Engine[@"getxuid64"](f34_arg0.controller),
			[@"rankxp"] = f34_local0[@"playerstatslist"][@"rankxp"][@"statvalue"]:get(),
			[@"challengexp"] = f34_local0[@"playerstatslist"][@"challengexp"][@"statvalue"]:get(),
			[@"killxp"] = f34_local0[@"playerstatslist"][@"killxp"][@"statvalue"]:get(),
			[@"placementxp"] = f34_local0[@"playerstatslist"][@"placementxp"][@"statvalue"]:get(),
			[@"winxp"] = f34_local0[@"playerstatslist"][@"winxp"][@"statvalue"]:get(),
		}
		local f34_local3 = function(f35_arg0)
			for f35_local3, f35_local4 in pairs({
				@"rankxp",
				@"challengexp",
				@"killxp",
				@"placementxp",
				@"winxp",
				@"lastxp",
				@"maxxp",
				@"minxp",
			}) do
				f35_arg0[f35_local4][@"statvalue"]:set(f35_arg0[f35_local4][@"statvalue"]:get() * 10)
			end
		end
		f34_local3(f34_local0[@"playerstatslist"])
		for f34_local7, f34_local8 in DDLUtils.pairs(f34_local0[@"playerstatsbygametype"]) do
			f34_local3(f34_local0[@"playerstatsbygametype"][f34_local7])
		end
		f34_local1:set(1)
		Engine[@"storagewrite"](f34_arg0.controller, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"])
		Engine[0xDE279ECDDDD966](f34_arg0.controller, @"hash_13AA8F200F54CE0E", f34_local2)
	end
end
Lobby.Stats.ValidateWZCharacterSelection = function(f36_arg0)
	if not Engine[@"storageisfileready"](f36_arg0, Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"]) or not Engine[@"storageisfileready"](f36_arg0, Enum[@"storagefiletype"][@"storage_wz_loadouts"]) or not Engine[@"storageisfileready"](f36_arg0, Enum[@"storagefiletype"][@"storage_wz_loadouts_offline"]) or not Engine[@"storageisfileready"](f36_arg0, Enum[@"storagefiletype"][@"storage_wz_loadouts_custom"]) or not Engine[@"storageisfileready"](f36_arg0, Enum[@"storagefiletype"][@"storage_common_settings"]) then
		return
	end
	local f36_local0 = Lobby.CharacterSelection.GetValidWarzoneCharacterSelections(f36_arg0)
	local f36_local1 = Lobby.CharacterSelection.GetDefaultWarzoneCharacters(f36_arg0)
	local f36_local2 = f36_local1[math.random(1, #f36_local1)]
	local f36_local3 = function(f37_arg0)
		local f37_local0 = f37_arg0:get()
		for f37_local4, f37_local5 in ipairs(f36_local0) do
			if f37_local0 == f37_local5 then
				return true
			end
		end
		return false
	end
	local f36_local4 = function(f38_arg0)
		local f38_local0 = f38_arg0:get()
		for f38_local4, f38_local5 in ipairs(f36_local1) do
			if f38_local0 == f38_local5 then
				return true
			end
		end
		return false
	end
	local f36_local5 = CoDLoadoutsShared[@"hash_11040083716E3993"](f36_arg0)
	local f36_local6 = CoDLoadoutsShared[0xF3A3045A9BEB31](f36_arg0)
	local f36_local7 = function(f39_arg0)
		for f39_local3, f39_local4 in ipairs(f36_local5) do
			if f39_local4 == f39_arg0 then
				return true
			end
		end
		return false
	end
	local f36_local8 = function(f40_arg0)
		for f40_local3, f40_local4 in ipairs(f36_local6) do
			if f40_local4 == f40_arg0 then
				return true
			end
		end
		return false
	end
	local f36_local9 = Engine[@"storagegetbuffer"](f36_arg0, Enum[@"storagefiletype"][@"storage_wz_loadouts"])
	if f36_local9 then
		local f36_local10 = f36_local9[@"cacloadouts"][@"charactercontext"][@"characterindex"]
		local f36_local11 = f36_local9[@"cacloadouts"][@"hash_6A8BD5071BCB463C"]
		if not f36_local3(f36_local10) then
			f36_local10:set(f36_local2)
		end
		if f36_local4(f36_local10) then
			f36_local11:set(f36_local10:get())
		end
		for f36_local15, f36_local16 in ipairs(Lobby.Stats.GetDefaultSprayGestures()) do
			f36_local9[@"cacloadouts"][@"hash_F48E22CED35E56D"][f36_local16]:set(1)
		end
		for f36_local15, f36_local16 in DDLUtils.ipairs(f36_local9[@"variant"]) do
			if f36_local16[@"paintjobslot"] and f36_local16[@"paintjobslot"]:get() ~= Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"] then
				f36_local16[@"paintjobslot"]:set(Enum[@"customizationpaintjobinvalidid"][@"customization_invalid_paintjob_slot"])
			end
			if f36_local16[@"charmindex"] and f36_local16[@"charmindex"]:get() ~= 0 and not f36_local7(f36_local16[@"charmindex"]:get()) then
				f36_local16[@"charmindex"]:set(0)
			end
			if f36_local16[@"deathfxindex"] and f36_local16[@"deathfxindex"]:get() ~= 0 and not f36_local8(f36_local16[@"deathfxindex"]:get()) then
				f36_local16[@"deathfxindex"]:set(0)
			end
		end
	end
	local f36_local10 = Engine[@"storagegetbuffer"](f36_arg0, Enum[@"storagefiletype"][@"storage_common_settings"])
	if f36_local10 then
		local f36_local11 = f36_local10[@"selectedcharacterindex_wz"]
		if not f36_local3(f36_local11) then
			f36_local11:set(f36_local2)
		end
	end
end
Lobby.Stats.ValidateZMWeaponArmory = function(f41_arg0)
	if not Engine[@"storageisfileready"](f41_arg0, Enum[@"storagefiletype"][@"storage_zm_stats_online"]) or not Engine[@"storageisfileready"](f41_arg0, Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"]) or not Engine[@"storageisfileready"](f41_arg0, Enum[@"storagefiletype"][@"storage_zm_loadouts"]) or not Engine[@"storageisfileready"](f41_arg0, Enum[@"storagefiletype"][@"hash_33376D9E1C3C8130"]) or not Engine[@"storageisfileready"](f41_arg0, Enum[@"storagefiletype"][@"storage_zm_loadouts_offline"]) or not Engine[@"storageisfileready"](f41_arg0, Enum[@"storagefiletype"][@"storage_common_settings"]) then
		return
	end
	local f41_local0 = CoDLoadoutsShared[@"hash_11040083716E3993"](f41_arg0)
	local f41_local1 = CoDLoadoutsShared[0xF3A3045A9BEB31](f41_arg0)
	local f41_local2 = function(f42_arg0, f42_arg1)
		for f42_local3, f42_local4 in ipairs(f42_arg1) do
			if f42_local4 == f42_arg0 then
				return true
			end
		end
		return false
	end
	local f41_local3 = function(f43_arg0)
		if f43_arg0[@"charmindex"] and f43_arg0[@"charmindex"]:get() ~= 0 and not f41_local2(f43_arg0[@"charmindex"]:get(), f41_local0) then
			f43_arg0[@"charmindex"]:set(0)
		end
		if f43_arg0[@"deathfxindex"] and f43_arg0[@"deathfxindex"]:get() ~= 0 and not f41_local2(f43_arg0[@"deathfxindex"]:get(), f41_local1) then
			f43_arg0[@"deathfxindex"]:set(0)
		end
	end
	local f41_local4 = Engine[@"storagegetbuffer"](f41_arg0, Enum[@"storagefiletype"][@"storage_zm_loadouts"])
	if f41_local4 then
		for f41_local11, f41_local12 in DDLUtils.ipairs(f41_local4[@"cacloadouts"]) do
			for f41_local8, f41_local9 in DDLUtils.ipairs(f41_local12[@"customclass"]) do
				f41_local3(f41_local9[@"primary"])
				f41_local3(f41_local9[@"secondary"])
			end
		end
		for f41_local11, f41_local12 in DDLUtils.ipairs(f41_local4[@"variant"]) do
			f41_local3(f41_local12)
		end
	end
end
Lobby.Stats.ValidateJumpkitSelection = function(f44_arg0, f44_arg1)
	local f44_local0 = Engine[@"hash_7A7E3CD65E63086F"](@"jumpkits")
	local f44_local1 = Engine[@"storagegetbuffer"](f44_arg0, f44_arg1)
	if not f44_local0 or not f44_local1 or not f44_local1.selectedJumpkitComponents or not f44_local1.selectedJumpkitNames then
		return
	end
	local f44_local2 = false
	for f44_local7, f44_local8 in DDLUtils.pairs(characterRoot[@"outfititems"]) do
		if f44_local8:get() == 0x0 then
			local f44_local6 = f44_local0[f44_local1.selectedJumpkitComponents[f44_local7]:get() + 1] or f44_local0[0]
			if f44_local6 then
				f44_local8:set(f44_local6[@"assetname"])
				f44_local2 = true
			end
		end
	end
	if f44_local2 then
		Engine[@"storagewrite"](f44_arg0, f44_arg1)
	end
end
Lobby.Stats.OnProfileCommonStatsDownloaded = function(f45_arg0)
	local f45_local0 = Engine[@"storagegetbuffer"](f45_arg0, Enum[@"storagefiletype"][@"storage_common_settings"])
	if f45_local0 == nil then
		return
	end
	local f45_local1 = false
	local f45_local2 = "gamedata/tables/common/music_player.csv"
	local f45_local3 = Engine[@"tablelookup"](f45_local2, Enum[@"musicplayertablecolumn"][@"music_player_column_alias"], Enum[@"musicplayertablecolumn"][@"music_player_column_index"], "mus_mp_lobby_intro")
	if f45_local3 ~= "" then
		f45_local3 = tonumber(f45_local3)
	else
		f45_local3 = nil
	end
	if f45_local0.snd_defaultFrontendTracksInitialized:get() == 0 then
		f45_local0.snd_defaultFrontendTracksInitialized:set(1)
		f45_local0.snd_muteMPFrontendMusic:set(0)
		if f45_local3 then
			f45_local0.snd_playMPFrontendMusicTrack[f45_local3]:set(1)
		else
			f45_local0.snd_playMPFrontendMusicTrack[0]:set(1)
		end
		f45_local1 = true
	end
	if f45_local0.snd_defaultFrontendTracksInitialized2:get() == 0 then
		f45_local0.snd_defaultFrontendTracksInitialized2:set(1)
		local f45_local4 = Engine[@"gettablerowcount"](f45_local2)
		local f45_local5 = false
		local f45_local6 = 0
		for f45_local7 = 0, f45_local4 - 1, 1 do
			if f45_local7 ~= f45_local3 and f45_local0.snd_playMPFrontendMusicTrack[f45_local7]:get() == 1 then
				f45_local5 = true
				break
			elseif f45_local7 == f45_local3 and f45_local0.snd_playMPFrontendMusicTrack[f45_local7]:get() == 0 then
				f45_local5 = true
				break
			end
		end
		if f45_local0.snd_muteMPFrontendMusic:get() == 1 then
			f45_local0.snd_frontendTracksState:set(Enum[@"frontendmusictrackstates"][@"frontend_music_state_off"])
		elseif f45_local5 then
			f45_local0.snd_frontendTracksState:set(Enum[@"frontendmusictrackstates"][@"frontend_music_state_on"])
		else
			f45_local0.snd_frontendTracksState:set(Enum[@"frontendmusictrackstates"][@"frontend_music_state_default"])
		end
		if not f45_local5 then
			for f45_local7 = 0, f45_local4 - 1, 1 do
				f45_local0.snd_playMPFrontendMusicTrack[f45_local7]:set(1)
			end
		end
		f45_local1 = true
	end
	local f45_local4 = f45_local0[@"hash_4DA66F98A9232A8E"]:get()
	if f45_local4 == 0 then
		f45_local0[@"hash_4DA66F98A9232A8E"]:set(1)
		f45_local1 = true
		local f45_local5 = function(f46_arg0, f46_arg1, f46_arg2)
			f46_arg0[@"characterhead"]:set(0)
			f46_arg0[@"outfitindex"]:set(0)
			for f46_local3, f46_local4 in DDLUtils.pairs(f46_arg0[@"outfititems"]) do
				f46_local4:set(0)
			end
			f46_local0 = f46_arg0[@"locked"]
			f46_local1 = f46_local0
			f46_local0 = f46_local0.set
			if f46_arg2 then
				f46_local2 = 1
				if not f46_local2 then
				else
					f46_local0(f46_local1, f46_local2)
				end
			end
			f46_local2 = 0
		end
		for f45_local9, f45_local10 in DDLUtils.ipairs(f45_local0[@"hash_D17B4E10FA9C28C"]) do
			f45_local5(f45_local10, f45_local9, false)
		end
		f45_local6 = Engine[@"hash_31657A284F55F9CD"](Enum[@"emodes"][@"mode_warzone"])
		for f45_local10, f45_local16 in DDLUtils.ipairs(f45_local0[@"wzcharacters"]) do
			local f45_local12 = true
			for f45_local13, f45_local14 in ipairs(f45_local6) do
				if f45_local14.bodyIndex == f45_local10 then
					local f45_local11 = Engine[@"getpositionrolebundleinfo"](Enum[@"emodes"][@"mode_warzone"], f45_local10)
					if f45_local11 and f45_local11[@"isdefaultcharacter"] == 1 then
					else
						f45_local12 = true
					end
					f45_local12 = false
				end
			end
			f45_local5(f45_local16, f45_local10, f45_local12)
		end
	else
		if f45_local4 == 1 then
			f45_local0[@"hash_4DA66F98A9232A8E"]:set(2)
			f45_local1 = true
		end
		local f45_local5 = function(f47_arg0, f47_arg1, f47_arg2)
			if Engine[@"hash_11D5921EEA87F940"](f47_arg1, f47_arg2) <= f47_arg0[@"outfitindex"]:get() then
				f45_local1 = true
				f47_arg0[@"outfitindex"]:set(0)
				for f47_local3, f47_local4 in DDLUtils.pairs(f47_arg0[@"outfititems"]) do
					f47_local4:set(0)
				end
			end
		end
		local f45_local6 = function(f48_arg0, f48_arg1)
			for f48_local3, f48_local4 in ipairs(Engine[@"hash_31657A284F55F9CD"](f48_arg0)) do
				if f48_local4.bodyIndex < #f48_arg1 then
					f45_local5(f48_arg1[f48_local4.bodyIndex], f48_arg0, f48_local4.bodyIndex)
				end
			end
		end
		f45_local6(Enum[@"emodes"][@"mode_multiplayer"], f45_local0[@"hash_D17B4E10FA9C28C"])
		f45_local6(Enum[@"emodes"][@"mode_warzone"], f45_local0[@"wzcharacters"])
	end
	if f45_local1 then
		Engine[@"storagewrite"](f45_arg0, Enum[@"storagefiletype"][@"storage_common_settings"])
	end
end
Lobby.Stats.InitializeCareerStats = function(f49_arg0, f49_arg1)
	local f49_local0 = Engine[@"storagegetbuffer"](f49_arg0, f49_arg1)
	if not f49_local0 then
		return
	end
	local f49_local1 = Enum[@"team_t"][@"team_allies"]
	if Engine[@"getdvarstring"]("pvp_forcePlayerTeam") == "axis" then
		f49_local1 = Enum[@"team_t"][@"team_axis"]
	end
	f49_local0.faction:set(f49_local1)
	Engine[@"storagewrite"](f49_arg0, f49_arg1)
end
Lobby.Stats.SetDefaultCPLoadouts = function()
	local f50_local0 = Engine[@"hash_4C4547D19EF98B12"]()
	if f50_local0 then
		local f50_local1 = Engine[@"hash_2E00B2F29271C60B"](@"cp_default_loadouts")
		local f50_local2 = Enum[@"emodes"][@"mode_campaign"]
		for f50_local3 = 1, #f50_local0.customclass, 1 do
			CoDShared.SetDefaultLoadout(f50_local0, f50_local3, f50_local1, f50_local2, nil)
		end
	end
end
function ResetZMVariants(f51_arg0)
	local f51_local0 = function(f52_arg0)
		local f52_local0 = Engine[@"storagegetbuffer"](f51_arg0, f52_arg0)
		if not f52_local0 then
			return
		end
		local f52_local1 = f52_local0.variant
		if f52_local1 then
			Engine[@"hash_757DAE186BC06A59"](f52_local1)
		end
	end
	f51_local0(Enum[@"storagefiletype"][@"storage_zm_loadouts"])
	f51_local0(Enum[@"storagefiletype"][@"hash_33376D9E1C3C8130"])
	f51_local0(Enum[@"storagefiletype"][@"storage_zm_loadouts_offline"])
end
function ResetLoadoutsForMode(f53_arg0, f53_arg1)
	if f53_arg1 == Enum[@"emodes"][@"mode_multiplayer"] then
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f53_arg0, Enum[@"storagefiletype"][@"storage_mp_loadouts"], @"mp_default_loadouts")
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f53_arg0, Enum[@"storagefiletype"][@"storage_mp_loadouts_custom"], @"mp_default_loadouts")
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f53_arg0, Enum[@"storagefiletype"][@"storage_mp_loadouts_offline"], @"mp_default_loadouts")
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f53_arg0, Enum[@"storagefiletype"][0x67DF1879D992E], @"mp_arena_default_loadouts")
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f53_arg0, Enum[@"storagefiletype"][@"hash_CEBE62E27709AD0"], @"mp_arena_default_loadouts")
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f53_arg0, Enum[@"storagefiletype"][@"hash_D062FA7B47FC13A"], @"mp_arena_default_loadouts")
	elseif f53_arg1 == Enum[@"emodes"][@"mode_zombies"] then
		local f53_local0 = function(f54_arg0)
			local f54_local0 = Engine[@"storagegetbuffer"](f53_arg0, f54_arg0)
			if not f54_local0 then
				return
			end
			local f54_local1 = f54_local0.cacLoadouts
			if f54_local1 then
				local f54_local2 = Enum[@"emodes"][@"mode_zombies"]
				local f54_local3 = Engine[@"hash_2E00B2F29271C60B"](@"zm_default_loadouts")
				for f54_local4 = 0, #f54_local1 - 1, 1 do
					local f54_local7 = f54_local1[f54_local4]
					for f54_local8 = 1, #f54_local7.customclass, 1 do
						CoDShared.SetCustomDefaultLoadout(f54_local7, f54_local8, f54_local3, f54_local2, f54_local4)
					end
					for f54_local8 = 1, #f54_local7.bubbleGumPack, 1 do
						CoDShared.SetDefaultBubbleGumBuffs(f54_local7, f54_local8, f54_local3, f54_local2, f54_local4)
					end
				end
				Engine[@"saveloadout"](f53_arg0, f54_local2)
			end
		end
		f53_local0(Enum[@"storagefiletype"][@"storage_zm_loadouts"])
		f53_local0(Enum[@"storagefiletype"][@"hash_33376D9E1C3C8130"])
		f53_local0(Enum[@"storagefiletype"][@"storage_zm_loadouts_offline"])
	end
end
Lobby.Stats.OnPrePrestige = function(f55_arg0)
	local f55_local0 = f55_arg0.controller
	local f55_local1 = f55_arg0.mode
	if f55_local1 == Enum[@"emodes"][@"mode_multiplayer"] then
		Engine[@"hash_45217EA14A38494C"](f55_local0)
	end
	ResetLoadoutsForMode(f55_local0, f55_local1)
end
Lobby.Stats.OnPostPrestige = function(f56_arg0)
	local f56_local0 = f56_arg0.controller
	local f56_local1 = f56_arg0.mode
	if f56_arg0.success and f56_local1 == Enum[@"emodes"][@"mode_warzone"] then
		Engine[@"hash_239A49F8F53E0E89"]()
		local f56_local2 = Engine[@"getplayerstats"](f56_local0, Enum[@"statslocation"][@"stats_location_normal"], f56_local1)
		if f56_local2 then
			local f56_local3 = f56_local2[@"playerstatslist"][@"plevel"][@"statvalue"]:get()
			for f56_local7, f56_local8 in ipairs(Engine[@"getherolist"](f56_local1)) do
				local f56_local9 = Engine[@"getpositionrolebundleinfo"](f56_local1, f56_local8.bodyIndex)
				if f56_local9 and f56_local9[0x8E63886F9B0BAB] == 1 then
					Engine[@"setcharacteroutfititemindex"](f56_local0, f56_local1, f56_local8.bodyIndex, 0, Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"], f56_local3)
				end
			end
			f56_local2[@"afteractionreportstats"][@"gametype"]:set(Engine[@"lobbygetgametype"]())
		end
		Lobby.Stats.ValidateWZCharacterSelection(f56_local0)
		Engine[@"storagewrite"](f56_local0, Enum[@"storagefiletype"][@"storage_wz_loadouts"])
		Engine[@"hash_46EB835BA632E5DB"](f56_local0, @"hash_85B4E472DBA4DAA", 0)
	end
end
Lobby.Stats.OnPrePrestigeFreshStart = function(f57_arg0)
	local f57_local0 = f57_arg0.controller
	local f57_local1 = f57_arg0.mode
	if f57_local1 == Enum[@"emodes"][@"mode_multiplayer"] then
		Engine[@"hash_45217EA14A38494C"](f57_local0)
	elseif f57_local1 == Enum[@"emodes"][@"mode_zombies"] then
		ResetZMVariants(f57_local0)
	end
	ResetLoadoutsForMode(f57_local0, f57_local1)
end
Lobby.Stats.OnPrestigeFreshStartSuccess = function(f58_arg0) end
Lobby.Stats.OnPrestigeFreshStartFailure = function(f59_arg0) end
Lobby.Stats.OnPrestigeFreshStartPreRestart = function(f60_arg0)
	if f60_arg0.wasError == nil or f60_arg0.wasError == false then
		local f60_local0 = Engine[@"getglobalmodel"]()
		f60_local0 = f60_local0:create("FreshRestartOccurred", true)
		f60_local0:set(true)
	end
end
Lobby.Stats.PopulatePrematchData = function(f61_arg0)
	local f61_local0 = f61_arg0.controller
	local f61_local1 = f61_arg0.ddlData
	if Engine[@"sessionmode_ispubliconlinegame"]() then
		f61_local1.tier_boost:set(CoDShared.Loot.GetCurrentTierBoost(f61_local0))
		f61_local1.bo_pass_tier_boost:set(CoDShared.Loot.GetBOPassTierBoost(f61_local0))
		f61_local1.bo_pass_party_tier_boost:set(CoDShared.Loot.GetBOPassPartyTierBoost(f61_local0))
		if Dvar[@"hash_689838993D5412B6"]:get() == true then
			CoDShared.Loot.GetWeaponPurchasedData(f61_local0, f61_local1)
		end
		CoDShared.LootContracts.GetActiveContracts(f61_local0, f61_local1)
	end
end
