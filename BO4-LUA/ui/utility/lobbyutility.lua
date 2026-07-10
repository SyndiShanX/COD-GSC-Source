require("x64:f3c5259f470592d")
CoD.LobbyUtility = {}
CoD.LobbyUtility.LobbyMemberSort = function(f1_arg0, f1_arg1)
	local f1_local0 = Engine[@"getxuid64"](Engine[@"getprimarycontroller"]())
	if f1_arg0.xuid == f1_local0 then
		return true
	elseif f1_arg1.xuid == f1_local0 then
		return false
	elseif f1_arg0.team < f1_arg1.team then
		return true
	elseif f1_arg0.team == f1_arg1.team then
		if f1_arg0.botType == Enum[@"lobbybottype"][@"lobby_bot_type_invalid"] and f1_arg1.botType ~= Enum[@"lobbybottype"][@"lobby_bot_type_invalid"] then
			return true
		elseif f1_arg0.botType ~= Enum[@"lobbybottype"][@"lobby_bot_type_invalid"] and f1_arg1.botType == Enum[@"lobbybottype"][@"lobby_bot_type_invalid"] then
			return false
		elseif f1_arg0.lobbyID < f1_arg1.lobbyID then
			return true
		end
	end
	return false
end
CoD.LobbyUtility.isMapFree = function(f2_arg0)
	local f2_local0 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav")
	if f2_local0 then
		return CoDShared.IsMapFree(f2_arg0, f2_local0, Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.playlistId")))
	else
		return false
	end
end
CoD.LobbyUtility.GetClientList = function()
	local f3_local0 = Enum[@"lobbymodule"][@"lobby_module_client"]
	local f3_local1 = Engine[@"lobbygetsessionclients"](f3_local0, Engine[@"lobbygetcontrollinglobbysession"](f3_local0))
	local f3_local2 = nil
	local f3_local3 = LobbyData.GetCurrentMenuTarget()
	if f3_local3[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) then
		f3_local2 = f3_local1
	else
		f3_local2 = Engine[@"lobbygetsessionclients"](f3_local0, Enum[@"lobbytype"][@"lobby_type_private"])
	end
	for f3_local14, f3_local15 in ipairs(f3_local1.sessionClients) do
		local f3_local10 = false
		f3_local1.sessionClients[f3_local14].isMember = 0
		f3_local1.sessionClients[f3_local14].isMemberLeader = 0
		f3_local1.sessionClients[f3_local14].isOtherMember = 0
		f3_local1.sessionClients[f3_local14].isMemberTopOrMiddle = 0
		f3_local1.sessionClients[f3_local14].isOtherMemberTopOrMiddle = 0
		f3_local1.sessionClients[f3_local14].lobbyClientType = f3_local15.lobbyClientType
		f3_local1.sessionClients[f3_local14].isInAParty = false
		if #f3_local2.sessionClients > 0 then
			for f3_local11, f3_local12 in ipairs(f3_local2.sessionClients) do
				if f3_local15.xuid == f3_local12.xuid then
					f3_local1.sessionClients[f3_local14].isMember = 1
					f3_local1.sessionClients[f3_local14].isMemberLeader = f3_local12.isLeader
					f3_local10 = true
					break
				end
			end
		end
		if f3_local10 == false then
			local f3_local7 = 0
			for f3_local12, f3_local13 in ipairs(f3_local1.sessionClients) do
				if f3_local15.simpleLobbyID == f3_local1.sessionClients[f3_local12].simpleLobbyID then
					f3_local7 = f3_local7 + 1
				end
			end
			if f3_local7 > 1 then
				f3_local1.sessionClients[f3_local14].isOtherMember = 1
			end
		end
		f3_local1.sessionClients[f3_local14].dlcBits = f3_local15.dlcBits
	end
	table.sort(f3_local1.sessionClients, CoD.LobbyUtility.LobbyMemberSort)
	f3_local4, f3_local5 = nil
	for f3_local10, f3_local7 in ipairs(f3_local1.sessionClients) do
		if f3_local4 ~= nil and f3_local5 == f3_local7.simpleLobbyID then
			f3_local4.isInAParty = true
			f3_local1.sessionClients[f3_local10].isInAParty = true
			if f3_local7.isMember == 1 or f3_local7.isMemberLeader and f3_local7.isMemberLeader ~= 0 then
				f3_local4.isMemberTopOrMiddle = 1
			elseif f3_local7.isOtherMember == 1 then
				f3_local4.isOtherMemberTopOrMiddle = 1
			end
		end
		f3_local4 = f3_local7
		f3_local5 = f3_local7.simpleLobbyID
	end
	return f3_local1.sessionClients
end
CoD.LobbyUtility.GetTeams = function()
	local f4_local0 = CoD.LobbyUtility.GetClientList()
	local f4_local1 = {}
	for f4_local5, f4_local6 in pairs(f4_local0) do
		if f4_local6.team ~= nil then
			if f4_local1[f4_local6.team] == nil then
				f4_local1[f4_local6.team] = {}
			end
			table.insert(f4_local1[f4_local6.team], f4_local6)
		end
	end
	return f4_local1
end
CoD.LobbyUtility.GetTeam = function(f5_arg0)
	local f5_local0 = CoD.LobbyUtility.GetClientList()
	local f5_local1 = {}
	for f5_local5, f5_local6 in pairs(f5_local0) do
		if f5_local6.team == f5_arg0 then
			table.insert(f5_local1, f5_local6)
		end
	end
	return f5_local1
end
CoD.LobbyUtility.GetEnemyTeam = function(f6_arg0)
	local f6_local0 = CoD.LobbyUtility.GetClientList()
	local f6_local1 = {}
	for f6_local5, f6_local6 in pairs(f6_local0) do
		if CoD.TeamUtility.IsValidPlayerTeam(f6_local6.team) and f6_local6.team ~= f6_arg0 then
			table.insert(f6_local1, f6_local6)
		end
	end
	return f6_local1
end
CoD.LobbyUtility.GetSortedTeams = function()
	local f7_local0 = CoD.LobbyUtility.GetClientList()
	local f7_local1 = function(f8_arg0, f8_arg1)
		f8_arg0 = f7_local0[f8_arg0]
		f8_arg1 = f7_local0[f8_arg1]
		if f8_arg0.isLocal or f8_arg1.isLocal then
			return f8_arg1.isLocal < f8_arg0.isLocal
		elseif f8_arg0.isMemberLeader or f8_arg1.isMemberLeader then
			return f8_arg1.isMemberLeader < f8_arg0.isMemberLeader
		elseif not (not f8_arg0.isMember or f8_arg1.isMember) or not f8_arg0.isMemberLeader and f8_arg1.isMember then
			return f8_arg1.isMember < f8_arg0.isMember
		else
			return f8_arg1.clientNum < f8_arg0.clientNum
		end
	end
	local f7_local2 = {}
	for f7_local6, f7_local7 in LUI.IterateTableBySortedKeys(f7_local0, f7_local1, nil) do
		if not f7_local2[f7_local7.team] then
			f7_local2[f7_local7.team] = {}
		end
		table.insert(f7_local2[f7_local7.team], f7_local7)
	end
	return f7_local2
end
CoD.LobbyUtility.GetSortedClients = function(f9_arg0)
	local f9_local0 = Engine[@"hash_4FCDE749B09C3D6"](f9_arg0)
	local f9_local1 = CoD.LobbyUtility.GetSortedTeams()
	local f9_local2 = function(f10_arg0, f10_arg1)
		if f10_arg1 == nil then
			return false
		end
		for f10_local3, f10_local4 in pairs(f10_arg1) do
			if f10_local4.clientNum == f10_arg0 then
				return true
			end
		end
		return false
	end
	for f9_local7, f9_local8 in pairs(f9_local0) do
		if not f9_local2(f9_local7, f9_local1[f9_local8]) then
			if not f9_local1[f9_local8] then
				f9_local1[f9_local8] = {}
			end
			local f9_local6 = Engine[@"getplayerlistdata"](f9_arg0, f9_local7)
			table.insert(f9_local1[f9_local8], {
				clientNum = f9_local7,
				isBot = f9_local6.isBot,
				isCompanion = f9_local6.isCompanion,
				companionOwner = Engine[@"hash_587453BFA40E0034"](f9_arg0, f9_local7),
			})
		end
	end
	return f9_local1
end
CoD.LobbyUtility.GetMaxClientCount = function()
	return Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) and Enum[@"lobbytype"][@"lobby_type_game"] or Enum[@"lobbytype"][@"lobby_type_private"])
end
CoD.LobbyUtility.GetClient = function(f12_arg0)
	for f12_local3, f12_local4 in pairs(CoD.LobbyUtility.GetClientList()) do
		if f12_local4.clientNum == f12_arg0 then
			return f12_local4
		end
	end
	return nil
end
CoD.LobbyUtility.IsSomePlayersDoNotHaveMapTextShowing = function()
	return CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "lobbyRoot.lobbyStatusString3") == @"hash_2A5EF279F9C4EDC1"
end
CoD.LobbyUtility.GetHostDLCBits = function(f14_arg0)
	for f14_local3, f14_local4 in ipairs(f14_arg0) do
		if f14_local4.isHost then
			return f14_local4.dlcBits
		end
	end
end
CoD.LobbyUtility.ShouldShowDLCWarningsBasedOnHost = function()
	return false
end
CoD.LobbyUtility.UpdateMapInstallStatusLine = function(f16_arg0)
	local f16_local0 = CoD.LobbyUtility.GetClientList()
	local f16_local1 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "MapVote.mapVoteMapNext")
	local f16_local2 = true
	if MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN) then
		if IsInTheaterMode() and not IsFilmSelected() then
		elseif not f16_local1 or not f16_local0 then
			f16_local2 = false
		else
			local f16_local3 = Engine[@"getdlcbitformapname"](f16_local1)
			if f16_local3 then
				for f16_local7, f16_local8 in ipairs(f16_local0) do
					if f16_local8.dlcBits and not CoD.BitUtility.IsBitwiseAndNonZero(f16_local8.dlcBits, f16_local3) then
						f16_local2 = false
						break
					end
				end
			end
		end
	end
	local f16_local3 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyStatusString3")
	local f16_local4 = CoD.SafeGetModelValue(Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav")
	local f16_local5 = nil
	if CoD.LobbyUtility.ShouldShowDLCWarningsBasedOnHost() then
		local f16_local6 = CoD.LobbyUtility.GetHostDLCBits(f16_local0)
		if f16_local6 then
			for f16_local10, f16_local11 in ipairs(f16_local0) do
				local f16_local12 = CoD.BaseUtility.GetKnownDLCBits() & f16_local6
				if f16_local11.dlcBits and f16_local12 ~= f16_local12 & f16_local11.dlcBits then
					f16_local2 = false
					break
				end
			end
		end
		if f16_local2 then
			f16_local5 = 0x0
		elseif f16_local4 == LobbyData.GetLobbyMenuIDByName(@"hash_4A82F65E15FA0AE4") then
			f16_local5 = @"hash_6D6F106BB57DB329"
		else
			f16_local5 = @"hash_3B1EA843FE92AE3A"
		end
	else
		if f16_local2 then
			local f16_local13 = 0x0
		end
		f16_local5 = f16_local13 or @"hash_2A5EF279F9C4EDC1"
	end
	if Engine[@"getmodelvalue"](f16_local3) ~= f16_local5 then
		Engine[@"setmodelvalue"](f16_local3, f16_local5)
		Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyButtonUpdate"))
	end
	if not f16_local2 and not f16_arg0._updateDLCBitTimer then
		f16_arg0._updateDLCBitTimer = LUI.UITimer.newElementTimer(1000, false, function()
			CoD.LobbyUtility.UpdateMapInstallStatusLine(f16_arg0)
		end)
		f16_arg0:addElement(f16_arg0._updateDLCBitTimer)
		LUI.OverrideFunction_CallOriginalSecond(f16_arg0, "close", function(element)
			if element._updateDLCBitTimer then
				element._updateDLCBitTimer:close()
				element._updateDLCBitTimer = nil
			end
		end)
	elseif f16_local2 and f16_arg0._updateDLCBitTimer then
		f16_arg0._updateDLCBitTimer:close()
		f16_arg0._updateDLCBitTimer = nil
	end
end
CoD.LobbyUtility.FailedDWConnection = false
CoD.LobbyUtility.Prompt = {}
CoD.LobbyUtility.Prompt.Title = nil
CoD.LobbyUtility.Prompt.Description = nil
CoD.LobbyUtility.Prompt.Options = nil
CoD.LobbyUtility.LeaderActivity = {
	INVALID = {
		index = 0,
		str = @"menu/ready",
	},
	EDITING_GAME_RULES = {
		index = 1,
		str = @"hash_4D334604C49E05C9",
	},
	CHOOSING_MAP = {
		index = 2,
		str = @"menu/selecting_map",
	},
	CHOOSING_GAME_MODE = {
		index = 3,
		str = @"menu/selecting_gametype",
	},
	SETTING_UP_BOTS = {
		index = 4,
		str = @"hash_34C99F698861859E",
	},
	MODIFYNG_REWARDS = {
		index = 5,
		str = @"hash_16DE0B068DDA2C48",
	},
	MODIFYING_CAC = {
		index = 6,
		str = @"hash_341938EA32980EE5",
	},
	MODIFYING_HERO = {
		index = 7,
		str = @"hash_3FBBB9AAF77166C",
	},
	VIEWING_PLAYLISTS = {
		index = 8,
		str = @"hash_3A918E99BC54400A",
	},
	VIEWING_PLAYERCARD = {
		index = 9,
		str = @"hash_4322D6BA4F6F1040",
	},
	MODIFYING_BUBBLEGUM = {
		index = 10,
		str = @"hash_1DB82DB610B19BD9",
	},
	MODIFYING_WEAPON_BUILD_KITS = {
		index = 11,
		str = 0x39AD93B1F97D39,
	},
	EDITING_CODCASTER_SETTINGS = {
		index = 12,
		str = @"hash_37DC5B3B89EB755",
	},
	AT_MEGACHEW_FACTORY = {
		index = 13,
		str = @"hash_6C0EDBD567A3996F",
	},
	WAITING_TO_SELECT = {
		index = 14,
		str = @"menu/ready",
		select = @"menu/waiting_select",
		main = @"menu/waiting_main",
	},
}
CoD.LobbyUtility.MapSelect = {
	LAUNCH = 0,
	NAVIGATE = 1,
	SELECT = 2,
}
CoD.LobbyUtility.DisplayedFirstTimeDurangoDownloadSetting = false
CoD.LobbyUtility.RegisterEventHandlers = function(f19_arg0)
	f19_arg0:registerEventHandler("open_toaster_popup", CoD.LobbyUtility.OpenToasterPopup)
	f19_arg0:registerEventHandler("clan_action", CoD.LobbyUtility.DoClanAction)
	f19_arg0:registerEventHandler("playlist_selected", CoD.LobbyUtility.GoToFindingGames)
	f19_arg0:registerEventHandler("lobby_leader_activity_changed", CoD.LobbyUtility.LeaderActivityChanged)
	CoD.LobbyUtility.LeaderActivityInit()
	CoD.LobbyUtility.SubscribeToModels(f19_arg0)
end
CoD.LobbyUtility.DoClanAction = function(f20_arg0, f20_arg1)
	local f20_local0 = f20_arg1.actionType
	local f20_local1 = f20_arg1.controller
	if f20_local0 == "go_back" then
	else
	end
end
CoD.LobbyUtility.CreateOverlay = function(f21_arg0)
	if CoD.mainMenu == nil then
		return
	end
	local f21_local0 = f21_arg0.overlay
	local f21_local1 = f21_arg0.controller
	local f21_local2 = f21_arg0.anyControllerAllowed
	local f21_local3 = f21_arg0.unusedControllerAllowed
	local f21_local4 = nil
	if f21_local0 == LuaEnum.LOBBYVM_OPENED_OVERLAYS.STILLDOWNLOADING then
		f21_local4 = CoD.OverlayUtility.CreateOverlay(f21_local1, CoD.mainMenu, "GenericModalDialog", "", "MENU_STILLDOWNLOADING", "t7_icon_connect_overlays_bkg", {
			@"mpui/ok",
		}, function(f22_arg0)
			return true
		end)
	end
	if f21_local4 == nil then
		return
	end
	f21_local4.anyControllerAllowed = f21_local2
	f21_local4.unusedControllerAllowed = f21_local3
end
CoD.LobbyUtility.eventHandlers = {}
CoD.LobbyUtility.eventHandlers.CreateOverlay = CoD.LobbyUtility.CreateOverlay
CoD.LobbyUtility.EventDispatcher = function(f23_arg0, f23_arg1)
	if CoD.LobbyUtility.eventHandlers[f23_arg0] then
		if type(CoD.LobbyUtility.eventHandlers[f23_arg0]) == "function" then
			CoD.LobbyUtility.eventHandlers[f23_arg0](f23_arg1)
			return
		elseif type(CoD.LobbyUtility.eventHandlers[f23_arg0]) == "table" then
			for f23_local3, f23_local4 in ipairs(CoD.LobbyUtility.eventHandlers[f23_arg0]) do
				f23_local4(f23_arg1)
			end
			return
		end
	end
	if not Engine[@"isshipbuild"]() then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "CoD.LobbyUtility.EventDispatcher() - invalid event: " .. f23_arg0 .. ".\n")
	else
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobbyvm"], "CoD.LobbyUtility.EventDispatcher() - invalid event: " .. f23_arg0 .. ".\n")
	end
