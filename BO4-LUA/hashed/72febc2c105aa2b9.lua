require("x64:53e8db3768fb02a")
Lobby.Join = {}
Lobby.Join.autoJoin = {}
Lobby.Join.ZMAllowJoin = true
Lobby.Join.OnJoin = function(f1_arg0)
	local f1_local0 = Lobby.Join.GetJoinProcess(f1_arg0)
	if f1_local0 ~= nil then
		Lobby.ProcessQueue.AddToQueue("Join", f1_local0)
	end
end
Lobby.Join.OnJoinSystemlink = function(f2_arg0)
	Lobby.ProcessQueue.AddToQueue("JoinSystemLink", Lobby.Process.JoinSystemlink(f2_arg0.controller, f2_arg0.lobbyMainMode, f2_arg0.lobbyNetworkMode, f2_arg0.hostXuid, f2_arg0.hostInfo, f2_arg0.sourceLobbyType, f2_arg0.destLobbyType))
end
Lobby.Join.OnJoinComplete = function(f3_arg0) end
Lobby.Join.OnEnableJoins = function(f4_arg0)
	if f4_arg0.enable then
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"sessionstatus"][@"session_status_idle"])
	else
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"sessionstatus"][@"session_status_paused"])
	end
end
Lobby.Join.OnInGameJoin = function(f5_arg0, f5_arg1)
	Lobby.Join.autoJoin.data = f5_arg0
	if f5_arg0.migrating ~= nil and f5_arg0.migrating == false and Engine[@"islobbyhost"](Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])) == true then
		if f5_arg1 == true then
			Lobby.Join.autoJoin.leaveServerImmediately = true
			return
		elseif not CoDShared.IsInTheaterLobby() then
			Engine[@"leaveserverimmediately"]()
		end
	end
