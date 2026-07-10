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
		if Engine[@"islobbyhost"](f2_local5.lobbyType) then
			return
		elseif Engine[@"islobbymigrateactive"](f2_local5.lobbyType) then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Ignoring stray host disconnect message\n")
			return
		end
		local f2_local6 = Enum[@"lobbymodule"][@"lobby_module_client"]
		local f2_local7 = Engine[@"getlobbymode"](f2_local5.lobbyType)
		if not Engine[@"islobbyactive"](f2_local6, f2_local5.lobbyType) then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Ignoring stray host disconnect message\n")
			return
		end
		local f2_local8 = Engine[@"getlobbyhostinfo"](f2_local6, f2_local5.lobbyType)
		if f2_local5.xuid ~= f2_local8.xuid then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Ignoring stray host disconnect message from xuid( " .. f2_local5.xuid .. " ).\n")
			return
		elseif LobbyVM.OnCanLobbyCanMigrate({
			lobbyModule = f2_local6,
			lobbyType = f2_local5.lobbyType,
			lobbyMode = f2_local7,
		}) then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Host Left Starting migrate.\n")
			if not Engine[@"isingame"]() then
				Engine[@"hash_4A81036E4141919F"](f2_local5.lobbyType, f2_local5.xuid, "Host left remove from the lobby and migrate.")
			end
		else
			LobbyVM.OnLobbyHostLeftNoMigration({
				controller = f2_local2,
				lobbyType = f2_local5.lobbyType,
				lobbyMainMode = Engine[@"getlobbymainmode"](),
				lobbyNetworkMode = Engine[@"getlobbynetworkmode"](),
				maxClients = Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]),
				isGameLobbyActive = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]),
				isPrivateHost = Engine[@"hash_7CF8B1723D782C24"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_private"]),
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
			lobbyModule = Enum[@"lobbymodule"][@"lobby_module_client"],
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