end
CoD.LobbyUtility.SubscribeToModels = function(f24_arg0)
	f24_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"), function(model)
		CoD.LobbyUtility.ResetLeaderActivity(Engine[@"getprimarycontroller"]())
	end, false)
	f24_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyVMRequest"), function(model)
		CoD.LobbyUtility.ExecuteLobbyVMRequest(f24_arg0, model)
	end, false)
	f24_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyVMCreateOverlay"), function(model)
		local f27_local0 = Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyVMCreateOverlayController"))
		local f27_local1 = Engine[@"getmodelvalue"](model)
		if LUI.createMenu[f27_local1] then
			OpenOverlay(f24_arg0, f27_local1, f27_local0, nil)
		else
			local f27_local2 = CoD.OverlayUtility.CreateOverlay(f27_local0, f24_arg0, f27_local1)
			f27_local2.callingMenu = f24_arg0
		end
	end, false)
	f24_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyVMOpenIntroSurvey"), function(model)
		CoD.SurveyUtility.OpenSurvey(f24_arg0, Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyVMOpenIntroSurvey")), CoD.SurveyUtility.GetIntroSurveyType())
	end, false)
	f24_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.showSelect"), function(model)
		local f29_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
		local f29_local1 = Enum[@"lobbytype"][@"lobby_type_private"]
		if f29_local0[@"lobbytype"] then
			f29_local1 = f29_local0[@"lobbytype"]
		end
		if f29_local1 == Enum[@"lobbytype"][@"lobby_type_invalid"] then
			return
		else
			CoD.LobbyUtility.LeaderActivityChanged(f24_arg0, {
				lobbyType = f29_local1,
				activity = Engine[@"getleaderactivity"](),
			})
		end
	end, false)
end
CoD.LobbyUtility.ExecuteLobbyVMRequest = function(f30_arg0, f30_arg1)
	local f30_local0 = Engine[@"getmodelvalue"](f30_arg1)
	local f30_local1 = Engine[@"getprimarycontroller"]()
	if f30_local0 == LuaEnum.LOBBYVM_REQUEST.FORCE_LOCAL_MODE then
		CoD.LobbyUtility.FailedDWConnection = true
		Engine[@"setmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.failedDemonwareConnection"), true)
	elseif f30_local0 == LuaEnum.LOBBYVM_REQUEST.RESET_LOADOUTS and not IsLobbyHostOfCurrentMenu() then
		local f30_local2 = Engine[@"getglobalmodel"]()
		f30_local2.lobbyRoot.closePopups:forceNotifySubscriptions()
		if CoD.isPC then
			ResetEverythingOnPC(f30_arg0, f30_local1)
		else
			CoD.BaseUtility.InitControllerModel(f30_local1, "PlayerSettingsUpdate", "")
			f30_local2 = OpenOverlay(f30_arg0, "StartMenu_Options_Controls", 0)
			CoD.OptionsUtility.ResetPlayerSettingsGroupListToDefault(0, f30_local2.OptionGroups)
			GoBack(f30_local2, 0)
			CoD.CACUtility.SetDefaultLoadouts({
				controller = f30_local1,
				storageFileType = Enum[@"storagefiletype"][@"storage_mp_loadouts_offline"],
			})
			CoD.CACUtility.SetDefaultLoadouts({
				controller = f30_local1,
				storageFileType = Enum[@"storagefiletype"][@"hash_D062FA7B47FC13A"],
			})
		end
	end
end
CoD.LobbyUtility.IsArenaStorageType = function(f31_arg0)
	local f31_local0
	if f31_arg0 ~= Enum[@"storagefiletype"][0x67DF1879D992E] and f31_arg0 ~= Enum[@"storagefiletype"][@"hash_CEBE62E27709AD0"] and f31_arg0 ~= Enum[@"storagefiletype"][@"hash_D062FA7B47FC13A"] then
		f31_local0 = false
	else
		f31_local0 = true
	end
	return f31_local0
end
CoD.LobbyUtility.OpenToasterPopup = function(f32_arg0, f32_arg1)
	local f32_local0 = f32_arg1.toastType
	local f32_local1 = f32_arg1.isError
	local f32_local2 = f32_arg1.gamertag
	if f32_local0 == "clan_join" then
		if f32_local1 == false then
			CoD.OverlayUtility.ShowToast("ClanJoin", CoD.BaseUtility.AlreadyLocalized(f32_arg1.message), "", LuaDefine.TOAST_POPUP_ICON_SUCCESS)
		else
			CoD.OverlayUtility.ShowToast("ClanJoin", Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"hash_3248E1604D27C8DA")), "", LuaDefine.TOAST_POPUP_ICON_ERROR)
		end
	elseif f32_local0 == "remove_user" then
		if f32_local1 == false then
			CoD.OverlayUtility.ShowToast("RemoveUser", CoD.BaseUtility.AlreadyLocalized(f32_arg1.message), "", LuaDefine.TOAST_POPUP_ICON_SUCCESS)
		else
			CoD.OverlayUtility.ShowToast("RemoveUser", Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"hash_3248E1604D27C8DA")), "", LuaDefine.TOAST_POPUP_ICON_ERROR)
		end
	elseif f32_local0 == "new_host" then
		CoD.OverlayUtility.ShowToast("NewHost", Engine[@"hash_4F9F1239CFD921FE"](@"hash_2174F6E6D02D9978"), "", LuaDefine.TOAST_POPUP_ICON_SUCCESS)
	elseif f32_local0 == "multiple_invites" then
		CoD.OverlayUtility.ShowToast("MultipleInvites", Engine[@"hash_4F9F1239CFD921FE"](@"hash_231D384E754F1A41"), "", LuaDefine.TOAST_POPUP_ICON_SUCCESS)
	elseif f32_local0 == "invite" then
		if f32_local1 == false then
			CoD.OverlayUtility.ShowToast("Invite", Engine[@"hash_4F9F1239CFD921FE"](@"hash_5513526C1CA23EB9"), f32_local2, LuaDefine.TOAST_POPUP_ICON_SUCCESS)
		else
			CoD.OverlayUtility.ShowToast("Invite", Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"hash_3248E1604D27C8DA")), f32_local2, LuaDefine.TOAST_POPUP_ICON_ERROR)
		end
	elseif f32_local0 == "trial_clients_kicked" then
		local f32_local3 = @"hash_667242EF77843FDB"
		if f32_arg1.koreanUnderageMembersRemoved > 0 then
			f32_local3 = @"hash_458C62A4F206EBFC"
		end
		if f32_arg1.limitedNoZMMembersRemoved > 0 then
			f32_local3 = @"hash_458C62A4F206EBFC"
		end
		CoD.OverlayUtility.ShowToast("TrialClientsKicked", Engine[@"hash_4F9F1239CFD921FE"](f32_local3), "", LuaDefine.TOAST_POPUP_ICON_ERROR)
	elseif f32_local0 == "error" then
		CoD.OverlayUtility.ShowToast("Invite", CoD.BaseUtility.AlreadyLocalized(f32_arg1.message), "", LuaDefine.TOAST_POPUP_ICON_ERROR)
	end
	return true
end
CoD.LobbyUtility.ChunkAllDownloading = function()
	if (IsOrbis() or IsDurango()) and Engine[@"hash_77D47312EBA41751"]() then
		return true
	else
		return false
	end
end
CoD.LobbyUtility.ChunkAnyDownloading = function()
	if (IsOrbis() or IsDurango()) and Engine[@"hash_77D47312EBA41751"]() then
		return true
	else
		return false
	end
end
CoD.LobbyUtility.ForceOffline = function()
	if (LuaDefine.isPS4 or LuaDefine.isXbox) and LuaUtils.IsSkuOfflineOnly() then
		return true
	elseif LuaDefine.isPC and Dvar[@"nodw"]:get() then
		return true
	else
		return false
	end
end
CoD.LobbyUtility.EndPlay = function(f36_arg0, f36_arg1)
	Engine[@"deactivatealllocalclients"]()
end
CoD.LobbyUtility.SetInitLobbyMenu = function(f37_arg0, f37_arg1)
	if Engine[@"iscinematicplaying"]() then
		f37_arg0:registerEventHandler("check_cinematic_play_music", function(element, event)
			if Engine[@"iscinematicplaying"]() then
				return
			else
				f37_arg0:registerEventHandler("check_cinematic_play_music", CoD.NullFunction)
				element.timer:close()
				CoD.PlayFrontendMusic()
			end
		end)
		f37_arg0.timer = LUI.UITimer.new(1000, "check_cinematic_play_music", false, f37_arg0)
		f37_arg0:addElement(f37_arg0.timer)
	else
		CoD.PlayFrontendMusic()
	end
end
CoD.LobbyUtility.SetMenuControllerRestriction = function(f39_arg0, f39_arg1, f39_arg2)
	local f39_local0 = LuaDefine.INVALID_CONTROLLER_PORT
	if f39_arg2 == 1 then
		f39_local0 = f39_arg1
	end
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ControllerRestrictionValidControllerIdx"), f39_local0)
end
CoD.LobbyUtility.LobbyNavigationActionModel = "lobbyRoot.lastNavigationAction"
CoD.LobbyUtility.NavigateToLobby = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4)
	local f40_local0 = LobbyData.GetCurrentMenuTarget()
	if f40_local0[@"name"] == f40_arg1 then
		return
	elseif Engine[@"hash_6AEF2B6FA8A0BE77"]() and not Engine[@"hash_7567E8691BA45BA"]() and not Engine[0xEE3E4DCDA4DB3F]() then
		local f40_local1 = LobbyData.GetLobbyMenuByName(f40_arg1)
		f40_local1 = f40_local1[@"mainmode"]
		if f40_local1 ~= Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
			local f40_local2 = @"menu/multiplayer"
			if f40_local1 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
				f40_local2 = @"menu/zombies"
			end
			Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.trialOverlayDescription"), Engine[@"hash_4F9F1239CFD921FE"](@"hash_1B844491C0871F92", f40_local2))
			CoD.OverlayUtility.CreateOverlay(f40_arg3, f40_arg0, "LobbyLeaveTrial")
			return
		end
	end
	if Engine[@"hash_6AEF2B6FA8A0BE77"]() or Engine[@"hash_7567E8691BA45BA"]() or Engine[0xEE3E4DCDA4DB3F]() then
		local f40_local1 = false
		local f40_local2 = false
		local f40_local3 = false
		local f40_local4 = LobbyData.GetLobbyMenuByName(f40_arg1)
		f40_local4 = f40_local4[@"mainmode"]
		local f40_local5 = @"menu/multiplayer"
		if f40_local4 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
			f40_local5 = @"menu/zombies"
		end
		if f40_local4 ~= Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] and Engine[@"hash_6AEF2B6FA8A0BE77"]() then
			f40_local1 = true
		end
		if f40_local4 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] and Engine[@"hash_7567E8691BA45BA"]() then
			f40_local2 = true
		end
		if f40_local4 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] and Engine[0xEE3E4DCDA4DB3F]() then
			f40_local3 = true
		end
		if f40_local1 or f40_local2 or f40_local3 then
			Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.trialOverlayDescription"), Engine[@"hash_4F9F1239CFD921FE"](@"hash_55D1FF5B55B1B0B3", f40_local5))
			CoD.OverlayUtility.CreateOverlay(f40_arg3, f40_arg0, "LobbyLeaveInvalidPlayers", {
				removeTrial = f40_local1,
				removeKoreanUnderage = f40_local2,
				removeLimitedNoZM = f40_local3,
			})
			return
		end
	end
	if f40_arg1 == LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME then
		Engine[@"lobbyevent"]("OnClanUIEvent", {
			controller = f40_arg3,
			event = LuaEnum.CLAN_UI_EVENT.INIT_MODELS,
		})
		Engine[@"lobbyevent"]("OnClanUIEvent", {
			controller = f40_arg3,
			event = LuaEnum.CLAN_UI_EVENT.FETCH_DATA,
		})
	end
	local f40_local1 = Engine[@"getglobalmodel"]()
	f40_local1 = f40_local1:create(CoD.LobbyUtility.LobbyNavigationActionModel)
	f40_local1:set(f40_arg1)
	f40_arg0:saveState(f40_arg3)
	if not CoD.MenuNavigation then
		CoD.MenuNavigation = {}
	end
	if not CoD.MenuNavigation[f40_arg3] then
		CoD.MenuNavigation[f40_arg3] = {
			{
				f40_arg0.menuName,
			},
		}
	end
	local f40_local1, f40_local2 = CoD.Menu.GetNavigationForMenu(f40_arg3, f40_arg0.menuName)
	if f40_local1 and f40_local2 then
		if f40_arg2 then
			table.insert(CoD.MenuNavigation[f40_arg3][f40_local1], f40_local2 + 1, "Director")
		else
			CoD.MenuNavigation[f40_arg3][f40_local1][f40_local2] = "Director"
		end
	else
		table.insert(CoD.MenuNavigation[f40_arg3], {
			"Director",
		})
	end
	local f40_local3 = {
		controller = f40_arg3,
		navToMenu = f40_arg1,
		playlistID = f40_arg4,
	}
	local f40_local4 = LobbyData.GetLobbyMenuByName(f40_arg1)
	if f40_local4[@"maxlocalclients"] < Engine[@"getusedcontrollercount"]() then
		f40_local3.maxLocalClients = f40_local4[@"maxlocalclients"]
		CoD.OverlayUtility.CreateOverlay(f40_arg3, f40_arg0, "LobbyLocalClientWarning", f40_local3)
		return
	elseif f40_local4[@"maxclients"] < Engine[@"getlobbyclientcount"](Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) and Enum[@"lobbymodule"][@"lobby_module_host"] or Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]) then
		OpenGenericSmallPopup(f40_arg0, f40_arg3, @"menu/warning", Engine[@"hash_4F9F1239CFD921FE"](@"hash_6128045808A178F3", f40_local4[@"maxclients"]), nil, Engine[@"hash_4F9F1239CFD921FE"](@"menu/ok"))
		return
	elseif f40_arg1 == LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING and CoD.CTUtility.ShouldPlayIntroStoryMovie(f40_arg3) then
		local f40_local6 = DataSources.SpecialistHeadquarters.getModel(f40_arg3)
		f40_local6.StartFullscreenBlack:set(true)
	end
	Engine[@"lobbyevent"]("OnGoForward", f40_local3)
