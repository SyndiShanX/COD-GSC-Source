
require( "x64:8fd3bbfccedd522" )
require( "x64:b8ea4f0a93b4f76" )
Lobby.Process = {}
Lobby.Process.DO_NOTHING_IF_FAILURE = nil
Lobby.Process.DO_NOTHING_IF_ERROR = nil
Lobby.Process.AddActions = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4 )
	if f1_arg1 ~= nil and f1_arg1.require ~= nil then
		local f1_local0 = false
		local f1_local1 = f1_arg0
		while f1_local1 ~= nil and f1_local0 == false do
			if f1_local1.name == f1_arg1.require then
				f1_local0 = true
			end
		end
		if f1_local0 ~= true then
			f1_arg3( "LobbyVM: AddAction called for: " .. f1_arg1.name .. " which requires: " .. f1_arg1.require .. " but does not precede this action." )
		else
			if f1_arg4 == nil then
				if f1_arg0.success ~= nil then
					f1_arg3( "Overwriting sucess in Action table: " .. f1_arg0.name .. "\n" )
				end
				if f1_arg0.failure ~= nil then
					f1_arg3( "Overwriting failure in Action table: " .. f1_arg0.name .. "\n" )
				end
				if f1_arg0.error ~= nil then
					f1_arg3( "Overwriting error in Action table: " .. f1_arg0.name .. "\n" )
				end
			end
			f1_arg0.success = f1_arg1
			f1_arg0.failure = f1_arg2
			f1_arg0.error = f1_arg3
			if f1_arg1 ~= nil then
				f1_arg1.parent = f1_arg0
			end
		end
		f1_local1 = f1_local1.parent
	end
	if f1_arg4 == nil then
		if f1_arg0.success ~= nil then
			f1_arg3( "Overwriting sucess in Action table: " .. f1_arg0.name .. "\n" )
		end
		if f1_arg0.failure ~= nil then
			f1_arg3( "Overwriting failure in Action table: " .. f1_arg0.name .. "\n" )
		end
		if f1_arg0.error ~= nil then
			f1_arg3( "Overwriting error in Action table: " .. f1_arg0.name .. "\n" )
		end
	end
	f1_arg0.success = f1_arg1
	f1_arg0.failure = f1_arg2
	f1_arg0.error = f1_arg3
	if f1_arg1 ~= nil then
		f1_arg1.parent = f1_arg0
	end
end
Lobby.Process.OverWriteAction = function ( f2_arg0, f2_arg1 )
	Lobby.Process.AddActions( f2_arg0, f2_arg1, f2_arg1, f2_arg1, true )
end
Lobby.Process.ForceAction = function ( f3_arg0, f3_arg1 )
	Lobby.Process.AddActions( f3_arg0, f3_arg1, f3_arg1, f3_arg1 )
end
Lobby.Process.AppendProcess = function ( f4_arg0, f4_arg1 )
	local f4_local0 = f4_arg0.head
	while f4_local0.success ~= nil do
		f4_local0 = f4_local0.success
	end
	f4_local0.success = f4_arg1.head
end
Lobby.Process.GetForwardFunc = function ( f5_arg0, f5_arg1 )
	return Lobby.Core.GetForwardProcessFunc( f5_arg0, f5_arg1 )
end
Lobby.Process.GetBackFunc = function ( f6_arg0 )
	return Lobby.Core.GetBackProcessFunc( f6_arg0 )
end
Lobby.Process.CreateDedicatedLANLobby = function ( f7_arg0, f7_arg1 )
	local f7_local0 = function ()
		Dvar[@"party_minplayers"]:set( 2 )
		Engine[@"setdvar"]( "live_dedicatedReady", 1 )
	end
	
	local f7_local1 = Lobby.Actions.SetNetworkMode( f7_arg0, Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] )
	local f7_local2 = Lobby.Actions.LobbySettings( f7_arg0, f7_arg1 )
	local f7_local3 = Lobby.Actions.UpdateUI( f7_arg0, f7_arg1 )
	local f7_local4 = Lobby.Actions.LobbyHostStart( f7_arg0, f7_arg1[@"mainmode"], f7_arg1[@"lobbytype"], f7_arg1[@"lobbymode"], f7_arg1[@"maxclients"], "", "" )
	local f7_local5 = Lobby.Actions.LobbyVMCall( Lobby.Timer.HostingLobby, {
		controller = f7_arg0,
		lobbyType = f7_arg1[@"lobbytype"],
		mainMode = f7_arg1[@"mainmode"],
		lobbyTimerType = f7_arg1[@"hash_5558B67A321D1120"]
	} )
	local f7_local6, f7_local7 = nil
	if Dvar[@"hash_2B852BA138B9853A"]:exists() and Dvar[@"hash_2B852BA138B9853A"]:get() then
		f7_local6 = Lobby.Actions.SetGameAndTypeMapName( f7_arg0, Enum[@"lobbytype"][@"lobby_type_private"], "tdm", "mp_seaside" )
		f7_local7 = Lobby.Actions.ExecuteScript( f7_local0 )
	end
	local f7_local8 = {
		head = f7_local1,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f7_local1, f7_local2 )
	Lobby.Process.AddActions( f7_local2, f7_local3 )
	Lobby.Process.AddActions( f7_local3, f7_local4 )
	Lobby.Process.AddActions( f7_local4, f7_local5 )
	if f7_local6 ~= nil and f7_local7 ~= nil then
		Lobby.Process.AddActions( f7_local5, f7_local6 )
		Lobby.Process.AddActions( f7_local6, f7_local7 )
	end
	return f7_local8
end
Lobby.Process.CreateDedicatedLobby = function ( f9_arg0, f9_arg1 )
	local f9_local0 = function ()
		Engine[@"setdvar"]( "live_dedicatedReady", 1 )
	end
	
	local f9_local1 = Dvar[@"hash_64B0B6AD67BC6A57"]:get()
	playlistInfo = Engine[@"hash_4C68B4B9A2458BCB"]( Engine[@"converttoxhash"]( Dvar[@"hash_3C3259DEA294DA54"]:get() ) )
	if playlistInfo ~= nil then
		f9_local1 = playlistInfo.id
	end
	Engine[@"setplaylistid"]( f9_local1 )
	LuaUtils.SetQuickplayPlaylistID( f9_local1 )
	local f9_local2 = Lobby.Actions.SetNetworkMode( f9_arg0, Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] )
	local f9_local3 = Lobby.Actions.LobbySettings( f9_arg0, f9_arg1 )
	local f9_local4 = Lobby.Actions.UpdateUI( f9_arg0, f9_arg1 )
	local f9_local5 = Lobby.Actions.LobbyHostStart( f9_arg0, f9_arg1[@"mainmode"], f9_arg1[@"lobbytype"], f9_arg1[@"lobbymode"], f9_arg1[@"maxclients"], "", "" )
	local f9_local6 = Lobby.Actions.AdvertiseLobby( true )
	local f9_local7 = Lobby.Actions.ExecuteScript( f9_local0 )
	local f9_local8 = {
		head = f9_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f9_local2, f9_local3 )
	Lobby.Process.AddActions( f9_local3, f9_local4 )
	Lobby.Process.AddActions( f9_local4, f9_local5 )
	Lobby.Process.AddActions( f9_local5, f9_local6 )
	Lobby.Process.AddActions( f9_local6, f9_local7 )
	Lobby.Process.AddActions( f9_local7, nil )
	return f9_local8
end
Lobby.Process.RegisterDedicatedWithAsyncMatchmaking = function ( f11_arg0, f11_arg1 )
	local f11_local0 = Engine[@"hash_216FF58A0A7C0C65"]()
	local f11_local1 = function ()
		if Engine[@"isqosprobelistenerenabled"]() == false then
			Engine[@"hash_2A8F0FED295F69CD"]( f11_local0.secId, f11_local0.secKey )
			Engine[@"qosprobelistenerenable"]( true, f11_local0.secIdInt64 )
		end
		Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.REGISTERED
	end
	
	Engine[@"setdvar"]( "live_dedicatedReady", 1 )
	local f11_local2 = Lobby.Actions.SetNetworkMode( f11_arg0, Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] )
	local f11_local3 = Lobby.Actions.LobbySettings( f11_arg0, f11_arg1 )
	local f11_local4 = Lobby.Actions.UpdateUI( f11_arg0, f11_arg1 )
	local f11_local5 = Lobby.Actions.ExecuteScript( f11_local1 )
	local f11_local6 = Lobby.Actions.RegisterDedicatedServerInContext( f11_arg0, Engine[@"numbertouint64"]( 20000 ), f11_local0, Engine[@"numbertouint64"]( 20000 ) )
	local f11_local7 = Lobby.Actions.WaitTillBDNetIsDone()
	local f11_local8 = {
		head = f11_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f11_local2, f11_local3 )
	Lobby.Process.AddActions( f11_local3, f11_local4 )
	Lobby.Process.AddActions( f11_local4, f11_local7 )
	Lobby.Process.AddActions( f11_local7, f11_local5 )
	Lobby.Process.AddActions( f11_local5, f11_local6 )
	return f11_local8
end
Lobby.Process.CreateAsyncMatchmakingLobby = function ( f13_arg0, f13_arg1, f13_arg2 )
	Engine[@"setplaylistid"]( f13_arg2.playlistID )
	LuaUtils.SetQuickplayPlaylistID( f13_arg2.playlistID )
	Engine[@"hash_6BFA89F119C70916"]( f13_arg2.lobbyBackendDocTable.valid_map_pack_bits )
	local f13_local0 = function ()
		Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_1_DESCRIPTION_1 )
		Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.WAIT_TO_LOBBY_DISBAND
	end
	
	local f13_local1 = function ()
		Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_1_DESCRIPTION_1 )
		if Dvar[@"hash_18B4B065CFA75119"]:exists() and Dvar[@"hash_18B4B065CFA75119"]:get() == true then
			Engine[@"lobbyhostsetprivatesession"]( Enum[@"lobbytype"][@"lobby_type_game"], true )
		end
	end
	
	local f13_local2 = {
		controller = f13_arg0,
		errorTarget = LobbyData.GetLobbyMenuByName( f13_arg1[@"errtarget"] ),
		isPublic = true
	}
	local f13_local3 = {}
	local f13_local4 = {}
	if not Engine[@"isdedicatedserver"]() then
		f13_local3 = Lobby.Interrupt.FailedAction( Lobby.ProcessNavigate.SearchProcessInterrupt, f13_local2 )
		f13_local4 = Lobby.Interrupt.ErrorMsg( Lobby.ProcessNavigate.GameLobbyInterrupt, f13_local2, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_649A850B933FDBD2" ) )
	else
		local f13_local5 = function ()
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.DISBAND_LOBBY
		end
		
		f13_local3 = Lobby.Actions.ExecuteScript( f13_local5 )
		f13_local4 = Lobby.Actions.ExecuteScript( f13_local5 )
	end
	local f13_local5 = Lobby.Actions.OpenSpinner()
	local f13_local6 = Lobby.Actions.CloseSpinnerAllowJoining()
	local f13_local7 = Lobby.Actions.LobbyHostStart( f13_arg0, f13_arg1[@"mainmode"], f13_arg1[@"lobbytype"], f13_arg1[@"lobbymode"], f13_arg1[@"maxclients"], "", "", f13_arg2 )
	local f13_local8 = Lobby.Actions.LobbyInfoProbe( f13_arg0, {
		xuid = Engine[@"getxuid64"]( f13_arg0 )
	} )
	local f13_local9 = Lobby.Actions.LobbyJoinXUID( f13_arg0, {
		xuid = Engine[@"getxuid64"]( f13_arg0 )
	}, Enum[@"jointype"][@"join_type_party"] )
	local f13_local10 = Lobby.Actions.LobbySettings( f13_arg0, f13_arg1 )
	local f13_local11 = Lobby.Actions.UpdateUI( f13_arg0, f13_arg1 )
	local f13_local12 = Lobby.Actions.RunPlaylistSettings( f13_arg0 )
	local f13_local13 = Lobby.Actions.SyncLobbyHostDoc( f13_arg0, Engine[@"numbertouint64"]( 20000 ), f13_arg2, true )
	local f13_local14 = Lobby.Actions.LobbyVMCall( Lobby.Timer.HostingLobby, {
		controller = f13_arg0,
		lobbyType = f13_arg1[@"lobbytype"],
		mainMode = f13_arg1[@"mainmode"],
		lobbyTimerType = f13_arg1[@"hash_5558B67A321D1120"]
	} )
	local f13_local15 = Lobby.Actions.ExecuteScript( f13_local1 )
	f13_local15.name = f13_local15.name .. "(lobbyHostStartedEvent)"
	local f13_local16 = Lobby.Actions.ExecuteScript( f13_local0 )
	local f13_local17 = {
		head = f13_local5,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false
	}
	Lobby.Process.ForceAction( f13_local5, f13_local7 )
	Lobby.Process.AddActions( f13_local7, f13_local15, f13_local3, f13_local3 )
	Lobby.Process.AddActions( f13_local15, f13_local10, f13_local4, f13_local4 )
	Lobby.Process.AddActions( f13_local10, f13_local12, f13_local4, f13_local4 )
	Lobby.Process.AddActions( f13_local12, f13_local13, f13_local4, f13_local4 )
	Lobby.Process.AddActions( f13_local13, f13_local6, f13_local4, f13_local4 )
	local f13_local18 = f13_local6
	if not Engine[@"isdedicatedserver"]() then
		Lobby.Process.AddActions( f13_local18, f13_local8, f13_local4, f13_local4 )
		Lobby.Process.AddActions( f13_local8, f13_local9, f13_local4, f13_local4 )
		f13_local18 = f13_local9
	end
	Lobby.Process.AddActions( f13_local18, f13_local11, f13_local4, f13_local4 )
	Lobby.Process.AddActions( f13_local11, f13_local14, f13_local4, f13_local4 )
	Lobby.Process.AddActions( f13_local14, f13_local16, f13_local4, f13_local4 )
	return f13_local17
end
Lobby.Process.JoinAsyncMatchmakingLobby = function ( f17_arg0, f17_arg1, f17_arg2 )
	local f17_local0 = function ()
		Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE )
		Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.WAIT_TO_LOBBY_DISBAND
	end
	
	local f17_local1 = Lobby.Interrupt.FailedAction( Lobby.ProcessNavigate.SearchProcessInterrupt, {
		controller = f17_arg0,
		errorTarget = LobbyData.GetLobbyMenuByName( f17_arg1[@"errtarget"] ),
		isPublic = true
	} )
	local f17_local2 = Lobby.Actions.OpenSpinner()
	local f17_local3 = Lobby.Actions.CloseSpinnerAllowJoining()
	local f17_local4 = Lobby.Actions.AsyncMatchmakingJoin( f17_arg2, f17_arg1 )
	local f17_local5 = Lobby.Actions.ExecuteScript( f17_local0 )
	f17_local5.name = f17_local5.name .. "(updateAction)"
	local f17_local6 = f17_arg2.joinPrivateXUID
	local f17_local7 = Lobby.Actions.ExecuteScriptWithReturn( function ()
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "JoinAsyncMatchmakingLobby. Should join private == " .. tostring( f17_local6 ) .. "\n" )
		return f17_local6 ~= nil
	end, true, false, false )
	f17_local7.name = f17_local7.name .. "(shouldJoinPrivate)"
	local f17_local8 = Lobby.Actions.LobbyInfoProbe( f17_arg0, {
		xuid = f17_local6
	} )
	local f17_local9 = Lobby.Actions.LobbyJoinXUIDExt( f17_arg0, Enum[@"jointype"][@"join_type_party"], f17_local8, Enum[@"lobbytype"][@"lobby_type_private"] )
	local f17_local10 = {
		head = f17_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false
	}
	Lobby.Process.AddActions( f17_local2, f17_local4 )
	Lobby.Process.AddActions( f17_local4, f17_local5, f17_local1, f17_local1 )
	Lobby.Process.ForceAction( f17_local5, f17_local3 )
	Lobby.Process.ForceAction( f17_local3, f17_local7 )
	Lobby.Process.AddActions( f17_local7, f17_local8 )
	Lobby.Process.AddActions( f17_local8, f17_local9 )
	return f17_local10
