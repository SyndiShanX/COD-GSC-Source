require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingMP = {}
Lobby.MatchmakingMP.DoListenSearch = function(f1_arg0, f1_arg1)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Matchmaking: Setting up Listen Search Parameters\n")
	Lobby.Matchmaking.SetQueryId(Enum[@"queryid"][@"queryid_search_sessions_all"])
	Lobby.Matchmaking.SetPlaylistInfo(f1_arg1)
end
Lobby.MatchmakingMP.DoDedicatedSearch = function(f2_arg0, f2_arg1)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Matchmaking: Setting up Dedicated Search Parameters\n")
	if Lobby.Matchmaking.SearchMode.LOBBY_MERGE == Lobby.Matchmaking.SearchParams.mode and f2_arg0 > Lobby.Matchmaking.SearchStage.DEDICATED_ON_PLAYLIST_1 then
		Lobby.MatchmakingMP.DoListenSearch(f2_arg0, f2_arg1)
	else
		local f2_local0 = Enum[@"queryid"][@"queryid_search_session_dedicated"]
		if not Lobby.Matchmaking.SetServerLocation(f2_local0, f2_arg0) then
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Couldn't get dediqos results, doing an OPS2 search instead")
			Lobby.MatchmakingMP.DoListenSearch(f2_arg0, f2_arg1)
		else
			Lobby.Matchmaking.SetPingBandWeight(1)
			Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
			Lobby.Matchmaking.SetQueryId(f2_local0)
		end
	end
	Lobby.Matchmaking.SetPlaylistInfo(f2_arg1)
end
Lobby.MatchmakingMP.UnparkDedicated = function(f3_arg0, f3_arg1)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Matchmaking: Setting up Dedicated Unpark Search Parameters\n")
	local f3_local0 = Enum[@"queryid"][@"queryid_search_session_dedicated_parked"]
	local f3_local1 = Engine[@"getparkingplaylistforrealplaylist"](f3_arg1)
	if f3_local1 ~= nil and f3_local1 ~= Lobby.Matchmaking.INVALID_PARKING_PLAYLIST then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "LobbyMatchmaking.Lobby.Matchmaking.SetPlaylistInfo(): No sessions found in playlistID<" .. f3_arg1 .. ">, looking in parkingPlaylist<" .. f3_local1 .. ">\n")
		Lobby.Matchmaking.SetMapPacksOriginal()
		f3_arg1 = f3_local1
	end
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_EMPTY)
	if not Lobby.Matchmaking.SetServerLocation(f3_local0, f3_arg0) then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Couldn't get dediqos results, doing an OPS2 search instead")
		Lobby.MatchmakingMP.DoListenSearch(f3_arg0, f3_arg1)
	else
		Lobby.Matchmaking.SetSkillWeight(0)
		Lobby.Matchmaking.SetQueryId(f3_local0)
	end
	Lobby.Matchmaking.SetPlaylistInfo(f3_arg1)
end
Lobby.MatchmakingMP.AllowListenSearch = function(f4_arg0)
	if Dvar[@"lobbydedicatedsearchskip"]:get() == true then
		return true
	elseif Lobby.Matchmaking.SearchParams.searchInfo == nil then
		return true
	else
		local f4_local0 = Lobby.Matchmaking.SearchParams.searchInfo.startTime
		if f4_local0 == nil then
			return true
		else
			local f4_local1 = (Engine[@"milliseconds"]() - f4_local0) / 1000
			local f4_local2 = Engine[@"getdvarint"]("lobbySearchMinDediSearchTime") + Engine[@"getdvarint"]("lobbySearchMinDediSearchClientAdd") * f4_arg0 < f4_local1
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Matchmaking: Allow Listen Search Time: " .. tostring(f4_local1) .. " seconds. Allow Listen Search: " .. tostring(f4_local2) .. " \n")
			return f4_local2
		end
	end
