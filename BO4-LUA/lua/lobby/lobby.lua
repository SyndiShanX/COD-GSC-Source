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
	local f1_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"])
	if f1_arg0 ~= nil then
		Engine[@"lobbysetmap"](f1_local0, f1_arg0)
	end
	if f1_arg1 ~= nil then
		Engine[@"lobbysetgametype"](f1_local0, f1_arg1)
	end
	if not Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], f1_local0) then
		return
	elseif not Engine[@"islobbyhost"](f1_local0) then
		return
	else
		Lobby.Timer.Clear(true)
		LobbyVM.LaunchGameExec(Engine[@"getprimarycontroller"](), f1_local0)
	end
end
LobbyVM.DevGui.LobbyReset = function()
	LobbyVM.OnErrorShutdown({
		controller = Engine[@"getprimarycontroller"](),
		signoutUsers = false,
	})
end
LobbyVM.PlaySound = function(f3_arg0, f3_arg1)
	local f3_local0 = false
	if LobbyVM.playSoundHistory[f3_arg0] == nil then
		f3_local0 = true
	elseif LobbyVM.playSoundHistory[f3_arg0] < Engine[@"milliseconds"]() then
		f3_local0 = true
	end
	if f3_local0 == true then
		Engine[@"playsound"](f3_arg0)
		LobbyVM.playSoundHistory[f3_arg0] = Engine[@"milliseconds"]() + f3_arg1
	end
end
LobbyVM.ExecuteLobbyVMRequest = function(f4_arg0)
	local f4_local0 = Engine[@"getglobalmodel"]()
	f4_local0 = f4_local0:create("lobbyRoot.lobbyVMRequest")
	if not f4_local0:set(f4_arg0) then
		f4_local0:forceNotifySubscriptions()
	end
end
LobbyVM.ExecuteLobbyVMCreateOverlay = function(f5_arg0, f5_arg1)
	local f5_local0 = Engine[@"getglobalmodel"]()
	f5_local0 = f5_local0:create("lobbyRoot.lobbyVMCreateOverlayController")
	f5_local0:set(f5_arg0)
	f5_local0 = Engine[@"getglobalmodel"]()
	f5_local0 = f5_local0:create("lobbyRoot.lobbyVMCreateOverlay")
	if not f5_local0:set(f5_arg1) then
		f5_local0:forceNotifySubscriptions()
	end
end
LobbyVM.ExecuteLobbyVMOpenSurvey = function(f6_arg0)
	local f6_local0 = Engine[@"getglobalmodel"]()
	f6_local0 = f6_local0:create("lobbyRoot.lobbyVMOpenIntroSurvey")
	if not f6_local0:set(f6_arg0) then
		f6_local0:forceNotifySubscriptions()
	end
end
LobbyVM.OnErrorShutdown = function(f7_arg0)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Performing emergency shutdown.\n")
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Close all popups in the lobby.\n")
	Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.closePopups"))
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Shutting down joins.\n")
	Engine[@"lobbyjoinerrorshutdown"]()
	if Engine[@"lobbyclienttaskerrorshutdown"] then
		Engine[@"lobbyclienttaskerrorshutdown"]()
	end
	if Engine[@"lobbyhosttaskerrorshutdown"] then
		Engine[@"lobbyhosttaskerrorshutdown"]()
	end
	if Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Shutting down qos probes.\n")
		Engine[@"qoserrorshutdown"](Enum[@"lobbytype"][@"lobby_type_game"])
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Shutting down advertisement.\n")
		Engine[@"advertiseerrorshutdown"](Enum[@"lobbytype"][@"lobby_type_game"])
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Shutting down search.\n")
		Engine[@"lobbysearcherrorshutdown"]()
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Shutting down private lobby.\n")
	Engine[@"lobbyclienterrorshutdown"](Enum[@"lobbytype"][@"lobby_type_game"])
	Engine[@"lobbyhosterrorshutdown"](Enum[@"lobbytype"][@"lobby_type_game"])
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Shutting down game lobby.\n")
	Engine[@"lobbyclienterrorshutdown"](Enum[@"lobbytype"][@"lobby_type_private"])
	Engine[@"lobbyhosterrorshutdown"](Enum[@"lobbytype"][@"lobby_type_private"])
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Clearing process queue.\n")
	Lobby.ProcessQueue.ErrorShutdown()
	if f7_arg0.signoutUsers ~= nil and f7_arg0.signoutUsers == true then
		for f7_local0 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
			LobbyVM.OnDWDisconnect({
				controller = f7_local0,
			})
		end
		Engine[@"signoutallusers"]()
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Forcing UI screen.\n")
	Engine[@"forcelobbyuiscreen"](LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN))
	Engine[@"luivm_event"]("open_main", {})
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby emergency shutdown complete.\n")
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
	local f9_local1 = Engine[@"getprimarycontroller"]()
	local f9_local2 = @"hash_59E4136B4110C280"
	local f9_local3 = {
		[@"playlist_version"] = Engine[@"getplaylistversionnumber"](),
		[@"hash_1514AE50C5450622"] = Engine[@"getprotocolversion"](),
		ffotd_version = Engine[@"getffotdversion"](),
	}
	local f9_local4 = Engine[@"getddlversion"]
	local f9_local5 = Engine[@"getstoragefileinfo"](Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	f9_local3[@"hash_5A5F320A7654324C"] = f9_local4(f9_local5.ddlPath)
	f9_local4 = Engine[@"getddlversion"]
	f9_local5 = Engine[@"getstoragefileinfo"](Enum[@"storagefiletype"][@"storage_mp_loadouts"])
	f9_local3[@"hash_4445FA044E754C98"] = f9_local4(f9_local5.ddlPath)
	f9_local3[@"hash_47B625C48C3B5FCC"] = Engine[@"getbuildintfield"](Enum[@"buildintfield"][@"build_intfield_changelist"])
	f9_local3[@"build_machine"] = Engine[@"getbuildstringfield"](Enum[@"buildstringfield"][@"build_stringfield_build_machine"])
	f9_local3[@"build_time"] = Engine[@"getbuildstringfield"](Enum[@"buildstringfield"][@"build_stringfield_build_time"])
	f9_local3[@"build_type"] = Engine[@"getbuildstringfield"](Enum[@"buildstringfield"][@"build_stringfield_build_type"])
	f9_local3[@"build_name"] = Engine[@"getbuildstringfield"](Enum[@"buildstringfield"][@"build_stringfield_build_name"])
	f9_local0(f9_local1, f9_local2, f9_local3)
end
LobbyVM.OnClientAdded = function(f10_arg0)
	local f10_local0 = f10_arg0.lobbyModule
	local f10_local1 = f10_arg0.lobbyType
	local f10_local2 = f10_arg0.lobbyMode
	local f10_local3 = f10_arg0.xuid
	if f10_local0 == Enum[@"lobbymodule"][@"lobby_module_host"] then
		local f10_local4 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.gameClient.isHost"))
		if f10_local4 and f10_local4 ~= 0 then
			LuaUtils.ForceLobbyButtonUpdate()
		end
	end
	Lobby.Matchmaking.OnClientAdded(f10_arg0)
	Lobby.TeamSelection.OnClientAdded(f10_arg0)
	Lobby.Pregame.OnClientAdded(f10_arg0)
	Lobby.Leaderboard.OnClientAdded(f10_arg0)
	Lobby.RecentPlayers.OnClientAdded(f10_arg0)
	Engine[@"qosprobelistenerupdate"](f10_local1)
	if f10_local0 == Enum[@"lobbymodule"][@"lobby_module_client"] and not Engine[@"islocalclient"](f10_local3) and not Engine[@"isingame"]() then
		LobbyVM.PlaySound(LobbyData.Sounds.ClientsAddedToLobby, 500)
	end
	if LuaDefine.isPS4 == true and Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] == Engine[@"getlobbynetworkmode"]() and f10_local0 == Enum[@"lobbymodule"][@"lobby_module_client"] and f10_local1 == Enum[@"lobbytype"][@"lobby_type_private"] and Engine[@"islocalclient"](f10_local3) and not Engine[@"isingame"]() then
		local f10_local4 = Engine[@"getcontrollerforxuid"](f10_local3)
		if Engine[@"notifypsplusasyncmultiplay"] ~= nil then
			Engine[@"notifypsplusasyncmultiplay"](f10_local4)
		end
	end
	local f10_local4 = Engine[@"xuidtostring"](f10_local3)
	if LobbyVM.ClientsToRemove[f10_local4] then
		LobbyVM.ClientsToRemove[f10_local4] = nil
	end
	if not LobbyVM.ClientsInModule[f10_local0] then
		LobbyVM.ClientsInModule[f10_local0] = {}
	end
	LobbyVM.ClientsInModule[f10_local0][f10_local4] = true
	f10_arg0.lobbyID = Engine[@"getlobbylobbyid"](f10_local0, f10_local1)
	Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), 0x84AA3CF21433C2, {
		[@"lobby_module"] = f10_arg0.lobbyModule,
		[@"lobby_type"] = f10_arg0.lobbyType,
		[@"lobby_mode"] = f10_arg0.lobbyMode,
		[@"xuid"] = f10_arg0.xuid,
	})
