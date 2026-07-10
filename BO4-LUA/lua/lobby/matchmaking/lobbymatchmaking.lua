require("x64:53e8db3768fb02a")
require("x64:3050b56bc941c17")
require("x64:2f7767db3f402c")
require("x64:b370b3af9224bd0")
require("x64:fce63782cae60aa")
require("x64:ebcb1114fc99aed")
require("x64:ed095114fda1463")
require("x64:e9d90114faeb24b")
require("x64:5008582fffb7f51")
require("x64:f589277656f0ada")
require("x64:6d4fe56f0a0f80f")
require("x64:a8c141ed4ad57ad")
Lobby.Matchmaking = {}
Lobby.Matchmaking.FFOTD_PLAYLIST_VERSION_OFFSET = 100000
Lobby.Matchmaking.INVALID_PARKING_PLAYLIST = 0
Lobby.Matchmaking.MAX_DATACENTERS_IN_QUERY = 5
Lobby.Matchmaking.SearchMode = {
	INVALID = 0,
	PUBLIC = 1,
	PUBLIC_CP_ALL = 2,
	ARENA = 3,
	LOBBY_MERGE = 4,
	CUSTOM_DEDICATED = 5,
}
Lobby.Matchmaking.ServerType = {
	P2P_SERVER_MP = 1000,
	P2P_SERVER_ZM = 1001,
	P2P_SERVER_CP = 1002,
	P2P_SERVER_CPZM = 1003,
	P2P_SERVER_CPDOA = 1004,
	DEDICATED_SERVER = 2000,
}
Lobby.Matchmaking.SearchStage = {
	DEDICATED_ON_PLAYLIST_1 = 1,
	DEDICATED_ON_PLAYLIST_2 = 2,
	DEDICATED_ON_PLAYLIST_3 = 3,
	DEDICATED_PARKED = 4,
	LISTEN = 5,
	LISTEN_DESPERATE = 6,
	DONE = 7,
}
Lobby.Matchmaking.Connection = {
	NORMAL = 0,
	BEST = 1,
	ANY = 2,
}
Lobby.Matchmaking.ContentPack = {
	CONTENT_ORIGINALMAPS = 2,
	CONTENT_ALL = 65535,
}
Lobby.Matchmaking.SessionEmpty = {
	IS_EMPTY = 1,
	IS_NOT_EMPTY = 0,
}
Lobby.Matchmaking.DatacenterType = {
	ANY = 0,
	GAMESERVERS = 1,
	THUNDERHEAD = 2,
}
Lobby.Matchmaking.SearchParams = {
	mode = -1,
	stage = -1,
	retry = -1,
}
Lobby.Matchmaking.OnClientAdded = function(f1_arg0)
	local f1_local0 = f1_arg0.lobbyModule
	local f1_local1 = f1_arg0.lobbyType
	local f1_local2 = f1_arg0.lobbyMode
	if f1_local0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] then
		Lobby.MatchmakingAsync.TelemetryOnClientAdded(f1_arg0)
		if f1_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and Engine[0xD0A7EB2B6916526](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
			Lobby.Matchmaking.UpdateLatencyBand()
			Lobby.Matchmaking.UpdateAdvertising("client joined")
		end
		if f1_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and Lobby.Platform.PlatformSessionDurangoS2SEnabled() then
			Lobby.Platform.PlatformSessionDurangoS2SCreateJoin(Engine[0x4C599F1694E23EF](f1_arg0.xuid))
		end
	end
end
Lobby.Matchmaking.OnClientRemoved = function(f2_arg0)
	local f2_local0 = f2_arg0.lobbyModule
	local f2_local1 = f2_arg0.lobbyType
	local f2_local2 = f2_arg0.lobbyMode
	if f2_local0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] then
		Lobby.MatchmakingAsync.TelemetryOnClientRemoved(f2_arg0)
		if f2_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and Engine[0xD0A7EB2B6916526](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
			Lobby.Matchmaking.UpdateLatencyBand()
			Lobby.Matchmaking.UpdateAdvertising("client left")
		end
		if f2_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and Lobby.Platform.PlatformSessionDurangoS2SEnabled() then
			Lobby.Platform.PlatformSessionDurangoS2SLeave(Engine[0x4C599F1694E23EF](f2_arg0.xuid))
		end
	end
end
Lobby.Matchmaking.OnMatchStart = function(f3_arg0)
	local f3_local0 = f3_arg0.lobbyModule
	local f3_local1 = f3_arg0.lobbyType
	local f3_local2 = f3_arg0.lobbyMode
	if f3_local0 == Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] and f3_local1 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and Engine[0x8EF5BEFA0AE50FE]() and Engine[0x9882F293C327557]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) then
		Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[0x805C82C8BA1B3C9][0xA0CDA037E1925A5], true)
	end
	local f3_local3 = Engine[0x786FFC9E621CAB7]()
	if Lobby.MatchmakingAsync.LobbyIntermissionSummary ~= nil then
		Lobby.MatchmakingAsync.LobbyIntermissionSummary[0x73A96EDFFBD3A8E] = f3_local3
	end
	Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[0x2B4A32E71C22452] = f3_local3
	Lobby.MatchmakingAsync.PartyToMatchSummary[0x2B4A32E71C22452] = f3_local3
	Lobby.MatchmakingPriority.OnMatchStart(f3_arg0)
