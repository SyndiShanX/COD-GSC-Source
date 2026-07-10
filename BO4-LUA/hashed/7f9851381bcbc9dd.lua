require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingCP = {}
Lobby.MatchmakingCP.SetupMatchmakingStage = function(f1_arg0)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Setting up CP matchmaking stage.\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[@"showinmatchmaking"][@"show_in_matchmaking_true"])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	if Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.PUBLIC_CP_ALL then
		Lobby.Matchmaking.SetQueryId(Enum[@"queryid"][@"queryid_search_sessions_by_server_type"])
		Dvar[@"lobbysearchplaylistversion"]:set(Lobby.Matchmaking.GetFfotdPlaylistVersionNumber())
		Dvar[@"lobbysearchplaylistnumber"]:set(LuaDefine.INT_MAX)
	else
		Lobby.Matchmaking.SetQueryId(Enum[@"queryid"][@"queryid_search_sessions_all"])
		Lobby.Matchmaking.SetPlaylistInfo(Engine[@"getplaylistid"]())
	end
	Lobby.Matchmaking.SetServerType(Lobby.Matchmaking.GetServerType())
	local f1_local0 = Lobby.Matchmaking.NextStage()
	local f1_local1 = Lobby.Matchmaking.GetConnection(f1_arg0)
	local f1_local2 = Dvar[@"excellentping"]:get()
	local f1_local3 = Dvar[@"goodping"]:get()
	local f1_local4 = Dvar[@"terribleping"]:get()
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(1)
	Lobby.Matchmaking.SetMapPacksAll()
	Lobby.Matchmaking.MinGeoMatch(1)
	Lobby.Matchmaking.SetTeamSize(Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]))
	if f1_local1 == Lobby.Matchmaking.Connection.BEST then
		Lobby.Matchmaking.PingRange(1, f1_local2)
	elseif f1_local1 == Lobby.Matchmaking.Connection.NORMAL then
		Lobby.Matchmaking.PingRange(f1_local2, f1_local3)
	else
		Lobby.Matchmaking.PingRange(f1_local3, 999)
	end
	if Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.LOBBY_MERGE then
		if f1_local0 > 0 then
			return false
		else
			return true
		end
	elseif Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.PUBLIC_CP_ALL or Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.PUBLIC then
		local f1_local5 = f1_local0 % 3
		if f1_local5 == 1 and f1_local1 == Lobby.Matchmaking.Connection.NORMAL then
			Lobby.Matchmaking.PingRange(f1_local3, f1_local4)
			return true
		elseif f1_local5 == 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end
