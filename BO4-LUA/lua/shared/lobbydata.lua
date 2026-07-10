require("x64:401e59513e41da9")
require("x64:b5d5f7ffe97a9a7")
require("x64:c6e3b538b3d95e3")
local f0_local0 = {}
local f0_local1 = {}
local f0_local2 = {
	Action = "action",
	LobbyClosed = "uin_lobby_closed",
	ClientsAddedToLobby = "uin_lobby_enter",
	ClientsRemovedFromLobby = "uin_lobby_exit",
	TimerTick = "uin_timer",
	ESportsTimerTick = "uin_timer_esports_beep",
	ESportsTimerTickLast = "uin_timer_esports_last_beep",
}
f0_local0.InitMenusIndexTable = function()
	f0_local1 = {}
	for f1_local8, f1_local9 in pairs({
		@"hash_251BB4F2EDE86F4C",
		@"hash_7262C7CA0E318854",
		@"hash_7276CBCA0E42382A",
		@"hash_7295ACCA0E5CB40C",
		@"hash_72BAB9CA0E7BE660",
		@"hash_341F5DBFEF6844A6",
		@"hash_4DAE12D7F3029A24",
		@"hash_69F8B20FBABFED4B",
		@"hash_3F4F713EF679C9BC",
	}) do
		local f1_local10 = Engine[@"hash_7A7E3CD65E63086F"](f1_local9)
		if f1_local10 then
			for f1_local6, f1_local7 in pairs(f1_local10) do
				f0_local1[f1_local7[@"id"]] = f1_local7[@"name"]
			end
		end
	end
end
f0_local0.InitMenusIndexTable()
f0_local0.InitLobbyNav = function()
	local f2_local0 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.MAIN)
	local f2_local1 = Engine[@"getglobalmodel"]()
	f2_local1 = f2_local1:create("lobbyRoot", true)
	local f2_local2 = f2_local1:create("lobbyNav", true)
	f2_local2:set(f2_local0[@"id"])
	f2_local2 = f2_local1:create("room", true)
	f2_local2:set(f2_local0[@"room"])
	f2_local2 = f2_local1:create("fullscreenBlackCount", true)
	f2_local2:set(0)
	f2_local2 = f2_local1:create("rankMode", true)
	f2_local2:set(Enum[@"emodes"][@"mode_invalid"])
	f2_local2 = f2_local1:create("theaterDataDownloaded")
	f2_local2:set(false)
	f2_local2 = f2_local1:create("theaterDownloadPercent")
	f2_local2:set(0)
	f2_local2 = f2_local1:create("entitlementsUpdated", true)
	f2_local2:set(false)
	if LUI then
		CoD.MetricsUtility.LobbyInit()
	end
end
f0_local0.GetLobbyNavModel = function()
	return Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav")
end
f0_local0.GetLobbyNav = function()
	return Engine[@"getmodelvalue"](f0_local0.GetLobbyNavModel())
end
f0_local0.GetCurrentMenuTarget = function()
	return LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
end
f0_local0.GetLobbyMenuByName = function(f6_arg0)
	if f6_arg0 == "director" then
		return {
			[@"name"] = "director",
			[@"id"] = 9999,
		}
	else
		return Engine[@"hash_2E00B2F29271C60B"](Engine[@"converttoxhash"](f6_arg0))
	end
end
f0_local0.GetLobbyMenuIDByName = function(f7_arg0)
	local f7_local0 = LobbyData.GetLobbyMenuByName(f7_arg0)
	return f7_local0 and f7_local0[@"id"]
end
f0_local0.GetLobbyMenuByID = function(f8_arg0)
	local f8_local0 = f0_local1[f8_arg0]
	if f8_local0 == nil then
		return nil
	else
		return LobbyData.GetLobbyMenuByName(f8_local0)
	end
