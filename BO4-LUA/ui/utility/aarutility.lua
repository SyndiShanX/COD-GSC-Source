CoD.AARUtility = {}
CoD.AARUtility.RankIdCol = 0
CoD.AARUtility.RankTableColMinXP = 2
CoD.AARUtility.RankTableColXPToNext = 3
CoD.AARUtility.RankDisplayStringCol = 5
CoD.AARUtility.RankTableColMaxXP = 7
CoD.AARUtility.RankDisplayLevelCol = 14
CoD.AARUtility.MedalXPCol = 2
CoD.AARUtility.MedalRefCol = 11
CoD.AARUtility.medalStringCol = 2
CoD.AARUtility.medalrefCol = 3
CoD.AARUtility.medalSortkeyCol = 10
CoD.AARUtility.GunRankCol = 0
CoD.AARUtility.GunRefCol = 2
CoD.AARUtility.GunAttachmentRefCol = 3
CoD.AARUtility.GunRankXPCol = 4
CoD.AARUtility.GameOrder = {}
CoD.AARUtility.GameOrder[@"hash_788F5B13A5B62C55"] = 1
CoD.AARUtility.GameOrder[@"hash_788F5A13A5B62AA2"] = 2
CoD.AARUtility.GameOrder[@"hash_788F5913A5B628EF"] = 3
CoD.AARUtility.GameOrder[@"hash_8B20213668F3A80"] = 4
CoD.AARUtility.MaxRank = 55
require("x64:f3c5259f470592d")
require("x64:697c588421e6ee1")
CoD.AARUtility.SetCurrLevelModels = function(f1_arg0, f1_arg1)
	local f1_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f1_arg0), "aarStats.performanceTabStats"), "xpBarInfo")
	local f1_local1 = Engine[@"createmodel"](f1_local0, "currLevel")
	local f1_local2 = Engine[@"createmodel"](f1_local0, "currLevelIcon")
	local f1_local3, f1_local4 = CoD.AARUtility.GetLevelAndLevelIconForRank(f1_arg1, CoD.AARUtility.GetCurrentPrestige(f1_arg0))
	Engine[@"setmodelvalue"](f1_local1, f1_local3)
	Engine[@"setmodelvalue"](f1_local2, f1_local4)
end
CoD.AARUtility.SetCurrLevelModelsForParagon = function(f2_arg0, f2_arg1, f2_arg2)
	local f2_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f2_arg0), "aarStats.performanceTabStats"), "xpBarInfo")
	local f2_local1 = Engine[@"createmodel"](f2_local0, "currLevel")
	local f2_local2 = Engine[@"createmodel"](f2_local0, "currLevelIcon")
	local f2_local3, f2_local4 = CoD.AARUtility.GetLevelAndIconForParagonRank(f2_arg1, f2_arg2)
	Engine[@"setmodelvalue"](f2_local1, f2_local3)
	Engine[@"setmodelvalue"](f2_local2, f2_local4)
end
CoD.AARUtility.SetNextLevelModels = function(f3_arg0, f3_arg1)
	local f3_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f3_arg0), "aarStats.performanceTabStats"), "xpBarInfo")
	local f3_local1 = Engine[@"createmodel"](f3_local0, "nextLevel")
	local f3_local2 = Engine[@"createmodel"](f3_local0, "nextLevelIcon")
	local f3_local3, f3_local4 = CoD.AARUtility.GetLevelAndLevelIconForRank(f3_arg1, CoD.AARUtility.GetCurrentPrestige(f3_arg0))
	Engine[@"setmodelvalue"](f3_local1, f3_local3)
	Engine[@"setmodelvalue"](f3_local2, f3_local4)
end
CoD.AARUtility.SetNextLevelModelsForParagon = function(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f4_arg0), "aarStats.performanceTabStats"), "xpBarInfo")
	local f4_local1 = Engine[@"createmodel"](f4_local0, "nextLevel")
	local f4_local2 = Engine[@"createmodel"](f4_local0, "nextLevelIcon")
	local f4_local3, f4_local4 = CoD.AARUtility.GetLevelAndIconForParagonRank(f4_arg1, f4_arg2)
	Engine[@"setmodelvalue"](f4_local1, f4_local3)
	Engine[@"setmodelvalue"](f4_local2, f4_local4)
end
CoD.AARUtility.GetLevelAndLevelIconForRank = function(f5_arg0, f5_arg1)
	return Engine[@"getrankdisplaylevel"](f5_arg0), Engine[@"hash_D4A9B159BE44163"](f5_arg0)
end
CoD.AARUtility.GetLevelAndIconForParagonRank = function(f6_arg0, f6_arg1)
	local f6_local0 = Engine[@"getparagonrankdisplaylevel"](f6_arg0)
	local f6_local1 = Engine[@"hash_B1AE00E1863FFE1"](f6_arg0)
	if f6_arg1 ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
		f6_local1 = Engine[@"getparagoniconbyid"](f6_arg1)
	end
	return f6_local0, f6_local1
end
CoD.AARUtility.GetCurrentPrestige = function(f7_arg0)
	local f7_local0 = CoD.GetPlayerStats(f7_arg0)
	return f7_local0.PlayerStatsList.PLEVEL.StatValue:get()
end
CoD.AARUtility.GetMinMaxXPForRank = function(f8_arg0, f8_arg1)
	return tonumber(Engine[@"getrankminxp"](f8_arg0)), tonumber(Engine[@"getrankmaxxp"](f8_arg0))
end
CoD.AARUtility.GetMinMaxXPForParagonRank = function(f9_arg0, f9_arg1)
	return tonumber(Engine[@"hash_109F8F1C5A3513B"](f9_arg0)), tonumber(Engine[@"hash_5E7C7AB06A7E4905"](f9_arg0))
end
CoD.AARUtility.UpdateRankInfoIconsForPrestige = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	if not f10_arg2 then
		return nil
	elseif not f10_arg3 then
		f10_arg3 = Engine[@"currentsessionmode"]()
	end
	local f10_local0 = CoD.RankUtility.GetRankIcons(f10_arg0, f10_arg3, f10_arg1)
	f10_arg2.icon = f10_local0.icon
	f10_arg2.iconLarge = f10_local0.iconLarge
	return f10_arg2
end
CoD.AARUtility.XPBarAnimTime = 1000
CoD.AARUtility.UseTestData = function()
	local f11_local0 = Dvar[@"aar_test"]:exists()
	if f11_local0 then
		if Dvar[@"aar_test"]:get() ~= true and Dvar[@"aar_test"]:get() ~= "1" then
			f11_local0 = false
		else
			f11_local0 = true
		end
	end
	return f11_local0
end
CoD.AARUtility.TestMultiplePromotions = function()
	local f12_local0 = Dvar[@"hash_4B1425C8D55AE7AC"]:exists()
	if f12_local0 then
		if Dvar[@"hash_4B1425C8D55AE7AC"]:get() ~= true and Dvar[@"hash_4B1425C8D55AE7AC"]:get() ~= "1" then
			f12_local0 = false
		else
			f12_local0 = true
		end
	end
	return f12_local0
end
CoD.AARUtility.TestSinglePromotion = function()
	local f13_local0 = Dvar[@"hash_3FB23BB9B9A617B4"]:exists()
	if f13_local0 then
		if Dvar[@"hash_3FB23BB9B9A617B4"]:get() ~= true and Dvar[@"hash_3FB23BB9B9A617B4"]:get() ~= "1" then
			f13_local0 = false
		else
			f13_local0 = true
		end
	end
	return f13_local0
end
CoD.AARUtility.SetupNeededAarModels = function(f14_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f14_arg0), "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]), 1)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f14_arg0), "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]), 1)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f14_arg0), "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]), 1)
end
CoD.AARUtility.SetupUIModels = function(f15_arg0)
	local f15_local0 = CoD.AARUtility.UseTestData()
	local f15_local1, f15_local2 = nil
	if f15_local0 then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f15_arg0), "aarType"), "public")
	end
	Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f15_arg0), "deadSpectator.playerIndex")
	Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f15_arg0), "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_team_spectator"])
	Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f15_arg0), "gameScore.gameTimeEnd")
	Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f15_arg0), "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
	if f15_local0 then
		f15_local1 = CoD.GetCurrentPlayerStats(f15_arg0)
	else
		f15_local1 = CoD.GetBeforeMatchPlayerStats(f15_arg0)
	end
	local f15_local3 = CoD.GetCurrentPlayerStats(f15_arg0)
	local f15_local4 = f15_local1.PlayerStatsList.RANKXP.StatValue:get()
	local f15_local5 = f15_local3.PlayerStatsList.RANK.StatValue:get()
	local f15_local6 = f15_local3.PlayerStatsList.PLEVEL.StatValue:get()
	local f15_local7 = f15_local3.PlayerStatsList.RANKXP.StatValue:get()
	local f15_local8 = CoD.PrestigeNext(f15_arg0)
	local f15_local9 = CoD.AARUtility.GetXPEarnedDuringMatch(f15_local7, f15_local4)
	if IsInParagonCapableGameMode() and f15_local6 == CoD.PrestigeUtility.GetPrestigeCap() then
		f15_local9 = CoD.AARUtility.GetXPEarnedDuringMatch(f15_local3.PlayerStatsList.PARAGON_RANKXP.StatValue:get(), f15_local1.PlayerStatsList.PARAGON_RANKXP.StatValue:get())
	end
	local f15_local10 = {}
	if f15_local8 then
		f15_local10.nextLevel = CoD.PrestigeNextLevelText(f15_arg0)
		f15_local10.nextLevelIcon = Engine[@"hash_6E21763E1EB756F8"](f15_local6 + 1)
	else
		f15_local10.nextLevel, f15_local10.nextLevelIcon = CoD.AARUtility.GetLevelAndLevelIconForRank(f15_local5 + 1, f15_local6 + 1)
	end
	if f15_local0 then
		f15_local2 = "tdm"
		f15_local10.kills = 24
		f15_local10.deaths = 26
		f15_local10.score = 2500
		local f15_local11 = Engine[@"getgametypeinfo"](f15_local2)
		f15_local10.gameTypeName = f15_local11.nameRefCaps
		f15_local10.gameTypeNameNormal = f15_local11.nameRef
		f15_local10.gameTypeIcon = f15_local11.image
		f15_local10.wins = 116
		f15_local10.losses = 90
		f15_local10.winLossRatio = 1.28
		f15_local10.lossesRingClockFrac = string.format("%.2f", f15_local10.losses / math.max(1, f15_local10.wins + f15_local10.losses))
		f15_local10.showBestScoreIcon = 1
		f15_local10.showBestKillsIcon = 1
		f15_local10.showBestSPMIcon = 1
		f15_local10.showBestKDRIcon = 1
	else
		f15_local2 = Engine[@"hash_36F8027A8BC75673"]()
		local f15_local11 = Engine[@"getgametypeinfo"](f15_local2)
		f15_local10.kills = f15_local3.PlayerStatsList.KILLS.StatValue:get() - f15_local1.PlayerStatsList.KILLS.StatValue:get()
		f15_local10.deaths = f15_local3.PlayerStatsList.DEATHS.StatValue:get() - f15_local1.PlayerStatsList.DEATHS.StatValue:get()
		f15_local10.score = f15_local3.PlayerStatsList.SCORE.StatValue:get() - f15_local1.PlayerStatsList.SCORE.StatValue:get()
		local f15_local12 = Engine[@"getdemofileid"]()
		local f15_local13 = f15_local11.nameRef
		local f15_local14 = Engine[@"getmatchrecordstats"](f15_arg0)
		local f15_local15 = f15_local14.playerBuffer
		local f15_local16 = f15_local14.header
		local f15_local17 = f15_local16.alliesScore:get()
		local f15_local18 = f15_local16.axisScore:get()
		local f15_local19 = f15_local16.map:get()
		local f15_local20 = aarStats.team:get()
		for f15_local21 = 1, #f15_local15, 1 do
			local f15_local24 = f15_local15[f15_local21 - 1]
			if f15_local24.xuid:get() == f15_local3.PlayerXUID:get() then
				f15_local20 = f15_local24.team:get()
				break
			end
		end
		if f15_local2 and f15_local2 ~= "" then
			local f15_local21 = aarStats.hardcore
			if f15_local21 then
				f15_local21 = aarStats.hardcore:get()
			end
			f15_local10.gameTypeIcon = f15_local11.image
			if f15_local21 ~= nil and f15_local21 == 1 then
				f15_local10.gameTypeNameNormal = f15_local11.hardcoreNameRef
				f15_local10.gameTypeName = LocalizeToUpperString(f15_local10.gameTypeNameNormal)
				f15_local2 = "hc" .. f15_local2
			else
				f15_local10.gameTypeName = f15_local11.nameRefCaps
				f15_local10.gameTypeNameNormal = f15_local11.nameRef
			end
			local f15_local22 = Engine[@"converttoxhash"](f15_local2)
			local f15_local23 = Engine[@"hash_7D492E0385F6D3E4"](f15_local2)
			f15_local10.wins = f15_local3.PlayerStatsByGameType[f15_local23].WINS.StatValue:get()
			f15_local10.losses = f15_local3.PlayerStatsByGameType[f15_local23].LOSSES.StatValue:get()
			f15_local10.winLossRatio = string.format("%.2f", f15_local10.wins / math.max(1, f15_local10.losses))
			f15_local10.lossesRingClockFrac = string.format("%.2f", f15_local10.losses / math.max(1, f15_local10.wins + f15_local10.losses))
		end
		f15_local10.showBestScoreIcon = 0
		f15_local10.showBestKillsIcon = 0
		f15_local10.showBestSPMIcon = 0
		f15_local10.showBestKDRIcon = 0
	end
	local f15_local25 = (f15_local3.PlayerStatsList.SCORE.StatValue:get() - f15_local1.PlayerStatsList.SCORE.StatValue:get()) / math.max(1, f15_local3.PlayerStatsList.TIME_PLAYED_TOTAL.StatValue:get() - f15_local1.PlayerStatsList.TIME_PLAYED_TOTAL.StatValue:get())
	local f15_local26 = f15_local10.kills / math.max(1, f15_local10.deaths)
	f15_local10.xpEarnedDuringMatch = f15_local9
	local f15_local12 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f15_arg0), "aarStats.performanceTabStats")
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f15_arg0), "aarStats.xpScale"), Engine[@"getxpscale"](f15_arg0))
	for f15_local16, f15_local17 in pairs(f15_local10) do
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f15_local12, f15_local16), f15_local17)
	end
	CoD.AARUtility.CreateUIModelsForPerformanceGraphs(f15_arg0, f15_local12, f15_local2)
	if CoD.isFrontend and f15_arg0 ~= 0 then
		f15_local13 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](0), "aarStats.performanceTabStats")
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](0), "aarStats.xpScale"), Engine[@"getxpscale"](0))
		for f15_local17, f15_local18 in pairs(f15_local10) do
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f15_local13, f15_local17), f15_local18)
		end
		f15_local14 = CoD.SafeGetModelValue(f15_local12, "globalSPM")
		f15_local15 = CoD.SafeGetModelValue(f15_local12, "globalKDR")
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f15_local13, "globalSPM"), f15_local14)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f15_local13, "globalKDR"), f15_local15)
	end
end
CoD.AARUtility.GetMaxValue = function(f16_arg0, f16_arg1)
	local f16_local0 = 0
	for f16_local4, f16_local5 in ipairs(f16_arg0) do
		if f16_local5[f16_arg1] and f16_local0 < tonumber(f16_local5[f16_arg1]) then
			f16_local0 = tonumber(f16_local5[f16_arg1])
		end
	end
	return f16_local0
end
CoD.AARUtility.GetMinValue = function(f17_arg0, f17_arg1)
	if not f17_arg0[1] then
		return
	end
	local f17_local0 = tonumber(f17_arg0[1][f17_arg1])
	for f17_local4, f17_local5 in ipairs(f17_arg0) do
		if f17_local5[f17_arg1] and tonumber(f17_local5[f17_arg1]) < f17_local0 then
			f17_local0 = tonumber(f17_local5[f17_arg1])
		end
	end
	return f17_local0
end
CoD.AARUtility.SetGraphValues = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5)
	local f18_local0 = CoD.AARUtility.UseTestData()
	if CoD.AARUtility.UseTestData() then
		for f18_local4, f18_local5 in ipairs({
			0.3,
			0.8,
			0.5,
			0.7,
			0.1,
		}) do
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f18_arg3, "graphValue" .. f18_local4), string.format("%.2f", f18_local5) .. " 0 0 0")
		end
	else
		for f18_local3, f18_local4 in ipairs(f18_arg0) do
			local f18_local5 = f18_local4[f18_arg1]
			local f18_local7 = 0
			if f18_arg2 <= f18_local5 then
				f18_local7 = 0.5 - (f18_local5 - f18_arg2) / math.max(1, f18_arg4 - f18_arg2) / 2
			else
				f18_local7 = 0.5 + (f18_arg2 - f18_local5) / math.max(1, f18_arg2 - f18_arg5) / 2
			end
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f18_arg3, "graphValue" .. f18_local3), string.format("%.2f", f18_local7) .. " 0 0 0")
		end
	end
end
CoD.AARUtility.CreateUIModelsForPerformanceGraphs = function(f19_arg0, f19_arg1, f19_arg2)
	local f19_local0 = CoD.AARUtility.UseTestData()
	local f19_local1 = {}
	local f19_local2 = 5
	local f19_local3 = 10
	local f19_local4 = CoD.GetCurrentPlayerStats(f19_arg0)
	local f19_local5 = Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](f19_arg2))
	local f19_local6 = f19_local4.PlayerStatsByGameType[f19_local5].prevScores
	local f19_local7 = f19_local4.PlayerStatsByGameType[f19_local5].prevScoreIndex:get()
	if f19_local7 < 0 or f19_local3 < f19_local7 then
		f19_local7 = 0
	end
	local f19_local8 = f19_local4.PlayerStatsByGameType[f19_local5].SCORE.StatValue:get()
	local f19_local9 = f19_local4.PlayerStatsByGameType[f19_local5].TIME_PLAYED_TOTAL.StatValue:get()
	local f19_local10 = f19_local4.PlayerStatsByGameType[f19_local5].KILLS.StatValue:get()
	local f19_local11 = f19_local4.PlayerStatsByGameType[f19_local5].DEATHS.StatValue:get()
	local f19_local12 = math.ceil(f19_local4.PlayerStatsList.SCORE.StatValue:get() / math.max(1, f19_local4.PlayerStatsList.TIME_PLAYED_TOTAL.StatValue:get() / 60))
	local f19_local13 = string.format("%.2f", f19_local4.PlayerStatsList.KILLS.StatValue:get() / math.max(1, f19_local4.PlayerStatsList.DEATHS.StatValue:get()))
	local f19_local14, f19_local15 = nil
	if f19_local0 then
		f19_local14 = 195
		f19_local15 = 0.95
		f19_local12 = 420
		f19_local13 = 1.25
		local f19_local16 = {
			180,
			202,
			175,
			208,
			201,
		}
		local f19_local17 = {
			1.5,
			0.87,
			1.2,
			1.65,
			0.65,
		}
		for f19_local18 = 1, f19_local2, 1 do
			table.insert(f19_local1, {
				spm = f19_local16[f19_local18],
				kdr = f19_local17[f19_local18],
				valid = 1,
			})
		end
	else
		for f19_local16 = 1, f19_local2, 1 do
			local f19_local19 = f19_local16
			local f19_local20 = {}
			local f19_local21 = f19_local6[f19_local7].score:get()
			local f19_local22 = f19_local6[f19_local7].timePlayed:get()
			local f19_local23 = f19_local6[f19_local7].kills:get()
			local f19_local24 = f19_local6[f19_local7].deaths:get()
			f19_local20.spm = math.floor(f19_local21 / math.max(1, f19_local22 / 60))
			f19_local20.kdr = string.format("%.2f", f19_local23 / math.max(1, f19_local24))
			f19_local20.valid = f19_local6[f19_local7].valid:get()
			table.insert(f19_local1, f19_local20)
			f19_local7 = f19_local7 - 1
			if f19_local7 < 0 then
				f19_local7 = f19_local3 - 1
			end
		end
	end
	local f19_local16 = Engine[@"createmodel"](f19_arg1, "spmGraph")
	local f19_local17 = Engine[@"createmodel"](f19_arg1, "kdrGraph")
	local f19_local18 = 0
	local f19_local19 = 0
	local f19_local20 = 0
	for f19_local24, f19_local25 in ipairs(f19_local1) do
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f19_local16, "value" .. f19_local24), f19_local25.spm)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f19_local16, "value" .. f19_local24 .. "Valid"), f19_local25.valid)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f19_local17, "value" .. f19_local24), string.format("%.2f", f19_local25.kdr))
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f19_local17, "value" .. f19_local24 .. "Valid"), f19_local25.valid)
		if f19_local25.valid == 1 then
			f19_local20 = f19_local20 + 1
			f19_local18 = f19_local18 + f19_local25.spm
			f19_local19 = f19_local19 + f19_local25.kdr
		end
	end
	if f19_local20 == 0 then
		local f19_local26 = "0.00"
	end
	f19_local15 = f19_local26 or string.format("%.2f", f19_local19 / f19_local20)
	if f19_local20 == 0 then
		local f19_local27 = 0
	end
	f19_local14 = f19_local27 or math.ceil(f19_local18 / f19_local20)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f19_local16, "avgSPM"), f19_local14)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f19_local17, "avgKDR"), f19_local15)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f19_arg1, "globalSPM"), f19_local12)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f19_arg1, "globalKDR"), f19_local13)
	f19_local21 = CoD.AARUtility.GetMaxValue(f19_local1, "spm")
	f19_local22 = CoD.AARUtility.GetMinValue(f19_local1, "spm")
	f19_local23 = math.max(f19_local21, f19_local14 + 200)
	f19_local24 = math.min(f19_local22, math.max(f19_local14 - 100, 0))
	f19_local25 = f19_local23 - f19_local24
	f19_local23 = math.max(f19_local23, f19_local21 + f19_local25 / 20)
	f19_local24 = math.min(f19_local24, f19_local22 - f19_local25 / 20)
	local f19_local28 = CoD.AARUtility.GetMaxValue(f19_local1, "kdr")
	local f19_local29 = CoD.AARUtility.GetMinValue(f19_local1, "kdr")
	local f19_local30 = math.max(f19_local28, f19_local15 + 1.5)
	local f19_local31 = math.min(f19_local29, math.max(f19_local15 - 0.5, 0))
	local f19_local32 = f19_local30 - f19_local31
	f19_local30 = math.max(f19_local30, f19_local28 + f19_local32 / 20)
	f19_local31 = math.min(f19_local31, f19_local29 - f19_local32 / 20)
	CoD.AARUtility.SetGraphValues(f19_local1, "spm", f19_local14, f19_local16, f19_local23, f19_local24)
	CoD.AARUtility.SetGraphValues(f19_local1, "kdr", f19_local15, f19_local17, f19_local30, f19_local31)
end
CoD.AARUtility.GetXPEarnedDuringMatch = function(f20_arg0, f20_arg1)
	local f20_local0 = f20_arg0 - f20_arg1
	if f20_local0 < 0 then
		f20_local0 = 0
	end
	return f20_local0
end
CoD.AARUtility.AnyItemsUnlockedForRank = function(f21_arg0, f21_arg1)
	for f21_local3, f21_local4 in pairs(f21_arg1) do
		if Engine[@"getitemunlocklevel"](f21_local4.itemIndex) == f21_arg0 then
			return true
		end
	end
end
CoD.AARUtility.GetBlueprintStringPrefixForItem = function(f22_arg0)
	local f22_local0 = Engine[@"getloadoutslotforitem"](f22_arg0)
	if f22_local0 == "primary" or f22_local0 == "secondary" then
		return Engine[@"getitemgroup"](f22_arg0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"])
	else
		return f22_local0
	end
end
CoD.AARUtility.IsHeroAbility = function(f23_arg0)
	if LUI.startswith(Engine[@"getitemref"](f23_arg0), "gadget_") then
		return true
	else
	end
end
CoD.AARUtility.IsHeroWeapon = function(f24_arg0)
	if LUI.startswith(Engine[@"getitemref"](f24_arg0), "hero_") then
		return true
	else
	end
end
CoD.AARUtility.CreateRewardInfoModel = function(f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4, f25_arg5)
	local f25_local0 = Engine[@"createmodel"](f25_arg0, "reward" .. f25_arg1 .. "Info")
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f25_arg0, "reward" .. f25_arg1 .. "InfoVisible"), 1)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f25_local0, "rewardName"), f25_arg2)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f25_local0, "rewardImage"), f25_arg3)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f25_local0, "rewardDesc"), f25_arg4)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f25_local0, "isCallingCard"), f25_arg5 or false)
	return f25_local0
end
CoD.AARUtility.GetRewardItemCount = function(f26_arg0)
	return Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f26_arg0.controller), "aarRewards.rewardsCarouselItemCount"))
end
CoD.AARUtility.GetModelForRewardItemByIndex = function(f27_arg0, f27_arg1)
	return Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f27_arg0), "aarRewards.rewardsCarouselItem" .. f27_arg1)
end
CoD.AARUtility.SortMedals = function(f28_arg0, f28_arg1)
	if f28_arg0 and f28_arg0.row and f28_arg1 and f28_arg1.row then
		local f28_local0 = Engine[@"hash_4C6F8EC444864600"](CoD.scoreInfoTable, f28_arg0.row, CoD.AARUtility.medalSortkeyCol)
		local f28_local1 = Engine[@"hash_4C6F8EC444864600"](CoD.scoreInfoTable, f28_arg1.row, CoD.AARUtility.medalSortkeyCol)
		if f28_local0 and f28_local1 then
			local f28_local2 = tonumber(f28_local0)
			local f28_local3 = tonumber(f28_local1)
			if f28_local2 == f28_local3 then
				return f28_arg0.value < f28_arg1.value
			else
				return f28_local2 < f28_local3
			end
		end
	end
	return false
end
CoD.AARUtility.CountdownRequiredXPNumber = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3, f29_arg4, f29_arg5)
	local f29_local0 = CoD.AARUtility.XPBarAnimTime
	local f29_local1 = Engine[@"createmodel"](Engine[@"getmodel"](Engine[@"getmodelforcontroller"](CoD.isFrontend and 0 or f29_arg0), "aarStats.performanceTabStats"), "xpNeededToLevelUpStringRefValue")
	local self = LUI.UITimer.new(5, "count_down", false, f29_arg1)
	self.currentValue = f29_arg3
	self.minValue = f29_arg4
	f29_arg1.xpNumberTimer = self
	local f29_local3 = 0
	f29_arg1:registerEventHandler("count_down", function(element, event)
		f29_local3 = f29_local3 + event.timeElapsed
		self.currentValue = math.floor(f29_arg3 - f29_local3 / f29_local0 * f29_arg3)
		if self.currentValue < self.minValue or f29_local0 < f29_local3 then
			self.currentValue = self.minValue
			self:close()
			if f29_arg5 then
				f29_arg5()
			end
		end
		Engine[@"setmodelvalue"](f29_local1, self.currentValue)
		if CoD.isFrontend and f29_arg0 ~= 0 then
			Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](0), "aarStats.performanceTabStats.xpNeededToLevelUpStringRefValue"), self.currentValue)
		end
	end)
	f29_arg1:addElement(f29_arg1.xpNumberTimer)
end
CoD.AARUtility.DoXPBarAnimationSequence = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3, f31_arg4, f31_arg5, f31_arg6, f31_arg7)
	local f31_local0 = CoD.AARUtility.XPBarAnimTime
	local f31_local1 = f31_arg1.XpBarContainer.XpBar
	local f31_local2, f31_local3 = CoD.AARUtility.GetMinMaxXPForRank(f31_arg3, f31_arg0)
	if f31_arg6 then
		f31_local2, f31_local3 = CoD.AARUtility.GetMinMaxXPForParagonRank(f31_arg3, f31_arg0)
	end
	local f31_local4 = (f31_arg2 - f31_local2) / math.max(1, f31_local3 - f31_local2)
	local f31_local5 = 1
	local f31_local6 = 0
	local f31_local7 = 0
	if f31_arg3 == f31_arg4 then
		f31_local5 = (f31_arg5 - f31_local2) / math.max(1, f31_local3 - f31_local2)
		f31_local6 = f31_local3 - f31_arg5
	end
	f31_local1.XpBarCurrXPBg:setShaderVector(0, f31_local4, 0, 0, 0)
	f31_local1.XpBarEarnedXPBg:setShaderVector(0, f31_local4, 0, 0, 0)
	f31_local1.XpBarEarnedXPBg:beginAnimation("animate_bar", f31_local0, true, true)
	f31_local1.XpBarEarnedXPBg:setShaderVector(0, f31_local5, 0, 0, 0)
	Engine[@"playsound"]("uin_aar_bar_fill_main")
	CoD.AARUtility.CountdownRequiredXPNumber(f31_arg0, f31_arg1, f31_local1, f31_local3 - f31_arg2, f31_local6, function()
		Engine[@"playsound"]("uin_aar_bar_fill_tail")
		if f31_arg4 <= f31_arg3 then
			if Engine[@"iscampaigngame"]() then
				CoD.AARUtilityCP.hasSeenXPBarAnim = true
			end
			return
		else
			f31_arg1.XpBarContainer:playClip("Update")
			f31_arg1.XpBarContainer:registerEventHandler("clip_over", function(element, event)
				local f33_local0 = math.min(CoD.RankUtility.GetRankCap(), f31_arg3 + 1)
				local f33_local1, f33_local2 = CoD.AARUtility.GetMinMaxXPForRank(f33_local0, f31_arg0)
				if f31_arg6 then
					f33_local0 = math.min(CoD.getParagonRankCap(), f31_arg3 + 1)
					f33_local1, f33_local2 = CoD.AARUtility.GetMinMaxXPForParagonRank(f33_local0, f31_arg0)
					CoD.AARUtility.SetCurrLevelModelsForParagon(f31_arg0, f33_local0, f31_arg7)
					CoD.AARUtility.SetNextLevelModelsForParagon(f31_arg0, math.min(CoD.getParagonRankCap(), f33_local0 + 1), f31_arg7)
				else
					CoD.AARUtility.SetCurrLevelModels(f31_arg0, f33_local0)
					CoD.AARUtility.SetNextLevelModels(f31_arg0, math.min(CoD.RankUtility.GetRankCap(), f33_local0 + 1))
				end
				f31_local1.XpBarCurrXPBg:setShaderVector(0, 0, 0, 0, 0)
				f31_local1.XpBarEarnedXPBg:setShaderVector(0, 0, 0, 0, 0)
				if IsCampaign() and f33_local0 == CoD.RankUtility.GetRankCap() then
					f31_arg1.XpBarContainer:playClip("FlashLastLevel")
				else
					f31_arg1.XpBarContainer:playClip("FlashNextLevel")
				end
				f31_arg1.XpBarContainer:registerEventHandler("clip_over", function(element, event)
					CoD.AARUtility.DoXPBarAnimationSequence(f31_arg0, f31_arg1, f33_local1, f33_local0, f31_arg4, f31_arg5, f31_arg6, f31_arg7)
				end)
			end)
		end
	end)
