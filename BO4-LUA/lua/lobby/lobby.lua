require("x64:53e8db3768fb02a")
require("x64:3050b56bc941c17")
require("x64:2f7767db3f402c")
require("x64:d0f84a2d7d94ca3")
require("x64:c6e3b538b3d95e3")
require("x64:4739393d6e4e043")
require("x64:aed888d0a6bbffc")
require("x64:ba4b39ed33f09b0")
require("x64:7036950a4f907a2")
require("x64:4b27017ec234a36")
require("x64:3d34eb545cb19f0")
require("x64:244a02989d808e7")
require("x64:b9e7c1be01567c1")
require("x64:fc364981803c3de")
require("x64:8034b632ce7f3e4")
require("x64:e80204599f61b79")
require("x64:194da1d58ee8f6f")
require("x64:88771219179e0e9")
require("x64:74d045268eb6203")
require("x64:d867300e0099eca")
require("x64:17b22ee799f2944")
require("x64:2bca0018d3f2c72")
require("x64:850554c32434c0a")
require("x64:9ca30b1e5f0be4d")
require("x64:4008652535479aa")
require("x64:5d438e4dddc68ba")
require("x64:a8265d32314332c")
require("x64:7d626e69f39ee8a")
require("x64:fce63782cae60aa")
require("x64:6a78baa6dfb003")
require("x64:5594baa6cd838d")
require("x64:1577baa6976e51")
require("x64:5ea582aa359cb8a")
require("x64:1306e43680ab7c")
require("x64:b56af127bf10bec")
require("x64:1ebaf79ed592662")
LobbyVM = {
	DevGui = {},
	lobbyStatus = {
		cleared = true,
		clearedTime = 0,
	},
	playSoundHistory = {},
}
LobbyVM.DevGui.LaunchGame = function(f1_arg0, f1_arg1)
	local f1_local0 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])
	if f1_arg0 ~= nil then
		Engine[0x9DB4788AE93C72D](f1_local0, f1_arg0)
	end
	if f1_arg1 ~= nil then
		Engine[0x1673E80DCB5CEA3](f1_local0, f1_arg1)
	end
	if not Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f1_local0) then
		return
	elseif not Engine[0xEA2BE00F49480D](f1_local0) then
		return
	else
		Lobby.Timer.Clear(true)
		LobbyVM.LaunchGameExec(Engine[0xA5B9C0111291A8B](), f1_local0)
	end
end
LobbyVM.DevGui.LobbyReset = function()
	LobbyVM.OnErrorShutdown({
		controller = Engine[0xA5B9C0111291A8B](),
		signoutUsers = false,
	})
end
LobbyVM.PlaySound = function(f3_arg0, f3_arg1)
	local f3_local0 = false
	if LobbyVM.playSoundHistory[f3_arg0] == nil then
		f3_local0 = true
	elseif LobbyVM.playSoundHistory[f3_arg0] < Engine[0x9D33D652B9B0F3B]() then
		f3_local0 = true
	end
	if f3_local0 == true then
		Engine[0xC4146BA76D0F982](f3_arg0)
		LobbyVM.playSoundHistory[f3_arg0] = Engine[0x9D33D652B9B0F3B]() + f3_arg1
	end
end
LobbyVM.ExecuteLobbyVMRequest = function(f4_arg0)
	local f4_local0 = Engine[0x8DF2E5447F384B9]()
	f4_local0 = f4_local0:create("lobbyRoot.lobbyVMRequest")
	if not f4_local0:set(f4_arg0) then
		f4_local0:forceNotifySubscriptions()
	end
end
LobbyVM.ExecuteLobbyVMCreateOverlay = function(f5_arg0, f5_arg1)
	local f5_local0 = Engine[0x8DF2E5447F384B9]()
	f5_local0 = f5_local0:create("lobbyRoot.lobbyVMCreateOverlayController")
	f5_local0:set(f5_arg0)
	f5_local0 = Engine[0x8DF2E5447F384B9]()
	f5_local0 = f5_local0:create("lobbyRoot.lobbyVMCreateOverlay")
	if not f5_local0:set(f5_arg1) then
		f5_local0:forceNotifySubscriptions()
	end
end
LobbyVM.ExecuteLobbyVMOpenSurvey = function(f6_arg0)
	local f6_local0 = Engine[0x8DF2E5447F384B9]()
	f6_local0 = f6_local0:create("lobbyRoot.lobbyVMOpenIntroSurvey")
	if not f6_local0:set(f6_arg0) then
		f6_local0:forceNotifySubscriptions()
	end
end
LobbyVM.OnErrorShutdown = function(f7_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Performing emergency shutdown.\n")
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Close all popups in the lobby.\n")
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.closePopups"))
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Shutting down joins.\n")
	Engine[0xA6B364A77D75A61]()
	if Engine[0xFBA11FA8773D18B] then
		Engine[0xFBA11FA8773D18B]()
	end
	if Engine[0x14185945116E1D4] then
		Engine[0x14185945116E1D4]()
	end
	if Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960] then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Shutting down qos probes.\n")
		Engine[0x3E0045B2BFBC092](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Shutting down advertisement.\n")
		Engine[0x3D86AB10C408002](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Shutting down search.\n")
		Engine[0xFEFD627D17150A9]()
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Shutting down private lobby.\n")
	Engine[0x7F81D0ECC617424](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	Engine[0x438E23E9BD0A11F](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Shutting down game lobby.\n")
	Engine[0x7F81D0ECC617424](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	Engine[0x438E23E9BD0A11F](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Clearing process queue.\n")
	Lobby.ProcessQueue.ErrorShutdown()
	if f7_arg0.signoutUsers ~= nil and f7_arg0.signoutUsers == true then
		for f7_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
			LobbyVM.OnDWDisconnect({
				controller = f7_local0,
			})
		end
		Engine[0xBCE638C29483CC1]()
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Forcing UI screen.\n")
	Engine[0xBFFECE7B49BC12](LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN))
	Engine[0xE1789115A2356E7]("open_main", {})
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby emergency shutdown complete.\n")
end
LobbyVM.ErrorShutdownMessage = function(f8_arg0, f8_arg1)
	LobbyVM.OnErrorShutdown({
		controller = f8_arg0,
		signoutUsers = false,
	})
	LuaUtils.UI_ShowErrorMessageDialog(f8_arg0, f8_arg1)
end
LobbyVM.LogGlobalData = function()
	local f9_local0 = Engine[0xDE279ECDDDD966]
	local f9_local1 = Engine[0xA5B9C0111291A8B]()
	local f9_local2 = 0x9E4136B4110C280
	local f9_local3 = {
		[0xB001CCB4B4A6BD0] = Engine[0xB15BEE2BE53060A](),
		[0x514AE50C5450622] = Engine[0xBDC89A97B6CE16D](),
		ffotd_version = Engine[0xBB208CB2EB85904](),
	}
	local f9_local4 = Engine[0xB51E213813BA60B]
	local f9_local5 = Engine[0x41979A67CD7F2C2](Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	f9_local3[0xA5F320A7654324C] = f9_local4(f9_local5.ddlPath)
	f9_local4 = Engine[0xB51E213813BA60B]
	f9_local5 = Engine[0x41979A67CD7F2C2](Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA])
	f9_local3[0x445FA044E754C98] = f9_local4(f9_local5.ddlPath)
	f9_local3[0x7B625C48C3B5FCC] = Engine[0x4FFC2D5916B1682](Enum[0x612EBB6BD74ACF0][0xBABF31AFD223EE0])
	f9_local3[0x3C8D0C915904179] = Engine[0x5C1CAE2FFBA193C](Enum[0xB5C29E1F576CCA2][0xDD83FC85A90B9DE])
	f9_local3[0x503BF40BEE579B5] = Engine[0x5C1CAE2FFBA193C](Enum[0xB5C29E1F576CCA2][0xF4435CE5FA728B4])
	f9_local3[0xE9C4B410C8C673C] = Engine[0x5C1CAE2FFBA193C](Enum[0xB5C29E1F576CCA2][0x64E89CE128A661D])
	f9_local3[0xFE0F01D08734D0F] = Engine[0x5C1CAE2FFBA193C](Enum[0xB5C29E1F576CCA2][0x78E1EA4884C34D6])
	f9_local0(f9_local1, f9_local2, f9_local3)
end
LobbyVM.OnClientAdded = function(f10_arg0)
	local f10_local0 = f10_arg0.lobbyModule
	local f10_local1 = f10_arg0.lobbyType
	local f10_local2 = f10_arg0.lobbyMode
	local f10_local3 = f10_arg0.xuid
	if f10_local0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] then
		local f10_local4 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.gameClient.isHost"))
		if f10_local4 and f10_local4 ~= 0 then
			LuaUtils.ForceLobbyButtonUpdate()
		end
	end
	Lobby.Matchmaking.OnClientAdded(f10_arg0)
	Lobby.TeamSelection.OnClientAdded(f10_arg0)
	Lobby.Pregame.OnClientAdded(f10_arg0)
	Lobby.Leaderboard.OnClientAdded(f10_arg0)
	Lobby.RecentPlayers.OnClientAdded(f10_arg0)
	Engine[0x5FF8107C3C62E89](f10_local1)
	if f10_local0 == Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] and not Engine[0x41DC2CF4139D7](f10_local3) and not Engine[0x7B48C1ABFF0F764]() then
		LobbyVM.PlaySound(LobbyData.Sounds.ClientsAddedToLobby, 500)
	end
	if LuaDefine.isPS4 == true and Enum[0xC84D3E505F1444][0xE99F41098B71960] == Engine[0xA63E42B2FB6EC02]() and f10_local0 == Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] and f10_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and Engine[0x41DC2CF4139D7](f10_local3) and not Engine[0x7B48C1ABFF0F764]() then
		local f10_local4 = Engine[0x852F787399D3F90](f10_local3)
		if Engine[0x33A0182C8E1848A] ~= nil then
			Engine[0x33A0182C8E1848A](f10_local4)
		end
	end
	local f10_local4 = Engine[0x5065E759595C457](f10_local3)
	if LobbyVM.ClientsToRemove[f10_local4] then
		LobbyVM.ClientsToRemove[f10_local4] = nil
	end
	if not LobbyVM.ClientsInModule[f10_local0] then
		LobbyVM.ClientsInModule[f10_local0] = {}
	end
	LobbyVM.ClientsInModule[f10_local0][f10_local4] = true
	f10_arg0.lobbyID = Engine[0x8CB6D1C656D57EE](f10_local0, f10_local1)
	Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x84AA3CF21433C2, {
		[0xA988C5BE2B9606C] = f10_arg0.lobbyModule,
		[0x193F66F4B46350C] = f10_arg0.lobbyType,
		[0x63C8C33B4DB02C7] = f10_arg0.lobbyMode,
		[0xB5C735486FC7CCB] = f10_arg0.xuid,
	})
end
LobbyVM.OnClientRemoved = function(f11_arg0)
	local f11_local0 = f11_arg0.lobbyModule
	local f11_local1 = f11_arg0.lobbyType
	local f11_local2 = f11_arg0.lobbyMode
	local f11_local3 = f11_arg0.xuid
	if f11_local0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] then
		LuaUtils.ForceLobbyButtonUpdate()
	end
	Lobby.Timer.OnClientRemoved(f11_arg0)
	Lobby.Pregame.OnClientRemoved(f11_arg0)
	Lobby.Matchmaking.OnClientRemoved(f11_arg0)
	Engine[0x5FF8107C3C62E89](f11_local1)
	if f11_local0 == Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] and not Engine[0x41DC2CF4139D7](f11_local3) and not Engine[0x7B48C1ABFF0F764]() then
		LobbyVM.PlaySound(LobbyData.Sounds.ClientsRemovedFromLobby, 500)
	end
	f11_arg0.lobbyID = Engine[0x8CB6D1C656D57EE](f11_local0, f11_local1)
	local f11_local4 = Engine[0x5065E759595C457](f11_local3)
	if LobbyVM.ClientsInModule[f11_local0] and LobbyVM.ClientsInModule[f11_local0][f11_local4] then
		LobbyVM.ClientsInModule[f11_local0][f11_local4] = nil
	end
	local f11_local5 = false
	for f11_local9, f11_local10 in pairs(LobbyVM.ClientsInModule) do
		if f11_local10[f11_local4] then
			f11_local5 = true
			break
		end
	end
	if not f11_local5 then
		LobbyVM.ClientsToRemove[f11_local4] = true
	end
	Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x5D76FEC9A7AF604, {
		[0xA988C5BE2B9606C] = f11_arg0.lobbyModule,
		[0x193F66F4B46350C] = f11_arg0.lobbyType,
		[0x63C8C33B4DB02C7] = f11_arg0.lobbyMode,
		[0xB5C735486FC7CCB] = f11_arg0.xuid,
	})