end
CoD.LobbyUtility.ShowLeaveLobbyPopup = function(f41_arg0)
	if Dvar[@"leavewithpartyenabled"]:get() == false then
		return LuaEnum.LEAVE_LOBBY_POPUP.NONE
	end
	local f41_local0 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"])
	local f41_local1 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"])
	local f41_local2 = Engine[@"inlobbyparty"](Enum[@"lobbytype"][@"lobby_type_private"])
	local f41_local3 = Engine[@"inlobbyparty"](Enum[@"lobbytype"][@"lobby_type_game"])
	local f41_local4 = Engine[@"getlobbyclientcount"](Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) and Enum[@"lobbymodule"][@"lobby_module_host"] or Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]) - Engine[@"getusedcontrollercount"]() == 0
	local f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.NONE
	if f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
	elseif f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		if f41_local0 and f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY
		elseif f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY
		end
	elseif f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME) then
		if f41_local0 and f41_local2 and not f41_local4 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE
		elseif f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		end
	elseif f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_THEATER) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_THEATER) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_THEATER) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_THEATER) then
		if not f41_local0 and f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		else
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.NONE_LEAVE_WITH_PARTY
		end
	elseif f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) then
		if not f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY
		elseif f41_local0 and f41_local2 and not f41_local4 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE
		elseif not f41_local0 and f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		end
	elseif f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) then
		local f41_local6 = CoD.LobbyUtility.AllMembersInFrontend()
		if not f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.NONE
		elseif f41_local0 and f41_local2 and not f41_local4 and f41_local6 == true then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE
		elseif not (f41_local0 or not f41_local2) or not f41_local6 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		end
	elseif f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM) then
		local f41_local6 = LobbyData.GetLobbyMenuByID(f41_arg0[@"id"])
		local f41_local7 = LobbyData.GetLobbyMenuByName(LuaUtils.LobbyMainModeData[f41_local6[@"mainmode"]].PregameMenu)
		local f41_local8 = Engine[@"getglobalmodel"]()
		f41_local8 = f41_local8.lobbyRoot.lobbyList.playerCount:get()
		if not f41_local8 or not f41_local8 then
			f41_local8 = 1
		end
		local f41_local9 = f41_local7[@"maxclients"]
		local f41_local10 = f41_arg0[@"maxclients"]
		if f41_local9 < f41_local10 then
			local f41_local11 = f41_local9
		end
		if (f41_local11 or f41_local10) < f41_local8 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY
		elseif not f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY
		elseif f41_local0 and f41_local2 and not f41_local4 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE
		elseif not f41_local0 and f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		end
	elseif f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_CP) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_MP) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_MP_ARENA) or f41_arg0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_ZM) then
		if f41_local1 and f41_local3 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY
		else
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY
		end
	end
	return f41_local5
end
CoD.LobbyUtility.ShouldShowLeaveLobbyPopup = function()
	local f42_local0 = Engine[@"getglobalmodel"]()
	local f42_local1 = LobbyData.GetLobbyMenuByID(f42_local0.lobbyRoot.lobbyNav:get())
	if f42_local1 == nil then
		return false
	else
		return CoD.LobbyUtility.ShowLeaveLobbyPopup(f42_local1) ~= LuaEnum.LEAVE_LOBBY_POPUP.NONE
	end
end
CoD.LobbyUtility.StopManualTimer = function(f43_arg0)
	local f43_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	local f43_local1 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "MapVote.timerActive")
	Engine[@"setmodelvalue"](f43_local1, 0)
	Engine[@"forcenotifymodelsubscriptions"](f43_local1)
	Engine[@"lobbyevent"]("OnStopLobbyTimer", {
		controller = f43_arg0,
		lobbyType = f43_local0[@"lobbytype"],
		mainMode = f43_local0[@"mainmode"],
	})
end
CoD.LobbyUtility.LobbyGoBack = function(f44_arg0, f44_arg1)
	local f44_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	f44_arg0:clearSavedState()
	local f44_local1 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.showSelect")
	if f44_local0[@"name"] == LuaEnum.UI.DIRECTOR_ONLINE and f44_local1:get() == false then
		Engine[@"setmodelvalue"](f44_local1, true)
		RefreshLobbyRoom(f44_arg0, f44_arg1)
		return
	end
	local f44_local2 = function(f45_arg0)
		Engine[@"lobbyevent"]("OnGoBack", {
			controller = f44_arg1,
			withParty = f45_arg0,
		})
	end
	if CoD.LobbyUtility.MapVoteTimerActive() and (f44_local0[@"hash_5558B67A321D1120"] == LuaEnum.TIMER_TYPE.MANUAL or f44_local0[@"hash_5558B67A321D1120"] == LuaEnum.TIMER_TYPE.MANUAL_CP or f44_local0[@"hash_5558B67A321D1120"] == LuaEnum.TIMER_TYPE.THEATER) then
		CoD.LobbyUtility.StopManualTimer(f44_arg1)
		return
	elseif f44_local0[@"hash_5558B67A321D1120"] == LuaEnum.TIMER_TYPE.AUTO_ZM and CoD.DirectorUtility.CanReadyDown(f44_arg1) then
		CoD.DirectorUtility.SetLocalClientsReady()
		return
	elseif IsZombies() and IsLobbyNetworkModeLAN() and IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.ShowDirectorCustom(f44_arg0, f44_arg1) and CoD.ZombieUtility.IsZMOfflineScreenStateCustomGame() then
		OpenSystemOverlay(f44_arg0, f44_arg0, f44_arg1, "LobbyLeaveZMOfflineCustom", nil)
		return
	elseif f44_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) then
		local f44_local3 = Engine[@"getglobalmodel"]()
		if f44_local3.lobbyRoot.publicLobby.stage:get() ~= LuaEnum.PUBLIC_LOBBY.INVALID and IsLobbyHostOfLobbyType(Enum[@"lobbytype"][@"lobby_type_private"]) then
			Engine[@"lobbyevent"]("OnLobbyClientLeftEvent", {
				controller = f44_arg1,
				withParty = LuaEnum.LEAVE_WITH_PARTY.WITH,
			})
			return
		end
	end
	if (f44_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f44_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING)) and IsLobbyHostOfLobbyType(Enum[@"lobbytype"][@"lobby_type_private"]) then
		f44_local2(LuaEnum.LEAVE_WITH_PARTY.WITH)
		return
	elseif f44_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) and not CoD.CTUtility.HasSeenMovie(f44_arg1, @"woods_outro") then
		local f44_local4, f44_local5, f44_local6 = CoD.CTUtility.GetOverallSpecialistProgress(f44_arg1)
		local f44_local7 = CoD.CTUtility.GetArchivesBundle()
		if f44_local5 and f44_local7[0x6F3C4D03C30332] ~= nil and f44_local7[0x6F3C4D03C30332] ~= "" and CoD.CTUtility.CanPlayVideo(f44_arg1, f44_local7[@"hash_3515E45AD81B9327"]) then
			CoD.CTUtility.PlaySkippableVideo(f44_arg1, f44_arg0, f44_local7[0x6F3C4D03C30332], f44_local7[@"hash_734B4156EBE6988B"] ~= 0, {
				onlySkippable = true,
				on_post_finished_movie_playback = function(f46_arg0, f46_arg1, f46_arg2)
					f44_local2(LuaEnum.LEAVE_WITH_PARTY.WITH)
				end,
			})
			CoD.CTUtility.SetSeenMovie(f44_arg1, "woods_outro")
			return
		end
	end
	local f44_local3 = CoD.LobbyUtility.ShowLeaveLobbyPopup(f44_local0)
	local f44_local4 = Engine[@"getglobalmodel"]()
	if f44_local0[@"id"] ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) and f44_local3 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY and Engine[@"getusedcontrollercount"]() == (f44_local4.lobbyRoot.lobbyList.playerCount:get() or 0) then
		f44_local3 = LuaEnum.LEAVE_LOBBY_POPUP.NONE
	end
	if f44_local3 > LuaEnum.LEAVE_LOBBY_POPUP.NONE_LEAVE_WITH_PARTY then
		if not CoD.isPC then
			CoD.OverlayUtility.CreateOverlay(f44_arg1, f44_arg0, "LobbyLeavePopup", f44_local3, f44_local0[@"name"])
		else
			CoD.OverlayUtility.CreateOverlay(f44_arg1, f44_arg0, "LeaveLobbyPopupPC", f44_local3, f44_local0[@"name"])
		end
	elseif f44_local3 == LuaEnum.LEAVE_LOBBY_POPUP.NONE_LEAVE_WITH_PARTY then
		f44_local2(LuaEnum.LEAVE_WITH_PARTY.WITH)
	else
		f44_local2(LuaEnum.LEAVE_WITH_PARTY.WITHOUT)
	end
end
local f0_local0 = function()
	local f47_local0 = nil
	if not IsLAN() and not Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"mode_game_matchmaking_manual"]) and not Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"hash_27B5630CD29180CB"]) then
		local f47_local1 = Engine[@"getplaylistinfobyid"](Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.playlistId")))
		local f47_local2 = Engine[@"getglobalmodel"]()
		if f47_local2.lobbyRoot.lobbyMainMode:get() == f47_local1.mainMode then
			f47_local0 = math.min(f47_local1.maxLocalPlayers, f47_local1.maxPartySize)
		else
			f47_local0 = Dvar[@"lobby_maxlocalplayers"]:get()
		end
	else
		f47_local0 = Dvar[@"lobby_maxlocalplayers"]:get()
	end
	if Engine[@"lobbygetgametype"]() == "ztutorial" then
		f47_local0 = 1
	end
	return f47_local0
end
CoD.LobbyUtility.GiveLeadership = function(f48_arg0, f48_arg1, f48_arg2)
	local f48_local0 = f48_arg0.MemberList
	if f48_local0 == nil then
		return
	elseif f48_arg1.id == "LUIList" then
		return
	else
		Engine[@"giveleadership"](f48_arg2, Enum[@"lobbytype"][@"lobby_type_private"], Engine[@"getmodelvalue"](f48_local0.listItems[f48_local0.firstIndex + f48_arg1.zeroBasedIndex]:getModel(f48_arg2, "xuid")))
	end
end
CoD.LobbyUtility.CanAddMoreBotsToLobby = function()
	local f49_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])
	return Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], f49_local0, Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]) + Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], f49_local0, Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_bot"]) < Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f49_local0)
end
CoD.LobbyUtility.SplitscreenControllersAllowed = function()
	if not IsLobbyHostOfLobbyType(Enum[@"lobbytype"][@"lobby_type_private"]) then
		return false
	elseif CoD.isPC then
		return false
	end
	local f50_local0 = Enum[@"lobbytype"][@"lobby_type_private"]
	if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		f50_local0 = Enum[@"lobbytype"][@"lobby_type_game"]
		if not IsLobbyHostOfLobbyType(f50_local0) then
			return false
		elseif not (not IsMultiplayer() or not IsLive() or Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"mode_game_matchmaking_manual"]) or Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"hash_27B5630CD29180CB"])) or IsZombies() and IsLive() and not Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"mode_game_matchmaking_manual"]) then
			return false
		elseif CompetitiveSettingsEnabled() then
			return false
		end
	end
	local f50_local1 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], f50_local0, Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	local f50_local2 = Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f50_local0)
	local f50_local3 = Engine[@"getusedcontrollercount"]()
	local f50_local4 = f0_local0()
	if f50_local3 >= 2 and f50_local0 == Enum[@"lobbytype"][@"lobby_type_game"] and f50_local1 + Engine[@"lobbyjoincount"]() ~= f50_local3 then
		return false
	else
		local f50_local5
		if f50_local1 >= f50_local2 or f50_local3 >= f50_local4 then
			f50_local5 = false
		else
			f50_local5 = true
		end
	end
	return f50_local5
end
CoD.LobbyUtility.UnusedGamepadButton = function(f51_arg0, f51_arg1)
	if not CoD.LobbyUtility.SplitscreenControllersAllowed() then
		return
	elseif not LuaUtils.LobbyProcessQueueEmpty() then
		return
	end
	local f51_local0 = Enum[@"lobbytype"][@"lobby_type_private"]
	if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		f51_local0 = Enum[@"lobbytype"][@"lobby_type_game"]
	end
	if not Engine[@"iscontrollerbeingused"](f51_arg1) then
		local f51_local1 = false
		local f51_local2 = Engine[@"signinlocalclient"](f51_arg1, f51_local0)
		if f51_local2 ~= nil then
			if f51_local2 == Enum[@"addlocalclientresult"][@"add_local_client_result_no_files_local"] then
				CoD.OverlayUtility.CreateOverlay(f51_arg1, f51_arg0, "LoadingProfile")
				f51_local1 = true
			elseif f51_local2 == Enum[@"addlocalclientresult"][@"add_local_client_result_no_files_live"] then
				CoD.OverlayUtility.CreateOverlay(f51_arg1, f51_arg0, "ConnectingToDemonware")
				f51_local1 = true
			elseif f51_local2 == Enum[@"addlocalclientresult"][@"hash_D883E9305361E58"] then
				f51_local1 = true
				return
			end
		end
		Engine[@"lobbyevent"]("OnClientSplitscreenSignin", {
			controller = f51_arg1,
		})
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_live"], "OnClientSplitscreenSignin fired for controller index" .. f51_arg1 .. ".\n")
		if IsLive() and not Engine[@"isuserguest"](f51_arg1) and not f51_local1 then
			CoD.OverlayUtility.CreateOverlay(f51_arg1, f51_arg0, "ConnectingToDemonware")
		end
	end
end
CoD.LobbyUtility.RemoveLocalPlayerFromTheLobby = function(f52_arg0, f52_arg1)
	Engine[@"setlocalclienttoinactive"](f52_arg1)
