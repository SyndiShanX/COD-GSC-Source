CoD.ArenaUtility = {}
CoD.ArenaUtility.DaysColors = {
	[0] = {
		r = 0.1,
		g = 0.1,
		b = 0.1,
	},
	[1] = {
		r = 0,
		g = 0,
		b = 0,
	},
	[2] = {
		r = 0,
		g = 0,
		b = 0,
	},
	[3] = {
		r = 0,
		g = 0,
		b = 0,
	},
	[4] = {
		r = 0.1,
		g = 0.1,
		b = 0.1,
	},
	[5] = {
		r = 0.1,
		g = 0.1,
		b = 0.1,
	},
	[6] = {
		r = 0.1,
		g = 0.1,
		b = 0.1,
	},
}
CoD.ArenaUtility.EventsColors = {
	[Enum[@"hash_6C0EA92D04BC003B"][@"hash_4A9E0B7849B16CD2"]] = {
		r = 0.5,
		g = 0,
		b = 0.7,
	},
	[Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"]] = {
		r = 0.15,
		g = 0.5,
		b = 0.15,
	},
	[Enum[@"hash_6C0EA92D04BC003B"][@"hash_670DF63F42A5E56A"]] = {
		r = 0,
		g = 0,
		b = 0,
	},
	[Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"]] = {
		r = 1,
		g = 0,
		b = 0,
	},
	[Enum[@"hash_6C0EA92D04BC003B"][@"hash_4185075D2D3D8497"]] = {
		r = 0.5,
		g = 0,
		b = 0.7,
	},
}
CoD.ArenaUtility.ScheduleWidget = nil
CoD.ArenaUtility.CurrentPlaylistID = nil
CoD.ArenaUtility.CurrentEventStartOffset = nil
CoD.ArenaUtility.secondsInMinute = 60
CoD.ArenaUtility.secondsInHour = 3600
CoD.ArenaUtility.secondsInDay = 86400
CoD.ArenaUtility.GetSeason = function()
	local f1_local0, f1_local1 = nil
	if not IsLobbyNetworkModeLAN() then
		if CoD.ArenaUtility.SeasonsAsset == nil or CoD.ArenaUtility.SeasonsAsset.seasonlist.nSeasons <= 0 then
			CoD.ArenaUtility.SeasonsAsset = Engine[@"hash_2349A8E5848A2FAC"]()
		end
		local f1_local2 = CoD.ArenaUtility.SeasonsAsset
		local f1_local3 = Engine.GetCurrentArenaSeason()
		if f1_local2 ~= nil and f1_local3 >= 0 then
			local f1_local4 = f1_local2.seasonlist[f1_local3]
			if f1_local4 ~= nil then
				f1_local0 = f1_local4
				f1_local1 = f1_local4.startTime
			end
		end
	end
	if 0 < Engine[@"getdvarfloat"]("arena_day_overwrite") then
		f1_local1 = 0
	end
	return f1_local0, f1_local1
end
CoD.ArenaUtility.GetDaysHoursMinutesSecondsFromSeconds = function(f2_arg0)
	return math.floor(f2_arg0 / CoD.ArenaUtility.secondsInDay), math.floor(f2_arg0 / CoD.ArenaUtility.secondsInHour) % 24, math.floor(f2_arg0 / CoD.ArenaUtility.secondsInMinute) % 60, f2_arg0 % 60
end
CoD.ArenaUtility.GetArenaSeasonElapsedSeconds = function()
	local f3_local0 = Engine[@"hash_1783588166FFFE1E"]()
	if Engine[@"getdvarfloat"]("arena_day_overwrite") > 0 then
		f3_local0 = Engine[@"getdvarfloat"]("arena_day_overwrite") * CoD.ArenaUtility.secondsInDay
		if CoD.ArenaUtility.ArenaDayOverwriteFixedTime == -1 then
			CoD.ArenaUtility.ArenaDayOverwriteFixedTime = Engine.seconds()
		else
			f3_local0 = f3_local0 + Engine.seconds() - CoD.ArenaUtility.ArenaDayOverwriteFixedTime
		end
	end
	return f3_local0
end
CoD.ArenaUtility.DrawScheduleBox = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5, f4_arg6, f4_arg7)
	local self = LUI.UIImage.new(0, 0, f4_arg1, f4_arg1 + 1, 0, 0, f4_arg2, f4_arg2 + f4_arg4)
	self:setRGB(f4_arg5, f4_arg6, f4_arg7)
	f4_arg0:addElement(self)
	local f4_local1 = LUI.UIImage.new(0, 0, f4_arg1 + f4_arg3 - 1, f4_arg1 + f4_arg3, 0, 0, f4_arg2, f4_arg2 + f4_arg4)
	f4_local1:setRGB(f4_arg5, f4_arg6, f4_arg7)
	f4_arg0:addElement(f4_local1)
	local f4_local2 = LUI.UIImage.new(0, 0, f4_arg1, f4_arg1 + f4_arg3, 0, 0, f4_arg2, f4_arg2 + 1)
	f4_local2:setRGB(f4_arg5, f4_arg6, f4_arg7)
	f4_arg0:addElement(f4_local2)
	local f4_local3 = LUI.UIImage.new(0, 0, f4_arg1, f4_arg1 + f4_arg3, 0, 0, f4_arg2 + f4_arg4 - 1, f4_arg2 + f4_arg4)
	f4_local3:setRGB(f4_arg5, f4_arg6, f4_arg7)
	f4_arg0:addElement(f4_local3)
end
CoD.ArenaUtility.DrawScheduleDayBox = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5)
	local f5_local0 = {
		"T",
		"F",
		"S",
		"S",
		"M",
		"T",
		"W",
	}
	local f5_local1 = f5_arg1 * f5_arg2
	local f5_local2 = f5_local1 + f5_arg2
	local f5_local3 = 0
	local f5_local4 = f5_local3 + f5_arg3
	local f5_local5 = (f5_arg1 + f5_arg4) % 7
	local self = LUI.UIImage.new(0, 0, f5_local1, f5_local2, 0, 0, f5_local3, f5_local4)
	local f5_local7 = CoD.ArenaUtility.DaysColors[f5_local5]
	self:setRGB(f5_local7.r, f5_local7.g, f5_local7.b)
	f5_arg0:addElement(self)
	local f5_local8 = LUI.UIText.new(0, 0, f5_local1, f5_local2, 0, 0, f5_local3 + f5_arg5, f5_local4 - f5_arg5)
	f5_local8:setText(f5_local0[f5_local5 + 1])
	f5_local8:setTTF("default")
	f5_local8:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	f5_arg0:addElement(f5_local8)
	CoD.ArenaUtility.DrawScheduleBox(f5_arg0, f5_arg1 * f5_arg2, 0, f5_arg2, f5_arg3, 0, 0, 0)
