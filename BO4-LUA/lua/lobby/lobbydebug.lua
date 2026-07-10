require("x64:53e8db3768fb02a")
require("x64:2f7767db3f402c")
require("x64:b370b3af9224bd0")
require("x64:b5d5f7ffe97a9a7")
if Engine[@"isdevelopmentbuild"]() then
	require("x64:3b9be7a3bb18b43")
end
Lobby.Debug = {}
Lobby.Debug.COLOR = {
	BLACK = "^0",
	RED = "^1",
	GREEN = "^2",
	YELLOW = "^3",
	BLUE = "^4",
	CYAN = "^5",
	MAGENTA = "^6",
	WHITE = "^7",
	MYTEAM = "^8",
	ENEMYTEAM = "^9",
}
Lobby.Debug.ProcessQueueDlogEvent = {
	[@"content"] = {},
}
Lobby.Debug.Action = {
	[@"action_count"] = 0,
	[@"actions"] = {},
}
Lobby.Debug.LobbyMember = {
	[@"hash_43081CC1B79588F9"] = 0,
	[@"hash_49BF5522E36C4FF6"] = 0,
	[@"lobby_members"] = {},
}
Lobby.Debug.Matchmaking = {
	[@"hash_FE1BB65E8DE4D51"] = Engine[@"defaultid64value"](),
	[@"hash_7A4B7F92D7E1DC7B"] = Engine[@"defaultid64value"](),
}
Lobby.Debug.jbEvent = LuaEnum.JB_MATCHMAKING_EVENT.START
if Engine[@"isshipbuild"]() then
	Lobby.Debug.gamertagDebugVisListOrbis = {}
	Lobby.Debug.gamertagDebugVisListDurango = {}
	Lobby.Debug.lobbyValidateListOrbis = {}
	Lobby.Debug.lobbyValidateListDurango = {
		"2 Dev 60168782",
	}
	Lobby.Debug.lobbySQJListOrbis = {}
	Lobby.Debug.lobbySQJListDurango = {}
else
	Lobby.Debug.gamertagDebugVisListOrbis = {}
	Lobby.Debug.gamertagDebugVisListDurango = {}
	Lobby.Debug.lobbyValidateListOrbis = {}
	Lobby.Debug.lobbyValidateListDurango = {}
	Lobby.Debug.lobbySQJListOrbis = {}
	Lobby.Debug.lobbySQJListDurango = {}
end
Lobby.Debug.EnableForPrimaryController = function(f1_arg0)
	if Engine[@"isdedicatedserver"]() then
		return false
	end
	local f1_local0 = Engine[@"getprimarycontroller"]()
	if f1_local0 == LuaDefine.INVALID_CONTROLLER_PORT or #f1_arg0 == 0 then
		return false
	end
	local f1_local1 = Engine[@"getgamertagforcontroller"](f1_local0)
	if f1_local1 == nil or f1_local1 == "" then
		return false
	end
	for f1_local5, f1_local6 in pairs(f1_arg0) do
		if f1_local1 == f1_local6 then
			return true
		end
	end
	return false
end
Lobby.Debug.LobbyDebugVisEnable = function()
	if Engine[@"getcurrentplatform"]() == "orbis" then
		if not Lobby.Debug.EnableForPrimaryController(Lobby.Debug.gamertagDebugVisListOrbis) then
			return
		end
	elseif Engine[@"getcurrentplatform"]() == "durango" and not Lobby.Debug.EnableForPrimaryController(Lobby.Debug.gamertagDebugVisListDurango) then
		return
	end
	Dvar[@"ui_lobbydebugvis"]:set(1)
end
Lobby.Debug.validateInfo = {
	Enabled = false,
	LastScreen = 0,
	CheckTime = 0,
	CheckDelay = 3000,
	CheckInterval = 1000,
}
Lobby.Debug.LobbyValidateEnable = function()
	if Engine[@"getcurrentplatform"]() == "orbis" then
		if not Lobby.Debug.EnableForPrimaryController(Lobby.Debug.lobbyValidateListOrbis) then
			return
		end
	elseif Engine[@"getcurrentplatform"]() == "durango" and not Lobby.Debug.EnableForPrimaryController(Lobby.Debug.lobbyValidateListDurango) then
		return
	end
	Lobby.Debug.validateInfo.Enabled = true
end
Lobby.Debug.LobbySQJEnable = function()
	if Engine[@"getcurrentplatform"]() == "orbis" then
		if not Lobby.Debug.EnableForPrimaryController(Lobby.Debug.lobbySQJListOrbis) then
			return
		end
	elseif Engine[@"getcurrentplatform"]() == "durango" and not Lobby.Debug.EnableForPrimaryController(Lobby.Debug.lobbySQJListDurango) then
		return
	end
	Dvar[@"ui_lobbydebugsessionsqj"]:set(1)