end
LobbyVM.OnClientRemoved = function(f11_arg0)
	local f11_local0 = f11_arg0.lobbyModule
	local f11_local1 = f11_arg0.lobbyType
	local f11_local2 = f11_arg0.lobbyMode
	local f11_local3 = f11_arg0.xuid
	if f11_local0 == Enum[@"lobbymodule"][@"lobby_module_host"] then
		LuaUtils.ForceLobbyButtonUpdate()
	end
	Lobby.Timer.OnClientRemoved(f11_arg0)
	Lobby.Pregame.OnClientRemoved(f11_arg0)
	Lobby.Matchmaking.OnClientRemoved(f11_arg0)
	Engine[@"qosprobelistenerupdate"](f11_local1)
	if f11_local0 == Enum[@"lobbymodule"][@"lobby_module_client"] and not Engine[@"islocalclient"](f11_local3) and not Engine[@"isingame"]() then
		LobbyVM.PlaySound(LobbyData.Sounds.ClientsRemovedFromLobby, 500)
	end
	f11_arg0.lobbyID = Engine[@"getlobbylobbyid"](f11_local0, f11_local1)
	local f11_local4 = Engine[@"xuidtostring"](f11_local3)
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
	Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_25D76FEC9A7AF604", {
		[@"lobby_module"] = f11_arg0.lobbyModule,
		[@"lobby_type"] = f11_arg0.lobbyType,
		[@"lobby_mode"] = f11_arg0.lobbyMode,
		[@"xuid"] = f11_arg0.xuid,
	})
