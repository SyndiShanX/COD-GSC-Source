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
	if f1_local0 == Enum[@"lobbymodule"][@"lobby_module_host"] then
		Lobby.MatchmakingAsync.TelemetryOnClientAdded(f1_arg0)
		if f1_local1 == Enum[@"lobbytype"][@"lobby_type_game"] and Engine[@"isadvertisedlobby"](Enum[@"lobbytype"][@"lobby_type_game"]) then
			Lobby.Matchmaking.UpdateLatencyBand()
			Lobby.Matchmaking.UpdateAdvertising("client joined")
		end
		if f1_local1 == Enum[@"lobbytype"][@"lobby_type_game"] and Lobby.Platform.PlatformSessionDurangoS2SEnabled() then
			Lobby.Platform.PlatformSessionDurangoS2SCreateJoin(Engine[@"uint64tostring"](f1_arg0.xuid))
		end
	end
end
Lobby.Matchmaking.OnClientRemoved = function(f2_arg0)
	local f2_local0 = f2_arg0.lobbyModule
	local f2_local1 = f2_arg0.lobbyType
	local f2_local2 = f2_arg0.lobbyMode
	if f2_local0 == Enum[@"lobbymodule"][@"lobby_module_host"] then
		Lobby.MatchmakingAsync.TelemetryOnClientRemoved(f2_arg0)
		if f2_local1 == Enum[@"lobbytype"][@"lobby_type_game"] and Engine[@"isadvertisedlobby"](Enum[@"lobbytype"][@"lobby_type_game"]) then
			Lobby.Matchmaking.UpdateLatencyBand()
			Lobby.Matchmaking.UpdateAdvertising("client left")
		end
		if f2_local1 == Enum[@"lobbytype"][@"lobby_type_game"] and Lobby.Platform.PlatformSessionDurangoS2SEnabled() then
			Lobby.Platform.PlatformSessionDurangoS2SLeave(Engine[@"uint64tostring"](f2_arg0.xuid))
		end
	end
end
Lobby.Matchmaking.OnMatchStart = function(f3_arg0)
	local f3_local0 = f3_arg0.lobbyModule
	local f3_local1 = f3_arg0.lobbyType
	local f3_local2 = f3_arg0.lobbyMode
	if f3_local0 == Enum[@"lobbymodule"][@"lobby_module_host"] and f3_local1 == Enum[@"lobbytype"][@"lobby_type_game"] and Engine[@"iszombiesgame"]() and Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) then
		Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[@"showinmatchmaking"][@"show_in_matchmaking_false"], true)
	end
	local f3_local3 = Engine[@"hash_2786FFC9E621CAB7"]()
	if Lobby.MatchmakingAsync.LobbyIntermissionSummary ~= nil then
		Lobby.MatchmakingAsync.LobbyIntermissionSummary[@"hash_573A96EDFFBD3A8E"] = f3_local3
	end
	Lobby.MatchmakingAsync.MatchmakingSearchSummaryLog[@"hash_2B4A32E71C22452"] = f3_local3
	Lobby.MatchmakingAsync.PartyToMatchSummary[@"hash_2B4A32E71C22452"] = f3_local3
	Lobby.MatchmakingPriority.OnMatchStart(f3_arg0)
end
Lobby.Matchmaking.OnMatchEnd = function(f4_arg0)
	if LuaUtils.IsArenaMode() then
		Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[@"showinmatchmaking"][@"show_in_matchmaking_false"], true)
	else
		Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[@"showinmatchmaking"][@"show_in_matchmaking_true"], true)
	end
	Lobby.Matchmaking.OnlineAdvertiseOnMatchEnd(f4_arg0)
end
Lobby.Matchmaking.OnMatchChangeMap = function(f5_arg0)
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_campaign"] and Engine[@"isadvertisedlobby"](Enum[@"lobbytype"][@"lobby_type_game"]) then
		local f5_local0 = f5_arg0.nextMap
		if string.sub(f5_local0, 1, 6) == "cp_sh_" then
			f5_local0 = Dvar[@"cp_queued_level"]:get()
		end
		local f5_local1 = LuaUtils.GetPlaylistIDForSelectedCPMission(f5_local0)
		if f5_local1 ~= nil and f5_local1 > 0 and f5_local1 ~= Dvar[@"lobbyadvertiseplaylistnumber"]:get() then
			Dvar[@"lobbyadvertiseplaylistnumber"]:set(f5_local1)
			Dvar[@"lobbyadvertisedirty"]:set(true)
		end
	end