end
LobbyVM.OnUILevelRunningChanged = function(f12_arg0)
	local f12_local0 = f12_arg0.running
	for f12_local1 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
		Engine[0x9005641B3423AB0](f12_local1, Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]))
	end
	if Engine[0xE39F1F30B306065]() and f12_local0 == true and (not Dvar[0xB852BA138B9853A]:exists() or not Dvar[0xB852BA138B9853A]:get()) then
		Lobby.Timer.SetDedicatedDelayedCMD(Lobby.Timer.LOBBY_DEDICATED_CMD.REMOVE_ALL_CLIENTS)
	end
end
LobbyVM.OnMatchChangeMap = function(f13_arg0)
	local f13_local0 = f13_arg0.lobbyModule
	local f13_local1 = f13_arg0.lobbyType
	local f13_local2 = f13_arg0.lobbyMode
	Lobby.Stats.OnMatchChangeMap(f13_arg0)
	Lobby.Matchmaking.OnMatchChangeMap(f13_arg0)
	Lobby.CharacterSelection.OnChangeMap(f13_arg0)
	local f13_local3 = Engine[0x8DF2E5447F384B9]()
	f13_local3 = f13_local3:create("lobbyRoot.selectedMapId")
	f13_local3:set(Engine[0xC53F8D38DF9042B](f13_arg0.nextMap))
	Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x393C9A4BAA822A3, {
		[0xA988C5BE2B9606C] = f13_arg0.lobbyModule,
		[0x193F66F4B46350C] = f13_arg0.lobbyType,
		[0x63C8C33B4DB02C7] = f13_arg0.lobbyMode,
		[0xF3076BC189A19FF] = f13_arg0.currentMap,
		[0xDB228AC0186F361] = f13_arg0.nextMap,
	})
end
LobbyVM.OnChangePlaylist = function(f14_arg0) end
LobbyVM.OnMatchEnd = function(f15_arg0)
	local f15_local0 = f15_arg0.lobbyModule
	local f15_local1 = f15_arg0.lobbyType
	local f15_local2 = f15_arg0.lobbyMode
	Lobby.MatchmakingAsync.OnMatchEnd(f15_arg0)
	Lobby.CP.OnMatchEnd(f15_arg0)
	Lobby.TeamSelection.OnMatchEnd(f15_arg0)
	Lobby.Timer.OnMatchEnd(f15_arg0)
	Lobby.Analytics.OnMatchEnd(f15_arg0)
	Lobby.Matchmaking.OnMatchEnd(f15_arg0)
	Lobby.Platform.OnMatchEnd(f15_arg0)
	Lobby.Debug.OnMatchEnd(f15_arg0)
	Lobby.RecentPlayers.OnMatchEnd(f15_arg0)
	Lobby.Paintjobs.OnMatchEnd(f15_arg0)
	CoDShared.UpdateQuitFlag()
	LuaUtils.SaveAfterMatchContractStats()
	LuaUtils.CycleContracts()
	LuaUtils.ResetToLastSelectedSpecialistIfNeededAfterMatch()
	LuaUtils.RefreshDoubleXPMask()
	LuaUtils.UploadAllLocalStatsBuffers()
end
LobbyVM.ShouldShowContentChangedMessage = function(f16_arg0, f16_arg1)
	if LobbyVM.CheckDLCBit(Engine[0xFD1E02C14853724](), Engine[0x943893A16399DCF](Engine[0xE67E7253CC272C9]())) then
		return true
	else
		return false
	end
end
LobbyVM.OnDisconnect = function(f17_arg0)
	local f17_local0 = f17_arg0.lobbyModule
	local f17_local1 = f17_arg0.lobbyType
	local f17_local2 = f17_arg0.lobbyMode
	local f17_local3 = f17_arg0.disconnectClientXuid
	local f17_local4 = f17_arg0.disconnectClient
	local f17_local5 = Engine[0xA5B9C0111291A8B]()
	local f17_local6 = true
	local f17_local7 = nil
	local f17_local8 = Engine[0xF9F1239CFD921FE](0xB6154C132FDA6EE)
	local f17_local9 = Lobby.Process.Recover(f17_local5)
	if f17_local4 == Enum[0x3EB01916743DF12][0xF1FF91F0B0EF524] then
	elseif f17_local4 == Enum[0x3EB01916743DF12][0x8313735094E5B68] then
	elseif f17_local4 == Enum[0x3EB01916743DF12][0x6EF5F11FAA609FC] then
		f17_local6 = false
		f17_local7 = Engine[0xF9F1239CFD921FE](0xA009F37E1567367)
		f17_local8 = Engine[0xF9F1239CFD921FE](0x22BE13738744598)
		Dvar[0xE21BBE3614F731D]:set(false)
	elseif f17_local4 == Enum[0x3EB01916743DF12][0x75E935EEE527F8B] then
		f17_local6 = false
		f17_local7 = Engine[0xF9F1239CFD921FE](0x8F4D42673CB46CD)
		f17_local8 = Engine[0xF9F1239CFD921FE](0x8188B874FA9DFE4)
		if f17_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and Engine[0x7B48C1ABFF0F764]() == true then
			f17_local9 = Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f17_local5, f17_local2, Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f17_local1))
		end
	elseif f17_local4 == Enum[0x3EB01916743DF12][0x18DF95700618225] then
		if LobbyVM.ShouldShowContentChangedMessage(f17_local5, f17_local1) then
			Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF], Engine[0xF9F1239CFD921FE](0xDDDB3A5B7CE38F1))
		else
			Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF], Engine[0xF9F1239CFD921FE](0x609344F0F879051))
		end
	elseif f17_local4 == Enum[0x3EB01916743DF12][0xCC945BAA59091A2] then
		if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) and not Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
			Lobby.ProcessQueue.AddToQueue("ReloadGameLobby", Lobby.ProcessNavigate.ReloadGameLobby(f17_local5, math.random(Engine[0x22EAAB59AA27E9B]("arena_lobbyReloadSearchDelayMin"), Engine[0x22EAAB59AA27E9B]("arena_lobbyReloadSearchDelayMax"))))
		end
		return
	elseif f17_local4 == Enum[0x3EB01916743DF12][0x49C6D6AA15230A8] then
		if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) and not Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
			local f17_local10 = LobbyData.GetCurrentMenuTarget()
			Lobby.ProcessQueue.AddToQueue("LeaveDedicatedGameLobby", Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f17_local5, f17_local10, f17_local10, LuaEnum.LEAVE_WITH_PARTY.WITH))
		end
		return
	elseif f17_local4 == Enum[0x3EB01916743DF12][0xDF49978C783A5BB] then
		f17_local6 = false
		f17_local7 = Engine[0xF9F1239CFD921FE](0x77FA7015AB6DB6F)
		f17_local8 = Engine[0xF9F1239CFD921FE](0xAE260610DD3C172)
		if f17_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and Engine[0x7B48C1ABFF0F764]() == true then
			f17_local9 = Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f17_local5, f17_local2, Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f17_local1))
		end
	elseif f17_local4 == Enum[0x3EB01916743DF12][0xB901B6DF0CD7657] then
		f17_local6 = false
		f17_local7 = Engine[0xF9F1239CFD921FE](0x8F4D42673CB46CD)
		f17_local8 = Engine[0xF9F1239CFD921FE](0xB582AE90C06D4FF)
		if f17_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and Engine[0x7B48C1ABFF0F764]() == true then
			f17_local9 = Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f17_local5, f17_local2, Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f17_local1))
		end
	elseif f17_local4 == Enum[0x3EB01916743DF12][0xA1580BBC7A114CC] then
		f17_local6 = false
		f17_local7 = Engine[0xF9F1239CFD921FE](0x8F4D42673CB46CD)
		f17_local8 = Engine[0xF9F1239CFD921FE](0xAE260610DD3C172)
		if f17_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and Engine[0x7B48C1ABFF0F764]() == true then
			f17_local9 = Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f17_local5, f17_local2, Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f17_local1))
		end
	end
	if f17_local6 == true then
		f17_local9.tail.success = Lobby.Actions.ErrorPopupMsg(f17_local8, f17_local7)
	else
		f17_local9.tail.success = Lobby.Actions.WarningPopupMsg(f17_local8, f17_local7)
	end
	Lobby.ProcessQueue.AddToQueue("DisconnectFromHost", f17_local9)
