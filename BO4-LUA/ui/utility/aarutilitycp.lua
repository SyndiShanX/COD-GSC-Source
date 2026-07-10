CoD.AARUtilityCP = {}
CoD.AARUtilityCP.RankIdCol = 0
CoD.AARUtilityCP.RankTableColMinXP = 2
CoD.AARUtilityCP.RankTableColXPToNext = 3
CoD.AARUtilityCP.RankDisplayStringCol = 5
CoD.AARUtilityCP.RankTableColMaxXP = 7
CoD.AARUtilityCP.RankDisplayLevelCol = 14
CoD.AARUtilityCP.ACCOLADE_STATE_NOT_COMPLETED = 0
CoD.AARUtilityCP.ACCOLADE_STATE_COMPLETED_NOT_SEEN = 1
CoD.AARUtilityCP.ACCOLADE_STATE_COMPLETED_SEEN = 2
CoD.AARUtilityCP.UnlockTokenIcon = "uie_img_t7_menu_cacselection_icontokenlarge_CP"
CoD.AARUtilityCP.GetLastMapName = function(f1_arg0)
	if CoD.perController[f1_arg0].playedTrainingSim then
		CoD.perController[f1_arg0].playedTrainingSim = nil
		return Engine[@"lobbygetmap"]()
	elseif CoD.perController[f1_arg0].lastAARMapName == nil then
		local f1_local0 = Dvar[@"last_map"]:get()
		if f1_local0 == nil or f1_local0 == false then
			return Engine[@"lobbygetmap"]()
		end
		CoD.perController[f1_arg0].lastAARMapName = CoD.MapUtility.MapsTable[f1_local0].rootMapName
	end
	return CoD.perController[f1_arg0].lastAARMapName
end
CoD.AARUtilityCP.GetLastMissionName = function(f2_arg0)
	if CoD.AARUtilityCP.lastMissionName == nil then
		CoD.AARUtilityCP.lastMissionName = CoD.MapUtility.MapsTable[CoD.AARUtilityCP.GetLastMapName(f2_arg0)].missionName
	end
	return CoD.AARUtilityCP.lastMissionName
end
CoD.AARUtilityCP.UseTestData = function()
	return false
end
CoD.AARUtilityCP.UpdateDatasourcesForScoreboard = function(f4_arg0, f4_arg1)
	if f4_arg1 == nil then
		return
	else
		f4_arg1.ScoreboardWidgetCP0.team1List.Team1:setWidgetType(CoD.ScoreboardRowWidgetCP)
		f4_arg1.ScoreboardWidgetCP0.team1List.Team1:setDataSource("ScoreboardTeam1List")
		f4_arg1.ScoreboardWidgetCP0.team1List.Team1:updateDataSource()
	end
end
CoD.AARUtilityCP.GetMatchStat = function(f5_arg0, f5_arg1)
	local f5_local0 = nil
	f5_local0 = CoD.GetCurrentPlayerStats(f5_arg0)
	local f5_local1 = f5_local0.PlayerStatsList[f5_arg1].StatValue:get()
	local f5_local2 = f5_local0.PlayerStatsByMap[CoD.AARUtilityCP.GetLastMapName(f5_arg0)].currentStats[f5_arg1]:get()
	local f5_local3 = math.floor(f5_local1)
	local f5_local4 = math.floor(f5_local2)
	if f5_local3 < f5_local4 then
		DebugPrint("CoDAARUtilityCP: GetMatchStat was going to be negative!")
		DebugPrint("\n PlayerStatsList[" .. f5_arg1 .. "].statValue:get() == " .. f5_local1)
		DebugPrint("\n PlayerStatsByMap[currentmap].currentStats[" .. f5_arg1 .. "]:get() == " .. f5_local2)
		return 0
	else
		return f5_local3 - f5_local4
	end
end
CoD.AARUtilityCP.GetMissionHighestStat = function(f6_arg0, f6_arg1)
	local f6_local0 = CoD.AARUtilityCP.GetLastMapName(f6_arg0)
	local f6_local1 = CoD.GetCurrentPlayerStats(f6_arg0)
	return f6_local1.PlayerStatsByMap[f6_local0].highestStats[f6_arg1]:get()