end
Lobby.Matchmaking.OnMatchEnd = function(f4_arg0)
	if LuaUtils.IsArenaMode() then
		Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[0x805C82C8BA1B3C9][0xA0CDA037E1925A5], true)
	else
		Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[0x805C82C8BA1B3C9][0xC7A6E94E122CDB2], true)
	end
	Lobby.Matchmaking.OnlineAdvertiseOnMatchEnd(f4_arg0)
end
Lobby.Matchmaking.OnMatchChangeMap = function(f5_arg0)
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] and Engine[0xD0A7EB2B6916526](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		local f5_local0 = f5_arg0.nextMap
		if string.sub(f5_local0, 1, 6) == "cp_sh_" then
			f5_local0 = Dvar[0x8D438D99BE5C86F]:get()
		end
		local f5_local1 = LuaUtils.GetPlaylistIDForSelectedCPMission(f5_local0)
		if f5_local1 ~= nil and f5_local1 > 0 and f5_local1 ~= Dvar[0x5B789559A59177]:get() then
			Dvar[0x5B789559A59177]:set(f5_local1)
			Dvar[0x506FA050DCE73C]:set(true)
		end
	end
end
Lobby.Matchmaking.OnLobbyOnlineUpdate = function(f6_arg0)
	local f6_local0 = f6_arg0.type
	local f6_local1 = f6_arg0.errorCode
	if f6_local1 ~= nil and f6_local1 == LuaEnum.BD_NOT_CONNECTED then
		return
	elseif f6_local0 == Enum[0xAE044D01AE0C127][0x4D2CC8521E24CEC] then
	elseif f6_local0 == Enum[0xAE044D01AE0C127][0x937C3FE7EE85C2D] then
		Lobby.Matchmaking.OnlineAdvertiseSuccess(f6_arg0)
	elseif f6_local0 == Enum[0xAE044D01AE0C127][0xF9FF6C0CA2D397C] then
		Lobby.Matchmaking.OnlineAdvertiseError(f6_arg0)
	end
end
Lobby.Matchmaking.OnJoinComplete = function(f7_arg0)
	Lobby.MatchmakingPriority.AddHost(f7_arg0.join.to.secIdint, f7_arg0.join.joinType)
end
Lobby.Matchmaking.GetFfotdPlaylistVersionNumber = function()
	return Engine[0xBB208CB2EB85904]() * Lobby.Matchmaking.FFOTD_PLAYLIST_VERSION_OFFSET + Engine[0xB15BEE2BE53060A]()
end
Lobby.Matchmaking.ChangeAdvertisedStatus = function(f9_arg0, f9_arg1)
	Dvar[0xE5350E8F7BD556]:set(f9_arg0)
	if f9_arg1 == true then
		Dvar[0x506FA050DCE73C]:set(f9_arg1)
	end
end
Lobby.Matchmaking.GetLobbyAverageSkill = function()
	local f10_local0 = 0
	local f10_local1 = 0
	local f10_local2 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	for f10_local6, f10_local7 in ipairs(f10_local2.sessionClients) do
		f10_local0 = f10_local0 + f10_local7.skillRating
		f10_local1 = f10_local1 + 1
	end
	if f10_local1 == 0 then
		return 0
	else
		return f10_local0 / f10_local1
	end
end
Lobby.Matchmaking.UpdateAdvertising = function(f11_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "UpdateAdvertising: " .. f11_arg0 .. "\n")
	local f11_local0 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) and Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
	local f11_local1 = Engine[0x29B25E8DA873863](f11_local0, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f11_local2 = Engine[0x44FC97037CE42ED](f11_local0, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	Dvar[0x52B5D4465EE5AD8]:set(f11_local1)
	Dvar[0x8D7611F93A7FCFE]:set(f11_local2)
	if f11_local2 > 0 then
		Dvar[0x88AAC69E4F7C18D]:set(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	else
		Dvar[0x88AAC69E4F7C18D]:set(Lobby.Matchmaking.SessionEmpty.IS_EMPTY)
	end
	local f11_local3 = math.max(0, f11_local1 - f11_local2)
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		local f11_local4 = Engine[0x7B3B2B73B53EB34]()
		local f11_local5 = math.floor(f11_local1 / 2)
		local f11_local6 = Engine[0xB2BAD8AD577224E](f11_local4)
		local f11_local7 = f11_local1 - f11_local2
		local f11_local8 = {
			lobbyID = -1,
			lobbySkill = 0,
			skillRating = 0,
			arenaPoints = 0,
			xuid = 0,
		}
		local f11_local9 = math.min(math.min(f11_local6, f11_local5), f11_local7)
		f11_local3 = f11_local9
		if not CoDShared.IsGametypeTeamBased() then
			f11_local3 = math.min(f11_local6, f11_local1 - f11_local2)
		else
			local f11_local10 = Engine[0x7B48C1ABFF0F764]()
			local f11_local11 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
			for f11_local12 = f11_local9, 1, -1 do
				if f11_local10 then
					if Lobby.TeamSelection.CanSplitInProgress(f11_local11.sessionClients, {
						f11_local12,
					}, f11_local1) then
						f11_local3 = f11_local12
						break
					end
				end
				local f11_local15 = {}
				for f11_local19, f11_local20 in ipairs(f11_local11.sessionClients) do
					if f11_local10 then
						Lobby.TeamSelection.AddToPrivateLobbyListAsTeam(f11_local20, f11_local19, f11_local15)
					else
						Lobby.TeamSelection.AddToPrivateLobbyList(f11_local20, f11_local19, f11_local15)
					end
				end
				for f11_local16 = 1, f11_local12, 1 do
					Lobby.TeamSelection.AddToPrivateLobbyList(f11_local8, f11_local16 + #f11_local11.sessionClients, f11_local15)
				end
				f11_local16 = Lobby.TeamSelection.VladSplit(f11_local15, f11_local1)
				if math.max(f11_local16.counts[1], f11_local16.counts[2]) <= f11_local5 then
					f11_local3 = f11_local12
				end
			end
		end
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "UpdateAdvertising: setting max team size to: " .. f11_local3 .. "\n")
	Dvar[0xA90AF2FA81CF8EA]:set(f11_local3)
	local f11_local4 = 0
	if LuaUtils.IsArenaMode() then
		f11_local4 = Lobby.MatchmakingArena.GetLobbyArenaSkill()
	else
		f11_local4 = Lobby.Matchmaking.GetLobbyAverageSkill()
	end
	Dvar[0x64614F5CA9FF2B9]:set(f11_local4)
	Dvar[0x506FA050DCE73C]:set(true)
end
Lobby.Matchmaking.UpdateLatencyBand = function() end
Lobby.Matchmaking.GetServerType = function()
	if Engine[0xE39F1F30B306065]() == true then
		return Lobby.Matchmaking.ServerType.DEDICATED_SERVER
	else
		local f13_local0 = Engine[0x3EAC408F958FF05]()
		if f13_local0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
			return Lobby.Matchmaking.ServerType.P2P_SERVER_CP
		elseif f13_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			return Lobby.Matchmaking.ServerType.P2P_SERVER_MP
		elseif f13_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			return Lobby.Matchmaking.ServerType.P2P_SERVER_ZM
		else
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "No SessionMode was set. Defaulting to Lobby.Matchmaking.ServerType.P2P_SERVER_MP.\n")
			return Lobby.Matchmaking.ServerType.P2P_SERVER_MP
		end
	end
end
Lobby.Matchmaking.SetupAdvertising = function()
	local f14_local0 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) and Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
	local f14_local1 = Engine[0x29B25E8DA873863](f14_local0, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f14_local2 = Engine[0x44FC97037CE42ED](f14_local0, Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	Dvar[0x4EC2C20CC5CBE0F]:set(Lobby.Matchmaking.GetServerType())
	Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[0x805C82C8BA1B3C9][0xC7A6E94E122CDB2], false)
	Dvar[0x21B1541ECD98A72]:set(Engine[0xBDC89A97B6CE16D]())
	local f14_local3 = Engine[0x7B3B2B73B53EB34]()
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		Dvar[0xA96CE8EF5319D80]:set(Lobby.Matchmaking.GetMapPackBits(Engine[0xEC040B95C0BF471](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]), f14_local3))
	else
		Dvar[0xA96CE8EF5319D80]:set(Lobby.Matchmaking.ContentPack.CONTENT_ALL)
	end
	if Engine[0xE39F1F30B306065]() == true then
		Dvar[0xA96CE8EF5319D80]:set(Lobby.Matchmaking.ContentPack.CONTENT_ORIGINALMAPS)
		Dvar[0x7D325BF9B693A80]:set(Dvar[0x865091C89C1F37C]:get())
		Dvar[0x686027EBE0C93F5]:set(0)
	end
	Dvar[0x60990550E224156]:set(Lobby.Matchmaking.GetFfotdPlaylistVersionNumber())
	Dvar[0x5B789559A59177]:set(f14_local3)
	Lobby.Matchmaking.UpdateAdvertising("session creation")
	local f14_local4 = Engine[0xA8F2AC61C57D927]()
	if f14_local4 == nil then
		Dvar[0xC83EFEB4F222B40]:set(0)
		Dvar[0xC83F2EB4F223059]:set(0)
		Dvar[0xC83F1EB4F222EA6]:set(0)
		Dvar[0xC83F4EB4F2233BF]:set(0)
	else
		Dvar[0xC83EFEB4F222B40]:set(f14_local4.geo_1)
		Dvar[0xC83F2EB4F223059]:set(f14_local4.geo_2)
		Dvar[0xC83F1EB4F222EA6]:set(f14_local4.geo_3)
		Dvar[0xC83F4EB4F2233BF]:set(f14_local4.geo_4)
	end
end
Lobby.Matchmaking.SetQueryId = function(f15_arg0)
	Dvar[0xD6F0384367E76DC]:set(f15_arg0)
end
Lobby.Matchmaking.SetShowInMatchmaking = function(f16_arg0)
	Dvar[0x78CB42E7042F8CB]:set(f16_arg0)
end
Lobby.Matchmaking.SetNetcodeVersion = function()
	Dvar[0xB6D149B6BCE7B6D]:set(Engine[0xBDC89A97B6CE16D]())
end
Lobby.Matchmaking.SetMapPacks = function(f18_arg0)
	Dvar[0xFD32115F3E81D0F]:set(f18_arg0)
end
Lobby.Matchmaking.SetMapPacksOriginal = function()
	Lobby.Matchmaking.SetMapPacks(Lobby.Matchmaking.ContentPack.CONTENT_ORIGINALMAPS)
end
Lobby.Matchmaking.SetMapPacksAll = function()
	Lobby.Matchmaking.SetMapPacks(Lobby.Matchmaking.ContentPack.CONTENT_ALL)
end
Lobby.Matchmaking.GetMapPackBits = function(f21_arg0, f21_arg1)
	local f21_local0 = Lobby.Matchmaking.ContentPack.CONTENT_ORIGINALMAPS
	local f21_local1 = Engine[0x3ACB99DBAD24D55](f21_arg1)
	if f21_local1 then
		f21_local0 = f21_local1.usedDLCMask & f21_arg0 | f21_local1.requiredDLCMask
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.Matchmaking.GetMapPackBits: Setting dlc bits to " .. f21_local0 .. " from client dlcBits " .. f21_arg0 .. ", playlist requiredBits " .. f21_local1.requiredDLCMask .. " and playlist usedBits " .. f21_local1.usedDLCMask .. "\n")
	else
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.Matchmaking.GetMapPackBits: Invalid playlistID " .. f21_arg1 .. ", setting dlc bits to originalmaps!\n")
	end
	return f21_local0
end
Lobby.Matchmaking.SetTeamSize = function(f22_arg0)
	Dvar[0xF60C6CF17A46E6B]:set(f22_arg0)
end
Lobby.Matchmaking.SetPlaylistInfo = function(f23_arg0)
	Dvar[0x1DCDE4E59ACB1DF]:set(Lobby.Matchmaking.GetFfotdPlaylistVersionNumber())
	Dvar[0x57D6B84159AE9C8]:set(f23_arg0)
end
Lobby.Matchmaking.SetServerType = function(f24_arg0)
	Dvar[0x107859BFDA22E40]:set(f24_arg0)
end
Lobby.Matchmaking.SetIsEmpty = function(f25_arg0)
	Dvar[0x20D3B772483054C]:set(f25_arg0)
end
Lobby.Matchmaking.SetSkillWeight = function(f26_arg0)
	local f26_local0 = 0
	if LuaUtils.IsArenaMode() then
		f26_local0 = Lobby.MatchmakingArena.GetLobbyArenaSkill()
	else
		f26_local0 = Lobby.Matchmaking.GetLobbyAverageSkill()
	end
	Dvar[0xD4F5D5C347C308]:set(f26_local0)
	Dvar[0xBD1AD7AFB19CD88]:set(f26_arg0)
end
Lobby.Matchmaking.SetGeoLocation = function()
	local f27_local0 = Engine[0xA8F2AC61C57D927]()
	if f27_local0 == nil then
		Dvar[0xF78BBF8409E5E7F]:set(0)
		Dvar[0xF78BCF8409E6032]:set(0)
		Dvar[0xF78BDF8409E61E5]:set(0)
		Dvar[0xF78B6F8409E5600]:set(0)
	else
		Dvar[0xF78BBF8409E5E7F]:set(f27_local0.geo_1)
		Dvar[0xF78BCF8409E6032]:set(f27_local0.geo_2)
		Dvar[0xF78BDF8409E61E5]:set(f27_local0.geo_3)
		Dvar[0xF78B6F8409E5600]:set(f27_local0.geo_4)
	end
end
Lobby.Matchmaking.ClearPingBandWeightsAndServerLocations = function()
	Dvar[0x86E5B4B359DD833]:set(0)
	Dvar[0x86E5C4B359DD9E6]:set(0)
	Dvar[0x86E5D4B359DDB99]:set(0)
	Dvar[0x86E5E4B359DDD4C]:set(0)
	Dvar[0x86E5F4B359DDEFF]:set(0)
	Dvar[0x2599C296FF29D0A]:set(33)
	Dvar[0x2599B296FF29B57]:set(33)
	Dvar[0x2599A296FF299A4]:set(33)
	Dvar[0x25999296FF297F1]:set(33)
	Dvar[0x25998296FF2963E]:set(33)
end
Lobby.Matchmaking.SetServerLocation = function(f29_arg0, f29_arg1)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Lobby.Matchmaking.SetServerLocation(" .. f29_arg0 .. "," .. f29_arg1 .. ")\n")
	resultsOK = true
	forceServer = Dvar[0xA007B37323C55D]:get()
	if forceServer ~= 0 then
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Forcing server to " .. forceServer .. "\n")
		Dvar[0x2599C296FF29D0A]:set(forceServer)
		Dvar[0xBD37C49236A4C70]:set(1)
		return resultsOK
	end
	local f29_local0 = Engine[0xA8F2AC61C57D927]()
	local f29_local1 = Lobby.Matchmaking.DatacenterType.GAMESERVERS
	if Dvar[0x811D3265B27B866]:get() ~= Lobby.Matchmaking.DatacenterType.ANY then
		f29_local1 = Dvar[0x811D3265B27B866]:get()
	end
	if f29_local0 then
		Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x8B4C0E360D4C8BD, {
			[0x448289A6F1EFC82] = f29_local0.geo_1,
			[0x448279A6F1EFACF] = f29_local0.geo_2,
			[0x448269A6F1EF91C] = f29_local0.geo_3,
			[0x448259A6F1EF769] = f29_local0.geo_4,
			[0xAA2237F60C55967] = f29_local0.country_code,
			[0x755A623F50A24DD] = f29_local0.region,
		})
		local f29_local2 = Dvar[0xAF990C759653E57]:get()
		for f29_local6, f29_local7 in pairs(Lobby.Matchmaking.DatacenterType) do
			local f29_local8 = nil
			if f29_local2:find("c" .. (f29_local0.country_code or "?") .. "=" .. f29_local6) then
				f29_local1 = f29_local7
			end
		end
	end
	if Dvar[0xBF9CEA4DBF2906]:get() ~= Lobby.Matchmaking.DatacenterType.ANY then
		f29_local1 = Dvar[0xBF9CEA4DBF2906]:get()
	end
	local f29_local2 = Engine[0x29A1F6E8893B96F](f29_local1)
	if f29_local2.numResults == 0 then
		Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x94361818A6585EC, {
			[0x8B05D07B5566BEF] = false,
			[0xA04F4EF1995407E] = "No dedicated QOS results",
			[0xB4A693339717412] = f29_local1,
		})
		resultsOK = false
		Engine[0x5DF86CF48135674](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Tried to get dedicated qos results, but no results available\n")
	else
		servers = f29_local2.pingResults
		Lobby.Matchmaking.ClearPingBandWeightsAndServerLocations()
		pingCutoff = Dvar[0x39E15BDB813DCCB]:get()
		if f29_arg0 == Enum[0x71A76D23911A20E][0x5AED0351BD1CE62] then
			resultsOK = false
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Looking to unpark a server in:\n")
			for f29_local6, f29_local7 in ipairs(servers) do
				if f29_local6 <= Lobby.Matchmaking.MAX_DATACENTERS_IN_QUERY then
					if f29_local7.ping > pingCutoff then
					end
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], f29_local6 .. " " .. f29_local7.location .. " " .. f29_local7.ping .. "ms away\n")
					Dvar["lobbySearchServerLocation" .. tostring(f29_local6)].set(f29_local8["lobbySearchServerLocation" .. tostring(f29_local6)], f29_local7.location)
					Dvar["lobbySearchPingBandWeight" .. tostring(f29_local6)].set(f29_local8["lobbySearchPingBandWeight" .. tostring(f29_local6)], 6 - f29_local6)
					resultsOK = true
				end
			end
		else
			local f29_local3 = servers[1].ping
			if f29_local3 > pingCutoff then
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "There are no acceptable datacenters\n")
				resultsOK = false
				Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x94361818A6585EC, {
					[0x8B05D07B5566BEF] = false,
					[0xA04F4EF1995407E] = "No good datacenters",
					[0xB4A693339717412] = f29_local1,
					[0xD52A7039A81C620] = f29_local3,
				})
			else
				if f29_arg1 <= f29_local2.numResults then
					local f29_local9 = f29_arg1
				end
				local f29_local4 = f29_local9 or 1
				if servers[f29_local4].ping > pingCutoff then
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Ping for location " .. servers[f29_local4].location .. " at " .. servers[f29_local4].ping .. "ms is too far away, selecting another suitable datacenter at random\n")
					local f29_local5 = 1
					for f29_local10, f29_local11 in ipairs(servers) do
						if f29_local10 <= Lobby.Matchmaking.MAX_DATACENTERS_IN_QUERY then
							if f29_local11.ping > pingCutoff then
								break
							end
							f29_local5 = f29_local10
						end
					end
					f29_local4 = math.random(f29_local5)
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Using index " .. f29_local4 .. " out of a possible " .. f29_local5 .. " good datacenters\n")
					Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Using location " .. servers[f29_local4].location .. " that is " .. servers[f29_local4].ping .. "ms away\n")
				end
				local f29_local5 = servers[f29_local4]
				Dvar[0x2599C296FF29D0A]:set(f29_local5.location)
				if Engine[0x9E5BE3B4BBA4E0E]("lobbySearchPingBandEnabled") then
					Dvar[0xBD37C49236A4C70]:set(0)
					if f29_local5.location == Engine[0x22EAAB59AA27E9B]("lobbySearchExperimentDatacenter") or Engine[0x22EAAB59AA27E9B]("lobbySearchExperimentDatacenter") == 999 then
						Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "lobbySearchPingBandEnabled is true and the experiment DC matches (" .. f29_local5.location .. ") - setting the ping band to " .. f29_local5.ping .. "ms\n")
						Dvar[0xBD37C49236A4C70]:set(f29_local5.ping)
					end
				else
					Dvar[0x533394B0E51A918]:set(f29_local5.ping)
				end
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Using datacenter " .. f29_local4 .. " for search stage " .. f29_arg1 .. "\n")
				Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Looking for an active server in " .. f29_local5.location .. " which is " .. f29_local5.ping .. "ms away\n")
				Engine[0xDE279ECDDDD966](Engine[0xA5B9C0111291A8B](), 0x94361818A6585EC, {
					[0x8B05D07B5566BEF] = true,
					[0xA04F4EF1995407E] = "Found datacenter",
					[0xB4A693339717412] = f29_local1,
					[0x16A88DDE6D931C0] = f29_local5.location,
					[0xF30E00DC53307A9] = f29_local5.ping,
				})
				resultsOK = true
			end
		end
	end
	return resultsOK
