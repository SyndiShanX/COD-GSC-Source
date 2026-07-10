
require( "x64:53e8db3768fb02a" )
require( "x64:3050b56bc941c17" )
require( "x64:2f7767db3f402c" )
require( "x64:b370b3af9224bd0" )
require( "x64:5916b7ba61d0794" )
Lobby.MMAsync = {}
Lobby.MMAsync.Info = {
	ffotdLoaded = false,
	LOBBY_DOC_FORCE_SYNC_INTERVAL = 60000,
	getLobbyDocs = false,
	migrateHost = false
}
Lobby.MMAsync.LocalUserInfo = {}
Lobby.MMAsync.RemoveList = {}
Lobby.MMAsync.QoS = {}
Lobby.MMAsync.QoSEventQueue = {}
Lobby.MMAsync.MAX_QOS_PROBE_RESULT_WAIT_TIME = 15000
Lobby.MMAsync.reservationTable = {
	count = 0
}
Lobby.MMAsync.Sync = {
	add = false,
	failedCount = 0
}
Lobby.MMAsync.lastUpdateTime = 0
Lobby.MMAsync.syncTimeInterval = 250000
Lobby.MMAsync.lobbyCreateTime = 0
Lobby.MMAsync.lastSyncTime = 0
Lobby.MMAsync.Info.matchmakingID = 0
Lobby.MMAsync.AdvertStatus = true
Lobby.MMAsync.backoffMultiplyer = 1
Lobby.MMAsync.Event = {}
Lobby.MMAsync.Event.Queue = {}
Lobby.MMAsync.LootReady = false
Lobby.MatchmakingAsync = {}
Lobby.MatchmakingAsync.DedicatedServerState = {
	REGISTER_SERVER = 0,
	REGISTERED = 1,
	WAIT_TO_LOBBY_DISBAND = 3,
	DISBAND_LOBBY = 4,
	DISBANDING_LOBBY = 5,
	SHUTDOWN = 6
}
Lobby.MatchmakingAsync.ShutdownRequestStage = {
	NONE = 0,
	REQUESTED = 1,
	SHUTTINGDOWN = 2
}
Lobby.MMAsync.Dedi = {
	status = Lobby.MatchmakingAsync.DedicatedServerState.REGISTER_SERVER,
	reason = "",
	ServerShutdownStage = Lobby.MatchmakingAsync.ShutdownRequestStage.NONE
}
Lobby.MatchmakingAsync.LeaveReason = {
	INVALID_REASON = -1,
	LOBBY_DISBANDED = 0,
	LOBBY_JOIN_FAILED = 1,
	CLIENT_CANCEL = 2
}
Lobby.MatchmakingAsync.SearchOutcome = {
	INVALID_OUTCOME = -1,
	SEARCH_CANCEL = 0,
	PARTY_DISBANDED = 1,
	LOBBY_JOIN = 2,
	LOBBY_JOIN_FAILED = 3
}
Lobby.MatchmakingAsync.QoSStage = {
	NONE = 0,
	INPROGRESS = 1,
	REPORT = 2,
	REPORTING = 3
}
Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog = {}
Lobby.MatchmakingAsync.PartyToMatchSummary = {
	[@"search_count"] = 0,
	[@"searches"] = {}
}
Lobby.MatchmakingAsync.PartyMembersTelemetry = {
	[@"hash_22BEBB24C7131B96"] = 0,
	[@"party_members"] = {}
}
Lobby.MatchmakingAsync.ReasonIntermissionEnded = {
	LOBBY_DISBANDED = 0,
	LOBBY_MERGE = 1,
	GAME_START = 2
}
Lobby.MatchmakingAsync.LobbyMembersTelemetry = {
	[@"hash_72623BA80A26AD5A"] = 0,
	[@"lobby_members"] = {}
}
Lobby.MatchmakingAsync.ErrorCodes = {
	TREY_AMM_INTERNAL = 14000,
	BD_AMM_NOT_LOBBY_HOST = 14500,
	BD_AMM_NOT_PARTY_HOST = 14501,
	BD_AMM_NOT_LOBBY_MEMBER = 14502,
	BD_AMM_INVALID_MATCHMAKING_ID = 14503,
	BD_AMM_INVALID_LOBBY_ID = 14504,
	BD_AMM_SEARCH_IN_PROGRESS = 14505,
	BD_AMM_USER_ALREADY_MATCHMAKING = 14506,
	BD_AMM_INVALID_TOKEN = 14507,
	BD_AMM_INVALID_DOCUMENT_FORMAT = 14508,
	BD_AMM_PLAYER_INFO_UNAVAILABLE = 14509,
	BD_AMM_REQUEST_DESERIALIZATION_FAILED = 14510,
	BD_AMM_INVALID_QOS_TRANSACTION_ID = 14511,
	BD_AMM_INVALID_USER_ID_IN_GUEST_SLOTS = 14512,
	BD_AMM_NO_BUILD_NAME_SET = 14513,
	BD_AMM_LOBBY_MERGED = 14514,
	BD_AMM_BACKOFF_REQUESTED = 14515,
	BD_AMM_PLAYER_INFO_INCOMPATIBLE_BUILDS = 14516,
	BD_AMM_INVALID_DC_QOS_ADDRESS = 14517,
	BD_AMM_INVALID_PLAYER_INFO_DC_QOS_SETTINGS = 14518,
	BD_AMM_INVALID_PLAYER_INFO_LISTEN_SERVER_SETTINGS = 14519,
	BD_AMM_MIGRATION_NOT_PERMITTED = 14520,
	BD_AMM_INVALID_LOBBY_MEMBER_STATUS_TRANSITION = 14521,
	BD_AMM_LOBBY_MEMBER_STATUS_REPORTED_FOR_UNKNOWN_PLAYER = 14522
}
Lobby.MatchmakingAsync.LobbyDelayedCMD = {
	LOBBY_NONE = 0,
	LOBBY_DISBAND_AFTERMATCH = 1
}
Lobby.MMAsync.DelayCmd = Lobby.MatchmakingAsync.LobbyDelayedCMD.LOBBY_NONE
Lobby.MMAsync.DelayData = nil
Lobby.MatchmakingAsync.LobbyIntermissionSummary = nil
Lobby.MatchmakingAsync.Init = function ( f1_arg0 )
	for f1_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
		Lobby.MatchmakingAsync.LogOutLocalUserInfo( f1_local0 )
	end
end
Lobby.MatchmakingAsync.GetFullBuildName = function ()
	local f2_local0 = Engine[@"getplaylistversionnumber"]()
	local f2_local1 = Engine[@"getprotocolversion"]()
	local f2_local2 = Engine[@"getffotdversion"]()
	local f2_local3 = Engine[@"getbuildintfield"]( Enum[@"buildintfield"][@"build_intfield_changelist"] )
	local f2_local4 = Engine[@"getbuildstringfield"]( Enum[@"buildstringfield"][@"build_stringfield_build_config"] )
	local f2_local5 = Engine[@"getbuildstringfield"]( Enum[@"buildstringfield"][@"build_stringfield_build_base_name"] )
	local f2_local6 = ""
	if f2_local4 == "release" or f2_local4 == "debug" then
		f2_local6 = "debug"
	else
		f2_local6 = "ship"
	end
	local f2_local7 = Engine[@"hash_12BA6A50A48E0620"]()
	local f2_local8 = ""
	if Rat ~= nil and Dvar[@"hash_39419CDA023087D5"]:exists() then
		f2_local8 = Dvar[@"hash_39419CDA023087D5"]:get()
		if f2_local8 ~= "" then
			f2_local8 = "-rat" .. f2_local8
		end
	end
	if Dvar[@"hash_FF10563FA6881A6"]:exists() then
		local f2_local9 = Dvar[@"hash_FF10563FA6881A6"]:get()
		if string.len( f2_local9 ) > 0 then
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.GetFullBuildName(): Setting buildCL to " .. f2_local9 .. " the actual changelist is " .. f2_local3 .. "\n" )
			f2_local3 = f2_local9
		end
	end
	local f2_local9 = ""
	if Dvar[@"hash_2E9FEAE73C26E56A"]:get() then
		f2_local9 = "-TU" .. Engine[0x861ADB8C3DD198]()
	end
	local f2_local10 = "-"
	if Dvar[@"hash_4FCA630E174CA332"]:get() then
		if Engine[@"isdedicatedserver"]() and Engine[@"hash_25AE97B58D7132F3"]() == "pc" then
			f2_local10 = Engine[@"hash_485601A81443CB80"]()
		elseif LuaDefine.isPC then
			f2_local10 = Engine[@"hash_69A70B14679D905C"]()
			if f2_local10 == "DEV8" or f2_local10 == "XX" or f2_local10 == "" then
				f2_local10 = "US"
			end
		end
		if f2_local10 ~= "-" then
			f2_local10 = "-" .. f2_local10 .. "-"
		end
	end
	local f2_local11 = f2_local5 .. "-" .. f2_local6 .. f2_local10 .. f2_local3 .. f2_local9 .. "-" .. f2_local0 .. "-" .. f2_local2 .. "-" .. f2_local7 .. "@" .. f2_local1 .. f2_local8
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.GetFullBuildName(): Full Matchmaking Build name: " .. f2_local11 .. "\nThe actual buildConfig is [" .. f2_local4 .. "]\n" )
	return f2_local11
end
Lobby.MatchmakingAsync.InitLocalUserInfo = function ( f3_arg0 )
	Lobby.MMAsync.LocalUserInfo[f3_arg0 + 1] = {}
	local f3_local0 = Lobby.MatchmakingAsync.GetLocalUserInfo( f3_arg0 )
	f3_local0.xuid = Engine[@"getxuid64"]( f3_arg0 )
	f3_local0.xuidstrnum = Engine[@"uint64tostring"]( f3_local0.xuid )
	f3_local0.gamertag = Engine[@"getgamertagforcontroller"]( f3_arg0 )
	f3_local0.secIdKey = Engine[@"hash_216FF58A0A7C0C65"]()
	f3_local0.secId = f3_local0.secIdKey.secId
	f3_local0.secKey = f3_local0.secIdKey.secKey
	f3_local0.encodedSecId = Engine[@"hash_61546B36B2B6E350"]( f3_local0.secId )
	f3_local0.encodeSecKey = Engine[@"hash_283AB0F1B4841E3C"]( f3_local0.secKey )
	f3_local0.playerInfo = false
	f3_local0.hasToken = false
	f3_local0.qosListening = false
	f3_local0.hasInitiateDCQoS = false
	f3_local0.completedDCQoS = false
	f3_local0.lastDCQoSSuccess = 0
	return f3_local0
end
Lobby.MatchmakingAsync.UpdatePlayerInfo = function ()
	if Dvar[@"hash_19F350E474489456"]:exists() and Dvar[@"hash_19F350E474489456"]:get() then
		for f4_local0 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
			local f4_local3 = Lobby.MatchmakingAsync.GetLocalUserInfo( f4_local0 )
			if f4_local3 ~= nil and f4_local3.xuid ~= LuaDefine.INVALID_XUID_X64 then
				Lobby.MMAsync.LootReady = false
				f4_local3.playerInfo = false
			end
		end
	end
end
Lobby.MatchmakingAsync.OnClientSplitscreenSignin = function ( f5_arg0 )
	Lobby.MatchmakingAsync.InitLocalUserInfo( f5_arg0.controller )
end
Lobby.MatchmakingAsync.LogOutLocalUserInfo = function ( f6_arg0 )
	Lobby.MMAsync.LocalUserInfo[f6_arg0 + 1] = {}
	local f6_local0 = Lobby.MatchmakingAsync.GetLocalUserInfo( f6_arg0 )
	f6_local0.xuid = LuaDefine.INVALID_XUID_X64
	f6_local0.xuidstrnum = "0"
	return f6_local0
end
Lobby.MatchmakingAsync.CacheAsyncInfo = function ( f7_arg0, f7_arg1, f7_arg2 )
	if f7_arg0 ~= nil then
		Lobby.MMAsync.Info.lobbyHostDocTable = f7_arg0
	end
	if f7_arg1 ~= nil then
		Lobby.MMAsync.Info.lobbyBackendDocTable = f7_arg1
	end
	if f7_arg2 ~= nil then
		Lobby.MMAsync.Info.lobbyID = f7_arg2
		Engine[@"hash_75D8333836EECECC"]( f7_arg2 )
	end
end
Lobby.MatchmakingAsync.OnGetLobbyID = function ()
	if nil ~= Lobby.MMAsync.Info.lobbyID then
		return Lobby.MMAsync.Info.lobbyID
	else
		return 0
	end
end
Lobby.MatchmakingAsync.ClearCacheAsyncInfo = function ()
	Lobby.MMAsync.Info.lobbyID = nil
	Engine[@"hash_75D8333836EECECC"]( 0 )
	Lobby.MMAsync.Info.lobbyHostDocTable = nil
	Lobby.MMAsync.Info.lobbyBackendDocTable = nil
	Lobby.MMAsync.Info.matchmakingID = 0
	Lobby.MMAsync.Sync.failedCount = 0
	Lobby.MatchmakingAsync.ClearReservationTable()
	Lobby.MMAsync.DelayCmd = Lobby.MatchmakingAsync.LobbyDelayedCMD.LOBBY_NONE
	Lobby.MMAsync.DelayData = nil
end
Lobby.MatchmakingAsync.SyncHostDocs = function ( f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4, f10_arg5, f10_arg6 )
	local f10_local0 = f10_arg6
	if f10_arg0 ~= nil then
		f10_local0 = Lobby.ProcessQueue.RegisterEventHandler( f10_arg0, {
			controller = f10_arg1,
			lobbyID = f10_arg3,
			updateID = f10_arg4
		} )
	end
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Pump(): Lobby.MMAsync.lastUpdateTime reached calling sync " .. "\n actionId: " .. tostring( f10_local0 ) .. "\n controller: " .. tostring( f10_arg1 ) .. "\n lobbyID: " .. Engine[@"uint64tostring"]( f10_arg3 ) .. "\n updateID: " .. Engine[@"uint64tostring"]( f10_arg4 ) .. "\n lobbyHostDoc: " .. f10_arg5 .. "\n" )
	local f10_local1 = Engine[@"hash_160EE082FC0978A0"]( f10_local0, f10_arg1, f10_arg2, f10_arg3, f10_arg4, f10_arg5 .. " " )
	if f10_local1 == true then
		Lobby.MMAsync.lastUpdateTime = Engine[@"milliseconds"]()
	elseif f10_arg0 ~= nil then
		Lobby.ProcessQueue.UnRegisterEventHandler( f10_local0 )
	end
	return f10_local1
end
Lobby.MatchmakingAsync.GetLocalUserInfo = function ( f11_arg0 )
	return Lobby.MMAsync.LocalUserInfo[f11_arg0 + 1]
end
Lobby.MatchmakingAsync.AsyncMatchmakingRunning = function ( f12_arg0 )
	Lobby.MMAsync.Info.asyncMatchmakingRunning = f12_arg0
end
Lobby.MatchmakingAsync.IsAsyncMatchmakingRunning = function ()
	return Lobby.MMAsync.Info.asyncMatchmakingRunning
end
Lobby.MatchmakingAsync.CheckIfWeShouldSendSync = function ( f14_arg0 )
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) and Engine[@"milliseconds"]() - Lobby.MMAsync.lastUpdateTime > Lobby.MMAsync.syncTimeInterval and Lobby.MMAsync.Info.lobbyHostDocTable ~= nil and Lobby.MatchmakingAsync.IsEventInQueue( LuaEnum.bdEventType.BD_UPDATED_LOBBY_DOCUMENT ) == false then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Pushing sync to the lobby system for heartbeat.\n" )
		Lobby.MMAsync.lastUpdateTime = Engine[@"milliseconds"]()
		Lobby.MMAsync.Info.lobbyHostDocTable.needs_update = true
	end
end
Lobby.MatchmakingAsync.CheckDelayedComands = function ( f15_arg0 )
	if not Engine[@"isingame"]() then
		if Lobby.MMAsync.DelayCmd == Lobby.MatchmakingAsync.LobbyDelayedCMD.LOBBY_NONE then
			return 
		end
		local f15_local0 = Lobby.MMAsync.DelayCmd
		local f15_local1 = Lobby.MMAsync.DelayData
		Lobby.MMAsync.DelayCmd = Lobby.MatchmakingAsync.LobbyDelayedCMD.LOBBY_NONE
		Lobby.MMAsync.DelayData = nil
		if f15_local0 == Lobby.MatchmakingAsync.LobbyDelayedCMD.LOBBY_DISBAND_AFTERMATCH then
			LuaUtils.SafeComError( Enum[@"errorcode"][@"error_drop"], @"exe/disconnected" )
		end
	end