end
LobbyVM.ComErrorCodeToString = function(f18_arg0)
	if f18_arg0 == Enum[0xE4C65AA61FAEC38][0x84590C95AD33750] then
		return "ERR_NONE"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0xB4C43B6B70ED514] then
		return "ERR_FATAL"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF] then
		return "ERR_DROP"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0xBA57228C2051AF4] then
		return "ERR_FROM_STARTUP"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x5C4F621E03F9383] then
		return "ERR_SERVERDISCONNECT"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0xD4ADF57B8A14BCC] then
		return "ERR_DISCONNECT"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x9341AB8A66C1641] then
		return "ERR_SCRIPT"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x7E578636CAA34BF] then
		return "ERR_SCRIPT_DROP"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0xAEB84C253C0C157] then
		return "ERR_LOCALIZATION"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x16ACC85EDB7768C] then
		return "ERR_UI"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x75C63927410FF8C] then
		return "ERR_LUA"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x2FD312C2C06EC11] then
		return "ERR_SOFTRESTART"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92] then
		return "ERR_SOFTRESTART_KEEPDW"
	elseif f18_arg0 == Enum[0xE4C65AA61FAEC38][0x37CE91CC63B87FB] then
		return "ERR_SOFTRESTART_SILENT"
	else
		return tostring(f18_arg0)
	end
end
LobbyVM.ClientsToRemove = {}
LobbyVM.ClientsInModule = {}
LobbyVM.OnUILoad = function(f19_arg0)
	local f19_local0 = f19_arg0.frontend
	local f19_local1 = Enum[0xC0AB9543C5C440B][0x755065F5A0B7FB0]
	if f19_local0 == false then
		f19_local1 = Enum[0xC0AB9543C5C440B][0xFA6FA0C00230DEE]
	elseif false == Engine[0xE39F1F30B306065]() then
		local f19_local2 = LobbyData.GetCurrentMenuTarget()
		local f19_local3 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC)
		if f19_local2[0x8B72E07B55C3AC0] == f19_local3[0x8B72E07B55C3AC0] then
			Engine[0x41D81D6B58AAF3F](Enum[0xBF54BE1BB3D618B][0xA1647599284110], f19_local3[0xEE71E4EE12BC453])
			Engine[0x7C75E608EA39B5C](Engine[0xA5B9C0111291A8B](), "pubSemaphoreFetch 0")
		end
		local f19_local4 = 1200000
		if Dvar[0x2A58B3AE6DE7CC7]:exists() then
			f19_local4 = Dvar[0x2A58B3AE6DE7CC7]:get() * 60000
		end
		local f19_local5 = Lobby.MatchmakingAsync.GetLocalUserInfo(Engine[0xA5B9C0111291A8B]())
		if f19_local5 and f19_local5.xuid ~= LuaDefine.INVALID_XUID_X64 and f19_local4 <= Engine[0x9D33D652B9B0F3B]() - f19_local5.lastDCQoSSuccess then
			f19_local5.completedDCQoS = false
			f19_local5.hasInitiateDCQoS = false
		end
	end
	local f19_local2 = 0
	local f19_local3 = Engine[0x370E918BE7B2017]() - 1
	for f19_local4 = f19_local2, f19_local3, 1 do
		if Engine[0xF285055A1A895A1](f19_local4) then
			Engine[0x1D2E041DAB54785](f19_local4, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f19_local1)
		end
	end
	for f19_local7, f19_local8 in pairs(LobbyVM.ClientsToRemove) do
		Engine[0x8C7A8C4C5FD9892](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "LobbyClients." .. f19_local7))
	end
	LobbyVM.ClientsToRemove = {}
end
LobbyVM.TestChangeWhereIAm = function(f20_arg0)
	Engine[0x1D2E041DAB54785](0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f20_arg0.testNumber)
end
LobbyVM.OnComError = function(f21_arg0)
	Lobby.Platform.OnComError(f21_arg0)
	if f21_arg0.isInCleanup then
		LobbyVM.OnComErrorCleanup(f21_arg0)
		return
	end
	local f21_local0 = f21_arg0.controller
	local f21_local1 = f21_arg0.errorCode
	local f21_local2 = f21_arg0.errorMsg
	local f21_local3 = f21_arg0.signoutUsers
	local f21_local4 = f21_arg0.comErrorInProgress
	Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "COM ERROR - errorCode: " .. LobbyVM.ComErrorCodeToString(f21_local1) .. ", errorMsg: " .. f21_local2 .. ".\n")
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.hideMenusForGameStart"), 0)
	if f21_local1 == Enum[0xE4C65AA61FAEC38][0x2FD312C2C06EC11] or f21_local1 == Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92] or f21_local1 == Enum[0xE4C65AA61FAEC38][0x37CE91CC63B87FB] then
		return
	elseif Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960] and not Engine[0xD7913D0F914DE47](f21_local0) then
		LobbyVM.OnErrorShutdown(f21_arg0)
	end
	if f21_local1 == Enum[0xE4C65AA61FAEC38][0x16ACC85EDB7768C] or f21_local1 == Enum[0xE4C65AA61FAEC38][0xD4ADF57B8A14BCC] or f21_local1 == Enum[0xE4C65AA61FAEC38][0xB4C43B6B70ED514] or f21_local1 == Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF] or f21_local1 == Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92] or f21_local1 == Enum[0xE4C65AA61FAEC38][0x37CE91CC63B87FB] then
		return
	elseif f21_local1 == Enum[0xE4C65AA61FAEC38][0x84590C95AD33750] or f21_local1 == Enum[0xE4C65AA61FAEC38][0x75C63927410FF8C] or f21_local1 == Enum[0xE4C65AA61FAEC38][0xBA57228C2051AF4] or f21_local1 == Enum[0xE4C65AA61FAEC38][0xAEB84C253C0C157] or f21_local1 == Enum[0xE4C65AA61FAEC38][0x5C4F621E03F9383] then
		LuaUtils.UI_ShowErrorMessageDialog(f21_local0, f21_local2)
		return
	elseif f21_local1 == Enum[0xE4C65AA61FAEC38][0x9341AB8A66C1641] or f21_local1 == Enum[0xE4C65AA61FAEC38][0x7E578636CAA34BF] then
		LuaUtils.UI_ShowErrorMessageDialog(f21_local0, f21_local2)
		Lobby.ProcessQueue.AddToQueue("ErrorNonFatal", Lobby.Process.NonFatalError(f21_local2))
		return
	end
	error("LobbyVM.OnError - Unhandled COM_ERROR: " .. LobbyVM.ComErrorCodeToString(f21_local1) .. ", Message: " .. f21_local2 .. ".\n")
end
LobbyVM.ShutdownCleanupMP = function(f22_arg0) end
LobbyVM.ShutdownCleanupZM = function(f23_arg0) end
LobbyVM.ShutdownCleanupCP = function(f24_arg0) end
LobbyVM.ShutdownCleanup = function(f25_arg0)
	LobbyVM.ShutdownCleanupCP(f25_arg0)
	LobbyVM.ShutdownCleanupMP(f25_arg0)
	LobbyVM.ShutdownCleanupZM(f25_arg0)
end
LobbyVM.OnComErrorCleanup = function(f26_arg0)
	local f26_local0 = f26_arg0.controller
	local f26_local1 = f26_arg0.errorCode
	local f26_local2 = f26_arg0.errorMsg
	local f26_local3 = f26_arg0.errorShutdown
	Engine[0xB972AE22481F1]()
	if f26_local3 ~= nil and f26_local3 == true then
		LobbyVM.OnErrorShutdown(f26_arg0)
		LobbyVM.ShutdownCleanup(f26_arg0)
	end
	if f26_local1 == Enum[0xE4C65AA61FAEC38][0xB4C43B6B70ED514] then
		LuaUtils.UI_ShowErrorMessageDialog(f26_local0, f26_local2)
		local f26_local4 = Lobby.Process.Recover(f26_local0)
		if f26_local4 ~= nil then
			Lobby.ProcessQueue.AddToQueue("ErrorFatal", f26_local4)
		end
	elseif f26_local1 == Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF] then
		local f26_local4 = Lobby.Process.Recover(f26_local0)
		if f26_local4 then
			local f26_local5 = Lobby.Actions.ErrorPopupMsg(f26_local2)
			Lobby.Process.AddActions(f26_local4.tail, f26_local5, f26_local5, f26_local5)
			Lobby.ProcessQueue.AddToQueue("ERROR_DROP", f26_local4)
		else
			LuaUtils.UI_ShowErrorMessageDialog(f26_local0, f26_local2)
		end
	elseif f26_local1 == 1026 then
		Lobby.ProcessQueue.ClearQueue()
		LuaUtils.UI_ShowErrorMessageDialog(f26_local0, f26_local2)
	elseif f26_local1 == 2050 then
		if string.len(f26_local2) > 0 then
			LuaUtils.UI_ShowErrorMessageDialog(f26_local0, f26_local2)
		end
	elseif f26_local1 == 4098 and string.len(f26_local2) > 0 then
		LuaUtils.UI_ShowInfoMessageDialog(f26_local0, f26_local2)
	end