end
Lobby.Matchmaking.OnLobbyOnlineUpdate = function(f6_arg0)
	local f6_local0 = f6_arg0.type
	local f6_local1 = f6_arg0.errorCode
	if f6_local1 ~= nil and f6_local1 == LuaEnum.BD_NOT_CONNECTED then
		return
	elseif f6_local0 == Enum[@"lobbyonlineupdateeventtype"][@"lobby_online_update_pump"] then
	elseif f6_local0 == Enum[@"lobbyonlineupdateeventtype"][@"lobby_online_update_success"] then
		Lobby.Matchmaking.OnlineAdvertiseSuccess(f6_arg0)
	elseif f6_local0 == Enum[@"lobbyonlineupdateeventtype"][@"lobby_online_update_error"] then
		Lobby.Matchmaking.OnlineAdvertiseError(f6_arg0)
	end
end
Lobby.Matchmaking.OnJoinComplete = function(f7_arg0)
	Lobby.MatchmakingPriority.AddHost(f7_arg0.join.to.secIdint, f7_arg0.join.joinType)
end
Lobby.Matchmaking.GetFfotdPlaylistVersionNumber = function()
	return Engine[@"getffotdversion"]() * Lobby.Matchmaking.FFOTD_PLAYLIST_VERSION_OFFSET + Engine[@"getplaylistversionnumber"]()
end
Lobby.Matchmaking.ChangeAdvertisedStatus = function(f9_arg0, f9_arg1)
	Dvar[@"lobbyadvertiseshowinmatchmaking"]:set(f9_arg0)
	if f9_arg1 == true then
		Dvar[@"lobbyadvertisedirty"]:set(f9_arg1)
	end
end
Lobby.Matchmaking.GetLobbyAverageSkill = function()
	local f10_local0 = 0
	local f10_local1 = 0
	local f10_local2 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"])
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
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "UpdateAdvertising: " .. f11_arg0 .. "\n")
	local f11_local0 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"]) and Enum[@"lobbymodule"][@"lobby_module_host"] or Enum[@"lobbymodule"][@"lobby_module_client"]
	local f11_local1 = Engine[@"getlobbymaxclients"](f11_local0, Enum[@"lobbytype"][@"lobby_type_game"])
	local f11_local2 = Engine[@"getlobbyclientcount"](f11_local0, Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	Dvar[@"lobbyadvertisemaxplayers"]:set(f11_local1)
	Dvar[@"lobbyadvertisenumplayers"]:set(f11_local2)
	if f11_local2 > 0 then
		Dvar[@"lobbyadvertiseisempty"]:set(Lobby.Matchmaking.SessionEmpty.IS_NOT_EMPTY)
	else
		Dvar[@"lobbyadvertiseisempty"]:set(Lobby.Matchmaking.SessionEmpty.IS_EMPTY)
	end
	local f11_local3 = math.max(0, f11_local1 - f11_local2)
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_multiplayer"] then
		local f11_local4 = Engine[@"getplaylistid"]()
		local f11_local5 = math.floor(f11_local1 / 2)
		local f11_local6 = Engine[@"getplaylistmaxpartysize"](f11_local4)
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
			local f11_local10 = Engine[@"isingame"]()
			local f11_local11 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"])
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
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "UpdateAdvertising: setting max team size to: " .. f11_local3 .. "\n")
	Dvar[@"lobbyadvertiseteamsizemax"]:set(f11_local3)
	local f11_local4 = 0
	if LuaUtils.IsArenaMode() then
		f11_local4 = Lobby.MatchmakingArena.GetLobbyArenaSkill()
	else
		f11_local4 = Lobby.Matchmaking.GetLobbyAverageSkill()
	end
	Dvar[@"lobbyadvertiseskill"]:set(f11_local4)
	Dvar[@"lobbyadvertisedirty"]:set(true)
