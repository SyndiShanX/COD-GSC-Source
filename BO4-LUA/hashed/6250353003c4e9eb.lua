require("x64:7d626e69f39ee8a")
LobbyMsgClient.HandleServerRequestToLeaveWithParty = function(f1_arg0)
	local f1_local0 = f1_arg0.lobbyMsg:getLobbyMsgInfo()
	local f1_local1 = f1_arg0.lobbyMsg:getMsgStructInfo()
	local f1_local2 = f1_arg0.controller
	local f1_local3 = f1_arg0.lobbyMsg
	local f1_local4 = true
	local f1_local5 = {}
	f1_local4, f1_local5 = LobbyMsg.PackageKickLobbyLeader(f1_local3)
	if f1_local4 then
		local f1_local6 = LobbyData.GetCurrentMenuTarget()
		local f1_local7 = Lobby.ProcessNavigate.LeaveGameLobby(f1_local2, f1_local6, f1_local6, LuaEnum.LEAVE_WITH_PARTY.WITH)
		local f1_local8 = Lobby.ProcessNavigate.PrivateLobbyNavigate(f1_local2, f1_local6, f1_local6, LuaEnum.LEAVE_WITH_PARTY.WITH)
		local f1_local9 = f1_local7
		Lobby.Process.AppendProcess(f1_local9, f1_local8)
		Lobby.ProcessQueue.AddToQueue("LeaveDedicatedCustomLobby", f1_local9)
	end
	return f1_local4
end
LobbyMsgClient.HandleHostDisconnect = function(f2_arg0)
	local f2_local0 = f2_arg0.lobbyMsg:getLobbyMsgInfo()
	local f2_local1 = f2_arg0.lobbyMsg:getMsgStructInfo()
	local f2_local2 = f2_arg0.controller
	local f2_local3 = f2_arg0.lobbyMsg
	local f2_local4 = true
	local f2_local5 = {}
	LobbyMsg.PackageLobbyTypeAndXuid(f2_local3, f2_local4, f2_local5)
	if f2_local4 then
		if Engine[0xEA2BE00F49480D](f2_local5.lobbyType) then
			return
		elseif Engine[0x5B4EB7919738C02](f2_local5.lobbyType) then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Ignoring stray host disconnect message\n")
			return
		end
		local f2_local6 = Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
		local f2_local7 = Engine[0x17B32C04C4BE462](f2_local5.lobbyType)
		if not Engine[0x3E68E350BEFE50D](f2_local6, f2_local5.lobbyType) then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Ignoring stray host disconnect message\n")
			return
		end
		local f2_local8 = Engine[0xA33D06620AC0D6B](f2_local6, f2_local5.lobbyType)
		if f2_local5.xuid ~= f2_local8.xuid then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Ignoring stray host disconnect message from xuid( " .. f2_local5.xuid .. " ).\n")
			return
		elseif LobbyVM.OnCanLobbyCanMigrate({
			lobbyModule = f2_local6,
			lobbyType = f2_local5.lobbyType,
			lobbyMode = f2_local7,
		}) then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Host Left Starting migrate.\n")
			if not Engine[0x7B48C1ABFF0F764]() then
				Engine[0xA81036E4141919F](f2_local5.lobbyType, f2_local5.xuid, "Host left remove from the lobby and migrate.")
			end
		else
			LobbyVM.OnLobbyHostLeftNoMigration({
				controller = f2_local2,
				lobbyType = f2_local5.lobbyType,
				lobbyMainMode = Engine[0x80964E6C43E0C4B](),
				lobbyNetworkMode = Engine[0xA63E42B2FB6EC02](),
				maxClients = Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]),
				isGameLobbyActive = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]),
				isPrivateHost = Engine[0xCF8B1723D782C24](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110]),
			})
		end
	end
	return f2_local4
end
LobbyMsgClient.HandleLeaveWithPrivateHost = function(f3_arg0)
	local f3_local0 = f3_arg0.lobbyMsg:getLobbyMsgInfo()
	local f3_local1 = f3_arg0.lobbyMsg:getMsgStructInfo()
	local f3_local2 = f3_arg0.controller
	local f3_local3 = f3_arg0.lobbyMsg
	local f3_local4 = true
	local f3_local5 = {}
	f3_local4, f3_local5 = LobbyMsg.PackageHostLeaveWithPary(f3_local3)
	if f3_local4 then
		LobbyVM.OnLobbyLeaveWithParty({
			lobbyType = f3_local5.lobbyType,
			lobbyModule = Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2],
			lobbyMode = nil,
		})
	end
	return f3_local4
end
LobbyMsgClient.HandleResetLoadouts = function()
	LobbyVM.ExecuteLobbyVMRequest(LuaEnum.LOBBYVM_REQUEST.RESET_LOADOUTS)
	return true
end
LobbyMsgClient.MsgHandlers[LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_SERVER_REQUEST_LEAVEWITHPARTY] = LobbyMsgClient.HandleServerRequestToLeaveWithParty
LobbyMsgClient.MsgHandlers[LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_LOBBY_HOST_DISCONNECT] = LobbyMsgClient.HandleHostDisconnect
LobbyMsgClient.MsgHandlers[LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_LOBBY_CLIENT_LEAVEWITHPARTY] = LobbyMsgClient.HandleLeaveWithPrivateHost
LobbyMsgClient.MsgHandlers[LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_LOBBY_CLIENT_RESET_LOADOUTS] = LobbyMsgClient.HandleResetLoadouts
