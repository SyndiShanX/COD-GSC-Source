require("x64:53e8db3768fb02a")
Lobby.Hopper = {}
Lobby.Hopper.lobbyHopper = nil
Lobby.Hopper.HOPPER_STATE = {
	PARKED = 0,
	UNPARKED = 1,
}
Lobby.Hopper.hopperState = Lobby.Hopper.HOPPER_STATE.UNPARKED
Lobby.Hopper.UpdateLobbyData = function(f1_arg0, f1_arg1)
	if Dvar[@"hash_44BADE8473F0165F"]:get() == true then
		return 1
	end
	local f1_local0 = 1
	local f1_local1 = LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC
	local f1_local2 = Engine[@"hash_131C19A6AF221CC9"](Engine[@"currentsessionmode"]())
	if f1_local2 == f1_arg0 then
		f1_local1 = LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM
	end
	local f1_local3 = LobbyData.GetLobbyMenuByName(f1_local1)
	if f1_local2 == f1_arg0 then
		if f1_arg1 ~= nil then
			Engine[@"hash_7DC3983C70B75088"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], f1_arg1)
		end
		Lobby.Timer.SetDedicatedDelayedCMD(Lobby.Timer.LOBBY_DEDICATED_CMD.INVALID_CMD)
		f1_local0 = 2
	end
	Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Updating Lobby Data for Target: " .. f1_local3[@"name"] .. "\n")
	LobbyVM.OnLobbySettings({
		toTarget = f1_local3,
		skipSwitchMode = true,
		isDevMap = false,
	})
	LobbyVM.OnUpdateUI({
		toTarget = f1_local3,
	})
	local f1_local4 = 0
	if f1_arg0 then
		Lobby.Timer.HostingLobby({
			controller = f1_local4,
			lobbyType = f1_local3[@"lobbytype"],
			mainMode = f1_local3[@"mainmode"],
			lobbyTimerType = f1_local3[@"hash_5558B67A321D1120"],
		})
	else
		Lobby.Timer.HostingLobbyEnd({
			lobbyType = f1_local3[@"lobbytype"],
		})
		Lobby.Pregame.Clear()
	end
	return f1_local0
end
Lobby.Hopper.OnClientJoin = function(f2_arg0)
	if Dvar[@"hash_44BADE8473F0165F"]:get() == true then
		return 1
	elseif Engine[@"isdedicatedserver"]() == false then
		return 1
	end
	local f2_local0 = f2_arg0.clientPlaylist
	if f2_local0 == 255 then
		return 1
	end
	local f2_local1 = Engine[@"getparkingplaylistforrealplaylist"](f2_local0)
	local f2_local2 = Engine[@"getplaylistid"]()
	local f2_local3 = 1
	if Lobby.Hopper.HOPPER_STATE.PARKED == Lobby.Hopper.hopperState then
		if f2_local2 ~= f2_local1 then
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Rejecting client because they want playlist " .. f2_local1 .. " but we're on parkingplaylist " .. f2_local2 .. " for playlist " .. f2_local2 .. "\n")
			f2_local3 = 0
		else
			f2_local3 = Lobby.Hopper.UpdateLobbyData(f2_local0, f2_arg0.leaderXuid)
			Lobby.Launch.HostLaunchClear()
			Engine[@"setfakedlcbits"](f2_arg0.dlcBits)
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Unparking onto playlist " .. f2_local0 .. "\n")
			Engine[@"switchplaylists"](f2_local0)
			Lobby.Matchmaking.UpdateLatencyBand()
			Engine[@"setplaylistid"](f2_local0)
			LuaUtils.SetQuickplayPlaylistID(f2_local0)
			Dvar[@"lobbyadvertiseplaylistnumber"]:set(f2_local0)
			Dvar[@"lobbyadvertisemappacks"]:set(Lobby.Matchmaking.GetMapPackBits(f2_arg0.dlcBits, f2_local0))
			Engine[@"setlobbymaxclients"](Enum[@"lobbytype"][@"lobby_type_game"], Dvar[@"party_maxplayers"]:get())
			Lobby.Matchmaking.SetSkillWeight(0.01)
			Lobby.Matchmaking.UpdateAdvertising(" hopper unpark ")
			Lobby.Hopper.hopperState = Lobby.Hopper.HOPPER_STATE.UNPARKED
		end
	elseif Lobby.Hopper.HOPPER_STATE.UNPARKED == Lobby.Hopper.hopperState and f2_local0 ~= 255 and f2_local0 ~= f2_local2 then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Rejecting client because they want playlist " .. f2_local0 .. " but we're unparked on playlist " .. f2_local2 .. "\n")
		f2_local3 = 0
	end
	return f2_local3