end
CoD.AARUtility.DoXPBarAnimation = function(f35_arg0, f35_arg1)
	local f35_local0 = CoD.AARUtility.UseTestData()
	if Engine[@"iscampaigngame"]() then
		f35_local0 = CoD.AARUtilityCP.UseTestData()
	end
	local f35_local1 = CoD.AARUtility.TestSinglePromotion()
	local f35_local2 = CoD.AARUtility.TestMultiplePromotions()
	local f35_local3, f35_local4, f35_local5, f35_local6 = nil
	local f35_local7 = false
	local f35_local8 = CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID
	if not f35_local0 then
		local f35_local9 = CoD.GetBeforeMatchPlayerStats(f35_arg1)
		local f35_local10 = IsInParagonCapableGameMode()
		if f35_local10 then
			f35_local10 = f35_local9.PlayerStatsList.PLEVEL.StatValue:get()
		end
		f35_local7 = IsInParagonCapableGameMode() and f35_local10 == CoD.PrestigeUtility.GetPrestigeCap()
		if Engine[@"iscampaigngame"]() then
			local f35_local11 = CoD.GetCurrentPlayerStats(f35_arg1)
			f35_local3 = CoD.AARUtilityCP.GetRankForRankXP(f35_arg1, f35_local11.currentRankXP:get())
			f35_local6 = f35_local11.PlayerStatsList.RANK.StatValue:get()
			f35_local5 = f35_local11.PlayerStatsList.RANKXP.StatValue:get()
		elseif f35_local7 then
			f35_local3 = f35_local9.PlayerStatsList.PARAGON_RANK.StatValue:get()
			f35_local4 = f35_local9.PlayerStatsList.PARAGON_RANKXP.StatValue:get()
			local f35_local11 = CoD.GetCurrentPlayerStats(f35_arg1)
			f35_local6 = f35_local11.PlayerStatsList.PARAGON_RANK.StatValue:get()
			f35_local5 = f35_local11.PlayerStatsList.PARAGON_RANKXP.StatValue:get()
			f35_local8 = f35_local11.PlayerStatsList.PARAGON_ICON_ID.StatValue:get()
		else
			f35_local3 = f35_local9.PlayerStatsList.RANK.StatValue:get()
			f35_local4 = f35_local9.PlayerStatsList.RANKXP.StatValue:get()
			local f35_local11 = CoD.GetCurrentPlayerStats(f35_arg1)
			f35_local6 = f35_local11.PlayerStatsList.RANK.StatValue:get()
			f35_local5 = f35_local11.PlayerStatsList.RANKXP.StatValue:get()
		end
	end
	local f35_local9 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f35_arg1), "aarStats.performanceTabStats")
	local f35_local10 = f35_arg0.XpBarContainer.XpBar
	if f35_local0 then
		if f35_local2 then
			f35_local3 = 4
			f35_local4 = 20250
			f35_local5 = 35500
			f35_local6 = 6
		elseif f35_local1 then
			f35_local3 = 5
			f35_local4 = 28500
			f35_local5 = 35500
			f35_local6 = 6
		else
			f35_local3 = 5
			f35_local4 = 28500
			f35_local5 = 31500
			f35_local6 = 5
		end
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f35_local9, "xpEarnedDuringMatch"), f35_local5 - f35_local4)
	end
	if not Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f35_arg1), "doAARXPBarAnimation")) then
		local f35_local12 = f35_local6 + 1
		local f35_local13 = CoD.RankUtility.GetRankCap()
		if f35_local7 then
			CoD.AARUtility.SetCurrLevelModelsForParagon(f35_arg1, f35_local6, f35_local8)
			f35_local13 = CoD.getParagonRankCap()
		else
			CoD.AARUtility.SetCurrLevelModels(f35_arg1, f35_local6)
		end
		if f35_local13 < f35_local12 then
			f35_local12 = f35_local6
		end
		local f35_local14 = f35_local5
		local f35_local15 = f35_local5
		if IsCampaign() and f35_local12 == f35_local6 then
			f35_local10.XpBarCurrXPBg:setShaderVector(0, 0, 0, 0, 0)
			f35_local10.XpBarEarnedXPBg:setShaderVector(0, 0, 0, 0, 0)
			f35_arg0.XpBarContainer.RankIconAndNumberWidgetNextTop:setAlpha(0)
			f35_arg0.XpBarContainer.RankIconAndNumberWidgetNextBase:setAlpha(0)
			f35_arg0.XpBarContainer.NextLevelDisplay:setAlpha(0)
			f35_arg0.XpBarContainer.XpBar:setAlpha(0)
			f35_arg0.XpBarContainer.XpBarFrame:setAlpha(0)
			f35_arg0.XpBarContainer.MeterGlow:setAlpha(0)
			f35_arg0.XpBarContainer.XPEarnedDisplay:setAlpha(0)
		elseif f35_local7 then
			CoD.AARUtility.SetNextLevelModelsForParagon(f35_arg1, f35_local12, f35_local8)
			f35_local14, f35_local15 = CoD.AARUtility.GetMinMaxXPForParagonRank(f35_local6, f35_arg1)
			f35_local10.XpBarCurrXPBg:setShaderVector(0, (f35_local5 - f35_local14) / math.max(1, f35_local15 - f35_local14), 0, 0, 0)
			f35_local10.XpBarEarnedXPBg:setShaderVector(0, 0, 0, 0, 0)
		else
			CoD.AARUtility.SetNextLevelModels(f35_arg1, f35_local12)
			f35_local14, f35_local15 = CoD.AARUtility.GetMinMaxXPForRank(f35_local6, f35_arg1)
			f35_local10.XpBarCurrXPBg:setShaderVector(0, (f35_local5 - f35_local14) / math.max(1, f35_local15 - f35_local14), 0, 0, 0)
			f35_local10.XpBarEarnedXPBg:setShaderVector(0, 0, 0, 0, 0)
		end
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f35_local9, "xpNeededToLevelUpStringRefValue"), f35_local15 - f35_local5)
		if CoD.isFrontend and f35_arg1 ~= 0 then
			Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](0), "aarStats.performanceTabStats.xpNeededToLevelUpStringRefValue"), f35_local15 - f35_local5)
		end
	elseif f35_local7 then
		local f35_local12, f35_local13 = CoD.AARUtility.GetMinMaxXPForParagonRank(f35_local3, f35_arg1)
		local f35_local14 = (f35_local4 - f35_local12) / math.max(1, f35_local13 - f35_local12)
		f35_local10.XpBarCurrXPBg:setShaderVector(0, f35_local14, 0, 0, 0)
		f35_local10.XpBarEarnedXPBg:setShaderVector(0, f35_local14, 0, 0, 0)
		CoD.AARUtility.SetCurrLevelModelsForParagon(f35_arg1, f35_local3, f35_local8)
		CoD.AARUtility.SetNextLevelModelsForParagon(f35_arg1, math.min(CoD.getParagonRankCap(), f35_local3 + 1), f35_local8)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f35_local9, "xpNeededToLevelUpStringRefValue"), f35_local13 - f35_local4)
		if CoD.isFrontend and f35_arg1 ~= 0 then
			Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](0), "aarStats.performanceTabStats.xpNeededToLevelUpStringRefValue"), f35_local13 - f35_local4)
		end
		local self = LUI.UITimer.new(1000, "start_xp_bar_animation", true, f35_arg0)
		f35_arg0:registerEventHandler("start_xp_bar_animation", function()
			CoD.AARUtility.DoXPBarAnimationSequence(f35_arg1, f35_arg0, f35_local4, f35_local3, f35_local6, f35_local5, f35_local7, f35_local8)
		end)
		f35_arg0:addElement(self)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f35_arg1), "doAARXPBarAnimation"), false)
	else
		local f35_local12, f35_local13 = CoD.AARUtility.GetMinMaxXPForRank(f35_local3, f35_arg1)
		local f35_local14 = (f35_local4 - f35_local12) / math.max(1, f35_local13 - f35_local12)
		f35_local10.XpBarCurrXPBg:setShaderVector(0, f35_local14, 0, 0, 0)
		f35_local10.XpBarEarnedXPBg:setShaderVector(0, f35_local14, 0, 0, 0)
		CoD.AARUtility.SetCurrLevelModels(f35_arg1, f35_local3)
		CoD.AARUtility.SetNextLevelModels(f35_arg1, math.min(CoD.RankUtility.GetRankCap(), f35_local3 + 1))
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f35_local9, "xpNeededToLevelUpStringRefValue"), f35_local13 - f35_local4)
		if CoD.isFrontend and f35_arg1 ~= 0 then
			Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](0), "aarStats.performanceTabStats.xpNeededToLevelUpStringRefValue"), f35_local13 - f35_local4)
		end
		local self = LUI.UITimer.new(1000, "start_xp_bar_animation", true, f35_arg0)
		f35_arg0:registerEventHandler("start_xp_bar_animation", function()
			CoD.AARUtility.DoXPBarAnimationSequence(f35_arg1, f35_arg0, f35_local4, f35_local3, f35_local6, f35_local5, f35_local7, f35_local8)
		end)
		f35_arg0:addElement(self)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f35_arg1), "doAARXPBarAnimation"), false)
	end
end
CoD.AARUtility.AARTabs = LuaEnum.createEnum("AAR_SUMMARY", "AAR_SCOREBOARD", "ZM_AAR_SCOREBOARD", "AAR_TRIAL", "AAR_REWARDS", "AAR_ARENA_LEAGUE_PLAY_LADDER", "AAR_MEDALS", "AAR_MERIT", "AAR_SQUAD", "AAR_CONTRACTS")
CoD.AARUtility.AARStatType = LuaEnum.createEnum("SCORE_PER_MINUTE", "SCORE", "DAMAGE", "OBJECTIVE", "EKIA_RATIO", "EKIA", "WL_RATIO", "KILLS", "CAPTURES_AND_RETURNS")
CoD.AARUtility.AARRewardType = LuaEnum.createEnum("PLAYER", "WEAPON", "CLASS", "CHALLENGE", "CURRENCY", "SPECIAL_EVENT", "DAILY_CALLING", "FACTION_CALLING", "CONTRACT")
CoD.AARUtility.AARFeatureRewardType = LuaEnum.createEnum("NONE", "CAC", "DEFAULT_CLASS", "CUSTOM_CLASS")
DataSources.AARTabs = ListHelper_SetupDataSource("AARTabs", function(f38_arg0, f38_arg1)
	local f38_local0 = {}
	if Engine[@"ismultiplayergame"]() then
		if LuaUtils.IsArenaMode() then
			if CoD.AARUtility.PlayerEarnedRewards(f38_arg0) then
				table.insert(f38_local0, {
					models = {
						tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/rewards"),
						action = CoD.AARUtility.SwitchAARTabs,
						param = CoD.AARUtility.AARTabs.AAR_REWARDS,
					},
					properties = {
						tabId = "rewards",
					},
				})
			end
			if CoD.ArenaLeaguePlayUtility.ShouldShowLeaguePlayLadderResults(f38_arg0) then
				table.insert(f38_local0, {
					models = {
						tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E6098A7D9AA644"),
						action = CoD.AARUtility.SwitchAARTabs,
						param = CoD.AARUtility.AARTabs.AAR_ARENA_LEAGUE_PLAY_LADDER,
					},
					properties = {
						tabId = "ladder",
					},
				})
			end
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/summary"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_SUMMARY,
				},
				properties = {
					tabId = "performance",
				},
			})
			if CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties") and IsPublicOnlineGame() then
				table.insert(f38_local0, {
					models = {
						tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6616EBD2B8F67E64"),
						action = CoD.AARUtility.SwitchAARTabs,
						param = CoD.AARUtility.AARTabs.AAR_CONTRACTS,
					},
					properties = {
						tabId = "contracts",
					},
				})
			end
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_8F69F5BDD4F7C26"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_MEDALS,
				},
				properties = {
					tabId = "medals",
				},
			})
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/stats"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_SCOREBOARD,
				},
				properties = {
					tabId = "scoreboard",
				},
			})
		else
			if Engine[@"sessionmode_ispubliconlinegame"]() and CoD.AARUtility.PlayerEarnedRewards(f38_arg0) then
				table.insert(f38_local0, {
					models = {
						tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/rewards"),
						action = CoD.AARUtility.SwitchAARTabs,
						param = CoD.AARUtility.AARTabs.AAR_REWARDS,
					},
					properties = {
						tabId = "rewards",
					},
				})
			end
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/summary"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_SUMMARY,
				},
				properties = {
					tabId = "performance",
				},
			})
			if CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties") and IsPublicOnlineGame() then
				table.insert(f38_local0, {
					models = {
						tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6616EBD2B8F67E64"),
						action = CoD.AARUtility.SwitchAARTabs,
						param = CoD.AARUtility.AARTabs.AAR_CONTRACTS,
					},
					properties = {
						tabId = "contracts",
					},
				})
			end
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_8F69F5BDD4F7C26"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_MEDALS,
				},
				properties = {
					tabId = "medals",
				},
			})
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/stats"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_SCOREBOARD,
				},
				properties = {
					tabId = "scoreboard",
				},
			})
		end
	elseif Engine[@"iszombiesgame"]() then
		if CoD.isOnlineGame() and CoD.AARUtility.PlayerEarnedRewards(f38_arg0) then
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/rewards"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_REWARDS,
				},
				properties = {
					tabId = "rewards",
				},
			})
		end
		if CoD.AARUtility.GetCurrentGametype(f38_arg0) == "ztrials" then
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"zmtrials/trial")),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_TRIAL,
				},
				properties = {
					tabId = "trial",
				},
			})
		end
		table.insert(f38_local0, {
			models = {
				tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/summary"),
				action = CoD.AARUtility.SwitchAARTabs,
				param = CoD.AARUtility.AARTabs.AAR_SUMMARY,
			},
			properties = {
				tabId = "performance",
			},
		})
		if CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties") and IsPublicOnlineGame() then
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6616EBD2B8F67E64"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_CONTRACTS,
				},
				properties = {
					tabId = "contracts",
				},
			})
		end
		table.insert(f38_local0, {
			models = {
				tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/stats"),
				action = CoD.AARUtility.SwitchAARTabs,
				param = CoD.AARUtility.AARTabs.ZM_AAR_SCOREBOARD,
			},
			properties = {
				tabId = "zmScoreboard",
			},
		})
	elseif Engine[@"hash_356B4618D857143D"]() then
		local f38_local1 = CoD.AARUtility.GetCurrentGametype(f38_arg0)
		CoD.AARUtility.SetupMeritRewardModels(f38_arg1.menu, f38_arg0, false)
		local f38_local2 = CoD.AARUtility.GetAARMeritReportRootModel(f38_arg0)
		if f38_local2.numInGameEntries:get() > 0 then
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_29C7C549DBCFDA00"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_MERIT,
				},
				properties = {
					tabId = "merit",
				},
			})
		end
		table.insert(f38_local0, {
			models = {
				tabName = Engine[@"hash_4F9F1239CFD921FE"](@"aar/summary"),
				action = CoD.AARUtility.SwitchAARTabs,
				param = CoD.AARUtility.AARTabs.AAR_SUMMARY,
			},
			properties = {
				tabId = "performance",
			},
		})
		if CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties") and IsPublicOnlineGame() then
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6616EBD2B8F67E64"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_CONTRACTS,
				},
				properties = {
					tabId = "contracts",
				},
			})
		end
		if f38_local1 ~= "warzone_solo" then
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4E6506EA8A4A9311"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_SQUAD,
				},
				properties = {
					tabId = "squad",
				},
			})
		end
		if CoD.BaseUtility.IsDvarEnabled("ui_wzMedalsEnabled") then
			table.insert(f38_local0, {
				models = {
					tabName = Engine[@"hash_4F9F1239CFD921FE"](@"hash_8F69F5BDD4F7C26"),
					action = CoD.AARUtility.SwitchAARTabs,
					param = CoD.AARUtility.AARTabs.AAR_MEDALS,
				},
				properties = {
					tabId = "medals",
				},
			})
		end
	end
	return f38_local0
end, true)
DataSources.AARStatTypeTabHeader = ListHelper_SetupDataSource("AARStatTypeTabHeader", function(f39_arg0)
	local f39_local0 = {}
	if IsWarzone() then
		table.insert(f39_local0, {
			models = {
				title = @"aar/kills",
				type = CoD.AARUtility.AARStatType.KILLS,
			},
		})
		table.insert(f39_local0, {
			models = {
				title = @"aar/damage",
				type = CoD.AARUtility.AARStatType.DAMAGE,
			},
		})
	else
		if CoD.AARUtility.IsGameTypeEqualToString("bounty", f39_arg0) then
			table.insert(f39_local0, {
				models = {
					title = @"hash_5AC781E043EB6AC4",
					type = CoD.AARUtility.AARStatType.SCORE_PER_MINUTE,
				},
			})
			table.insert(f39_local0, {
				models = {
					title = @"aar/cash",
					type = CoD.AARUtility.AARStatType.SCORE_PER_MINUTE,
				},
			})
		else
			table.insert(f39_local0, {
				models = {
					title = @"hash_312D135A50F00BC3",
					type = CoD.AARUtility.AARStatType.SCORE_PER_MINUTE,
				},
			})
			table.insert(f39_local0, {
				models = {
					title = @"aar/score",
					type = CoD.AARUtility.AARStatType.SCORE,
				},
			})
		end
		if CoD.AARUtility.IsGametypeObjectiveType(f39_arg0) then
			table.insert(f39_local0, {
				models = {
					title = @"aar/objective",
					type = CoD.AARUtility.AARStatType.OBJECTIVE,
				},
			})
		elseif CoD.AARUtility.IsGameTypeEqualToString("ctf", f39_arg0) then
			table.insert(f39_local0, {
				models = {
					title = @"aar/objective",
					type = CoD.AARUtility.AARStatType.CAPTURES_AND_RETURNS,
				},
			})
		end
		table.insert(f39_local0, {
			models = {
				title = @"aar/damage",
				type = CoD.AARUtility.AARStatType.DAMAGE,
			},
		})
		table.insert(f39_local0, {
			models = {
				title = @"hash_6FC92B031C85115A",
				type = CoD.AARUtility.AARStatType.EKIA_RATIO,
			},
		})
		table.insert(f39_local0, {
			models = {
				title = @"aar/ekia",
				type = CoD.AARUtility.AARStatType.EKIA,
			},
		})
		table.insert(f39_local0, {
			models = {
				title = @"hash_39F34F3A8BD173F7",
				type = CoD.AARUtility.AARStatType.WL_RATIO,
			},
		})
	end
	return f39_local0
end, true)
DataSources.AARGameHistory = ListHelper_SetupDataSource("AARGameHistory", function(f40_arg0, f40_arg1)
	local f40_local0 = {}
	local f40_local1 = Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](CoD.AARUtility.GetCurrentGametype(f40_arg0)))
	local f40_local2 = 9
	local f40_local3 = CoD.AARUtility.GetAARRootModel(f40_arg0)
	local f40_local4 = f40_local3.activeStat:get()
	local f40_local5 = CoD.AARUtility.GetCurrentStats(f40_arg0)
	local f40_local6 = f40_local5.PlayerStatsByGametype[f40_local1]
	local f40_local7 = f40_local6.prevScores
	local f40_local8 = f40_local6.prevScoreIndex:get()
	if f40_local8 < 0 or f40_local2 < f40_local8 then
		f40_local8 = 0
	end
	local f40_local9 = 0
	local f40_local10 = 0
	local f40_local11, f40_local12 = nil
	local f40_local13 = 10
	local f40_local14, f40_local15 = nil
	local f40_local16 = 0
	local f40_local17 = 0
	local f40_local18 = 0
	if CoD.AARUtility.UseTestData() or CoD.isZombie then
		for f40_local19 = 1, f40_local13, 1 do
			f40_local12 = 100
			f40_local11 = 50
			f40_local9 = 500
			f40_local10 = f40_local13
			table.insert(f40_local0, 1, {
				models = {
					statValue = "50",
					belowAvg = false,
					valid = true,
					isLastMatch = f40_local19 == 1,
					barFraction = 0,
				},
			})
		end
	else
		for f40_local19 = 1, f40_local13, 1 do
			local f40_local22 = f40_local7[f40_local8]
			local f40_local23 = false
			local f40_local24 = f40_local22.valid:get()
			local f40_local25 = f40_local22.kills:get()
			if f40_local4 == CoD.AARUtility.AARStatType.SCORE_PER_MINUTE then
				f40_local14 = math.ceil(f40_local22.score:get() / math.max(1, f40_local22.timePlayed:get() / 60))
			elseif f40_local4 == CoD.AARUtility.AARStatType.SCORE then
				f40_local14 = f40_local22.score:get()
			elseif f40_local4 == CoD.AARUtility.AARStatType.DAMAGE then
				f40_local14 = f40_local22.damage:get()
			elseif f40_local4 == CoD.AARUtility.AARStatType.OBJECTIVE then
				local f40_local26 = f40_local22.objectiveTime:get()
				local f40_local27 = f40_local22.objectiveScore:get()
				local f40_local28 = f40_local22.objectiveDefends:get()
				f40_local14 = f40_local27 + f40_local22.objectiveEkia:get()
			elseif f40_local4 == CoD.AARUtility.AARStatType.CAPTURES_AND_RETURNS then
				f40_local14 = f40_local22.objectiveScore:get()
			elseif f40_local4 == CoD.AARUtility.AARStatType.EKIA_RATIO then
				f40_local14 = f40_local22.ekia:get() / math.max(1, f40_local22.deaths:get())
				f40_local23 = true
			elseif f40_local4 == CoD.AARUtility.AARStatType.EKIA then
				f40_local14 = f40_local22.ekia:get()
			elseif f40_local4 == CoD.AARUtility.AARStatType.WL_RATIO then
				f40_local14 = 0
				f40_local15 = f40_local22.outcome:get()
				if f40_local24 == 1 then
					if f40_local15 == @"win" then
						f40_local16 = f40_local16 + 1
					end
					if f40_local15 == @"loss" then
						f40_local17 = f40_local17 + 1
					end
					f40_local18 = f40_local18 + 1
				end
			elseif f40_local4 == CoD.AARUtility.AARStatType.KILLS then
				f40_local14 = f40_local25
			else
				f40_local14 = 0
			end
			if not f40_local11 then
				f40_local11 = f40_local14
			end
			if not f40_local12 then
				f40_local12 = f40_local14
			end
			if f40_local24 == 1 then
				f40_local11 = math.min(f40_local11, f40_local14)
				f40_local12 = math.max(f40_local12, f40_local14)
				f40_local9 = f40_local9 + f40_local14
				f40_local10 = f40_local10 + 1
			end
			local f40_local26 = nil
			if f40_local23 then
				f40_local26 = string.format("%.2f", f40_local14)
			else
				f40_local26 = tostring(f40_local14)
			end
			table.insert(f40_local0, 1, {
				models = {
					statValue = f40_local26,
					outcome = f40_local15,
					belowAvg = false,
					valid = f40_local24,
					isLastMatch = f40_local19 == 1,
					barFraction = 0,
				},
			})
			f40_local8 = f40_local8 - 1
			if f40_local8 < 0 then
				f40_local8 = f40_local2
			end
		end
	end
	local f40_local19 = f40_local12 - f40_local11
	local f40_local20 = f40_local9 / math.max(1, f40_local10)
	local f40_local21 = f40_local16 / f40_local18 * 100
	local f40_local29 = CoD.AARUtility.GetAARSummaryStatsRootModel(f40_arg0)
	local f40_local22 = f40_local29:create("statRange")
	f40_local22:set(f40_local19)
	f40_local22 = f40_local29:create("averageStat")
	f40_local22:set(string.format("%.2f", f40_local20))
	f40_local22 = f40_local29:create("wins")
	f40_local22:set(f40_local16)
	f40_local22 = f40_local29:create("losses")
	f40_local22:set(f40_local17)
	f40_local22 = f40_local29:create("winRatio")
	f40_local22:set(string.format("%i", f40_local21))
	return f40_local0
end, true)
DataSources.AARGameHistory.getWidgetTypeForItem = function(f41_arg0, f41_arg1, f41_arg2)
	local f41_local0 = CoD.AARUtility.GetAARRootModel(f41_arg0.controller)
	if f41_local0.activeStat:get() == CoD.AARUtility.AARStatType.WL_RATIO then
		return CoD.AARWinLoseHistory
	else
		return CoD.AARNumericalStatHistory
	end
end
DataSources.AARRoot = {
	getModel = function(f42_arg0)
		return CoD.AARUtility.GetAARRootModel(f42_arg0)
	end,
}
DataSources.AARLevelUp = {
	getModel = function(f43_arg0)
		return CoD.AARUtility.GetAARLevelUpRootModel(f43_arg0)
	end,
}
DataSources.AARSummaryStats = {
	getModel = function(f44_arg0)
		return CoD.AARUtility.GetAARSummaryStatsRootModel(f44_arg0)
	end,
}
DataSources.AARScoreboard = {
	getModel = function(f45_arg0)
		return CoD.AARUtility.GetAARScoreboardRootModel(f45_arg0)
	end,
}
DataSources.AARMeritReport = {
	getModel = function(f46_arg0)
		return CoD.AARUtility.GetAARMeritReportRootModel(f46_arg0)
	end,
}
DataSources.AARMissionReward = {
	getModel = function(f47_arg0)
		return CoD.AARUtility.GetAARMissionRewardRootModel(f47_arg0)
	end,
}
DataSources.AARTierReward = {
	getModel = function(f48_arg0)
		return CoD.AARUtility.GetAARTierRewardRootModel(f48_arg0)
	end,
}
DataSources.AARLadderStats = {
	getModel = function(f49_arg0)
		return CoD.AARUtility.GetAARLadderRootModel(f49_arg0)
	end,
}
DataSources.AARKillStats = {
	prepare = function(f50_arg0, f50_arg1)
		local f50_local0 = f50_arg1:getParent()
		if f50_local0 then
			local f50_local1 = f50_local0.TabbedScoreboardScores
			if f50_local1 then
				f50_local1 = f50_local0.TabbedScoreboardScores.EnemyTeamScores
			end
			f50_arg1.enemyList = f50_local1
		end
	end,
	getCount = function(f51_arg0)
		local f51_local0 = 0
		local f51_local1 = f51_arg0.enemyList
		if f51_local1 then
			f51_local0 = #f51_local1.clients
		end
		return f51_local0
	end,
	getItem = function(f52_arg0, f52_arg1, f52_arg2)
		local f52_local0 = nil
		local f52_local1 = f52_arg1.enemyList
		if f52_local1 then
			local f52_local2 = f52_local1.clients[f52_arg2]
			local f52_local3 = Engine[@"getmodelforclient"](CoD.AARUtility.GetInGameClientNum(f52_arg0))
			local f52_local4 = f52_local3.scoreboard.killStats
			if f52_local4 then
				for f52_local5 = 0, 5, 1 do
					local f52_local8 = f52_local4[f52_local5]
					if f52_local8.clientNum:get() == f52_local2 then
						f52_local0 = f52_local8
						break
					end
				end
			end
		end
		return f52_local0
	end,
}
DataSources.AARRewardPages = ListHelper_SetupDataSource("AARRewardPages", function(f53_arg0)
	local f53_local0 = {}
	local f53_local1 = 4
	local f53_local2 = CoD.AARUtility.GetPlayerRewards(f53_arg0)
	local f53_local3 = CoD.AARUtility.GetWeaponRewards(f53_arg0)
	local f53_local4 = CoD.AARUtility.GetChallengeRewards(f53_arg0)
	local f53_local5 = CoD.AARUtility.GetContractRewards(f53_arg0)
	local f53_local6 = #f53_local2 + #f53_local3 + #f53_local4 + #f53_local5
	if IsWarzone() then
		f53_local6 = #f53_local4 + #CoD.AARUtility.GetUnlockedWZTagRewards(f53_arg0) + #f53_local5
	end
	local f53_local7 = CoD.AARUtility.GetAARRewardsRootModel(f53_arg0)
	local f53_local8 = math.ceil(f53_local6 / f53_local1)
	if f53_local8 > 1 then
		for f53_local9 = 1, f53_local8, 1 do
			table.insert(f53_local0, {
				models = {
					title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3CFFDEFC0F2E1786", f53_local9),
				},
				properties = {
					page = f53_local9,
				},
			})
		end
		local f53_local9 = f53_local7:create("multiPage")
		f53_local9:set(true)
	else
		local f53_local9 = f53_local7:create("multiPage")
		f53_local9:set(false)
	end
	CoD.AARUtility.InitRewardsPaging(f53_arg0)
	return f53_local0
end, true)
DataSources.AARRewards = ListHelper_SetupDataSource("AARRewards", function(f54_arg0, f54_arg1)
	local f54_local0 = {}
	if not IsWarzone() then
		for f54_local4, f54_local5 in ipairs(CoD.AARUtility.GetPlayerRewards(f54_arg0)) do
			table.insert(f54_local0, f54_local5)
		end
		for f54_local5, f54_local6 in ipairs(CoD.AARUtility.GetWeaponRewards(f54_arg0)) do
			table.insert(f54_local0, f54_local6)
		end
	else
		for f54_local4, f54_local5 in ipairs(CoD.AARUtility.GetUnlockedWZTagRewards(f54_arg0)) do
			table.insert(f54_local0, f54_local5)
		end
	end
	for f54_local4, f54_local5 in ipairs(CoD.AARUtility.GetChallengeRewards(f54_arg0)) do
		table.insert(f54_local0, f54_local5)
	end
	for f54_local5, f54_local6 in ipairs(CoD.AARUtility.GetContractRewards(f54_arg0)) do
		table.insert(f54_local0, f54_local6)
	end
	if f54_arg1.hCount and f54_arg1.hCount > 0 and f54_arg1.hCount < #f54_local0 and #f54_local0 % f54_arg1.hCount > 0 then
		for f54_local2 = 1, f54_arg1.hCount - #f54_local0 % f54_arg1.hCount, 1 do
			f54_local5 = f54_local2
			table.insert(f54_local0, {
				models = {
					empty = true,
				},
			})
		end
	end
	return f54_local0
end, true)
DataSources.AARRewards.getWidgetTypeForItem = function(f55_arg0, f55_arg1, f55_arg2)
	if f55_arg1 then
		local f55_local0 = f55_arg1.empty
		local f55_local1 = f55_arg1.empty:get()
	end
	if f55_local0 and f55_local1 or false then
		return CoD.AAREmptyReward
	elseif f55_arg1 then
		local f55_local2 = f55_arg1.rewardType
		local f55_local3 = f55_arg1.rewardType:get()
	end
	local f55_local4 = f55_local2 and f55_local3 or nil
	if IsZombies() then
		if f55_local4 == CoD.AARUtility.AARRewardType.PLAYER then
			return CoD.AARPlayerReward_ZM
		elseif f55_local4 == CoD.AARUtility.AARRewardType.WEAPON then
			return CoD.AARWeaponReward_ZM
		elseif f55_local4 == CoD.AARUtility.AARRewardType.CHALLENGE then
			return CoD.AARChallengeReward_ZM
		elseif f55_local4 == CoD.AARUtility.AARRewardType.CURRENCY then
			return CoD.AARCurrencyReward_ZM
		elseif f55_local4 == CoD.AARUtility.AARRewardType.SPECIAL_EVENT then
			return CoD.AARSpecialEventReward_ZM
		elseif f55_local4 == CoD.AARUtility.AARRewardType.DAILY_CALLING then
			return CoD.AARDailyCallingReward_ZM
		elseif f55_local4 == CoD.AARUtility.AARRewardType.FACTION_CALLING then
			return CoD.AARFactionCallingReward_ZM
		elseif f55_local4 == CoD.AARUtility.AARRewardType.CONTRACT then
			return CoD.AARContractReward_ZM
		end
		return CoD.AARClassReward_ZM
	elseif f55_local4 == CoD.AARUtility.AARRewardType.PLAYER then
		return CoD.AARPlayerReward
	elseif f55_local4 == CoD.AARUtility.AARRewardType.WEAPON then
		return CoD.AARWeaponReward
	elseif f55_local4 == CoD.AARUtility.AARRewardType.CHALLENGE then
		return CoD.AARChallengeReward
	elseif f55_local4 == CoD.AARUtility.AARRewardType.SPECIAL_EVENT then
		return CoD.AARSpecialEventReward
	elseif f55_local4 == CoD.AARUtility.AARRewardType.CONTRACT then
		return CoD.AARContractReward
	end
	return CoD.AARClassReward