end
CoD.AARUtilityCP.SetMissionHighestStat = function(f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = CoD.AARUtilityCP.GetLastMapName(f7_arg0)
	local f7_local1 = CoD.GetCurrentPlayerStats(f7_arg0)
	f7_local1.PlayerStatsByMap[f7_local0].highestStats[f7_arg1]:set(f7_arg2)
end
CoD.AARUtilityCP.AddToArray = function(f8_arg0, f8_arg1)
	if f8_arg0.count == nil then
		f8_arg0.count = 0
	end
	f8_arg0.count = f8_arg0.count + 1
	f8_arg0[f8_arg0.count] = f8_arg1
end
CoD.AARUtilityCP.InitRewards = function(f9_arg0)
	f9_arg0 = {
		count = 0,
	}
end
CoD.AARUtilityCP.AddReward = function(f10_arg0, f10_arg1, f10_arg2)
	CoD.AARUtilityCP.AddToArray(f10_arg0, {
		type = f10_arg2,
		reward = f10_arg1,
	})
end
CoD.AARUtilityCP.GetScoreboardTeamTable = function(f11_arg0, f11_arg1)
	local f11_local0 = Engine[@"getteampositions"](f11_arg0, Engine[@"getcurrentteamcount"]())
	if Engine[@"getcurrentteamcount"]() < 2 and f11_arg1 == 2 then
		return {}
	end
	local f11_local1 = f11_local0[f11_arg1].team
	local f11_local2 = Engine[@"getscoreboardteamclientcount"](Enum[@"team_t"][@"team_allies"])
	local f11_local3 = CoD.GetCurrentPlayerStats(f11_arg0)
	local f11_local4 = {}
	local f11_local5 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f11_arg0), "scoreboardInfo")
	local f11_local6 = {}
	for f11_local7 = 1, f11_local2, 1 do
		local f11_local10 = "team: " .. f11_local1 .. " client: " .. f11_local7 - 1
		local f11_local11 = -1
		if Engine[@"getscoreboardteamclientcount"](f11_local1) < f11_local7 then
			f11_local10 = "team: " .. f11_local1 .. " client: -1"
		else
			f11_local11 = Engine[@"getscoreboardplayerdata"](f11_local7 - 1, f11_local1, Enum[@"scoreboardcolumns_e"][@"scoreboard_column_clientnum"])
		end
		f11_local10 = f11_local10 .. " " .. Engine[@"milliseconds"]()
		local f11_local12 = {
			models = {
				team = f11_local1,
				clientNum = tonumber(f11_local11),
				score = f11_local3.AfterActionReportStats.playerStats[f11_local11].score:get(),
				kills = f11_local3.AfterActionReportStats.playerStats[f11_local11].kills:get(),
				deaths = f11_local3.AfterActionReportStats.playerStats[f11_local11].deaths:get(),
				assists = f11_local3.AfterActionReportStats.playerStats[f11_local11].assists:get(),
				revives = f11_local3.AfterActionReportStats.playerStats[f11_local11].revives:get(),
			},
		}
		f11_local12.models.ping = Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "scoreboard.team1." .. f11_local11 .. ".ping"))
		table.insert(f11_local6, f11_local12)
	end
	return f11_local6
end
CoD.AARUtilityCP.SetupUIModels = function(f12_arg0)
	local f12_local0 = CoD.AARUtilityCP.UseTestData()
	local f12_local1 = nil
	local f12_local2 = CoD.GetPlayerStats(f12_arg0)
	local f12_local3 = f12_local2.PlayerStatsList.RANK.StatValue:get()
	local f12_local4 = f12_local2.PlayerStatsList.PLEVEL.StatValue:get()
	local f12_local5 = CoD.AARUtilityCP.GetXPEarnedDuringMatch(f12_local2.PlayerStatsList.RANKXP.StatValue:get(), f12_local2.currentRankXP:get())
	local f12_local6 = CoD.AARUtilityCP.GetLastMapName(f12_arg0)
	local f12_local7 = f12_local2.AfterActionReportStats
	local f12_local8 = {}
	f12_local8.nextLevel, f12_local8.nextLevelIcon = CoD.AARUtility.GetLevelAndLevelIconForRank(f12_local3 + 1, f12_local4 + 1)
	if f12_local0 then
		f12_local8.kills = 24
		f12_local8.assists = 14
		f12_local8.score = 11550
		f12_local8.revives = 3
		f12_local8.incaps = 2
		f12_local8.difficulty = 1
		f12_local8.showBestScoreIcon = 1
		f12_local8.showBestKillsIcon = 1
		f12_local8.showBestCompletionTimeIcon = 1
		f12_local8.showBestIncapsIcon = 1
		f12_local8.showBestAssistsIcon = 1
		f12_local8.showBestRevivesIcon = 1
	else
		f12_local8.kills = CoD.AARUtilityCP.GetMatchStat(f12_arg0, "KILLS")
		f12_local8.assists = CoD.AARUtilityCP.GetMatchStat(f12_arg0, "ASSISTS")
		f12_local8.score = CoD.AARUtilityCP.GetMatchStat(f12_arg0, "SCORE")
		f12_local8.revives = CoD.AARUtilityCP.GetMatchStat(f12_arg0, "REVIVES")
		f12_local8.incaps = CoD.AARUtilityCP.GetMatchStat(f12_arg0, "INCAPS")
		f12_local8.difficulty = f12_local2.PlayerStatsByMap[CoD.AARUtilityCP.GetLastMapName(f12_arg0)].lastCompletedDifficulty:get()
		f12_local8.showBestScoreIcon = 0
		f12_local8.showBestKillsIcon = 0
		f12_local8.showBestDifficultyIcon = 0
		f12_local8.showBestIncapsIcon = 0
		f12_local8.showBestAssistsIcon = 0
		f12_local8.showBestRevivesIcon = 0
		local f12_local9 = CoD.AARUtilityCP.GetMissionHighestStat(f12_arg0, "SCORE")
		local f12_local10 = CoD.AARUtilityCP.GetMissionHighestStat(f12_arg0, "KILLS")
		local f12_local11 = CoD.AARUtilityCP.GetMissionHighestStat(f12_arg0, "ASSISTS")
		local f12_local12 = CoD.AARUtilityCP.GetMissionHighestStat(f12_arg0, "REVIVES")
		local f12_local13 = CoD.AARUtilityCP.GetMissionHighestStat(f12_arg0, "INCAPS")
		local f12_local14 = CoD.AARUtilityCP.GetMissionHighestStat(f12_arg0, "HIGHEST_DIFFICULTY")
		if f12_local9 < f12_local8.score and f12_local9 ~= nil then
			f12_local8.showBestScoreIcon = 1
		end
		if f12_local10 < f12_local8.kills and f12_local10 ~= nil then
			f12_local8.showBestKillsIcon = 1
		end
		if f12_local11 < f12_local8.assists and f12_local11 ~= nil then
			f12_local8.showBestAssistsIcon = 1
		end
		if f12_local12 < f12_local8.revives and f12_local12 ~= nil then
			f12_local8.showBestRevivesIcon = 1
		end
		if f12_local8.incaps < f12_local13 and f12_local13 ~= nil then
			f12_local8.showBestIncapsIcon = 1
		end
		if f12_local14 < f12_local8.difficulty then
			f12_local8.showBestDifficultyIcon = 1
		end
	end
	f12_local8.xpEarnedDuringMatch = f12_local5
	local f12_local9 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f12_arg0), "aarStats.performanceTabStats")
	for f12_local13, f12_local14 in pairs(f12_local8) do
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f12_local9, f12_local13), f12_local14)
	end
