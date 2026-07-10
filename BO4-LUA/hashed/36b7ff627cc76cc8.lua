require("x64:53e8db3768fb02a")
Lobby.Leaderboard = {}
Lobby.Leaderboard.MP = 0
Lobby.Leaderboard.CALC_NOT_FOUND = -2
Lobby.Leaderboard.ANTICHEAT_CONDITION = {
	SUCCESS = 1,
	FAILURE = 2,
}
Lobby.Leaderboard.STATS_COLUMN = {
	RANK = 65535,
	RATING = 65534,
	GAMERTAG = 65533,
	INCREMENT_BY = 65532,
	UI_CALCULATE_SCALE_AVG = 65531,
	RATING_CALCULATE_PERCENTAGE = 65530,
}
Lobby.Leaderboard.GAME_RESULT = {
	LOSS = 0,
	TIE = 1,
	WIN = 2,
}
Lobby.Leaderboard.MIN_PLAY_TIME = 120
Lobby.Leaderboard.Tokens = {
	updateTime = 0,
	numValidationTokens = Engine[@"hash_663B67D1D7B3116"]() - 1,
	LiveBackoff = {},
}
Lobby.Leaderboard.customMatchRecentlyPlayed = {}
Lobby.Leaderboard.StartsWith = function(f1_arg0, f1_arg1)
	return string.sub(f1_arg0, 1, string.len(f1_arg1)) == f1_arg1
end
Lobby.Leaderboard.XUIDMismatch = function(f2_arg0)
	local f2_local0 = Engine[@"getplayerstats"](f2_arg0)
	if f2_local0.playerxuid:get() ~= Engine[@"getxuidstring"](f2_arg0) then
		return 1
	else
		return 0
	end
end
Lobby.Leaderboard.OnClientAdded = function(f3_arg0)
	if f3_arg0.lobbyModule ~= Enum[@"lobbymodule"][@"lobby_module_client"] then
		return
	elseif Engine[@"getlobbyuiscreen"]() ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) then
		return
	end
	local f3_local0 = f3_arg0.xuid
	if Engine[@"islocalclient"](f3_local0) == true or Engine[@"isfriendfromxuid"](Engine[@"getprimarycontroller"](), f3_local0) == true then
		return
	end
	for f3_local4, f3_local5 in pairs(Lobby.Leaderboard.customMatchRecentlyPlayed) do
		if f3_local5.xuid == f3_local0 then
			table.remove(Lobby.Leaderboard.customMatchRecentlyPlayed, f3_local4)
			break
		end
	end
	if #Lobby.Leaderboard.customMatchRecentlyPlayed >= LuaDefine.LEADERBOARD_MAX_ROWS - 1 then
		table.remove(Lobby.Leaderboard.customMatchRecentlyPlayed, 1)
	end
	table.insert(Lobby.Leaderboard.customMatchRecentlyPlayed, {
		xuid = f3_local0,
	})