end
Lobby.MatchmakingAsync.ShouldSyncDocs = function ( f16_arg0 )
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) and Dvar[@"hash_32D5F9372BA23051"]:get() * Lobby.MMAsync.backoffMultiplyer < Engine[@"milliseconds"]() - Lobby.MMAsync.lastSyncTime then
		Lobby.MMAsync.lastSyncTime = Engine[@"milliseconds"]()
		Lobby.MMAsync.backoffMultiplyer = 1
		if Lobby.MMAsync.Info.lobbyHostDocTable ~= nil and Lobby.MatchmakingAsync.IsEventInQueue( LuaEnum.bdEventType.BD_SYNC_HOSTDOC ) == false and Lobby.MMAsync.Info.lobbyHostDocTable.needs_update == true then
			local f16_local0 = {
				controller = f16_arg0.primaryController,
				eventType = LuaEnum.bdEventType.BD_SYNC_HOSTDOC
			}
			Lobby.MMAsync.Info.lobbyHostDocTable.needs_update = false
			Lobby.MatchmakingAsync.Event( f16_local0 )
		end
	end
end
Lobby.MatchmakingAsync.Pump = function ( f17_arg0 )
	if Dvar[@"hash_44BADE8473F0165F"]:get() ~= true then
		return 
	else
		f17_arg0.primaryController = Engine[@"getprimarycontroller"]()
		Lobby.MatchmakingAsync.PumpLocalClients( f17_arg0 )
		Lobby.MatchmakingAsync.PumpAddClients( f17_arg0 )
		Lobby.MatchmakingAsync.PumpRemoveClients( f17_arg0 )
		Lobby.MatchmakingAsync.PumpQoSReports( f17_arg0 )
		Lobby.MatchmakingAsync.PumpAsyncUpdate( f17_arg0 )
		Lobby.MatchmakingAsync.PumpTimeOuts( f17_arg0 )
		Lobby.MatchmakingAsync.CheckIfWeShouldSendSync( f17_arg0 )
		Lobby.MatchmakingAsync.ShouldSyncDocs( f17_arg0 )
		Lobby.MatchmakingAsync.ProcessQOSQueue()
		Lobby.MatchmakingAsync.CheckDelayedComands( f17_arg0 )
	end
end
Lobby.MatchmakingAsync.PumpLocalClients = function ( f18_arg0 )
	if Lobby.MMAsync.Info.ffotdLoaded == false or f18_arg0.isDedicatedServer or f18_arg0.users == nil or #f18_arg0.users == 0 then
		return 
	elseif Lobby.MMAsync.LootReady == false then
		if Engine[@"islootready"]( f18_arg0.primaryController ) == false then
			return 
		end
		Lobby.MMAsync.LootReady = true
	end
	for f18_local4, f18_local5 in ipairs( f18_arg0.users ) do
		if f18_local5.signedInDW == true then
			local f18_local3 = Lobby.MatchmakingAsync.GetLocalUserInfo( f18_local5.controller )
			if f18_local5.xuid ~= f18_local3.xuid then
				f18_local3 = Lobby.MatchmakingAsync.InitLocalUserInfo( f18_local5.controller )
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Async Matchmaking init local client " .. f18_local3.gamertag .. ", xuid " .. f18_local3.xuidstrnum .. ".\n" )
			end
			if f18_local3.playerInfo == false and Engine[@"hash_C3DAFC9624723BB"]( f18_local5.controller, Enum[@"hash_1253E52758902088"][@"hash_6922E7FF274B28B2"] ) == false then
				Lobby.MatchmakingAsync.SetPlayerInfo( f18_local5.controller, f18_local3 )
			end
			if f18_local3.hasToken == false and Engine[@"hash_C3DAFC9624723BB"]( f18_local5.controller, Enum[@"hash_1253E52758902088"][@"hash_2A8CF5840144D3B6"] ) == false then
				Lobby.MatchmakingAsync.GetMatchMakingPlayerToken( f18_local5.controller, f18_local3 )
			end
			if f18_local3.hasInitiateDCQoS == false and Engine[@"hash_C3DAFC9624723BB"]( f18_local5.controller, Enum[@"hash_1253E52758902088"][@"hash_369F286EEB744898"] ) == false then
				Lobby.MatchmakingAsync.InitiateDCQoS( f18_local5.controller, f18_local3 )
			end
		end
	end
end
Lobby.MatchmakingAsync.ClientSearchStatusInfo = function ( f19_arg0 )
	if f19_arg0.lobbyType == Enum[@"lobbytype"][@"lobby_type_game"] then
		return 
	end
	local f19_local0 = f19_arg0.searchStage
	local f19_local1 = f19_arg0.searchStageValue
	local f19_local2 = 0x0
	local f19_local3 = 0x0
	local f19_local4 = nil
	if f19_local0 == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1 then
		Lobby.MapVote.Hide()
		f19_local2 = @"hash_7EE23E72D89E24F1"
		f19_local3 = LuaEnum.SEARCH_DESCRIPTION_STRING[f19_local1]
	elseif f19_local0 == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_2 then
		f19_local2 = @"hash_4CEF2BB5C997C164"
		f19_local3 = LuaEnum.SEARCH_DESCRIPTION_STRING[f19_local1]
		f19_local4 = true
	elseif f19_local0 == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3 then
		f19_local2 = @"hash_4C4D2D56E3932FAB"
		f19_local3 = LuaEnum.SEARCH_DESCRIPTION_STRING[f19_local1]
		if f19_local1 == LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_3_DESCRIPTION_2 or f19_local1 == LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_3_DESCRIPTION_3 then
			Engine[@"playsound"]( "uin_lobby_find" )
		end
	elseif f19_local0 == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4 then
		f19_local2 = @"hash_4D62495C7EEE7626"
		f19_local3 = LuaEnum.SEARCH_DESCRIPTION_STRING[f19_local1]
	else
		f19_local2 = 0x0
		f19_local3 = 0x0
		f19_local0 = LuaEnum.PUBLIC_LOBBY.INVALID
	end
	Lobby.Matchmaking.UpdatePublicLobby( {
		stage = f19_local0,
		stageTitle = f19_local2,
		stageDetails = Engine[@"hash_4F9F1239CFD921FE"]( f19_local3 ),
		showWaitingWidget = f19_local4
	} )
end
Lobby.MatchmakingAsync.PumpAddClients = function ( f20_arg0 )
	if Lobby.MMAsync.Sync.add == false then
		return 
	else
		local f20_local0 = f20_arg0.primaryController
		if false == Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"] ) then
			Lobby.MMAsync.Sync.add = false
			return 
		else
			local f20_local1 = Lobby.MMAsync.Info.lobbyHostDocTable
			if f20_local1 == nil or Lobby.MMAsync.Info.lobbyID == nil or Lobby.MMAsync.Info.lobbyBackendDocTable == nil then
				return 
			else
				Lobby.MMAsync.Sync.add = false
				local f20_local2 = Engine[@"lobbygetsessionclients"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"] )
				local f20_local3 = {
					sessionClients = f20_local2.sessionClients
				}
				local f20_local4, f20_local5 = Lobby.JSON.CreateWritableDocFromString( Lobby.MMAsync.Info.lobbyHostDocTable.lobbyDoc )
				f20_local1 = Lobby.JSON.AddClientsToHostData( f20_local4, f20_local5, f20_local1, f20_local3 )
				f20_local1 = Lobby.JSON.setUpdateID( f20_local4, f20_local5, f20_local1, f20_local1.update_id + 1 )
				Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f20_local4, f20_local1 )
				Lobby.MatchmakingAsync.CacheAsyncInfo( f20_local1 )
			end
		end
	end
end
Lobby.MatchmakingAsync.PumpRemoveClients = function ( f21_arg0 )
	if #Lobby.MMAsync.RemoveList == 0 then
		return 
	else
		local f21_local0 = f21_arg0.primaryController
		if Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"] ) == false then
			Lobby.MMAsync.RemoveList = {}
			return 
		else
			local f21_local1 = Lobby.MMAsync.Info.lobbyHostDocTable
			if f21_local1 == nil or Lobby.MMAsync.Info.lobbyID == nil or Lobby.MMAsync.Info.lobbyBackendDocTable == nil then
				return 
			else
				local f21_local2 = {
					removeList = Lobby.MMAsync.RemoveList
				}
				local f21_local3, f21_local4 = Lobby.JSON.CreateWritableDocFromString( Lobby.MMAsync.Info.lobbyHostDocTable.lobbyDoc )
				f21_local1 = Lobby.JSON.RemoveClientsFromHostData( f21_local3, f21_local4, f21_local1, f21_local2 )
				f21_local1 = Lobby.JSON.setUpdateID( f21_local3, f21_local4, f21_local1, f21_local1.update_id + 1 )
				Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f21_local3, f21_local1 )
				Lobby.MMAsync.RemoveList = {}
				Lobby.MatchmakingAsync.CacheAsyncInfo( f21_local1, nil )
			end
		end
	end
end
Lobby.MatchmakingAsync.PumpQoSReports = function ( f22_arg0 )
	if f22_arg0.isDedicatedServer == true then
		return 
	end
	for f22_local7, f22_local8 in pairs( Lobby.MMAsync.QoS ) do
		if (f22_local8.stage == Lobby.MatchmakingAsync.QoSStage.REPORT or f22_local8.probeWaitEndTime <= Engine[@"milliseconds"]()) and Engine[@"hash_C3DAFC9624723BB"]( f22_local8.controller, Enum[@"hash_1253E52758902088"][@"hash_213289989E9E3691"] ) == false then
			if f22_local8.stage ~= Lobby.MatchmakingAsync.QoSStage.REPORT then
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpQoSReports(): timeout reached for " .. tostring( f22_local7 ) .. " \n" )
			end
			f22_local8.stage = Lobby.MatchmakingAsync.QoSStage.REPORTING
			f22_local8.active = false
			local f22_local3 = f22_local8.transactionID
			local f22_local4 = f22_local8.probedHostsResults
			if f22_local4 == nil or #f22_local4 == 0 then
				f22_local4 = {
					disabled = true
				}
			end
			Lobby.ProcessQueue.UnRegisterEventHandler( f22_local8.actionId )
			local f22_local5 = Lobby.ProcessQueue.RegisterEventHandler( Lobby.MatchmakingAsync.QoSHostsReplyComplete, {
				controller = f22_local8.controller,
				transactionID = f22_local3,
				originActionID = f22_local8.actionId
			} )
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpQoSReports(): calling LobbyMatchmakingQoSHostsReply" .. "\n actionId: " .. tostring( f22_local5 ) .. "\n controller: " .. tostring( f22_local8.controller ) .. "\n transactionID: " .. Engine[@"uint64tostring"]( f22_local3 ) .. "\n" )
			if Engine[@"hash_28918BE9D86FBD1F"]( f22_local5, f22_local8.controller, Engine[@"numbertouint64"]( 20000 ), f22_local3, f22_local4 ) == false then
				if Lobby.MMAsync.QoS[f22_local7].dedicatedQoS == true then
					local f22_local6 = Lobby.MatchmakingAsync.GetLocalUserInfo( f22_local8.controller )
					f22_local6.completedDCQoS = false
					f22_local6.hasInitiateDCQoS = false
				end
				Lobby.MMAsync.QoS[f22_local7] = nil
				Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpQoSReports(): LobbyMatchmakingQoSHostsReply failed.\n" )
				Lobby.ProcessQueue.UnRegisterEventHandler( f22_local5 )
			end
		end
	end
end
Lobby.MatchmakingAsync.PumpAsyncUpdate = function ( f23_arg0 )
	local f23_local0 = f23_arg0.primaryController
	if Lobby.MMAsync.Info.getLobbyDocs == false then
		return 
	elseif Engine[@"hash_C3DAFC9624723BB"]( f23_local0, Enum[@"hash_1253E52758902088"][@"hash_6294F9F5EBFD36E5"] ) then
		return 
	elseif Lobby.MMAsync.Info.lobbyID == nil or false == Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] ) then
		Lobby.MMAsync.Info.getLobbyDocs = false
		Lobby.MMAsync.Info.migrateHost = false
		return 
	end
	local f23_local1 = Lobby.ProcessQueue.RegisterEventHandler( Lobby.MatchmakingAsync.PumpAsyncUpdateComplete, {
		controller = f23_local0
	} )
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpAsyncUpdate(): calling LobbyMatchmakingGetLobbyDocuments" .. "\n actionId: " .. tostring( f23_local1 ) .. "\n controller: " .. tostring( f23_local0 ) .. "\n lobbyID: " .. Engine[@"uint64tostring"]( Lobby.MMAsync.Info.lobbyID ) .. "\n" )
	if Engine[@"hash_3D9856AEA42D5FD1"]( f23_local1, f23_local0, Engine[@"numbertouint64"]( 20000 ), Lobby.MMAsync.Info.lobbyID ) == false then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpAsyncUpdate(): LobbyMatchmakingGetLobbyDocuments failed.\n" )
		Lobby.ProcessQueue.UnRegisterEventHandler( f23_local1 )
	end
end
Lobby.MatchmakingAsync.IsInLobbyDocs = function ( f24_arg0, f24_arg1, f24_arg2 )
	if f24_arg1 == nil or f24_arg2 == nil then
		return false
	end
	local f24_local0 = false
	for f24_local4, f24_local5 in ipairs( f24_arg2.expectedPlayers ) do
		if f24_arg0 == f24_local5.xuid then
			f24_local0 = true
			break
		end
	end
	if f24_local0 == false then
		return false
	end
	f24_local0 = false
	f24_local1 = Engine[@"uint64tostring"]( f24_arg0 )
	for f24_local5, f24_local6 in pairs( f24_arg1.current_player_state ) do
		if f24_local1 == f24_local5 and f24_local6 == LuaEnum.LobbyMemberStatus.MEMBER_STATUS_CONNECTED then
			f24_local0 = true
			break
		end
	end
	return f24_local0
end
Lobby.MatchmakingAsync.PumpAsyncUpdateComplete = function ( f25_arg0, f25_arg1, f25_arg2 )
	local f25_local0 = f25_arg1.controller
	local f25_local1 = Lobby.MatchmakingAsync.GetLocalUserInfo( f25_local0 )
	if f25_local1.xuid == LuaDefine.INVALID_XUID_X64 then
		return 
	elseif f25_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING or f25_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f25_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpAsyncUpdateComplete failure.\n" )
		local f25_local2 = {
			controller = f25_local0,
			eventType = LuaEnum.bdEventType.BD_INTERNAL_ERROR,
			errorCode = f25_arg2.errorCode,
			lobbyID = Lobby.MMAsync.Info.lobbyID
		}
		Lobby.MMAsync.Info.migrateHost = false
		Lobby.MMAsync.Info.getLobbyDocs = false
		Lobby.MatchmakingAsync.Event( f25_local2 )
	elseif f25_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpAsyncUpdateComplete success.\n" )
		local f25_local2 = f25_arg2.lobbyHostDoc
		local f25_local3 = f25_arg2.lobbyBackendDoc
		Lobby.MMAsync.Info.getLobbyDocs = false
		if Lobby.MMAsync.Info.migrateHost == true then
			Lobby.MMAsync.Info.migrateHost = false
			local f25_local4 = Engine[@"lobbygetsessionclients"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"] )
			local f25_local5 = f25_local1.xuid
			local f25_local6 = {
				gamertag = f25_local1.gamertag,
				hostXuid = f25_local5,
				hostAddress = f25_local1.encodedAddr,
				sessionClients = f25_local4.sessionClients
			}
			local f25_local7 = Lobby.JSON.ParseLobbyBackendDoc( f25_local3 )
			local f25_local8 = Lobby.JSON.ParseLobbyHostDoc( f25_local2 )
			if f25_local7 ~= nil and f25_local8 ~= nil then
				if Lobby.MatchmakingAsync.IsInLobbyDocs( f25_local5, f25_local8, f25_local7 ) == false then
					local f25_local9 = {
						controller = f25_local0,
						eventType = LuaEnum.bdEventType.BD_INTERNAL_ERROR,
						errorCode = Lobby.MatchmakingAsync.ErrorCodes.TREY_AMM_INTERNAL,
						lobbyID = Lobby.MMAsync.Info.lobbyID
					}
					Lobby.MMAsync.Info.migrateHost = false
					Lobby.MMAsync.Info.getLobbyDocs = false
					Lobby.MatchmakingAsync.Event( f25_local9 )
				else
					Lobby.MatchmakingAsync.CacheAsyncInfo( f25_local8 )
					local f25_local9, f25_local10 = Lobby.JSON.CreateWritableDocFromString( Lobby.MMAsync.Info.lobbyHostDocTable.lobbyDoc )
					f25_local8 = Lobby.JSON.migrateHostData( f25_local9, f25_local10, f25_local8, f25_local6 )
					f25_local8 = Lobby.JSON.setUpdateID( f25_local9, f25_local10, f25_local8, f25_local8.update_id + 1 )
					Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f25_local9, f25_local8 )
					Lobby.MatchmakingAsync.CacheAsyncInfo( f25_local8, f25_local7, f25_local7.lobby_id )
					Engine[@"hash_6BFA89F119C70916"]( f25_local7.valid_map_pack_bits )
				end
			end
		end
	end
