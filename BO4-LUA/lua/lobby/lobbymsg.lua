require("x64:53e8db3768fb02a")
LobbyMsg = {}
LobbyMsgClient = {}
LobbyMsgHost = {}
LobbyMsgClient.MsgHandlers = {}
LobbyMsgHost.MsgHandlers = {}
LobbyMsg.LuaMsgType = {
	LUA_MESSAGE_TYPE_TEST = 1,
	LUA_MESSAGE_TYPE_SERVER_REQUEST_LEAVEWITHPARTY = 2,
	LUA_MESSAGE_TYPE_LOBBY_HOST_DISCONNECT = 3,
	LUA_MESSAGE_TYPE_LOBBY_CLIENT_DISCONNECT = 4,
	LUA_MESSAGE_TYPE_LOBBY_CLIENT_LEAVEWITHPARTY = 5,
	LUA_MESSAGE_TYPE_LOBBY_CLIENT_RESET_LOADOUTS = 6,
}
LobbyMsg.PackageMessage = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
	if f1_arg0 then
		return f1_arg2(f1_arg1, f1_arg3, f1_arg4)
	else
		return false, 0
	end
end
LobbyMsg.PackageMessageCheckValue = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4)
	if f2_arg0 then
		local f2_local0, f2_local1 = f2_arg2(f2_arg1, f2_arg3, f2_arg4)
		if f2_local0 and (f2_arg4 == nil or f2_local1 == f2_arg4) then
			return f2_local0, f2_local1
		elseif f2_local0 then
			error("LobbyMsg.PackageMessageValuesMatch failed to package [" .. f2_arg3 .. "] " .. f2_arg4 .. " into message.  Value packaged == " .. retValue)
		end
	end
	return false, 0
end
LobbyMsg.OnTestHostPacket = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9, f3_arg10, f3_arg11, f3_arg12, f3_arg13)
	local f3_local0 = {}
	local f3_local1, f3_local2 = LobbyMsg.PackageMessage(true, f3_arg0, f3_arg0.packageInt32, "integer32", f3_arg1)
	f3_local0.integer32 = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessageCheckValue(f3_local1, f3_arg0, f3_arg0.packageUInt32, "uInteger32", f3_arg2)
	f3_local0.uInteger32 = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageBool, "boolean", f3_arg3)
	f3_local0.boolean = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageInt16, "short", f3_arg4)
	f3_local0.short = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageUInt16, "ushort", f3_arg5)
	f3_local0.ushort = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageInt8, "character", f3_arg6)
	f3_local0.character = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageUInt8, "uCharacter", f3_arg7)
	f3_local0.uCharacter = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageInt64, "int64", f3_arg8)
	f3_local0.int64 = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageUInt64, "uInt64", f3_arg9)
	f3_local0.uInt64 = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageFloat, "float", f3_arg10)
	f3_local0.float = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageXUID, "xuid", f3_arg11)
	f3_local0.xuid = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageString, "StringTest", f3_arg12)
	f3_local0.StringTest = f3_local2
	f3_local1, f3_local2 = LobbyMsg.PackageMessage(f3_local1, f3_arg0, f3_arg0.packageInt16, "bigToSmall", f3_arg13)
	f3_local0.testBigToSmall = f3_local2
	return f3_local1, f3_local0
