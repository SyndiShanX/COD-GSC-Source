require("x64:f3c5259f470592d")
CoD.LobbyUtility = {}
CoD.LobbyUtility.LobbyMemberSort = function(f1_arg0, f1_arg1)
	local f1_local0 = Engine[0x93B19E01B1FD1C7](Engine[0xA5B9C0111291A8B]())
	if f1_arg0.xuid == f1_local0 then
		return true
	elseif f1_arg1.xuid == f1_local0 then
		return false
	elseif f1_arg0.team < f1_arg1.team then
		return true
	elseif f1_arg0.team == f1_arg1.team then
		if f1_arg0.botType == Enum[0x956B3E4CE760AF8][0xDE80AE3863AA3E] and f1_arg1.botType ~= Enum[0x956B3E4CE760AF8][0xDE80AE3863AA3E] then
			return true
		elseif f1_arg0.botType ~= Enum[0x956B3E4CE760AF8][0xDE80AE3863AA3E] and f1_arg1.botType == Enum[0x956B3E4CE760AF8][0xDE80AE3863AA3E] then
			return false
		elseif f1_arg0.lobbyID < f1_arg1.lobbyID then
			return true
		end
	end
	return false
end
CoD.LobbyUtility.isMapFree = function(f2_arg0)
	local f2_local0 = CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav")
	if f2_local0 then
		return CoDShared.IsMapFree(f2_arg0, f2_local0, Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.playlistId")))
	else
		return false
	end
end
CoD.LobbyUtility.GetClientList = function()
	local f3_local0 = Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
	local f3_local1 = Engine[0x755D55B3813D249](f3_local0, Engine[0xC3DF042E7492B66](f3_local0))
	local f3_local2 = nil
	local f3_local3 = LobbyData.GetCurrentMenuTarget()
	if f3_local3[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) then
		f3_local2 = f3_local1
	else
		f3_local2 = Engine[0x755D55B3813D249](f3_local0, Enum[0xBF54BE1BB3D618B][0xA1647599284110])
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
	local f9_local0 = Engine[0x4FCDE749B09C3D6](f9_arg0)
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
			local f9_local6 = Engine[0xCBB96BC2E287F92](f9_arg0, f9_local7)
			table.insert(f9_local1[f9_local8], {
				clientNum = f9_local7,
				isBot = f9_local6.isBot,
				isCompanion = f9_local6.isCompanion,
				companionOwner = Engine[0x87453BFA40E0034](f9_arg0, f9_local7),
			})
		end
	end
	return f9_local1
end
CoD.LobbyUtility.GetMaxClientCount = function()
	return Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) and Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] or Enum[0xBF54BE1BB3D618B][0xA1647599284110])
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
	return CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatusString3") == 0xA5EF279F9C4EDC1
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
	local f16_local1 = CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "MapVote.mapVoteMapNext")
	local f16_local2 = true
	if MapVoteInState(LuaEnum.MAP_VOTE_STATE.LOCKEDIN) then
		if IsInTheaterMode() and not IsFilmSelected() then
		elseif not f16_local1 or not f16_local0 then
			f16_local2 = false
		else
			local f16_local3 = Engine[0x943893A16399DCF](f16_local1)
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
	local f16_local3 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyStatusString3")
	local f16_local4 = CoD.SafeGetModelValue(Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav")
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
		elseif f16_local4 == LobbyData.GetLobbyMenuIDByName(0xA82F65E15FA0AE4) then
			f16_local5 = 0xD6F106BB57DB329
		else
			f16_local5 = 0xB1EA843FE92AE3A
		end
	else
		if f16_local2 then
			local f16_local13 = 0x0
		end
		f16_local5 = f16_local13 or 0xA5EF279F9C4EDC1
	end
	if Engine[0x614D394F6F9A18D](f16_local3) ~= f16_local5 then
		Engine[0x83C9B5DE1D9371](f16_local3, f16_local5)
		Engine[0x6A489878620F3BC](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyButtonUpdate"))
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
		str = 0xE6F6113B8B75F3E,
	},
	EDITING_GAME_RULES = {
		index = 1,
		str = 0xD334604C49E05C9,
	},
	CHOOSING_MAP = {
		index = 2,
		str = 0x3B44FAC9FA39DC,
	},
	CHOOSING_GAME_MODE = {
		index = 3,
		str = 0x1ABA2DD833D3F28,
	},
	SETTING_UP_BOTS = {
		index = 4,
		str = 0x4C99F698861859E,
	},
	MODIFYNG_REWARDS = {
		index = 5,
		str = 0x6DE0B068DDA2C48,
	},
	MODIFYING_CAC = {
		index = 6,
		str = 0x41938EA32980EE5,
	},
	MODIFYING_HERO = {
		index = 7,
		str = 0x3FBBB9AAF77166C,
	},
	VIEWING_PLAYLISTS = {
		index = 8,
		str = 0xA918E99BC54400A,
	},
	VIEWING_PLAYERCARD = {
		index = 9,
		str = 0x322D6BA4F6F1040,
	},
	MODIFYING_BUBBLEGUM = {
		index = 10,
		str = 0xDB82DB610B19BD9,
	},
	MODIFYING_WEAPON_BUILD_KITS = {
		index = 11,
		str = 0x39AD93B1F97D39,
	},
	EDITING_CODCASTER_SETTINGS = {
		index = 12,
		str = 0x37DC5B3B89EB755,
	},
	AT_MEGACHEW_FACTORY = {
		index = 13,
		str = 0xC0EDBD567A3996F,
	},
	WAITING_TO_SELECT = {
		index = 14,
		str = 0xE6F6113B8B75F3E,
		select = 0xD6BACCCB20C09CF,
		main = 0x193E1BD7C5E960E,
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
			0x154E30A1DF77FF1,
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
	if not Engine[0x573048F8D3B4E25]() then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA1C4971DA015C84], "CoD.LobbyUtility.EventDispatcher() - invalid event: " .. f23_arg0 .. ".\n")
	else
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xA1C4971DA015C84], "CoD.LobbyUtility.EventDispatcher() - invalid event: " .. f23_arg0 .. ".\n")
	end
end
CoD.LobbyUtility.SubscribeToModels = function(f24_arg0)
	f24_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav"), function(model)
		CoD.LobbyUtility.ResetLeaderActivity(Engine[0xA5B9C0111291A8B]())
	end, false)
	f24_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyVMRequest"), function(model)
		CoD.LobbyUtility.ExecuteLobbyVMRequest(f24_arg0, model)
	end, false)
	f24_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyVMCreateOverlay"), function(model)
		local f27_local0 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyVMCreateOverlayController"))
		local f27_local1 = Engine[0x614D394F6F9A18D](model)
		if LUI.createMenu[f27_local1] then
			OpenOverlay(f24_arg0, f27_local1, f27_local0, nil)
		else
			local f27_local2 = CoD.OverlayUtility.CreateOverlay(f27_local0, f24_arg0, f27_local1)
			f27_local2.callingMenu = f24_arg0
		end
	end, false)
	f24_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyVMOpenIntroSurvey"), function(model)
		CoD.SurveyUtility.OpenSurvey(f24_arg0, Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyVMOpenIntroSurvey")), CoD.SurveyUtility.GetIntroSurveyType())
	end, false)
	f24_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.showSelect"), function(model)
		local f29_local0 = LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
		local f29_local1 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
		if f29_local0[0xBF54BE1BB3D618B] then
			f29_local1 = f29_local0[0xBF54BE1BB3D618B]
		end
		if f29_local1 == Enum[0xBF54BE1BB3D618B][0xB0756CC6FC8665C] then
			return
		else
			CoD.LobbyUtility.LeaderActivityChanged(f24_arg0, {
				lobbyType = f29_local1,
				activity = Engine[0x93A049DEA13587F](),
			})
		end
	end, false)
end
CoD.LobbyUtility.ExecuteLobbyVMRequest = function(f30_arg0, f30_arg1)
	local f30_local0 = Engine[0x614D394F6F9A18D](f30_arg1)
	local f30_local1 = Engine[0xA5B9C0111291A8B]()
	if f30_local0 == LuaEnum.LOBBYVM_REQUEST.FORCE_LOCAL_MODE then
		CoD.LobbyUtility.FailedDWConnection = true
		Engine[0x83C9B5DE1D9371](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.failedDemonwareConnection"), true)
	elseif f30_local0 == LuaEnum.LOBBYVM_REQUEST.RESET_LOADOUTS and not IsLobbyHostOfCurrentMenu() then
		local f30_local2 = Engine[0x8DF2E5447F384B9]()
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
				storageFileType = Enum[0xBBD4F9E70101BA8][0xF9A4C4451E3499E],
			})
			CoD.CACUtility.SetDefaultLoadouts({
				controller = f30_local1,
				storageFileType = Enum[0xBBD4F9E70101BA8][0xD062FA7B47FC13A],
			})
		end
	end
end
CoD.LobbyUtility.IsArenaStorageType = function(f31_arg0)
	local f31_local0
	if f31_arg0 ~= Enum[0xBBD4F9E70101BA8][0x67DF1879D992E] and f31_arg0 ~= Enum[0xBBD4F9E70101BA8][0xCEBE62E27709AD0] and f31_arg0 ~= Enum[0xBBD4F9E70101BA8][0xD062FA7B47FC13A] then
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
			CoD.OverlayUtility.ShowToast("ClanJoin", Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x248E1604D27C8DA)), "", LuaDefine.TOAST_POPUP_ICON_ERROR)
		end
	elseif f32_local0 == "remove_user" then
		if f32_local1 == false then
			CoD.OverlayUtility.ShowToast("RemoveUser", CoD.BaseUtility.AlreadyLocalized(f32_arg1.message), "", LuaDefine.TOAST_POPUP_ICON_SUCCESS)
		else
			CoD.OverlayUtility.ShowToast("RemoveUser", Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x248E1604D27C8DA)), "", LuaDefine.TOAST_POPUP_ICON_ERROR)
		end
	elseif f32_local0 == "new_host" then
		CoD.OverlayUtility.ShowToast("NewHost", Engine[0xF9F1239CFD921FE](0x174F6E6D02D9978), "", LuaDefine.TOAST_POPUP_ICON_SUCCESS)
	elseif f32_local0 == "multiple_invites" then
		CoD.OverlayUtility.ShowToast("MultipleInvites", Engine[0xF9F1239CFD921FE](0x31D384E754F1A41), "", LuaDefine.TOAST_POPUP_ICON_SUCCESS)
	elseif f32_local0 == "invite" then
		if f32_local1 == false then
			CoD.OverlayUtility.ShowToast("Invite", Engine[0xF9F1239CFD921FE](0x513526C1CA23EB9), f32_local2, LuaDefine.TOAST_POPUP_ICON_SUCCESS)
		else
			CoD.OverlayUtility.ShowToast("Invite", Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x248E1604D27C8DA)), f32_local2, LuaDefine.TOAST_POPUP_ICON_ERROR)
		end
	elseif f32_local0 == "trial_clients_kicked" then
		local f32_local3 = 0x67242EF77843FDB
		if f32_arg1.koreanUnderageMembersRemoved > 0 then
			f32_local3 = 0x58C62A4F206EBFC
		end
		if f32_arg1.limitedNoZMMembersRemoved > 0 then
			f32_local3 = 0x58C62A4F206EBFC
		end
		CoD.OverlayUtility.ShowToast("TrialClientsKicked", Engine[0xF9F1239CFD921FE](f32_local3), "", LuaDefine.TOAST_POPUP_ICON_ERROR)
	elseif f32_local0 == "error" then
		CoD.OverlayUtility.ShowToast("Invite", CoD.BaseUtility.AlreadyLocalized(f32_arg1.message), "", LuaDefine.TOAST_POPUP_ICON_ERROR)
	end
	return true
