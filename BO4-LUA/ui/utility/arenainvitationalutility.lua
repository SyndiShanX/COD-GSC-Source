CoD.ArenaInvitationalUtility = {}
CoD.ArenaInvitationalUtility.GameStateColor = {
	[Enum[@"hash_53BC79BF1DC288C"][@"hash_1CD55F9EF35B7CE2"]] = {
		r = 1,
		g = 1,
		b = 1,
	},
	[Enum[@"hash_53BC79BF1DC288C"][@"hash_4D65C385BCE45950"]] = {
		r = 0,
		g = 1,
		b = 0,
	},
	[Enum[@"hash_53BC79BF1DC288C"][@"hash_5B87D2053AB9602C"]] = {
		r = 1,
		g = 0,
		b = 0,
	},
}
CoD.ArenaInvitationalUtility.RoundPool = {
	Round1 = 1,
	Round2 = 2,
	Round3 = 3,
	Challenger = 4,
	Spoiler = 5,
	Winner = 6,
}
CoD.ArenaInvitationalUtility.GetGameStateColor = function(f1_arg0)
	local f1_local0 = CoD.ArenaInvitationalUtility.GameStateColor[f1_arg0]
	return f1_local0.r, f1_local0.g, f1_local0.b
end
CoD.ArenaInvitationalUtility.GetRoundName = function(f2_arg0)
	local f2_local0 = ""
	if CoD.ArenaInvitationalUtility.GetIsRound(f2_arg0) then
		f2_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_381DD74C4D0ED43C", f2_arg0)
	elseif CoD.ArenaInvitationalUtility.GetIsChallenger(f2_arg0) then
		f2_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2ABBE17CDB539A05")
	end
	return f2_local0
end
CoD.ArenaInvitationalUtility.GetRoundSeriesAndGameCount = function(f3_arg0, f3_arg1)
	local f3_local0 = nil
	if CoD.ArenaInvitationalUtility.GetIsChallenger(f3_arg1) then
		f3_local0 = f3_arg0
	elseif CoD.ArenaInvitationalUtility.GetIsRound(f3_arg1) then
		for f3_local4, f3_local5 in ipairs(f3_arg0.roundlist) do
			if f3_local4 == f3_arg1 then
				f3_local0 = f3_local5
				break
			end
		end
	end
	if f3_local0 == nil then
		return
	end
	local f3_local6 = f3_local0[@"bestof"]
	local f3_local1 = f3_local0.objective
	local f3_local2 = Engine[@"hash_2E00B2F29271C60B"](f3_local0[@"hash_65BADF6732342CB6"])
	local f3_local3 = f3_local2.serieslist
	local f3_local4 = {}
	for f3_local9, f3_local10 in ipairs(f3_local3) do
		table.insert(f3_local4, f3_local10.gametype)
	end
	return f3_local4, f3_local6, f3_local1
end
CoD.ArenaInvitationalUtility.GetRoundIsComplete = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	local f4_local0 = 0
	local f4_local1 = 0
	for f4_local9, f4_local10 in ipairs(f4_arg1) do
		local f4_local6 = 0
		local f4_local7 = 0
		for f4_local8 = 1, f4_arg2, 1 do
			local f4_local5 = f4_arg0[(f4_local9 - 1) * f4_arg2 + f4_local8 - 1].state
			if f4_local5 == Enum[@"hash_53BC79BF1DC288C"][@"hash_4D65C385BCE45950"] then
				f4_local6 = f4_local6 + 1
			end
			if f4_local5 == Enum[@"hash_53BC79BF1DC288C"][@"hash_5B87D2053AB9602C"] then
				f4_local7 = f4_local7 + 1
			end
		end
		if f4_arg2 / 2 < f4_local6 then
			f4_local0 = f4_local0 + 1
		end
		if f4_arg2 / 2 < f4_local7 then
			f4_local1 = f4_local1 + 1
		end
	end
	f4_local2 = false
	f4_local3 = false
	if f4_arg3 <= f4_local0 then
		f4_local2 = true
		f4_local3 = true
	elseif #f4_arg1 - f4_arg3 < f4_local1 then
		f4_local2 = true
		f4_local3 = false
	end
	return f4_local2, f4_local3
end
CoD.ArenaInvitationalUtility.GetChallengerRoundIsComplete = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0, f5_local1, f5_local2 = CoD.ArenaInvitationalUtility.GetRoundSeriesAndGameCount(f5_arg0, CoD.ArenaInvitationalUtility.RoundPool.Challenger)
	local f5_local3, f5_local4 = CoD.ArenaInvitationalUtility.GetRoundIsComplete(Engine[@"hash_75A6CB7A68FB519D"](f5_arg1, f5_arg2), f5_local0, f5_local1, f5_local2)
	return f5_local3, f5_local4