end
LobbyMsg.OnTestClientPacket = function(f4_arg0)
	local f4_local0 = 0
	local f4_local1 = Engine[@"hash_1E42CF04B7DDD5DE"](LobbyMsg.EncodeToLobbyMsgType(LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_TEST), Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
	local f4_local2 = {
		integer32 = -23345,
		uInteger32 = 23345,
		boolean = true,
		short = -2436,
		ushort = 2437,
		character = -56,
		uCharacter = 132,
		int64 = Engine[@"numbertouint64"](123456792) + Engine[@"numbertouint64"](123456792),
		uInt64 = Engine[@"numbertouint64"](11121314) * Engine[@"numbertouint64"](11121314),
		float = 3.14,
		xuid = Engine[@"getxuid64"](0),
		StringTest = "Hello Host",
		testBigToSmall = Engine[@"numbertouint64"](12345),
	}
	LobbyMsg.OnTestHostPacket(f4_local1, f4_local2.integer32, f4_local2.uInteger32, f4_local2.boolean, f4_local2.short, f4_local2.ushort, f4_local2.character, f4_local2.uCharacter, f4_local2.int64, f4_local2.uInt64, f4_local2.float, f4_local2.xuid, f4_local2.StringTest, f4_local2.testBigToSmall)
	f4_local1:debugPrint()
	f4_local1:sendTo(f4_local0, Enum[@"lobbymodule"][@"hash_3F90DB2D4085A3E0"], Enum[@"netchanmsgtype_e"][@"netchan_lobbygame_unreliable"])
	f4_local1:free()
end
LobbyMsg.handleTestClientPacket = function(f5_arg0)
	local f5_local0 = f5_arg0.lobbyMsg:getLobbyMsgInfo()
	local f5_local1 = f5_arg0.lobbyMsg:getMsgStructInfo()
	local f5_local2 = f5_arg0.controller
	local f5_local3 = f5_arg0.lobbyMsg
	local f5_local4 = true
	local f5_local5 = {}
	f5_local4, f5_local5 = LobbyMsg.OnTestHostPacket(f5_local3)
	if f5_local4 then
		f5_local3:debugPrint()
	end
	return f5_local4
end
LobbyMsg.ConvertToLuaMsgType = function(f6_arg0)
	return f6_arg0 - Enum[@"msgtype"][@"hash_28D9789F91FCDB78"]
end
LobbyMsg.EncodeToLobbyMsgType = function(f7_arg0)
	return f7_arg0 + Enum[@"msgtype"][@"hash_28D9789F91FCDB78"]
end
LobbyMsg.PackageLobbyType = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0, f8_local1 = LobbyMsg.PackageMessage(f8_arg1, f8_arg0, f8_arg0.packageInt8, "lobbyType", f8_arg3)
	f8_arg2.lobbyType = f8_local1
	return f8_local0, f8_arg2
end
LobbyMsg.PackageKickLobbyLeader = function(f9_arg0, f9_arg1)
	local f9_local0 = {}
	local f9_local1, f9_local2 = LobbyMsg.PackageMessage(true, f9_arg0, f9_arg0.packageXUID, "leader", f9_arg1)
	f9_local0.xuid = f9_local2
	return f9_local1, f9_local0
end
LobbyMsg.PackageLobbyTypeAndXuid = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4)
	local f10_local0, f10_local1 = LobbyMsg.PackageLobbyType(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	f10_arg2 = f10_local1
	f10_local0, f10_local1 = LobbyMsg.PackageMessage(f10_local0, f10_arg0, f10_arg0.packageXUID, "xuid", f10_arg4)
	f10_arg2.xuid = f10_local1
	return f10_local0, f10_arg2
end
LobbyMsg.PackageLobbyDisconnect = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	local f11_local0, f11_local1 = LobbyMsg.PackageLobbyTypeAndXuid(f11_arg0, true, {}, f11_arg1, f11_arg2)
	local f11_local2 = f11_local1
	f11_local0, f11_local1 = LobbyMsg.PackageMessage(f11_local0, f11_arg0, f11_arg0.packageUInt8, "reason", f11_arg3)
	f11_local2.disconnectReason = f11_local1
	return f11_local0, f11_local2
end
LobbyMsg.PackageHostLeaveWithPary = function(f12_arg0, f12_arg1)
	local f12_local0, f12_local1 = LobbyMsg.PackageLobbyType(f12_arg0, true, {}, f12_arg1)
	return f12_local0, f12_local1
end
LobbyMsg.PackageLobbyMove = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0, f13_local1 = LobbyMsg.PackageLobbyType(f13_arg0, true, {}, f13_arg1)
	local f13_local2 = f13_local1
	f13_local0, f13_local1 = LobbyMsg.PackageMessage(f13_local0, f13_arg0, f13_arg0.packageInt8, "movelobbytype", f13_arg2)
	f13_local2.lobbyTypeMoveFrom = f13_local1
	return f13_local0, f13_local2
end
LobbyMsg.PackageLobbyMove = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0, f14_local1 = LobbyMsg.PackageLobbyType(f14_arg0, true, {}, f14_arg1)
	local f14_local2 = f14_local1
	f14_local0, f14_local1 = LobbyMsg.PackageMessage(f14_local0, f14_arg0, f14_arg0.packageInt32, "response", response)
	f14_local2.response = f14_local1
	f14_local0, f14_local1 = LobbyMsg.PackageMessage(f14_local0, f14_arg0, f14_arg0.packageString, "name", name)
	f14_local2.name = f14_local1
	f14_local0, f14_local1 = LobbyMsg.PackageMessage(f14_local0, f14_arg0, f14_arg0.packageUInt32, "serverLocation", serverLocation)
	f14_local2.serverLocation = f14_local1
	f14_local0, f14_local1 = LobbyMsg.PackageMessage(f14_local0, f14_arg0, f14_arg0.packageInt32, "networkMode", networkMode)
	f14_local2.networkMode = f14_local1
	f14_local0, f14_local1 = LobbyMsg.PackageMessage(f14_local0, f14_arg0, f14_arg0.packageInt32, "mainMode", mainMode)
	f14_local2.mainMode = f14_local1
	f14_local0, f14_local1 = LobbyMsg.PackageMessage(f14_local0, f14_arg0, f14_arg0.packageUInt64, "reservationKey", reservationKey)
	f14_local2.reservationKey = f14_local1
	return f14_local0, f14_local2
end
LobbyMsg.HandleDisconnect = function(f15_arg0)
	local f15_local0 = f15_arg0.lobbyMsg:getLobbyMsgInfo()
	local f15_local1 = f15_arg0.lobbyMsg:getMsgStructInfo()
	local f15_local2 = f15_arg0.controller
	local f15_local3 = f15_arg0.lobbyMsg
	local f15_local4, f15_local5 = LobbyMsg.PackageLobbyTypeAndXuid(msg, true, {})
end
LobbyMsg.MsgHandlers = {}
LobbyMsg.MsgHandlers[LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_TEST] = LobbyMsg.handleTestClientPacket
require("x64:599b52a1238a9d8")
require("x64:1182af24cee44ef")
function ContainsKey(f16_arg0, f16_arg1)
	return f16_arg0[f16_arg1] ~= nil
end
LobbyMsg.OnLobbyMessage = function(f17_arg0)
	local f17_local0 = f17_arg0.lobbyMsg:getLobbyMsgInfo()
	local f17_local1 = LobbyMsg.ConvertToLuaMsgType(f17_local0.msgType)
	if ContainsKey(LobbyMsg.MsgHandlers, f17_local1) then
		return LobbyMsg.MsgHandlers[f17_local1](f17_arg0)
	elseif ContainsKey(LobbyMsgClient.MsgHandlers, f17_local1) then
		return LobbyMsgClient.MsgHandlers[f17_local1](f17_arg0)
	elseif ContainsKey(LobbyMsgHost.MsgHandlers, f17_local1) then
		return LobbyMsgClient.MsgHandlers[f17_local1](f17_arg0)
	else
		assert(false)
		return false
	end
end
