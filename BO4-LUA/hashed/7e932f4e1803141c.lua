require("x64:53e8db3768fb02a")
Lobby.Arena = {}
Lobby.Arena.Tokens = {
	updateTime = 0,
}
Lobby.Arena.INVALID_LADDER_POINTS = -1
Lobby.Arena.INVALID_ARENA_SLOT = -1
Lobby.Arena.INVALID_PLACEMENT = -1
Lobby.Arena.LocalPlacement = Lobby.Arena.INVALID_PLACEMENT
Lobby.Arena.UpdateLadderWithLocalStandings = function(f1_arg0)
	local f1_local0 = Engine[0xA5B9C0111291A8B]()
	local f1_local1 = Lobby.Arena.INVALID_PLACEMENT
	local f1_local2 = Engine[0xEF39E16C566439B]()
	if f1_local2 ~= Lobby.Arena.INVALID_ARENA_SLOT then
		local f1_local3 = false
		for f1_local8, f1_local9 in ipairs(f1_arg0) do
			local f1_local10 = Engine[0x852F787399D3F90](f1_local9.entityID)
			if f1_local10 == f1_local0 then
				local f1_local7 = Engine[0x4344E141A9317C5](f1_local10, f1_local2)
				if f1_local7 ~= f1_local9.ladderPoints then
				else
					f1_local1 = f1_local9.position
					break
				end
				f1_local3 = true
				f1_local9.ladderPoints = f1_local7
			end
		end
		if f1_local3 then
			table.sort(f1_arg0, function(f2_arg0, f2_arg1)
				return f2_arg1.ladderPoints < f2_arg0.ladderPoints
			end)
			f1_local5 = 1
			f1_local6 = 1
			f1_local8 = Lobby.Arena.INVALID_LADDER_POINTS
			for f1_local11, f1_local12 in ipairs(f1_arg0) do
				if f1_local8 == Lobby.Arena.INVALID_LADDER_POINTS or f1_local12.ladderPoints == f1_local8 then
					f1_local12.position = f1_local5
					f1_local8 = f1_local12.ladderPoints
					f1_local6 = f1_local6 + 1
				else
					f1_local8 = f1_local12.ladderPoints
					f1_local12.position = f1_local6
					f1_local6 = f1_local12.position + 1
				end
				if Engine[0x852F787399D3F90](f1_local12.entityID) == f1_local0 then
					Lobby.Arena.LocalPlacement = f1_local12.position
					Lobby.Arena.PopulateLeagueEntityLadderRank(nil)
				end
			end
		end
		Lobby.Arena.LocalPlacement = Lobby.Arena.INVALID_PLACEMENT
		Lobby.Arena.PopulateLeagueEntityLadderRank({
			subdivisionPoints = f1_local1,
		})
	end
	return f1_arg0