end
CoD.ArenaInvitationalUtility.GetCurrentRound = function(f6_arg0, f6_arg1, f6_arg2)
	local f6_local0 = false
	for f6_local1 = 1, #f6_arg2.roundlist, 1 do
		local f6_local4 = Engine[@"hash_5E18D7CD5CC634C4"](f6_arg0, f6_arg1, f6_local1)
		local f6_local5, f6_local6, f6_local7 = CoD.ArenaInvitationalUtility.GetRoundSeriesAndGameCount(f6_arg2, f6_local1)
		local f6_local8, f6_local9 = CoD.ArenaInvitationalUtility.GetRoundIsComplete(f6_local4, f6_local5, f6_local6, f6_local7)
		if not f6_local8 then
			return f6_local1
		elseif not f6_local9 then
			if f6_local0 or f6_local1 == CoD.ArenaInvitationalUtility.RoundPool.Round3 then
				return CoD.ArenaInvitationalUtility.RoundPool.Spoiler
			end
			local f6_local10, f6_local11 = CoD.ArenaInvitationalUtility.GetChallengerRoundIsComplete(f6_arg2, f6_arg0, f6_arg1)
			if not f6_local10 then
				return CoD.ArenaInvitationalUtility.RoundPool.Challenger
			elseif not f6_local11 then
				return CoD.ArenaInvitationalUtility.RoundPool.Spoiler
			end
			f6_local0 = true
		end
	end
	return CoD.ArenaInvitationalUtility.RoundPool.Winner
end
CoD.ArenaInvitationalUtility.GetRoundGameStates = function(f7_arg0, f7_arg1, f7_arg2)
	if CoD.ArenaInvitationalUtility.GetIsChallenger(f7_arg2) then
		return Engine[@"hash_75A6CB7A68FB519D"](f7_arg0, f7_arg1)
	elseif CoD.ArenaInvitationalUtility.GetIsRound(f7_arg2) then
		return Engine[@"hash_5E18D7CD5CC634C4"](f7_arg0, f7_arg1, f7_arg2)
	else
		return nil
	end
end
CoD.ArenaInvitationalUtility.GetIsRound = function(f8_arg0)
	local f8_local0
	if CoD.ArenaInvitationalUtility.RoundPool.Round1 > f8_arg0 or f8_arg0 > CoD.ArenaInvitationalUtility.RoundPool.Round3 then
		f8_local0 = false
	else
		f8_local0 = true
	end
	return f8_local0
end
CoD.ArenaInvitationalUtility.GetIsChallenger = function(f9_arg0)
	return f9_arg0 == CoD.ArenaInvitationalUtility.RoundPool.Challenger
end
CoD.ArenaInvitationalUtility.GetIsWinner = function(f10_arg0)
	return f10_arg0 == CoD.ArenaInvitationalUtility.RoundPool.Winner
end
CoD.ArenaInvitationalUtility.GetIsSpoiler = function(f11_arg0)
	return f11_arg0 == CoD.ArenaInvitationalUtility.RoundPool.Spoiler
end
CoD.ArenaInvitationalUtility.PopulateRound = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4)
	if f12_arg3 == nil then
		return
	else
		local f12_local0, f12_local1, f12_local2 = CoD.ArenaInvitationalUtility.GetRoundSeriesAndGameCount(f12_arg3, f12_arg4)
		if f12_local0 == nil then
			return
		else
			local f12_local3 = CoD.ArenaInvitationalUtility.GetRoundGameStates(f12_arg1, f12_arg2, f12_arg4)
			local f12_local4 = "InvitationalSeries" .. f12_arg4
			DataSources[f12_local4] = ListHelper_SetupDataSource(f12_local4, function(f13_arg0)
				local f13_local0 = {}
				for f13_local4, f13_local5 in ipairs(f12_local0) do
					local f13_local6 = "InvitationalSeriesGames" .. f13_local4 .. f12_arg4
					DataSources[f13_local6] = ListHelper_SetupDataSource(f13_local6, function(f14_arg0)
						local f14_local0 = {}
						for f14_local1 = 1, f12_local1, 1 do
							local f14_local4 = f12_local3
							local f14_local5 = (f13_local4 - 1)
							table.insert(f14_local0, {
								models = {
									state = f14_local4[(f13_local4 - 1) * f12_local1 + f14_local1 - 1].state,
								},
								properties = {},
							})
						end
						return f14_local0
					end, true)
					table.insert(f13_local0, {
						models = {
							gametype = f12_local0[f13_local4],
							games = f13_local6,
						},
						properties = {},
					})
					DataSources[f13_local6].prepare(f13_arg0, f12_arg0, f12_arg0.filter)
				end
				return f13_local0
			end, true)
			DataSources[f12_local4].prepare(f12_arg1, f12_arg0, f12_arg0.filter)
			return f12_arg4, f12_local2, f12_local4, DataSources[f12_local4]
		end
	end