end
local f0_local1 = function(f53_arg0, f53_arg1)
	if CoD.isDurango and not IsLAN() and Engine[@"isuserguest"](1) then
		local f53_local0 = Engine[@"getplaylistinfobyid"](Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.playlistId")))
		if f53_local0.disableGuests then
			OpenGenericSmallPopup(f53_arg0, f53_arg1, Engine[@"hash_4F9F1239CFD921FE"](@"menu/warning"), Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C3209E08F133230"), nil, Engine[@"hash_4F9F1239CFD921FE"](@"menu/ok"))
			return true
		end
	end
	return false
end
local f0_local2 = function(f54_arg0, f54_arg1)
	local f54_local0 = Engine[@"getusedcontrollercount"]()
	local f54_local1 = f0_local0()
	if f54_local1 < f54_local0 then
		OpenGenericSmallPopup(f54_arg0, f54_arg1, Engine[@"hash_4F9F1239CFD921FE"](@"menu/warning"), Engine[@"hash_4F9F1239CFD921FE"](@"hash_6128045808A178F3", f54_local1), nil, Engine[@"hash_4F9F1239CFD921FE"](@"menu/ok"))
		return true
	else
		return false
	end
end
CoD.LobbyUtility.LaunchGame = function(f55_arg0, f55_arg1, f55_arg2)
	local f55_local0 = {
		controller = f55_arg1,
		lobbyType = f55_arg2,
	}
	if not f0_local2(f55_arg0, f55_arg1) then
		Engine[@"lobbyevent"]("OnLaunchGame", f55_local0)
	end
end
CoD.LobbyUtility.StartSearch = function(f56_arg0, f56_arg1, f56_arg2)
	local f56_local0 = {
		controller = f56_arg2,
	}
	if not f0_local2(f56_arg1, f56_arg2) and not f0_local1(f56_arg1, f56_arg2) and CoD.DirectorUtility.PrepareSearchPlaylistModels(f56_arg0, f56_arg2) then
		Engine[@"lobbyevent"]("OnAsyncMatchmakingStart", f56_local0)
	end
end
CoD.LobbyUtility.LaunchDemo = function(f57_arg0, f57_arg1, f57_arg2)
	local f57_local0 = {
		controller = f57_arg1,
		lobbyType = f57_arg2,
	}
	if not f0_local2(f57_arg0, f57_arg1) then
		Engine[@"lobbyevent"]("OnLaunchDemo", f57_local0)
	end
end
CoD.LobbyUtility.SetPlaylistName = function(f58_arg0, f58_arg1)
	local f58_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyPlaylist")
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f58_local0, "name"), Engine[@"toupper"](f58_arg0))
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f58_local0, "kickerText"), f58_arg1 or 0x0)
end
CoD.LobbyUtility.GetActivityString = function(f59_arg0)
	for f59_local7, f59_local8 in pairs(CoD.LobbyUtility.LeaderActivity) do
		if f59_local8.index == f59_arg0 then
			if f59_arg0 == CoD.LobbyUtility.LeaderActivity.WAITING_TO_SELECT.index then
				local f59_local3 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.hostGamertag")
				local f59_local4 = nil
				if f59_local3 ~= nil then
					f59_local4 = Engine[@"getmodelvalue"](f59_local3)
				end
				if f59_local4 ~= nil then
					local f59_local5 = LobbyData.GetCurrentMenuTarget()
					if f59_local5[@"name"] == LuaEnum.UI.DIRECTOR_ONLINE then
						if f59_local4 == "" then
							return Engine[@"hash_4F9F1239CFD921FE"](f59_local8.str)
						else
							local f59_local6 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.showSelect")
							if f59_local6:get() then
								return Engine[@"hash_4F9F1239CFD921FE"](f59_local8.select, f59_local4)
							else
								return Engine[@"hash_4F9F1239CFD921FE"](f59_local8.main, f59_local4)
							end
						end
					end
				end
			end
			return Engine[@"hash_4F9F1239CFD921FE"](@"menu/party_leader", Engine[@"localize"](f59_local8.str))
		end
	end
	return ""
end
CoD.LobbyUtility.LeaderActivityInit = function()
	local f60_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	local f60_local1 = Enum[@"lobbytype"][@"lobby_type_private"]
	if f60_local0[@"lobbytype"] then
		f60_local1 = f60_local0[@"lobbytype"]
	end
	if f60_local1 == Enum[@"lobbytype"][@"lobby_type_invalid"] then
		return
	else
		CoD.LobbyUtility.LeaderActivityChanged(nil, {
			lobbyType = f60_local1,
			activity = 0,
		})
		CoD.LobbyUtility.ResetLeaderActivity(Engine[@"getprimarycontroller"]())
	end
end
CoD.LobbyUtility.LeaderActivityChanged = function(f61_arg0, f61_arg1)
	local f61_local0 = Engine[@"createmodel"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot"), "leaderActivity")
	if Engine[@"islobbyhost"](f61_arg1.lobbyType) then
		Engine[@"setmodelvalue"](f61_local0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_173E87C1D2E33FA4"))
	elseif Engine[@"lobbyconnectedtodedicatedhost"]() == true then
		Engine[@"setmodelvalue"](f61_local0, Engine[@"hash_4F9F1239CFD921FE"](@"menu/dedicated"))
	else
		Engine[@"setmodelvalue"](f61_local0, CoD.LobbyUtility.GetActivityString(f61_arg1.activity))
	end
	return true
end
CoD.LobbyUtility.SetLeaderActivity = function(f62_arg0, f62_arg1)
	local f62_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])
	if not Engine[@"isanylocalclientleader"](f62_local0) then
		return
	elseif f62_arg1 ~= nil then
		Engine[@"setleaderactivity"](f62_arg0, f62_local0, f62_arg1.index)
	else
		Engine[@"setleaderactivity"](f62_arg0, f62_local0, 0)
	end
end
CoD.LobbyUtility.ResetLeaderActivity = function(f63_arg0)
	local f63_local0 = LobbyData.GetCurrentMenuTarget()
	if f63_local0[@"name"] == LuaEnum.UI.DIRECTOR_ONLINE then
		CoD.LobbyUtility.SetLeaderActivity(f63_arg0, CoD.LobbyUtility.LeaderActivity.WAITING_TO_SELECT)
		return
	else
		CoD.LobbyUtility.SetLeaderActivity(f63_arg0, CoD.LobbyUtility.LeaderActivity.READY)
	end
end
CoD.LobbyUtility.OpenFindMatch = function(f64_arg0, f64_arg1, f64_arg2)
	CoD.LobbyUtility.SetLeaderActivity(f64_arg1, CoD.LobbyUtility.LeaderActivity.VIEWING_PLAYLISTS)
	CoD.PlaylistCategoryFilter = "playermatch"
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f64_arg0, f64_arg2 or "PlaylistSelection", f64_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f64_arg1)
	end)
end
CoD.LobbyUtility.OpenCompetitivePlaylist = function(f66_arg0, f66_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f66_arg1, CoD.LobbyUtility.LeaderActivity.VIEWING_PLAYLISTS)
	CoD.PlaylistCategoryFilter = "arenamatch"
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f66_arg0, "Competitive_Playlist", f66_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f66_arg1)
	end)
end
CoD.LobbyUtility.OpenFreerunMapSelection = function(f68_arg0, f68_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f68_arg1, CoD.LobbyUtility.LeaderActivity.CHOOSING_MAP)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f68_arg0, "Freerun_ChangeMap", f68_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f68_arg1)
	end)
end
CoD.LobbyUtility.OpenMPLobbyLeaderboard = function(f70_arg0, f70_arg1)
	if not Engine[@"getplaylistinfobyid"](Engine[@"getplaylistid"]()) then
		return
	end
	CoD.perController[f70_arg1].isInLobbyLeaderboard = true
	local f70_local0 = ""
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "combatRecordMode"), "mp")
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "leaderboardCategoryName"), f70_local0)
	local f70_local1 = "LB_MP_GM_" .. Engine[@"toupper"](Engine[@"lobbygetgametype"]())
	if f70_local0 == "hardcore" then
		f70_local1 = f70_local1 .. "_HC"
	end
	SetGlobalModelValue("leaderboardDef", f70_local1)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f70_arg0, "Leaderboard_GameMode", f70_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f70_arg1)
		CoD.perController[f70_arg1].isInLobbyLeaderboard = false
	end)
end
CoD.LobbyUtility.OpenArenaMasterLeaderboards = function(f72_arg0, f72_arg1)
	local f72_local0 = Engine[@"getcurrentarenaslot"]()
	if f72_local0 < 0 then
		return
	else
		local f72_local1 = 0
		local f72_local2 = "LB_MP_ARENA_MASTERS_0" .. tostring(f72_local0)
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "combatRecordMode"), "mp")
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "leaderboardCategoryName"), "arena")
		CoD.LeaderboardUtility.LeaderboardGameModeButtonPrepare(f72_arg1)
		SetGlobalModelValue("leaderboardDef", f72_local2)
		LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f72_arg0, "Leaderboard_GameMode", f72_arg1), "close", function()
			CoD.LobbyUtility.ResetLeaderActivity(f72_arg1)
		end)
	end
end
CoD.LobbyUtility.GoToFindingGames = function(f74_arg0, f74_arg1)
	local f74_local0 = Engine[@"getmodename"]()
	f74_local0 = f74_local0:lower()
	if f74_local0 == "Invalid" then
		Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lobby"], "GoToFindingGames: Invalid mode in matchmaking, Engine.@GetModeName() == 'Invalid'.\n")
		return
	else
		NavigateToLobby_SelectionList(f74_arg0, nil, f74_arg1.controller, "online_" .. f74_local0 .. "_public", f74_arg0)
		return true
	end
end
CoD.LobbyUtility.OpenTheaterSelectFilm = function(f75_arg0, f75_arg1)
	CoD.FileshareUtility.InitModels()
	OpenOverlay(f75_arg0, "Theater_SelectFilm", f75_arg1)
end
CoD.LobbyUtility.OpenCAC = function(f76_arg0, f76_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f76_arg1, CoD.LobbyUtility.LeaderActivity.MODIFYING_CAC)
	Engine[@"playsound"]("cac_enter_cac")
	CoD.CACUtility.SetDefaultCACRoot(f76_arg1)
	if IsClassSetsAvailableForCurrentGameMode() then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f76_arg1), "currentClassSetIndex"), Engine[@"getcurrentclasssetindex"](f76_arg1))
		CopyLoadoutFromClassSet(f76_arg1)
	else
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f76_arg1), "currentClassSetIndex"), 0)
	end
	CoD.CACUtility.ValidateMPLootWeapons(f76_arg1)
	LUI.OverrideFunction_CallOriginalFirst(CoD.CACUtility.OpenCACMenu(f76_arg0, f76_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f76_arg1)
	end)
end
CoD.LobbyUtility.OpenScorestreaks = function(f78_arg0, f78_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f78_arg1, CoD.LobbyUtility.LeaderActivity.MODIFYNG_REWARDS)
	LUI.OverrideFunction_CallOriginalFirst(OpenPopup(f78_arg0, "Scorestreaks", f78_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f78_arg1)
	end)
end
CoD.LobbyUtility.OpenDirectorLoadoutsWithCurrentSessionMode = function(f80_arg0, f80_arg1)
	local f80_local0 = Engine[@"getglobalmodel"]()
	local f80_local1 = LuaUtils.GetEModeForLobbyMainMode(f80_local0["lobbyRoot.lobbyMainMode"]:get())
	if not f80_local1 then
		f80_local1 = Engine[@"currentsessionmode"]()
	end
	local f80_local2 = "MPCustomizeClassMenu"
	if f80_local1 == Enum[@"emodes"][@"mode_zombies"] then
		f80_local2 = "ZMCustomizeClassMenu"
	end
	OpenOverlay(f80_arg0, f80_local2, f80_arg1, {
		_sessionMode = f80_local1,
	})
end
CoD.LobbyUtility.OpenDirectorScorestreaks = function(f81_arg0, f81_arg1)
	OpenOverlay(f81_arg0, "SupportSelection", f81_arg1, {
		_sessionMode = Enum[@"emodes"][@"mode_multiplayer"],
	})
end
CoD.LobbyUtility.OpenDirectorCodcasterSettings = function(f82_arg0, f82_arg1)
	OpenOverlay(f82_arg0, "DirectorCodCasterSettings", f82_arg1)
end
CoD.LobbyUtility.OpenOverlayByName = function(f83_arg0, f83_arg1, f83_arg2, f83_arg3)
	OpenOverlay(f83_arg0, f83_arg2, f83_arg1, f83_arg3)
end
CoD.LobbyUtility.OpenTest = function(f84_arg0, f84_arg1)
	local f84_local0 = OpenPopup(f84_arg0, "MarketplaceTest", f84_arg1)
end
CoD.LobbyUtility.OpenBarracks = function(f85_arg0, f85_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f85_arg1, CoD.LobbyUtility.LeaderActivity.VIEWING_PLAYERCARD)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f85_arg0, "Barracks", f85_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f85_arg1)
	end)
end
CoD.LobbyUtility.OpenMegaChewFactory = function(f87_arg0, f87_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f87_arg1, CoD.LobbyUtility.LeaderActivity.AT_MEGACHEW_FACTORY)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f87_arg0, "MegaChewFactory", f87_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f87_arg1)
	end)
end
CoD.LobbyUtility.OpenChooseCharacterLoadout = function(f89_arg0, f89_arg1, f89_arg2)
	CoD.LobbyUtility.SetLeaderActivity(f89_arg1, CoD.LobbyUtility.LeaderActivity.MODIFYING_HERO)
	if f89_arg2 ~= LuaEnum.CHOOSE_CHARACTER_OPENED_FROM.FIRST_TIME then
		SetFirstTimeSetupComplete_MP(nil, nil, f89_arg1, nil, nil)
	end
	local f89_local0 = OpenOverlay(f89_arg0, "ChooseCharacterLoadout", f89_arg1, f89_arg2)
	LUI.OverrideFunction_CallOriginalFirst(f89_local0, "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f89_arg1)
	end)
	return f89_local0
end
CoD.LobbyUtility.OpenPersonalizeCharacter = function(f91_arg0, f91_arg1)
	NavigateToMenu(f91_arg0, "ChoosePersonalizationCharacter", true, f91_arg1)
end
CoD.LobbyUtility.OpenChoosePositionLoadout = function(f92_arg0, f92_arg1, f92_arg2)
	CoD.LobbyUtility.SetLeaderActivity(f92_arg1, CoD.LobbyUtility.LeaderActivity.MODIFYING_HERO)
	local f92_local0 = OpenOverlay(f92_arg0, "PositionsLoadout", f92_arg1, f92_arg2)
	LUI.OverrideFunction_CallOriginalFirst(f92_local0, "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f92_arg1)
	end)
	return f92_local0
end
CoD.LobbyUtility.OpenChangeMap = function(f94_arg0, f94_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f94_arg1, CoD.LobbyUtility.LeaderActivity.CHOOSING_MAP)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f94_arg0, "ChangeMap", f94_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f94_arg1)
	end)
end
CoD.LobbyUtility.SetLeaderActivityAndOpenOverlay = function(f96_arg0, f96_arg1, f96_arg2, f96_arg3)
	CoD.LobbyUtility.SetLeaderActivity(f96_arg1, f96_arg2)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f96_arg0, f96_arg3, f96_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f96_arg1)
	end)
end
CoD.LobbyUtility.SetLeaderActivityAndOpenOverlayNoDeps = function(f98_arg0, f98_arg1, f98_arg2, f98_arg3)
	CoD.LobbyUtility.SetLeaderActivity(f98_arg1, f98_arg2)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f98_arg0, f98_arg3, f98_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f98_arg1)
	end)
end
CoD.LobbyUtility.OpenSetupGame = function(f100_arg0, f100_arg1, f100_arg2)
	OpenPopup(f100_arg0, f100_arg2, f100_arg1)