end
Lobby.Matchmaking.SetPingBand = function(f30_arg0)
	Dvar[0xBD37C49236A4C70]:set(f30_arg0)
end
Lobby.Matchmaking.SetPingBandWeight = function(f31_arg0)
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Ping band weight set to " .. f31_arg0 .. "\n")
	Dvar[0x86E5B4B359DD833]:set(f31_arg0)
end
Lobby.Matchmaking.SetGeoWeightFlat = function(f32_arg0)
	Dvar[0x6A0C9D1B5E5E5BB]:set(f32_arg0)
	Dvar[0xC6A5C1204B980DA]:set(f32_arg0)
	Dvar[0xB39CA390B7FC7D9]:set(f32_arg0)
	Dvar[0xC17DF3E855A4940]:set(f32_arg0)
end
Lobby.Matchmaking.SetGeoWeightTiered = function(f33_arg0)
	Dvar[0x6A0C9D1B5E5E5BB]:set(f33_arg0 * 4)
	Dvar[0xC6A5C1204B980DA]:set(f33_arg0 * 3)
	Dvar[0xB39CA390B7FC7D9]:set(f33_arg0 * 2)
	Dvar[0xC17DF3E855A4940]:set(f33_arg0)
end
Lobby.Matchmaking.PingRange = function(f34_arg0, f34_arg1)
	Dvar[0xB331A08D4780C2B]:set(1)
	Dvar[0xD12B3AE4A4BEBB8]:set(f34_arg1)
