require("x64:53e8db3768fb02a")
require("x64:2f7767db3f402c")
Lobby.PartyPrivacy = {}
Lobby.PartyPrivacy.checkTime = 0
Lobby.PartyPrivacy.ON_SESSION_START_RECHECK_TIME = 500
Lobby.PartyPrivacy.GetGameLobbyPartyPrivacy = function()
	local f1_local0 = Engine[@"getlobbyuiscreen"]()
	if f1_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f1_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f1_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) then
		return Engine[@"getprofilevarint"](Engine[@"getprimarycontroller"](), "party_privacyStatus")
	elseif Engine[@"iscampaigngame"]() then
	elseif Engine[@"ismultiplayergame"]() then
		if Engine[@"sessionmode_ispubliconlinegame"]() and Engine[@"getplaylistmaxpartysize"](Engine[@"getplaylistid"]()) == 1 then
			return Enum[@"partyprivacy"][@"party_privacy_closed"]
		elseif LuaUtils.IsArenaMode() then
			if ((Engine[@"getgametypesetting"]("pregameItemVoteEnabled") == 1) or Engine[@"getgametypesetting"]("pregameDraftEnabled") == 1) and Engine[@"sessionmode_ispubliconlinegame"]() and (not Engine[@"isrunninguilevel"]() or Engine[@"isingame"]() or Lobby.Launch.IsHostLaunching()) then
				return Enum[@"partyprivacy"][@"party_privacy_closed"]
			elseif Lobby.Timer.LobbyIsLocked() then
				return Enum[@"partyprivacy"][@"party_privacy_closed"]
			end
		end
	elseif Engine[@"iszombiesgame"]() then
		if not Lobby.Launch.IsHostLaunching() and not Engine[@"isingame"]() and not Engine[@"isrunninguilevel"]() then
		end
	elseif Engine[@"hash_356B4618D857143D"]() and (Lobby.Launch.IsHostLaunching() or Engine[@"isingame"]() or not Engine[@"isrunninguilevel"]()) then
		return Enum[@"partyprivacy"][@"party_privacy_closed"]
	end
	if CoDShared.IsInTheaterLobby() then
		return Enum[@"partyprivacy"][@"party_privacy_closed"]
	end
	return Enum[@"partyprivacy"][@"party_privacy_open"]
end
Lobby.PartyPrivacy.SetPartyPrivacy = function()
	local f2_local0 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"])
	local f2_local1 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	local f2_local2 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"])
	local f2_local3 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f2_local4 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	local f2_local5 = Enum[@"partyprivacy"][@"party_privacy_open"]
	local f2_local6 = Enum[@"partyprivacy"][@"party_privacy_open"]
	if f2_local0 then
		f2_local5 = Engine[@"getprofilevarint"](Engine[@"getprimarycontroller"](), "party_privacyStatus")
		Engine[@"setsessionpartyprivacy"](Enum[@"lobbytype"][@"lobby_type_private"], f2_local5)
	elseif f2_local1 then
		f2_local5 = Engine[@"getsessionpartyprivacy"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	end
	if f2_local2 then
		f2_local6 = Lobby.PartyPrivacy.GetGameLobbyPartyPrivacy()
		Engine[@"setsessionpartyprivacy"](Enum[@"lobbytype"][@"lobby_type_game"], f2_local6)
	elseif f2_local3 then
		f2_local6 = Engine[@"getsessionpartyprivacy"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	end
	local f2_local7 = math.max(f2_local5, f2_local6)
	Engine[@"setpartyprivacy"](f2_local7)
	local f2_local8 = LobbyData.PartyPrivacyToString(f2_local7)
	local f2_local9 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "PartyPrivacy")
	if f2_local9 then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f2_local9, "privacy"), f2_local7)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f2_local9, "privacyStatus"), f2_local8)
	end
end
Lobby.PartyPrivacy.IsPrivateGameLobby = function(f3_arg0)
	local f3_local0 = f3_arg0[@"id"]
	if f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) or f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM) or f3_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM) then
		return true
	else
		return false
	end
end
Lobby.PartyPrivacy.SetLobbyMaxClients = function(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_host"], f4_arg1)
	local f4_local1 = Dvar[@"hash_4FF45B41C6046F8"]:get()
	if f4_arg2 == nil then
		f4_arg2 = LobbyData.GetCurrentMenuTarget()
	end
	if Lobby.PartyPrivacy.IsPrivateGameLobby(f4_arg2) then
		f4_local1 = f4_local0
	end
	local f4_local2 = math.min(math.max(1, f4_local1), f4_local0)
	Dvar[@"hash_4FF45B41C6046F8"]:set(f4_local2)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "PartyPrivacy"), "maxPlayers"), f4_local2)