end
DataSources.AARMedalsList = ListHelper_SetupDataSource("AARMedalsList", function(f56_arg0)
	local f56_local0 = {}
	local f56_local1 = Engine[@"getxpscale"](f56_arg0)
	local f56_local2 = {}
	local f56_local3, f56_local4 = CoD.AARUtility.GetStats(f56_arg0)
	if f56_local3 and f56_local4 then
		f56_local2 = Engine[@"getrecentmedals"](f56_arg0, CoD.AARUtility.MedalXPCol)
	end
	CoD.scoreInfoTable = CoD.GameTypeUtility.GetGameTypeValue(CoD.AARUtility.GetCurrentGametype(f56_arg0), "scoreInfoFile", CoD.scoreInfoTable)
	if f56_local2 then
		table.sort(f56_local2, CoD.AARUtility.SortMedals)
		local f56_local5 = nil
		for f56_local11, f56_local12 in ipairs(f56_local2) do
			local f56_local13 = f56_local12.value
			local f56_local14 = f56_local12.row
			local f56_local15 = CoD.NotificationUtility.GetMedalData(f56_local14)
			if f56_local15.foundMedal then
				local f56_local9 = f56_local1 * (tonumber(Engine[@"hash_25DC2BA4A99CE43E"](CoD.scoreInfoTable, f56_local14, CoD.AARUtility.MedalXPCol)) or 0) * f56_local13
				local f56_local10 = nil
				if not IsWarzone() then
					f56_local10 = Engine[@"hash_4F9F1239CFD921FE"](@"rank/xp", f56_local9)
				else
					f56_local10 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1BCE3D9B07DE63B7", f56_local9)
				end
				if f56_local5 and f56_local15.name == @"medal/shutdown" then
					f56_local5.timesEarned = f56_local5.timesEarned + f56_local13
				end
				table.insert(f56_local0, {
					models = {
						name = f56_local15.name,
						description = f56_local15.description,
						iconSmall = f56_local15.iconSmall,
						iconLarge = f56_local15.iconLarge,
						timesEarned = f56_local13,
						xpValue = f56_local10,
					},
				})
				if f56_local15.name == @"medal/shutdown" then
					f56_local5 = f56_local0[#f56_local0].models
				end
			end
		end
	end
	return f56_local0
end, true)
CoD.AARUtility.CreateClassRewardPreviewDataSource = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
	DataSources[f57_arg0] = DataSourceHelpers.ListSetup(f57_arg0, function(f58_arg0, f58_arg1)
		local f58_local0 = {}
		if f57_arg1 then
			local f58_local1 = Engine[@"currentsessionmode"]()
			for f58_local5, f58_local6 in pairs(f57_arg1) do
				local f58_local7 = f58_local6[f57_arg2]
				if f58_local7 then
					table.insert(f58_local0, {
						models = {
							image = Engine[@"getitemimage"](Engine[@"hash_2D97229B24C685D5"](f58_local7, f58_local1), f57_arg3, f58_local1),
						},
					})
				end
			end
		end
		return f58_local0
	end, true)
	return f57_arg0
end
CoD.AARUtility.GetCurrencyEarned = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
	if not CoD.isOnlineGame() then
		return 0
	end
	local f59_local0 = -1
	for f59_local4, f59_local5 in pairs(Engine[@"getplayerbalanceitems"](f59_arg0)) do
		if f59_local5.name == f59_arg2 then
			f59_local0 = f59_local5.value
		end
	end
	if f59_arg3 and f59_arg3 > 0 then
		f59_local0 = f59_local0 - f59_arg3
	end
	if f59_local0 < 0 then
		f59_local0 = 0
	end
	f59_local1 = f59_local0
	f59_local2 = Engine[@"getmodelforcontroller"](f59_arg0)
	f59_local3 = f59_local2.AARPreMatch
	if f59_local3 and f59_local3[f59_arg1] then
		f59_local1 = f59_local3[f59_arg1]:get()
	end
	f59_local4 = f59_local0 - f59_local1
	if f59_local4 < 0 then
		f59_local4 = 0
	end
	return f59_local4
end
CoD.AARUtility.GetPlayerRewards = function(f60_arg0)
	local f60_local0 = {}
	if not IsPublicOnlineGame() and (not IsZombies() or not CoD.isOnlineGame()) then
		return f60_local0
	end
	local f60_local1, f60_local2 = CoD.AARUtility.GetStats(f60_arg0)
	local f60_local3 = {}
	if IsPublicOnlineGame() then
		f60_local3 = Engine[@"getrecentlyunlockeditems"](f60_arg0)
	end
	local f60_local4 = Engine[@"currentsessionmode"]()
	local f60_local5 = {}
	local f60_local6 = {}
	local f60_local7 = {}
	local f60_local8 = function(f61_arg0, f61_arg1)
		local f61_local0 = {}
		if IsZombies() then
			local f61_local1 = 0
			for f61_local5, f61_local6 in ipairs(f61_arg1) do
				if f61_local6.models.npEarned then
					f61_local1 = f61_local1 + f61_local6.models.npEarned
				end
			end
			f61_local2 = CoD.AARUtility.GetCurrencyEarned(f61_arg0, "initialPlasma", @"nebulium_plasma", f61_local1)
			if CoD.BaseUtility.IsDvarEnabled("ui_forceAAR") and f61_local2 <= 0 then
				f61_local2 = 1
			end
			if f61_local2 > 0 then
				f61_local3 = @"ui_icon_nebulium_medium"
				f61_local4 = f61_local3
				if CoD.ZombieUtility.IsDoubleNP(f61_arg0) then
					f61_local4 = @"ui_icon_nebulium_2x"
				end
				f61_local0.mainTitle = @"hash_480234A872BD64AC"
				f61_local0.levelText = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"hash_633CCE15E5387569"))
				f61_local0.mainIcon = f61_local4
				f61_local0.rewardType = CoD.AARUtility.AARRewardType.CURRENCY
				f61_local0.reward1Icon = f61_local3
				f61_local0.reward1Desc = Engine[@"hash_4F9F1239CFD921FE"](@"menu/multiplier_x", f61_local2)
				table.insert(f61_arg1, 1, {
					models = f61_local0,
				})
			end
		end
	end
	local f60_local9 = function(f62_arg0, f62_arg1)
		if IsZombies() and f60_local1 and f60_local2 then
			if IsBooleanDvarSet(@"hash_11DA02CA40639DE5") then
				for f62_local3, f62_local4 in ipairs(CoD.ZombiesCallingsUtility.GetFactionCallingRewardModels(f62_arg0, f60_local1, f60_local2)) do
					table.insert(f62_arg1, {
						models = f62_local4,
					})
				end
			end
			for f62_local3, f62_local4 in ipairs(CoD.SpecialEventUtility.GetSpecialEventRewardModels(f62_arg0, f60_local1, f60_local2)) do
				table.insert(f62_arg1, {
					models = f62_local4,
				})
			end
			for f62_local4, f62_local5 in ipairs(CoD.ZombiesCallingsUtility.GetDailyCallingRewardModels(f62_arg0, f60_local1, f60_local2)) do
				table.insert(f62_arg1, {
					models = f62_local5,
				})
			end
		end
	end
	local f60_local10 = function(f63_arg0, f63_arg1)
		if IsZombies() and f60_local1 and f60_local2 then
			for f63_local7, f63_local8 in pairs(CoD.BlackMarketTableUtility[@"hash_548F022EAF4F53A3"]) do
				local f63_local3 = f60_local1
				if f63_local3 then
					f63_local3 = LUI.getTableFromFieldList(f63_local8.path, f63_local3)
				end
				local f63_local4
				if not f63_local3 or f63_local3:get() == 0 then
					f63_local4 = false
				else
					f63_local4 = true
				end
				local f63_local5 = f60_local2
				if f63_local5 then
					f63_local5 = LUI.getTableFromFieldList(f63_local8.path, f63_local5)
				end
				local f63_local6
				if not f63_local5 or f63_local5:get() == 0 then
					f63_local6 = false
				else
					f63_local6 = true
				end
				if f63_local6 and not f63_local4 then
					table.insert(f63_arg1, {
						models = {
							mainTitle = @"hash_7318F49227D658CF",
							levelText = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A1AD934441EF46B", f63_local8.lockedStringRef)),
							mainIcon = @"ui_icon_gamemode_zm_gauntlet_large",
							rewardType = CoD.AARUtility.AARRewardType.CHALLENGE,
							challengeImage = f63_local7,
							challengeName = f63_local8.lockedStringRef,
							challengeDesc = Engine[@"hash_4F9F1239CFD921FE"](f63_local8.unlockedStringRef),
						},
					})
				end
			end
		end
	end
	f60_local9(f60_arg0, f60_local7)
	f60_local10(f60_arg0, f60_local7)
	f60_local8(f60_arg0, f60_local7)
	local f60_local11 = function(f64_arg0, f64_arg1)
		if f64_arg0 then
			local f64_local0 = nil
			if not f64_arg1 then
				return Engine[@"getitemimage"](Engine[@"hash_2D97229B24C685D5"](f64_arg0, f60_local4))
			else
				return Engine[@"getitemimage"](Engine[@"hash_2D97229B24C685D5"](f64_arg0, f60_local4), Enum[@"statindexoffset"][@"hash_68EA6ADA81FD4511"], f60_local4)
			end
		else
			return "blacktransparent"
		end
	end
	local f60_local12 = function(f65_arg0, f65_arg1, f65_arg2)
		f65_arg0.title = f65_arg1[@"customclassname"]
		f65_arg0.primaryImage = f60_local11(f65_arg1[@"primary"])
		f65_arg0.secondaryImage = f60_local11(f65_arg1[@"secondary"])
		f65_arg0.grenadeImage = f60_local11(f65_arg1[@"primarygrenade"])
		f65_arg0.tacticalGearImage = f60_local11(f65_arg1[@"tacticalgear"], true)
		f65_arg0.perksDataSource = CoD.AARUtility.CreateClassRewardPreviewDataSource("AARClassRewardPerks_" .. f65_arg2, f65_arg1.talents, @"talent", Enum[@"statindexoffset"][@"hash_68EA6ADA81FD4511"])
		f65_arg0.wildcardsDataSource = CoD.AARUtility.CreateClassRewardPreviewDataSource("AARClassRewardWildcards_" .. f65_arg2, f65_arg1.bonuscards, @"bonuscard", Enum[@"statindexoffset"][@"hash_1A949B83CC070B0"])
	end
	local f60_local13 = function(f66_arg0, f66_arg1)
		local f66_local0 = CoD.CACUtility.GetUnlockableItemInfo(f66_arg1, f60_local4)
		if not f66_local0 then
			return
		end
		local f66_local1 = f66_local0.itemGroup == "feature"
		local f66_local2 = f60_local5
		if f66_local1 then
			f66_local2 = f60_local6
		end
		if not f66_local2[f66_arg0] then
			f66_local2[f66_arg0] = {}
		end
		local f66_local3 = {
			itemGroup = f66_local0.itemGroup,
			title = Engine[@"getitemname"](f66_arg1),
			desc = CoD.CACUtility.GetItemGroupDisplayNameFromRef(f66_local0.itemGroup),
			icon = Engine[@"getitemimage"](f66_arg1),
			featureType = f66_local0[@"featuretype"],
		}
		if f66_local1 then
			local f66_local4 = Engine[@"hash_2E00B2F29271C60B"](@"mp_default_loadouts")
			local f66_local5 = f66_local0[@"loadoutindex"]
			if f66_local0[@"featuretype"] == CoD.AARUtility.AARFeatureRewardType.CAC then
				f66_local3.desc = 0x0
			elseif f66_local0[@"featuretype"] == CoD.AARUtility.AARFeatureRewardType.DEFAULT_CLASS then
				f60_local12(f66_local3, f66_local4.defaultloadouts[f66_local5], f66_arg1)
				f66_local3.desc = @"hash_2F75210679B788D6"
			elseif f66_local0[@"featuretype"] == CoD.AARUtility.AARFeatureRewardType.CUSTOM_CLASS then
				f60_local12(f66_local3, f66_local4.defaultcustomloadouts[f66_local5], f66_arg1)
				f66_local3.desc = @"hash_59AF52F9F90F6244"
			end
		end
		table.insert(f66_local2[f66_arg0], f66_local3)
	end
	for f60_local17, f60_local18 in pairs(f60_local3) do
		f60_local13(Engine[@"getitemunlocklevel"](f60_local18.itemIndex), f60_local18.itemIndex)
	end
	for f60_local17, f60_local18 in pairs(f60_local6) do
		local f60_local23 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f60_arg0, f60_local17, Engine[@"getrankinfo"](f60_local17), f60_local4)
		for f60_local19, f60_local20 in ipairs(f60_local18) do
			local f60_local22 = {
				mainTitle = f60_local23.fullNameRef,
				level = f60_local23.level,
				levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BC1D826D76D607F", f60_local23.level),
				mainIcon = f60_local23.iconLarge,
				multiItem = false,
				rewardType = CoD.AARUtility.AARRewardType.CLASS,
				reward1Title = f60_local20.title,
				reward1Desc = f60_local20.desc,
				featureType = f60_local20.featureType,
			}
			if f60_local20.featureType == CoD.AARUtility.AARFeatureRewardType.CAC then
				f60_local22.reward1Icon = f60_local20.icon
			else
				f60_local22.reward1Icon = f60_local20.icon
				f60_local22.primaryImage = f60_local20.primaryImage
				f60_local22.secondaryImage = f60_local20.secondaryImage
				f60_local22.grenadeImage = f60_local20.grenadeImage
				f60_local22.tacticalGearImage = f60_local20.tacticalGearImage
				f60_local22.perksDataSource = f60_local20.perksDataSource
				f60_local22.wildcardsDataSource = f60_local20.wildcardsDataSource
			end
			table.insert(f60_local0, {
				models = f60_local22,
				rank = f60_local17,
			})
		end
	end
	for f60_local17, f60_local18 in pairs(f60_local5) do
		if not f60_local6[f60_local17] then
			local f60_local23 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f60_arg0, f60_local17, Engine[@"getrankinfo"](f60_local17), f60_local4)
			local f60_local24 = f60_local23.level
			local f60_local19 = {
				mainTitle = f60_local23.fullNameRef,
				level = f60_local24,
				levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BC1D826D76D607F", f60_local24),
				mainIcon = f60_local23.iconLarge,
				multiItem = #f60_local18 > 1,
				rewardType = CoD.AARUtility.AARRewardType.PLAYER,
			}
			table.sort(f60_local18, function(f67_arg0, f67_arg1)
				if LUI.startswith(f67_arg0.itemGroup, "weapon_") and not LUI.startswith(f67_arg1.itemGroup, "weapon_") then
					return true
				else
					return false
				end
			end)
			local f60_local22 = f60_local18[1]
			if f60_local22 then
				f60_local19.reward1Title = f60_local22.title
				f60_local19.reward1Desc = f60_local22.desc
				f60_local19.reward1Icon = f60_local22.icon
			end
			local f60_local26 = f60_local18[2]
			if f60_local26 then
				f60_local19.reward2Title = f60_local26.title
				f60_local19.reward2Desc = f60_local26.desc
				f60_local19.reward2Icon = f60_local26.icon
			end
			table.insert(f60_local0, {
				models = f60_local19,
				rank = f60_local17,
			})
		end
	end
	table.sort(f60_local0, function(f68_arg0, f68_arg1)
		return f68_arg0.rank < f68_arg1.rank
	end)
	if #f60_local7 > 0 then
		for f60_local17, f60_local18 in ipairs(f60_local0) do
			table.insert(f60_local7, f60_local18)
		end
		f60_local0 = f60_local7
	end
	return f60_local0
end
CoD.AARUtility.GetWeaponRewards = function(f69_arg0)
	local f69_local0 = {}
	if not IsPublicOnlineGame() then
		return f69_local0
	elseif LuaUtils.IsArenaMode() then
		return f69_local0
	end
	local f69_local1 = function(f70_arg0, f70_arg1)
		if not f70_arg0[f70_arg1] then
			f70_arg0[f70_arg1] = {}
		end
		return f70_arg0[f70_arg1]
	end
	local f69_local2 = {}
	local f69_local3 = Engine[@"currentsessionmode"]()
	for f69_local20, f69_local21 in pairs(Engine[0x325E78EC6C6329](f69_arg0)) do
		for f69_local8, f69_local9 in ipairs(f69_local21) do
			local f69_local11 = Engine[@"getattachmentnamebyindex"](f69_local9)
			local f69_local12 = Engine[@"hash_48B0A6A290155A1C"](f69_local9)
			local f69_local13 = Engine[@"getattachmentdescbyattachmentindex"](f69_local9, f69_local3)
			local f69_local14 = Engine[@"getattachmentuniqueimagebyattachmentindex"](f69_local3, f69_local20, f69_local9)
			local f69_local15 = Engine[0x37522AE910C327](f69_local9, f69_local3)
			local f69_local16 = Engine[@"hash_7B98952F69D937F9"](f69_local20)
			local f69_local17 = Engine[@"getattachmentrefbyindex"](f69_local9)
			local f69_local18 = tonumber(Engine[@"tablelookup"](CoD.gunLevelsTable, CoD.AARUtility.GunRankCol, CoD.AARUtility.GunRefCol, f69_local16, CoD.AARUtility.GunAttachmentRefCol, f69_local17))
			local f69_local19 = tonumber(Engine[@"tablelookup"](CoD.gunLevelsTable, CoD.AARUtility.GunRankXPCol, CoD.AARUtility.GunRefCol, f69_local16, CoD.AARUtility.GunAttachmentRefCol, f69_local17))
			if f69_local18 then
				local f69_local7 = f69_local1(f69_local1(f69_local1(f69_local2, f69_local20), f69_local18), f69_local9)
				f69_local7.attachmentName = f69_local11
				f69_local7.attachmentNameShort = f69_local12
				f69_local7.attachmentDesc = f69_local13
				f69_local7.attachmentGroupName = CoD.WeaponAttachmentsUtility.GetDisplayNameForAttachmentGroup(f69_local15)
				f69_local7.attachmentImage = f69_local14
				f69_local7.xp = f69_local19
			else
				DebugPrint("LUI: level requirement for [" .. Engine[@"hash_4F9F1239CFD921FE"](Engine[@"getitemname"](f69_local20)) .. " - " .. Engine[@"hash_4F9F1239CFD921FE"](f69_local11) .. "] not found.")
			end
		end
	end
	for f69_local20, f69_local21 in pairs(f69_local2) do
		local f69_local22 = Engine[@"getitemname"](f69_local20)
		local f69_local23 = Engine[@"getitemimage"](f69_local20)
		for f69_local11, f69_local12 in pairs(f69_local21) do
			local f69_local13 = {
				mainTitle = f69_local22,
				levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_16CE4C353AA0FCC9", f69_local11 + 2),
				mainIcon = f69_local23,
				multiItem = false,
				rewardType = CoD.AARUtility.AARRewardType.WEAPON,
			}
			local f69_local14 = {}
			for f69_local18, f69_local19 in pairs(f69_local12) do
				table.insert(f69_local14, f69_local18)
			end
			f69_local15 = 0
			f69_local16 = f69_local12[f69_local14[1]]
			if f69_local16 then
				f69_local13.reward1Title = f69_local16.attachmentName
				f69_local13.reward1Desc = f69_local16.attachmentGroupName
				f69_local13.reward1Icon = f69_local16.attachmentImage
				f69_local15 = f69_local15 + f69_local16.xp
			end
			f69_local17 = f69_local12[f69_local14[2]]
			if f69_local17 then
				f69_local13.reward2Title = f69_local17.attachmentName
				f69_local13.reward2Desc = f69_local17.attachmentGroupName
				f69_local13.reward2Icon = f69_local17.attachmentImage
				f69_local15 = f69_local15 + f69_local17.xp
				f69_local13.multiItem = true
			end
			f69_local13.totalXP = Engine[@"hash_4F9F1239CFD921FE"](@"rank/xp", f69_local15)
			table.insert(f69_local0, {
				models = f69_local13,
				level = f69_local11,
			})
		end
	end
	table.sort(f69_local0, function(f71_arg0, f71_arg1)
		return f71_arg0.level < f71_arg1.level
	end)
	return f69_local0
end
CoD.AARUtility.GetChallengeRewards = function(f72_arg0)
	local f72_local0 = {}
	if not IsPublicOnlineGame() then
		return f72_local0
	end
	local f72_local1 = function(f73_arg0)
		local f73_local0 = {}
		if not f73_arg0 or not f73_arg0.icon or f73_arg0.icon == @"blacktransparent" then
			return
		end
		f73_local0.mainTitle = f73_arg0.categoryName
		f73_local0.levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3547C51E854B9C9")
		f73_local0.mainIcon = f73_arg0.icon
		f73_local0.rewardType = CoD.AARUtility.AARRewardType.CHALLENGE
		f73_local0.challengeName = f73_arg0.titleText
		f73_local0.challengeDesc = f73_arg0.subtitleText
		f73_local0.tierProgress = f73_arg0.currentTier + 1
		f73_local0.tierMax = f73_arg0.maxTier + 1
		f73_local0.tierProgressText = Engine[@"hash_4F9F1239CFD921FE"](0x38A59531FCD1E, f73_local0.tierProgress, f73_local0.tierMax)
		f73_local0.isTiered = f73_local0.tierMax > 1
		f73_local0.challengeRewardLocked = false
		f73_local0.rotateChallengeRewardIcon = false
		if f73_arg0.camoInfo then
			f73_local0.challengeName = f73_arg0.camoInfo.aarDisplayString
			f73_local0.challengeImage = f73_arg0.camoInfo.image
			f73_local0.mainTitle = f73_arg0.camoInfo.weaponName
			f73_local0.isTiered = false
			f73_local0.rotateChallengeRewardIcon = f73_arg0.camoInfo.useRotatedIcon
			if f73_arg0.camoInfo.category == "activecamounveil" then
				f73_local0.levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4B19AFEA158DD0DF")
			else
				f73_local0.levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1E2BF0935706BEDD")
				if f73_arg0.camoInfo.aarDescription ~= "" then
					f73_local0.challengeDesc = f73_arg0.camoInfo.aarDescription
				end
			end
			if IsZombies() and not IsBooleanDvarSet(@"hash_730FAB929626F598") then
				local f73_local1 = f73_arg0.camoInfo.camoRef
				if f73_local1 == "camo_gold" or f73_local1 == "camo_diamond" or f73_local1 == "camo_darkmatter" then
					return
				end
			end
		end
		if f73_arg0.emblemInfo then
			local f73_local1 = f73_arg0.emblemInfo.image
			if not f73_local1 then
				f73_local1 = f73_arg0.emblemInfo.maxTierImage
			end
			if f73_arg0.currentTier < f73_arg0.maxTier then
				f73_local0.challengeRewardLocked = true
			end
			if f73_local1 then
				f73_local0.challengeImage = f73_local1
			end
		end
		if f73_arg0.reticleInfo then
			f73_local0.challengeName = f73_arg0.reticleInfo.displayString
			f73_local0.challengeImage = f73_arg0.reticleInfo.image
			f73_local0.mainTitle = f73_arg0.reticleInfo.attachmentName
			f73_local0.levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5693D62588AD774D")
		end
		if f73_arg0.xpInfo then
			f73_local0.totalXP = f73_arg0.xpInfo.displayString
			if not f73_local0.challengeImage then
				f73_local0.challengeImage = f73_arg0.xpInfo.image
			end
		end
		table.insert(f72_local0, {
			models = f73_local0,
		})
	end
	local f72_local2 = nil
	if CoD.AARUtility.UseTestData() then
		f72_local2 = CoD.AARUtility.ChallengeRewardsTable or {}
	else
		f72_local2 = Engine[@"getrecentchallenges"](f72_arg0)
	end
	for f72_local6, f72_local7 in ipairs(f72_local2) do
		f72_local1(CoD.ChallengesUtility.GetChallengeRewardInfo(f72_arg0, f72_local7.tableNumber, f72_local7.row, f72_local7.type, f72_local7.itemIndex, f72_local7.specialistIndex))
	end
	return f72_local0
end
CoD.AARUtility.ClearChallengeRewards = function()
	CoD.AARUtility.ChallengeRewardsTable = {}
end
CoD.AARUtility.AddTestChallengeReward = function(f75_arg0, f75_arg1, f75_arg2)
	if not CoD.AARUtility.ChallengeRewardsTable then
		CoD.AARUtility.ChallengeRewardsTable = {}
	end
	local f75_local0 = CoD.getStatsMilestoneTable(f75_arg1 + 1, Engine[@"currentsessionmode"]())
	if f75_local0 then
		local f75_local1 = Engine[@"hash_4C6F8EC444864600"](f75_local0, f75_arg2, Enum[@"milestonetablecolumns_t"][@"milestone_column_stattype"])
		local f75_local2 = CoD.ChallengesUtility.ChallengeTypeHashToEnum[f75_local1]
		if not f75_local2 then
			f75_local2 = Enum[@"statsmilestonetypes_t"][@"milestone_weapon"]
		end
		local f75_local3 = 0
		local f75_local4 = 225
		if f75_local2 == Enum[@"statsmilestonetypes_t"][@"milestone_group"] then
			f75_local4 = 4
		elseif f75_local2 == Enum[@"statsmilestonetypes_t"][@"milestone_attachments"] then
			f75_local4 = 1
		end
		if f75_local2 == Enum[@"statsmilestonetypes_t"][@"milestone_weapon"] then
			local f75_local5 = {
				"weapon_smg",
				"weapon_assault",
				"weapon_tactical",
				"weapon_cqb",
				"weapon_lmg",
				"weapon_sniper",
				"weapon_pistol",
				"weapon_launcher",
				"weapon_knife",
				"weapon_special",
				"weapon_shotgun",
				"weapon_explosive",
				"weapon_grenade",
				"weapon_mastery",
				"weapon_grenadelauncher",
				"weapon_flamethrowe",
			}
			local f75_local6 = "weapon_assault"
			for f75_local10, f75_local11 in ipairs(f75_local5) do
				if Engine[@"converttoxhash"](f75_local11) == f75_local1 then
					f75_local6 = f75_local11
					break
				end
			end
			f75_local8 = CoD.CACUtility.GetUnlockableItemsForItemGroup(f75_arg0, Engine[@"currentsessionmode"](), f75_local6)
			if f75_local8 then
				for f75_local12, f75_local13 in ipairs(f75_local8) do
					if f75_local13.allocation >= 1 then
						table.insert(CoD.AARUtility.ChallengeRewardsTable, {
							tableNumber = f75_arg1,
							row = f75_arg2,
							type = f75_local2,
							itemIndex = f75_local13.itemIndex,
							specialistIndex = f75_local3,
						})
					end
				end
			end
		else
			table.insert(CoD.AARUtility.ChallengeRewardsTable, {
				tableNumber = f75_arg1,
				row = f75_arg2,
				type = f75_local2,
				itemIndex = f75_local4,
				specialistIndex = f75_local3,
			})
		end
	end
end
CoD.AARUtility.InitAARDevgui = function(f76_arg0, f76_arg1)
	f76_arg0:subscribeToGlobalModel(f76_arg1, "PerController", "scriptNotify", function(model)
		local f77_local0 = model:get()
		if f77_local0 == @"aar_clear_rewards" then
			DebugPrint("aar_clear_rewards")
			CoD.AARUtility.ClearChallengeRewards()
		elseif f77_local0 == 0x5727F8A59698B1 then
			local f77_local1 = CoD.GetScriptNotifyData(model)
			CoD.AARUtility.AddTestChallengeReward(f76_arg1, f77_local1[1], f77_local1[2])
		end
	end)
end
CoD.AARUtility.GetContractRewards = function(f78_arg0)
	local f78_local0 = {}
	local f78_local1 = CoD.BlackMarketUtility.GetContractsInGameModelRoot(f78_arg0)
	local f78_local2 = function(f79_arg0, f79_arg1)
		local f79_local0 = f78_local1[f79_arg0]
		if f79_local0 and f79_local0.completed and f79_local0.completed:get() and f79_arg1 and f79_arg1.models then
			local f79_local1 = f79_arg1.models
			local f79_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"rank/xp", f79_local1.xpReward)
			if f79_local1.contractMode == CoDShared.LootContracts.ContractGameMode.LOOT_CONTRACT_GAME_MODE_WZ then
				f79_local2 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1BCE3D9B07DE63B7", f79_local1.xpReward)
			end
			table.insert(f78_local0, {
				models = {
					contractName = f79_local1.displayName,
					contractDesc = f79_local1.description,
					contractRewardIcon = f79_local1.rewardIcon,
					contractRewardAmount = f79_local1.rewardDisplay,
					contractXPAmount = f79_local2,
					levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_755B609EA20C4D97"),
					mainTitle = @"hash_0",
					mainIcon = f79_local1.contractIcon,
					rewardType = CoD.AARUtility.AARRewardType.CONTRACT,
				},
			})
			if not CoD.AARUtility.ContractRewardModels[f79_arg0] then
				CoD.AARUtility.ContractRewardModels[f79_arg0] = f79_arg1
			end
		end
	end
	if not CoD.AARUtility.ContractRewardModels then
		CoD.AARUtility.ContractRewardModels = {}
		local f78_local3 = CoD.BlackMarketUtility.GetContractsModelTable(f78_arg0, "dailyContracts")
		f78_local2("dailyActive", f78_local3[1])
		local f78_local4 = CoD.BlackMarketUtility.GetContractsModelTable(f78_arg0, "pinnedContracts")
		f78_local2("contractSlot1", f78_local4[1])
		f78_local2("contractSlot2", f78_local4[2])
	else
		f78_local2("dailyActive", CoD.AARUtility.ContractRewardModels.dailyActive)
		f78_local2("contractSlot1", CoD.AARUtility.ContractRewardModels.contractSlot1)
		f78_local2("contractSlot2", CoD.AARUtility.ContractRewardModels.contractSlot2)
	end
	return f78_local0
end
CoD.AARUtility.PlayerEarnedRewards = function(f80_arg0)
	local f80_local0 = CoD.AARUtility.GetPlayerRewards(f80_arg0)
	local f80_local1 = CoD.AARUtility.GetWeaponRewards(f80_arg0)
	local f80_local2 = CoD.AARUtility.GetChallengeRewards(f80_arg0)
	local f80_local3 = CoD.AARUtility.GetContractRewards(f80_arg0)
	if IsWarzone() then
		return #f80_local2 + #CoD.AARUtility.GetUnlockedWZTagRewards(f80_arg0) + #f80_local3 > 0
	else
		return #f80_local0 + #f80_local1 + #f80_local2 + #f80_local3 > 0
	end
end
DataSources.CharacterUnlock = ListHelper_SetupDataSource("CharacterUnlock", function(f81_arg0)
	local f81_local0 = {}
	local f81_local1 = Enum[@"emodes"][@"mode_warzone"]
	local f81_local2 = Engine[@"getrecentlyunlockeditems"](f81_arg0)
	if CoD.BaseUtility.IsDvarEnabled("ui_debugWZCharUnlock") then
		f81_local2 = {}
		for f81_local3 = 701, 741, 1 do
			table.insert(f81_local2, {
				itemIndex = f81_local3,
			})
		end
	end
	if IsInGame() and not IsDemoPlaying() then
		for f81_local6, f81_local7 in ipairs(f81_local2) do
			if f81_local7.itemIndex == 701 or f81_local7.itemIndex == 702 or f81_local7.itemIndex == 703 or f81_local7.itemIndex == 704 or f81_local7.itemIndex == 705 then
				f81_local2[f81_local6] = nil
			end
		end
		f81_local3, f81_local4 = CoD.AARUtility.GetStats(f81_arg0)
		f81_local5 = f81_local3.PlayerStatsList.RANK.StatValue:get()
		f81_local6 = f81_local4.PlayerStatsList.RANK.StatValue:get()
		if f81_local5 ~= f81_local6 then
			if f81_local5 < 19 and f81_local6 >= 19 then
				table.insert(f81_local2, {
					itemIndex = 703,
				})
			elseif f81_local5 < 39 and f81_local6 >= 39 then
				table.insert(f81_local2, {
					itemIndex = 704,
				})
			elseif f81_local5 < 59 and f81_local6 >= 59 then
				table.insert(f81_local2, {
					itemIndex = 701,
				})
			elseif f81_local5 < 79 and f81_local6 >= 79 then
				table.insert(f81_local2, {
					itemIndex = 705,
				})
			elseif f81_local5 < 80 and f81_local6 >= 80 then
				table.insert(f81_local2, {
					itemIndex = 702,
				})
			end
		end
	end
	for f81_local6, f81_local7 in pairs(f81_local2) do
		f81_local7.refHash = Engine[@"hash_7B98952F69D937F9"](f81_local7.itemIndex)
	end
	f81_local3 = CoD.PlayerRoleUtility.GetHeroList(f81_local1)
	if #f81_local2 > 0 then
		f81_local4 = 0
		for f81_local24, f81_local25 in ipairs(f81_local3) do
			local f81_local26 = f81_local25.bodyIndex
			local f81_local27 = Engine[@"getpositionrolebundleinfo"](f81_local1, f81_local26)
			for f81_local21, f81_local22 in ipairs(f81_local2) do
				if f81_local22.refHash == f81_local27[@"unlockableitementry"] then
					local f81_local8 = nil
					local f81_local9 = @"hash_C6F2E103E4397D"
					if IsBooleanDvarSet(@"hash_4A5FD7D94CFC9DFD") and f81_local27[@"modecategory"] == Enum[@"emodes"][@"mode_multiplayer"] then
						local f81_local10 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f81_local1, f81_local26)
						for f81_local17, f81_local18 in ipairs(f81_local10.outfits) do
							for f81_local14, f81_local15 in ipairs(f81_local18.presets) do
								if CoD.BlackMarketTableUtility[@"hash_733358695872A441"][f81_local15.lootId] then
									f81_local8 = f81_local17 - 1
									f81_local9 = 0x46FF513F7848C9
									break
								end
							end
							if f81_local8 then
							end
						end
					end
					local f81_local10 = Engine[@"getunlockableinfobyindex"](f81_local22.itemIndex, f81_local1)
					table.insert(f81_local0, {
						models = {
							name = f81_local10.name,
							unlockDesc = f81_local10.description,
							characterIndex = f81_local26,
							outfitIndex = f81_local8 or 0,
							unlockTitle = f81_local9,
							portrait = f81_local25.positionDraftIcon,
						},
					})
					f81_local4 = f81_local4 + 1
				end
			end
			if #f81_local2 <= f81_local4 then
			end
		end
	end
	for f81_local24, f81_local25 in ipairs(CoD.AARUtility.GetRecentlyUnlockedWarzoneCharacters(f81_arg0)) do
		local f81_local26 = Engine[@"hash_284E3CB0C7D8BA11"](f81_local1, f81_local25)
		if f81_local26 then
			local f81_local27 = CoD.AARUtility.GetUnlockableItemInfoFromCharacterIndex(f81_local1, f81_local26)
			local f81_local28 = Engine[@"getpositionrolebundleinfo"](f81_local1, f81_local26)
			local f81_local29 = nil
			local f81_local23 = @"hash_C6F2E103E4397D"
			if IsBooleanDvarSet(@"hash_4A5FD7D94CFC9DFD") and f81_local28[@"modecategory"] == Enum[@"emodes"][@"mode_multiplayer"] then
				local f81_local21 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f81_local1, f81_local26)
				for f81_local10, f81_local11 in ipairs(f81_local21.outfits) do
					for f81_local18, f81_local19 in ipairs(f81_local11.presets) do
						if CoD.BlackMarketTableUtility[@"hash_733358695872A441"][f81_local19.lootId] then
							f81_local29 = f81_local10 - 1
							f81_local23 = 0x46FF513F7848C9
							break
						end
					end
					if f81_local29 then
					end
				end
			end
			table.insert(f81_local0, {
				models = {
					name = f81_local27.name,
					unlockDesc = f81_local27.description,
					characterIndex = f81_local26,
					outfitIndex = f81_local29 or 0,
					unlockTitle = f81_local23,
					portrait = f81_local3[f81_local26].positionDraftIcon,
				},
			})
		end
	end
	if #f81_local0 > 0 then
		f81_local5 = Engine[@"getmodelforcontroller"](f81_arg0)
		if f81_local5.hudItems.warzone then
			f81_local6 = f81_local5.hudItems.warzone:create("wzAAR.characterEarned")
			f81_local6:set(true)
		end
	end
	return f81_local0
