CoD.GameEndScoreUtility = {}
CoD.GameEndScoreUtility.MaxTeamPoseClients = 6
CoD.GameEndScoreUtility.ShowOutcomeTransition = function(f1_arg0)
	if Engine.IsVisibilityBitSet(f1_arg0, Enum.UIVisibilityBit[@"bit_in_killcam"]) or Engine.IsVisibilityBitSet(f1_arg0, Enum.UIVisibilityBit[@"bit_final_killcam"]) or Engine.IsVisibilityBitSet(f1_arg0, Enum.UIVisibilityBit[@"bit_play_of_the_match"]) or Engine.IsVisibilityBitSet(f1_arg0, Enum.UIVisibilityBit[@"bit_scoreboard_open"]) then
		return false
	else
		local f1_local0 = Engine.GetModelForController(f1_arg0)
		return f1_local0.gameScore.currentState:get() == "outcome"
	end
end
CoD.GameEndScoreUtility.ShowOutcomeTransitionTransparent = function(f2_arg0)
	if Engine.IsVisibilityBitSet(f2_arg0, Enum.UIVisibilityBit[@"bit_in_killcam"]) or Engine.IsVisibilityBitSet(f2_arg0, Enum.UIVisibilityBit[@"bit_final_killcam"]) or Engine.IsVisibilityBitSet(f2_arg0, Enum.UIVisibilityBit[@"bit_play_of_the_match"]) or Engine.IsVisibilityBitSet(f2_arg0, Enum.UIVisibilityBit[@"bit_scoreboard_open"]) then
		return false
	else
		local f2_local0 = Engine.GetModelForController(f2_arg0)
		return f2_local0.gameScore.currentState:get() == "outcome_transparent"
	end
end
CoD.GameEndScoreUtility.ShowOutcomeWithScoreTransition = function(f3_arg0)
	if Engine.IsVisibilityBitSet(f3_arg0, Enum.UIVisibilityBit[@"bit_in_killcam"]) or Engine.IsVisibilityBitSet(f3_arg0, Enum.UIVisibilityBit[@"bit_final_killcam"]) or Engine.IsVisibilityBitSet(f3_arg0, Enum.UIVisibilityBit[@"bit_play_of_the_match"]) or Engine.IsVisibilityBitSet(f3_arg0, Enum.UIVisibilityBit[@"bit_scoreboard_open"]) then
		return false
	end
	local f3_local0 = Engine.GetModelForController(f3_arg0)
	f3_local0 = f3_local0.forceScoreboard:get() == 1
	local f3_local1 = Engine.GetModelForController(f3_arg0)
	if f3_local1.gameScore.currentState:get() == "outcome_with_score" then
		f3_local1 = not f3_local0
	else
		f3_local1 = false
	end
	return f3_local1
end
CoD.GameEndScoreUtility.ShowOutcomeWithTimeTransition = function(f4_arg0)
	if Engine.IsVisibilityBitSet(f4_arg0, Enum.UIVisibilityBit[@"bit_in_killcam"]) or Engine.IsVisibilityBitSet(f4_arg0, Enum.UIVisibilityBit[@"bit_final_killcam"]) or Engine.IsVisibilityBitSet(f4_arg0, Enum.UIVisibilityBit[@"bit_play_of_the_match"]) or Engine.IsVisibilityBitSet(f4_arg0, Enum.UIVisibilityBit[@"bit_scoreboard_open"]) then
		return false
	end
	local f4_local0 = Engine.GetModelForController(f4_arg0)
	f4_local0 = f4_local0.forceScoreboard:get() == 1
	local f4_local1 = Engine.GetModelForController(f4_arg0)
	if f4_local1.gameScore.currentState:get() == "outcome_with_time" then
		f4_local1 = not f4_local0
	else
		f4_local1 = false
	end
	return f4_local1
end
CoD.GameEndScoreUtility.ShowOutcomeWithScoreOrTimeTransition = function(f5_arg0)
	if Engine.IsVisibilityBitSet(f5_arg0, Enum.UIVisibilityBit[@"bit_in_killcam"]) or Engine.IsVisibilityBitSet(f5_arg0, Enum.UIVisibilityBit[@"bit_final_killcam"]) or Engine.IsVisibilityBitSet(f5_arg0, Enum.UIVisibilityBit[@"bit_play_of_the_match"]) or Engine.IsVisibilityBitSet(f5_arg0, Enum.UIVisibilityBit[@"bit_scoreboard_open"]) then
		return false
	end
	local f5_local0 = Engine.GetModelForController(f5_arg0)
	f5_local0 = f5_local0.forceScoreboard:get() == 1
	local f5_local1 = Engine.GetModelForController(f5_arg0)
	if f5_local1.gameScore.currentState:get() ~= "outcome_with_score" then
		f5_local1 = Engine.GetModelForController(f5_arg0)
		if f5_local1.gameScore.currentState:get() == "outcome_with_time" then
			f5_local1 = not f5_local0
		end
		f5_local1 = false
	end
	f5_local1 = not f5_local0
end
CoD.GameEndScoreUtility.ShowWinningTeamTransition = function(f6_arg0)
	if Engine.IsVisibilityBitSet(f6_arg0, Enum.UIVisibilityBit[@"bit_in_killcam"]) or Engine.IsVisibilityBitSet(f6_arg0, Enum.UIVisibilityBit[@"bit_final_killcam"]) or Engine.IsVisibilityBitSet(f6_arg0, Enum.UIVisibilityBit[@"bit_play_of_the_match"]) or Engine.IsVisibilityBitSet(f6_arg0, Enum.UIVisibilityBit[@"bit_scoreboard_open"]) then
		return false
	else
		local f6_local0 = Engine.GetModelForController(f6_arg0)
		return f6_local0.gameScore.currentState:get() == "team_pose"
	end
end
CoD.GameEndScoreUtility.IsGameScoreCurrentState = function(f7_arg0, f7_arg1)
	local f7_local0 = Engine.GetModelForController(f7_arg0)
	return f7_local0.gameScore.currentState:get() == f7_arg1