end
Lobby.PartyPrivacy.OnSessionStart = function(f5_arg0)
	local f5_local0 = f5_arg0.lobbyModule
	local f5_local1 = f5_arg0.lobbyType
	local f5_local2 = f5_arg0.lobbyMode
	if Dvar[@"partyprivacyenabled"]:get() == false then
		return
	elseif Engine[@"isdedicatedserver"]() == true or f5_local0 ~= Enum[@"lobbymodule"][@"lobby_module_host"] or Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_local"] or Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] then
		return
	end
	local f5_local3 = Engine[@"getprimarycontroller"]()
	local f5_local4 = Engine[@"getprofilevarint"](f5_local3, "party_privacyStatus")
	if f5_local1 == Enum[@"lobbytype"][@"lobby_type_game"] and (f5_local2 == Enum[@"lobbymode"][@"lobby_mode_public"] or f5_local2 == Enum[@"lobbymode"][@"lobby_mode_arena"]) then
		f5_local4 = Enum[@"partyprivacy"][@"party_privacy_open"]
	else
		Lobby.PartyPrivacy.SetLobbyMaxClients(f5_local3, f5_local1)
	end
	f5_local4 = math.min(math.max(Enum[@"partyprivacy"][@"party_privacy_open"], f5_local4), Enum[@"partyprivacy"][@"party_privacy_closed"])
	Engine[@"setsessionpartyprivacy"](f5_local1, f5_local4)
	local f5_local5 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "PartyPrivacy")
	local f5_local6 = LobbyData.PartyPrivacyToString(f5_local4)
	if f5_local5 then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f5_local5, "privacyStatus"), f5_local6)
	end
	Lobby.PartyPrivacy.checkTime = Lobby.PartyPrivacy.ON_SESSION_START_RECHECK_TIME + Engine[@"milliseconds"]()
end
Lobby.PartyPrivacy.OnJoinPartyPrivacyCheck = function(f6_arg0)
	local f6_local0 = f6_arg0.lobbyType
	local f6_local1 = f6_arg0.joinType
	local f6_local2 = f6_arg0.fromXuid
	if f6_local1 == Enum[@"jointype"][@"join_type_party"] or f6_local1 == Enum[@"jointype"][@"join_type_playlist"] then
		return Enum[@"joinresult"][@"join_result_success"]
	else
		local f6_local3 = Engine[@"getpartyprivacy"]()
		if f6_local3 == Enum[@"partyprivacy"][@"party_privacy_closed"] then
			Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Rejecting join request from xuid(" .. tostring(f6_local2) .. ") because we are not joinable, session party privacy is closed.\n")
			return Enum[@"joinresult"][@"join_result_not_joinable_closed"]
		elseif f6_local3 == Enum[@"partyprivacy"][@"party_privacy_invite_only"] and f6_local1 ~= Enum[@"jointype"][@"join_type_invite"] then
			Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Rejecting join request from xuid(" .. tostring(f6_local2) .. ") because we are not joinable, session party privacy is invite only.\n")
			return Enum[@"joinresult"][@"join_result_not_joinable_invite_only"]
		elseif f6_local3 == Enum[@"partyprivacy"][@"party_privacy_friends_only"] and f6_local1 ~= Enum[@"jointype"][@"join_type_invite"] then
			if f6_local1 == Enum[@"jointype"][@"join_type_friend"] and Engine[@"isfriendfromxuid"](Engine[@"getprimarycontroller"](), f6_local2) then
				return Enum[@"joinresult"][@"join_result_success"]
			else
				Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyhost"], "Rejecting join request from xuid(" .. tostring(f6_local2) .. ") because we are not joinable, session party privacy is friends only.\n")
				return Enum[@"joinresult"][@"join_result_not_joinable_friends_only"]
			end
		else
			return Enum[@"joinresult"][@"join_result_success"]
		end
	end
end
Lobby.PartyPrivacy.OnGametypeSettingsChange = function(f7_arg0)
	local f7_local0 = f7_arg0.lobbyModule
	local f7_local1 = f7_arg0.lobbyType
	local f7_local2 = Engine[@"getlobbyuiscreen"]()
	if (f7_local2 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f7_local2 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f7_local2 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) or f7_local2 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM)) and f7_arg0.fromUI == true then
		local f7_local3 = Engine[@"getgametypesetting"]("allowSpectating") == 1
		local f7_local4 = LobbyData.GetCurrentLobbySizes()
		local f7_local5 = Engine[@"getgametypesetting"]("maxPlayers")
		if f7_local3 then
			f7_local5 = f7_local5 + f7_local4.maxCoDcasterClients or f7_local5
		end
		Engine[@"setlobbymaxclients"](f7_local1, f7_local5)
	end
end
Lobby.PartyPrivacy.Pump = function()
	if Dvar[@"partyprivacyenabled"]:get() == false or Dvar[@"partyprivacypumpenabled"]:get() == false then
		return
	elseif Lobby.PartyPrivacy.checkTime > Engine[@"milliseconds"]() then
		return
	else
		Lobby.PartyPrivacy.checkTime = Dvar[@"partyprivacycheckinterval"]:get() + Engine[@"milliseconds"]()
		Lobby.PartyPrivacy.SetPartyPrivacy()
	end
end