end
Lobby.Debug.LobbyValidate = function()
	if Engine[@"isdedicatedserver"]() then
		return
	elseif Lobby.Debug.validateInfo.Enabled == false then
		return
	elseif not Lobby.ProcessQueue.IsQueueEmpty() then
		return
	end
	local f5_local0 = Engine[@"getlobbyuiscreen"]()
	if f5_local0 == 0 then
		return
	elseif f5_local0 ~= Lobby.Debug.validateInfo.LastScreen then
		Lobby.Debug.validateInfo.LastScreen = f5_local0
		Lobby.Debug.validateInfo.CheckTime = Engine[@"milliseconds"]() + Lobby.Debug.validateInfo.CheckDelay
	end
	if Engine[@"milliseconds"]() < Lobby.Debug.validateInfo.CheckTime then
		return
	end
	Lobby.Debug.validateInfo.CheckTime = Engine[@"milliseconds"]() + Lobby.Debug.validateInfo.CheckInterval
	local f5_local1 = LobbyData.GetLobbyMenuByID(f5_local0)
	if f5_local1 == nil then
		return
	end
	local f5_local2 = Engine[@"getlobbynetworkmode"]()
	local f5_local3 = Engine[@"getlobbymainmode"]()
	local f5_local4 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	local f5_local5 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	local f5_local6 = Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	local f5_local7 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f5_local8 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	local f5_local9 = Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	if f5_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) and f5_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN) and f5_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) and f5_local1[@"networkmode"] ~= f5_local2 then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: Network Mode mismatch. uiInfo.@networkMode(" .. f5_local1[@"networkmode"] .. ") ~= networkMode(" .. f5_local2 .. ").\n")
	end
	if f5_local1[@"mainmode"] ~= f5_local3 then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: Main Mode mismatch. uiInfo.@mainMode(" .. f5_local1[@"mainmode"] .. ") ~= mainMode(" .. f5_local3 .. ").\n")
	end
	if f5_local1[@"isprivate"] ~= f5_local4 then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], string.format(Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: Private active mismatch. uiInfo.@isPrivate(%s) ~= privateActive(%s).\n", tostring(f5_local1[@"isprivate"]), tostring(f5_local4)))
	end
	if f5_local1[@"isgame"] ~= f5_local7 then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], string.format(Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: Game active mismatch. uiInfo.@isGame(%s) ~= gameActive(%s).\n", tostring(f5_local1[@"isgame"]), tostring(f5_local7)))
	end
	if f5_local1[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_invalid"] then
		if f5_local5 ~= 0 or f5_local8 ~= 0 then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: LobbyType LOBBY_TYPE_INVALID player count: privateClientCount(" .. f5_local5 .. ") ~= 0 or gameClientCount(" .. f5_local8 .. ") ~= 0.\n")
		end
	elseif f5_local1[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_private"] then
		if f5_local5 == 0 or f5_local8 ~= 0 then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: LobbyType LOBBY_TYPE_PRIVATE player count: privateClientCount(" .. f5_local5 .. ") == 0 or gameClientCount(" .. f5_local8 .. ") ~= 0.\n")
		end
		if f5_local1[@"maxclients"] < f5_local6 then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: LobbyType LOBBY_TYPE_PRIVATE maxClient mismatch. uiInfo.@maxClients(" .. f5_local1[@"maxclients"] .. ") < privateMaxClients(" .. f5_local6 .. ").\n")
		end
	elseif f5_local1[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_game"] then
		if f5_local5 == 0 or f5_local8 == 0 then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: LobbyType LOBBY_TYPE_GAME player count: privateClientCount(" .. f5_local5 .. ") == 0 or gameClientCount(" .. f5_local8 .. ") == 0.\n")
		end
		if f5_local1[@"maxclients"] < f5_local9 then
			Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], Lobby.Debug.COLOR.MAGENTA .. "Lobby.Debug.LobbyValidate: LobbyType LOBBY_TYPE_GAME maxClient mismatch. uiInfo.@maxClients(" .. f5_local1[@"maxclients"] .. ") < gameMaxClients(" .. f5_local9 .. ").\n")
		end
	end
end
Lobby.Debug.NumberOfSQJRowsToDisplay = 50
Lobby.Debug.sessionSQJ = {
	searchStage = 0,
	results = {
		asyncMatchmakingStrings = {},
	},
	joinOrder = 0,
}
Lobby.Debug.SessionSQJEnabled = function()
	if Dvar[@"ui_lobbydebugsessionsqj"]:get() == false then
		return false
	else
		return true
	end
end
Lobby.Debug.SessionSQJClearModels = function()
	if not Lobby.Debug.SessionSQJEnabled() then
		return
	end
	local f7_local0 = function(f8_arg0, f8_arg1, f8_arg2)
		local f8_local0 = Engine[@"getmodel"](f8_arg0, f8_arg1)
		local f8_local1 = Engine[@"getmodelvalue"](f8_local0)
		Engine[@"setmodelvalue"](f8_local0, f8_arg2)
		return f8_local1
	end
	local f7_local1 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "debug")
	if not f7_local1 then
		return
	end
	local f7_local2 = Engine[@"getmodel"](f7_local1, "sessionSQJ")
	if not f7_local2 then
		return
	elseif not Engine[@"getmodel"](f7_local2, "searchStage") then
		return
	end
	local f7_local3 = f7_local0(f7_local2, "searchStage", 0)
	local f7_local4 = Engine[@"getmodel"](f7_local2, "results")
	for f7_local5 = 1, f7_local3, 1 do
		local f7_local8 = Engine[@"getmodel"](f7_local4, tostring(f7_local5))
		local f7_local9 = f7_local0(f7_local8, "numResults", 0)
		if f7_local9 > 0 then
			local f7_local10 = Engine[@"getmodel"](f7_local8, "data")
			for f7_local11 = 1, f7_local9, 1 do
				local f7_local14 = Engine[@"getmodel"](f7_local10, tostring(f7_local11))
				f7_local0(f7_local14, "xuid", 0)
				f7_local0(f7_local14, "xuidstr", "")
				f7_local0(f7_local14, "publicIPAddress", "")
				f7_local0(f7_local14, "privateIPAddress", "")
				f7_local0(f7_local14, "natType", "")
				f7_local0(f7_local14, "ping", "")
				f7_local0(f7_local14, "status", "")
			end
		end
	end
end
Lobby.Debug.SessionSQJClear = function()
	if not Lobby.Debug.SessionSQJEnabled() then
		return
	else
		Lobby.Debug.SessionSQJClearModels()
		Lobby.Debug.sessionSQJ.searchStage = 0
		Lobby.Debug.sessionSQJ.results = {
			asyncMatchmakingStrings = {},
		}
		Lobby.Debug.sessionSQJ.joinOrder = 0
		Lobby.Debug.SessionSQJUpdateUIInfo()
	end
end
Lobby.Debug.CreateSetModel = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = Engine[@"createmodel"](f10_arg0, f10_arg1)
	Engine[@"setmodelvalue"](f10_local0, f10_arg2)
	return f10_local0
end
Lobby.Debug.SessionSQJRefreshInfo = function()
	if not Lobby.Debug.SessionSQJEnabled() then
		return
	end
	local f11_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "debug"), "sessionSQJ")
	Lobby.Debug.CreateSetModel(f11_local0, "searchStage", Lobby.Debug.sessionSQJ.searchStage)
	local f11_local1 = Engine[@"createmodel"](f11_local0, "results")
	if Dvar[@"hash_44BADE8473F0165F"]:exists() and Dvar[@"hash_44BADE8473F0165F"]:get() then
		local f11_local2 = Engine[@"createmodel"](f11_local1, "1")
		Lobby.Debug.CreateSetModel(f11_local2, "numResults", Lobby.Debug.sessionSQJ.results.numResults)
		local f11_local3 = Engine[@"createmodel"](f11_local2, "data")
		for f11_local7, f11_local8 in ipairs(Lobby.Debug.sessionSQJ.results.asyncMatchmakingStrings) do
			Lobby.Debug.CreateSetModel(Engine[@"createmodel"](f11_local3, tostring(f11_local7)), "asyncMatchmakingString", f11_local8)
		end
	else
		for f11_local2 = 1, Lobby.Debug.sessionSQJ.searchStage, 1 do
			local f11_local6 = Engine[@"createmodel"](f11_local1, tostring(f11_local2))
			Lobby.Debug.CreateSetModel(f11_local6, "numResults", Lobby.Debug.sessionSQJ.results[f11_local2].numResults)
			local f11_local7 = Engine[@"createmodel"](f11_local6, "data")
			for f11_local11, f11_local12 in ipairs(Lobby.Debug.sessionSQJ.results[f11_local2].data) do
				local f11_local13 = Engine[@"createmodel"](f11_local7, tostring(f11_local11))
				Lobby.Debug.CreateSetModel(f11_local13, "xuid", f11_local12.xuid)
				Lobby.Debug.CreateSetModel(f11_local13, "xuidstr", f11_local12.xuidstr)
				Lobby.Debug.CreateSetModel(f11_local13, "gamertag", f11_local12.gamertag)
				Lobby.Debug.CreateSetModel(f11_local13, "publicIPAddress", f11_local12.publicIPAddress)
				Lobby.Debug.CreateSetModel(f11_local13, "privateIPAddress", f11_local12.privateIPAddress)
				Lobby.Debug.CreateSetModel(f11_local13, "natType", f11_local12.natType)
				Lobby.Debug.CreateSetModel(f11_local13, "ping", f11_local12.ping)
				Lobby.Debug.CreateSetModel(f11_local13, "status", f11_local12.status)
			end
		end
	end