end
LobbyVM.OnUILevelRunningChanged = function(f12_arg0)
	local f12_local0 = f12_arg0.running
	for f12_local1 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
		Engine[@"sendclientheartbeat"](f12_local1, Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
	end
	if Engine[@"isdedicatedserver"]() and f12_local0 == true and (not Dvar[@"hash_2B852BA138B9853A"]:exists() or not Dvar[@"hash_2B852BA138B9853A"]:get()) then
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
	local f13_local3 = Engine[@"getglobalmodel"]()
	f13_local3 = f13_local3:create("lobbyRoot.selectedMapId")
	f13_local3:set(Engine[@"converttoxhash"](f13_arg0.nextMap))
	Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_393C9A4BAA822A3", {
		[@"lobby_module"] = f13_arg0.lobbyModule,
		[@"lobby_type"] = f13_arg0.lobbyType,
		[@"lobby_mode"] = f13_arg0.lobbyMode,
		[@"current_map"] = f13_arg0.currentMap,
		[@"next_map"] = f13_arg0.nextMap,
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
	if LobbyVM.CheckDLCBit(Engine[@"getdlcbits"](), Engine[@"getdlcbitformapname"](Engine[@"lobbygetmap"]())) then
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
	local f17_local5 = Engine[@"getprimarycontroller"]()
	local f17_local6 = true
	local f17_local7 = nil
	local f17_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_B6154C132FDA6EE")
	local f17_local9 = Lobby.Process.Recover(f17_local5)
	if f17_local4 == Enum[@"lobbydisconnectclient"][@"lobby_disconnect_client_invalid"] then
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"lobby_disconnect_client_drop"] then
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"lobby_disconnect_client_nopartychat"] then
		f17_local6 = false
		f17_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/notice")
		f17_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_422BE13738744598")
		Dvar[@"partychatdisallowed"]:set(false)
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"lobby_disconnect_client_kick"] then
		f17_local6 = false
		f17_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_18F4D42673CB46CD")
		f17_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_38188B874FA9DFE4")
		if f17_local1 == Enum[@"lobbytype"][@"lobby_type_private"] and Engine[@"isingame"]() == true then
			f17_local9 = Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f17_local5, f17_local2, Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f17_local1))
		end
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"lobby_disconnect_client_baddlc"] then
		if LobbyVM.ShouldShowContentChangedMessage(f17_local5, f17_local1) then
			Engine[@"comerror"](Enum[@"errorcode"][@"error_drop"], Engine[@"hash_4F9F1239CFD921FE"](@"hash_DDDB3A5B7CE38F1"))
		else
			Engine[@"comerror"](Enum[@"errorcode"][@"error_drop"], Engine[@"hash_4F9F1239CFD921FE"](@"platform/missingmap"))
		end
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"lobby_disconnect_client_hostreload"] then
		if Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) and not Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"]) then
			Lobby.ProcessQueue.AddToQueue("ReloadGameLobby", Lobby.ProcessNavigate.ReloadGameLobby(f17_local5, math.random(Engine[@"getdvarint"]("arena_lobbyReloadSearchDelayMin"), Engine[@"getdvarint"]("arena_lobbyReloadSearchDelayMax"))))
		end
		return
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"hash_449C6D6AA15230A8"] then
		if Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) and not Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"]) then
			local f17_local10 = LobbyData.GetCurrentMenuTarget()
			Lobby.ProcessQueue.AddToQueue("LeaveDedicatedGameLobby", Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f17_local5, f17_local10, f17_local10, LuaEnum.LEAVE_WITH_PARTY.WITH))
		end
		return
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"hash_1DF49978C783A5BB"] then
		f17_local6 = false
		f17_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_377FA7015AB6DB6F")
		f17_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7AE260610DD3C172")
		if f17_local1 == Enum[@"lobbytype"][@"lobby_type_private"] and Engine[@"isingame"]() == true then
			f17_local9 = Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f17_local5, f17_local2, Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f17_local1))
		end
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"hash_3B901B6DF0CD7657"] then
		f17_local6 = false
		f17_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_18F4D42673CB46CD")
		f17_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/korea_15plus_blocked_gamemode")
		if f17_local1 == Enum[@"lobbytype"][@"lobby_type_private"] and Engine[@"isingame"]() == true then
			f17_local9 = Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f17_local5, f17_local2, Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f17_local1))
		end
	elseif f17_local4 == Enum[@"lobbydisconnectclient"][@"hash_4A1580BBC7A114CC"] then
		f17_local6 = false
		f17_local7 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_18F4D42673CB46CD")
		f17_local8 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7AE260610DD3C172")
		if f17_local1 == Enum[@"lobbytype"][@"lobby_type_private"] and Engine[@"isingame"]() == true then
			f17_local9 = Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f17_local5, f17_local2, Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f17_local1))
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
	if f18_arg0 == Enum[@"errorcode"][@"error_none"] then
		return "ERR_NONE"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_fatal"] then
		return "ERR_FATAL"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_drop"] then
		return "ERR_DROP"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_from_startup"] then
		return "ERR_FROM_STARTUP"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_serverdisconnect"] then
		return "ERR_SERVERDISCONNECT"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_disconnect"] then
		return "ERR_DISCONNECT"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_script"] then
		return "ERR_SCRIPT"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_script_drop"] then
		return "ERR_SCRIPT_DROP"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_localization"] then
		return "ERR_LOCALIZATION"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_ui"] then
		return "ERR_UI"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_lua"] then
		return "ERR_LUA"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_softrestart"] then
		return "ERR_SOFTRESTART"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_softrestart_keepdw"] then
		return "ERR_SOFTRESTART_KEEPDW"
	elseif f18_arg0 == Enum[@"errorcode"][@"error_softrestart_silent"] then
		return "ERR_SOFTRESTART_SILENT"
	else
		return tostring(f18_arg0)
	end
end
LobbyVM.ClientsToRemove = {}
LobbyVM.ClientsInModule = {}
LobbyVM.OnUILoad = function(f19_arg0)
	local f19_local0 = f19_arg0.frontend
	local f19_local1 = Enum[@"hash_C0AB9543C5C440B"][@"hash_6755065F5A0B7FB0"]
	if f19_local0 == false then
		f19_local1 = Enum[@"hash_C0AB9543C5C440B"][@"hash_6FA6FA0C00230DEE"]
	elseif false == Engine[@"isdedicatedserver"]() then
		local f19_local2 = LobbyData.GetCurrentMenuTarget()
		local f19_local3 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC)
		if f19_local2[@"id"] == f19_local3[@"id"] then
			Engine[@"setlobbymaxclients"](Enum[@"lobbytype"][@"lobby_type_private"], f19_local3[@"maxclients"])
			Engine[@"exec"](Engine[@"getprimarycontroller"](), "pubSemaphoreFetch 0")
		end
		local f19_local4 = 1200000
		if Dvar[@"hash_2A58B3AE6DE7CC7"]:exists() then
			f19_local4 = Dvar[@"hash_2A58B3AE6DE7CC7"]:get() * 60000
		end
		local f19_local5 = Lobby.MatchmakingAsync.GetLocalUserInfo(Engine[@"getprimarycontroller"]())
		if f19_local5 and f19_local5.xuid ~= LuaDefine.INVALID_XUID_X64 and f19_local4 <= Engine[@"milliseconds"]() - f19_local5.lastDCQoSSuccess then
			f19_local5.completedDCQoS = false
			f19_local5.hasInitiateDCQoS = false
		end
	end
	local f19_local2 = 0
	local f19_local3 = Engine[@"getmaxlocalcontrollers"]() - 1
	for f19_local4 = f19_local2, f19_local3, 1 do
		if Engine[@"iscontrollerbeingused"](f19_local4) then
			Engine[@"hash_61D2E041DAB54785"](f19_local4, Enum[@"lobbytype"][@"lobby_type_private"], f19_local1)
		end
	end
	for f19_local7, f19_local8 in pairs(LobbyVM.ClientsToRemove) do
		Engine[@"unsubscribeandfreemodel"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "LobbyClients." .. f19_local7))
	end
	LobbyVM.ClientsToRemove = {}