end
Lobby.Arena.PopulateLeaguePlayLadderMemberList = function(f3_arg0)
	local f3_local0 = Engine[0x8DF2E5447F384B9]()
	f3_local0 = f3_local0:create("LeaguePlayLadderMemberList")
	local f3_local1 = f3_local0:create("loaded")
	local f3_local2 = true
	f3_arg0 = Lobby.Arena.UpdateLadderWithLocalStandings(f3_arg0)
	for f3_local7, f3_local8 in ipairs(f3_arg0) do
		local f3_local9 = f3_local0:create(f3_local7)
		local f3_local10 = f3_local9:create("position")
		f3_local10:set(f3_local8.position)
		f3_local10 = f3_local9:create("xuid")
		f3_local10:set(f3_local8.entityID)
		f3_local10 = LuaUtils.GetRubiesForPosition(f3_local8.position)
		local f3_local11 = f3_local9:create("rubies")
		f3_local11:set(f3_local10)
		f3_local11 = f3_local9:create("identityBadge")
		local f3_local12 = f3_local11:create("xuid")
		f3_local12:set(f3_local8.entityID)
		f3_local12 = Engine[0x1FB3481C8114A9A](f3_local8.entityID)
		local f3_local13 = f3_local9:create("gamertag")
		f3_local13:set(f3_local12)
		f3_local13 = f3_local9:create("clantag")
		f3_local13:set("")
		f3_local13 = Engine[0x2000A30A9678274](f3_local8.entityID)
		local f3_local6 = f3_local9:create("rankInfoReady")
		f3_local6:set(f3_local13 ~= nil)
		f3_local6 = f3_local9:create("ladderPoints")
		f3_local6:set(f3_local8.ladderPoints)
		if f3_local12 == "" or f3_local13 == nil then
			f3_local2 = false
		end
		f3_local6 = f3_local9:create("arrow")
		f3_local6:set("uie_arena_ladder_same")
	end
	f3_local3 = f3_local0:create("count")
	f3_local3:set(#f3_arg0)
	f3_local3 = f3_local0:create("allXuidInfoLoaded")
	f3_local3:set(f3_local2)
	f3_local4 = f3_local1
	f3_local3 = f3_local1.set
	if #f3_arg0 > 0 then
		f3_local5 = LuaEnum.ARENA_INFO_MODELS.LOADED
		if not f3_local5 then
		else
			f3_local3(f3_local4, f3_local5)
		end
	end
	f3_local5 = LuaEnum.ARENA_INFO_MODELS.LOADED_EMPTY
end
Lobby.Arena.PopulateLeagueLadderNameCode = function(f4_arg0)
	local f4_local0 = Engine[0x8DF2E5447F384B9]()
	f4_local0 = f4_local0:create("LeaguePlayLadder")
	local f4_local1 = f4_local0:create("leagueNameCodeLoaded")
	local f4_local2 = f4_local0:create("leagueNameCode")
	f4_local2:set(f4_arg0.leagueNameCode)
	local f4_local3 = f4_local1
	f4_local2 = f4_local1.set
	local f4_local4
	if f4_arg0 then
		f4_local4 = LuaEnum.ARENA_INFO_MODELS.LOADED
		if not f4_local4 then
		else
			f4_local2(f4_local3, f4_local4)
		end
	end
	f4_local4 = LuaEnum.ARENA_INFO_MODELS.NOT_LOADED
end
Lobby.Arena.PopulateLeagueEntityLadderRank = function(f5_arg0)
	local f5_local0 = Engine[0x8DF2E5447F384B9]()
	f5_local0 = f5_local0:create("LeaguePlayLadder")
	local f5_local1 = f5_local0:create("entityLadderRankLoaded")
	local f5_local2 = nil
	if f5_arg0 then
		f5_local2 = f5_arg0.subdivisionRank
	end
	if Lobby.Arena.LocalPlacement ~= Lobby.Arena.INVALID_PLACEMENT then
		f5_local2 = Lobby.Arena.LocalPlacement
	end
	if Engine[0x22EAAB59AA27E9B]("arena_league_subdivisionrank") > 0 then
		f5_local2 = Engine[0x22EAAB59AA27E9B]("arena_league_subdivisionrank")
	end
	local f5_local3 = f5_local0:create("entityLadderRank")
	f5_local3:set(f5_local2)
	local f5_local4 = f5_local1
	f5_local3 = f5_local1.set
	local f5_local5
	if f5_local2 then
		f5_local5 = LuaEnum.ARENA_INFO_MODELS.LOADED
		if not f5_local5 then
		else
			f5_local3(f5_local4, f5_local5)
		end
	end
	f5_local5 = LuaEnum.ARENA_INFO_MODELS.NOT_LOADED
end
Lobby.Arena.Pump = function()
	if Engine[0xE39F1F30B306065]() then
		return
	elseif not Engine[0xFD9E0D91D366130]() then
		return
	elseif not LuaUtils.IsArenaPublicGame() then
		Lobby.Arena.ClearLastEventSeen()
		return
	elseif Engine[0x7B48C1ABFF0F764]() then
		return
	end
	Lobby.Arena.UpdateEventTimers()
	Lobby.Arena.CheckForEventChange()
	local f6_local0 = Engine[0xA5B9C0111291A8B]()
	local f6_local1 = Engine[0xEF39E16C566439B]()
	if f6_local1 < 0 then
		return
	end
	local f6_local2 = LuaUtils.GetCurrentEventEntry()
	if f6_local2 and f6_local2.leagueID and Engine[0xFCBF58203F54D39](f6_local0, f6_local1) ~= f6_local2.leagueID then
		return
	elseif Engine[0xA7B974CED336CF1](f6_local0, f6_local1) == 0 then
		return
	elseif Engine[0x439AFE2B09A5DC9](f6_local0) == false then
		return
	end
	local f6_local3 = Engine[0x8DF2E5447F384B9]()
	f6_local3 = f6_local3:create("LeaguePlayLadderMemberList")
	local f6_local4 = f6_local3:create("loaded")
	f6_local4 = f6_local4:get()
	if not f6_local4 or f6_local4 == LuaEnum.ARENA_INFO_MODELS.NOT_LOADED then
		local f6_local5 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Arena.GetLadderMembersComplete, {})
		if Engine[0x63D6C5AA421DB90](f6_local5, f6_local0) == false then
			Lobby.ProcessQueue.UnRegisterEventHandler(f6_local5)
		end
	else
		local f6_local5 = f6_local3:create("allXuidInfoLoaded")
		if not f6_local5:get() then
			f6_local5 = f6_local3:create("count")
			f6_local5 = f6_local5:get()
			local f6_local6 = true
			for f6_local7 = 1, f6_local5, 1 do
				local f6_local10 = f6_local3:create(tostring(f6_local7))
				local f6_local11 = f6_local10:create("xuid")
				f6_local11 = f6_local11:get()
				local f6_local12 = f6_local10:create("gamertag")
				if f6_local12:get() == "" then
					f6_local6 = false
					f6_local12:set(Engine[0x1FB3481C8114A9A](f6_local11))
				end
				local f6_local13 = f6_local10:create("rankInfoReady")
				if f6_local13:get() == false then
					f6_local6 = false
					f6_local13:set(Engine[0x2000A30A9678274](f6_local11) ~= nil)
				end
			end
			local f6_local7 = f6_local3:create("allXuidInfoLoaded")
			f6_local7:set(f6_local6)
		end
	end
	local f6_local5 = Engine[0x8DF2E5447F384B9]()
	f6_local5 = f6_local5:create("LeaguePlayLadder")
	f6_local5 = f6_local5:create("leagueNameCodeLoaded")
	f6_local5 = f6_local5:get()
	if not f6_local5 or f6_local5 == LuaEnum.ARENA_INFO_MODELS.NOT_LOADED then
		local f6_local6 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Arena.GetLadderNameCodeComplete, {})
		if Engine[0xEE07AA87AAF69DB](f6_local6, f6_local0, f6_local1) == false then
			Lobby.ProcessQueue.UnRegisterEventHandler(f6_local6)
		end
	end
	local f6_local6 = Engine[0x8DF2E5447F384B9]()
	f6_local6 = f6_local6:create("LeaguePlayLadder")
	f6_local6 = f6_local6:create("entityLadderRankLoaded")
	f6_local6 = f6_local6:get()
	if not f6_local6 or f6_local6 == LuaEnum.ARENA_INFO_MODELS.NOT_LOADED then
		local f6_local7 = Lobby.ProcessQueue.RegisterEventHandler(Lobby.Arena.GetEntityLadderRankComplete, {})
		if Engine[0xBEF1168B76F3398](f6_local7, f6_local0, f6_local1) == false then
			Lobby.ProcessQueue.UnRegisterEventHandler(f6_local7)
		end
	end