end
CoD.AARUtilityCP.GetXPEarnedDuringMatch = function(f13_arg0, f13_arg1)
	local f13_local0 = f13_arg0 - f13_arg1
	if f13_local0 < 0 then
		f13_local0 = 0
	end
	return f13_local0
end
CoD.AARUtilityCP.GetModelForRewardItemByIndex = function(f14_arg0, f14_arg1)
	return Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f14_arg0), "aarRewards." .. f14_arg1)
end
CoD.AARUtilityCP.CheckRankRewards = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = Engine[@"tablelookup"](CoD.rankTable, f15_arg2, 0, f15_arg1.rank)
	if f15_arg1.Rewards == nil then
		f15_arg1.Rewards = {}
	end
	for f15_local7 in f15_local0:gmatch("%S+") do
		local f15_local8 = {}
		if f15_local7 == "token" then
			local f15_local4 = 1
			local f15_local5 = Engine[@"tablelookup"](CoD.rankTable, 18, 0, f15_arg1.rank)
			if f15_local5 ~= nil and f15_local5 ~= "" then
				f15_local4 = f15_local4 + tonumber(f15_local5)
			end
			f15_local8.name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27C13CC7BFE47E5C", f15_local4)
			f15_local8.description = 0x0
			f15_local8.icon = CoD.AARUtilityCP.UnlockTokenIcon
		else
			local f15_local4 = Enum[@"emodes"][@"mode_campaign"]
			local f15_local5 = Engine[@"getitemindexfromreference"](f15_local7, f15_local4)
			local f15_local6 = Engine[@"getitemimage"](f15_local5, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f15_local4)
			if not string.find(f15_local7, "cybercom") then
				f15_local6 = f15_local6 .. "_rwd"
			end
			f15_local8.name = Engine[@"getitemname"](f15_local5, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f15_local4)
			f15_local8.description = Engine[@"getitemdesc"](f15_local5, Enum[@"statindexoffset"][@"hash_13057ABF96AF8289"], f15_local4)
			f15_local8.icon = f15_local6
		end
		CoD.AARUtilityCP.AddToArray(f15_arg1.Rewards, f15_local8)
	end
end
CoD.AARUtilityCP.GetRankForRankXP = function(f16_arg0, f16_arg1)
	for f16_local0 = 0, 19, 1 do
		if f16_arg1 < tonumber(Engine[@"tablelookup"](CoD.rankTable, 7, 0, f16_local0)) then
			return f16_local0
		end
	end
	return 19
end
CoD.AARUtilityCP.CheckRankAndPrestige = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = CoD.AARUtilityCP.UseTestData()
	local f17_local1 = 8
	local f17_local2 = 12
	local f17_local3 = 17
	if f17_local0 then
		local f17_local4 = {
			icon = "rank_lcpl_128",
			title = "SOME HIGH RANK",
			description = "Level Someting",
			rank = 1,
		}
		for f17_local5 = f17_local1, f17_local2, 1 do
			CoD.AARUtilityCP.CheckRankRewards(f17_arg0, f17_local4, f17_local5)
		end
		CoD.AARUtilityCP.CheckRankRewards(f17_arg0, f17_local4, f17_local3)
		CoD.AARUtilityCP.AddReward(f17_arg2, f17_local4, "RANK")
	elseif f17_arg1 and f17_arg1.currentRankXP then
		local f17_local5 = CoD.AARUtilityCP.GetRankForRankXP(f17_arg0, f17_arg1.currentRankXP:get())
		local f17_local8 = CoD.AARUtilityCP.GetRankForRankXP(f17_arg0, f17_arg1.PlayerStatsList.RANKXP.statValue:get()) - f17_local5
		if f17_local8 > 0 then
			local f17_local9 = 8
			local f17_local10 = 12
			for f17_local11 = 1, f17_local8, 1 do
				local f17_local14 = {
					icon = "t7_icon_rank_cp_level_" .. string.format("%02d", f17_local5 + f17_local11 + 1) .. "_lrg",
					title = CoD.GetRankName(f17_local5 + f17_local11, 0),
					description = Engine[@"hash_4F9F1239CFD921FE"](@"menu/level") .. " " .. f17_local5 + f17_local11 + 1,
					rank = f17_local5 + f17_local11,
				}
				for f17_local15 = f17_local9, f17_local10, 1 do
					CoD.AARUtilityCP.CheckRankRewards(f17_arg0, f17_local14, f17_local15)
				end
				CoD.AARUtilityCP.CheckRankRewards(f17_arg0, f17_local14, f17_local3)
				CoD.AARUtilityCP.AddReward(f17_arg2, f17_local14, "RANK")
			end
		end
	end