end
f0_local0.SetLobbyNav = function(f9_arg0)
	local f9_local0 = f0_local0.GetLobbyNavModel()
	if not f9_local0 then
		f0_local0.InitLobbyNav()
		f9_local0 = f0_local0.GetLobbyNavModel()
	end
	local f9_local1 = Engine[@"getmodelvalue"](f9_local0)
	local f9_local2
	if f9_arg0[@"id"] ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) or f9_local1 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		f9_local2 = false
	else
		f9_local2 = true
	end
	if f9_local2 then
		Lobby.Arena.OnNavToArenaPregame()
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "LobbyData.SetLobbyNav. From: " .. tostring(f9_local1) .. " To: " .. tostring(f9_arg0[@"id"]) .. "\n")
	Engine[@"setmodelvalue"](f9_local0, f9_arg0[@"id"])
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyTitle"), f9_arg0[@"title"])
	local f9_local3 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.headingKickerMode")
	local f9_local4 = Engine[@"setmodelvalue"]
	local f9_local5 = f9_local3
	if f9_arg0[@"kicker"] then
		local f9_local6 = f9_arg0[@"kicker"]
		local f9_local7 = Engine[@"hash_4F9F1239CFD921FE"](f9_arg0[@"kicker"])
	end
	f9_local4(f9_local5, f9_local6 and f9_local7 or "")
	Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.headingKickerText")
end
f0_local0.GetCurrentLobbySizes = function(f10_arg0)
	local f10_local0 = Engine[@"getlobbyuiscreen"]()
	local f10_local1 = LobbyData.GetLobbyMenuByID(f10_local0)
	local f10_local2 = Engine[@"getlobbymaxclients"](Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_host"], f10_local1[@"lobbytype"]) and Enum[@"lobbymodule"][@"lobby_module_host"] or Enum[@"lobbymodule"][@"lobby_module_client"], f10_local1[@"lobbytype"])
	if f10_arg0 == true then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Current Lobby Sizes (" .. f10_local1[@"name"] .. ", ID " .. tostring(f10_local0) .. "):" .. " maxClients(" .. tostring(f10_local1[@"maxclients"]) .. "), maxLaunchClients(" .. tostring(f10_local1[@"hash_24A523F3AE5C68D6"]) .. "), maxCoDcasterClients(" .. tostring(f10_local1[@"hash_62BF14968131BE83"]) .. "), maxLocalClients(" .. tostring(f10_local1[@"maxlocalclients"]) .. "), maxLocalClientsNetwork(" .. tostring(f10_local1[@"maxlocalclientsnetwork"]) .. "), maxClientsSession(" .. tostring(f10_local2) .. ").\n")
	end
	return {
		maxClients = f10_local1[@"maxclients"],
		maxLaunchClients = f10_local1[@"hash_24A523F3AE5C68D6"],
		maxCoDcasterClients = f10_local1[@"hash_62BF14968131BE83"],
		maxLocalClients = f10_local1[@"maxlocalclients"],
		maxLocalClientsNetwork = f10_local1[@"maxlocalclientsnetwork"],
		maxClientsSession = f10_local2,
	}
end
f0_local0.PartyPrivacyToString = function(f11_arg0)
	local f11_local0 = @"hash_4980DDEA2FD1615B"
	if f11_arg0 == Enum[@"partyprivacy"][@"party_privacy_open"] then
		f11_local0 = @"hash_1D7568CAE1BE3F6B"
	elseif f11_arg0 == Enum[@"partyprivacy"][@"party_privacy_friends_only"] then
		f11_local0 = @"hash_D5B11C63C41C427"
	elseif f11_arg0 == Enum[@"partyprivacy"][@"party_privacy_invite_only"] then
		f11_local0 = 0x4D4EA9B2703EF9
	elseif f11_arg0 == Enum[@"partyprivacy"][@"party_privacy_closed"] then
		f11_local0 = @"hash_4980DDEA2FD1615B"
	end
	return Engine[@"hash_4F9F1239CFD921FE"](f11_local0)
end
f0_local0.ButtonStates_ReevaluateDisabledState = function()
	local f12_local0 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "ButtonStates.ReevaluateDisabledStates")
	if f12_local0 then
		Engine[@"setmodelvalue"](f12_local0, not Engine[@"getmodelvalue"](f12_local0))
	end
end
f0_local0.Sounds = LuaReadOnlyTables.ReadOnlyTable(f0_local2)
LobbyData = LuaReadOnlyTables.ReadOnlyTable(f0_local0)