end
Lobby.Arena.ClearTokenBackoff = function(f7_arg0)
	Lobby.Arena.Tokens.LiveBackoff[f7_arg0] = Engine[0xBDF857C8ED1376B](Dvar[0x6735176B24AC764]:get(), Dvar[0x22483092C2D3DB9]:get(), Dvar[0x3ECC9B20882306]:get(), true)
end
Lobby.Arena.OnClearValidationToken = function(f8_arg0)
	Lobby.Arena.ClearTokenBackoff(f8_arg0.tokenNum)
end
Lobby.Arena.GetLadderMembersComplete = function(f9_arg0, f9_arg1, f9_arg2)
	if f9_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f9_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS or f9_arg0 == Lobby.ProcessQueue.ACTIONSTATE.UPDATE then
		Lobby.Arena.PopulateLeaguePlayLadderMemberList(f9_arg2.arenaLeaguePlayLadderMembersInfo)
	elseif f9_arg0 ~= Lobby.ProcessQueue.ACTIONSTATE.FAILURE and f9_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
	else
	end
	return true
end
Lobby.Arena.GetLadderNameCodeComplete = function(f10_arg0, f10_arg1, f10_arg2)
	if f10_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f10_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Lobby.Arena.PopulateLeagueLadderNameCode(f10_arg2.arenaLeaguePlayLadderNameCode)
	elseif f10_arg0 ~= Lobby.ProcessQueue.ACTIONSTATE.FAILURE and f10_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
	else
	end
	return true