end
CoD.AARUtilityCP.CheckWeaponRewards = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4)
	if f18_arg1.Rewards == nil then
		f18_arg1.Rewards = {}
	end
	if f18_arg3 ~= nil and f18_arg3 ~= "" then
		local f18_local0 = {}
		local f18_local1 = Engine[@"tablelookup"](CoD.attachmentTable, 0, 4, f18_arg3)
		f18_local0.name = Engine[@"tablelookup"](CoD.attachmentTable, 3, 4, f18_arg3)
		f18_local0.icon = Engine[@"getattachmentuniqueimagebyattachmentindex"](Enum[@"emodes"][@"mode_multiplayer"], f18_arg2, tonumber(f18_local1))
		f18_local0.description = @"hash_51E8029FC8EC490"
		CoD.AARUtilityCP.AddToArray(f18_arg1.Rewards, f18_local0)
	end
	if f18_arg4 ~= nil and f18_arg4 ~= "0" and f18_arg4 ~= "" then
		CoD.AARUtilityCP.AddToArray(f18_arg1.Rewards, {
			name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", f18_arg4),
			icon = "t7_hud_mp_notifications_xp_blue",
			description = @"hash_0",
		})
	end
end
CoD.AARUtilityCP.CheckWeaponLevels = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = CoD.AARUtilityCP.UseTestData()
	local f19_local1 = Enum[@"emodes"][@"mode_campaign"]
	if f19_local0 then
		local f19_local2 = {
			icon = "t7_icon_weapon_ar_standard_sm",
			title = "ARAK 74",
			description = "Level 2",
		}
		CoD.AARUtilityCP.CheckWeaponRewards(f19_arg0, f19_local2, 2, "ar_standard", 2)
		CoD.AARUtilityCP.AddReward(f19_arg2, f19_local2, "WEAPON")
	elseif f19_arg1 and f19_arg1.currentWeaponLevels then
		for f19_local2 = 1, 57, 1 do
			local f19_local5 = Engine[@"getitemref"](f19_local2, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f19_local1)
			if f19_local5 ~= nil and f19_local5 ~= "" then
				local f19_local6 = Engine[@"getitemname"](f19_local2, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f19_local1)
				local f19_local7 = f19_arg1.itemstats[f19_local2].xp:get()
				local f19_local8 = f19_arg1.currentWeaponLevels[f19_local2]:get()
				local f19_local9 = Engine[@"tablefindrows"](CoD.gunLevelsTable, 2, f19_local5)
				if f19_local9 ~= nil then
					local f19_local10 = tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.gunLevelsTable, f19_local9[#f19_local9], 0))
					local f19_local11 = f19_local9[#f19_local9]
					if f19_local8 < f19_local10 then
						local f19_local12 = f19_local9[1]
						while Engine[@"hash_4C6F8EC444864600"](CoD.gunLevelsTable, f19_local12, 1) == "0" do
							f19_local12 = f19_local12 + 1
						end
						while tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.gunLevelsTable, f19_local12, 0)) < f19_local8 do
							local f19_local12 = f19_local12 + 1
						end
						local f19_local13 = Engine[@"hash_4C6F8EC444864600"](CoD.gunLevelsTable, f19_local12, 1)
						while tonumber(f19_local13) < f19_local7 do
							local f19_local14 = Engine[@"hash_4C6F8EC444864600"](CoD.gunLevelsTable, f19_local12, 3)
							local f19_local15 = Engine[@"hash_4C6F8EC444864600"](CoD.gunLevelsTable, f19_local12, 4)
							local f19_local16 = Engine[@"hash_4C6F8EC444864600"](CoD.gunLevelsTable, f19_local12, 0)
							if f19_local14 ~= "" then
								local f19_local17 = {
									icon = Engine[@"getitemimage"](f19_local2, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f19_local1),
									title = f19_local6,
									description = Engine[@"hash_4F9F1239CFD921FE"](@"menu/level") .. " " .. tonumber(f19_local16) + 2,
								}
								CoD.AARUtilityCP.CheckWeaponRewards(f19_arg0, f19_local17, f19_local2, f19_local14, f19_local15)
								CoD.AARUtilityCP.AddReward(f19_arg2, f19_local17, "WEAPON")
							end
							f19_local12 = f19_local12 + 1
							if f19_local11 < f19_local12 then
								break
							end
							f19_local13 = Engine[@"hash_4C6F8EC444864600"](CoD.gunLevelsTable, f19_local12, 1)
							if f19_local13 == nil then
								break
							end
						end
					end
				end
				local f19_local11 = Engine[@"tablefindrows"](CoD.getStatsMilestoneTable(3, f19_local1), 3, Engine[@"getitemgroup"](f19_local2, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f19_local1))
				if f19_local11 ~= nil then
					for f19_local12 = 1, #f19_local11, 1 do
						if f19_arg1.ItemStats[f19_local2].challengeCompleted[f19_local12 - 1]:get() == 1 then
							local f19_local17 = Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(3, f19_local1), f19_local11[f19_local12], 9)
							local f19_local18 = {
								icon = Engine[@"tablelookup"](CoD.attachmentTable, 6, 4, f19_local17),
								title = Engine[@"tablelookup"](CoD.attachmentTable, 3, 4, f19_local17),
								description = f19_local6,
								Rewards = {},
							}
							CoD.AARUtilityCP.AddToArray(f19_local18.Rewards, {
								name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(3, f19_local1), f19_local11[f19_local12], 6))),
								icon = "t7_hud_mp_notifications_xp_blue",
								description = @"hash_0",
							})
							CoD.AARUtilityCP.AddReward(f19_arg2, f19_local18, "WEAPON_CHALLENGE")
							f19_arg1.ItemStats[f19_local2].challengeCompleted[f19_local12 - 1]:set(0)
						end
					end
				end
			end
		end
	end