end
LobbyVM.TestChangeWhereIAm = function(f20_arg0)
	Engine[@"hash_61D2E041DAB54785"](0, Enum[@"lobbytype"][@"lobby_type_private"], f20_arg0.testNumber)
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
	Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_default"], "COM ERROR - errorCode: " .. LobbyVM.ComErrorCodeToString(f21_local1) .. ", errorMsg: " .. f21_local2 .. ".\n")
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.hideMenusForGameStart"), 0)
	if f21_local1 == Enum[@"errorcode"][@"error_softrestart"] or f21_local1 == Enum[@"errorcode"][@"error_softrestart_keepdw"] or f21_local1 == Enum[@"errorcode"][@"error_softrestart_silent"] then
		return
	elseif Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] and not Engine[@"issignedintodemonware"](f21_local0) then
		LobbyVM.OnErrorShutdown(f21_arg0)
	end
	if f21_local1 == Enum[@"errorcode"][@"error_ui"] or f21_local1 == Enum[@"errorcode"][@"error_disconnect"] or f21_local1 == Enum[@"errorcode"][@"error_fatal"] or f21_local1 == Enum[@"errorcode"][@"error_drop"] or f21_local1 == Enum[@"errorcode"][@"error_softrestart_keepdw"] or f21_local1 == Enum[@"errorcode"][@"error_softrestart_silent"] then
		return
	elseif f21_local1 == Enum[@"errorcode"][@"error_none"] or f21_local1 == Enum[@"errorcode"][@"error_lua"] or f21_local1 == Enum[@"errorcode"][@"error_from_startup"] or f21_local1 == Enum[@"errorcode"][@"error_localization"] or f21_local1 == Enum[@"errorcode"][@"error_serverdisconnect"] then
		LuaUtils.UI_ShowErrorMessageDialog(f21_local0, f21_local2)
		return
	elseif f21_local1 == Enum[@"errorcode"][@"error_script"] or f21_local1 == Enum[@"errorcode"][@"error_script_drop"] then
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
	Engine[@"lobbylaunchclear"]()
	if f26_local3 ~= nil and f26_local3 == true then
		LobbyVM.OnErrorShutdown(f26_arg0)
		LobbyVM.ShutdownCleanup(f26_arg0)
	end
	if f26_local1 == Enum[@"errorcode"][@"error_fatal"] then
		LuaUtils.UI_ShowErrorMessageDialog(f26_local0, f26_local2)
		local f26_local4 = Lobby.Process.Recover(f26_local0)
		if f26_local4 ~= nil then
			Lobby.ProcessQueue.AddToQueue("ErrorFatal", f26_local4)
		end
	elseif f26_local1 == Enum[@"errorcode"][@"error_drop"] then
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
		controller = Engine[@"getprimarycontroller"](),
		signoutUsers = false,
	}
	local f27_local1 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.FFOTDShutdown")
	Engine[@"setmodelvalue"](f27_local1, true)
	LobbyVM.OnErrorShutdown(f27_local0)
	Engine[@"setmodelvalue"](f27_local1, false)