end
CoD.ArenaUtility.CardDisplayDetails = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
	local f6_local0 = f6_arg1.ArenaPlaylistOptionInternal:getModel()
	local f6_local1 = CoD.ArenaUtility
	local f6_local2 = f6_local0.playlist
	if f6_local2 then
		f6_local2 = f6_local0.playlist:get()
	end
	f6_local1.CurrentPlaylistID = f6_local2
	f6_local1 = CoD.ArenaUtility
	f6_local2 = f6_local0.eventStartOffset
	if f6_local2 then
		f6_local2 = f6_local0.eventStartOffset:get()
	end
	f6_local1.CurrentEventStartOffset = f6_local2
end
CoD.ArenaUtility.GetEventName = function(f7_arg0)
	if f7_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4A9E0B7849B16CD2"] then
		return "ARENA/EVENT_RANKED_PLAY_NAME"
	elseif f7_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		return "ARENA/EVENT_LEAGUE_PLAY_NAME"
	elseif f7_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_670DF63F42A5E56A"] then
		return "ARENA/EVENT_INVITATIONAL_NAME"
	elseif f7_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"] then
		return "ARENA/EVENT_RUN_NAME"
	elseif f7_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4185075D2D3D8497"] then
		return "ARENA/EVENT_SCRIMS_NAME"
	else
		return nil
	end
end
CoD.ArenaUtility.GetEventDescription = function(f8_arg0)
	if f8_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4A9E0B7849B16CD2"] then
		return 0xFD3E00A4DF5D0B
	elseif f8_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		return @"hash_3810D65D59C0D1E1"
	elseif f8_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_670DF63F42A5E56A"] then
		return @"hash_1C54F06BDAF5C3D3"
	elseif f8_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"] then
		return @"hash_78622F1A00D53C00"
	elseif f8_arg0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4185075D2D3D8497"] then
		return @"hash_79ED533954F2722"
	else
		return nil
	end
end
CoD.ArenaUtility.GetPlaylistEntryForEvent = function(f9_arg0, f9_arg1)
	local f9_local0 = LuaUtils.GetArenaEventEntryPlaylistByName(f9_arg0)
	local f9_local1 = f9_local0.id
	for f9_local2 = 1, #f9_arg1, 1 do
		local f9_local5 = f9_arg1[f9_local2]
		if f9_local5 ~= nil and f9_local5.arenaSlot >= 0 and f9_local5.id == f9_local1 then
			return f9_local5
		end
	end
	return nil
end
CoD.ArenaUtility.ContainsArenaPlaylists = function(f10_arg0)
	for f10_local0 = 1, #f10_arg0, 1 do
		local f10_local3 = f10_arg0[f10_local0]
		if f10_local3 ~= nil and f10_local3.arenaSlot > 0 then
			return true
		end
	end
	return false
