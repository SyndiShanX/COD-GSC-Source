require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
require("x64:b8ea4f0a93b4f76")
Lobby.MatchmakingCP = {}
Lobby.MatchmakingCP.SetupMatchmakingStage = function(f1_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Setting up CP matchmaking stage.\n")
	Lobby.Matchmaking.SetShowInMatchmaking(Enum[0x805C82C8BA1B3C9][0xC7A6E94E122CDB2])
	Lobby.Matchmaking.SetNetcodeVersion()
	Lobby.Matchmaking.SetGeoLocation()
	Lobby.Matchmaking.SetIsEmpty(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	if Lobby.Matchmaking.SearchParams.mode == Lobby.Matchmaking.SearchMode.PUBLIC_CP_ALL then
		Lobby.Matchmaking.SetQueryId(Enum[0x71A76D23911A20E][0xC137C49BFA09150])
		Dvar[0x1DCDE4E59ACB1DF]:set(Lobby.Matchmaking.GetFfotdPlaylistVersionNumber())
		Dvar[0x57D6B84159AE9C8]:set(LuaDefine.INT_MAX)
	else
		Lobby.Matchmaking.SetQueryId(Enum[0x71A76D23911A20E][0x1288E0B9D3852C1])
		Lobby.Matchmaking.SetPlaylistInfo(Engine[0x7B3B2B73B53EB34]())
	end
	Lobby.Matchmaking.SetServerType(Lobby.Matchmaking.GetServerType())
	local f1_local0 = Lobby.Matchmaking.NextStage()
	local f1_local1 = Lobby.Matchmaking.GetConnection(f1_arg0)
	local f1_local2 = Dvar[0x9A8F14A21E7424D]:get()
	local f1_local3 = Dvar[0x8E0DBD8C71F9D10]:get()
	local f1_local4 = Dvar[0xB2C59B4EE116AEA]:get()
	Lobby.Matchmaking.SetGeoWeightTiered(0.2)
	Lobby.Matchmaking.SetSkillWeight(1)
	Lobby.Matchmaking.SetMapPacksAll()
	Lobby.Matchmaking.MinGeoMatch(1)
	Lobby.Matchmaking.SetTeamSize(Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F]))
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