end
Lobby.Debug.SessionSQJUpdateUIInfo = function()
	local f12_local0 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "debug")
	if not f12_local0 then
		return
	else
		Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"getmodel"](f12_local0, "sessionSQJ"), "update"))
	end
end
Lobby.Debug.SessionSQJSearchResults = function(f13_arg0)
	if not Lobby.Debug.SessionSQJEnabled() then
		return
	elseif Lobby.Debug.sessionSQJ.searchStage > 5 then
		Lobby.Debug.SessionSQJClearModels()
		Lobby.Debug.sessionSQJ.searchStage = 2
		Lobby.Debug.sessionSQJ.results[1] = Lobby.Debug.sessionSQJ.results[#Lobby.Debug.sessionSQJ.results - 1]
		Lobby.Debug.sessionSQJ.results[2] = Lobby.Debug.sessionSQJ.results[#Lobby.Debug.sessionSQJ.results]
	end
	Lobby.Debug.sessionSQJ.searchStage = Lobby.Debug.sessionSQJ.searchStage + 1
	Lobby.Debug.sessionSQJ.results[Lobby.Debug.sessionSQJ.searchStage] = {
		numResults = f13_arg0.numResults,
		data = {},
	}
	if f13_arg0.numResults == 0 then
		Lobby.Debug.SessionSQJUpdateUIInfo()
		return
	end
	local f13_local0 = Lobby.Debug.sessionSQJ.results[Lobby.Debug.sessionSQJ.searchStage].data
	for f13_local6, f13_local7 in ipairs(f13_arg0.remoteHosts) do
		f13_local0[f13_local6] = {}
		f13_local0[f13_local6].xuid = f13_local7.xuid
		f13_local0[f13_local6].xuidstr = f13_local7.xuidstr
		local f13_local4 = ""
		if Engine[@"xuidtogamertag"] then
			f13_local4 = Engine[@"xuidtogamertag"](f13_local7.xuid) or ""
		end
		f13_local0[f13_local6].gamertag = f13_local4 .. "  " .. tostring(f13_local7.teamSizeMax) .. "-" .. tostring(f13_local7.numPlayers) .. "-" .. tostring(f13_local7.maxPlayers) .. "-" .. tostring(f13_local7.showInMatchmaking)
		local f13_local5 = Engine[@"serializedadrtolua"](f13_local7.hostAddress)
		f13_local0[f13_local6].publicIPAddress = f13_local5.publicIPAddress .. ":" .. tostring(f13_local5.publicIPPort)
		f13_local0[f13_local6].privateIPAddress = f13_local5.privateIPAddress
		f13_local0[f13_local6].natType = f13_local5.natTypeStr
	end
	Lobby.Debug.SessionSQJUpdateUIInfo()
end
Lobby.Debug.SessionSQJQoSResult = function(f14_arg0)
	if not Lobby.Debug.SessionSQJEnabled() then
		return
	end
	for f14_local3, f14_local4 in ipairs(Lobby.Debug.sessionSQJ.results[Lobby.Debug.sessionSQJ.searchStage].data) do
		if f14_local4.xuid == f14_arg0.xuid then
			if f14_arg0.validResult then
				f14_local4.ping = tostring(math.floor(f14_arg0.latency)) .. "ms, s:" .. tostring(f14_arg0.numAvailableSlots)
			else
				f14_local4.ping = "PING-INVALID"
			end
			Lobby.Debug.SessionSQJUpdateUIInfo()
			return
		end
	end
end
Lobby.Debug.SessionSQJLogBDEvent = function(f15_arg0)
	if not Dvar[@"ui_lobbydebugsessionsqj"]:get() then
		return
	elseif not Lobby.Debug.SessionSQJEnabled() then
		return
	end
	local f15_local0 = f15_arg0.eventType
	local f15_local1 = ""
	if f15_local0 ~= nil then
		f15_local1 = LuaEnum.bdEventTypeString[f15_local0]
	end
	local f15_local2 = ""
	if f15_local0 == LuaEnum.bdEventType.BD_QOS_HOSTS then
		f15_local2 = string.format("%s: NumProbes: %d", f15_local1, f15_arg0.numProbes)
	elseif f15_local0 == LuaEnum.bdEventType.BD_JOIN_LOBBY then
		f15_local2 = string.format("%s: MMID: %s, LobbyID: %s", f15_local1, Engine[@"uint64tostring"](f15_arg0.matchmakingID), Engine[@"uint64tostring"](f15_arg0.lobbyID))
	elseif f15_local0 == LuaEnum.bdEventType.BD_LOBBY_DISBANDED then
		f15_local2 = string.format("%s: LobbyID: %s", f15_local1, Engine[@"uint64tostring"](f15_arg0.lobbyID))
	elseif f15_local0 == LuaEnum.bdEventType.BD_MATCHMAKING_SEARCH_STATUS then
		f15_local2 = string.format("%s: MMID: %s, MMSearchStatus: %s", f15_local1, Engine[@"uint64tostring"](f15_arg0.matchmakingID), f15_arg0.matchmakingSearchStatus)
	elseif f15_local0 == LuaEnum.bdEventType.BD_LOBBY_NOT_FOUND then
		f15_local2 = string.format("%s: MMID: %s, Cause: %s", f15_local1, Engine[@"uint64tostring"](f15_arg0.matchmakingID), f15_arg0.lobbyNotFoundCause)
	elseif f15_local0 == LuaEnum.bdEventType.BD_CREATE_NEW_LOBBY then
		f15_local2 = string.format("%s: MMID: %s, LobbyID: %s, UpdateID: %s", f15_local1, Engine[@"uint64tostring"](f15_arg0.matchmakingID), Engine[@"uint64tostring"](f15_arg0.lobbyID), Engine[@"uint64tostring"](f15_arg0.updateID))
	elseif f15_local0 == LuaEnum.bdEventType.BD_UPDATED_LOBBY_DOCUMENT then
		f15_local2 = string.format("%s: LobbyID: %s, UpdateID: %s", f15_local1, Engine[@"uint64tostring"](f15_arg0.lobbyID), Engine[@"uint64tostring"](f15_arg0.updateID))
	elseif f15_local0 == LuaEnum.bdEventType.BD_MERGE_INTO_LOBBY then
		local f15_local3 = Engine[@"uint64tostring"](f15_arg0.matchmakingID)
		f15_local2 = string.format("%s: MMID: %s, SourceLobby: %s, DestLobby: %s", f15_local1, matchmakingID, Engine[@"uint64tostring"](f15_arg0.lobbyID), Engine[@"uint64tostring"](f15_arg0.destinationLobbyID))
	elseif f15_local0 == LuaEnum.bdEventType.BD_SYNC_HOSTDOC then
		f15_local2 = f15_local1
	else
		f15_local2 = f15_arg0.message
	end
	table.insert(Lobby.Debug.sessionSQJ.results.asyncMatchmakingStrings, 1, f15_local2)
	if Lobby.Debug.NumberOfSQJRowsToDisplay < #Lobby.Debug.sessionSQJ.results.asyncMatchmakingStrings then
		Lobby.Debug.sessionSQJ.results.asyncMatchmakingStrings[Lobby.Debug.NumberOfSQJRowsToDisplay + 1] = nil
	end
	Lobby.Debug.sessionSQJ.results.numResults = #Lobby.Debug.sessionSQJ.results.asyncMatchmakingStrings
	Lobby.Debug.SessionSQJUpdateUIInfo()
end
Lobby.Debug.SessionSQJJoinInitiate = function(f16_arg0)
	if not Lobby.Debug.SessionSQJEnabled() then
		return
	end
	for f16_local3, f16_local4 in ipairs(Lobby.Debug.sessionSQJ.results[Lobby.Debug.sessionSQJ.searchStage].data) do
		if f16_local4.xuid == f16_arg0 then
			Lobby.Debug.sessionSQJ.joinOrder = Lobby.Debug.sessionSQJ.joinOrder + 1
			f16_local4.status = "(" .. tostring(Lobby.Debug.sessionSQJ.joinOrder) .. ") JOINING"
			Lobby.Debug.SessionSQJUpdateUIInfo()
			return
		end
	end
end
Lobby.Debug.SessionSQJJoinResult = function(f17_arg0)
	if not Lobby.Debug.SessionSQJEnabled() or Lobby.Debug.sessionSQJ.searchStage <= 0 then
		return
	end
	for f17_local4, f17_local5 in ipairs(Lobby.Debug.sessionSQJ.results[Lobby.Debug.sessionSQJ.searchStage].data) do
		if f17_local5.xuid == f17_arg0.xuid then
			local f17_local3 = Lobby.Join.JoinResultToString(f17_arg0.joinResult, false)
			f17_local5.status = "(" .. tostring(Lobby.Debug.sessionSQJ.joinOrder) .. ") " .. f17_local3.debug
			Lobby.Debug.SessionSQJUpdateUIInfo()
			return
		end
	end
end
Lobby.Debug.KVSInit = function(f18_arg0) end
Lobby.Debug.SendKVSJoin = function(f19_arg0)
	if Dvar[@"lobbydebuglogjoins"]:get() == true and f19_arg0.join.result.code == Enum[@"joinresult"][@"join_result_success"] and Dvar[@"lobbydebuglogjoinsuccess"]:get() == true then
	else
	end
end
Lobby.Debug.IsProcessDebugEnabled = function()
	return Dvar[@"ui_lobbydebugoverlay"]:exists() and Dvar[@"ui_lobbydebugoverlay"]:get()
end
Lobby.Debug.InitProcessQueueDebug = function()
	Lobby.Debug.ProcessHistory = {}
	Lobby.Debug.DebugQueueSize = 5
	Lobby.Debug.MaxActions = 20
end
Lobby.Debug.UpdateProcessQueue = function()
	if not Lobby.Debug.IsProcessDebugEnabled() then
		return
	end
	local f22_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyDebug"), "processQueue")
	local f22_local1 = Engine[@"createmodel"](f22_local0, "data")
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f22_local0, "count"), #Lobby.Debug.ProcessHistory)
	for f22_local12, f22_local13 in ipairs(Lobby.Debug.ProcessHistory) do
		local f22_local14 = Engine[@"createmodel"](f22_local1, tostring(f22_local12))
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f22_local14, "processName"), f22_local13.processName)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f22_local14, "processCancellable"), f22_local13.cancellable)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f22_local14, "type"), "process")
		if f22_local13.actions then
			Engine[@"setmodelvalue"](Engine[@"createmodel"](f22_local14, "actionCount"), #f22_local13.actions)
			local f22_local5 = Engine[@"createmodel"](f22_local14, "actions")
			for f22_local9, f22_local10 in ipairs(f22_local13.actions) do
				local f22_local11 = Engine[@"createmodel"](f22_local5, tostring(f22_local9))
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f22_local11, "processName"), f22_local10.name)
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f22_local11, "processState"), f22_local10.state)
				Engine[@"setmodelvalue"](Engine[@"createmodel"](f22_local11, "type"), "action")
			end
		end
	end
	Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](f22_local0, "update"))
