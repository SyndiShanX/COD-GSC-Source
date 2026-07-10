require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingArena = {}
Lobby.MatchmakingArena.HandleMerge = function(f1_arg0)
	if f1_arg0 == Lobby.Matchmaking.SearchStage.DEDICATED_ON_PLAYLIST_1 then
		Lobby.MatchmakingArena.DoDedicatedSearch(f1_arg0)
	else
		Lobby.MatchmakingArena.DoListenSearch(f1_arg0)
	end
end
Lobby.MatchmakingArena.HandleDedicatedSearchStage = function(f2_arg0)
	Lobby.MatchmakingArena.DoDedicatedSearch(f2_arg0)
end
Lobby.MatchmakingArena.HandleDedicatedParkedStage = function(f3_arg0)
	if not Lobby.MatchmakingArena.CanHostAnyLobby() then
		Lobby.MatchmakingArena.DoDedicatedSearch(f3_arg0)
		return
	end
	local f3_local0 = Enum[@"queryid"][@"queryid_search_session_dedicated_parked"]
	local f3_local1 = Engine[@"getplaylistid"]()
	local f3_local2 = Engine[@"getparkingplaylistforrealplaylist"](f3_local1)
	if f3_local2 ~= Lobby.Matchmaking.INVALID_PARKING_PLAYLIST then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.MatchmakingArena.HandleDedicatedParkedStage: No sessions found in playlistID<" .. f3_local1 .. ">, looking in parkingPlaylist<" .. f3_local2 .. ">\n")
		Lobby.Matchmaking.SetMapPacksOriginal()
		Lobby.Matchmaking.SetPlaylistInfo(f3_local2)
	end
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_EMPTY)
	if Lobby.Matchmaking.SetServerLocation(f3_local0, f3_arg0) ~= true then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingArena.HandleDedicatedParkedStage: Failed to set server location, doing a listen search instead\n")
		Lobby.MatchmakingArena.DoListenSearch(f3_arg0)
	else
		Lobby.Matchmaking.SetSkillWeight(0)
		Lobby.Matchmaking.SetQueryId(f3_local0)
	end
end
Lobby.MatchmakingArena.HandleListenStage = function(f4_arg0)
	Lobby.MatchmakingArena.DoListenSearch(f4_arg0)
end
Lobby.MatchmakingArena.DoDedicatedSearch = function(f5_arg0)
	local f5_local0 = Enum[@"queryid"][@"queryid_search_session_dedicated"]
	if Lobby.Matchmaking.SetServerLocation(f5_local0, f5_arg0) == true then
		Lobby.Matchmaking.SetPingBandWeight(1)
		Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
		Lobby.Matchmaking.SetQueryId(f5_local0)
	else
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingArena.DoDedicatedSearch: Failed to set server location, doing a listen search instead\n")
		if Dvar[@"arena_enablelistenhosting"]:exists() and Dvar[@"arena_enablelistenhosting"]:get() then
			Lobby.MatchmakingArena.DoListenSearch(f5_arg0)
		end
	end
end
Lobby.MatchmakingArena.DoListenSearch = function(f6_arg0)
	if Dvar[@"arena_enablelistenhosting"]:exists() and Dvar[@"arena_enablelistenhosting"]:get() then
		Lobby.Matchmaking.SetQueryId(Enum[@"queryid"][@"queryid_search_sessions_all"])
	else
		Lobby.MatchmakingArena.DoDedicatedSearch(f6_arg0)
	end