end
LobbyVM.OnPreExecFFOTD = function()
	Lobby.Platform.OnPreExecFFOTD()
	local f27_local0 = {
		controller = Engine[0xA5B9C0111291A8B](),
		signoutUsers = false,
	}
	local f27_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.FFOTDShutdown")
	Engine[0x83C9B5DE1D9371](f27_local1, true)
	LobbyVM.OnErrorShutdown(f27_local0)
	Engine[0x83C9B5DE1D9371](f27_local1, false)
end
LobbyVM.OnDWDisconnect = function(f28_arg0)
	local f28_local0 = f28_arg0.controller
	if not Engine[0xE39F1F30B306065]() then
		if f28_local0 == Engine[0xA5B9C0111291A8B]() then
			Engine[0xAD8E547671F2E86](true)
		end
		Lobby.MatchmakingAsync.LogOutLocalUserInfo(f28_local0)
	end
end
LobbyVM.OnDemoEndFinished = function(f29_arg0)
	if Lobby.Join.autoJoin.data ~= nil then
		local f29_local0 = nil
		if Lobby.Join.autoJoin.data.platform == true then
			if Lobby.Platform.PlatformSessionOrbisEnabled() then
				if Lobby.Join.autoJoin.data.playTogether == true then
					recoverProcess = Lobby.Process.Recover(controller, LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN))
					f29_local0 = Lobby.Platform.PS4ProcessPlayTogetherEvent(Lobby.Join.autoJoin.data.platformData)
				else
					f29_local0 = Lobby.Platform.InGamePlatformJoinOrbis(Lobby.Join.autoJoin.data.platformData)
				end
			elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
				f29_local0 = Lobby.Platform.InGamePlatformJoinDurango(Lobby.Join.autoJoin.data.platformData)
			end
		else
			f29_local0 = Lobby.Join.GetJoinProcess(Lobby.Join.autoJoin.data)
		end
		if f29_local0 ~= nil then
			Lobby.ProcessQueue.AddToQueue("DemoEnd", f29_local0)
		end
		Lobby.Join.autoJoin.data = nil
	end
end
LobbyVM.OnLobbyHostLeftNoMigration = function(f30_arg0)
	local f30_local0 = f30_arg0.controller
	local f30_local1 = f30_arg0.lobbyType
	local f30_local2 = f30_arg0.lobbyMainMode
	local f30_local3 = f30_arg0.lobbyNetworkMode
	local f30_local4 = f30_arg0.maxClients
	local f30_local5 = f30_arg0.isGameLobbyActive
	local f30_local6 = f30_arg0.isPrivateHost
	if not LobbyVM.CanClientLaunch(false) then
		return
	elseif Engine[0x8FCA273DF0BEF97](f30_local1) then
		return
	elseif f30_local5 == true and f30_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
		if Lobby.ProcessQueue.GetCurrentRunningProcessName() ~= "HostLeftNoMigrationGame" then
			local f30_local7 = Lobby.Process.Recover(f30_local0)
			if Engine[0x9882F293C327557]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) then
				local f30_local8 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC)
				f30_local7 = Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f30_local0, f30_local8, f30_local8, LuaEnum.LEAVE_WITH_PARTY.WITH, true)
			end
			Lobby.ProcessQueue.AddToQueue("HostLeftNoMigrationGame", f30_local7)
		end
	else
		local f30_local7 = LobbyData.GetLobbyNav()
		if f30_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and f30_local5 == false and (f30_local7 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f30_local7 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC)) then
			if Lobby.ProcessQueue.GetCurrentRunningProcessName() ~= "HostLeftNoMigrationSearch" then
				Lobby.ProcessQueue.AddToQueue("HostLeftNoMigrationSearch", Lobby.Process.Recover(f30_local0))
			end
		else
			Lobby.ProcessQueue.AddToQueue("HostLeftNoMigration", Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f30_local0, f30_local2, f30_local4))
		end
	end
	Engine[0xC4146BA76D0F982](LobbyData.Sounds.LobbyClosed)
	Engine[0xDE279ECDDDD966](f30_local0, 0x7ED422C1906DDFB, {
		[0x8B8DE5B56F6D021] = f30_arg0.controller,
		[0xA988C5BE2B9606C] = f30_arg0.lobbyModule,
		[0xA553941A735DE81] = f30_arg0.lobbyMainMode,
		[0x862D3F1B0F11978] = f30_arg0.lobbyNetworkMode,
		[0xD2D053EF8A44776] = f30_arg0.maxClients,
		[0x6B8AE8B89BF06C2] = f30_arg0.isGameLobbyActive,
		[0xB3088C31338F710] = f30_arg0.isPrivateHost,
	})
end
LobbyVM.OnLobbyHostLeftInGameMigrateFinished = function(f31_arg0)
	local f31_local0 = f31_arg0.controller
	local f31_local1 = Lobby.Process.Recover(f31_local0)
	if Lobby.Join.autoJoin.data ~= nil then
		local f31_local2 = nil
		if Lobby.Join.autoJoin.data.platform == true then
			if Lobby.Platform.PlatformSessionOrbisEnabled() then
				if Lobby.Join.autoJoin.data.playTogether == true then
					f31_local1 = Lobby.Process.Recover(f31_local0, LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN))
					f31_local2 = Lobby.Platform.PS4ProcessPlayTogetherEvent(Lobby.Join.autoJoin.data.platformData)
				else
					f31_local2 = Lobby.Platform.InGamePlatformJoinOrbis(Lobby.Join.autoJoin.data.platformData)
				end
			elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
				f31_local2 = Lobby.Platform.InGamePlatformJoinDurango(Lobby.Join.autoJoin.data.platformData)
			end
		else
			f31_local2 = Lobby.Join.GetJoinProcess(Lobby.Join.autoJoin.data)
		end
		if f31_local2 ~= nil then
			Lobby.Process.AppendProcess(f31_local1, f31_local2)
		end
		Lobby.Join.autoJoin.data = nil
	end
	Lobby.ProcessQueue.AddToQueue("LobbyHostLeft_InGameMigrateFinished", f31_local1)
	Engine[0xC4146BA76D0F982](LobbyData.Sounds.LobbyClosed)
	Engine[0xDE279ECDDDD966](f31_local0, 0xE50E3FBE0A7A1C6, {
		[0x8B8DE5B56F6D021] = f31_arg0.controller,
	})
end
LobbyVM.OnLobbyHostLeftMigrateFinished = function(f32_arg0)
	local f32_local0 = f32_arg0.controller
	local f32_local1 = f32_arg0.lobbyType
	local f32_local2 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f32_local3 = false
	local f32_local4 = LobbyData.GetCurrentMenuTarget()
	if f32_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and f32_local2 == false and (f32_local4[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f32_local4[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) or f32_local4[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING)) then
		f32_local3 = true
	end
	if f32_local3 == true then
		local f32_local5, f32_local6 = Lobby.Process.GetBackFunc(f32_local4)
		Lobby.ProcessQueue.AddToQueue("LobbyMigrationFinished", f32_local6(f32_local0, f32_local4, f32_local5, LuaEnum.LEAVE_WITH_PARTY.WITH))
	end
	if f32_local1 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
		Engine[0xE1789115A2356E7]("open_toaster_popup", {
			toastType = "new_host",
		})
	end
end
LobbyVM.OnLobbyClientLeftEvent = function(f33_arg0)
	local f33_local0 = f33_arg0.controller
	if not f33_arg0.withParty then
		local f33_local1 = LuaEnum.LEAVE_WITH_PARTY.WITHOUT
	end
	local f33_local2 = {}
	if LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) == Engine[0x9882F293C327557]() then
		local f33_local3 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC)
		f33_local2 = Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f33_local0, f33_local3, f33_local3, LuaEnum.LEAVE_WITH_PARTY.WITH, true)
	else
		f33_local2 = Lobby.Process.Recover(f33_local0)
	end
	if Lobby.Join.autoJoin.data ~= nil then
		local f33_local3 = nil
		if Lobby.Join.autoJoin.data.platform == true then
			if Lobby.Platform.PlatformSessionOrbisEnabled() then
				if Lobby.Join.autoJoin.data.playTogether == true then
					f33_local2 = Lobby.Process.Recover(f33_local0, LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE))
					f33_local3 = Lobby.Platform.PS4ProcessPlayTogetherEvent(Lobby.Join.autoJoin.data.platformData)
				else
					f33_local3 = Lobby.Platform.InGamePlatformJoinOrbis(Lobby.Join.autoJoin.data.platformData)
				end
			elseif Lobby.Platform.PlatformSessionDurangoEnabled() then
				f33_local3 = Lobby.Platform.InGamePlatformJoinDurango(Lobby.Join.autoJoin.data.platformData)
			end
		else
			f33_local3 = Lobby.Join.GetJoinProcess(Lobby.Join.autoJoin.data)
		end
		if f33_local3 ~= nil then
			Lobby.Process.AppendProcess(f33_local2, f33_local3)
		end
		Lobby.Join.autoJoin.data = nil
	end
	Lobby.ProcessQueue.AddToQueue("LobbyClientLeft", f33_local2)
end
LobbyVM.OnDevmap = function(f34_arg0)
	Lobby.ProcessQueue.AddToQueue("Devmap", Lobby.Process.Devmap(f34_arg0.controller, f34_arg0.mainMode, f34_arg0.mapname, f34_arg0.gametype))
end
LobbyVM.OnDevmapClient = function(f35_arg0)
	Lobby.ProcessQueue.AddToQueue("DevmapClient", Lobby.Process.DevmapClient(f35_arg0.controller))