end
CoD.AARUtilityCP.GetAccoladeMapStatValue = function(f20_arg0, f20_arg1, f20_arg2)
	if CoD.AARUtilityCP.UseTestData() then
		return tonumber(Engine[@"tablelookup"](CoD.statsMilestone, 2, 0, f20_arg2))
	else
		return f20_arg1.PlayerStatsByMap[CoD.AARUtilityCP.GetLastMapName(f20_arg0)].accolades[f20_arg2].value:get()
	end
end
CoD.AARUtilityCP.GetAccoladeMapStatState = function(f21_arg0, f21_arg1, f21_arg2)
	if CoD.AARUtilityCP.UseTestData() then
		return CoD.AARUtilityCP.ACCOLADE_STATE_COMPLETED_NOT_SEEN
	else
		return f21_arg1.PlayerStatsByMap[CoD.AARUtilityCP.GetLastMapName(f21_arg0)].accolades[f21_arg2].state:get()
	end
end
CoD.AARUtilityCP.SetAccoladeMapStatState = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
	f22_arg1.PlayerStatsByMap[CoD.AARUtilityCP.GetLastMapName(f22_arg0)].accolades[f22_arg2].state:set(f22_arg3)
end
CoD.AARUtilityCP.SetAccoladeMapStatValue = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
	f23_arg1.PlayerStatsByMap[CoD.AARUtilityCP.GetLastMapName(f23_arg0)].accolades[f23_arg2].value:set(f23_arg3)
end
CoD.AARUtilityCP.GetAccoladeIconFromType = function(f24_arg0)
	local f24_local0 = string.lower(f24_arg0)
	if f24_local0 == "accuracy" then
		return "uie_accuracy"
	elseif f24_local0 == "airvehicledestroy" then
		return "uie_air_vehicle"
	elseif f24_local0 == "bullshark" then
		return "uie_bullshark"
	elseif f24_local0 == "cybernetics" then
		return "uie_cybernetics"
	elseif f24_local0 == "defend" then
		return "uie_protect"
	elseif f24_local0 == "explosion" then
		return "uie_explosion"
	elseif f24_local0 == "find" then
		return "uie_collectibles"
	elseif f24_local0 == "grenade" then
		return "uie_grenade"
	elseif f24_local0 == "groundvehicledestroy" then
		return "uie_ground_vehicle"
	elseif f24_local0 == "heavyweapon" then
		return "uie_heavy_weapon"
	elseif f24_local0 == "kills" then
		return "uie_kill"
	elseif f24_local0 == "melee" then
		return "uie_melee"
	elseif f24_local0 == "score" then
		return "uie_score"
	elseif f24_local0 == "stealth" then
		return "uie_stealth"
	elseif f24_local0 == "traversal" then
		return "uie_traversal"
	elseif f24_local0 == "trickshot" then
		return "uie_trickshot"
	elseif f24_local0 == "untouched" then
		return "uie_indestructible"
	elseif f24_local0 == "weapon" then
		return "uie_weapons"
	else
	end