end
Lobby.Process.RedeployJoinAsyncMatchmakingLobby = function ( f20_arg0, f20_arg1, f20_arg2 )
	local f20_local0 = function ()
		Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE )
		Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.WAIT_TO_LOBBY_DISBAND
	end
	
	local f20_local1 = Lobby.Actions.CloseSpinnerAllowJoining()
	f20_local1.name = f20_local1.name .. "RecoverError"
	local f20_local2 = Lobby.Actions.OpenSpinner()
	local f20_local3 = Lobby.Actions.CloseSpinnerAllowJoining()
	local f20_local4 = Lobby.Actions.AsyncMatchmakingJoin( f20_arg2, f20_arg1 )
	local f20_local5 = Lobby.Actions.ExecuteScript( f20_local0 )
	f20_local5.name = f20_local5.name .. "(updateAction)"
	local f20_local6 = f20_arg2.joinPrivateXUID
	local f20_local7 = function ()
		Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "JoinAsyncMatchmakingLobby. Should join private == " .. tostring( f20_local6 ) .. "\n" )
		return f20_local6 ~= nil
	end
	
	local f20_local8 = Lobby.Actions.ExecuteScript( function ()
		Engine[@"hash_90C67C9C480D8FF"]( true )
	end )
	local f20_local9 = Lobby.Actions.ExecuteScript( function ()
		Engine[@"hash_90C67C9C480D8FF"]( false )
	end )
	local f20_local10 = Lobby.Actions.ExecuteScriptWithReturn( f20_local7, true, false, false )
	f20_local10.name = f20_local10.name .. "(shouldJoinPrivate)"
	local f20_local11 = Lobby.Actions.LobbyInfoProbe( f20_arg0, {
		xuid = f20_local6
	} )
	local f20_local12 = Lobby.Actions.LobbyJoinXUIDExt( f20_arg0, Enum[@"jointype"][@"join_type_party"], f20_local11, Enum[@"lobbytype"][@"lobby_type_private"] )
	local f20_local13 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f20_local14 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f20_local15 = {
		head = f20_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false
	}
	Lobby.Process.AddActions( f20_local2, f20_local8 )
	Lobby.Process.AddActions( f20_local8, f20_local4 )
	Lobby.Process.AddActions( f20_local4, f20_local5, f20_local1, f20_local1 )
	Lobby.Process.ForceAction( f20_local5, f20_local3 )
	Lobby.Process.ForceAction( f20_local3, f20_local9 )
	Lobby.Process.ForceAction( f20_local9, f20_local10 )
	Lobby.Process.AddActions( f20_local10, f20_local11 )
	Lobby.Process.AddActions( f20_local11, f20_local12 )
	return f20_local15
end
Lobby.Process.MergeAsyncMatchmakingLobby = function ( f25_arg0, f25_arg1, f25_arg2 )
	local f25_local0 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] )
	local f25_local1 = function ()
		Lobby.Matchmaking.UpdateSearchStatus( f25_local0, LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_4_DESCRIPTION_1 )
		Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.WAIT_TO_LOBBY_DISBAND
		Engine[@"setsessionstatus"]( f25_local0, Enum[@"sessionstatus"][@"session_status_idle"] )
		Lobby.Merge.Complete()
	end
	
	local f25_local2 = Lobby.Interrupt.FailedAction( Lobby.ProcessNavigate.GameLobbyInterrupt, {
		controller = f25_arg0,
		errorTarget = LobbyData.GetLobbyMenuByName( f25_arg1[@"errtarget"] ),
		isPublic = true
	} )
	if Engine[@"isdedicatedserver"]() then
		f25_local2 = Lobby.Actions.ExecuteScript( function ()
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.DISBAND_LOBBY
		end )
	end
	local f25_local3 = Lobby.Actions.CloseSpinner()
	local f25_local4 = Lobby.Actions.AsyncMatchmakingJoin( f25_arg2, f25_arg1 )
	local f25_local5 = Lobby.Actions.ExecuteScript( f25_local1 )
	local f25_local6 = Lobby.Actions.ErrorPopup( f25_local4 )
	local f25_local7 = Lobby.Actions.ExecuteScript( function ()
		Engine[@"setsessionstatus"]( f25_local0, Enum[@"sessionstatus"][@"session_status_merge"] )
		Lobby.Timer.HostingLobbyEnd( {
			lobbyType = f25_local0
		} )
	end )
	local f25_local8 = {
		head = f25_local3,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false
	}
	Lobby.Process.AddActions( f25_local3, f25_local7 )
	Lobby.Process.AddActions( f25_local7, f25_local4, f25_local2, f25_local2 )
	Lobby.Process.AddActions( f25_local4, f25_local5, f25_local2, f25_local2 )
	return f25_local8
end
Lobby.Process.ShutdownAsyncMatchmakingLobby = function ( f29_arg0 )
	local f29_local0 = Engine[@"currentsessionmode"]()
	local f29_local1 = function ()
		if f29_local0 == Enum[@"emodes"][@"mode_warzone"] then
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.SHUTDOWN
			Lobby.MMAsync.Dedi.reason = "wzEnd"
		else
			Lobby.MMAsync.Dedi.status = Lobby.MatchmakingAsync.DedicatedServerState.REGISTER_SERVER
		end
	end
	
	local f29_local2 = Lobby.Actions.LobbyVMCallRetVal( Lobby.Timer.HostingLobbyEnd, {
		controller = f29_arg0,
		lobbyType = Enum[@"lobbytype"][@"lobby_type_game"]
	}, true, false, false )
	local f29_local3 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f29_local4 = Lobby.Actions.AsyncMatchmakingDisbandLobby( f29_arg0, Engine[@"numbertouint64"]( 20000 ), Lobby.MMAsync.Info.lobbyID )
	local f29_local5 = Lobby.Actions.WaitTillXSRestIsDone( Dvar[@"hash_666F40AC92AAA0A0"]:get() )
	local f29_local6 = Lobby.Actions.ExecuteScript( f29_local1 )
	local f29_local7 = {
		head = f29_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false
	}
	Lobby.Process.ForceAction( f29_local2, f29_local3 )
	Lobby.Process.ForceAction( f29_local3, f29_local5 )
	if Lobby.MMAsync.Info.lobbyID == nil then
		Lobby.Process.ForceAction( f29_local5, f29_local6 )
	else
		Lobby.Process.ForceAction( f29_local5, f29_local4 )
		Lobby.Process.ForceAction( f29_local4, f29_local6 )
	end
	return f29_local7
end
Lobby.Process.AsynMatchMakingRecover = function ( f31_arg0, f31_arg1, f31_arg2, f31_arg3 )
	local f31_local0 = f31_arg1.controller
	local f31_local1 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] )
	local f31_local2 = function ()
		Engine[@"setsessionstatus"]( f31_local1, Enum[@"sessionstatus"][@"session_status_idle"] )
	end
	
	local f31_local3 = Lobby.Actions.ExecuteScript( function ()
		Lobby.Matchmaking.UpdateSearchStatus( f31_local1, LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE )
	end )
	local f31_local4 = Lobby.Actions.ExecuteScript( f31_local2 )
	local f31_local5 = Lobby.Actions.AsyncMatchmakingCancel( f31_local0, Engine[@"numbertouint64"]( 20000 ), {
		matchmakingID = Lobby.MMAsync.Info.matchmakingID
	} )
	local f31_local6 = Lobby.Actions.OpenSpinner( true )
	local f31_local7 = Lobby.Actions.CloseSpinner()
	local f31_local8 = f31_arg2.errorMsg
	local f31_local9 = f31_arg2.errorTitle
	local f31_local10 = {
		head = f31_local6,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false
	}
	if f31_arg2.action ~= nil and Engine[@"isdevelopmentbuild"]() then
		if f31_arg2.action.errorFuncPtr then
			f31_local8 = f31_local8 .. "\n\ndebug: " .. f31_arg2.action:errorFuncPtr()
		else
			f31_local8 = f31_local8 .. "\n\n(debug info, failed action: " .. f31_arg2.action.name .. ")"
		end
	end
	local f31_local11 = Lobby.Actions.ErrorPopupMsg( f31_local8, f31_local9 )
	Lobby.Process.ForceAction( f31_local6, f31_local5 )
	Lobby.Process.ForceAction( f31_local5, f31_local3 )
	Lobby.Process.ForceAction( f31_local3, f31_local4 )
	Lobby.Process.ForceAction( f31_local4, f31_local7 )
	Lobby.Process.ForceAction( f31_local7, f31_local11 )
	return f31_local10