end
LobbyVM.OnNetworkModeChanged = function(f36_arg0) end
LobbyVM.OnGoForward = function(f37_arg0)
	if Lobby.Launch.IsHostLaunching() then
		return
	end
	local f37_local0 = f37_arg0.controller
	local f37_local1 = f37_arg0.navToMenu
	local f37_local2 = f37_arg0.withParty
	local f37_local3 = f37_arg0.disbandParty
	local f37_local4 = LobbyData.GetLobbyMenuByID(LobbyData.GetLobbyNav())
	local f37_local5 = LobbyData.GetLobbyMenuByName(f37_local1)
	if f37_local0 == nil then
		f37_local0 = Engine[0xA5B9C0111291A8B]()
	end
	if f37_local4 == nil then
		error("LobbyVM: No menu called '" .. currentMenu .. "' found.")
	end
	if f37_local5 == nil then
		error("LobbyVM: No menu called '" .. f37_local1 .. "' found.")
	end
	local f37_local6 = Lobby.Process.GetForwardFunc(f37_local4, f37_local5)
	if f37_local6 == nil then
		error("LobbyVM: No forward process function found to move from '" .. f37_local4[0x4BCADBA8E631B86] .. "' to '" .. f37_local1 .. "'.")
	end
	local f37_local7 = f37_local6(f37_local0, f37_local4, f37_local5, f37_arg0)
	if f37_local7 ~= nil and f37_local3 == true then
		if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) == true then
			local f37_local8 = Lobby.Process.ManagePartyLeave(f37_local0)
			Lobby.Process.AppendProcess(f37_local8, f37_local7)
			Lobby.ProcessQueue.AddToQueue("GoForward from '" .. f37_local4[0x4BCADBA8E631B86] .. "' menu to '" .. f37_local5[0x4BCADBA8E631B86] .. "' menu AND ManagePartyLeave", f37_local8)
		else
			local f37_local8 = Lobby.Process.ReloadPrivateLobby(f37_local0, Engine[0xA63E42B2FB6EC02]())
			Lobby.Process.AppendProcess(f37_local8, f37_local7)
			Lobby.ProcessQueue.AddToQueue("GoForward from '" .. f37_local4[0x4BCADBA8E631B86] .. "' menu to '" .. f37_local5[0x4BCADBA8E631B86] .. "' menu AND PartyMemberLeave", f37_local8)
		end
		return
	end
	Lobby.ProcessQueue.AddToQueue("GoForward from '" .. f37_local4[0x4BCADBA8E631B86] .. "' menu to '" .. f37_local5[0x4BCADBA8E631B86] .. "' menu.", f37_local7)
end
LobbyVM.OnGoBack = function(f38_arg0)
	if Lobby.Launch.IsHostLaunching() then
		return
	end
	local f38_local0 = Engine[0xA5B9C0111291A8B]()
	local f38_local1 = f38_arg0.withParty
	local f38_local2 = LobbyData.GetLobbyMenuByID(LobbyData.GetLobbyNav())
	if f38_local2 == nil then
		error("LobbyVM: No menu called '" .. currentMenu .. "' found.")
	end
	local f38_local3, f38_local4 = Lobby.Process.GetBackFunc(f38_local2)
	if f38_local3 == nil or f38_local4 == nil then
		error("LobbyVM: No back process function found for '" .. currentMenu("'."))
	end
	Lobby.ProcessQueue.AddToQueue("GoBackFrom" .. f38_local2[0x4BCADBA8E631B86], f38_local4(f38_local0, f38_local2, f38_local3, f38_local1))
end
LobbyVM.OnManagePartyLeave = function(f39_arg0)
	if Lobby.Launch.IsHostLaunching() then
		return
	end
	local f39_local0 = f39_arg0.controller
	if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) == true then
		Lobby.ProcessQueue.AddToQueue("ManagePartyLeave", Lobby.Process.ManagePartyLeave(f39_local0))
	else
		Lobby.ProcessQueue.AddToQueue("PartyMemberLeave", Lobby.Process.ReloadPrivateLobby(f39_local0, Engine[0xA63E42B2FB6EC02]()))
	end
end
LobbyVM.OnCreateDedicatedLANLobby = function()
	local f40_local0 = LuaEnum.UI.DIRECTOR_LAN_MP
	if Dvar[0xA56A9C383009025]:exists() and Dvar[0xA56A9C383009025]:get() == "wz" then
		f40_local0 = LuaEnum.UI.DIRECTOR_LAN_WZ
	end
	Lobby.ProcessQueue.AddToQueue("CreateDedicatedLANLobby", Lobby.Process.CreateDedicatedLANLobby(0, LobbyData.GetLobbyMenuByName(f40_local0)))
end
LobbyVM.OnCreateDedicatedLobby = function(f41_arg0)
	if Dvar[0x4BADE8473F0165F]:get() == true then
		return
	else
		Lobby.ProcessQueue.AddToQueue("CreateDedicatedLobby", Lobby.Process.CreateDedicatedLobby(0, LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC)))
	end
end
LobbyVM.OnForceToMenu = function(f42_arg0)
	Lobby.ProcessQueue.AddToQueue("ForceToMenu", Lobby.Process.ForceToMenu(f42_arg0.controller, LobbyData.GetLobbyMenuByName(f42_arg0.menuName), f42_arg0.msg))
end
LobbyVM.OnLobbyClientPromoteToHost = function(f43_arg0)
	Lobby.ProcessQueue.AddToQueue("PromoteClientToHost", Lobby.Process.PromoteClientToHost(f43_arg0.controller, f43_arg0.lobbyMainMode, f43_arg0.lobbyType, f43_arg0.lobbyMode, f43_arg0.maxClients, f43_arg0.hostInfo, f43_arg0.isAdvertised, f43_arg0.isInGame, f43_arg0.newMigrateIndex, f43_arg0.gametype, f43_arg0.mapname))
end
LobbyVM.OnLobbyLeaveWithParty = function(f44_arg0)
	local f44_local0 = Lobby.Process.LeaveWithParty(f44_arg0.lobbyModule, f44_arg0.lobbyType, f44_arg0.lobbyMode)
	if f44_local0 == nil then
		return
	else
		Lobby.ProcessQueue.AddToQueue("LeaveWithParty", f44_local0)
	end
end
LobbyVM.OnCanLobbyCanMigrate = function(f45_arg0)
	local f45_local0 = f45_arg0.lobbyModule
	if f45_local0 == nil then
		f45_local0 = Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]
	end
	local f45_local1 = f45_arg0.lobbyType
	local f45_local2 = f45_arg0.lobbyMode
	if Engine[0x9E5BE3B4BBA4E0E]("lobbyMigrate_Enabled") == false or Engine[0x9E5BE3B4BBA4E0E]("lobbyMigrate_dedicatedOnly") == true or Engine[0x9E5BE3B4BBA4E0E]("lobbyMigrate_EnabledLAN") == false and Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] == Engine[0xA63E42B2FB6EC02]() then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x422418A32076161], "Cannot become host, failed lobby migrateable check\n")
		return false
	elseif f45_local1 == Enum[0xBF54BE1BB3D618B][0xBC48855DCB4BE0E] then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x422418A32076161], "Cannot become host, lobby type is LOBBY_TYPE_TRANSITION\n")
		return false
	elseif Engine[0x3E68E350BEFE50D](f45_local0, f45_local1) == false then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x422418A32076161], "Cannot become host, requested lobby is not active\n")
		return false
	else
		local f45_local3 = LobbyData.GetCurrentMenuTarget()
		if f45_local3[0x439FA113121ADC5] ~= 1 then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x422418A32076161], "Cannot become host, lobby menu does not allow migration\n")
			return false
		elseif Engine[0x8FCA273DF0BEF97](f45_local1) then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x422418A32076161], "Cannot become host, lobby is in recovery\n")
			return false
		elseif true == LuaUtils.IsArenaMode() then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x422418A32076161], "Cannot become host, migration is not allowed in arena\n")
			return false
		elseif false == Lobby.ProcessQueue.IsQueueEmpty() then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0x422418A32076161], "Cannot become host, process queue is not empty\n")
			return false
		else
			return true
		end
	end
end
LobbyVM.OnLobbyLocalClientLeave = function(f46_arg0)
	if not Lobby.ProcessQueue.IsQueueEmpty() then
		return false
	else
		local f46_local0 = Lobby.Process.LocalClientLeave(f46_arg0.controller, f46_arg0.xuid)
		if f46_local0 == nil then
			return false
		else
			Lobby.ProcessQueue.AddToQueue("LobbyLocalClientLeave", f46_local0)
			return true
		end
	end
end
LobbyVM.SetMaxLocalPlayers = function(f47_arg0)
	Dvar[0x6BAC8B42067D2C5]:set(math.min(f47_arg0[0x6D8502BDC7A4868], Engine[0x370E918BE7B2017]()))
end
LobbyVM.OnLobbySettings = function(f48_arg0)
	local f48_local0 = f48_arg0.controller
	local f48_local1 = f48_arg0.toTarget
	local f48_local2 = f48_arg0.skipSwitchMode
	local f48_local3 = f48_arg0.isDevMap
	if type(f48_local1) == "number" then
		f48_local1 = LobbyData.GetLobbyMenuByID(f48_local1)
	end
	if f48_local1 == nil then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Tried to apply settings for an invalid target.@\n")
		return
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Applying settings for menu: " .. f48_local1[0x4BCADBA8E631B86] .. ".\n")
	if not Engine[0xC3441D67206942](f48_local0) and Engine[0xCB675CA7856DA25]() and f48_local1[0xEB7DDC7F079D51B] ~= Enum[0x89C1455C5032969][0xD5FBB8D74AC6D62] and f48_local1[0xEB7DDC7F079D51B] ~= Enum[0x89C1455C5032969][0x78C124999125C42] then
		LuaUtils.SafeComError(Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92], 0x89F50A5AB4EE929)
	end
	if not Engine[0xC3441D67206942](f48_local0) and f48_local1[0xEB7DDC7F079D51B] == Enum[0x89C1455C5032969][0x79D01499920B292] then
		if Engine[0xA8FBC7AC4C3F3A6]() then
			LuaUtils.SafeComError(Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92], 0xB582AE90C06D4FF)
		elseif Engine[0x5405A6484A88367]() then
			LuaUtils.SafeComError(Enum[0xE4C65AA61FAEC38][0x7039D0A1017FE92], 0x89F50A5AB4EE929)
		end
	end
	if not f48_local2 then
		local f48_local4 = Engine[0x80964E6C43E0C4B]()
		local f48_local5 = f48_local1[0xEB7DDC7F079D51B]
		if Engine[0x60CA86E76BBABC0] then
			Engine[0x60CA86E76BBABC0](Enum[0x4317C8C4998D8DC][0xBC3515387CDAB7])
		end
		if f48_local4 ~= f48_local5 then
			Engine[0xA47E6B48AB89F8E](f48_local0, Lobby.Core.GetMainModeStr(f48_local5))
		end
	end
	if f48_local3 ~= true and f48_local1[0xF7AE5746E79F2CE] == Enum[0xF7AE5746E79F2CE][0xC8A8AE094E793A5] then
		Engine[0xB418B3A08848737]()
	end
	LobbyVM.SetMaxLocalPlayers(f48_local1)
	Engine[0xA69E412987A9A16](f48_local1[0xBF54BE1BB3D618B], f48_local1[0x8409AA0F01B5DBC])
	Engine[0xA52D2CF79103AE1](f48_local1[0xF7AE5746E79F2CE])
	Engine[0x41D81D6B58AAF3F](f48_local1[0xBF54BE1BB3D618B], f48_local1[0xEE71E4EE12BC453])
