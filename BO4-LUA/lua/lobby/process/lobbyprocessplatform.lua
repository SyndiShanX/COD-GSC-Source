require("x64:8fd3bbfccedd522")
require("x64:b8ea4f0a93b4f76")
Lobby.ProcessPlatform = {}
Lobby.ProcessPlatform.PS4AcceptInvite = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	Engine[@"lobbylaunchclear"]()
	local f1_local0 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local1 = function()
		if not f1_local0 and Engine[@"getlobbyuiscreen"]() == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.MAIN) then
			local f2_local0 = 0
			for f2_local1 = 0, LuaDefine.MAX_CONTROLLER_COUNT - 1, 1 do
				if Engine[@"isuseractive"](f2_local1) then
					f2_local0 = f2_local0 + 1
				end
			end
			if f2_local0 == 0 or Engine[@"getprimarycontroller"]() ~= f1_arg0 then
				Engine[@"activateprimarylocalclient"](f1_arg0)
			end
		end
	end
	f1_arg0 = Engine[@"getprimarycontroller"]()
	local f1_local2 = function()
		Engine[@"deactivatealllocalclients"]()
	end
	local f1_local3 = function()
		Lobby.Timer.HostingLobbyEnd({
			lobbyType = Enum[@"lobbytype"][@"lobby_type_game"],
		})
	end
	local f1_local4 = function()
		Engine[@"platformsessionclearinvitejoininfo"]()
	end
	local f1_local5 = function()
		Engine[@"liveplatformsessiondisableinvitehotjoin"]()
		LobbyVM.ExecuteLobbyVMCreateOverlay(f1_arg0, "EULA")
	end
	if Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_invalid"] then
		local f1_local6 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
	end
	if LuaUtils.OnlineOnlyDemo() == true then
		local f1_local6 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"]
	end
	if LuaUtils.OfflineOnlyDemo() == true then
		local f1_local6 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
	end
	local f1_local7 = f1_local6 == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
	local f1_local8 = LuaUtils.ConnectingToDemonwareMaxWaitTime()
	local f1_local9 = function()
		return Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	end
	local f1_local10 = 6
	if f1_local0 == true then
		f1_local10 = Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	end
	local f1_local11 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE)
	if f1_local6 == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] then
		f1_local11 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN)
	end
	local f1_local12 = Lobby.Process.ReloadPrivateLobby(f1_arg0, f1_local6, f1_local11)
	local f1_local13 = Lobby.Actions.LobbySettings(f1_arg0, f1_local11)
	local f1_local14 = Lobby.Actions.UpdateUI(f1_arg0, f1_local11)
	local f1_local15 = Lobby.Process.ReloadPrivateLobby(f1_arg0, f1_local6, f1_local11)
	local f1_local16 = Lobby.Actions.LobbySettings(f1_arg0, f1_local11)
	local f1_local17 = Lobby.Actions.UpdateUI(f1_arg0, f1_local11)
	local f1_local18 = Lobby.Process.ReloadPrivateLobby(f1_arg0, f1_local6, f1_local11)
	local f1_local19 = Lobby.Actions.LobbySettings(f1_arg0, f1_local11)
	local f1_local20 = Lobby.Actions.UpdateUI(f1_arg0, f1_local11)
	local f1_local21 = Lobby.Process.ReloadPrivateLobby(f1_arg0, f1_local6, f1_local11)
	local f1_local22 = Lobby.Actions.LobbySettings(f1_arg0, f1_local11)
	local f1_local23 = Lobby.Actions.UpdateUI(f1_arg0, f1_local11)
	local f1_local24 = Lobby.Actions.OpenSpinner(nil, true)
	local f1_local25 = Lobby.Actions.CloseSpinnerAllowJoining()
	local f1_local26 = Lobby.Actions.CloseSpinnerAllowJoining()
	f1_local26.name = f1_local26.name .. "Error"
	local f1_local27 = Lobby.Actions.CloseSpinner()
	f1_local27.name = f1_local27.name .. "NeedsGlobalFirstTimeFlow"
	local f1_local28 = Lobby.Actions.CloseSpinnerAllowJoining()
	f1_local28.name = f1_local28.name .. "CannotPlayOnline"
	local f1_local29 = Lobby.Actions.CloseSpinnerAllowJoining()
	f1_local29.name = f1_local29.name .. "InviteBlocked"
	local f1_local30 = Lobby.Actions.CloseSpinnerAllowJoining()
	f1_local30.name = f1_local30.name .. "NeedsFirstTimeFlow"
	local f1_local31 = Lobby.Actions.CloseSpinnerAllowJoining()
	f1_local31.name = f1_local31.name .. "RecoverError"
	local f1_local32 = Lobby.Actions.CloseSpinnerAllowJoining()
	f1_local32.name = f1_local32.name .. "RecoverErrorJoin"
	local f1_local33 = Lobby.Actions.CloseSpinnerAllowJoining()
	f1_local33.name = f1_local33.name .. "RecoverSearchError"
	local f1_local34 = Lobby.Actions.EmptyAction()
	local f1_local35 = Lobby.Actions.ExecuteScript(f1_local4)
	local f1_local36 = Lobby.Actions.ExecuteScript(f1_local4)
	local f1_local37 = Lobby.Actions.ExecuteScript(f1_local4)
	local f1_local38 = Lobby.Actions.ExecuteScript(f1_local4)
	local f1_local39 = Lobby.Actions.ExecuteScript(f1_local4)
	local f1_local40 = Lobby.Actions.ExecuteScript(f1_local4)
	local f1_local41 = Lobby.Actions.ExecuteScript(f1_local4)
	local f1_local42 = Lobby.Actions.ExecuteScript(f1_local4)
	local f1_local43 = Lobby.Actions.ExecuteScript(f1_local5)
	local f1_local44 = {}
	if Engine[@"getusedcontrollercount"]() > 1 then
		local f1_local45 = 1
		for f1_local46 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			local f1_local49 = f1_local46 - 1
			if Engine[@"isuseractive"](f1_local49) then
				f1_local44[f1_local45] = Lobby.Actions.CanPlayOnline(f1_local49)
				f1_local45 = f1_local45 + 1
			end
		end
	else
		f1_local44[1] = Lobby.Actions.CanPlayOnline(f1_arg0)
	end
	local f1_local45 = Lobby.Actions.ConnectingToDemonware(f1_arg0, f1_local8, true)
	local f1_local46 = Lobby.Actions.CheckGlobalFirstTimeFlowRequirements(f1_arg0)
	local f1_local47 = Lobby.Actions.CanAcceptPlatformInvite(f1_arg0)
	local f1_local48 = Lobby.Actions.ErrorPopupMsg(@"menu/update_needed")
	local f1_local50 = Lobby.Actions.ExecuteScript(f1_local1)
	local f1_local49 = Lobby.Actions.ExecuteScript(f1_local2)
	local f1_local51 = Lobby.Actions.ExecuteScript(f1_local3)
	local f1_local52 = Lobby.Actions.ForceLobbyUIScreen(f1_arg0, LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE))
	local f1_local53 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f1_local54 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f1_local55 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local56 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local57 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f1_local58 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f1_local59 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local60 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local61 = Lobby.Actions.PlatformSessionGetReceivedInvitation(f1_arg0, f1_arg1, Enum[@"lobbytype"][@"lobby_type_private"], f1_arg2)
	local f1_local62 = Lobby.Actions.PlatformSessionGetSessionInfo(f1_arg0, f1_arg1, Enum[@"lobbytype"][@"lobby_type_private"], f1_arg3, f1_local61.info)
	local f1_local63 = Lobby.Actions.GamertagsToXuids(f1_arg0, f1_local62)
	local f1_local64 = Lobby.Actions.LobbyInfoProbe(f1_arg0, f1_local63)
	local f1_local65 = Lobby.Actions.CheckRestrictedClients(f1_arg0, f1_local64)
	local f1_local66 = Lobby.Actions.CheckFirstTimeFlowRequirements(f1_arg0, f1_local64)
	local f1_local67 = Lobby.Actions.ShowFirstTimeFlowError(f1_arg0, f1_local66)
	local f1_local68 = Lobby.Actions.LobbyJoinXUID(f1_arg0, f1_local63, f1_arg4)
	local f1_local69 = Lobby.Actions.ErrorPopup(f1_local68)
	local f1_local70 = Lobby.Actions.ExecuteScriptWithReturn(f1_local9, true, false, false)
	local f1_local71 = Lobby.Actions.LobbyJoinXUIDExt(f1_arg0, Enum[@"jointype"][@"join_type_party"], f1_local64, Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local72 = Lobby.Actions.ErrorPopup(f1_local71)
	local f1_local73 = Lobby.Actions.LobbyJoinXUIDExt(f1_arg0, Enum[@"jointype"][@"join_type_party"], f1_local64, Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local74 = Lobby.Actions.LobbyHostStart(f1_arg0, Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbymode"][@"lobby_mode_invalid"], f1_local10, "", "")
	local f1_local75 = Lobby.Actions.LobbyHostAddPrimary(Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local76 = Lobby.Actions.LobbyClientStart(Enum[@"lobbytype"][@"lobby_type_private"])
	local f1_local77 = Lobby.Actions.AsyncMatchmakingJoinCheck(f1_local64)
	local f1_local78 = Lobby.Actions.AsyncMatchmakingWaitTillHostHasAllTokens(10000)
	local f1_local79 = Lobby.Actions.AsyncMatchmakingStartSearch(f1_arg0, Engine[@"numbertouint64"](40000), f1_local64)
	local f1_local80 = Lobby.Actions.AsyncMatchmakingWaitToComplete(f1_local79)
	local f1_local81 = Lobby.Actions.ErrorPopup(f1_local80)
	local f1_local82 = Lobby.Actions.AsyncMatchmakingCancel(f1_arg0, Engine[@"numbertouint64"](40000), f1_local79)
	local f1_local83 = Lobby.Actions.WaitForJoiningClients(5000)
	local f1_local84 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_join"])
	end
	local f1_local85 = function()
		if Engine[@"hash_686E64DD1C270046"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]), f1_arg1) then
			Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
			return false
		else
			return true
		end
	end
	local f1_local86 = Lobby.Actions.ExecuteScript(f1_local84)
	f1_local86.name = "preventPlayerJoining"
	local f1_local87 = Lobby.Actions.ExecuteScript(f1_local85)
	f1_local87.name = "didPlayerJoinUs"
	local f1_local88 = {
		head = f1_local24,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true,
	}
	Lobby.Process.ForceAction(f1_local24, f1_local50)
	local f1_local89 = f1_local50
	for f1_local90 = 1, #f1_local44, 1 do
		Lobby.Process.AddActions(f1_local89, f1_local44[f1_local90], f1_local26, f1_local26)
		f1_local89 = f1_local44[f1_local90]
	end
	Lobby.Process.AddActions(f1_local89, f1_local51, f1_local28, f1_local28)
	Lobby.Process.AddActions(f1_local51, f1_local45, f1_local26, f1_local26)
	Lobby.Process.AddActions(f1_local45, f1_local46, f1_local26, f1_local26)
	Lobby.Process.AddActions(f1_local46, f1_local47, f1_local27, f1_local27)
	Lobby.Process.AddActions(f1_local47, f1_local34, f1_local29, f1_local29)
	f1_local89 = f1_local34
	if f1_local7 then
		Lobby.Process.ForceAction(f1_local89, f1_local52)
		Lobby.Process.ForceAction(f1_local52, f1_local53)
		Lobby.Process.ForceAction(f1_local53, f1_local54)
		Lobby.Process.ForceAction(f1_local54, f1_local55)
		Lobby.Process.ForceAction(f1_local55, f1_local56)
		f1_local89 = f1_local56
	end
	Lobby.Process.AddActions(f1_local89, f1_local57, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local57, f1_local58, f1_local31, f1_local31)
	f1_local89 = f1_local58
	if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"]) then
		Lobby.Process.AddActions(f1_local89, f1_local59, f1_local31, f1_local31)
		f1_local89 = f1_local59
		if Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) then
			Lobby.Process.AddActions(f1_local89, f1_local60, f1_local31, f1_local31)
			f1_local89 = f1_local60
		end
	end
	Lobby.Process.AddActions(f1_local89, f1_local74, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local74, f1_local75, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local75, f1_local76, f1_local31, f1_local31)
	lastaction = f1_local76
	if f1_arg2 ~= nil then
		Lobby.Process.AddActions(f1_local76, f1_local61, f1_local31, f1_local31)
		lastaction = f1_local61
	end
	Lobby.Process.AddActions(lastaction, f1_local62, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local62, f1_local63, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local63, f1_local83, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local83, f1_local87, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local87, f1_local86, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local86, f1_local64, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local64, f1_local65, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local65, f1_local66, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local66, f1_local77, f1_local30, f1_local30)
	Lobby.Process.AddActions(f1_local77, f1_local78, f1_local71, f1_local68)
	Lobby.Process.AddActions(f1_local78, f1_local79, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local79, f1_local80, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local80, f1_local25, f1_local33, f1_local33)
	Lobby.Process.AddActions(f1_local68, f1_local35, f1_local32, f1_local32)
	Lobby.Process.AddActions(f1_local35, f1_local70, f1_local31, f1_local31)
	Lobby.Process.AddActions(f1_local70, f1_local73, f1_local25, f1_local25)
	Lobby.Process.AddActions(f1_local73, f1_local25, f1_local25, f1_local25)
	Lobby.Process.AddActions(f1_local71, f1_local25, f1_local31, f1_local31)
	Lobby.Process.ForceAction(f1_local26, f1_local36)
	Lobby.Process.ForceAction(f1_local36, f1_local72)
	Lobby.Process.ForceAction(f1_local29, f1_local37)
	Lobby.Process.ForceAction(f1_local37, f1_local48)
	Lobby.Process.ForceAction(f1_local30, f1_local38)
	Lobby.Process.ForceAction(f1_local38, f1_local21.head)
	Lobby.Process.ForceAction(f1_local21.tail, f1_local22)
	Lobby.Process.ForceAction(f1_local22, f1_local23)
	Lobby.Process.ForceAction(f1_local23, f1_local67)
	Lobby.Process.ForceAction(f1_local31, f1_local39)
	Lobby.Process.ForceAction(f1_local39, f1_local12.head)
	Lobby.Process.ForceAction(f1_local12.tail, f1_local13)
	Lobby.Process.ForceAction(f1_local13, f1_local14)
	Lobby.Process.ForceAction(f1_local14, f1_local72)
	Lobby.Process.ForceAction(f1_local33, f1_local40)
	Lobby.Process.ForceAction(f1_local40, f1_local15.head)
	Lobby.Process.ForceAction(f1_local15.tail, f1_local16)
	Lobby.Process.ForceAction(f1_local16, f1_local17)
	Lobby.Process.ForceAction(f1_local17, f1_local81)
	Lobby.Process.ForceAction(f1_local32, f1_local41)
	Lobby.Process.ForceAction(f1_local41, f1_local18.head)
	Lobby.Process.ForceAction(f1_local18.tail, f1_local19)
	Lobby.Process.ForceAction(f1_local19, f1_local20)
	Lobby.Process.ForceAction(f1_local20, f1_local69)
	Lobby.Process.ForceAction(f1_local25, f1_local42)
	Lobby.Process.ForceAction(f1_local27, f1_local43)
	return f1_local88
end
Lobby.ProcessPlatform.XboxJoin = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
	Engine[@"lobbylaunchclear"]()
	local f10_local0 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	if Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_invalid"] then
		local f10_local1 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
	end
	if LuaUtils.OnlineOnlyDemo() == true then
		local f10_local1 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"]
	end
	if LuaUtils.OfflineOnlyDemo() == true then
		local f10_local1 = Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
	end
	local f10_local2 = f10_local1 == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
	local f10_local3 = LuaUtils.ConnectingToDemonwareMaxWaitTime()
	if Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_invalid"] then
		f10_local3 = f10_local3 + 30000
	end
	local f10_local4 = function()
		if not f10_local0 then
			Engine[@"activateprimarylocalclient"](f10_arg0)
			Engine[@"durango_trytosetxuidtogpad"](Engine[@"getxuid64"](f10_arg0))
		end
	end
	local f10_local5 = function()
		Engine[@"deactivatealllocalclients"]()
	end
	local f10_local6 = function()
		Engine[@"platformsessionclearinvitejoininfo"]()
	end
	local f10_local7 = function()
		Lobby.Timer.HostingLobbyEnd({
			lobbyType = Enum[@"lobbytype"][@"lobby_type_game"],
		})
	end
	local f10_local8 = function()
		return Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	end
	local f10_local9 = function()
		Engine[@"liveplatformsessiondisableinvitehotjoin"]()
		LobbyVM.ExecuteLobbyVMCreateOverlay(f10_arg0, "EULA")
	end
	local f10_local10 = 6
	if f10_local0 == true then
		f10_local10 = Engine[@"getlobbymaxclients"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	end
	local f10_local11 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_ONLINE)
	if f10_local1 == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] then
		f10_local11 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN_SELECT)
	end
	local f10_local12 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN_SELECT)
	local f10_local13 = Lobby.Process.ReloadPrivateLobby(f10_arg0, f10_local11[@"networkmode"], f10_local11)
	local f10_local14 = Lobby.Actions.LobbySettings(f10_arg0, f10_local11)
	local f10_local15 = Lobby.Actions.UpdateUI(f10_arg0, f10_local11)
	local f10_local16 = Lobby.Process.ReloadPrivateLobby(f10_arg0, f10_local1, f10_local11)
	local f10_local17 = Lobby.Actions.LobbySettings(f10_arg0, f10_local11)
	local f10_local18 = Lobby.Actions.UpdateUI(f10_arg0, f10_local11)
	local f10_local19 = Lobby.Process.ReloadPrivateLobby(f10_arg0, f10_local1)
	local f10_local20 = Lobby.Actions.LobbySettings(f10_arg0, f10_local11)
	local f10_local21 = Lobby.Actions.UpdateUI(f10_arg0, f10_local11)
	local f10_local22 = Lobby.Process.ReloadPrivateLobby(f10_arg0, f10_local1)
	local f10_local23 = Lobby.Actions.LobbySettings(f10_arg0, f10_local12)
	local f10_local24 = Lobby.Actions.UpdateUI(f10_arg0, f10_local12)
	local f10_local25 = Lobby.Actions.CloseSpinner()
	f10_local25.name = f10_local25.name .. "NeedsGlobalFirstTimeFlow"
	local f10_local26 = Lobby.Actions.ExecuteScript(f10_local9)
	local f10_local27 = Lobby.Actions.CheckGlobalFirstTimeFlowRequirements(f10_arg0)
	local f10_local28 = Lobby.Actions.OpenSpinner(nil, true)
	local f10_local29 = Lobby.Actions.CloseSpinnerAllowJoining()
	local f10_local30 = Lobby.Actions.CloseSpinnerAllowJoining()
	f10_local30.name = f10_local30.name .. "CanPlayOnline"
	local f10_local31 = Lobby.Actions.CloseSpinnerAllowJoining()
	f10_local31.name = f10_local31.name .. "RecoverError"
	local f10_local32 = Lobby.Actions.CloseSpinnerAllowJoining()
	f10_local32.name = f10_local32.name .. "RecoverErrorJoin"
	local f10_local33 = Lobby.Actions.CloseSpinnerAllowJoining()
	f10_local33.name = f10_local33.name .. "RecoverSearchError"
	local f10_local34 = {}
	if Engine[@"getusedcontrollercount"]() > 1 then
		local f10_local35 = 1
		for f10_local36 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			local f10_local39 = f10_local36 - 1
			if Engine[@"isuseractive"](f10_local39) and not Engine[@"isuserguest"](f10_local39) then
				f10_local34[f10_local35] = Lobby.Actions.CanPlayOnline(f10_local39)
				f10_local35 = f10_local35 + 1
			end
		end
	else
		f10_local34[1] = Lobby.Actions.CanPlayOnline(f10_arg0)
	end
	local f10_local35 = Lobby.Actions.ExecuteScript(f10_local7)
	local f10_local36 = Lobby.Actions.ConnectingToDemonware(f10_arg0, f10_local3, true)
	local f10_local37 = Lobby.Actions.ExecuteScript(f10_local4)
	local f10_local38 = Lobby.Actions.ExecuteScript(f10_local5)
	local f10_local40 = Lobby.Actions.ForceLobbyUIScreen(f10_arg0, f10_local11[@"id"])
	local f10_local39 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f10_local41 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f10_local42 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f10_local43 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f10_local44 = Lobby.Actions.LeaveWithParty(3000)
	local f10_local45 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f10_local46 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f10_local47 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f10_local48 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f10_local49 = Lobby.Actions.LobbyInfoProbe(f10_arg0, {
		xuid = f10_arg1,
	})
	local f10_local50 = Lobby.Actions.CheckRestrictedClients(f10_arg0, f10_local49)
	local f10_local51 = Lobby.Actions.LobbyJoinXUIDExt(f10_arg0, f10_arg2, f10_local49, Enum[@"lobbytype"][@"lobby_type_count"])
	local f10_local52 = Lobby.Actions.EmptyAction()
	local f10_local53 = Lobby.Actions.ExecuteScriptWithReturn(f10_local8, true, false, false)
	local f10_local54 = Lobby.Actions.LobbyJoinXUIDExt(f10_arg0, Enum[@"jointype"][@"join_type_party"], f10_local49, Enum[@"lobbytype"][@"lobby_type_private"])
	f10_local54.name = f10_local54.name .. "(private)"
	local f10_local55 = Lobby.Actions.LobbyHostStart(f10_arg0, Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbymode"][@"lobby_mode_invalid"], f10_local10, "", "")
	local f10_local56 = Lobby.Actions.LobbyHostAddPrimary(Enum[@"lobbytype"][@"lobby_type_private"])
	local f10_local57 = Lobby.Actions.LobbyClientStart(Enum[@"lobbytype"][@"lobby_type_private"])
	local f10_local58 = Lobby.Actions.AsyncMatchmakingJoinCheck(f10_local49)
	local f10_local59 = Lobby.Actions.AsyncMatchmakingWaitTillHostHasAllTokens(10000)
	local f10_local60 = Lobby.Actions.AsyncMatchmakingStartSearch(f10_arg0, Engine[@"numbertouint64"](40000), f10_local49)
	local f10_local61 = Lobby.Actions.AsyncMatchmakingWaitToComplete(f10_local60)
	local f10_local62 = Lobby.Actions.AsyncMatchmakingCancel(f10_arg0, Engine[@"numbertouint64"](40000), f10_local60)
	local f10_local63 = Lobby.Actions.ErrorPopup(f10_local61)
	local f10_local64 = Lobby.Actions.ExecuteScript(f10_local6)
	local f10_local65 = Lobby.Actions.ExecuteScript(f10_local6)
	local f10_local66 = Lobby.Actions.ExecuteScript(f10_local6)
	local f10_local67 = Lobby.Actions.ExecuteScript(f10_local6)
	local f10_local68 = Lobby.Actions.ExecuteScript(f10_local6)
	local f10_local69 = Lobby.Actions.ExecuteScript(f10_local6)
	local f10_local70 = Lobby.Actions.WaitForJoiningClients(5000)
	local f10_local71 = Lobby.Actions.ExecuteScript(function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_join"])
	end)
	f10_local71.name = "preventPlayerJoining"
	local f10_local72 = Lobby.Actions.ExecuteScript(function()
		if Engine[@"hash_686E64DD1C270046"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]), f10_arg1) then
			Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
			return false
		else
			return true
		end
	end)
	f10_local72.name = "didPlayerJoinUs"
	local f10_local73 = Lobby.Actions.CloseSpinnerAllowJoining()
	local f10_local74 = Lobby.Actions.ErrorPopup(f10_local51)
	local f10_local75 = Lobby.Actions.ErrorPopup(f10_local54)
	local f10_local76 = f10_arg3 == LuaEnum.LEAVE_WITH_PARTY.WITH
	local f10_local77 = Engine[@"isingame"]()
	local f10_local78 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"])
	local f10_local79 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f10_local80 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"])
	local f10_local81 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"])
	local f10_local82 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	local f10_local83 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	local f10_local84 = false
	local f10_local85 = false
	local f10_local86 = false
	local f10_local87 = false
	if f10_local77 == true then
		f10_local84 = true
		f10_local85 = true
		f10_local86 = true
		if f10_local80 == true then
			f10_local87 = true
		end
	elseif f10_local79 == true then
		f10_local84 = true
		f10_local85 = true
		if f10_local76 == false then
			f10_local86 = true
			if f10_local80 == true then
				f10_local87 = true
			end
		end
	elseif f10_local78 == true then
		if f10_local76 == false then
			f10_local86 = true
			if f10_local80 == true then
				f10_local87 = true
			end
		end
	else
		f10_local84 = true
		f10_local85 = true
		f10_local86 = true
		f10_local87 = true
	end
	local f10_local88 = {
		head = f10_local28,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true,
	}
	Lobby.Process.ForceAction(f10_local28, f10_local37)
	local f10_local89 = f10_local37
	for f10_local90 = 1, #f10_local34, 1 do
		Lobby.Process.AddActions(f10_local89, f10_local34[f10_local90], f10_local30, f10_local30)
		f10_local89 = f10_local34[f10_local90]
	end
	Lobby.Process.AddActions(f10_local89, f10_local35, f10_local30, f10_local30)
	Lobby.Process.AddActions(f10_local35, f10_local36, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local36, f10_local27, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local27, f10_local52, f10_local25, f10_local25)
	f10_local89 = f10_local52
	if f10_local2 then
		Lobby.Process.ForceAction(f10_local89, f10_local40)
		Lobby.Process.ForceAction(f10_local40, f10_local39)
		Lobby.Process.ForceAction(f10_local39, f10_local41)
		Lobby.Process.ForceAction(f10_local41, f10_local42)
		Lobby.Process.ForceAction(f10_local42, f10_local43)
		f10_local89 = f10_local43
	end
	if f10_local79 == true and f10_local76 == true then
		Lobby.Process.AddActions(f10_local89, f10_local44, f10_local31, f10_local31)
		f10_local89 = f10_local44
	end
	if f10_local84 == true then
		Lobby.Process.AddActions(f10_local89, f10_local47, f10_local31, f10_local31)
		f10_local89 = f10_local47
	end
	if f10_local85 == true then
		Lobby.Process.AddActions(f10_local89, f10_local48, f10_local31, f10_local31)
		f10_local89 = f10_local48
	end
	if f10_local86 == true then
		Lobby.Process.AddActions(f10_local89, f10_local45, f10_local31, f10_local31)
		f10_local89 = f10_local45
	end
	if f10_local87 == true then
		Lobby.Process.AddActions(f10_local89, f10_local46, f10_local31, f10_local31)
		f10_local89 = f10_local46
	end
	if f10_local80 == false or f10_local87 == true then
		Lobby.Process.AddActions(f10_local89, f10_local55, f10_local31, f10_local31)
		Lobby.Process.AddActions(f10_local55, f10_local56, f10_local31, f10_local31)
		f10_local89 = f10_local56
	end
	if f10_local86 == true then
		Lobby.Process.AddActions(f10_local89, f10_local57, f10_local31, f10_local31)
		f10_local89 = f10_local57
	end
	Lobby.Process.AddActions(f10_local89, f10_local70, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local70, f10_local72, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local72, f10_local71, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local71, f10_local49, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local49, f10_local50, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local50, f10_local58, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local58, f10_local59, f10_local54, f10_local51)
	Lobby.Process.AddActions(f10_local59, f10_local60, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local60, f10_local61, f10_local31, f10_local31)
	Lobby.Process.AddActions(f10_local61, f10_local29, f10_local33, f10_local33)
	Lobby.Process.AddActions(f10_local51, f10_local53, f10_local32, f10_local32)
	Lobby.Process.AddActions(f10_local53, f10_local54, f10_local64, f10_local64)
	Lobby.Process.AddActions(f10_local54, f10_local64, f10_local31, f10_local31)
	Lobby.Process.ForceAction(f10_local64, f10_local29)
	Lobby.Process.ForceAction(f10_local30, f10_local66)
	Lobby.Process.ForceAction(f10_local66, f10_local22.head)
	Lobby.Process.ForceAction(f10_local22.tail, f10_local23)
	Lobby.Process.ForceAction(f10_local23, f10_local24)
	Lobby.Process.ForceAction(f10_local31, f10_local67)
	Lobby.Process.ForceAction(f10_local67, f10_local13.head)
	Lobby.Process.ForceAction(f10_local13.tail, f10_local14)
	Lobby.Process.ForceAction(f10_local14, f10_local15)
	Lobby.Process.ForceAction(f10_local15, f10_local75)
	Lobby.Process.ForceAction(f10_local75, f10_local38)
	Lobby.Process.ForceAction(f10_local33, f10_local68)
	Lobby.Process.ForceAction(f10_local68, f10_local16.head)
	Lobby.Process.ForceAction(f10_local16.tail, f10_local17)
	Lobby.Process.ForceAction(f10_local17, f10_local18)
	Lobby.Process.ForceAction(f10_local18, f10_local63)
	Lobby.Process.ForceAction(f10_local63, f10_local38)
	Lobby.Process.ForceAction(f10_local32, f10_local69)
	Lobby.Process.ForceAction(f10_local69, f10_local19.head)
	Lobby.Process.ForceAction(f10_local19.tail, f10_local20)
	Lobby.Process.ForceAction(f10_local20, f10_local21)
	Lobby.Process.ForceAction(f10_local21, f10_local74)
	Lobby.Process.ForceAction(f10_local74, f10_local38)
	Lobby.Process.ForceAction(f10_local25, f10_local26)
	return f10_local88