end
Lobby.Matchmaking.UpdateLatencyBand = function() end
Lobby.Matchmaking.GetServerType = function()
	if Engine[@"isdedicatedserver"]() == true then
		return Lobby.Matchmaking.ServerType.DEDICATED_SERVER
	else
		local f13_local0 = Engine[@"currentsessionmode"]()
		if f13_local0 == Enum[@"emodes"][@"mode_campaign"] then
			return Lobby.Matchmaking.ServerType.P2P_SERVER_CP
		elseif f13_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
			return Lobby.Matchmaking.ServerType.P2P_SERVER_MP
		elseif f13_local0 == Enum[@"emodes"][@"mode_zombies"] then
			return Lobby.Matchmaking.ServerType.P2P_SERVER_ZM
		else
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "No SessionMode was set. Defaulting to Lobby.Matchmaking.ServerType.P2P_SERVER_MP.\n")
			return Lobby.Matchmaking.ServerType.P2P_SERVER_MP
		end
	end
end
Lobby.Matchmaking.SetupAdvertising = function()
	local f14_local0 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"]) and Enum[@"lobbymodule"][@"lobby_module_host"] or Enum[@"lobbymodule"][@"lobby_module_client"]
	local f14_local1 = Engine[@"getlobbymaxclients"](f14_local0, Enum[@"lobbytype"][@"lobby_type_game"])
	local f14_local2 = Engine[@"getlobbyclientcount"](f14_local0, Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	Dvar[@"lobbyadvertiseservertype"]:set(Lobby.Matchmaking.GetServerType())
	Lobby.Matchmaking.ChangeAdvertisedStatus(Enum[@"showinmatchmaking"][@"show_in_matchmaking_true"], false)
	Dvar[@"lobbyadvertisenetcodeversion"]:set(Engine[@"getprotocolversion"]())
	local f14_local3 = Engine[@"getplaylistid"]()
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_multiplayer"] then
		Dvar[@"lobbyadvertisemappacks"]:set(Lobby.Matchmaking.GetMapPackBits(Engine[@"getdlcbitsforlobby"](Enum[@"lobbytype"][@"lobby_type_game"]), f14_local3))
	else
		Dvar[@"lobbyadvertisemappacks"]:set(Lobby.Matchmaking.ContentPack.CONTENT_ALL)
	end
	if Engine[@"isdedicatedserver"]() == true then
		Dvar[@"lobbyadvertisemappacks"]:set(Lobby.Matchmaking.ContentPack.CONTENT_ORIGINALMAPS)
		Dvar[@"lobbyadvertiseserverlocation"]:set(Dvar[@"hash_865091C89C1F37C"]:get())
		Dvar[@"lobbyadvertiselatencyband"]:set(0)
	end
	Dvar[@"lobbyadvertiseplaylistversion"]:set(Lobby.Matchmaking.GetFfotdPlaylistVersionNumber())
	Dvar[@"lobbyadvertiseplaylistnumber"]:set(f14_local3)
	Lobby.Matchmaking.UpdateAdvertising("session creation")
	local f14_local4 = Engine[@"getgeolocation"]()
	if f14_local4 == nil then
		Dvar[@"lobbyadvertisegeo1"]:set(0)
		Dvar[@"lobbyadvertisegeo2"]:set(0)
		Dvar[@"lobbyadvertisegeo3"]:set(0)
		Dvar[@"lobbyadvertisegeo4"]:set(0)
	else
		Dvar[@"lobbyadvertisegeo1"]:set(f14_local4.geo_1)
		Dvar[@"lobbyadvertisegeo2"]:set(f14_local4.geo_2)
		Dvar[@"lobbyadvertisegeo3"]:set(f14_local4.geo_3)
		Dvar[@"lobbyadvertisegeo4"]:set(f14_local4.geo_4)
	end
end
Lobby.Matchmaking.SetQueryId = function(f15_arg0)
	Dvar[@"lobbysearchqueryid"]:set(f15_arg0)
end
Lobby.Matchmaking.SetShowInMatchmaking = function(f16_arg0)
	Dvar[@"lobbysearchshowinmatchmaking"]:set(f16_arg0)
end
Lobby.Matchmaking.SetNetcodeVersion = function()
	Dvar[@"lobbysearchnetcodeversion"]:set(Engine[@"getprotocolversion"]())
end
Lobby.Matchmaking.SetMapPacks = function(f18_arg0)
	Dvar[@"lobbysearchmappacks"]:set(f18_arg0)
end
Lobby.Matchmaking.SetMapPacksOriginal = function()
	Lobby.Matchmaking.SetMapPacks(Lobby.Matchmaking.ContentPack.CONTENT_ORIGINALMAPS)
end
Lobby.Matchmaking.SetMapPacksAll = function()
	Lobby.Matchmaking.SetMapPacks(Lobby.Matchmaking.ContentPack.CONTENT_ALL)
end
Lobby.Matchmaking.GetMapPackBits = function(f21_arg0, f21_arg1)
	local f21_local0 = Lobby.Matchmaking.ContentPack.CONTENT_ORIGINALMAPS
	local f21_local1 = Engine[@"getplaylistinfobyid"](f21_arg1)
	if f21_local1 then
		f21_local0 = f21_local1.usedDLCMask & f21_arg0 | f21_local1.requiredDLCMask
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.Matchmaking.GetMapPackBits: Setting dlc bits to " .. f21_local0 .. " from client dlcBits " .. f21_arg0 .. ", playlist requiredBits " .. f21_local1.requiredDLCMask .. " and playlist usedBits " .. f21_local1.usedDLCMask .. "\n")
	else
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.Matchmaking.GetMapPackBits: Invalid playlistID " .. f21_arg1 .. ", setting dlc bits to originalmaps!\n")
	end
	return f21_local0
end
Lobby.Matchmaking.SetTeamSize = function(f22_arg0)
	Dvar[@"lobbysearchteamsize"]:set(f22_arg0)
end
Lobby.Matchmaking.SetPlaylistInfo = function(f23_arg0)
	Dvar[@"lobbysearchplaylistversion"]:set(Lobby.Matchmaking.GetFfotdPlaylistVersionNumber())
	Dvar[@"lobbysearchplaylistnumber"]:set(f23_arg0)
end
Lobby.Matchmaking.SetServerType = function(f24_arg0)
	Dvar[@"lobbysearchservertype"]:set(f24_arg0)
end
Lobby.Matchmaking.SetIsEmpty = function(f25_arg0)
	Dvar[@"lobbysearchisempty"]:set(f25_arg0)
end
Lobby.Matchmaking.SetSkillWeight = function(f26_arg0)
	local f26_local0 = 0
	if LuaUtils.IsArenaMode() then
		f26_local0 = Lobby.MatchmakingArena.GetLobbyArenaSkill()
	else
		f26_local0 = Lobby.Matchmaking.GetLobbyAverageSkill()
	end
	Dvar[@"lobbysearchskill"]:set(f26_local0)
	Dvar[@"lobbysearchskillweight"]:set(f26_arg0)
end
Lobby.Matchmaking.SetGeoLocation = function()
	local f27_local0 = Engine[@"getgeolocation"]()
	if f27_local0 == nil then
		Dvar[@"lobbysearchgeo1"]:set(0)
		Dvar[@"lobbysearchgeo2"]:set(0)
		Dvar[@"lobbysearchgeo3"]:set(0)
		Dvar[@"lobbysearchgeo4"]:set(0)
	else
		Dvar[@"lobbysearchgeo1"]:set(f27_local0.geo_1)
		Dvar[@"lobbysearchgeo2"]:set(f27_local0.geo_2)
		Dvar[@"lobbysearchgeo3"]:set(f27_local0.geo_3)
		Dvar[@"lobbysearchgeo4"]:set(f27_local0.geo_4)
	end
end
Lobby.Matchmaking.ClearPingBandWeightsAndServerLocations = function()
	Dvar[@"lobbysearchpingbandweight1"]:set(0)
	Dvar[@"lobbysearchpingbandweight2"]:set(0)
	Dvar[@"lobbysearchpingbandweight3"]:set(0)
	Dvar[@"lobbysearchpingbandweight4"]:set(0)
	Dvar[@"lobbysearchpingbandweight5"]:set(0)
	Dvar[@"lobbysearchserverlocation1"]:set(33)
	Dvar[@"lobbysearchserverlocation2"]:set(33)
	Dvar[@"lobbysearchserverlocation3"]:set(33)
	Dvar[@"lobbysearchserverlocation4"]:set(33)
	Dvar[@"lobbysearchserverlocation5"]:set(33)
end
Lobby.Matchmaking.SetServerLocation = function(f29_arg0, f29_arg1)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.Matchmaking.SetServerLocation(" .. f29_arg0 .. "," .. f29_arg1 .. ")\n")
	resultsOK = true
	forceServer = Dvar[@"lobbysearchforcelocation"]:get()
	if forceServer ~= 0 then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Forcing server to " .. forceServer .. "\n")
		Dvar[@"lobbysearchserverlocation1"]:set(forceServer)
		Dvar[@"lobbysearchpingband"]:set(1)
		return resultsOK
	end
	local f29_local0 = Engine[@"getgeolocation"]()
	local f29_local1 = Lobby.Matchmaking.DatacenterType.GAMESERVERS
	if Dvar[@"lobbysearchdatacentertype"]:get() ~= Lobby.Matchmaking.DatacenterType.ANY then
		f29_local1 = Dvar[@"lobbysearchdatacentertype"]:get()
	end
	if f29_local0 then
		Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_18B4C0E360D4C8BD", {
			[@"geo_1"] = f29_local0.geo_1,
			[@"geo_2"] = f29_local0.geo_2,
			[@"geo_3"] = f29_local0.geo_3,
			[@"geo_4"] = f29_local0.geo_4,
			[@"country_code"] = f29_local0.country_code,
			[@"region"] = f29_local0.region,
		})
		local f29_local2 = Dvar[@"lobbysearchdatacentertypegeo"]:get()
		for f29_local6, f29_local7 in pairs(Lobby.Matchmaking.DatacenterType) do
			local f29_local8 = nil
			if f29_local2:find("c" .. (f29_local0.country_code or "?") .. "=" .. f29_local6) then
				f29_local1 = f29_local7
			end
		end
	end
	if Dvar[@"lobbysearchdatacentertypeoverride"]:get() ~= Lobby.Matchmaking.DatacenterType.ANY then
		f29_local1 = Dvar[@"lobbysearchdatacentertypeoverride"]:get()
	end
	local f29_local2 = Engine[@"getdediqosresultsbytype"](f29_local1)
	if f29_local2.numResults == 0 then
		Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_794361818A6585EC", {
			[@"ok"] = false,
			[@"text"] = "No dedicated QOS results",
			[@"search_type"] = f29_local1,
		})
		resultsOK = false
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Tried to get dedicated qos results, but no results available\n")
	else
		servers = f29_local2.pingResults
		Lobby.Matchmaking.ClearPingBandWeightsAndServerLocations()
		pingCutoff = Dvar[@"lobbysearchdediunparkpinglimit"]:get()
		if f29_arg0 == Enum[@"queryid"][@"queryid_search_session_dedicated_parked"] then
			resultsOK = false
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Looking to unpark a server in:\n")
			for f29_local6, f29_local7 in ipairs(servers) do
				if f29_local6 <= Lobby.Matchmaking.MAX_DATACENTERS_IN_QUERY then
					if f29_local7.ping > pingCutoff then
					end
					Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], f29_local6 .. " " .. f29_local7.location .. " " .. f29_local7.ping .. "ms away\n")
					Dvar["lobbySearchServerLocation" .. tostring(f29_local6)].set(f29_local8["lobbySearchServerLocation" .. tostring(f29_local6)], f29_local7.location)
					Dvar["lobbySearchPingBandWeight" .. tostring(f29_local6)].set(f29_local8["lobbySearchPingBandWeight" .. tostring(f29_local6)], 6 - f29_local6)
					resultsOK = true
				end
			end
		else
			local f29_local3 = servers[1].ping
			if f29_local3 > pingCutoff then
				Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "There are no acceptable datacenters\n")
				resultsOK = false
				Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_794361818A6585EC", {
					[@"ok"] = false,
					[@"text"] = "No good datacenters",
					[@"search_type"] = f29_local1,
					[@"best_ping"] = f29_local3,
				})
			else
				if f29_arg1 <= f29_local2.numResults then
					local f29_local9 = f29_arg1
				end
				local f29_local4 = f29_local9 or 1
				if servers[f29_local4].ping > pingCutoff then
					Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Ping for location " .. servers[f29_local4].location .. " at " .. servers[f29_local4].ping .. "ms is too far away, selecting another suitable datacenter at random\n")
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
					Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Using index " .. f29_local4 .. " out of a possible " .. f29_local5 .. " good datacenters\n")
					Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Using location " .. servers[f29_local4].location .. " that is " .. servers[f29_local4].ping .. "ms away\n")
				end
				local f29_local5 = servers[f29_local4]
				Dvar[@"lobbysearchserverlocation1"]:set(f29_local5.location)
				if Engine[@"getdvarbool"]("lobbySearchPingBandEnabled") then
					Dvar[@"lobbysearchpingband"]:set(0)
					if f29_local5.location == Engine[@"getdvarint"]("lobbySearchExperimentDatacenter") or Engine[@"getdvarint"]("lobbySearchExperimentDatacenter") == 999 then
						Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "lobbySearchPingBandEnabled is true and the experiment DC matches (" .. f29_local5.location .. ") - setting the ping band to " .. f29_local5.ping .. "ms\n")
						Dvar[@"lobbysearchpingband"]:set(f29_local5.ping)
					end
				else
					Dvar[@"hash_1533394B0E51A918"]:set(f29_local5.ping)
				end
				Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Using datacenter " .. f29_local4 .. " for search stage " .. f29_arg1 .. "\n")
				Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Looking for an active server in " .. f29_local5.location .. " which is " .. f29_local5.ping .. "ms away\n")
				Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_794361818A6585EC", {
					[@"ok"] = true,
					[@"text"] = "Found datacenter",
					[@"search_type"] = f29_local1,
					[@"server_location"] = f29_local5.location,
					[@"ping"] = f29_local5.ping,
				})
				resultsOK = true
			end
		end
	end
	return resultsOK
