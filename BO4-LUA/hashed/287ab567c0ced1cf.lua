
require( "x64:53e8db3768fb02a" )
require( "x64:3050b56bc941c17" )
require( "x64:2f7767db3f402c" )
require( "x64:b370b3af9224bd0" )
Lobby.Pregame = {}
Lobby.Pregame.Timer = {}
Lobby.Pregame.Stage = {
	IDLE = 100,
	PRESTAGE = 101,
	ROUND = 102,
	INTERMISSION = 103,
	POSTSTAGE = 104,
	LAUNCH = 105,
	LAST_STAGE = 106
}
Lobby.Pregame.CurrentState = {}
Lobby.Pregame.LobbyState = {
	IDLE = Enum[0xE8191BED9823BAB][0xECCE7392BE20418],
	VOTE = Enum[0xE8191BED9823BAB][0x80503ECA55D2B4A],
	DRAFT = Enum[0xE8191BED9823BAB][0xA92B0F10B2D8631],
	CAC_EDIT = Enum[0xE8191BED9823BAB][0x69EC00C4FB3000],
	STREAK_EDIT = Enum[0xE8191BED9823BAB][0xB8F42BBB163BB8F],
	LAUNCH_GAME = Enum[0xE8191BED9823BAB][0xA5AA22183845C10],
	COUNT = Enum[0xE8191BED9823BAB][0xA5A048C913985ED]
}
Lobby.Pregame.ClientState = {
	IDLE = Enum[0xEDB4C044CB28840][0x2FFCFE1473B8AD8],
	SELECTING = Enum[0xEDB4C044CB28840][0xAA7DA7C4AE701A],
	SELECTED = Enum[0xEDB4C044CB28840][0x11B822C85E9B637],
	FORCED = Enum[0xEDB4C044CB28840][0x7C1C9D7AAFD3C80],
	COMPLETE = Enum[0xEDB4C044CB28840][0xFB228954C0E9842],
	RESET = Enum[0xEDB4C044CB28840][0x3E5033C5A3470C1],
	END = Enum[0xEDB4C044CB28840][0x3735E3C075E8B0B],
	COUNT = Enum[0xEDB4C044CB28840][0x53091E1BC9ABEAD]
}
Lobby.Pregame.StateInfo = {
	[Lobby.Pregame.Stage.PRESTAGE] = {
		[Lobby.Pregame.LobbyState.VOTE] = {
			setting = "pregamePreStageTime",
			statusString = 0x789B1BB18060943
		},
		[Lobby.Pregame.LobbyState.DRAFT] = {
			setting = "pregamePreStageTime",
			statusString = 0x789B1BB18060943
		},
		[Lobby.Pregame.LobbyState.CAC_EDIT] = {
			setting = "pregamePreStageTime",
			statusString = 0x789B1BB18060943
		},
		[Lobby.Pregame.LobbyState.STREAK_EDIT] = {
			setting = "pregamePreStageTime",
			statusString = 0x789B1BB18060943
		},
		[Lobby.Pregame.LobbyState.LAUNCH_GAME] = {
			setting = "pregamePreStageTime",
			statusString = 0x789B1BB18060943
		}
	},
	[Lobby.Pregame.Stage.ROUND] = {
		[Lobby.Pregame.LobbyState.VOTE] = {
			setting = "pregameItemVoteRoundTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.DRAFT] = {
			setting = "pregameDraftRoundTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.CAC_EDIT] = {
			setting = "pregameCACModifyTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.STREAK_EDIT] = {
			setting = "pregameScorestreakModifyTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.LAUNCH_GAME] = {
			setting = nil,
			statusString = 0x0
		}
	},
	[Lobby.Pregame.Stage.INTERMISSION] = {
		[Lobby.Pregame.LobbyState.VOTE] = {
			setting = "pregamePostRoundTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.DRAFT] = {
			setting = "pregamePostRoundTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.CAC_EDIT] = {
			setting = nil,
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.STREAK_EDIT] = {
			setting = nil,
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.LAUNCH_GAME] = {
			setting = nil,
			statusString = 0x0
		}
	},
	[Lobby.Pregame.Stage.POSTSTAGE] = {
		[Lobby.Pregame.LobbyState.VOTE] = {
			setting = "pregamePostStageTime",
			statusString = 0xF0C75904F29F8BC
		},
		[Lobby.Pregame.LobbyState.DRAFT] = {
			setting = "pregamePostStageTime",
			statusString = 0xF0C75904F29F8BC
		},
		[Lobby.Pregame.LobbyState.CAC_EDIT] = {
			setting = "pregamePostStageTime",
			statusString = 0xF0C75904F29F8BC
		},
		[Lobby.Pregame.LobbyState.STREAK_EDIT] = {
			setting = "pregamePostStageTime",
			statusString = 0xF0C75904F29F8BC
		},
		[Lobby.Pregame.LobbyState.LAUNCH_GAME] = {
			setting = "pregamePostStageTime",
			statusString = 0x0
		}
	},
	[Lobby.Pregame.Stage.LAUNCH] = {
		[Lobby.Pregame.LobbyState.VOTE] = {
			setting = "pregamePostStageTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.DRAFT] = {
			setting = "pregamePostStageTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.CAC_EDIT] = {
			setting = "pregamePostStageTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.STREAK_EDIT] = {
			setting = "pregamePostStageTime",
			statusString = 0x0
		},
		[Lobby.Pregame.LobbyState.LAUNCH_GAME] = {
			setting = "pregamePostStageTime",
			statusString = 0x0
		}
	}
}
Lobby.Pregame.Settings = {
	MAX_VOTE_COUNT = "pregameItemMaxVotes",
	VOTE_ENABLED = "pregameItemVoteEnabled",
	DRAFT_ENABLED = "pregameDraftEnabled",
	ALWAYS_EDIT_CAC = "pregameAlwaysShowCACEdit",
	ALWAYS_EDIT_STREAKS = "pregameAlwaysShowStreakEdit",
	SORT_ORDER = "pregamePositionSortType",
	SHUFFLE_METHOD = "pregamePositionShuffleMethod",
	TIMER_WARNING_SOUND = LobbyData.Sounds.ESportsTimerTick,
	TIMER_WARNING_TIME = 9,
	TIMER_FINAL_SOUND = LobbyData.Sounds.ESportsTimerTickLast,
	TIMER_FINAL_TIME = 4
}
Lobby.Pregame.OnClientAdded = function ( f1_arg0 )
	if Engine[0xC1AA623AAF32C21]() == Enum[0xE8191BED9823BAB][0xECCE7392BE20418] then
		return 
	else
		Engine[0x3E0EFA24890DC98]( f1_arg0.xuid, Lobby.Pregame.ClientState.SELECTED )
	end