end
Lobby.Matchmaking.MinGeoMatch = function(f35_arg0)
	Dvar[0xE01BF4D20878528]:set(f35_arg0)
end
Lobby.Matchmaking.GetConnection = function(f36_arg0)
	return 0
end
Lobby.Matchmaking.NextStage = function()
	local f37_local0 = Lobby.Matchmaking.SearchParams.stage
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f37_local0 = f37_local0 + 1
		local f37_local1 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F])
		if f37_local0 == Lobby.Matchmaking.SearchStage.DEDICATED_PARKED and not Lobby.MatchmakingMP.AllowUnparkSearch(f37_local1) then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Matchmaking: Unpark Stage Skipped. Setting stage to DEDICATED_ON_PLAYLIST_1\n")
			f37_local0 = Lobby.Matchmaking.SearchStage.DEDICATED_ON_PLAYLIST_1
			Lobby.Matchmaking.SearchParams.retry = Lobby.Matchmaking.SearchParams.retry + 1
		end
		if Lobby.Matchmaking.SearchStage.LISTEN <= f37_local0 and f37_local0 <= Lobby.Matchmaking.SearchStage.LISTEN_DESPERATE and not Lobby.MatchmakingMP.AllowListenSearch(f37_local1) then
			Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "Matchmaking: Listen Host Stage Skipped. Setting stage to DEDICATED_ON_PLAYLIST_1\n")
			f37_local0 = Lobby.Matchmaking.SearchStage.DEDICATED_ON_PLAYLIST_1
			Lobby.Matchmaking.SearchParams.retry = Lobby.Matchmaking.SearchParams.retry + 1
		end
	elseif f37_local0 == 0 then
		f37_local0 = Lobby.Matchmaking.SearchStage.LISTEN
	else
		f37_local0 = f37_local0 + 1
	end
	if f37_local0 == Lobby.Matchmaking.SearchStage.DEDICATED_ON_PLAYLIST_3 then
		Lobby.Matchmaking.UpdatePublicLobby({
			stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_2,
			stageTitle = 0xCEF2BB5C997C164,
			stageDetails = Engine[0xF9F1239CFD921FE](0xB6CBF63FCB43294),
		})
	elseif f37_local0 == Lobby.Matchmaking.SearchStage.LISTEN then
		Lobby.Matchmaking.UpdatePublicLobby({
			stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3,
			stageTitle = 0xC4D2D56E3932FAB,
			stageDetails = Engine[0xF9F1239CFD921FE](0xA2CD2CF34FD702F),
		})
	end
	Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "NextStage: " .. Lobby.Matchmaking.SearchParams.stage .. "-->" .. f37_local0 .. "\n")
	Lobby.Matchmaking.SearchParams.stage = f37_local0
	return f37_local0