end
Lobby.MatchmakingAsync.PumpTimeOuts = function ()
	local f26_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
	if f26_local0 == nil or Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) == false then
		return 
	elseif Lobby.MMAsync.reservationTable.count == 0 then
		return 
	end
	local f26_local1 = Engine[@"milliseconds"]()
	local f26_local2 = {}
	for f26_local7, f26_local8 in pairs( f26_local0.current_player_state ) do
		if f26_local8 == LuaEnum.LobbyMemberStatus.MEMBER_STATUS_MAY_CONNECT then
			local f26_local6 = Lobby.MMAsync.reservationTable[f26_local7]
			if f26_local6 ~= nil and f26_local6 < f26_local1 then
				table.insert( f26_local2, {
					xuid = Engine[@"stringtoxuiddecimal"]( f26_local7 ),
					xuidstrnum = f26_local7
				} )
				Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpTimeOuts(), Client: " .. f26_local7 .. " has timed out adding to remove list.\n" )
			end
		end
	end
	if #f26_local2 > 0 then
		f26_local3 = {
			removeList = f26_local2
		}
		f26_local4, f26_local5 = Lobby.JSON.CreateWritableDocFromString( Lobby.MMAsync.Info.lobbyHostDocTable.lobbyDoc )
		f26_local0 = Lobby.JSON.RemoveClientsFromHostData( f26_local4, f26_local5, f26_local0, f26_local3 )
		Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f26_local4, Lobby.JSON.setUpdateID( f26_local4, f26_local5, f26_local0, f26_local0.update_id + 1 ) )
	end
end
Lobby.MatchmakingAsync.GetReservationWindow = function ()
	local f27_local0 = Dvar[@"hash_3DE6892CD84059A5"]:get()
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		f27_local0 = Dvar[@"hash_7CB0CCB76F22B527"]:get()
	end
	return f27_local0
end
Lobby.MatchmakingAsync.AddReservation = function ( f28_arg0 )
	if Lobby.MMAsync.reservationTable[f28_arg0] == nil then
		Lobby.MMAsync.reservationTable[f28_arg0] = Engine[@"milliseconds"]() + Lobby.MatchmakingAsync.GetReservationWindow()
		Lobby.MMAsync.reservationTable.count = Lobby.MMAsync.reservationTable.count + 1
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.AddReservation, Client: " .. f28_arg0 .. " adding list.\n" )
	end
end
Lobby.MatchmakingAsync.UpdateReservation = function ( f29_arg0 )
	if Lobby.MMAsync.Info.lobbyHostDocTable == nil then
		return true
	end
	local f29_local0 = Lobby.MatchmakingAsync.GetReservationWindow()
	local f29_local1 = ""
	for f29_local5, f29_local6 in pairs( f29_arg0 ) do
		f29_local1 = Engine[@"uint64tostring"]( f29_local6.xuid )
		if Lobby.MMAsync.reservationTable[f29_local1] ~= nil then
			Lobby.MMAsync.reservationTable[f29_local1] = Engine[@"milliseconds"]() + f29_local0
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.UpdateReservation, Client: " .. f29_local1 .. " starting join updating timeout.\n" )
		end
		return false
	end
	return true
end
Lobby.MatchmakingAsync.RemoveReservation = function ( f30_arg0 )
	if Lobby.MMAsync.reservationTable[f30_arg0] ~= nil then
		Lobby.MMAsync.reservationTable.count = Lobby.MMAsync.reservationTable.count - 1
		Lobby.MMAsync.reservationTable[f30_arg0] = nil
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.RemoveReservation, Removing client reservation: " .. f30_arg0 .. " from list.\n" )
	end
end
Lobby.MatchmakingAsync.ClearReservationTable = function ()
	for f31_local3 in pairs( Lobby.MMAsync.reservationTable ) do
		Lobby.MMAsync.reservationTable[f31_local3] = nil
	end
	Lobby.MMAsync.reservationTable.count = 0
end
Lobby.MatchmakingAsync.SyncFailedExtendTimeout = function ()
	local f32_local0 = Lobby.MatchmakingAsync.GetReservationWindow()
	for f32_local4 in pairs( Lobby.MMAsync.reservationTable ) do
		Lobby.MMAsync.reservationTable[f32_local4] = Engine[@"milliseconds"]() + f32_local0
	end
end
Lobby.MatchmakingAsync.OnPreExecFFOTD = function ( f33_arg0 )
	Engine[@"hash_7169BC389A4ED578"]()
end
Lobby.MatchmakingAsync.OnAsyncMatchmaking = function ( f34_arg0 )
	if Dvar[@"hash_44BADE8473F0165F"]:get() ~= true then
		return LuaDefine.ZERO_X64
	else
		local f34_local0 = Lobby.MatchmakingAsync.GetLocalUserInfo( f34_arg0.controller )
		if f34_local0 ~= nil and f34_local0.token ~= nil then
			return f34_local0.token
		else
			return LuaDefine.ZERO_X64
		end
	end
end
Lobby.MatchmakingAsync.OnClientAdded = function ( f35_arg0 )
	local f35_local0 = f35_arg0.lobbyModule
	local f35_local1 = f35_arg0.lobbyType
	local f35_local2 = f35_arg0.xuid
	if f35_local0 ~= Enum[@"lobbymodule"][@"lobby_module_host"] or f35_local1 ~= Enum[@"lobbytype"][@"lobby_type_game"] then
		return 
	elseif f35_local2 == Engine[@"getxuid64"]( Engine[@"getprimarycontroller"]() ) then
		return 
	else
		Lobby.MatchmakingAsync.RemoveReservation( Engine[@"uint64tostring"]( f35_local2 ) )
		Lobby.MMAsync.Sync.add = true
	end
end
Lobby.MatchmakingAsync.OnClientRemoved = function ( f36_arg0 )
	local f36_local0 = f36_arg0.lobbyModule
	local f36_local1 = f36_arg0.lobbyType
	local f36_local2 = f36_arg0.xuid
	if f36_local0 ~= Enum[@"lobbymodule"][@"lobby_module_host"] or f36_local1 ~= Enum[@"lobbytype"][@"lobby_type_game"] then
		return 
	elseif f36_local2 == Engine[@"getxuid64"]( Engine[@"getprimarycontroller"]() ) then
		return 
	else
		table.insert( Lobby.MMAsync.RemoveList, {
			xuid = f36_local2,
			xuidstrnum = Engine[@"uint64tostring"]( f36_local2 )
		} )
	end
end
Lobby.MatchmakingAsync.OnLobbyClientPromoteToHost = function ( f37_arg0 )
	Lobby.MMAsync.Info.getLobbyDocs = true
	Lobby.MMAsync.Info.migrateHost = true
	Lobby.MatchmakingAsync.LobbyIntermissionSummary = {}
	Lobby.MatchmakingAsync.LobbyIntermissionSummary[@"hash_522C2D85063EC515"] = Engine[@"hash_2786FFC9E621CAB7"]()
end
Lobby.MatchmakingAsync.OnJoinComplete = function ( f38_arg0 )
	
end
Lobby.MatchmakingAsync.OnPostExecFFOTD = function ( f39_arg0 )
	if Lobby.MMAsync.Info.ffotdLoaded == true then
		
	else
		
	end
	Lobby.MMAsync.Info.ffotdLoaded = true
end
Lobby.MatchmakingAsync.SetPlayerInfo = function ( f40_arg0, f40_arg1 )
	local f40_local0 = Engine[@"hash_1AA253936E744305"]()
	if f40_local0.valid == false then
		return 
	else
		f40_arg1.encodedAddr = Engine[@"hash_392DBC81F5C565D0"]( f40_local0.serializedAdr )
		local f40_local1 = Lobby.JSON.CreatePlayerInfoDoc( f40_arg1 )
		local f40_local2 = Lobby.ProcessQueue.RegisterEventHandler( Lobby.MatchmakingAsync.SetPlayerInfoComplete, {
			controller = f40_arg0,
			playerInfoDoc = f40_local1
		} )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.SetPlayerInfo(): calling LobbyMatchmakingSetPlayerInfo" .. "\n actionId: " .. tostring( f40_local2 ) .. "\n controller: " .. tostring( f40_arg0 ) .. "\n playerInfoDoc: " .. f40_local1 .. "\n" )
		if Engine[@"hash_264060ECD2E5E1DE"]( f40_local2, f40_arg0, Engine[@"numbertouint64"]( 20000 ), f40_local1 .. " " ) == false then
			Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.SetPlayerInfo(): LobbyMatchmakingSetPlayerInfo failed.\n" )
			Lobby.ProcessQueue.UnRegisterEventHandler( f40_local2 )
			return false
		else
			return true
		end
	end
end
Lobby.MatchmakingAsync.SetPlayerInfoComplete = function ( f41_arg0, f41_arg1, f41_arg2 )
	local f41_local0 = f41_arg1.controller
	local f41_local1 = Lobby.MatchmakingAsync.GetLocalUserInfo( f41_local0 )
	if f41_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING or f41_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f41_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "LobbyMatchmakingSetPlayerInfo for " .. Engine[@"getgamertagforcontroller"]( f41_local0 ) .. " failed.\n" )
	elseif f41_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		f41_local1.playerInfo = true
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "LobbyMatchmakingSetPlayerInfo for " .. f41_local1.gamertag .. " success.\n" )
	end
end
Lobby.MatchmakingAsync.GetMatchMakingPlayerToken = function ( f42_arg0, f42_arg1 )
	local f42_local0 = Lobby.ProcessQueue.RegisterEventHandler( Lobby.MatchmakingAsync.GetMatchMakingPlayerTokenComplete, {
		controller = f42_arg0
	} )
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.GetMatchMakingPlayerToken(): calling LobbyMatchmakingGetMatchMakingPlayerToken" .. "\n actionId: " .. tostring( f42_local0 ) .. "\n controller: " .. tostring( f42_arg0 ) .. "\n" )
	if Engine[@"hash_519E87D6B48B8419"]( f42_local0, f42_arg0, Engine[@"numbertouint64"]( 20000 ) ) == false then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.GetMatchMakingPlayerToken(): LobbyMatchmakingGetMatchMakingPlayerToken failed.\n" )
		Lobby.ProcessQueue.UnRegisterEventHandler( f42_local0 )
		return false
	else
		return true
	end
end
Lobby.MatchmakingAsync.GetMatchMakingPlayerTokenComplete = function ( f43_arg0, f43_arg1, f43_arg2 )
	local f43_local0 = f43_arg1.controller
	local f43_local1 = Lobby.MatchmakingAsync.GetLocalUserInfo( f43_local0 )
	if f43_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING or f43_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f43_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "LobbyMatchmakingGetMatchMakingPlayerToken for " .. Engine[@"getgamertagforcontroller"]( f43_local0 ) .. " failed.\n" )
	elseif f43_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		f43_local1.hasToken = true
		f43_local1.token = f43_arg2.matchMakingPlayerToken
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "LobbyMatchmakingGetMatchMakingPlayerToken for " .. f43_local1.gamertag .. " success, saving player token: " .. tostring( f43_local1.token ) .. ".\n" )
	end
end
Lobby.MatchmakingAsync.InitiateDCQoS = function ( f44_arg0, f44_arg1 )
	local f44_local0 = Lobby.ProcessQueue.RegisterEventHandler( Lobby.MatchmakingAsync.InitiateDCQoSComplete, {
		controller = f44_arg0
	} )
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.InitiateDCQoS(): calling LobbyMatchmakingInitiateDCQoS" .. "\n actionId: " .. tostring( f44_local0 ) .. "\n controller: " .. tostring( f44_arg0 ) .. "\n" )
	if Engine[@"hash_645C148D02FC85DC"]( f44_local0, f44_arg0, Engine[@"numbertouint64"]( 20000 ) ) == false then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.InitiateDCQoS(): LobbyMatchmakingInitiateDCQoS failed.\n" )
		Lobby.ProcessQueue.UnRegisterEventHandler( f44_local0 )
		return false
	else
		f44_arg1.completedDCQoS = false
		return true
	end
end
Lobby.MatchmakingAsync.InitiateDCQoSComplete = function ( f45_arg0, f45_arg1, f45_arg2 )
	local f45_local0 = f45_arg1.controller
	local f45_local1 = Lobby.MatchmakingAsync.GetLocalUserInfo( f45_local0 )
	if f45_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING or f45_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f45_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "LobbyMatchmakingInitiateDCQoS failed.\n" )
	elseif f45_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "LobbyMatchmakingInitiateDCQoS for " .. f45_local1.gamertag .. " success.\n" )
		f45_local1.hasInitiateDCQoS = true
		f45_local1.completedDCQoS = false
		f45_local1.lastDCQoSSuccess = Engine[@"milliseconds"]()
		f45_local1.dcQoSInfo = f45_arg2.dcQoSInfo
		if f45_local1.dcQoSInfo == "{}" then
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "LobbyMatchmakingInitiateDCQoS no results to QoS.\n" )
			return 
		end
		local f45_local2 = Lobby.JSON.ParseDCQoSInfo( f45_local1.dcQoSInfo )
		if f45_local2 == nil then
			return 
		end
		f45_local2.controller = f45_local0
		Lobby.MatchmakingAsync.EventQoSHosts( f45_local2, true )
	end
end
Lobby.MatchmakingAsync.QoSHostsComplete = function ( f46_arg0, f46_arg1, f46_arg2 )
	local f46_local0 = f46_arg1.controller
	local f46_local1 = f46_arg1.transactionID
	local f46_local2 = f46_arg2.qosProbeInfo
	local f46_local3 = Lobby.MatchmakingAsync.GetLocalUserInfo( f46_local0 )
	local f46_local4 = Lobby.MMAsync.QoS[f46_arg2.actionId]
	if f46_local4 == nil or f46_local4.active == false then
		return 
	elseif f46_arg2.validResult == false then
		f46_local2 = {
			disabled = true
		}
	end
	if f46_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING or f46_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f46_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		f46_local4.stage = Lobby.MatchmakingAsync.QoSStage.REPORT
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.QoSHostsComplete for " .. Engine[@"getgamertagforcontroller"]( f46_local0 ) .. " failed.\n" )
	elseif f46_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS or f46_arg0 == Lobby.ProcessQueue.ACTIONSTATE.UPDATE then
		table.insert( f46_local4.probedHostsResults, f46_local2 )
		if #f46_local4.probedHosts == #f46_local4.probedHostsResults then
			f46_local4.stage = Lobby.MatchmakingAsync.QoSStage.REPORT
			f46_local4.probeWaitEndTime = 0
		end
	end
	return false
end
Lobby.MatchmakingAsync.QoSHostsReplyComplete = function ( f47_arg0, f47_arg1, f47_arg2 )
	local f47_local0 = f47_arg1.controller
	local f47_local1 = f47_arg1.transactionID
	local f47_local2 = Lobby.MatchmakingAsync.GetLocalUserInfo( f47_local0 )
	if f47_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING or f47_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f47_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.QoSHostsReplyComplete for " .. Engine[@"getgamertagforcontroller"]( f47_local0 ) .. " failed.\n" )
	elseif f47_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.QoSHostsReplyComplete success, results reported for " .. f47_local2.gamertag .. ".\n" )
	end
	local f47_local3 = f47_arg1.originActionID
	if Lobby.MMAsync.QoS[f47_local3].dedicatedQoS == true then
		local f47_local4 = Lobby.MatchmakingAsync.GetLocalUserInfo( f47_local0 )
		f47_local4.completedDCQoS = true
	end
	Lobby.MMAsync.QoS[f47_local3] = nil
	Engine[@"hash_699C78DEE757B95D"]( f47_local3 )