end
LobbyVM.OnSessionModeChange = function(f49_arg0)
	Lobby.CharacterSelection.OnSetGametype()
	if f49_arg0.toMode == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		for f49_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
			Lobby.Stats.ValidateWZCharacterSelection(f49_local0)
		end
	elseif f49_arg0.toMode == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		for f49_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
			Lobby.Stats.ValidateZMWeaponArmory(f49_local0)
		end
	end
end
LobbyVM.lobbyID = nil
LobbyVM.OnUpdateUI = function(f50_arg0)
	local f50_local0 = f50_arg0.toTarget
	local f50_local1 = f50_arg0.controller
	local f50_local2 = f50_arg0.fromLobbyState
	if type(f50_local0) == "number" then
		f50_local0 = LobbyData.GetLobbyMenuByID(f50_local0)
	end
	local f50_local3 = function(f51_arg0)
		if f51_arg0 == "auto" then
			return "room2"
		else
			return f51_arg0
		end
	end
	local f50_local4 = Engine[0x8CB6D1C656D57EE](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	if f50_local4 ~= LobbyVM.lobbyID then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.showSelect"), true)
		LobbyVM.lobbyID = f50_local4
	end
	Engine[0x58F4769A24A7C7B](f50_local0[0x8B72E07B55C3AC0])
	LobbyData.SetLobbyNav(f50_local0)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyMode", true), f50_local0[0x8409AA0F01B5DBC])
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyMainMode", true), f50_local0[0xEB7DDC7F079D51B])
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyGameMode", true), f50_local0[0xF7AE5746E79F2CE])
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.room", true), f50_local3(f50_local0[0x355141FF0C48EDA]))
	CoDShared[0x562F4B21BD0FAB0](f50_local1, f50_local0[0xEB7DDC7F079D51B])
	if f50_local2 then
		local f50_local5 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME)
		if f50_local5 ~= nil and f50_local0[0x8B72E07B55C3AC0] == f50_local5[0x8B72E07B55C3AC0] then
			Lobby.Events.EventDispatcher("OnClanUIEvent", {
				controller = f50_local1,
				event = LuaEnum.CLAN_UI_EVENT.INIT_MODELS,
			})
			Lobby.Events.EventDispatcher("OnClanUIEvent", {
				controller = f50_local1,
				event = LuaEnum.CLAN_UI_EVENT.FETCH_DATA,
			})
		end
	end
end
LobbyVM.ResetClientLoadouts = function()
	local f52_local0 = Engine[0x3797858022DCB59](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	local f52_local1 = Engine[0xE42CF04B7DDD5DE](LobbyMsg.EncodeToLobbyMsgType(LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_LOBBY_CLIENT_RESET_LOADOUTS), Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	f52_local1:sendTo(f52_local0, Enum[0x7CA2DE5266A94BF][0xDAA8D01F295C885], Enum[0xBF5D4C4954EF3E5][0x41640605E759E71])
	f52_local1:free()
end
LobbyVM.Leaderboard_PopulateCustomList = function(f53_arg0)
	return Lobby.Leaderboard.PopulateCustomList(f53_arg0)
end
LobbyVM.CheckDLCBit = function(f54_arg0, f54_arg1)
	return f54_arg0 & f54_arg1 == f54_arg1
end
LobbyVM.LaunchGameExec = function(f55_arg0, f55_arg1)
	if f55_arg1 ~= Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]) then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Launch game not supported for this lobby type(" .. f55_arg1 .. ")\n")
		return false
	elseif Lobby.ProcessQueue.IsQueueEmpty() then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "** Launching game... **\n")
		Engine[0x7C75E608EA39B5C](f55_arg0, "lobbyLaunchGame")
		return true
	else
		local f55_local0 = Lobby.ProcessQueue.GetQueueHead()
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Warning: Could not launch game. Lobby process '" .. f55_local0.name .. "' in progress.\n")
		return false
	end
end
LobbyVM.LaunchDemoExec = function(f56_arg0, f56_arg1)
	if f56_arg1 ~= Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Launch demo not supported for this lobby type(" .. f56_arg1 .. ")\n")
		return
	elseif Lobby.ProcessQueue.IsQueueEmpty() then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "** Launching demo... **\n")
		Engine[0x7C75E608EA39B5C](f56_arg0, "lobbyLaunchDemo")
		LuaUtils.UI_ClearErrorMessageDialog()
	else
		local f56_local0 = Lobby.ProcessQueue.GetQueueHead()
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Warning: Could not launch damo. Lobby process '" .. f56_local0.name .. "' in progress.\n")
	end
end
LobbyVM.GetBitsForLockedInMap = function()
	local f57_local0 = Engine[0xE67E7253CC272C9]()
	if f57_local0 == nil or f57_local0 == "" then
		f57_local0 = Engine[0xB87231BF773995E]()
	end
	return Engine[0x943893A16399DCF](f57_local0)
end
LobbyVM.GetNeededDLCBits = function()
	local f58_local0 = Engine[0x9882F293C327557]()
	if f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) or f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) then
		return Lobby.Matchmaking.GetMapPackBits(CoDShared.GetLobbyDLCBits(Engine[0x80964E6C43E0C4B](), Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]), Engine[0x7B3B2B73B53EB34]())
	elseif f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME) or f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME) then
		return 0
	elseif f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		return 0
	end
	local f58_local1 = Engine[0xE67E7253CC272C9]()
	if f58_local1 == nil or f58_local1 == "" then
		f58_local1 = Engine[0xB87231BF773995E]()
	end
	return Engine[0x943893A16399DCF](f58_local1)
end
LobbyVM.TriggerQuitMissingMapProcess = function(f59_arg0, f59_arg1)
	Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xD48A9770CD84BB6], "Leaving game because map '" .. Engine[0xE67E7253CC272C9]() .. "' is in contentpack '" .. f59_arg1 .. "' but our dlcbits is '" .. f59_arg0 .. "'.\n")
	local f59_local0 = Lobby.Process.Recover(Engine[0xA5B9C0111291A8B]())
	Lobby.Process.ForceAction(f59_local0.tail, Lobby.Actions.ErrorPopupMsg(0x609344F0F879051))
	Lobby.ProcessQueue.AddToQueue("MissingMap", f59_local0)
end
LobbyVM.DLCMapCheck = function()
	local f60_local0 = CoDShared.GetLobbyDLCBits(Engine[0x80964E6C43E0C4B](), Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]))
	local f60_local1 = LobbyVM.GetNeededDLCBits()
	if not LobbyVM.CheckDLCBit(f60_local0, f60_local1) then
		LobbyVM.TriggerQuitMissingMapProcess(f60_local0, f60_local1)
		return false
	else
		return true
	end
end
LobbyVM.CanLoadMap = function()
	local f61_local0 = CoDShared.GetLobbyDLCBits(Engine[0x80964E6C43E0C4B](), Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]))
	local f61_local1 = LobbyVM.GetBitsForLockedInMap()
	if not LobbyVM.CheckDLCBit(f61_local0, f61_local1) then
		LobbyVM.TriggerQuitMissingMapProcess(f61_local0, f61_local1)
		return false
	else
		return true
	end
end
LobbyVM.CanClientLaunch = function(f62_arg0)
	if CoDShared.IsMapFree(Engine[0xC53F8D38DF9042B](Engine[0xE67E7253CC272C9]()), Engine[0x9882F293C327557](), Engine[0x7B3B2B73B53EB34]()) then
		return true
	elseif LobbyVM.CanLoadMap() == false then
		Engine[0xB972AE22481F1]()
		return false
	else
		return true
	end
end
LobbyVM.GameModeChanged = function(f63_arg0)
	Lobby.TeamSelection.GameModeChanged(f63_arg0)
end
LobbyVM.OnCanBroadcastHostInfo = function(f64_arg0)
	return true
end
LobbyVM.OnUpdateAdvertising = function(f65_arg0)
	if f65_arg0.lobbyType == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] then
		Lobby.Matchmaking.UpdateAdvertising("force update from code")
	end
end
LobbyVM.UGCOffensiveEmblemAdd = function(f66_arg0)
	Lobby.UGC.OffensiveEmblemAdd(f66_arg0)
end
LobbyVM.OnChangeSigninState = function(f67_arg0)
	local f67_local0 = nil
	if f67_arg0.onlineState == Enum[0x1F6577DCFF6E881][0xFE806F50201F7E3] then
		Lobby.Anticheat.OnControllerSignedOut(f67_arg0.controller)
		if f67_arg0.isPrimary then
			f67_local0 = Lobby.Process.PrimaryControllerSignedOut(f67_arg0.controller)
		end
	elseif f67_arg0.onlineState == Enum[0x1F6577DCFF6E881][0x1675B607D4A7DAA] then
		if f67_arg0.isPrimary then
			f67_local0 = Lobby.Process.PrimaryControllerSignedIn(f67_arg0.controller)
		end
	else
		DebugPrint("Warning unknown signin State [" .. f67_arg0.onlineState .. "]")
	end
	if f67_local0 ~= nil then
		Lobby.ProcessQueue.AddToQueue("ChangeSignInState", f67_local0)
	end