end
Lobby.Matchmaking.GetNumSlotsNeededOnTeam = function(f38_arg0)
	local f38_local0 = 1
	if f38_arg0 ~= Lobby.Matchmaking.SearchStage.DEDICATED_PARKED then
		f38_local0 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], Enum[0x575E471C039DBD6][0x92BC25E18D296F])
		if f38_local0 < 1 then
			Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "numSlotsNeededOnTeam was 0, why?\n")
			f38_local0 = 1
		end
	end
	return f38_local0
end
Lobby.Matchmaking.ClearSearchInfo = function()
	Lobby.Matchmaking.SearchParams.searchInfo = {}
end
Lobby.Matchmaking.SetupMatchmakingQuery = function(f40_arg0, f40_arg1, f40_arg2)
	if nil == f40_arg1 then
		error("Lobby.Matchmaking.SetupMatchmakingQuery called with nil mode")
	end
	Lobby.Matchmaking.SearchParams.mode = f40_arg1
	Lobby.Matchmaking.SearchParams.stage = 0
	if f40_arg2 == true then
		Lobby.Matchmaking.ClearSearchInfo()
		Lobby.Matchmaking.SearchParams.searchInfo.startTime = Engine[0x9D33D652B9B0F3B]()
		Lobby.Matchmaking.SearchParams.retry = 0
	elseif nil == Lobby.Matchmaking.SearchParams.searchInfo or nil == Lobby.Matchmaking.SearchParams.searchInfo.startTime then
		Lobby.Matchmaking.ClearSearchInfo()
		Lobby.Matchmaking.SearchParams.searchInfo.startTime = Engine[0x9D33D652B9B0F3B]()
		Lobby.Matchmaking.SearchParams.retry = 0
	end