end
Lobby.Arena.GetEntityLadderRankComplete = function(f11_arg0, f11_arg1, f11_arg2)
	if f11_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING then
		return false
	elseif f11_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Lobby.Arena.PopulateLeagueEntityLadderRank(f11_arg2.arenaLeaguePlayEntityLadderRank)
	elseif f11_arg0 ~= Lobby.ProcessQueue.ACTIONSTATE.FAILURE and f11_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
	else
	end
	return true
end
Lobby.Arena.UpdateCurrentEventTimer = function()
	local f12_local0 = LuaUtils.GetCurrentEventEntry()
	if f12_local0 == nil or f12_local0.eventType ~= Enum[0xC0EA92D04BC003B][0xC32571741C5B730] then
		return false
	end
	local f12_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "Arena.arenaEventTimer")
	if f12_local1 == nil then
		return
	end
	local f12_local2 = f12_local0.endOffset - LuaUtils.GetArenaSeasonElapsedSeconds()
	if f12_local2 > 0 then
		f12_local1:set(Engine[0xF9F1239CFD921FE](0x65525DD5B9CD3D0, LuaUtils.SecondsToTimeRemainingString(f12_local2)))
	else
		f12_local1:set("")
	end
end
Lobby.Arena.UpdateNextEventTimer = function()
	local f13_local0 = LuaUtils.GetUpcomingEventEntry()
	if f13_local0 == nil or f13_local0.eventType ~= Enum[0xC0EA92D04BC003B][0xC32571741C5B730] then
		return false
	end
	local f13_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "Arena.arenaNextEventTimer")
	if f13_local1 == nil then
		return false
	end
	local f13_local2 = f13_local0.startOffset - LuaUtils.GetArenaSeasonElapsedSeconds()
	if f13_local2 > 0 then
		f13_local1:set(Engine[0xF9F1239CFD921FE](0x7AE91AA1C7961D3, LuaUtils.SecondsToTimeRemainingString(f13_local2)))
	else
		f13_local1:set("")
	end
	return true