end
LobbyVM.ClearLobbyStatus = function()
	if LobbyVM.lobbyStatus.cleared == true then
		return
	elseif LobbyVM.lobbyStatus.clearedTime > Engine[0x9D33D652B9B0F3B]() then
		return
	else
		LobbyVM.lobbyStatus.cleared = true
		local f68_local0 = Engine[0x8DF2E5447F384B9]()
		f68_local0 = f68_local0.lobbyRoot
		local f68_local1 = f68_local0:create("lobbyStatusString1")
		f68_local1:set("")
		f68_local1 = f68_local0:create("lobbyStatusString2")
		f68_local1:set("")
		f68_local1 = f68_local0:create("lobbyStatusString3")
		f68_local1:set("")
	end
end
LobbyVM.LobbyStatusUpdate = function(f69_arg0)
	if not Engine[0x3E5B188BDE5B13B]() then
		return
	end
	local f69_local0 = Engine[0x8DF2E5447F384B9]()
	f69_local0 = f69_local0.lobbyRoot
	local f69_local1 = f69_local0:create("lobbyStatusString1")
	local f69_local2 = f69_local0:create("lobbyStatusString2")
	local f69_local3 = f69_local0:create("lobbyStatusString3")
	LobbyVM.lobbyStatus.cleared = false
	LobbyVM.lobbyStatus.clearedTime = Engine[0x9D33D652B9B0F3B]() + 10000
	local f69_local4 = f69_arg0.searchStage
	local f69_local5 = ""
	if f69_local4 == 1 then
		local f69_local6 = f69_arg0.numResults
		if f69_local6 == 1 then
			f69_local5 = Engine[0xF9F1239CFD921FE](0xE4043BEC55997D7)
		else
			f69_local5 = Engine[0xF9F1239CFD921FE](0xF5C23E745BBA03A, f69_local6)
		end
		f69_local1:set(f69_local5)
		f69_local2:set("")
		f69_local3:set("")
	elseif f69_local4 == 2 then
		f69_local2:set(Engine[0xF9F1239CFD921FE](0x14406E6B65BB0D6, f69_arg0.contactedResults, f69_arg0.numResults))
	elseif f69_local4 == 3 then
		f69_local3:set(Engine[0xF9F1239CFD921FE](0x5AE8C0E42569E25, f69_arg0.joiningCurHost, f69_arg0.joiningNumHosts))
	end
end
LobbyVM.ProcessCompleteSuccess = function(f70_arg0)
	Lobby.ProcessQueue.Success(f70_arg0)
end
LobbyVM.ProcessCompleteFailure = function(f71_arg0)
	Lobby.ProcessQueue.Failure(f71_arg0)
end
LobbyVM.ProcessCompleteError = function(f72_arg0)
	Lobby.ProcessQueue.Error(f72_arg0)
end
LobbyVM.ProcessUpdate = function(f73_arg0)
	Lobby.ProcessQueue.Update(f73_arg0)
end
LobbyVM.OnGameLobbyGameServerDataUpdate = function(f74_arg0)
	local f74_local0 = LobbyData.GetCurrentMenuTarget()
	if f74_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9] or f74_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xD42D003CEEA3F87] then
		local f74_local1 = Engine[0x3ACB99DBAD24D55](Engine[0x7B3B2B73B53EB34]())
		if f74_local1 then
			local f74_local2 = f74_local1.name
			local f74_local3 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyPlaylist")
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f74_local3, "name"), Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](f74_local2)))
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f74_local3, "kickerText"), 0x0)
		end
	end
	Lobby.MapVote.GameLobbyGameServerDataUpdate(f74_arg0)
end
LobbyVM.OnPrivateLobbyServerDataUpdate = function(f75_arg0)
	local f75_local0 = LobbyData.GetCurrentMenuTarget()
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		local f75_local1 = Engine[0x8DF2E5447F384B9]()
		f75_local1 = f75_local1:create("lobbyRoot.fillParty")
		f75_local1:set(f75_arg0.fillParty)
	end
	if f75_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9] or f75_local0[0x8409AA0F01B5DBC] == Enum[0x8409AA0F01B5DBC][0xD42D003CEEA3F87] then
		local f75_local2 = Engine[0x3ACB99DBAD24D55](Engine[0x7B3B2B73B53EB34]())
		if f75_local2 then
			local f75_local3 = f75_local2.name
			local f75_local4 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyPlaylist")
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f75_local4, "name"), Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](f75_local3)))
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f75_local4, "kickerText"), 0x0)
		end
	end
end
LobbyVM.OnGameLobbyClientDataUpdate = function(f76_arg0)
	Lobby.MapVote.GameLobbyClientDataUpdate(f76_arg0)
	Lobby.TeamSelection.GameLobbyClientDataUpdate(f76_arg0)
	Lobby.Pregame.GameLobbyClientDataUpdate(f76_arg0)
	LuaUtils.ForceLobbyButtonUpdate()
	Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.gameClientDataUpdate"))
end
LobbyVM.OnDediQosReady = function()
	local f77_local0 = Engine[0x29A1F6E8893B96F](Lobby.Matchmaking.DatacenterType.ANY)
	if f77_local0.numResults == 0 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Engine told us results were ready, but no results available\n")
	else
		servers = f77_local0.pingResults
		for f77_local4, f77_local5 in ipairs(servers) do
			Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x744BF3845B0D442, {
				[0xF90406E9A94ABE6] = f77_local5.location,
				[0xF30E00DC53307A9] = f77_local5.ping,
			})
		end
	end
end
LobbyVM.OnPopulateMutableClientDDLBuff = function(f78_arg0)
	local f78_local0 = f78_arg0.controller
	local f78_local1 = f78_arg0.ddlData
end
LobbyVM.OnReceiveMutableClientDDLBuff = function(f79_arg0)
	local f79_local0 = f79_arg0.xuid
	local f79_local1 = f79_arg0.ddlData
end
LobbyVM.LobbyPumpList = {}
LobbyVM.LobbyPumpList.sequence = 0
LobbyVM.LobbyPumpList.funcs = {
	Lobby.Anticheat.Pump,
	Lobby.Arena.Pump,
	Lobby.Clans.Pump,
	Lobby.Debug.Pump,
	Lobby.Hopper.Pump,
	Lobby.MapVote.Pump,
	Lobby.Matchmaking.Pump,
	Lobby.Merge.Pump,
	Lobby.MatchmakingAsync.PumpLobbyMerging,
	Lobby.PartyPrivacy.Pump,
	Lobby.Platform.Pump,
	Lobby.Pregame.Pump,
	Lobby.ProcessQueue.Pump,
	Lobby.Scheduler.Pump,
	Lobby.TeamSelection.Pump,
	Lobby.Test.Pump,
	Lobby.Theater.Pump,
	Lobby.Timer.Pump,
	Lobby.Leaderboard.Pump,
}
LobbyVM.OnPump = function(f80_arg0)
	LobbyVM.LobbyPumpList.sequence = math.fmod(LobbyVM.LobbyPumpList.sequence, #LobbyVM.LobbyPumpList.funcs)
	LobbyVM.LobbyPumpList.sequence = LobbyVM.LobbyPumpList.sequence + 1
	LobbyVM.LobbyPumpList.funcs[LobbyVM.LobbyPumpList.sequence](f80_arg0)
	if Lobby.Join.autoJoin.leaveServerImmediately == true then
		Lobby.Join.autoJoin.leaveServerImmediately = false
		if not CoDShared.IsInTheaterLobby() then
			Engine[0x81B232D8CD69A4B]()
		end
	end
end
LobbyVM.OnIsFeatureBanned = function(f81_arg0)
	local f81_local0, f81_local1 = Lobby.Anticheat.CheckIsFeatureBannedForIndex(f81_arg0.controller, f81_arg0.feature)
	return f81_local0
end
LobbyVM.OnGetBanTimeRemaining = function(f82_arg0)
	return Lobby.Anticheat.OnGetBanTimeRemaining(f82_arg0)
end
LobbyVM.GetLootItemCategory = function(f83_arg0)
	local f83_local0 = "gamedata/loot/mplootitems.csv"
	local f83_local1 = 1
	local f83_local2 = 2
	local f83_local3 = Engine[0x910CBCCD3C164C9](f83_local0, f83_local1, f83_arg0)
	if f83_local3 == nil or #f83_local3 == 0 then
		return -1
	else
		local f83_local4 = Engine[0x5A4D00DABC5F44B](f83_local0, f83_local3[1], f83_local2)
		if f83_local4 == nil then
			return -1
		else
			return f83_local4
		end
	end
end
LobbyVM.GetRecentItemTags = function(f84_arg0, f84_arg1)
	local f84_local0 = Engine[0xF9DEF4016ECF1FB](f84_arg0, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5], 0, Engine[0xE3E5F674ECC4A61](f84_arg0, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]))
	local f84_local1 = LuaUtils.GetCurrentLootVersion()
	local f84_local2 = "gamedata/loot/mplootitems.csv"
	local f84_local3 = Engine[0x910CBCCD3C164C9](f84_local2, 2, f84_arg1)
	local f84_local4 = 6
	local f84_local5 = 0
	for f84_local10, f84_local11 in ipairs(f84_local3) do
		local f84_local9 = Engine[0x5A4D00DABC5F44B](f84_local2, f84_local11, f84_local4)
		if f84_local9 == nil or f84_local9 == "" then
			f84_local9 = -1
		else
			f84_local9 = tonumber(f84_local9)
		end
		if f84_local9 ~= -1 and f84_local9 <= f84_local1 then
			f84_local5 = f84_local5 + 1
		end
	end
	if f84_local0 == nil then
		return ""
	end
	f84_local6 = {}
	for f84_local11, f84_local9 in ipairs(f84_local0) do
		if CoDShared.GetLootItemCategory(f84_local9.id) == f84_arg1 and CoDShared.GetLootItemVersion(f84_local9.id) <= f84_local1 then
			table.insert(f84_local6, f84_local9.id)
		end
		if f84_local5 <= #f84_local6 then
			return ""
		end
	end
	if #f84_local6 == 0 then
		return ""
	end
	f84_local7 = ""
	for f84_local9, f84_local12 in ipairs(f84_local6) do
		f84_local7 = f84_local7 .. "[ 203, " .. f84_local12 .. "]"
		if f84_local9 < #f84_local6 then
			f84_local7 = f84_local7 .. " , "
		end
	end
	return f84_local7
