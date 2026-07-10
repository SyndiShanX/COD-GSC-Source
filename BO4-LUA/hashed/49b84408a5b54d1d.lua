require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingCustom = {}
Lobby.MatchmakingCustom.HandleDedicatedParkedStage = function(f1_arg0, f1_arg1)
	local f1_local0 = Enum[0x71A76D23911A20E][0x5AED0351BD1CE62]
	local f1_local1 = Engine[0x6D46FF33D97B908](f1_arg1)
	if f1_local1 ~= Lobby.Matchmaking.INVALID_PARKING_PLAYLIST then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "Lobby.MatchmakingCustom.HandleDedicatedParkedStage: No sessions found in playlistID<" .. f1_arg1 .. ">, looking in parkingPlaylist<" .. f1_local1 .. ">\n")
		Lobby.Matchmaking.SetMapPacksOriginal()
		Lobby.Matchmaking.SetPlaylistInfo(f1_local1)
	end
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_EMPTY)
	if Lobby.Matchmaking.SetServerLocation(f1_local0, f1_arg0) ~= true then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingCustom.HandleDedicatedParkedStage: Failed to set server location, doing a listen search instead\n")
	end
	Lobby.Matchmaking.SetSkillWeight(0)
	Lobby.Matchmaking.SetQueryId(f1_local0)
end
Lobby.MatchmakingCustom.SetupConnectionInfo = function(f2_arg0)
	local f2_local0 = Lobby.Matchmaking.GetConnection(f2_arg0)
	local f2_local1 = Dvar[0x9A8F14A21E7424D]:get()
	local f2_local2 = Dvar[0x8E0DBD8C71F9D10]:get()
	local f2_local3 = Dvar[0xB2C59B4EE116AEA]:get()
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
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingCustom.SetupConnectionInfo: Connection: " .. tostring(f2_local0) .. "\n")
end
Lobby.MatchmakingCustom.SetupMatchmakingStage = function(f3_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingCustom.SetupMatchmakingStage: Setting up Custom Dedicated matchmaking stage\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[0x805C82C8BA1B3C9][0xC7A6E94E122CDB2])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(0.01)
	local f3_local0 = Lobby.Matchmaking.SearchStage.DEDICATED_PARKED
	if f3_local0 == Lobby.Matchmaking.SearchStage.DONE then
		return false
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingCustom.SetupMatchmakingStage: Next Stage: " .. tostring(f3_local0) .. "\n")
	local f3_local1 = Engine[0x31C19A6AF221CC9](Engine[0x3EAC408F958FF05]())
	Engine[0xCE25A90DC553200](f3_local1)
	LuaUtils.SetQuickplayPlaylistID(f3_local1)
	Lobby.Matchmaking.SetPlaylistInfo(f3_local1)
	if Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.CUSTOM_DEDICATED then
		Lobby.MatchmakingCustom.HandleDedicatedParkedStage(f3_local0, f3_local1)
	else
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.MatchmakingCustom.SetupMatchmakingStage Called with Unhandled Search Mode.\n")
	end
	Lobby.Matchmaking.SetTeamSize(Lobby.Matchmaking.GetNumSlotsNeededOnTeam(f3_local0))
	Dvar[0xFD32115F3E81D0F]:set(Lobby.Matchmaking.GetMapPackBits(Engine[0xEC040B95C0BF471](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]), f3_local1))
	Lobby.MatchmakingCustom.SetupConnectionInfo(f3_arg0)
	return true
end