end
Lobby.Arena.UpdateLockoutTimer = function()
	if Dvar[0xF1DE3CEF5A9E0DB]:get() == 0 then
		return
	end
	local f14_local0 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "Arena"), "lockoutDescription")
	local f14_local1 = Engine[0xA798E4552F5E872](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "Arena"), "lockoutTimeRemaining")
	local f14_local2 = Engine[0x77FB2E755901A66]()
	if f14_local2 > 0 then
		f14_local0:set(0xB58CF470802AA10)
		f14_local1:set(Engine[0xF9F1239CFD921FE](0x9DE8C0BAF67F32B, Engine[0xEFB3C7874640AD1](f14_local2)))
		return
	elseif Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) then
		local f14_local3 = Engine[0x2C6A9625D001089](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
		if f14_local3 > 0 then
			f14_local0:set(0x9886E072A3E47BF)
			f14_local1:set(Engine[0xF9F1239CFD921FE](0x9DE8C0BAF67F32B, Engine[0xEFB3C7874640AD1](f14_local3)))
			return
		end
	end
	f14_local0:set(0x0)
	f14_local1:set("")
end
Lobby.Arena.UpdateEventTimers = function()
	Lobby.Arena.UpdateCurrentEventTimer()
	Lobby.Arena.UpdateNextEventTimer()
	Lobby.Arena.UpdateLockoutTimer()
end
Lobby.Arena.ClearLastEventSeen = function()
	local f16_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "Arena")
	local f16_local1 = f16_local0 and f16_local0:create("lastEventSeen", true)
	if f16_local1 then
		f16_local1:set(nil)
	end
end
Lobby.Arena.EventHasEnded = function()
	local f17_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "Arena")
	local f17_local1 = f17_local0 and f17_local0.triggerEndOfEvent
	return f17_local1 and f17_local1:get()
end
Lobby.Arena.CheckForEventChange = function()
	local f18_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "Arena")
	local f18_local1 = LuaUtils.GetCurrentEventEntry()
	local f18_local2 = f18_local0 and f18_local0:create("lastEventSeen", true)
	if f18_local2 and f18_local1 then
		local f18_local3 = f18_local2:get()
		if f18_local3 and f18_local3 ~= f18_local1.leagueID then
			local f18_local4 = f18_local0 and f18_local0:create("triggerEndOfEvent")
			if f18_local4 and not f18_local4:set(true) then
				Engine[0x6A489878620F3BC](f18_local4)
			end
		end
		f18_local2:set(f18_local1.leagueID)
	end
end
Lobby.Arena.ProcesLeagueAEEvent = function(f19_arg0)
	local f19_local0 = LuaUtils.GetLeaguePlayTierTable()
	local f19_local1 = Engine[0x8BF970606552F4C](f19_arg0, Enum[0xBBD4F9E70101BA8][0xD5A7695E03A7A90])
	if f19_local1 and f19_local0 then
		local f19_local2 = f19_local1.arenaBest.leaguePlayStats
		if f19_local2 and f19_local2.leagueID:get() == f19_local2.processLeagueID:get() then
			local f19_local3 = f19_local2.lastSubdivisionRank:get()
			if f19_local3 == f19_local0.tierlist[1][0x8A3024830754A20] then
				f19_local2.firstSubdivisionRankTotalBarrack:set(f19_local2.firstSubdivisionRankTotalBarrack:get() + 1)
				if f19_local2.firstGoldPointsBarrack:get() == 0 then
					f19_local2.firstGoldPointsBarrack:set(f19_local2.points:get())
				end
				if f19_local2.firstDiamondPointsBarrack:get() == 0 and f19_local2.firstSubdivisionRankTotal:get() == f19_local0[0x5AB8CB56CCAB0D9] then
					f19_local2.firstDiamondPointsBarrack:set(f19_local2.points:get())
				end
			elseif f19_local3 <= f19_local0.tierlist[2][0x8A3024830754A20] then
				f19_local2.top5SubdivisionRankTotalBarrack:set(f19_local2.top5SubdivisionRankTotalBarrack:get() + 1)
				if f19_local2.firstSilverGoldPointsBarrack:get() == 0 then
					f19_local2.firstSilverGoldPointsBarrack:set(f19_local2.points:get())
				end
			elseif f19_local3 <= f19_local0.tierlist[3][0x8A3024830754A20] then
				f19_local2.top10SubdivisionRankTotalBarrack:set(f19_local2.top10SubdivisionRankTotalBarrack:get() + 1)
				if f19_local2.firstSilverPointsBarrack:get() == 0 then
					f19_local2.firstSilverPointsBarrack:set(f19_local2.points:get())
				end
			elseif f19_local3 <= f19_local0.tierlist[4][0x8A3024830754A20] then
				f19_local2.top25SubdivisionRankTotalBarrack:set(f19_local2.top25SubdivisionRankTotalBarrack:get() + 1)
				if f19_local2.firstBronzePointsBarrack:get() == 0 then
					f19_local2.firstBronzePointsBarrack:set(f19_local2.points:get())
				end
			end
			f19_local2.processLeagueID:set(0)
			local f19_local4 = Engine[0x8DF2E5447F384B9]()
			local f19_local5 = f19_local4 and f19_local4.Arena
			if f19_local5 then
				local f19_local6 = f19_local5:create("processingEvent")
				f19_local6:set(false)
			end
			Engine[0x7C75E608EA39B5C](f19_arg0, "uploadstats")
			return true
		end
	end
	return false