end
Lobby.MatchmakingAsync.SyncHostDocumentsComplete = function ( f48_arg0, f48_arg1, f48_arg2 )
	local f48_local0 = f48_arg1.controller
	if f48_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING or f48_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f48_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Lobby.MatchmakingAsync.SyncFailedExtendTimeout()
		Lobby.MMAsync.Sync.failedCount = Lobby.MMAsync.Sync.failedCount + 1
		if f48_arg2.errorCode == Lobby.MatchmakingAsync.ErrorCodes.BD_AMM_BACKOFF_REQUESTED then
			Lobby.MMAsync.backoffMultiplyer = 2
		elseif f48_arg2.errorCode == Lobby.MatchmakingAsync.ErrorCodes.BD_AMM_INVALID_LOBBY_ID or Lobby.MMAsync.Sync.failedCount > 20 then
			local f48_local1 = {
				controller = Engine[@"getprimarycontroller"](),
				eventType = LuaEnum.bdEventType.BD_INTERNAL_ERROR,
				errorCode = f48_arg2.errorCode,
				lobbyID = Lobby.MMAsync.Info.lobbyID
			}
			if Lobby.MMAsync.Info.lobbyHostDocTable ~= nil then
				Lobby.MMAsync.Info.lobbyHostDocTable.needs_update = false
			end
			Lobby.MatchmakingAsync.Event( f48_local1 )
		end
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.SyncHostDocumentsComplete failed.  Failed Count = " .. tostring( Lobby.MMAsync.Sync.failedCount ) .. "\n" )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				message = "SyncHostDocumentsComplete: failed"
			} )
		end
	elseif f48_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Lobby.MMAsync.Sync.failedCount = 0
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.SyncHostDocumentsComplete for success. Sync result " .. tostring( f48_arg2.syncLobbyDocuments ) .. "\n" )
		if f48_arg2.syncLobbyDocuments == false then
			Lobby.MatchmakingAsync.SyncFailedExtendTimeout()
		end
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				message = "SyncHostDocumentsComplete: success"
			} )
		end
	end
end
Lobby.MatchmakingAsync.OnRequestDedicatedShutdown = function ()
	Lobby.MMAsync.Dedi.ServerShutdownStage = Lobby.MatchmakingAsync.ShutdownRequestStage.REQUESTED