end
CoD.ArenaUtility.SortEventEntries = function(f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0.eventEntry
	local f11_local1 = f11_arg1.eventEntry
	if f11_local0.startOffset == f11_local1.startOffset then
		local f11_local2 = LuaUtils.GetArenaEventEntryPlaylistByName(f11_local0)
		local f11_local3 = f11_local2.id
		local f11_local4 = LuaUtils.GetArenaEventEntryPlaylistByName(f11_local1)
		return f11_local3 < f11_local4.id
	else
		return f11_local0.startOffset < f11_local1.startOffset
	end
end
CoD.ArenaUtility.SetArenaDisplayRankAndIcon = function(f12_arg0)
	local f12_local0 = nil
	if f12_arg0.isLocal then
		local f12_local1 = Engine.GetControllerForXuid(f12_arg0.xuid)
		if f12_local1 ~= Enum[@"controllerindex_t"][@"invalid_controller_port"] then
			f12_local0 = CoD.ArenaLeaguePlayUtility.GetLeaguePlayIconAndRank(CoD.ArenaLeaguePlayUtility.GetPoints(f12_local1), CoD.ArenaLeaguePlayUtility.GetBestRank(f12_local1), CoD.ArenaLeaguePlayUtility.GetFirstPlaceCount(f12_local1))
		end
	end
	if f12_local0 == nil then
		f12_local0 = CoD.ArenaLeaguePlayUtility.GetLeaguePlayIconAndRank(f12_arg0.arenaLeaguePlayPoints, f12_arg0.arenaLeaguePlayBestSubdivisionRank, f12_arg0.arenaLeaguePlayFirstSubdivisionRankTotal)
	end
	f12_arg0.displayRank = f12_local0.displayRank
	f12_arg0.rankIcon = f12_local0.rankIcon
	local f12_local1, f12_local2 = CoD.ArenaLeaguePlayUtility.GetBanner(f12_arg0.arenaLeaguePlayPoints, f12_arg0.arenaLeaguePlayBestSubdivisionRank, f12_arg0.arenaLeaguePlayFirstSubdivisionRankTotal)
	return Engine[@"hash_4F9F1239CFD921FE"](f12_local2)
end
CoD.ArenaUtility.IsClientInTeam = function(f13_arg0, f13_arg1)
	for f13_local3, f13_local4 in ipairs(f13_arg1) do
		if f13_arg0 == f13_local4 then
			return true
		end
	end
	return false
end
CoD.ArenaUtility.IsTeamComplete = function(f14_arg0, f14_arg1)
	local f14_local0 = 2
	if #f14_arg0 ~= f14_local0 or #f14_arg1 < f14_local0 then
		return false
	end
	for f14_local4, f14_local5 in ipairs(f14_arg0) do
		if not CoD.ArenaUtility.IsClientInTeam(f14_local5.xuid, f14_arg1) then
			return false
		end
	end
	return true
end
CoD.ArenaUtility.GetCurrentTeamIndexAndId = function(f15_arg0)
	local f15_local0 = CoD.ClanUtility.GetControllerClanModel(f15_arg0)
	if f15_local0 == nil or f15_local0.teams == nil or f15_local0.teams.count:get() == 0 then
		return {
			index = -1,
			id = -1,
		}
	end
	local f15_local1 = CoD.LobbyUtility.GetClientList()
	local f15_local2 = f15_local0.teams.count:get()
	for f15_local3 = 1, f15_local2, 1 do
		local f15_local6 = f15_local0.teams["team" .. f15_local3]
		if CoD.ArenaUtility.IsTeamComplete(f15_local1, CoD.ClanUtility.GetMembersFilteredList(f15_arg0, f15_local6.kind:get(), f15_local6.ID:get())) then
			return {
				index = f15_local3,
				id = f15_local6.ID:get(),
			}
		end
	end
	return {
		index = -1,
		id = -1,
	}
end
CoD.ArenaUtility.GetArenaSlot = function(f16_arg0)
	local f16_local0 = nil
	local f16_local1 = Engine[@"getplaylistinfobyid"](f16_arg0)
	if f16_local1 ~= nil then
		f16_local0 = f16_local1.arenaSlot
	end
	return f16_local0
end
CoD.ArenaUtility.GetArenaSlotFromPlaylistOrEngine = function(f17_arg0)
	if not f17_arg0 then
		f17_arg0 = Engine[@"getplaylistid"]()
	end
	local f17_local0 = Engine.GetCurrentArenaSlot()
	if f17_local0 < 0 then
		f17_local0 = CoD.ArenaUtility.GetArenaSlot(f17_arg0)
	end
	if f17_local0 < 0 then
		f17_local0 = 0
	end
	return f17_local0
end
CoD.ArenaUtility.CheckArenaStats = function(f18_arg0, f18_arg1)
	if (CoD.ArenaLeaguePlayUtility.CheckLeagueID(f18_arg0, f18_arg1) or CoD.ArenaRankedPlayUtility.CheckSeason(f18_arg0)) == true then
		Engine.exec(f18_arg0, "uploadstats")
	end
end
CoD.ArenaUtility.ClearMatchesStats = function(f19_arg0)
	f19_arg0.streak:set(0)
	f19_arg0.bestStreak:set(0)
	f19_arg0.wins:set(0)
	f19_arg0.losses:set(0)
	f19_arg0.lossesLateJoin:set(0)
	f19_arg0.ties:set(0)
	f19_arg0.matchCount:set(0)
end
CoD.ArenaUtility.DelayFuncCall = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
	if not f20_arg2 then
		return
	elseif not f20_arg1 then
		f20_arg1 = 0
	end
	f20_arg0:addElement(LUI.UITimer.newElementTimer(f20_arg1, true, function()
		if f20_arg3 then
			f20_arg2(unpack(f20_arg3))
		else
			f20_arg2()
		end
	end))
end
CoD.ArenaUtility.InitLadderListLoadedModel = function(f22_arg0)
	local f22_local0 = DataSources.LeaguePlayLadderMemberList.getModel(f22_arg0)
	local f22_local1 = nil
	f22_local1 = f22_local0:create("allXuidInfoLoaded")
	if not f22_local1:get() then
		f22_local1:set(false)
	end
	f22_local1 = f22_local0:create("count")
	if not f22_local1:get() then
		f22_local1:set(0)
	end
end
CoD.ArenaUtility.PostLoad = function(f23_arg0, f23_arg1)
	CoD.ArenaUtility.UpdateArenaOnLobbyNav()
	f23_arg1.CommonHeader:unsubscribeFromGlobalModels()
	f23_arg1.CommonHeader.subtitle:unsubscribeFromGlobalModels()
	f23_arg1.CommonHeader.subtitle.subtitle:unsubscribeFromGlobalModels()
	f23_arg1.CommonHeader:subscribeToGlobalModel(f23_arg0, "Arena", "arenaEventName", function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			f23_arg1.CommonHeader.subtitle.subtitle:setText(f24_local0)
		end
	end)
end
CoD.ArenaUtility.ClearCurrentPlaylistID = function(f25_arg0)
	CoD.ArenaUtility.CurrentPlaylistID = nil
end
CoD.ArenaUtility.ShowCurrentEventDetails = function(f26_arg0)
	f26_arg0.RankedPlayDetails:hide()
	f26_arg0.LeaguePlayDetails:hide()
	f26_arg0.InvitationalDetails:hide()
	local f26_local0 = LuaUtils.GetEventEntry(CoD.ArenaUtility.CurrentEventStartOffset)
	if not f26_local0 then
		return nil
	end
	local f26_local1 = DataSources.Arena.getModel()
	local f26_local2 = LuaUtils.GetArenaEventEntryPlaylistByName(f26_local0)
	local f26_local3 = f26_local2.arenaSlot
	local f26_local4 = Engine.GetPrimaryController()
	if f26_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4A9E0B7849B16CD2"] then
		local f26_local5 = f26_local1:create("arenaSubtitle")
		f26_local5:set("arena/event_ranked_play_name")
		f26_arg0.RankedPlayDetails:show()
	elseif f26_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		local f26_local5 = f26_local1:create("arenaSubtitle")
		f26_local5:set("arena/event_league_play_name")
		f26_arg0.LeaguePlayDetails:show()
	elseif f26_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_670DF63F42A5E56A"] then
		DataSources.InvitationalDetails.PopulateWidget(f26_arg0.InvitationalDetails, f26_local4, f26_local3, Engine[@"hash_2E00B2F29271C60B"](f26_local0.event))
		local f26_local6 = f26_local1:create("arenaSubtitle")
		f26_local6:set("arena/event_invitational_name")
		f26_arg0.InvitationalDetails:show()
	elseif f26_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"] then
		local f26_local5 = f26_local1:create("arenaSubtitle")
		f26_local5:set("arena/event_run_name")
	elseif f26_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4185075D2D3D8497"] then
		local f26_local5 = f26_local1:create("arenaSubtitle")
		f26_local5:set("arena/event_scrims_name")
	end
end
CoD.ArenaUtility.UpdateNewsTabDisplay = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
	if f27_arg1.tabId == "news" then
		f27_arg3.ArenaNews:setAlpha(1)
	else
		f27_arg3.ArenaNews:setAlpha(0)
	end
end
CoD.ArenaUtility.GetDisplayName = function()
	local f28_local0 = Engine[@"hash_1FB9BB235992D6F7"]()
	local f28_local1 = ""
	if f28_local0 then
		f28_local1 = 0x29B029BA1AA475F
	else
		for f28_local7, f28_local8 in ipairs(CoD.LobbyUtility.GetClientList()) do
			if f28_local8.isLocal == 1 then
				local f28_local5 = f28_local8.gamertag
				local f28_local6 = ""
				if string.len(f28_local8.clantag) > 0 then
				else
					f28_local1 = f28_local6 .. f28_local5
					break
				end
				f28_local6 = "[" .. f28_local8.clantag .. "]"
			end
		end
	end
	local f28_local9 = DataSources.Arena.getModel()
	local f28_local2 = f28_local9:create("playerOrTeamDisplayName")
	f28_local2:set(f28_local1)
end
CoD.ArenaUtility.ArenaQuitGame = function(f29_arg0, f29_arg1, f29_arg2)
	CoD.OverlayUtility.CreateOverlay(f29_arg2, f29_arg0, "ArenaQuitNotification")
end
CoD.ArenaUtility.CurrentArenaEventTypeEquals = function(f30_arg0, f30_arg1)
	if not LuaUtils.IsArenaPublicGame() then
		return false
	else
		local f30_local0 = LuaUtils.GetCurrentEventEntry()
		if f30_local0 == nil then
			return false
		else
			return f30_local0.eventType == f30_arg1
		end
	end
end
CoD.ArenaUtility.UpcomingArenaEventTypeEquals = function(f31_arg0, f31_arg1)
	if not LuaUtils.IsArenaPublicGame() then
		return false
	else
		local f31_local0 = LuaUtils.GetUpcomingEventEntry()
		if f31_local0 == nil then
			return false
		else
			return f31_local0.eventType == f31_arg1
		end
	end
end
CoD.ArenaUtility.IsEventCompleteTimer = function(f32_arg0, f32_arg1, f32_arg2)
	local f32_local0 = LuaUtils.GetCurrentEventEntry()
	if f32_local0.eventType ~= Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		return false
	else
		return true
	end
end
CoD.ArenaUtility.IsNextEventCompleteTimer = function(f33_arg0, f33_arg1, f33_arg2)
	local f33_local0 = LuaUtils.GetUpcomingEventEntry()
	if f33_local0 == nil or f33_local0.eventType ~= Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		return false
	else
		return true
	end
end
CoD.ArenaUtility.IsArenaLeaguePlay = function(f34_arg0)
	if not LuaUtils.IsArenaPublicGame() then
		return false
	end
	local f34_local0 = CoD.ArenaUtility.CurrentArenaEventTypeEquals(nil, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"])
	if f34_arg0 and not f34_local0 then
		f34_local0 = CoD.ArenaUtility.UpcomingArenaEventTypeEquals(nil, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"])
	end
	return f34_local0
end
CoD.ArenaUtility.IsInTeam = function(f35_arg0)
	local f35_local0 = CoD.ArenaUtility.GetCurrentTeamIndexAndId(f35_arg0)
	return f35_local0.id ~= -1
end
CoD.ArenaUtility.ArenaMatchSet = function(f36_arg0)
	if CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.START_MATCH) then
		return true
	else
		return false
	end
end
CoD.ArenaUtility.IsDailyPoolRemainingCompleteTimer = function(f37_arg0, f37_arg1, f37_arg2)
	local f37_local0 = LuaUtils.GetCurrentEventEntry()
	if f37_local0.eventType ~= Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		return false
	elseif f37_arg2.arenaLeaguePlayDailyPoolTimer then
		f37_arg2.arenaLeaguePlayDailyPoolTimer:close()
		f37_arg2.arenaLeaguePlayDailyPoolTimer = nil
	end
	local f37_local1 = Engine.GetModel(Engine.GetGlobalModel(), "Arena.arenaLeaguePlayDailyPoolTimer")
	if f37_local1 == nil then
		return false
	end
	f37_arg2.arenaLeaguePlayDailyPoolTimer = LUI.UITimer.newElementTimer(500, false, function(f38_arg0)
		local f38_local0 = CoD.ArenaLeaguePlayUtility.GetDailyBonusPoolTimeRemaining(f37_arg1, CoD.ArenaUtility.GetArenaSlotFromPlaylistOrEngine())
		if f38_local0 > 0 then
			f37_local1:set(Engine[@"hash_2EFB3C7874640AD1"](f38_local0))
		else
			f37_local1:set("")
			UpdateState(f37_arg2, {
				name = "update_state",
				controller = f37_arg1,
			})
			f37_arg2.arenaLeaguePlayDailyPoolTimer:close()
			f37_arg2.arenaLeaguePlayDailyPoolTimer = nil
		end
	end)
	f37_arg2:addElement(f37_arg2.arenaLeaguePlayDailyPoolTimer)
	return true
end
CoD.ArenaUtility.IsPlayerMatchmakingLocked = function(f39_arg0)
	return true
end
CoD.ArenaUtility.UpdateArenaOnLobbyNav = function()
	local f40_local0 = LobbyData.GetCurrentMenuTarget()
	if f40_local0.LobbyMode ~= Enum.LobbyMode[@"lobby_mode_arena"] then
		return
	end
	local f40_local1 = CoD.ArenaUtility.GetArenaSlotFromPlaylistOrEngine(Engine[@"getplaylistid"]())
	local f40_local2 = Engine.GetPrimaryController()
	local f40_local3 = Engine.GetGlobalModel()
	local f40_local4 = f40_local3.Arena
	local f40_local5 = f40_local3.LeaguePlay
	if f40_local0.id == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) then
		CoD.ArenaUtility.CheckArenaStats(f40_local2, f40_local1)
		CoD.ArenaLeaguePlayUtility.CheckIfProcessingLeagueID(f40_local2)
	end
	local f40_local6 = Engine.GetArenaPoints(f40_local2, f40_local1)
	local f40_local7 = CoD.ArenaRankedPlayUtility.GetDisplayRankString(f40_local6)
	local f40_local8 = CoD.ArenaRankedPlayUtility.GetStarCount(f40_local6)
	local f40_local9 = CoD.ArenaRankedPlayUtility.GetArenaRankIcon(f40_local6)
	local f40_local10 = CoD.ArenaRankedPlayUtility.GetArenaRankIconLarge(f40_local6)
	local f40_local11 = f40_local4:create("arenaRank")
	f40_local11:set(f40_local7)
	f40_local11 = f40_local4:create("arenaStars")
	f40_local11:set(f40_local8)
	f40_local11 = f40_local4:create("arenaRankIcon")
	f40_local11:set(f40_local9)
	f40_local11 = f40_local4:create("arenaRankIconLarge")
	f40_local11:set(f40_local10)
	f40_local11 = LuaUtils.GetCurrentEventEntry()
	local f40_local12 = LuaUtils.GetArenaEventEntryPlaylistByName(f40_local11)
	local f40_local13 = f40_local4:create("arenaEventName")
	f40_local13:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ArenaUtility.GetEventName(f40_local11)))
	f40_local13 = f40_local4:create("arenaPlaylistName")
	f40_local13:set(Engine[@"hash_4F9F1239CFD921FE"](f40_local12.name))
	local f40_local14, f40_local15, f40_local16, f40_local17 = CoD.ArenaUtility.GetDaysHoursMinutesSecondsFromSeconds(f40_local11.endOffset - CoD.ArenaUtility.GetArenaSeasonElapsedSeconds())
	local f40_local18 = f40_local4:create("endsInInfo")
	f40_local18:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_21F21B24D48D430C", f40_local14, f40_local15, f40_local16))
	f40_local18 = Engine.GetPrimaryController()
	local f40_local19 = CoD.ArenaUtility.GetCurrentTeamIndexAndId(f40_local18)
	if f40_local19.id ~= -1 then
		local f40_local20 = f40_local4:create("currentTeamId")
		f40_local20:set(f40_local19.id)
		local f40_local21 = f40_local3.socialRoot:create("clans")
		f40_local21 = f40_local21:create("listTeams")
		local f40_local22 = f40_local21[Engine[@"xuidtostring"](f40_local19.id)]
		if f40_local22 then
			local f40_local23 = f40_local4:create("currentTeamName")
			f40_local23:set(f40_local22.name:get())
		end
		local f40_local23 = Engine.StorageGetBuffer(f40_local18, Enum.StorageFileType[@"hash_6423A66A665DE4DF"], LuaEnum.TEAM_STORAGE_SLOT.TEAM_1_DATA - 1 + f40_local19.index)
		if f40_local23 ~= nil and f40_local1 ~= -1 then
			local f40_local24 = f40_local23.arenaStats[f40_local1].leaguePlayStats.subdivisionPoints:get()
			local f40_local25 = f40_local23.arenaStats[f40_local1].leaguePlayStats.subdivisionRank:get()
			local f40_local26 = f40_local4:create("currentTeamSubdivisionPoints")
			f40_local26:set(f40_local24)
			f40_local26 = f40_local4:create("currentTeamSubdivisionRank")
			f40_local26:set(f40_local25)
		end
	else
		local f40_local20 = f40_local4:create("currentTeamId")
		f40_local20:set(LuaDefine.INVALID_XUID_X64)
		f40_local20 = f40_local4:create("currentTeamSubdivisionPoints")
		f40_local20:set(0)
		f40_local20 = f40_local4:create("currentTeamSubdivisionRank")
		f40_local20:set(0)
	end
	CoD.ArenaUtility.PopulateStats(f40_local18)