end
Lobby.Pregame.OnClientRemoved = function ( f2_arg0 )
	
end
Lobby.Pregame.GetStateInfo = function ( f3_arg0 )
	if Lobby.Pregame.StateInfo[f3_arg0] ~= nil then
		return Lobby.Pregame.StateInfo[f3_arg0][Lobby.Pregame.CurrentState]
	else
		
	end
end
Lobby.Pregame.GetStatusById = function ( f4_arg0 )
	for f4_local3, f4_local4 in pairs( Lobby.Pregame.StateInfo ) do
		if f4_local4.id == f4_arg0 then
			return f4_local4
		end
	end
end
Lobby.Pregame.GetGlobalRoot = function ()
	return Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "lobbyRoot.Pregame" )
end
Lobby.Pregame.GetRootModelForController = function ( f6_arg0 )
	return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f6_arg0 ), "Pregame" )
end
Lobby.Pregame.StartTimer = function ( f7_arg0, f7_arg1 )
	local f7_local0 = Engine[0x9D33D652B9B0F3B]()
	local f7_local1 = Lobby.Pregame.Timer
	local f7_local2 = Lobby.Pregame.GetStateInfo( f7_arg0 )
	local f7_local3 = Engine[0xDBC2AD5002B261B]( f7_local2.setting )
	if f7_arg1 ~= nil then
		f7_local3 = f7_arg1
	end
	f7_local1.stage = f7_arg0
	f7_local1.startTime = f7_local0
	f7_local1.endTime = f7_local0 + f7_local3 * 1000
	f7_local1.lastTime = -1
	f7_local1.timerCompleteProcessed = false