end
CoD.GameEndScoreUtility.ShowEliminationStateSkipButton = function(f8_arg0)
	local f8_local0 = Engine.GetModelForController(f8_arg0)
	f8_local0 = f8_local0.gameScore
	if f8_local0.currentState:get() == "elimination" and f8_local0.postEliminationGameState:get() ~= "" then
		return true
	else
		return false
	end
end
CoD.GameEndScoreUtility.CanShowWarzoneKillcam = function(f9_arg0)
	if Engine.GetGametypeSetting("allowkillcam") == 1 and not Engine.issplitscreen() then
		local f9_local0 = Engine.GetModelForController(f9_arg0)
		if not f9_local0.gameScore.hasPlayedDeathCam:get() and (not CoD.GameEndScoreUtility.IsTeamAlive(f9_arg0) or Engine.IsVisibilityBitSet(f9_arg0, Enum.UIVisibilityBit[@"bit_game_ended"])) then
			f9_local0 = Engine.IsVisibilityBitSet(f9_arg0, Enum.UIVisibilityBit[@"bit_player_dead"])
			if not f9_local0 then
				f9_local0 = Engine.IsVisibilityBitSet(f9_arg0, Enum.UIVisibilityBit[@"bit_spectating_client"])
			end
			return f9_local0
		end
	end
	return false
end
CoD.GameEndScoreUtility.CanShowWarzoneSpectate = function(f10_arg0)
	local f10_local0 = Engine.GetModelForController(f10_arg0)
	f10_local0 = f10_local0.gameScore.currentState:get()
	local f10_local1 = Engine.GetModelForController(f10_arg0)
	local f10_local2
	if IsBooleanDvarSet("ui_showWZAAR") then
		f10_local2 = f10_local1.hudItems.warzone.aarViewed:get()
	else
		f10_local2 = true
	end
	local f10_local3
	if f10_local0 ~= "elimination" then
		if f10_local0 == "team_elimination" then
			f10_local3 = f10_local2
		else
			f10_local3 = false
		end
	else
		f10_local3 = true
	end
	return f10_local3
end
CoD.GameEndScoreUtility.ShowScoreInsteadOfPips = function(f11_arg0)
	local f11_local0 = CoD.HUDUtility.IsGameTypeEqualToString("tdm")
	if not f11_local0 then
		f11_local0 = CoD.HUDUtility.IsGameTypeEqualToString("dom")
		if not f11_local0 then
			f11_local0 = CoD.HUDUtility.IsGameTypeEqualToString("koth")
			if not f11_local0 then
				f11_local0 = CoD.HUDUtility.IsGameTypeEqualToString("dom_dm")
				if not f11_local0 then
					f11_local0 = Engine.GetModelForController(f11_arg0)
					f11_local0 = f11_local0.gameScore.roundWinLimit:get() > 4
				end
			end
		end
	end
	return f11_local0
end
CoD.GameEndScoreUtility.ShowMatchBonus = function(f12_arg0, f12_arg1)
	local f12_local0 = Engine.GetModelForController(f12_arg1)
	f12_local0 = f12_local0.gameScore
	if f12_local0 then
		local f12_local1 = f12_local0.isRoundEnd
		local f12_local2 = f12_local0.matchBonus
		local f12_local3
		if f12_local2 then
			f12_local3 = f12_local2:get()
			if not f12_local3 then
			else
				return f12_local1 and f12_local1:get() and f12_local3 > 0
			end
		end
		f12_local3 = 0
	else
		return false
	end
end
CoD.GameEndScoreUtility.GetEndTypeString = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	local f13_local0 = @"hash_48B69A4A25A9ED2C"
	local f13_local1 = nil
	if f13_arg3 then
		f13_local1 = Engine[@"hash_83B01F154A61015"](f13_arg0)
	else
		f13_local1 = Engine[@"hash_6846CEC728EAE5BC"](f13_arg0, f13_arg1)
	end
	if f13_local1 == Enum[@"endroundtype"][0x1BBB87B87C962D] then
		if f13_arg3 then
			f13_local0 = f13_local0 .. "dnf_match"
		else
			f13_local0 = f13_local0 .. "dnf_round"
		end
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_3683836650E29384"] then
		if f13_arg2 then
			f13_local0 = f13_local0 .. "completed_winner"
		else
			f13_local0 = f13_local0 .. "completed_loser"
		end
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_3C9D96623F884FD1"] then
		f13_local0 = f13_local0 .. "timelimit"
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_36E013C97845C972"] or f13_local1 == Enum[@"endroundtype"][@"hash_6E40EAEAF56BC228"] then
		f13_local0 = f13_local0 .. "scorelimit"
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_71D01C89DF495850"] then
		f13_local0 = f13_local0 .. "roundlimit"
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_62DF76230CCB22BF"] then
		if f13_arg2 then
			f13_local0 = f13_local0 .. "eliminated_winner"
		else
			f13_local0 = f13_local0 .. "eliminated_loser"
		end
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_58C62F816D4E87FB"] then
		f13_local0 = f13_local0 .. "forfeited"
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_21011D71A3C6AEE9"] then
		f13_local0 = f13_local0 .. "ended"
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_49896C618B952FEB"] then
		f13_local0 = f13_local0 .. "host_ended"
	elseif f13_local1 == Enum[@"endroundtype"][@"hash_1AD4085D51F9596D"] then
		f13_local0 = f13_local0 .. "host_sucks"
	end
	return CoD.GameEndScoreUtility.EndTypeStrings[f13_local0] or 0x0
end
CoD.GameEndScoreUtility.GetChallengeCoinImage = function(f14_arg0)
	local f14_local0 = Engine[@"converttoxhash"](Engine.GetCurrentGameType())
	local f14_local1 = CoD.GetCurrentPlayerStats(f14_arg0)
	if f14_local1 and f14_local1.PlayerStatsByGameType and f14_local1.PlayerStatsByGameType[f14_local0] then
		return Engine[@"hash_2450462A7BEA79E5"](f14_local1.PlayerStatsByGameType[f14_local0].WINS.StatValue:get())
	else
		return "blacktransparent"
	end
end
CoD.GameEndScoreUtility.GetChallengeCoinImageForWins = function(f15_arg0)
	return Engine[@"hash_2450462A7BEA79E5"](f15_arg0)