end
LobbyVM.OnBuyCrate = function(f85_arg0)
	local f85_local0 = ' "SupplyDropID": ' .. f85_arg0.crateDWID .. ", "
	local f85_local1 = ' "PurchaseWith": "' .. f85_arg0.currency .. '", '
	local f85_local2 = ' "Rank": [], '
	local f85_local3 = ' "ExcludeTag": [], '
	local f85_local4 = ' "InventoryVersion": [ ' .. Dvar[0x7EC5101FF8361D3]:get() .. " ] "
	local f85_local5 = false
	local f85_local6 = ""
	if f85_arg0.crateDWID == 32 then
		f85_local5 = true
		f85_local6 = "weapon"
	elseif f85_arg0.crateDWID == 31 then
		f85_local5 = true
		f85_local6 = "melee_weapon"
	end
	if f85_local5 == true then
		local f85_local7 = LobbyVM.GetRecentItemTags(f85_arg0.controller, f85_local6)
		f85_local3 = ' "ExcludeTag": [ '
		if f85_local7 ~= "" then
			f85_local3 = f85_local3 .. f85_local7
		end
		f85_local3 = f85_local3 .. " ], "
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x1725ABF82092BD8], "Excluding: " .. f85_local3 .. ".\n")
	end
	return f85_local0 .. f85_local1 .. f85_local2 .. f85_local3 .. f85_local4
end
LobbyVM.DLCInfo = {
	{
		dlcIndex = Enum[0x15A59C8C59697E5][0xAE7A7ACDC9568EC],
		dlcPackName = "dlc1",
		inventoryVersion = 101,
	},
	{
		dlcIndex = Enum[0x15A59C8C59697E5][0x186BB7D796153ED],
		dlcPackName = "dlc2",
		inventoryVersion = 102,
	},
	{
		dlcIndex = Enum[0x15A59C8C59697E5][0xA15323F2E0DB8C2],
		dlcPackName = "dlc3",
		inventoryVersion = 103,
	},
	{
		dlcIndex = Enum[0x15A59C8C59697E5][0x3AC6F0A427CC963],
		dlcPackName = "dlc4",
		inventoryVersion = 104,
	},
}
LobbyVM.OnSpendVials = function(f86_arg0)
	local f86_local0 = ' "NumVials": ' .. f86_arg0.vialCount .. ", "
	local f86_local1 = ' "InventoryVersion": [' .. Dvar[0x1FE5ADAF8E375DF]:get() .. " "
	local f86_local2 = Engine[0x22EAAB59AA27E9B]("tu9_highestAvailableDLC")
	for f86_local6, f86_local7 in ipairs(LobbyVM.DLCInfo) do
		if f86_local7.dlcIndex <= f86_local2 and Engine[0xB521CB398C92692](f86_arg0.controller, Engine[0xC53F8D38DF9042B](f86_local7.dlcPackName)) then
			f86_local1 = f86_local1 .. ", " .. f86_local7.inventoryVersion .. " "
		end
	end
	return f86_local0 .. f86_local1 .. "]"
end
LobbyVM.OnInventoryFetched = function(f87_arg0)
	local f87_local0 = {
		"na_team_mtx",
		"eu_team_mtx",
		"anz_team_mtx",
		"cwl_mtx",
		"cwl_mtx_v2",
	}
	local f87_local1 = "gamedata/tables/common/inventory_items.csv"
	local f87_local2 = 1
	local f87_local3 = 2
	local f87_local4 = false
	for f87_local8, f87_local9 in ipairs(f87_local0) do
		if Engine[0xDCACE8F075B721B](f87_arg0.controller, tonumber(Engine[0x2DCF0973239E909](nil, f87_local1, f87_local2, f87_local9, f87_local3))) > 0 then
			Engine[0x280E4C1191CC53D](f87_arg0.controller, f87_local9, "1")
			f87_local4 = true
		end
	end
	if f87_local4 then
		Engine[0x16C9486C6451EEE](f87_arg0.controller)
	end
end
LobbyVM.CheckSpecialPlaylistRules = function(f88_arg0)
	if Dvar[0xE21BBE3614F731D]:get() == true then
		if Engine[0x4160EF6B98737EF]() and not Engine[0x1B09567078C4A6F]() then
			Dvar[0xE21BBE3614F731D]:set(false)
			Engine[0xBC42C678E40DBE8](Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF], Engine[0xF9F1239CFD921FE](0x22BE13738744598))
		end
		local f88_local0 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		for f88_local4, f88_local5 in ipairs(f88_local0.sessionClients) do
			if f88_local5.isInPlatformPartyChat == true then
				Engine[0x3C379E096BB7570](f88_arg0, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f88_local5.xuid, Enum[0x3EB01916743DF12][0x6EF5F11FAA609FC], 0x22BE13738744598)
			end
		end
	end
end
LobbyVM.IngameMonitor = function()
	if not Engine[0x7B48C1ABFF0F764]() then
		return
	elseif (Engine[0xE39F1F30B306065]() or CoDShared.IsLobbyMode(Enum[0x8409AA0F01B5DBC][0xBB5FD8AEFC4D4B9])) and Dvar[0xE21BBE3614F731D]:get() and Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		local f89_local0 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		local f89_local1 = Engine[0x3797858022DCB59](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
		for f89_local5, f89_local6 in ipairs(f89_local0.sessionClients) do
			if f89_local6.isInPlatformPartyChat == true then
				Engine[0x3C379E096BB7570](f89_local1, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f89_local6.xuid, Enum[0x3EB01916743DF12][0x6EF5F11FAA609FC], 0x22BE13738744598)
			end
		end
	end
end
LobbyVM.OnMessageReceived = function(f90_arg0)
	if f90_arg0.msgType == Enum[0x3901A96E6973A52][0x2DF0374DB931C86] then
		LobbyVM.ProcesMoveLobby(f90_arg0)
	end
end
LobbyVM.ProcesMoveLobby = function(f91_arg0)
	local f91_local0 = f91_arg0.controller
	local f91_local1 = f91_arg0.lobbyType
	local f91_local2 = f91_arg0.lobbyTypeMoveFrom
	local f91_local3 = f91_local1
	Engine[0xC31C302EB4FEC60](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f91_local2, f91_local3)
	Engine[0xBB840C7E3D32BD6](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f91_local3)
	Engine[0xBB840C7E3D32BD6](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], f91_local2)
	Engine[0xBB840C7E3D32BD6](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f91_local2)
	local f91_local4 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f91_local3)
	for f91_local8, f91_local9 in ipairs(f91_local4.sessionClients) do
		Engine[0x5D28F97B2C14CD7](f91_local0, f91_local3, f91_local9.xuid)
	end
end
LobbyVM.OnPublisherVarScript = function(f92_arg0)
	local f92_local0 = {}
	local f92_local1 = 0
	local f92_local2, f92_local3, f92_local4 = nil
	for f92_local8 in string.gmatch(f92_arg0.data, "[^,]+") do
		f92_local8 = f92_local8:gsub("%s+", "")
		if f92_local1 == 0 then
			f92_local2 = f92_local8
		elseif f92_local1 == 1 then
			f92_local3 = f92_local8
		else
			if f92_local3 == "string" then
				f92_local4 = f92_local8
			elseif f92_local3 == "number" then
				f92_local4 = tonumber(f92_local8)
			elseif f92_local3 == "bool" then
				if f92_local8 == "true" then
					f92_local4 = true
				else
					f92_local4 = false
				end
			else
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xD48A9770CD84BB6], "Unknown publisher variable type [" .. f92_local3 .. "] \n")
			end
			f92_local0[f92_local2] = f92_local4
		end
		f92_local1 = f92_local1 + 1
		if f92_local1 >= 3 then
			f92_local1 = 0
		end
	end
	if LobbyVM ~= nil then
		Lobby.Events.EventDispatcher(f92_arg0.name, f92_local0)
	else
		Engine[0x87AE7E64BA5AD61](f92_arg0.name, f92_local0)
	end
end
LobbyVM.OnGetMapName = function(f93_arg0)
	return LuaUtils.GetBSPNameFromAsset(f93_arg0.assetID)
end
LobbyVM.OnCanFitPlayers = function(f94_arg0)
	local f94_local0 = f94_arg0.lobbyType
	local f94_local1 = f94_arg0.reservationCount
	local f94_local2 = f94_arg0.clientCount
	local f94_local3 = f94_arg0.memberCount
	local f94_local4 = Engine[0xA63E42B2FB6EC02]()
	local f94_local5
	if f94_local4 ~= Enum[0xC84D3E505F1444][0xDB898B3478D2D71] and f94_local4 ~= Enum[0xC84D3E505F1444][0xBAA8EC6F3E77255] then
		f94_local5 = false
	else
		f94_local5 = true
	end
	if f94_local5 == false and f94_local0 == Enum[0xBF54BE1BB3D618B][0xA1647599284110] and f94_local1 + f94_local2 + f94_local3 > Dvar[0x4FF45B41C6046F8]:get() then
		return false
	else
		return true
	end
end
LobbyVM.OnLobbyAsyncMatchmakerStart = function(f95_arg0)
	if Lobby.ProcessQueue.GetCurrentRunningProcessName() ~= "FindWarZoneServer" and Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		Lobby.ProcessQueue.AddToQueue("FindWarZoneServer", Lobby.Process.AsyncMatchmakingStartAsyncMatchmaker(f95_arg0.controller))
	end
end
LobbyVM.OnLobbyAsyncMatchmakerRedeploy = function(f96_arg0)
	if Lobby.ProcessQueue.GetCurrentRunningProcessName() ~= "Redeploy" and Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		Lobby.ProcessQueue.AddToQueue("Redeploy", Lobby.Process.AsyncMatchmakingStartAsyncMatchmaker(f96_arg0.controller))
	end
end
LobbyVM.TestFFOTDFnOverride = function()
	Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "Failed to override Lobby VM funtion from FFOTD.\n")
	error("Failed to override Lobby VM funtion from FFOTD.")
end
require("x64:eef8dcfe7b2aafc")
