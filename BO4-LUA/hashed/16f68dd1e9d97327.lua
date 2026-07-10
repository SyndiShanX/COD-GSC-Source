require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingMP = {}
Lobby.MatchmakingMP.DoListenSearch = function(f1_arg0, f1_arg1)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Matchmaking: Setting up Listen Search Parameters\n")
	Lobby.Matchmaking.SetQueryId(Enum[0x71A76D23911A20E][0x1288E0B9D3852C1])
	Lobby.Matchmaking.SetPlaylistInfo(f1_arg1)
end
Lobby.MatchmakingMP.DoDedicatedSearch = function(f2_arg0, f2_arg1)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Matchmaking: Setting up Dedicated Search Parameters\n")
	if Lobby.Matchmaking.SearchMode.LOBBY_MERGE == Lobby.Matchmaking.SearchParams.mode and f2_arg0 > Lobby.Matchmaking.SearchStage.DEDICATED_ON_PLAYLIST_1 then
		Lobby.MatchmakingMP.DoListenSearch(f2_arg0, f2_arg1)
	else
		local f2_local0 = Enum[0x71A76D23911A20E][0x50431AFB53B1412]
		if not Lobby.Matchmaking.SetServerLocation(f2_local0, f2_arg0) then
			Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Couldn't get dediqos results, doing an OPS2 search instead")
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
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Matchmaking: Setting up Dedicated Unpark Search Parameters\n")
	local f3_local0 = Enum[0x71A76D23911A20E][0x5AED0351BD1CE62]
	local f3_local1 = Engine[0x6D46FF33D97B908](f3_arg1)
	if f3_local1 ~= nil and f3_local1 ~= Lobby.Matchmaking.INVALID_PARKING_PLAYLIST then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "LobbyMatchmaking.Lobby.Matchmaking.SetPlaylistInfo(): No sessions found in playlistID<" .. f3_arg1 .. ">, looking in parkingPlaylist<" .. f3_local1 .. ">\n")
		Lobby.Matchmaking.SetMapPacksOriginal()
		f3_arg1 = f3_local1
	end
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_EMPTY)
	if not Lobby.Matchmaking.SetServerLocation(f3_local0, f3_arg0) then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Couldn't get dediqos results, doing an OPS2 search instead")
		Lobby.MatchmakingMP.DoListenSearch(f3_arg0, f3_arg1)
	else
		Lobby.Matchmaking.SetSkillWeight(0)
		Lobby.Matchmaking.SetQueryId(f3_local0)
	end
	Lobby.Matchmaking.SetPlaylistInfo(f3_arg1)
end
Lobby.MatchmakingMP.AllowListenSearch = function(f4_arg0)
	if Dvar[0xE7A52A88079870B]:get() == true then
		return true
	elseif Lobby.Matchmaking.SearchParams.searchInfo == nil then
		return true
	else
		local f4_local0 = Lobby.Matchmaking.SearchParams.searchInfo.startTime
		if f4_local0 == nil then
			return true
		else
			local f4_local1 = (Engine[0x9D33D652B9B0F3B]() - f4_local0) / 1000
			local f4_local2 = Engine[0x22EAAB59AA27E9B]("lobbySearchMinDediSearchTime") + Engine[0x22EAAB59AA27E9B]("lobbySearchMinDediSearchClientAdd") * f4_arg0 < f4_local1
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Matchmaking: Allow Listen Search Time: " .. tostring(f4_local1) .. " seconds. Allow Listen Search: " .. tostring(f4_local2) .. " \n")
			return f4_local2
		end
	end
end
Lobby.MatchmakingMP.AllowUnparkSearch = function(f5_arg0)
	if Lobby.MatchmakingMP.AllowListenSearch(f5_arg0) then
		return true
	elseif f5_arg0 >= Engine[0x22EAAB59AA27E9B]("lobbySearchForceUnparkLobbySize") then
		return true
	else
		return Engine[0xEDCFC612B39E0C0]("lobbySearchSkipUnparkProbability") <= math.random()
	end
end
Lobby.MatchmakingMP.SetupMatchmakingStage = function(f6_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Matchmaking: Setting up multiplayer matchmaking stage.\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[0x805C82C8BA1B3C9][0xC7A6E94E122CDB2])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(0.01)
	local f6_local0 = Lobby.Matchmaking.NextStage()
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Matchmaking: SETUP MATCHMAKING STAGE: " .. tostring(f6_local0) .. "\n")
	if f6_local0 == Lobby.Matchmaking.SearchStage.DONE then
		return false
	elseif Dvar[0xE7A52A88079870B]:exists() and Dvar[0xE7A52A88079870B]:get() == true and f6_local0 ~= Lobby.Matchmaking.SearchStage.LISTEN and f6_local0 ~= Lobby.Matchmaking.SearchStage.LISTEN_DESPERATE and f6_local0 ~= Lobby.Matchmaking.SearchStage.DONE then
		f6_local0 = Lobby.Matchmaking.SearchStage.LISTEN
	end
	local f6_local1 = Lobby.Matchmaking.GetConnection(f6_arg0)
	local f6_local2 = Engine[0x7B3B2B73B53EB34]()
	Dvar[0xFD32115F3E81D0F]:set(Lobby.Matchmaking.GetMapPackBits(Engine[0xEC040B95C0BF471](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]), f6_local2))
	if f6_local0 < Lobby.Matchmaking.SearchStage.DEDICATED_PARKED then
		if Engine[0xEDCFC612B39E0C0]("lobbySearchSkipDLCProbability") >= math.random() then
			local f6_local3 = Dvar[0xFD32115F3E81D0F]:get()
			if LobbyVM.CheckDLCBit(f6_local3, Enum[0xE2A6806BB83D51C][0x8F57745D21DF973]) then
				Dvar[0xFD32115F3E81D0F]:set(f6_local3 & 16776719)
				Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xD48A9770CD84BB6], "Dlcbits was " .. f6_local3 .. " now it's " .. Dvar[0xFD32115F3E81D0F]:get() .. "\n")
			end
		else
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xD48A9770CD84BB6], "Diceroll failed, not going to fiddle dlc bits\n")
		end
		Lobby.MatchmakingMP.DoDedicatedSearch(f6_local0, f6_local2)
	elseif f6_local0 == Lobby.Matchmaking.SearchStage.DEDICATED_PARKED then
		Lobby.MatchmakingMP.UnparkDedicated(f6_local0, f6_local2)
	elseif f6_local0 == Lobby.Matchmaking.SearchStage.LISTEN and Lobby.Matchmaking.SearchMode.PUBLIC == Lobby.Matchmaking.SearchParams.mode then
		Lobby.MatchmakingMP.DoListenSearch(f6_local0, f6_local2)
	end
	Lobby.Matchmaking.SetTeamSize(Lobby.Matchmaking.GetNumSlotsNeededOnTeam(f6_local0))
	local f6_local4 = math.max(Dvar[0x8E0DBD8C71F9D10]:get(), Dvar[0x39E15BDB813DCCB]:get())
	local f6_local3 = Engine[0x29A1F6E8893B96F](Lobby.Matchmaking.DatacenterType.ANY)
	if f6_local3.numResults > 0 then
		f6_local4 = math.max(f6_local4, f6_local3.pingResults[1].ping)
	end
	Lobby.Matchmaking.PingRange(1, f6_local4)
	Lobby.Matchmaking.MinGeoMatch(2)
	return true
end