end
DataSources.InvitationalDetails = {
	PopulateWidget = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "InvitationalDetails")
		DataSources.InvitationalRounds = ListHelper_SetupDataSource("InvitationalRounds", function(f16_arg0)
			local f16_local0 = {}
			for f16_local1 = 1, #f15_arg3.roundlist, 1 do
				local f16_local4, f16_local5, f16_local6, f16_local7 = CoD.ArenaInvitationalUtility.PopulateRound(f15_arg0, f16_arg0, f15_arg2, f15_arg3, f16_local1)
				table.insert(f16_local0, {
					models = {
						progression = f16_local4,
						objective = f16_local5,
						series = f16_local6,
					},
					properties = {},
				})
			end
			return f16_local0
		end, true)
		DataSources.InvitationalChallenger = ListHelper_SetupDataSource("InvitationalChallenger", function(f17_arg0)
			local f17_local0 = {}
			local f17_local1, f17_local2, f17_local3, f17_local4 = CoD.ArenaInvitationalUtility.PopulateRound(f15_arg0, f17_arg0, f15_arg2, f15_arg3, CoD.ArenaInvitationalUtility.RoundPool.Challenger)
			table.insert(f17_local0, {
				models = {
					progression = f17_local1,
					objective = f17_local2,
					series = f17_local3,
				},
				properties = {},
			})
			return f17_local0
		end, true)
		DataSources.InvitationalRounds.prepare(f15_arg1, f15_arg0, f15_arg0.filter)
		DataSources.InvitationalChallenger.prepare(f15_arg1, f15_arg0, f15_arg0.filter)
	end,
	getModel = function(f18_arg0)
		local f18_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "InvitationalDetails")
		local f18_local1 = f18_local0:create("rounds")
		f18_local1:set("InvitationalRounds")
		f18_local1 = f18_local0:create("challenger")
		f18_local1:set("InvitationalChallenger")
		return f18_local0
	end,
}
DataSources.InvitationalStats = {
	PopulateWidget = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3, f19_arg4)
		if f19_arg3 == nil then
			return
		else
			f19_arg0.Win:hide()
			f19_arg0.Future:hide()
			f19_arg0.Spoiler:hide()
			f19_arg0.CurrentRound:hide()
			local f19_local0 = CoD.ArenaInvitationalUtility.GetCurrentRound(f19_arg1, f19_arg2, f19_arg3)
			if not f19_arg4 then
				f19_arg0.Future:show()
				return
			elseif CoD.ArenaInvitationalUtility.GetIsWinner(f19_local0) then
				f19_arg0.Win:show()
				return
			elseif CoD.ArenaInvitationalUtility.GetIsSpoiler(f19_local0) then
				f19_arg0.Spoiler:show()
				return
			else
				f19_arg0.CurrentRound:show()
				DataSources.InvitationalStatsRound = ListHelper_SetupDataSource("InvitationalStatsRound", function(f20_arg0)
					local f20_local0 = {}
					local f20_local1, f20_local2, f20_local3 = CoD.ArenaInvitationalUtility.PopulateRound(f19_arg0, f20_arg0, f19_arg2, f19_arg3, f19_local0)
					table.insert(f20_local0, {
						models = {
							progression = f20_local1,
							objective = f20_local2,
							series = f20_local3,
						},
						properties = {},
					})
					return f20_local0
				end, true)
				local f19_local1 = Engine.CreateModel(Engine.GetGlobalModel(), "InvitationalStats")
				DataSources.InvitationalStatsRound.prepare(f19_arg1, f19_arg0, f19_arg0.filter)
			end
		end
	end,
	getModel = function(f21_arg0)
		local f21_local0 = Engine.CreateModel(Engine.GetGlobalModel(), "InvitationalStats")
		local f21_local1 = f21_local0:create("round")
		f21_local1:set("InvitationalStatsRound")
		return f21_local0
	end,
}
