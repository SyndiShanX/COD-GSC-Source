require("x64:7d626e69f39ee8a")
LobbyMsgHost.HandleClientDisconnect = function(f1_arg0)
	local f1_local0 = f1_arg0.lobbyMsg:getLobbyMsgInfo()
	local f1_local1 = f1_arg0.lobbyMsg:getMsgStructInfo()
	local f1_local2 = f1_arg0.controller
	local f1_local3 = f1_arg0.lobbyMsg
	local f1_local4 = true
	local f1_local5 = {}
	LobbyMsg.PackageLobbyTypeAndXuid(f1_local3, f1_local4, f1_local5)
	if f1_local4 then
		Engine[@"hash_5D5BFDFD805494DF"](f1_local5.lobbyType, f1_local5.xuid)
	end
end
LobbyMsgHost.MsgHandlers[LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_LOBBY_CLIENT_DISCONNECT] = LobbyMsgHost.HandleClientDisconnect