end, true)
CoD.AARUtility.SecondsToHoursMinutesSecondsString = function(f82_arg0)
	local f82_local0 = math.floor(f82_arg0 / 60)
	local f82_local1 = f82_arg0 % 60
	local f82_local2 = math.floor(f82_local0 / 60)
	f82_local0 = f82_local0 - f82_local2 * 60
	if f82_local0 <= 0 and f82_local2 <= 0 and f82_local1 <= 0 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_411256C7F1D89ACB")
	else
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_27E8A65C2A456432", f82_local2, f82_local0, f82_local1)
	end
end
CoD.AARUtility.GetAARRootModel = function(f83_arg0)
	local f83_local0 = Engine[@"getmodelforcontroller"](f83_arg0)
	return f83_local0:create("AAR")
end
CoD.AARUtility.GetAARLevelUpRootModel = function(f84_arg0)
	local f84_local0 = CoD.AARUtility.GetAARRootModel(f84_arg0)
	return f84_local0:create("levelUp")
end
CoD.AARUtility.GetAARSummaryStatsRootModel = function(f85_arg0)
	local f85_local0 = CoD.AARUtility.GetAARRootModel(f85_arg0)
	return f85_local0:create("summaryStats")
end
CoD.AARUtility.GetAARScoreboardRootModel = function(f86_arg0)
	local f86_local0 = CoD.AARUtility.GetAARRootModel(f86_arg0)
	return f86_local0:create("scoreboard")
end
CoD.AARUtility.GetAARRewardsRootModel = function(f87_arg0)
	local f87_local0 = CoD.AARUtility.GetAARRootModel(f87_arg0)
	return f87_local0:create("rewards")
end
CoD.AARUtility.GetAARMeritReportRootModel = function(f88_arg0)
	local f88_local0 = CoD.AARUtility.GetAARRootModel(f88_arg0)
	return f88_local0:create("merit")
end
CoD.AARUtility.GetAARMissionRewardRootModel = function(f89_arg0)
	local f89_local0 = CoD.AARUtility.GetAARRootModel(f89_arg0)
	return f89_local0:create("missionReward")
end
CoD.AARUtility.GetAARTierRewardRootModel = function(f90_arg0)
	local f90_local0 = CoD.AARUtility.GetAARRootModel(f90_arg0)
	return f90_local0:create("tierReward")
end
CoD.AARUtility.GetAARLadderRootModel = function(f91_arg0)
	local f91_local0 = CoD.AARUtility.GetAARRootModel(f91_arg0)
	return f91_local0:create("ladderStats")
end
CoD.AARUtility.GetCurrentGametype = function(f92_arg0)
	local f92_local0 = CoD.AARUtility.GetAARRootModel(f92_arg0)
	local f92_local1 = f92_local0.gametype
	if f92_local1 then
		f92_local1 = f92_local0.gametype:get()
	end
	if not f92_local1 then
		local f92_local2 = CoD.GetCurrentPlayerStats(f92_arg0)
		local f92_local3 = f92_local2 and f92_local2.AfterActionReportStats
		if f92_local3 then
			local f92_local4 = f92_local3.gameType
			if f92_local4 then
				f92_local4 = f92_local3.gameType:get()
			end
			if f92_local4 and f92_local4 ~= "" then
				f92_local1 = f92_local4
			else
				f92_local1 = Engine[@"hash_36F8027A8BC75673"]()
			end
		end
	end
	return f92_local1
end
CoD.AARUtility.GetCurrentMapName = function(f93_arg0)
	local f93_local0 = CoD.AARUtility.GetAARRootModel(f93_arg0)
	return f93_local0.mapName and f93_local0.mapName:get() or Engine[@"getcurrentmapname"]()
end
CoD.AARUtility.GetInGameClientNum = function(f94_arg0)
	local f94_local0 = Engine[@"getclientnum"](f94_arg0)
	if not Engine[@"isingame"]() then
		local f94_local1 = CoD.GetCurrentPlayerStats(f94_arg0)
		if IsLobbyNetworkModeLAN() then
			f94_local1 = CoD.GetBeforeMatchPlayerStats(f94_arg0)
		end
		if f94_local1 and f94_local1.AfterActionReportStats and f94_local1.AfterActionReportStats.clientNum then
			f94_local0 = f94_local1.AfterActionReportStats.clientNum:get()
		end
	end
	return f94_local0
end
CoD.AARUtility.GetLastPlayedCharacterIndex = function(f95_arg0)
	local f95_local0 = 0
	local f95_local1 = CoD.GetCurrentPlayerStats(f95_arg0)
	if f95_local1 and f95_local1.AfterActionReportStats and f95_local1.AfterActionReportStats.characterIndex then
		f95_local0 = f95_local1.AfterActionReportStats.characterIndex:get()
	end
	return f95_local0
end
CoD.AARUtility.GetCurrentStats = function(f96_arg0)
	local f96_local0 = CoD.GetCurrentPlayerStats(f96_arg0)
	if IsLobbyNetworkModeLAN() then
		f96_local0 = CoD.GetBeforeMatchPlayerStats(f96_arg0)
	end
	return f96_local0
end
CoD.AARUtility.GetStats = function(f97_arg0)
	local f97_local0 = CoD.GetBeforeMatchPlayerStats(f97_arg0)
	local f97_local1 = CoD.GetCurrentPlayerStats(f97_arg0)
	if IsLobbyNetworkModeLAN() then
		f97_local1 = f97_local0
	end
	return f97_local0, f97_local1
end
CoD.AARUtility.GetGameModeOnMapNameString = function(f98_arg0, f98_arg1)
	return CoD.BaseUtility.GetGameModeOnMapNameString(CoD.AARUtility.GetCurrentGametype(controller), CoD.AARUtility.GetCurrentMapName(controller))
end
CoD.AARUtility.GetAARStamp = function(f99_arg0, f99_arg1)
	local f99_local0 = CoD.GetCurrentPlayerStats(f99_arg0)
	if not IsZombies() or IsLobbyNetworkModeLAN() or f99_local0 == nil then
		return ""
	else
		return Engine[@"hash_6B84A5D75CFD746D"](f99_local0.AfterActionReportStats.matchID:get())
	end
end
CoD.AARUtility.AARMatchIDValid = function(f100_arg0)
	local f100_local0 = CoD.GetCurrentPlayerStats(f100_arg0)
	if IsLobbyNetworkModeLAN() or f100_local0 == nil then
		return false
	end
	local f100_local1 = f100_local0.AfterActionReportStats.matchID:get()
	local f100_local2 = f100_local1
	local f100_local3
	if f100_local1 == 0 or f100_local1 == "" or f100_local1 == "0" then
		f100_local3 = false
	else
		f100_local3 = f100_local2 and true
	end
	return f100_local3
end
CoD.AARUtility.IsGametypeObjectiveType = function(f101_arg0)
	local f101_local0 = CoD.AARUtility.GetCurrentGametype(f101_arg0)
	for f101_local4, f101_local5 in ipairs({
		"control",
		"dom",
		"bounty",
		"escort",
		"clean",
	}) do
		if f101_local5 == f101_local0 then
			return true
		end
	end
	return false
end
CoD.AARUtility.IsWinLoseStat = function(f102_arg0)
	local f102_local0 = CoD.AARUtility.GetAARRootModel(f102_arg0)
	return f102_local0.activeStat:get() == CoD.AARUtility.AARStatType.WL_RATIO
end
CoD.AARUtility.IsNemesis = function(f103_arg0, f103_arg1)
	local f103_local0 = f103_arg0:getModel()
	if f103_local0 then
		local f103_local1 = CoD.AARUtility.GetAARScoreboardRootModel(f103_arg1)
		local f103_local2 = f103_local1.nemesisName:get()
		local f103_local3 = Engine[@"getmodelforclient"](f103_local0.clientNum:get())
		return f103_local3.scoreboard.playerName:get() == f103_local2
	else
		return false
	end
end
CoD.AARUtility.IsClientSelectedInScoreboard = function(f104_arg0, f104_arg1)
	local f104_local0 = Engine[@"getmodelforcontroller"](f104_arg1)
	if f104_local0.currentFocusedClient then
		local f104_local1 = f104_local0.currentFocusedClient:get()
		if f104_local1 then
			local f104_local2 = f104_local1.clientNum:get()
			local f104_local3 = f104_arg0:getModel()
			if f104_local3 then
				return f104_local3.clientNum:get() == f104_local2
			end
		end
	end
	return false
end
CoD.AARUtility.ShouldShowNemesis = function(f105_arg0, f105_arg1)
	local f105_local0 = true
	local f105_local1 = Engine[@"getmodelforcontroller"](f105_arg1)
	if f105_local1.currentFocusedClient then
		local f105_local2 = f105_local1.currentFocusedClient:get()
		if f105_local2 then
			local f105_local3 = f105_local2.team:get()
			local f105_local4 = f105_arg0:getModel()
			if f105_local4 then
				local f105_local5 = Engine[@"getmodelforclient"](f105_local4.clientNum:get())
				local f105_local6 = f105_local5
				local f105_local7 = f105_local5.team
				if f105_local7 then
					f105_local7 = f105_local6 and f105_local5.team:get()
				end
				f105_local0 = f105_local7 == f105_local3
			end
		end
	end
	local f105_local2 = CoD.AARUtility.IsClientSelectedInScoreboard(f105_arg0, f105_arg1)
	local f105_local8 = CoD.AARUtility.IsNemesis(f105_arg0, f105_arg1)
	local f105_local4
	if f105_local0 then
		f105_local4 = f105_local2
	else
		f105_local4 = f105_local8 and true
	end
	return f105_local4
end
CoD.AARUtility.IsGameTypeEqualToString = function(f106_arg0, f106_arg1)
	local f106_local0 = CoD.AARUtility.GetCurrentGametype(f106_arg1)
	local f106_local1
	if f106_local0 ~= f106_arg0 and f106_local0 ~= f106_arg0 .. "_hc" then
		f106_local1 = false
	else
		f106_local1 = true
	end
	return f106_local1
end
CoD.AARUtility.IsGameTypeTeamFFA = function(f107_arg0)
	for f107_local3, f107_local4 in ipairs({
		"gun",
		"dm",
		"oic",
		"sas",
	}) do
		if CoD.AARUtility.IsGameTypeEqualToString(f107_local4, f107_arg0) then
			return true
		end
	end
	return false
end
CoD.AARUtility.GetActiveTab = function(f108_arg0)
	local f108_local0 = CoD.AARUtility.GetAARRootModel(f108_arg0)
	return f108_local0.activeTab:get()
end
CoD.AARUtility.SetActiveListItemToActiveTab = function(f109_arg0, f109_arg1, f109_arg2)
	f109_arg2:findItem({
		param = CoD.AARUtility.GetActiveTab(f109_arg0),
	}, nil, true, nil)
end
CoD.AARUtility.SwitchAARTabs = function(f110_arg0, f110_arg1, f110_arg2, f110_arg3, f110_arg4)
	local f110_local0 = f110_arg3
	local f110_local1 = CoD.AARUtility.GetAARRootModel(f110_arg2)
	f110_local1.activeTab:set(f110_local0)
	if f110_local0 == CoD.AARUtility.AARTabs.AAR_SCOREBOARD or f110_local0 == CoD.AARUtility.AARTabs.ZM_AAR_SCOREBOARD then
		MenuUnhideFreeCursor(f110_arg4, f110_arg2)
		f110_arg4:addElement(LUI.UITimer.newElementTimer(0, true, function()
			local f111_local0 = LUI.getTableFromPath("AARScoreboardTab.TabbedScoreboardScores.YourTeamScores", f110_arg4)
			if f111_local0 then
				for f111_local4, f111_local5, f111_local6 in f111_local0:forEachElement() do
					if IsSelfClient(f110_arg2, f111_local6) then
						f111_local6:processEvent({
							name = "gain_focus",
							controller = f110_arg2,
						})
						f111_local6:centerFreeCursorOnElement(f110_arg2)
						break
					end
				end
			end
		end))
	elseif f110_local0 == CoD.AARUtility.AARTabs.AAR_MEDALS then
		MenuUnhideFreeCursor(f110_arg4, f110_arg2)
		f110_arg4:addElement(LUI.UITimer.newElementTimer(0, true, function()
			local f112_local0 = LUI.getTableFromPath("AARMedalsTab", f110_arg4)
			if f112_local0 then
				f112_local0:processEvent({
					name = "gain_focus",
					controller = f110_arg2,
				})
				if f112_local0.active then
					f112_local0.active:centerFreeCursorOnElement(f110_arg2)
				end
			end
		end))
	else
		MenuHidesFreeCursor(f110_arg4, f110_arg2)
	end
end
CoD.AARUtility.RegisterForRightStickGridControl = function(f113_arg0, f113_arg1, f113_arg2, f113_arg3)
	if not f113_arg0._rStickGrids then
		f113_arg0._rStickGrids = {}
	end
	f113_arg0._rStickGrids[f113_arg3] = f113_arg1
	if IsFreeCursorActive(f113_arg2) then
		f113_arg0:AddButtonCallbackFunction(f113_arg0, f113_arg2, Enum[@"luibutton"][@"lui_key_left"], nil, function(element, menu, controller, model)
			local f114_local0 = menu._rStickGrids[CoD.AARUtility.GetActiveTab(controller)]
			if f114_local0 then
				f114_local0:navigateItemLeft()
			end
		end, AlwaysFalse, false)
		f113_arg0:AddButtonCallbackFunction(f113_arg0, f113_arg2, Enum[@"luibutton"][@"lui_key_right"], nil, function(element, menu, controller, model)
			local f115_local0 = menu._rStickGrids[CoD.AARUtility.GetActiveTab(controller)]
			if f115_local0 then
				f115_local0:navigateItemRight()
			end
		end, AlwaysFalse, false)
	end
end
CoD.AARUtility.RegisterForTriggerNavigation = function(f116_arg0, f116_arg1, f116_arg2, f116_arg3, f116_arg4)
	if not f116_arg0._triggerGrids then
		f116_arg0._triggerGrids = {}
	end
	local f116_local0 = LUI.getTableFromPath(f116_arg3, f116_arg1)
	if f116_local0 then
		f116_arg0._triggerGrids[f116_arg4] = f116_local0
		f116_arg0:AddButtonCallbackFunction(f116_arg0, f116_arg2, Enum[@"luibutton"][@"lui_key_ltrig"], "ui_prevtab", function(element, menu, controller, model)
			if IsRepeatButtonPress(model) then
				return
			else
				local f117_local0 = menu._triggerGrids[CoD.AARUtility.GetActiveTab(controller)]
				if f117_local0 then
					f117_local0:navigateItemLeft()
					return true
				else
				end
			end
		end, AlwaysFalse, false)
		f116_arg0:AddButtonCallbackFunction(f116_arg0, f116_arg2, Enum[@"luibutton"][@"lui_key_rtrig"], "ui_nexttab", function(element, menu, controller, model)
			if IsRepeatButtonPress(model) then
				return
			else
				local f118_local0 = menu._triggerGrids[CoD.AARUtility.GetActiveTab(controller)]
				if f118_local0 then
					f118_local0:navigateItemRight()
					return true
				else
				end
			end
		end, AlwaysFalse, false)
	end
end
CoD.AARUtility.SetupSummaryStats = function(f119_arg0)
	local f119_local0 = CoD.AARUtility.GetAARSummaryStatsRootModel(f119_arg0)
	local f119_local1, f119_local2 = CoD.AARUtility.GetStats(f119_arg0)
	if not f119_local1 then
		f119_local1 = f119_local2
	end
	assert(f119_local1)
	assert(f119_local2)
	local f119_local3 = CoD.AARUtility.GetCurrentGametype(f119_arg0)
	if not f119_local3 then
		f119_local3 = Engine[@"hash_36F8027A8BC75673"]()
	end
	local f119_local4 = CoD.AARUtility.GetCurrentMapName(f119_arg0)
	local f119_local5 = CoD.BaseUtility.GetGameModeOnMapNameString(Engine[@"converttoxhash"](f119_local3), Engine[@"converttoxhash"](f119_local4))
	local f119_local6 = GameTypeToImage(f119_local3)
	local f119_local7 = function(f120_arg0)
		return f119_local2.PlayerStatsList[f120_arg0].StatValue:get() - f119_local1.PlayerStatsList[f120_arg0].StatValue:get()
	end
	local f119_local8 = {}
	if IsLobbyNetworkModeLAN() or not Engine[@"sessionmode_ispubliconlinegame"]() then
		f119_local8.score = f119_local1.PlayerStatsList.SCORE.StatValue:get()
		f119_local8.deaths = f119_local1.PlayerStatsList.DEATHS.StatValue:get()
		if CoD.AARUtility.IsGameTypeEqualToString("escort", f119_arg0) then
			f119_local8.escortDisables = f119_local1.PlayerStatsList.DISABLES.StatValue:get()
			f119_local8.escortDeliveries = f119_local1.PlayerStatsList.STATS_ESCORT_ROBOT_DELIVERED.StatValue:get()
		elseif CoD.AARUtility.IsGameTypeEqualToString("clean", f119_arg0) then
			f119_local8.cleanDeposits = f119_local1.PlayerStatsList.cleandeposits.StatValue:get()
			f119_local8.cleanDenies = f119_local1.PlayerStatsList.cleandenies.StatValue:get()
		elseif CoD.AARUtility.IsGameTypeEqualToString("ctf", f119_arg0) then
			f119_local8.ctfCaptures = f119_local1.PlayerStatsList.captures.StatValue:get()
			f119_local8.ctfReturns = f119_local1.PlayerStatsList.returns.StatValue:get()
		end
	else
		f119_local8.score = f119_local7("SCORE")
		f119_local8.deaths = f119_local7("DEATHS")
		if CoD.AARUtility.IsGameTypeEqualToString("escort", f119_arg0) then
			f119_local8.escortDisables = f119_local7("DISABLES")
			f119_local8.escortDeliveries = f119_local7("STATS_ESCORT_ROBOT_DELIVERED")
		elseif CoD.AARUtility.IsGameTypeEqualToString("clean", f119_arg0) then
			f119_local8.cleanDeposits = f119_local7("cleanDeposits")
			f119_local8.cleanDenies = f119_local7("cleanDenies")
		elseif CoD.AARUtility.IsGameTypeEqualToString("ctf", f119_arg0) then
			f119_local8.ctfCaptures = f119_local7("captures")
			f119_local8.ctfReturns = f119_local7("returns")
		end
	end
	f119_local8.averageStat = ""
	f119_local8.mapname = f119_local4
	f119_local8.gametype = Engine[@"converttoxhash"](f119_local3)
	f119_local8.gametypeAndMap = f119_local5
	f119_local8.gametypeIcon = f119_local6
	f119_local8.lastMatchOutcome = @"draw"
	f119_local8.wins = 0
	f119_local8.losses = 0
	f119_local8.winRatio = ""
	local f119_local9 = Engine[@"hash_7D492E0385F6D3E4"](f119_local8.gametype)
	local f119_local10 = f119_local2.PlayerStatsList.RANKXP.StatValue:get()
	local f119_local11 = f119_local1.PlayerStatsList.RANKXP.StatValue:get()
	f119_local8.xpEarnedDuringMatch = CoD.AARUtility.GetXPEarnedDuringMatch(f119_local10, f119_local11)
	local f119_local12 = 9
	local f119_local13 = f119_local2.PlayerStatsByGametype[f119_local9]
	local f119_local14 = f119_local13.prevScores
	local f119_local15 = f119_local13.prevScoreIndex:get()
	if f119_local15 < 0 or f119_local12 < f119_local15 then
		f119_local15 = 0
	end
	local f119_local16 = f119_local14[f119_local15]
	local f119_local17 = f119_local16.objectiveTime and f119_local16.objectiveTime:get() or -1
	local f119_local18 = f119_local16.objectiveScore and f119_local16.objectiveScore:get() or -1
	local f119_local19 = f119_local16.objectiveDefends and f119_local16.objectiveDefends:get() or -1
	local f119_local20 = f119_local16.objectiveEkia and f119_local16.objectiveEkia:get() or -1
	local f119_local21 = f119_local16.ekia and f119_local16.ekia:get() or -1
	f119_local8.lastMatchOutcome = f119_local16.outcome and f119_local16.outcome:get() or -1
	f119_local8.objectiveTime = f119_local17
	f119_local8.objectiveScore = f119_local18
	f119_local8.objectiveEkia = f119_local20
	f119_local8.objectiveTotal = f119_local18 + f119_local20
	f119_local8.kills = f119_local21
	f119_local8.kdRatio = string.format("%.2f", f119_local8.kills / math.max(1, f119_local8.deaths))
	f119_local8.damage = f119_local16.damage and f119_local16.damage:get() or -1
	f119_local8.previousProgressThisLevel = 0
	if CoD.AARUtility.IsGameTypeEqualToString("escort", f119_arg0) then
		f119_local8.objectiveTotal = f119_local8.escortDisables + f119_local8.escortDeliveries + f119_local8.objectiveEkia
	elseif CoD.AARUtility.IsGameTypeEqualToString("clean", f119_arg0) then
		f119_local8.objectiveTotal = f119_local8.cleanDeposits + f119_local8.cleanDenies
	elseif CoD.AARUtility.IsGameTypeEqualToString("ctf", f119_arg0) then
		f119_local8.objectiveTotal = f119_local8.ctfCaptures + f119_local8.ctfReturns
	end
	if not IsPublicOnlineGame() then
		f119_local8.rankLabel = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BC1D826D76D607F", 0)
		f119_local8.rankIcon = @"blacktransparent"
		f119_local8.nextRank = 0
		f119_local8.nextRankIcon = @"blacktransparent"
		f119_local8.nextRankLabel = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BC1D826D76D607F", 1)
		f119_local8.levelProgress = 0
		f119_local8.xpNeededToLevelUp = 0
		f119_local8.barCurrentTier = 0
		f119_local8.barNextTier = 0
		f119_local8.previousTierProgress = 0
		f119_local8.earnedTierProgress = 0
		f119_local8.tierProgress = 0
	else
		local f119_local22 = f119_local2.PlayerStatsList.RANK.StatValue:get()
		local f119_local23 = CoD.AARUtility.GetCurrentPrestige(f119_arg0)
		local f119_local24 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f119_arg0, f119_local22, Engine[@"getrankinfo"](f119_local22))
		local f119_local25 = f119_local22 + 1
		local f119_local26 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f119_arg0, f119_local25, Engine[@"getrankinfo"](f119_local25))
		local f119_local27, f119_local28 = CoD.AARUtility.GetMinMaxXPForRank(f119_local22)
		f119_local8.levelProgress = (f119_local10 - f119_local27) / math.max(1, f119_local28 - f119_local27)
		local f119_local29 = IsInParagonCapableGameMode()
		if f119_local29 then
			f119_local29 = f119_local23 == CoD.PrestigeUtility.GetPrestigeCap()
		end
		if f119_local29 then
			f119_local22 = f119_local2.PlayerStatsList.PARAGON_RANK.StatValue:get()
			f119_local25 = f119_local22 + 1
			f119_local10 = f119_local2.PlayerStatsList.PARAGON_RANKXP.StatValue:get()
			f119_local11 = f119_local1.PlayerStatsList.PARAGON_RANKXP.StatValue:get()
			local f119_local30 = Engine[@"currentsessionmode"]()
			f119_local10 = CoD.PlayerStatsUtility.GetPrestigeMasterAbsoluteXP(f119_local30, f119_local10)
			f119_local11 = CoD.PlayerStatsUtility.GetPrestigeMasterAbsoluteXP(f119_local30, f119_local11)
			f119_local8.xpEarnedDuringMatch = CoD.AARUtility.GetXPEarnedDuringMatch(f119_local10, f119_local11)
			f119_local24 = CoD.RankUtility.GetRankIcons(f119_arg0, f119_local30, f119_local22, f119_local23)
			f119_local24.level = f119_local22 + 1
			if f119_local25 <= CoD.RankUtility.GetParagonRankCap(f119_local30) then
				f119_local26 = CoD.RankUtility.GetRankIcons(f119_arg0, f119_local30, f119_local25, f119_local23)
				f119_local26.level = f119_local25 + 1
			else
				f119_local26 = nil
			end
			f119_local27, f119_local28 = CoD.AARUtility.GetMinMaxXPForParagonRank(f119_local22)
			f119_local8.levelProgress = (f119_local10 - f119_local27) / math.max(1, f119_local28 - f119_local27)
		end
		if f119_local24 then
			f119_local8.rank = f119_local24.level
			f119_local8.rankLabel = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BC1D826D76D607F", f119_local24.level)
			f119_local8.rankIcon = f119_local24.iconLarge
			f119_local8.previousProgressThisLevel = math.max(f119_local11 - f119_local27, 0) / math.max(1, f119_local28 - f119_local27)
			f119_local8.xpNeededToLevelUp = f119_local28 - f119_local10
		else
			f119_local8.rankLabel = ""
			f119_local8.rankIcon = @"blacktransparent"
			f119_local8.previousProgressThisLevel = 0
			f119_local8.xpNeededToLevelUp = 0
		end
		if f119_local26 then
			f119_local8.nextRank = f119_local26.level
			f119_local8.nextRankIcon = f119_local26.iconLarge
			f119_local8.nextRankLabel = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BC1D826D76D607F", f119_local26.level)
		else
			f119_local8.nextRank = 0
			f119_local8.nextRankIcon = @"blacktransparent"
			f119_local8.nextRankLabel = ""
		end
		local f119_local30, f119_local31 = CoD.AARUtility.GetPreMatchLootStreamData(f119_arg0)
		local f119_local32, f119_local33, f119_local34, f119_local35 = CoD.AARUtility.GetLootStreamData(f119_arg0)
		f119_local8.barCurrentTier = f119_local32
		f119_local8.barNextTier = f119_local32 + 1
		if f119_local32 == f119_local30 then
			f119_local8.previousTierProgress = f119_local31 / f119_local34
		else
			f119_local8.previousTierProgress = 0
		end
		f119_local8.earnedTierProgress = f119_local33 / f119_local34
		f119_local8.tierProgress = f119_local8.previousTierProgress
		local f119_local36, f119_local37 = CoD.AARUtility.GetLootCaseData(f119_arg0)
		local f119_local38, f119_local39 = CoD.AARUtility.GetPreMatchLootCaseData(f119_arg0)
		local f119_local40 = CoDShared.Loot.GetLootCaseOwnedCount(f119_arg0)
		if CoD.AARUtility.HasSeenLootCaseProgressAnimate(f119_arg0) or CoD.AARUtility.TierRewardUp(f119_arg0) then
			f119_local8.lootCaseEarnedProgress = f119_local37
			f119_local8.lootCaseProgress = f119_local37
			f119_local8.previousLootCaseProgress = f119_local39
			f119_local8.lootCaseCount = f119_local40
			if f119_local37 < f119_local39 then
				f119_local8.previousLootCaseProgress = 0
			end
		else
			f119_local8.lootCaseEarnedProgress = f119_local37
			f119_local8.lootCaseProgress = f119_local39
			f119_local8.previousLootCaseProgress = f119_local39
			f119_local8.lootCaseCount = f119_local40
			if f119_local37 < f119_local39 then
				f119_local8.lootCaseCount = f119_local40 - 1
			end
		end
	end
	Engine[0xDE279ECDDDD966](f119_arg0, @"hash_143529817734F2D9", {
		[@"match_id"] = Engine[@"hash_6D52E2360F482280"](),
		[@"damage_dealt"] = f119_local8.damage,
		[@"score"] = f119_local8.score,
		[@"ekia"] = f119_local8.kills,
		[@"deaths"] = f119_local8.deaths,
	})
	for f119_local25, f119_local26 in pairs(f119_local8) do
		local f119_local27 = f119_local0:create(f119_local25)
		f119_local27:set(f119_local26)
	end
end
CoD.AARUtility.SetupSummaryStats_WZ = function(f121_arg0)
	local f121_local0 = CoD.AARUtility.GetAARSummaryStatsRootModel(f121_arg0)
	local f121_local1, f121_local2 = CoD.AARUtility.GetStats(f121_arg0)
	if not f121_local1 then
		f121_local1 = f121_local2
	end
	local f121_local3 = CoD.AARUtility.GetCurrentGametype(f121_arg0)
	if not f121_local3 then
		f121_local3 = Engine[@"hash_36F8027A8BC75673"]()
	end
	local f121_local4 = {
		mapname = CoD.AARUtility.GetCurrentMapName(f121_arg0),
		gametype = Engine[@"converttoxhash"](f121_local3),
		gametypeDisplay = GameTypeToLocalizedGameType(f121_local3),
		gametypeIcon = GameTypeToImage(f121_local3),
	}
	local f121_local5 = Engine[@"hash_7D492E0385F6D3E4"](f121_local4.gametype)
	if f121_local1 and f121_local2 then
		local f121_local6 = f121_local2.PlayerStatsByGameType[f121_local5]
		local f121_local7 = f121_local1.PlayerStatsByGameType[f121_local5]
		local f121_local8 = function(f122_arg0)
			if f121_local7 and f121_local6 then
				return f121_local6[f122_arg0].StatValue:get() - f121_local7[f122_arg0].StatValue:get()
			else
				return 0
			end
		end
		f121_local4.finishes = f121_local8("KILLS_ELIMINATED")
		local f121_local9
		if f121_local2 then
			f121_local9 = f121_local2[@"afteractionreportstats"][@"longestdistancekill"]:get()
			if not f121_local9 then
			else
				f121_local4.longestDistanceKill = f121_local9
				f121_local4.revives = f121_local8("REVIVES")
				f121_local4.cleanUps = f121_local8("KILLS_ELIMINATED")
				f121_local4.cleanUps = f121_local4.cleanUps + f121_local8("DOWNS_ELIMINATED")
				f121_local4.cleanUps = f121_local4.cleanUps + f121_local8("DOWNS_ELIMINATED_TEAM")
				f121_local4.unfinishedDrops = f121_local8("DOWNS_REVIVED")
				f121_local4.downs = f121_local8("DOWNS")
				f121_local4.kills = f121_local8("KILLS")
				f121_local4.damage = f121_local8("TOTAL_DAMAGE")
				f121_local4.paintCans = f121_local8("ITEMS_PAINT_CANS_COLLECTED")
				f121_local9 = f121_local2.PlayerStatsList.RANK.StatValue:get()
				local f121_local10 = f121_local2.PlayerStatsList.RANKXP.StatValue:get()
				local f121_local11 = f121_local2.PlayerStatsList.PLEVEL.StatValue:get()
				local f121_local12 = f121_local1.PlayerStatsList.RANKXP.StatValue:get()
				local f121_local13 = Engine[@"getrankinfo"](f121_local9)
				local f121_local14 = Engine[@"getrankinfo"](f121_local9 + 1)
				local f121_local15, f121_local16 = CoD.AARUtility.GetMinMaxXPForRank(f121_local9)
				local f121_local17 = (f121_local10 - f121_local15) / math.max(1, f121_local16 - f121_local15)
				f121_local4.xpEarnedDuringMatch = CoD.AARUtility.GetXPEarnedDuringMatch(f121_local10, f121_local12)
				f121_local4.levelProgress = f121_local17
				f121_local4.xpNeededToLevelUp = f121_local16 - f121_local10
				f121_local4.previousProgressThisLevel = math.max(f121_local12 - f121_local15, 0) / math.max(1, f121_local16 - f121_local15)
				if f121_local13 then
					f121_local4.rankLabel = Engine[@"hash_4F9F1239CFD921FE"](0xC538B68F8CA671, CoD.WZUtility.GetWZLevel(f121_local13.level))
					local f121_local18
					if f121_local11 ~= nil then
						f121_local18 = Engine[@"getrankicon"](f121_local13.level, f121_local11, Enum[@"emodes"][@"mode_warzone"])
						if not f121_local18 then
						else
							f121_local4.rankIcon = f121_local18
							if f121_local4.rankIcon == 0x0 then
								f121_local4.rankIcon = f121_local13.iconLarge
							end
							f121_local4.rank = f121_local13.level
						end
					end
					f121_local18 = Engine[@"hash_D4A9B159BE44163"](f121_local13.level)
				else
					f121_local4.rankLabel = ""
					f121_local4.rankIcon = @"blacktransparent"
					f121_local4.rank = 0
				end
				if f121_local14 then
					f121_local4.nextRankLabel = Engine[@"hash_4F9F1239CFD921FE"](0xC538B68F8CA671, CoD.WZUtility.GetWZLevel(f121_local14.level))
					local f121_local18
					if f121_local11 ~= nil then
						f121_local18 = Engine[@"getrankicon"](f121_local14.level, f121_local11, Enum[@"emodes"][@"mode_warzone"])
						if not f121_local18 then
						else
							f121_local4.nextRankIcon = f121_local18
							if f121_local4.nextRankIcon == 0x0 then
								f121_local4.nextRankIcon = f121_local14.iconLarge
							end
							f121_local4.nextRank = f121_local14.level
						end
					end
					f121_local18 = Engine[@"hash_D4A9B159BE44163"](f121_local14.level)
				else
					f121_local4.nextRankLabel = ""
					f121_local4.nextRankIcon = @"blacktransparent"
					f121_local4.nextRank = 0
				end
				if not CoD.AARUtility.ShouldHideTierRewardMiniStatus(nil, f121_arg0) then
					local f121_local19, f121_local18 = CoD.AARUtility.GetPreMatchLootStreamData(f121_arg0)
					local f121_local20, f121_local21, f121_local22, f121_local23 = CoD.AARUtility.GetLootStreamData(f121_arg0)
					f121_local4.barCurrentTier = f121_local20
					f121_local4.barNextTier = f121_local20 + 1
					if f121_local20 == f121_local19 then
						f121_local4.previousTierProgress = f121_local18 / f121_local22
					else
						f121_local4.previousTierProgress = 0
					end
					f121_local4.earnedTierProgress = f121_local21 / f121_local22
					f121_local4.tierProgress = f121_local4.previousTierProgress
				end
				local f121_local19, f121_local18 = CoD.AARUtility.GetLootCaseData(f121_arg0)
				local f121_local20, f121_local21 = CoD.AARUtility.GetPreMatchLootCaseData(f121_arg0)
				local f121_local22 = CoDShared.Loot.GetLootCaseOwnedCount(f121_arg0)
				if CoD.AARUtility.HasSeenLootCaseProgressAnimate(f121_arg0) or CoD.AARUtility.TierRewardUp(f121_arg0) then
					f121_local4.lootCaseEarnedProgress = f121_local18
					f121_local4.lootCaseProgress = f121_local18
					f121_local4.previousLootCaseProgress = f121_local21
					f121_local4.lootCaseCount = f121_local22
					if f121_local18 < f121_local21 then
						f121_local4.previousLootCaseProgress = 0
					end
				else
					f121_local4.lootCaseEarnedProgress = f121_local18
					f121_local4.lootCaseProgress = f121_local21
					f121_local4.previousLootCaseProgress = f121_local21
					f121_local4.lootCaseCount = f121_local22
					if f121_local18 < f121_local21 then
						f121_local4.lootCaseCount = f121_local22 - 1
					end
				end
			end
		end
		f121_local9 = 0
	else
		f121_local4.finishes = 0
		f121_local4.longestDistanceKill = 0
		f121_local4.revives = 0
		f121_local4.cleanUps = 0
		f121_local4.unfinishedDrops = 0
		f121_local4.downs = 0
		f121_local4.kills = 0
		f121_local4.damage = 0
		f121_local4.paintCans = 0
		f121_local4.xpEarnedDuringMatch = 0
		f121_local4.levelProgress = 0
		f121_local4.xpNeededToLevelUp = 0
		f121_local4.previousProgressThisLevel = 0
		f121_local4.rankLabel = ""
		f121_local4.rankIcon = @"blacktransparent"
		f121_local4.nextRank = 0
		f121_local4.nextRankIcon = @"blacktransparent"
		f121_local4.nextRankLabel = ""
		f121_local4.levelProgress = 0
		f121_local4.xpNeededToLevelUp = 0
		f121_local4.barCurrentTier = 0
		f121_local4.barNextTier = 0
		f121_local4.previousTierProgress = 0
		f121_local4.earnedTierProgress = 0
		f121_local4.tierProgress = 0
	end
	for f121_local9, f121_local10 in pairs(f121_local4) do
		local f121_local11 = f121_local0:create(f121_local9)
		f121_local11:set(f121_local10)
	end
