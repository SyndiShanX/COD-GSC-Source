require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingCustom = {}
Lobby.MatchmakingCustom.HandleDedicatedParkedStage = function(f1_arg0, f1_arg1)
	local f1_local0 = Enum[@"queryid"][@"queryid_search_session_dedicated_parked"]
	local f1_local1 = Engine[@"getparkingplaylistforrealplaylist"](f1_arg1)
	if f1_local1 ~= Lobby.Matchmaking.INVALID_PARKING_PLAYLIST then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Lobby.MatchmakingCustom.HandleDedicatedParkedStage: No sessions found in playlistID<" .. f1_arg1 .. ">, looking in parkingPlaylist<" .. f1_local1 .. ">\n")
		Lobby.Matchmaking.SetMapPacksOriginal()
		Lobby.Matchmaking.SetPlaylistInfo(f1_local1)
	end
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_EMPTY)
	if Lobby.Matchmaking.SetServerLocation(f1_local0, f1_arg0) ~= true then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingCustom.HandleDedicatedParkedStage: Failed to set server location, doing a listen search instead\n")
	end
	Lobby.Matchmaking.SetSkillWeight(0)
	Lobby.Matchmaking.SetQueryId(f1_local0)
end
Lobby.MatchmakingCustom.SetupConnectionInfo = function(f2_arg0)
	local f2_local0 = Lobby.Matchmaking.GetConnection(f2_arg0)
	local f2_local1 = Dvar[@"excellentping"]:get()
	local f2_local2 = Dvar[@"goodping"]:get()
	local f2_local3 = Dvar[@"terribleping"]:get()
	if f2_local0 == Lobby.Matchmaking.Connection.BEST then
		Lobby.Matchmaking.PingRange(1, f2_local1)
		Lobby.Matchmaking.MinGeoMatch(1)
	elseif f2_local0 == Lobby.Matchmaking.Connection.NORMAL then
		Lobby.Matchmaking.PingRange(f2_local1, f2_local2)
		Lobby.Matchmaking.MinGeoMatch(1)
	else
		Lobby.Matchmaking.PingRange(f2_local2, 999)
		Lobby.Matchmaking.MinGeoMatch(0)
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingCustom.SetupConnectionInfo: Connection: " .. tostring(f2_local0) .. "\n")
end
Lobby.MatchmakingCustom.SetupMatchmakingStage = function(f3_arg0)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingCustom.SetupMatchmakingStage: Setting up Custom Dedicated matchmaking stage\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[@"showinmatchmaking"][@"show_in_matchmaking_true"])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(0.01)
	local f3_local0 = Lobby.Matchmaking.SearchStage.DEDICATED_PARKED
	if f3_local0 == Lobby.Matchmaking.SearchStage.DONE then
		return false
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingCustom.SetupMatchmakingStage: Next Stage: " .. tostring(f3_local0) .. "\n")
	local f3_local1 = Engine[@"hash_131C19A6AF221CC9"](Engine[@"currentsessionmode"]())
	Engine[@"setplaylistid"](f3_local1)
	LuaUtils.SetQuickplayPlaylistID(f3_local1)
	Lobby.Matchmaking.SetPlaylistInfo(f3_local1)
	if Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.CUSTOM_DEDICATED then
		Lobby.MatchmakingCustom.HandleDedicatedParkedStage(f3_local0, f3_local1)
	else
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.MatchmakingCustom.SetupMatchmakingStage Called with Unhandled Search Mode.\n")
	end
	Lobby.Matchmaking.SetTeamSize(Lobby.Matchmaking.GetNumSlotsNeededOnTeam(f3_local0))
	Dvar[@"lobbysearchmappacks"]:set(Lobby.Matchmaking.GetMapPackBits(Engine[@"getdlcbitsforlobby"](Enum[@"lobbytype"][@"lobby_type_game"]), f3_local1))
	Lobby.MatchmakingCustom.SetupConnectionInfo(f3_arg0)
	return true
end