end
Lobby.MatchmakingAsync.Event = function ( f50_arg0 )
	local f50_local0 = f50_arg0.eventType
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( " .. LuaEnum.bdEventTypeString[f50_local0] .. " ) received for controller(" .. tostring( f50_arg0.controller ) .. ").\n" )
	if f50_local0 == LuaEnum.bdEventType.BD_QOS_HOSTS then
		Lobby.MMAsync.QoSEventQueue[#Lobby.MMAsync.QoSEventQueue + 1] = f50_arg0
	else
		Lobby.MatchmakingAsync.IsEventQueuePush( f50_arg0 )
	end
end
Lobby.MatchmakingAsync.CheckEventQueue = function ()
	if not Lobby.MatchmakingAsync.IsEventQueueEmpty() then
		local f51_local0 = Lobby.MatchmakingAsync.EventQueuePeek()
		Lobby.MatchmakingAsync.EventQueuePop()
		Lobby.MatchmakingAsync.ProcessEvent( f51_local0 )
	end
end
Lobby.MatchmakingAsync.ProcessQOSQueue = function ()
	if #Lobby.MMAsync.QoSEventQueue > 0 then
		local f52_local0 = Lobby.MMAsync.QoSEventQueue[1]
		table.remove( Lobby.MMAsync.QoSEventQueue, 1 )
		Lobby.MatchmakingAsync.ProcessEvent( f52_local0 )
	end
end
Lobby.MatchmakingAsync.IsEventQueueEmpty = function ()
	return #Lobby.MMAsync.Event.Queue == 0
end
Lobby.MatchmakingAsync.EventQueuePeek = function ()
	if not Lobby.MatchmakingAsync.IsEventQueueEmpty() then
		return Lobby.MMAsync.Event.Queue[1]
	else
		return nil
	end
end
Lobby.MatchmakingAsync.EventQueueOverwriteTop = function ( f55_arg0 )
	if not Lobby.MatchmakingAsync.IsEventQueueEmpty() then
		Lobby.MMAsync.Event.Queue[1] = f55_arg0
	end
end
Lobby.MatchmakingAsync.EventQueuePop = function ()
	table.remove( Lobby.MMAsync.Event.Queue, 1 )
end
Lobby.MatchmakingAsync.IsEventQueuePush = function ( f57_arg0 )
	Lobby.MMAsync.Event.Queue[#Lobby.MMAsync.Event.Queue + 1] = f57_arg0
end
Lobby.MatchmakingAsync.EmptyEventQueue = function ()
	Lobby.MatchmakingAsync.ClearCacheAsyncInfo()
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EmptyEventQueue() called\n" )
	while #Lobby.MMAsync.Event.Queue > 0 do
		table.remove( Lobby.MMAsync.Event.Queue, 1 )
	end
	Lobby.MMAsync.Info.matchmakingID = 0
end
Lobby.MatchmakingAsync.IsEventInQueue = function ( f59_arg0 )
	for f59_local3, f59_local4 in ipairs( Lobby.MMAsync.Event.Queue ) do
		if f59_local4.eventType == f59_arg0 then
			return true
		end
	end
	return false
end
Lobby.MatchmakingAsync.ProcessEvent = function ( f60_arg0 )
	local f60_local0 = f60_arg0.eventType
	local f60_local1 = f60_arg0.controller
	local f60_local2 = Engine[@"getprimarycontroller"]()
	if Engine[@"isdedicatedserver"]() == true then
		f60_local1 = Engine[@"getprimarycontroller"]()
	end
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.ProcessEvent( " .. LuaEnum.bdEventTypeString[f60_local0] .. " ) received for controller(" .. tostring( f60_local1 ) .. ").\n" )
	if f60_local2 ~= f60_local1 and f60_local0 ~= LuaEnum.bdEventType.BD_QOS_HOSTS then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Ignoring not primary controller \n" )
		return 
	end
	Lobby.Debug.OnAsyncMatchmaking( f60_arg0 )
	if f60_local0 == LuaEnum.bdEventType.BD_QOS_HOSTS then
		local f60_local3 = f60_arg0.transactionID
		local f60_local4 = f60_arg0.qosHosts
		local f60_local5 = f60_arg0.numProbes
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_QOS_HOSTS ):" .. "\n controller: " .. tostring( f60_local1 ) .. "\n transactionID: " .. Engine[@"uint64tostring"]( f60_local3 ) .. "\n numProbes: " .. tostring( f60_local5 ) .. "\n" )
		Lobby.MatchmakingAsync.EventQoSHosts( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0,
				transactionID = f60_local3,
				numProbes = f60_local5
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_JOIN_LOBBY then
		local f60_local3 = f60_arg0.matchMakingID
		local f60_local4 = f60_arg0.lobbyID
		local f60_local5 = f60_arg0.lobbyHostDoc
		local f60_local6 = f60_arg0.lobbyHostDocLength
		local f60_local7 = f60_arg0.lobbyBackendDoc
		local f60_local8 = f60_arg0.lobbyBackendDocLength
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_JOIN_LOBBY ): \n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "controller: " .. tostring( f60_local1 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "matchMakingID: " .. Engine[@"uint64tostring"]( f60_local3 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyID: " .. Engine[@"uint64tostring"]( f60_local4 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyHostDoc: " .. f60_local5 .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyHostDocLength: " .. tostring( f60_local6 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyBackendDoc: " .. f60_local7 .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyBackendDocLength: " .. tostring( f60_local8 ) .. "\n" )
		Lobby.MatchmakingAsync.EventJoinLobby( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0,
				matchmakingID = f60_local3,
				lobbyID = f60_local4
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_LOBBY_DISBANDED then
		local f60_local3 = f60_arg0.lobbyID
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_LOBBY_DISBANDED ):" .. "\n controller: " .. tostring( f60_local1 ) .. "\n lobbyID: " .. Engine[@"uint64tostring"]( f60_local3 ) .. "\n" )
		Lobby.MatchmakingAsync.EventLobbyDisbanded( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0,
				lobbyID = f60_local3
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_MATCHMAKING_SEARCH_STATUS then
		local f60_local3 = f60_arg0.matchMakingID
		local f60_local4 = f60_arg0.matchMakingSearchStatus
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_MATCHMAKING_SEARCH_STATUS ):" .. "\n controller: " .. tostring( f60_local1 ) .. "\n matchMakingID: " .. Engine[@"uint64tostring"]( f60_local3 ) .. "\n matchMakingSearchStatus: " .. f60_local4 .. "\n statusBufferSize: " .. tostring( f60_arg0.statusBufferSize ) .. "\n" )
		Lobby.MatchmakingAsync.EventMatchmakingSearchStatus( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0,
				matchmakingID = f60_local3,
				matchmakingSearchStatus = f60_local4
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_LOBBY_NOT_FOUND then
		local f60_local3 = f60_arg0.matchMakingID
		local f60_local4 = f60_arg0.lobbyNotFoundCause
		local f60_local5 = "Unknown"
		if f60_local4 <= LuaEnum.LobbyNotFoundCause.BD_LAST and f60_local4 >= 0 then
			f60_local5 = LuaEnum.LobbyNotFoundCauseString[f60_local4]
		end
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_LOBBY_NOT_FOUND ):" .. "\n controller: " .. tostring( f60_local1 ) .. "\n matchMakingID: " .. Engine[@"uint64tostring"]( f60_local3 ) .. "\n lobbyNotFoundCause: " .. tostring( f60_local4 ) .. " (" .. f60_local5 .. ")" .. "\n" )
		Lobby.MatchmakingAsync.EventLobbyNotFound( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0,
				matchmakingID = f60_local3,
				lobbyNotFoundCause = f60_local4
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_CREATE_NEW_LOBBY then
		local f60_local3 = f60_arg0.matchMakingID
		local f60_local4 = f60_arg0.lobbyID
		local f60_local5 = f60_arg0.updateID
		local f60_local6 = f60_arg0.lobbyHostDoc
		local f60_local7 = f60_arg0.lobbyHostDocLength
		local f60_local8 = f60_arg0.lobbyBackendDoc
		local f60_local9 = f60_arg0.lobbyBackendDocLength
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_CREATE_NEW_LOBBY ):\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "controller: " .. tostring( f60_local1 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "matchMakingID: " .. Engine[@"uint64tostring"]( f60_local3 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyID: " .. Engine[@"uint64tostring"]( f60_local4 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "updateID: " .. Engine[@"uint64tostring"]( f60_local5 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyHostDoc: " .. f60_local6 .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyHostDocLength: " .. tostring( f60_local7 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyBackendDoc: " .. f60_local8 .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyBackendDocLength: " .. tostring( f60_local9 ) .. "\n" )
		Lobby.MatchmakingAsync.EventCreateNewLobby( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0,
				lobbyID = f60_local4,
				matchmakingID = f60_local3,
				updateID = f60_local5
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_UPDATED_LOBBY_DOCUMENT then
		local f60_local3 = f60_arg0.lobbyID
		local f60_local4 = f60_arg0.updateID
		local f60_local5 = f60_arg0.lobbyHostDoc
		local f60_local6 = f60_arg0.lobbyHostDocLength
		local f60_local7 = f60_arg0.lobbyBackendDoc
		local f60_local8 = f60_arg0.lobbyBackendDocLength
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_UPDATED_LOBBY_DOCUMENT ):\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "controller: " .. tostring( f60_local1 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyID: " .. Engine[@"uint64tostring"]( f60_local3 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "updateID: " .. Engine[@"uint64tostring"]( f60_local4 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyHostDoc: " .. f60_local5 .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyHostDocLength: " .. tostring( f60_local6 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyBackendDoc: " .. f60_local7 .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyBackendDocLength: " .. tostring( f60_local8 ) .. "\n" )
		Lobby.MatchmakingAsync.EventUpdatedLobbyDocument( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0,
				lobbyID = f60_local3,
				updateID = f60_local4
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_EXPECT_GAME then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_EXPECT_GAME ):" .. "\n controller: " .. tostring( f60_local1 ) .. "\n lobbyID: " .. Engine[@"uint64tostring"]( f60_arg0.lobbyID ) .. "\n lobbyBackendDoc: " .. f60_arg0.lobbyBackendDoc .. "\n lobbyBackendDocLength: " .. tostring( f60_arg0.lobbyBackendDocLength ) .. "\n" )
		Lobby.MatchmakingAsync.EventExpectGame( f60_arg0 )
	elseif f60_local0 == LuaEnum.bdEventType.BD_MERGE_INTO_LOBBY then
		local f60_local3 = f60_arg0.matchMakingID
		local f60_local4 = f60_arg0.sourceLobbyID
		local f60_local5 = f60_arg0.destinationLobbyID
		local f60_local6 = f60_arg0.lobbyHostDoc
		local f60_local7 = f60_arg0.lobbyHostDocLength
		local f60_local8 = f60_arg0.lobbyBackendDoc
		local f60_local9 = f60_arg0.lobbyBackendDocLength
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_MERGE_INTO_LOBBY ):\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "controller: " .. tostring( f60_local1 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "matchMakingID: " .. Engine[@"uint64tostring"]( f60_local3 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "sourceLobbyID: " .. Engine[@"uint64tostring"]( f60_local4 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "destinationLobbyID: " .. Engine[@"uint64tostring"]( f60_local5 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyHostDoc: " .. f60_local6 .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyHostDocLength: " .. tostring( f60_local7 ) .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyBackendDoc: " .. f60_local8 .. "\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "lobbyBackendDocLength: " .. tostring( f60_local9 ) .. "\n" )
		Lobby.MatchmakingAsync.EventMergeIntoLobby( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0,
				matchmakingID = f60_local3,
				lobbyID = f60_local4,
				destinationLobbyID = f60_local5
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_SYNC_HOSTDOC then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_SYNC_HOSTDOC ):\n" )
		Lobby.MatchmakingAsync.EventSyncHostDocument( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0
			} )
		end
	elseif f60_local0 == LuaEnum.bdEventType.BD_INTERNAL_ERROR then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.Event( BD_INTERNAL_ERROR ):\n" )
		Lobby.MatchmakingAsync.EventLobbyDisbanded( f60_arg0 )
		if Dvar[@"ui_lobbydebugsessionsqj"]:get() then
			Lobby.Debug.SessionSQJLogBDEvent( {
				eventType = f60_local0
			} )
		end
	else
		f60_local0 = f60_arg0.eventType
	end
end
Lobby.MatchmakingAsync.EventQoSHosts = function ( f61_arg0, f61_arg1 )
	local f61_local0 = f61_arg0.controller
	local f61_local1 = f61_arg0.transactionID
	local f61_local2 = f61_arg0.qosHosts
	local f61_local3 = f61_arg0.numProbes
	if f61_local2 == nil or #f61_local2 == 0 then
		return 
	end
	local f61_local4 = Lobby.ProcessQueue.RegisterEventHandler( Lobby.MatchmakingAsync.QoSHostsComplete, {
		controller = f61_local0,
		transactionID = f61_local1
	} )
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventQoSHosts(): calling QoSProbeInitiate" .. "\n actionId: " .. tostring( f61_local4 ) .. "\n controller: " .. tostring( f61_local0 ) .. "\n" )
	Lobby.MMAsync.QoS[f61_local4] = {}
	Lobby.MMAsync.QoS[f61_local4].probedHosts = {}
	for f61_local8, f61_local9 in ipairs( f61_local2 ) do
		Lobby.MMAsync.QoS[f61_local4].probedHosts[f61_local8] = {
			xuid = LuaDefine.INVALID_XUID_X64,
			hostAddress = f61_local9.serializedAdr,
			gameSecurityId = f61_local9.secIdInt64,
			gameSecurityKey = f61_local9.secKey,
			addressBase64Encoded = f61_local9.addressBase64Encoded,
			datacenterBase64Encoded = f61_local9.datacenterBase64Encoded
		}
	end
	f61_local5 = false
	if f61_arg1 ~= nil then
		f61_local5 = Engine[@"hash_15345F3E39A92329"]( f61_local4, Enum[@"lobbytype"][@"lobby_type_private"], Lobby.MMAsync.QoS[f61_local4].probedHosts, f61_local3 )
	else
		f61_local5 = Engine[@"qosprobeinitiate"]( f61_local4, Lobby.MMAsync.QoS[f61_local4].probedHosts, f61_local3 )
	end
	if f61_local5 == false then
		Lobby.MMAsync.QoS[f61_local4] = nil
		Engine[@"hash_699C78DEE757B95D"]( f61_local4 )
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventQoSHosts(): QoSProbeInitiate failed.\n" )
		Lobby.ProcessQueue.UnRegisterEventHandler( f61_local4 )
		return false
	end
	Lobby.MMAsync.QoS[f61_local4].controller = f61_local0
	Lobby.MMAsync.QoS[f61_local4].active = true
	Lobby.MMAsync.QoS[f61_local4].stage = Lobby.MatchmakingAsync.QoSStage.INPROGRESS
	Lobby.MMAsync.QoS[f61_local4].probedHostsResults = {}
	Lobby.MMAsync.QoS[f61_local4].actionId = f61_local4
	Lobby.MMAsync.QoS[f61_local4].transactionID = f61_local1
	f61_local6 = Lobby.MMAsync.MAX_QOS_PROBE_RESULT_WAIT_TIME
	if Dvar[@"liveqos_lobbymaxwaitms"]:exists() then
		f61_local7 = Dvar[@"liveqos_lobbymaxwaitms"]:get()
		if f61_local7 > 0 then
			f61_local6 = f61_local7
		end
	end
	Lobby.MMAsync.QoS[f61_local4].probeWaitEndTime = Engine[@"milliseconds"]() + f61_local6
	Lobby.MMAsync.QoS[f61_local4].dedicatedQoS = f61_arg1 ~= nil
end
Lobby.MatchmakingAsync.EventJoinLobby = function ( f62_arg0 )
	local f62_local0 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"] )
	local f62_local1 = f62_arg0.matchMakingID
	local f62_local2 = f62_arg0.lobbyID
	if Engine[@"islobbyhost"]( f62_local0 ) == false and false == Dvar[@"hash_554BAC1E47D5EAE5"]:get() then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventJoinLobby() I'm a remote client ignore JOIN\n" )
		Lobby.MatchmakingAsync.CacheAsyncInfo( nil, nil, f62_local2 )
		return 
	elseif f62_local1 ~= Lobby.MMAsync.Info.matchmakingID then
		return 
	end
	Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_3_DESCRIPTION_2 )
	local f62_local3 = f62_arg0.controller
	local f62_local4 = f62_arg0.lobbyHostDoc
	local f62_local5 = f62_arg0.lobbyHostDocLength
	local f62_local6 = f62_arg0.lobbyBackendDoc
	local f62_local7 = f62_arg0.lobbyBackendDocLength
	Lobby.MatchmakingAsync.AsyncMatchmakingRunning( false )
	local f62_local8 = Lobby.JSON.ParseLobbyHostDoc( f62_local4 )
	local f62_local9 = Lobby.JSON.ParseLobbyBackendDoc( f62_local6 )
	local f62_local10 = Engine[@"hash_2786FFC9E621CAB7"]()
	Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[@"hash_4C352A5202CDD23F"] = f62_local10
	local f62_local11 = false
	if f62_local8.team_balance ~= nil and f62_local8.team_balance.can_change_teams ~= nil and f62_local8.team_balance.can_change_teams == false then
		f62_local11 = true
		Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[@"hash_2B4A32E71C22452"] = Engine[@"defaultid64value"]()
		Lobby.MatchmakingAsync.PartyToMatchSummary[@"hash_2B4A32E71C22452"] = Engine[@"defaultid64value"]()
	end
	Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[@"hash_329A52FFC78A973"] = f62_local11
	Lobby.MatchmakingAsync.PartyToMatchSummary[@"hash_329A52FFC78A973"] = f62_local11
	search_record = Lobby.MatchmakingAsync.PartyToMatchSummary[@"searches"][tostring( f62_local1 )]
	if nil ~= search_record then
		search_record[@"hash_4C352A5202CDD23F"] = f62_local10
		search_record[@"hash_EFDBE96A9503CF"] = f62_local2
		search_record[0xF7CBB339F0026] = f62_local8.listen_server.host_player_id
		search_record[@"hash_63088D1189C30C01"] = f62_local10
		search_record[@"search_outcome"] = Lobby.MatchmakingAsync.SearchOutcome.LOBBY_JOIN
	end
	Lobby.MatchmakingAsync.CacheAsyncInfo( f62_local8, f62_local9, f62_local2, f62_local9.update_id )
	local f62_local12 = {
		controller = f62_local3,
		lobbyHostXuid = f62_local8.listen_server.host_player_id,
		hostAddress = f62_local8.listen_server.hostAddress,
		secIdKey = f62_local9.secIdKey,
		hostName = f62_local8.attachment.host_name,
		joinPrivateXUID = f62_arg0.joinPrivateXUID
	}
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventJoinLobby(): calling LobbyMatchmakingJoinAsyncMatchmakingHost" .. "\n controller: " .. tostring( f62_local3 ) .. "\n" )
	local f62_local13 = LobbyData.GetLobbyMenuByID( Engine[@"hash_29876169A285ECE7"]( f62_local8.attachment.host_menuID ) )
	if Engine[@"isingame"]() and Dvar[@"hash_554BAC1E47D5EAE5"]:get() == true then
		Lobby.ProcessQueue.AddToQueue( "RedeployJoinAsyncMatchmakingLobby", Lobby.Process.RedeployJoinAsyncMatchmakingLobby( f62_local3, f62_local13, f62_local12 ) )
	else
		Lobby.ProcessQueue.AddToQueue( "JoinAsyncMatchmakingLobby", Lobby.Process.JoinAsyncMatchmakingLobby( f62_local3, f62_local13, f62_local12 ) )
	end
end
Lobby.MatchmakingAsync.EventLobbyDisbanded = function ( f63_arg0 )
	local f63_local0 = f63_arg0.controller
	local f63_local1 = f63_arg0.lobbyID
	Lobby.Matchmaking.UpdateSearchStatus( Enum[@"lobbytype"][@"lobby_type_private"], LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE )
	Lobby.MatchmakingAsync.LobbyIntermissionSummarySendDLogEvent( {
		reasonIntermissionEnded = Lobby.MatchmakingAsync.ReasonIntermissionEnded.LOBBY_DISBANDED
	} )
	if Engine[@"isdedicatedserver"]() == true then
		Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.DISBAND_LOBBY
		if Dvar[@"hash_7DF7E183879409E7"]:exists() and true == Dvar[@"hash_7DF7E183879409E7"]:get() then
			LuaUtils.SafeComError( Enum[@"errorcode"][@"error_drop"], @"exe/disconnected" )
		end
	elseif not Engine[@"isingame"]() then
		if Lobby.MMAsync.Info.lobbyID ~= nil and f63_local1 == Lobby.MMAsync.Info.lobbyID and Enum[@"emodes"][@"mode_warzone"] ~= Engine[@"currentsessionmode"]() then
			LuaUtils.SafeComError( Enum[@"errorcode"][@"error_drop"], @"exe/disconnected" )
		end
	elseif Dvar[@"hash_7DF7E183879409E7"]:exists() and true == Dvar[@"hash_7DF7E183879409E7"]:get() then
		LuaUtils.SafeComError( Enum[@"errorcode"][@"error_drop"], @"exe/disconnected" )
	else
		Lobby.MMAsync.DelayCmd = Lobby.MatchmakingAsync.LobbyDelayedCMD.LOBBY_DISBAND_AFTERMATCH
	end
end
Lobby.MatchmakingAsync.EventMatchmakingSearchStatus = function ( f64_arg0 )
	local f64_local0 = f64_arg0.controller
	local f64_local1 = f64_arg0.matchMakingID
	local f64_local2 = f64_arg0.matchMakingSearchStatus
	local f64_local3 = f64_arg0.statusBufferSize
end
Lobby.MatchmakingAsync.EventLobbyNotFound = function ( f65_arg0 )
	local f65_local0 = f65_arg0.controller
	local f65_local1 = f65_arg0.matchMakingID
	local f65_local2 = f65_arg0.lobbyNotFoundCause
	if f65_local1 ~= Lobby.MMAsync.Info.matchmakingID then
		return 
	end
	Lobby.Matchmaking.UpdateSearchStatus( Enum[@"lobbytype"][@"lobby_type_private"], LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE )
	searchRecord = Lobby.MatchmakingAsync.PartyToMatchSummary[@"searches"][tostring( matchmakingID )]
	if searchRecord ~= nil then
		searchRecord[@"hash_63088D1189C30C01"] = Engine[@"hash_2786FFC9E621CAB7"]()
		searchRecord[@"search_outcome"] = Lobby.MatchmakingAsync.SearchOutcome.LOBBY_JOIN_FAILED
	end
	local f65_local3 = Engine[@"getlobbyuiscreen"]()
	if f65_local3 == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC ) and f65_local3 == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING ) and f65_local3 == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC ) and f65_local3 == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_CP_PUBLIC ) and f65_local3 == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC ) then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby not found go back\n" )
		LobbyVM.OnGoBack( {
			controller = f65_local0,
			withParty = LuaEnum.LEAVE_WITH_PARTY.WITH
		} )
	end
end
Lobby.MatchmakingAsync.EventCreateNewLobby = function ( f66_arg0 )
	if not Engine[@"isdedicatedserver"]() then
		local f66_local0 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"] )
		if f66_arg0.matchMakingID ~= Lobby.MMAsync.Info.matchmakingID then
			return 
		elseif Engine[@"islobbyhost"]( f66_local0 ) == false then
			error( "Remote client got a Create Host message!" )
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventJoinLobby() I'm a remote client ignore JOIN\n" )
			return 
		end
	end
	Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_3_DESCRIPTION_3 )
	local f66_local1 = f66_arg0.controller
	local f66_local0 = f66_arg0.lobbyID
	local f66_local2 = f66_arg0.updateID
	local f66_local3 = f66_arg0.lobbyHostDoc
	local f66_local4 = f66_arg0.lobbyHostDocLength
	local f66_local5 = f66_arg0.lobbyBackendDoc
	local f66_local6 = f66_arg0.lobbyBackendDocLength
	local f66_local7 = {
		hostName = Engine[@"getselfgamertag"]( f66_local1 )
	}
	local f66_local8 = Lobby.JSON.ParseLobbyBackendDoc( f66_local5 )
	local f66_local9 = {
		expectedPlayers = f66_local8.expectedPlayers
	}
	local f66_local10 = f66_local8.playlist_id
	local f66_local11 = Engine[@"getplaylistinfobyid"]( f66_local10 )
	local f66_local12 = f66_local8.secIdKey
	local f66_local13 = {}
	if Engine[@"isdedicatedserver"]() == true then
		if f66_local11.mainMode == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] then
			if LuaUtils.IsArenaPlaylist( f66_local10 ) then
				f66_local13 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING )
			else
				f66_local13 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC )
			end
		elseif f66_local11.mainMode == Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
			f66_local13 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC )
		elseif f66_local11.mainMode == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
			f66_local13 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC )
		end
		f66_local7.menuID = f66_local13[@"id"]
		Engine[@"setfakedlcbits"]( f66_local8.valid_map_pack_bits )
	else
		f66_local7.menuID = Engine[@"getlobbyuiscreen"]()
		f66_local13 = LobbyData.GetLobbyMenuByID( f66_local7.menuID )
	end
	local f66_local14 = Lobby.JSON.ParseLobbyHostDoc( f66_local3 )
	local f66_local15, f66_local16 = Lobby.JSON.CreateWritableDocFromString( f66_local14.lobbyDoc )
	f66_local14 = Lobby.JSON.AddExpectedPlayersToLobbyHostDoc( f66_local15, f66_local16, Lobby.JSON.AddHostAttachmentInfo( f66_local15, f66_local16, f66_local14, f66_local7 ), f66_local9, {} )
	if f66_local8.forced_empty == true then
		f66_local14 = Lobby.JSON.setAllowPresenseJoin( f66_local15, f66_local16, Lobby.JSON.setLobbyOpen( f66_local15, f66_local16, f66_local14, false ), true )
	end
	f66_local14 = Lobby.JSON.setUpdateID( f66_local15, f66_local16, f66_local14, 1 )
	Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f66_local15, f66_local14 )
	Lobby.MatchmakingAsync.CacheAsyncInfo( f66_local14, f66_local8, f66_local0 )
	Lobby.MatchmakingAsync.AsyncMatchmakingRunning( false )
	for f66_local20, f66_local21 in ipairs( f66_local9.expectedPlayers ) do
		Lobby.MatchmakingAsync.AddReservation( f66_local21.xuidstrnum )
	end
	f66_local17 = Engine[@"hash_2786FFC9E621CAB7"]()
	Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[@"hash_4C352A5202CDD23F"] = f66_local17
	Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[@"hash_329A52FFC78A973"] = false
	Lobby.MatchmakingAsync.PartyToMatchSummary[@"hash_329A52FFC78A973"] = false
	search_record = Lobby.MatchmakingAsync.PartyToMatchSummary[@"searches"][tostring( f66_arg0.matchMakingID )]
	if search_record ~= nil then
		search_record[@"hash_4C352A5202CDD23F"] = f66_local17
		search_record[@"hash_EFDBE96A9503CF"] = f66_local0
		search_record[0xF7CBB339F0026] = f66_local14.listen_server.host_player_id
		search_record[@"hash_63088D1189C30C01"] = f66_local17
		search_record[@"search_outcome"] = Lobby.MatchmakingAsync.SearchOutcome.LOBBY_JOIN
	end
	Lobby.MatchmakingAsync.LobbyIntermissionSummary = {}
	Lobby.MatchmakingAsync.LobbyIntermissionSummary[@"hash_522C2D85063EC515"] = Engine[@"hash_2786FFC9E621CAB7"]()
	Lobby.MatchmakingAsync.LobbyIntermissionSummary[@"hash_529F1B2656189232"] = f66_arg0.updateID
	f66_local18 = {
		secIdKey = f66_local12,
		secId = f66_local12.secId,
		secKey = f66_local12.secKey,
		playlistID = f66_local10,
		matchMakingID = matchMakingID,
		lobbyID = f66_local0,
		lobbyHostDocTable = f66_local14,
		lobbyBackendDocTable = f66_local8
	}
	Lobby.MMAsync.lobbyCreateTime = Engine[@"milliseconds"]() + 5000
	Lobby.ProcessQueue.AddToQueue( "CreateAsyncMatchmakingLobby", Lobby.Process.CreateAsyncMatchmakingLobby( f66_local1, f66_local13, f66_local18 ) )