end
CoD.AARUtility.HasSeenLootCaseProgressAnimate = function(f123_arg0)
	return f123_local0.hasAnimatedLootCaseProgress and f123_local0.hasAnimatedLootCaseProgress:get() == true
end
CoD.AARUtility.AnimateAARSummaryLootCaseProgress = function(f124_arg0, f124_arg1)
	if CoD.AARUtility.HasSeenLootCaseProgressAnimate(f124_arg1) then
		return
	else
		local f124_local0 = 1000
		local f124_local1 = 0
		local f124_local2 = CoD.AARUtility.GetAARSummaryStatsRootModel(f124_arg1)
		local f124_local3 = f124_local2.previousLootCaseProgress:get()
		local f124_local4 = f124_local2.lootCaseEarnedProgress:get()
		if f124_local3 == f124_local4 then
			return
		else
			f124_arg0:addElement(LUI.UITimer.newElementTimer(250, true, function()
				Engine[@"playsound"]("uin_aar_bar_fill_main")
				f124_arg0._animateLootCaseProgress = LUI.UITimer.newElementTimer(10, false, function(f126_arg0)
					f124_local1 = f124_local1 + f126_arg0.timeElapsed
					local f126_local0 = f124_local1 / f124_local0
					f126_local0 = f126_local0 * (2 - f126_local0)
					if f124_local0 <= f124_local1 then
						if f124_arg0._animateLootCaseProgress then
							f124_arg0._animateLootCaseProgress:close()
							f124_arg0._animateLootCaseProgress = nil
						end
						f124_local2.lootCaseProgress:set(f124_local4)
						Engine[@"playsound"]("uin_aar_bar_fill_tail")
					else
						f124_local2.lootCaseProgress:set(f126_local0 * (f124_local4 - f124_local3) + f124_local3)
					end
				end)
				f124_arg0:addElement(f124_arg0._animateLootCaseProgress)
			end))
			local f124_local5 = Engine[@"getmodelforcontroller"](f124_arg1)
			f124_local5 = f124_local5:create("hasAnimatedLootCaseProgress")
			f124_local5:set(true)
		end
	end
end
CoD.AARUtility.AnimateCurrentTierProgress = function(f127_arg0, f127_arg1)
	if CoD.AARUtility.ShouldHideTierRewardMiniStatus(f127_arg0, f127_arg1) then
		return
	else
		local f127_local0 = 1000
		local f127_local1 = 0
		local f127_local2 = CoD.AARUtility.GetAARSummaryStatsRootModel(f127_arg1)
		local f127_local3 = f127_local2.previousTierProgress:get()
		local f127_local4 = f127_local2.earnedTierProgress:get()
		f127_arg0:addElement(LUI.UITimer.newElementTimer(250, true, function()
			Engine[@"playsound"]("uin_aar_bar_fill_main")
			f127_arg0._animateTierProgress = LUI.UITimer.newElementTimer(10, false, function(f129_arg0)
				f127_local1 = f127_local1 + f129_arg0.timeElapsed
				local f129_local0 = f127_local1 / f127_local0
				f129_local0 = f129_local0 * (2 - f129_local0)
				if f127_local0 <= f127_local1 then
					f127_local2.tierProgress:set(f127_local4)
					Engine[@"playsound"]("uin_aar_bar_fill_tail")
					f127_arg0._animateTierProgress:close()
					if not IsZombies() then
						CoD.AARUtility.AnimateAARSummaryLootCaseProgress(f127_arg0, f127_arg1)
					end
				else
					f127_local2.tierProgress:set(f129_local0 * (f127_local4 - f127_local3) + f127_local3)
				end
			end)
			f127_arg0:addElement(f127_arg0._animateTierProgress)
		end))
	end
end
CoD.AARUtility.AnimateCurrentLevelProgress = function(f130_arg0, f130_arg1)
	local f130_local0 = 1000
	local f130_local1 = 0
	local f130_local2 = CoD.AARUtility.GetAARSummaryStatsRootModel(f130_arg1)
	local f130_local3 = f130_local2.xpNeededToLevelUp:get()
	local f130_local4 = f130_local3 + f130_local2.xpEarnedDuringMatch:get()
	local f130_local5 = f130_local2.levelProgress:get()
	local f130_local6 = f130_local2.previousProgressThisLevel:get()
	f130_local2.xpNeededToLevelUp:set(f130_local4)
	f130_local2.levelProgress:set(f130_local6)
	if f130_local2 ~= nil then
		f130_arg0:addElement(LUI.UITimer.newElementTimer(0, true, function()
			f130_arg0:addElement(LUI.UITimer.newElementTimer(250, true, function()
				Engine[@"playsound"]("uin_aar_bar_fill_main")
				f130_arg0._animateProgressTimer = LUI.UITimer.newElementTimer(10, false, function(f133_arg0)
					f130_local1 = f130_local1 + f133_arg0.timeElapsed
					local f133_local0 = f130_local1 / f130_local0
					f133_local0 = f133_local0 * (2 - f133_local0)
					if f130_local0 <= f130_local1 then
						f130_local2.xpNeededToLevelUp:set(f130_local3)
						f130_local2.levelProgress:set(f130_local5)
						Engine[@"playsound"]("uin_aar_bar_fill_tail")
						f130_arg0._animateProgressTimer:close()
						CoD.AARUtility.AnimateCurrentTierProgress(f130_arg0, f130_arg1)
					else
						f130_local2.xpNeededToLevelUp:set(math.floor(f133_local0 * (f130_local3 - f130_local4) + f130_local4 + 0.5))
						f130_local2.levelProgress:set(f133_local0 * (f130_local5 - f130_local6) + f130_local6)
					end
				end)
				f130_arg0:addElement(f130_arg0._animateProgressTimer)
			end))
		end))
	end
end
CoD.AARUtility.SetupScoreboard = function(f134_arg0)
	local f134_local0 = Engine[@"getmodelforcontroller"](f134_arg0)
	local f134_local1 = f134_local0:create("forceScoreboard")
	f134_local1:set(0)
	f134_local1 = f134_local0:create("scoreboardInfo.activeTab")
	f134_local1:set(CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
	f134_local1 = Engine[@"getglobalmodel"]()
	local f134_local2 = f134_local1:create("scoreboard.highestKad")
	f134_local2:set(0)
	f134_local2 = f134_local1:create("scoreboard.highestKills")
	f134_local2:set(0)
	f134_local2 = f134_local1:create("scoreboard.highestObjScore")
	f134_local2:set(0)
	f134_local2 = f134_local1:create("scoreboard.highestDamageDone")
	f134_local2:set(0)
	f134_local2 = f134_local1:create("scoreboard.highestScore")
	f134_local2:set(0)
	local f134_local3 = Engine[@"getmodelforclient"](CoD.AARUtility.GetInGameClientNum(f134_arg0))
	local f134_local4 = nil
	if CoD.CodCasterUtility.IsCodCasterAssigned(f134_arg0) then
		f134_local4 = Enum[@"team_t"][@"team_allies"]
	else
		f134_local4 = f134_local3.team:get()
	end
	local f134_local5 = Enum[@"team_t"][@"team_axis"]
	local f134_local6 = "TEAM_ALLIES"
	local f134_local7 = "TEAM_AXIS"
	if f134_local4 == Enum[@"team_t"][@"team_axis"] then
		f134_local5 = Enum[@"team_t"][@"team_allies"]
		f134_local6 = "TEAM_AXIS"
		f134_local7 = "TEAM_ALLIES"
	end
	local f134_local8 = Engine[@"getscoreboarddata"](f134_arg0)
	local f134_local9 = f134_local8.scores[f134_local6]
	local f134_local10 = f134_local8.scores[f134_local7]
	local f134_local11 = CoD.AARUtility.GetAARScoreboardRootModel(f134_arg0)
	local f134_local12 = f134_local11:create("teamScore")
	f134_local12:set(f134_local9)
	f134_local12 = f134_local11:create("teamIcon")
	f134_local12:set(CoD.TeamUtility.GetTeamFactionIcon(f134_local4))
	f134_local12 = f134_local11:create("enemyScore")
	f134_local12:set(f134_local10)
	f134_local12 = f134_local11:create("enemyIcon")
	f134_local12:set(CoD.TeamUtility.GetTeamFactionIcon(f134_local5))
	f134_local12 = CoD.AARUtility.GetCurrentStats(f134_arg0)
	local f134_local13 = f134_local12.AfterActionReportStats
	local f134_local14 = f134_local13.nemesisKills:get()
	local f134_local15 = f134_local13.nemesisKilledBy:get()
	local f134_local16 = f134_local13.nemesisXuid:get()
	local f134_local17 = f134_local13.nemesisName:get()
	local f134_local18 = f134_local11:create("nemesisKills")
	f134_local18:set(f134_local14)
	f134_local18 = f134_local11:create("nemesisKilledBy")
	f134_local18:set(f134_local15)
	f134_local18 = f134_local11:create("nemesisXuid")
	f134_local18:set(f134_local16)
	f134_local18 = f134_local11:create("nemesisName")
	f134_local18:set(f134_local17)
end
CoD.AARUtility.SetupRewards = function(f135_arg0)
	local f135_local0 = CoD.AARUtility.GetAARRewardsRootModel(f135_arg0)
	local f135_local1 = f135_local0:create("multiPage")
	f135_local1:set(false)
	CoD.AARUtility.InitRewardsPaging(f135_arg0)
end
CoD.AARUtility.InitRewardsPaging = function(f136_arg0)
	local f136_local0 = CoD.AARUtility.GetAARRewardsRootModel(f136_arg0)
	local f136_local1 = f136_local0:create("currentPage")
	f136_local1:set(1)
	f136_local1 = f136_local0:create("newPage")
	f136_local1:set(1)
end
CoD.AARUtility.InitAARModels = function(f137_arg0)
	local f137_local0 = CoD.AARUtility.GetAARRootModel(f137_arg0)
	local f137_local1 = CoD.AARUtility.GetCurrentGametype(f137_arg0)
	local f137_local2 = Engine[@"getcurrentmapname"]()
	local f137_local3 = CoD.AARUtility.AARTabs.AAR_SUMMARY
	if IsZombies() then
		if CoD.isOnlineGame() and CoD.AARUtility.PlayerEarnedRewards(f137_arg0) then
			f137_local3 = CoD.AARUtility.AARTabs.AAR_REWARDS
		elseif f137_local1 == "ztrials" then
			f137_local3 = CoD.AARUtility.AARTabs.AAR_TRIAL
		end
	end
	local f137_local4 = CoD.AARUtility.AARStatType.SCORE_PER_MINUTE
	if IsWarzone() then
		f137_local4 = CoD.AARUtility.AARStatType.KILLS
	end
	if f137_local1 == "" then
		if IsWarzone() then
			f137_local1 = "warzone_quad"
		elseif IsZombies() then
			f137_local1 = "zclassic"
		else
			f137_local1 = "tdm"
		end
	end
	local f137_local5 = f137_local0:create("activeTab")
	f137_local5:set(f137_local3)
	f137_local5 = f137_local0:create("activeStat")
	f137_local5:set(f137_local4)
	f137_local5 = f137_local0:create("gametype")
	f137_local5:set(f137_local1)
	f137_local5 = f137_local0:create("mapName")
	f137_local5:set(f137_local2)
	f137_local5 = f137_local0:create("clientNum")
	f137_local5:set(CoD.AARUtility.GetInGameClientNum(f137_arg0))
	f137_local5 = f137_local0:create("characterIndex")
	f137_local5:set(CoD.AARUtility.GetLastPlayedCharacterIndex(f137_arg0))
	if IsWarzone() then
		CoD.AARUtility.SetupNeededAarModels(f137_arg0)
		CoD.AARUtility.SetupSummaryStats_WZ(f137_arg0)
		CoD.AARUtility.SetupRewards(f137_arg0)
	elseif IsZombies() then
		CoD.AARUtility.SetupNeededAarModels(f137_arg0)
		CoD.AARUtility.SetupSummaryStats(f137_arg0)
		CoD.ZombieUtility.SetupTrialStats(f137_arg0)
		CoD.AARUtility.SetupScoreboard(f137_arg0)
		CoD.AARUtility.SetupRewards(f137_arg0)
	elseif LuaUtils.IsArenaMode() then
		CoD.AARUtility.SetupNeededAarModels(f137_arg0)
		CoD.AARUtility.SetupSummaryStats(f137_arg0)
		CoD.AARUtility.SetupScoreboard(f137_arg0)
		CoD.AARUtility.SetupRewards(f137_arg0)
		CoD.AARUtility.SetupLadderModels(f137_arg0)
	else
		CoD.AARUtility.SetupNeededAarModels(f137_arg0)
		CoD.AARUtility.SetupSummaryStats(f137_arg0)
		CoD.AARUtility.SetupScoreboard(f137_arg0)
		CoD.AARUtility.SetupRewards(f137_arg0)
	end
	CoD.BlackMarketUtility.UpdateActiveContractSlotModelsForAAR(f137_arg0)
	Dvar.ui_shouldDiscardStableStats:set(true)
end
CoD.AARUtility.UpdateAARScene = function(f138_arg0, f138_arg1)
	local f138_local0 = CoD.AARUtility.GetActiveTab(f138_arg1)
	local f138_local1 = "no_character"
	if f138_local0 == CoD.AARUtility.AARTabs.AAR_SUMMARY or f138_local0 == CoD.AARUtility.AARTabs.AAR_TRIAL or f138_local0 == CoD.AARUtility.AARTabs.ZM_AAR_SCOREBOARD then
		f138_local1 = "character"
	end
	SendCustomClientScriptMenuStateChangeNotify(f138_arg1, f138_arg0.menuName, true, f138_local1)
end
CoD.AARUtility.CanShowAAR = function(f139_arg0, f139_arg1)
	local f139_local0, f139_local1 = CoD.AARUtility.GetStats(f139_arg1)
	local f139_local2
	if f139_local0 == nil or f139_local1 == nil then
		f139_local2 = false
	else
		f139_local2 = true
	end
	local f139_local3 = IsMenuInState(f139_arg0, "ShowPublic")
	if not f139_local3 then
		f139_local3 = IsMenuInState(f139_arg0, "ShowCustom")
		if not f139_local3 then
			f139_local3 = IsMenuInState(f139_arg0, "ShowArena")
			if not f139_local3 then
				f139_local3 = IsMenuInState(f139_arg0, "ShowPrivate")
				if not f139_local3 then
					f139_local3 = IsMenuInState(f139_arg0, "ShowPregame")
				end
			end
		end
	end
	if f139_local2 and f139_local3 then
		local f139_local4 = CoD.AARUtility.GetCurrentGametype(f139_arg1)
		if not f139_local4 then
			f139_local4 = Engine[@"hash_36F8027A8BC75673"]()
		end
		local f139_local5 = Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](f139_local4))
		local f139_local6 = false
		if f139_local1.PlayerStatsByGametype and f139_local4 and f139_local4 ~= "" then
			f139_local6 = f139_local1.PlayerStatsByGametype[f139_local5] ~= nil
		end
		local f139_local7 = false
		if IsZombies() then
			f139_local7 = f139_local4 ~= "ztutorial"
		elseif IsWarzone() then
			if f139_local5 ~= nil then
				local f139_local8 = f139_local0.PlayerStatsByGameType[f139_local5]
				local f139_local9 = f139_local1.PlayerStatsByGameType[f139_local5]
				if f139_local8 and f139_local9 then
					f139_local7 = f139_local8.TIME_PLAYED_TOTAL.StatValue:get() < f139_local9.TIME_PLAYED_TOTAL.StatValue:get()
				end
			end
		else
			f139_local7 = f139_local1.AfterActionReportStats.valid:get() == 1
		end
		return f139_local6 and f139_local7
	elseif CoD.BaseUtility.IsDvarEnabled("ui_forceAAR") and f139_local1 and f139_local3 then
		return true
	else
		return false
	end
end
CoD.AARUtility.AddForceStreamTierRewardImages = function(f140_arg0, f140_arg1)
	if CoD.AARUtility.TierRewardUp(f140_arg0) then
		local f140_local0, f140_local1 = CoD.AARUtility.GetPreMatchLootStreamData(f140_arg0)
		local f140_local2, f140_local3, f140_local4, f140_local5 = CoD.AARUtility.GetLootStreamData(f140_arg0)
		local f140_local6 = f140_local0
		local f140_local7 = f140_local2 + 1
		local f140_local8 = Engine[@"currentsessionmode"]()
		local f140_local9 = {}
		for f140_local10 = f140_local6, f140_local7, 1 do
			CoD.AARUtility.AddTierRewardDataToTable(f140_arg0, f140_local9, f140_local10, f140_local8, false, false)
		end
		for f140_local13, f140_local14 in ipairs(f140_local9) do
			if f140_local14.models and f140_local14.models.primaryImage then
				CoD.BaseUtility.AddForcedImageToTable(f140_local14.models.primaryImage, f140_arg1)
			end
		end
	end
end
CoD.AARUtility.ForceStreamedImages = {}
CoD.AARUtility.AddForceStreamAARImages = function(f141_arg0)
	local f141_local0 = {}
	local f141_local1, f141_local2 = CoD.AARUtility.GetStats(f141_arg0)
	if f141_local1 and f141_local2 then
		local f141_local3 = f141_local1.PlayerStatsList.RANK.StatValue:get()
		local f141_local4 = f141_local2.PlayerStatsList.RANK.StatValue:get()
		for f141_local5 = f141_local3, f141_local4, 1 do
			local f141_local8 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f141_arg0, f141_local5, Engine[@"getrankinfo"](f141_local5))
			local f141_local9 = CoD.BaseUtility.AddForcedImageToTable
			local f141_local10
			if f141_local8 then
				f141_local10 = f141_local8.iconLarge
				if not f141_local10 then
				else
					f141_local9(f141_local10, f141_local0)
				end
			end
			f141_local10 = 0x0
		end
		local f141_local5 = function(f142_arg0)
			for f142_local3, f142_local4 in pairs(f142_arg0) do
				local f142_local5 = f142_local4.models
				CoD.BaseUtility.AddForcedImageToTable(f142_local5.mainIcon, f141_local0)
				CoD.BaseUtility.AddForcedImageToTable(f142_local5.reward1Icon, f141_local0)
				CoD.BaseUtility.AddForcedImageToTable(f142_local5.reward2Icon, f141_local0)
			end
		end
		f141_local5(CoD.AARUtility.GetPlayerRewards(f141_arg0))
		f141_local5(CoD.AARUtility.GetWeaponRewards(f141_arg0))
		local f141_local6 = CoD.AARUtility.GetCurrentGametype(f141_arg0)
		if not f141_local6 then
			f141_local6 = Engine[@"hash_36F8027A8BC75673"]()
		end
		CoD.BaseUtility.AddForcedImageToTable(GameTypeToImage(f141_local6), f141_local0)
		CoD.AARUtility.AddForceStreamTierRewardImages(f141_arg0, f141_local0)
		CoD.AARUtility.ForceStreamedImages = CoD.BaseUtility.ForceStreamHelper(CoD.AARUtility.ForceStreamedImages, f141_local0)
	end
end
CoD.AARUtility.OpenAARIfNeeded = function(f143_arg0, f143_arg1)
	local f143_local0 = CoD.AARUtility.GetAARRootModel(f143_arg1)
	local f143_local1 = f143_local0.viewedAAR
	if not f143_local1 then
		f143_local1 = f143_local0:create("viewedAAR")
	end
	if f143_local1 and f143_local1:get() == true then
		return
	elseif CoD.AARUtility.CanShowAAR(f143_arg0, f143_arg1) then
		CoD.DirectorUtility.PostponeForceStreamedImages(f143_arg1)
		CoD.AARUtility.AddForceStreamAARImages(f143_arg1)
		f143_arg0:addElement(LUI.UITimer.newElementTimer(0, true, function()
			if CoD.BaseUtility.AreAllForcedImagesStreamed(CoD.AARUtility.ForceStreamedImages) then
				CoD.DirectorUtility.ResumeForceStreamedImages(f143_arg1)
				CoD.AARUtility.OpenAAR(f143_arg0, f143_arg1)
				ClearMenuSavedState(f143_arg0)
			else
				local f144_local0 = OpenOverlay(f143_arg0, "FullScreenSpinner", f143_arg1, "")
				local f144_local1 = 0
				f143_arg0._openAARTimer = LUI.UITimer.newElementTimer(50, false, function(f145_arg0)
					f144_local1 = f144_local1 + f145_arg0.timeElapsed
					if f144_local1 > 6000 or CoD.BaseUtility.AreAllForcedImagesStreamed(CoD.AARUtility.ForceStreamedImages) then
						CoD.DirectorUtility.ResumeForceStreamedImages(f143_arg1)
						GoBack(f144_local0, f143_arg1)
						CoD.AARUtility.OpenAAR(f143_arg0, f143_arg1)
						ClearMenuSavedState(f143_arg0)
						f143_arg0._openAARTimer:close()
					end
				end)
				f144_local0:addElement(f143_arg0._openAARTimer)
			end
		end))
		f143_local1:set(true)
	elseif IsElementInAnyState(f143_arg0, "ShowArenaMatchmaking", "ShowPublic") then
		CoD.AnalyticsUtility.ShowMatchSurveyIfNecessary(f143_arg0, f143_arg1)
	end
end
CoD.AARUtility.OpenAAR = function(f146_arg0, f146_arg1)
	if IsWarzone() then
		OpenOverlay(f146_arg0, "AAR_T8_WZ", f146_arg1, "", "")
	elseif IsZombies() then
		OpenOverlay(f146_arg0, "AAR_T8_ZM", f146_arg1, "", "")
	elseif LuaUtils.IsArenaMode() then
		OpenOverlay(f146_arg0, "AAR_T8_Arena", f146_arg1, "", "")
	else
		OpenOverlay(f146_arg0, "AAR_T8_MP", f146_arg1, "", "")
	end
end
CoD.AARUtility.AARFirstTimeOpenActions = function(f147_arg0, f147_arg1, f147_arg2)
	if not CoD.AARUtility.AARFirstTimeOpen then
		CoD.AARUtility.AARFirstTimeOpen = true
		CoD.AARUtility.UpdateAARScene(f147_arg2, f147_arg1)
	end
end
CoD.AARUtility.AARStatTypeSwitch = function(f148_arg0, f148_arg1, f148_arg2, f148_arg3)
	local f148_local0 = f148_arg2:getModel()
	if f148_local0 then
		local f148_local1 = f148_local0.type:get()
		local f148_local2 = CoD.AARUtility.GetAARRootModel(f148_arg0)
		f148_local2.activeStat:set(f148_local1)
	end
end
CoD.AARUtility.SetupStatHistory = function(f149_arg0, f149_arg1)
	local f149_local0 = f149_arg0:getModel()
	if f149_local0 then
		local f149_local1 = CoD.AARUtility.GetAARSummaryStatsRootModel(f149_arg1)
		local f149_local2 = f149_local1.statRange:get()
		local f149_local3 = f149_local1.averageStat:get()
		local f149_local4 = f149_local0.statValue:get()
		local f149_local5, f149_local6 = f149_arg0:getLocalSize()
		local f149_local7 = nil
		local f149_local8 = 0
		local f149_local9 = tonumber(f149_local4)
		local f149_local10 = tonumber(f149_local3)
		if f149_local10 ~= 0 then
			f149_local8 = f149_local9 / f149_local10 * 2
		end
		f149_local7 = f149_local8 * f149_local6
		local f149_local11 = f149_local6 - 30
		if f149_local11 < f149_local7 then
			f149_local7 = f149_local11
		end
		if f149_local7 < 12 then
			f149_local7 = 12
		end
		local f149_local12 = f149_arg0.HistoryBar
		if f149_local12 then
			f149_local12:setTopBottom(1, 1, -f149_local7, 0)
		end
		f149_local0.belowAvg:set(f149_local9 < f149_local10)
		f149_local0.barFraction:set(f149_local8)
	end
end
CoD.AARUtility.AARRewardPageChanged = function(f150_arg0, f150_arg1, f150_arg2, f150_arg3)
	local f150_local0 = f150_arg2.page
	if f150_local0 then
		local f150_local1 = CoD.AARUtility.GetAARRewardsRootModel(f150_arg0)
		f150_local1.newPage:set(f150_local0)
	end
end
CoD.AARUtility.UpdateRewardListView = function(f151_arg0, f151_arg1)
	local f151_local0 = CoD.AARUtility.GetAARRewardsRootModel(f151_arg0)
	local f151_local1 = f151_local0.currentPage:get()
	local f151_local2 = f151_local0.newPage:get()
	if f151_local2 and f151_local1 and f151_local2 ~= f151_local1 then
		if f151_local1 < f151_local2 then
			f151_arg1:pageRight()
		else
			f151_arg1:pageLeft()
		end
		f151_local0.currentPage:set(f151_local2)
	end
end
CoD.AARUtility.GetPreviousGameStatForGametype = function(f152_arg0, f152_arg1, f152_arg2)
	local f152_local0, f152_local1 = CoD.AARUtility.GetStats(f152_arg0)
	if f152_local1 then
		local f152_local2 = f152_local1.PlayerStatsByGameType[Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](f152_arg1))]
		if f152_local2 then
			local f152_local3 = 9
			local f152_local4 = f152_local2.prevScores
			local f152_local5 = f152_local2.prevScoreIndex:get()
			if f152_local5 < 0 or f152_local3 < f152_local5 then
				f152_local5 = 0
			end
			local f152_local6 = f152_local4[f152_local5]
			if f152_local6.valid:get() == 1 then
				return f152_local6[f152_arg2]:get()
			end
		end
	end
	return 0
end
CoD.AARUtility.AARTierRewardAnimStartDelay = 500
CoD.AARUtility.AARTierRewardBarAnimTime = 600
CoD.AARUtility.AARTierRewardTierAdvanceToBarDelay = 800
CoD.AARUtility.AARTierRewardStaggeredUnlockTime = 125
CoD.AARUtility.AARTierRewardTierSkipAnimationDelay = 500
CoD.AARUtility.AARLootCaseMeterStartDelayMS = 500
CoD.AARUtility.AARLootCaseMeterAnimTimeMS = 600
CoD.AARUtility.AARLootCaseMeterAdvanceDelayMS = 800
CoD.AARUtility.AddTierRewardDataToTable = function(f153_arg0, f153_arg1, f153_arg2, f153_arg3, f153_arg4, f153_arg5)
	if not IsBooleanDvarSet("loot_enableBlackMarket") then
		return
	end
	local f153_local0 = CoD.BlackMarketUtility.GetTierItemsForStream(f153_arg0, f153_arg2, f153_arg2, false, true)
	for f153_local1 = 1, #f153_local0, 1 do
		local f153_local4 = f153_local0[f153_local1]
		local f153_local5 = {}
		if f153_local4.signatureWeaponInfo and f153_local4.signatureWeaponInfo.ref then
			f153_local4.weaponRef = f153_local4.signatureWeaponInfo.ref
			f153_local5.signatureWeaponInfo = f153_local4.signatureWeaponInfo
		else
			f153_local4.weaponRef = 0x0
		end
		if f153_local4.outfitIndexes then
			f153_local5 = f153_local4.outfitIndexes
		end
		local f153_local6 = function(f154_arg0)
			for f154_local3, f154_local4 in ipairs({
				@"hash_7A2E4E7EB993B95A",
				@"hash_78F8028D9C81781C",
				@"hash_4FF7352068DF6710",
				@"hash_3CB5B4C6D31CECE7",
				@"weapon_bribe",
			}) do
				if f154_local4 == f154_arg0 then
					return true
				end
			end
			return false
		end
		if f153_local6(f153_local4.itemName) then
			f153_local4.rarity = Enum[@"lootraritytype"][@"hash_63006FE890A202D9"]
		end
		f153_local5.gesture_index = f153_local4.gesture_index
		f153_local4.outfitIndexes = nil
		f153_local4.signatureWeaponInfo = nil
		f153_local4.unlocked = f153_arg4
		f153_local4.isLootCase = false
		if Dvar[@"hash_72A824A091BE059C"] then
			f153_local6 = Dvar[@"hash_72A824A091BE059C"]:get()
			if f153_local6 then
				f153_local4.rarity = tonumber(f153_local6)
			end
		end
		if not f153_arg5 or f153_local4.name and f153_local4.name ~= 0x0 then
			table.insert(f153_arg1, {
				models = f153_local4,
				properties = f153_local5,
			})
		end
	end
end
CoD.AARUtility.AddLootCaseRewardDataToTable = function(f155_arg0, f155_arg1, f155_arg2)
	table.insert(f155_arg1, {
		models = {
			name = @"hash_D004F2913090A",
			itemName = @"hash_0",
			desc = Engine[@"hash_4F9F1239CFD921FE"](@"hash_45BF036E550C7E0B"),
			category = @"hash_5B59099CB3805DEB",
			tier = f155_arg2,
			isContrabandCrate = true,
			isLootCase = true,
			itemCategory = @"case",
			primaryImage = 0x16542A61FD09C0,
			rarity = Enum[@"lootraritytype"][@"loot_rarity_type_count"],
			lootType = LuaEnum.LOOT_TYPE.CONTRABAND,
			unlocked = false,
			setComplete = false,
		},
	})