end
Lobby.ProcessPlatform.PlayTogetherBeginPlay = function(f19_arg0, f19_arg1)
	local f19_local0 = function()
		Engine[@"platformsessionclearplaytogetherinfo"]()
	end
	local f19_local1 = Lobby.Actions.OpenSpinner(nil, true)
	local f19_local2 = Lobby.Actions.CloseSpinner()
	local f19_local3 = Lobby.Platform.PS4GetSessionId(f19_arg0)
	local f19_local4 = Lobby.Actions.PlayTogetherBeginPlayWait(f19_arg0)
	local f19_local5 = Lobby.Actions.PlayTogetherPSNSessionWait(f19_arg0, f19_local3)
	local f19_local6 = Lobby.Actions.SendPlatformInvite(f19_arg0, Enum[@"lobbytype"][@"lobby_type_private"], f19_arg1)
	local f19_local7 = Lobby.Actions.ExecuteScript(f19_local0, nil)
	local f19_local8 = {
		head = f19_local1,
		interrupt = Lobby.Interrupt.NONE,
		force = false,
		cancellable = false,
	}
	Lobby.Process.AddActions(f19_local1, f19_local4)
	Lobby.Process.AddActions(f19_local4, f19_local5)
	Lobby.Process.AddActions(f19_local5, f19_local6)
	Lobby.Process.AddActions(f19_local6, f19_local7)
	Lobby.Process.AddActions(f19_local7, f19_local2)
	return f19_local8
end
Lobby.ProcessPlatform.SendPlayTogetherInvites = function(f21_arg0, f21_arg1)
	Engine[@"setmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.beginPlay"), Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"])
	local f21_local0 = Lobby.Platform.PS4GetSessionId(f21_arg0)
	local f21_local1 = function()
		Engine[@"platformsessionclearplaytogetherinfo"]()
	end
	local f21_local2 = Lobby.Actions.OpenSpinner(nil, true)
	local f21_local3 = Lobby.Actions.CloseSpinner()
	local f21_local4 = Lobby.Actions.ExecuteScript(f21_local1, nil)
	local f21_local5 = Lobby.Actions.SendPlatformInvite(f21_arg0, Enum[@"lobbytype"][@"lobby_type_private"], f21_arg1, f21_local0)
	local f21_local6 = {
		head = f21_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = false,
		cancellable = false,
	}
	Lobby.Process.AddActions(f21_local2, f21_local5)
	Lobby.Process.AddActions(f21_local5, f21_local4)
	Lobby.Process.AddActions(f21_local4, f21_local3)
	return f21_local6
end