end
Lobby.Hopper.OnSessionEnd = function(f3_arg0)
	if Dvar[@"hash_44BADE8473F0165F"]:get() == true then
		return
	end
	local f3_local0 = f3_arg0.lobbyModule
	local f3_local1 = f3_arg0.lobbyType
	local f3_local2 = f3_arg0.lobbyMode
	if f3_local1 == Enum[@"lobbytype"][@"lobby_type_game"] then
		Engine[@"hash_2BBB5B39E4BA37EB"]("old", true)
	end
end
Lobby.Hopper.Pump = function()
	if Engine[@"isdedicatedserver"]() == false then
		return
	elseif false == Dvar[@"hash_68827F6EDED32B08"]:get() then
		return
	elseif Dvar[@"hash_44BADE8473F0165F"]:get() == true then
		return
	elseif Dvar[@"hash_2B852BA138B9853A"]:exists() == true and Dvar[@"hash_2B852BA138B9853A"]:get() == true then
		return
	elseif Dvar[@"hash_3E2390D9E82B6369"]:get() == true and Dvar[@"hash_74CE6DE7EC1A56FE"]:get() == true then
		return
	elseif Lobby.Hopper.HOPPER_STATE.UNPARKED == Lobby.Hopper.hopperState then
		if Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]) == 0 and not Engine[@"isprocessingjoin"](Enum[@"lobbytype"][@"lobby_type_game"]) and false == Dvar[@"com_sv_running"]:get() and Dvar[@"hash_4DD6A5A551E5E17E"]:get() == 0 then
			local f4_local0 = Engine[@"getplaylistid"]()
			local f4_local1 = Engine[@"getparkingplaylistforrealplaylist"](f4_local0)
			if f4_local1 ~= 0 then
				Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "No clients left and we're currently on playlist " .. f4_local0 .. " - parking on playlist " .. f4_local1 .. "\n")
				Lobby.Hopper.hopperState = Lobby.Hopper.HOPPER_STATE.PARKED
				Lobby.Hopper.UpdateLobbyData()
				Dvar[@"lobbyadvertiselatencyband"]:set(0)
				Dvar[@"lobbyadvertiseplaylistnumber"]:set(f4_local1)
				Dvar[@"lobbyadvertisemappacks"]:set(Lobby.Matchmaking.ContentPack.CONTENT_ORIGINALMAPS)
				Dvar[@"lobbyadvertiseshowinmatchmaking"]:set(1)
				Lobby.Matchmaking.UpdateAdvertising("hopper park")
				Engine[@"switchplaylists"](f4_local1)
				Engine[@"setplaylistid"](f4_local1)
				LuaUtils.SetQuickplayPlaylistID(f4_local1)
				if Dvar[@"hash_3E2390D9E82B6369"]:get() == true then
					Dvar[@"hash_74CE6DE7EC1A56FE"]:set(true)
				end
			end
		end
	elseif Lobby.Hopper.HOPPER_STATE.PARKED == Lobby.Hopper.hopperState then
	else
	end
end
Lobby.Hopper.OnIsParked = function()
	if Dvar[@"hash_44BADE8473F0165F"]:get() == true then
		return false
	else
		return Lobby.Hopper.HOPPER_STATE.PARKED == Lobby.Hopper.hopperState
	end
end
