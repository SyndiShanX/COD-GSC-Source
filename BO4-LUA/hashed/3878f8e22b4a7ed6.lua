require("x64:53e8db3768fb02a")
Lobby.Launch = {}
Lobby.Launch.hostLaunch = {}
Lobby.Launch.clientLaunch = {}
Lobby.Launch.printInterval = 5000
Lobby.Launch.IsHostLaunching = function()
	if Lobby.Launch.hostLaunch.startTime ~= nil then
		return true
	elseif Engine[@"lobbyhostlaunchtaskinprogress"] and Engine[@"lobbyhostlaunchtaskinprogress"]() then
		return true
	else
		return false
	end
end
Lobby.Launch.OnHostLaunch = function(f2_arg0)
	if f2_arg0.stage == Enum[@"launchgamestate"][@"launch_game_state_start"] then
		return Lobby.Launch.HostLaunchInit()
	elseif f2_arg0.stage == Enum[@"launchgamestate"][@"launch_game_state_pump"] then
		return Lobby.Launch.HostLaunchPump(f2_arg0)
	else
		Engine[@"hash_3141E84ACAAE0A4E"]()
		return Lobby.Launch.HostLaunchClear()
	end
end
Lobby.Launch.HostLaunchInit = function()
	Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.closePopups"))
	Lobby.Launch.hostLaunch = {}
	Lobby.Launch.hostLaunch.fadeToBlack = false
	local f3_local0 = Engine[@"milliseconds"]()
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.hideMenusForGameStart"), 1)
	Lobby.Launch.hostLaunch.startTime = f3_local0
	Lobby.Launch.hostLaunch.printAtTime = f3_local0 + Lobby.Launch.printInterval
	Lobby.Launch.hostLaunch.fadeToBlackTime = f3_local0 + Dvar[@"lobbylaunch_fadetoblackdelay"]:get()
	Lobby.Launch.hostLaunch.launchTime = f3_local0 + Dvar[@"lobbylaunch_gamelaunchdelay"]:get()
	Lobby.Launch.hostLaunch.waitForClientAckTime = f3_local0 + Dvar[@"lobbylaunch_waitforclientackdelay"]:get()
	Lobby.Timer.ResetUIModel()
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive"), true)
	return true
end
Lobby.Launch.MapImagePreloading = function(f4_arg0)
	local f4_local0 = false
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_zombies"] then
		if (Engine[@"getlobbyclientcount"](f4_arg0, Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]), Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]) or 0) <= 1 and Engine[@"lobbygetgametype"]() ~= "ztutorial" then
			f4_local0 = false
		else
			f4_local0 = true
		end
	end
	local f4_local1 = Engine[@"converttoxhash"](Engine[@"lobbygetmap"]())
	local f4_local2
	if not f4_local0 then
		f4_local2 = LuaUtils.GetMapsTable()
		f4_local2 = f4_local2[f4_local1]
		if f4_local2 then
			f4_local2 = LuaUtils.GetMapsTable()
			f4_local2 = f4_local2[f4_local1].introMovie
		end
	else
		f4_local2 = false
	end
	if f4_local2 then
		return false
	end
	local f4_local3 = LuaUtils.GetMapsTable()
	f4_local3 = f4_local3[f4_local1]
	if f4_local3 then
		f4_local3 = LuaUtils.GetMapsTable()
		f4_local3 = f4_local3[f4_local1].loadingImage
	end
	if f4_local3 and not Engine[@"hash_8A31148EE1BE3B1"](f4_local3) then
		return true
	end
	return false
end
Lobby.Launch.HostLaunchPump = function(f5_arg0)
	local f5_local0 = Engine[@"getlobbyuiscreen"]()
	if f5_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) then
		local f5_local1 = false
		local f5_local2 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
		if f5_local2 < Dvar[@"party_minplayers"]:get() then
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.Launch.LaunchGameExec: Not enough players (" .. tostring(f5_local2) .. "/" .. tostring(Dvar[@"party_minplayers"]:get()) .. "), restart timer.\n")
			f5_local1 = true
		end
		if CoDShared.IsGametypeTeamBased() == true and Engine[@"currentsessionmode"]() ~= Enum[@"emodes"][@"mode_warzone"] then
			local f5_local3 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"])
			if f5_local3 ~= nil then
				local f5_local4 = 0
				local f5_local5 = 0
				for f5_local9, f5_local10 in ipairs(f5_local3.sessionClients) do
					if f5_local10.team == Enum[@"team_t"][@"team_allies"] then
						f5_local4 = f5_local4 + 1
					end
					if f5_local10.team == Enum[@"team_t"][@"team_axis"] then
						f5_local5 = f5_local5 + 1
					end
				end
				if math.abs(f5_local4 - f5_local5) > 1 then
					Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.Launch.LaunchGameExec: Teams are not balanced (teamAlliesCount: " .. tostring(f5_local4) .. "/teamAxisCount: " .. tostring(f5_local5) .. "), restart timer.\n")
					f5_local1 = true
				end
			end
		end
		if Engine[@"isdevelopmentbuild"]() and Engine[@"getdvarbool"]("lobby_forceBalanced") == true then
			f5_local1 = false
		end
		if f5_local1 == true then
			Engine[@"lobbylaunchclear"]()
			Lobby.Launch.HostLaunchClear()
			local f5_local3 = LobbyData.GetLobbyMenuByID(f5_local0)
			Lobby.Timer.HostingLobby({
				controller = Engine[@"getprimarycontroller"](),
				lobbyType = Enum[@"lobbytype"][@"lobby_type_game"],
				mainMode = f5_local3[@"mainmode"],
				lobbyTimerType = f5_local3[@"hash_5558B67A321D1120"],
				matchEnded = true,
				status = Lobby.Timer.LOBBY_STATUS.RESET_TO_NEED,
			})
			return false
		end
	end
	if Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive")) == false then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive"), true)
	end
	if not f5_arg0.hasAllClientsGotLatestStateMsg and Engine[@"milliseconds"]() < Lobby.Launch.hostLaunch.waitForClientAckTime then
		return false
	elseif not Engine[@"isdedicatedserver"]() then
		if Lobby.Launch.MapImagePreloading(Enum[@"lobbymodule"][@"lobby_module_host"]) then
			return false
		elseif not Engine[@"iscommonfastfileloaded"]() then
			local f5_local1 = Engine[@"milliseconds"]()
			if f5_local1 > Lobby.Launch.hostLaunch.printAtTime then
				Lobby.Launch.hostLaunch.printAtTime = f5_local1 + Lobby.Launch.printInterval
				Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Waiting for common FF \n")
			end
			return false
		end
	end
	if Engine[@"currentsessionmode"]() ~= Enum[@"emodes"][@"mode_warzone"] then
		Engine[@"markplaylistrotationentryplayed"](Enum[@"lobbymodule"][@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]))
	end
	return true
