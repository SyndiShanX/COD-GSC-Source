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
		Engine[0xF56FEF6357B5097](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x5A046D0646801][0x4787E42BE26EFCD])
	else
		Engine[0xF56FEF6357B5097](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x5A046D0646801][0x1385B1D1D72AFC1])
	end
end
Lobby.Join.OnInGameJoin = function(f5_arg0, f5_arg1)
	Lobby.Join.autoJoin.data = f5_arg0
	if f5_arg0.migrating ~= nil and f5_arg0.migrating == false and Engine[0xEA2BE00F49480D](Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2])) == true then
		if f5_arg1 == true then
			Lobby.Join.autoJoin.leaveServerImmediately = true
			return
		elseif not CoDShared.IsInTheaterLobby() then
			Engine[0x81B232D8CD69A4B]()
		end
	end
end
Lobby.Join.OnJoinableCheck = function(f6_arg0)
	local f6_local0 = f6_arg0.joinRequest
	local f6_local1 = f6_arg0.joinResponse
	local f6_local2 = LobbyData.GetCurrentMenuTarget()
	local f6_local3 = false
	if Engine[0xE39F1F30B306065]() == false and Engine[0xDFE2D4D623AD782]() == true and f6_local2[0xBF54BE1BB3D618B] == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and (f6_local2[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9] or f6_local2[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xD42D003CEEA3F87]) then
		if f6_local2[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7B50049993542C0] and Engine[0x9E5BE3B4BBA4E0E]("cpProcessingJoinCheck") then
			return Enum[0x2E4144AA1C3ABB8][0xB1C0D3E06FFEFB4]
		elseif f6_local2[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x7E41449995CD57E] and Engine[0x9E5BE3B4BBA4E0E]("mpProcessingJoinCheck") then
			return Enum[0x2E4144AA1C3ABB8][0xB1C0D3E06FFEFB4]
		elseif f6_local2[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x79D01499920B292] and Engine[0x9E5BE3B4BBA4E0E]("zmProcessingJoinCheck") then
			return Enum[0x2E4144AA1C3ABB8][0xB1C0D3E06FFEFB4]
		end
	end
	if (Engine[0x7B48C1ABFF0F764]() or Lobby.Launch.IsHostLaunching()) and not Engine[0x8BF601ABD141DF9]() then
		if not LobbyVM.CheckDLCBit(f6_local0.dlcBits, LobbyVM.GetBitsForLockedInMap()) then
			return Enum[0x2E4144AA1C3ABB8][0xB1D61382C39F8A]
		end
	elseif Engine[0x8BF601ABD141DF9]() and f6_local0.splitscreenClients ~= nil and f6_local0.splitscreenClients > 0 then
		local f6_local4 = Engine[0x3ACB99DBAD24D55](Engine[0x7B3B2B73B53EB34]())
		if f6_local4 and f6_local4.maxLocalPlayers == 1 then
			return Enum[0x2E4144AA1C3ABB8][0xA801566ABA38A11]
		end
	end
	if f6_local1.response == Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657] then
		if Engine[0x32ABAFDCA93FDF9]() then
			if LuaUtils.IsArenaMode() then
				if ((Engine[0xDBC2AD5002B261B]("pregameItemVoteEnabled") == 1) or Engine[0xDBC2AD5002B261B]("pregameDraftEnabled") == 1) and Engine[0x7B48C1ABFF0F764]() and Engine[0x8BF601ABD141DF9]() then
					return Enum[0x2E4144AA1C3ABB8][0xAA3151947FE5E10]
				elseif f6_arg0.joinRequest.splitscreenClients ~= nil and f6_arg0.joinRequest.splitscreenClients > 0 then
					return Enum[0x2E4144AA1C3ABB8][0xA801566ABA38A11]
				elseif Lobby.Timer.LobbyIsLocked() then
					return Enum[0x2E4144AA1C3ABB8][0xAA3151947FE5E10]
				elseif Engine[0xC1AA623AAF32C21]() ~= Enum[0xE8191BED9823BAB][0xECCE7392BE20418] then
					return Enum[0x2E4144AA1C3ABB8][0xAA3151947FE5E10]
				end
				local f6_local5 = Lobby.Timer.GetTimerStatus()
				if f6_local5 == Lobby.Timer.LOBBY_STATUS.POST_GAME or f6_local5 == Lobby.Timer.LOBBY_STATUS.FIND_NEW_LOBBY then
					return Enum[0x2E4144AA1C3ABB8][0xAA3151947FE5E10]
				elseif Engine[0x9E5BE3B4BBA4E0E]("probation_league_enabled") and f6_local2[0xBF54BE1BB3D618B] == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
					for f6_local9, f6_local10 in pairs(f6_local0.members) do
						if f6_local10.arenaProbation > 0 then
							return Enum[0x2E4144AA1C3ABB8][0xFC4025228C014F4]
						end
					end
				end
			elseif Engine[0x9E5BE3B4BBA4E0E]("probation_public_enabled") and f6_local2[0xBF54BE1BB3D618B] == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
				for f6_local5, f6_local6 in pairs(f6_local0.members) do
					if f6_local6.publicProbation > 0 then
						return Enum[0x2E4144AA1C3ABB8][0xFB9C91F64F55BFE]
					end
				end
			end
		elseif Engine[0x8EF5BEFA0AE50FE]() then
			local f6_local11 = false
			if Dvar[0x8CA6583B1EFAB4B]:get() then
				f6_local11 = true
			end
			if CoDShared.IsInTheaterLobby() then
				return Enum[0x2E4144AA1C3ABB8][0x761A111744279]
			elseif (Engine[0x7B48C1ABFF0F764]() or Lobby.Launch.IsHostLaunching()) and false == Lobby.Join.ZMAllowJoin then
				return Enum[0x2E4144AA1C3ABB8][0xAA3151947FE5E10]
			elseif f6_local2[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) then
				f6_local3 = true
			end
		elseif Engine[0x56B4618D857143D]() and Engine[0xE39F1F30B306065]() == false then
			if f6_local2[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9] then
				if (not Dvar[0xA546240BBE08638]:exists() or not Dvar[0xA546240BBE08638]:get()) and (Lobby.Launch.IsHostLaunching() or Engine[0x7B48C1ABFF0F764]() or not Engine[0x95D8A0296E9E574]()) then
					return Enum[0x2E4144AA1C3ABB8][0xAA3151947FE5E10]
				end
			elseif f6_local2[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] and (Lobby.Launch.IsHostLaunching() or Engine[0x7B48C1ABFF0F764]() or not Engine[0x95D8A0296E9E574]()) and false == Lobby.Join.ZMAllowJoin then
				return Enum[0x2E4144AA1C3ABB8][0xAA3151947FE5E10]
			end
		end
		if f6_arg0.joinRequest.joinType ~= Enum[0xC018C5F55467EB1][0x9707B48B88781B9] and f6_local3 == false and Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960] and (f6_local2[0xBF54BE1BB3D618B] == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] or Engine[0xE39F1F30B306065]() == true) and Lobby.MatchmakingAsync.UpdateReservation(f6_local0.members) == false then
			return Enum[0x2E4144AA1C3ABB8][0x4AFED012A3898A0]
		end
		local f6_local11 = Engine[0x80964E6C43E0C4B]()
		if Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
			if not f6_arg0.isLocalRequest then
				local f6_local4 = Lobby.Join.DoChunksAllowJoin(f6_local0, f6_local11)
				if f6_local4 ~= Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657] then
					return f6_local4
				end
			end
		elseif not f6_arg0.isLocalRequest then
			local f6_local4 = Lobby.Join.DoChunksAllowJoin(f6_local0, f6_local11)
			if f6_local4 ~= Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657] then
				return f6_local4
			end
		end
	end
	return f6_local1.response