end
DataSources.AARTierRewardShowcase = ListHelper_SetupDataSource("AARTierRewardShowcase", function(f156_arg0, f156_arg1)
	local f156_local0 = {}
	local f156_local1 = Engine[@"currentsessionmode"]()
	local f156_local2 = f156_arg1.menu
	local f156_local3 = f156_local2._startTier + 1
	local f156_local4 = f156_local2._endTier
	for f156_local5 = f156_local3, f156_local4, 1 do
		CoD.AARUtility.AddTierRewardDataToTable(f156_arg0, f156_local0, f156_local5, f156_local1, false, true)
	end
	if CoD.AARUtility.LootCaseRewardUp(f156_arg0) then
		CoD.AARUtility.AddLootCaseRewardDataToTable(f156_arg0, f156_local0, f156_local4)
	end
	return f156_local0
end, true)
DataSources.AARCurrentTierRewards = ListHelper_SetupDataSource("AARCurrentTierRewards", function(f157_arg0)
	local f157_local0 = {}
	local f157_local1 = Engine[@"currentsessionmode"]()
	local f157_local2 = CoD.AARUtility.GetAARTierRewardRootModel(f157_arg0)
	local f157_local3 = f157_local2.currentTier.tier:get()
	CoD.AARUtility.AddTierRewardDataToTable(f157_arg0, f157_local0, f157_local3, f157_local1, false, false)
	if CoD.BaseUtility.IsDvarEnabled("ui_fakeTierRewards") then
	else
		return f157_local0
	end
	while #f157_local0 < 4 do
		CoD.AARUtility.AddTierRewardDataToTable(f157_arg0, f157_local0, math.random(1, math.max(1, f157_local3 - 1)), f157_local1, false, false)
	end
	f157_local0[1].models.reroll = true
end, true)
DataSources.AARPreviousTierRewards = ListHelper_SetupDataSource("AARPreviousTierRewards", function(f158_arg0)
	local f158_local0 = {}
	local f158_local1 = Engine[@"currentsessionmode"]()
	local f158_local2 = CoD.AARUtility.GetAARTierRewardRootModel(f158_arg0)
	CoD.AARUtility.AddTierRewardDataToTable(f158_arg0, f158_local0, f158_local2.previousTier.tier:get(), f158_local1, true, false)
	return f158_local0
end, true)
DataSources.AARNextTierRewards = ListHelper_SetupDataSource("AARNextTierRewards", function(f159_arg0)
	local f159_local0 = {}
	local f159_local1 = Engine[@"currentsessionmode"]()
	local f159_local2 = CoD.AARUtility.GetAARTierRewardRootModel(f159_arg0)
	CoD.AARUtility.AddTierRewardDataToTable(f159_arg0, f159_local0, f159_local2.nextTier.tier:get(), f159_local1, false, false)
	return f159_local0
end, true)
CoD.AARUtility.UnlockTierRewardShowcase = function(f160_arg0, f160_arg1)
	local f160_local0 = f160_arg1
	local f160_local1 = f160_local0:getDataSource()
	local f160_local2 = f160_local0.menu
	local f160_local3 = CoD.AARUtility.GetAARTierRewardRootModel(f160_arg0)
	local f160_local4 = f160_local3.currentTier.tier:get()
	local f160_local5 = 0
	local f160_local6 = f160_local1.getCount(f160_local0)
	for f160_local7 = 1, f160_local6, 1 do
		local f160_local10 = f160_local1.getItem(f160_arg0, f160_local0, f160_local7)
		local f160_local11 = f160_local10.tier:get()
		local f160_local12 = f160_local10.isLootCase:get()
		if f160_local11 == f160_local4 then
			f160_local5 = f160_local7
			break
		end
	end
	if f160_local5 == 0 then
		return
	end
	LUI.OverrideFunction_CallOriginalSecond(f160_local0, "close", function(element)
		if element._unlockTimer then
			element._unlockTimer:close()
			element._unlockTimer = nil
		end
	end)
	if f160_local0._unlockTimer then
		f160_local0._unlockTimer:close()
		f160_local0._unlockTimer = nil
	end
	f160_local0._unlockTimer = LUI.UITimer.newElementTimer(CoD.AARUtility.AARTierRewardStaggeredUnlockTime, false, function(f162_arg0)
		local f162_local0 = f160_local1.getCount(f160_local0)
		local f162_local1 = f160_local3.currentTier.tier:get()
		local f162_local2 = false
		if f162_local0 > 0 and f160_local5 <= f162_local0 then
			local f162_local3 = f160_local1.getItem(f160_arg0, f160_local0, f160_local5)
			local f162_local4 = f162_local3.tier:get()
			local f162_local5 = f162_local3.isLootCase:get()
			local f162_local6 = f162_local5
			if not f160_local2._hasDroppedLootCaseItem then
				local f162_local7 = f160_local2._hasLootCaseProgressBarFilled
			else
				local f162_local7 = false
			end
			if f162_local4 == f162_local1 then
				f160_local2._hasDroppedLootCaseItem = f160_local2._hasDroppedLootCaseItem or f162_local5
				f160_local0:setActiveItem(f160_local0:getItemAtPosition(1, f160_local5, true))
				f162_local3.unlocked:set(true)
				if f162_local3.setComplete:get() then
					local f162_local8 = f162_local3.setBonusImage:get()
					if f162_local8 and f162_local8 ~= 0x0 then
						local f162_local9 = LocalizeToUpperString(f162_local3.mainExtraText and f162_local3.mainExtraText:get() or 0x0)
						local f162_local10 = LocalizeToUpperString(f162_local3.category:get() and f162_local3.category:get() or 0x0)
						local f162_local11 = LocalizeToUpperString(f162_local3.setBonusName and f162_local3.setBonusName:get() or 0x0)
						if f162_local3.itemCategory:get() == @"calling_card" then
							CoD.OverlayUtility.ShowToast("LootBonusCallingCard", f162_local11, f162_local9, f162_local8, nil, nil, nil, f162_local10)
						else
							CoD.OverlayUtility.ShowToast("LootBonusStandard", f162_local11, f162_local9, f162_local8, nil, nil, nil, f162_local10)
						end
					end
				end
			else
				f162_local2 = true
			end
		end
		if f162_local0 <= f160_local5 or f162_local2 then
			f160_local0._unlockTimer:close()
			f160_local0._unlockTimer = nil
		else
			f160_local5 = f160_local5 + 1
		end
	end)
	f160_local0:addElement(f160_local0._unlockTimer)
end
CoD.AARUtility.UnlockTierRewards = function(f163_arg0, f163_arg1)
	local f163_local0 = f163_arg1
	local f163_local1 = f163_arg1.menu
	local f163_local2 = f163_local0:getDataSource()
	local f163_local3 = CoD.AARUtility.GetAARTierRewardRootModel(f163_arg0)
	local f163_local4 = 1
	LUI.OverrideFunction_CallOriginalSecond(f163_local0, "close", function(element)
		if element._unlockTimer then
			element._unlockTimer:close()
			element._unlockTimer = nil
		end
	end)
	if f163_local0._unlockTimer then
		f163_local0._unlockTimer:close()
		f163_local0._unlockTimer = nil
	end
	f163_local0._unlockTimer = LUI.UITimer.newElementTimer(CoD.AARUtility.AARTierRewardStaggeredUnlockTime, false, function(f165_arg0)
		local f165_local0 = f163_local2.getCount(f163_local0)
		if f165_local0 > 0 and f163_local4 <= f165_local0 then
			local f165_local1 = f163_local2.getItem(f163_arg0, f163_local0, f163_local4)
			f165_local1.unlocked:set(true)
			if f165_local1.itemName and f165_local1.itemName:get() == @"case" then
				f163_local1._lootCaseCurrentCount = f163_local1._lootCaseCurrentCount + 1
				f163_local3.lootCaseCount:set(f163_local1._lootCaseCurrentCount)
				if not f163_local3.lootCaseEarned:set(true) then
					Engine[@"forcenotifymodelsubscriptions"](f163_local3.lootCaseEarned)
				end
			end
		end
		if f165_local0 <= f163_local4 then
			f163_local0._unlockTimer:close()
			f163_local0._unlockTimer = nil
		else
			f163_local4 = f163_local4 + 1
		end
	end)
	f163_local0:addElement(f163_local0._unlockTimer)
end
CoD.AARUtility.AnimateTierSkips = function(f166_arg0, f166_arg1)
	local f166_local0 = CoD.AARUtility.GetAARTierRewardRootModel(f166_arg1)
	f166_local0.currentTier.triggerUnlock:set(false)
	f166_arg0._tierSkipTimer = LUI.UITimer.newElementTimer(CoD.AARUtility.AARTierRewardTierSkipAnimationDelay, true, function(f167_arg0)
		f166_arg0._hasUnlockedItems = true
		if not f166_local0.tierSkipEarned:set(true) then
			f166_local0.tierSkipEarned:forceNotifySubscriptions()
		end
		f166_local0.barCurrentTier:set(f166_arg0._currentTier)
		f166_local0.barNextTier:set(f166_arg0._currentTier + 1)
		f166_local0.highlightedTier:set(f166_arg0._currentTier)
		f166_local0.currentTier.tier:set(f166_arg0._currentTier)
		f166_local0.previousTier.tier:set(f166_arg0._currentTier - 1)
		f166_local0.nextTier.tier:set(f166_arg0._currentTier + 1)
		f166_local0.currentTier.triggerUnlock:set(true)
		CoD.AARUtility.AnimateTierBar(f166_arg0, f166_arg1)
	end)
	f166_arg0:addElement(f166_arg0._tierSkipTimer)
end
CoD.AARUtility.AdvanceTier = function(f168_arg0, f168_arg1)
	local f168_local0 = CoD.AARUtility.GetAARTierRewardRootModel(f168_arg1)
	f168_local0.currentTier.triggerUnlock:set(false)
	f168_local0.currentTier.tier:set(f168_arg0._currentTier)
	f168_local0.previousTier.tier:set(f168_arg0._currentTier - 1)
	f168_local0.nextTier.tier:set(f168_arg0._currentTier + 1)
	f168_local0.highlightedTier:set(f168_arg0._currentTier)
	f168_arg0._tierAdvanceTimer = LUI.UITimer.newElementTimer(CoD.AARUtility.AARTierRewardTierAdvanceToBarDelay, true, function(f169_arg0)
		CoD.AARUtility.AnimateTierBar(f168_arg0, f168_arg1)
	end)
	f168_arg0:addElement(f168_arg0._tierAdvanceTimer)
end
CoD.AARUtility.AnimateTierBar = function(f170_arg0, f170_arg1)
	local f170_local0 = CoD.AARUtility.GetAARTierRewardRootModel(f170_arg1)
	local f170_local1, f170_local2 = nil
	if f170_arg0._currentTier == f170_arg0._startTier then
		f170_local1 = f170_arg0._previousProgress
		if f170_arg0._startTier == f170_arg0._tierSkipStart then
			f170_local2 = f170_arg0._earnedProgress
		else
			f170_local2 = 1
		end
		f170_local0.previousBarProgress:set(f170_local1)
	elseif f170_arg0._tierSkipStart <= f170_arg0._currentTier then
		f170_local1 = 0
		f170_local2 = f170_arg0._earnedProgress
		f170_local0.previousBarProgress:set(0)
	else
		f170_local1 = 0
		f170_local2 = 1
	end
	local f170_local3 = CoD.AARUtility.AARTierRewardBarAnimTime
	local f170_local4 = 0
	if f170_arg0._barAnimTimer then
		f170_arg0._barAnimTimer:close()
		f170_arg0._barAnimTimer = nil
	end
	Engine[@"playsound"]("uin_aar_bar_fill_main")
	f170_arg0._barAnimTimer = LUI.UITimer.newElementTimer(10, false, function(f171_arg0)
		f170_local4 = f170_local4 + f171_arg0.timeElapsed
		local f171_local0 = f170_local4 / f170_local3
		f171_local0 = f171_local0 * (2 - f171_local0)
		if f170_local3 <= f170_local4 then
			f170_local0.earnedBarProgress:set(f170_local2)
			f170_arg0._barAnimTimer:close()
			Engine[@"playsound"]("uin_aar_bar_fill_tail")
			if f170_arg0._currentTier < f170_arg0._tierSkipStart then
				f170_arg0._hasUnlockedItems = true
				local f171_local1 = f170_arg0._currentTier + 1
				f170_local0.currentTier.triggerUnlock:set(true)
				f170_local0.barCurrentTier:set(f171_local1)
				f170_local0.barNextTier:set(f171_local1 + 1)
			end
			f170_arg0._currentTier = f170_arg0._currentTier + 1
			if f170_arg0._currentTier <= f170_arg0._tierSkipStart then
				f170_local0.previousBarProgress:set(0)
				f170_local0.earnedBarProgress:set(0)
				CoD.AARUtility.AdvanceTier(f170_arg0, f170_arg1)
			elseif f170_arg0._tierSkipCurrent < f170_arg0._endTier then
				f170_arg0._tierSkipCurrent = f170_arg0._tierSkipCurrent + 1
				CoD.AARUtility.AnimateTierSkips(f170_arg0, f170_arg1)
			else
				f170_local0.tierProgressFinished:set(true)
			end
		else
			f170_local0.earnedBarProgress:set(f171_local0 * (f170_local2 - f170_local1) + f170_local1)
		end
	end)
	f170_arg0:addElement(f170_arg0._barAnimTimer)
end
CoD.AARUtility.GetPreMatchLootStreamData = function(f172_arg0)
	if CoD.BaseUtility.IsDvarEnabled("ui_fakeTierSkip") then
		local f172_local0 = Engine[@"getmodelforcontroller"](f172_arg0)
		local f172_local1 = f172_local0.LootStreamProgress
		if f172_local1 and f172_local1.currentTier then
			return f172_local1.currentTier:get() - 3, 200
		end
	end
	local f172_local0 = Engine[@"getmodelforcontroller"](f172_arg0)
	local f172_local1 = f172_local0.AARPreMatch
	local f172_local2, f172_local3, f172_local4, f172_local5 = nil
	if f172_local1 and f172_local1.tiers then
		f172_local2 = f172_local1.tiers:get()
		f172_local3 = f172_local1.credits:get()
		if f172_local1.currentSeasonTiers then
			f172_local2 = f172_local1.currentSeasonTiers:get()
		end
	else
		f172_local2, f172_local3, f172_local4, f172_local5 = CoD.AARUtility.GetLootStreamData(f172_arg0)
	end
	return f172_local2, f172_local3
end
CoD.AARUtility.GetLootStreamData = function(f173_arg0)
	if CoD.BaseUtility.IsDvarEnabled("ui_fakeTierSkip") then
		local f173_local0 = Engine[@"getmodelforcontroller"](f173_arg0)
		local f173_local1 = f173_local0.LootStreamProgress
		if f173_local1 and f173_local1.currentTier then
			return f173_local1.currentTier:get(), 800, f173_local1.lootTierMax:get(), 1
		end
	end
	local f173_local0 = Engine[@"getmodelforcontroller"](f173_arg0)
	local f173_local1 = f173_local0.LootStreamProgress
	if f173_local1 and f173_local1.currentTier then
		return f173_local1.currentTier:get(), f173_local1.currentLootXP:get(), f173_local1.lootTierMax:get(), f173_local1.tierSkipsRedeemed and f173_local1.tierSkipsRedeemed:get() or 0
	end
	return 0, 0, 0, 0
end
CoD.AARUtility.GetLootCaseData = function(f174_arg0)
	local f174_local0 = Engine[@"getmodelforcontroller"](f174_arg0)
	f174_local0 = f174_local0.LootStreamProgress
	if f174_local0 then
		local f174_local1 = f174_local0.currentCaseXP and f174_local0.currentCaseXP:get() or 0
		local f174_local2 = f174_local0.caseProgress and f174_local0.caseProgress:get() or 0
		if Engine[@"isdevelopmentbuild"]() and Dvar[@"hash_7F6CA45E5DCB4A98"]:exists() then
			local f174_local3 = f174_local0.lootCaseXPMax and f174_local0.lootCaseXPMax:get() or 0
			f174_local1 = tonumber(Dvar[@"hash_7F6CA45E5DCB4A98"]:get())
			f174_local2 = f174_local1 / f174_local3
		end
		return f174_local1, f174_local2
	else
		return 0, 0
	end
end
CoD.AARUtility.GetPreMatchLootCaseData = function(f175_arg0)
	local f175_local0 = Engine[@"getmodelforcontroller"](f175_arg0)
	local f175_local1 = f175_local0.AARPreMatch
	local f175_local2 = f175_local0.LootStreamProgress
	if f175_local1 and f175_local2 then
		local f175_local3 = f175_local1.caseXP and f175_local1.caseXP:get() or 0
		local f175_local4 = f175_local2.lootCaseXPMax and f175_local2.lootCaseXPMax:get() or 0
		local f175_local5 = 0
		if f175_local4 > 0 then
			f175_local5 = f175_local3 / f175_local4
		end
		if Engine[@"isdevelopmentbuild"]() and Dvar[@"hash_7F61BE860EB8007A"]:exists() then
			f175_local3 = tonumber(Dvar[@"hash_7F61BE860EB8007A"]:get())
			f175_local5 = f175_local3 / f175_local4
		end
		return f175_local3, f175_local5
	else
		return 0, 0
	end
end
CoD.AARUtility.AdvanceLootCaseCount = function(f176_arg0, f176_arg1)
	local f176_local0 = CoD.AARUtility.GetAARTierRewardRootModel(f176_arg1)
	f176_arg0._lootCaseCurrentCount = f176_arg0._lootCaseCurrentCount + 1
	f176_local0.lootCaseCount:set(f176_arg0._lootCaseCurrentCount)
	f176_local0.lootCaseEarned:set(false)
	f176_arg0._lootCaseAdvanceTimer = LUI.UITimer.newElementTimer(CoD.AARUtility.AARLootCaseMeterAdvanceDelayMS, true, function(f177_arg0)
		CoD.AARUtility.AnimateLootCaseMeter(f176_arg0, f176_arg1)
	end)
	f176_arg0:addElement(f176_arg0._lootCaseAdvanceTimer)
end
CoD.AARUtility.AnimateLootCaseMeter = function(f178_arg0, f178_arg1)
	local f178_local0 = CoD.AARUtility.GetAARTierRewardRootModel(f178_arg1)
	local f178_local1, f178_local2 = nil
	if f178_arg0._lootCaseCurrentCount == f178_arg0._lootCaseStartCount then
		f178_local1 = f178_arg0._lootCasePreviousProgress
		if f178_arg0._lootCaseStartCount == f178_arg0._lootCaseEndCount then
			f178_local2 = f178_arg0._lootCaseEarnedProgress
		else
			f178_local2 = 1
		end
		f178_local0.previousLootCaseProgress:set(f178_local1)
	else
		f178_local1 = 0
		f178_local2 = f178_arg0._lootCaseEarnedProgress
		f178_local0.previousLootCaseProgress:set(0)
	end
	local f178_local3 = CoD.AARUtility.AARLootCaseMeterAnimTimeMS
	local f178_local4 = 0
	if f178_arg0._lootCaseMeterAnimTimer then
		f178_arg0._lootCaseMeterAnimTimer:close()
		f178_arg0._lootCaseMeterAnimTimer = nil
	end
	Engine[@"playsound"]("uin_aar_bar_fill_main")
	f178_arg0._lootCaseMeterAnimTimer = LUI.UITimer.newElementTimer(10, false, function(f179_arg0)
		f178_local4 = f178_local4 + f179_arg0.timeElapsed
		local f179_local0 = f178_local4 / f178_local3
		if f178_local3 <= f178_local4 then
			if f178_arg0._lootCaseMeterAnimTimer then
				f178_arg0._lootCaseMeterAnimTimer:close()
				f178_arg0._lootCaseMeterAnimTimer = nil
			end
			f178_local0.lootCaseProgress:set(f178_local2)
			Engine[@"playsound"]("uin_aar_bar_fill_tail")
			if f178_arg0._lootCaseCurrentCount < f178_arg0._lootCaseEndCount then
				f178_local0.lootCaseEarned:set(true)
				f178_arg0._hasLootCaseProgressBarFilled = true
				CoD.AARUtility.AdvanceLootCaseCount(f178_arg0, f178_arg1)
			else
				local f179_local1 = f178_local0:create("allAnimationsFinished")
				f179_local1:set(true)
			end
		else
			f178_local0.lootCaseProgress:set(f179_local0 * (f178_local2 - f178_local1) + f178_local1)
		end
	end)
	f178_arg0:addElement(f178_arg0._lootCaseMeterAnimTimer)
end
CoD.AARUtility.SetupRerolledRewardItemModels = function(f180_arg0, f180_arg1)
	local f180_local0 = Engine[@"getmodelforcontroller"](f180_arg0)
	local f180_local1 = f180_local0.LootStreamProgress
	if CoD.BaseUtility.IsDvarEnabled("ui_fakeTierRewards") then
		local f180_local2 = f180_local1:create("recentRerolledItem")
		f180_local2:set("298062365")
	end
	if f180_local1.recentRerolledItem then
		local f180_local2 = f180_local1.recentRerolledItem:get()
		local f180_local3 = CoDShared.Loot.GetCurrentSeason()
		if f180_local3 and f180_local3 ~= 0x0 then
			local f180_local4 = CoDShared.Loot.GetSeasonInfo(f180_local3)
			local f180_local5 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f180_arg0, f180_local2, f180_arg1)
			if f180_local5.name and f180_local5.name ~= 0x0 and f180_local5.category and f180_local5.rarity then
				local f180_local6 = CoD.BlackMarketUtility.GetItemRefs(f180_arg0, f180_local5.name, f180_local5.category, f180_local5.rarity, f180_local5.inSet, f180_local4.id, f180_local5.lootType, f180_local5.refOptic, f180_local5.itemId)
				local f180_local7 = CoD.AARUtility.GetAARTierRewardRootModel(f180_arg0)
				local f180_local8 = f180_local7:create("rerolledItem")
				for f180_local13, f180_local14 in pairs(f180_local6) do
					if type(f180_local14) ~= "table" then
						local f180_local12 = f180_local8:create(f180_local13)
						f180_local12:set(f180_local14)
					end
				end
			end
		end
	end
end
CoD.AARUtility.SetupTierRewardModels = function(f181_arg0, f181_arg1)
	local f181_local0, f181_local1 = CoD.AARUtility.GetPreMatchLootStreamData(f181_arg1)
	local f181_local2, f181_local3, f181_local4, f181_local5 = CoD.AARUtility.GetLootStreamData(f181_arg1)
	local f181_local6 = f181_local1 / f181_local4
	local f181_local7 = f181_local3 / f181_local4
	if CoD.BaseUtility.IsDvarEnabled("ui_animateAllAARTiers") then
		f181_local0 = 0
	end
	f181_arg0._hasUnlockedItems = false
	f181_arg0._hasLootCaseProgressBarFilled = false
	f181_arg0._hasDroppedLootCaseItem = false
	f181_arg0._startTier = f181_local0
	f181_arg0._currentTier = f181_local0
	f181_arg0._endTier = f181_local2
	f181_arg0._tierSkipStart = f181_local2 - f181_local5
	f181_arg0._tierSkipCurrent = f181_arg0._tierSkipStart
	f181_arg0._previousProgress = f181_local6
	f181_arg0._earnedProgress = f181_local7
	local f181_local8 = CoD.AARUtility.GetAARTierRewardRootModel(f181_arg1)
	local f181_local9 = f181_local8:create("barCurrentTier")
	f181_local9:set(f181_local0)
	f181_local9 = f181_local8:create("barNextTier")
	f181_local9:set(f181_local0 + 1)
	f181_local9 = f181_local8:create("highlightedTier")
	f181_local9:set(f181_local0)
	f181_local9 = f181_local8:create("previousBarProgress")
	f181_local9:set(f181_local6)
	f181_local9 = f181_local8:create("earnedBarProgress")
	f181_local9:set(f181_local6)
	f181_local9 = f181_local8:create("tierSkipEarned")
	f181_local9:set(false)
	f181_local9 = f181_local8:create("tierProgressFinished")
	f181_local9:set(false)
	f181_local9 = f181_local8:create("allAnimationsFinished")
	f181_local9:set(false)
	f181_local9 = CoDShared.Loot.GetLootCaseOwnedCount(f181_arg1)
	local f181_local10, f181_local11 = CoD.AARUtility.GetLootCaseData(f181_arg1)
	local f181_local12, f181_local13 = CoD.AARUtility.GetPreMatchLootCaseData(f181_arg1)
	if f181_local0 < f181_local2 then
		for f181_local17, f181_local18 in ipairs(CoD.BlackMarketUtility.GetTierItemsForStream(f181_arg1, f181_local0 + 1, f181_local2, false, true)) do
			if f181_local18.unlocked and f181_local18.itemName == @"case" then
				f181_local9 = f181_local9 - 1
			end
		end
	end
	local f181_local19 = f181_local9
	if f181_local11 < f181_local13 then
		f181_local9 = f181_local9 - 1
	end
	f181_arg0._lootCaseStartCount = f181_local9
	f181_arg0._lootCaseCurrentCount = f181_local9
	f181_arg0._lootCaseEndCount = f181_local19
	f181_arg0._lootCasePreviousProgress = f181_local13
	f181_arg0._lootCaseEarnedProgress = f181_local11
	local f181_local14 = f181_local8:create("lootCaseCount")
	f181_local14:set(f181_local9)
	f181_local14 = f181_local8:create("lootCaseProgress")
	f181_local14:set(f181_local13)
	f181_local14 = f181_local8:create("previousLootCaseProgress")
	f181_local14:set(f181_local13)
	f181_local14 = f181_local8:create("lootCaseEarned")
	f181_local14:set(false)
	f181_local14 = function(f182_arg0, f182_arg1, f182_arg2)
		local f182_local0 = f181_local8:create(f182_arg0)
		local f182_local1 = f182_local0:create("tier")
		f182_local1:set(f182_arg1)
		f182_local1 = f182_local0:create("tierRewardDatasource")
		f182_local1:set(f182_arg2)
		f182_local1 = f182_local0:create("triggerUnlock")
		f182_local1:set(false)
	end
	f181_local14("currentTier", f181_arg0._currentTier + 1, "AARCurrentTierRewards")
	f181_local14("previousTier", f181_arg0._startTier, "AARPreviousTierRewards")
	f181_local14("nextTier", f181_arg0._currentTier + 2, "AARNextTierRewards")
	local f181_local15 = f181_local8:create("showcaseDataSource")
	f181_local15:set("AARTierRewardShowcase")
	CoD.AARUtility.SetupRerolledRewardItemModels(f181_arg1, f181_local2)
	f181_arg0._unlockTimer = LUI.UITimer.newElementTimer(CoD.AARUtility.AARTierRewardAnimStartDelay, true, function(f183_arg0)
		CoD.AARUtility.AnimateTierBar(f181_arg0, f181_arg1)
	end)
	f181_arg0:addElement(f181_arg0._unlockTimer)
	f181_arg0:subscribeToModel(f181_local8.tierProgressFinished, function(model)
		if model:get() then
			f181_arg0._lootCaseDelayTimer = LUI.UITimer.newElementTimer(CoD.AARUtility.AARLootCaseMeterStartDelayMS, true, function(f185_arg0)
				if f181_arg0._lootCaseEarnedProgress == f181_arg0._lootCasePreviousProgress then
					f181_local8.allAnimationsFinished:set(true)
				else
					CoD.AARUtility.AnimateLootCaseMeter(f181_arg0, f181_arg1)
				end
			end)
			f181_arg0:addElement(f181_arg0._lootCaseDelayTimer)
		end
	end, false)
end
CoD.AARUtility.SetShowcaseInputState = function(f186_arg0, f186_arg1)
	local f186_local0 = CoD.AARUtility.GetAARTierRewardRootModel(f186_arg1)
	local f186_local1 = f186_local0.allAnimationsFinished
	if f186_local1 then
		f186_local1 = f186_local0.allAnimationsFinished:get()
	end
	if f186_local1 then
		f186_arg0.m_disableNavigation = nil
	else
		f186_arg0.m_disableNavigation = true
	end
end
CoD.AARUtility.AddHorizontalCounterToList = function(f187_arg0, f187_arg1)
	if CoD.horizontalCounter then
		f187_arg0:setHorizontalCounter(CoD.horizontalCounter)
		f187_arg0:updateCounters()
	end
end
CoD.AARUtility.IsTierColumnItemHighlighted = function(f188_arg0, f188_arg1)
	local f188_local0 = f188_arg0:getModel()
	if f188_local0 then
		local f188_local1 = CoD.AARUtility.GetAARTierRewardRootModel(f188_arg1)
		local f188_local2 = f188_local1.highlightedTier
		if f188_local2 then
			f188_local2 = f188_local1.highlightedTier:get()
		end
		local f188_local3 = f188_local0.tier
		if f188_local3 then
			f188_local3 = f188_local0.tier:get()
		end
		return f188_local2 == f188_local3
	else
		return false
	end
end
CoD.AARUtility.IsTierColumnLocked = function(f189_arg0, f189_arg1)
	local f189_local0 = f189_arg0:getModel()
	if f189_local0 then
		local f189_local1 = CoD.AARUtility.GetAARTierRewardRootModel(f189_arg1)
		local f189_local2 = f189_local1.highlightedTier
		if f189_local2 then
			f189_local2 = f189_local1.highlightedTier:get()
		end
		local f189_local3 = f189_local0.tier
		if f189_local3 then
			f189_local3 = f189_local0.tier:get()
		end
		return f189_local2 < f189_local3
	else
		return false
	end
end
CoD.AARUtility.ShouldHideTierRewardMiniStatus = function(f190_arg0, f190_arg1)
	if not IsBooleanDvarSet("loot_enableBlackMarket") or not Engine[@"sessionmode_ispubliconlinegame"]() then
		return true
	else
		return false
	end
end
CoD.AARUtility.ShouldHideAARLootCaseMeter = function(f191_arg0)
	if IsZombies() then
		return true
	elseif not IsBooleanDvarSet("loot_enable_blackjack_reserves") then
		return true
	elseif not IsBooleanDvarSet("loot_enableBlackMarket") or not Engine[@"sessionmode_ispubliconlinegame"]() then
		return true
	else
		return false
	end
end
CoD.AARUtility.IsTierRewardCharacterType = function(f192_arg0, f192_arg1)
	local f192_local0 = f192_arg0:getModel()
	if f192_local0 and f192_local0.itemCategory then
		local f192_local1 = f192_local0.itemCategory:get()
		local f192_local2
		if f192_local1 ~= @"palette" and f192_local1 ~= @"outfit_bundle" then
			f192_local2 = false
		else
			f192_local2 = true
		end
		return f192_local2
	else
		return false
	end
end
CoD.AARUtility.SetMiniProgressNextTierRewardImage = function(f193_arg0, f193_arg1, f193_arg2)
	local f193_local0 = CoD.AARUtility.GetAARTierRewardRootModel(f193_arg0)
	local f193_local1 = f193_local0:create("miniProgress")
	local f193_local2 = {}
	CoD.AARUtility.AddTierRewardDataToTable(f193_arg0, f193_local2, f193_arg2, f193_arg1, false, false)
	local f193_local3 = f193_local2[1]
	if f193_local3 and f193_local3.models then
		local f193_local4 = f193_local3.models.primaryImage
		local f193_local5 = f193_local1:create("nextTierRewardImage")
		f193_local5:set(f193_local4)
	else
		local f193_local4 = f193_local1:create("nextTierRewardImage")
		f193_local4:set(@"blacktransparent")
	end
end
CoD.AARUtility.SetupTierProgressMiniWidgetModels = function(f194_arg0, f194_arg1, f194_arg2)
	local f194_local0, f194_local1 = CoD.AARUtility.GetPreMatchLootStreamData(f194_arg2)
	local f194_local2, f194_local3, f194_local4, f194_local5 = CoD.AARUtility.GetLootStreamData(f194_arg2)
	local f194_local6 = f194_local1 / f194_local4
	local f194_local7 = f194_local3 / f194_local4
	local f194_local8 = f194_local2 + 1
	f194_arg0._startTier = f194_local0
	f194_arg0._currentTier = f194_arg0._startTier
	f194_arg0._endTier = f194_local2
	f194_arg0._previousProgress = f194_local6
	f194_arg0._earnedProgress = f194_local7
	local f194_local9 = CoD.AARUtility.GetAARTierRewardRootModel(f194_arg2)
	local f194_local10 = f194_local9:create("miniProgress")
	local f194_local11 = f194_local10:create("currentTier")
	f194_local11:set(f194_arg0._startTier)
	f194_local11 = f194_local10:create("nextTier")
	f194_local11:set(f194_arg0._startTier + 1)
	f194_local11 = f194_local10:create("currentProgress")
	f194_local11:set(f194_local6)
	CoD.AARUtility.SetMiniProgressNextTierRewardImage(f194_arg2, Engine[@"currentsessionmode"](), f194_arg0._startTier + 1)
	local f194_local12 = f194_local10:create("unlockReward")
	f194_local12:set(false)
	LUI.OverrideFunction_CallOriginalSecond(f194_arg0, "close", function(element)
		if element._itemUnlockTimer then
			element._itemUnlockTimer:close()
			element._itemUnlockTimer = nil
		end
		if element._barAnimTimer then
			element._barAnimTimer:close()
			element._barAnimTimer = nil
		end
	end)