end
Lobby.Matchmaking.SetupMatchmakingStage = function(f41_arg0)
	local f41_local0 = Engine[0x3EAC408F958FF05]()
	if f41_local0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		return Lobby.MatchmakingCP.SetupMatchmakingStage(f41_arg0)
	elseif f41_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		if Engine[0x17B32C04C4BE462](Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103])) == Enum[0x8409AA0F01B5DBC][0xF5EE25D311E5223] then
			return Lobby.MatchmakingCustom.SetupMatchmakingStage(f41_arg0)
		elseif Engine[0xE39F1F30B306065]() == true then
			return Lobby.MatchmakingDedicated.SetupMatchmakingStage(f41_arg0)
		elseif LuaUtils.IsArenaMode() then
			return Lobby.MatchmakingArena.SetupMatchmakingStage(f41_arg0)
		else
			return Lobby.MatchmakingMP.SetupMatchmakingStage(f41_arg0)
		end
	elseif f41_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return Lobby.MatchmakingZM.SetupMatchmakingStage(f41_arg0)
	else
		return false
	end
end
Lobby.Matchmaking.LobbyOnline = {
	errorCount = 0,
	errorTime = -1,
	reAdvertiseTime = -1,
	comError = false,
	RE_ADVERTISE_INTERVAL = 30000,
	ADVERTISE_ERROR_TIME = 300000,
}
Lobby.Matchmaking.OnlineAdvertiseClear = function()
	Lobby.Matchmaking.LobbyOnline = {
		errorCount = 0,
		errorTime = -1,
		reAdvertiseTime = -1,
		comError = false,
		RE_ADVERTISE_INTERVAL = 30000,
		ADVERTISE_ERROR_TIME = 300000,
	}