end
CoD.LobbyUtility.ChunkAllDownloading = function()
	if (IsOrbis() or IsDurango()) and Engine[0x7D47312EBA41751]() then
		return true
	else
		return false
	end
end
CoD.LobbyUtility.ChunkAnyDownloading = function()
	if (IsOrbis() or IsDurango()) and Engine[0x7D47312EBA41751]() then
		return true
	else
		return false
	end
end
CoD.LobbyUtility.ForceOffline = function()
	if (LuaDefine.isPS4 or LuaDefine.isXbox) and LuaUtils.IsSkuOfflineOnly() then
		return true
	elseif LuaDefine.isPC and Dvar[0xC2F09BAD1862417]:get() then
		return true
	else
		return false
	end
end
CoD.LobbyUtility.EndPlay = function(f36_arg0, f36_arg1)
	Engine[0xFAE25A8BACF647F]()
end
CoD.LobbyUtility.SetInitLobbyMenu = function(f37_arg0, f37_arg1)
	if Engine[0x498D0E20C7F1218]() then
		f37_arg0:registerEventHandler("check_cinematic_play_music", function(element, event)
			if Engine[0x498D0E20C7F1218]() then
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
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "ControllerRestrictionValidControllerIdx"), f39_local0)
end
CoD.LobbyUtility.LobbyNavigationActionModel = "lobbyRoot.lastNavigationAction"
CoD.LobbyUtility.NavigateToLobby = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4)
	local f40_local0 = LobbyData.GetCurrentMenuTarget()
	if f40_local0[0x4BCADBA8E631B86] == f40_arg1 then
		return
	elseif Engine[0xAEF2B6FA8A0BE77]() and not Engine[0x7567E8691BA45BA]() and not Engine[0xEE3E4DCDA4DB3F]() then
		local f40_local1 = LobbyData.GetLobbyMenuByName(f40_arg1)
		f40_local1 = f40_local1[0xEB7DDC7F079D51B]
		if f40_local1 ~= Enum[0x89C1455C5032969][0x78C124999125C42] then
			local f40_local2 = 0x55D96CC762EABDD
			if f40_local1 == Enum[0x89C1455C5032969][0x79D01499920B292] then
				f40_local2 = 0xB06081B8B4567F2
			end
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.trialOverlayDescription"), Engine[0xF9F1239CFD921FE](0xB844491C0871F92, f40_local2))
			CoD.OverlayUtility.CreateOverlay(f40_arg3, f40_arg0, "LobbyLeaveTrial")
			return
		end
	end
	if Engine[0xAEF2B6FA8A0BE77]() or Engine[0x7567E8691BA45BA]() or Engine[0xEE3E4DCDA4DB3F]() then
		local f40_local1 = false
		local f40_local2 = false
		local f40_local3 = false
		local f40_local4 = LobbyData.GetLobbyMenuByName(f40_arg1)
		f40_local4 = f40_local4[0xEB7DDC7F079D51B]
		local f40_local5 = 0x55D96CC762EABDD
		if f40_local4 == Enum[0x89C1455C5032969][0x79D01499920B292] then
			f40_local5 = 0xB06081B8B4567F2
		end
		if f40_local4 ~= Enum[0x89C1455C5032969][0x78C124999125C42] and Engine[0xAEF2B6FA8A0BE77]() then
			f40_local1 = true
		end
		if f40_local4 == Enum[0x89C1455C5032969][0x79D01499920B292] and Engine[0x7567E8691BA45BA]() then
			f40_local2 = true
		end
		if f40_local4 == Enum[0x89C1455C5032969][0x79D01499920B292] and Engine[0xEE3E4DCDA4DB3F]() then
			f40_local3 = true
		end
		if f40_local1 or f40_local2 or f40_local3 then
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.trialOverlayDescription"), Engine[0xF9F1239CFD921FE](0x5D1FF5B55B1B0B3, f40_local5))
			CoD.OverlayUtility.CreateOverlay(f40_arg3, f40_arg0, "LobbyLeaveInvalidPlayers", {
				removeTrial = f40_local1,
				removeKoreanUnderage = f40_local2,
				removeLimitedNoZM = f40_local3,
			})
			return
		end
	end
	if f40_arg1 == LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME then
		Engine[0x87AE7E64BA5AD61]("OnClanUIEvent", {
			controller = f40_arg3,
			event = LuaEnum.CLAN_UI_EVENT.INIT_MODELS,
		})
		Engine[0x87AE7E64BA5AD61]("OnClanUIEvent", {
			controller = f40_arg3,
			event = LuaEnum.CLAN_UI_EVENT.FETCH_DATA,
		})
	end
	local f40_local1 = Engine[0x8DF2E5447F384B9]()
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
	if f40_local4[0x6D8502BDC7A4868] < Engine[0x9FB56855DFACDAD]() then
		f40_local3.maxLocalClients = f40_local4[0x6D8502BDC7A4868]
		CoD.OverlayUtility.CreateOverlay(f40_arg3, f40_arg0, "LobbyLocalClientWarning", f40_local3)
		return
	elseif f40_local4[0xEE71E4EE12BC453] < Engine[0x44FC97037CE42ED](Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) and Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F]) then
		OpenGenericSmallPopup(f40_arg0, f40_arg3, 0xD0CB6ADB37BED49, Engine[0xF9F1239CFD921FE](0x128045808A178F3, f40_local4[0xEE71E4EE12BC453]), nil, Engine[0xF9F1239CFD921FE](0x5BE4A02B20F31F1))
		return
	elseif f40_arg1 == LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING and CoD.CTUtility.ShouldPlayIntroStoryMovie(f40_arg3) then
		local f40_local6 = DataSources.SpecialistHeadquarters.getModel(f40_arg3)
		f40_local6.StartFullscreenBlack:set(true)
	end
	Engine[0x87AE7E64BA5AD61]("OnGoForward", f40_local3)
end
CoD.LobbyUtility.ShowLeaveLobbyPopup = function(f41_arg0)
	if Dvar[0x1CD7A5D0E152F8D]:get() == false then
		return LuaEnum.LEAVE_LOBBY_POPUP.NONE
	end
	local f41_local0 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	local f41_local1 = Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f41_local2 = Engine[0x47928339DC88872](Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	local f41_local3 = Engine[0x47928339DC88872](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f41_local4 = Engine[0x44FC97037CE42ED](Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0xA1647599284110]) and Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103] or Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], Enum[0x575E471C039DBD6][0x92BC25E18D296F]) - Engine[0x9FB56855DFACDAD]() == 0
	local f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.NONE
	if f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
	elseif f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		if f41_local0 and f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY
		elseif f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY
		end
	elseif f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_PREGAME) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PREGAME) then
		if f41_local0 and f41_local2 and not f41_local4 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE
		elseif f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		end
	elseif f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_THEATER) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_THEATER) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_THEATER) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_THEATER) then
		if not f41_local0 and f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		else
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.NONE_LEAVE_WITH_PARTY
		end
	elseif f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PRIVATE) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) then
		if not f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY
		elseif f41_local0 and f41_local2 and not f41_local4 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE
		elseif not f41_local0 and f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		end
	elseif f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) then
		local f41_local6 = CoD.LobbyUtility.AllMembersInFrontend()
		if not f41_local2 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.NONE
		elseif f41_local0 and f41_local2 and not f41_local4 and f41_local6 == true then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE
		elseif not (f41_local0 or not f41_local2) or not f41_local6 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY
		end
	elseif f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM) then
		local f41_local6 = LobbyData.GetLobbyMenuByID(f41_arg0[0x8B72E07B55C3AC0])
		local f41_local7 = LobbyData.GetLobbyMenuByName(LuaUtils.LobbyMainModeData[f41_local6[0xEB7DDC7F079D51B]].PregameMenu)
		local f41_local8 = Engine[0x8DF2E5447F384B9]()
		f41_local8 = f41_local8.lobbyRoot.lobbyList.playerCount:get()
		if not f41_local8 or not f41_local8 then
			f41_local8 = 1
		end
		local f41_local9 = f41_local7[0xEE71E4EE12BC453]
		local f41_local10 = f41_arg0[0xEE71E4EE12BC453]
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
	elseif f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_CP) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_MP) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_MP_ARENA) or f41_arg0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_ZM) then
		if f41_local1 and f41_local3 then
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY
		else
			f41_local5 = LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY
		end
	end
	return f41_local5
end
CoD.LobbyUtility.ShouldShowLeaveLobbyPopup = function()
	local f42_local0 = Engine[0x8DF2E5447F384B9]()
	local f42_local1 = LobbyData.GetLobbyMenuByID(f42_local0.lobbyRoot.lobbyNav:get())
	if f42_local1 == nil then
		return false
	else
		return CoD.LobbyUtility.ShowLeaveLobbyPopup(f42_local1) ~= LuaEnum.LEAVE_LOBBY_POPUP.NONE
	end
end
CoD.LobbyUtility.StopManualTimer = function(f43_arg0)
	local f43_local0 = LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
	local f43_local1 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "MapVote.timerActive")
	Engine[0x83C9B5DE1D9371](f43_local1, 0)
	Engine[0x6A489878620F3BC](f43_local1)
	Engine[0x87AE7E64BA5AD61]("OnStopLobbyTimer", {
		controller = f43_arg0,
		lobbyType = f43_local0[0xBF54BE1BB3D618B],
		mainMode = f43_local0[0xEB7DDC7F079D51B],
	})
