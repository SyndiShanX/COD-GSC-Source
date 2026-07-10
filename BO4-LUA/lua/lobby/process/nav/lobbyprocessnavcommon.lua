require("x64:2f7767db3f402c")
Lobby.Core.AddProcessForward(LuaEnum.UI.MAIN, "director", function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	return Lobby.ProcessNavigate.PressStart(f1_arg0, f1_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_LAN_SELECT, function(f2_arg0, f2_arg1, f2_arg2)
	return Lobby.ProcessNavigate.ChangeNetworkMode(f2_arg0, f2_arg1, f2_arg2)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_LAN_SELECT, LuaEnum.UI.DIRECTOR_ONLINE, function(f3_arg0, f3_arg1, f3_arg2)
	Dvar[0x4FF45B41C6046F8]:set(f3_arg2[0xEE71E4EE12BC453])
	return Lobby.ProcessNavigate.ChangeNetworkMode(f3_arg0, fromTargeet, f3_arg2)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.MAIN, LuaEnum.UI.DIRECTOR_ONLINE, function(f4_arg0, f4_arg1, f4_arg2)
	Dvar[0x4FF45B41C6046F8]:set(f4_arg2[0xEE71E4EE12BC453])
	if LuaUtils.SkipDirectorOnlineMenu() then
		local f4_local0 = Lobby.ProcessNavigate.CreatePrivateLobby(f4_arg0, f4_arg1, f4_arg2)
		Lobby.Process.AppendProcess(f4_local0, Lobby.ProcessNavigate.PrivateLobbyNavigate(f4_arg0, f4_arg2, LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME)))
		return f4_local0
	else
		return Lobby.ProcessNavigate.CreatePrivateLobby(f4_arg0, f4_arg1, f4_arg2)
	end
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.MAIN, function(f5_arg0, f5_arg1, f5_arg2)
	return Lobby.ProcessNavigate.LeavePrivateLobby(f5_arg0, f5_arg1, f5_arg2)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_THEATER, function(f6_arg0, f6_arg1, f6_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f6_arg0, f6_arg1, f6_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_THEATER, LuaEnum.UI.DIRECTOR_ONLINE, function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
end)
for f0_local6, f0_local7 in pairs(LuaUtils.LobbyMainModeData) do
	for f0_local3, f0_local4 in pairs(LuaUtils.LobbyMainModeData) do
		if f0_local6 ~= f0_local3 then
			Lobby.Core.AddProcessForward(f0_local7.OnlineCustomMenu, f0_local4.OnlineCustomMenu, function(f8_arg0, f8_arg1, f8_arg2)
				return Lobby.ProcessNavigate.PrivateLobbyNavigate(f8_arg0, f8_arg1, f8_arg2, LuaEnum.LEAVE_WITH_PARTY.WITH)
			end)
			Lobby.Core.AddProcessForward(f0_local7.LanMenu, f0_local4.LanMenu, function(f9_arg0, f9_arg1, f9_arg2)
				return Lobby.ProcessNavigate.PrivateLobbyNavigate(f9_arg0, f9_arg1, f9_arg2, LuaEnum.LEAVE_WITH_PARTY.WITH)
			end)
		end
	end
end
Lobby.Core.AddProcessForward(LuaEnum.UI.MAIN, LuaEnum.UI.DIRECTOR_LAN_SELECT, function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = Lobby.ProcessNavigate.CreatePrivateLobby(f10_arg0, f10_arg1, f10_arg2)
	Engine[0x7778612F9CB9B0D]()
	return f10_local0
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_LAN_SELECT, LuaEnum.UI.MAIN, function(f11_arg0, f11_arg1, f11_arg2)
	return Lobby.ProcessNavigate.LeavePrivateLobby(f11_arg0, f11_arg1, f11_arg2)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_LAN_SELECT, LuaEnum.UI.DIRECTOR_LAN, function(f12_arg0, f12_arg1, f12_arg2)
	return Lobby.ProcessNavigate.MoveToScreen(f12_arg0, f12_arg1, f12_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_LAN, LuaEnum.UI.DIRECTOR_LAN_SELECT, function(f13_arg0, f13_arg1, f13_arg2)
	return Lobby.ProcessNavigate.MoveToScreen(f13_arg0, f13_arg1, f13_arg2)
end)