end
Lobby.Join.OnJoinableCheck = function(f6_arg0)
	local f6_local0 = f6_arg0.joinRequest
	local f6_local1 = f6_arg0.joinResponse
	local f6_local2 = LobbyData.GetCurrentMenuTarget()
	local f6_local3 = false
	if Engine[@"isdedicatedserver"]() == false and Engine[@"isprocessingjoin"]() == true and f6_local2[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_game"] and (f6_local2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_public"] or f6_local2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_arena"]) then
		if f6_local2[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_cp"] and Engine[@"getdvarbool"]("cpProcessingJoinCheck") then
			return Enum[@"joinresult"][@"join_result_vm_failure_1"]
		elseif f6_local2[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] and Engine[@"getdvarbool"]("mpProcessingJoinCheck") then
			return Enum[@"joinresult"][@"join_result_vm_failure_1"]
		elseif f6_local2[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] and Engine[@"getdvarbool"]("zmProcessingJoinCheck") then
			return Enum[@"joinresult"][@"join_result_vm_failure_1"]
		end
	end
	if (Engine[@"isingame"]() or Lobby.Launch.IsHostLaunching()) and not Engine[@"sessionmode_ispubliconlinegame"]() then
		if not LobbyVM.CheckDLCBit(f6_local0.dlcBits, LobbyVM.GetBitsForLockedInMap()) then
			return Enum[@"joinresult"][@"join_result_bad_dlc_bits"]
		end
	elseif Engine[@"sessionmode_ispubliconlinegame"]() and f6_local0.splitscreenClients ~= nil and f6_local0.splitscreenClients > 0 then
		local f6_local4 = Engine[@"getplaylistinfobyid"](Engine[@"getplaylistid"]())
		if f6_local4 and f6_local4.maxLocalPlayers == 1 then
			return Enum[@"joinresult"][@"join_result_splitscreen_not_allowed"]
		end
	end
	if f6_local1.response == Enum[@"joinresult"][@"join_result_success"] then
		if Engine[@"ismultiplayergame"]() then
			if LuaUtils.IsArenaMode() then
				if ((Engine[@"getgametypesetting"]("pregameItemVoteEnabled") == 1) or Engine[@"getgametypesetting"]("pregameDraftEnabled") == 1) and Engine[@"isingame"]() and Engine[@"sessionmode_ispubliconlinegame"]() then
					return Enum[@"joinresult"][@"join_result_no_join_in_progress"]
				elseif f6_arg0.joinRequest.splitscreenClients ~= nil and f6_arg0.joinRequest.splitscreenClients > 0 then
					return Enum[@"joinresult"][@"join_result_splitscreen_not_allowed"]
				elseif Lobby.Timer.LobbyIsLocked() then
					return Enum[@"joinresult"][@"join_result_no_join_in_progress"]
				elseif Engine[@"getlobbypregamestate"]() ~= Enum[@"lobbypregamestate"][@"lobby_pregame_state_idle"] then
					return Enum[@"joinresult"][@"join_result_no_join_in_progress"]
				end
				local f6_local5 = Lobby.Timer.GetTimerStatus()
				if f6_local5 == Lobby.Timer.LOBBY_STATUS.POST_GAME or f6_local5 == Lobby.Timer.LOBBY_STATUS.FIND_NEW_LOBBY then
					return Enum[@"joinresult"][@"join_result_no_join_in_progress"]
				elseif Engine[@"getdvarbool"]("probation_league_enabled") and f6_local2[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_game"] then
					for f6_local9, f6_local10 in pairs(f6_local0.members) do
						if f6_local10.arenaProbation > 0 then
							return Enum[@"joinresult"][@"join_result_in_arena_probation"]
						end
					end
				end
			elseif Engine[@"getdvarbool"]("probation_public_enabled") and f6_local2[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_game"] then
				for f6_local5, f6_local6 in pairs(f6_local0.members) do
					if f6_local6.publicProbation > 0 then
						return Enum[@"joinresult"][@"join_result_in_public_probation"]
					end
				end
			end
		elseif Engine[@"iszombiesgame"]() then
			local f6_local11 = false
			if Dvar[@"zm_private_rankedmatch"]:get() then
				f6_local11 = true
			end
			if CoDShared.IsInTheaterLobby() then
				return Enum[@"joinresult"][@"join_result_join_disabled"]
			elseif (Engine[@"isingame"]() or Lobby.Launch.IsHostLaunching()) and false == Lobby.Join.ZMAllowJoin then
				return Enum[@"joinresult"][@"join_result_no_join_in_progress"]
			elseif f6_local2[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) then
				f6_local3 = true
			end
		elseif Engine[@"hash_356B4618D857143D"]() and Engine[@"isdedicatedserver"]() == false then
			if f6_local2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_public"] then
				if (not Dvar[@"hash_2A546240BBE08638"]:exists() or not Dvar[@"hash_2A546240BBE08638"]:get()) and (Lobby.Launch.IsHostLaunching() or Engine[@"isingame"]() or not Engine[@"isrunninguilevel"]()) then
					return Enum[@"joinresult"][@"join_result_no_join_in_progress"]
				end
			elseif f6_local2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_custom"] and (Lobby.Launch.IsHostLaunching() or Engine[@"isingame"]() or not Engine[@"isrunninguilevel"]()) and false == Lobby.Join.ZMAllowJoin then
				return Enum[@"joinresult"][@"join_result_no_join_in_progress"]
			end
		end
		if f6_arg0.joinRequest.joinType ~= Enum[@"jointype"][@"join_type_party"] and f6_local3 == false and Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] and (f6_local2[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_game"] or Engine[@"isdedicatedserver"]() == true) and Lobby.MatchmakingAsync.UpdateReservation(f6_local0.members) == false then
			return Enum[@"joinresult"][@"join_result_could_not_reserve"]
		end
		local f6_local11 = Engine[@"getlobbymainmode"]()
		if Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
			if not f6_arg0.isLocalRequest then
				local f6_local4 = Lobby.Join.DoChunksAllowJoin(f6_local0, f6_local11)
				if f6_local4 ~= Enum[@"joinresult"][@"join_result_success"] then
					return f6_local4
				end
			end
		elseif not f6_arg0.isLocalRequest then
			local f6_local4 = Lobby.Join.DoChunksAllowJoin(f6_local0, f6_local11)
			if f6_local4 ~= Enum[@"joinresult"][@"join_result_success"] then
				return f6_local4
			end
		end
	end
	return f6_local1.response
end
Lobby.Join.DoChunksAllowJoin = function(f7_arg0, f7_arg1)
	if LuaUtils.OnlineOnlyDemo() then
		return Enum[@"joinresult"][@"join_result_success"]
	elseif f7_arg1 == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] then
		if not f7_arg0.chunkMP then
			return Enum[@"joinresult"][@"join_result_chunk_mp_required"]
		elseif Engine[@"hash_77D47312EBA41751"]() or Engine[@"hash_5CB675CA7856DA25"]() then
			return Enum[@"joinresult"][@"join_result_chunk_mp_required_host"]
		end
	elseif f7_arg1 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
		if not f7_arg0.chunkZM then
			return Enum[@"joinresult"][@"join_result_chunk_zm_required"]
		elseif Engine[@"hash_77D47312EBA41751"]() or Engine[@"hash_5CB675CA7856DA25"]() then
			return Enum[@"joinresult"][@"join_result_chunk_zm_required_host"]
		end
	elseif f7_arg1 == Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
		return Enum[@"joinresult"][@"join_result_success"]
	end
	return Enum[@"joinresult"][@"join_result_success"]
end
Lobby.Join.JoinResultToString = function(f8_arg0, f8_arg1)
	local f8_local0 = {
		debug = "",
		errorMsg = "",
	}
	if f8_arg1 == true then
		f8_local0.debug = "Enum.@JoinResult.@JOIN_RESULT_"
	end
	local f8_local1 = false
	if f8_arg0 == Enum[@"joinresult"][@"join_result_invalid"] then
		f8_local0.debug = f8_local0.debug .. "INVALID"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_success"] then
		f8_local0.debug = f8_local0.debug .. "SUCCESS"
		f8_local0.errorMsg = 0x0
	elseif f8_arg0 == Enum[@"joinresult"][@"hash_14DBA6AD892EF9EF"] then
		f8_local0.debug = f8_local0.debug .. "CONNECT_TO_HOST_START_FAILURE"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_connect_to_host_failure"] then
		f8_local0.debug = f8_local0.debug .. "CONNECT_TO_HOST_FAILURE"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_probe_send_failure"] then
		f8_local0.debug = f8_local0.debug .. "PROBE_SEND_FAILURE"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_probe_timeout"] then
		f8_local0.debug = f8_local0.debug .. "PROBE_TIMEOUT"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_probe_invalid_lobby"] then
		f8_local0.debug = f8_local0.debug .. "PROBE_INVALID_LOBBY"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_probe_invalid_info"] then
		f8_local0.debug = f8_local0.debug .. "PROBE_INVALID_INFO"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_probe_result_invalid"] then
		f8_local0.debug = f8_local0.debug .. "PROBE_RESULT_INVALID"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_invalid_lobby"] then
		f8_local0.debug = f8_local0.debug .. "INVALID_LOBBY"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_send_agreement_request_failed"] then
		f8_local0.debug = f8_local0.debug .. "SEND_AGREEMENT_REQUEST_FAILED"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_join_disabled"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_DISABLED"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_join_already_in_progress"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_ALREADY_IN_PROGRESS"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_not_joinable_closed"] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_CLOSED"
		f8_local0.errorMsg = @"hash_217F8070D669C205"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_not_joinable_invite_only"] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_INVITE_ONLY"
		f8_local0.errorMsg = @"hash_2746755DA421AE6F"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_not_joinable_friends_only"] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_FRIENDS_ONLY"
		f8_local0.errorMsg = @"hash_5EEAACE1B8D6A761"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_not_joinable_solo_mode"] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_SOLO_MODE"
		f8_local0.errorMsg = @"hash_64D13BB993505CC8"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_over_max_party_limit"] then
		f8_local0.debug = f8_local0.debug .. "OVER_MAX_PARTY_LIMIT"
		f8_local0.errorMsg = @"exe/to_many_local_players"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_no_parties"] then
		f8_local0.debug = f8_local0.debug .. "NO_PARTIES"
		f8_local0.errorMsg = @"hash_66AD213965B12ACB"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_lobby_full"] then
		f8_local0.debug = f8_local0.debug .. "LOBBY_FULL"
		f8_local0.errorMsg = @"menu/join_result_lobby_full"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_network_mode_mismatch"] then
		f8_local0.debug = f8_local0.debug .. "NETWORK_MODE_MISMATCH"
		f8_local0.errorMsg = @"menu/join_result_network_mode_mismatch"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_mismatch_playlistid"] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_PLAYLISTID"
		f8_local0.errorMsg = 0xF5E0383755610
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_mismatch_playlist_version_to_new"] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_PLAYLIST_VERSION_TO_NEW"
		f8_local0.errorMsg = @"menu/join_result_mismatch_playlist_version_to_new"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_mismatch_playlist_version_to_old"] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_PLAYLIST_VERSION_TO_OLD"
		f8_local0.errorMsg = @"menu/join_result_mismatch_playlist_version_to_old"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_mismatch_protocol_version"] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_PROTOCOL_VERSION"
		f8_local0.errorMsg = @"menu/join_result_mismatch_protocol_version"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_mismatch_netfield_checksum"] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_NETFIELD_CHECKSUM"
		f8_local0.errorMsg = @"menu/join_result_mismatch_netfield_checksum"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_mismatch_ffotd_version_to_new"] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_FFOTD_VERSION_TO_NEW"
		f8_local0.errorMsg = @"menu/join_result_mismatch_playlist_version_to_new"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_mismatch_ffotd_version_to_old"] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_FFOTD_VERSION_TO_OLD"
		f8_local0.errorMsg = @"menu/join_result_mismatch_playlist_version_to_old"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_migrate_in_progress"] then
		f8_local0.debug = f8_local0.debug .. "MIGRATE_IN_PROGRESS"
		f8_local0.errorMsg = @"menu/join_result_migrate_in_progress"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_could_not_reserve"] then
		f8_local0.debug = f8_local0.debug .. "COULD_NOT_RESERVE"
		f8_local0.errorMsg = @"menu/join_result_could_not_reserve"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_handshake_window_expired"] then
		f8_local0.debug = f8_local0.debug .. "HANDSHAKE_WINDOW_EXPIRED"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_agreement_window_expired"] then
		f8_local0.debug = f8_local0.debug .. "AGREEMENT_WINDOW_EXPIRED"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_not_joinable_not_idle"] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_NOT_IDLE"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_no_join_in_progress"] then
		f8_local0.debug = f8_local0.debug .. "NO_JOIN_IN_PROGRESS"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_game_paused"] then
		f8_local0.debug = f8_local0.debug .. "GAME_PAUSED"
		f8_local0.errorMsg = @"hash_72FB253405B55FEB"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_chunk_mp_required"] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_MP_REQUIRED"
		f8_local0.errorMsg = @"hash_B09CBEFC0B1F611"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_chunk_zm_required"] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_ZM_REQUIRED"
		f8_local0.errorMsg = @"hash_552914AE3D277E49"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_chunk_cp_required"] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_CP_REQUIRED"
		f8_local0.errorMsg = @"hash_35D043C11FB29CAB"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_chunk_mp_required_host"] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_MP_REQUIRED_HOST"
		f8_local0.errorMsg = @"hash_2587A85BD4211F74"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_chunk_zm_required_host"] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_ZM_REQUIRED_HOST"
		f8_local0.errorMsg = @"hash_7FE1FE30ED15198C"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_chunk_cp_required_host"] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_CP_REQUIRED_HOST"
		f8_local0.errorMsg = @"hash_61B4E77816C8496E"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_splitscreen_not_allowed"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_SPLITSCREEN_NOT_ALLOWED"
		f8_local0.errorMsg = @"hash_510AD6C2BBB60130"
	elseif Engine[@"getdvarbool"]("probation_public_enabled") and f8_arg0 == Enum[@"joinresult"][@"join_result_in_public_probation"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_IN_PUBLIC_PROBATION"
		f8_local0.errorMsg = @"hash_1269234E91BB604E"
	elseif Engine[@"getdvarbool"]("probation_league_enabled") and f8_arg0 == Enum[@"joinresult"][@"join_result_in_arena_probation"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_IN_ARENA_PROBATION"
		f8_local0.errorMsg = @"hash_204EF7E6A9E9E44"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_bad_dlc_bits"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_BAD_DLC_BITS"
		f8_local0.errorMsg = @"platform/missingmap"
	elseif f8_arg0 == Enum[@"joinresult"][@"join_result_vm_failure_1"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_VM_FAILURE_1"
		f8_local0.errorMsg = @"hash_7EEB3FB0EE6EF9FF"
	elseif f8_arg0 == Enum[@"joinresult"][0x190D2DCFDB65D5] then
		f8_local0.debug = f8_local0.debug .. "TRIAL_GAME_NO_MP"
		f8_local0.errorMsg = @"hash_1F2FF7102326CF9"
		if Engine[@"hash_5CB675CA7856DA25"]() then
			f8_local0.errorMsg = @"hash_523316EC64FC7A80"
		end
		f8_local1 = true
	elseif f8_arg0 == Enum[@"joinresult"][@"hash_6FD8202DCFA3EF29"] then
		f8_local0.debug = f8_local0.debug .. "TRIAL_GAME_NO_ZM"
		f8_local0.errorMsg = @"hash_1F2FF7102326CF9"
		if Engine[@"hash_5CB675CA7856DA25"]() then
			f8_local0.errorMsg = @"hash_523316EC64FC7A80"
		end
		f8_local1 = true
	elseif f8_arg0 == Enum[@"joinresult"][@"hash_6FCE132DCF9B848D"] then
		f8_local0.debug = f8_local0.debug .. "TRIAL_GAME_NO_WZ"
		f8_local0.errorMsg = @"hash_1F2FF7102326CF9"
		if Engine[@"hash_5CB675CA7856DA25"]() then
			f8_local0.errorMsg = @"hash_523316EC64FC7A80"
		end
		f8_local1 = true
	elseif f8_arg0 == Enum[@"joinresult"][@"hash_293CD441D8056B0F"] then
		f8_local0.debug = f8_local0.debug .. "TRIAL_GAME_INVALID_MODE"
		f8_local0.errorMsg = @"hash_1F2FF7102326CF9"
		if Engine[@"hash_5CB675CA7856DA25"]() then
			f8_local0.errorMsg = @"hash_523316EC64FC7A80"
		end
		f8_local1 = true
	elseif f8_arg0 == Enum[@"joinresult"][@"hash_53205A1909D53FDF"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_KOREANUNDERAGE_NO_ZM"
		f8_local0.errorMsg = @"menu/korea_15plus_blocked_gamemode"
	elseif f8_arg0 == Enum[@"joinresult"][@"hash_3E1121BBA975AA40"] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_LIMITED_NO_ZM"
		f8_local0.errorMsg = @"hash_14E7A3DA0B52B973"
		f8_local1 = true
	else
		f8_local0.debug = f8_local0.debug .. "UNHANDLED JOINRESULT ENUM(" .. tostring(f8_arg0) .. ")"
		f8_local0.errorMsg = @"menu/join_result_not_joinable"
	end
	return f8_local0, f8_local1
end
Lobby.Join.GetRestrictedJoinFailedMessage = function(f9_arg0, f9_arg1)
	local f9_local0 = ""
	if f9_arg0.probeResult.privateLobby.isValid == true then
		f9_local0 = f9_arg0.probeResult.privateLobby.hostName
	else
		f9_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/lobby")
	end
	local f9_local1 = @"menu/multiplayer"
	local f9_local2 = f9_arg0.probeResult.mainMode
	if f9_local2 == Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
		f9_local1 = @"menu/warzone"
	elseif f9_local2 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
		f9_local1 = @"menu/zombies"
	end
	local f9_local3 = @"hash_523316EC64FC7A80"
	if f9_arg1 and Engine[@"hash_5CB675CA7856DA25"]() == false then
		f9_local3 = @"hash_1F2FF7102326CF9"
	end
	return Engine[@"hash_4F9F1239CFD921FE"](f9_local3, f9_local0, f9_local1)
end
Lobby.Join.GetJoinProcess = function(f10_arg0)
	local f10_local0 = Enum[@"lobbytype"][@"lobby_type_private"]
	if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		f10_local0 = Enum[@"lobbytype"][@"lobby_type_game"]
	end
	if Engine[@"hash_686E64DD1C270046"](Enum[@"lobbymodule"][@"lobby_module_client"], f10_local0, f10_arg0.xuid) then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.Join: Trying to Join lobby we are already part of\n")
		return nil
	else
		return Lobby.Process.Join(f10_arg0.controller, f10_arg0.xuid, f10_arg0.joinType, LuaEnum.LEAVE_WITH_PARTY.WITH)
	end
end