end
Lobby.Pregame.LaunchGame = function ()
	LobbyVM.LaunchGameExec( Engine[0xA5B9C0111291A8B](), Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] )
	Lobby.Pregame.SetState( Lobby.Pregame.LobbyState.IDLE )
end
Lobby.Pregame.GetTeams = function ()
	local f9_local0 = Engine[0x755D55B3813D249]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] )
	local f9_local1 = {}
	for f9_local5, f9_local6 in pairs( f9_local0.sessionClients ) do
		if f9_local6.team ~= Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
			if f9_local1[f9_local6.team] == nil then
				f9_local1[f9_local6.team] = {}
			end
			table.insert( f9_local1[f9_local6.team], f9_local6 )
		end
	end
	f9_local2 = function ( f10_arg0, f10_arg1 )
		return f10_arg0.pregamePosition < f10_arg1.pregamePosition
	end
	
	for f9_local6, f9_local7 in pairs( f9_local1 ) do
		table.sort( f9_local7, f9_local2 )
	end
	return f9_local1
end
Lobby.Pregame.Shuffle = function ( f11_arg0 )
	local f11_local0 = {}
	while table.getn( f11_arg0 ) > 0 do
		table.insert( f11_local0, table.remove( f11_arg0, math.random( table.getn( f11_arg0 ) ) ) )
	end
	return f11_local0
end
Lobby.Pregame.AssignTeamPositions = function ()
	local f12_local0 = Lobby.Pregame.GetTeams()
	local f12_local1 = Engine[0xDBC2AD5002B261B]( Lobby.Pregame.Settings.SORT_ORDER )
	if f12_local1 == Enum[0x999F869FE87E8B0][0x304012B859D8624] then
		for f12_local8, f12_local9 in pairs( f12_local0 ) do
			for f12_local5, f12_local6 in ipairs( Lobby.Pregame.Shuffle( f12_local9 ) ) do
				Engine[0xDFCC74C38E7DAA4]( f12_local6.xuid, f12_local5 )
			end
		end
	elseif f12_local1 == Enum[0x999F869FE87E8B0][0xC4FA3BE8DFF3E84] then
		for f12_local8, f12_local9 in pairs( f12_local0 ) do
			table.sort( f12_local9, function ( f13_arg0, f13_arg1 )
				return f13_arg0.joinOrder < f13_arg1.joinOrder
			end )
			for f12_local5, f12_local6 in ipairs( f12_local9 ) do
				Engine[0xDFCC74C38E7DAA4]( f12_local6.xuid, f12_local5 )
			end
		end
	elseif f12_local1 == Enum[0x999F869FE87E8B0][0xDA1C0DCA25E2FC3] then
		error( "AssignTeamPositions: Unhandled Sort Type" )
	end