end
Lobby.MatchmakingAsync.EventUpdatedLobbyDocument = function ( f67_arg0 )
	local f67_local0 = f67_arg0.controller
	local f67_local1 = f67_arg0.lobbyID
	local f67_local2 = f67_arg0.updateID
	local f67_local3 = f67_arg0.lobbyBackendDoc
	local f67_local4 = f67_arg0.lobbyBackendDocLength
	local f67_local5 = f67_arg0.lobbyHostDoc
	if f67_local1 ~= Lobby.MMAsync.Info.lobbyID then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "EventUpdatedLobbyDocument ignoring incorrect lobbyID \n" )
		return 
	end
	local f67_local6 = nil
	if Lobby.MMAsync.Info.lobbyHostDocTable == nil then
		f67_local6 = f67_arg0.lobbyHostDoc
	else
		f67_local6 = Lobby.MMAsync.Info.lobbyHostDocTable.lobbyDoc
	end
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "EventUpdatedLobbyDocument\njson lobbyHostDoc: " .. f67_local6 .. "\n" )
	local f67_local7 = Lobby.JSON.ParseLobbyHostDoc( f67_local5 )
	local f67_local8 = Lobby.JSON.ParseLobbyHostDoc( f67_local6 )
	local f67_local9 = {}
	if f67_local7.update_id < f67_local8.update_id then
		for f67_local13, f67_local14 in pairs( f67_local8.current_player_state ) do
			f67_local7.current_player_state[f67_local13] = nil
		end
		for f67_local13, f67_local14 in pairs( f67_local7.current_player_state ) do
			f67_local9[f67_local13] = f67_local13
		end
	end
	local f67_local10 = Lobby.JSON.ParseLobbyBackendDoc( f67_local3 )
	local f67_local11 = {
		expectedPlayers = f67_local10.expectedPlayers
	}
	local f67_local12, f67_local13 = Lobby.JSON.CreateWritableDocFromString( f67_local6 )
	f67_local8 = Lobby.JSON.AddExpectedPlayersToLobbyHostDoc( f67_local12, f67_local13, Lobby.JSON.setUpdateID( f67_local12, f67_local13, f67_local8, f67_local8.update_id + 1 ), f67_local11, f67_local9 )
	Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f67_local12, f67_local8 )
	f67_local8.needs_update = true
	Lobby.MatchmakingAsync.CacheAsyncInfo( f67_local8, f67_local10, f67_local1 )
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "EventUpdatedLobbyDocument\njson lobbyHostDocTable.lobbyHostDoc: " .. f67_local8.lobbyDoc .. "\n" )
end
Lobby.MatchmakingAsync.TestBadJSON = function ( f68_arg0 )
	local f68_local0 = {
		controller = 0,
		eventType = LuaEnum.bdEventType.BD_INTERNAL_ERROR,
		errorCode = f68_arg0.errorCode,
		lobbyID = Lobby.MMAsync.Info.lobbyID
	}
	Lobby.MMAsync.Info.migrateHost = false
	Lobby.MMAsync.Info.getLobbyDocs = false
	Lobby.MatchmakingAsync.Event( f68_local0 )
end
Lobby.MatchmakingAsync.EventExpectGame = function ( f69_arg0 )
	local f69_local0 = f69_arg0.controller
	local f69_local1 = f69_arg0.lobbyID
	local f69_local2 = f69_arg0.lobbyBackendDoc
	local f69_local3 = f69_arg0.lobbyBackendDocLength
	Lobby.MatchmakingAsync.CacheAsyncInfo( nil, nil, f69_local1, nil )
	local f69_local4 = Lobby.ProcessQueue.RegisterEventHandler( Lobby.MatchmakingAsync.EventExpectGameComplete, {
		controller = f69_local0
	} )
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventExpectGame(): calling LobbyMatchmakingAckExpectGame" .. "\n actionId: " .. tostring( f69_local4 ) .. "\n controller: " .. tostring( f69_local0 ) .. "\n lobbyID: " .. Engine[@"uint64tostring"]( Lobby.MMAsync.Info.lobbyID ) .. "\n" )
	if Engine[@"hash_49CD49238204EB79"]( f69_local4, f69_local0, Engine[@"numbertouint64"]( 20000 ), Lobby.MMAsync.Info.lobbyID ) == false then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventExpectGame(): LobbyMatchmakingAckExpectGame failed.\n" )
		Lobby.ProcessQueue.UnRegisterEventHandler( f69_local4 )
	end
end
Lobby.MatchmakingAsync.EventExpectGameComplete = function ( f70_arg0, f70_arg1, f70_arg2 )
	local f70_local0 = f70_arg1.controller
	if f70_arg0 == Lobby.ProcessQueue.ACTIONSTATE.RUNNING or f70_arg0 == Lobby.ProcessQueue.ACTIONSTATE.FAILURE or f70_arg0 == Lobby.ProcessQueue.ACTIONSTATE.ERROR then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventExpectGameComplete failure.\n" )
	elseif f70_arg0 == Lobby.ProcessQueue.ACTIONSTATE.SUCCESS then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventExpectGameComplete success.\n" )
	end
end
Lobby.MatchmakingAsync.EventMergeIntoLobby = function ( f71_arg0 )
	local f71_local0 = f71_arg0.controller
	local f71_local1 = f71_arg0.matchMakingID
	local f71_local2 = f71_arg0.sourceLobbyID
	local f71_local3 = f71_arg0.destinationLobbyID
	local f71_local4 = f71_arg0.lobbyHostDoc
	local f71_local5 = f71_arg0.lobbyHostDocLength
	local f71_local6 = f71_arg0.lobbyBackendDoc
	local f71_local7 = f71_arg0.lobbyBackendDocLength
	if Lobby.MatchmakingAsync.LobbyIntermissionSummary ~= nil then
		local f71_local8 = Lobby.JSON.ParseLobbyHostDoc( f71_local4 )
		Lobby.MatchmakingAsync.LobbyIntermissionSummarySendDLogEvent( {
			reasonIntermissionEnded = Lobby.MatchmakingAsync.ReasonIntermissionEnded.LOBBY_MERGE,
			newLobbyID = f71_local3,
			lobbyHostDocTable = lobbyHostDocTable
		} )
	end
	if not Engine[@"isdedicatedserver"]() and Engine[@"islobbyhost"]( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"] ) ) == false then
		Lobby.MatchmakingAsync.CacheAsyncInfo( nil, nil, f71_local3, nil )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventJoinLobby() I'm a remote client ignore MERGE, but update lobbyID\n" )
		return 
	elseif f71_local2 ~= Lobby.MMAsync.Info.lobbyID then
		return 
	end
	Lobby.MatchmakingAsync.AsyncMatchmakingRunning( false )
	local f71_local8 = Lobby.JSON.ParseLobbyHostDoc( f71_local4 )
	local f71_local9 = Lobby.JSON.ParseLobbyBackendDoc( f71_local6 )
	if not Engine[@"isdedicatedserver"]() then
		Lobby.MatchmakingAsync.CacheAsyncInfo( f71_local8, f71_local9, f71_local3, f71_local9.update_id )
	end
	local f71_local10 = {
		controller = f71_local0,
		lobbyHostXuid = f71_local8.listen_server.host_player_id,
		hostAddress = f71_local8.listen_server.hostAddress,
		secIdKey = f71_local9.secIdKey,
		hostName = f71_local8.attachment.host_name
	}
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventMergeIntoLobby(): calling MergAsyncMatchmakingLobby" .. "\n controller: " .. tostring( f71_local0 ) .. "\n" )
	Lobby.ProcessQueue.AddToQueue( "MergAsyncMatchmakingLobby", Lobby.Process.MergeAsyncMatchmakingLobby( f71_local0, LobbyData.GetLobbyMenuByID( Engine[@"hash_29876169A285ECE7"]( f71_local8.attachment.host_menuID ) ), f71_local10 ) )
end
Lobby.MatchmakingAsync.EventSyncHostDocument = function ( f72_arg0 )
	if Lobby.MMAsync.Info.lobbyID == nil or Lobby.MMAsync.Info.lobbyBackendDocTable == nil or Lobby.MMAsync.Info.lobbyHostDocTable == nil then
		return 
	end
	local f72_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
	local f72_local1, f72_local2 = Lobby.JSON.CreateWritableDocFromString( f72_local0.lobbyDoc )
	Lobby.MatchmakingAsync.CacheAsyncInfo( Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f72_local1, Lobby.JSON.setUpdateTime( f72_local1, f72_local2, f72_local0, Engine[@"milliseconds"]() ) ) )
	if Lobby.MatchmakingAsync.SyncHostDocs( Lobby.MatchmakingAsync.SyncHostDocumentsComplete, f72_arg0.controller, Engine[@"numbertouint64"]( 20000 ), Lobby.MMAsync.Info.lobbyID, Lobby.MMAsync.Info.lobbyBackendDocTable.update_id, Lobby.MMAsync.Info.lobbyHostDocTable.lobbyDoc ) == false then
		Engine[@"printerror"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.EventUpdatedLobbyDocument(): LobbyMatchmakingSyncLobbyDocuments failed.\n" )
	end
end
Lobby.MatchmakingAsync.EventInternalError = function ( f73_arg0 )
	if Lobby.MMAsync.Info.lobbyID == nil or Lobby.MMAsync.Info.lobbyBackendDocTable == nil or Lobby.MMAsync.Info.lobbyHostDocTable == nil then
		return 
	else
		local f73_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
	end
end
Lobby.MatchmakingAsync.OnDedicatedOnlineFrame = function ( f74_arg0 )
	if Dvar[@"hash_44BADE8473F0165F"]:get() == false or f74_arg0.validateFFOTD == false or Dvar[@"hash_3E2390D9E82B6369"]:get() == true then
		return 
	elseif true == Engine[@"isingame"]() then
		return 
	end
	local f74_local0 = Enum[@"controllerindex_t"][@"controller_index_first"]
	if Engine[@"issignedintodemonware"]( f74_local0 ) == false then
		return 
	elseif Lobby.MMAsync.Dedi.status == Lobby.MatchmakingAsync.DedicatedServerState.REGISTER_SERVER then
		if Lobby.MMAsync.Dedi.ServerShutdownStage == Lobby.MatchmakingAsync.ShutdownRequestStage.SHUTTINGDOWN then
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.SHUTDOWN
			Lobby.MMAsync.Dedi.reason = "requested"
		else
			Engine[@"sessionmodesetonlinegame"]( true )
			local f74_local1 = {}
			local f74_local2 = Dvar[@"hash_575A9B5FFE98CD02"]:get()
			if f74_local2:find( "wz" ) ~= nil then
				f74_local1 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC )
			elseif f74_local2:find( "mp" ) ~= nil then
				f74_local1 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC )
			else
				if f74_local2 == nil or f74_local2 ~= "" then
					f74_local2 = "No context provided in dvar"
				end
				error( "context incorectly built need mp or wz in the string: " .. f74_local2 )
			end
			Lobby.ProcessQueue.AddToQueue( "RegisterDedicatedWithAsyncMatchmaking", Lobby.Process.RegisterDedicatedWithAsyncMatchmaking( f74_local0, f74_local1 ) )
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.REGISTERED
			Lobby.MMAsync.Dedi.waitForclientToJoin = true
		end
	elseif Lobby.MMAsync.Dedi.status == Lobby.MatchmakingAsync.DedicatedServerState.REGISTERED then
		
	elseif Lobby.MMAsync.Dedi.status == Lobby.MatchmakingAsync.DedicatedServerState.WAIT_TO_LOBBY_DISBAND then
		local f74_local1 = Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"] )
		if true == Lobby.MMAsync.Dedi.waitForclientToJoin and f74_local1 > 0 then
			Lobby.MMAsync.Dedi.waitForclientToJoin = false
		elseif false == Lobby.MMAsync.Dedi.waitForclientToJoin and f74_local1 == 0 then
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.DISBAND_LOBBY
		end
	elseif Lobby.MMAsync.Dedi.status == Lobby.MatchmakingAsync.DedicatedServerState.DISBAND_LOBBY then
		Lobby.ProcessQueue.AddToQueue( "ShutdownAsyncMatchmakingLobby", Lobby.Process.ShutdownAsyncMatchmakingLobby( f74_local0 ) )
		Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.DISBANDING_LOBBY
	elseif Lobby.MMAsync.Dedi.status == Lobby.MatchmakingAsync.DedicatedServerState.DISBANDING_LOBBY then
		
	elseif Lobby.MMAsync.Dedi.status == Lobby.MatchmakingAsync.DedicatedServerState.SHUTDOWN then
		Engine[@"hash_2BBB5B39E4BA37EB"]( Lobby.MMAsync.Dedi.reason, false )
	end
end
Lobby.MatchmakingAsync.AssignTeams = function ( f75_arg0, f75_arg1, f75_arg2, f75_arg3 )
	if Lobby.MMAsync.Info.lobbyBackendDocTable == nil then
		return false
	elseif Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		return true
	elseif f75_arg2 then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.MatchmakingAsync.AssignTeams start\n" )
	end
	if f75_arg3 == true and f75_arg1 == false then
		if f75_arg2 then
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.MatchmakingAsync.AssignTeams balance check but we don't care if it's balanced \n" )
		end
		return true
	end
	local f75_local0 = Lobby.MMAsync.Info.lobbyBackendDocTable
	local f75_local1 = 0
	local f75_local2 = 0
	if #f75_local0.teams > 0 then
		local f75_local3 = Enum[@"team_t"][@"team_free"]
		for f75_local12, f75_local13 in ipairs( f75_local0.teams ) do
			if f75_local12 == 1 then
				f75_local3 = Enum[@"team_t"][@"team_allies"]
				f75_local1 = #f75_local13
			else
				f75_local3 = Enum[@"team_t"][@"team_axis"]
				f75_local2 = #f75_local13
			end
			for f75_local10, f75_local11 in ipairs( f75_local13 ) do
				if f75_arg2 then
					Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Client XUID: " .. tostring( f75_local11 ) .. " 
				end
				if f75_arg3 ~= true then
					Engine[@"lobbyhostassignteamtoclient"]( f75_arg0, f75_local11, f75_local3 )
				end
			end
		end
	end
	if Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_host"], f75_arg0, Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_bot"] ) > 0 then
		local f75_local3 = Engine[@"lobbygetsessionclients"]( Enum[@"lobbymodule"][@"lobby_module_host"], f75_arg0 )
		local f75_local4 = 0
		local f75_local5 = 0
		local f75_local6 = 0
		local f75_local12 = 0
		for f75_local9, f75_local10 in ipairs( f75_local3.sessionClients ) do
			local f75_local11 = f75_local10.lobbyClientType
			local f75_local14
			if f75_local11 ~= Enum[@"lobbyclienttype"][@"lobby_client_type_bot_permanent"] and f75_local11 ~= Enum[@"lobbyclienttype"][@"lobby_client_type_bot_temp"] then
				f75_local14 = false
			else
				f75_local14 = true
			end
			if f75_local14 == false then
				if f75_local10.team == Enum[@"team_t"][@"team_allies"] then
					f75_local4 = f75_local4 + 1
				end
				if f75_local10.team == Enum[@"team_t"][@"team_axis"] then
					f75_local5 = f75_local5 + 1
				end
				if f75_local10.team == Enum[@"team_t"][@"team_free"] then
					f75_local6 = f75_local6 + 1
				else
					f75_local12 = f75_local12 + 1
				end
			end
		end
		f75_local13 = Enum[@"team_t"][@"team_allies"]
		for f75_local10, f75_local11 in ipairs( f75_local3.sessionClients ) do
			local f75_local14 = f75_local11.team
			local f75_local16 = f75_local11.lobbyClientType
			local f75_local15
			if f75_local16 ~= Enum[@"lobbyclienttype"][@"lobby_client_type_bot_permanent"] and f75_local16 ~= Enum[@"lobbyclienttype"][@"lobby_client_type_bot_temp"] then
				f75_local15 = false
			else
				f75_local15 = true
			end
			if f75_local15 == true then
				if f75_local4 < f75_local5 then
					f75_local4 = f75_local4 + 1
					f75_local13 = Enum[@"team_t"][@"team_allies"]
				else
					f75_local5 = f75_local5 + 1
					f75_local13 = Enum[@"team_t"][@"team_axis"]
				end
				if f75_arg3 ~= true then
					Engine[@"lobbyhostassignteamtoclient"]( f75_arg0, f75_local11.xuid, f75_local13 )
				end
				if f75_arg2 then
					Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "BOT assigned to: 
				end
			end
		end
		f75_local1 = f75_local4
		f75_local2 = f75_local5
	end
	local f75_local3 = math.abs( f75_local1 - f75_local2 )
	if f75_arg2 then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "-----------------------------------------\n" )
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.MatchmakingAsync.AssignTeams end\n" )
	end
	if f75_arg1 == true and f75_local3 > 1 then
		if f75_arg2 then
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Could not create balanced teams.\n" )
		end
		return false
	end
	return true