end
Lobby.Debug.DeleteProcessUIModel = function(f23_arg0, f23_arg1)
	if not Lobby.Debug.IsProcessDebugEnabled() then
		return
	else
		local f23_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyDebug"), "processQueue")
		local f23_local1 = Engine[@"createmodel"](f23_local0, "data")
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f23_local0, "count"), #Lobby.Debug.ProcessHistory - 1)
		Engine[@"unsubscribeandfreemodel"](Engine[@"createmodel"](f23_local1, tostring(f23_arg1)))
	end
end
Lobby.Debug.DeleteActionUIModel = function(f24_arg0)
	if not Lobby.Debug.IsProcessDebugEnabled() then
		return
	end
	local f24_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyDebug"), "processQueue")
	local f24_local1 = Engine[@"createmodel"](f24_local0, "data")
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f24_local0, "count"), #Lobby.Debug.ProcessHistory - 1)
	local f24_local2 = Engine[@"createmodel"](f24_local1, tostring(f24_arg0))
	local f24_local3 = Lobby.Debug.ProcessHistory[f24_arg0]
	if f24_local3.actions then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f24_local2, "actionCount"), #f24_local3.actions - 1)
		Engine[@"unsubscribeandfreemodel"](Engine[@"createmodel"](Engine[@"createmodel"](f24_local2, "actions"), tostring(#f24_local3.actions)))
	end
end
Lobby.Debug.AddDebugProcess = function()
	if not Lobby.Debug.IsProcessDebugEnabled() then
		return
	elseif Lobby.Debug.DebugQueueSize <= #Lobby.Debug.ProcessHistory then
		Lobby.Debug.DeleteProcessUIModel(Lobby.Debug.ProcessHistory[Lobby.Debug.ProcessHistory], #Lobby.Debug.ProcessHistory)
		table.remove(Lobby.Debug.ProcessHistory, #Lobby.Debug.ProcessHistory)
	end
	table.insert(Lobby.Debug.ProcessHistory, 1, Lobby.ProcessQueue.queue)
	Lobby.Debug.UpdateProcessQueue()
end
Lobby.Debug.AddDebugAction = function(f26_arg0)
	if not Lobby.Debug.IsProcessDebugEnabled() then
		return
	elseif not Lobby.Debug.ProcessHistory[1].actions then
		Lobby.Debug.ProcessHistory[1].actions = {}
	end
	if Lobby.Debug.MaxActions < #Lobby.Debug.ProcessHistory[1].actions then
		Lobby.Debug.DeleteActionUIModel(1)
		table.remove(Lobby.Debug.ProcessHistory[1].actions, #Lobby.Debug.ProcessHistory[1].actions)
	end
	table.insert(Lobby.Debug.ProcessHistory[1].actions, 1, f26_arg0)
	Lobby.Debug.UpdateProcessQueue()
end
Lobby.Debug.JBMatchmakingEvent = function(f27_arg0)
	Lobby.Debug.jbEvent = f27_arg0
	if Engine[@"jbmatchmakingevent"] ~= nil then
		Engine[@"jbmatchmakingevent"](f27_arg0)
	end
end
Lobby.Debug.OnInit = function(f28_arg0)
	Lobby.Debug.KVSInit(f28_arg0)
	Lobby.Debug.InitProcessQueueDebug()
end
Lobby.Debug.OnUILoad = function(f29_arg0)
	if f29_arg0.init == true then
		if Engine[@"getcurrentplatform"]() == "orbis" or Engine[@"getcurrentplatform"]() == "durango" then
			Lobby.Debug.LobbyDebugVisEnable()
			Lobby.Debug.LobbyValidateEnable()
			Lobby.Debug.LobbySQJEnable()
		end
		Lobby.Debug.SessionSQJClear()
	end
end
Lobby.Debug.OnProcessStart = function(f30_arg0)
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"process_name"] = f30_arg0
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_5B950829C03B3406"] = false
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_4E650E9C822CB0CE"] = Engine[@"getlobbymainmode"]()
	local f30_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_2B50577FE93B2256"] = Engine[@"getlobbylobbyid"](Enum[@"lobbymodule"][@"lobby_module_client"], f30_local0)
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_669CA7A9DE06F403"] = f30_local0
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_740D73D751CF7979"] = Engine[@"getlobbyhostxuid"](f30_local0)
	local f30_local1 = Engine[@"hash_38020859DF7AAF7B"](Enum[@"lobbymodule"][@"lobby_module_client"], f30_local0)
	local f30_local2 = 10
	for f30_local6, f30_local7 in ipairs(f30_local1) do
		if f30_local6 <= f30_local2 then
			Lobby.Debug.LobbyMember[@"lobby_members"][f30_local6] = {}
			Lobby.Debug.LobbyMember[@"lobby_members"][f30_local6][@"hash_79CAC019C120269B"] = f30_local7
		end
		Lobby.Debug.LobbyMember[@"hash_43081CC1B79588F9"] = f30_local6
	end
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_68C4483FED6CF75E"] = Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_FE1BB65E8DE4D51"]
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_4C2F2B7A55FD35A8"] = Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_7A4B7F92D7E1DC7B"]
end
Lobby.Debug.OnAsyncMatchmaking = function(f31_arg0)
	Lobby.Debug.Matchmaking[@"hash_FE1BB65E8DE4D51"] = f31_arg0.matchMakingID
	Lobby.Debug.Matchmaking[@"hash_7A4B7F92D7E1DC7B"] = f31_arg0.lobbyID
end
Lobby.Debug.OnActionComplete = function(f32_arg0, f32_arg1, f32_arg2)
	actions = Lobby.Debug.Action
	if actions[@"action_count"] < 40 then
		actions[@"action_count"] = actions[@"action_count"] + 1
		actions[@"actions"][actions[@"action_count"]] = {}
		actions[@"actions"][actions[@"action_count"]][@"action_name"] = f32_arg0.name
		local f32_local0 = actions[@"actions"][actions[@"action_count"]]
		local f32_local1
		if f32_arg1 then
			f32_local1 = f32_arg1.name
			if not f32_local1 then
			else
				f32_local0[@"next_name"] = f32_local1
				actions[@"actions"][actions[@"action_count"]][@"action_id"] = f32_arg0.actionId
				actions[@"actions"][actions[@"action_count"]][@"hash_273DFB188DE1A27D"] = f32_arg2
				Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_5B950829C03B3406"] = Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_5B950829C03B3406"] or f32_arg2
				if f32_arg0.message ~= nil then
					Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"extra_msg"] = f32_arg0.message
				elseif f32_arg0.errorMessage ~= nil then
					Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"extra_msg"] = f32_arg0.errorMessage
				end
			end
		end
		f32_local1 = "none"
	end