end
Lobby.Arena.OnProcessLeagueAEEvent = function(f20_arg0)
	local f20_local0 = f20_arg0 and f20_arg0.controller
	if f20_local0 then
		local f20_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "LeaguePlayLadderMemberList")
		if f20_local1 then
			local f20_local2 = f20_local1:create("loaded")
			f20_local2:set(LuaEnum.ARENA_INFO_MODELS.NOT_LOADED)
		end
		Lobby.Arena.ProcesLeagueAEEvent(f20_local0)
	end
end
Lobby.Arena.OnNavToArenaPregame = function()
	local f21_local0 = Engine[0xA5B9C0111291A8B]()
	if Engine[0x3CD0351DA0D371](f21_local0) == true then
		local f21_local1 = Engine[0x8BF970606552F4C](f21_local0, Enum[0xBBD4F9E70101BA8][0xD5A7695E03A7A90])
		if f21_local1 then
			local f21_local2 = f21_local1.arenaBest.leaguePlayStats
			local f21_local3 = f21_local1.arenaStats[Enum[0xC0EA92D04BC003B][0xC32571741C5B730]].leaguePlayStats
			Lobby.Arena.InitializeSkillDivision(f21_local1)
			local f21_local4 = Engine[0x8DF2E5447F384B9]()
			local f21_local5 = f21_local4 and f21_local4.Arena
			if f21_local5 and f21_local2 and f21_local3 then
				local f21_local6 = f21_local2.leagueCount:get()
				if f21_local6 ~= f21_local3.leagueCount:get() or Dvar.arena_league_play_show_end_rank_up:get() then
					f21_local3.leagueCount:set(f21_local6)
					if not Lobby.Arena.ProcesLeagueAEEvent(f21_local0) then
						Engine[0x7C75E608EA39B5C](f21_local0, "uploadstats")
					end
					local f21_local7 = f21_local5:create("arenaLeaguePlayShowEndRankUp")
					f21_local7:set(true)
				else
					local f21_local7 = f21_local5:create("triggerDelayedResultsPopup")
					if f21_local7 and f21_local7:get() == true then
						local f21_local8 = f21_local5:create("arenaLeaguePlayShowDelayedResultsPopup")
						f21_local8:set(true)
						f21_local7:set(false)
					end
				end
			end
		end
	end
end
Lobby.Arena.InitializeSkillDivision = function(f22_arg0)
	if f22_arg0 and f22_arg0.skillDivisionInitialized:get() == 0 then
		f22_arg0.performanceValue:set(-2)
		f22_arg0.arenaBest.performanceValue:set(-2)
		f22_arg0.arenaStats[Enum[0xC0EA92D04BC003B][0xC32571741C5B730]].performanceValue:set(-2)
		f22_arg0.skillDivisionInitialized:set(1)
	end
end