end
Lobby.Launch.HostLaunchClear = function()
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.hideMenusForGameStart"), 0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive"), false)
	Lobby.Launch.hostLaunch.startTime = nil
	return true
end
Lobby.Launch.OnClientLaunch = function(f7_arg0)
	if f7_arg0.stage == Enum[@"launchgamestate"][@"launch_game_state_start"] then
		return Lobby.Launch.ClientLaunchInit(f7_arg0.justConnected)
	elseif f7_arg0.stage == Enum[@"launchgamestate"][@"launch_game_state_pump"] then
		return Lobby.Launch.ClientLaunchPump()
	else
		Engine[@"hash_3141E84ACAAE0A4E"]()
		return Lobby.Launch.ClientLaunchClear()
	end
end
Lobby.Launch.ClientLaunchInit = function(f8_arg0)
	if not LobbyVM.CanClientLaunch(f8_arg0) then
		return false
	end
	Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.closePopups"))
	Lobby.Launch.clientLaunch = {}
	Lobby.Launch.clientLaunch.fadeToBlack = false
	local f8_local0 = Dvar[@"lobbylaunch_fadetoblackdelay"]:get()
	local f8_local1 = Dvar[@"lobbylaunch_gamelaunchdelay"]:get()
	if f8_arg0 then
		f8_local0 = Dvar[@"lobbylaunch_fadetoblackdelayonconnect"]:get()
		f8_local1 = Dvar[@"lobbylaunch_gamelaunchdelayonconnect"]:get()
	end
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.hideMenusForGameStart"), 1)
	local f8_local2 = Engine[@"milliseconds"]()
	Lobby.Launch.clientLaunch.startTime = f8_local2
	Lobby.Launch.clientLaunch.fadeToBlackTime = f8_local2 + f8_local0
	Lobby.Launch.clientLaunch.launchTime = f8_local2 + f8_local1
	Lobby.Launch.clientLaunch.printAtTime = f8_local2 + Lobby.Launch.printInterval
	Lobby.Timer.ResetUIModel()
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive"), true)
	return true
end
Lobby.Launch.ClientLaunchPump = function()
	if Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive")) == false then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive"), true)
	end
	if false == Lobby.Launch.clientLaunch.fadeToBlack and Engine[@"milliseconds"]() > Lobby.Launch.clientLaunch.fadeToBlackTime then
		Lobby.Launch.clientLaunch.fadeToBlack = true
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.hideMenusForGameStart"), 1)
	end
	if Lobby.Launch.MapImagePreloading(Enum[@"lobbymodule"][@"lobby_module_client"]) then
		return false
	elseif Lobby.Launch.clientLaunch.launchTime ~= nil and Engine[@"milliseconds"]() < Lobby.Launch.clientLaunch.launchTime then
		return false
	elseif not Engine[@"iscommonfastfileloaded"]() then
		local f9_local0 = Engine[@"milliseconds"]()
		if f9_local0 > Lobby.Launch.clientLaunch.printAtTime then
			Lobby.Launch.clientLaunch.printAtTime = f9_local0 + Lobby.Launch.printInterval
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_live_matchmaking"], "Client Waiting for common FF \n")
		end
		return false
	elseif 1 == Dvar[@"hash_3F1DE3CEF5A9E0DB"]:get() and LuaUtils.IsArenaPublicGame() then
		Engine[0x8587B36B7F8EF5](Engine[@"getprimarycontroller"](), Enum[@"hash_6DB66542051E7C15"][@"hash_78D8FC5F8CDC337F"])
	end
	return true
end
Lobby.Launch.ClientLaunchClear = function()
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.hideMenusForGameStart"), 0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive"), false)
	return true
end