end
CoD.AARUtilityCP.CheckAccolades = function(f25_arg0, f25_arg1, f25_arg2)
	if CoD.AARUtilityCP.UseTestData() then
		CoD.AARUtilityCP.AddReward(f25_arg2, {
			icon = "uie_headicon_dead",
			title = "Accolade",
			description = "Can't Touch This",
		}, "ACCOLADE")
	elseif f25_arg1 ~= nil then
		if CoD.AARUtilityCP.GetLastMissionName(f25_arg0) == nil then
			return
		end
		local f25_local0 = "MISSION_"
		local f25_local1 = CoD.AARUtilityCP.GetLastMissionName(f25_arg0)
		f25_local1 = Engine[@"tablelookup"](CoD.statsMilestone, 0, 4, f25_local0 .. f25_local1:upper() .. "_UNTOUCHED")
		if f25_local1 == "" then
			return
		elseif CoD.MapUtility.MapsTable[CoD.AARUtilityCP.GetLastMapName(f25_arg0)].accoladelist == nil then
			return
		end
		local f25_local2 = Engine[@"hash_7A7E3CD65E63086F"](Engine[@"converttoxhash"](CoD.MapUtility.MapsTable[CoD.AARUtilityCP.GetLastMapName(f25_arg0)].accoladelist))
		for f25_local3 = 0, 18, 1 do
			local f25_local6 = CoD.AARUtilityCP.GetAccoladeMapStatState(f25_arg0, f25_arg1, f25_local3)
			if f25_local6 ~= CoD.AARUtilityCP.ACCOLADE_STATE_COMPLETED_SEEN then
				if f25_local6 == CoD.AARUtilityCP.ACCOLADE_STATE_COMPLETED_NOT_SEEN then
					local f25_local7 = Engine[@"tablelookup"](CoD.statsMilestone, 4, 0, f25_local3 + f25_local1)
					local f25_local8 = "uie_headicon_dead"
					for f25_local12, f25_local13 in pairs(f25_local2) do
						if f25_local13[@"challengereference"] == f25_local7 then
							f25_local8 = CoD.AARUtilityCP.GetAccoladeIconFromType(f25_local13[@"challengewidget"])
							break
						end
					end
					f25_local9 = {
						icon = f25_local8,
						title = Engine[@"tablelookup"](CoD.statsMilestone, 5, 0, f25_local3 + f25_local1) .. "_NAME",
						description = @"hash_111074F44B301995",
					}
					f25_local10 = Engine[@"tablelookup"](CoD.statsMilestone, 7, 0, f25_local3 + f25_local1)
					f25_local9.Rewards = {}
					if f25_local10 ~= nil and f25_local10 ~= "" then
						CoD.AARUtilityCP.AddToArray(f25_local9.Rewards, {
							name = @"hash_3663BFDF80BC4247",
							description = @"hash_0",
							icon = CoD.AARUtilityCP.UnlockTokenIcon,
						})
					end
					f25_local11 = Engine[@"tablelookup"](CoD.statsMilestone, 6, 0, f25_local3 + f25_local1)
					if f25_local11 ~= nil and f25_local11 ~= "" then
						CoD.AARUtilityCP.AddToArray(f25_local9.Rewards, {
							name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", tonumber(f25_local11)),
							description = @"hash_0",
							icon = "t7_hud_mp_notifications_xp_blue",
						})
					end
					CoD.AARUtilityCP.AddReward(f25_arg2, f25_local9, "ACCOLADE")
					CoD.AARUtilityCP.SetAccoladeMapStatState(f25_arg0, f25_arg1, f25_local3, CoD.AARUtilityCP.ACCOLADE_STATE_COMPLETED_SEEN)
				end
				CoD.AARUtilityCP.SetAccoladeMapStatValue(f25_arg0, f25_arg1, f25_local3, 0)
			end
		end
	end
end
CoD.AARUtilityCP.GetDifficultyFromIndex = function(f26_arg0)
	if f26_arg0 == 0 then
		return "RECRUIT"
	elseif f26_arg0 == 1 then
		return "REGULAR"
	elseif f26_arg0 == 2 then
		return "HARDENED"
	elseif f26_arg0 == 3 then
		return "VETERAN"
	else
		return "HEROIC"
	end
end
CoD.AARUtilityCP.CheckMissionRewards = function(f27_arg0, f27_arg1, f27_arg2)
	local f27_local0 = CoD.AARUtilityCP.GetLastMapName(f27_arg0)
	local f27_local1 = false
	local f27_local2 = true
	local f27_local3 = 0
	local f27_local4 = 0
	for f27_local5 = 0, 5, 1 do
		local f27_local8 = f27_arg1.PlayerStatsByMap[f27_local0].previousCompletedDifficulties[f27_local5]:get()
		local f27_local9 = f27_arg1.PlayerStatsByMap[f27_local0].previousReceivedXPForDifficulty[f27_local5]:get()
		local f27_local10 = f27_arg1.PlayerStatsByMap[f27_local0].receivedXPForDifficulty[f27_local5]:get()
		if f27_local8 == 1 then
			f27_local2 = false
		end
		if f27_local9 ~= f27_local10 then
			f27_local1 = true
			local f27_local11 = "complete_mission_" .. CoD.AARUtilityCP.GetDifficultyFromIndex(f27_local5)
			if f27_local5 == f27_arg1.PlayerStatsByMap[CoD.AARUtilityCP.GetLastMapName(f27_arg0)].lastCompletedDifficulty:get() then
				f27_local3 = f27_local3 + tonumber(Engine[@"tablelookup"](CoD.scoreInfoTable, 23, 0, f27_local11))
			else
				f27_local4 = f27_local4 + tonumber(Engine[@"tablelookup"](CoD.scoreInfoTable, 23, 0, f27_local11))
			end
		end
	end
	if f27_local1 == true then
		local f27_local6 = {
			icon = "t7_cp_hud_mission_complete",
			title = 0xBB7B88B33DF484,
			description = CoD.MapUtility.MapsTable[f27_local0].mapName,
			Rewards = {},
		}
		CoD.AARUtilityCP.AddToArray(f27_local6.Rewards, {
			name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", f27_local3),
			icon = "t7_hud_mp_notifications_xp_blue",
			description = "MENU_COMPLETED_" .. CoD.AARUtilityCP.GetDifficultyFromIndex(f27_arg1.PlayerStatsByMap[CoD.AARUtilityCP.GetLastMapName(f27_arg0)].lastCompletedDifficulty:get()),
		})
		if f27_local4 ~= 0 then
			CoD.AARUtilityCP.AddToArray(f27_local6.Rewards, {
				name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", f27_local4),
				icon = "t7_hud_mp_notifications_xp_blue",
				description = @"hash_1C2415D35D75C92E",
			})
		end
		if f27_local2 == true then
			CoD.AARUtilityCP.AddToArray(f27_local6.Rewards, {
				name = @"hash_3663BFDF80BC4247",
				description = @"hash_0",
				icon = CoD.AARUtilityCP.UnlockTokenIcon,
			})
		end
		CoD.AARUtilityCP.AddReward(f27_arg2, f27_local6, "MISSION")
	end