end
Lobby.Pregame.PostVoteShuffle = function ()
	local f14_local0 = Lobby.Pregame.GetTeams()
	local f14_local1 = Engine[0xDBC2AD5002B261B]( Lobby.Pregame.Settings.SHUFFLE_METHOD )
	if f14_local1 == Enum[0xC37DB7C34A3B3A0][0x42CE69189B63835] then
		return 
	elseif f14_local1 == Enum[0xC37DB7C34A3B3A0][0x51AF62F0910A747] then
		for f14_local7, f14_local8 in pairs( f14_local0 ) do
			local f14_local5 = 0
			for f14_local6 = #f14_local8, 1, -1 do
				Engine[0xDFCC74C38E7DAA4]( f14_local8[f14_local6].xuid, f14_local5 )
				f14_local5 = f14_local5 + 1
			end
		end
	elseif f14_local1 == Enum[0xC37DB7C34A3B3A0][0xA032B0BCA8CEB04] then
		for f14_local7, f14_local8 in pairs( f14_local0 ) do
			for f14_local11, f14_local12 in ipairs( Lobby.Pregame.Shuffle( f14_local8 ) ) do
				Engine[0xDFCC74C38E7DAA4]( f14_local12.xuid, f14_local11 )
			end
		end
	end
end
Lobby.Pregame.Clear = function ()
	Lobby.Pregame.Timer = {}
	Lobby.Pregame.CurrentState = {}
	Engine[0x2099421AC9DAA72]()
end
Lobby.Pregame.Shutdown = function ( f16_arg0 )
	Lobby.Timer.UnlockLobby( f16_arg0, true )
	Lobby.Pregame.Clear()
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "lobbyRoot.Pregame" ), "state" ), Enum[0xE8191BED9823BAB][0xECCE7392BE20418] )
	Engine[0x6A489878620F3BC]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "Pregame.shutdown" ) )
end
Lobby.Pregame.SetState = function ( f17_arg0 )
	if Lobby.Pregame.CurrentState ~= f17_arg0 then
		Lobby.Pregame.CurrentState = f17_arg0
		Engine[0xB1CC98090648313]( f17_arg0 )
	end
end
Lobby.Pregame.OnMatchStart = function ( f18_arg0 )
	Lobby.Timer.UnlockLobby( Engine[0xA5B9C0111291A8B](), false )
	if Engine[0xEA2BE00F49480D]( Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] ) then
		Lobby.Pregame.SetState( Lobby.Pregame.LobbyState.IDLE )
	end
end
Lobby.Pregame.OnMatchEnd = function ( f19_arg0 )
	Lobby.Pregame.Clear()
end
Lobby.Pregame.Start = function ()
	Lobby.Pregame.Clear()
	Lobby.Pregame.AssignTeamPositions()
	if Engine[0xDBC2AD5002B261B]( Lobby.Pregame.Settings.VOTE_ENABLED ) == 1 then
		Lobby.Pregame.SetState( Enum[0xE8191BED9823BAB][0x80503ECA55D2B4A] )
	elseif Engine[0xDBC2AD5002B261B]( Lobby.Pregame.Settings.DRAFT_ENABLED ) == 1 then
		Lobby.Pregame.SetState( Enum[0xE8191BED9823BAB][0xA92B0F10B2D8631] )
	else
		error( "Attempted to start Pregame with unhandled settings." )
		Lobby.Pregame.LaunchGame()
	end
	Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.PRESTAGE )