end
CoD.LobbyUtility.LobbyGoBack = function(f44_arg0, f44_arg1)
	local f44_local0 = LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
	f44_arg0:clearSavedState()
	local f44_local1 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.showSelect")
	if f44_local0[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE and f44_local1:get() == false then
		Engine[0x83C9B5DE1D9371](f44_local1, true)
		RefreshLobbyRoom(f44_arg0, f44_arg1)
		return
	end
	local f44_local2 = function(f45_arg0)
		Engine[0x87AE7E64BA5AD61]("OnGoBack", {
			controller = f44_arg1,
			withParty = f45_arg0,
		})
	end
	if CoD.LobbyUtility.MapVoteTimerActive() and (f44_local0[0x558B67A321D1120] == LuaEnum.TIMER_TYPE.MANUAL or f44_local0[0x558B67A321D1120] == LuaEnum.TIMER_TYPE.MANUAL_CP or f44_local0[0x558B67A321D1120] == LuaEnum.TIMER_TYPE.THEATER) then
		CoD.LobbyUtility.StopManualTimer(f44_arg1)
		return
	elseif f44_local0[0x558B67A321D1120] == LuaEnum.TIMER_TYPE.AUTO_ZM and CoD.DirectorUtility.CanReadyDown(f44_arg1) then
		CoD.DirectorUtility.SetLocalClientsReady()
		return
	elseif IsZombies() and IsLobbyNetworkModeLAN() and IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.ShowDirectorCustom(f44_arg0, f44_arg1) and CoD.ZombieUtility.IsZMOfflineScreenStateCustomGame() then
		OpenSystemOverlay(f44_arg0, f44_arg0, f44_arg1, "LobbyLeaveZMOfflineCustom", nil)
		return
	elseif f44_local0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_PUBLIC) then
		local f44_local3 = Engine[0x8DF2E5447F384B9]()
		if f44_local3.lobbyRoot.publicLobby.stage:get() ~= LuaEnum.PUBLIC_LOBBY.INVALID and IsLobbyHostOfLobbyType(Enum[0xBF54BE1BB3D618B][0xA1647599284110]) then
			Engine[0x87AE7E64BA5AD61]("OnLobbyClientLeftEvent", {
				controller = f44_arg1,
				withParty = LuaEnum.LEAVE_WITH_PARTY.WITH,
			})
			return
		end
	end
	if (f44_local0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) or f44_local0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_MATCHMAKING)) and IsLobbyHostOfLobbyType(Enum[0xBF54BE1BB3D618B][0xA1647599284110]) then
		f44_local2(LuaEnum.LEAVE_WITH_PARTY.WITH)
		return
	elseif f44_local0[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) and not CoD.CTUtility.HasSeenMovie(f44_arg1, 0x9DE4F0913361A61) then
		local f44_local4, f44_local5, f44_local6 = CoD.CTUtility.GetOverallSpecialistProgress(f44_arg1)
		local f44_local7 = CoD.CTUtility.GetArchivesBundle()
		if f44_local5 and f44_local7[0x6F3C4D03C30332] ~= nil and f44_local7[0x6F3C4D03C30332] ~= "" and CoD.CTUtility.CanPlayVideo(f44_arg1, f44_local7[0x515E45AD81B9327]) then
			CoD.CTUtility.PlaySkippableVideo(f44_arg1, f44_arg0, f44_local7[0x6F3C4D03C30332], f44_local7[0x34B4156EBE6988B] ~= 0, {
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
	local f44_local4 = Engine[0x8DF2E5447F384B9]()
	if f44_local0[0x8B72E07B55C3AC0] ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) and f44_local3 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY and Engine[0x9FB56855DFACDAD]() == (f44_local4.lobbyRoot.lobbyList.playerCount:get() or 0) then
		f44_local3 = LuaEnum.LEAVE_LOBBY_POPUP.NONE
	end
	if f44_local3 > LuaEnum.LEAVE_LOBBY_POPUP.NONE_LEAVE_WITH_PARTY then
		if not CoD.isPC then
			CoD.OverlayUtility.CreateOverlay(f44_arg1, f44_arg0, "LobbyLeavePopup", f44_local3, f44_local0[0x4BCADBA8E631B86])
		else
			CoD.OverlayUtility.CreateOverlay(f44_arg1, f44_arg0, "LeaveLobbyPopupPC", f44_local3, f44_local0[0x4BCADBA8E631B86])
		end
	elseif f44_local3 == LuaEnum.LEAVE_LOBBY_POPUP.NONE_LEAVE_WITH_PARTY then
		f44_local2(LuaEnum.LEAVE_WITH_PARTY.WITH)
	else
		f44_local2(LuaEnum.LEAVE_WITH_PARTY.WITHOUT)
	end
end
local f0_local0 = function()
	local f47_local0 = nil
	if not IsLAN() and not Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x5E90ACB801E4A3D]) and not Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x7B5630CD29180CB]) then
		local f47_local1 = Engine[0x3ACB99DBAD24D55](Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.playlistId")))
		local f47_local2 = Engine[0x8DF2E5447F384B9]()
		if f47_local2.lobbyRoot.lobbyMainMode:get() == f47_local1.mainMode then
			f47_local0 = math.min(f47_local1.maxLocalPlayers, f47_local1.maxPartySize)
		else
			f47_local0 = Dvar[0x6BAC8B42067D2C5]:get()
		end
	else
		f47_local0 = Dvar[0x6BAC8B42067D2C5]:get()
	end
	if Engine[0x69811927938FCD7]() == "ztutorial" then
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
		Engine[0x3CDCDFD486E97B7](f48_arg2, Enum[0xBF54BE1BB3D618B][0xA1647599284110], Engine[0x614D394F6F9A18D](f48_local0.listItems[f48_local0.firstIndex + f48_arg1.zeroBasedIndex]:getModel(f48_arg2, "xuid")))
	end
end
CoD.LobbyUtility.CanAddMoreBotsToLobby = function()
	local f49_local0 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2])
	return Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f49_local0, Enum[0x575E471C039DBD6][0x92BC25E18D296F]) + Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f49_local0, Enum[0x575E471C039DBD6][0x7D6D125E5450799]) < Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f49_local0)
end
CoD.LobbyUtility.SplitscreenControllersAllowed = function()
	if not IsLobbyHostOfLobbyType(Enum[0xBF54BE1BB3D618B][0xA1647599284110]) then
		return false
	elseif CoD.isPC then
		return false
	end
	local f50_local0 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	if Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		f50_local0 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
		if not IsLobbyHostOfLobbyType(f50_local0) then
			return false
		elseif not (not IsMultiplayer() or not IsLive() or Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x5E90ACB801E4A3D]) or Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x7B5630CD29180CB])) or IsZombies() and IsLive() and not Engine[0x994291BF56E485B](Enum[0xF7AE5746E79F2CE][0x5E90ACB801E4A3D]) then
			return false
		elseif CompetitiveSettingsEnabled() then
			return false
		end
	end
	local f50_local1 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f50_local0, Enum[0x575E471C039DBD6][0x92BC25E18D296F])
	local f50_local2 = Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f50_local0)
	local f50_local3 = Engine[0x9FB56855DFACDAD]()
	local f50_local4 = f0_local0()
	if f50_local3 >= 2 and f50_local0 == Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and f50_local1 + Engine[0xC9190AFD905AC12]() ~= f50_local3 then
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
	local f51_local0 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	if Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		f51_local0 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
	end
	if not Engine[0xF285055A1A895A1](f51_arg1) then
		local f51_local1 = false
		local f51_local2 = Engine[0x6517A5F0DDF47C9](f51_arg1, f51_local0)
		if f51_local2 ~= nil then
			if f51_local2 == Enum[0xE3993C388C91269][0x314B73565D20C88] then
				CoD.OverlayUtility.CreateOverlay(f51_arg1, f51_arg0, "LoadingProfile")
				f51_local1 = true
			elseif f51_local2 == Enum[0xE3993C388C91269][0xB67E58C25715FAF] then
				CoD.OverlayUtility.CreateOverlay(f51_arg1, f51_arg0, "ConnectingToDemonware")
				f51_local1 = true
			elseif f51_local2 == Enum[0xE3993C388C91269][0xD883E9305361E58] then
				f51_local1 = true
				return
			end
		end
		Engine[0x87AE7E64BA5AD61]("OnClientSplitscreenSignin", {
			controller = f51_arg1,
		})
		Engine[0x8C5711DAACC99F4](Enum[0x7A63DCD561B0FA8][0xA9AE284CC7DE955], "OnClientSplitscreenSignin fired for controller index" .. f51_arg1 .. ".\n")
		if IsLive() and not Engine[0xE91B1452CB6FBE6](f51_arg1) and not f51_local1 then
			CoD.OverlayUtility.CreateOverlay(f51_arg1, f51_arg0, "ConnectingToDemonware")
		end
	end
end
CoD.LobbyUtility.RemoveLocalPlayerFromTheLobby = function(f52_arg0, f52_arg1)
	Engine[0x42F846A8E810CA1](f52_arg1)