end
CoD.LobbyUtility.OpenChangeGameMode = function(f101_arg0, f101_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f101_arg1, CoD.LobbyUtility.LeaderActivity.CHOOSING_GAME_MODE)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f101_arg0, "ChangeGameMode", f101_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f101_arg1)
	end)
end
CoD.LobbyUtility.OpenEditGameRules = function(f103_arg0, f103_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f103_arg1, CoD.LobbyUtility.LeaderActivity.EDITING_GAME_RULES)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f103_arg0, "GameSettings_Main", f103_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f103_arg1)
	end)
end
CoD.LobbyUtility.OpenBotSettings = function(f105_arg0, f105_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f105_arg1, CoD.LobbyUtility.LeaderActivity.SETTING_UP_BOTS)
	LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f105_arg0, "CustomGames_BotSettingsPopup", f105_arg1), "close", function()
		CoD.LobbyUtility.ResetLeaderActivity(f105_arg1)
	end)
end
CoD.LobbyUtility.AddLobbyBot = function(f107_arg0, f107_arg1)
	local f107_local0 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f107_local1 = Enum[@"lobbytype"][@"lobby_type_game"]
	if not f107_local0 then
		f107_local1 = Enum[@"lobbytype"][@"lobby_type_private"]
	end
	if Engine[@"islobbyhost"](f107_local1) then
		Engine[@"addlobbybot"](f107_local1, 1, false, 0)
	end
end
CoD.LobbyUtility.RemoveLobbyBot = function(f108_arg0, f108_arg1)
	local f108_local0 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f108_local1 = Enum[@"lobbytype"][@"lobby_type_game"]
	if not f108_local0 then
		f108_local1 = Enum[@"lobbytype"][@"lobby_type_private"]
	end
	if Engine[@"islobbyhost"](f108_local1) then
		Engine[@"removelobbybot"](f108_local1, 1)
	end
end
CoD.LobbyUtility.RemoveAllLobbyBots = function(f109_arg0)
	local f109_local0 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f109_local1 = Enum[@"lobbytype"][@"lobby_type_game"]
	if not f109_local0 then
		f109_local1 = Enum[@"lobbytype"][@"lobby_type_private"]
	end
	if Engine[@"islobbyhost"](f109_local1) then
		local f109_local2 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], f109_local1, Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_bot"])
		if f109_local2 > 0 then
			Engine[@"removelobbybot"](f109_local1, f109_local2)
		end
	end
end
CoD.LobbyUtility.OpenOptions = function(f110_arg0, f110_arg1)
	Engine[@"execnow"](f110_arg1, "disableallclients")
	Engine[@"execnow"](f110_arg1, "setclientbeingusedandprimary")
	OpenPopup(f110_arg0, "OptionsMenu", f110_arg1)
end
CoD.LobbyUtility.OpenQuit = function(f111_arg0, f111_arg1)
	OpenMenu(f111_arg0, "QuitPopup", f111_arg1)
end
CoD.LobbyUtility.OpenWeaponBuildKits = function(f112_arg0, f112_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f112_arg1, CoD.LobbyUtility.LeaderActivity.MODIFYING_WEAPON_BUILD_KITS)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f112_arg1), "Gunsmith.Mode"), Enum[@"gunsmithmode"][@"gunsmithmode_weaponlist"])
	local f112_local0 = CoD.CraftUtility.Gunsmith.ParseDDL(f112_arg1, "cacRoot")
	local f112_local1 = CoD.CraftUtility.Paintjobs.ParseDDL(f112_arg1, Enum[@"storagefiletype"][@"storage_paintjobs"])
	if not f112_local0 then
		return
	elseif IsLobbyNetworkModeLive() and not f112_local1 then
		return
	else
		LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f112_arg0, "WeaponBuildKitsCategorySelect", f112_arg1), "close", function()
			CoD.LobbyUtility.ResetLeaderActivity(f112_arg1)
		end)
	end
end
CoD.LobbyUtility.InitOverheadNamesPreLobby = function(f114_arg0, f114_arg1, f114_arg2)
	f114_arg2:setupOverheadNameContainer()
	local f114_local0 = CoD.DirectorCharacterDynamic
	if f114_local0 then
		local f114_local1 = CoD.PlayerRoleUtility.MAX_SUPPORTED_LOBBY_CLIENTS
		for f114_local2 = 0, f114_local1 - 1, 1 do
			local f114_local5 = f114_local0.new(f114_arg0, f114_arg1, 0, 0, 0, f114_local0.__defaultWidth, 0, 0, 0, f114_local0.__defaultHeight)
			f114_local5:subscribeToGlobalModel(f114_arg1, "LobbyClients", f114_local2 + 1, function(model)
				f114_local5:setModel(model, f114_arg1)
			end)
			f114_local5:setupOverheadNameFrontend(f114_local2)
			f114_arg2:addElement(f114_local5)
			f114_arg0:sendInitializationEvents(f114_arg1, f114_local5)
		end
	end
end
CoD.LobbyUtility.InitOverheadNamesZM = function(f116_arg0, f116_arg1, f116_arg2)
	f116_arg2:setupOverheadNameContainer()
	local f116_local0 = CoD.DirectorCharacterZM
	if f116_local0 then
		local f116_local1 = CoD.PlayerRoleUtility.MAX_SUPPORTED_LOBBY_CLIENTS
		for f116_local2 = 0, f116_local1 - 1, 1 do
			local f116_local5 = f116_local0.new(f116_arg0, f116_arg1, 0, 0, 0, f116_local0.__defaultWidth, 0, 0, 0, f116_local0.__defaultHeight)
			f116_local5:subscribeToGlobalModel(f116_arg1, "LobbyClients", f116_local2 + 1, function(model)
				f116_local5:setModel(model, f116_arg1)
			end)
			f116_local5:setupOverheadNameFrontend(f116_local2)
			f116_arg2:addElement(f116_local5)
			f116_arg0:sendInitializationEvents(f116_arg1, f116_local5)
		end
	end
end
CoD.LobbyUtility.LobbyMapVoteSelectNext = function(f118_arg0, f118_arg1)
	CoD.LobbyUtility.LobbyMapVoteSelect(f118_arg0, f118_arg1, Enum[@"lobbymapvote"][@"lobby_mapvote_next"])
end
CoD.LobbyUtility.LobbyMapVoteSelectPrevious = function(f119_arg0, f119_arg1)
	CoD.LobbyUtility.LobbyMapVoteSelect(f119_arg0, f119_arg1, Enum[@"lobbymapvote"][@"lobby_mapvote_previous"])
end
CoD.LobbyUtility.LobbyMapVoteSelectRandom = function(f120_arg0, f120_arg1)
	CoD.LobbyUtility.LobbyMapVoteSelect(f120_arg0, f120_arg1, Enum[@"lobbymapvote"][@"lobby_mapvote_random"])
end
CoD.LobbyUtility.LobbyMapVoteSelect = function(f121_arg0, f121_arg1, f121_arg2)
	local f121_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"])
	Engine[@"playsound"]("uin_map_vote")
	Engine[@"mapvoteselect"](f121_arg1, f121_local0, f121_arg2)
end
CoD.LobbyUtility.SetMapVoteSelectedStateOnClipOver = function(f122_arg0, f122_arg1, f122_arg2)
	f122_arg0._originalClipOver = f122_arg0.m_eventHandlers.clip_over
	f122_arg0:registerEventHandler("clip_over", function(element, event)
		if not element.nextClip and not IsSelfInState(element, f122_arg2) and CoD.LobbyUtility.ShouldSetMapVoteStateToSelectedMap(element) then
			SetState(element, f122_arg2, f122_arg1)
		end
		element:_originalClipOver(event)
		element:registerEventHandler("clip_over", LUI.UIElement.clipOver)
	end)
end
CoD.LobbyUtility.ShouldSetMapVoteStateToSelectedMap = function(f124_arg0)
	if not IsSelfInState(f124_arg0, "SelectedMap") and CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN) and (IsSelfInState(f124_arg0, "MapVoteChosenNext") or IsSelfInState(f124_arg0, "MapVoteChosenPrevious") or IsSelfInState(f124_arg0, "MapVoteChosenRandom")) then
		return true
	else
		return false
	end
end
CoD.LobbyUtility.MapVoteInState = function(f125_arg0)
	local f125_local0 = Engine[@"getglobalmodel"]()
	local f125_local1 = f125_local0["lobbyRoot.mapVote"]
	if not f125_local1 then
		return false
	end
	local f125_local2 = f125_local0["lobbyRoot.lobbyNav"].get(f125_local0["lobbyRoot.lobbyNav"])
	if f125_local2 then
		local f125_local3 = LobbyData.GetLobbyMenuByID(f125_local2)
		if f125_local3[@"lobbytype"] ~= Enum[@"lobbytype"][@"lobby_type_game"] and f125_local3[@"lobbytype"] ~= Enum[@"lobbytype"][@"lobby_type_private"] then
			return false
		end
	end
	return tonumber(f125_arg0) == f125_local1:get()
end
CoD.LobbyUtility.MapVotePreviousSelectable = function()
	if not CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.VOTING) then
		return false
	end
	local f126_local0 = Enum[@"lobbymodule"][@"lobby_module_client"]
	if Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"]) then
		f126_local0 = Enum[@"lobbymodule"][@"lobby_module_host"]
	end
	if Engine[@"getplaylistprevcount"](f126_local0, Engine[@"lobbygetcontrollinglobbysession"](f126_local0)) >= Dvar[@"lobbymapvoteprevmapplaycount"]:get() then
		return false
	end
	return true
end
CoD.LobbyUtility.MapVoteTimerActive = function()
	local f127_local0 = Engine[@"getglobalmodel"]()
	f127_local0 = f127_local0["MapVote.timerActive"]
	if not f127_local0 then
		return false
	end
	local f127_local1 = LobbyData.GetLobbyMenuByID(LobbyData.GetLobbyNav())
	if f127_local1[@"hash_5558B67A321D1120"] == LuaEnum.TIMER_TYPE.TESTING then
		return false
	end
	local f127_local2 = f127_local0:get()
	local f127_local3
	if f127_local2 == nil or f127_local2 == 0 then
		f127_local3 = false
	else
		f127_local3 = true
	end
	return f127_local3
end
CoD.LobbyUtility.LobbyTeamSelection = function(f128_arg0, f128_arg1, f128_arg2, f128_arg3, f128_arg4)
	if f128_arg3 == nil then
		f128_arg3 = 0
	end
	Engine[@"lobbyevent"]("OnSwitchTeam", {
		controller = f128_arg1,
		selection = f128_arg2,
		xuid = f128_arg3,
		lobbyClientType = f128_arg4,
	})
end
CoD.LobbyUtility.LobbySetTeam = function(f129_arg0, f129_arg1)
	Engine[@"teamselection"](f129_arg0, Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]), f129_arg1)
end
CoD.LobbyUtility.LobbyLANServerBrowserFilterUpdateEvent = function(f130_arg0, f130_arg1)
	local f130_local0 = Engine[@"lobbyserverlistgetmainmodefilter"]()
	local f130_local1 = "all"
	if f130_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_cp"] then
		f130_local1 = "cp"
	elseif f130_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] then
		f130_local1 = "mp"
	elseif f130_local0 == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"] then
		f130_local1 = "zm"
	end
	f130_arg0.currentFilter = f130_local1
	f130_arg0:processEvent({
		name = "filter_mode_changed",
		controller = f130_arg1,
	})
end
CoD.LobbyUtility.LobbyLANServerBrowserSetMainModeFilter = function(f131_arg0, f131_arg1, f131_arg2)
	local f131_local0 = f131_arg1:getModel()
	f131_local0 = f131_local0.filter:get()
	if Dvar[@"ui_execdemo_cp"]:get() == true then
		f131_local0 = Enum[@"lobbymainmode"][@"lobby_mainmode_cp"]
	end
	Engine[@"lobbyserverlistsetmainmodefilter"](f131_local0)
	CoD.LobbyUtility.LobbyLANServerBrowserFilterUpdateEvent(f131_arg0, f131_arg2)
end
CoD.LobbyUtility.SetSpinnerActive = function(f132_arg0)
	CoD.Menu.SpinnerIsActive = f132_arg0
end
CoD.LobbyUtility.MainPreLoad = function(f133_arg0)
	f133_arg0.anyControllerAllowed = true
	f133_arg0.unusedControllerAllowed = true
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.platformUpdate"), true)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.beginPlay"), Enum[@"lobbynetworkmode"][@"lobby_networkmode_invalid"])
	if Engine[@"lobbyremovealllocalsplitscreenclient"] then
		Engine[@"lobbyremovealllocalsplitscreenclient"]()
	end
end
CoD.LobbyUtility.KoreaRatings_AlreadyOpened = function()
	return Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.shownKoreaRatings") ~= nil
end
CoD.LobbyUtility.SetupStartPopups = function(f135_arg0, f135_arg1)
	local f135_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.startPopups")
	local f135_local1 = 0
	local f135_local2
	if Dvar[@"motd_enabled"]:get() and not CoD.MOTDUtility.MOTD_AlreadyOpened() then
		local f135_local3 = Dvar[@"hash_6CC0AD043B9FD789"]:exists()
		local f135_local4 = Dvar[@"hash_6CC0AD043B9FD789"]
		local f135_local5 = f135_local4
		f135_local4 = f135_local4.get
		local f135_local6 = f135_local4(f135_local5)
		f135_local2 = LuaEnum
		f135_local2 = f135_local4.START_POPUPS
		f135_local2 = f135_local4.MOTD
		f135_local1 = 1 << f135_local2
	end
	local f135_local4 = f135_local3 and f135_local6 or f135_local2
	f135_local2 = Engine
	f135_local4[@"setmodelvalue"](f135_local0, f135_local1)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.startBitsToFetch"), Engine[@"numbertouint64"](1) << Engine[@"numbertouint64"](Enum[@"connectivitytypes"][@"hash_CA1833D94AE73C0"]))
end
CoD.LobbyUtility.SetupPostPopups = function(f136_arg0, f136_arg1)
	local f136_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.postPopups")
	local f136_local1 = 0
	if Dvar[@"motd_enabled"]:get() and not CoD.MOTDUtility.MOTD_AlreadyOpened() and Dvar[@"hash_6CC0AD043B9FD789"]:exists() and Dvar[@"hash_6CC0AD043B9FD789"]:get() then
		f136_local1 = 1 << LuaEnum.POST_POPUPS.MOTD
	end
	if CoD.isPC and CoD.PCKoreaUtility.IsInKorea() then
		f136_local1 = f136_local1 | 1 << LuaEnum.START_POPUPS.KoreaRating
	end
	Engine[@"setmodelvalue"](f136_local0, f136_local1)