end
Lobby.Leaderboard.PopulateCustomList = function(f4_arg0)
	table.insert(Lobby.Leaderboard.customMatchRecentlyPlayed, {
		xuid = Engine[@"getxuid64"](f4_arg0.controller),
	})
	Engine[@"leaderboardpopulatecustomlist"](Lobby.Leaderboard.customMatchRecentlyPlayed)
	table.remove(Lobby.Leaderboard.customMatchRecentlyPlayed, #Lobby.Leaderboard.customMatchRecentlyPlayed)
end
Lobby.Leaderboard.GetScore = function(f5_arg0)
	return math.max(0, Engine[@"leaderboard_getdeltastat"](f5_arg0, @"score"))
end
Lobby.Leaderboard.GetPointsPerGame = function(f6_arg0, f6_arg1, f6_arg2)
	return math.max(0, (Engine[@"leaderboard_getdeltastat"](f6_arg1, @"score") + Engine[@"leaderboard_getcachedbycolname"](f6_arg1, "Points")) / (Lobby.Leaderboard.GetGamesPlayed(f6_arg1) + Engine[@"leaderboard_getcachedbycolname"](f6_arg1, "Games Played")))
end
Lobby.Leaderboard.GetScorePerMinute = function(f7_arg0, f7_arg1, f7_arg2)
	return math.max(0, (Engine[@"leaderboard_getdeltastat"](f7_arg1, @"score") + Engine[@"leaderboard_getcachedbycolname"](f7_arg1, "Score")) / (math.max(Lobby.Leaderboard.MIN_PLAY_TIME, Engine[@"leaderboard_getdeltastat"](f7_arg1, @"time_played_total")) + Engine[@"leaderboard_getcachedbycolname"](f7_arg1, "Time Played")) / 60)
end
Lobby.Leaderboard.GetKillDeathRatio = function(f8_arg0)
	return math.max(0, (Engine[@"leaderboard_getdeltastat"](f8_arg0, @"kills") + Engine[@"leaderboard_getcachedbycolname"](f8_arg0, "Kills")) / (Engine[@"leaderboard_getdeltastat"](f8_arg0, @"deaths") + Engine[@"leaderboard_getcachedbycolname"](f8_arg0, "Deaths")) * 100)
end
Lobby.Leaderboard.GetTimePlayed = function(f9_arg0)
	return math.max(Lobby.Leaderboard.MIN_PLAY_TIME, Engine[@"leaderboard_getdeltastat"](f9_arg0, @"time_played_total"))
end
Lobby.Leaderboard.GetGamesPlayed = function(f10_arg0)
	return 1
end
Lobby.Leaderboard.GetPrestige = function(f11_arg0)
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		return 0
	else
		local f11_local0 = Engine[@"getplayerstats"](f11_arg0)
		local f11_local1 = f11_local0.PlayerStatsList.PLEVEL.statValue:get()
		if LuaUtils.IsGameModeParagonCapable(Engine[@"currentsessionmode"]()) and f11_local1 == Engine[@"getprestigecap"]() then
			return LuaUtils.ConvertToPrestigeMerged(f11_local1, f11_local0.PlayerStatsList.PARAGON_RANK.statValue:get(), f11_local0.PlayerStatsList.PARAGON_ICON_ID.statValue:get())
		else
			return f11_local1
		end
	end
end
Lobby.Leaderboard.LB_GetAverageDamage = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = Engine[@"leaderboard_getcachedbycolname"](f12_arg1, "Damage")
	local f12_local1 = Engine[@"leaderboard_getcachedbycolname"](f12_arg1, "Games Played")
	if f12_local1 == 0 then
		return 0
	else
		return math.max(0, f12_local0 / f12_local1)
	end
end
Lobby.Leaderboard.LB_GetKillDeathRatio = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = Engine[@"leaderboard_getcachedbycolname"](f13_arg1, "Kills")
	local f13_local1 = Engine[@"leaderboard_getcachedbycolname"](f13_arg1, "Deaths")
	if f13_local1 == 0 then
		f13_local1 = 1
	end
	return math.max(0, f13_local0 / f13_local1)
end
Lobby.Leaderboard.LB_GetCashPerMinute = function(f14_arg0, f14_arg1, f14_arg2)
	return math.max(0, Engine[@"leaderboard_getcachedbycolname"](f14_arg1, "Cash") / Engine[@"leaderboard_getcachedbycolname"](f14_arg1, "Time Played") / 60)
end
Lobby.Leaderboard.LB_GetAverageObjectives = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = Engine[@"leaderboard_getcachedbycolname"](f15_arg1, "Objectives")
	local f15_local1 = Engine[@"leaderboard_getcachedbycolname"](f15_arg1, "Games Played")
	if f15_local1 == 0 then
		return 0
	else
		return math.max(0, f15_local0 / f15_local1)
	end
end
Lobby.Leaderboard.LB_GetAverageObjectiveTime = function(f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = Engine[@"leaderboard_getcachedbycolname"](f16_arg1, "Objective Time")
	local f16_local1 = Engine[@"leaderboard_getcachedbycolname"](f16_arg1, "Games Played")
	if f16_local1 == 0 then
		return 0
	else
		return math.max(0, f16_local0 / f16_local1)
	end
end
Lobby.Leaderboard.GeneralCalc = function(f17_arg0)
	local f17_local0 = f17_arg0.controller
	local f17_local1 = f17_arg0.lbTrackType
	local f17_local2 = f17_arg0.lbColName
	if f17_local2 == "Time Played" then
		return Lobby.Leaderboard.GetTimePlayed(f17_local0)
	elseif f17_local2 == "Score Per Minute" then
		return Lobby.Leaderboard.GetScorePerMinute(f17_arg0, f17_local0, f17_local1)
	elseif f17_local2 == "Games Played" then
		return Lobby.Leaderboard.GetGamesPlayed(f17_local0)
	elseif f17_local2 == "Points Per Game" then
		return Lobby.Leaderboard.GetPointsPerGame(f17_arg0, f17_local0, f17_local1)
	elseif f17_local2 == "Prestige Level" then
		return Lobby.Leaderboard.GetPrestige(f17_local0)
	elseif f17_local2 == "Avg Damage" then
		return Lobby.Leaderboard.LB_GetAverageDamage(f17_arg0, f17_local0, f17_local1)
	elseif f17_local2 == "K/D Ratio" then
		return Lobby.Leaderboard.LB_GetKillDeathRatio(f17_arg0, f17_local0, f17_local1)
	elseif f17_local2 == "Cash/Min" then
		return Lobby.Leaderboard.LB_GetCashPerMinute(f17_arg0, f17_local0, f17_local1)
	elseif f17_local2 == "Avg Objectives" then
		return Lobby.Leaderboard.LB_GetAverageObjectives(f17_arg0, f17_local0, f17_local1)
	elseif f17_local2 == "Avg Obj Time" then
		return Lobby.Leaderboard.LB_GetAverageObjectiveTime(f17_arg0, f17_local0, f17_local1)
	else
		return Lobby.Leaderboard.CALC_NOT_FOUND
	end
end
Lobby.Leaderboard.Global = function(f18_arg0)
	local f18_local0 = f18_arg0.lbNameID
	local f18_local1 = 0
	f18_local1 = Lobby.Leaderboard.GeneralCalc(f18_arg0)
	if f18_local1 ~= Lobby.Leaderboard.CALC_NOT_FOUND then
		return f18_local1
	else
		return 0
	end
end
Lobby.Leaderboard.LB_MP_GM_KOTH = function(f19_arg0)
	local f19_local0 = f19_arg0.lbColName
	local f19_local1 = f19_arg0.controller
	if f19_local0 == "KOTH Avg Time" then
		return (Engine[@"leaderboard_getcachedbycolname"](f19_local1, "Captured Time") + Engine[@"leaderboard_getdeltastat"](f19_local1, @"objective_time")) / math.max(1, Engine[@"leaderboard_getcachedbycolname"](f19_local1, "Games Played") + 1)
	else
		return 0
	end
end
Lobby.Leaderboard.LB_MP_GM_ESCORT = function(f20_arg0)
	local f20_local0 = f20_arg0.lbColName
	local f20_local1 = f20_arg0.controller
	if f20_local0 == "ESCORT Avg Time" then
		return (Engine[@"leaderboard_getcachedbycolname"](f20_local1, "Escort Time") + Engine[@"leaderboard_getdeltastat"](f20_local1, @"escorts")) / math.max(1, Engine[@"leaderboard_getcachedbycolname"](f20_local1, "Games Played") + 1)
	else
		return 0
	end
end
Lobby.Leaderboard.Friend = function(f21_arg0)
	local f21_local0 = 0
	local f21_local1 = f21_arg0.lbColName
	local f21_local2 = f21_arg0.controller
	local f21_local3 = Engine[@"getlobbysessiongamedata"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
	if f21_local1 == f21_local3.gametype then
		f21_local0 = Lobby.Leaderboard.GetScore(f21_local2)
	end
	return f21_local0
end
Lobby.Leaderboard.Gamemode = function(f22_arg0)
	local f22_local0 = 0
	f22_local0 = Lobby.Leaderboard.GeneralCalc(f22_arg0)
	if f22_local0 ~= Lobby.Leaderboard.CALC_NOT_FOUND then
		return f22_local0
	else
		return 0
	end
end
Lobby.Leaderboard.GetArenaStats = function(f23_arg0)
	local f23_local0 = Engine[@"storagegetbuffer"](f23_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	return f23_local0.arenaStats[Engine[@"getcurrentarenaslot"]()]
end
Lobby.Leaderboard.GetArenaSkill = function(f24_arg0)
	local f24_local0 = Lobby.Leaderboard.GetArenaStats(f24_arg0)
	return f24_local0.skill:get()
end
Lobby.Leaderboard.GetArenaPowerRating = function(f25_arg0)
	local f25_local0 = Lobby.Leaderboard.GetArenaStats(f25_arg0)
	return LuaUtils.GetArenaPowerRating(f25_local0.skill:get())
end
Lobby.Leaderboard.GetArenaWinPercentage = function(f26_arg0)
	local f26_local0 = Lobby.Leaderboard.GetArenaStats(f26_arg0)
	local f26_local1 = f26_local0.wins:get()
	return f26_local1 / math.max(f26_local1 + f26_local0.losses:get(), 1)
end
Lobby.Leaderboard.GetArenaAdjustedWinPct = function(f27_arg0)
	return Engine[@"getadjustedwinpercentage"](f27_arg0, Engine[@"getcurrentarenaslot"]())
end
Lobby.Leaderboard.GetArenaScheduleStrength = function(f28_arg0)
	local f28_local0 = Lobby.Leaderboard.GetArenaStats(f28_arg0)
	return Lobby.Leaderboard.GetArenaAdjustedWinPct(f28_arg0) / math.max(1, Lobby.Leaderboard.GetArenaWinPercentage(f28_arg0))
end
Lobby.Leaderboard.GetArenaGamesPlayed = function(f29_arg0)
	local f29_local0 = Lobby.Leaderboard.GetArenaStats(f29_arg0)
	return f29_local0.wins:get() + f29_local0.losses:get() + f29_local0.ties:get()
end
Lobby.Leaderboard.ArenaMasters = function(f30_arg0)
	local f30_local0 = f30_arg0.lbColName
	local f30_local1 = f30_arg0.controller
	if f30_local0 == "Skill" then
		return Lobby.Leaderboard.GetArenaSkill(f30_local1)
	elseif f30_local0 == "Power Rating" then
		return Lobby.Leaderboard.GetArenaPowerRating(f30_local1)
	elseif f30_local0 == "Win Pct" then
		return Lobby.Leaderboard.GetArenaWinPercentage(f30_local1)
	elseif f30_local0 == "Schedule Strength" then
		return Lobby.Leaderboard.GetArenaScheduleStrength(f30_local1)
	elseif f30_local0 == "Adjusted Win Pct" then
		return Lobby.Leaderboard.GetArenaAdjustedWinPct(f30_local1)
	elseif f30_local0 == "Games Played" then
		return Lobby.Leaderboard.GetArenaGamesPlayed(f30_local1)
	else
		return Lobby.Leaderboard.CALC_NOT_FOUND
	end
end
Lobby.Leaderboard.Anticheat = function(f31_arg0)
	local f31_local0 = 0
	local f31_local1 = f31_arg0.controller
	local f31_local2 = f31_arg0.lbTrackType
	if f31_arg0.lbColName == "XUID Mismatch" then
		return Lobby.Leaderboard.XUIDMismatch(f31_local1)
	else
		return f31_local0
	end
end
Lobby.Leaderboard.CustomData = function(f32_arg0)
	local f32_local0 = f32_arg0.lbColName
	local f32_local1 = f32_arg0.controller
	if f32_local0 == "Score Per Minute" then
		return math.max(0, (Engine[@"leaderboard_getscoreboardstat"](f32_local1, "Score") + Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Score")) / (math.max(Lobby.Leaderboard.MIN_PLAY_TIME, Engine[@"leaderboard_getscoreboardstat"](f32_local1, "TimePlayed")) + Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Time Played")) / 60)
	elseif f32_local0 == "Time Played" then
		return math.max(Lobby.Leaderboard.MIN_PLAY_TIME, Engine[@"leaderboard_getscoreboardstat"](f32_local1, "TimePlayed"))
	elseif f32_local0 == "W/L Ratio" then
		local f32_local2 = Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Wins")
		local f32_local3 = Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Losses")
		local f32_local4 = Engine[@"leaderboard_getscoreboardstat"](f32_local1, "victory")
		if f32_local4 == Lobby.Leaderboard.GAME_RESULT.WIN then
			f32_local2 = f32_local2 + 1
		elseif f32_local4 == Lobby.Leaderboard.GAME_RESULT.LOSS then
			f32_local3 = f32_local3 + 1
		end
		return math.max(0, f32_local2 / math.max(1, f32_local3)) * 100
	elseif f32_local0 == "Wins" then
		if Engine[@"leaderboard_getscoreboardstat"](f32_local1, "victory") == Lobby.Leaderboard.GAME_RESULT.WIN then
			return 1
		else
			return 0
		end
	elseif f32_local0 == "Losses" then
		if Engine[@"leaderboard_getscoreboardstat"](f32_local1, "victory") == Lobby.Leaderboard.GAME_RESULT.LOSS then
			return 1
		else
			return 0
		end
	elseif f32_local0 == "Current Win Streak" then
		if Engine[@"leaderboard_getscoreboardstat"](f32_local1, "victory") == 2 then
			return Engine[@"leaderboard_getcached"](f32_local1, 4) + 1
		else
			return 0
		end
	elseif f32_local0 == "Max Win Streak" then
		if Engine[@"leaderboard_getscoreboardstat"](f32_local1, "victory") == 2 then
			return Engine[@"leaderboard_getcached"](f32_local1, 4) + 1
		else
			return 0
		end
	elseif f32_local0 == "Shots Hit" then
		return Engine[@"leaderboard_getscoreboardstat"](f32_local1, "shots_hit")
	elseif f32_local0 == "Shots Missed" then
		return Engine[@"leaderboard_getscoreboardstat"](f32_local1, "shots_missed")
	elseif f32_local0 == "Confirms" then
		return Engine[@"leaderboard_getscoreboardstat"](f32_local1, "kills_confirmed")
	elseif f32_local0 == "Denies" then
		return Engine[@"leaderboard_getscoreboardstat"](f32_local1, "kills_denied")
	elseif f32_local0 == "Clean Deposits" then
		return Engine[@"leaderboard_getscoreboardstat"](f32_local1, "clean_deposits")
	elseif f32_local0 == "Clean Denies" then
		return Engine[@"leaderboard_getscoreboardstat"](f32_local1, "clean_denies")
	elseif f32_local0 == "Captured Time" then
		return Engine[@"leaderboard_getscoreboardstat"](f32_local1, "objtime")
	elseif f32_local0 == "KOTH Avg Time" then
		return (Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Captured Time") + Engine[@"leaderboard_getscoreboardstat"](f32_local1, "objtime")) / math.max(1, Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Games Played") + 1)
	elseif f32_local0 == "Points Per Game" then
		return math.max(0, (Engine[@"leaderboard_getscoreboardstat"](f32_local1, "points") + Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Points")) / (Lobby.Leaderboard.GetGamesPlayed(f32_local1) + Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Games Played")))
	elseif f32_local0 == "Escort Time" then
		return Engine[@"leaderboard_getscoreboardstat"](f32_local1, "escorts")
	elseif f32_local0 == "ESCORT Avg Time" then
		return (Engine[@"leaderboard_getscoreboardstat"](f32_local1, "escorts") + Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Escort Time")) / math.max(1, Lobby.Leaderboard.GetGamesPlayed(f32_local1) + Engine[@"leaderboard_getcachedbycolname"](f32_local1, "Games Played"))
	else
		return Lobby.Leaderboard.CALC_NOT_FOUND
	end
end
Lobby.Leaderboard.Custom = function(f33_arg0)
	local f33_local0 = f33_arg0.lbColName
	local f33_local1 = f33_arg0.controller
	local f33_local2 = 0
	f33_local2 = Lobby.Leaderboard.CustomData(f33_arg0)
	if f33_local2 == Lobby.Leaderboard.CALC_NOT_FOUND then
		f33_local2 = Engine[@"leaderboard_getscoreboardstat"](f33_local1, f33_local0)
	end
	return f33_local2
end
Lobby.Leaderboard.OnCalculateLBColValue = function(f34_arg0)
	result = Lobby.Leaderboard.GeneralCalc(f34_arg0)
	return result
end
Lobby.Leaderboard.ShouldWrite_LB_MP_GB_HEADSHOTS = function(f35_arg0)
	if Engine[@"leaderboard_getdeltastat"](f35_arg0.controller, @"headshots") > 0 then
		return true
	else
		return false
	end
end
Lobby.Leaderboard.ShouldWriteFriend = function(f36_arg0)
	local f36_local0 = f36_arg0.controller
	local f36_local1 = Engine[@"getlobbysessiongamedata"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
	local f36_local2 = f36_local1.gametype
	local f36_local3 = "ball conf ctf dem dom escort"
	local f36_local4 = "gun koth sd tdm dm"
	return false
end
Lobby.Leaderboard.AreLeaderboardWritesEnabled = function(f37_arg0, f37_arg1)
	if not Engine[@"isdedicatedserver"]() then
		local f37_local0 = -1
		if f37_arg1 == Enum[@"emodes"][@"mode_multiplayer"] then
			f37_local0 = LuaEnum.FEATURE_BAN.LEADERBOARD_WRITE_MP
		elseif f37_arg1 == Enum[@"emodes"][@"mode_zombies"] then
			f37_local0 = LuaEnum.FEATURE_BAN.LEADERBOARD_WRITE_ZM
		elseif f37_arg1 == Enum[@"emodes"][@"mode_campaign"] then
			f37_local0 = LuaEnum.FEATURE_BAN.LEADERBOARD_WRITE_CP
		end
		if f37_local0 >= 0 then
			local f37_local1, f37_local2 = Lobby.Anticheat.CheckIsFeatureBannedForIndex(f37_arg0, f37_local0)
			if f37_local1 then
				return false
			end
		end
	end
	return true
end
Lobby.Leaderboard.OnShouldWriteLeaderboard = function(f38_arg0)
	local f38_local0 = f38_arg0.mode
	local f38_local1 = f38_arg0.controller
	if Dvar[@"hash_43FE27BAE92B9095"]:get() == false then
		return false
	elseif Lobby.Leaderboard.AreLeaderboardWritesEnabled(f38_local1, f38_local0) == false then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_leaderboards"], "Controller " .. f38_local1 .. " is banned from writing to this mode's leaderboards\n")
		return false
	else
		return true
	end
end
Lobby.Leaderboard.OnShouldWriteValidationToken = function(f39_arg0)
	if Dvar[@"hash_298A5E119DBFF724"]:get() == false then
		return false
	else
		local f39_local0 = f39_arg0.objectName
		local f39_local1 = f39_arg0.mode
		local f39_local2 = f39_arg0.controller
		if f39_local0 ~= "mp_progression_online" and f39_local0 ~= "zm_progression_online" and f39_local0 ~= "wz_progression_online" then
			return false
		elseif Lobby.Leaderboard.AreLeaderboardWritesEnabled(f39_local2, f39_local1) == false then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_leaderboards"], "Controller " .. f39_local2 .. " is banned from writing to this mode's leaderboards\n")
			return false
		else
			return true
		end
	end
end
Lobby.Leaderboard.OnValidationTokenUploadComplete = function(f40_arg0, f40_arg1, f40_arg2)
	local f40_local0 = f40_arg1.token
	if f40_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f40_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[@"hash_6299C3DC3A21873E"](f40_local0.liveBackoff)
	elseif f40_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f40_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[@"hash_6F910D4EFAE3B0F3"](f40_local0.liveBackoff, Engine[@"hash_6316595FEDC72451"]())
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_leaderboards"], "OnValidationTokenUploadComplete failed\n")
		Engine[@"hash_D4A068A30B177E9"](f40_local0.num, Enum[@"hash_36F312F534DDFE3F"][@"hash_3E6F98DC65C32E2B"])
	end
	return true
end
Lobby.Leaderboard.UploadValidationTokenAction = function(f41_arg0, f41_arg1)
	local f41_local0 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Leaderboard.OnValidationTokenUploadComplete, {
		controller = controller,
		token = {
			num = f41_arg1,
			liveBackoff = f41_arg0,
		},
	})
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_live"], "UploadValidationTokenAction started.\n")
	if Engine[@"isshipbuild"]() == false and Engine[@"getdvarint"]("uploadValidationTokenActionFailure") == 1 then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_leaderboards"], "UploadValidationTokenAction FAILURE TEST.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f41_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	elseif Engine[@"hash_7997EBB08ADACF80"](f41_local0, f41_arg1) == false then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_leaderboards"], "UploadValidationTokenAction failed to start.\n")
		LobbyVM.ProcessCompleteFailure({
			actionId = f41_local0,
			isError = true,
			returnCode = Lobby.ProcessQueue.EVENT_START_ERROR,
			returnCodeHex = "EVENT START ERROR",
		})
		return
	else
	end
end
Lobby.Leaderboard.GetBackoffForTokenNum = function(f42_arg0)
	local f42_local0 = Lobby.Leaderboard.Tokens.LiveBackoff[f42_arg0]
	if f42_local0 == nil then
		Lobby.Leaderboard.ClearTokenBackoff(f42_arg0)
		f42_local0 = Lobby.Leaderboard.Tokens.LiveBackoff[f42_arg0]
	end
	return f42_local0
end
Lobby.Leaderboard.Pump = function()
	if Dvar[@"hash_298A5E119DBFF724"]:get() == false then
		return false
	elseif Engine[@"isdedicatedserver"]() then
		return
	elseif Engine[@"milliseconds"]() < Lobby.Leaderboard.Tokens.updateTime then
		return
	end
	Lobby.Leaderboard.Tokens.updateTime = Engine[@"milliseconds"]() + Dvar[@"hash_4C1F9A9CC5C45DCF"]:get()
	if Engine[@"hash_2C93F1223033FAA3"]() == true then
		return
	end
	for f43_local0 = 0, Lobby.Leaderboard.Tokens.numValidationTokens, 1 do
		local f43_local3 = Engine[@"hash_5399C82B663F88E1"](f43_local0)
		local f43_local4 = Lobby.Leaderboard.GetBackoffForTokenNum(f43_local0)
		if f43_local4 ~= nil and f43_local3.tokenState == Enum[@"hash_36F312F534DDFE3F"][@"hash_3E6F98DC65C32E2B"] then
			if Engine[0x88C82D2C4BED05](f43_local4, Engine[@"hash_6316595FEDC72451"]()) == true then
				Lobby.Leaderboard.UploadValidationTokenAction(f43_local4, f43_local0)
			end
			if Engine[@"hash_F0BE234CA582955"](f43_local4) == true then
				Engine[@"hash_58FFF58B4601944B"](f43_local0)
				Lobby.Leaderboard.ClearTokenBackoff(f43_local0)
			end
		end
	end
end
Lobby.Leaderboard.ClearTokenBackoff = function(f44_arg0)
	Lobby.Leaderboard.Tokens.LiveBackoff[f44_arg0] = Engine[@"hash_7BDF857C8ED1376B"](Dvar[@"hash_26735176B24AC764"]:get(), Dvar[@"hash_422483092C2D3DB9"]:get(), Dvar[0x3ECC9B20882306]:get(), true)
end
Lobby.Leaderboard.OnClearValidationToken = function(f45_arg0)
	Lobby.Leaderboard.ClearTokenBackoff(f45_arg0.tokenNum)
end
