require("x64:2f7767db3f402c")
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME, function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	local f1_local0, f1_local1 = Lobby.Anticheat.IsFeatureBanned(LuaEnum.FEATURE_BAN.LIVE_MP, false)
	if f1_local0 then
		LuaUtils.UI_ShowErrorMessageDialog(f1_arg0, f1_local1)
		return nil
	else
		return Lobby.ProcessNavigate.PrivateLobbyNavigate(f1_arg0, f1_arg1, f1_arg2, nil, f1_arg3.playlistID)
	end
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE, function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	Dvar[0x4FF45B41C6046F8]:set(f2_arg2[0xEE71E4EE12BC453])
	if LuaUtils.SkipDirectorOnlineMenu() then
		return Lobby.ProcessNavigate.LeavePrivateLobby(f2_arg0, f2_arg1, LobbyData.GetLobbyMenuByName(LuaEnum.UI.MAIN))
	else
		return Lobby.ProcessNavigate.PrivateLobbyNavigate(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	end
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC, function(f3_arg0, f3_arg1, f3_arg2)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.CreatePublicGameLobbyAsyncMatchmaking(f3_arg0, f3_arg1, f3_arg2)
	else
		return Lobby.ProcessNavigate.CreatePublicGameLobby(f3_arg0, f3_arg1, f3_arg2)
	end
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC, function(f4_arg0, f4_arg1, f4_arg2)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.CreatePublicGameLobbyAsyncMatchmaking(f4_arg0, f4_arg1, f4_arg2)
	else
		return Lobby.ProcessNavigate.CreatePublicGameLobby(f4_arg0, f4_arg1, f4_arg2)
	end
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC, LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME, function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	else
		return Lobby.ProcessNavigate.LeaveGameLobby(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
	end
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM, function(f6_arg0, f6_arg1, f6_arg2)
	Dvar[0x4FF45B41C6046F8]:set(f6_arg2[0xEE71E4EE12BC453])
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f6_arg0, f6_arg1, f6_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM, LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME, function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	Dvar[0x4FF45B41C6046F8]:set(f7_arg2[0xEE71E4EE12BC453])
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING, function(f8_arg0, f8_arg1, f8_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f8_arg0, f8_arg1, f8_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING, LuaEnum.UI.DIRECTOR_ONLINE, function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME, function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	local f10_local0, f10_local1 = Lobby.Anticheat.IsFeatureBanned(LuaEnum.FEATURE_BAN.LIVE_MP, false)
	if f10_local0 then
		LuaUtils.UI_ShowErrorMessageDialog(f10_arg0, f10_local1)
		return nil
	else
		return Lobby.ProcessNavigate.PrivateLobbyNavigate(f10_arg0, f10_arg1, f10_arg2, nil, f10_arg3.playlistID)
	end
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE, function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING, function(f12_arg0, f12_arg1, f12_arg2)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.CreatePublicGameLobbyAsyncMatchmaking(f12_arg0, f12_arg1, f12_arg2)
	else
		return Lobby.ProcessNavigate.CreatePublicGameLobby(f12_arg0, f12_arg1, f12_arg2)
	end
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME, function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	else
		return Lobby.ProcessNavigate.LeaveGameLobby(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	end
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM, function(f14_arg0, f14_arg1, f14_arg2)
	Dvar[0x4FF45B41C6046F8]:set(f14_arg2[0xEE71E4EE12BC453])
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f14_arg0, f14_arg1, f14_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM, LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME, function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
	Dvar[0x4FF45B41C6046F8]:set(f15_arg2[0xEE71E4EE12BC453])
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_ONLINE, LuaEnum.UI.DIRECTOR_ONLINE_MP_THEATER, function(f16_arg0, f16_arg1, f16_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f16_arg0, f16_arg1, f16_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_ONLINE_MP_THEATER, LuaEnum.UI.DIRECTOR_ONLINE, function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_LAN_SELECT, LuaEnum.UI.DIRECTOR_LAN_MP, function(f18_arg0, f18_arg1, f18_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f18_arg0, f18_arg1, f18_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_LAN_MP, LuaEnum.UI.DIRECTOR_LAN_SELECT, function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
	return Lobby.Process.ReloadPrivateLobby(f19_arg0, Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255], f19_arg2)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_LAN_SELECT, LuaEnum.UI.DIRECTOR_LAN_MP_TRAINING, function(f20_arg0, f20_arg1, f20_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f20_arg0, f20_arg1, f20_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_LAN_MP_TRAINING, LuaEnum.UI.DIRECTOR_LAN_SELECT, function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
end)
Lobby.Core.AddProcessForward(LuaEnum.UI.DIRECTOR_LAN_SELECT, LuaEnum.UI.DIRECTOR_LAN_MP_ARENA, function(f22_arg0, f22_arg1, f22_arg2)
	return Lobby.ProcessNavigate.PrivateLobbyNavigate(f22_arg0, f22_arg1, f22_arg2)
end)
Lobby.Core.AddProcessBack(LuaEnum.UI.DIRECTOR_LAN_MP_ARENA, LuaEnum.UI.DIRECTOR_LAN_SELECT, function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
	return Lobby.Process.ReloadPrivateLobby(f23_arg0, Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255], f23_arg2)
end)