end
CoD.LobbyUtility.MainPostLoad = function(f137_arg0, f137_arg1)
	CoD.LobbyUtility.RegisterEventHandlers(f137_arg0)
	if Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive") == nil then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.spinnerActive", true), false)
	end
	Engine[@"disableallclients"]()
	CoD.LobbyUtility.EndPlay()
	CoD.LobbyUtility.SetupStartPopups(f137_arg0, f137_arg1)
	CoD.LobbyUtility.SetupPostPopups(f137_arg0, f137_arg1)
	local f137_local0 = function(f138_arg0, f138_arg1, f138_arg2, f138_arg3)
		local f138_local0 = {
			controller = f138_arg2,
			navToMenu = "director",
		}
		if LuaUtils.LobbyProcessQueueEmpty() and Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			Engine[@"playsound"]("uin_splashscreen_exit")
			Engine[@"lobbyevent"]("OnGoForward", f138_local0)
		end
	end
	local f137_local1 = function(f139_arg0, f139_arg1, f139_arg2, f139_arg3)
		if IsDpadButton(f139_arg3) then
			f137_local0(f139_arg0, f139_arg1, f139_arg2, f139_arg3)
		end
	end
	local f137_local2 = 0
	local f137_local3 = function(f140_arg0, f140_arg1, f140_arg2, f140_arg3)
		if Engine[@"issignedintolive"](f140_arg2) then
			f137_local0(f140_arg0, f140_arg1, f140_arg2, f140_arg3)
		elseif f137_local2 > 3 then
			CoD.DirectorUtility.LoadPlaylistFileFromLPC()
			f137_local2 = 0
		else
			f137_local2 = f137_local2 + 1
		end
	end
	local f137_local4 = 0
	local f137_local5 = function(f141_arg0, f141_arg1, f141_arg2, f141_arg3)
		if Engine[@"issignedintolive"](f141_arg2) then
			f137_local0(f141_arg0, f141_arg1, f141_arg2, f141_arg3)
		elseif f137_local4 > 3 then
			CoD.DirectorUtility.LoadFFOTDFileFromLPC()
			f137_local4 = 0
		else
			f137_local4 = f137_local4 + 1
		end
	end
	Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav")
	f137_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"), function(model)
		if Engine[@"getmodelvalue"](model) ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			NavigateToMenu(f137_arg0, "Director", true, f137_arg1)
		end
	end, false)
	f137_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "pubstorageFilesChanged"), function(model)
		if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) then
			return
		elseif Engine[@"getmodelvalue"](model) == true then
			CoD.OverlayUtility.OpenPublisherFilesChangedOverlay(f137_arg1, f137_arg0)
		end
	end, false)
	f137_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.beginPlay"), function(model)
		f137_local0(nil, nil, f137_arg1, nil)
	end, false)
	f137_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.showPopup"), function(model)
		local f145_local0 = Engine[@"getglobalmodel"]()
		f145_local0 = f145_local0["lobbyRoot.startPopups"]
		local f145_local1 = f145_local0:get()
		if CoD.BitUtility.IsBitSet(f145_local0:get(), LuaEnum.START_POPUPS.MOTD) then
			if CoD.MOTDUtility.MOTD_ShouldShowMOTD(f137_arg1) then
				f145_local0:set(CoD.BitUtility.ClearBit(f145_local1, LuaEnum.START_POPUPS.MOTD))
				Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.shownMOTD")
				CoD.MOTDUtility.MOTD_OpenMOTDPopup(f137_arg0, nil, f137_arg1, true, f137_arg0)
				return
			end
			f145_local0:set(CoD.BitUtility.ClearBit(f145_local1, LuaEnum.START_POPUPS.MOTD))
		end
		if IsBooleanDvarSet(@"hash_3AA4F815BA2261") and CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(f137_arg0, f137_arg1, "PromoEvent") then
			return
		elseif f145_local0:get() == 0 and Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			Engine[@"lobbyevent"]("OnGoForward", {
				controller = f137_arg1,
				navToMenu = "director",
			})
		end
	end, false)
	f137_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.showPostPopup"), function(model)
		local f146_local0 = Engine[@"getglobalmodel"]()
		f146_local0 = f146_local0["lobbyRoot.postPopups"]
		local f146_local1 = f146_local0:get()
		if CoD.BitUtility.IsBitSet(f146_local0:get(), LuaEnum.POST_POPUPS.MOTD) then
			if CoD.MOTDUtility.MOTD_ShouldShowMOTD(f137_arg1) then
				if not CoD.isPC then
					f146_local0:set(CoD.BitUtility.ClearBit(f146_local1, LuaEnum.POST_POPUPS.MOTD))
				elseif CoD.MOTDUtility.MOTD_AlreadyOpened() then
					return
				end
				Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.shownMOTD")
				CoD.MOTDUtility.MOTD_OpenMOTDPopup(f137_arg0, nil, f137_arg1, true, f137_arg0)
				return
			end
			f146_local0:set(CoD.BitUtility.ClearBit(f146_local1, LuaEnum.POST_POPUPS.MOTD))
		end
		if CoD.BitUtility.IsBitSet(f146_local1, LuaEnum.START_POPUPS.KoreaRating) then
			if CoD.PCKoreaUtility.IsInKorea() then
				if not CoD.LobbyUtility.KoreaRatings_AlreadyOpened() then
					Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.shownKoreaRatings")
					local f146_local2 = f137_arg0:openPopup("PC_Korea_Bootsequence_Rating", f137_arg1)
				end
				return
			end
			startPopUpsModel:set(CoD.BitUtility.ClearBit(f146_local1, LuaEnum.START_POPUPS.KoreaRating))
		end
		if IsBooleanDvarSet(@"hash_3AA4F815BA2261") and CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(f137_arg0, f137_arg1, "PromoEvent") then
			return
		elseif f146_local0:get() == 0 and Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			Engine[@"lobbyevent"]("OnGoForward", {
				controller = f137_arg1,
				navToMenu = "director",
			})
		end
	end, false)
	f137_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "mainFirstTimeFlowComplete"), function(model)
		local f147_local0 = Engine[@"getmodelvalue"](model)
		CloseAllOccludingMenus(f137_arg0, f137_arg1)
		f137_local0(nil, nil, f137_arg1, nil)
	end, false)
	f137_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.closePopups"), function(model)
		local f148_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.FFOTDShutdown"))
		if f148_local0 == nil or f148_local0 == false then
			CloseAllOccludingMenus(f137_arg0, f137_arg1)
		end
	end, false)
	Engine[@"sendclientscriptnotify"](f137_arg1, "menu_change" .. CoD.GetLocalClientAdjustedNum(f137_arg1), {
		menu = "Main",
		status = "closeToMenu",
	})
	f137_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.room"), function(model)
		RefreshLobbyRoom(f137_arg0, f137_arg1)
	end)
	local f137_local6 = function()
		return false
	end
	f137_arg0.pcQuitOverlayActive = false
	local f137_local7 = function(f151_arg0, f151_arg1, f151_arg2, f151_arg3)
		OpenPCQuit(f137_arg0, f151_arg1, f151_arg0, f151_arg2)
	end
	if LuaDefine.isPC then
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, f137_local7, f137_local6, false)
	else
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_left"], nil, f137_local1, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_up"], nil, f137_local1, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_right"], nil, f137_local1, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_down"], nil, f137_local1, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_start"], "ui_confirm", f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_lb"], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_rb"], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_lstick_pressed"], nil, f137_local3, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[@"luibutton"][@"lui_key_rstick_pressed"], nil, f137_local5, f137_local6, false)
	end
	f137_arg0.handleMouseButton = true
	local f137_local8 = function()
		f137_arg0.launchInvitesHotJoinTimer = nil
		Engine[@"liveplatformsessionenableinvitehotjoin"]()
	end
	local f137_local9 = function(f153_arg0)
		if Engine[@"iscinematicplaying"]() then
			return
		elseif Engine[@"hash_2FFC1C70C8D5B359"]() and not f137_arg0.__authErrorShown then
			LuaUtils.UI_ShowErrorMessageDialog(f137_arg1, Engine[0xA771C266E4512D](), "")
			f137_arg0.__authErrorShown = true
		end
		if Engine[@"hash_34D07729ED48730D"]() then
			f137_arg0.launchSignInTimer:close()
			f137_arg0.ConnectionLabel.lblConnecting:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_227BE553CE368A05"))
			if not Engine[@"hash_2FFC1C70C8D5B359"]() then
				local f153_local0 = Engine[@"hash_40B6B0577E345DA"](f137_arg1)
				if f153_local0 <= 0 then
					f153_local0 = Engine[@"hash_B559CD5AFE03E74"](f137_arg1)
				end
				if f153_local0 > 0 then
					LuaUtils.UI_ShowErrorMessageDialog(f137_arg1, Engine[@"hash_4F9F1239CFD921FE"](@"hash_29E217C1FA1920C2", f153_local0), "")
				end
			end
		end
		local f153_local0 = Engine[@"hash_28E117182481F32E"]()
		local f153_local1 = Engine[@"getplayerqueueinfo"](f137_arg1)
		local f153_local2 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f137_arg1), "PCConnectionQueue")
		local f153_local3 = Engine[@"createmodel"](f153_local2, "IsInConnectionQueue")
		local f153_local4 = f153_local3
		f153_local3 = f153_local3.set
		local f153_local5
		if not f153_local1.queued or f153_local1.position <= 0 then
			f153_local5 = f153_local0
		else
			f153_local5 = true
		end
		f153_local3(f153_local4, f153_local5)
		if f153_local0 then
			f153_local3 = Engine[@"createmodel"](f153_local2, "ConnectionQueuePosition")
			f153_local3:set(Engine[@"hash_4A2EB0EF477CB10C"]())
			f153_local3 = Engine[@"createmodel"](f153_local2, "ConnectionQueueRemainingtime")
			f153_local3:set(Engine[@"hash_7A1A5ED0AB5889C"]())
		elseif f153_local1.queued then
			f153_local3 = Engine[@"createmodel"](f153_local2, "ConnectionQueuePosition")
			f153_local3:set(f153_local1.position)
			f153_local3 = Engine[@"createmodel"](f153_local2, "ConnectionQueueRemainingtime")
			f153_local3:set(f153_local1.estimatedWaitTimeSec)
		end
		if Engine[@"issignedintolive"](f137_arg1) or CoD.LobbyUtility.ForceOffline() then
			if Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) and not f137_arg0.pcQuitOverlayActive then
				f137_arg0.launchSignInTimer:close()
				f137_arg0.ConnectionLabel:playClip("DefaultClip")
				f137_arg0.ConnectionLabel.lblConnecting:setText(LocalizeToUpperString(@"menu/connected_dw"))
				Engine[@"lobbyevent"]("OnGoForward", {
					controller = f137_arg1,
					navToMenu = "director",
				})
			end
		else
			f153_local3 = Engine[@"getglobalmodel"]()
			f153_local3 = f153_local3:create("FreshRestartOccurred", true)
			if f153_local3:get() then
				f137_arg0.ConnectionLabel.lblConnecting:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_227BE553CE368A05"))
			end
		end
	end
	local f137_local10 = 0
	if LuaDefine.isPS4 == true and true == Dvar[@"platformsessionlaunchinvitejoinprocessdelay"]:exists() then
		f137_local10 = Dvar[@"platformsessionlaunchinvitejoinprocessdelay"]:get()
	end
	if not f137_arg0.launchInvitesHotJoinTimer and not Engine[@"liveplatformsessioncanprocesslaunchdata"]() then
		f137_arg0.launchInvitesHotJoinTimer = LUI.UITimer.newElementTimer(f137_local10, true, f137_local8)
		f137_arg0:addElement(f137_arg0.launchInvitesHotJoinTimer)
	end
	if LuaDefine.isPC and not f137_arg0.launchSignInTimer then
		f137_arg0.launchSignInTimer = LUI.UITimer.newElementTimer(400, false, f137_local9)
		f137_arg0:addElement(f137_arg0.launchSignInTimer)
	end
	if LuaDefine.isPC and Engine[@"hash_34D07729ED48730D"]() then
		f137_arg0.ConnectionLabel.lblConnecting:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_227BE553CE368A05"))
	end
end
CoD.LobbyUtility.SetTextToDurangoSignedInString = function(f154_arg0, f154_arg1)
	f154_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "durango.signedInGamertag", true), function(model)
		if model ~= nil then
			local f155_local0 = Engine[@"getmodelvalue"](model)
			if f155_local0 ~= nil and string.len(f155_local0) > 0 then
				f154_arg1:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1FAACA5179AA8A57", f155_local0))
				return
			end
		end
		f154_arg1:setText("")
	end)
end
CoD.LobbyUtility.UpdateOfficialCustomGame = function(f156_arg0, f156_arg1, f156_arg2)
	Engine[@"lobbyhostsetofficialcustomgame"](Engine[@"lobbygetcontrollinglobbysession"](f156_arg1), f156_arg2)
end
CoD.LobbyUtility.SocialMainPreLoad = function(f157_arg0, f157_arg1)
	local f157_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "SocialMainMenu")
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f157_local0, "anyChildSelected"), false)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f157_local0, "managePartyButtonText"), "")
	f157_arg0:setModel(f157_local0, f157_arg1)
	f157_arg0.disableLeaderChangePopupShutdown = true
	if not IsInGame() then
		SendClientScriptMenuChangeNotify(f157_arg1, f157_arg0, true)
	end
end
CoD.LobbyUtility.DisbandParty = function(f158_arg0, f158_arg1, f158_arg2)
	local f158_local0 = LobbyData.GetLobbyMenuByID(f158_arg2)
	GoBack(f158_arg0, f158_arg1)
	if f158_local0[@"backtarget"] == LuaEnum.UI.MAIN then
		for f158_local1 = 1, Engine[@"getmaxcontrollercount"]() - 1, 1 do
			LobbyRemoveLocalClientFromLobby(f158_arg0, f158_local1)
		end
	end
	Engine[@"lobbyevent"]("OnManagePartyLeave", {
		controller = f158_arg1,
	})