end
CoD.ArenaUtility.SetArenaModel = function(f41_arg0, f41_arg1)
	local f41_local0 = DataSources.Arena
	if f41_local0 then
		f41_local0 = DataSources.Arena:getModel()
	end
	local f41_local1 = f41_local0 and f41_local0:create(f41_arg0)
	if f41_local1 then
		return f41_local1:set(f41_arg1)
	else
		return false
	end
end
DataSources.Arena = {
	Initialize = function()
		if not DataSources.Arena.subscriptionElement then
			DataSources.Arena.subscriptionElement = LUI.UIElement.new()
			DataSources.Arena.subscriptionElement.updateDataSource = CoD.ArenaUtility.UpdateArenaOnLobbyNav
			CoD.DirectorUtility.AddLobbyNavSubscriptionOnce(DataSources.Arena.subscriptionElement)
			if not DataSources.Arena.subscriptionElement._hasTeamsChangeSubscription then
				DataSources.Arena.subscriptionElement._hasTeamsChangeSubscription = true
				DataSources.Arena.subscriptionElement:subscribeToModel(Engine.CreateModel(Engine.GetGlobalModel(), "socialRoot.clans.listTeams"), function()
					DataSources.Arena.subscriptionElement:updateDataSource(false, false)
				end, false)
			end
		end
	end,
	getModel = function()
		DataSources.Arena.Initialize()
		local f44_local0 = Engine.GetGlobalModel()
		if not DataSources.Arena.HasCreatedModels then
			local f44_local1 = f44_local0:create("Arena")
			local f44_local2 = Engine.GetCurrentArenaSeason()
			local f44_local3 = Engine.GetCurrentArenaSeasonTimeRemaining()
			local f44_local4 = f44_local1:create("season")
			f44_local4:set(f44_local2)
			f44_local4 = f44_local1:create("seasonTimeleft")
			f44_local4:set(f44_local3)
			f44_local4 = f44_local1:create("arenaTitle")
			f44_local4:set(@"hash_1B59895A7A19714A")
			f44_local1:create("arenaSubtitle")
			f44_local1:create("arenaEventName")
			f44_local1:create("arenaPlaylistName")
			f44_local1:create("gameModes")
			f44_local1:create("mapList")
			f44_local1:create("modeList")
			f44_local1:create("gameModeAdditionalInfo")
			f44_local1:create("endsInInfo")
			f44_local1:create("arenaEventDescription")
			f44_local1:create("teamFormat")
			f44_local1:create("teamSize")
			f44_local1:create("playerOrTeamDisplayName")
			f44_local1:create("arenaEventTimer")
			f44_local1:create("arenaNextEventTimer")
			f44_local1:create("lockoutTimeRemaining")
			f44_local1:create("arenaLeaguePlayDailyPoolTimer")
			f44_local1:create("arenaLeaguePlayShowEndRankUp")
			f44_local1:create("triggerEndOfEvent")
			f44_local1:create("arenaLeaguePlayShowDelayedResultsPopup")
			f44_local1:create("processingEvent")
			f44_local1:create("currentTeamName")
			f44_local1:create("currentTeamId")
			DataSources.Arena.HasCreatedModels = true
		end
		return f44_local0.Arena
	end,
}
DataSources.LeaguePlayLeaderboardMenuTabs = ListHelper_SetupDataSource("LeaguePlayLeaderboardMenuTabs", function(f45_arg0)
	local f45_local0 = {}
	table.insert(f45_local0, {
		models = {
			tabName = @"hash_6FBD29F62B3124E9",
			tabWidget = "CoD.LeaguePlayLeaderboardTab",
			tabIcon = "",
		},
		properties = {
			tabId = "solo",
		},
	})
	return f45_local0
end, true)
DataSources.ArenaPlaylistGameModesMaps = ListHelper_SetupDataSource("ArenaPlaylistGameModesMaps", function(f46_arg0)
	local f46_local0 = {}
	local f46_local1 = Engine[@"getplaylistinfobyid"](Engine[@"getplaylistid"]())
	local f46_local2 = nil
	for f46_local9, f46_local10 in ipairs(f46_local1.rotationList) do
		if f46_local10.gametype ~= f46_local2 then
			local f46_local6 = Engine[@"hash_1F2CD89B3C345FD3"](f46_local10.gametype)
			local f46_local7 = f46_local6.gametype
			table.insert(f46_local0, {
				models = {
					modesTitleString = CoD.GameTypeUtility.GameTypeToLocalizeName(f46_local7),
					modesString = "",
					modesIcon = CoD.GameTypeUtility.GameTypeToImage(f46_local7),
					modesDesc = CoD.GameTypeUtility.GameTypeToLocalizeDesc(f46_local7),
				},
				properties = {
					mapList = {},
					gameMode = f46_local7,
				},
			})
		end
		local f46_local6 = CoD.MapUtility.MapNameToLocalizedName(f46_local10.map)
		table.insert(f46_local0[#f46_local0].properties.mapList, CoD.MapUtility.GetMapValue(f46_local10.map, "mapName", ""))
		local f46_local8 = f46_local0[#f46_local0].models.modesString
		if f46_local8 == "" then
			f46_local8 = CoD.MapUtility.MapNameToLocalizedName(f46_local10.map)
		else
			f46_local8 = f46_local8 .. ", " .. CoD.MapUtility.MapNameToLocalizedName(f46_local10.map)
		end
		f46_local0[#f46_local0].models.modesString = f46_local8
		f46_local2 = f46_local10.gametype
	end
	for f46_local9, f46_local10 in ipairs(f46_local0) do
		if f46_local10.properties and f46_local10.properties.mapList then
			f46_local10.models.mapList = CoD.ArenaUtility.ModeMapListPrepareHelper(f46_arg0, f46_local9, f46_local10.properties.mapList)
		end
	end
	return f46_local0
end)
CoD.ArenaUtility.ModeMapListPrepareHelper = function(f47_arg0, f47_arg1, f47_arg2)
	local f47_local0 = "CWLMapList_" .. f47_arg1
	DataSources[f47_local0] = DataSourceHelpers.ListSetup(f47_local0, function(f48_arg0, f48_arg1)
		local f48_local0 = {}
		for f48_local4, f48_local5 in ipairs(f47_arg2) do
			table.insert(f48_local0, {
				models = {
					displayText = f48_local5,
				},
			})
		end
		return f48_local0
	end)
	return f47_local0
end
CoD.ArenaUtility.PopulateStats = function(f49_arg0)
	if CoD.ArenaUtility.CurrentPlaylistID ~= nil then
		return
	elseif LuaUtils.MPArenaDisabled() then
		return
	end
	local f49_local0, f49_local1 = LuaUtils.GetCurrentEventEntryAndUpcoming()
	if not f49_local0 then
		return nil
	end
	local f49_local2 = LuaUtils.GetArenaEventEntryPlaylistByName(f49_local0)
	local f49_local3 = DataSources.Arena.getModel()
	local f49_local4 = f49_local3:create("arenaEventName")
	f49_local4:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ArenaUtility.GetEventName(f49_local0)))
	f49_local4 = f49_local3:create("arenaPlaylistName")
	f49_local4:set(Engine[@"hash_4F9F1239CFD921FE"](f49_local2.name))
	f49_local4 = {}
	local f49_local5 = {}
	DataSources.PlaylistGameModes = ListHelper_SetupDataSource("PlaylistGameModes", function(f50_arg0)
		local f50_local0 = ""
		for f50_local6, f50_local7 in ipairs(f49_local2.rotationList) do
			if f50_local7.gametype ~= f50_local0 then
				local f50_local4 = Engine[@"hash_1F2CD89B3C345FD3"](f50_local7.gametype)
				local f50_local5 = f50_local4.gametype
				table.insert(f49_local5, {
					models = {
						gameMode = CoD.GameTypeUtility.GameTypeToLocalizeName(f50_local5),
						image = CoD.GameTypeUtility.GameTypeToImage(f50_local5),
					},
					properties = {},
				})
			end
			f49_local4[f50_local7.map] = CoD.MapUtility.MapNameToLocalizedName(f50_local7.map)
			f50_local0 = f50_local7.gametype
		end
		for f50_local2 = #f49_local5 + 1, 4, 1 do
			f50_local7 = f50_local2
			table.insert(f49_local5, {
				models = {
					gameMode = "",
					image = "$blacktransparent",
				},
				properties = {},
			})
		end
		return f49_local5
	end, true)
	local f49_local6 = ""
	for f49_local10, f49_local11 in pairs(f49_local5) do
		if f49_local11.models.gameMode ~= "" then
			if f49_local6 == "" then
				f49_local6 = f49_local11.models.gameMode
			else
				f49_local6 = f49_local6 .. ", " .. f49_local11.models.gameMode
			end
		end
	end
	f49_local7 = f49_local3:create("modeList")
	f49_local7:set(f49_local6)
	f49_local7 = ""
	for f49_local11, f49_local12 in pairs(f49_local4) do
		if f49_local7 == "" then
			f49_local7 = f49_local12
		else
			f49_local7 = f49_local7 .. ", " .. f49_local12
		end
	end
	f49_local8 = f49_local3:create("mapList")
	f49_local8:set(f49_local7)
	f49_local8 = f49_local2.maxPartySize
	f49_local9 = f49_local3:create("arenaEventDescription")
	f49_local9:set(Engine[@"hash_4F9F1239CFD921FE"](CoD.ArenaUtility.GetEventDescription(f49_local0)))
	f49_local9 = f49_local3:create("teamFormat")
	f49_local9:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_14CFE4C1B8478DCF", f49_local8, f49_local8))
	f49_local9 = f49_local3:create("teamSize")
	f49_local9:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_368C8D890C6A5835", f49_local8))
	local f49_local10, f49_local11, f49_local12, f49_local13 = CoD.ArenaUtility.GetDaysHoursMinutesSecondsFromSeconds(f49_local0.endOffset - CoD.ArenaUtility.GetArenaSeasonElapsedSeconds())
	if f49_local0.changesDaily and f49_local1 ~= nil then
		local f49_local14 = LuaUtils.GetArenaEventEntryPlaylistByName(f49_local1)
		local f49_local15 = Engine[@"hash_1F2CD89B3C345FD3"](f49_local14.rotationList[1].gametype)
		local f49_local16 = CoD.GameTypeUtility.GameTypeToLocalizeName(Engine[@"converttoxhash"](f49_local15.gametype))
		local f49_local17 = f49_local3:create("gameModeAdditionalInfo")
		f49_local17:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_17E18E188D686F77", f49_local16, f49_local11, f49_local12))
	else
		local f49_local14 = f49_local3:create("gameModeAdditionalInfo")
		f49_local14:set("")
	end
	if f49_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] or f49_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"] then
		local f49_local14 = LuaUtils.GetArenaSeason()
		local f49_local18 = f49_local14.endTime - f49_local14.endTime
		if f49_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"] then
			f49_local18 = f49_local0.endOffset
		elseif f49_local1 ~= nil then
			f49_local18 = f49_local1.startOffset
		end
		f49_local10, f49_local11, f49_local12, f49_local13 = CoD.ArenaUtility.GetDaysHoursMinutesSecondsFromSeconds(f49_local18 - CoD.ArenaUtility.GetArenaSeasonElapsedSeconds())
		local f49_local15 = f49_local3:create("endsInInfo")
		f49_local15:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_21F21B24D48D430C", f49_local10, f49_local11, f49_local12))
	else
		local f49_local14 = f49_local3:create("endsInInfo")
		f49_local14:set("")
	end
	local f49_local14 = CoD.ArenaUtility.GetArenaSeasonElapsedSeconds()
	local f49_local18 = f49_local2.arenaSlot
	if f49_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4A9E0B7849B16CD2"] then
		local f49_local15 = f49_local3:create("arenaSubtitle")
		f49_local15:set("arena/event_ranked_play_name")
	elseif f49_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		DataSources.LeaguePlay.PopulateWidget(f49_arg0, f49_local18, Engine[@"hash_2E00B2F29271C60B"](f49_local0.event))
		DataSources.ArenaGauntlet.PopulateWidget(f49_arg0)
		local f49_local19 = f49_local3:create("arenaSubtitle")
		f49_local19:set("arena/event_league_play_name")
	elseif f49_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_670DF63F42A5E56A"] then
		local f49_local15 = Engine[@"hash_2E00B2F29271C60B"](f49_local0.event)
		local f49_local19 = f49_local0.startOffset <= f49_local14
		local f49_local16 = f49_local3:create("arenaSubtitle")
		f49_local16:set("arena/event_invitational_name")
	elseif f49_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"] then
		local f49_local15 = f49_local3:create("arenaSubtitle")
		f49_local15:set("arena/event_run_name")
	elseif f49_local0.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4185075D2D3D8497"] then
		DataSources.LeaguePlay.PopulateWidget(f49_arg0, f49_local18, nil)
		local f49_local15 = f49_local3:create("arenaSubtitle")
		f49_local15:set("arena/event_scrims_name")
	end
	if f49_local1 and f49_local1.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] then
		DataSources.LeaguePlay.PopulateWidget(f49_arg0, f49_local18, nil)
	end