end
LobbyVM.OnDWDisconnect = function(f28_arg0)
	local f28_local0 = f28_arg0.controller
	if not Engine[@"isdedicatedserver"]() then
		if f28_local0 == Engine[@"getprimarycontroller"]() then
			Engine[@"lobbyonlinecancel"](true)
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
	elseif Engine[@"islobbyinrecovery"](f30_local1) then
		return
	elseif f30_local5 == true and f30_local1 == Enum[@"lobbytype"][@"lobby_type_game"] then
		if Lobby.ProcessQueue.GetCurrentRunningProcessName() ~= "HostLeftNoMigrationGame" then
			local f30_local7 = Lobby.Process.Recover(f30_local0)
			if Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) then
				local f30_local8 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC)
				f30_local7 = Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking(f30_local0, f30_local8, f30_local8, LuaEnum.LEAVE_WITH_PARTY.WITH, true)
			end
			Lobby.ProcessQueue.AddToQueue("HostLeftNoMigrationGame", f30_local7)
		end
	else
		local f30_local7 = LobbyData.GetLobbyNav()
		if f30_local1 == Enum[@"lobbytype"][@"lobby_type_private"] and f30_local5 == false and (f30_local7 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f30_local7 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC)) then
			if Lobby.ProcessQueue.GetCurrentRunningProcessName() ~= "HostLeftNoMigrationSearch" then
				Lobby.ProcessQueue.AddToQueue("HostLeftNoMigrationSearch", Lobby.Process.Recover(f30_local0))
			end
		else
			Lobby.ProcessQueue.AddToQueue("HostLeftNoMigration", Lobby.Process.HostLeftNoMigrationCreatePrivateLobby(f30_local0, f30_local2, f30_local4))
		end
	end
	Engine[@"playsound"](LobbyData.Sounds.LobbyClosed)
	Engine[0xDE279ECDDDD966](f30_local0, @"hash_37ED422C1906DDFB", {
		[@"controller"] = f30_arg0.controller,
		[@"lobby_module"] = f30_arg0.lobbyModule,
		[@"hash_1A553941A735DE81"] = f30_arg0.lobbyMainMode,
		[@"hash_5862D3F1B0F11978"] = f30_arg0.lobbyNetworkMode,
		[@"max_clients"] = f30_arg0.maxClients,
		[@"hash_46B8AE8B89BF06C2"] = f30_arg0.isGameLobbyActive,
		[@"hash_4B3088C31338F710"] = f30_arg0.isPrivateHost,
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
	Engine[@"playsound"](LobbyData.Sounds.LobbyClosed)
	Engine[0xDE279ECDDDD966](f31_local0, @"hash_2E50E3FBE0A7A1C6", {
		[@"controller"] = f31_arg0.controller,
	})
end
LobbyVM.OnLobbyHostLeftMigrateFinished = function(f32_arg0)
	local f32_local0 = f32_arg0.controller
	local f32_local1 = f32_arg0.lobbyType
	local f32_local2 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f32_local3 = false
	local f32_local4 = LobbyData.GetCurrentMenuTarget()
	if f32_local1 == Enum[@"lobbytype"][@"lobby_type_private"] and f32_local2 == false and (f32_local4[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f32_local4[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) or f32_local4[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING)) then
		f32_local3 = true
	end
	if f32_local3 == true then
		local f32_local5, f32_local6 = Lobby.Process.GetBackFunc(f32_local4)
		Lobby.ProcessQueue.AddToQueue("LobbyMigrationFinished", f32_local6(f32_local0, f32_local4, f32_local5, LuaEnum.LEAVE_WITH_PARTY.WITH))
	end
	if f32_local1 == Enum[@"lobbytype"][@"lobby_type_private"] then
		Engine[@"luivm_event"]("open_toaster_popup", {
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
	if LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) == Engine[@"getlobbyuiscreen"]() then
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
		f37_local0 = Engine[@"getprimarycontroller"]()
	end
	if f37_local4 == nil then
		error("LobbyVM: No menu called '" .. currentMenu .. "' found.")
	end
	if f37_local5 == nil then
		error("LobbyVM: No menu called '" .. f37_local1 .. "' found.")
	end
	local f37_local6 = Lobby.Process.GetForwardFunc(f37_local4, f37_local5)
	if f37_local6 == nil then
		error("LobbyVM: No forward process function found to move from '" .. f37_local4[@"name"] .. "' to '" .. f37_local1 .. "'.")
	end
	local f37_local7 = f37_local6(f37_local0, f37_local4, f37_local5, f37_arg0)
	if f37_local7 ~= nil and f37_local3 == true then
		if Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) == true then
			local f37_local8 = Lobby.Process.ManagePartyLeave(f37_local0)
			Lobby.Process.AppendProcess(f37_local8, f37_local7)
			Lobby.ProcessQueue.AddToQueue("GoForward from '" .. f37_local4[@"name"] .. "' menu to '" .. f37_local5[@"name"] .. "' menu AND ManagePartyLeave", f37_local8)
		else
			local f37_local8 = Lobby.Process.ReloadPrivateLobby(f37_local0, Engine[@"getlobbynetworkmode"]())
			Lobby.Process.AppendProcess(f37_local8, f37_local7)
			Lobby.ProcessQueue.AddToQueue("GoForward from '" .. f37_local4[@"name"] .. "' menu to '" .. f37_local5[@"name"] .. "' menu AND PartyMemberLeave", f37_local8)
		end
		return
	end
	Lobby.ProcessQueue.AddToQueue("GoForward from '" .. f37_local4[@"name"] .. "' menu to '" .. f37_local5[@"name"] .. "' menu.", f37_local7)
end
LobbyVM.OnGoBack = function(f38_arg0)
	if Lobby.Launch.IsHostLaunching() then
		return
	end
	local f38_local0 = Engine[@"getprimarycontroller"]()
	local f38_local1 = f38_arg0.withParty
	local f38_local2 = LobbyData.GetLobbyMenuByID(LobbyData.GetLobbyNav())
	if f38_local2 == nil then
		error("LobbyVM: No menu called '" .. currentMenu .. "' found.")
	end
	local f38_local3, f38_local4 = Lobby.Process.GetBackFunc(f38_local2)
	if f38_local3 == nil or f38_local4 == nil then
		error("LobbyVM: No back process function found for '" .. currentMenu("'."))
	end
	Lobby.ProcessQueue.AddToQueue("GoBackFrom" .. f38_local2[@"name"], f38_local4(f38_local0, f38_local2, f38_local3, f38_local1))
end
LobbyVM.OnManagePartyLeave = function(f39_arg0)
	if Lobby.Launch.IsHostLaunching() then
		return
	end
	local f39_local0 = f39_arg0.controller
	if Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) == true then
		Lobby.ProcessQueue.AddToQueue("ManagePartyLeave", Lobby.Process.ManagePartyLeave(f39_local0))
	else
		Lobby.ProcessQueue.AddToQueue("PartyMemberLeave", Lobby.Process.ReloadPrivateLobby(f39_local0, Engine[@"getlobbynetworkmode"]()))
	end
end
LobbyVM.OnCreateDedicatedLANLobby = function()
	local f40_local0 = LuaEnum.UI.DIRECTOR_LAN_MP
	if Dvar[@"hash_6A56A9C383009025"]:exists() and Dvar[@"hash_6A56A9C383009025"]:get() == "wz" then
		f40_local0 = LuaEnum.UI.DIRECTOR_LAN_WZ
	end
	Lobby.ProcessQueue.AddToQueue("CreateDedicatedLANLobby", Lobby.Process.CreateDedicatedLANLobby(0, LobbyData.GetLobbyMenuByName(f40_local0)))
end
LobbyVM.OnCreateDedicatedLobby = function(f41_arg0)
	if Dvar[@"hash_44BADE8473F0165F"]:get() == true then
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
		f45_local0 = Enum[@"lobbymodule"][@"lobby_module_host"]
	end
	local f45_local1 = f45_arg0.lobbyType
	local f45_local2 = f45_arg0.lobbyMode
	if Engine[@"getdvarbool"]("lobbyMigrate_Enabled") == false or Engine[@"getdvarbool"]("lobbyMigrate_dedicatedOnly") == true or Engine[@"getdvarbool"]("lobbyMigrate_EnabledLAN") == false and Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] == Engine[@"getlobbynetworkmode"]() then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_migration"], "Cannot become host, failed lobby migrateable check\n")
		return false
	elseif f45_local1 == Enum[@"lobbytype"][@"lobby_type_transition"] then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_migration"], "Cannot become host, lobby type is LOBBY_TYPE_TRANSITION\n")
		return false
	elseif Engine[@"islobbyactive"](f45_local0, f45_local1) == false then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_migration"], "Cannot become host, requested lobby is not active\n")
		return false
	else
		local f45_local3 = LobbyData.GetCurrentMenuTarget()
		if f45_local3[@"hasmigration"] ~= 1 then
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_migration"], "Cannot become host, lobby menu does not allow migration\n")
			return false
		elseif Engine[@"islobbyinrecovery"](f45_local1) then
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_migration"], "Cannot become host, lobby is in recovery\n")
			return false
		elseif true == LuaUtils.IsArenaMode() then
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_migration"], "Cannot become host, migration is not allowed in arena\n")
			return false
		elseif false == Lobby.ProcessQueue.IsQueueEmpty() then
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_migration"], "Cannot become host, process queue is not empty\n")
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
	Dvar[@"lobby_maxlocalplayers"]:set(math.min(f47_arg0[@"maxlocalclients"], Engine[@"getmaxlocalcontrollers"]()))
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
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Tried to apply settings for an invalid target.@\n")
		return
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Applying settings for menu: " .. f48_local1[@"name"] .. ".\n")
	if not Engine[@"isinventorybusy"](f48_local0) and Engine[@"hash_5CB675CA7856DA25"]() and f48_local1[@"mainmode"] ~= Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"] and f48_local1[@"mainmode"] ~= Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
		LuaUtils.SafeComError(Enum[@"errorcode"][@"error_softrestart_keepdw"], @"menu/join_result_full_version_required_title")
	end
	if not Engine[@"isinventorybusy"](f48_local0) and f48_local1[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
		if Engine[@"hash_3A8FBC7AC4C3F3A6"]() then
			LuaUtils.SafeComError(Enum[@"errorcode"][@"error_softrestart_keepdw"], @"menu/korea_15plus_blocked_gamemode")
		elseif Engine[@"hash_45405A6484A88367"]() then
			LuaUtils.SafeComError(Enum[@"errorcode"][@"error_softrestart_keepdw"], @"menu/join_result_full_version_required_title")
		end
	end
	if not f48_local2 then
		local f48_local4 = Engine[@"getlobbymainmode"]()
		local f48_local5 = f48_local1[@"mainmode"]
		if Engine[@"switchcampaignmode"] then
			Engine[@"switchcampaignmode"](Enum[@"campaignmode"][0xBC3515387CDAB7])
		end
		if f48_local4 ~= f48_local5 then
			Engine[@"switchmode"](f48_local0, Lobby.Core.GetMainModeStr(f48_local5))
		end
	end
	if f48_local3 ~= true and f48_local1[@"egamemodes"] == Enum[@"egamemodes"][@"mode_game_invalid"] then
		Engine[@"resetgametypesettings"]()
	end
	LobbyVM.SetMaxLocalPlayers(f48_local1)
	Engine[@"setlobbymode"](f48_local1[@"lobbytype"], f48_local1[@"lobbymode"])
	Engine[@"tempgamemodesetmode"](f48_local1[@"egamemodes"])
	Engine[@"setlobbymaxclients"](f48_local1[@"lobbytype"], f48_local1[@"maxclients"])
end
LobbyVM.OnSessionModeChange = function(f49_arg0)
	Lobby.CharacterSelection.OnSetGametype()
	if f49_arg0.toMode == Enum[@"emodes"][@"mode_warzone"] then
		for f49_local0 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
			Lobby.Stats.ValidateWZCharacterSelection(f49_local0)
		end
	elseif f49_arg0.toMode == Enum[@"emodes"][@"mode_zombies"] then
		for f49_local0 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
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
	local f50_local4 = Engine[@"getlobbylobbyid"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	if f50_local4 ~= LobbyVM.lobbyID then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.showSelect"), true)
		LobbyVM.lobbyID = f50_local4
	end
	Engine[@"setlobbyuiscreen"](f50_local0[@"id"])
	LobbyData.SetLobbyNav(f50_local0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyMode", true), f50_local0[@"lobbymode"])
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyMainMode", true), f50_local0[@"mainmode"])
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyGameMode", true), f50_local0[@"egamemodes"])
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.room", true), f50_local3(f50_local0[@"room"]))
	CoDShared[@"hash_3562F4B21BD0FAB0"](f50_local1, f50_local0[@"mainmode"])
	if f50_local2 then
		local f50_local5 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME)
		if f50_local5 ~= nil and f50_local0[@"id"] == f50_local5[@"id"] then
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
	local f52_local0 = Engine[@"getlobbyhostcontrollerindex"](Enum[@"lobbytype"][@"lobby_type_private"])
	local f52_local1 = Engine[@"hash_1E42CF04B7DDD5DE"](LobbyMsg.EncodeToLobbyMsgType(LobbyMsg.LuaMsgType.LUA_MESSAGE_TYPE_LOBBY_CLIENT_RESET_LOADOUTS), Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_private"])
	f52_local1:sendTo(f52_local0, Enum[@"lobbymodule"][@"hash_2DAA8D01F295C885"], Enum[@"netchanmsgtype_e"][@"netchan_lobbyprivate_reliable"])
	f52_local1:free()
end
LobbyVM.Leaderboard_PopulateCustomList = function(f53_arg0)
	return Lobby.Leaderboard.PopulateCustomList(f53_arg0)
end
LobbyVM.CheckDLCBit = function(f54_arg0, f54_arg1)
	return f54_arg0 & f54_arg1 == f54_arg1
end
LobbyVM.LaunchGameExec = function(f55_arg0, f55_arg1)
	if f55_arg1 ~= Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]) then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Launch game not supported for this lobby type(" .. f55_arg1 .. ")\n")
		return false
	elseif Lobby.ProcessQueue.IsQueueEmpty() then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "** Launching game... **\n")
		Engine[@"exec"](f55_arg0, "lobbyLaunchGame")
		return true
	else
		local f55_local0 = Lobby.ProcessQueue.GetQueueHead()
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Warning: Could not launch game. Lobby process '" .. f55_local0.name .. "' in progress.\n")
		return false
	end
end
LobbyVM.LaunchDemoExec = function(f56_arg0, f56_arg1)
	if f56_arg1 ~= Enum[@"lobbytype"][@"lobby_type_private"] then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Launch demo not supported for this lobby type(" .. f56_arg1 .. ")\n")
		return
	elseif Lobby.ProcessQueue.IsQueueEmpty() then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "** Launching demo... **\n")
		Engine[@"exec"](f56_arg0, "lobbyLaunchDemo")
		LuaUtils.UI_ClearErrorMessageDialog()
	else
		local f56_local0 = Lobby.ProcessQueue.GetQueueHead()
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Warning: Could not launch damo. Lobby process '" .. f56_local0.name .. "' in progress.\n")
	end