end
Lobby.Join.DoChunksAllowJoin = function(f7_arg0, f7_arg1)
	if LuaUtils.OnlineOnlyDemo() then
		return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
	elseif f7_arg1 == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
		if not f7_arg0.chunkMP then
			return Enum[0x2E4144AA1C3ABB8][0xB89BCD557A3E9E9]
		elseif Engine[0x7D47312EBA41751]() or Engine[0xCB675CA7856DA25]() then
			return Enum[0x2E4144AA1C3ABB8][0x55F2D90CE4AFE6C]
		end
	elseif f7_arg1 == Enum[0x89C1455C5032969][0x79D01499920B292] then
		if not f7_arg0.chunkZM then
			return Enum[0x2E4144AA1C3ABB8][0xE89CBC6ED1BB751]
		elseif Engine[0x7D47312EBA41751]() or Engine[0xCB675CA7856DA25]() then
			return Enum[0x2E4144AA1C3ABB8][0x570E40878AAF9B4]
		end
	elseif f7_arg1 == Enum[0x89C1455C5032969][0x78C124999125C42] then
		return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
	end
	return Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657]
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
	if f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x5C738AF2ADFCAEF] then
		f8_local0.debug = f8_local0.debug .. "INVALID"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x26E669B1C0B3657] then
		f8_local0.debug = f8_local0.debug .. "SUCCESS"
		f8_local0.errorMsg = 0x0
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x4DBA6AD892EF9EF] then
		f8_local0.debug = f8_local0.debug .. "CONNECT_TO_HOST_START_FAILURE"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x6CE619947A746D8] then
		f8_local0.debug = f8_local0.debug .. "CONNECT_TO_HOST_FAILURE"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xAC204533B1AEB04] then
		f8_local0.debug = f8_local0.debug .. "PROBE_SEND_FAILURE"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x428F31A5F26E67E] then
		f8_local0.debug = f8_local0.debug .. "PROBE_TIMEOUT"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x8A6DC5175600785] then
		f8_local0.debug = f8_local0.debug .. "PROBE_INVALID_LOBBY"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xD1A629D9BB23A3] then
		f8_local0.debug = f8_local0.debug .. "PROBE_INVALID_INFO"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xC622483BBC09676] then
		f8_local0.debug = f8_local0.debug .. "PROBE_RESULT_INVALID"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x3E2600F087201A8] then
		f8_local0.debug = f8_local0.debug .. "INVALID_LOBBY"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x36A123C1F40222D] then
		f8_local0.debug = f8_local0.debug .. "SEND_AGREEMENT_REQUEST_FAILED"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x761A111744279] then
		f8_local0.debug = f8_local0.debug .. "JOIN_DISABLED"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xEA5F104B438C09F] then
		f8_local0.debug = f8_local0.debug .. "JOIN_ALREADY_IN_PROGRESS"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x65D30E028BCE71F] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_CLOSED"
		f8_local0.errorMsg = 0x17F8070D669C205
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x6DCFF2389FEAED5] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_INVITE_ONLY"
		f8_local0.errorMsg = 0x746755DA421AE6F
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xBC432169BFCDE7B] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_FRIENDS_ONLY"
		f8_local0.errorMsg = 0xEEAACE1B8D6A761
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x41ED29C63CD2416] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_SOLO_MODE"
		f8_local0.errorMsg = 0x4D13BB993505CC8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xE144E480B0BE31C] then
		f8_local0.debug = f8_local0.debug .. "OVER_MAX_PARTY_LIMIT"
		f8_local0.errorMsg = 0x3CDAF1F38C88A4
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x9E083F2EA9B6844] then
		f8_local0.debug = f8_local0.debug .. "NO_PARTIES"
		f8_local0.errorMsg = 0x6AD213965B12ACB
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x9BB0AFF5C451740] then
		f8_local0.debug = f8_local0.debug .. "LOBBY_FULL"
		f8_local0.errorMsg = 0xFE324A6C23AE852
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x19A37262B4933A9] then
		f8_local0.debug = f8_local0.debug .. "NETWORK_MODE_MISMATCH"
		f8_local0.errorMsg = 0xC1262984183DEAB
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x11A1F5E2557ADEE] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_PLAYLISTID"
		f8_local0.errorMsg = 0xF5E0383755610
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x1CCAC9B57144FBD] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_PLAYLIST_VERSION_TO_NEW"
		f8_local0.errorMsg = 0x4CF317BC479F1B7
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x773649B50BD4912] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_PLAYLIST_VERSION_TO_OLD"
		f8_local0.errorMsg = 0x980F57BBD5293F8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x19E20AD5BDB297A] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_PROTOCOL_VERSION"
		f8_local0.errorMsg = 0x771CDACD069D844
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x5CB957214181DDE] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_NETFIELD_CHECKSUM"
		f8_local0.errorMsg = 0xDEE524B618DC8D4
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x8B163743DD1778A] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_FFOTD_VERSION_TO_NEW"
		f8_local0.errorMsg = 0x4CF317BC479F1B7
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x7D7F7441FCFB31] then
		f8_local0.debug = f8_local0.debug .. "MISMATCH_FFOTD_VERSION_TO_OLD"
		f8_local0.errorMsg = 0x980F57BBD5293F8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xAB6992EF59C58A1] then
		f8_local0.debug = f8_local0.debug .. "MIGRATE_IN_PROGRESS"
		f8_local0.errorMsg = 0xF432240F7E9CEA7
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x4AFED012A3898A0] then
		f8_local0.debug = f8_local0.debug .. "COULD_NOT_RESERVE"
		f8_local0.errorMsg = 0x616952A261A619A
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xB4F111D99295074] then
		f8_local0.debug = f8_local0.debug .. "HANDSHAKE_WINDOW_EXPIRED"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x1004EF66060D857] then
		f8_local0.debug = f8_local0.debug .. "AGREEMENT_WINDOW_EXPIRED"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xA2983578D2BC18F] then
		f8_local0.debug = f8_local0.debug .. "NOT_JOINABLE_NOT_IDLE"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xAA3151947FE5E10] then
		f8_local0.debug = f8_local0.debug .. "NO_JOIN_IN_PROGRESS"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xD587302520D8B45] then
		f8_local0.debug = f8_local0.debug .. "GAME_PAUSED"
		f8_local0.errorMsg = 0x2FB253405B55FEB
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xB89BCD557A3E9E9] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_MP_REQUIRED"
		f8_local0.errorMsg = 0xB09CBEFC0B1F611
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xE89CBC6ED1BB751] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_ZM_REQUIRED"
		f8_local0.errorMsg = 0x52914AE3D277E49
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x2ACA535401DF93] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_CP_REQUIRED"
		f8_local0.errorMsg = 0x5D043C11FB29CAB
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x55F2D90CE4AFE6C] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_MP_REQUIRED_HOST"
		f8_local0.errorMsg = 0x587A85BD4211F74
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x570E40878AAF9B4] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_ZM_REQUIRED_HOST"
		f8_local0.errorMsg = 0xFE1FE30ED15198C
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x5FA41A325D43916] then
		f8_local0.debug = f8_local0.debug .. "CHUNK_CP_REQUIRED_HOST"
		f8_local0.errorMsg = 0x1B4E77816C8496E
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xA801566ABA38A11] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_SPLITSCREEN_NOT_ALLOWED"
		f8_local0.errorMsg = 0x10AD6C2BBB60130
	elseif Engine[0x9E5BE3B4BBA4E0E]("probation_public_enabled") and f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xFB9C91F64F55BFE] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_IN_PUBLIC_PROBATION"
		f8_local0.errorMsg = 0x269234E91BB604E
	elseif Engine[0x9E5BE3B4BBA4E0E]("probation_league_enabled") and f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xFC4025228C014F4] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_IN_ARENA_PROBATION"
		f8_local0.errorMsg = 0x204EF7E6A9E9E44
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xB1D61382C39F8A] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_BAD_DLC_BITS"
		f8_local0.errorMsg = 0x609344F0F879051
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xB1C0D3E06FFEFB4] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_VM_FAILURE_1"
		f8_local0.errorMsg = 0xEEB3FB0EE6EF9FF
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x190D2DCFDB65D5] then
		f8_local0.debug = f8_local0.debug .. "TRIAL_GAME_NO_MP"
		f8_local0.errorMsg = 0x1F2FF7102326CF9
		if Engine[0xCB675CA7856DA25]() then
			f8_local0.errorMsg = 0x23316EC64FC7A80
		end
		f8_local1 = true
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xFD8202DCFA3EF29] then
		f8_local0.debug = f8_local0.debug .. "TRIAL_GAME_NO_ZM"
		f8_local0.errorMsg = 0x1F2FF7102326CF9
		if Engine[0xCB675CA7856DA25]() then
			f8_local0.errorMsg = 0x23316EC64FC7A80
		end
		f8_local1 = true
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xFCE132DCF9B848D] then
		f8_local0.debug = f8_local0.debug .. "TRIAL_GAME_NO_WZ"
		f8_local0.errorMsg = 0x1F2FF7102326CF9
		if Engine[0xCB675CA7856DA25]() then
			f8_local0.errorMsg = 0x23316EC64FC7A80
		end
		f8_local1 = true
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x93CD441D8056B0F] then
		f8_local0.debug = f8_local0.debug .. "TRIAL_GAME_INVALID_MODE"
		f8_local0.errorMsg = 0x1F2FF7102326CF9
		if Engine[0xCB675CA7856DA25]() then
			f8_local0.errorMsg = 0x23316EC64FC7A80
		end
		f8_local1 = true
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0x3205A1909D53FDF] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_KOREANUNDERAGE_NO_ZM"
		f8_local0.errorMsg = 0xB582AE90C06D4FF
	elseif f8_arg0 == Enum[0x2E4144AA1C3ABB8][0xE1121BBA975AA40] then
		f8_local0.debug = f8_local0.debug .. "JOIN_RESULT_LIMITED_NO_ZM"
		f8_local0.errorMsg = 0x4E7A3DA0B52B973
		f8_local1 = true
	else
		f8_local0.debug = f8_local0.debug .. "UNHANDLED JOINRESULT ENUM(" .. tostring(f8_arg0) .. ")"
		f8_local0.errorMsg = 0xA26AA910A2D8FD8
	end
	return f8_local0, f8_local1