end
Lobby.Matchmaking.OnlineAdvertiseSuccess = function(f43_arg0)
	Lobby.Matchmaking.OnlineAdvertiseClear()
end
Lobby.Matchmaking.OnlineAdvertiseError = function(f44_arg0)
	Lobby.Matchmaking.LobbyOnline.errorCount = Lobby.Matchmaking.LobbyOnline.errorCount + 1
	if Engine[0xE39F1F30B306065]() == true then
		if Lobby.Matchmaking.LobbyOnline.errorCount == 1 then
			Lobby.Matchmaking.LobbyOnline.errorTime = Engine[0x9D33D652B9B0F3B]() + Lobby.Matchmaking.LobbyOnline.ADVERTISE_ERROR_TIME
		end
		Lobby.Matchmaking.LobbyOnline.reAdvertiseTime = Engine[0x9D33D652B9B0F3B]() + Lobby.Matchmaking.LobbyOnline.RE_ADVERTISE_INTERVAL
	elseif Engine[0x7B48C1ABFF0F764]() then
		Lobby.Matchmaking.LobbyOnline.comError = true
	else
		Lobby.Matchmaking.OnlineAdvertiseClear()
		LuaUtils.SafeComError(Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF], 0xB6154C132FDA6EE)
		return
	end
end
Lobby.Matchmaking.OnlineAdvertisePump = function(f45_arg0)
	if Engine[0xE39F1F30B306065]() == false then
		return
	elseif Lobby.Matchmaking.LobbyOnline.errorCount == 0 then
		return
	elseif Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) == false then
		Lobby.Matchmaking.OnlineAdvertiseClear()
		return
	elseif Lobby.Matchmaking.LobbyOnline.errorCount > 0 and Lobby.ProcessQueue.IsQueueEmpty() == true then
		if Engine[0x9D33D652B9B0F3B]() > Lobby.Matchmaking.LobbyOnline.reAdvertiseTime then
			Lobby.ProcessQueue.AddToQueue("ReAdvertiseLobby", Lobby.Process.ReAdvertiseLobby(controller))
			Lobby.Matchmaking.LobbyOnline.reAdvertiseTime = Engine[0x9D33D652B9B0F3B]() + Lobby.Matchmaking.LobbyOnline.RE_ADVERTISE_INTERVAL
		end
		if Engine[0x9D33D652B9B0F3B]() > Lobby.Matchmaking.LobbyOnline.errorTime then
			if Engine[0x7B48C1ABFF0F764]() then
				Lobby.Matchmaking.LobbyOnline.comError = true
			else
				Engine[0x3D86AB10C408002](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
				Lobby.Matchmaking.OnlineAdvertiseClear()
				LuaUtils.SafeComError(Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF], 0xB6154C132FDA6EE)
				return
			end
		end
	end