end
Lobby.Process.AsyncMatchmakingStartAsyncMatchmaker = function ( f34_arg0 )
	Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE )
	local f34_local0 = {
		controller = f34_arg0,
		errorTarget = LobbyData.GetCurrentMenuTarget(),
		isPublic = true
	}
	local f34_local1 = function ()
		Engine[@"setsessionstatus"]( Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_join"] )
	end
	
	local f34_local2 = function ()
		Engine[@"setsessionstatus"]( Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"] )
	end
	
	local f34_local3 = function ()
		Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_1_DESCRIPTION_1 )
	end
	
	local f34_local4 = function ()
		Lobby.Matchmaking.UpdateSearchStatus( Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_2, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_2_DESCRIPTION_1 )
	end
	
	local f34_local5 = function ()
		if Engine[@"hash_356B4618D857143D"]() then
			
		else
			
		end
	end
	
	local f34_local6 = Engine[@"getplaylistinfobyid"]( Engine[@"getplaylistid"]() )
	local f34_local7 = Lobby.Actions.ExecuteScriptWithReturn( function ()
		return Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"] ) <= f34_local6.maxPartySize
	end, true, false, false )
	f34_local7.name = f34_local7.name .. "(canWeFitOurParty)"
	local f34_local8 = Lobby.Actions.ExecuteScriptWithReturn( function ()
		if f34_local6.maxLocalPlayers > 1 then
			return true
		else
			return Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ), Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_splitscreen_remote"] ) <= 0
		end
	end, true, false, false )
	f34_local8.name = f34_local8.name .. "(canWeAllowRemoteSplitscreenParty)"
	local f34_local9 = Lobby.Actions.ExecuteScriptWithReturn( function ()
		if not f34_local6.isSpectreRising then
			return true
		end
		local f42_local0 = Enum[@"lobbymodule"][@"lobby_module_host"]
		local f42_local1 = Engine[@"lobbygetsessionclients"]( f42_local0, Engine[@"lobbygetcontrollinglobbysession"]( f42_local0 ) )
		for f42_local5, f42_local6 in ipairs( f42_local1.sessionClients ) do
			local f42_local7 = Engine[@"getpositionrolebundleinfo"]( Engine[@"currentsessionmode"](), Engine[@"getcharacterindexforclientnum"]( f34_arg0, f42_local6.clientNum ) )
			if f42_local7[@"unlockableitementry"] == @"wz_character_spectre" then
				return false
			end
		end
		return true
	end, true, false, false )
	f34_local9.name = f34_local9.name .. "(canEnterSpectreRising)"
	local f34_local10 = Lobby.Actions.ExecuteScript( f34_local5 )
	f34_local10.name = "updateContextByPlayerCount"
	local f34_local11 = Lobby.Interrupt.Back( Lobby.Process.AsynMatchMakingRecover, f34_local0 )
	local f34_local12 = Lobby.Actions.OpenSpinner( true )
	local f34_local13 = Lobby.Actions.CloseSpinner()
	local f34_local14 = Lobby.Actions.WaitForJoiningClients( 5000 )
	local f34_local15 = Lobby.Actions.ExecuteScript( f34_local1 )
	local f34_local16 = Lobby.Actions.ExecuteScript( f34_local2 )
	local f34_local17 = Lobby.Actions.SetQueueCancellable( true )
	local f34_local18 = Lobby.Actions.WaitForDSPingsToBeDone( f34_arg0 )
	local f34_local19 = Lobby.Actions.ExecuteScript( f34_local3 )
	local f34_local20 = Lobby.Actions.ExecuteScript( f34_local4 )
	local f34_local21 = Lobby.Actions.AsyncMatchmakingWaitTillHostHasAllTokens( 10000 )
	local f34_local22 = Lobby.Actions.AsyncMatchmakingStartSearch( f34_arg0, Engine[@"numbertouint64"]( 40000 ), nil )
	local f34_local23 = Lobby.Actions.AsyncMatchmakingWaitToComplete( f34_local22 )
	local f34_local24 = Lobby.Actions.CaptureStartSearchErrorAndAct( f34_local22 )
	local f34_local25 = Lobby.Actions.AsyncMatchmakingCancel( f34_arg0, Engine[@"numbertouint64"]( 40000 ), f34_local22 )
	local f34_local26 = Lobby.Interrupt.AsyncMatchmakingErrorMsg( Lobby.Process.AsynMatchMakingRecover, f34_local0, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_112B0EAC15FB53DE" ), f34_local22 )
	local f34_local27 = Lobby.Interrupt.AsyncMatchmakingErrorMsg( Lobby.Process.AsynMatchMakingRecover, f34_local0, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_13A32B690B0CF2C8" ), f34_local23 )
	local f34_local28 = Lobby.Interrupt.AsyncMatchmakingErrorMsg( Lobby.Process.AsynMatchMakingRecover, f34_local0, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_6128045808A178F3", f34_local6.maxPartySize ) )
	local f34_local29 = Lobby.Interrupt.AsyncMatchmakingErrorMsg( Lobby.Process.AsynMatchMakingRecover, f34_local0, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_3B44D2306F5FF2B6" ) )
	local f34_local30 = Lobby.Interrupt.AsyncMatchmakingErrorMsg( Lobby.Process.AsynMatchMakingRecover, f34_local0, Engine[@"hash_4F9F1239CFD921FE"]( @"menu/spectre_restricted" ) )
	local f34_local31 = Lobby.Interrupt.ErrorMsg( Lobby.Process.AsynMatchMakingRecover, f34_local0, Engine[@"hash_4F9F1239CFD921FE"]( @"hash_13A32B690B0CF2C8" ) )
	local f34_local32 = {
		head = f34_local12,
		interrupt = f34_local11,
		force = false,
		cancellable = false
	}
	Lobby.Process.ForceAction( f34_local12, f34_local10 )
	Lobby.Process.ForceAction( f34_local10, f34_local19 )
	Lobby.Process.ForceAction( f34_local19, f34_local18 )
	Lobby.Process.AddActions( f34_local18, f34_local14, f34_local31, f34_local31 )
	Lobby.Process.ForceAction( f34_local14, f34_local15 )
	Lobby.Process.ForceAction( f34_local15, f34_local7 )
	Lobby.Process.AddActions( f34_local7, f34_local8, f34_local28, f34_local28 )
	Lobby.Process.AddActions( f34_local8, f34_local9, f34_local29, f34_local29 )
	Lobby.Process.AddActions( f34_local9, f34_local21, f34_local30, f34_local30 )
	Lobby.Process.AddActions( f34_local21, f34_local22, f34_local26, f34_local26 )
	Lobby.Process.AddActions( f34_local22, f34_local20, f34_local24, f34_local24 )
	Lobby.Process.AddActions( f34_local20, f34_local13 )
	Lobby.Process.ForceAction( f34_local13, f34_local17 )
	Lobby.Process.ForceAction( f34_local17, f34_local23 )
	Lobby.Process.AddActions( f34_local23, f34_local16, f34_local27, f34_local27 )
	Lobby.Process.AddActions( f34_local24, f34_local25, f34_local26, f34_local26 )
	Lobby.Process.ForceAction( f34_local25, f34_local21 )
	return f34_local32
end
Lobby.Process.UnParkAndJoinCustomDedicatedServer = function ( f43_arg0 )
	Lobby.Matchmaking.SetupMatchmakingQuery( f43_arg0, Lobby.Matchmaking.SearchMode.CUSTOM_DEDICATED )
	local f43_local0 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] )
	Engine[@"setsessionstatus"]( f43_local0, Enum[@"sessionstatus"][@"session_status_idle"] )
	local f43_local1 = function ()
		Engine[@"setsessionstatus"]( f43_local0, Enum[@"sessionstatus"][@"session_status_join"] )
	end
	
	local f43_local2 = function ()
		Engine[@"setsessionstatus"]( f43_local0, Enum[@"sessionstatus"][@"session_status_idle"] )
		Lobby.Timer.HostingLobbyEnd( {
			lobbyType = f43_local0
		} )
		Lobby.Timer.Clear( false )
		Engine[@"qosprobelistenerenable"]( false )
		Lobby.Merge.Complete()
		Lobby.Matchmaking.ClearSearchInfo()
	end
	
	local f43_local3 = function ()
		Engine[@"setsessionstatus"]( f43_local0, Enum[@"sessionstatus"][@"session_status_idle"] )
		Lobby.Timer.SetManualStatusTo( Lobby.Timer.LOBBY_STATUS.STARTING )
		Lobby.Merge.Complete()
	end
	
	local f43_local4 = Lobby.Actions.ExecuteScript( f43_local1 )
	local f43_local5 = Lobby.Actions.ExecuteScript( f43_local2 )
	local f43_local6 = Lobby.Actions.ExecuteScript( f43_local3 )
	local f43_local7 = Lobby.Actions.SearchForLobby( f43_arg0, f43_local0 )
	local f43_local8 = Lobby.Actions.QoSJoinSearchResults( f43_arg0, f43_local7, true )
	f43_local7.name = f43_local7.name
	f43_local8.name = f43_local8.name
	local f43_local9 = {
		head = f43_local4,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f43_local4, f43_local7 )
	Lobby.Process.AddActions( f43_local7, f43_local8, f43_local6, f43_local6 )
	Lobby.Process.AddActions( f43_local8, f43_local5, f43_local6, f43_local6 )
	return f43_local9
end
Lobby.Process.MergePublicDedicatedLobby = function ( f47_arg0 )
	Lobby.Matchmaking.SetupMatchmakingQuery( f47_arg0, Lobby.Matchmaking.SearchMode.LOBBY_MERGE )
	local f47_local0 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] )
	local f47_local1 = function ()
		Engine[@"setsessionstatus"]( f47_local0, Enum[@"sessionstatus"][@"session_status_merge"] )
	end
	
	local f47_local2 = function ()
		Lobby.Timer.HostingLobbyEnd( {
			lobbyType = f47_local0
		} )
		Lobby.Merge.Complete()
		Lobby.Matchmaking.ClearSearchInfo()
	end
	
	local f47_local3 = function ()
		Engine[@"setsessionstatus"]( f47_local0, Enum[@"sessionstatus"][@"session_status_idle"] )
		Lobby.Merge.Complete()
	end
	
	local f47_local4 = Lobby.Actions.ExecuteScript( f47_local1 )
	local f47_local5 = Lobby.Actions.ExecuteScript( f47_local2 )
	local f47_local6 = Lobby.Actions.ExecuteScript( f47_local3 )
	local f47_local7 = Lobby.Actions.SearchForLobby( f47_arg0, f47_local0 )
	local f47_local8 = Lobby.Actions.SearchForLobby( f47_arg0, f47_local0 )
	f47_local7.name = f47_local7.name .. "_1"
	f47_local8.name = f47_local8.name .. "_2"
	local f47_local9 = Lobby.Actions.QoSJoinSearchResults( f47_arg0, f47_local7 )
	local f47_local10 = Lobby.Actions.QoSJoinSearchResults( f47_arg0, f47_local8 )
	f47_local9.name = f47_local9.name .. "_1"
	f47_local10.name = f47_local10.name .. "_2"
	local f47_local11 = Lobby.Actions.TimeDelay( 1000 )
	local f47_local12 = {
		head = f47_local4,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f47_local4, f47_local7 )
	Lobby.Process.AddActions( f47_local7, f47_local9, f47_local11, f47_local6 )
	Lobby.Process.AddActions( f47_local9, f47_local5, f47_local11, f47_local6 )
	Lobby.Process.AddActions( f47_local11, f47_local8, f47_local8, f47_local6 )
	Lobby.Process.AddActions( f47_local8, f47_local10, f47_local6, f47_local6 )
	Lobby.Process.AddActions( f47_local10, f47_local5, f47_local6, f47_local6 )
	return f47_local12
end
Lobby.Process.MergePublicGameLobby = function ( f51_arg0 )
	Lobby.Matchmaking.SetupMatchmakingQuery( f51_arg0, Lobby.Matchmaking.SearchMode.LOBBY_MERGE )
	local f51_local0 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] )
	Engine[@"setsessionstatus"]( f51_local0, Enum[@"sessionstatus"][@"session_status_idle"] )
	local f51_local1 = function ()
		Engine[@"setsessionstatus"]( f51_local0, Enum[@"sessionstatus"][@"session_status_merge"] )
	end
	
	local f51_local2 = function ()
		Engine[@"setsessionstatus"]( f51_local0, Enum[@"sessionstatus"][@"session_status_idle"] )
		Lobby.Timer.HostingLobbyEnd( {
			lobbyType = f51_local0
		} )
		Engine[@"qosprobelistenerenable"]( false )
		Lobby.Merge.Complete()
		Lobby.Matchmaking.ClearSearchInfo()
	end
	
	local f51_local3 = function ()
		Engine[@"setsessionstatus"]( f51_local0, Enum[@"sessionstatus"][@"session_status_idle"] )
		Lobby.Merge.Complete()
	end
	
	local f51_local4 = Lobby.Actions.ExecuteScript( f51_local1 )
	local f51_local5 = Lobby.Actions.ExecuteScript( f51_local2 )
	local f51_local6 = Lobby.Actions.ExecuteScript( f51_local3 )
	local f51_local7 = Lobby.Actions.SearchForLobby( f51_arg0, f51_local0 )
	local f51_local8 = Lobby.Actions.SearchForLobby( f51_arg0, f51_local0 )
	local f51_local9 = Lobby.Actions.QoSJoinSearchResults( f51_arg0, f51_local7 )
	local f51_local10 = Lobby.Actions.QoSJoinSearchResults( f51_arg0, f51_local8 )
	local f51_local11 = Lobby.Actions.TimeDelay( 1000 )
	f51_local7.name = f51_local7.name .. "_1"
	f51_local8.name = f51_local8.name .. "_2"
	f51_local9.name = f51_local9.name .. "_1"
	f51_local10.name = f51_local10.name .. "_2"
	local f51_local12 = {
		head = f51_local4,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f51_local4, f51_local7 )
	Lobby.Process.AddActions( f51_local7, f51_local9, f51_local11, f51_local6 )
	Lobby.Process.AddActions( f51_local9, f51_local5, f51_local11, f51_local6 )
	Lobby.Process.AddActions( f51_local11, f51_local8, f51_local8, f51_local6 )
	Lobby.Process.AddActions( f51_local8, f51_local10, f51_local6, f51_local6 )
	Lobby.Process.AddActions( f51_local10, f51_local5, f51_local6, f51_local6 )
	return f51_local12