end
Lobby.Debug.OnProcessComplete = function()
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_2459C7BB3080C37F"] = Engine[@"getlobbymainmode"]()
	local f33_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_438C4B6C6AFD6185"] = Engine[@"getlobbylobbyid"](Enum[@"lobbymodule"][@"lobby_module_client"], f33_local0)
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_7D8E410D4A2C6050"] = f33_local0
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_7E014C3BEC12CC14"] = Engine[@"getlobbyhostxuid"](f33_local0)
	Lobby.Debug.ProcessQueueDlogEvent[@"actions"] = Lobby.Debug.Action[@"actions"]
	local f33_local1 = Engine[@"hash_38020859DF7AAF7B"](Enum[@"lobbymodule"][@"lobby_module_client"], f33_local0)
	local f33_local2 = 10
	for f33_local6, f33_local7 in ipairs(f33_local1) do
		if f33_local6 <= f33_local2 then
			if Lobby.Debug.LobbyMember[@"lobby_members"][f33_local6] == nil then
				Lobby.Debug.LobbyMember[@"lobby_members"][f33_local6] = {}
			end
			Lobby.Debug.LobbyMember[@"lobby_members"][f33_local6][@"hash_7FAAF5ED10257A8A"] = f33_local7
		end
		Lobby.Debug.LobbyMember[@"hash_49BF5522E36C4FF6"] = f33_local6
	end
	Lobby.Debug.ProcessQueueDlogEvent[@"lobby_members"] = Lobby.Debug.LobbyMember[@"lobby_members"]
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_43081CC1B79588F9"] = Lobby.Debug.LobbyMember[@"hash_43081CC1B79588F9"]
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_49BF5522E36C4FF6"] = Lobby.Debug.LobbyMember[@"hash_49BF5522E36C4FF6"]
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_FE1BB65E8DE4D51"] = Lobby.Debug.Matchmaking[@"hash_FE1BB65E8DE4D51"]
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_7A4B7F92D7E1DC7B"] = Lobby.Debug.Matchmaking[@"hash_7A4B7F92D7E1DC7B"]
	if Dvar[@"hash_3B59E659FCF4DB51"]:get() then
		Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_32FBA4E98DF55C89", Lobby.Debug.ProcessQueueDlogEvent)
	end
	Lobby.Debug.ResetProcessQueueDlogEvent()