end
local f0_local1 = function(f53_arg0, f53_arg1)
	if CoD.isDurango and not IsLAN() and Engine[0xE91B1452CB6FBE6](1) then
		local f53_local0 = Engine[0x3ACB99DBAD24D55](Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.playlistId")))
		if f53_local0.disableGuests then
			OpenGenericSmallPopup(f53_arg0, f53_arg1, Engine[0xF9F1239CFD921FE](0xD0CB6ADB37BED49), Engine[0xF9F1239CFD921FE](0xC3209E08F133230), nil, Engine[0xF9F1239CFD921FE](0x5BE4A02B20F31F1))
			return true
		end
	end
	return false
end
local f0_local2 = function(f54_arg0, f54_arg1)
	local f54_local0 = Engine[0x9FB56855DFACDAD]()
	local f54_local1 = f0_local0()
	if f54_local1 < f54_local0 then
		OpenGenericSmallPopup(f54_arg0, f54_arg1, Engine[0xF9F1239CFD921FE](0xD0CB6ADB37BED49), Engine[0xF9F1239CFD921FE](0x128045808A178F3, f54_local1), nil, Engine[0xF9F1239CFD921FE](0x5BE4A02B20F31F1))
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
		Engine[0x87AE7E64BA5AD61]("OnLaunchGame", f55_local0)
	end
end
CoD.LobbyUtility.StartSearch = function(f56_arg0, f56_arg1, f56_arg2)
	local f56_local0 = {
		controller = f56_arg2,
	}
	if not f0_local2(f56_arg1, f56_arg2) and not f0_local1(f56_arg1, f56_arg2) and CoD.DirectorUtility.PrepareSearchPlaylistModels(f56_arg0, f56_arg2) then
		Engine[0x87AE7E64BA5AD61]("OnAsyncMatchmakingStart", f56_local0)
	end
end
CoD.LobbyUtility.LaunchDemo = function(f57_arg0, f57_arg1, f57_arg2)
	local f57_local0 = {
		controller = f57_arg1,
		lobbyType = f57_arg2,
	}
	if not f0_local2(f57_arg0, f57_arg1) then
		Engine[0x87AE7E64BA5AD61]("OnLaunchDemo", f57_local0)
	end
end
CoD.LobbyUtility.SetPlaylistName = function(f58_arg0, f58_arg1)
	local f58_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyPlaylist")
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f58_local0, "name"), Engine[0xB03220D3A4F3E38](f58_arg0))
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f58_local0, "kickerText"), f58_arg1 or 0x0)
end
CoD.LobbyUtility.GetActivityString = function(f59_arg0)
	for f59_local7, f59_local8 in pairs(CoD.LobbyUtility.LeaderActivity) do
		if f59_local8.index == f59_arg0 then
			if f59_arg0 == CoD.LobbyUtility.LeaderActivity.WAITING_TO_SELECT.index then
				local f59_local3 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.hostGamertag")
				local f59_local4 = nil
				if f59_local3 ~= nil then
					f59_local4 = Engine[0x614D394F6F9A18D](f59_local3)
				end
				if f59_local4 ~= nil then
					local f59_local5 = LobbyData.GetCurrentMenuTarget()
					if f59_local5[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE then
						if f59_local4 == "" then
							return Engine[0xF9F1239CFD921FE](f59_local8.str)
						else
							local f59_local6 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.showSelect")
							if f59_local6:get() then
								return Engine[0xF9F1239CFD921FE](f59_local8.select, f59_local4)
							else
								return Engine[0xF9F1239CFD921FE](f59_local8.main, f59_local4)
							end
						end
					end
				end
			end
			return Engine[0xF9F1239CFD921FE](0x20D8C6763DEDD8F, Engine[0xED84C33EC5F01EA](f59_local8.str))
		end
	end
	return ""
end
CoD.LobbyUtility.LeaderActivityInit = function()
	local f60_local0 = LobbyData.GetLobbyMenuByID(Engine[0x9882F293C327557]())
	local f60_local1 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	if f60_local0[0xBF54BE1BB3D618B] then
		f60_local1 = f60_local0[0xBF54BE1BB3D618B]
	end
	if f60_local1 == Enum[0xBF54BE1BB3D618B][0xB0756CC6FC8665C] then
		return
	else
		CoD.LobbyUtility.LeaderActivityChanged(nil, {
			lobbyType = f60_local1,
			activity = 0,
		})
		CoD.LobbyUtility.ResetLeaderActivity(Engine[0xA5B9C0111291A8B]())
	end
end
CoD.LobbyUtility.LeaderActivityChanged = function(f61_arg0, f61_arg1)
	local f61_local0 = Engine[0xA798E4552F5E872](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot"), "leaderActivity")
	if Engine[0xEA2BE00F49480D](f61_arg1.lobbyType) then
		Engine[0x83C9B5DE1D9371](f61_local0, Engine[0xF9F1239CFD921FE](0x73E87C1D2E33FA4))
	elseif Engine[0x8EB264B38365442]() == true then
		Engine[0x83C9B5DE1D9371](f61_local0, Engine[0xF9F1239CFD921FE](0xE2EDE41E4B5939C))
	else
		Engine[0x83C9B5DE1D9371](f61_local0, CoD.LobbyUtility.GetActivityString(f61_arg1.activity))
	end
	return true
end
CoD.LobbyUtility.SetLeaderActivity = function(f62_arg0, f62_arg1)
	local f62_local0 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2])
	if not Engine[0x504FD34622CBF0A](f62_local0) then
		return
	elseif f62_arg1 ~= nil then
		Engine[0xD55BA32E7D072F3](f62_arg0, f62_local0, f62_arg1.index)
	else
		Engine[0xD55BA32E7D072F3](f62_arg0, f62_local0, 0)
	end
end
CoD.LobbyUtility.ResetLeaderActivity = function(f63_arg0)
	local f63_local0 = LobbyData.GetCurrentMenuTarget()
	if f63_local0[0x4BCADBA8E631B86] == LuaEnum.UI.DIRECTOR_ONLINE then
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
	if not Engine[0x3ACB99DBAD24D55](Engine[0x7B3B2B73B53EB34]()) then
		return
	end
	CoD.perController[f70_arg1].isInLobbyLeaderboard = true
	local f70_local0 = ""
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "combatRecordMode"), "mp")
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "leaderboardCategoryName"), f70_local0)
	local f70_local1 = "LB_MP_GM_" .. Engine[0xB03220D3A4F3E38](Engine[0x69811927938FCD7]())
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
	local f72_local0 = Engine[0xEF39E16C566439B]()
	if f72_local0 < 0 then
		return
	else
		local f72_local1 = 0
		local f72_local2 = "LB_MP_ARENA_MASTERS_0" .. tostring(f72_local0)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "combatRecordMode"), "mp")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "leaderboardCategoryName"), "arena")
		CoD.LeaderboardUtility.LeaderboardGameModeButtonPrepare(f72_arg1)
		SetGlobalModelValue("leaderboardDef", f72_local2)
		LUI.OverrideFunction_CallOriginalFirst(OpenOverlay(f72_arg0, "Leaderboard_GameMode", f72_arg1), "close", function()
			CoD.LobbyUtility.ResetLeaderActivity(f72_arg1)
		end)
	end
end
CoD.LobbyUtility.GoToFindingGames = function(f74_arg0, f74_arg1)
	local f74_local0 = Engine[0x5AA137994DA7513]()
	f74_local0 = f74_local0:lower()
	if f74_local0 == "Invalid" then
		Engine[0x458FE92FEB39D4E](Enum[0x7A63DCD561B0FA8][0xC1DE3DC19B3B20D], "GoToFindingGames: Invalid mode in matchmaking, Engine.@GetModeName() == 'Invalid'.\n")
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
	Engine[0xC4146BA76D0F982]("cac_enter_cac")
	CoD.CACUtility.SetDefaultCACRoot(f76_arg1)
	if IsClassSetsAvailableForCurrentGameMode() then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f76_arg1), "currentClassSetIndex"), Engine[0x69D03275BEFBC0C](f76_arg1))
		CopyLoadoutFromClassSet(f76_arg1)
	else
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f76_arg1), "currentClassSetIndex"), 0)
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
	local f80_local0 = Engine[0x8DF2E5447F384B9]()
	local f80_local1 = LuaUtils.GetEModeForLobbyMainMode(f80_local0["lobbyRoot.lobbyMainMode"]:get())
	if not f80_local1 then
		f80_local1 = Engine[0x3EAC408F958FF05]()
	end
	local f80_local2 = "MPCustomizeClassMenu"
	if f80_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f80_local2 = "ZMCustomizeClassMenu"
	end
	OpenOverlay(f80_arg0, f80_local2, f80_arg1, {
		_sessionMode = f80_local1,
	})
end
CoD.LobbyUtility.OpenDirectorScorestreaks = function(f81_arg0, f81_arg1)
	OpenOverlay(f81_arg0, "SupportSelection", f81_arg1, {
		_sessionMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
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
	local f107_local0 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f107_local1 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
	if not f107_local0 then
		f107_local1 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	end
	if Engine[0xEA2BE00F49480D](f107_local1) then
		Engine[0xCBDED49058F1E19](f107_local1, 1, false, 0)
	end
end
CoD.LobbyUtility.RemoveLobbyBot = function(f108_arg0, f108_arg1)
	local f108_local0 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f108_local1 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
	if not f108_local0 then
		f108_local1 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	end
	if Engine[0xEA2BE00F49480D](f108_local1) then
		Engine[0xA468BF674010CE8](f108_local1, 1)
	end
end
CoD.LobbyUtility.RemoveAllLobbyBots = function(f109_arg0)
	local f109_local0 = Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43])
	local f109_local1 = Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]
	if not f109_local0 then
		f109_local1 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	end
	if Engine[0xEA2BE00F49480D](f109_local1) then
		local f109_local2 = Engine[0x44FC97037CE42ED](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], f109_local1, Enum[0x575E471C039DBD6][0x7D6D125E5450799])
		if f109_local2 > 0 then
			Engine[0xA468BF674010CE8](f109_local1, f109_local2)
		end
	end
end
CoD.LobbyUtility.OpenOptions = function(f110_arg0, f110_arg1)
	Engine[0xB81A5136C5503E4](f110_arg1, "disableallclients")
	Engine[0xB81A5136C5503E4](f110_arg1, "setclientbeingusedandprimary")
	OpenPopup(f110_arg0, "OptionsMenu", f110_arg1)
end
CoD.LobbyUtility.OpenQuit = function(f111_arg0, f111_arg1)
	OpenMenu(f111_arg0, "QuitPopup", f111_arg1)
end
CoD.LobbyUtility.OpenWeaponBuildKits = function(f112_arg0, f112_arg1)
	CoD.LobbyUtility.SetLeaderActivity(f112_arg1, CoD.LobbyUtility.LeaderActivity.MODIFYING_WEAPON_BUILD_KITS)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f112_arg1), "Gunsmith.Mode"), Enum[0xD0B6F7C5838AE03][0x7D90C30A88E0E20])
	local f112_local0 = CoD.CraftUtility.Gunsmith.ParseDDL(f112_arg1, "cacRoot")
	local f112_local1 = CoD.CraftUtility.Paintjobs.ParseDDL(f112_arg1, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61])
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
	CoD.LobbyUtility.LobbyMapVoteSelect(f118_arg0, f118_arg1, Enum[0xF116421015E781B][0x658B6B1B964D38A])
end
CoD.LobbyUtility.LobbyMapVoteSelectPrevious = function(f119_arg0, f119_arg1)
	CoD.LobbyUtility.LobbyMapVoteSelect(f119_arg0, f119_arg1, Enum[0xF116421015E781B][0xD8A67C2C1AF1036])
end
CoD.LobbyUtility.LobbyMapVoteSelectRandom = function(f120_arg0, f120_arg1)
	CoD.LobbyUtility.LobbyMapVoteSelect(f120_arg0, f120_arg1, Enum[0xF116421015E781B][0x74A46A6237E75F4])