end
CoD.ArenaUtility.TryAddDevPlaylist = function(f51_arg0, f51_arg1, f51_arg2)
	if f51_arg2 and #f51_arg2 == 1 and f51_arg2[1].arenaSlot == 0 then
		local f51_local0 = CoD.ArenaUtility.GetArenaSeasonElapsedSeconds()
		local f51_local1 = f51_arg2[1]
		f51_arg0.cards[#f51_arg0.cards + 1] = {
			id = f51_arg1 .. "Ent" .. 0,
			playlist = f51_local1.id,
			name = Engine[@"hash_4F9F1239CFD921FE"](f51_local1.name),
			detailedDesc = f51_local1.description,
			icon = f51_local1.image,
			iconBackground = f51_local1.imageBackground,
			iconBackgroundFocus = f51_local1.imageBackgroundFocus,
			action = CoD.DirectorUtility.CardNavigateToLobby,
			secondaryAction = CoD.ArenaUtility.CardDisplayDetails,
			mode = f51_local1.mainMode,
			locked = false,
			lockState = f51_local1.lockState,
			featured = false,
			eventStartOffset = f51_local0,
			eventName = "ARENA/ARENA_PLAYLIST_DEV",
		}
	end
end
CoD.ArenaUtility.CreateArenaCards = function(f52_arg0, f52_arg1, f52_arg2, f52_arg3)
	if not CoD.ArenaUtility.ContainsArenaPlaylists(f52_arg3) then
		CoD.ArenaUtility.TryAddDevPlaylist(f52_arg0, f52_arg2, f52_arg3)
		return
	end
	local f52_local0 = CoD.ArenaUtility.GetArenaSeasonElapsedSeconds()
	local f52_local1 = LuaUtils.ArenaSeasonAsset.seasonlist[Engine.GetCurrentArenaSeason()]
	local f52_local2 = {}
	for f52_local12, f52_local13 in ipairs(f52_local1.schedulelist) do
		for f52_local6, f52_local7 in ipairs(f52_local13.eventlist) do
			local f52_local9, f52_local10 = LuaUtils.GetEventStartAndDuration(f52_local13, f52_local6, f52_local7, dayCount)
			local f52_local11 = f52_local9 + f52_local10
			if f52_local0 < f52_local11 then
				f52_local2[#f52_local2 + 1] = {
					eventEntry = f52_local7,
					endOffset = f52_local11,
				}
			end
		end
	end
	table.sort(f52_local2, CoD.ArenaUtility.SortEventEntries)
	f52_local3 = false
	for f52_local13, f52_local14 in ipairs(f52_local2) do
		local f52_local15 = f52_local14.eventEntry
		local f52_local8 = CoD.ArenaUtility.GetPlaylistEntryForEvent(f52_local15, f52_arg3)
		if f52_local8 then
			local f52_local6 = f52_local15.startOffset <= f52_local0
			local f52_local7 = ""
			if not f52_local6 then
				local f52_local9 = (f52_local15.startOffset - f52_local0) / CoD.ArenaUtility.secondsInDay
				if f52_local9 == 1 then
					f52_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_145217C57F61BD3C")
				else
					f52_local7 = LocalizeIntoString(@"hash_3855D6B0C3E27F88", f52_local9)
				end
			end
			local f52_local9, f52_local10, f52_local11, f52_local16 = CoD.ArenaUtility.GetDaysHoursMinutesSecondsFromSeconds(f52_local15.endOffset - f52_local0)
			local f52_local17 = ""
			local f52_local18 = "$blacktransparent"
			local f52_local19 = f52_local6 and not f52_local15.changesDaily
			local f52_local20 = not f52_local6
			if f52_local15.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4A9E0B7849B16CD2"] or f52_local15.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_4185075D2D3D8497"] then
				f52_local19 = false
				if f52_local15.changesDaily then
					f52_local17 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4303C2808FF513FF")
					if f52_local6 then
						f52_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2F8ECCF00FD98637", f52_local10, f52_local11)
					end
				end
			elseif f52_local15.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"] or f52_local15.eventType == Enum[@"hash_6C0EA92D04BC003B"][@"hash_33603CAC0849A965"] then
				f52_local17 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_149073FF7D7F70AC")
				if f52_local6 then
					f52_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_21F21B24D48D430C", f52_local9, f52_local10, f52_local11)
				end
			end
			local f52_local21 = false
			local f52_local22 = false
			if CoD.DirectorUtility.DisableForCurrentMilestone(f52_arg1) then
				local f52_local23 = Engine.GetXPScale(f52_arg1)
				f52_local21 = f52_local23 and f52_local23 >= 2
				local f52_local24 = Engine.GetGunXPScale(f52_arg1)
				f52_local22 = f52_local24 and f52_local24 >= 2
			else
				local f52_local23 = LuaUtils.PlaylistRulesIncludes(f52_local8.rules, @"xpgroups", "group_party2")
				local f52_local25 = LuaUtils.PlaylistRulesIncludes(f52_local8.rules, "scr_xpscalemp", "2")
				if f52_local23 and 2 > totalPartyCount - guestCount then
					f52_local21 = false
				else
					f52_local21 = f52_local25 and true
				end
				f52_local22 = LuaUtils.PlaylistRulesIncludes(f52_local8.rules, @"scr_gunxpscalemp", "2")
			end
			if not f52_local3 then
				f52_local3 = f52_local19
			end
			local f52_local23 = f52_arg0.cards
			local f52_local24 = #f52_arg0.cards + 1
			local f52_local26 = {
				id = f52_arg2 .. "Ent" .. f52_local13,
				playlist = f52_local8.id,
				name = Engine[@"hash_4F9F1239CFD921FE"](f52_local8.name),
				detailedDesc = f52_local8.description,
				icon = f52_local8.image,
				iconBackground = f52_local8.imageBackground,
				iconBackgroundFocus = f52_local8.imageBackgroundFocus,
			}
			local f52_local27
			if f52_local6 then
				f52_local27 = CoD.DirectorUtility.CardNavigateToLobby
				if not f52_local27 then
				else
					f52_local26.action = f52_local27
					f52_local26.secondaryAction = CoD.ArenaUtility.CardDisplayDetails
					f52_local26.mode = f52_local8.mainMode
					f52_local26.featured = f52_local19
					f52_local26.locked = f52_local20
					f52_local26.lockState = f52_local8.lockState
					f52_local26.hasDoubleXP = f52_local21
					f52_local26.hasDoubleWeaponXP = f52_local22
					f52_local26.showForAllClients = false
					f52_local26.eventStartOffset = f52_local15.startOffset
					f52_local26.eventFutureNotice = f52_local7
					f52_local26.eventAdditionalInfo = f52_local17
					f52_local26.eventName = CoD.ArenaUtility.GetEventName(f52_local15)
					f52_local26.eventType = f52_local15.eventType
					f52_local26.arenaPoints = Engine.GetArenaPoints(f52_arg1, f52_local8.arenaSlot)
					f52_local26.leaguePlayDivisionIcon = f52_local18
					f52_local23[f52_local24] = f52_local26
				end
			end
			f52_local27 = nil
		end
	end
	if not f52_local3 then
		f52_arg0.cards[1].featured = true
	end
