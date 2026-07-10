require("x64:2f7767db3f402c")
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC, function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0, f1_local1 = Lobby.Anticheat.IsFeatureBanned(LuaEnum.FEATURE_BAN.LIVE_WZ, false)
	if f1_local0 then
		LuaUtils.UI_ShowErrorMessageDialog(f1_arg0, f1_local1)
		return nil
	elseif Dvar[0x4BADE8473F0165F]:get() == true then
		if Dvar[0x88535A8640704E2]:exists() == true and Dvar[0x88535A8640704E2]:get() == true then
			return Lobby.ProcessNavigate.PrivateLobbyNavigate(f1_arg0, f1_arg1, f1_arg2, nil, f1_arg3.playlistID)
		else
			return Lobby.ProcessNavigate.CreatePublicGameLobbyAsyncMatchmaking(f1_arg0, f1_arg1, f1_arg2, nil, f1_arg3.playlistID)
		end
	else
		return Lobby.ProcessNavigate.CreatePublicGameLobby(f1_arg0, f1_arg1, f1_arg2, nil, f1_arg3.playlistID)
	end
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC, LuaEnum.UI.DIRECTOR_ONLINE, function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	Dvar[0x4FF45B41C6046F8]:set(f2_arg2[0xEE71E4EE12BC453])
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	else
		return Lobby.ProcessNavigate.LeaveGameLobby(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	end
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC, LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM, function(f3_arg0, f3_arg1, f3_arg2)
	Dvar[0x4FF45B41C6046F8]:set(f3_arg2[0xEE71E4EE12BC453])
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f3_arg0, f3_arg1, f3_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM, LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC, function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	Dvar[0x4FF45B41C6046F8]:set(f4_arg2[0xEE71E4EE12BC453])
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_WZ_THEATER, function(f5_arg0, f5_arg1, f5_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f5_arg0, f5_arg1, f5_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_WZ_THEATER, LuaEnum.UI.DIRECTOR_ONLINE, function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_LAN_SELECT, LuaEnum.UI.DIRECTOR_LAN_WZ, function(f7_arg0, f7_arg1, f7_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f7_arg0, f7_arg1, f7_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_LAN_WZ, LuaEnum.UI.DIRECTOR_LAN_SELECT, function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	return Lobby.Process.ReloadPrivateLobby(f8_arg0, Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255], f8_arg2)
end)