end
Lobby.Join.GetRestrictedJoinFailedMessage = function(f9_arg0, f9_arg1)
	local f9_local0 = ""
	if f9_arg0.probeResult.privateLobby.isValid == true then
		f9_local0 = f9_arg0.probeResult.privateLobby.hostName
	else
		f9_local0 = Engine[0xF9F1239CFD921FE](0xDA680012C01968D)
	end
	local f9_local1 = 0x55D96CC762EABDD
	local f9_local2 = f9_arg0.probeResult.mainMode
	if f9_local2 == Enum[0x89C1455C5032969][0x78C124999125C42] then
		f9_local1 = 0xA2DD20750465431
	elseif f9_local2 == Enum[0x89C1455C5032969][0x79D01499920B292] then
		f9_local1 = 0xB06081B8B4567F2
	end
	local f9_local3 = 0x23316EC64FC7A80
	if f9_arg1 and Engine[0xCB675CA7856DA25]() == false then
		f9_local3 = 0x1F2FF7102326CF9
	end
	return Engine[0xF9F1239CFD921FE](f9_local3, f9_local0, f9_local1)
end
Lobby.Join.GetJoinProcess = function(f10_arg0)
	local f10_local0 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	if Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		f10_local0 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
	end
	if Engine[0x86E64DD1C270046](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f10_local0, f10_arg0.xuid) then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.Join: Trying to Join lobby we are already part of\n")
		return nil
	else
		return Lobby.Process.Join(f10_arg0.controller, f10_arg0.xuid, f10_arg0.joinType, LuaEnum.LEAVE_WITH_PARTY.WITH)
	end
end