end
Lobby.Debug.ResetProcessQueueDlogEvent = function()
	to_matchmaking_id = Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_FE1BB65E8DE4D51"]
	to_match_lobby_id = Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_7A4B7F92D7E1DC7B"]
	Lobby.Debug.ProcessQueueDlogEvent[@"content"] = {}
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_FE1BB65E8DE4D51"] = to_matchmaking_id
	Lobby.Debug.ProcessQueueDlogEvent[@"content"][@"hash_7A4B7F92D7E1DC7B"] = to_match_lobby_id
	Lobby.Debug.Action[@"action_count"] = 0
	Lobby.Debug.Action[@"actions"] = {}
	Lobby.Debug.LobbyMember[@"hash_43081CC1B79588F9"] = 0
	Lobby.Debug.LobbyMember[@"hash_49BF5522E36C4FF6"] = 0
	Lobby.Debug.LobbyMember[@"lobby_members"] = {}
end
Lobby.Debug.OnSessionStart = function(f35_arg0)
	local f35_local0 = f35_arg0.lobbyModule
	local f35_local1 = f35_arg0.lobbyType
	local f35_local2 = f35_arg0.lobbyMode
	f35_arg0.lobbyID = Engine[@"getlobbylobbyid"](f35_local0, f35_local1)
	Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_18152512C03A265B", {
		[@"lobby_module"] = f35_arg0.lobbyModule,
		[@"lobby_type"] = f35_arg0.lobbyType,
		[@"lobby_mode"] = f35_arg0.lobbyMode,
	})
	if f35_local1 == Enum[@"lobbytype"][@"lobby_type_game"] and f35_local0 == Enum[@"lobbymodule"][@"lobby_module_host"] and (not Dvar[@"hash_44BADE8473F0165F"]:exists() or not Dvar[@"hash_44BADE8473F0165F"]:get()) then
		Lobby.Debug.SessionSQJClear()
	end