end
Lobby.Process.JoinSystemlinkOld = function ( f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4, f55_arg5, f55_arg6 )
	local f55_local0 = function ()
		Lobby.Timer.HostingLobbyEnd( {
			lobbyType = Enum[@"lobbytype"][@"lobby_type_private"]
		} )
	end
	
	local f55_local1 = Engine[@"getlobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"] )
	local f55_local2 = Lobby.Actions.OpenSpinner()
	local f55_local3 = Lobby.Actions.CloseSpinner()
	local f55_local4 = Lobby.Actions.ExecuteScript( f55_local0 )
	local f55_local5 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f55_local6 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f55_local7 = Lobby.Actions.LobbyHostStart( f55_arg0, f55_arg1, f55_arg5, f55_local1.lobbyMode, f55_local1.sessionHost.maxClients, "", "" )
	local f55_local8 = Lobby.Actions.LobbyHostAddPrimary( f55_local7.lobbyType )
	local f55_local9 = Lobby.Actions.LobbyClientStart( f55_local7.lobbyType )
	local f55_local10 = Lobby.Actions.JoinHost( f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4, f55_arg5, f55_arg6 )
	local f55_local11 = Lobby.Actions.CloseSpinner()
	Lobby.Process.ForceAction( f55_local11, Lobby.Actions.ErrorPopup( f55_local10 ) )
	local f55_local12 = {
		head = f55_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f55_local2, f55_local4 )
	local f55_local13 = f55_local4
	if Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_private"] ) == false then
		Lobby.Process.AddActions( f55_local13, f55_local5 )
		Lobby.Process.AddActions( f55_local5, f55_local6 )
		Lobby.Process.AddActions( f55_local6, f55_local7 )
		Lobby.Process.AddActions( f55_local7, f55_local8 )
		Lobby.Process.AddActions( f55_local8, f55_local9 )
		f55_local13 = f55_local9
	end
	Lobby.Process.AddActions( f55_local13, f55_local10 )
	Lobby.Process.AddActions( f55_local10, f55_local3, f55_local11, f55_local11 )
	return f55_local12