end
CoD.LobbyUtility.LobbyMapVoteSelect = function(f121_arg0, f121_arg1, f121_arg2)
	local f121_local0 = Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2])
	Engine[0xC4146BA76D0F982]("uin_map_vote")
	Engine[0x692CCBB48AA3F99](f121_arg1, f121_local0, f121_arg2)
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
	local f125_local0 = Engine[0x8DF2E5447F384B9]()
	local f125_local1 = f125_local0["lobbyRoot.mapVote"]
	if not f125_local1 then
		return false
	end
	local f125_local2 = f125_local0["lobbyRoot.lobbyNav"].get(f125_local0["lobbyRoot.lobbyNav"])
	if f125_local2 then
		local f125_local3 = LobbyData.GetLobbyMenuByID(f125_local2)
		if f125_local3[0xBF54BE1BB3D618B] ~= Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] and f125_local3[0xBF54BE1BB3D618B] ~= Enum[0xBF54BE1BB3D618B][0xA1647599284110] then
			return false
		end
	end
	return tonumber(f125_arg0) == f125_local1:get()
end
CoD.LobbyUtility.MapVotePreviousSelectable = function()
	if not CoD.LobbyUtility.MapVoteInState(LuaEnum.MAP_VOTE_STATE.VOTING) then
		return false
	end
	local f126_local0 = Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
	if Engine[0xEA2BE00F49480D](Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
		f126_local0 = Enum[0x7CA2DE5266A94BF][0x98EA1BB7164D103]
	end
	if Engine[0x1A4C6DB0E9E5B3](f126_local0, Engine[0xC3DF042E7492B66](f126_local0)) >= Dvar[0xFDE55C3193279A9]:get() then
		return false
	end
	return true
end
CoD.LobbyUtility.MapVoteTimerActive = function()
	local f127_local0 = Engine[0x8DF2E5447F384B9]()
	f127_local0 = f127_local0["MapVote.timerActive"]
	if not f127_local0 then
		return false
	end
	local f127_local1 = LobbyData.GetLobbyMenuByID(LobbyData.GetLobbyNav())
	if f127_local1[0x558B67A321D1120] == LuaEnum.TIMER_TYPE.TESTING then
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
	Engine[0x87AE7E64BA5AD61]("OnSwitchTeam", {
		controller = f128_arg1,
		selection = f128_arg2,
		xuid = f128_arg3,
		lobbyClientType = f128_arg4,
	})
end
CoD.LobbyUtility.LobbySetTeam = function(f129_arg0, f129_arg1)
	Engine[0x887353BB976C702](f129_arg0, Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]), f129_arg1)
end
CoD.LobbyUtility.LobbyLANServerBrowserFilterUpdateEvent = function(f130_arg0, f130_arg1)
	local f130_local0 = Engine[0xCCC297B03873278]()
	local f130_local1 = "all"
	if f130_local0 == Enum[0x89C1455C5032969][0x7B50049993542C0] then
		f130_local1 = "cp"
	elseif f130_local0 == Enum[0x89C1455C5032969][0x7E41449995CD57E] then
		f130_local1 = "mp"
	elseif f130_local0 == Enum[0x89C1455C5032969][0x79D01499920B292] then
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
	if Dvar[0x39AC704E09BFB98]:get() == true then
		f131_local0 = Enum[0x89C1455C5032969][0x7B50049993542C0]
	end
	Engine[0x9577C190ED7A99C](f131_local0)
	CoD.LobbyUtility.LobbyLANServerBrowserFilterUpdateEvent(f131_arg0, f131_arg2)
end
CoD.LobbyUtility.SetSpinnerActive = function(f132_arg0)
	CoD.Menu.SpinnerIsActive = f132_arg0
end
CoD.LobbyUtility.MainPreLoad = function(f133_arg0)
	f133_arg0.anyControllerAllowed = true
	f133_arg0.unusedControllerAllowed = true
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.platformUpdate"), true)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.beginPlay"), Enum[0xC84D3E505F1444][0xDB898B3478D2D71])
	if Engine[0x7A82FB9AB875B2C] then
		Engine[0x7A82FB9AB875B2C]()
	end
end
CoD.LobbyUtility.KoreaRatings_AlreadyOpened = function()
	return Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.shownKoreaRatings") ~= nil
end
CoD.LobbyUtility.SetupStartPopups = function(f135_arg0, f135_arg1)
	local f135_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.startPopups")
	local f135_local1 = 0
	local f135_local2
	if Dvar[0x4FF2012C26D8FB]:get() and not CoD.MOTDUtility.MOTD_AlreadyOpened() then
		local f135_local3 = Dvar[0xCC0AD043B9FD789]:exists()
		local f135_local4 = Dvar[0xCC0AD043B9FD789]
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
	f135_local4[0x83C9B5DE1D9371](f135_local0, f135_local1)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.startBitsToFetch"), Engine[0x8506F73B393062F](1) << Engine[0x8506F73B393062F](Enum[0xFBD04AEB20CE6F3][0xCA1833D94AE73C0]))
end
CoD.LobbyUtility.SetupPostPopups = function(f136_arg0, f136_arg1)
	local f136_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.postPopups")
	local f136_local1 = 0
	if Dvar[0x4FF2012C26D8FB]:get() and not CoD.MOTDUtility.MOTD_AlreadyOpened() and Dvar[0xCC0AD043B9FD789]:exists() and Dvar[0xCC0AD043B9FD789]:get() then
		f136_local1 = 1 << LuaEnum.POST_POPUPS.MOTD
	end
	if CoD.isPC and CoD.PCKoreaUtility.IsInKorea() then
		f136_local1 = f136_local1 | 1 << LuaEnum.START_POPUPS.KoreaRating
	end
	Engine[0x83C9B5DE1D9371](f136_local0, f136_local1)