end
Lobby.MatchmakingArena.SetupConnectionInfo = function(f7_arg0)
	local f7_local0 = Lobby.Matchmaking.GetConnection(f7_arg0)
	local f7_local1 = Dvar[@"excellentping"]:get()
	local f7_local2 = Dvar[@"goodping"]:get()
	local f7_local3 = Dvar[@"terribleping"]:get()
	if f7_local0 == Lobby.Matchmaking.Connection.BEST then
		Lobby.Matchmaking.PingRange(1, f7_local1)
		Lobby.Matchmaking.MinGeoMatch(1)
	elseif f7_local0 == Lobby.Matchmaking.Connection.NORMAL then
		Lobby.Matchmaking.PingRange(f7_local1, f7_local2)
		Lobby.Matchmaking.MinGeoMatch(1)
	else
		Lobby.Matchmaking.PingRange(f7_local2, 999)
		Lobby.Matchmaking.MinGeoMatch(0)
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingArena.SetupConnectionInfo: Connection: " .. tostring(f7_local0) .. "\n")
end
Lobby.MatchmakingArena.SetupMatchmakingStage = function(f8_arg0)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingArena.SetupMatchmakingStage: Setting up arena matchmaking stage\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[@"showinmatchmaking"][@"show_in_matchmaking_true"])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(0.01)
	local f8_local0 = Lobby.Matchmaking.NextStage()
	if f8_local0 == Lobby.Matchmaking.SearchStage.DONE then
		return false
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingArena.SetupMatchmakingStage: Next Stage: " .. tostring(f8_local0) .. "\n")
	Lobby.Matchmaking.SetPlaylistInfo(Engine[@"getplaylistid"]())
	if Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.ARENA then
		if f8_local0 < Lobby.Matchmaking.SearchStage.DEDICATED_PARKED then
			Lobby.MatchmakingArena.HandleDedicatedSearchStage(f8_local0)
		elseif f8_local0 == Lobby.Matchmaking.SearchStage.DEDICATED_PARKED then
			Lobby.MatchmakingArena.HandleDedicatedParkedStage(f8_local0)
		elseif f8_local0 == Lobby.Matchmaking.SearchStage.LISTEN then
			Lobby.MatchmakingArena.HandleListenStage(f8_local0)
		end
	elseif Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.LOBBY_MERGE then
		Lobby.MatchmakingArena.HandleMerge(f8_local0)
	else
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingArena.SetupMatchmakingStage Called with Unhandled Search Mode.\n")
	end
	Lobby.Matchmaking.SetTeamSize(Lobby.Matchmaking.GetNumSlotsNeededOnTeam(f8_local0))
	Dvar[@"lobbysearchmappacks"]:set(Lobby.Matchmaking.GetMapPackBits(Engine[@"getdlcbitsforlobby"](Enum[@"lobbytype"][@"lobby_type_game"]), Engine[@"getplaylistid"]()))
	Lobby.MatchmakingArena.SetupConnectionInfo(f8_arg0)
	return true
end
Lobby.MatchmakingArena.CanHostAnyLobby = function()
	local f9_local0 = 10
	if Dvar[@"arena_minhostskillrange"]:exists() then
		f9_local0 = Dvar[@"arena_minhostskillrange"]:get()
	end
	local f9_local1 = Lobby.Matchmaking.SearchParams.searchInfo.maxQOSedRange
	if f9_local1 then
		return f9_local0 < f9_local1
	else
		return f9_local0 < Lobby.MatchmakingArena.GetArenaSkillRange() / 2
	end
end
Lobby.MatchmakingArena.GetArenaSkillRange = function(f10_arg0)
	local f10_local0 = Lobby.Matchmaking.SearchParams.searchInfo.startTime
	if f10_local0 == nil then
		return 0
	end
	local f10_local1 = (Engine[@"milliseconds"]() - f10_local0) / 1000
	local f10_local2 = 0
	if Dvar[@"arena_qosskillstart"]:exists() then
		f10_local2 = Dvar[@"arena_qosskillstart"]:get()
	end
	local f10_local3 = 1
	if Dvar[@"arena_qosbrodenskillstep"]:exists() then
		f10_local3 = Dvar[@"arena_qosbrodenskillstep"]:get()
	end
	local f10_local4 = 2
	if Dvar[@"arena_qosbrodenskillfrequency"]:exists() then
		f10_local4 = Dvar[@"arena_qosbrodenskillfrequency"]:get()
	end
	local f10_local5 = math.min(f10_local2 + f10_local1 / f10_local4 * f10_local3, Engine[@"getmaxarenapoints"]())
	if f10_arg0 == true then
		Lobby.Matchmaking.SearchParams.searchInfo.maxQOSedRange = f10_local5
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.MatchmakingArena.GetArenaSkillRange: Search Time " .. tostring(f10_local1) .. " seconds. Skill Range: " .. f10_local5 .. " points\n")
	return f10_local5
end
Lobby.MatchmakingArena.GetLobbyArenaSkill = function()
	local f11_local0 = {}
	local f11_local1 = 0
	local f11_local2 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"])
	for f11_local6, f11_local7 in ipairs(f11_local2.sessionClients) do
		if not f11_local0[f11_local7.simpleLobbyID] then
			f11_local0[f11_local7.simpleLobbyID] = f11_local7.arenaPoints
			f11_local1 = f11_local1 + 1
		else
			f11_local0[f11_local7.simpleLobbyID] = math.max(f11_local0[f11_local7.simpleLobbyID], f11_local7.arenaPoints)
		end
	end
	if f11_local1 == 0 then
		return 0
	end
	table.sort(f11_local0, arenaSkillSort)
	f11_local3 = 0
	if math.fmod(#f11_local0, 2) == 0 then
		f11_local3 = (f11_local0[#f11_local0 / 2] + f11_local0[#f11_local0 / 2 + 1]) / 2
	else
		f11_local3 = f11_local0[math.ceil(#f11_local0 / 2)]
	end
	return f11_local3
end