end
Lobby.MatchmakingAsync.PumpLobbyMerging = function ()
	if Dvar[@"lobbymergeenabled"]:get() == false then
		return 
	elseif Lobby.MMAsync.Info.lobbyHostDocTable ~= nil then
		local f76_local0 = Lobby.Timer.GetTimerStatus()
		local f76_local1 = true
		if f76_local0 == Lobby.Timer.LOBBY_STATUS.STARTING or f76_local0 == Lobby.Timer.LOBBY_STATUS.IDLE or f76_local0 == Lobby.Timer.LOBBY_STATUS.NOT_RUNNING or f76_local0 == Lobby.Timer.LOBBY_STATUS.POST_GAME or f76_local0 == Lobby.Timer.LOBBY_STATUS.FIND_NEW_LOBBY or f76_local0 == Lobby.Timer.MATCH_START_INVALID then
			f76_local1 = false
		end
		if Dvar[@"party_minplayers"]:get() <= Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"] ) then
			f76_local1 = false
		end
		local f76_local2 = {
			src = f76_local1,
			dst = true
		}
		local f76_local3 = Lobby.MMAsync.Info.lobbyHostDocTable
		if f76_local3.is_merge_src ~= f76_local2.src or f76_local3.is_merge_dst ~= f76_local2.dst then
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpLobbyMerging() lobbyHostDocTable is_merge_src = " .. tostring( f76_local3.is_merge_src ) .. " is_merge_dst = " .. tostring( f76_local3.is_merge_dst ) .. "\n" )
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.PumpLobbyMerging() changing to merge Src = " .. tostring( f76_local2.src ) .. " Dest = " .. tostring( f76_local2.dst ) .. "\n" )
			local f76_local4, f76_local5 = Lobby.JSON.CreateWritableDocFromString( f76_local3.lobbyDoc )
			f76_local3 = Lobby.JSON.UpdateMergeRules( f76_local4, f76_local5, f76_local3, f76_local2 )
			f76_local3 = Lobby.JSON.setUpdateID( f76_local4, f76_local5, f76_local3, f76_local3.update_id + 1 )
			Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f76_local4, f76_local3 )
			if f76_local3 ~= nil then
				Lobby.MatchmakingAsync.CacheAsyncInfo( f76_local3 )
			end
		end
	end
end
Lobby.MatchmakingAsync.OnMatchStart = function ( f77_arg0 )
	Lobby.MatchmakingAsync.WaitingForMatchID = true
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) and Lobby.MMAsync.Info.lobbyHostDocTable ~= nil then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.OnMatchStart() setting 'setCanSplitTeam' \n" )
		local f77_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
		local f77_local1, f77_local2 = Lobby.JSON.CreateWritableDocFromString( f77_local0.lobbyDoc )
		f77_local0 = Lobby.JSON.setCanSplitTeam( f77_local1, f77_local2, f77_local0, false )
		f77_local0 = Lobby.JSON.setUpdateID( f77_local1, f77_local2, f77_local0, f77_local0.update_id + 1 )
		Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f77_local1, f77_local0 )
		Lobby.MatchmakingAsync.CacheAsyncInfo( f77_local0 )
	end
end
Lobby.MatchmakingAsync.OnMatchEnd = function ( f78_arg0 )
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) then
		if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.OnMatchEnd() In warzone leaving the matchmaking off \n" )
			return 
		elseif Lobby.MatchmakingAsync.LobbyIntermissionSummary ~= nil then
			Lobby.MatchmakingAsync.LobbyIntermissionSummary[@"hash_274F4160F246B900"] = Engine[@"hash_2786FFC9E621CAB7"]()
		end
		if Lobby.MMAsync.Info.lobbyHostDocTable ~= nil then
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.OnMatchEnd() updating cansplitTeam, lobby_open, merge rules \n" )
			local f78_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
			local f78_local1 = true
			local f78_local2, f78_local3 = Lobby.JSON.CreateWritableDocFromString( f78_local0.lobbyDoc )
			if Engine[@"isdedicatedserver"]() == true and Lobby.MMAsync.Dedi.ServerShutdownStage == Lobby.MatchmakingAsync.ShutdownRequestStage.REQUESTED then
				f78_local0 = Lobby.JSON.markDedicatedToShutdown( f78_local2, f78_local3, f78_local0 )
				Lobby.MMAsync.Dedi.ServerShutdownStage = Lobby.MatchmakingAsync.ShutdownRequestStage.SHUTTINGDOWN
				f78_local1 = false
			end
			f78_local0 = Lobby.JSON.setAllowPresenseJoin( f78_local2, f78_local3, Lobby.JSON.setLobbyOpen( f78_local2, f78_local3, Lobby.JSON.setCanSplitTeam( f78_local2, f78_local3, f78_local0, f78_local1 ), f78_local1 ), f78_local1 )
			f78_local0 = Lobby.JSON.setUpdateID( f78_local2, f78_local3, f78_local0, f78_local0.update_id + 1 )
			f78_local0 = Lobby.JSON.UpdateMergeRules( f78_local2, f78_local3, Lobby.JSON.setGameID( f78_local2, f78_local3, f78_local0, f78_local0.game_id + 1 ), {
				src = false,
				dst = true
			} )
			Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f78_local2, f78_local0 )
			Lobby.MatchmakingAsync.CacheAsyncInfo( f78_local0 )
		end
	end
end
Lobby.MatchmakingAsync.TogglePresenceJoin = function ( f79_arg0 )
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) and Lobby.MMAsync.Info.lobbyHostDocTable ~= nil then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.TogglePresenceJoin() setting 'allowJoin' \n" )
		local f79_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
		local f79_local1, f79_local2 = Lobby.JSON.CreateWritableDocFromString( f79_local0.lobbyDoc )
		f79_local0 = Lobby.JSON.setAllowPresenseJoin( f79_local1, f79_local2, f79_local0, f79_arg0 )
		f79_local0 = Lobby.JSON.setUpdateID( f79_local1, f79_local2, f79_local0, f79_local0.update_id + 1 )
		Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f79_local1, f79_local0 )
		Lobby.MatchmakingAsync.CacheAsyncInfo( f79_local0 )
	end
	Lobby.Join.ZMAllowJoin = f79_arg0
end
Lobby.MatchmakingAsync.ToggleAdvertingTWITCHCON = function ( f80_arg0 )
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) and Lobby.MMAsync.Info.lobbyHostDocTable ~= nil then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.ToggleAdverting() setting 'lobby_open' \n" )
		local f80_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
		local f80_local1, f80_local2 = Lobby.JSON.CreateWritableDocFromString( f80_local0.lobbyDoc )
		f80_local0 = Lobby.JSON.setAllowPresenseJoin( f80_local1, f80_local2, Lobby.JSON.setLobbyOpen( f80_local1, f80_local2, f80_local0, true ), false )
		f80_local0 = Lobby.JSON.setUpdateID( f80_local1, f80_local2, f80_local0, f80_local0.update_id + 1 )
		Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f80_local1, f80_local0 )
		Lobby.MatchmakingAsync.CacheAsyncInfo( f80_local0 )
	end
end
Lobby.MatchmakingAsync.ToggleAdverting = function ( f81_arg0 )
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) and Lobby.MMAsync.Info.lobbyHostDocTable ~= nil then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.ToggleAdverting() setting 'lobby_open' \n" )
		local f81_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
		local f81_local1, f81_local2 = Lobby.JSON.CreateWritableDocFromString( f81_local0.lobbyDoc )
		f81_local0 = Lobby.JSON.setLobbyOpen( f81_local1, f81_local2, f81_local0, f81_arg0.areWeAdvertising )
		f81_local0 = Lobby.JSON.setUpdateID( f81_local1, f81_local2, f81_local0, f81_local0.update_id + 1 )
		Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f81_local1, f81_local0 )
		Lobby.MatchmakingAsync.CacheAsyncInfo( f81_local0 )
	end
end
Lobby.MatchmakingAsync.SetTeamsSplitLock = function ( f82_arg0 )
	if Lobby.MMAsync.Info.lobbyHostDocTable ~= nil then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.SetTeamsSplitLock() setting 'setCanSplitTeam' to " .. tostring( f82_arg0 ) .. "\n" )
		local f82_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
		local f82_local1, f82_local2 = Lobby.JSON.CreateWritableDocFromString( f82_local0.lobbyDoc )
		f82_local0 = Lobby.JSON.setCanSplitTeam( f82_local1, f82_local2, f82_local0, f82_arg0 )
		f82_local0 = Lobby.JSON.setUpdateID( f82_local1, f82_local2, f82_local0, f82_local0.update_id + 1 )
		Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f82_local1, f82_local0 )
		Lobby.MatchmakingAsync.CacheAsyncInfo( f82_local0 )
	end
end
Lobby.MatchmakingAsync.LockTeams = function ()
	Lobby.MatchmakingAsync.SetTeamsSplitLock( false )
end
Lobby.MatchmakingAsync.UnLockTeams = function ()
	Lobby.MatchmakingAsync.SetTeamsSplitLock( true )