end
Lobby.Process.JoinSystemlink = function ( f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4, f57_arg5, f57_arg6 )
	if Dvar[@"join_transitionlobby"]:get() == false then
		return Lobby.Process.JoinSystemlinkOld( f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4, f57_arg5, f57_arg6 )
	else
		local f57_local0 = Lobby.Actions.OpenSpinner()
		local f57_local1 = Lobby.Actions.CloseSpinner()
		local f57_local2 = Lobby.Actions.LobbyHostStart( f57_arg0, Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"], Enum[@"lobbytype"][@"lobby_type_transition"], Enum[@"lobbymode"][@"lobby_mode_invalid"], 18, "", "" )
		local f57_local3 = Lobby.Actions.LobbyJoinSession( f57_arg0, Enum[@"lobbytype"][@"lobby_type_transition"], Enum[@"jointype"][@"join_type_party"] )
		local f57_local4 = Lobby.Actions.JoinHost( f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4, Enum[@"lobbytype"][@"lobby_type_transition"], f57_arg6 )
		local f57_local5 = Lobby.Actions.WaitForParty( f57_local4.joinResults, 10000 )
		local f57_local6 = Lobby.Actions.MoveLobbySession( f57_arg0, f57_local4.joinResults )
		local f57_local7 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_transition"] )
		local f57_local8 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_transition"] )
		local f57_local9 = {
			head = f57_local0,
			interrupt = Lobby.Interrupt.NONE,
			force = true,
			cancellable = true
		}
		local f57_local10 = f57_local7
		Lobby.Process.ForceAction( f57_local10, f57_local8 )
		Lobby.Process.ForceAction( f57_local8, f57_local1 )
		local f57_local11 = Lobby.ProcessQueue.CopyProcess( f57_local10 )
		Lobby.Process.AddActions( f57_local0, f57_local2, f57_local11, f57_local11 )
		Lobby.Process.AddActions( f57_local2, f57_local3, f57_local11, f57_local11 )
		Lobby.Process.AddActions( f57_local3, f57_local4, f57_local11, f57_local11 )
		Lobby.Process.AddActions( f57_local4, f57_local5, f57_local11, f57_local11 )
		Lobby.Process.AddActions( f57_local5, f57_local6, f57_local11, f57_local11 )
		Lobby.Process.ForceAction( f57_local6, f57_local1 )
		return f57_local9
	end
end
Lobby.Process.Join = function ( f58_arg0, f58_arg1, f58_arg2, f58_arg3 )
	Lobby.ProcessNavigate.RemoveAllBots()
	local f58_local0 = Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] ) and Enum[@"lobbytype"][@"lobby_type_game"] or Enum[@"lobbytype"][@"lobby_type_private"]
	local f58_local1 = Engine[@"getlobbymaxclients"]( Enum[@"lobbymodule"][@"lobby_module_client"], f58_local0 )
	local f58_local2 = function ()
		Lobby.Timer.HostingLobbyEnd( {
			lobbyType = f58_local0
		} )
	end
	
	local f58_local3 = function ()
		return Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] )
	end
	
	local f58_local4 = function ()
		LobbyVM.OnErrorShutdown( {
			controller = f58_arg0,
			signoutUsers = false
		} )
	end
	
	local f58_local5 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	local f58_local6 = nil
	if f58_local5[@"networkmode"] == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		f58_local6 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE )
	else
		f58_local6 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_LAN )
	end
	local f58_local7 = Lobby.Actions.WaitForJoiningClients( 5000 )
	local f58_local8 = function ()
		Engine[@"setsessionstatus"]( Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_join"] )
	end
	
	local f58_local9 = function ()
		Engine[@"setsessionstatus"]( Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"] )
	end
	
	local f58_local10 = function ()
		if Engine[@"hash_686E64DD1C270046"]( Enum[@"lobbymodule"][@"lobby_module_client"], f58_local0, f58_arg1 ) then
			Engine[@"setsessionstatus"]( Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"] )
			return false
		else
			return true
		end
	end
	
	local f58_local11 = Lobby.Actions.ExecuteScript( f58_local8 )
	f58_local11.name = "preventPlayerJoining"
	local f58_local12 = Lobby.Actions.ExecuteScript( f58_local9 )
	f58_local12.name = "allowPlayerJoining"
	local f58_local13 = Lobby.Actions.ExecuteScript( f58_local10 )
	f58_local13.name = "didPlayerJoinUs"
	local f58_local14 = Lobby.Process.ReloadPrivateLobby( f58_arg0, f58_local6[@"networkmode"] )
	local f58_local15 = Lobby.Actions.LobbySettings( f58_arg0, f58_local6 )
	local f58_local16 = Lobby.Actions.UpdateUI( f58_arg0, f58_local6 )
	local f58_local17 = Lobby.Actions.OpenSpinner()
	local f58_local18 = Lobby.Actions.CloseSpinnerAllowJoining()
	local f58_local19 = Lobby.Actions.CloseSpinnerAllowJoining()
	local f58_local20 = Lobby.Actions.CloseSpinnerAllowJoining()
	f58_local20.name = f58_local20.name .. "Error"
	local f58_local21 = Lobby.Actions.CloseSpinnerAllowJoining()
	f58_local21.name = f58_local21.name .. "NeedsFirstTimeFlowPreCheck"
	local f58_local22 = Lobby.Actions.ExecuteScript( f58_local2 )
	local f58_local23 = Lobby.Actions.ExecuteScript( f58_local4 )
	local f58_local24 = Lobby.Actions.LeaveWithParty( 3000 )
	local f58_local25 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f58_local26 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f58_local27 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f58_local28 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f58_local29 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f58_local30 = Lobby.Actions.LobbyInfoProbe( f58_arg0, {
		xuid = f58_arg1
	} )
	local f58_local31 = Lobby.Actions.CheckFirstTimeFlowRequirements( f58_arg0, f58_local30 )
	local f58_local32 = Lobby.Actions.ShowFirstTimeFlowError( f58_arg0, f58_local31 )
	local f58_local33 = Lobby.Actions.LobbyInfoProbe( f58_arg0, {
		xuid = f58_arg1
	} )
	local f58_local34 = Lobby.Actions.CheckRestrictedClients( f58_arg0, f58_local33 )
	local f58_local35 = Lobby.Actions.CheckLobbySessionStatus( Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"], f58_local33 )
	local f58_local36 = Lobby.Actions.AsyncMatchmakingJoinCheck( f58_local33 )
	local f58_local37 = Lobby.Actions.AsyncMatchmakingWaitTillHostHasAllTokens( 10000 )
	local f58_local38 = Lobby.Actions.AsyncMatchmakingStartSearch( f58_arg0, Engine[@"numbertouint64"]( 40000 ), {
		probeResult = {
			probedXuid = f58_arg1
		}
	} )
	local f58_local39 = Lobby.Actions.AsyncMatchmakingWaitToComplete( f58_local38 )
	local f58_local40 = Lobby.Actions.AsyncMatchmakingCancel( f58_arg0, Engine[@"numbertouint64"]( 40000 ), f58_local38 )
	local f58_local41 = Lobby.Actions.LobbyJoinXUIDExt( f58_arg0, f58_arg2, f58_local33, Enum[@"lobbytype"][@"lobby_type_count"] )
	f58_local41.name = f58_local41.name .. "_joinGame"
	local f58_local42 = Lobby.Actions.LobbyJoinXUIDExt( f58_arg0, Enum[@"jointype"][@"join_type_party"], f58_local33, Enum[@"lobbytype"][@"lobby_type_private"] )
	f58_local42.name = f58_local42.name .. "_joinPrivate"
	local f58_local43 = Lobby.Actions.LobbyJoinXUIDExt( f58_arg0, Enum[@"jointype"][@"join_type_party"], f58_local33, Enum[@"lobbytype"][@"lobby_type_private"] )
	f58_local43.name = f58_local42.name .. "_BackJoinPrivate"
	local f58_local44 = Lobby.Actions.ExecuteScriptWithReturn( f58_local3, true, false, false )
	local f58_local45 = Lobby.Actions.LobbyHostStart( f58_arg0, Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbymode"][@"lobby_mode_invalid"], f58_local1, "", "" )
	local f58_local46 = Lobby.Actions.LobbyHostAddPrimary( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f58_local47 = Lobby.Actions.LobbyClientStart( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f58_local48 = false
	if Engine[@"getlobbyuiscreen"]() ~= LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC ) then
		f58_local48 = true
	end
	local f58_local49 = Lobby.Actions.ForceLobbyUIScreen( f58_arg0, LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE ) )
	local f58_local50 = Lobby.Actions.ErrorPopup( f58_local41 )
	local f58_local51 = Lobby.Process.ReloadPrivateLobby( f58_arg0, f58_local6[@"networkmode"] )
	local f58_local52 = Lobby.Actions.LobbySettings( f58_arg0, f58_local6 )
	local f58_local53 = Lobby.Actions.UpdateUI( f58_arg0, f58_local6 )
	local f58_local54 = f58_local51.head
	Lobby.Process.ForceAction( f58_local51.tail, f58_local52 )
	Lobby.Process.ForceAction( f58_local52, f58_local53 )
	Lobby.Process.ForceAction( f58_local53, f58_local50 )
	Lobby.Process.ForceAction( f58_local50, f58_local12 )
	local f58_local55 = Lobby.Actions.ErrorPopup( f58_local42 )
	local f58_local56 = Lobby.Process.ReloadPrivateLobby( f58_arg0, f58_local6[@"networkmode"] )
	local f58_local57 = Lobby.Process.JoinFailedPrivateLobby( f58_arg0, f58_local6[@"networkmode"] )
	local f58_local58 = Lobby.Actions.LobbySettings( f58_arg0, f58_local6 )
	local f58_local59 = Lobby.Actions.UpdateUI( f58_arg0, f58_local6 )
	local f58_local60 = f58_local56.head
	Lobby.Process.ForceAction( f58_local56.tail, f58_local58 )
	Lobby.Process.ForceAction( f58_local58, f58_local59 )
	Lobby.Process.ForceAction( f58_local59, f58_local55 )
	Lobby.Process.ForceAction( f58_local55, f58_local12 )
	local f58_local61 = f58_local57.head
	Lobby.Process.ForceAction( f58_local57.tail, f58_local58 )
	local f58_local62 = f58_local22
	local f58_local63 = Engine[@"isingame"]()
	local f58_local64 = Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"] )
	local f58_local65 = Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] )
	local f58_local66 = Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f58_local67 = Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f58_local68 = Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"] )
	local f58_local69 = Engine[@"getlobbyclientcount"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"] )
	local f58_local70 = f58_local66 and f58_arg3 == LuaEnum.LEAVE_WITH_PARTY.WITH
	local f58_local71 = false
	local f58_local72 = false
	local f58_local73 = false
	local f58_local74 = false
	if f58_local63 == true then
		f58_local71 = true
		f58_local72 = true
		f58_local73 = true
		if f58_local66 == true then
			f58_local74 = true
		end
	elseif f58_local65 == true then
		f58_local71 = true
		f58_local72 = true
		if f58_local70 == false then
			f58_local73 = true
			if f58_local66 == true then
				f58_local74 = true
			end
		end
	elseif f58_local64 == true then
		if f58_local70 == false then
			f58_local73 = true
			if f58_local66 == true then
				f58_local74 = true
			end
		end
	else
		f58_local71 = true
		f58_local72 = true
		f58_local73 = true
		f58_local74 = true
	end
	local f58_local75 = {
		head = f58_local17,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f58_local17, f58_local7 )
	Lobby.Process.AddActions( f58_local7, f58_local11, f58_local18, f58_local18 )
	Lobby.Process.AddActions( f58_local11, f58_local13, f58_local18, f58_local18 )
	Lobby.Process.AddActions( f58_local13, f58_local30, f58_local18, f58_local18 )
	Lobby.Process.AddActions( f58_local30, f58_local31, f58_local18, f58_local18 )
	Lobby.Process.AddActions( f58_local31, f58_local22, f58_local21, f58_local21 )
	local f58_local76 = false
	if f58_local65 == true and f58_local70 == true then
		Lobby.Process.AddActions( f58_local62, f58_local24, f58_local60, f58_local60 )
		f58_local62 = f58_local24
		f58_local76 = true
	end
	if f58_local71 == true then
		Lobby.Process.AddActions( f58_local62, f58_local27, f58_local60, f58_local60 )
		f58_local62 = f58_local27
		f58_local76 = true
	end
	if f58_local72 == true then
		Lobby.Process.AddActions( f58_local62, f58_local28, f58_local60, f58_local60 )
		f58_local62 = f58_local28
		f58_local76 = true
	end
	if f58_local73 == true then
		Lobby.Process.AddActions( f58_local62, f58_local29, f58_local60, f58_local60 )
		f58_local62 = f58_local29
		f58_local48 = true
		f58_local76 = true
	end
	if f58_local74 == true then
		Lobby.Process.AddActions( f58_local62, f58_local26, f58_local60, f58_local60 )
		f58_local62 = f58_local26
		f58_local48 = true
		f58_local76 = true
	end
	if f58_local66 == false or f58_local74 == true then
		Lobby.Process.AddActions( f58_local62, f58_local45, f58_local60, f58_local60 )
		Lobby.Process.AddActions( f58_local45, f58_local46, f58_local60, f58_local60 )
		f58_local62 = f58_local46
		f58_local48 = true
		f58_local76 = true
	end
	if f58_local73 == true then
		Lobby.Process.AddActions( f58_local62, f58_local47, f58_local60, f58_local60 )
		f58_local62 = f58_local47
		f58_local48 = true
		f58_local76 = true
	end
	local f58_local77 = Lobby.Actions.IsConditionTrue( not f58_local48 )
	local f58_local78 = Lobby.Actions.IsConditionTrue( f58_local76 )
	Lobby.Process.AddActions( f58_local62, f58_local33, f58_local60, f58_local60 )
	Lobby.Process.AddActions( f58_local33, f58_local34, f58_local60, f58_local60 )
	Lobby.Process.AddActions( f58_local34, f58_local35, f58_local60, f58_local60 )
	Lobby.Process.AddActions( f58_local35, f58_local36, f58_local60, f58_local60 )
	Lobby.Process.AddActions( f58_local36, f58_local37, f58_local42, f58_local41 )
	Lobby.Process.AddActions( f58_local37, f58_local38, f58_local60, f58_local60 )
	Lobby.Process.AddActions( f58_local38, f58_local39, f58_local77, f58_local60 )
	Lobby.Process.AddActions( f58_local39, f58_local18, f58_local77, f58_local60 )
	Lobby.Process.AddActions( f58_local77, f58_local49, f58_local78, f58_local60 )
	Lobby.Process.AddActions( f58_local78, f58_local60, f58_local20, f58_local60 )
	Lobby.Process.AddActions( f58_local42, f58_local18, f58_local61, f58_local61 )
	Lobby.Process.AddActions( f58_local41, f58_local44, f58_local77, f58_local54 )
	Lobby.Process.AddActions( f58_local44, f58_local43, f58_local18, f58_local18 )
	Lobby.Process.ForceAction( f58_local43, f58_local18 )
	Lobby.Process.ForceAction( f58_local49, f58_local20 )
	Lobby.Process.ForceAction( f58_local20, f58_local50 )
	Lobby.Process.ForceAction( f58_local21, f58_local32 )
	return f58_local75
end
Lobby.Process.JoinFailedPrivateLobby = function ( f65_arg0, f65_arg1, f65_arg2 )
	Lobby.ProcessNavigate.RemoveAllBots()
	local f65_local0 = function ()
		Lobby.Timer.HostingLobbyEnd( {
			lobbyType = Enum[@"lobbytype"][@"lobby_type_game"]
		} )
	end
	
	local f65_local1 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	if f65_arg2 ~= nil then
		f65_local1 = f65_arg2
	end
	local f65_local2 = nil
	if LuaUtils.OnlineOnlyDemo() == true or f65_local1[@"networkmode"] == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		f65_local2 = LuaEnum.UI.DIRECTOR_ONLINE
	else
		f65_local2 = LuaEnum.UI.DIRECTOR_LAN
	end
	f65_local2 = LobbyData.GetLobbyMenuByName( f65_local2 )
	local f65_local3 = Engine[@"lobbygetgametype"]()
	local f65_local4 = Engine[@"lobbygetmap"]()
	if (f65_local3 == nil or f65_local3 == "") and to then
		f65_local3 = LuaUtils.GetDefaultGameType( f65_local1 )
	end
	if f65_local4 == nil or f65_local4 == "" then
		f65_local4 = LuaUtils.GetDefaultMap( f65_local1 )
	end
	local f65_local5 = Lobby.Actions.LobbySettings( f65_arg0, f65_arg2 )
	local f65_local6 = Lobby.Actions.UpdateUI( f65_arg0, f65_arg2 )
	local f65_local7 = Lobby.Actions.ExecuteScript( f65_local0 )
	local f65_local8 = Lobby.Actions.OpenSpinner()
	local f65_local9 = Lobby.Actions.CloseSpinner()
	local f65_local10 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f65_local11 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f65_local12 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f65_local13 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f65_local14 = Lobby.Actions.SetNetworkMode( f65_arg0, f65_arg1 )
	local f65_local15 = Lobby.Actions.LobbyHostStart( f65_arg0, Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbymode"][@"lobby_mode_invalid"], f65_local2[@"maxclients"], f65_local4, f65_local3 )
	local f65_local16 = Lobby.Actions.LobbyHostAddPrimary( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f65_local17 = Lobby.Actions.LobbyClientStart( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f65_local18 = {
		head = f65_local8,
		tail = f65_local9,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	local f65_local19 = f65_local8
	if f65_arg2 ~= nil then
		Lobby.Process.AddActions( f65_local19, f65_local5 )
		Lobby.Process.AddActions( f65_local5, f65_local6 )
		f65_local19 = f65_local6
	end
	Lobby.Process.AddActions( f65_local19, f65_local7 )
	Lobby.Process.AddActions( f65_local7, f65_local10 )
	Lobby.Process.AddActions( f65_local10, f65_local11 )
	local f65_local20 = f65_local11
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_private"] ) == false then
		Lobby.Process.AddActions( f65_local20, f65_local12 )
		Lobby.Process.AddActions( f65_local12, f65_local13 )
		Lobby.Process.AddActions( f65_local13, f65_local14 )
		if f65_arg1 == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
			local f65_local21 = Lobby.Actions.SignUserInToLive( f65_arg0 )
			Lobby.Process.AddActions( f65_local14, f65_local21 )
			Lobby.Process.AddActions( f65_local21, f65_local15 )
		else
			Lobby.Process.AddActions( f65_local14, f65_local15 )
		end
		Lobby.Process.AddActions( f65_local15, f65_local16 )
		Lobby.Process.AddActions( f65_local16, f65_local17 )
		f65_local20 = f65_local17
	end
	Lobby.Process.AddActions( f65_local20, f65_local9 )
	return f65_local18
end
Lobby.Process.ReloadPrivateLobby = function ( f67_arg0, f67_arg1, f67_arg2 )
	Lobby.ProcessNavigate.RemoveAllBots()
	local f67_local0 = function ()
		Lobby.Timer.HostingLobbyEnd( {
			lobbyType = Enum[@"lobbytype"][@"lobby_type_game"]
		} )
	end
	
	local f67_local1 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	if f67_arg2 ~= nil then
		f67_local1 = f67_arg2
	end
	local f67_local2 = nil
	if LuaUtils.OnlineOnlyDemo() == true then
		f67_local2 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE )
	elseif LuaUtils.OfflineOnlyDemo() == true then
		f67_local2 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_LAN )
	elseif f67_local1[@"networkmode"] == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		f67_local2 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_ONLINE )
	else
		f67_local2 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.DIRECTOR_LAN )
	end
	local f67_local3 = Engine[@"lobbygetgametype"]()
	local f67_local4 = Engine[@"lobbygetmap"]()
	if (f67_local3 == nil or f67_local3 == "") and to then
		f67_local3 = LuaUtils.GetDefaultGameType( f67_local1 )
	end
	if f67_local4 == nil or f67_local4 == "" then
		f67_local4 = LuaUtils.GetDefaultMap( f67_local1 )
	end
	local f67_local5 = Lobby.Actions.LobbySettings( f67_arg0, f67_arg2 )
	local f67_local6 = Lobby.Actions.UpdateUI( f67_arg0, f67_arg2 )
	local f67_local7 = Lobby.Actions.ExecuteScript( f67_local0 )
	local f67_local8 = Lobby.Actions.OpenSpinner()
	local f67_local9 = Lobby.Actions.CloseSpinner()
	local f67_local10 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f67_local11 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f67_local12 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f67_local13 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f67_local14 = Lobby.Actions.SetNetworkMode( f67_arg0, f67_arg1 )
	local f67_local15 = Lobby.Actions.LobbyHostStart( f67_arg0, Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbymode"][@"lobby_mode_invalid"], f67_local2[@"maxclients"], f67_local4, f67_local3 )
	local f67_local16 = Lobby.Actions.LobbyHostAddPrimary( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f67_local17 = Lobby.Actions.LobbyClientStart( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f67_local18 = {
		head = f67_local8,
		tail = f67_local9,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	local f67_local19 = f67_local8
	if f67_arg2 ~= nil then
		Lobby.Process.AddActions( f67_local19, f67_local5 )
		Lobby.Process.AddActions( f67_local5, f67_local6 )
		f67_local19 = f67_local6
	end
	Lobby.Process.AddActions( f67_local19, f67_local7 )
	Lobby.Process.AddActions( f67_local7, f67_local10 )
	Lobby.Process.AddActions( f67_local10, f67_local11 )
	Lobby.Process.AddActions( f67_local11, f67_local12 )
	Lobby.Process.AddActions( f67_local12, f67_local13 )
	Lobby.Process.AddActions( f67_local13, f67_local14 )
	if f67_arg1 == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		local f67_local20 = Lobby.Actions.SignUserInToLive( f67_arg0 )
		Lobby.Process.AddActions( f67_local14, f67_local20 )
		Lobby.Process.AddActions( f67_local20, f67_local15 )
	else
		Lobby.Process.AddActions( f67_local14, f67_local15 )
	end
	Lobby.Process.AddActions( f67_local15, f67_local16 )
	Lobby.Process.AddActions( f67_local16, f67_local17 )
	Lobby.Process.AddActions( f67_local17, f67_local9 )
	return f67_local18
end
Lobby.Process.Recover = function ( f69_arg0, f69_arg1 )
	Lobby.ProcessNavigate.RemoveAllBots()
	Lobby.MatchmakingAsync.EmptyEventQueue()
	local f69_local0 = Engine[@"getlobbyuiscreen"]()
	if f69_arg1 ~= nil then
		f69_local0 = f69_arg1
	end
	local f69_local1 = LobbyData.GetLobbyMenuByID( f69_local0 )
	if f69_local1[@"name"] == LuaEnum.UI.MAIN then
		return nil
	end
	local f69_local2 = LobbyData.GetLobbyMenuByName( f69_local1[@"errtarget"] )
	local f69_local3 = LobbyData.GetLobbyMenuByName( f69_local2[@"backtarget"] )
	local f69_local4 = Lobby.Actions.OpenSpinner( nil, true )
	local f69_local5 = Lobby.Actions.LobbyInRecovery()
	local f69_local6 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f69_local7 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f69_local8 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f69_local9 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f69_local10 = Lobby.Actions.LobbySettings( f69_arg0, f69_local2 )
	local f69_local11 = Lobby.Actions.ForceLobbyUIScreen( f69_arg0, f69_local2[@"id"] )
	local f69_local12 = Lobby.Actions.UpdateUI( f69_arg0, f69_local2 )
	local f69_local13 = Lobby.Actions.ArenaErrorShutdown( f69_arg0 )
	local f69_local14 = Lobby.Actions.SetDefaultArenaPlaylist( f69_arg0 )
	local f69_local15 = Lobby.Actions.RunPlaylistRules( f69_arg0 )
	local f69_local16 = Lobby.Actions.CloseSpinner()
	local f69_local17 = Lobby.Actions.LobbyVMCallRetVal( Lobby.Timer.HostingLobbyEnd, {
		controller = f69_arg0,
		lobbyType = f69_local1[@"lobbytype"],
		mainMode = f69_local1[@"mainmode"]
	}, true, false, false )
	local f69_local18 = {
		head = f69_local4,
		interrupt = Lobby.Interrupt.NONE,
		tail = nil,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f69_local4, f69_local5 )
	Lobby.Process.AddActions( f69_local5, f69_local17 )
	Lobby.Process.AddActions( f69_local17, f69_local8 )
	Lobby.Process.AddActions( f69_local8, f69_local9 )
	Lobby.Process.AddActions( f69_local9, f69_local6 )
	Lobby.Process.AddActions( f69_local6, f69_local7 )
	Lobby.Process.AddActions( f69_local7, f69_local10 )
	local f69_local19 = Engine[@"lobbygetgametype"]()
	local f69_local20 = Engine[@"lobbygetmap"]()
	if f69_local19 == nil or f69_local19 == "" then
		f69_local19 = LuaUtils.GetDefaultGameType( f69_local2 )
	end
	if f69_local20 == nil or f69_local20 == "" then
		f69_local20 = LuaUtils.GetDefaultMap( f69_local2 )
	end
	local f69_local21 = f69_local10
	if f69_local3 ~= nil then
		if f69_local3[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_invalid"] then
			
		elseif f69_local3[@"lobbytype"] ~= f69_local2[@"lobbytype"] then
			local f69_local22 = Lobby.Actions.LobbyHostStart( f69_arg0, f69_local3[@"mainmode"], f69_local3[@"lobbytype"], f69_local3[@"lobbymode"], f69_local3[@"maxclients"], f69_local20, f69_local19 )
			local f69_local23 = Lobby.Actions.LobbyHostAddPrimary( f69_local3[@"lobbytype"] )
			local f69_local24 = Lobby.Actions.LobbyClientStart( f69_local3[@"lobbytype"] )
			f69_local22.name = f69_local22.name .. "_1"
			Lobby.Process.AddActions( f69_local21, f69_local22 )
			Lobby.Process.AddActions( f69_local22, f69_local23 )
			Lobby.Process.AddActions( f69_local23, f69_local24 )
			f69_local21 = f69_local24
		elseif f69_local2[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_cp"] or f69_local2[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
			local f69_local22 = Lobby.Actions.LobbyHostStart( f69_arg0, f69_local2[@"mainmode"], Enum[@"lobbytype"][@"lobby_type_private"], f69_local2[@"lobbymode"], f69_local2[@"maxclients"], f69_local20, f69_local19 )
			local f69_local23 = Lobby.Actions.LobbyHostAddPrimary( Enum[@"lobbytype"][@"lobby_type_private"] )
			local f69_local24 = Lobby.Actions.LobbyClientStart( Enum[@"lobbytype"][@"lobby_type_private"] )
			f69_local22.name = f69_local22.name .. "_4"
			Lobby.Process.AddActions( f69_local21, f69_local22 )
			Lobby.Process.AddActions( f69_local22, f69_local23 )
			Lobby.Process.AddActions( f69_local23, f69_local24 )
			f69_local21 = f69_local24
		end
	end
	if f69_local2[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_private"] then
		local f69_local22 = Lobby.Actions.LobbyHostStart( f69_arg0, f69_local2[@"mainmode"], f69_local2[@"lobbytype"], f69_local2[@"lobbymode"], f69_local2[@"maxclients"], f69_local20, f69_local19 )
		local f69_local23 = Lobby.Actions.LobbyHostAddPrimary( f69_local2[@"lobbytype"] )
		local f69_local24 = Lobby.Actions.LobbyClientStart( f69_local2[@"lobbytype"] )
		local f69_local25 = Lobby.Actions.LobbyVMCall( Lobby.Timer.HostingLobby, {
			controller = f69_arg0,
			lobbyType = f69_local2[@"lobbytype"],
			mainMode = f69_local2[@"mainmode"],
			lobbyTimerType = f69_local2[@"hash_5558B67A321D1120"]
		} )
		f69_local22.name = f69_local22.name .. "_2"
		Lobby.Process.AddActions( f69_local21, f69_local22 )
		Lobby.Process.AddActions( f69_local22, f69_local23 )
		Lobby.Process.AddActions( f69_local23, f69_local24 )
		f69_local21 = f69_local24
		if f69_local2[@"hash_5558B67A321D1120"] ~= LuaEnum.TIMER_TYPE.INVALID then
			Lobby.Process.AddActions( f69_local24, f69_local25 )
			f69_local21 = f69_local25
		end
	elseif f69_local2[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_game"] then
		local f69_local22 = function ()
			if f69_local2[@"egamemodes"] == Enum[@"egamemodes"][@"mode_game_matchmaking_playlist"] and playlistID ~= LuaDefine.INVALID_PLAYLIST_ID then
				local f70_local0 = Engine[@"getplaylistinfobyid"]( playlistID )
				Engine[@"setlobbymaxclients"]( Enum[@"lobbytype"][@"lobby_type_private"], f70_local0.maxPartySize )
			end
		end
		
		local f69_local23 = Lobby.Actions.LobbyHostStart( f69_arg0, f69_local2[@"mainmode"], f69_local2[@"lobbytype"], f69_local2[@"lobbymode"], f69_local2[@"maxclients"], f69_local20, f69_local19 )
		local f69_local24 = Lobby.Actions.LobbyInfoProbe( f69_arg0, {
			xuid = Engine[@"getxuid64"]( f69_arg0 )
		} )
		local f69_local25 = Lobby.Actions.LobbyJoinXUID( f69_arg0, {
			xuid = Engine[@"getxuid64"]( f69_arg0 )
		}, Enum[@"jointype"][@"join_type_playlist"] )
		local f69_local26 = Lobby.Actions.LobbyVMCall( Lobby.Timer.HostingLobby, {
			controller = f69_arg0,
			lobbyType = f69_local2[@"lobbytype"],
			mainMode = f69_local2[@"mainmode"],
			lobbyTimerType = f69_local2[@"hash_5558B67A321D1120"]
		} )
		f69_local23.name = f69_local23.name .. "_3"
		local f69_local27 = Lobby.Actions.RunPlaylistSettings( f69_arg0 )
		local f69_local28 = Lobby.Actions.AdvertiseLobby( true )
		local f69_local29 = Lobby.Actions.ExecuteScript( f69_local22 )
		Lobby.Process.AddActions( f69_local21, f69_local23 )
		Lobby.Process.AddActions( f69_local23, f69_local24 )
		Lobby.Process.AddActions( f69_local24, f69_local25 )
		f69_local21 = f69_local25
		if f69_local2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_public"] or f69_local2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_arena"] then
			Lobby.Process.AddActions( f69_local21, f69_local27 )
			Lobby.Process.AddActions( f69_local27, f69_local28 )
			Lobby.Process.AddActions( f69_local28, f69_local29 )
			f69_local21 = f69_local29
		end
		Lobby.Process.AddActions( f69_local21, f69_local26 )
		f69_local21 = f69_local26
	end
	if f69_local2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_arena"] then
		Lobby.Process.AddActions( f69_local21, f69_local14 )
		Lobby.Process.AddActions( f69_local14, f69_local15 )
		f69_local21 = f69_local15
	end
	Lobby.Process.AddActions( f69_local21, f69_local13 )
	Lobby.Process.AddActions( f69_local13, f69_local11 )
	Lobby.Process.AddActions( f69_local11, f69_local12 )
	Lobby.Process.AddActions( f69_local12, f69_local16 )
	Lobby.Process.AddActions( f69_local16, nil )
	f69_local18.tail = f69_local16
	return f69_local18
end
Lobby.Process.ForceToMenu = function ( f71_arg0, f71_arg1, f71_arg2 )
	local f71_local0 = f71_arg1[@"isprivate"]
	local f71_local1 = f71_arg1[@"mainmode"]
	local f71_local2 = f71_arg1[@"networkmode"]
	local f71_local3 = f71_arg1[@"maxclients"]
	local f71_local4 = Lobby.Actions.LobbySettings( f71_arg0, f71_arg1 )
	local f71_local5 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f71_local6 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f71_local7 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f71_local8 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f71_local9 = Lobby.Actions.ForceLobbyUIScreen( f71_arg0, f71_arg1[@"id"] )
	local f71_local10 = Lobby.Actions.UpdateUI( f71_arg0, f71_arg1 )
	local f71_local11 = {
		head = f71_local4,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f71_local4, f71_local7 )
	Lobby.Process.AddActions( f71_local7, f71_local8 )
	Lobby.Process.AddActions( f71_local8, f71_local5 )
	Lobby.Process.AddActions( f71_local5, f71_local6 )
	local f71_local12 = f71_local6
	if f71_local0 == true then
		local f71_local13 = Lobby.Actions.LobbyHostStart( f71_arg0, f71_local1, Enum[@"lobbytype"][@"lobby_type_private"], f71_arg1[@"lobbymode"], f71_local3, "", "" )
		local f71_local14 = Lobby.Actions.LobbyHostAddPrimary( Enum[@"lobbytype"][@"lobby_type_private"] )
		local f71_local15 = Lobby.Actions.LobbyClientStart( Enum[@"lobbytype"][@"lobby_type_private"] )
		Lobby.Process.AddActions( f71_local8, f71_local13 )
		Lobby.Process.AddActions( f71_local13, f71_local14 )
		Lobby.Process.AddActions( f71_local14, f71_local15 )
		f71_local12 = f71_local15
	end
	Lobby.Process.AddActions( f71_local12, f71_local9 )
	Lobby.Process.AddActions( f71_local9, f71_local10 )
	if f71_arg2 ~= nil then
		Lobby.Process.AddActions( f71_local10, Lobby.Actions.ErrorPopupMsg( f71_arg2 ) )
	end
	return f71_local11
end
Lobby.Process.HostLeftNoMigrationCreatePrivateLobby = function ( f72_arg0, f72_arg1, f72_arg2 )
	local f72_local0 = LobbyData.GetCurrentMenuTarget()
	local f72_local1 = Enum[@"lobbytype"][@"lobby_type_private"]
	local f72_local2 = function ()
		if not Engine[@"isingame"]() and f72_local0[@"hash_5558B67A321D1120"] ~= LuaEnum.TIMER_TYPE.INVALID then
			Lobby.Timer.HostingLobby( {
				controller = f72_arg0,
				lobbyType = f72_local0[@"lobbytype"],
				mainMode = f72_local0[@"mainmode"],
				lobbyTimerType = f72_local0[@"hash_5558B67A321D1120"]
			} )
		end
	end
	
	local f72_local3 = Engine[@"lobbygetgametype"]()
	local f72_local4 = Engine[@"lobbygetmap"]()
	if f72_local3 == nil or f72_local3 == "" then
		f72_local3 = LuaUtils.GetDefaultGameType( f72_local0 )
	end
	if f72_local4 == nil or f72_local4 == "" then
		f72_local4 = LuaUtils.GetDefaultMap( f72_local0 )
	end
	local f72_local5 = Lobby.Actions.OpenSpinner( true )
	local f72_local6 = Lobby.Actions.CloseSpinner()
	local f72_local7 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f72_local8 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f72_local9 = Lobby.Actions.LobbyHostStart( f72_arg0, f72_arg1, f72_local1, f72_local0[@"lobbymode"], f72_arg2, f72_local4, f72_local3 )
	local f72_local10 = Lobby.Actions.LobbyHostAddPrimary( f72_local9.lobbyType )
	local f72_local11 = Lobby.Actions.LobbyClientStart( f72_local9.lobbyType )
	local f72_local12 = Lobby.Actions.ExecuteScript( f72_local2 )
	local f72_local13 = Lobby.Actions.ErrorPopup( f72_local9 )
	local f72_local14 = {
		head = f72_local5,
		interrupt = Lobby.Interrupt.NONE,
		force = false,
		cancellable = false
	}
	Lobby.Process.ForceAction( f72_local5, f72_local7 )
	Lobby.Process.ForceAction( f72_local7, f72_local8 )
	Lobby.Process.ForceAction( f72_local8, f72_local9 )
	Lobby.Process.ForceAction( f72_local9, f72_local10 )
	Lobby.Process.ForceAction( f72_local10, f72_local11 )
	Lobby.Process.ForceAction( f72_local11, f72_local12 )
	Lobby.Process.ForceAction( f72_local12, f72_local6 )
	f72_local14.tail = f72_local6
	return f72_local14
end
Lobby.Process.PromoteClientToPrivateLobbyHost = function ( f74_arg0, f74_arg1, f74_arg2, f74_arg3, f74_arg4, f74_arg5, f74_arg6, f74_arg7, f74_arg8, f74_arg9, f74_arg10 )
	local f74_local0 = Engine[@"getlobbyuiscreen"]()
	local f74_local1 = LobbyData.GetLobbyMenuByID( f74_local0 )
	local f74_local2 = function ()
		if f74_arg2 ~= Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] ) then
			return 
		elseif not Engine[@"isingame"]() and f74_local1[@"hash_5558B67A321D1120"] ~= LuaEnum.TIMER_TYPE.INVALID then
			local f75_local0, f75_local1 = Engine[@"getgamelobbystatusinfo"]( f74_arg2 )
			Lobby.Timer.HostingLobby( {
				controller = f74_arg0,
				lobbyType = f74_local1[@"lobbytype"],
				mainMode = f74_local1[@"mainmode"],
				lobbyTimerType = f74_local1[@"hash_5558B67A321D1120"],
				status = f75_local0,
				statusValue = f75_local1
			} )
		end
	end
	
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.Process.PromoteClientToPrivateLobbyHost: menuId(" .. f74_local0 .. "), lobbyType(" .. f74_arg2 .. "), mainMode(" .. f74_arg1 .. "), lobbyTimerType(" .. f74_local1[@"hash_5558B67A321D1120"] .. ").\n" )
	local f74_local3 = Lobby.Actions.ExecuteScript( function ()
		Lobby.Matchmaking.UpdateSearchStatus( f74_arg2, LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE )
	end )
	local f74_local4 = Lobby.Actions.PromoteToHostDone( f74_arg0, f74_arg2, f74_arg8, f74_arg7 )
	local f74_local5 = Lobby.Actions.LobbyHostStartMigratedInfo( f74_arg0, f74_arg1, f74_arg2, f74_arg3, f74_arg4, f74_arg10, f74_arg9, f74_arg5 )
	local f74_local6 = Lobby.Actions.ExecuteScript( f74_local2 )
	local f74_local7 = {
		head = f74_local4,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	if Engine[@"islobbyhost"]( f74_arg2 ) == false then
		f74_local7.head = f74_local5
		Lobby.Process.AddActions( f74_local5, f74_local6 )
		Lobby.Process.AddActions( f74_local6, f74_local3 )
		Lobby.Process.AddActions( f74_local3, f74_local4 )
	end
	return f74_local7
end
Lobby.Process.TransferDataFromClientModuleToHostModule = function ()
	local f77_local0 = Engine[@"lobbygetsessionclients"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] )
	for f77_local4, f77_local5 in ipairs( f77_local0.sessionClients ) do
		local f77_local6 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_host"] )
		Engine[@"lobbyhostassignmapvotetoclient"]( f77_local6, f77_local5.xuid, f77_local5.mapVote )
		Engine[@"lobbyhostassignteamtoclient"]( f77_local6, f77_local5.xuid, f77_local5.team )
	end
end
Lobby.Process.PromoteClientToGameLobbyHost = function ( f78_arg0, f78_arg1, f78_arg2, f78_arg3, f78_arg4, f78_arg5, f78_arg6, f78_arg7, f78_arg8, f78_arg9, f78_arg10 )
	local f78_local0 = Engine[@"getlobbyuiscreen"]()
	local f78_local1 = LobbyData.GetLobbyMenuByID( f78_local0 )
	local f78_local2 = Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"] )
	local f78_local3, f78_local4 = Engine[@"getgamelobbystatusinfo"]( f78_local2 )
	local f78_local5 = function ()
		if not Engine[@"isingame"]() and f78_local1[@"hash_5558B67A321D1120"] ~= LuaEnum.TIMER_TYPE.INVALID then
			Lobby.Timer.HostingLobby( {
				controller = f78_arg0,
				lobbyType = f78_local1[@"lobbytype"],
				mainMode = f78_local1[@"mainmode"],
				lobbyTimerType = f78_local1[@"hash_5558B67A321D1120"],
				status = f78_local3,
				statusValue = f78_local4
			} )
		end
		Lobby.Process.TransferDataFromClientModuleToHostModule()
		Lobby.MatchmakingAsync.OnLobbyClientPromoteToHost( nil )
	end
	
	Engine[@"printinfo"]( Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.Process.PromoteClientToGameLobbyHost: menuId(" .. f78_local0 .. "), lobbyType(" .. f78_local2 .. "), mainMode(" .. f78_arg1 .. "), lobbyTimerType(" .. f78_local1[@"hash_5558B67A321D1120"] .. ").\n" )
	local f78_local6 = Lobby.Actions.PromoteToHostDone( f78_arg0, f78_local2, f78_arg8, f78_arg7 )
	local f78_local7 = Lobby.Actions.LobbyHostStartMigratedInfo( f78_arg0, f78_arg1, f78_local2, f78_arg3, f78_arg4, f78_arg10, f78_arg9, f78_arg5 )
	local f78_local8 = Lobby.Actions.ExecuteScript( f78_local5 )
	local f78_local9 = Lobby.Actions.AdvertiseLobby( true )
	local f78_local10 = Lobby.Actions.LobbySettings( f78_arg0, f78_local1 )
	local f78_local11 = Lobby.Actions.RunPlaylistSettings( f78_arg0 )
	local f78_local12 = {
		head = f78_local6,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	if Engine[@"islobbyhost"]( f78_local2 ) == false then
		f78_local12.head = f78_local7
		Lobby.Process.AddActions( f78_local7, f78_local6 )
		Lobby.Process.AddActions( f78_local6, f78_local8 )
		if f78_local1[@"isadvertised"] == true then
			Lobby.Process.AddActions( f78_local8, f78_local9 )
			if f78_arg7 == false then
				Lobby.Process.AddActions( f78_local9, f78_local10 )
			end
		end
	end
	return f78_local12
end
Lobby.Process.PromoteClientToHost = function ( f80_arg0, f80_arg1, f80_arg2, f80_arg3, f80_arg4, f80_arg5, f80_arg6, f80_arg7, f80_arg8, f80_arg9, f80_arg10 )
	local f80_local0 = nil
	if f80_arg2 == Enum[@"lobbytype"][@"lobby_type_private"] then
		f80_local0 = Lobby.Process.PromoteClientToPrivateLobbyHost( f80_arg0, f80_arg1, f80_arg2, f80_arg3, f80_arg4, f80_arg5, f80_arg6, f80_arg7, f80_arg8, f80_arg9, f80_arg10 )
	elseif f80_arg2 == Enum[@"lobbytype"][@"lobby_type_game"] then
		f80_local0 = Lobby.Process.PromoteClientToGameLobbyHost( f80_arg0, f80_arg1, f80_arg2, f80_arg3, f80_arg4, f80_arg5, f80_arg6, f80_arg7, f80_arg8, f80_arg9, f80_arg10 )
	end
	return f80_local0
end
Lobby.Process.LocalClientLeave = function ( f81_arg0, f81_arg1 )
	local f81_local0 = Lobby.Actions.LobbyLocalClientLeave( Enum[@"lobbytype"][@"lobby_type_private"], f81_arg0, f81_arg1 )
	local f81_local1 = Lobby.Actions.LobbyLocalClientLeave( Enum[@"lobbytype"][@"lobby_type_game"], f81_arg0, f81_arg1 )
	local f81_local2 = {
		head = f81_local1,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false
	}
	Lobby.Process.AddActions( f81_local1, f81_local0 )
	Lobby.Process.AddActions( f81_local0 )
	return f81_local2
end
Lobby.Process.LeaveWithParty = function ( f82_arg0, f82_arg1, f82_arg2 )
	local f82_local0 = Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f82_local1 = Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"] )
	local f82_local2 = nil
	if f82_arg0 ~= Enum[@"lobbymodule"][@"lobby_module_client"] or f82_local1 == false then
		return 
	end
	local f82_local3 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f82_local4 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f82_local5 = Lobby.Actions.CloseSpinner()
	local f82_local6 = {
		head = f82_local3,
		interrupt = Lobby.Interrupt.NONE,
		force = false,
		cancellable = true
	}
	local f82_local7 = f82_local3
	if f82_local0 == true then
		Lobby.Process.ForceAction( f82_local7, f82_local4 )
		f82_local7 = f82_local4
	end
	Lobby.Process.ForceAction( f82_local7, f82_local5 )
	return f82_local6
end
Lobby.Process.ManagePartyLeave = function ( f83_arg0 )
	local f83_local0 = LobbyData.GetLobbyMenuByID( LobbyData.GetLobbyNav() )
	if f83_local0 == nil then
		error( "LobbyVM: No menu called '" .. currentMenu .. "' found." )
	end
	if Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_private"] ) == false or Engine[@"islobbyactive"]( Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"] ) == false then
		return nil
	end
	local f83_local1 = Engine[@"lobbygetgametype"]()
	local f83_local2 = Engine[@"lobbygetmap"]()
	if f83_local1 == nil or f83_local1 == "" then
		f83_local1 = LuaUtils.GetDefaultGameType( f83_local0 )
	end
	if f83_local2 == nil or f83_local2 == "" then
		f83_local2 = LuaUtils.GetDefaultMap( f83_local0 )
	end
	local f83_local3 = Engine[@"getlobbymainmode"]()
	local f83_local4 = Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_private"] ) and Enum[@"lobbymodule"][@"lobby_module_host"] or Enum[@"lobbymodule"][@"lobby_module_client"]
	local f83_local5 = Engine[@"getlobbymode"]( f83_local4, Enum[@"lobbytype"][@"lobby_type_private"] )
	local f83_local6 = Engine[@"getlobbymaxclients"]( f83_local4, Enum[@"lobbytype"][@"lobby_type_private"] )
	local f83_local7 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f83_local8 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f83_local9 = Lobby.Actions.LobbyHostStart( f83_arg0, f83_local3, Enum[@"lobbytype"][@"lobby_type_private"], f83_local5, f83_local6, f83_local2, f83_local1 )
	local f83_local10 = Lobby.Actions.LobbyHostAddPrimary( f83_local9.lobbyType )
	local f83_local11 = Lobby.Actions.LobbyClientStart( f83_local9.lobbyType )
	local f83_local12 = {
		head = f83_local7,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f83_local7, f83_local8 )
	Lobby.Process.AddActions( f83_local8, f83_local9 )
	Lobby.Process.AddActions( f83_local9, f83_local10 )
	Lobby.Process.AddActions( f83_local10, f83_local11 )
	return f83_local12
end
Lobby.Process.NonFatalError = function ( f84_arg0 )
	local f84_local0 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	return {
		head = Lobby.Actions.ErrorPopupMsg( f84_arg0 ),
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
end
Lobby.Process.FatalError = function ( f85_arg0 )
	local f85_local0 = Engine[@"getprimarycontroller"]()
	local f85_local1 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	local f85_local2 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.MAIN )
	local f85_local3 = Lobby.Actions.OpenSpinner()
	local f85_local4 = Lobby.Actions.CloseSpinner()
	local f85_local5 = Lobby.Actions.LobbySettings( f85_local0, f85_local2 )
	local f85_local6 = Lobby.Actions.UpdateUI( f85_local0, f85_local2 )
	local f85_local7 = Lobby.Actions.ErrorPopupMsg( f85_arg0 )
	local f85_local8 = {
		head = f85_local3,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f85_local3, f85_local5 )
	Lobby.Process.AddActions( f85_local5, f85_local5 )
	Lobby.Process.AddActions( f85_local5, f85_local6 )
	Lobby.Process.AddActions( f85_local6, f85_local4 )
	Lobby.Process.AddActions( f85_local4, f85_local7 )
	return f85_local8
end
Lobby.Process.Reset = function ()
	local f86_local0 = Engine[@"getprimarycontroller"]()
	local f86_local1 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	local f86_local2 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.MAIN )
	local f86_local3 = Lobby.Actions.CloseSpinner()
	local f86_local4 = Lobby.Actions.CloseSpinner()
	local f86_local5 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f86_local6 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f86_local7 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f86_local8 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f86_local9 = Lobby.Actions.LobbySettings( f86_local0, f86_local2 )
	local f86_local10 = Lobby.Actions.UpdateUI( f86_local0, f86_local2 )
	local f86_local11 = {
		head = f86_local8,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f86_local3, f86_local8 )
	Lobby.Process.AddActions( f86_local8, f86_local7 )
	Lobby.Process.AddActions( f86_local7, f86_local6 )
	Lobby.Process.AddActions( f86_local6, f86_local5 )
	Lobby.Process.AddActions( f86_local5, f86_local9 )
	Lobby.Process.AddActions( f86_local9, f86_local10 )
	Lobby.Process.AddActions( f86_local10, f86_local4 )
	return f86_local11
end
Lobby.Process.DevmapClient = function ( f87_arg0 )
	local f87_local0 = {
		public = LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC,
		custom = LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM,
		arena = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING,
		arenaCustom = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM
	}
	local f87_local1 = Engine[@"getdvarstring"]( "devmaponline" )
	if f87_local1 == nil or f87_local1 == 0 then
		devmapOnlne = ""
	end
	local f87_local2 = LuaEnum.UI.DIRECTOR_LAN_MP
	local f87_local3 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
	if f87_local1 ~= "" then
		f87_local2 = f87_local0[f87_local1]
		f87_local3 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"]
	end
	local f87_local4 = LobbyData.GetLobbyMenuByName( f87_local2 )
	local f87_local5 = f87_local4[@"mainmode"]
	local f87_local6 = f87_local4[@"lobbytype"]
	local f87_local7 = f87_local4[@"lobbymode"]
	local f87_local8 = f87_local4[@"maxclients"]
	local f87_local9 = Lobby.Actions.LobbySettings( f87_arg0, f87_local4, nil, true )
	local f87_local10 = Lobby.Actions.SetNetworkMode( f87_arg0, f87_local3 )
	local f87_local11 = Lobby.Actions.LobbyHostStart( f87_arg0, f87_local5, f87_local6, f87_local7, f87_local8, "", "" )
	local f87_local12 = Lobby.Actions.LobbyHostAddPrimary( f87_local6 )
	local f87_local13 = Lobby.Actions.LobbyClientStart( f87_local6 )
	local f87_local14 = {
		head = f87_local9,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f87_local9, f87_local10 )
	Lobby.Process.AddActions( f87_local10, f87_local11 )
	Lobby.Process.AddActions( f87_local11, f87_local12 )
	Lobby.Process.AddActions( f87_local12, f87_local13 )
	return f87_local14
end
Lobby.Process.Devmap = function ( f88_arg0, f88_arg1, f88_arg2, f88_arg3 )
	local f88_local0 = {
		public = {
			[Enum[@"lobbymainmode"][@"lobby_mainmode_cp"]] = LuaEnum.UI.DIRECTOR_ONLINE_CP_PUBLIC,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_mp"]] = LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_zm"]] = LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_wz"]] = LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC
		},
		custom = {
			[Enum[@"lobbymainmode"][@"lobby_mainmode_cp"]] = LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_mp"]] = LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_zm"]] = LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_wz"]] = LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM
		},
		arena = {
			[Enum[@"lobbymainmode"][@"lobby_mainmode_mp"]] = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING
		},
		arenaCustom = {
			[Enum[@"lobbymainmode"][@"lobby_mainmode_mp"]] = LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM
		},
		 = {
			[Enum[@"lobbymainmode"][@"lobby_mainmode_cp"]] = LuaEnum.UI.DIRECTOR_LAN_CP,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_mp"]] = LuaEnum.UI.DIRECTOR_LAN_MP,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_zm"]] = LuaEnum.UI.DIRECTOR_LAN_ZM,
			[Enum[@"lobbymainmode"][@"lobby_mainmode_wz"]] = LuaEnum.UI.DIRECTOR_LAN_WZ
		}
	}
	local f88_local1 = Engine[@"getdvarstring"]( "devmaponline" )
	if f88_local1 == nil or f88_local1 == 0 then
		f88_local1 = ""
	end
	local f88_local2 = Lobby.Actions.ExecuteScript( function ()
		Engine[@"sendclientheartbeat"]( f88_arg0, Engine[@"lobbygetcontrollinglobbysession"]( Enum[@"lobbymodule"][@"lobby_module_client"] ) )
	end )
	local f88_local3 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
	local f88_local4 = LuaEnum.UI.DIRECTOR_LAN
	if f88_local1 ~= "" then
		f88_local4 = LuaEnum.UI.DIRECTOR_ONLINE
		f88_local3 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"]
	end
	local f88_local5 = LobbyData.GetLobbyMenuByName( f88_local4 )
	local f88_local6 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.MAIN )
	if f88_arg1 ~= Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"] then
		f88_local6 = LobbyData.GetLobbyMenuByName( f88_local0[f88_local1][f88_arg1] )
	end
	local f88_local7 = f88_local5[@"mainmode"]
	local f88_local8 = f88_local5[@"lobbytype"]
	local f88_local9 = f88_local5[@"lobbymode"]
	local f88_local10 = f88_local5[@"maxclients"]
	local f88_local11 = f88_local6[@"mainmode"]
	local f88_local12 = f88_local6[@"lobbytype"]
	local f88_local13 = f88_local6[@"lobbymode"]
	local f88_local14 = f88_local6[@"maxclients"]
	local f88_local15 = Lobby.Actions.LobbySettings( f88_arg0, f88_local6, nil, true )
	local f88_local16 = Lobby.Actions.UpdateUI( f88_arg0, f88_local6 )
	local f88_local17 = Lobby.Actions.SetNetworkMode( f88_arg0, f88_local3 )
	local f88_local18 = Lobby.Actions.LobbyHostStart( f88_arg0, f88_local7, f88_local8, f88_local9, f88_local10, f88_arg2, f88_arg3 )
	local f88_local19 = Lobby.Actions.LobbyHostAddPrimary( f88_local8 )
	local f88_local20 = Lobby.Actions.LobbyClientStart( f88_local8 )
	local f88_local21 = Lobby.Actions.LobbyHostStart( f88_arg0, f88_local11, Enum[@"lobbytype"][@"lobby_type_game"], f88_local13, f88_local14, f88_arg2, f88_arg3 )
	local f88_local22 = Lobby.Actions.LobbyHostAddPrimary( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f88_local23 = Lobby.Actions.LobbyClientStart( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f88_local24 = Lobby.Actions.SetGameAndTypeMapName( f88_arg0, Enum[@"lobbytype"][@"lobby_type_game"], f88_arg3, f88_arg2 )
	local f88_local25 = {
		head = f88_local15,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f88_local15, f88_local16 )
	Lobby.Process.AddActions( f88_local16, f88_local17 )
	Lobby.Process.AddActions( f88_local17, f88_local18 )
	Lobby.Process.AddActions( f88_local18, f88_local19 )
	Lobby.Process.AddActions( f88_local19, f88_local20 )
	Lobby.Process.AddActions( f88_local20, f88_local21 )
	Lobby.Process.AddActions( f88_local21, f88_local24 )
	Lobby.Process.AddActions( f88_local24, f88_local22 )
	if true == Dvar[@"splitscreen"]:get() and Dvar[@"splitscreen_playercount"]:get() > 1 then
		local f88_local26 = Lobby.Actions.LobbyHostAddLocal( 1, f88_local12 )
		Lobby.Process.AddActions( f88_local22, f88_local26 )
		Lobby.Process.AddActions( f88_local26, f88_local23 )
	else
		Lobby.Process.AddActions( f88_local22, f88_local23 )
	end
	Lobby.Process.AddActions( f88_local23, f88_local2 )
	return f88_local25
end
Lobby.Process.PrimaryControllerSignedIn = function ( f90_arg0 )
	local f90_local0 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	local f90_local1 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.MAIN )
	local f90_local2 = Lobby.Actions.OpenSpinner()
	local f90_local3 = Lobby.Actions.CloseSpinner()
	local f90_local4 = Lobby.Actions.LobbySettings( f90_arg0, f90_local1 )
	local f90_local5 = Lobby.Actions.UpdateUI( f90_arg0, f90_local1 )
	local f90_local6 = Lobby.Actions.SignUserInToLive( f90_arg0 )
	local f90_local7 = Lobby.Actions.ErrorPopupMsg( @"xboxlive/signedout" )
	local f90_local8 = Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f90_local9 = Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f90_local10 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f90_local11 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f90_local12 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f90_local13 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f90_local14 = {
		head = f90_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f90_local2, f90_local4 )
	Lobby.Process.AddActions( f90_local4, f90_local5 )
	Lobby.Process.AddActions( f90_local5, f90_local12 )
	Lobby.Process.AddActions( f90_local12, f90_local13 )
	Lobby.Process.AddActions( f90_local13, f90_local10 )
	Lobby.Process.AddActions( f90_local10, f90_local11 )
	Lobby.Process.AddActions( f90_local11, f90_local6 )
	Lobby.Process.AddActions( f90_local6, f90_local3 )
	Lobby.Process.AddActions( f90_local3, f90_local7 )
	return f90_local14
end
Lobby.Process.PrimaryControllerSignedOut = function ( f91_arg0 )
	local f91_local0 = LobbyData.GetLobbyMenuByID( Engine[@"getlobbyuiscreen"]() )
	local f91_local1 = LobbyData.GetLobbyMenuByName( LuaEnum.UI.MAIN )
	local f91_local2 = Lobby.Actions.OpenSpinner()
	local f91_local3 = Lobby.Actions.CloseSpinner()
	local f91_local4 = Lobby.Actions.LobbySettings( f91_arg0, f91_local1 )
	local f91_local5 = Lobby.Actions.UpdateUI( f91_arg0, f91_local1 )
	local f91_local6 = Lobby.Actions.SignUserOutOfLive( f91_arg0 )
	local f91_local7 = Lobby.Actions.ErrorPopupMsg( @"xboxlive/signedout" )
	local f91_local8 = Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f91_local9 = Engine[@"islobbyhost"]( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f91_local10 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f91_local11 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_private"] )
	local f91_local12 = Lobby.Actions.LobbyClientEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f91_local13 = Lobby.Actions.LobbyHostEnd( Enum[@"lobbytype"][@"lobby_type_game"] )
	local f91_local14 = {
		head = f91_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true
	}
	Lobby.Process.AddActions( f91_local2, f91_local4 )
	Lobby.Process.AddActions( f91_local4, f91_local5 )
	Lobby.Process.AddActions( f91_local5, f91_local12 )
	Lobby.Process.AddActions( f91_local12, f91_local13 )
	Lobby.Process.AddActions( f91_local13, f91_local10 )
	Lobby.Process.AddActions( f91_local10, f91_local11 )
	Lobby.Process.AddActions( f91_local11, f91_local6 )
	Lobby.Process.AddActions( f91_local6, f91_local3 )
	Lobby.Process.AddActions( f91_local3, f91_local7 )
	return f91_local14
end
Lobby.Process.ReAdvertiseLobby = function ( f92_arg0 )
	local f92_local0 = function ()
		Dvar[@"lobbyadvertisedirty"]:set( true )
	end
	
	local f92_local1 = Lobby.Actions.AdvertiseLobby( false )
	local f92_local2 = Lobby.Actions.AdvertiseLobby( true )
	local f92_local3 = Lobby.Actions.ExecuteScript( f92_local0 )
	local f92_local4 = {
		head = f92_local1,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false
	}
	Lobby.Process.ForceAction( f92_local1, f92_local2 )
	Lobby.Process.ForceAction( f92_local2, f92_local3 )
	return f92_local4
end
