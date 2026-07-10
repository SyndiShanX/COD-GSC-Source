require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingZM = {}
Lobby.MatchmakingZM.SetupMatchmakingStage = function(f1_arg0)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Setting up ZM matchmaking stage.\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[@"showinmatchmaking"][@"show_in_matchmaking_true"])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	Lobby.Matchmaking.SetQueryId(Enum[@"queryid"][@"queryid_search_sessions_all"])
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(1)
	Lobby.Matchmaking.SetMapPacksAll()
	Lobby.Matchmaking.MinGeoMatch(1)
	Lobby.Matchmaking.SetPlaylistInfo(Engine[@"getplaylistid"]())
	Lobby.Matchmaking.SetTeamSize(Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]))
	local f1_local0 = Lobby.Matchmaking.GetConnection(f1_arg0)
	local f1_local1 = Dvar[@"excellentping"]:get()
	local f1_local2 = Dvar[@"goodping"]:get()
	local f1_local3 = Dvar[@"terribleping"]:get()
	if f1_local0 == Lobby.Matchmaking.Connection.BEST then
		Lobby.Matchmaking.PingRange(1, f1_local1)
	elseif f1_local0 == Lobby.Matchmaking.Connection.NORMAL then
		Lobby.Matchmaking.PingRange(f1_local1, f1_local2)
	else
		Lobby.Matchmaking.PingRange(f1_local2, 999)
	end
	local f1_local4 = Lobby.Matchmaking.NextStage()
	if Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.LOBBY_MERGE then
		if f1_local4 > 0 then
			return false
		else
			return true
		end
	elseif Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.PUBLIC then
		local f1_local5 = f1_local4 % 3
		if f1_local5 == 1 and f1_local0 == Lobby.Matchmaking.Connection.NORMAL then
			Lobby.Matchmaking.PingRange(f1_local2, f1_local3)
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