end
CoD.OverlayUtility.AddAutoDetectOverlay("LobbyLeavePopup", {
	title = function(f159_arg0)
		local f159_local0 = 0x0
		if f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY then
			f159_local0 = @"hash_5B69F71ABEAEC777"
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			f159_local0 = @"hash_E6679EE5787CB48"
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY then
			f159_local0 = @"hash_4318119895303B4B"
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			f159_local0 = @"hash_5B69F71ABEAEC777"
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE then
			f159_local0 = @"hash_4318119895303B4B"
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			f159_local0 = @"hash_27992FB2AE130417"
		end
		return Engine[@"hash_4F9F1239CFD921FE"](f159_local0)
	end,
	description = function(f160_arg0)
		local f160_local0 = 0x0
		if f160_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY then
			f160_local0 = @"hash_B543EF9A1104B6E"
		elseif f160_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			f160_local0 = @"hash_6EF7BFBB3912534B"
		elseif f160_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			f160_local0 = @"hash_B543EF9A1104B6E"
		elseif f160_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			f160_local0 = @"hash_2E47086DBA25578E"
		end
		return Engine[@"hash_4F9F1239CFD921FE"](f160_local0)
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	postCreateStep = function(f161_arg0, f161_arg1)
		f161_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyLockedIn"), function(model)
			if Engine[@"getmodelvalue"](model) == true then
				GoBack(f161_arg0, f161_arg1)
			end
		end)
		f161_arg0:subscribeToModel(Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.publicLobby.stage"), function(model)
			if LuaUtils.IsArenaPublicGame() and Engine[@"getmodelvalue"](model) == LuaEnum.PUBLIC_LOBBY.START_MATCH then
				GoBack(f161_arg0, f161_arg1)
			end
		end)
	end,
	getGoBackFn = function(f164_arg0, f164_arg1)
		return function(f165_arg0, f165_arg1)
			if f164_arg0 == nil then
				GoBack(f165_arg0, f165_arg1)
				return
			else
				GoBackAndLeaveParty(f165_arg0, f165_arg1, f164_arg0)
			end
		end
	end,
	options = function(f166_arg0, f166_arg1)
		local f166_local0 = {}
		if f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = @"hash_34BE8031E505109A",
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = @"hash_3EA3B4895763DFF0",
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = @"hash_F420F9DB5188F96",
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT, f166_arg1),
				text = @"hash_5ACDE687F90ACD0B",
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITH),
				text = @"hash_27D920DBE7BE3E1D",
			})
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = @"hash_7C57347FF991141",
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			table.insert(f166_local0, {
				action = function(f167_arg0, f167_arg1)
					GoBack(f167_arg0, f167_arg1)
					Engine[@"lobbyevent"]("OnManagePartyLeave", {
						controller = f167_arg1,
					})
				end,
				text = @"hash_5349737B0BDAA763",
			})
		end
		table.insert(f166_local0, {
			action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(nil),
			text = @"hash_6E4E9924A266D1FC",
			isCancelOption = true,
		})
		return f166_local0
	end,
})
DataSourceHelpers.GlobalDataSourceSetup("EULA", "eula", function(f168_arg0)
	local f168_local0 = f168_arg0:create("CurrentEULAPage")
	f168_local0:set(1)
	f168_arg0:create("MaxEULAPage")
	f168_local0 = f168_arg0:create("CurrentEULAScreen")
	f168_local0:set(1)
	f168_local0 = f168_arg0:create("SawAllPages")
	f168_local0:set(false)
end, false)
DataSources.PCEULAOptions = DataSourceHelpers.ListSetup("PCEULAOptions", function(f169_arg0)
	local f169_local0 = {}
	local f169_local1 = function(f170_arg0, f170_arg1, f170_arg2)
		CoD.LobbyUtility.DeclineEULA(f170_arg0, f170_arg1, f170_arg2)
	end
	table.insert(
		f169_local0,
		CoD.LobbyUtility.packageEULAButtonData(@"menu/accept", @"hash_0", nil, function(f171_arg0, f171_arg1, f171_arg2)
			CoD.LobbyUtility.AcceptEULA(f171_arg0, f171_arg2)
		end, function(f172_arg0, f172_arg1, f172_arg2)
			local f172_local0 = DataSources.EULA.getModel(f172_arg2)
			local f172_local1 = f172_local0.CurrentEULAScreen:get()
			if f172_local1 > #CoD.LobbyUtility.EULAEnum then
				return true
			else
				local f172_local2 = CoD.LobbyUtility.EULAEnum[f172_local1].disableAcceptUntilReadFct
				if not (f172_local2 and f172_local2()) then
					return false
				else
					return not f172_local0.SawAllPages:get()
				end
			end
		end)
	)
	table.insert(f169_local0, CoD.LobbyUtility.packageEULAButtonData(@"menu/decline", @"hash_0", nil, f169_local1))
	return f169_local0
end, true)
CoD.LobbyUtility.packageEULAButtonData = function(f173_arg0, f173_arg1, f173_arg2, f173_arg3, f173_arg4)
	return {
		models = {
			displayText = f173_arg0,
			description = f173_arg1,
			currentText = f173_arg2,
			disabledFunction = f173_arg4,
		},
		properties = {
			action = f173_arg3,
		},
	}
end
CoD.LobbyUtility.LoadPage = function(f174_arg0, f174_arg1)
	local f174_local0 = DataSources.EULA.getModel(f174_arg1)
	f174_local0 = f174_local0.CurrentEULAPage:get()
	for f174_local4, f174_local5 in ipairs(f174_arg0.__entries) do
		if f174_local4 <= #f174_arg0.__pages[f174_local0].entries then
			f174_local5:setText(Engine[@"hash_4F9F1239CFD921FE"](f174_arg0.__pages[f174_local0].entries[f174_local4]))
		else
			f174_local5:setText("")
		end
	end
end
CoD.LobbyUtility.ShouldForceReadAllPages = function()
	return CoD.isPC
end
CoD.LobbyUtility.EULAEnum = {}
CoD.LobbyUtility.EULAEnum[1] = {
	prefix = "",
	stringTable = @"eula",
	header = @"hash_431BE80D5236D780",
	declinePopup = "DeclineEULA",
	disableAcceptUntilReadFct = nil,
}
CoD.LobbyUtility.EULAEnum[2] = {
	prefix = "KPI_",
	stringTable = @"hash_7A0BA87EFF24E71A",
	header = @"hash_4E1564E44E03C6CD",
	declinePopup = "DeclineKPIEULA",
	forKorea = true,
	disableAcceptUntilReadFct = CoD.LobbyUtility.ShouldForceReadAllPages,
}
CoD.LobbyUtility.EULAEnum[3] = {
	prefix = "KPIO_",
	stringTable = @"hash_7A0BA87EFF24E71A",
	header = @"hash_4E1FAC29E6397460",
	declinePopup = "DeclineKPIOEULA",
	forKorea = true,
	disableAcceptUntilReadFct = CoD.LobbyUtility.ShouldForceReadAllPages,
}
CoD.LobbyUtility.InitializeEULA = function(f176_arg0, f176_arg1, f176_arg2)
	if f176_arg0 == nil then
		f176_arg0 = f176_arg2.eulaBody
	end
	local f176_local0 = DataSources.EULA.getModel(f176_arg1)
	f176_local0.CurrentEULAPage:set(1)
	local f176_local1 = f176_local0.CurrentEULAScreen:get()
	if f176_arg2.Header then
		f176_arg2.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.LobbyUtility.EULAEnum[f176_local1].header))
	end
	if not f176_arg0.__entries then
		f176_arg0.__entries = {}
	end
	local f176_local2 = {}
	local f176_local3 = nil
end
CoD.LobbyUtility.SetPlayerLocation = function(f177_arg0, f177_arg1)
	Engine[@"hash_61D2E041DAB54785"](f177_arg0, Enum[@"lobbytype"][@"lobby_type_private"], f177_arg1)
end
CoD.LobbyUtility.AllMembersInFrontend = function()
	local f178_local0 = Enum[@"lobbymodule"][@"lobby_module_client"]
	local f178_local1 = Enum[@"lobbytype"][@"lobby_type_private"]
	local f178_local2 = Engine[@"lobbygetsessionclients"](f178_local0, f178_local1)
	local f178_local3 = Engine[@"hash_E00882E35AF63D2"](f178_local0, f178_local1)
	for f178_local7, f178_local8 in pairs(f178_local2.sessionClients) do
		local f178_local9 = f178_local3.partyLocations[f178_local8.clientNum + 1]
		if f178_local9 ~= nil and f178_local9 ~= Enum[@"hash_C0AB9543C5C440B"][@"hash_6755065F5A0B7FB0"] then
			return false
		end
	end
	return true
end
CoD.LobbyUtility.AllMembersCanRedeploy = function()
	local f179_local0 = Enum[@"lobbymodule"][@"lobby_module_client"]
	local f179_local1 = Enum[@"lobbytype"][@"lobby_type_private"]
	local f179_local2 = Engine[@"lobbygetsessionclients"](f179_local0, f179_local1)
	local f179_local3 = Engine[@"hash_E00882E35AF63D2"](f179_local0, f179_local1)
	for f179_local7, f179_local8 in pairs(f179_local2.sessionClients) do
		local f179_local9 = f179_local3.partyLocations[f179_local8.clientNum + 1]
		if f179_local9 ~= nil and f179_local9 ~= Enum[@"hash_C0AB9543C5C440B"][@"hash_6755065F5A0B7FB0"] and f179_local9 ~= Enum[@"hash_C0AB9543C5C440B"][@"hash_B4603B82CB82E77"] and f179_local9 ~= Enum[@"hash_C0AB9543C5C440B"][@"hash_49B478094C85DBBB"] then
			return false
		end
	end
	return true
end
CoD.LobbyUtility.IsFirstEULAPage = function(f180_arg0)
	local f180_local0 = DataSources.EULA.getModel(f180_arg0)
	return f180_local0.CurrentEULAPage:get() == 1
end
CoD.LobbyUtility.IsLastEULAPage = function(f181_arg0)
	local f181_local0 = DataSources.EULA.getModel(f181_arg0)
	return f181_local0.CurrentEULAPage:get() == f181_local0.MaxEULAPage:get()
end
CoD.LobbyUtility.IsPregameLobby = function()
	local f182_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav")
	local f182_local1 = f182_local0 and Engine[@"getmodelvalue"](f182_local0)
	if f182_local1 then
		local f182_local2 = {}
		local f182_local3 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME)
		local f182_local4 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME)
		local f182_local5 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME)
		local f182_local6 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PREGAME)
		return LuaUtils.FindItemInArray(f182_local3, f182_local1)
	else
		return false
	end
end
CoD.LobbyUtility.SetEULAPageText = function(f183_arg0, f183_arg1)
	local f183_local0 = DataSources.EULA.getModel(f183_arg1)
	f183_arg0:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A205700391CF3AD", f183_local0.CurrentEULAPage:get(), f183_local0.MaxEULAPage:get()))
end
CoD.LobbyUtility.NextEULAPage = function(f184_arg0, f184_arg1, f184_arg2)
	local f184_local0 = DataSources.EULA.getModel(f184_arg2)
	f184_local0 = f184_local0.CurrentEULAPage
	if f184_local0:get() < #f184_arg0.eulaBody.__pages then
		f184_local0:set(f184_local0:get() + 1)
		CoD.LobbyUtility.LoadPage(f184_arg0.eulaBody, f184_arg2)
		if f184_local0:get() == #f184_arg0.eulaBody.__pages then
			local f184_local1 = DataSources.EULA.getModel(f184_arg2)
			f184_local1.SawAllPages:set(true)
		end
	end
	if CoD.isPC then
		CoD.LobbyUtility.SetEULAPageText(f184_arg0.PCEULAPages.pageText, f184_arg2)
	end
end
CoD.LobbyUtility.PreviousEULAPage = function(f185_arg0, f185_arg1, f185_arg2)
	local f185_local0 = DataSources.EULA.getModel(f185_arg2)
	f185_local0 = f185_local0.CurrentEULAPage
	if f185_local0:get() > 1 then
		f185_local0:set(f185_local0:get() - 1)
		CoD.LobbyUtility.LoadPage(f185_arg0.eulaBody, f185_arg2)
	end
	if CoD.isPC then
		CoD.LobbyUtility.SetEULAPageText(f185_arg0.PCEULAPages.pageText, f185_arg2)
	end
end
CoD.LobbyUtility.OpenFTUEGameIntroductionOverlay = function(f186_arg0)
	local f186_local0 = Engine[@"getglobalmodel"]()
	f186_local0 = f186_local0:create("lobbyRoot.lobbyVMCreateOverlayController")
	f186_local0:set(f186_arg0)
	f186_local0 = Engine[@"getglobalmodel"]()
	f186_local0 = f186_local0:create("lobbyRoot.lobbyVMCreateOverlay")
	if not f186_local0:set("FTUEGameIntroduction") then
		f186_local0:forceNotifySubscriptions()
	end
end
CoD.LobbyUtility.AcceptEULA = function(f187_arg0, f187_arg1)
	if CoD.isPC then
		local f187_local0 = nil
		local f187_local1 = DataSources.EULA.getModel(f187_arg1)
		f187_local1 = f187_local1.CurrentEULAScreen
		local f187_local2 = f187_local1:get()
		repeat
			f187_local2 = f187_local2 + 1
			f187_local0 = CoD.LobbyUtility.EULAEnum[f187_local2]
		until not f187_local0 or f187_local0.forKorea and CoD.PCKoreaUtility.IsInKorea()
		f187_local1:set(f187_local2)
		if f187_local0 then
			CoD.LobbyUtility.InitializeEULA(nil, f187_arg1, f187_arg0)
			return
		end
	end
	if Engine[@"hash_5CB675CA7856DA25"]() and CoD.CoDAccountUtility.IsTrialAccountFeatureEnabled() and CoD.CoDAccountUtility.IsAccountFeatureEnabled(f187_arg1) then
		if CoD.isPC then
			CoD.PCUtility.LockUIShortcutInput(f187_arg0, f187_arg1)
		end
		OpenOverlay(f187_arg0, "StartMenu_Options_CoDAccount_CTA", f187_arg1, {
			_signInRequired = true,
		})
	else
		CoD.LobbyUtility.OpenFTUEGameIntroductionOverlay(f187_arg1)
	end
end
CoD.LobbyUtility.DeclineEULA = function(f188_arg0, f188_arg1, f188_arg2)
	local f188_local0 = DataSources.EULA.getModel(f188_arg2)
	local f188_local1 = CoD.LobbyUtility.EULAEnum[f188_local0.CurrentEULAScreen:get()]
	if f188_local1 then
		OpenSystemOverlay(f188_arg0, f188_arg1, f188_arg2, f188_local1.declinePopup, nil)
	end
end
CoD.LobbyUtility.CompleteFTUEIntro = function(f189_arg0, f189_arg1)
	if not CoD.isPC or not CoD.PCKoreaUtility.ShowKorea15Plus() then
		CoD.BaseUtility.InitControllerModel(f189_arg1, "PlayerSettingsUpdate", "")
		OpenPopup(f189_arg0, "DirectorFirstTimeContentWarning", f189_arg1)
	else
		CoD.LobbyUtility.CompleteFirstTimeContentWarning(f189_arg0, f189_arg1)
	end
end
CoD.LobbyUtility.CompleteFirstTimeContentWarning = function(f190_arg0, f190_arg1)
	if CoD.isPC then
		CoD.LobbyUtility.CompleteFirstTimeSafeArea(f190_arg0, f190_arg1)
	else
		OpenPopup(f190_arg0, "DirectorFirstTimeSafeArea", f190_arg1)
	end
end
CoD.LobbyUtility.CompleteFirstTimeSafeArea = function(f191_arg0, f191_arg1)
	if CoD.isPC then
		CoD.LobbyUtility.CompleteFirstTimeFlow(f191_arg0, f191_arg1)
	else
		OpenPopup(f191_arg0, "FirstTimeBrightnessSetting", f191_arg1)
	end
end
CoD.LobbyUtility.SetEmblemBackground_Internal = function(f192_arg0, f192_arg1)
	Engine[@"emblemselectbackground"](f192_arg1)
	if IsLive() and not IsUserContentRestricted(f192_arg0) then
		CoD.perController[f192_arg0].uploadProfile = true
		Engine[@"hash_34A08EAF3D9417A"](f192_arg0)
		local f192_local0 = CoD.BlackMarketTableUtility.LootInfoLookup(f192_arg0, CoD.BlackMarketUtility.GetLootBackgroundName(f192_arg0, f192_arg1), nil)
		if f192_local0 and f192_local0.isLoot and f192_local0.itemId then
			Engine[0xDE279ECDDDD966](f192_arg0, @"hash_74F639DE6E9A6066", {
				[@"loot_id"] = f192_local0.itemId,
			})
		end
	else
		Engine[@"setprofilevar"](f192_arg0, "default_background_index", f192_arg1)
		Engine[@"hash_22D0B221710560E9"](f192_arg0, f192_arg1)
	end
end
CoD.LobbyUtility.CompleteFirstTimeBrightness = function(f193_arg0, f193_arg1)
	CoD.LobbyUtility.CompleteFirstTimeFlow(f193_arg0, f193_arg1)