end
CoD.AARUtilityCP.CheckRatingRewards = function(f28_arg0, f28_arg1, f28_arg2)
	if CoD.MapUtility.MapsTable[Engine[@"lobbygetmap"]()].isSafeHouse ~= true then
		return
	end
	local f28_local0 = Engine[@"hash_7A7E3CD65E63086F"](@"rating_list")
	for f28_local1 = 0, 3, 1 do
		if f28_arg1.PlayerStatsByMap.cp_sh_cairo.completedDifficulties[f28_local1]:get() ~= f28_arg1.PlayerStatsByMap.cp_sh_cairo.previousCompletedDifficulties[f28_local1]:get() then
			local f28_local4 = f28_local0[f28_local1 + 1]
			local f28_local5 = {
				icon = f28_local4.ratingImage,
				title = f28_local4.ratingName,
				description = @"hash_66BE861D2FE82E56",
				Rewards = {},
			}
			CoD.AARUtilityCP.AddToArray(f28_local5.Rewards, {
				name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_27C13CC7BFE47E5C", f28_local4.tokensAwarded),
				icon = CoD.AARUtilityCP.UnlockTokenIcon,
				description = @"hash_0",
			})
			CoD.AARUtilityCP.AddToArray(f28_local5.Rewards, {
				name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", f28_local4.xpAwarded),
				icon = "t7_hud_mp_notifications_xp_blue",
				description = @"hash_0",
			})
			CoD.AARUtilityCP.AddReward(f28_arg2, f28_local5, "RATING")
		end
	end
end
CoD.AARUtilityCP.contains = function(f29_arg0, f29_arg1)
	for f29_local0 = 1, #f29_arg0, 1 do
		if f29_arg0[f29_local0] == f29_arg1 then
			return true
		end
	end
	return false
end
CoD.AARUtilityCP.CheckRedDotRewards = function(f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = Engine[@"tablefindrows"](CoD.getStatsMilestoneTable(3, Enum[@"emodes"][@"mode_campaign"]), 3, "attachment")
	local f30_local1 = {}
	for f30_local2 = 1, #f30_local0, 1 do
		local f30_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(3, Enum[@"emodes"][@"mode_campaign"]), f30_local0[f30_local2], 13)
		if not CoD.AARUtilityCP.contains(f30_local1, f30_local5) then
			table.insert(f30_local1, f30_local5)
		end
	end
	for f30_local2 = 1, #f30_local1, 1 do
		local f30_local5 = f30_local1[f30_local2]
		local f30_local6 = Engine[@"tablefindrows"](CoD.getStatsMilestoneTable(3, Enum[@"emodes"][@"mode_campaign"]), 13, f30_local5)
		if f30_local6 ~= nil then
			for f30_local7 = 1, #f30_local6, 1 do
				if f30_arg1.Attachments[f30_local5].challengeCompleted[f30_local7 - 1]:get() == 1 then
					local f30_local10 = Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(3, Enum[@"emodes"][@"mode_campaign"]), f30_local6[f30_local7], 9)
					local f30_local11 = {
						icon = f30_local5 .. "_" .. f30_local7,
						title = "mpui_reticle_" .. f30_local5 .. "_" .. f30_local7,
						description = "mpui_reticle",
						Rewards = {},
					}
					CoD.AARUtilityCP.AddToArray(f30_local11.Rewards, {
						name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(3, Enum[@"emodes"][@"mode_campaign"]), f30_local6[f30_local7], 6))),
						icon = "t7_hud_mp_notifications_xp_blue",
						description = @"hash_0",
					})
					CoD.AARUtilityCP.AddReward(f30_arg2, f30_local11, "WEAPON_CHALLENGE")
					f30_arg1.Attachments[f30_local5].challengeCompleted[f30_local7 - 1]:set(0)
				end
			end
		end
	end
end
CoD.AARUtilityCP.CheckCampaignDecorations = function(f31_arg0, f31_arg1, f31_arg2)
	local f31_local0 = Engine[@"hash_7A7E3CD65E63086F"](@"cp_medals")
	for f31_local1 = 1, #f31_local0, 1 do
		local f31_local4 = f31_local0[f31_local1]
		if f31_arg1.currentPlayerCPDecorations[f31_local1 - 1]:get() ~= f31_arg1.PlayerCPDecorations[f31_local1 - 1]:get() then
			local f31_local5 = {
				icon = f31_local4[@"smallicon"],
				title = f31_local4[@"displayname"],
				description = @"hash_3BDD39B3FB1538BA",
				Rewards = {},
			}
			CoD.AARUtilityCP.AddToArray(f31_local5.Rewards, {
				name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", f31_local4[@"xpbonus"]),
				icon = "t7_hud_mp_notifications_xp_blue",
				description = @"hash_0",
			})
			CoD.AARUtilityCP.AddReward(f31_arg2, f31_local5, "DECORATION")
		end
	end