end
Lobby.MatchmakingMP.AllowUnparkSearch = function(f5_arg0)
	if Lobby.MatchmakingMP.AllowListenSearch(f5_arg0) then
		return true
	elseif f5_arg0 >= Engine[@"getdvarint"]("lobbySearchForceUnparkLobbySize") then
		return true
	else
		return Engine[@"getdvarfloat"]("lobbySearchSkipUnparkProbability") <= math.random()
	end
end
Lobby.MatchmakingMP.SetupMatchmakingStage = function(f6_arg0)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Matchmaking: Setting up multiplayer matchmaking stage.\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[@"showinmatchmaking"][@"show_in_matchmaking_true"])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(0.01)
	local f6_local0 = Lobby.Matchmaking.NextStage()
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Matchmaking: SETUP MATCHMAKING STAGE: " .. tostring(f6_local0) .. "\n")
	if f6_local0 == Lobby.Matchmaking.SearchStage.DONE then
		return false
	elseif Dvar[@"lobbydedicatedsearchskip"]:exists() and Dvar[@"lobbydedicatedsearchskip"]:get() == true and f6_local0 ~= Lobby.Matchmaking.SearchStage.LISTEN and f6_local0 ~= Lobby.Matchmaking.SearchStage.LISTEN_DESPERATE and f6_local0 ~= Lobby.Matchmaking.SearchStage.DONE then
		f6_local0 = Lobby.Matchmaking.SearchStage.LISTEN
	end
	local f6_local1 = Lobby.Matchmaking.GetConnection(f6_arg0)
	local f6_local2 = Engine[@"getplaylistid"]()
	Dvar[@"lobbysearchmappacks"]:set(Lobby.Matchmaking.GetMapPackBits(Engine[@"getdlcbitsforlobby"](Enum[@"lobbytype"][@"lobby_type_game"]), f6_local2))
	if f6_local0 < Lobby.Matchmaking.SearchStage.DEDICATED_PARKED then
		if Engine[@"getdvarfloat"]("lobbySearchSkipDLCProbability") >= math.random() then
			local f6_local3 = Dvar[@"lobbysearchmappacks"]:get()
			if LobbyVM.CheckDLCBit(f6_local3, Enum[@"contentflagbits"][@"content_originalmaps"]) then
				Dvar[@"lobbysearchmappacks"]:set(f6_local3 & 16776719)
				Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobbyclient"], "Dlcbits was " .. f6_local3 .. " now it's " .. Dvar[@"lobbysearchmappacks"]:get() .. "\n")
			end
		else
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyclient"], "Diceroll failed, not going to fiddle dlc bits\n")
		end
		Lobby.MatchmakingMP.DoDedicatedSearch(f6_local0, f6_local2)
	elseif f6_local0 == Lobby.Matchmaking.SearchStage.DEDICATED_PARKED then
		Lobby.MatchmakingMP.UnparkDedicated(f6_local0, f6_local2)
	elseif f6_local0 == Lobby.Matchmaking.SearchStage.LISTEN and Lobby.Matchmaking.SearchMode.PUBLIC == Lobby.Matchmaking.SearchParams.mode then
		Lobby.MatchmakingMP.DoListenSearch(f6_local0, f6_local2)
	end
	Lobby.Matchmaking.SetTeamSize(Lobby.Matchmaking.GetNumSlotsNeededOnTeam(f6_local0))
	local f6_local4 = math.max(Dvar[@"goodping"]:get(), Dvar[@"lobbysearchdediunparkpinglimit"]:get())
	local f6_local3 = Engine[@"getdediqosresultsbytype"](Lobby.Matchmaking.DatacenterType.ANY)
	if f6_local3.numResults > 0 then
		f6_local4 = math.max(f6_local4, f6_local3.pingResults[1].ping)
	end
	Lobby.Matchmaking.PingRange(1, f6_local4)
	Lobby.Matchmaking.MinGeoMatch(2)
	return true
end