end
LobbyVM.GetBitsForLockedInMap = function()
	local f57_local0 = Engine[@"lobbygetmap"]()
	if f57_local0 == nil or f57_local0 == "" then
		f57_local0 = Engine[@"getcurrentmap"]()
	end
	return Engine[@"getdlcbitformapname"](f57_local0)
end
LobbyVM.GetNeededDLCBits = function()
	local f58_local0 = Engine[@"getlobbyuiscreen"]()
	if f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) or f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) then
		return Lobby.Matchmaking.GetMapPackBits(CoDShared.GetLobbyDLCBits(Engine[@"getlobbymainmode"](), Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"]), Engine[@"getplaylistid"]())
	elseif f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME) or f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME) then
		return 0
	elseif f58_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		return 0
	end
	local f58_local1 = Engine[@"lobbygetmap"]()
	if f58_local1 == nil or f58_local1 == "" then
		f58_local1 = Engine[@"getcurrentmap"]()
	end
	return Engine[@"getdlcbitformapname"](f58_local1)
end
LobbyVM.TriggerQuitMissingMapProcess = function(f59_arg0, f59_arg1)
	Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyclient"], "Leaving game because map '" .. Engine[@"lobbygetmap"]() .. "' is in contentpack '" .. f59_arg1 .. "' but our dlcbits is '" .. f59_arg0 .. "'.\n")
	local f59_local0 = Lobby.Process.Recover(Engine[@"getprimarycontroller"]())
	Lobby.Process.ForceAction(f59_local0.tail, Lobby.Actions.ErrorPopupMsg(@"platform/missingmap"))
	Lobby.ProcessQueue.AddToQueue("MissingMap", f59_local0)