end
Lobby.Pregame.GetRandomUnpickedCharacter = function ( f21_arg0 )
	local f21_local0 = Engine[0xA5B5E7CABA5C3AB]( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
	local f21_local1 = {}
	for f21_local5, f21_local6 in pairs( f21_arg0 ) do
		local f21_local7 = f21_local6.characterDraft.characterIndex
		if f21_local7 >= 0 and (f21_local6.pregameState == Enum[0xEDB4C044CB28840][0x11B822C85E9B637] or f21_local6.pregameState == Enum[0xEDB4C044CB28840][0x7C1C9D7AAFD3C80]) then
			f21_local0[f21_local7 + 1].__draftSelected = true
		end
	end
	for f21_local5, f21_local6 in ipairs( f21_local0 ) do
		if f21_local6.disabled == false and CoDShared.IsLootHero( f21_local6 ) == false and not f21_local6.__draftSelected then
			table.insert( f21_local1, f21_local5 - 1 )
		end
	end
	if #f21_local1 > 0 then
		return f21_local1[math.random( 1, #heroLoadoutPool )]
	else
		return -1, -1
	end
end
Lobby.Pregame.StartNextRound = function ()
	local f22_local0 = false
	for f22_local8, f22_local9 in pairs( Lobby.Pregame.GetTeams() ) do
		local f22_local4 = false
		for f22_local5, f22_local6 in pairs( f22_local9 ) do
			if not f22_local4 and f22_local6.pregameState == Lobby.Pregame.ClientState.IDLE then
				Engine[0x3E0EFA24890DC98]( f22_local6.xuid, Lobby.Pregame.ClientState.SELECTING )
				f22_local4 = true
				f22_local0 = true
			end
		end
	end
	if f22_local0 then
		Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.ROUND )
	else
		Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.POSTSTAGE )
	end
end
Lobby.Pregame.StartRoundForAllPlayers = function ()
	for f23_local6, f23_local7 in pairs( Lobby.Pregame.GetTeams() ) do
		for f23_local3, f23_local4 in pairs( f23_local7 ) do
			Engine[0x3E0EFA24890DC98]( f23_local4.xuid, Lobby.Pregame.ClientState.SELECTING )
		end
	end
	Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.ROUND )
end
Lobby.Pregame.ForcefullyEndRound = function ()
	local f24_local0 = Lobby.Pregame.GetTeams()
	local f24_local1 = Lobby.Pregame.CurrentState
	for f24_local10, f24_local11 in pairs( f24_local0 ) do
		for f24_local7, f24_local8 in pairs( f24_local11 ) do
			if f24_local8.pregameState == Lobby.Pregame.ClientState.SELECTING then
				local f24_local5 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] )
				if f24_local1 == Lobby.Pregame.LobbyState.VOTE then
					Engine[0x24AE7CEC130F10E]( f24_local5, f24_local8.xuid )
				end
				if f24_local1 == Lobby.Pregame.LobbyState.DRAFT then
					local f24_local6 = Lobby.Pregame.GetRandomUnpickedCharacter( f24_local11 )
					if f24_local6 < 0 then
						Engine[0x24AE7CEC130F10E]( f24_local5, f24_local8.xuid )
					else
						Engine[0x4558F0683EF31FC]( f24_local5, f24_local8.xuid, f24_local6 )
						goto basicblock_13:
					end
				end
				if f24_local1 == Lobby.Pregame.LobbyState.CAC_EDIT or f24_local1 == Lobby.Pregame.LobbyState.STREAK_EDIT then
					Engine[0x8E262BDF7840361]( f24_local5, f24_local8.xuid )
				end
			end
		end
	end
	Lobby.Pregame.AdvanceStateIfAllClientsSelected()
end
Lobby.Pregame.GetAllBannedItems = function ()
	local f25_local0 = {}
	local f25_local1 = Engine[0xC41C2D2C075424E]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] ) )
	if f25_local1 ~= nil and #f25_local1 > 0 then
		for f25_local5, f25_local6 in ipairs( f25_local1 ) do
			if f25_local6.voteType == Enum[0xB4E67669EDDF5D][0xB7AC034CE116958] then
				table.insert( f25_local0, f25_local6 )
			end
		end
	end
	return f25_local0
end
Lobby.Pregame.AnyCACItemsBanned = function ()
	for f26_local4, f26_local5 in ipairs( Lobby.Pregame.GetAllBannedItems() ) do
		if f26_local5.voteType == Enum[0xB4E67669EDDF5D][0xB7AC034CE116958] then
			if f26_local5.itemType == Enum[0x4AC3B18EEECCA6][0x9CA3BEF4CEA2F4C] then
				local f26_local3 = Engine[0xCA0179D394E63CE]( f26_local5.itemIndex )
				if not LuaUtils.StartsWith( f26_local3.loadoutSlot, "hero" ) and not LuaUtils.StartsWith( f26_local3.loadoutSlot, "killstreak" ) and f26_local3.loadoutSlot ~= "specialgadget" then
					return true
				end
			end
			if f26_local5.itemType == Enum[0x4AC3B18EEECCA6][0x531597DBEBAD66] then
				return true
			elseif f26_local5.itemType == Enum[0x4AC3B18EEECCA6][0xC37980943B384C] then
				return true
			elseif f26_local5.itemType == Enum[0x4AC3B18EEECCA6][0xDDA818CB3949372] then
				return true
			end
		end
	end
	return false