end
CoD.AARUtility.AnimateTierProgressMiniWidget = function(f196_arg0, f196_arg1, f196_arg2)
	local f196_local0 = CoD.AARUtility.GetAARTierRewardRootModel(f196_arg2)
	local f196_local1 = f196_local0:create("miniProgress")
	local f196_local2, f196_local3 = nil
	if f196_arg0._currentTier == f196_arg0._startTier then
		f196_local2 = f196_arg0._previousProgress
		if f196_arg0._currentTier ~= f196_arg0._endTier then
			f196_local3 = 1
		else
			f196_local3 = f196_arg0._earnedProgress
		end
		f196_local1.currentProgress:set(f196_local2)
	elseif f196_arg0._currentTier == f196_arg0._endTier then
		if f196_arg0._startTier == f196_arg0._endTier then
			f196_local2 = f196_arg0._previousProgress
			f196_local3 = f196_arg0._earnedProgress
			f196_local1.currentProgress(f196_local2)
		else
			f196_local2 = 0
			f196_local3 = f196_arg0._earnedProgress
			f196_local1.currentProgress:set(0)
		end
	else
		f196_local2 = 0
		f196_local3 = 1
	end
	local f196_local4 = 1000
	local f196_local5 = 0
	local f196_local6 = Engine[@"currentsessionmode"]()
	f196_arg0._barAnimTimer = LUI.UITimer.newElementTimer(10, false, function(f197_arg0)
		f196_local5 = f196_local5 + f197_arg0.timeElapsed
		local f197_local0 = f196_local5 / f196_local4
		f197_local0 = f197_local0 * (2 - f197_local0)
		if f196_local4 <= f196_local5 then
			f196_local1:set(f196_local3)
			f196_arg0._barAnimTimer:close()
			f196_arg0._barAnimTimer = nil
			if f196_arg0._currentTier < f196_arg0._endTier then
				local f197_local1 = f196_arg0._currentTier + 1
				f196_local1.currentTier:set(f197_local1)
				f196_local1.nextTier:set(f197_local1 + 1)
			end
			f196_arg0._currentTier = f196_arg0._currentTier + 1
			if f196_arg0._currentTier <= f196_arg0._endTier then
				f196_local1.unlockReward:set(true)
				f196_arg0._itemUnlockTimer = LUI.UITimer.newElementTimer(2000, true, function(f198_arg0)
					CoD.AARUtility.SetMiniProgressNextTierRewardImage(f196_arg2, f196_local6, f196_arg0._currentTier + 1)
					f196_local1.unlockReward:set(false)
					CoD.AARUtility.AnimateTierProgressMiniWidget(f196_arg0, f196_arg1, f196_arg2)
				end)
				f196_arg0:addElement(f196_arg0._itemUnlockTimer)
			end
		else
			f196_local1.currentProgress:set(f197_local0 * (f196_local3 - f196_local2) + f196_local2)
		end
	end)
	f196_arg0:addElement(f196_arg0._barAnimTimer)
end
CoD.AARUtility.GetUnlockedWarzoneCharacters = function(f199_arg0)
	local f199_local0 = {}
	local f199_local1, f199_local2 = CoD.AARUtility.GetStats(f199_arg0)
	if f199_local2 then
		local f199_local3 = f199_local2[@"characters"]
		if f199_local3 then
			f199_local3 = f199_local2[@"characters"].__keys
		end
		for f199_local7, f199_local8 in ipairs(f199_local3) do
			if f199_local2[@"characters"][f199_local8][@"unlocked"]:get() == 1 then
				table.insert(f199_local0, f199_local8)
			end
		end
	end
	return f199_local0
end
CoD.AARUtility.GetUnlockedWZTagRewards = function(f200_arg0)
	local f200_local0 = {}
	local f200_local1, f200_local2 = CoD.AARUtility.GetStats(f200_arg0)
	if f200_local1 and f200_local2 then
		local f200_local3 = f200_local1[@"unlockedtags"]
		local f200_local4 = f200_local2[@"unlockedtags"]
		local f200_local5 = f200_local2[@"unlockedtags"].__keys
		local f200_local6 = Engine[@"hash_2B2E4CCC119597B0"]()
		for f200_local16, f200_local17 in ipairs(f200_local5) do
			if f200_local3[f200_local17] then
				if f200_local3[f200_local17]:get() == 0 and f200_local4[f200_local17]:get() == 1 then
					local f200_local10 = nil
					for f200_local14, f200_local15 in ipairs(f200_local6) do
						if f200_local15[@"assetname"] == f200_local17 then
							f200_local10 = f200_local15
							break
						end
					end
					if f200_local10 then
						table.insert(f200_local0, {
							models = {
								mainTitle = f200_local10[@"unlocktitle"],
								levelText = Engine[@"hash_4F9F1239CFD921FE"](@"hash_47FC454B26C88374"),
								mainIcon = f200_local10[@"unlockicon"],
								rewardType = CoD.AARUtility.AARRewardType.SPECIAL_EVENT,
								reward1Icon = f200_local10[@"icon"],
								reward1Title = f200_local10[@"title"],
								tierProgress = 1,
								tierMax = 1,
								tierProgressText = "",
								isTiered = false,
							},
						})
					end
				end
			end
		end
	end
	return f200_local0
end
CoD.AARUtility.GetRecentlyUnlockedWarzoneCharacters = function(f201_arg0)
	local f201_local0 = {}
	local f201_local1, f201_local2 = CoD.AARUtility.GetStats(f201_arg0)
	if f201_local1 and f201_local2 then
		for f201_local6, f201_local7 in ipairs(f201_local2[@"characters"].__keys) do
			if f201_local1[@"characters"][f201_local7][@"unlocked"]:get() == 0 and f201_local2[@"characters"][f201_local7][@"unlocked"]:get() == 1 then
				table.insert(f201_local0, f201_local7)
			end
		end
	end
	return f201_local0
end
CoD.AARUtility.GetUnlockableItemInfoFromCharacterIndex = function(f202_arg0, f202_arg1)
	local f202_local0 = Engine[@"getpositionrolebundleinfo"](f202_arg0, f202_arg1)
	return Engine[@"getunlockableinfobyindex"](Engine[@"hash_2D97229B24C685D5"](f202_local0[@"unlockableitementry"], f202_arg0), f202_arg0)
end
CoD.AARUtility.WarzoneUnlockedCharacterFocusChanged = function(f203_arg0, f203_arg1, f203_arg2)
	local f203_local0 = f203_arg1:getModel()
	if f203_local0 then
		local f203_local1 = CoD.SafeGetModelValue(f203_local0, "characterIndex")
		local f203_local2 = CoD.SafeGetModelValue(f203_local0, "outfitIndex")
		if f203_local1 and f203_local2 then
			SendCustomClientScriptMenuStateChangeNotify(f203_arg2, f203_arg0.menuName, true, f203_local1 .. ";" .. f203_local2)
		end
	end
end
CoD.AARUtility.SetupMissionRewardModels = function(f204_arg0, f204_arg1)
	local f204_local0 = CoD.AARUtility.GetAARMissionRewardRootModel(f204_arg1)
	local f204_local1, f204_local2 = CoD.AARUtility.GetStats(f204_arg1)
	if f204_local2 then
		local f204_local3 = f204_local2.PlayerStatsList.RANK.StatValue:get()
		local f204_local4 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f204_arg1, f204_local3, Engine[@"getrankinfo"](f204_local3))
		local f204_local5 = f204_local0:create("rank")
		f204_local5:set(f204_local4.level)
		f204_local5 = f204_local0:create("rankIcon")
		f204_local5:set(f204_local4.iconLarge)
	end
end
CoD.AARUtility.SetMeritModelsFromRankInfo = function(f205_arg0, f205_arg1, f205_arg2, f205_arg3, f205_arg4)
	local f205_local0 = CoD.AARUtility.GetAARMeritReportRootModel(f205_arg0)
	if f205_arg1 then
		local f205_local1
		if f205_arg3 ~= nil then
			f205_local1 = Engine[@"getrankicon"](f205_arg1.level, f205_arg3, Enum[@"emodes"][@"mode_warzone"])
			if not f205_local1 then
			else
				if f205_local1 == 0x0 then
					f205_local1 = f205_arg1.iconLarge
				end
				local f205_local2
				if f205_arg3 ~= nil then
					f205_local2 = Engine[@"hash_11F63E4E0932DCCF"](f205_arg1.level, f205_arg3, Enum[@"emodes"][@"mode_warzone"])
					if not f205_local2 then
					else
						if f205_local2 == 0x0 then
							f205_local2 = f205_arg1.iconLarge
						end
						local f205_local3 = f205_local0:create("echelon")
						f205_local3:set(f205_local2)
						f205_local3 = f205_local0:create("rankIcon")
						f205_local3:set(f205_local1)
						f205_local3 = CoD.WZUtility.GetWZLevel(f205_arg1.level)
						local f205_local4 = f205_local0:create("rankLabel")
						f205_local4:set(f205_local3)
						f205_local4 = f205_local0:create("rank")
						f205_local4:set(f205_arg1.level)
					end
				end
				f205_local2 = Engine[@"hash_7E1B786B1A765D9E"](f205_arg1.level)
			end
		end
		f205_local1 = Engine[@"hash_D4A9B159BE44163"](f205_arg1.level)
	end
	if f205_arg2 then
		local f205_local1
		if f205_arg3 ~= nil then
			f205_local1 = Engine[@"getrankicon"](f205_arg2.level, f205_arg3, Enum[@"emodes"][@"mode_warzone"])
			if not f205_local1 then
			else
				if f205_local1 == 0x0 then
					f205_local1 = f205_arg2.iconLarge
				end
				local f205_local2 = f205_local0:create("nextRankIcon")
				f205_local2:set(f205_local1)
				f205_local2 = CoD.WZUtility.GetWZLevel(f205_arg2.level)
				local f205_local3 = f205_local0:create("nextRankLabel")
				f205_local3:set(f205_local2)
				f205_local3 = f205_local0:create("nextRank")
				f205_local3:set(f205_arg2.level)
			end
		end
		f205_local1 = Engine[@"hash_D4A9B159BE44163"](f205_arg2.level)
	else
		local f205_local1 = f205_local0:create("nextRankIcon")
		f205_local1:set(@"blacktransparent")
		f205_local1 = f205_local0:create("nextRankLabel")
		f205_local1:set("")
	end
	if f205_arg4 then
		Engine[@"forcenotifymodelsubscriptions"](f205_local0:create("showRank"))
	end
end
CoD.AARUtility.SetupInGameMeritModels = function(f206_arg0, f206_arg1)
	local f206_local0 = {
		"firstInGameEntry",
		"secondInGameEntry",
		"thirdInGameEntry",
		"fourthInGameEntry",
		"fifthInGameEntry",
	}
	local f206_local1 = false
	local f206_local2 = 1
	if not f206_arg0[f206_local0[1]] then
		for f206_local3 = 1, #f206_local0, 1 do
			local f206_local6 = f206_arg0:create(f206_local0[f206_local3])
			f206_local6:create("value")
			f206_local6 = f206_arg0:create(f206_local0[f206_local3])
			f206_local6:create("label")
		end
	end
	for f206_local8, f206_local6 in ipairs(f206_arg1) do
		local f206_local9 = f206_local6[1]
		local f206_local10 = f206_local6[2]
		if f206_local9 > 0 then
			local f206_local7 = f206_arg0:create(f206_local0[f206_local2])
			f206_local7 = f206_local7:create("value")
			f206_local7:set(f206_local9)
			f206_local7 = f206_arg0:create(f206_local0[f206_local2])
			f206_local7 = f206_local7:create("label")
			f206_local7:set(f206_local10)
			f206_local2 = f206_local2 + 1
		end
	end
	for f206_local3 = f206_local2, 4, 1 do
		f206_local6 = f206_arg0:create(f206_local0[f206_local3])
		f206_local6 = f206_local6:create("value")
		f206_local6:set(0)
		f206_local6 = f206_arg0:create(f206_local0[f206_local3])
		f206_local6 = f206_local6:create("label")
		f206_local6:set("")
	end
	f206_local3 = f206_arg0:create("numInGameEntries")
	f206_local3:set(f206_local2 - 1)
end
CoD.AARUtility.SetupMeritRewardModels = function(f207_arg0, f207_arg1, f207_arg2)
	local f207_local0 = 1
	local f207_local1 = 1
	local f207_local2 = 0
	local f207_local3 = 0
	local f207_local4 = 0
	local f207_local5 = 0
	local f207_local6 = 0
	local f207_local7 = 0
	local f207_local8 = 0
	local f207_local9 = 0
	local f207_local10 = CoD.AARUtility.GetCurrentGametype(f207_arg1)
	if not f207_local10 then
		f207_local10 = Engine[@"hash_36F8027A8BC75673"]()
	end
	local f207_local11 = Engine[@"hash_7D492E0385F6D3E4"](Engine[@"converttoxhash"](f207_local10))
	f207_arg0._finalMerit = 0
	f207_arg0._kills = 0
	f207_arg0._currentPrestige = 0
	f207_arg0._killMerits = 0
	f207_arg0._placementMerits = 0
	f207_arg0._winMerits = 0
	f207_arg0._challengeMerits = 0
	f207_arg0._medalMerits = 0
	f207_arg0._paintCans = 0
	local f207_local12 = false
	if IsDemoPlaying() then
		return
	end
	local f207_local13, f207_local14 = CoD.AARUtility.GetStats(f207_arg1)
	if CoD.AARUtility.UseTestData() and not f207_local13 then
		f207_local13 = f207_local14
	end
	if f207_local13 and f207_local14 then
		f207_arg0._currentPrestige = f207_local14.PlayerStatsList.PLEVEL.StatValue:get()
		f207_local12 = IsInParagonCapableGameMode() and f207_arg0._currentPrestige == CoD.PrestigeUtility.GetPrestigeCap()
		if f207_local12 then
			f207_local0 = f207_local13.PlayerStatsList.PARAGON_RANK.StatValue:get()
			f207_local2 = f207_local13.PlayerStatsList.PARAGON_RANKXP.StatValue:get()
			f207_local1 = f207_local14.PlayerStatsList.PARAGON_RANK.StatValue:get()
			f207_local3 = f207_local14.PlayerStatsList.PARAGON_RANKXP.StatValue:get()
		else
			f207_local0 = f207_local13.PlayerStatsList.RANK.StatValue:get()
			f207_local2 = f207_local13.PlayerStatsList.RANKXP.StatValue:get()
			f207_local1 = f207_local14.PlayerStatsList.RANK.StatValue:get()
			f207_local3 = f207_local14.PlayerStatsList.RANKXP.StatValue:get()
		end
		f207_arg0._finalMerit = f207_local3 - f207_local2
		if f207_local13.PlayerStatsByGameType[f207_local11] and f207_local14.PlayerStatsByGameType[f207_local11] then
			f207_arg0._kills = f207_local14.PlayerStatsByGameType[f207_local11].KILLS.StatValue:get() - f207_local13.PlayerStatsByGameType[f207_local11].KILLS.StatValue:get()
			f207_local4 = f207_local13.PlayerStatsByGameType[f207_local11].WINS.StatValue:get()
			f207_local5 = f207_local14.PlayerStatsByGameType[f207_local11].WINS.StatValue:get()
			f207_local8 = f207_local13.PlayerStatsByGameType[f207_local11].ITEMS_PAINT_CANS_COLLECTED.StatValue:get()
			f207_local9 = f207_local14.PlayerStatsByGameType[f207_local11].ITEMS_PAINT_CANS_COLLECTED.StatValue:get()
		else
			DebugPrint("^1LUI: ^2gametype missing from WZGametypes in wz_progression.ddl [" .. f207_local11 .. "]")
		end
		f207_arg0._killMerits = f207_local14.PlayerStatsList.KILLXP.statValue:get() - f207_local13.PlayerStatsList.KILLXP.statValue:get()
		f207_arg0._placementMerits = f207_local14.PlayerStatsList.PLACEMENTXP.statValue:get() - f207_local13.PlayerStatsList.PLACEMENTXP.statValue:get()
		f207_arg0._winMerits = f207_local14.PlayerStatsList.WINXP.statValue:get() - f207_local13.PlayerStatsList.WINXP.statValue:get()
		f207_arg0._challengeMerits = f207_local14.PlayerStatsList.CHALLENGEXP.StatValue:get() - f207_local13.PlayerStatsList.CHALLENGEXP.StatValue:get()
		f207_arg0._contractMerits = f207_local14.PlayerStatsList.CONTRACTXP.StatValue:get() - f207_local13.PlayerStatsList.CONTRACTXP.StatValue:get()
		f207_arg0._medalMerits = f207_local14.PlayerStatsList.MEDALXP.StatValue:get() - f207_local13.PlayerStatsList.MEDALXP.StatValue:get()
	end
	f207_arg0._startRank = f207_local0 + 1
	f207_arg0._endRank = f207_local1 + 1
	f207_arg0._currentRank = f207_arg0._startRank
	f207_arg0._startRankXp = f207_local2
	f207_arg0._endRankXp = f207_local3
	f207_arg0._paintCans = f207_local9 - f207_local8
	local f207_local15 = Engine[@"getrankinfo"](f207_local0)
	local f207_local16 = Engine[@"getrankinfo"](f207_local0 + 1)
	if f207_local12 then
		f207_local15 = CoD.AARUtility.GetParagonRankInfo(f207_local0, f207_arg0._currentPrestige)
		f207_local16 = CoD.AARUtility.GetParagonRankInfo(f207_local0 + 1, f207_arg0._currentPrestige)
	end
	if f207_arg2 then
		f207_local15 = Engine[@"getrankinfo"](f207_local1)
		f207_local16 = Engine[@"getrankinfo"](f207_local1 + 1)
	end
	CoD.AARUtility.SetMeritModelsFromRankInfo(f207_arg1, f207_local15, f207_local16, f207_arg0._currentPrestige)
	local f207_local17 = 0
	local f207_local18 = 0
	if f207_local14 then
		f207_local17 = f207_local14.AfterActionReportStats.placement_team:get()
		if f207_local17 == 1 then
			f207_local18 = f207_arg0._winMerits
			f207_arg0._challengeCoin = Engine[@"hash_2450462A7BEA79E5"](f207_local5)
			f207_arg0._winValue = f207_arg0._winMerits
		end
	end
	local f207_local19 = nil
	if f207_arg0._placementMerits > 0 then
		local f207_local20 = function(f208_arg0)
			local f208_local0 = {
				5,
				10,
				15,
				20,
				25,
				30,
				50,
				60,
				75,
			}
			local f208_local1 = Engine[@"getxpscale"](f207_arg1)
			for f208_local5, f208_local6 in ipairs(f208_local0) do
				if Engine[@"getgametypesetting"]("wzMeritTop" .. f208_local6) * f208_local1 == f208_arg0 then
					return f208_local6
				end
			end
		end
		f207_local19 = Engine[@"hash_4F9F1239CFD921FE"](@"aar/top_x", f207_local20(f207_arg0._placementMerits))
	else
		f207_local19 = Engine[@"hash_4F9F1239CFD921FE"](0x6503D553D4D6C3)
	end
	f207_arg0._finalOutcome = f207_arg0._placementMerits
	local f207_local21 = 0
	if f207_arg0._placementMerits > 0 then
		f207_local21 = f207_arg0._placementMerits
	end
	local f207_local20 = LocalizeStringWithParameter(@"ui/warzone_placement", tostring(f207_local17))
	if f207_local17 == 0 then
		f207_local20 = "--"
	end
	local f207_local22 = CoD.AARUtility.GetAARMeritReportRootModel(f207_arg1)
	local f207_local23 = f207_local22:create("placement")
	f207_local23:set(f207_local20)
	f207_local23 = f207_local22:create("topLabel")
	local f207_local24 = f207_local23
	f207_local23 = f207_local23.set
	local f207_local25 = tostring
	local f207_local26 = f207_arg0._kills
	if not f207_local26 then
		f207_local26 = 0
	end
	f207_local23(f207_local24, f207_local25(f207_local26))
	f207_local23 = f207_local22:create("middleLabel")
	f207_local23:set(f207_local19)
	f207_local23 = f207_local22:create("bottomLabel")
	f207_local23:set(@"aar/challenges")
	f207_local23 = f207_local22:create("bottomValue")
	f207_local24 = f207_local23
	f207_local23 = f207_local23.set
	f207_local25 = f207_arg0._challengeMerits
	if not f207_local25 then
		f207_local25 = 0
	end
	f207_local23(f207_local24, f207_local25)
	f207_local23 = f207_local22:create("winLabel")
	f207_local23:set(@"aar/win")
	f207_local23 = f207_local22:create("challengeCoinImage")
	f207_local23:set(@"blacktransparent")
	f207_local23 = f207_local22:create("paintCans")
	f207_local23:set(f207_arg0._paintCans)
	f207_local22:create("showRank")
	f207_local22:create("showRankDone")
	if f207_arg2 then
		f207_local23, f207_local24 = CoD.AARUtility.GetMinMaxXPForRank(f207_arg0._endRank - 1)
		f207_local25 = (f207_arg0._startRankXp - f207_local23) / math.max(1, f207_local24 - f207_local23)
		f207_local26 = (f207_arg0._endRankXp - f207_local23) / math.max(1, f207_local24 - f207_local23)
		local f207_local27 = CoD.AARUtility.GetXPEarnedDuringMatch(f207_arg0._endRankXp, f207_arg0._startRankXp)
		local f207_local28 = f207_local24 - f207_arg0._endRankXp
		local f207_local29 = f207_local22:create("previousXpProgress")
		f207_local29:set(f207_local25)
		f207_local29 = f207_local22:create("earnedXpProgress")
		f207_local29:set(f207_local26)
		f207_local29 = f207_local22:create("xpEarnedDuringMatch")
		f207_local29:set(f207_local27)
		f207_local29 = f207_local22:create("xpNeededForLevelUp")
		f207_local29:set(f207_local28)
		if f207_arg0._kills > 0 then
			f207_local29 = f207_local22:create("topValue")
			f207_local29:set(f207_arg0._killMerits)
		else
			f207_local29 = f207_local22:create("topValue")
			f207_local29:set(0)
		end
		f207_local29 = f207_local22:create("middleValue")
		f207_local29:set(f207_local21)
		f207_local29 = f207_local22:create("winValue")
		f207_local29:set(f207_local18)
		f207_local29 = f207_local22:create("totalMerit")
		f207_local29:set(f207_arg0._finalMerit)
		if f207_arg0._challengeCoin then
			f207_local29 = f207_local22:create("challengeCoinImage")
			f207_local29:set(f207_arg0._challengeCoin)
		end
	else
		f207_local23 = f207_local22:create("topValue")
		f207_local23:set(0)
		f207_local23 = f207_local22:create("middleValue")
		f207_local23:set(f207_local21)
		f207_local23 = f207_local22:create("winValue")
		f207_local23:set(f207_local18)
		f207_local23 = f207_local22:create("totalMerit")
		f207_local23:set(0)
		f207_local23, f207_local24 = CoD.AARUtility.GetMinMaxXPForRank(f207_arg0._startRank - 1)
		f207_local25 = (f207_arg0._startRankXp - f207_local23) / math.max(1, f207_local24 - f207_local23)
		f207_local26 = (f207_arg0._endRankXp - f207_local23) / math.max(1, f207_local24 - f207_local23)
		if 1 <= f207_local26 then
			f207_local26 = f207_local25
		end
		local f207_local27 = CoD.AARUtility.GetXPEarnedDuringMatch(f207_arg0._endRankXp, f207_arg0._startRankXp)
		local f207_local28 = f207_local24 - f207_arg0._startRankXp
		local f207_local29 = f207_local22:create("previousXpProgress")
		f207_local29:set(f207_local25)
		f207_local29 = f207_local22:create("earnedXpProgress")
		f207_local29:set(f207_local26)
		f207_local29 = f207_local22:create("xpEarnedDuringMatch")
		f207_local29:set(f207_local27)
		f207_local29 = f207_local22:create("xpNeededForLevelUp")
		f207_local29:set(f207_local28)
	end
	f207_local23 = nil
	if f207_arg0._kills == 1 then
		f207_local23 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3729C0F7D61A14FA", f207_local22.topLabel:get())
	else
		f207_local23 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_56076E20CE50E4CB", f207_local22.topLabel:get())
	end
	f207_local24 = CoD.AARUtility.SetupInGameMeritModels
	f207_local25 = f207_local22
	f207_local26 = {}
	local f207_local27 = {}
	local f207_local28 = f207_arg0._killMerits
	if not f207_local28 then
		f207_local28 = 0
	end
	local f207_local29 = f207_local23
	f207_local27[1] = f207_local28
	f207_local27[2] = f207_local29
	f207_local28 = {}
	f207_local29 = f207_arg0._placementMerits
	if not f207_local29 then
		f207_local29 = 0
	end
	local f207_local30 = f207_local22.middleLabel:get()
	f207_local28 = f207_local29
	f207_local29 = {}
	f207_local30 = f207_arg0._winMerits
	if not f207_local30 then
		f207_local30 = 0
	end
	local f207_local31 = Engine[@"hash_4F9F1239CFD921FE"](@"aar/win")
	f207_local29 = f207_local30
	f207_local30 = {}
	f207_local31 = f207_arg0._challengeMerits
	if not f207_local31 then
		f207_local31 = 0
	end
	local f207_local32 = f207_arg0._contractMerits
	if not f207_local32 then
		f207_local32 = 0
	end
	f207_local31 = f207_local31 + f207_local32
	f207_local32 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_33360B742151B00C")
	f207_local30 = f207_local31
	f207_local31 = {}
	f207_local32 = f207_arg0._medalMerits
	if not f207_local32 then
		f207_local32 = 0
	end
	local f207_local33 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_8F69F5BDD4F7C26")
	f207_local31 = f207_local32
	f207_local26[1] = f207_local27
	f207_local26[2] = f207_local28
	f207_local26[3] = f207_local29
	f207_local26[4] = f207_local30
	f207_local26[5] = f207_local31
	f207_local24(f207_local25, f207_local26)
end
CoD.AARUtility.SetupAnimateMeritRankUp = function(f209_arg0, f209_arg1)
	LUI.OverrideFunction_CallOriginalSecond(f209_arg0, "close", function(element)
		if element._meritRankUpIntroTimer then
			element._meritRankUpIntroTimer:close()
			element._meritRankUpIntroTimer = nil
		end
		if element._meritRankUpTimer then
			element._meritRankUpTimer:close()
			element._meritRankUpTimer = nil
		end
	end)
end
CoD.AARUtility.DelayAndOpenMeritMedal = function(f211_arg0, f211_arg1, f211_arg2)
	if not f211_arg0:hasClip("MedalIntro") then
		return
	elseif f211_arg0._meritRankUpIntroTimer then
		f211_arg0._meritRankUpIntroTimer:close()
		f211_arg0._meritRankUpIntroTimer = nil
	end
	f211_arg0._meritRankUpIntroTimer = LUI.UITimer.newElementTimer(f211_arg2 * 1000, true, function()
		f211_arg0:playClip("MedalIntro")
	end)
	f211_arg0:addElement(f211_arg0._meritRankUpIntroTimer)
end
CoD.AARUtility.DelayAndCloseMeritMedal = function(f213_arg0, f213_arg1, f213_arg2)
	if not f213_arg0:hasClip("MedalOutro") then
		return
	elseif f213_arg0._meritRankUpTimer then
		f213_arg0._meritRankUpTimer:close()
		f213_arg0._meritRankUpTimer = nil
	end
	f213_arg0._meritRankUpTimer = LUI.UITimer.newElementTimer(f213_arg2 * 1000, true, function()
		f213_arg0:playClip("MedalOutro")
	end)
	f213_arg0:addElement(f213_arg0._meritRankUpTimer)
end
CoD.AARUtility.AnimateMeritReportNumbersAfter = function(f215_arg0, f215_arg1, f215_arg2)
	f215_arg0:addElement(LUI.UITimer.newElementTimer(f215_arg2, true, CoD.AARUtility.AnimateMeritReportNumbers, f215_arg0, f215_arg1))
end
CoD.AARUtility.AnimateMeritReportNumbers = function(f216_arg0, f216_arg1)
	local f216_local0 = 1000
	local f216_local1 = 0
	local f216_local2 = f216_arg0._killMerits
	local f216_local3 = f216_arg0._finalMerit or 0
	local f216_local4 = f216_local2
	local f216_local5 = f216_arg0._finalOutcome
	local f216_local6 = f216_arg0._winValue or 0
	local f216_local7 = f216_local5 > 0
	local f216_local8 = f216_local6 > 0
	local f216_local9 = CoD.AARUtility.GetAARMeritReportRootModel(f216_arg1)
	f216_arg0:addElement(LUI.UITimer.newElementTimer(1000, true, function()
		Engine[@"playsound"]("uin_aar_bar_fill_main")
		f216_arg0._numAnimTimer = LUI.UITimer.newElementTimer(10, false, function(f218_arg0)
			f216_local1 = f216_local1 + f218_arg0.timeElapsed
			local f218_local0 = f216_local1 / f216_local0
			f218_local0 = f218_local0 * (2 - f218_local0)
			if f216_local0 <= f216_local1 then
				local f218_local1
				if f216_local4 > 0 then
					f218_local1 = f216_local4
					if not f218_local1 then
					else
						f216_local9.totalMerit:set(f216_local3)
						f216_local9.topValue:set(f218_local1)
						if f216_local7 then
							f216_local9.middleValue:set(f216_local5)
						end
						if f216_local8 then
							f216_local9.winValue:set(f216_local6)
						end
						f216_arg0._numAnimTimer:close()
						Engine[@"playsound"]("uin_aar_bar_fill_tail")
					end
				end
				f218_local1 = 0
			else
				local f218_local1
				if f216_local4 > 0 then
					f218_local1 = math.floor(f218_local0 * f216_local4)
					if not f218_local1 then
					else
						f216_local9.totalMerit:set(math.floor(f218_local0 * f216_local3))
						f216_local9.topValue:set(f218_local1)
						if f216_local7 then
							f216_local9.middleValue:set(math.floor(f218_local0 * f216_local5))
						end
						if f216_local8 then
							f216_local9.winValue:set(math.floor(f218_local0 * f216_local6))
						end
					end
				end
				f218_local1 = 0
			end
		end)
		f216_arg0:addElement(f216_arg0._numAnimTimer)
		CoD.AARUtility.AnimateMeritBar(f216_arg0, f216_arg1)
	end))
end
CoD.AARUtility.AnimateMeritBar = function(f219_arg0, f219_arg1)
	local f219_local0 = CoD.AARUtility.GetAARMeritReportRootModel(f219_arg1)
	local f219_local1, f219_local2, f219_local3, f219_local4 = nil
	if f219_arg0._currentRank == f219_arg0._startRank then
		local f219_local5, f219_local6 = CoD.AARUtility.GetMinMaxXPForRank(f219_arg0._currentRank - 1)
		f219_local1 = (f219_arg0._startRankXp - f219_local5) / math.max(1, f219_local6 - f219_local5)
		f219_local2 = 1
		f219_local3 = f219_local6 - f219_arg0._startRankXp
		f219_local4 = math.max(f219_local6 - f219_arg0._endRankXp, 0)
		f219_local0.previousXpProgress:set(f219_local1)
		f219_local0.xpNeededForLevelUp:set(f219_local3)
	else
		local f219_local5, f219_local6 = CoD.AARUtility.GetMinMaxXPForRank(f219_arg0._currentRank - 1)
		f219_local1 = 0
		f219_local2 = 1
		f219_local3 = f219_local6 - f219_local5
		f219_local4 = 0
		f219_local0.previousXpProgress:set(0)
		f219_local0.xpNeededForLevelUp:set(f219_local3)
	end
	if f219_arg0._currentRank == f219_arg0._endRank then
		local f219_local5, f219_local6 = CoD.AARUtility.GetMinMaxXPForRank(f219_arg0._currentRank - 1)
		f219_local2 = (f219_arg0._endRankXp - f219_local5) / math.max(1, f219_local6 - f219_local5)
		f219_local4 = f219_local6 - f219_arg0._endRankXp
	end
	local f219_local5 = 1000
	local f219_local6 = 0
	f219_arg0._barAnimTimer = LUI.UITimer.newElementTimer(10, false, function(f220_arg0)
		f219_local6 = f219_local6 + f220_arg0.timeElapsed
		local f220_local0 = f219_local6 / f219_local5
		f220_local0 = f220_local0 * (2 - f220_local0)
		if f219_local5 <= f219_local6 then
			f219_local0.earnedXpProgress:set(f219_local2)
			f219_local0.xpNeededForLevelUp:set(f219_local4)
			f219_arg0._barAnimTimer:close()
			if f219_arg0._currentRank < f219_arg0._endRank then
				CoD.AARUtility.SetMeritModelsFromRankInfo(f219_arg1, Engine[@"getrankinfo"](f219_arg0._currentRank), Engine[@"getrankinfo"](f219_arg0._currentRank + 1), f219_arg0._currentPrestige, not f219_arg0._hasShownRank)
				if not f219_arg0._hasShownRank then
					f219_arg0._hasShownRank = true
				end
			end
			f219_arg0._currentRank = f219_arg0._currentRank + 1
			if f219_arg0._currentRank <= f219_arg0._endRank then
				Engine[@"playsound"]("mpl_promotion", f219_arg1)
				CoD.AARUtility.AnimateMeritBar(f219_arg0, f219_arg1)
			else
				if f219_arg0._challengeCoin then
					f219_local0.challengeCoinImage:set(f219_arg0._challengeCoin)
				end
				if f219_arg0._hasShownRank then
					Engine[@"forcenotifymodelsubscriptions"](f219_local0.showRankDone)
				end
			end
		else
			f219_local0.earnedXpProgress:set(f220_local0 * (f219_local2 - f219_local1) + f219_local1)
			f219_local0.xpNeededForLevelUp:set(math.floor(f220_local0 * (f219_local4 - f219_local3) + f219_local3))
		end
	end)
	f219_arg0:addElement(f219_arg0._barAnimTimer)