end
Lobby.Matchmaking.SetPingBand = function(f30_arg0)
	Dvar[@"lobbysearchpingband"]:set(f30_arg0)
end
Lobby.Matchmaking.SetPingBandWeight = function(f31_arg0)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Ping band weight set to " .. f31_arg0 .. "\n")
	Dvar[@"lobbysearchpingbandweight1"]:set(f31_arg0)
end
Lobby.Matchmaking.SetGeoWeightFlat = function(f32_arg0)
	Dvar[@"lobbysearchgeo1weight"]:set(f32_arg0)
	Dvar[@"lobbysearchgeo2weight"]:set(f32_arg0)
	Dvar[@"lobbysearchgeo3weight"]:set(f32_arg0)
	Dvar[@"lobbysearchgeo4weight"]:set(f32_arg0)
end
Lobby.Matchmaking.SetGeoWeightTiered = function(f33_arg0)
	Dvar[@"lobbysearchgeo1weight"]:set(f33_arg0 * 4)
	Dvar[@"lobbysearchgeo2weight"]:set(f33_arg0 * 3)
	Dvar[@"lobbysearchgeo3weight"]:set(f33_arg0 * 2)
	Dvar[@"lobbysearchgeo4weight"]:set(f33_arg0)
end
Lobby.Matchmaking.PingRange = function(f34_arg0, f34_arg1)
	Dvar[@"qospreferredping"]:set(1)
	Dvar[@"qosmaxallowedping"]:set(f34_arg1)