end
LobbyVM.DLCMapCheck = function()
	local f60_local0 = CoDShared.GetLobbyDLCBits(Engine[@"getlobbymainmode"](), Enum[@"lobbymodule"][@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
	local f60_local1 = LobbyVM.GetNeededDLCBits()
	if not LobbyVM.CheckDLCBit(f60_local0, f60_local1) then
		LobbyVM.TriggerQuitMissingMapProcess(f60_local0, f60_local1)
		return false
	else
		return true
	end
end
LobbyVM.CanLoadMap = function()
	local f61_local0 = CoDShared.GetLobbyDLCBits(Engine[@"getlobbymainmode"](), Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
	local f61_local1 = LobbyVM.GetBitsForLockedInMap()
	if not LobbyVM.CheckDLCBit(f61_local0, f61_local1) then
		LobbyVM.TriggerQuitMissingMapProcess(f61_local0, f61_local1)
		return false
	else
		return true
	end
end
LobbyVM.CanClientLaunch = function(f62_arg0)
	if CoDShared.IsMapFree(Engine[@"converttoxhash"](Engine[@"lobbygetmap"]()), Engine[@"getlobbyuiscreen"](), Engine[@"getplaylistid"]()) then
		return true
	elseif LobbyVM.CanLoadMap() == false then
		Engine[@"lobbylaunchclear"]()
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
	if f65_arg0.lobbyType == Enum[@"lobbytype"][@"lobby_type_game"] then
		Lobby.Matchmaking.UpdateAdvertising("force update from code")
	end
end
LobbyVM.UGCOffensiveEmblemAdd = function(f66_arg0)
	Lobby.UGC.OffensiveEmblemAdd(f66_arg0)
end
LobbyVM.OnChangeSigninState = function(f67_arg0)
	local f67_local0 = nil
	if f67_arg0.onlineState == Enum[@"liveuserstate"][@"live_user_signed_out"] then
		Lobby.Anticheat.OnControllerSignedOut(f67_arg0.controller)
		if f67_arg0.isPrimary then
			f67_local0 = Lobby.Process.PrimaryControllerSignedOut(f67_arg0.controller)
		end
	elseif f67_arg0.onlineState == Enum[@"liveuserstate"][@"live_user_signed_in"] then
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
	elseif LobbyVM.lobbyStatus.clearedTime > Engine[@"milliseconds"]() then
		return
	else
		LobbyVM.lobbyStatus.cleared = true
		local f68_local0 = Engine[@"getglobalmodel"]()
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
	if not Engine[@"ismainthreadorproxy"]() then
		return
	end
	local f69_local0 = Engine[@"getglobalmodel"]()
	f69_local0 = f69_local0.lobbyRoot
	local f69_local1 = f69_local0:create("lobbyStatusString1")
	local f69_local2 = f69_local0:create("lobbyStatusString2")
	local f69_local3 = f69_local0:create("lobbyStatusString3")
	LobbyVM.lobbyStatus.cleared = false
	LobbyVM.lobbyStatus.clearedTime = Engine[@"milliseconds"]() + 10000
	local f69_local4 = f69_arg0.searchStage
	local f69_local5 = ""
	if f69_local4 == 1 then
		local f69_local6 = f69_arg0.numResults
		if f69_local6 == 1 then
			f69_local5 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_2E4043BEC55997D7")
		else
			f69_local5 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F5C23E745BBA03A", f69_local6)
		end
		f69_local1:set(f69_local5)
		f69_local2:set("")
		f69_local3:set("")
	elseif f69_local4 == 2 then
		f69_local2:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_614406E6B65BB0D6", f69_arg0.contactedResults, f69_arg0.numResults))
	elseif f69_local4 == 3 then
		f69_local3:set(Engine[@"hash_4F9F1239CFD921FE"](@"hash_75AE8C0E42569E25", f69_arg0.joiningCurHost, f69_arg0.joiningNumHosts))
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
	if f74_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_public"] or f74_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_arena"] then
		local f74_local1 = Engine[@"getplaylistinfobyid"](Engine[@"getplaylistid"]())
		if f74_local1 then
			local f74_local2 = f74_local1.name
			local f74_local3 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyPlaylist")
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f74_local3, "name"), Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](f74_local2)))
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f74_local3, "kickerText"), 0x0)
		end
	end
	Lobby.MapVote.GameLobbyGameServerDataUpdate(f74_arg0)
end
LobbyVM.OnPrivateLobbyServerDataUpdate = function(f75_arg0)
	local f75_local0 = LobbyData.GetCurrentMenuTarget()
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		local f75_local1 = Engine[@"getglobalmodel"]()
		f75_local1 = f75_local1:create("lobbyRoot.fillParty")
		f75_local1:set(f75_arg0.fillParty)
	end
	if f75_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_public"] or f75_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_arena"] then
		local f75_local2 = Engine[@"getplaylistinfobyid"](Engine[@"getplaylistid"]())
		if f75_local2 then
			local f75_local3 = f75_local2.name
			local f75_local4 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyPlaylist")
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f75_local4, "name"), Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](f75_local3)))
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f75_local4, "kickerText"), 0x0)
		end
	end
end
LobbyVM.OnGameLobbyClientDataUpdate = function(f76_arg0)
	Lobby.MapVote.GameLobbyClientDataUpdate(f76_arg0)
	Lobby.TeamSelection.GameLobbyClientDataUpdate(f76_arg0)
	Lobby.Pregame.GameLobbyClientDataUpdate(f76_arg0)
	LuaUtils.ForceLobbyButtonUpdate()
	Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.gameClientDataUpdate"))
end
LobbyVM.OnDediQosReady = function()
	local f77_local0 = Engine[@"getdediqosresultsbytype"](Lobby.Matchmaking.DatacenterType.ANY)
	if f77_local0.numResults == 0 then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Engine told us results were ready, but no results available\n")
	else
		servers = f77_local0.pingResults
		for f77_local4, f77_local5 in ipairs(servers) do
			Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_6744BF3845B0D442", {
				[@"location"] = f77_local5.location,
				[@"ping"] = f77_local5.ping,
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
			Engine[@"leaveserverimmediately"]()
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
	local f83_local3 = Engine[@"tablefindrows"](f83_local0, f83_local1, f83_arg0)
	if f83_local3 == nil or #f83_local3 == 0 then
		return -1
	else
		local f83_local4 = Engine[@"tablelookupgetcolumnvalueforrow"](f83_local0, f83_local3[1], f83_local2)
		if f83_local4 == nil then
			return -1
		else
			return f83_local4
		end
	end
end
LobbyVM.GetRecentItemTags = function(f84_arg0, f84_arg1)
	local f84_local0 = Engine[@"getlootitems"](f84_arg0, Enum[@"emodes"][@"mode_multiplayer"], 0, Engine[@"getlootitemcount"](f84_arg0, Enum[@"emodes"][@"mode_multiplayer"]))
	local f84_local1 = LuaUtils.GetCurrentLootVersion()
	local f84_local2 = "gamedata/loot/mplootitems.csv"
	local f84_local3 = Engine[@"tablefindrows"](f84_local2, 2, f84_arg1)
	local f84_local4 = 6
	local f84_local5 = 0
	for f84_local10, f84_local11 in ipairs(f84_local3) do
		local f84_local9 = Engine[@"tablelookupgetcolumnvalueforrow"](f84_local2, f84_local11, f84_local4)
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
	local f85_local4 = ' "InventoryVersion": [ ' .. Dvar[@"loot_mpitemversions"]:get() .. " ] "
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
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_default"], "Excluding: " .. f85_local3 .. ".\n")
	end
	return f85_local0 .. f85_local1 .. f85_local2 .. f85_local3 .. f85_local4