end
CoD.LobbyUtility.MainPostLoad = function(f137_arg0, f137_arg1)
	CoD.LobbyUtility.RegisterEventHandlers(f137_arg0)
	if Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive") == nil then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive", true), false)
	end
	Engine[0xD2A53954F5F46E2]()
	CoD.LobbyUtility.EndPlay()
	CoD.LobbyUtility.SetupStartPopups(f137_arg0, f137_arg1)
	CoD.LobbyUtility.SetupPostPopups(f137_arg0, f137_arg1)
	local f137_local0 = function(f138_arg0, f138_arg1, f138_arg2, f138_arg3)
		local f138_local0 = {
			controller = f138_arg2,
			navToMenu = "director",
		}
		if LuaUtils.LobbyProcessQueueEmpty() and Engine[0x9882F293C327557]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			Engine[0xC4146BA76D0F982]("uin_splashscreen_exit")
			Engine[0x87AE7E64BA5AD61]("OnGoForward", f138_local0)
		end
	end
	local f137_local1 = function(f139_arg0, f139_arg1, f139_arg2, f139_arg3)
		if IsDpadButton(f139_arg3) then
			f137_local0(f139_arg0, f139_arg1, f139_arg2, f139_arg3)
		end
	end
	local f137_local2 = 0
	local f137_local3 = function(f140_arg0, f140_arg1, f140_arg2, f140_arg3)
		if Engine[0xD37197A182D17E1](f140_arg2) then
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
		if Engine[0xD37197A182D17E1](f141_arg2) then
			f137_local0(f141_arg0, f141_arg1, f141_arg2, f141_arg3)
		elseif f137_local4 > 3 then
			CoD.DirectorUtility.LoadFFOTDFileFromLPC()
			f137_local4 = 0
		else
			f137_local4 = f137_local4 + 1
		end
	end
	Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav")
	f137_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav"), function(model)
		if Engine[0x614D394F6F9A18D](model) ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			NavigateToMenu(f137_arg0, "Director", true, f137_arg1)
		end
	end, false)
	f137_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "pubstorageFilesChanged"), function(model)
		if Engine[0x3E68E350BEFE50D](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43]) then
			return
		elseif Engine[0x614D394F6F9A18D](model) == true then
			CoD.OverlayUtility.OpenPublisherFilesChangedOverlay(f137_arg1, f137_arg0)
		end
	end, false)
	f137_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.beginPlay"), function(model)
		f137_local0(nil, nil, f137_arg1, nil)
	end, false)
	f137_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.showPopup"), function(model)
		local f145_local0 = Engine[0x8DF2E5447F384B9]()
		f145_local0 = f145_local0["lobbyRoot.startPopups"]
		local f145_local1 = f145_local0:get()
		if CoD.BitUtility.IsBitSet(f145_local0:get(), LuaEnum.START_POPUPS.MOTD) then
			if CoD.MOTDUtility.MOTD_ShouldShowMOTD(f137_arg1) then
				f145_local0:set(CoD.BitUtility.ClearBit(f145_local1, LuaEnum.START_POPUPS.MOTD))
				Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.shownMOTD")
				CoD.MOTDUtility.MOTD_OpenMOTDPopup(f137_arg0, nil, f137_arg1, true, f137_arg0)
				return
			end
			f145_local0:set(CoD.BitUtility.ClearBit(f145_local1, LuaEnum.START_POPUPS.MOTD))
		end
		if IsBooleanDvarSet(0x3AA4F815BA2261) and CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(f137_arg0, f137_arg1, "PromoEvent") then
			return
		elseif f145_local0:get() == 0 and Engine[0x9882F293C327557]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			Engine[0x87AE7E64BA5AD61]("OnGoForward", {
				controller = f137_arg1,
				navToMenu = "director",
			})
		end
	end, false)
	f137_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.showPostPopup"), function(model)
		local f146_local0 = Engine[0x8DF2E5447F384B9]()
		f146_local0 = f146_local0["lobbyRoot.postPopups"]
		local f146_local1 = f146_local0:get()
		if CoD.BitUtility.IsBitSet(f146_local0:get(), LuaEnum.POST_POPUPS.MOTD) then
			if CoD.MOTDUtility.MOTD_ShouldShowMOTD(f137_arg1) then
				if not CoD.isPC then
					f146_local0:set(CoD.BitUtility.ClearBit(f146_local1, LuaEnum.POST_POPUPS.MOTD))
				elseif CoD.MOTDUtility.MOTD_AlreadyOpened() then
					return
				end
				Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.shownMOTD")
				CoD.MOTDUtility.MOTD_OpenMOTDPopup(f137_arg0, nil, f137_arg1, true, f137_arg0)
				return
			end
			f146_local0:set(CoD.BitUtility.ClearBit(f146_local1, LuaEnum.POST_POPUPS.MOTD))
		end
		if CoD.BitUtility.IsBitSet(f146_local1, LuaEnum.START_POPUPS.KoreaRating) then
			if CoD.PCKoreaUtility.IsInKorea() then
				if not CoD.LobbyUtility.KoreaRatings_AlreadyOpened() then
					Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.shownKoreaRatings")
					local f146_local2 = f137_arg0:openPopup("PC_Korea_Bootsequence_Rating", f137_arg1)
				end
				return
			end
			startPopUpsModel:set(CoD.BitUtility.ClearBit(f146_local1, LuaEnum.START_POPUPS.KoreaRating))
		end
		if IsBooleanDvarSet(0x3AA4F815BA2261) and CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(f137_arg0, f137_arg1, "PromoEvent") then
			return
		elseif f146_local0:get() == 0 and Engine[0x9882F293C327557]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			Engine[0x87AE7E64BA5AD61]("OnGoForward", {
				controller = f137_arg1,
				navToMenu = "director",
			})
		end
	end, false)
	f137_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "mainFirstTimeFlowComplete"), function(model)
		local f147_local0 = Engine[0x614D394F6F9A18D](model)
		CloseAllOccludingMenus(f137_arg0, f137_arg1)
		f137_local0(nil, nil, f137_arg1, nil)
	end, false)
	f137_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.closePopups"), function(model)
		local f148_local0 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.FFOTDShutdown"))
		if f148_local0 == nil or f148_local0 == false then
			CloseAllOccludingMenus(f137_arg0, f137_arg1)
		end
	end, false)
	Engine[0x6ABA4D7F0840A1E](f137_arg1, "menu_change" .. CoD.GetLocalClientAdjustedNum(f137_arg1), {
		menu = "Main",
		status = "closeToMenu",
	})
	f137_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.room"), function(model)
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
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, f137_local7, f137_local6, false)
	else
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], nil, f137_local1, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], nil, f137_local1, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], nil, f137_local1, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], nil, f137_local1, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], "ui_confirm", f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x49A252B20B48936], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], nil, f137_local0, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], nil, f137_local3, f137_local6, false)
		f137_arg0:AddButtonCallbackFunction(f137_arg0, f137_arg1, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], nil, f137_local5, f137_local6, false)
	end
	f137_arg0.handleMouseButton = true
	local f137_local8 = function()
		f137_arg0.launchInvitesHotJoinTimer = nil
		Engine[0xD8D417082862655]()
	end
	local f137_local9 = function(f153_arg0)
		if Engine[0x498D0E20C7F1218]() then
			return
		elseif Engine[0xFFC1C70C8D5B359]() and not f137_arg0.__authErrorShown then
			LuaUtils.UI_ShowErrorMessageDialog(f137_arg1, Engine[0xA771C266E4512D](), "")
			f137_arg0.__authErrorShown = true
		end
		if Engine[0x4D07729ED48730D]() then
			f137_arg0.launchSignInTimer:close()
			f137_arg0.ConnectionLabel.lblConnecting:setText(Engine[0xF9F1239CFD921FE](0x27BE553CE368A05))
			if not Engine[0xFFC1C70C8D5B359]() then
				local f153_local0 = Engine[0x40B6B0577E345DA](f137_arg1)
				if f153_local0 <= 0 then
					f153_local0 = Engine[0xB559CD5AFE03E74](f137_arg1)
				end
				if f153_local0 > 0 then
					LuaUtils.UI_ShowErrorMessageDialog(f137_arg1, Engine[0xF9F1239CFD921FE](0x9E217C1FA1920C2, f153_local0), "")
				end
			end
		end
		local f153_local0 = Engine[0x8E117182481F32E]()
		local f153_local1 = Engine[0x8D7B33196264589](f137_arg1)
		local f153_local2 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f137_arg1), "PCConnectionQueue")
		local f153_local3 = Engine[0xA798E4552F5E872](f153_local2, "IsInConnectionQueue")
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
			f153_local3 = Engine[0xA798E4552F5E872](f153_local2, "ConnectionQueuePosition")
			f153_local3:set(Engine[0xA2EB0EF477CB10C]())
			f153_local3 = Engine[0xA798E4552F5E872](f153_local2, "ConnectionQueueRemainingtime")
			f153_local3:set(Engine[0x7A1A5ED0AB5889C]())
		elseif f153_local1.queued then
			f153_local3 = Engine[0xA798E4552F5E872](f153_local2, "ConnectionQueuePosition")
			f153_local3:set(f153_local1.position)
			f153_local3 = Engine[0xA798E4552F5E872](f153_local2, "ConnectionQueueRemainingtime")
			f153_local3:set(f153_local1.estimatedWaitTimeSec)
		end
		if Engine[0xD37197A182D17E1](f137_arg1) or CoD.LobbyUtility.ForceOffline() then
			if Engine[0x9882F293C327557]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) and not f137_arg0.pcQuitOverlayActive then
				f137_arg0.launchSignInTimer:close()
				f137_arg0.ConnectionLabel:playClip("DefaultClip")
				f137_arg0.ConnectionLabel.lblConnecting:setText(LocalizeToUpperString(0x5AC0BDFC731AEDA))
				Engine[0x87AE7E64BA5AD61]("OnGoForward", {
					controller = f137_arg1,
					navToMenu = "director",
				})
			end
		else
			f153_local3 = Engine[0x8DF2E5447F384B9]()
			f153_local3 = f153_local3:create("FreshRestartOccurred", true)
			if f153_local3:get() then
				f137_arg0.ConnectionLabel.lblConnecting:setText(Engine[0xF9F1239CFD921FE](0x27BE553CE368A05))
			end
		end
	end
	local f137_local10 = 0
	if LuaDefine.isPS4 == true and true == Dvar[0x670F1660AB82174]:exists() then
		f137_local10 = Dvar[0x670F1660AB82174]:get()
	end
	if not f137_arg0.launchInvitesHotJoinTimer and not Engine[0x9653F40EBFE8444]() then
		f137_arg0.launchInvitesHotJoinTimer = LUI.UITimer.newElementTimer(f137_local10, true, f137_local8)
		f137_arg0:addElement(f137_arg0.launchInvitesHotJoinTimer)
	end
	if LuaDefine.isPC and not f137_arg0.launchSignInTimer then
		f137_arg0.launchSignInTimer = LUI.UITimer.newElementTimer(400, false, f137_local9)
		f137_arg0:addElement(f137_arg0.launchSignInTimer)
	end
	if LuaDefine.isPC and Engine[0x4D07729ED48730D]() then
		f137_arg0.ConnectionLabel.lblConnecting:setText(Engine[0xF9F1239CFD921FE](0x27BE553CE368A05))
	end
end
CoD.LobbyUtility.SetTextToDurangoSignedInString = function(f154_arg0, f154_arg1)
	f154_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "durango.signedInGamertag", true), function(model)
		if model ~= nil then
			local f155_local0 = Engine[0x614D394F6F9A18D](model)
			if f155_local0 ~= nil and string.len(f155_local0) > 0 then
				f154_arg1:setText(Engine[0xF9F1239CFD921FE](0xFAACA5179AA8A57, f155_local0))
				return
			end
		end
		f154_arg1:setText("")
	end)
end
CoD.LobbyUtility.UpdateOfficialCustomGame = function(f156_arg0, f156_arg1, f156_arg2)
	Engine[0xB4A27DBBE6D51CF](Engine[0xC3DF042E7492B66](f156_arg1), f156_arg2)
end
CoD.LobbyUtility.SocialMainPreLoad = function(f157_arg0, f157_arg1)
	local f157_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "SocialMainMenu")
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f157_local0, "anyChildSelected"), false)
	Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f157_local0, "managePartyButtonText"), "")
	f157_arg0:setModel(f157_local0, f157_arg1)
	f157_arg0.disableLeaderChangePopupShutdown = true
	if not IsInGame() then
		SendClientScriptMenuChangeNotify(f157_arg1, f157_arg0, true)
	end
end
CoD.LobbyUtility.DisbandParty = function(f158_arg0, f158_arg1, f158_arg2)
	local f158_local0 = LobbyData.GetLobbyMenuByID(f158_arg2)
	GoBack(f158_arg0, f158_arg1)
	if f158_local0[0xADEEFEFDA7AD0E3] == LuaEnum.UI.MAIN then
		for f158_local1 = 1, Engine[0xB686A0A723E6442]() - 1, 1 do
			LobbyRemoveLocalClientFromLobby(f158_arg0, f158_local1)
		end
	end
	Engine[0x87AE7E64BA5AD61]("OnManagePartyLeave", {
		controller = f158_arg1,
	})