end
Lobby.Matchmaking.MinGeoMatch = function(f35_arg0)
	Dvar[@"lobbysearchgeomin"]:set(f35_arg0)
end
Lobby.Matchmaking.GetConnection = function(f36_arg0)
	return 0
end
Lobby.Matchmaking.NextStage = function()
	local f37_local0 = Lobby.Matchmaking.SearchParams.stage
	if Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_multiplayer"] then
		f37_local0 = f37_local0 + 1
		local f37_local1 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
		if f37_local0 == Lobby.Matchmaking.SearchStage.DEDICATED_PARKED and not Lobby.MatchmakingMP.AllowUnparkSearch(f37_local1) then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Matchmaking: Unpark Stage Skipped. Setting stage to DEDICATED_ON_PLAYLIST_1\n")
			f37_local0 = Lobby.Matchmaking.SearchStage.DEDICATED_ON_PLAYLIST_1
			Lobby.Matchmaking.SearchParams.retry = Lobby.Matchmaking.SearchParams.retry + 1
		end
		if Lobby.Matchmaking.SearchStage.LISTEN <= f37_local0 and f37_local0 <= Lobby.Matchmaking.SearchStage.LISTEN_DESPERATE and not Lobby.MatchmakingMP.AllowListenSearch(f37_local1) then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Matchmaking: Listen Host Stage Skipped. Setting stage to DEDICATED_ON_PLAYLIST_1\n")
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
			stageTitle = @"hash_4CEF2BB5C997C164",
			stageDetails = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4B6CBF63FCB43294"),
		})
	elseif f37_local0 == Lobby.Matchmaking.SearchStage.LISTEN then
		Lobby.Matchmaking.UpdatePublicLobby({
			stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_3,
			stageTitle = @"hash_4C4D2D56E3932FAB",
			stageDetails = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7A2CD2CF34FD702F"),
		})
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "NextStage: " .. Lobby.Matchmaking.SearchParams.stage .. "-->" .. f37_local0 .. "\n")
	Lobby.Matchmaking.SearchParams.stage = f37_local0
	return f37_local0