end
Lobby.Debug.OnSessionEnd = function(f36_arg0)
	local f36_local0 = f36_arg0.lobbyModule
	local f36_local1 = f36_arg0.lobbyType
	local f36_local2 = f36_arg0.lobbyMode
	f36_arg0.lobbyID = Engine[@"getlobbylobbyid"](f36_local0, f36_local1)
	Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_356D8D6EEEB3533E", {
		[@"lobby_module"] = f36_arg0.lobbyModule,
		[@"lobby_type"] = f36_arg0.lobbyType,
		[@"lobby_mode"] = f36_arg0.lobbyMode,
	})
end
Lobby.Debug.OnMatchStart = function(f37_arg0)
	local f37_local0 = f37_arg0.lobbyModule
	local f37_local1 = f37_arg0.lobbyType
	local f37_local2 = f37_arg0.lobbyMode
	Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_5E254CD7EDAA8B12", {
		[@"lobby_module"] = f37_arg0.lobbyModule,
		[@"lobby_type"] = f37_arg0.lobbyType,
		[@"lobby_mode"] = f37_arg0.lobbyMode,
	})
	if Dvar[@"hash_6AC9C04A5EFC9DAD"]:exists() then
		Dvar[@"hash_6AC9C04A5EFC9DAD"]:set("none")
	end
	Lobby.Debug.SessionSQJClear()
end
Lobby.Debug.OnMatchEnd = function(f38_arg0)
	Engine[0xDE279ECDDDD966](Engine[@"getprimarycontroller"](), @"hash_5567090FC821F077", {
		[@"lobby_module"] = f38_arg0.lobbyModule,
		[@"lobby_type"] = f38_arg0.lobbyType,
		[@"lobby_mode"] = f38_arg0.lobbyMode,
	})