end
Lobby.Pregame.AnyStreaksBanned = function ()
	for f27_local4, f27_local5 in ipairs( Lobby.Pregame.GetAllBannedItems() ) do
		if f27_local5.voteType == Enum[0xB4E67669EDDF5D][0xB7AC034CE116958] and f27_local5.itemType == Enum[0x4AC3B18EEECCA6][0x9CA3BEF4CEA2F4C] then
			local f27_local3 = Engine[0xCA0179D394E63CE]( f27_local5.itemIndex )
			if LuaUtils.StartsWith( f27_local3.loadoutSlot, "killstreak" ) then
				return true
			end
		end
	end
	return false
end
Lobby.Pregame.OnStageEnd = function ( f28_arg0 )
	local f28_local0 = Engine[0xDBC2AD5002B261B]( Lobby.Pregame.Settings.DRAFT_ENABLED )
	local f28_local1 = Engine[0xDBC2AD5002B261B]( Lobby.Pregame.Settings.VOTE_ENABLED )
	local f28_local2 = Engine[0xDBC2AD5002B261B]( Lobby.Pregame.Settings.ALWAYS_EDIT_CAC )
	local f28_local3 = Engine[0xDBC2AD5002B261B]( Lobby.Pregame.Settings.ALWAYS_EDIT_STREAKS )
	Engine[0xBE6140F85B312F2]( Lobby.Pregame.ClientState.IDLE )
	if f28_arg0 == Lobby.Pregame.LobbyState.VOTE then
		if f28_local0 == 1 then
			Lobby.Pregame.PostVoteShuffle()
			Lobby.Pregame.SetState( Lobby.Pregame.LobbyState.DRAFT )
			Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.PRESTAGE )
		elseif f28_local2 == 1 or Lobby.Pregame.AnyCACItemsBanned() then
			Lobby.Pregame.SetState( Lobby.Pregame.LobbyState.CAC_EDIT )
			Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.PRESTAGE )
		else
			Lobby.Pregame.OnStageEnd( Lobby.Pregame.LobbyState.CAC_EDIT )
		end
	elseif f28_arg0 == Lobby.Pregame.LobbyState.DRAFT then
		if f28_local1 == 1 then
			if f28_local2 == 1 or Lobby.Pregame.AnyCACItemsBanned() then
				Lobby.Pregame.SetState( Lobby.Pregame.LobbyState.CAC_EDIT )
				Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.PRESTAGE )
			else
				Lobby.Pregame.OnStageEnd( Lobby.Pregame.LobbyState.CAC_EDIT )
			end
		else
			Lobby.Pregame.SetState( Lobby.Pregame.LobbyState.LAUNCH_GAME )
			Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.LAUNCH )
		end
	elseif f28_arg0 == Lobby.Pregame.LobbyState.CAC_EDIT then
		if f28_local3 == 1 or Lobby.Pregame.AnyStreaksBanned() then
			Lobby.Pregame.SetState( Lobby.Pregame.LobbyState.STREAK_EDIT )
			Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.PRESTAGE )
		else
			Lobby.Pregame.OnStageEnd( Lobby.Pregame.LobbyState.STREAK_EDIT )
		end
	elseif f28_arg0 == Lobby.Pregame.LobbyState.STREAK_EDIT then
		Lobby.Pregame.SetState( Lobby.Pregame.LobbyState.LAUNCH_GAME )
		Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.LAUNCH )
	else
		error( "Lobby.Pregame.OnStageEnd - unhandled lobby state" )
	end