end
CoD.OverlayUtility.AddAutoDetectOverlay("LobbyLeavePopup", {
	title = function(f159_arg0)
		local f159_local0 = 0x0
		if f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY then
			f159_local0 = 0xB69F71ABEAEC777
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			f159_local0 = 0xE6679EE5787CB48
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY then
			f159_local0 = 0x318119895303B4B
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			f159_local0 = 0xB69F71ABEAEC777
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE then
			f159_local0 = 0x318119895303B4B
		elseif f159_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			f159_local0 = 0x7992FB2AE130417
		end
		return Engine[0xF9F1239CFD921FE](f159_local0)
	end,
	description = function(f160_arg0)
		local f160_local0 = 0x0
		if f160_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY then
			f160_local0 = 0xB543EF9A1104B6E
		elseif f160_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			f160_local0 = 0xEF7BFBB3912534B
		elseif f160_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			f160_local0 = 0xB543EF9A1104B6E
		elseif f160_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			f160_local0 = 0xE47086DBA25578E
		end
		return Engine[0xF9F1239CFD921FE](f160_local0)
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	postCreateStep = function(f161_arg0, f161_arg1)
		f161_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyLockedIn"), function(model)
			if Engine[0x614D394F6F9A18D](model) == true then
				GoBack(f161_arg0, f161_arg1)
			end
		end)
		f161_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.publicLobby.stage"), function(model)
			if LuaUtils.IsArenaPublicGame() and Engine[0x614D394F6F9A18D](model) == LuaEnum.PUBLIC_LOBBY.START_MATCH then
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
				text = 0x4BE8031E505109A,
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = 0xEA3B4895763DFF0,
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = 0xF420F9DB5188F96,
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT, f166_arg1),
				text = 0xACDE687F90ACD0B,
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE then
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITH),
				text = 0x7D920DBE7BE3E1D,
			})
			table.insert(f166_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = 0x7C57347FF991141,
			})
		elseif f166_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			table.insert(f166_local0, {
				action = function(f167_arg0, f167_arg1)
					GoBack(f167_arg0, f167_arg1)
					Engine[0x87AE7E64BA5AD61]("OnManagePartyLeave", {
						controller = f167_arg1,
					})
				end,
				text = 0x349737B0BDAA763,
			})
		end
		table.insert(f166_local0, {
			action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(nil),
			text = 0xE4E9924A266D1FC,
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
		CoD.LobbyUtility.packageEULAButtonData(0xBD872543F8A833, 0x0, nil, function(f171_arg0, f171_arg1, f171_arg2)
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
	table.insert(f169_local0, CoD.LobbyUtility.packageEULAButtonData(0xFD0A4EC72EF5F3F, 0x0, nil, f169_local1))
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
			f174_local5:setText(Engine[0xF9F1239CFD921FE](f174_arg0.__pages[f174_local0].entries[f174_local4]))
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
	stringTable = 0xE6AE9608073C408,
	header = 0x31BE80D5236D780,
	declinePopup = "DeclineEULA",
	disableAcceptUntilReadFct = nil,
}
CoD.LobbyUtility.EULAEnum[2] = {
	prefix = "KPI_",
	stringTable = 0xA0BA87EFF24E71A,
	header = 0xE1564E44E03C6CD,
	declinePopup = "DeclineKPIEULA",
	forKorea = true,
	disableAcceptUntilReadFct = CoD.LobbyUtility.ShouldForceReadAllPages,
}
CoD.LobbyUtility.EULAEnum[3] = {
	prefix = "KPIO_",
	stringTable = 0xA0BA87EFF24E71A,
	header = 0xE1FAC29E6397460,
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
		f176_arg2.Header:setText(Engine[0xF9F1239CFD921FE](CoD.LobbyUtility.EULAEnum[f176_local1].header))
	end
	if not f176_arg0.__entries then
		f176_arg0.__entries = {}
	end
	local f176_local2 = {}
	local f176_local3 = nil
end
CoD.LobbyUtility.SetPlayerLocation = function(f177_arg0, f177_arg1)
	Engine[0x1D2E041DAB54785](f177_arg0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f177_arg1)
end
CoD.LobbyUtility.AllMembersInFrontend = function()
	local f178_local0 = Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
	local f178_local1 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	local f178_local2 = Engine[0x755D55B3813D249](f178_local0, f178_local1)
	local f178_local3 = Engine[0xE00882E35AF63D2](f178_local0, f178_local1)
	for f178_local7, f178_local8 in pairs(f178_local2.sessionClients) do
		local f178_local9 = f178_local3.partyLocations[f178_local8.clientNum + 1]
		if f178_local9 ~= nil and f178_local9 ~= Enum[0xC0AB9543C5C440B][0x755065F5A0B7FB0] then
			return false
		end
	end
	return true
end
CoD.LobbyUtility.AllMembersCanRedeploy = function()
	local f179_local0 = Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
	local f179_local1 = Enum[0xBF54BE1BB3D618B][0xA1647599284110]
	local f179_local2 = Engine[0x755D55B3813D249](f179_local0, f179_local1)
	local f179_local3 = Engine[0xE00882E35AF63D2](f179_local0, f179_local1)
	for f179_local7, f179_local8 in pairs(f179_local2.sessionClients) do
		local f179_local9 = f179_local3.partyLocations[f179_local8.clientNum + 1]
		if f179_local9 ~= nil and f179_local9 ~= Enum[0xC0AB9543C5C440B][0x755065F5A0B7FB0] and f179_local9 ~= Enum[0xC0AB9543C5C440B][0xB4603B82CB82E77] and f179_local9 ~= Enum[0xC0AB9543C5C440B][0x9B478094C85DBBB] then
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
	local f182_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyNav")
	local f182_local1 = f182_local0 and Engine[0x614D394F6F9A18D](f182_local0)
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
	f183_arg0:setText(Engine[0xF9F1239CFD921FE](0xA205700391CF3AD, f183_local0.CurrentEULAPage:get(), f183_local0.MaxEULAPage:get()))
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
	local f186_local0 = Engine[0x8DF2E5447F384B9]()
	f186_local0 = f186_local0:create("lobbyRoot.lobbyVMCreateOverlayController")
	f186_local0:set(f186_arg0)
	f186_local0 = Engine[0x8DF2E5447F384B9]()
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
	if Engine[0xCB675CA7856DA25]() and CoD.CoDAccountUtility.IsTrialAccountFeatureEnabled() and CoD.CoDAccountUtility.IsAccountFeatureEnabled(f187_arg1) then
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
	Engine[0x3EEA9852DCD27E7](f192_arg1)
	if IsLive() and not IsUserContentRestricted(f192_arg0) then
		CoD.perController[f192_arg0].uploadProfile = true
		Engine[0x34A08EAF3D9417A](f192_arg0)
		local f192_local0 = CoD.BlackMarketTableUtility.LootInfoLookup(f192_arg0, CoD.BlackMarketUtility.GetLootBackgroundName(f192_arg0, f192_arg1), nil)
		if f192_local0 and f192_local0.isLoot and f192_local0.itemId then
			Engine[0xDE279ECDDDD966](f192_arg0, 0x4F639DE6E9A6066, {
				[0xAB83A8CC61E6325] = f192_local0.itemId,
			})
		end
	else
		Engine[0x280E4C1191CC53D](f192_arg0, "default_background_index", f192_arg1)
		Engine[0x2D0B221710560E9](f192_arg0, f192_arg1)
	end
end
CoD.LobbyUtility.CompleteFirstTimeBrightness = function(f193_arg0, f193_arg1)
	CoD.LobbyUtility.CompleteFirstTimeFlow(f193_arg0, f193_arg1)
end
CoD.LobbyUtility.CompleteFirstTimeFlow = function(f194_arg0, f194_arg1)
	SetProfileVar(f194_arg1, "com_first_time", 0)
	local f194_local0 = Engine[0x4DF5CFBC1771947](f194_arg1)
	f194_local0 = f194_local0:create("defaultBackgroundNeeded")
	f194_local0 = f194_local0:get()
	if f194_local0 then
		CoD.LobbyUtility.SetEmblemBackground_Internal(f194_arg1, f194_local0)
	end
	UpdateGamerprofile(f194_arg0, f194_arg0, f194_arg1)
	Engine[0xD8D417082862655]()
	local f194_local1 = Engine[0x8DF2E5447F384B9]()
	f194_local1.lobbyRoot.closePopups:forceNotifySubscriptions()
	ForceNotifyGlobalModel(f194_arg1, "mainFirstTimeFlowComplete")
end
CoD.LobbyUtility.IsPlayerInMyParty = function(f195_arg0)
	local f195_local0 = Engine[0x755D55B3813D249](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
	for f195_local4, f195_local5 in ipairs(f195_local0.sessionClients) do
		if f195_local5.xuid == f195_arg0 then
			return true
		end
	end
	return false
end
CoD.OverlayUtility.AddAutoDetectOverlay("DeclineEULA", {
	title = 0xDAE50568F833334,
	description = 0x53558889BC2A324,
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	options = function()
		return {
			{
				action = GoBack,
				text = 0x5BE4A02B20F31F1,
				isCancelOption = true,
			},
			{
				action = function()
					Engine[0x7C75E608EA39B5C](Engine[0xA5B9C0111291A8B](), "quit")
				end,
				text = 0xB2EF56B4AF147B8,
			},
		}
	end,
})
CoD.OverlayUtility.AddAutoDetectOverlay("DeclineKPIEULA", {
	title = 0x847E0849B2BD127,
	description = 0x499380188085A83,
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	options = function()
		return {
			{
				action = GoBack,
				text = 0x5BE4A02B20F31F1,
				isCancelOption = true,
			},
			{
				action = function()
					Engine[0x7C75E608EA39B5C](Engine[0xA5B9C0111291A8B](), "quit")
				end,
				text = 0xB2EF56B4AF147B8,
			},
		}
	end,
})
CoD.OverlayUtility.AddAutoDetectOverlay("DeclineKPIOEULA", {
	title = 0x1F231B2C83CEA54,
	description = 0x828AE232A499144,
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	options = function()
		return {
			{
				action = GoBack,
				text = 0x5BE4A02B20F31F1,
				isCancelOption = true,
			},
			{
				action = function()
					Engine[0x7C75E608EA39B5C](Engine[0xA5B9C0111291A8B](), "quit")
				end,
				text = 0xB2EF56B4AF147B8,
			},
		}
	end,
})
CoD.LobbyUtility.Presence = {}
CoD.LobbyUtility.Presence.Strings = {
	[Enum[0x4BBA402DE649132][0x1CF21FD793411B9]] = 0xFD86E09666FBFFC,
	[Enum[0x4BBA402DE649132][0xA2184EBB293AF2D]] = 0x3C11BD55E8A933E,
	[Enum[0x4BBA402DE649132][0xC14960E60DA36B7]] = 0x3AE1A6F98E3D0B8,
	[Enum[0x4BBA402DE649132][0x69F9F19327AE3B3]] = 0x3520ACF1FF88175,
	[Enum[0x4BBA402DE649132][0x53A911F86DD9C9B]] = 0xC78AC016652D8A5,
	[Enum[0x4BBA402DE649132][0x9D5EE7754ABD279]] = 0x92CA8D296218C2C,
	[Enum[0x4BBA402DE649132][0xAA283B8037DC205]] = 0x2C79EA24AB1A2BA,
	[Enum[0x4BBA402DE649132][0xF7D12CD08D8C65C]] = 0x3520ACF1FF88175,
	[Enum[0x4BBA402DE649132][0x846A99A50CCC84E]] = 0x3520ACF1FF88175,
	[Enum[0x4BBA402DE649132][0xA4492C005EC75F0]] = 0x40D245780AD8EFF,
	[Enum[0x4BBA402DE649132][0x4E2503E9D4B69C0]] = 0xC78AC016652D8A5,
	[Enum[0x4BBA402DE649132][0xAE25F6D4C969F9E]] = 0x92CA8D296218C2C,
	[Enum[0x4BBA402DE649132][0xBCCA43B72FB5208]] = 0x2103511DF6266F5,
	[Enum[0x4BBA402DE649132][0x9416FBBD255A16A]] = 0xCC924B73B51D3BD,
	[Enum[0x4BBA402DE649132][0xF94CFF7D3FA72DC]] = 0x63C97056B8E55C4,
	[Enum[0x4BBA402DE649132][0x9AFD04B89B9744E]] = 0xAE563A7A5B0AB2D,
	[Enum[0x4BBA402DE649132][0x5064020050B6D74]] = 0x6F3647A52E50BDB,
	[Enum[0x4BBA402DE649132][0x9CA1B7DCE359D28]] = 0x6481DE3D57CE651,
	[Enum[0x4BBA402DE649132][0xE35ED0592F0886A]] = 0x35D9608916969B3,
	[Enum[0x4BBA402DE649132][0x3DDB5074B337D14]] = 0x3520ACF1FF88175,
	[Enum[0x4BBA402DE649132][0x48AC07729D7006]] = 0x3520ACF1FF88175,
	[Enum[0x4BBA402DE649132][0x70200988C735128]] = 0x40D245780AD8EFF,
	[Enum[0x4BBA402DE649132][0x487C6ABC12117D8]] = 0xC78AC016652D8A5,
	[Enum[0x4BBA402DE649132][0xF5DADE95366AFF6]] = 0x92CA8D296218C2C,
	[Enum[0x4BBA402DE649132][0xFD787C9BCCFE500]] = 0x2103511DF6266F5,
	[Enum[0x4BBA402DE649132][0x322CC5E9D503B12]] = 0xE906EBFDA3FF04,
	[Enum[0x4BBA402DE649132][0x36C3C9302013104]] = 0x4A6A1D33B52A740,
	[Enum[0x4BBA402DE649132][0x4871D036CE76516]] = 0x75B35B49A96EFDA,
	[Enum[0x4BBA402DE649132][0x23458C8FB915CDC]] = 0x6F3647A52E50BDB,
	[Enum[0x4BBA402DE649132][0x55B49B47C060CDE]] = 0x3520ACF1FF88175,
	[Enum[0x4BBA402DE649132][0x3B9C9B68663386E]] = 0xC78AC016652D8A5,
	[Enum[0x4BBA402DE649132][0xF21EC063EDFC550]] = 0x92CA8D296218C2C,
	[Enum[0x4BBA402DE649132][0x252AA84DE65D0E2]] = 0x2C79EA24AB1A2BA,
	[Enum[0x4BBA402DE649132][0xCD26F398D441822]] = 0x2C79EA24AB1A2BA,
	[Enum[0x4BBA402DE649132][0x4FB5F3E62DDDF50]] = 0xD5F01774DFDA821,
	[Enum[0x4BBA402DE649132][0xA117D3D5821AF0A]] = 0x6F3647A52E50BDB,
	[Enum[0x4BBA402DE649132][0x73359042AA77776]] = 0xAAB6370A22F9E55,
	[Enum[0x4BBA402DE649132][0x8C64A84CA98015B]] = 0x88B5B64AD126EDE,
	[Enum[0x4BBA402DE649132][0xFB997F24F594F52]] = 0x218D47DD1A2EE91,
	[Enum[0x4BBA402DE649132][0xF202C4DB22E15DE]] = 0x92CA8D296218C2C,
	[Enum[0x4BBA402DE649132][0xB076B46FC30D568]] = 0x24D4DF6975546DD,
	[Enum[0x4BBA402DE649132][0xBDCE30A7024A319]] = 0xD91FECC419D0400,
	[Enum[0x4BBA402DE649132][0xA1D6A588ADE03B0]] = 0x981253B1F6E0BA1,
	[Enum[0x4BBA402DE649132][0x1E7C2C9963D2B4]] = 0x6F3647A52E50BDB,
	[Enum[0x4BBA402DE649132][0x89F4CB04C20BE96]] = 0x24D4DF6975546DD,
	[Enum[0x4BBA402DE649132][0x1F2CBBDAF02CDFB]] = 0xACC1029BFF9174E,
	[Enum[0x4BBA402DE649132][0xAA08BA358D14172]] = 0x243160288C38B7D,
	[Enum[0x4BBA402DE649132][0x86162EAB3E6939C]] = 0x3520ACF1FF88175,
	[Enum[0x4BBA402DE649132][0x42CB93800EAED30]] = 0x40D245780AD8EFF,
	[Enum[0x4BBA402DE649132][0x5E4D2D4F9A91A00]] = 0xC78AC016652D8A5,
	[Enum[0x4BBA402DE649132][0xF2F56EC63267A1C]] = 0x4413BDC981E0771,
	[Enum[0x4BBA402DE649132][0x162324AB992F8E]] = 0xD5F01774DFDA821,
	[Enum[0x4BBA402DE649132][0xCC36D9470CB113F]] = 0xFEBD7559DBB565,
	[Enum[0x4BBA402DE649132][0xF69882510317719]] = 0xCE604E6624429F1,
	[Enum[0x4BBA402DE649132][0x1F17820D60C1F7A]] = 0x21903C9A98D92F,
	[Enum[0x4BBA402DE649132][0x60BE5FE42385C84]] = 0xB9F19808502EFE9,
	[Enum[0x4BBA402DE649132][0x62EDA3666404E5D]] = 0xB93203A76233CE0,
	[Enum[0x4BBA402DE649132][0x6C12798671429E7]] = 0x52D3959032D935E,
	[Enum[0x4BBA402DE649132][0x72BAB5AA810756E]] = 0x83AA94BEC077E03,
	[Enum[0x4BBA402DE649132][0xF7B2CBB47A1ED07]] = 0xB11E3D5271BE6B4,
	[Enum[0x4BBA402DE649132][0xF1310916FF8A442]] = 0x2BB8EB52A843649,
}
CoD.LobbyUtility.Presence.ActivityStrings = {}
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x49372DE9D3CE680]] = 0x2C79EA24AB1A2BA
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x14916BC7C01AE13]] = 0x2C79EA24AB1A2BA
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x5BC71242ADF26CC]] = 0x3520ACF1FF88175
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x6A0F2DC99ADE81B]] = 0x92A0F337939C195
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x570428F1E5F8185]] = 0xB305AF9F0693803
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xCBE4F2CD15105C6]] = 0xD5F01774DFDA821
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x1AEAA695AC5EB0D]] = 0x3AE1A6F98E3D0B8
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x64B773BEE133CC6]] = 0x1A908EC9526CC29
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xC1055BC2928B2D4]] = 0x1A908EC9526CC29
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xA7679ECD147AF59]] = 0xF9E775C80FA4687
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xC6805A87801C6CB]] = 0xEF88B1188106EC9
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x4A334D45185F6B]] = 0x3520ACF1FF88175
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xE81D8707024075]] = 0x6F3647A52E50BDB
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x7AA83AC0476244F]] = 0x92A0F337939C195
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xF73EB38F67244F1]] = 0xB305AF9F0693803
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xFE206CCBAD07FC3]] = 0xD5F01774DFDA821
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x748FD38908AA0FD]] = 0xE906EBFDA3FF04
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xDAC8680E83AD8E1]] = 0x3520ACF1FF88175
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x4BF289EF1DBD8B]] = 0x6F3647A52E50BDB
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x82E58F1EADE5729]] = 0x92A0F337939C195
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x273A3389A55D9BF]] = 0xB305AF9F0693803
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xF20A53DB89C94ED]] = 0xD5F01774DFDA821
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x28985D4608133B3]] = 0x252D497455C5FA9
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xFE56E96047E83F9]] = 0x3520ACF1FF88175
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x5F246C347394203]] = 0x6F3647A52E50BDB
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x8E137C5AAD633B1]] = 0x92A0F337939C195
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0xB1D628ACB5DE257]] = 0xB305AF9F0693803
CoD.LobbyUtility.Presence.ActivityStrings[Enum[0xD75FB136CB17239][0x20647E009460DD5]] = 0xD5F01774DFDA821
CoD.LobbyUtility.Presence.StickyLobbyStrings = {}
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[0xC0AB9543C5C440B][0xA084EA6923C3B80]] = 0xB83F54F0B0CE513
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[0xC0AB9543C5C440B][0xFA6FA0C00230DEE]] = 0xD1FA62620BF6CEF
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[0xC0AB9543C5C440B][0x9B478094C85DBBB]] = 0x372605BCEEE5BA6
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[0xC0AB9543C5C440B][0xB4603B82CB82E77]] = 0xDDA6F3E65A0982
CoD.LobbyUtility.Presence.StickyLobbyStrings[Enum[0xC0AB9543C5C440B][0x755065F5A0B7FB0]] = 0x2E37D5A62344333
CoD.LobbyUtility.Presence.ContextStrings = {}
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0x6E648D86CF25777]] = 0x2C79EA24AB1A2BA
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0xD1D271B16CBDECF]] = 0x2C79EA24AB1A2BA
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0xEC5714B2997955E]] = 0xF3575BD58460BDC
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0xAB43F5FC3B1D47F]] = 0x88013D573A07266
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0x6E5169843F8060A]] = 0xEAC49902CCFCAF3
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0x83133B37DEC6C0E]] = 0x708123409640966
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0x13019B8A3BE3E0C]] = 0x6747795A62485EE
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0x388C548A4995338]] = 0x8008E04FE1D817A
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0xEB6BF23C3E8DF40]] = 0x8B34A5CFCA886A7
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0x2F025C1C623F80C]] = 0x708123409640966
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0x8F23A57DC88F890]] = 0x678F90B79774906
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0xBCFE38DE82A3E19]] = 0xFC98B88B9F75E67
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0x646D62F4F2FF73C]] = 0xE3EA8C15139713A
CoD.LobbyUtility.Presence.ContextStrings[Enum[0x51366F188DF5EA1][0xD6554BF1FA271B8]] = 0x708123409640966
CoD.LobbyUtility.Presence.LobbyJoinableStrings = {}
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0x449F4A7CB58D3D5]] = 0xD87E6B6018DC30E
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0x1FD2A499E7CD0E4]] = 0x6AA4BA2A90A62C5
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0xBFB4278A2E811D]] = 0x673F902643F6CCD
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0x6252239318EF8A5]] = 0x1D91C1D7F730F13
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0xF8870754F7796AF]] = 0x88841DDF008ECA1
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0x955305BD7650757]] = 0x8D705C1E446FC4B
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0x1B38B4C01EB9883]] = 0x5BD624A06A9D489
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0x16101102656B523]] = 0x14CF094EFFE712A
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0x5CB4C01F97AE708]] = 0xA3EF629E735A81E
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0xFEE30D662E77AAE]] = 0x34F5097A432DED7
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0xF610D3F1267C9DD]] = 0x92AE67FCEA8248A
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0x8FCE6A0B08CD559]] = 0x4D26561B845EA8
CoD.LobbyUtility.Presence.LobbyJoinableStrings[Enum[0xCA6AE10CC343A4F][0xC47680CFC712B91]] = 0xE55CA0039948577
