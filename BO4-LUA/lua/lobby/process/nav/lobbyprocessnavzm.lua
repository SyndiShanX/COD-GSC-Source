require("x64:2f7767db3f402c")
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0, f1_local1 = Lobby.Anticheat.IsFeatureBanned(LuaEnum.FEATURE_BAN.LIVE_ZM, false)
	if f1_local0 then
		LuaUtils.UI_ShowErrorMessageDialog(f1_arg0, f1_local1)
		return nil
	else
		return Lobby.ProcessNavigate.PrivateLobbyNavigate(f1_arg0, f1_arg1, f1_arg2, nil, f1_arg3.playlistID)
	end
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE, function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC, function(f3_arg0, f3_arg1, f3_arg2)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.CreatePublicGameLobbyAsyncMatchmaking(f3_arg0, f3_arg1, f3_arg2)
	else
		return Lobby.ProcessNavigate.CreatePublicGameLobby(f3_arg0, f3_arg1, f3_arg2)
	end
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC, function(f4_arg0, f4_arg1, f4_arg2)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.CreatePublicGameLobbyAsyncMatchmaking(f4_arg0, f4_arg1, f4_arg2)
	else
		return Lobby.ProcessNavigate.CreatePublicGameLobby(f4_arg0, f4_arg1, f4_arg2)
	end
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC, LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	else
		return Lobby.ProcessNavigate.LeaveGameLobby(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	end
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE, function(f6_arg0, f6_arg1, f6_arg2)
	return Lobby.ProcessNavigate.CreateGameLobbyNONMatchmaking(f6_arg0, f6_arg1, f6_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE, LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	return Lobby.ProcessNavigate.LeaveGameLobby(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM, function(f8_arg0, f8_arg1, f8_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f8_arg0, f8_arg1, f8_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM, LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE_ZM_THEATER, function(f10_arg0, f10_arg1, f10_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f10_arg0, f10_arg1, f10_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_ZM_THEATER, LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME, function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_LAN_SELECT, LuaEnum.UI.DIRECTOR_LAN_ZM, function(f12_arg0, f12_arg1, f12_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f12_arg0, f12_arg1, f12_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_LAN_ZM, LuaEnum.UI.DIRECTOR_LAN_SELECT, function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	return Lobby.Process.ReloadPrivateLobby(f13_arg0, Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255], f13_arg2)
end)