end
CoD.LobbyUtility.CompleteFirstTimeFlow = function(f194_arg0, f194_arg1)
	SetProfileVar(f194_arg1, "com_first_time", 0)
	local f194_local0 = Engine[@"getmodelforcontroller"](f194_arg1)
	f194_local0 = f194_local0:create("defaultBackgroundNeeded")
	f194_local0 = f194_local0:get()
	if f194_local0 then
		CoD.LobbyUtility.SetEmblemBackground_Internal(f194_arg1, f194_local0)
	end
	UpdateGamerprofile(f194_arg0, f194_arg0, f194_arg1)
	Engine[@"liveplatformsessionenableinvitehotjoin"]()
	local f194_local1 = Engine[@"getglobalmodel"]()
	f194_local1.lobbyRoot.closePopups:forceNotifySubscriptions()
	ForceNotifyGlobalModel(f194_arg1, "mainFirstTimeFlowComplete")
end
CoD.LobbyUtility.IsPlayerInMyParty = function(f195_arg0)
	local f195_local0 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	for f195_local4, f195_local5 in ipairs(f195_local0.sessionClients) do
		if f195_local5.xuid == f195_arg0 then
			return true
		end
	end
	return false
end
CoD.OverlayUtility.AddAutoDetectOverlay("DeclineEULA", {
	title = @"hash_3DAE50568F833334",
	description = @"hash_353558889BC2A324",
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	options = function()
		return {
			{
				action = GoBack,
				text = @"menu/ok",
				isCancelOption = true,
			},
			{
				action = function()
					Engine[@"exec"](Engine[@"getprimarycontroller"](), "quit")
				end,
				text = @"menu/quit",
			},
		}
	end,
})
CoD.OverlayUtility.AddAutoDetectOverlay("DeclineKPIEULA", {
	title = @"hash_7847E0849B2BD127",
	description = @"hash_1499380188085A83",
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	options = function()
		return {
			{
				action = GoBack,
				text = @"menu/ok",
				isCancelOption = true,
			},
			{
				action = function()
					Engine[@"exec"](Engine[@"getprimarycontroller"](), "quit")
				end,
				text = @"menu/quit",
			},
		}
	end,
})
CoD.OverlayUtility.AddAutoDetectOverlay("DeclineKPIOEULA", {
	title = @"hash_51F231B2C83CEA54",
	description = @"hash_5828AE232A499144",
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	options = function()
		return {
			{
				action = GoBack,
				text = @"menu/ok",
				isCancelOption = true,
			},
			{
				action = function()
					Engine[@"exec"](Engine[@"getprimarycontroller"](), "quit")
				end,
				text = @"menu/quit",
			},
		}
	end,
})
CoD.LobbyUtility.Presence = {}
CoD.LobbyUtility.Presence.Strings = {
	[Enum[@"presencetitle"][@"hash_51CF21FD793411B9"]] = @"hash_7FD86E09666FBFFC",
	[Enum[@"presencetitle"][@"hash_7A2184EBB293AF2D"]] = @"hash_13C11BD55E8A933E",
	[Enum[@"presencetitle"][@"hash_6C14960E60DA36B7"]] = @"hash_53AE1A6F98E3D0B8",
	[Enum[@"presencetitle"][@"hash_669F9F19327AE3B3"]] = @"hash_73520ACF1FF88175",
	[Enum[@"presencetitle"][@"hash_253A911F86DD9C9B"]] = @"hash_4C78AC016652D8A5",
	[Enum[@"presencetitle"][@"hash_39D5EE7754ABD279"]] = @"hash_492CA8D296218C2C",
	[Enum[@"presencetitle"][@"hash_AA283B8037DC205"]] = @"hash_2C79EA24AB1A2BA",
	[Enum[@"presencetitle"][@"hash_2F7D12CD08D8C65C"]] = @"hash_73520ACF1FF88175",
	[Enum[@"presencetitle"][@"hash_7846A99A50CCC84E"]] = @"hash_73520ACF1FF88175",
	[Enum[@"presencetitle"][@"hash_5A4492C005EC75F0"]] = @"hash_640D245780AD8EFF",
	[Enum[@"presencetitle"][@"hash_54E2503E9D4B69C0"]] = @"hash_4C78AC016652D8A5",
	[Enum[@"presencetitle"][@"hash_6AE25F6D4C969F9E"]] = @"hash_492CA8D296218C2C",
	[Enum[@"presencetitle"][@"hash_4BCCA43B72FB5208"]] = @"hash_12103511DF6266F5",
	[Enum[@"presencetitle"][@"hash_29416FBBD255A16A"]] = @"hash_3CC924B73B51D3BD",
	[Enum[@"presencetitle"][@"hash_6F94CFF7D3FA72DC"]] = @"hash_163C97056B8E55C4",
	[Enum[@"presencetitle"][@"hash_9AFD04B89B9744E"]] = @"hash_7AE563A7A5B0AB2D",
	[Enum[@"presencetitle"][@"hash_5064020050B6D74"]] = @"hash_76F3647A52E50BDB",
	[Enum[@"presencetitle"][@"hash_69CA1B7DCE359D28"]] = @"hash_26481DE3D57CE651",
	[Enum[@"presencetitle"][@"hash_3E35ED0592F0886A"]] = @"hash_135D9608916969B3",
	[Enum[@"presencetitle"][@"hash_43DDB5074B337D14"]] = @"hash_73520ACF1FF88175",
	[Enum[@"presencetitle"][0x48AC07729D7006]] = @"hash_73520ACF1FF88175",
	[Enum[@"presencetitle"][@"hash_270200988C735128"]] = @"hash_640D245780AD8EFF",
	[Enum[@"presencetitle"][@"hash_2487C6ABC12117D8"]] = @"hash_4C78AC016652D8A5",
	[Enum[@"presencetitle"][@"hash_2F5DADE95366AFF6"]] = @"hash_492CA8D296218C2C",
	[Enum[@"presencetitle"][@"hash_FD787C9BCCFE500"]] = @"hash_12103511DF6266F5",
	[Enum[@"presencetitle"][@"hash_2322CC5E9D503B12"]] = 0xE906EBFDA3FF04,
	[Enum[@"presencetitle"][@"hash_436C3C9302013104"]] = @"hash_74A6A1D33B52A740",
	[Enum[@"presencetitle"][@"hash_74871D036CE76516"]] = @"hash_275B35B49A96EFDA",
	[Enum[@"presencetitle"][@"hash_23458C8FB915CDC"]] = @"hash_76F3647A52E50BDB",
	[Enum[@"presencetitle"][@"hash_555B49B47C060CDE"]] = @"hash_73520ACF1FF88175",
	[Enum[@"presencetitle"][@"hash_13B9C9B68663386E"]] = @"hash_4C78AC016652D8A5",
	[Enum[@"presencetitle"][@"hash_5F21EC063EDFC550"]] = @"hash_492CA8D296218C2C",
	[Enum[@"presencetitle"][@"hash_6252AA84DE65D0E2"]] = @"hash_2C79EA24AB1A2BA",
	[Enum[@"presencetitle"][@"hash_4CD26F398D441822"]] = @"hash_2C79EA24AB1A2BA",
	[Enum[@"presencetitle"][@"hash_24FB5F3E62DDDF50"]] = @"hash_6D5F01774DFDA821",
	[Enum[@"presencetitle"][@"hash_3A117D3D5821AF0A"]] = @"hash_76F3647A52E50BDB",
	[Enum[@"presencetitle"][@"hash_273359042AA77776"]] = @"hash_7AAB6370A22F9E55",
	[Enum[@"presencetitle"][@"hash_8C64A84CA98015B"]] = @"hash_88B5B64AD126EDE",
	[Enum[@"presencetitle"][@"hash_4FB997F24F594F52"]] = @"hash_1218D47DD1A2EE91",
	[Enum[@"presencetitle"][@"hash_F202C4DB22E15DE"]] = @"hash_492CA8D296218C2C",
	[Enum[@"presencetitle"][@"hash_2B076B46FC30D568"]] = @"hash_624D4DF6975546DD",
	[Enum[@"presencetitle"][@"hash_3BDCE30A7024A319"]] = @"hash_6D91FECC419D0400",
	[Enum[@"presencetitle"][@"hash_7A1D6A588ADE03B0"]] = @"hash_4981253B1F6E0BA1",
	[Enum[@"presencetitle"][0x1E7C2C9963D2B4]] = @"hash_76F3647A52E50BDB",
	[Enum[@"presencetitle"][@"hash_689F4CB04C20BE96"]] = @"hash_624D4DF6975546DD",
	[Enum[@"presencetitle"][@"hash_51F2CBBDAF02CDFB"]] = @"hash_7ACC1029BFF9174E",
	[Enum[@"presencetitle"][@"hash_3AA08BA358D14172"]] = @"hash_3243160288C38B7D",
	[Enum[@"presencetitle"][@"hash_786162EAB3E6939C"]] = @"hash_73520ACF1FF88175",
	[Enum[@"presencetitle"][@"hash_242CB93800EAED30"]] = @"hash_640D245780AD8EFF",
	[Enum[@"presencetitle"][@"hash_45E4D2D4F9A91A00"]] = @"hash_4C78AC016652D8A5",
	[Enum[@"presencetitle"][@"hash_1F2F56EC63267A1C"]] = @"hash_44413BDC981E0771",
	[Enum[@"presencetitle"][0x162324AB992F8E]] = @"hash_6D5F01774DFDA821",
	[Enum[@"presencetitle"][@"hash_4CC36D9470CB113F"]] = 0xFEBD7559DBB565,
	[Enum[@"presencetitle"][@"hash_4F69882510317719"]] = @"hash_2CE604E6624429F1",
	[Enum[@"presencetitle"][@"hash_61F17820D60C1F7A"]] = 0x21903C9A98D92F,
	[Enum[@"presencetitle"][@"hash_560BE5FE42385C84"]] = @"hash_B9F19808502EFE9",
	[Enum[@"presencetitle"][@"hash_162EDA3666404E5D"]] = @"hash_3B93203A76233CE0",
	[Enum[@"presencetitle"][@"hash_46C12798671429E7"]] = @"hash_452D3959032D935E",
	[Enum[@"presencetitle"][@"hash_572BAB5AA810756E"]] = @"hash_83AA94BEC077E03",
	[Enum[@"presencetitle"][@"hash_F7B2CBB47A1ED07"]] = @"hash_4B11E3D5271BE6B4",
	[Enum[@"presencetitle"][@"hash_3F1310916FF8A442"]] = @"hash_2BB8EB52A843649",
}
CoD.LobbyUtility.Presence.ActivityStrings = {}
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_offline"]] = @"hash_2C79EA24AB1A2BA"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_online_not_in_title"]] = @"hash_2C79EA24AB1A2BA"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_menu_inlobby"]] = @"hash_73520ACF1FF88175"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_menu_looking_for_party"]] = @"hash_92A0F337939C195"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_menu_looking_for_players"]] = @"hash_3B305AF9F0693803"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_menu_local"]] = @"hash_6D5F01774DFDA821"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_menu_start"]] = @"hash_53AE1A6F98E3D0B8"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_playing_coop_on_map"]] = @"hash_61A908EC9526CC29"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_playing_solo_on_map"]] = @"hash_61A908EC9526CC29"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_playing_coop_in_safehouse"]] = @"hash_2F9E775C80FA4687"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_playing_solo_in_safehouse"]] = @"hash_4EF88B1188106EC9"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_in_lobby"]] = @"hash_73520ACF1FF88175"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_watching_film"]] = @"hash_76F3647A52E50BDB"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_looking_for_party"]] = @"hash_92A0F337939C195"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_looking_for_players"]] = @"hash_3B305AF9F0693803"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_cp_playing_local"]] = @"hash_6D5F01774DFDA821"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_mp_playing_gmode_on_map"]] = 0xE906EBFDA3FF04
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_mp_in_lobby"]] = @"hash_73520ACF1FF88175"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_mp_watching_film"]] = @"hash_76F3647A52E50BDB"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_mp_looking_for_party"]] = @"hash_92A0F337939C195"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_mp_looking_for_players"]] = @"hash_3B305AF9F0693803"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_mp_playing_local"]] = @"hash_6D5F01774DFDA821"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_zm_playing_map_on_round"]] = @"hash_7252D497455C5FA9"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_zm_in_lobby"]] = @"hash_73520ACF1FF88175"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_zm_watching_film"]] = @"hash_76F3647A52E50BDB"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_zm_looking_for_party"]] = @"hash_92A0F337939C195"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_zm_looking_for_players"]] = @"hash_3B305AF9F0693803"
CoD.LobbyUtility.Presence.ActivityStrings[Enum[@"presenceactivity"][@"presence_activity_zm_playing_local"]] = @"hash_6D5F01774DFDA821"
CoD.LobbyUtility.Presence.StickyLobbyStrings = {}
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[@"hash_C0AB9543C5C440B"][@"hash_7A084EA6923C3B80"]] = @"hash_6B83F54F0B0CE513"
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[@"hash_C0AB9543C5C440B"][@"hash_6FA6FA0C00230DEE"]] = @"hash_2D1FA62620BF6CEF"
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[@"hash_C0AB9543C5C440B"][@"hash_49B478094C85DBBB"]] = @"hash_2372605BCEEE5BA6"
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[@"hash_C0AB9543C5C440B"][@"hash_B4603B82CB82E77"]] = 0xDDA6F3E65A0982
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[@"hash_C0AB9543C5C440B"][@"hash_6755065F5A0B7FB0"]] = @"hash_12E37D5A62344333"
CoD.LobbyUtility.Presence.ContextStrings = {}
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_unknown"]] = @"hash_2C79EA24AB1A2BA"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_menu_mode_select"]] = @"hash_2C79EA24AB1A2BA"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_cp_main_menu"]] = @"hash_4F3575BD58460BDC"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_cp_private_game"]] = @"hash_188013D573A07266"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_cp_public_match"]] = @"hash_4EAC49902CCFCAF3"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_cp_theater"]] = @"hash_2708123409640966"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_mp_main_menu"]] = @"hash_66747795A62485EE"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_mp_custom_games"]] = @"hash_8008E04FE1D817A"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_mp_public_match"]] = @"hash_68B34A5CFCA886A7"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_mp_theater"]] = @"hash_2708123409640966"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_zm_main_menu"]] = @"hash_1678F90B79774906"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_zm_private_game"]] = @"hash_FC98B88B9F75E67"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_zm_public_match"]] = @"hash_5E3EA8C15139713A"
CoD.LobbyUtility.Presence.ContextStrings[Enum[@"presencectx"][@"presence_ctx_zm_theater"]] = @"hash_2708123409640966"
CoD.LobbyUtility.Presence.LobbyJoinableStrings = {}
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no_not_in_lobby"]] = @"hash_3D87E6B6018DC30E"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_yes"]] = @"hash_46AA4BA2A90A62C5"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_yes_friends_only"]] = @"hash_5673F902643F6CCD"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no_party_privacy_invite_only"]] = @"hash_61D91C1D7F730F13"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no_party_privacy_closed"]] = @"hash_688841DDF008ECA1"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no_party_full"]] = @"hash_28D705C1E446FC4B"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no_game_full"]] = @"hash_45BD624A06A9D489"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no_playing_local"]] = @"hash_214CF094EFFE712A"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no_game_paused"]] = @"hash_7A3EF629E735A81E"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no"]] = @"hash_634F5097A432DED7"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"lobby_joinable_no_you_need_dlc"]] = @"hash_292AE67FCEA8248A"
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"hash_78FCE6A0B08CD559"]] = 0x4D26561B845EA8
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[@"lobbyjoinable"][@"hash_5C47680CFC712B91"]] = @"hash_E55CA0039948577"