end
Lobby.Matchmaking.OnlineAdvertiseOnMatchEnd = function(f46_arg0)
	if Lobby.Matchmaking.LobbyOnline.errorCount > 0 and Lobby.Matchmaking.LobbyOnline.comError == true then
		Lobby.Matchmaking.OnlineAdvertiseClear()
		LuaUtils.SafeComError(Enum[0xE4C65AA61FAEC38][0x100911D2B38A4EF], 0xB6154C132FDA6EE)
		return
	else
	end
end
Lobby.Matchmaking.PublicLobby = {}
Lobby.Matchmaking.PublicLobby.stage = LuaEnum.PUBLIC_LOBBY.INVALID
Lobby.Matchmaking.PublicLobby.estimatedTime = 20
Lobby.Matchmaking.PublicLobby.startTime = 0
Lobby.Matchmaking.UpdatePublicLobby = function(f47_arg0)
	local f47_local0 = Engine[0x9D33D652B9B0F3B]() / 1000 - Lobby.Matchmaking.PublicLobby.startTime
	local f47_local1 = 0
	local f47_local2 = f47_arg0.stage and f47_arg0.stage or 0
	local f47_local3 = f47_arg0.stageTitle and f47_arg0.stageTitle or 0x0
	local f47_local4 = f47_arg0.stageDetails and f47_arg0.stageDetails or ""
	local f47_local5 = f47_arg0.startTime and f47_arg0.startTime or 0
	local f47_local6 = f47_arg0.intermissionTime and f47_arg0.intermissionTime or 0
	local f47_local7 = f47_arg0.showWaitingWidget and f47_arg0.showWaitingWidget or false
	Lobby.Matchmaking.PublicLobby.stage = f47_local2
	if f47_arg0.stage == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1 then
		Lobby.Matchmaking.PublicLobby.startTime = Engine[0x9D33D652B9B0F3B]() / 1000
	elseif f47_arg0.stage == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4 then
		if f47_arg0.preloadPercentage ~= nil then
			local f47_local8 = f47_arg0.preloadPercentage
		end
		f47_local1 = f47_local8 or 0
	end
	local f47_local9 = Engine[0x8DF2E5447F384B9]()
	f47_local9 = f47_local9:create("lobbyRoot.publicLobby")
	local f47_local10 = f47_local9:create("stage")
	f47_local10:set(f47_local2)
	f47_local10 = f47_local9:create("stageTitle")
	f47_local10:set(f47_local3)
	f47_local10 = f47_local9:create("stageDetails")
	f47_local10:set(f47_local4)
	f47_local10 = f47_local9:create("matchmakingStartTime")
	f47_local10:set(f47_local5)
	f47_local10 = f47_local9:create("matchmakingIntermissionTime")
	f47_local10:set(f47_local6)
	f47_local10 = f47_local9:create("waitingAnimation")
	f47_local10:set(f47_local7)
	if f47_arg0.stage == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1 then
		f47_local10 = f47_local9:create("matchmakingEstimatedTime")
		f47_local10:set(Lobby.Matchmaking.PublicLobby.estimatedTime)
	end
	f47_local10 = f47_local9:create("stageLoadedFraction")
	f47_local10:set(f47_local1)
	if Dvar[0x5C97E7161905FCA]:exists() == true and Dvar[0x5C97E7161905FCA]:get() == true then
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0x59962D5EF982597], "UpdatePublicLobby: stage " .. f47_local2 .. "\n\t stageDetails " .. f47_local4 .. "\n\t elapsedTime " .. f47_local0 .. "\n\t matchmakingStartTime " .. f47_local5 .. "\n\t matchmakingIntermissionTime " .. f47_local6 .. "\n\t matchmakingEstimatedTime " .. Lobby.Matchmaking.PublicLobby.estimatedTime .. "\n\t stageLoadedFraction " .. f47_local1 .. "\n")
	end
end
Lobby.Matchmaking.UpdateSearchStatus = function(f48_arg0, f48_arg1, f48_arg2)
	Engine[0x963E6074EEFD57](f48_arg0, f48_arg1, f48_arg2)
end
Lobby.Matchmaking.UpdatePublicLobbySearch = function()
	local f49_local0 = Lobby.Matchmaking.PublicLobby.stage
	if f49_local0 < LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1 or f49_local0 > LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4 then
		return
	else
		local f49_local1 = math.floor(Engine[0x9D33D652B9B0F3B]() / 1000 - Lobby.Matchmaking.PublicLobby.startTime)
		local f49_local2 = Engine[0x8DF2E5447F384B9]()
		f49_local2 = f49_local2:create("lobbyRoot.publicLobby")
		local f49_local3 = f49_local2:create("matchmakingElapsedTime")
		f49_local3:set(f49_local1)
	end
end
Lobby.Matchmaking.Pump = function(f50_arg0)
	Lobby.Matchmaking.OnlineAdvertisePump(f50_arg0)
	Lobby.Matchmaking.UpdatePublicLobbySearch()
	Lobby.MatchmakingAsync.Pump(f50_arg0)
	Lobby.MatchmakingAsync.DlogPump(f50_arg0)
end