end
Lobby.MatchmakingAsync.ToggleAsyncMatchmaking = function ( f85_arg0 )
	local f85_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
	local f85_local1 = Engine[@"currentsessionmode"]()
	if Dvar[@"hash_41FEB500743B0D15"]:exists() and Dvar[@"hash_41FEB500743B0D15"]:get() and f85_arg0.advertise == false then
		Engine[@"printwarning"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.ToggleAsyncMatchmaking - skipping, as sv_wznostartever is true\n" )
		return 
	elseif f85_local0 ~= nil then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.ToggleAsyncMatchmaking setting 'lobby_open' to " .. tostring( f85_arg0.advertise ) .. " \n" )
		local f85_local2, f85_local3 = Lobby.JSON.CreateWritableDocFromString( f85_local0.lobbyDoc )
		f85_local0 = Lobby.JSON.setLobbyOpen( f85_local2, f85_local3, f85_local0, f85_arg0.advertise )
		f85_local0 = Lobby.JSON.setUpdateID( f85_local2, f85_local3, f85_local0, f85_local0.update_id + 1 )
		if f85_local1 == Enum[@"emodes"][@"mode_zombies"] or f85_local1 == Enum[@"emodes"][@"mode_warzone"] or LuaUtils.IsArenaMode() then
			f85_local0 = Lobby.JSON.setAllowPresenseJoin( f85_local2, f85_local3, f85_local0, f85_arg0.advertise )
		end
		if f85_arg0.advertise == false then
			f85_local0 = Lobby.JSON.UpdateMergeRules( f85_local2, f85_local3, f85_local0, {
				src = false,
				dst = false
			} )
		else
			f85_local0 = Lobby.JSON.UpdateMergeRules( f85_local2, f85_local3, f85_local0, {
				src = false,
				dst = true
			} )
		end
		Lobby.MatchmakingAsync.CacheAsyncInfo( Lobby.JSON.CreateConvertJsonToStringAndCloseHandle( f85_local2, f85_local0 ) )
	end
	if f85_local1 == Enum[@"emodes"][@"mode_zombies"] or f85_local1 == Enum[@"emodes"][@"mode_warzone"] then
		Lobby.Join.ZMAllowJoin = f85_arg0.advertise
	end
end
Lobby.MatchmakingAsync.OnGetAdvertStatus = function ()
	return Lobby.MMAsync.AdvertStatus
end
Lobby.MatchmakingAsync.DlogPump = function ( f87_arg0 )
	if Lobby.MatchmakingAsync.WaitingForMatchID == true and true == Engine[@"isingame"]() then
		Lobby.MatchmakingAsync.WaitingForMatchID = false
		local f87_local0 = Engine[@"getlobbymode"]( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"] ) )
		if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_private"] ) and (f87_local0 == Enum[@"lobbymode"][@"lobby_mode_public"] or f87_local0 == Enum[@"lobbymode"][@"lobby_mode_arena"]) then
			Lobby.MatchmakingAsync.PartyMatchStartSendDLogEvent()
		end
		if Lobby.MatchmakingAsync.LobbyIntermissionSummary ~= nil then
			local f87_local1 = Lobby.MatchmakingAsync.LobbyIntermissionSummary[@"hash_238A1943270A668E"]
			if f87_local1 == nil or f87_local1 ~= Engine[@"getmatchid"]() then
				Lobby.MatchmakingAsync.LobbyIntermissionSummarySendDLogEvent( {
					reasonIntermissionEnded = Lobby.MatchmakingAsync.ReasonIntermissionEnded.GAME_START
				} )
			end
		end
		if Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[@"hash_2B4A32E71C22452"] ~= nil then
			Lobby.MatchmakingAsync.MatchmakingSearchSummaryLogSendDLogEvent( nil )
			Lobby.MatchmakingAsync.PartyToMatchSummarySendDLogEvent()
		end
	end
end
Lobby.MatchmakingAsync.TelemetryOnClientAdded = function ( f88_arg0 )
	if f88_arg0.lobbyType == Enum[@"lobbytype"][@"lobby_type_private"] then
		local f88_local0 = Lobby.MatchmakingAsync.PartyMembersTelemetry
		local f88_local1 = tostring( f88_arg0.xuid )
		local f88_local2 = Engine[@"hash_2786FFC9E621CAB7"]()
		local f88_local3 = {}
		local f88_local4 = f88_local0[@"party_members"][f88_local1]
		f88_local3[@"xuid"] = f88_arg0.xuid
		f88_local3[@"hash_1D1BF732B0333B59"] = f88_local2
		f88_local3[@"session_id"] = 0
		f88_local3[@"num_slots"] = 0
		local f88_local5 = 10
		if Dvar[@"hash_71484C1FA08DAB67"]:exists() then
			f88_local5 = Dvar[@"hash_71484C1FA08DAB67"]:get()
		end
		if f88_local0[@"hash_22BEBB24C7131B96"] < f88_local5 then
			if f88_local4 ~= nil then
				f88_local0[@"party_members"][f88_local1 .. "_left_" .. tostring( f88_local2 )] = f88_local0[@"party_members"][f88_local1]
				f88_local0[@"party_members"][f88_local1] = nil
			end
			f88_local0[@"hash_22BEBB24C7131B96"] = f88_local0[@"hash_22BEBB24C7131B96"] + 1
		else
			local f88_local6 = nil
			for f88_local10, f88_local11 in pairs( f88_local0[@"party_members"] ) do
				local f88_local12 = f88_local11[0xF1765710DF7771]
				if f88_local12 ~= nil and (f88_local6 == nil or f88_local12 < f88_local6[0xF1765710DF7771]) then
					f88_local6 = f88_local11
				end
			end
			if f88_local6 ~= nil then
				f88_local0[@"party_members"][tostring( f88_local6.xuid )] = nil
			end
			f88_local1 = nil
			Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Attempted to add a player to the party member telemetry list when the list was full\n" )
		end
		if f88_local1 ~= nil then
			f88_local0[@"party_members"][f88_local1] = f88_local3
		end
	end
	local f88_local0 = Lobby.MatchmakingAsync.LobbyMembersTelemetry[@"lobby_members"]
	local f88_local1 = Lobby.MatchmakingAsync.LobbyMembersTelemetry[@"hash_72623BA80A26AD5A"]
	local f88_local2 = Engine[@"hash_2786FFC9E621CAB7"]()
	local f88_local3 = {
		[@"user_id"] = f88_arg0.xuid,
		[@"hash_26FCF92F9EE7FC5"] = f88_local2
	}
	local f88_local4 = tostring( f88_arg0.xuid )
	local f88_local5 = f88_local0[f88_local4]
	local f88_local6 = 50
	if Dvar[@"hash_3C9231D9C5B7583"]:exists() then
		f88_local6 = Dvar[@"hash_3C9231D9C5B7583"]:get()
	end
	if f88_local1 < f88_local6 then
		if f88_local5 ~= nil then
			f88_local0[f88_local4 .. "_left_" .. tostring( f88_local2 )] = f88_local0[f88_local4]
			f88_local0[f88_local4] = nil
		end
		Lobby.MatchmakingAsync.LobbyMembersTelemetry[@"hash_72623BA80A26AD5A"] = f88_local1 + 1
	else
		local f88_local7 = nil
		for f88_local11, f88_local12 in pairs( f88_local0 ) do
			local f88_local13 = f88_local12[@"hash_4FD83CAFEC6D041D"]
			if f88_local13 ~= nil and (f88_local7 == nil or f88_local13 < f88_local7[@"hash_4FD83CAFEC6D041D"]) then
				f88_local7 = f88_local12
			end
		end
		if f88_local7 ~= nil then
			f88_local0[tostring( f88_local7[@"xuid"] )] = nil
		end
		f88_local4 = nil
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Attempted to add a player to the lobby member telemetry list when the list was full\n" )
	end
	if f88_local4 ~= nil then
		f88_local0[f88_local4] = f88_local3
	end
end
Lobby.MatchmakingAsync.TelemetryOnClientRemoved = function ( f89_arg0 )
	local f89_local0 = tostring( f89_arg0.xuid )
	local f89_local1 = Engine[@"hash_2786FFC9E621CAB7"]()
	local f89_local2 = Lobby.MatchmakingAsync.PartyMembersTelemetry[@"party_members"][f89_local0]
	if f89_local2 ~= nil then
		f89_local2[0xF1765710DF7771] = f89_local1
	end
	local f89_local3 = Lobby.MatchmakingAsync.LobbyMembersTelemetry[@"lobby_members"][f89_local0]
	if f89_local3 ~= nil then
		f89_local3[@"hash_4FD83CAFEC6D041D"] = f89_local1
	end
end
Lobby.MatchmakingAsync.PartyMatchStartSendDLogEvent = function ()
	local f90_local0 = Lobby.MatchmakingAsync.PartyMembersTelemetry
	local f90_local1 = {
		[@"hash_244CFE1AF6487D5A"] = {}
	}
	f90_local1[@"hash_244CFE1AF6487D5A"][@"hash_22BEBB24C7131B96"] = 0
	f90_local1[@"hash_244CFE1AF6487D5A"][@"hash_46838162D06A1E0D"] = Lobby.MMAsync.Info.matchmakingID
	if f90_local1[@"hash_244CFE1AF6487D5A"][@"hash_46838162D06A1E0D"] == nil or f90_local1[@"hash_244CFE1AF6487D5A"][@"hash_46838162D06A1E0D"] == 0 then
		return 
	end
	f90_local1[@"party_members"] = {}
	for f90_local5, f90_local6 in pairs( Lobby.MatchmakingAsync.PartyMembersTelemetry[@"party_members"] ) do
		if f90_local6[0xF1765710DF7771] == nil then
			f90_local1[@"party_members"][tostring( f90_local6[@"xuid"] )] = {
				[@"xuid"] = f90_local6[@"xuid"]
			}
			f90_local1[@"hash_244CFE1AF6487D5A"][@"hash_22BEBB24C7131B96"] = f90_local1[@"hash_244CFE1AF6487D5A"][@"hash_22BEBB24C7131B96"] + 1
		end
	end
	Engine[0xDE279ECDDDD966]( Engine[@"getprimarycontroller"](), @"hash_2FB187B49A287F3E", f90_local1 )
end
Lobby.MatchmakingAsync.MatchmakingSearchSummaryLogSendDLogEvent = function ( f91_arg0 )
	local f91_local0 = Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog
	local f91_local1 = Lobby.MatchmakingAsync.PartyMembersTelemetry
	local f91_local2 = Lobby.MMAsync.Info
	local f91_local3 = {}
	if f91_local0[@"hash_248ADCCF3C622ADC"] ~= nil then
		local f91_local4 = f91_local0[@"hash_248ADCCF3C622ADC"]
		local f91_local5 = Lobby.MatchmakingAsync.GetLocalUserInfo( Engine[@"getprimarycontroller"]() )
		if f91_local4 ~= f91_local5.xuid then
			Lobby.MatchmakingAsync.ResetMatchmakingSearchSummaryLog()
			return 
		elseif f91_arg0 ~= nil then
			f91_local0[@"hash_391C576AC028696A"] = Engine[@"hash_2786FFC9E621CAB7"]()
		end
		f91_local0[@"reason_left"] = f91_arg0
		f91_local0[@"playlist_version"] = Engine[@"getplaylistversionnumber"]()
		f91_local0[@"playlist_id"] = Engine[@"getplaylistid"]()
		f91_local0[@"ffotd_version"] = Engine[@"getffotdversion"]()
		f91_local0[@"hash_5ADCB2E00EC9EAB1"] = f91_local2.lobbyID
		f91_local0[@"hash_46838162D06A1E0D"] = f91_local2.matchmakingID
		if f91_local0[@"hash_46838162D06A1E0D"] == 0 then
			f91_local0[@"hash_46838162D06A1E0D"] = Engine[@"defaultid64value"]()
		end
		if f91_local2.lobbyHostDocTable ~= nil then
			if f91_local2.lobbyHostDocTable.dedicated_server ~= nil then
				f91_local0[@"is_dedi"] = true
				f91_local0[@"hash_5E523AEF49CE7554"] = f91_local2.lobbyHostDocTable.dedicated_server.data_center
				f91_local0[0xF7CBB339F0026] = f91_local2.lobbyHostDocTable.dedicated_server.user_id
			else
				f91_local0[@"is_dedi"] = false
				f91_local0[0xF7CBB339F0026] = f91_local2.lobbyHostDocTable.listen_server.host_player_id
			end
		end
		f91_local0[@"hash_22BEBB24C7131B96"] = f91_local1[@"hash_22BEBB24C7131B96"]
		f91_local0[@"hash_7BF9DACCC9B256DD"] = Engine[@"hash_69A70B14679D905C"]()
		f91_local3[@"party_members"] = f91_local1[@"party_members"]
		f91_local3[@"hash_326402D544E6C4A7"] = f91_local0
		f91_local4 = Enum[@"lobbymodule"][@"lobby_module_client"]
		f91_local5 = f91_local0[0xF7CBB339F0026]
		local f91_local6 = Lobby.MatchmakingAsync.GetLocalUserInfo( Engine[@"getprimarycontroller"]() )
		if f91_local5 == f91_local6.xuid then
			f91_local4 = Enum[@"lobbymodule"][@"lobby_module_host"]
		end
		Engine[0xDE279ECDDDD966]( Engine[@"getprimarycontroller"](), @"hash_585D1520F04EB173", f91_local3 )
		Lobby.MatchmakingAsync.ResetMatchmakingSearchSummaryLog()
	end
	Lobby.MatchmakingAsync.ResetMatchmakingSearchSummaryLog()
	return 
end
Lobby.MatchmakingAsync.AddSearch = function ()
	local f92_local0 = Lobby.MatchmakingAsync.PartyToMatchSummary
	local f92_local1 = f92_local0[@"searches"]
	local f92_local2 = {
		[@"hash_46838162D06A1E0D"] = Lobby.MMAsync.Info.matchmakingID,
		[@"hash_5C868775A96E3DE0"] = f92_local0.last_sent_timestamp
	}
	local f92_local3 = tostring( f92_local2[@"hash_46838162D06A1E0D"] )
	local f92_local4 = Lobby.MatchmakingAsync.PartyMembersTelemetry
	f92_local0.last_sent_timestamp = nil
	f92_local2[@"playlist_version"] = Engine[@"getplaylistversionnumber"]()
	f92_local2[@"playlist_id"] = Engine[@"getplaylistid"]()
	f92_local2[@"ffotd_version"] = Engine[@"getffotdversion"]()
	local f92_local5 = 10
	if Dvar[@"hash_3A6B6B9A3617AB97"]:exists() then
		f92_local5 = Dvar[@"hash_3A6B6B9A3617AB97"]:get()
	end
	if f92_local0[@"search_count"] < f92_local5 then
		f92_local1[f92_local3] = f92_local2
		f92_local0.last_joined_lobby_key = f92_local2[@"hash_46838162D06A1E0D"]
		f92_local0[@"search_count"] = f92_local0[@"search_count"] + 1
	else
		local f92_local6 = nil
		for f92_local10, f92_local11 in pairs( f92_local1 ) do
			if f92_local11[@"hash_63088D1189C30C01"] ~= nil and (f92_local6 == nil or tonumber( f92_local11[@"hash_5C868775A96E3DE0"] ) < tonumber( f92_local6[@"hash_5C868775A96E3DE0"] )) then
				f92_local6 = recordedRecord
			end
		end
		if f92_local6 ~= nil then
			f92_local0[@"searches"][tostring( f92_local6[@"hash_46838162D06A1E0D"] )] = nil
			f92_local0[@"searches"][f92_local3] = f92_local2
			f92_local0.last_joined_lobby_key = f92_local2[@"hash_46838162D06A1E0D"]
		end
	end
end
Lobby.MatchmakingAsync.LobbyClientEnd = function ( f93_arg0 )
	local f93_local0 = Lobby.MatchmakingAsync.PartyToMatchSummary
	local f93_local1 = f93_local0[@"searches"]
	if f93_local0[@"hash_248ADCCF3C622ADC"] ~= nil and f93_local0.last_joined_lobby_key ~= nil then
		local f93_local2 = f93_local0[@"hash_248ADCCF3C622ADC"]
		local f93_local3 = Lobby.MatchmakingAsync.GetLocalUserInfo( Engine[@"getprimarycontroller"]() )
		if f93_local2 ~= f93_local3.xuid then
			return 
		end
		f93_local2 = f93_local0[@"searches"][tostring( f93_local0.last_joined_lobby_key )]
		if f93_local2 ~= nil then
			f93_local2[@"hash_391C576AC028696A"] = Engine[@"hash_2786FFC9E621CAB7"]()
			f93_local0.last_joined_lobby_key = nil
		end
	end
	return 
end
Lobby.MatchmakingAsync.ResetMatchmakingSearchSummaryLog = function ()
	Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog = {}
end
Lobby.MatchmakingAsync.PartyToMatchSummarySendDLogEvent = function ()
	local f95_local0 = Lobby.MatchmakingAsync.PartyToMatchSummary
	local f95_local1 = Lobby.MatchmakingAsync.PartyMembersTelemetry
	local f95_local2 = Lobby.MMAsync.Info
	local f95_local3 = {}
	if f95_local0[@"hash_248ADCCF3C622ADC"] ~= nil then
		local f95_local4 = f95_local0[@"hash_248ADCCF3C622ADC"]
		local f95_local5 = Lobby.MatchmakingAsync.GetLocalUserInfo( Engine[@"getprimarycontroller"]() )
		if f95_local4 ~= f95_local5.xuid then
			Lobby.MatchmakingAsync.ResetPartyToMatchSummary()
			return 
		end
		f95_local0[@"hash_56A1B6D783AA7A25"] = Engine[@"hash_2786FFC9E621CAB7"]()
		f95_local0[@"hash_22BEBB24C7131B96"] = f95_local1[@"hash_22BEBB24C7131B96"]
		f95_local3[@"party_members"] = f95_local1[@"party_members"]
		f95_local3[@"hash_48C11ED545FA1E34"] = f95_local0
		f95_local3[@"searches"] = f95_local0[@"searches"]
		f95_local5 = Enum[@"lobbymodule"][@"lobby_module_client"]
		if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] ) then
			f95_local5 = Enum[@"lobbymodule"][@"lobby_module_host"]
		end
		Engine[0xDE279ECDDDD966]( Engine[@"getprimarycontroller"](), @"hash_1A910ED9A5157510", f95_local3 )
		Lobby.MatchmakingAsync.ResetPartyToMatchSummary()
	end
	Lobby.MatchmakingAsync.ResetPartyToMatchSummary()
	return 
end
Lobby.MatchmakingAsync.ResetPartyToMatchSummary = function ()
	Lobby.MatchmakingAsync.PartyToMatchSummary = {
		[@"search_count"] = 0,
		[@"searches"] = {}
	}
end
Lobby.MatchmakingAsync.LobbyIntermissionSummarySendDLogEvent = function ( f97_arg0 )
	local f97_local0 = f97_arg0.lobbyHostDocTable
	local f97_local1 = Lobby.MatchmakingAsync.LobbyIntermissionSummary
	if f97_local1 == nil then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Lobby.MatchmakingAsync.LobbyIntermissionSummarySendDLogEvent() called while the summary was null \n" )
		return 
	elseif f97_local0 == nil then
		f97_local0 = Lobby.MMAsync.Info.lobbyHostDocTable
	end
	if f97_local0 ~= nil then
		if Engine[@"isdedicatedserver"]() == false then
			local f97_local2 = f97_local0.listen_server.host_player_id
			local f97_local3 = Lobby.MatchmakingAsync.GetLocalUserInfo( Engine[@"getprimarycontroller"]() )
			if f97_local2 ~= f97_local3.xuid then
				return 
			end
			f97_local1[@"is_dedi"] = false
			f97_local1[0xF7CBB339F0026] = f97_local0.listen_server.host_player_id
		else
			f97_local1[@"is_dedi"] = true
			f97_local1[@"hash_5E523AEF49CE7554"] = f97_local0.dedicated_server.data_center
			f97_local1[@"hash_7A177695FFBDBBBF"] = f97_local0.listen_server.host_address
		end
	end
	local f97_local2 = Engine[@"hash_2786FFC9E621CAB7"]()
	local f97_local3 = Lobby.MatchmakingAsync.LobbyMembersTelemetry
	f97_local1[@"playlist_version"] = Engine[@"getplaylistversionnumber"]()
	f97_local1[@"playlist_id"] = Engine[@"getplaylistid"]()
	f97_local1[@"ffotd_version"] = Engine[@"getffotdversion"]()
	f97_local1[@"lobby_id"] = Lobby.MMAsync.Info.lobbyID
	f97_local1[@"hash_72623BA80A26AD5A"] = f97_local3[@"hash_72623BA80A26AD5A"]
	f97_local1[@"hash_56A1B6D783AA7A25"] = f97_local2
	f97_local1[@"hash_3D6DCEB705C92439"] = f97_arg0.reasonIntermissionEnded
	if f97_arg0.reasonIntermissionEnded == Lobby.MatchmakingAsync.ReasonIntermissionEnded.GAME_START then
		f97_local1[@"hash_296AEED34055C468"] = Engine[@"lobbygetmap"]()
		f97_local1[0x4F262B1F3B8CCF] = Engine[@"getmatchid"]()
	elseif f97_arg0.reasonIntermissionEnded == Lobby.MatchmakingAsync.ReasonIntermissionEnded.LOBBY_MERGE then
		f97_local1[@"hash_4F2F10801676AC78"] = f97_arg0.newLobbyID
	end
	Engine[0xDE279ECDDDD966]( Engine[@"getprimarycontroller"](), @"hash_7A30BE33DFE55997", {
		[@"hash_637A0A0969AAEB3B"] = f97_local1,
		[@"lobby_members"] = f97_local3[@"lobby_members"]
	} )
	if f97_arg0.reasonIntermissionEnded == Lobby.MatchmakingAsync.ReasonIntermissionEnded.LOBBY_MERGE or f97_arg0.reasonIntermissionEnded == Lobby.MatchmakingAsync.ReasonIntermissionEnded.LOBBY_DISBANDED then
		Lobby.MatchmakingAsync.HardResetIntermissionSummary()
	else
		Lobby.MatchmakingAsync.SoftResetIntermissionSummary()
	end
end
Lobby.MatchmakingAsync.StartBlockedWaitingForPlayers = function ()
	local f98_local0 = Lobby.MatchmakingAsync.LobbyIntermissionSummary
	if f98_local0 == nil then
		return 
	elseif f98_local0.blockedStartTime == nil then
		f98_local0.blockedStartTime = Engine[@"seconds"]()
	end
end
Lobby.MatchmakingAsync.StopBlockedWaitingForPlayers = function ()
	local f99_local0 = Lobby.MatchmakingAsync.LobbyIntermissionSummary
	if f99_local0 == nil then
		return 
	elseif f99_local0.blockedStartTime == nil then
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Attempted to stop being blocked for players with a nil start time" )
		return 
	end
	local f99_local1 = Engine[@"seconds"]() - f99_local0.blockedStartTime
	if f99_local0[@"hash_623FD292CBF4DD16"] ~= nil then
		f99_local0[@"hash_623FD292CBF4DD16"] = f99_local0[@"hash_623FD292CBF4DD16"] + f99_local1
	else
		f99_local0[@"hash_623FD292CBF4DD16"] = f99_local1
	end
	f99_local0.blockedStartTime = nil
end
Lobby.MatchmakingAsync.SoftResetIntermissionSummary = function ()
	local f100_local0 = Lobby.MatchmakingAsync.LobbyIntermissionSummary
	Lobby.MatchmakingAsync.LobbyIntermissionSummary = {
		[@"hash_529F1B2656189232"] = f100_local0[@"hash_529F1B2656189232"],
		[@"hash_522C2D85063EC515"] = f100_local0[@"hash_522C2D85063EC515"],
		[@"hash_238A1943270A668E"] = f100_local0[0x4F262B1F3B8CCF],
		[@"hash_3BCA0A9C8F341C79"] = f100_local0[@"hash_296AEED34055C468"]
	}
end
Lobby.MatchmakingAsync.HardResetIntermissionSummary = function ()
	Lobby.MatchmakingAsync.LobbyIntermissionSummary = nil
	Lobby.MatchmakingAsync.LobbyMembersTelemetry = {
		[@"hash_72623BA80A26AD5A"] = 0,
		[@"lobby_members"] = {}
	}
end
Lobby.MatchmakingAsync.IsPlayerExpected = function ()
	
end
