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
	local f3_local0 = Enum[0x71A76D23911A20E][0x5AED0351BD1CE62]
	local f3_local1 = Engine[0x7B3B2B73B53EB34]()
	local f3_local2 = Engine[0x6D46FF33D97B908](f3_local1)
	if f3_local2 ~= Lobby.Matchmaking.INVALID_PARKING_PLAYLIST then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.MatchmakingArena.HandleDedicatedParkedStage: No sessions found in playlistID<" .. f3_local1 .. ">, looking in parkingPlaylist<" .. f3_local2 .. ">\n")
		Lobby.Matchmaking.SetMapPacksOriginal()
		Lobby.Matchmaking.SetPlaylistInfo(f3_local2)
	end
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_EMPTY)
	if Lobby.Matchmaking.SetServerLocation(f3_local0, f3_arg0) ~= true then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingArena.HandleDedicatedParkedStage: Failed to set server location, doing a listen search instead\n")
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
	local f5_local0 = Enum[0x71A76D23911A20E][0x50431AFB53B1412]
	if Lobby.Matchmaking.SetServerLocation(f5_local0, f5_arg0) == true then
		Lobby.Matchmaking.SetPingBandWeight(1)
		Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
		Lobby.Matchmaking.SetQueryId(f5_local0)
	else
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingArena.DoDedicatedSearch: Failed to set server location, doing a listen search instead\n")
		if Dvar[0x181DF5AA7D92095]:exists() and Dvar[0x181DF5AA7D92095]:get() then
			Lobby.MatchmakingArena.DoListenSearch(f5_arg0)
		end
	end
end
Lobby.MatchmakingArena.DoListenSearch = function(f6_arg0)
	if Dvar[0x181DF5AA7D92095]:exists() and Dvar[0x181DF5AA7D92095]:get() then
		Lobby.Matchmaking.SetQueryId(Enum[0x71A76D23911A20E][0x1288E0B9D3852C1])
	else
		Lobby.MatchmakingArena.DoDedicatedSearch(f6_arg0)
	end
end
Lobby.MatchmakingArena.SetupConnectionInfo = function(f7_arg0)
	local f7_local0 = Lobby.Matchmaking.GetConnection(f7_arg0)
	local f7_local1 = Dvar[0x9A8F14A21E7424D]:get()
	local f7_local2 = Dvar[0x8E0DBD8C71F9D10]:get()
	local f7_local3 = Dvar[0xB2C59B4EE116AEA]:get()
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
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingArena.SetupConnectionInfo: Connection: " .. tostring(f7_local0) .. "\n")
end
Lobby.MatchmakingArena.SetupMatchmakingStage = function(f8_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingArena.SetupMatchmakingStage: Setting up arena matchmaking stage\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[0x805C82C8BA1B3C9][0xC7A6E94E122CDB2])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(0.01)
	local f8_local0 = Lobby.Matchmaking.NextStage()
	if f8_local0 == Lobby.Matchmaking.SearchStage.DONE then
		return false
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingArena.SetupMatchmakingStage: Next Stage: " .. tostring(f8_local0) .. "\n")
	Lobby.Matchmaking.SetPlaylistInfo(Engine[0x7B3B2B73B53EB34]())
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
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingArena.SetupMatchmakingStage Called with Unhandled Search Mode.\n")
	end
	Lobby.Matchmaking.SetTeamSize(Lobby.Matchmaking.GetNumSlotsNeededOnTeam(f8_local0))
	Dvar[0xFD32115F3E81D0F]:set(Lobby.Matchmaking.GetMapPackBits(Engine[0xEC040B95C0BF471](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]), Engine[0x7B3B2B73B53EB34]()))
	Lobby.MatchmakingArena.SetupConnectionInfo(f8_arg0)
	return true
end
Lobby.MatchmakingArena.CanHostAnyLobby = function()
	local f9_local0 = 10
	if Dvar[0xA5FFA081C299437]:exists() then
		f9_local0 = Dvar[0xA5FFA081C299437]:get()
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
	local f10_local1 = (Engine[0x9D33D652B9B0F3B]() - f10_local0) / 1000
	local f10_local2 = 0
	if Dvar[0x5A4B7E98B04250D]:exists() then
		f10_local2 = Dvar[0x5A4B7E98B04250D]:get()
	end
	local f10_local3 = 1
	if Dvar[0x4A22EC68E0798C5]:exists() then
		f10_local3 = Dvar[0x4A22EC68E0798C5]:get()
	end
	local f10_local4 = 2
	if Dvar[0x5215E81615C6A0F]:exists() then
		f10_local4 = Dvar[0x5215E81615C6A0F]:get()
	end
	local f10_local5 = math.min(f10_local2 + f10_local1 / f10_local4 * f10_local3, Engine[0xE0CCEEF5541DCD9]())
	if f10_arg0 == true then
		Lobby.Matchmaking.SearchParams.searchInfo.maxQOSedRange = f10_local5
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.MatchmakingArena.GetArenaSkillRange: Search Time " .. tostring(f10_local1) .. " seconds. Skill Range: " .. f10_local5 .. " points\n")
	return f10_local5
end
Lobby.MatchmakingArena.GetLobbyArenaSkill = function()
	local f11_local0 = {}
	local f11_local1 = 0
	local f11_local2 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
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