end
Lobby.Pregame.PrestageMonitorSpecialRules = function ()
	if LuaUtils.IsArenaMode() and Dvar[0x500E4DB2F10F5EE]:get() > Engine[0x44FC97037CE42ED]( Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F] ) then
		Lobby.Pregame.Shutdown( Engine[0xA5B9C0111291A8B]() )
		local f29_local0 = Engine[0x9882F293C327557]()
		Engine[0xB972AE22481F1]()
		LobbyVM.HostLaunchClear()
		local f29_local1 = LobbyData.GetLobbyMenuByID( f29_local0 )
		Lobby.Timer.HostingLobby( {
			controller = Engine[0xA5B9C0111291A8B](),
			lobbyType = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43],
			mainMode = f29_local1[0xEB7DDC7F079D51B],
			lobbyTimerType = f29_local1[0x558B67A321D1120],
			matchEnded = false,
			status = Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED
		} )
		Engine[0xBE6140F85B312F2]( Lobby.Pregame.ClientState.RESET )
		return true
	else
		return false
	end
end
Lobby.Pregame.Pump = function ()
	local f30_local0 = Engine[0xC1AA623AAF32C21]()
	if f30_local0 == Enum[0xE8191BED9823BAB][0xECCE7392BE20418] then
		return 
	end
	local f30_local1 = Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]
	local f30_local2 = Engine[0xC3DF042E7492B66]( f30_local1 )
	if not Engine[0xEA2BE00F49480D]( f30_local2 ) then
		return 
	end
	local f30_local3 = Lobby.Pregame.Timer
	local f30_local4, f30_local5 = Engine[0x1ECF7C2EACD404D]( f30_local2 )
	if not f30_local3.startTime or not f30_local3.endTime then
		return 
	elseif f30_local3.startTime == f30_local3.endTime then
		Engine[0x321357761DC3249]( f30_local1, f30_local2, f30_local3.stage, -1 )
		f30_local3.lastTime = -1
		return 
	elseif f30_local3.endTime < Engine[0x9D33D652B9B0F3B]() and not f30_local3.timerCompleteProcessed then
		Lobby.Pregame.Timer.timerCompleteProcessed = true
		local f30_local6 = Lobby.Pregame.CurrentState
		if f30_local4 ~= Lobby.Pregame.Stage.INTERMISSION and f30_local4 ~= Lobby.Pregame.Stage.POSTSTAGE and f30_local4 ~= Lobby.Pregame.Stage.PRESTAGE and Lobby.Pregame.PrestageMonitorSpecialRules() then
			return 
		elseif f30_local4 == Lobby.Pregame.Stage.PRESTAGE then
			if f30_local6 == Lobby.Pregame.LobbyState.CAC_EDIT or f30_local6 == Lobby.Pregame.LobbyState.STREAK_EDIT then
				Lobby.Pregame.StartRoundForAllPlayers()
			elseif not Lobby.Pregame.PrestageMonitorSpecialRules() then
				Lobby.Pregame.StartNextRound()
			end
		elseif f30_local4 == Lobby.Pregame.Stage.ROUND then
			Lobby.Pregame.ForcefullyEndRound()
		elseif f30_local4 == Lobby.Pregame.Stage.INTERMISSION then
			Lobby.Pregame.StartNextRound()
		elseif f30_local4 == Lobby.Pregame.Stage.POSTSTAGE then
			Lobby.Pregame.OnStageEnd( f30_local0 )
		elseif f30_local4 == Lobby.Pregame.Stage.LAUNCH then
			Lobby.Pregame.LaunchGame()
		end
	end
	local f30_local6 = math.floor( (f30_local3.endTime - Engine[0x9D33D652B9B0F3B]() + 1) / 1000 )
	if f30_local6 ~= f30_local3.lastTime then
		f30_local3.lastTime = f30_local6
		Engine[0x321357761DC3249]( f30_local1, f30_local2, f30_local3.stage, f30_local6 )
	end