end
LobbyVM.DLCInfo = {
	{
		dlcIndex = Enum[@"dlcindex_t"][@"content_dlc1_index"],
		dlcPackName = "dlc1",
		inventoryVersion = 101,
	},
	{
		dlcIndex = Enum[@"dlcindex_t"][@"content_dlc2_index"],
		dlcPackName = "dlc2",
		inventoryVersion = 102,
	},
	{
		dlcIndex = Enum[@"dlcindex_t"][@"content_dlc3_index"],
		dlcPackName = "dlc3",
		inventoryVersion = 103,
	},
	{
		dlcIndex = Enum[@"dlcindex_t"][@"content_dlc4_index"],
		dlcPackName = "dlc4",
		inventoryVersion = 104,
	},
}
LobbyVM.OnSpendVials = function(f86_arg0)
	local f86_local0 = ' "NumVials": ' .. f86_arg0.vialCount .. ", "
	local f86_local1 = ' "InventoryVersion": [' .. Dvar[@"loot_zmitemversions"]:get() .. " "
	local f86_local2 = Engine[@"getdvarint"]("tu9_highestAvailableDLC")
	for f86_local6, f86_local7 in ipairs(LobbyVM.DLCInfo) do
		if f86_local7.dlcIndex <= f86_local2 and Engine[@"hasentitlement"](f86_arg0.controller, Engine[@"converttoxhash"](f86_local7.dlcPackName)) then
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
		if Engine[@"getinventoryitemquantity"](f87_arg0.controller, tonumber(Engine[@"tablelookup"](nil, f87_local1, f87_local2, f87_local9, f87_local3))) > 0 then
			Engine[@"setprofilevar"](f87_arg0.controller, f87_local9, "1")
			f87_local4 = true
		end
	end
	if f87_local4 then
		Engine[@"commitprofilechanges"](f87_arg0.controller)
	end
end
LobbyVM.CheckSpecialPlaylistRules = function(f88_arg0)
	if Dvar[@"partychatdisallowed"]:get() == true then
		if Engine[@"islocalclientinplatformpartychat"]() and not Engine[@"isincomerror"]() then
			Dvar[@"partychatdisallowed"]:set(false)
			Engine[@"comerror"](Enum[@"errorcode"][@"error_drop"], Engine[@"hash_4F9F1239CFD921FE"](@"hash_422BE13738744598"))
		end
		local f88_local0 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"])
		for f88_local4, f88_local5 in ipairs(f88_local0.sessionClients) do
			if f88_local5.isInPlatformPartyChat == true then
				Engine[@"kickclient"](f88_arg0, Enum[@"lobbytype"][@"lobby_type_game"], f88_local5.xuid, Enum[@"lobbydisconnectclient"][@"lobby_disconnect_client_nopartychat"], @"hash_422BE13738744598")
			end
		end
	end
end
LobbyVM.IngameMonitor = function()
	if not Engine[@"isingame"]() then
		return
	elseif (Engine[@"isdedicatedserver"]() or CoDShared.IsLobbyMode(Enum[@"lobbymode"][@"lobby_mode_public"])) and Dvar[@"partychatdisallowed"]:get() and Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		local f89_local0 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"])
		local f89_local1 = Engine[@"getlobbyhostcontrollerindex"](Enum[@"lobbytype"][@"lobby_type_game"])
		for f89_local5, f89_local6 in ipairs(f89_local0.sessionClients) do
			if f89_local6.isInPlatformPartyChat == true then
				Engine[@"kickclient"](f89_local1, Enum[@"lobbytype"][@"lobby_type_game"], f89_local6.xuid, Enum[@"lobbydisconnectclient"][@"lobby_disconnect_client_nopartychat"], @"hash_422BE13738744598")
			end
		end
	end
end
LobbyVM.OnMessageReceived = function(f90_arg0)
	if f90_arg0.msgType == Enum[@"msgtype"][@"message_type_lobby_host_lobby_move"] then
		LobbyVM.ProcesMoveLobby(f90_arg0)
	end
end
LobbyVM.ProcesMoveLobby = function(f91_arg0)
	local f91_local0 = f91_arg0.controller
	local f91_local1 = f91_arg0.lobbyType
	local f91_local2 = f91_arg0.lobbyTypeMoveFrom
	local f91_local3 = f91_local1
	Engine[@"copylobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"], f91_local2, f91_local3)
	Engine[@"clearlobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"], f91_local3)
	Engine[@"clearlobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"], f91_local2)
	Engine[@"clearlobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"], f91_local2)
	local f91_local4 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f91_local3)
	for f91_local8, f91_local9 in ipairs(f91_local4.sessionClients) do
		Engine[@"hash_35D28F97B2C14CD7"](f91_local0, f91_local3, f91_local9.xuid)
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
				Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyclient"], "Unknown publisher variable type [" .. f92_local3 .. "] \n")
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
		Engine[@"lobbyevent"](f92_arg0.name, f92_local0)
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
	local f94_local4 = Engine[@"getlobbynetworkmode"]()
	local f94_local5
	if f94_local4 ~= Enum[@"lobbynetworkmode"][@"lobby_networkmode_invalid"] and f94_local4 ~= Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] then
		f94_local5 = false
	else
		f94_local5 = true
	end
	if f94_local5 == false and f94_local0 == Enum[@"lobbytype"][@"lobby_type_private"] and f94_local1 + f94_local2 + f94_local3 > Dvar[@"hash_4FF45B41C6046F8"]:get() then
		return false
	else
		return true
	end
end
LobbyVM.OnLobbyAsyncMatchmakerStart = function(f95_arg0)
	if Lobby.ProcessQueue.GetCurrentRunningProcessName() ~= "FindWarZoneServer" and Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		Lobby.ProcessQueue.AddToQueue("FindWarZoneServer", Lobby.Process.AsyncMatchmakingStartAsyncMatchmaker(f95_arg0.controller))
	end
end
LobbyVM.OnLobbyAsyncMatchmakerRedeploy = function(f96_arg0)
	if Lobby.ProcessQueue.GetCurrentRunningProcessName() ~= "Redeploy" and Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_warzone"] then
		Lobby.ProcessQueue.AddToQueue("Redeploy", Lobby.Process.AsyncMatchmakingStartAsyncMatchmaker(f96_arg0.controller))
	end
end
LobbyVM.TestFFOTDFnOverride = function()
	Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_live"], "Failed to override Lobby VM funtion from FFOTD.\n")
	error("Failed to override Lobby VM funtion from FFOTD.")
end
require("x64:eef8dcfe7b2aafc")