end
DataSources.AARSquadStats = ListHelper_SetupDataSource("AARSquadStats", function(f221_arg0)
	local f221_local0 = {}
	local f221_local1, f221_local2 = CoD.AARUtility.GetStats(f221_arg0)
	if f221_local2 then
		local f221_local3 = CoD.AARUtility.GetPreviousGameStatForGametype(f221_arg0, CoD.AARUtility.GetCurrentGametype(f221_arg0), "placement_team") > 0
		local f221_local4 = Engine[@"getgamertagforcontroller"](f221_arg0)
		local f221_local5 = f221_local2.AfterActionReportStats
		if f221_local5 then
			for f221_local6 = 0, 3, 1 do
				local f221_local9 = f221_local5.teammates[f221_local6]
				if f221_local9 then
					local f221_local10 = f221_local9.rank:get()
					local f221_local11 = Engine[@"getrankinfo"](f221_local10)
					local f221_local12 = f221_local9.pLevel:get()
					if IsInParagonCapableGameMode() and f221_local12 == CoD.PrestigeUtility.GetPrestigeCap() then
						f221_local11 = CoD.AARUtility.GetParagonRankInfo(f221_local10, f221_local12)
					end
					local f221_local13 = f221_local9.name:get()
					if f221_local13 and f221_local13 ~= "" then
						local f221_local14 = table.insert
						local f221_local15 = f221_local0
						local f221_local16 = {}
						local f221_local17 = {}
						local f221_local18
						if f221_local9.died:get() ~= 0 or f221_local3 or f221_local13 == f221_local4 then
							f221_local18 = false
						else
							f221_local18 = true
						end
						f221_local17.stillAlive = f221_local18
						f221_local17.isSelf = f221_local13 == f221_local4
						f221_local17.playerName = f221_local13
						f221_local17.echelon = f221_local11.level
						f221_local17.echelonIcon = f221_local11.iconLarge or @"blacktransparent"
						f221_local17.kills = f221_local9.kills:get()
						f221_local17.finishes = f221_local9.kills_eliminated:get()
						f221_local17.longestKill = f221_local9.longest_distance_kill:get()
						f221_local17.damage = f221_local9.total_damage:get()
						f221_local17.revives = f221_local9.revives:get()
						f221_local17.cleanUps = f221_local9.downs_eliminated:get() + f221_local9.downs_eliminated_team:get() + f221_local9.kills_eliminated:get()
						f221_local17.unfinishedDrops = f221_local9.downs:get()
						f221_local17.score = f221_local9.score:get()
						f221_local16.models = f221_local17
						f221_local14(f221_local15, f221_local16)
					end
				end
			end
		end
	end
	return f221_local0
end)
CoD.AARUtility.LevelUpScreenAnimTime = 5000
CoD.AARUtility.LevelUpScreenCloseDelay = 5000
CoD.AARUtility.SetLevelUpModelsFromRankInfo = function(f222_arg0, f222_arg1, f222_arg2)
	local f222_local0 = CoD.AARUtility.GetAARLevelUpRootModel(f222_arg0)
	local f222_local1 = f222_local0:create("rank")
	f222_local1:set(f222_arg1.level)
	f222_local1 = f222_local0:create("rankName")
	f222_local1:set(f222_arg1.fullNameRef)
	f222_local1 = f222_local0:create("rankLabel")
	f222_local1:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2BC1D826D76D607F", f222_arg1.level))
	f222_local1 = f222_local0:create("rankIcon")
	f222_local1:set(f222_arg1.iconLarge)
	f222_local1 = 0x0
	local f222_local2 = 0x0
	local f222_local3 = 0x0
	local f222_local4 = CoD.AARUtility.AARRewardType.PLAYER
	local f222_local5 = CoD.AARUtility.GetPlayerRewards(f222_arg0)
	local f222_local6 = false
	local f222_local7 = nil
	for f222_local12, f222_local13 in pairs(f222_local5) do
		if f222_local13.models.level == f222_arg1.level then
			local f222_local11 = f222_local13.models.rewardType
			if f222_local11 == CoD.AARUtility.AARRewardType.CLASS then
				f222_local7 = f222_local13
				break
			elseif f222_local11 == CoD.AARUtility.AARRewardType.PLAYER then
				f222_local7 = f222_local13
				f222_local6 = true
			end
			if not f222_local6 then
				f222_local7 = f222_local13
			end
		end
	end
	if f222_local7 then
		f222_local1 = f222_local7.models.reward1Title
		f222_local2 = f222_local7.models.reward1Icon
		f222_local3 = f222_local7.models.reward1Desc
		f222_local4 = f222_local7.models.rewardType
	end
	f222_local8 = f222_local0:create("rewardName")
	f222_local8:set(f222_local1)
	f222_local8 = f222_local0:create("rewardDesc")
	f222_local8:set(f222_local3)
	f222_local8 = f222_local0:create("rewardImage")
	f222_local8:set(f222_local2)
	f222_local8 = f222_local0:create("rewardType")
	f222_local8:set(f222_local4)
	if f222_arg2 then
		f222_local8 = f222_local0:create("nextRank")
		f222_local8:set(f222_arg2.level)
		f222_local8 = f222_local0:create("nextRankIcon")
		f222_local8:set(f222_arg2.iconLarge)
	else
		f222_local8 = f222_local0:create("nextRank")
		f222_local8:set(0)
		f222_local8 = f222_local0:create("nextRankIcon")
		f222_local8:set(@"blacktransparent")
	end
end
CoD.AARUtility.GetParagonRankInfo = function(f223_arg0, f223_arg1)
	return {
		level = f223_arg0 + 1,
		fullNameRef = @"hash_0",
		iconLarge = Engine[@"hash_2FC100C7712C1987"](f223_arg1, Engine[@"currentsessionmode"]()),
	}
end
CoD.AARUtility.SetupLevelUpModels = function(f224_arg0, f224_arg1)
	local f224_local0, f224_local1 = CoD.AARUtility.GetStats(f224_arg1)
	if CoD.AARUtility.UseTestData() and not f224_local0 then
		f224_local0 = f224_local1
	end
	local f224_local2 = f224_local0.PlayerStatsList.RANK.StatValue:get()
	local f224_local3 = f224_local0.PlayerStatsList.RANKXP.StatValue:get()
	local f224_local4 = f224_local1.PlayerStatsList.RANK.StatValue:get()
	local f224_local5 = f224_local1.PlayerStatsList.RANKXP.StatValue:get()
	local f224_local6 = f224_local1.PlayerStatsList.PLEVEL.StatValue:get()
	local f224_local7 = IsInParagonCapableGameMode()
	if f224_local7 then
		f224_local7 = f224_local6 == CoD.PrestigeUtility.GetPrestigeCap()
	end
	local f224_local8 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f224_arg1, f224_local2, Engine[@"getrankinfo"](f224_local2))
	local f224_local9 = f224_local2 + 1
	local f224_local10 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f224_arg1, f224_local9, Engine[@"getrankinfo"](f224_local9))
	if f224_local7 then
		f224_local8 = CoD.AARUtility.GetParagonRankInfo(f224_local2, f224_local6)
		f224_local10 = CoD.AARUtility.GetParagonRankInfo(f224_local9, f224_local6)
	end
	CoD.AARUtility.SetLevelUpModelsFromRankInfo(f224_arg1, f224_local8, f224_local10)
	local f224_local11 = CoD.AARUtility.GetAARLevelUpRootModel(f224_arg1)
	local f224_local12 = CoD.AARUtility.GetXPEarnedDuringMatch(f224_local5, f224_local3)
	local f224_local13 = f224_local11:create("xpEarnedDuringMatch")
	f224_local13:set(f224_local12)
	f224_arg0._isParagonRank = f224_local7
	f224_arg0._currentPrestige = f224_local6
	f224_arg0._startRank = f224_local2 + 1
	f224_arg0._endRank = f224_local4 + 1
	f224_arg0._currentRank = f224_arg0._startRank
	f224_arg0._startRankXp = f224_local3
	f224_arg0._endRankXp = f224_local5
	f224_arg0._rankAnimTime = CoD.AARUtility.LevelUpScreenAnimTime / (f224_local4 - f224_local2 + 1)
	f224_local13 = f224_local11:create("startRank")
	f224_local13:set(f224_arg0._startRank)
	local f224_local13, f224_local14 = CoD.AARUtility.GetMinMaxXPForRank(f224_arg0._startRank - 1)
	if f224_local7 then
		f224_local13, f224_local14 = CoD.AARUtility.GetMinMaxXPForParagonRank(f224_arg0._currentRank - 1)
	end
	local f224_local15 = (f224_arg0._startRankXp - f224_local13) / math.max(1, f224_local14 - f224_local13)
	local f224_local16 = (f224_arg0._endRankXp - f224_local13) / math.max(1, f224_local14 - f224_local13)
	if f224_local16 >= 1 then
		f224_local16 = f224_local15
	end
	local f224_local17 = f224_local11:create("previousXpProgress")
	f224_local17:set(f224_local15)
	f224_local17 = f224_local11:create("earnedXpProgress")
	f224_local17:set(f224_local16)
end
CoD.AARUtility.RankUp = function(f225_arg0, f225_arg1)
	local f225_local0 = f225_arg0._currentRank
	local f225_local1 = f225_local0 + 1
	local f225_local2 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f225_arg1, f225_local0, Engine[@"getrankinfo"](f225_local0))
	local f225_local3 = CoD.AARUtility.UpdateRankInfoIconsForPrestige(f225_arg1, f225_local1, Engine[@"getrankinfo"](f225_local1))
	if f225_arg0._isParagonRank then
		f225_local2 = CoD.AARUtility.GetParagonRankInfo(f225_local0, f225_arg0._currentPrestige)
		f225_local3 = CoD.AARUtility.GetParagonRankInfo(f225_local1, f225_arg0._currentPrestige)
	end
	CoD.AARUtility.SetLevelUpModelsFromRankInfo(f225_arg1, f225_local2, f225_local3)
end
CoD.AARUtility.AnimateRankXpBar = function(f226_arg0, f226_arg1)
	local f226_local0 = CoD.AARUtility.GetAARLevelUpRootModel(f226_arg1)
	local f226_local1, f226_local2, f226_local3, f226_local4 = nil
	if f226_arg0._currentRank == f226_arg0._startRank then
		local f226_local5, f226_local6 = CoD.AARUtility.GetMinMaxXPForRank(f226_arg0._currentRank - 1)
		if f226_arg0._isParagonRank then
			f226_local5, f226_local6 = CoD.AARUtility.GetMinMaxXPForParagonRank(f226_arg0._currentRank - 1)
		end
		f226_local1 = (f226_arg0._startRankXp - f226_local5) / math.max(1, f226_local6 - f226_local5)
		f226_local2 = 1
		f226_local0.previousXpProgress:set(f226_local1)
	else
		local f226_local5, f226_local6 = CoD.AARUtility.GetMinMaxXPForRank(f226_arg0._currentRank - 1)
		if f226_arg0._isParagonRank then
			f226_local5, f226_local6 = CoD.AARUtility.GetMinMaxXPForParagonRank(f226_arg0._currentRank - 1)
		end
		f226_local1 = 0
		f226_local2 = 1
		f226_local0.previousXpProgress:set(0)
	end
	if f226_arg0._currentRank == f226_arg0._endRank then
		local f226_local5, f226_local6 = CoD.AARUtility.GetMinMaxXPForRank(f226_arg0._currentRank - 1)
		if f226_arg0._isParagonRank then
			f226_local5, f226_local6 = CoD.AARUtility.GetMinMaxXPForParagonRank(f226_arg0._currentRank - 1)
		end
		f226_local2 = (f226_arg0._endRankXp - f226_local5) / math.max(1, f226_local6 - f226_local5)
	end
	local f226_local5 = f226_arg0._rankAnimTime
	local f226_local6 = 0
	f226_arg0._barAnimTimer = LUI.UITimer.newElementTimer(10, false, function(f227_arg0)
		f226_local6 = f226_local6 + f227_arg0.timeElapsed
		local f227_local0 = f226_local6 / f226_local5
		f227_local0 = f227_local0 * (2 - f227_local0)
		if f226_local5 <= f226_local6 then
			f226_local0.earnedXpProgress:set(f226_local2)
			f226_arg0._barAnimTimer:close()
			if f226_arg0._currentRank < f226_arg0._endRank then
				CoD.AARUtility.RankUp(f226_arg0, f226_arg1)
			end
			f226_arg0._currentRank = f226_arg0._currentRank + 1
			if f226_arg0._currentRank <= f226_arg0._endRank then
				CoD.AARUtility.AnimateRankXpBar(f226_arg0, f226_arg1)
			end
			Engine[@"playsound"]("mpl_promotion", f226_arg1)
		else
			f226_local0.earnedXpProgress:set(f227_local0 * (f226_local2 - f226_local1) + f226_local1)
		end
	end)
	f226_arg0:addElement(f226_arg0._barAnimTimer)
end
CoD.AARUtility.TierRewardUp = function(f228_arg0)
	if not Engine[@"sessionmode_ispubliconlinegame"]() or not IsBooleanDvarSet("loot_enableBlackMarket") then
		return false
	elseif CoD.BaseUtility.IsDvarEnabled("ui_alwaysShowAAROverlays") then
		return true
	elseif CoD.AARUtility.LootCaseRewardUp(f228_arg0) then
		return true
	else
		local f228_local0, f228_local1 = CoD.AARUtility.GetPreMatchLootStreamData(f228_arg0)
		local f228_local2, f228_local3, f228_local4, f228_local5 = CoD.AARUtility.GetLootStreamData(f228_arg0)
		return f228_local0 < f228_local2
	end
end
CoD.AARUtility.LootCaseRewardUp = function(f229_arg0)
	local f229_local0, f229_local1 = CoD.AARUtility.GetLootCaseData(f229_arg0)
	local f229_local2, f229_local3 = CoD.AARUtility.GetPreMatchLootCaseData(f229_arg0)
	return f229_local0 < f229_local2
end
CoD.AARUtility.CloseLevelUpOverlay = function(f230_arg0, f230_arg1)
	if CoD.ArenaLeaguePlayUtility.ShowPlacementMatchesPopup(f230_arg1) then
		GoBackAndOpenOverlayOnParent(f230_arg0, "AAR_LeaguePlay_PlacementMatchesProgress", f230_arg1)
	elseif CoD.ArenaLeaguePlayUtility.ShowArenaPlacement(f230_arg1) then
		CoD.ArenaLeaguePlayUtility.DLogSkillDivision(f230_arg1)
		GoBackAndOpenOverlayOnParent(f230_arg0, "LeaguePlayIntroLadderResults", f230_arg1, nil)
	elseif CoD.ArenaLeaguePlayUtility.ShouldShowLeaguePlayLadderResults(f230_arg1) then
		GoBackAndOpenOverlayOnParent(f230_arg0, "LeaguePlayLadderResults", f230_arg1)
	elseif IsKoreaProgressionSpecialEventActive(f230_arg1) then
		GoBackAndOpenOverlayOnParent(f230_arg0, "PC_Korea_Event_AAR_Menu", f230_arg1)
	elseif CoD.AARUtility.TierRewardUp(f230_arg1) then
		GoBackAndOpenOverlayOnParent(f230_arg0, "AARTierReward", f230_arg1)
	elseif CoD.AARUtility.PlayerEarnedRewards(f230_arg1) then
		GoBackAndOpenOverlayOnParent(f230_arg0, "AARRewardOverlay", f230_arg1)
	else
		GoBack(f230_arg0, f230_arg1)
	end
end
CoD.AARUtility.ClosePlacementMatchesProgressOverlay = function(f231_arg0, f231_arg1)
	if IsKoreaProgressionSpecialEventActive(f231_arg1) then
		GoBackAndOpenOverlayOnParent(f231_arg0, "PC_Korea_Event_AAR_Menu", f231_arg1)
	elseif CoD.AARUtility.TierRewardUp(f231_arg1) then
		GoBackAndOpenOverlayOnParent(f231_arg0, "AARTierReward", f231_arg1)
	elseif CoD.AARUtility.PlayerEarnedRewards(f231_arg1) then
		GoBackAndOpenOverlayOnParent(f231_arg0, "AARRewardOverlay", f231_arg1)
	else
		GoBack(f231_arg0, f231_arg1)
	end
end
CoD.AARUtility.CloseArenaLeaguePlayPlacementOverlay = function(f232_arg0, f232_arg1)
	GoBackAndOpenOverlayOnParent(f232_arg0, "LeaguePlayLadderResults", f232_arg1)
end
CoD.AARUtility.CloseArenaLeaguePlayLadderOverlay = function(f233_arg0, f233_arg1)
	if IsKoreaProgressionSpecialEventActive(f233_arg1) then
		GoBackAndOpenOverlayOnParent(f233_arg0, "PC_Korea_Event_AAR_Menu", f233_arg1)
	elseif CoD.AARUtility.TierRewardUp(f233_arg1) then
		GoBackAndOpenOverlayOnParent(f233_arg0, "AARTierReward", f233_arg1)
	elseif CoD.AARUtility.PlayerEarnedRewards(f233_arg1) then
		GoBackAndOpenOverlayOnParent(f233_arg0, "AARRewardOverlay", f233_arg1)
	else
		GoBack(f233_arg0, f233_arg1)
	end
end
CoD.AARUtility.CloseIGRKoreaEventOverlay = function(f234_arg0, f234_arg1)
	if CoD.AARUtility.TierRewardUp(f234_arg1) then
		GoBackAndOpenOverlayOnParent(f234_arg0, "AARTierReward", f234_arg1)
	elseif CoD.AARUtility.PlayerEarnedRewards(f234_arg1) then
		GoBackAndOpenOverlayOnParent(f234_arg0, "AARRewardOverlay", f234_arg1)
	else
		GoBack(f234_arg0, f234_arg1)
	end
end
CoD.AARUtility.CloseTierRewardOverlay = function(f235_arg0, f235_arg1)
	local f235_local0 = CoD.AARUtility.PlayerEarnedRewards(f235_arg1)
	if IsMultiplayer() and f235_local0 then
		GoBackAndOpenOverlayOnParent(f235_arg0, "AARRewardOverlay", f235_arg1)
	elseif IsWarzone() and CoD.AARUtility.MissionRewardUnlocked(f235_arg0, f235_arg1) then
		GoBackAndOpenOverlayOnParent(f235_arg0, "AARMissionRewardOverlay", f235_arg1)
	elseif IsWarzone() and f235_local0 then
		GoBackAndOpenOverlayOnParent(f235_arg0, "AARRewardOverlay_WZ", f235_arg1)
	else
		GoBack(f235_arg0, f235_arg1)
	end
end
CoD.AARUtility.MissionRewardUnlocked = function(f236_arg0, f236_arg1)
	if CoD.BaseUtility.IsDvarEnabled("ui_debugWZCharUnlock") then
		return true
	else
		return #Engine[@"getrecentlyunlockeditems"](f236_arg1) + #CoD.AARUtility.GetRecentlyUnlockedWarzoneCharacters(f236_arg1) > 0
	end
end
CoD.AARUtility.CloseMeritReportOverlay = function(f237_arg0, f237_arg1)
	if IsKoreaProgressionSpecialEventActive(f237_arg1) then
		GoBackAndOpenOverlayOnParent(f237_arg0, "PC_Korea_Event_AAR_Menu", f237_arg1)
	elseif CoD.AARUtility.TierRewardUp(f237_arg1) then
		GoBackAndOpenOverlayOnParent(f237_arg0, "AARTierReward", f237_arg1)
	elseif CoD.AARUtility.MissionRewardUnlocked(f237_arg0, f237_arg1) then
		SendCustomClientScriptMenuStateChangeNotify(f237_arg1, "AARMissionRewardOverlay", true, 1)
		GoBackAndOpenOverlayOnParent(f237_arg0, "AARMissionRewardOverlay", f237_arg1)
	elseif CoD.AARUtility.PlayerEarnedRewards(f237_arg1) then
		GoBackAndOpenOverlayOnParent(f237_arg0, "AARRewardOverlay_WZ", f237_arg1)
	else
		GoBack(f237_arg0, f237_arg1)
	end
end
CoD.AARUtility.CloseMissionRewardOverlay = function(f238_arg0, f238_arg1)
	SendCustomClientScriptMenuStateChangeNotify(f238_arg1, f238_arg0.menuName, false, 1)
	if CoD.AARUtility.PlayerEarnedRewards(f238_arg1) then
		GoBackAndOpenOverlayOnParent(f238_arg0, "AARRewardOverlay_WZ", f238_arg1)
	else
		GoBack(f238_arg0, f238_arg1)
	end
end
CoD.AARUtility.ProcessAAROverlays_ZM = function(f239_arg0, f239_arg1)
	if IsBooleanDvarSet(@"hash_11DA02CA40639DE5") and CoD.ZombiesCallingsUtility.ShowFactionCallingFullscreen(f239_arg1) then
		f239_arg0.factionCallingFullscreenOverlay = OpenOverlay(f239_arg0, "AAR_FactionCalling", f239_arg1, nil)
	else
		CoD.AARUtility.ProcessAAROverlays(f239_arg0, f239_arg1)
	end
end
CoD.AARUtility.ProcessAAROverlays = function(f240_arg0, f240_arg1)
	local f240_local0 = function()
		if CoD.AARUtility.UseTestData() then
			return true
		else
			local f241_local0, f241_local1 = CoD.AARUtility.GetStats(f240_arg1)
			if not f241_local0 or not f241_local1 then
				return false
			elseif LuaUtils.IsArenaMode() then
				return false
			else
				return f241_local0.PlayerStatsList.RANK.StatValue:get() < f241_local1.PlayerStatsList.RANK.StatValue:get()
			end
		end
	end
	local f240_local1 = function()
		local f242_local0, f242_local1 = CoD.AARUtility.GetStats(f240_arg1)
		if not f242_local0 or not f242_local1 then
			return false
		elseif LuaUtils.IsArenaMode() then
			return false
		end
		local f242_local2 = f242_local0.PlayerStatsList.RANK.StatValue:get()
		local f242_local3 = f242_local1.PlayerStatsList.RANK.StatValue:get()
		local f242_local4 = CoD.RankUtility.GetRankCap()
		local f242_local5
		if f242_local2 ~= f242_local4 or f242_local3 ~= f242_local4 + 1 then
			f242_local5 = false
		else
			f242_local5 = true
		end
		return f242_local5
	end
	f240_local1 = f240_local1()
	if f240_local0() or f240_local1 then
		if not f240_arg0._levelUp then
			local f240_local2
			if f240_local1 then
				f240_local2 = "AARPrestigeMasterOverlay"
				if not f240_local2 then
				else
					local f240_local3 = OpenOverlay(f240_arg0, f240_local2, f240_arg1, nil)
					f240_arg0._levelUp = f240_local3
					local f240_local4 = function()
						CoD.AARUtility.CloseLevelUpOverlay(f240_local3, f240_arg1)
					end
					if f240_arg0._closeTimer then
						f240_arg0._closeTimer:close()
						f240_arg0._closeTimer = nil
					end
					if not f240_local1 then
						f240_arg0._closeTimer = LUI.UITimer.newElementTimer(CoD.AARUtility.LevelUpScreenAnimTime + CoD.AARUtility.LevelUpScreenCloseDelay, true, f240_local4)
						f240_local3:addElement(f240_arg0._closeTimer)
					end
				end
			end
			f240_local2 = "AARLevelUpOverlay"
		end
	elseif CoD.ArenaLeaguePlayUtility.ShowPlacementMatchesPopup(f240_arg1) then
		if not f240_arg0._placementMatchesOverlay then
			f240_arg0._placementMatchesOverlay = OpenOverlay(f240_arg0, "AAR_LeaguePlay_PlacementMatchesProgress", f240_arg1, nil)
		end
	elseif CoD.ArenaLeaguePlayUtility.ShowArenaPlacement(f240_arg1) then
		if not f240_arg0._ladderPlacementOverlay then
			local f240_local2 = nil
			CoD.ArenaLeaguePlayUtility.DLogSkillDivision(f240_arg1)
			f240_arg0._ladderPlacementOverlay = OpenOverlay(f240_arg0, "LeaguePlayIntroLadderResults", f240_arg1, nil)
		end
	elseif CoD.ArenaLeaguePlayUtility.ShouldShowLeaguePlayLadderResults(f240_arg1) then
		if not f240_arg0._ladderOverlay then
			f240_arg0._ladderOverlay = OpenOverlay(f240_arg0, "LeaguePlayLadderResults", f240_arg1, nil)
		end
	elseif IsKoreaProgressionSpecialEventActive(f240_arg1) then
		if not f240_arg0._koreaEvent then
			f240_arg0._koreaEvent = OpenOverlay(f240_arg0, "PC_Korea_Event_AAR_Menu", f240_arg1, nil)
		end
	elseif CoD.AARUtility.TierRewardUp(f240_arg1) then
		if not f240_arg0._tierReward then
			f240_arg0._tierReward = OpenOverlay(f240_arg0, "AARTierReward", f240_arg1, nil)
		end
	elseif CoD.AARUtility.PlayerEarnedRewards(f240_arg1) and not f240_arg0._rewardsOverlay then
		f240_arg0._rewardsOverlay = OpenOverlay(f240_arg0, "AARRewardOverlay", f240_arg1, nil)
	end
end
CoD.AARUtility.ProcessAAROverlays_WZ = function(f244_arg0, f244_arg1)
	local f244_local0 = function(f245_arg0)
		local f245_local0 = Engine[@"getmodelforcontroller"](f245_arg0)
		if f245_local0.seenWZInGameAAR and f245_local0.seenWZInGameAAR:get() == true then
			local f245_local1 = false
		else
			local f245_local1 = true
		end
		Engine[@"unsubscribeandfreemodel"](f245_local0.seenWZInGameAAR)
		CoD.AARUtility.SetupMeritRewardModels(f244_arg0, f245_arg0, false)
		local f245_local2 = CoD.AARUtility.GetAARMeritReportRootModel(f245_arg0)
		if f245_local2.numInGameEntries:get() == 0 then
			local f245_local1 = false
		end
		return f245_local1
	end
	local f244_local1 = function()
		local f246_local0, f246_local1 = CoD.AARUtility.GetStats(f244_arg1)
		if not f246_local0 or not f246_local1 then
			return false
		end
		local f246_local2 = f246_local0.PlayerStatsList.PLEVEL.StatValue:get()
		local f246_local3 = f246_local0.PlayerStatsList.RANK.StatValue:get()
		local f246_local4 = f246_local1.PlayerStatsList.PLEVEL.StatValue:get()
		local f246_local5 = f246_local1.PlayerStatsList.RANK.StatValue:get()
		local f246_local6 = CoD.RankUtility.GetRankCap()
		local f246_local7
		if f246_local4 ~= Engine[@"getprestigecap"](Enum[@"emodes"][@"mode_warzone"]) or f246_local3 ~= f246_local6 - 1 or f246_local5 ~= f246_local6 then
			f246_local7 = false
		else
			f246_local7 = true
		end
		return f246_local7
	end
	if f244_local0(f244_arg1) then
		if not f244_arg0._meritOverlay then
			f244_arg0._meritOverlay = OpenOverlay(f244_arg0, "AARMeritReportOverlay", f244_arg1, nil)
		end
	elseif IsKoreaProgressionSpecialEventActive(f244_arg1) then
		OpenOverlay(f244_arg0, "PC_Korea_Event_AAR_Menu", f244_arg1)
	elseif CoD.AARUtility.TierRewardUp(f244_arg1) then
		OpenOverlay(f244_arg0, "AARTierReward", f244_arg1)
	elseif CoD.AARUtility.MissionRewardUnlocked(f244_arg0, f244_arg1) then
		SendCustomClientScriptMenuStateChangeNotify(f244_arg1, "AARMissionRewardOverlay", true, 1)
		OpenOverlay(f244_arg0, "AARMissionRewardOverlay", f244_arg1)
	elseif CoD.AARUtility.PlayerEarnedRewards(f244_arg1) then
		OpenOverlay(f244_arg0, "AARRewardOverlay_WZ", f244_arg1)
	end
	if f244_local1() and not f244_arg0._levelUp then
		f244_arg0._levelUp = OpenOverlay(f244_arg0, "AARPrestigeMasterOverlay", f244_arg1, nil)
	end
end
CoD.AARUtility.OpenAAROverlays = function(f247_arg0, f247_arg1)
	local f247_local0 = CoD.AARUtility.GetAARRootModel(f247_arg1)
	local f247_local1 = f247_local0.viewedOverlays
	if not (f247_local1 and f247_local1:get() == true) then
		if IsWarzone() then
			CoD.AARUtility.ProcessAAROverlays_WZ(f247_arg0, f247_arg1)
		elseif IsZombies() then
			CoD.AARUtility.ProcessAAROverlays_ZM(f247_arg0, f247_arg1)
		else
			CoD.AARUtility.ProcessAAROverlays(f247_arg0, f247_arg1)
		end
	end
	if CoD.BaseUtility.IsDvarEnabled("ui_alwaysShowAAROverlays") then
		return
	elseif not f247_local1 then
		local f247_local2 = f247_local0:create("viewedOverlays")
		f247_local2:set(true)
	else
		f247_local1:set(true)
	end
end
CoD.AARUtility.IsCurrentRankStartingRank = function(f248_arg0, f248_arg1)
	local f248_local0 = false
	local f248_local1 = f248_arg0:getModel()
	if f248_local1 then
		local f248_local2 = f248_local1.rank
		if f248_local2 then
			f248_local2 = f248_local1.rank:get()
		end
		local f248_local3 = f248_local1.startRank
		if f248_local3 then
			f248_local3 = f248_local1.startRank:get()
		end
		f248_local0 = f248_local2 == f248_local3
	end
	return f248_local0
end
CoD.AARUtility.MaxRankReached = function(f249_arg0)
	local f249_local0 = CoD.RankUtility.GetRankCap()
	local f249_local1, f249_local2 = CoD.AARUtility.GetStats(f249_arg0)
	if f249_local1 and f249_local2 then
		local f249_local3 = f249_local1.PlayerStatsList.RANK.StatValue:get()
		local f249_local4 = f249_local2.PlayerStatsList.RANK.StatValue:get()
		if f249_local3 < f249_local4 and f249_local0 <= f249_local4 then
			return true
		end
	end
	return false
end
CoD.AARUtility.SetupLadderModels = function(f250_arg0)
	local f250_local0 = CoD.AARUtility.GetAARLadderRootModel(f250_arg0)
	if CoD.ArenaUtility.IsArenaLeaguePlay() then
		local f250_local1 = Engine[@"hash_541E446B5AC646FF"](f250_arg0, CoD.ArenaUtility.GetArenaSlotFromPlaylistOrEngine())
		local f250_local2 = f250_local0:create("points")
		f250_local2:set(f250_local1.points)
		f250_local2 = f250_local0:create("bonus")
		f250_local2:set(f250_local1.bonusPoints)
	end
end
CoD.OverlayUtility.AddSystemOverlay("AAR_LeaguePlayDivPlacement", {
	menuName = "SystemOverlay_Compact",
	frameWidget = "CoD.systemOverlay_DivisionPlacement",
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	title = function(f251_arg0)
		local f251_local0 = DataSources.LeaguePlayLadder.getModel(f251_arg0)
		if f251_local0 and f251_local0.leagueNameCode and f251_local0.leagueNameCode:get() then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A833716CBB8F05A")
		else
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_127999393F1681")
		end
	end,
	description = function(f252_arg0)
		local f252_local0 = DataSources.LeaguePlayLadder.getModel(f252_arg0)
		if f252_local0 and f252_local0.leagueNameCode then
			local f252_local1 = f252_local0.leagueNameCode:get()
			if f252_local1 then
				return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5153472CCACFCAB9", ToUpper(CoD.ArenaLeaguePlayUtility.ConvertLadderNameCode(f252_local1)))
			end
		end
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F1557B5BE871E8E")
	end,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f253_arg0)
		return function(f254_arg0, f254_arg1)
			CoD.AARUtility.CloseArenaLeaguePlayPlacementOverlay(f254_arg0, f254_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = @"menu/continue",
	[CoD.OverlayUtility.ContinuePropertyName] = function(f255_arg0, f255_arg1, f255_arg2, f255_arg3)
		return function(f256_arg0, f256_arg1)
			CoD.AARUtility.CloseArenaLeaguePlayPlacementOverlay(f256_arg0, f256_arg1)
		end
	end,
})