end
CoD.GameEndScoreUtility.IsSoloTeamGame = function()
	local f16_local0 = Engine.GetGametypeSettings()
	return (f16_local0 and f16_local0.maxteamplayers:get()) == 1
end
CoD.GameEndScoreUtility.IsTeamAlive = function(f17_arg0)
	local f17_local0 = Engine.GetModelForController(f17_arg0)
	local f17_local1 = f17_local0["hudItems.aliveTeammateCount"]
	local f17_local2
	if f17_local1 then
		f17_local2 = f17_local1:get()
		if not f17_local2 then
		else
			return f17_local2 > 0
		end
	end
	f17_local2 = 0
end
CoD.GameEndScoreUtility.SetupTransition = function(f18_arg0, f18_arg1)
	local f18_local0 = f18_arg1.controller
	local f18_local1 = nil
	local f18_local2 = f18_arg1.data[1]
	if f18_arg1.elimination then
		f18_local1 = CoD.GameEndScoreUtility.EliminationTransitions[f18_local2]
	elseif f18_arg1.isMatchEnd then
		f18_local1 = CoD.GameEndScoreUtility.FinalTransitions[f18_local2]
	else
		f18_local1 = CoD.GameEndScoreUtility.RoundTransitions[f18_local2]
	end
	if not f18_local1 then
		return
	end
	local f18_local3 = Engine.CurrentSessionMode()
	CoD.ScoreboardUtility.HideScoreboard(nil, f18_local0)
	local f18_local4 = Engine.GetModelForController(f18_local0)
	f18_local4 = f18_local4.gameScore
	local f18_local5 = Engine.GetRoundsPlayed(f18_local0) + 1
	local f18_local6 = LuaDefine.INVALID_CLIENT_INDEX
	if IsCodCaster(f18_local0) then
		local f18_local7 = Engine.GetModelForController(f18_local0)
		f18_local6 = f18_local7.deadSpectator.playerIndex:get()
	else
		f18_local6 = Engine.GetClientNum(f18_local0)
	end
	local f18_local7 = Engine.GetTeamID(f18_local0, f18_local6)
	local f18_local8 = Engine[@"getteamplatoon"](f18_local0, f18_local7)
	local f18_local9 = Enum.team_t[@"team_bad"]
	local f18_local10 = Engine[@"hash_1CFD8E3722B9896B"](f18_local0)
	if f18_arg1.isMatchEnd then
		f18_local9 = Engine[@"hash_392D186356890261"](f18_local0)
	else
		f18_local9 = Engine[@"hash_7520A1FFDAFA7BE2"](f18_local0, f18_local5)
	end
	local f18_local11 = f18_local9 == f18_local7
	if CoD.HUDUtility.IsGameTypeEqualToString("warzone_pandemic_quad") and CoD.ModelUtility.IsModelValueEqualTo(f18_local0, "hudItems.playerOnInfectedPlatoon", 0) then
		f18_local11 = true
	end
	local f18_local12
	if f18_local9 ~= Enum.team_t[@"team_bad"] or f18_local10 ~= Enum[@"platoon_t"][@"platoon_none"] then
		f18_local12 = false
	else
		f18_local12 = true
	end
	local f18_local13
	if f18_local8 == Enum[@"platoon_t"][@"platoon_none"] or f18_local8 ~= f18_local10 then
		f18_local13 = false
	else
		f18_local13 = true
	end
	f18_local4.winningTeam:set(f18_local9)
	f18_local4.isRoundEnd:set(true)
	local f18_local14 = 0x0
	local f18_local15 = CoD.GameEndScoreUtility.GetEndTypeString(f18_local0, f18_local5, f18_local11, f18_arg1.isMatchEnd)
	if f18_local12 then
		f18_local14 = f18_local1[@"text_tie"]
		if f18_local3 == Enum.eModes.mode_multiplayer and not IsGametypeTeambased() then
			local f18_local16 = DataSources.FFALeader.getModel()
			f18_local16 = f18_local16.clientNum:get()
			local f18_local17 = DataSources.FFASecondBest.getModel()
			f18_local17 = f18_local17.clientNum:get()
			local f18_local18 = DataSources.FFAThirdBest.getModel()
			if f18_local6 == f18_local16 or f18_local6 == f18_local17 or f18_local6 == f18_local18.clientNum:get() then
				f18_local14 = @"hash_64BE6C7C5CB087D9"
			end
		end
	elseif f18_local11 or f18_local13 then
		f18_local14 = f18_local1[@"text_winner"]
	else
		f18_local14 = f18_local1[@"text_loser"]
		if CoD.HUDUtility.IsGameTypeEqualToString("warzone_pandemic_quad") then
			f18_local14 = "mp/defeat_caps"
		end
		if f18_local3 == Enum.eModes.mode_multiplayer and not IsGametypeTeambased() then
			local f18_local16 = DataSources.FFALeader.getModel()
			f18_local16 = f18_local16.clientNum:get()
			local f18_local17 = DataSources.FFASecondBest.getModel()
			f18_local17 = f18_local17.clientNum:get()
			local f18_local18 = DataSources.FFAThirdBest.getModel()
			if f18_local6 == f18_local16 or f18_local6 == f18_local17 or f18_local6 == f18_local18.clientNum:get() then
				f18_local14 = @"hash_64BE6C7C5CB087D9"
			end
		end
	end
	if f18_local1.type == "outcome" then
		f18_local4.showSwitchingSides:set(false)
		f18_local4.victory:set(f18_local11 or f18_local13)
		if f18_local3 == Enum.eModes.mode_multiplayer and not IsGametypeTeambased() then
			local f18_local16 = DataSources.FFALeader.getModel()
			f18_local16 = f18_local16.clientNum:get()
			local f18_local17 = DataSources.FFASecondBest.getModel()
			f18_local17 = f18_local17.clientNum:get()
			local f18_local18 = DataSources.FFAThirdBest.getModel()
			if f18_local6 == f18_local16 or f18_local6 == f18_local17 or f18_local6 == f18_local18.clientNum:get() then
				f18_local4.victory:set(true)
			end
		end
		f18_local4.draw:set(f18_local12)
		local f18_local16 = f18_local4.defeat
		local f18_local17 = f18_local16
		f18_local16 = f18_local16.set
		local f18_local18
		if not f18_local11 and not f18_local12 then
			f18_local18 = not f18_local13
		else
			f18_local18 = false
		end
		f18_local16(f18_local17, f18_local18)
		f18_local4.titleString:set(f18_local14)
		f18_local4.subtitleString:set(f18_local15)
		if f18_local3 == Enum.eModes.mode_warzone then
			f18_local4.hasPlayedFirstTimeIntro:set(false)
			if f18_local11 or f18_local13 then
				f18_local4.challengeCoinImage:set(CoD.GameEndScoreUtility.GetChallengeCoinImage(f18_local0))
				f18_local4.currentState:set("outcome")
			else
				f18_local4.challengeCoinImage:set("blacktransparent")
				if not f18_local4.hasShownEliminationScreen:get() and not CoD.HUDUtility.IsGameTypeEqualToString("warzone_pandemic_quad") then
					f18_local4.hasShownEliminationScreen:set(true)
					f18_local4.postEliminationGameState:set("defeat")
					f18_local4.currentState:set("elimination")
				else
					f18_local4.currentState:set("defeat")
				end
			end
			SendClientScriptNotify(f18_local0, "wz_outcome" .. Engine.GetLocalClientNum(f18_local0))
		else
			f18_local4.currentState:set("outcome")
		end
	elseif f18_local1.type == "outcome_with_score" or f18_local1.type == "outcome_with_time" then
		f18_local4.currentState:set(f18_local1.type)
		if IsCodCaster(f18_local0) then
			f18_local7 = Enum.team_t[@"team_allies"]
		end
		local f18_local16 = Enum.team_t[@"team_allies"]
		if f18_local16 == f18_local7 then
			f18_local16 = Enum.team_t[@"team_axis"]
		end
		local f18_local17 = 0
		local f18_local18 = 0
		if IsGametypeTeambased() then
			if f18_arg1.isMatchEnd then
				f18_local17 = Engine[@"hash_4E488A0BF2D44AA3"](f18_local0, f18_local7)
				f18_local18 = Engine[@"hash_4E488A0BF2D44AA3"](f18_local0, f18_local16)
			else
				f18_local17 = Engine[@"hash_D21537F86A6EF8C"](f18_local0, f18_local5, f18_local7)
				f18_local18 = Engine[@"hash_D21537F86A6EF8C"](f18_local0, f18_local5, f18_local16)
			end
		else
			f18_local17 = f18_local4.playerScore:get()
			f18_local18 = f18_local4.enemyScore:get()
		end
		f18_local4.playerScoreOrTime:set(tostring(f18_local17))
		f18_local4.enemyScoreOrTime:set(tostring(f18_local18))
		f18_local4.victory:set(f18_local11)
		if f18_local3 == Enum.eModes.mode_multiplayer and not IsGametypeTeambased() then
			local f18_local19 = DataSources.FFALeader.getModel()
			f18_local19 = f18_local19.clientNum:get()
			local f18_local20 = DataSources.FFASecondBest.getModel()
			f18_local20 = f18_local20.clientNum:get()
			local f18_local21 = DataSources.FFAThirdBest.getModel()
			if f18_local6 == f18_local19 or f18_local6 == f18_local20 or f18_local6 == f18_local21.clientNum:get() then
				f18_local4.victory:set(true)
			end
		end
		f18_local4.draw:set(f18_local12)
		local f18_local19 = f18_local4.defeat
		local f18_local20 = f18_local19
		f18_local19 = f18_local19.set
		local f18_local21
		if not f18_local11 then
			f18_local21 = not f18_local12
		else
			f18_local21 = false
		end
		f18_local19(f18_local20, f18_local21)
		f18_local4.titleString:set(f18_local14)
		f18_local4.subtitleString:set(f18_local15)
	elseif f18_local1.type == "final_killcam" or f18_local1.type == "play_of_the_match" then
		f18_local4.showSwitchingSides:set(false)
		f18_local4.victory:set(false)
		f18_local4.draw:set(false)
		f18_local4.defeat:set(false)
		f18_local4.titleString:set(f18_local14)
		f18_local4.subtitleString:set(0x0)
	elseif f18_local1.type == "switch_sides" then
		f18_local4.showSwitchingSides:set(true)
		f18_local4.victory:set(false)
		f18_local4.draw:set(false)
		f18_local4.defeat:set(false)
		f18_local4.titleString:set(f18_local14)
		f18_local4.subtitleString:set(0x0)
		f18_local4.currentState:set("outcome")
	elseif f18_local1.type == "team_pose" then
		f18_local4.currentState:set("team_pose")
		f18_local4.titleString:set(f18_local14)
		f18_local4.subtitleString:set(f18_local15)
		local f18_local16 = {}
		for f18_local17 = Enum[@"clientnum_t"][@"client_index_first"], Enum[@"clientnum_t"][@"client_index_count"] - 1, 1 do
			local f18_local21 = Engine[@"getmodelforclient"](f18_local17)
			if f18_local21.team:get() == f18_local9 then
				table.insert(f18_local16, f18_local21)
			end
		end
		table.sort(f18_local16, function(f19_arg0, f19_arg1)
			if f19_arg0.scoreboard.score:get() ~= f19_arg1.scoreboard.score:get() then
				return f19_arg1.scoreboard.score:get() < f19_arg0.scoreboard.score:get()
			else
				return f19_arg0.clientNum:get() < f19_arg1.clientNum:get()
			end
		end)
		f18_local4.winningTeamTopScoreCount:set(#f18_local16)
		for f18_local18 = 1, CoD.GameEndScoreUtility.MaxTeamPoseClients, 1 do
			local f18_local22 = f18_local4["winningTeamTopScorer" .. f18_local18]
			local f18_local23 = f18_local22
			f18_local22 = f18_local22.set
			local f18_local24 = f18_local16[f18_local18]
			if not f18_local24 then
				f18_local24 = nil
			end
			f18_local22(f18_local23, f18_local24)
		end
	elseif f18_local1.type == "elimination" then
		if f18_arg1.teamElimination then
			Engine.PlayMenuMusic("team_eliminated")
			Engine.playsound("uin_endgame_team_eliminated", f18_local0)
			f18_local4.titleString:set(f18_local1[@"text_loser"])
			if f18_local3 == Enum.eModes.mode_warzone and not f18_local4.hasShownEliminationScreen:get() then
				f18_local4.hasShownEliminationScreen:set(true)
				f18_local4.postEliminationGameState:set("team_elimination")
				f18_local4.currentState:set("elimination")
			else
				f18_local4.currentState:set("team_elimination")
			end
		else
			Engine.PlayMenuMusic("player_eliminated")
			Engine.playsound("uin_endgame_player_eliminated", f18_local0)
			f18_local4.currentState:set("elimination")
			f18_local4.hasShownEliminationScreen:set(true)
			f18_local4.titleString:set(f18_local1[@"text_tie"])
		end
		f18_local4.subtitleString:set(0x0)
	elseif f18_local1.type == "high_value_operatives" then
		f18_local4.currentState:set("high_value_operatives")
	end
	CoD.GameEndScoreUtility.SetEndGameQuote(f18_local0, f18_local11)
	if f18_local1.time > 0 then
		if f18_arg0._delayTimer then
			f18_arg0._delayTimer:close()
			f18_arg0._delayTimer = nil
		end
		local f18_local16 = Engine[@"getservertime"](f18_local0) + f18_local1.time
		f18_arg0._delayTimer = LUI.UITimer.newElementTimer(20, false, function()
			local f20_local0 = f18_local16 - Engine[@"getservertime"](f18_local0)
			f18_local4.transitionTimeRemaining:set(f20_local0)
			if f20_local0 < 0 and f18_arg0._delayTimer then
				f18_arg0._delayTimer:close()
				f18_arg0._delayTimer = nil
			end
		end)
		f18_arg0:addElement(f18_arg0._delayTimer)
	end
end
CoD.GameEndScoreUtility.SetEndGameQuote = function(f21_arg0, f21_arg1)
	local f21_local0 = 0x0
	local f21_local1 = 0x0
	local f21_local2 = Engine[@"hash_7A7E3CD65E63086F"](0x88D3CC27BB78B7)
	if f21_local2 then
		local f21_local3 = nil
		if f21_arg1 then
			f21_local3 = Engine[@"hash_7A7E3CD65E63086F"](@"hash_392804C37CD213F0")
		else
			f21_local3 = Engine[@"hash_7A7E3CD65E63086F"](@"hash_4316E10F9989CF79")
		end
		if f21_local3 then
			local f21_local4 = #f21_local2
			local f21_local5 = math.random(1, f21_local4 + #f21_local3)
			local f21_local6 = nil
			if f21_local4 < f21_local5 then
				f21_local6 = f21_local3[f21_local5 - f21_local4]
			else
				f21_local6 = f21_local2[f21_local5]
			end
			f21_local0 = f21_local6.quote
			f21_local1 = f21_local6[@"author"]
		end
	end
	local f21_local3 = Engine.GetModelForController(f21_arg0)
	f21_local3 = f21_local3.gameScore
	local f21_local4 = f21_local3:create("quote")
	f21_local4:set(f21_local0)
	f21_local4 = f21_local3:create("quoteAuthor")
	f21_local4:set(f21_local1)
end
CoD.GameEndScoreUtility.SetEliminatorData = function(f22_arg0, f22_arg1)
	local f22_local0 = f22_arg1.data[1]
	local f22_local1 = f22_arg1.data[2]
	local f22_local2 = f22_arg1.data[3]
	local f22_local3 = Engine.CurrentSessionMode()
	local f22_local4 = Engine[@"getmodelforclient"](f22_local0)
	local f22_local5 = 0x0
	local f22_local6 = 0x0
	local f22_local7 = CoD.CACUtility.GetUnlockableItemInfo(f22_local2, f22_local3)
	if f22_local7 then
		f22_local5 = f22_local7.displayName
		f22_local6 = f22_local7.previewImageLarge
	end
	local f22_local8 = 0x0
	local f22_local9 = "blacktransparent"
	local f22_local10 = CoD.HUDUtility.GetModInfo(f22_local1)
	if f22_local10 then
		f22_local8 = f22_local10.displayname
		f22_local9 = f22_local10[@"iconlarge"]
	end
	local f22_local11 = Engine.GetModelForController(f22_arg1.controller)
	f22_local11 = f22_local11.gameScore
	local f22_local12 = f22_local11:create("attackerClientModel")
	f22_local12:set(f22_local4)
	f22_local12 = f22_local11:create("meansOfDeath")
	f22_local12:set(f22_local1)
	f22_local12 = f22_local11:create("meansOfDeathLabel")
	f22_local12:set(f22_local8)
	f22_local12 = f22_local11:create("meansOfDeathIcon")
	f22_local12:set(f22_local9)
	f22_local12 = f22_local11:create("weaponName")
	f22_local12:set(f22_local5)
	f22_local12 = f22_local11:create("weaponImage")
	f22_local12:set(f22_local6)
end
CoD.GameEndScoreUtility.SetupRoundEndPreKillcamModels = function(f23_arg0, f23_arg1)
	local f23_local0 = f23_arg1.controller
	local f23_local1
	if f23_arg1.data[1] ~= 1 and f23_arg1.data[1] ~= true then
		f23_local1 = false
	else
		f23_local1 = true
	end
	local f23_local2 = f23_arg1.data[2]
	local f23_local3 = f23_arg1.data[3]
	local f23_local4 = f23_arg1.data[4]
	local f23_local5 = f23_arg1.data[5]
	local f23_local6 = Engine.GetModelForController(f23_local0)
	f23_local6 = f23_local6.gameScore
	if not f23_local1 then
		f23_local6.currentState:set("")
	else
		local f23_local7 = f23_local6.currentState
		local f23_local8 = f23_local7
		f23_local7 = f23_local7.set
		local f23_local9
		if f23_local5 then
			f23_local9 = "outcome_transparent"
			if not f23_local9 then
			else
				f23_local7(f23_local8, f23_local9)
				f23_local7 = Engine.GetIString(f23_local3, "CS_LOCALIZED_STRINGS")
				f23_local8 = Engine.GetIString(f23_local4, "CS_LOCALIZED_STRINGS")
				if CoD.IsShoutcaster(f23_local0) then
					f23_local7 = Engine.Localize(f23_local7, CoD.TeamUtility.GetTeamName(f23_local2))
				end
				f23_local6.titleString:set(f23_local7)
				f23_local6.subtitleString:set(f23_local8)
				local f23_local10 = Engine.GetTeamID(f23_local0, Engine.GetClientNum(f23_local0))
				if IsCodCaster(f23_local0) then
					f23_local10 = Enum.team_t[@"team_allies"]
					f23_local2 = Enum.team_t[@"team_allies"]
				end
				local f23_local11 = f23_local2 == Enum.team_t[@"team_bad"]
				f23_local6.victory:set(false)
				f23_local6.draw:set(false)
				f23_local6.defeat:set(false)
				if not f23_local11 then
					if f23_local2 == f23_local10 then
						f23_local6.victory:set(true)
					else
						f23_local6.defeat:set(true)
					end
				else
					f23_local6.draw:set(true)
				end
			end
		end
		f23_local9 = "outcome"
	end
end
CoD.GameEndScoreUtility.InitGameInfoTables = function()
	local f24_local0 = Engine[@"getgametypeinfo"](Engine.GetCurrentGameType())
	CoD.GameEndScoreUtility.RoundTransitions = f24_local0.roundDisplayTransition
	CoD.GameEndScoreUtility.FinalTransitions = f24_local0.finalDisplayTransition
	CoD.GameEndScoreUtility.EliminationTransitions = f24_local0.eliminatedDisplayTransition
	CoD.GameEndScoreUtility.EndTypeStrings = {}
	for f24_local4, f24_local5 in pairs(f24_local0) do
		if type(f24_local5) == "xhash" then
			CoD.GameEndScoreUtility.EndTypeStrings[f24_local4] = f24_local5
		end
	end
end
CoD.GameEndScoreUtility.InitializeUIModels = function(f25_arg0)
	local f25_local0 = Engine.GetModelForController(f25_arg0)
	f25_local0 = f25_local0:create("gameScore")
	local f25_local1 = f25_local0:create("draw")
	f25_local1:set(false)
	f25_local1 = f25_local0:create("isRoundEnd")
	f25_local1:set(false)
	f25_local1 = f25_local0:create("matchBonus")
	f25_local1:set(0)
	f25_local1 = f25_local0:create("alliesScore")
	f25_local1:set(0)
	f25_local1 = f25_local0:create("axisScore")
	f25_local1:set(0)
	f25_local1 = f25_local0:create("victory")
	f25_local1:set(false)
	f25_local1 = f25_local0:create("defeat")
	f25_local1:set(false)
	f25_local1 = f25_local0:create("enemyScoreOrTime")
	f25_local1:set("")
	f25_local1 = f25_local0:create("playerScoreOrTime")
	f25_local1:set("")
	f25_local1 = f25_local0:create("currentState")
	f25_local1:set("")
	f25_local1 = f25_local0:create("titleString")
	f25_local1:set(0x0)
	f25_local1 = f25_local0:create("subtitleString")
	f25_local1:set(0x0)
	f25_local1 = f25_local0:create("showSwitchingSides")
	f25_local1:set(false)
	f25_local1 = f25_local0:create("winningTeam")
	f25_local1:set(Enum.team_t[@"team_bad"])
	f25_local1 = f25_local0:create("winningTeamTopScoreCount")
	f25_local1:set(0)
	f25_local1 = f25_local0:create("teamRanking")
	f25_local1:set(0)
	f25_local1 = f25_local0:create("attackerClientModel")
	f25_local1:set(Engine[@"getmodelforclient"](-1))
	f25_local1 = f25_local0:create("meansOfDeath")
	f25_local1:set(0)
	f25_local1 = f25_local0:create("meansOfDeathLabel")
	f25_local1:set(0x0)
	f25_local1 = f25_local0:create("meansOfDeathIcon")
	f25_local1:set(0x0)
	f25_local1 = f25_local0:create("weaponName")
	f25_local1:set(0x0)
	f25_local0:create("weaponImage")
	f25_local1 = f25_local0:create("hvoUpdate")
	f25_local1:set(0)
	f25_local1 = f25_local0:create("quote")
	f25_local1:set(0x0)
	f25_local1 = f25_local0:create("quoteAuthor")
	f25_local1:set(0x0)
	f25_local1 = f25_local0:create("transitionTimeRemaining")
	f25_local1:set(0)
	f25_local1 = f25_local0:create("hasPlayedFirstTimeIntro")
	f25_local1:set(false)
	f25_local1 = f25_local0:create("hasPlayedDeathCam")
	f25_local1:set(false)
	f25_local1 = f25_local0:create("hasShownEliminationScreen")
	f25_local1:set(false)
	f25_local1 = f25_local0:create("postEliminationGameState")
	f25_local1:set("")
	f25_local1 = f25_local0:create("challengeCoinImage")
	f25_local1:set("blacktransparent")
	for f25_local1 = 1, CoD.GameEndScoreUtility.MaxTeamPoseClients, 1 do
		f25_local0:create("winningTeamTopScorer" .. f25_local1)
	end
	f25_local1 = Engine.GetGlobalModel()
	f25_local1 = f25_local1:create("factions")
	local f25_local2 = f25_local1:create("winningTeamScore")
	f25_local2:set(0)
	f25_local2 = f25_local1:create("losingTeamScore")
	f25_local2:set(0)
	f25_local2 = f25_local1:create("winnersFactionDisplayName")
	f25_local2:set(0x0)
	f25_local2 = f25_local1:create("winnersFactionIcon")
	f25_local2:set("")
	f25_local2 = f25_local1:create("losersFactionDisplayName")
	f25_local2:set(0x0)
	f25_local2 = f25_local1:create("losersFactionIcon")
	f25_local2:set("")
end
CoD.GameEndScoreUtility.SetupGameEndScoreWidget = function(f26_arg0, f26_arg1)
	CoD.GameEndScoreUtility.InitializeUIModels(f26_arg1)
	CoD.GameEndScoreUtility.InitGameInfoTables()
	local f26_local0 = Engine.GetModelForController(f26_arg1)
	f26_local0 = f26_local0.gameScore
	f26_arg0:subscribeToGlobalModel(f26_arg1, "PerController", "scriptNotify", function(model)
		local modelValue = Engine.GetModelValue(model)
		if LUI.DEV and Dvar[@"cg_luidebug"]:get() == true then
			Engine.PrintInfo(Enum[@"consolelabel_e"][@"con_label_lui"], "LUI scriptNotify " .. tostring(modelValue) .. "\n")
		end
		local f27_local1 = Engine.CurrentSessionMode()
		if modelValue == "pre_killcam_transition" then
			CoD.GameEndScoreUtility.SetupRoundEndPreKillcamModels(f26_arg0, {
				controller = f26_arg1,
				name = modelValue,
				data = CoD.GetScriptNotifyData(model),
			})
		elseif modelValue == "pre_potm_transition" then
			local f27_local2 = Engine.GetModelForController(f26_arg1)
			f27_local2.scriptNotify:set("quick_fade")
		elseif modelValue == "post_potm_transition" then
			local f27_local2 = Engine.GetModelForController(f26_arg1)
			f27_local2.scriptNotify:set(@"post_potm")
		elseif modelValue == "winners_circle" then
			f26_local0.currentState:set("")
			f26_local0.isRoundEnd:set(false)
		elseif modelValue == "round_transition" then
			CoD.GameEndScoreUtility.SetupTransition(f26_arg0, {
				controller = f26_arg1,
				name = modelValue,
				isMatchEnd = false,
				data = CoD.GetScriptNotifyData(model),
			})
		elseif modelValue == "match_transition" then
			local f27_local2 = Engine.GetModelForController(f26_arg1)
			local f27_local3 = f27_local2:create("hudItems.reEvalScoreboard")
			f27_local3:forceNotifySubscriptions()
			CoD.GameEndScoreUtility.SetupTransition(f26_arg0, {
				controller = f26_arg1,
				name = modelValue,
				isMatchEnd = true,
				data = CoD.GetScriptNotifyData(model),
			})
		elseif modelValue == "elimination_transition" then
			CoD.GameEndScoreUtility.SetupTransition(f26_arg0, {
				controller = f26_arg1,
				name = modelValue,
				isMatchEnd = false,
				elimination = true,
				data = CoD.GetScriptNotifyData(model),
			})
		elseif modelValue == "team_elimination_transition" then
			CoD.GameEndScoreUtility.SetupTransition(f26_arg0, {
				controller = f26_arg1,
				name = modelValue,
				isMatchEnd = false,
				elimination = true,
				teamElimination = true,
				data = CoD.GetScriptNotifyData(model),
			})
		elseif modelValue == "clear_transition" then
			CoD.GameEndScoreUtility.ClearTransition(f26_arg1)
		elseif modelValue == "eliminator_info" then
			CoD.GameEndScoreUtility.SetEliminatorData(f26_arg0, {
				controller = f26_arg1,
				name = modelValue,
				data = CoD.GetScriptNotifyData(model),
			})
		elseif modelValue == "team_eliminated" then
			local f27_local2 = CoD.GetScriptNotifyData(model)
			f26_local0.teamRanking:set(f27_local2[1])
		elseif modelValue == "hvo_card" then
			CoD.GameEndScoreUtility.ProcessHVOCard(f26_arg1, CoD.GetScriptNotifyData(model))
		elseif modelValue == "match_bonus_notify" then
			local f27_local2 = CoD.GetScriptNotifyData(model)
			f26_local0.matchBonus:set(f27_local2[1])
		end
	end)
end
CoD.GameEndScoreUtility.GetHVOCardList = function()
	if not CoD.GameEndScoreUtility.HVOCardList then
		CoD.GameEndScoreUtility.HVOCardList = Engine[@"hash_7A7E3CD65E63086F"](@"hvolist")
	end
	return CoD.GameEndScoreUtility.HVOCardList
end
CoD.GameEndScoreUtility.ProcessHVOCard = function(f29_arg0, f29_arg1)
	if not CoD.GameEndScoreUtility.HVOCardData then
		CoD.GameEndScoreUtility.HVOCardData = {}
	end
	local f29_local0 = {}
	for f29_local1 = 3, 7, 1 do
		table.insert(f29_local0, f29_arg1[f29_local1])
	end
	table.insert(CoD.GameEndScoreUtility.HVOCardData, {
		clientNum = f29_arg1[1],
		cardIndex = f29_arg1[2],
		statValues = f29_local0,
	})
	if #CoD.GameEndScoreUtility.HVOCardData >= 3 then
		local f29_local3 = Engine.GetModelForController(f29_arg0)
		f29_local3 = f29_local3.gameScore
		local f29_local4 = Engine.GetModelForController(f29_arg0)
		Engine.ForceNotifyModelSubscriptions(f29_local4.gameScore.hvoUpdate)
	end
end
CoD.GameEndScoreUtility.CreateHVOCardStatsDataSource = function(f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = "HVOStats" .. f30_arg1
	DataSources[f30_local0] = DataSourceHelpers.ListSetup(f30_local0, function(f31_arg0, f31_arg1)
		local f31_local0 = {}
		if f30_arg0.statsarray then
			for f31_local1 = 1, #f30_arg2, 1 do
				local f31_local4 = f30_arg0.statsarray[f31_local1]
				if f31_local4 then
					local f31_local5 = {
						models = {
							label = f31_local4[@"displaystatname"],
							value = f30_arg2[f31_local1] or 0,
						},
					}
					if f31_local1 == 1 or f31_local5.models.value > 0 then
						table.insert(f31_local0, f31_local5)
					end
				end
			end
			table.sort(f31_local0, function(f32_arg0, f32_arg1)
				return f32_arg1.models.value < f32_arg0.models.value
			end)
		end
		return f31_local0
	end, true)
	return f30_local0
end
DataSources.HighValueOperatives = DataSourceHelpers.ListSetup("HighValueOperatives", function(f33_arg0, f33_arg1)
	local f33_local0 = {}
	if not CoD.GameEndScoreUtility.HVOCardData then
		return f33_local0
	end
	local f33_local1 = Engine.CurrentSessionMode()
	local f33_local2 = CoD.GameEndScoreUtility.GetHVOCardList()
	local f33_local3 = function(f34_arg0, f34_arg1)
		local f34_local0 = nil
		if f34_arg0.imagearray then
			for f34_local4, f34_local5 in ipairs(f34_arg0.imagearray) do
				if f34_local5.specialist == f34_arg1 then
					f34_local0 = f34_local5.image
				end
			end
		end
		local f34_local6 = f34_local0
		local f34_local1 = f34_arg0[@"defaultimage"]
		if not f34_local1 then
			f34_local1 = f34_local6 or "blacktransparent"
		end
		return f34_local1
	end
	local f33_local4 = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
		local f35_local0 = Engine[@"getmodelforclient"](f35_arg0)
		local f35_local1 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f33_local1, f35_local0.characterIndex:get() or 1)
		local f35_local2 = f35_local1.assetName
		local f35_local3 = f33_local2[f35_arg1]
		return {
			models = {
				perClient = f35_local0,
				clientNum = f35_arg0,
				cardTitle = f35_local3[@"cardname"],
				cardImage = f33_local3(f35_local3, f35_local2),
				statsDataSource = CoD.GameEndScoreUtility.CreateHVOCardStatsDataSource(f35_local3, f35_arg3, f35_arg2),
			},
		}
	end
	for f33_local8, f33_local9 in ipairs(CoD.GameEndScoreUtility.HVOCardData) do
		table.insert(f33_local0, f33_local4(f33_local9.clientNum, f33_local9.cardIndex, f33_local9.statValues, f33_local8))
	end
	return f33_local0
end)
CoD.GameEndScoreUtility.Redeploy = function(f36_arg0)
	Engine[@"hash_6BA6C731FA654F3B"](f36_arg0)
end
CoD.GameEndScoreUtility.SetupHVOCard = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
	local f37_local0 = DataSources[f37_arg3]
	if f37_arg2 and f37_local0 then
		local f37_local1 = f37_local0.getItem(f37_arg0, f37_arg2, f37_arg4)
		if f37_local1 then
			f37_arg1:setModel(f37_local1, f37_arg0)
		end
	end
end
CoD.GameEndScoreUtility.ClearTransitionModels = function(f38_arg0)
	local f38_local0 = Engine.GetModelForController(f38_arg0)
	f38_local0 = f38_local0.gameScore
	f38_local0.currentState:set("")
	f38_local0.isRoundEnd:set(false)
	f38_local0.hasPlayedFirstTimeIntro:set(false)
end
CoD.GameEndScoreUtility.IsInTransition = function(f39_arg0)
	return f39_local0.currentState and f39_local1 and f39_local0.currentState:get() ~= ""
end
CoD.GameEndScoreUtility.ClearTransition = function(f40_arg0)
	local f40_local0 = Engine.CurrentSessionMode()
	if f40_local0 ~= Enum.eModes.mode_warzone then
		local f40_local1 = Engine.GetModelForController(f40_arg0)
		f40_local1.scriptNotify:set("quick_fade")
	end
	CoD.GameEndScoreUtility.ClearTransitionModels(f40_arg0)
	if f40_local0 == Enum.eModes.mode_warzone then
		CoD.BaseUtility.PlayMusic("death")
		Engine.playsound("uin_endgame_screen_exit")
	elseif f40_local0 == Enum.eModes.mode_multiplayer then
		local f40_local1 = Engine.GetModelForController(f40_arg0)
		if f40_local1.StartMenu_Main and f40_local1.StartMenu_Main.clear_transition then
			Engine.ForceNotifyModelSubscriptions(f40_local1.StartMenu_Main.clear_transition)
		end
	end
end
CoD.GameEndScoreUtility.PlayFirstTimeIntroClipIfNeeded = function(f41_arg0, f41_arg1)
	local f41_local0 = Engine.GetModelForController(f41_arg1)
	f41_local0 = f41_local0.gameScore
	CoD.LobbyUtility.SetPlayerLocation(f41_arg1, Enum[@"hash_C0AB9543C5C440B"][@"hash_B4603B82CB82E77"])
	if not f41_local0.hasPlayedFirstTimeIntro:get() and f41_arg0:hasClip("FirstTimeIntro") then
		f41_arg0:playClip("FirstTimeIntro")
		f41_local0.hasPlayedFirstTimeIntro:set(true)
		if CoD.GameEndScoreUtility.IsGameScoreCurrentState(f41_arg1, "elimination") then
			f41_arg0:registerEventHandler("clip_over", function(element, event)
				if f41_local0.postEliminationGameState:get() ~= "" and not element._postElimTimer then
					element._postElimTimer = LUI.UITimer.newElementTimer(1500, true, function()
						CoD.GameEndScoreUtility.SetPostEliminationGameState(f41_arg1)
					end)
					element:addElement(element._postElimTimer)
					LUI.UIElement.clipOver(element, event)
				end
			end)
		else
			CoD.WZUtility.DelayThenShowInGameReport(f41_arg0, f41_arg1)
		end
	else
		CoD.WZUtility.DelayThenShowInGameReport(f41_arg0, f41_arg1)
	end
end
CoD.GameEndScoreUtility.GetEliminatedString = function(f44_arg0, f44_arg1)
	if f44_arg1 == 0 then
		return "null/empty"
	else
		return @"hash_5DB82AD88E0752FB"
	end
end
CoD.GameEndScoreUtility.SetPostEliminationGameState = function(f45_arg0)
	local f45_local0 = Engine.GetModelForController(f45_arg0)
	f45_local0 = f45_local0.gameScore
	local f45_local1 = f45_local0.postEliminationGameState:get()
	if f45_local1 == "" then
		f45_local1 = "defeat"
	end
	f45_local0.currentState:set(f45_local1)
	f45_local0.postEliminationGameState:set("")
end
CoD.GameEndScoreUtility.HasViewedInGameReport = function(f46_arg0)
	local f46_local0
	if IsOnlineGame() then
		f46_local0 = Engine.GetModelForController(f46_arg0)
		f46_local0 = f46_local0.hudItems.warzone.aarViewed:get()
	else
		f46_local0 = true
	end
	return f46_local0
end