end
Lobby.Pregame.AnyClientInState = function ( f31_arg0, f31_arg1 )
	for f31_local6, f31_local7 in pairs( f31_arg0 ) do
		for f31_local3, f31_local4 in pairs( f31_local7 ) do
			if f31_local4.pregameState == f31_arg1 then
				return true
			end
		end
	end
	return false
end
Lobby.Pregame.AllClientsInState = function ( f32_arg0, f32_arg1 )
	for f32_local6, f32_local7 in pairs( f32_arg0 ) do
		for f32_local3, f32_local4 in pairs( f32_local7 ) do
			if f32_arg1[f32_local4.pregameState] == nil then
				return false
			end
		end
	end
	return true
end
Lobby.Pregame.AdvanceStateIfAllClientsSelected = function ()
	local f33_local0 = Lobby.Pregame.GetTeams()
	local f33_local1 = {
		[Enum[0xEDB4C044CB28840][0x11B822C85E9B637]] = true,
		[Enum[0xEDB4C044CB28840][0x7C1C9D7AAFD3C80]] = true,
		[Enum[0xEDB4C044CB28840][0xFB228954C0E9842]] = true
	}
	if Lobby.Pregame.AnyClientInState( f33_local0, Enum[0xEDB4C044CB28840][0xAA7DA7C4AE701A] ) == false then
		if Lobby.Pregame.AllClientsInState( f33_local0, f33_local1 ) == true then
			Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.POSTSTAGE )
		else
			Lobby.Pregame.StartTimer( Lobby.Pregame.Stage.INTERMISSION )
		end
	end
end
Lobby.Pregame.OnClientSelectionReceived = function ( f34_arg0 )
	
end
Lobby.Pregame.GameLobbyClientDataUpdate = function ( f35_arg0 )
	
end
local f0_local0 = -1
Lobby.Pregame.UpdateLobbyStatusInfo = function ( f36_arg0 )
	local f36_local0 = Lobby.Pregame.GetGlobalRoot()
	Lobby.Pregame.CurrentState = f36_arg0.pregameState
	local f36_local1 = f36_arg0.status
	local f36_local2 = f36_arg0.pregameState
	local f36_local3 = f36_arg0.statusValue
	Engine[0x3B9F1AA6A523204]( Engine[0x20826BD382E3A23]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] ), Engine[0x93B19E01B1FD1C7]( f36_arg0.controller ) ) )
	if f36_local3 < 0 then
		f36_local3 = -1
		f0_local0 = -1
	end
	if f36_local3 ~= f0_local0 then
		f0_local0 = f36_local3
		if f36_local1 == Lobby.Pregame.Stage.ROUND and Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( Lobby.Pregame.GetRootModelForController( f36_arg0.controller ), "clientState" ) ) == Lobby.Pregame.ClientState.SELECTING then
			if f36_local3 <= Lobby.Pregame.Settings.TIMER_WARNING_TIME and Lobby.Pregame.Settings.TIMER_FINAL_TIME < f36_local3 then
				Engine[0xC4146BA76D0F982]( Lobby.Pregame.Settings.TIMER_WARNING_SOUND )
			elseif f36_local3 <= Lobby.Pregame.Settings.TIMER_FINAL_TIME and f36_local3 >= 0 then
				Engine[0xC4146BA76D0F982]( Lobby.Pregame.Settings.TIMER_FINAL_SOUND )
			end
		end
	end
	local f36_local4 = Lobby.Pregame.GetStateInfo( f36_local1 )
	if f36_local4 then
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f36_local0, "status" ), f36_local4.statusString )
	end
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f36_local0, "stage" ), f36_local1 )
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f36_local0, "state" ), f36_local2 )
	if f36_local3 == -1 then
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f36_local0, "timeleft" ), "" )
	else
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f36_local0, "timeleft" ), tostring( f36_local3 + 1 ) )
	end
end