end
Lobby.Matchmaking.GetNumSlotsNeededOnTeam = function(f38_arg0)
	local f38_local0 = 1
	if f38_arg0 ~= Lobby.Matchmaking.SearchStage.DEDICATED_PARKED then
		f38_local0 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
		if f38_local0 < 1 then
			Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "numSlotsNeededOnTeam was 0, why?\n")
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
		Lobby.Matchmaking.SearchParams.searchInfo.startTime = Engine[@"milliseconds"]()
		Lobby.Matchmaking.SearchParams.retry = 0
	elseif nil == Lobby.Matchmaking.SearchParams.searchInfo or nil == Lobby.Matchmaking.SearchParams.searchInfo.startTime then
		Lobby.Matchmaking.ClearSearchInfo()
		Lobby.Matchmaking.SearchParams.searchInfo.startTime = Engine[@"milliseconds"]()
		Lobby.Matchmaking.SearchParams.retry = 0
	end
end
Lobby.Matchmaking.SetupMatchmakingStage = function(f41_arg0)
	local f41_local0 = Engine[@"currentsessionmode"]()
	if f41_local0 == Enum[@"emodes"][@"mode_campaign"] then
		return Lobby.MatchmakingCP.SetupMatchmakingStage(f41_arg0)
	elseif f41_local0 == Enum[@"emodes"][@"mode_multiplayer"] then
		if Engine[@"getlobbymode"](Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"])) == Enum[@"lobbymode"][@"lobby_mode_custom"] then
			return Lobby.MatchmakingCustom.SetupMatchmakingStage(f41_arg0)
		elseif Engine[@"isdedicatedserver"]() == true then
			return Lobby.MatchmakingDedicated.SetupMatchmakingStage(f41_arg0)
		elseif LuaUtils.IsArenaMode() then
			return Lobby.MatchmakingArena.SetupMatchmakingStage(f41_arg0)
		else
			return Lobby.MatchmakingMP.SetupMatchmakingStage(f41_arg0)
		end
	elseif f41_local0 == Enum[@"emodes"][@"mode_zombies"] then
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
	if Engine[@"isdedicatedserver"]() == true then
		if Lobby.Matchmaking.LobbyOnline.errorCount == 1 then
			Lobby.Matchmaking.LobbyOnline.errorTime = Engine[@"milliseconds"]() + Lobby.Matchmaking.LobbyOnline.ADVERTISE_ERROR_TIME
		end
		Lobby.Matchmaking.LobbyOnline.reAdvertiseTime = Engine[@"milliseconds"]() + Lobby.Matchmaking.LobbyOnline.RE_ADVERTISE_INTERVAL
	elseif Engine[@"isingame"]() then
		Lobby.Matchmaking.LobbyOnline.comError = true
	else
		Lobby.Matchmaking.OnlineAdvertiseClear()
		LuaUtils.SafeComError(Enum[@"errorcode"][@"error_drop"], @"hash_B6154C132FDA6EE")
		return
	end
end
Lobby.Matchmaking.OnlineAdvertisePump = function(f45_arg0)
	if Engine[@"isdedicatedserver"]() == false then
		return
	elseif Lobby.Matchmaking.LobbyOnline.errorCount == 0 then
		return
	elseif Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"]) == false then
		Lobby.Matchmaking.OnlineAdvertiseClear()
		return
	elseif Lobby.Matchmaking.LobbyOnline.errorCount > 0 and Lobby.ProcessQueue.IsQueueEmpty() == true then
		if Engine[@"milliseconds"]() > Lobby.Matchmaking.LobbyOnline.reAdvertiseTime then
			Lobby.ProcessQueue.AddToQueue("ReAdvertiseLobby", Lobby.Process.ReAdvertiseLobby(controller))
			Lobby.Matchmaking.LobbyOnline.reAdvertiseTime = Engine[@"milliseconds"]() + Lobby.Matchmaking.LobbyOnline.RE_ADVERTISE_INTERVAL
		end
		if Engine[@"milliseconds"]() > Lobby.Matchmaking.LobbyOnline.errorTime then
			if Engine[@"isingame"]() then
				Lobby.Matchmaking.LobbyOnline.comError = true
			else
				Engine[@"advertiseerrorshutdown"](Enum[@"lobbytype"][@"lobby_type_game"])
				Lobby.Matchmaking.OnlineAdvertiseClear()
				LuaUtils.SafeComError(Enum[@"errorcode"][@"error_drop"], @"hash_B6154C132FDA6EE")
				return
			end
		end
	end
end
Lobby.Matchmaking.OnlineAdvertiseOnMatchEnd = function(f46_arg0)
	if Lobby.Matchmaking.LobbyOnline.errorCount > 0 and Lobby.Matchmaking.LobbyOnline.comError == true then
		Lobby.Matchmaking.OnlineAdvertiseClear()
		LuaUtils.SafeComError(Enum[@"errorcode"][@"error_drop"], @"hash_B6154C132FDA6EE")
		return
	else
	end
end
Lobby.Matchmaking.PublicLobby = {}
Lobby.Matchmaking.PublicLobby.stage = LuaEnum.PUBLIC_LOBBY.INVALID
Lobby.Matchmaking.PublicLobby.estimatedTime = 20
Lobby.Matchmaking.PublicLobby.startTime = 0
Lobby.Matchmaking.UpdatePublicLobby = function(f47_arg0)
	local f47_local0 = Engine[@"milliseconds"]() / 1000 - Lobby.Matchmaking.PublicLobby.startTime
	local f47_local1 = 0
	local f47_local2 = f47_arg0.stage and f47_arg0.stage or 0
	local f47_local3 = f47_arg0.stageTitle and f47_arg0.stageTitle or 0x0
	local f47_local4 = f47_arg0.stageDetails and f47_arg0.stageDetails or ""
	local f47_local5 = f47_arg0.startTime and f47_arg0.startTime or 0
	local f47_local6 = f47_arg0.intermissionTime and f47_arg0.intermissionTime or 0
	local f47_local7 = f47_arg0.showWaitingWidget and f47_arg0.showWaitingWidget or false
	Lobby.Matchmaking.PublicLobby.stage = f47_local2
	if f47_arg0.stage == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1 then
		Lobby.Matchmaking.PublicLobby.startTime = Engine[@"milliseconds"]() / 1000
	elseif f47_arg0.stage == LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4 then
		if f47_arg0.preloadPercentage ~= nil then
			local f47_local8 = f47_arg0.preloadPercentage
		end
		f47_local1 = f47_local8 or 0
	end
	local f47_local9 = Engine[@"getglobalmodel"]()
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
	if Dvar[@"hash_5C97E7161905FCA"]:exists() == true and Dvar[@"hash_5C97E7161905FCA"]:get() == true then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "UpdatePublicLobby: stage " .. f47_local2 .. "\n\t stageDetails " .. f47_local4 .. "\n\t elapsedTime " .. f47_local0 .. "\n\t matchmakingStartTime " .. f47_local5 .. "\n\t matchmakingIntermissionTime " .. f47_local6 .. "\n\t matchmakingEstimatedTime " .. Lobby.Matchmaking.PublicLobby.estimatedTime .. "\n\t stageLoadedFraction " .. f47_local1 .. "\n")
	end
end
Lobby.Matchmaking.UpdateSearchStatus = function(f48_arg0, f48_arg1, f48_arg2)
	Engine[@"hash_963E6074EEFD57"](f48_arg0, f48_arg1, f48_arg2)
end
Lobby.Matchmaking.UpdatePublicLobbySearch = function()
	local f49_local0 = Lobby.Matchmaking.PublicLobby.stage
	if f49_local0 < LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1 or f49_local0 > LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4 then
		return
	else
		local f49_local1 = math.floor(Engine[@"milliseconds"]() / 1000 - Lobby.Matchmaking.PublicLobby.startTime)
		local f49_local2 = Engine[@"getglobalmodel"]()
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