end
CoD.AARUtilityCP.AddRewardsToChallengeReward = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
	local f32_local0 = {}
	if not f32_arg3 then
		f32_local0.name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", f32_arg2)
		f32_local0.icon = "t7_hud_mp_notifications_xp_blue"
		f32_local0.description = 0x0
	else
		f32_local0.name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_29C133695663ED79", f32_arg3 + 1)
		f32_local0.icon = "t7_hud_mp_notifications_xp_blue"
		f32_local0.description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C0E387C289AD7A9", f32_arg2)
	end
	CoD.AARUtilityCP.AddToArray(f32_arg1.Rewards, f32_local0)
	return f32_arg1
end
CoD.AARUtilityCP.CreateChallengeReward = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3)
	local f33_local0 = CoD.getStatsMilestoneTable(3, Enum[@"emodes"][@"mode_campaign"])
	local f33_local1 = {
		title = LocalizeIntoString(Engine[@"hash_4C6F8EC444864600"](f33_local0, f33_arg2, 5), "", "", ""),
		icon = Engine[@"tablelookup"]("gamedata/emblems/backgrounds.csv", 3, 4, Engine[@"hash_4C6F8EC444864600"](f33_local0, f33_arg2, 12)) .. "_nstrm",
	}
	if f33_arg3 then
		f33_local1.description = @"hash_6A8CC1BBD259D2F6"
	else
		f33_local1.description = @"hash_2F2A25EAC0D5B2AD"
	end
	f33_local1.Rewards = {}
	return f33_local1
end
CoD.AARUtilityCP.BuildChallengeTable = function(f34_arg0)
	CoD.AARUtilityCP.challengeTable = {}
	local f34_local0 = CoD.getStatsMilestoneTable(3, Enum[@"emodes"][@"mode_campaign"])
	for f34_local11, f34_local12 in ipairs({
		"missions",
		"tott",
		"career",
	}) do
		for f34_local8, f34_local9 in ipairs(Engine[@"getchallengeinfoforimages"](f34_arg0, f34_local12, Enum[@"emodes"][@"mode_campaign"])) do
			if f34_local9 ~= nil then
				local f34_local4 = Engine[@"hash_4C6F8EC444864600"](f34_local0, f34_local9.challengeRow, 1)
				if f34_local4 and f34_local4 ~= "0" then
					f34_local4 = tonumber(f34_local4)
					f34_local9.tiers = {}
					for f34_local5 = f34_local9.challengeRow - f34_local4, f34_local9.challengeRow, 1 do
						table.insert(f34_local9.tiers, {
							tierID = tonumber(Engine[@"hash_4C6F8EC444864600"](f34_local0, f34_local5, 1)),
							tierRowNum = f34_local5,
							tierTargetValue = tonumber(Engine[@"hash_4C6F8EC444864600"](f34_local0, f34_local5, 2)),
							tierXPEarned = tonumber(Engine[@"hash_4C6F8EC444864600"](f34_local0, f34_local5, 6)),
						})
					end
				end
				table.insert(CoD.AARUtilityCP.challengeTable, f34_local9)
			end
		end
	end
	return CoD.AARUtilityCP.challengeTable
end
CoD.AARUtilityCP.CheckChallengeCompletion = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = CoD.getStatsMilestoneTable(3, Enum[@"emodes"][@"mode_campaign"])
	CoD.AARUtilityCP.BuildChallengeTable(f35_arg0)
	for f35_local11, f35_local12 in ipairs(CoD.AARUtilityCP.challengeTable) do
		if not f35_local12.tiers then
			if not f35_local12.isLocked and not Engine[@"getchallengehasbeenseen"](f35_arg0, f35_local12.challengeRow) then
				Engine[@"setchallengehasbeenseen"](f35_arg0, f35_local12.challengeRow)
				CoD.AARUtilityCP.AddReward(f35_arg2, CoD.AARUtilityCP.AddRewardsToChallengeReward(f35_arg0, CoD.AARUtilityCP.CreateChallengeReward(f35_arg0, f35_arg1, f35_local12.challengeRow), tonumber(Engine[@"hash_4C6F8EC444864600"](f35_local0, f35_local12.challengeRow, 6))), "CHALLENGE")
			end
		end
		local f35_local4 = CoD.AARUtilityCP.CreateChallengeReward(f35_arg0, f35_arg1, f35_local12.challengeRow, f35_local12.isLocked)
		local f35_local5 = false
		for f35_local9, f35_local10 in ipairs(f35_local12.tiers) do
			if f35_local10.tierTargetValue <= f35_local12.currChallengeStatValue and not Engine[@"getchallengehasbeenseen"](f35_arg0, f35_local10.tierRowNum) then
				Engine[@"setchallengehasbeenseen"](f35_arg0, f35_local10.tierRowNum)
				f35_local4 = CoD.AARUtilityCP.AddRewardsToChallengeReward(f35_arg0, f35_local4, f35_local10.tierXPEarned, f35_local10.tierID)
				f35_local5 = true
			end
		end
		if f35_local5 then
			CoD.AARUtilityCP.AddReward(f35_arg2, f35_local4, "CHALLENGE")
		end
	end
end
CoD.AARUtilityCP.GetRewardItemCount = function(f36_arg0)
	return Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f36_arg0.controller), "aarRewards.aarRewardsCount"))
end