end
Lobby.Debug.OnJoinComplete = function(f39_arg0)
	Lobby.Debug.SendKVSJoin(f39_arg0)
end
Lobby.Debug.Pump = function()
	Lobby.Debug.LobbyValidate()
end
Lobby.Debug.StartDedicatedBotTest = function(f41_arg0)
	if Lobby.ProcessQueue.GetCurrentRunningProcessName() == "DedicatedLobbyBotTest" then
		return
	end
	local f41_local0 = Dvar[@"hash_22B63CD6CD2CA89F"]:get()
	local f41_local1 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC)
	if f41_local0 == "mp" then
		f41_local1 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC)
	elseif f41_local0 == "zm" then
		f41_local1 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC)
	elseif f41_local0 == "wz" then
		f41_local1 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC)
	end
	Lobby.ProcessQueue.AddToQueue("DedicatedLobbyBotTest", Lobby.Debug.CreateDedicatedBotTestGameLobbyNONMatchmaking(0, f41_local1, f41_local1, Dvar[@"hash_3D88449B897ADB65"]:get(), Dvar[@"hash_2566DC1BF546455B"]:get()))
end
Lobby.Debug.CreateDedicatedBotTestGameLobbyNONMatchmaking = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4)
	local f42_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"])
	local f42_local1 = {
		controller = f42_arg0,
		errorTarget = f42_arg1,
		isPublic = true,
	}
	local f42_local2 = Lobby.Interrupt.Back(Lobby.ProcessNavigate.GameLobbyInterrupt, f42_local1)
	local f42_local3 = Lobby.Interrupt.ErrorMsg(Lobby.ProcessNavigate.GameLobbyInterrupt, f42_local1, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"))
	local f42_local4 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_join"])
	end
	local f42_local5 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end
	local f42_local6 = function()
		Lobby.Timer.HostingLobby({
			controller = f42_arg0,
			lobbyType = f42_arg2[@"lobbytype"],
			mainMode = f42_arg2[@"mainmode"],
			lobbyTimerType = f42_arg2[@"hash_5558B67A321D1120"],
		})
		Lobby.Matchmaking.ClearSearchInfo()
		Dvar[@"hash_68827F6EDED32B08"]:set(true)
		Dvar[@"lobbytimerstartinterval"]:set(1000)
		Dvar[@"lobbycptimerstartinterval"]:set(1000)
		Dvar[@"lobbycpzmtimerstartinterval"]:set(1000)
		Dvar[@"lobbytimerstatusvotinginterval"]:set(1000)
		Dvar[@"lobbytimerstatusbegininterval"]:set(1000)
		Dvar[@"lobbytimerstatusstartinterval"]:set(1000)
		Dvar[@"lobbytimerstatuspostgameinterval"]:set(1000)
		Engine[@"setgametype"](f42_arg4)
	end
	local f42_local7 = Lobby.Actions.OpenSpinner(true)
	local f42_local8 = Lobby.Actions.CloseSpinner()
	local f42_local9 = Lobby.Actions.WaitForJoiningClients(5000)
	local f42_local10 = Lobby.Actions.ExecuteScript(f42_local4)
	local f42_local11 = Lobby.Actions.ExecuteScript(f42_local5)
	local f42_local12 = Lobby.Actions.LobbyHostStart(f42_arg0, f42_arg2[@"mainmode"], f42_arg2[@"lobbytype"], f42_arg2[@"lobbymode"], f42_arg2[@"maxclients"], f42_arg3, f42_arg4)
	local f42_local13 = Lobby.Actions.ExecuteScript(f42_local6)
	local f42_local14 = Lobby.Actions.LobbySettings(f42_arg0, f42_arg2)
	local f42_local15 = Lobby.Actions.UpdateUI(f42_arg0, f42_arg2)
	local f42_local16 = Lobby.Actions.RunPlaylistSettings(f42_arg0)
	local f42_local17 = Lobby.Actions.ExecuteScript(function()
		local f46_local0 = Dvar[@"hash_231B653F08E07111"]:get()
		Engine[@"setlobbymaxclients"](Enum[@"lobbytype"][@"lobby_type_game"], f46_local0)
		Engine[@"addlobbybot"](Enum[@"lobbytype"][@"lobby_type_game"], f46_local0, true, 0)
	end)
	local f42_local18 = {
		head = f42_local7,
		interrupt = f42_local2,
		force = false,
		cancellable = false,
	}
	Lobby.Process.AddActions(f42_local7, f42_local9, f42_local3, f42_local3)
	Lobby.Process.AddActions(f42_local9, f42_local10, f42_local3, f42_local3)
	Lobby.Process.AddActions(f42_local10, f42_local12, f42_local3, f42_local3)
	Lobby.Process.AddActions(f42_local12, f42_local14, f42_local3, f42_local3)
	Lobby.Process.AddActions(f42_local14, f42_local16, f42_local3, f42_local3)
	Lobby.Process.AddActions(f42_local16, f42_local13, f42_local3, f42_local3)
	Lobby.Process.ForceAction(f42_local13, f42_local17)
	Lobby.Process.ForceAction(f42_local17, f42_local15)
	Lobby.Process.AddActions(f42_local15, f42_local11, f42_local3, f42_local3)
	Lobby.Process.AddActions(f42_local11, f42_local8, f42_local3, f42_local3)
	return f42_local18
end
Lobby.Debug.OnInit({})