end
CoD.ArenaUtility.GetLadderPositionOrdinal = function(f53_arg0)
	local f53_local0 = f53_arg0 % 10
	if f53_arg0 == 11 or f53_arg0 == 12 or f53_arg0 == 13 then
		f53_arg0 = @"hash_34411487E2A5D24A"
	elseif f53_local0 == 1 then
		f53_arg0 = @"hash_344B2A87E2AE4C31"
	elseif f53_local0 == 2 then
		f53_arg0 = @"hash_348C1487E2E5BDC4"
	elseif f53_local0 == 3 then
		f53_arg0 = @"hash_34481487E2ABF0F8"
	else
		f53_arg0 = @"hash_34411487E2A5D24A"
	end
	return f53_arg0
end
CoD.ArenaUtility.GetLadderPositionResult = function(f54_arg0)
	if f54_arg0 == 1 then
		f54_arg0 = @"hash_53D5F1A3853D382D"
	elseif f54_arg0 <= 5 then
		f54_arg0 = @"hash_48A53833E9EF12F2"
	elseif f54_arg0 <= 10 then
		f54_arg0 = @"hash_243D5C06EB275969"
	elseif f54_arg0 <= 25 then
		f54_arg0 = @"hash_4C516D33B0595B88"
	else
		f54_arg0 = @"hash_53D5F1A3853D382D"
	end
	return f54_arg0
end
CoD.ArenaUtility.GetLadderPositionRankUpResult = function(f55_arg0)
	if f55_arg0 == 1 then
		f55_arg0 = @"hash_13C506115779D2A6"
	elseif f55_arg0 <= 5 then
		f55_arg0 = @"hash_48A53833E9EF12F2"
	elseif f55_arg0 <= 10 then
		f55_arg0 = @"hash_243D5C06EB275969"
	elseif f55_arg0 <= 25 then
		f55_arg0 = @"hash_4C516D33B0595B88"
	else
		f55_arg0 = 0x0
	end
	return f55_arg0
end
