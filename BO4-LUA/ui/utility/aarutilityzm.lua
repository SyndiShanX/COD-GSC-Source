CoD.AARUtilityZM = {}
CoD.AARUtilityZM.RankIdCol = 0
CoD.AARUtilityZM.RankTableColMinXP = 2
CoD.AARUtilityZM.RankTableColXPToNext = 3
CoD.AARUtilityZM.RankDisplayStringCol = 5
CoD.AARUtilityZM.RankTableColMaxXP = 7
CoD.AARUtilityZM.RankDisplayLevelCol = 14
CoD.AARUtilityZM.UseTestData = function()
	return false
end
CoD.AARUtilityZM.GetMatchStat = function(f2_arg0, f2_arg1)
	local f2_local0 = CoD.AARUtilityZM.UseTestData()
	local f2_local1, f2_local2 = nil
	f2_local2 = CoD.GetCurrentPlayerStats(f2_arg0)
	if f2_local0 then
		f2_local1 = CoD.GetCurrentPlayerStats(f2_arg0)
	else
		f2_local1 = CoD.GetPlayerStats(f2_arg0, CoD.STATS_LOCATION_STABLE)
	end
	return f2_local2.PlayerStatsList[f2_arg1].StatValue:get() - f2_local1.PlayerStatsList[f2_arg1].StatValue:get()
end
CoD.AARUtilityZM.GetMissionHighestStat = function(f3_arg0, f3_arg1)
	local f3_local0 = CoD.AARUtilityCP.GetLastMapName(f3_arg0)
	local f3_local1 = CoD.GetCurrentPlayerStats(f3_arg0)
	return f3_local1.PlayerStatsByMap[f3_local0].currentStats[f3_arg1]:get()
end
CoD.AARUtilityZM.SetupUIModels = function(f4_arg0)
	local f4_local0 = CoD.AARUtilityZM.UseTestData()
	local f4_local1 = nil
	if f4_local0 then
		f4_local1 = CoD.GetCurrentPlayerStats(f4_arg0)
	else
		f4_local1 = CoD.GetPlayerStats(f4_arg0, CoD.STATS_LOCATION_STABLE)
	end
	local f4_local2 = CoD.GetCurrentPlayerStats(f4_arg0)
	local f4_local3
	if f4_local1 then
		f4_local3 = f4_local1.PlayerStatsList.RANKXP.StatValue:get()
		if not f4_local3 then
		else
			local f4_local4 = f4_local2.PlayerStatsList.RANK.StatValue:get()
			local f4_local5 = f4_local2.PlayerStatsList.PLEVEL.StatValue:get()
			local f4_local6 = CoD.AARUtilityZM.GetXPEarnedDuringMatch(f4_local2.PlayerStatsList.RANKXP.StatValue:get(), f4_local3)
			local f4_local7 = f4_local2.AfterActionReportStats
			local f4_local8 = {}
			f4_local8.nextLevel, f4_local8.nextLevelIcon = CoD.AARUtility.GetLevelAndLevelIconForRank(f4_local4 + 1, f4_local5 + 1)
			if f4_local0 then
				f4_local8.kills = 24
				f4_local8.points = 4550
				f4_local8.rounds = 14
				f4_local8.headshots = 12
				f4_local8.meleeKills = 13
				f4_local8.pointsPerKill = 110.9
				f4_local8.revives = 3
				f4_local8.bgbTokensGainedThisGame = 1
				f4_local8.showBestScoreIcon = 1
				f4_local8.showBestStyleIcon = 1
				f4_local8.showBestRoundIcon = 1
			else
				f4_local8.kills = CoD.AARUtilityZM.GetMatchStat(f4_arg0, "KILLS")
				f4_local8.total_points = f4_local2.PlayerStatsList.TOTAL_POINTS.StatValue:get()
				f4_local8.rounds = CoD.AARUtilityZM.GetMatchStat(f4_arg0, "ROUNDS")
				f4_local8.headshots = CoD.AARUtilityZM.GetMatchStat(f4_arg0, "HEADSHOTS")
				f4_local8.revives = CoD.AARUtilityZM.GetMatchStat(f4_arg0, "REVIVES")
				f4_local8.downs = CoD.AARUtilityZM.GetMatchStat(f4_arg0, "DOWNS")
				f4_local8.meleeKills = CoD.AARUtilityZM.GetMatchStat(f4_arg0, "MELEE_KILLS")
				f4_local8.pointsPerKill = CoD.AARUtilityZM.GetMatchStat(f4_arg0, "BGBS_CHEWED")
				f4_local8.bgbTokensGainedThisGame = f4_local2.PlayerStatsList.BGB_TOKENS_GAINED_THIS_GAME.StatValue:get()
				for f4_local13, f4_local14 in ipairs(Engine.GetRecentChallenges(f4_arg0)) do
					if f4_local14.type == Enum.statsMilestoneTypes_t[@"milestone_daily"] then
						local f4_local12 = tonumber(Engine[@"hash_4C6F8EC444864600"](CoD.getStatsMilestoneTable(f4_local14.tableNumber + 1), f4_local14.row, Enum.milestoneTableColumns_t[@"milestone_column_vialsearned"]))
						if f4_local12 then
							f4_local8.bgbTokensGainedThisGame = f4_local8.bgbTokensGainedThisGame + f4_local12
						end
					end
				end
				f4_local8.showBestScoreIcon = 0
				f4_local8.showBestStyleIcon = 0
				f4_local8.showBestRoundIcon = 0
			end
			if f4_local8.bgbTokensGainedThisGame ~= 0 then
				f4_local2.showMegaChewFactoryBreadcrumb:set(1)
			end
			f4_local8.xpEarnedDuringMatch = f4_local6
			local f4_local15 = Engine.CreateModel(Engine.GetModelForController(f4_arg0), "aarStats.performanceTabStats")
			for f4_local13, f4_local14 in pairs(f4_local8) do
				Engine.SetModelValue(Engine.CreateModel(f4_local15, f4_local13), f4_local14)
			end
			if CoD.isFrontend and f4_arg0 ~= 0 then
				f4_local9 = Engine.CreateModel(Engine.GetModelForController(0), "aarStats.performanceTabStats")
				for f4_local14, f4_local16 in pairs(f4_local8) do
					Engine.SetModelValue(Engine.CreateModel(f4_local9, f4_local14), f4_local16)
				end
			end
			UploadStats(nil, f4_arg0)
		end
	end
	f4_local3 = 0
end
CoD.AARUtilityZM.GetXPEarnedDuringMatch = function(f5_arg0, f5_arg1)
	local f5_local0 = f5_arg0 - f5_arg1
	if f5_local0 < 0 then
		f5_local0 = 0
	end
	return f5_local0
end
CoD.AARUtilityZM.GetModelForRewardItemByIndex = function(f6_arg0, f6_arg1)
	return Engine.GetModel(Engine.GetModelForController(f6_arg0), "aarRewards." .. f6_arg1)
end
CoD.AARUtilityZM.GetRewardItemCount = function(f7_arg0)
	if CoD.AARUtilityZM.UseTestData() then
		return 3
	else
		return 0
	end
end
CoD.AARUtilityZM.CreateQuestItemModels = function(f8_arg0)
	local f8_local0 = Engine.CreateModel(Engine.GetModelForController(f8_arg0), "aarQuests")
end
