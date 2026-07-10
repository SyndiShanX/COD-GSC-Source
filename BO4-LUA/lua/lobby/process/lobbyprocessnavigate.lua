require("x64:ea6bc9504fbe5e")
require("x64:63b2846467b6f54")
require("x64:64f2c46468c1f2a")
require("x64:690114646c3883e")
require("x64:6641a46469e5c9e")
Lobby.ProcessNavigate = {}
Lobby.ProcessNavigate.FailedDWConnection = false
Lobby.ProcessNavigate.DisplayedFirstTimeDurangoDownloadSetting = false
Lobby.ProcessNavigate.DoFirstTimeProfileSetup = function(f1_arg0, f1_arg1)
	if CoDShared.IsMainFirstTimeSetup(f1_arg1) then
		LobbyVM.ExecuteLobbyVMCreateOverlay(f1_arg1, "EULA")
		return true
	else
		return false
	end
end
Lobby.ProcessNavigate.BeginIfLocalFilesReady = function(f2_arg0, f2_arg1)
	if Engine[@"arelocalfilesready"](f2_arg1) then
		Engine[@"loadsavegame"]()
		Engine[@"execnow"](f2_arg1, "invalidateEmblemComponent")
		if not Lobby.ProcessNavigate.DoFirstTimeProfileSetup(f2_arg0, f2_arg1) then
			local f2_local0 = {
				controller = f2_arg1,
			}
			local f2_local1 = LuaEnum.UI.DIRECTOR_LAN_SELECT
			if not f2_local1 then
				f2_local1 = LuaEnum.UI.DIRECTOR_LAN
			end
			f2_local0.navToMenu = f2_local1
			LobbyVM.OnGoForward(f2_local0)
		end
	else
		LobbyVM.ExecuteLobbyVMCreateOverlay(f2_arg1, "LoadingProfile")
	end
end
Lobby.ProcessNavigate.ShouldBeginLAN = function(f3_arg0)
	if LuaUtils.OnlineOnlyDemo() then
		return false
	elseif LuaUtils.OfflineOnlyDemo() then
		return true
	elseif Engine[@"hash_5CB675CA7856DA25"]() then
		return false
	elseif not Engine[@"isdevelopmentbuild"]() then
		return false
	elseif not Engine[@"issignedintolive"](f3_arg0) and not Engine[@"isplayerqueued"](f3_arg0) then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(true) due to not being signed into LIVE and is not in the waiting queue.\n")
		return true
	elseif Dvar[@"lobby_forcelan"]:get() > 0 then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(true) Dvar lobby_forceLAN > 0.\n")
		return true
	elseif CoDShared.ForceOffline() == true then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(true) due to per-sku online override dvar(see utils.IsSkuOfflineOnly() for details).\n")
		return true
	end
	local f3_local0 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.failedDemonwareConnection")
	local f3_local1 = Lobby.ProcessNavigate
	local f3_local2
	if f3_local0 == nil or Engine[@"getmodelvalue"](f3_local0) ~= true then
		f3_local2 = false
	else
		f3_local2 = true
	end
	f3_local1.FailedDWConnection = f3_local2
	if true == Lobby.ProcessNavigate.FailedDWConnection then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(true) due to failed Demonware connection.\n")
		return true
	end
	f3_local1 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.beginPlay")
	if f3_local1 ~= nil and Engine[@"getmodelvalue"](f3_local1) == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(true) lobbyRoot.beginPlay force LAN.\n")
		return true
	elseif LuaUtils.RequirePaidSubscriptionForOnlinePlay() and not Engine[@"isplusauthorized"](f3_arg0) then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(true) - user do not have paid subscription.\n")
		return true
	elseif Engine[@"getanticheatreputation"](f3_arg0) >= LuaEnum.DW_REPUTATION_BAN then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(true) has a ban reputation.\n")
		return true
	end
	f3_local2 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.beginPlay")
	if f3_local2 ~= nil and Engine[@"getmodelvalue"](f3_local2) == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(true) lobbyRoot.beginPlay force LAN.\n")
		return true
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "Lobby.ProcessNavigate.ShouldBeginLAN(false).\n")
	return false
end
Lobby.ProcessNavigate.BeginLocalPlay = function(f4_arg0, f4_arg1)
	if LuaUtils.OnlineOnlyDemo() then
		return
	else
		Engine[@"setlobbynetworkmode"](Enum[@"lobbynetworkmode"][@"lobby_networkmode_local"])
		Lobby.ProcessNavigate.BeginIfLocalFilesReady(f4_arg0, f4_arg1)
	end
end
Lobby.ProcessNavigate.BeginLANPlay = function(f5_arg0, f5_arg1)
	if LuaUtils.OnlineOnlyDemo() then
		return
	elseif Engine[@"hash_5CB675CA7856DA25"]() then
		return true
	else
		Engine[@"setlobbynetworkmode"](Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"])
		Lobby.ProcessNavigate.BeginIfLocalFilesReady(f5_arg0, f5_arg1)
	end
end
Lobby.ProcessNavigate.BeginLivePlay = function(f6_arg0, f6_arg1, f6_arg2)
	if LuaDefine.isPS4 then
		if Engine[@"displaynpavailabilityerrors"](f6_arg1) then
			Lobby.ProcessNavigate.BeginLANPlay(f6_arg0, f6_arg1)
			return
		elseif not LuaUtils.PlayStationPlusUpsell(f6_arg1) then
			Lobby.ProcessNavigate.BeginLANPlay(f6_arg0, f6_arg1)
			return
		elseif not Engine[@"hascompletedcheckingrestrictions"](f6_arg1) then
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_lobby"], "HasCompletedCheckingRestrictions has not completed, opening CheckingRestrictions overlay.\n")
			LobbyVM.ExecuteLobbyVMCreateOverlay(f6_arg1, "CheckingRestrictions")
			return
		end
	end
	local f6_local0 = Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.startPopups"))
	local f6_local1 = Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.startBitsToFetch"))
	if Engine[@"hash_F62AEC4075B0105"](f6_arg1) or Engine[@"isplayerqueued"](f6_arg1) then
		LobbyVM.ExecuteLobbyVMCreateOverlay(f6_arg1, "LoginQueued")
	elseif f6_local0 > 0 then
		if f6_local1 & Engine[0x4DC3A644148CFC](f6_arg1) == f6_local1 then
			Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.showPopup"))
		else
			Engine[@"liveconnectenabledemonwareconnect"]()
			LobbyVM.ExecuteLobbyVMCreateOverlay(f6_arg1, "ConnectingToDemonware")
		end
	elseif Engine[@"isdemonwarefetchingdone"](f6_arg1) and Engine[@"arelocalfilesready"](f6_arg1) then
		if CoDShared.ForceOffline() == true then
			LobbyVM.ExecuteLobbyVMCreateOverlay(f6_arg1, "UpdateNeeded")
			return
		end
		Lobby.ProcessNavigate.FailedDWConnection = false
		Engine[@"setlobbynetworkmode"](Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"])
		Engine[@"loadsavegame"]()
		Engine[@"execnow"](f6_arg1, "invalidateEmblemComponent")
		if not Engine[@"isdedicatedserver"]() then
			Engine[@"hash_F5111961D03A0F5"]("successfulDWConnection", 1)
		end
		if not Lobby.ProcessNavigate.DoFirstTimeProfileSetup(f6_arg0, f6_arg1) then
			local f6_local2 = LobbyData.GetLobbyMenuByID(LobbyData.GetLobbyNav())
			local f6_local3 = {
				controller = f6_arg1,
				navToMenu = LuaEnum.UI.DIRECTOR_ONLINE,
			}
			if Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.postPopups")) > 0 then
				Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.showPostPopup"))
				return
			end
			LobbyVM.OnGoForward(f6_local3)
		end
	else
		Engine[@"liveconnectenabledemonwareconnect"]()
		LobbyVM.ExecuteLobbyVMCreateOverlay(f6_arg1, "ConnectingToDemonware")
	end
end
Lobby.ProcessNavigate.PressStart = function(f7_arg0, f7_arg1)
	if Engine[@"iscinematicplaying"]() then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "PressStart - Unable to proceed, cinematic is still playing.\n")
		return
	elseif not Engine[@"liveiscontrollersignedin"](f7_arg0) and not Engine[@"signintoplatformlivesystem"](f7_arg0) then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "PressStart - Unable to proceed, not signed into system.\n")
		return
	end
	local f7_local0 = Engine[@"checknetconnection"]()
	if Engine[@"hash_FA9C33583AA157"]() == 1 or Dvar[@"director_gate"]:exists() and Dvar[@"director_gate"]:get() == 0 then
		LuaUtils.UI_ShowInfoMessageDialog(f7_arg0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_5226414A840AD597"))
		return
	elseif not f7_local0 and (LuaUtils.OnlineOnlyDemo() or Engine[@"hash_5CB675CA7856DA25"]()) then
		LuaUtils.UI_ShowErrorMessageDialog(f7_arg0, Engine[@"hash_4F9F1239CFD921FE"](@"xboxlive/netconnection"))
		return
	elseif LuaDefine.isXbox then
		if Dvar[@"hash_51DC1D441B7221C3"]:get() then
		elseif not Engine[@"hasmpprivileges"](f7_arg0) and (LuaUtils.OnlineOnlyDemo() or Engine[@"hash_5CB675CA7856DA25"]() and LuaUtils.RequirePaidSubscriptionForOnlinePlay()) then
			Engine[@"privilegeforcecheck"](f7_arg0, 254, true)
			return
		end
	end
	if Engine[@"isuserguest"](f7_arg0) then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "PressStart - Unable to proceed, content is guest user restricted.\n")
		LuaUtils.UI_ShowErrorMessageDialog(f7_arg0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_55CF149A251A1B95"))
		return
	elseif (LuaDefine.isPS4 or LuaDefine.isXbox) and Engine[@"hash_77D47312EBA41751"]() then
		local f7_local1 = {
			overlay = LuaEnum.LOBBYVM_OPENED_OVERLAYS.STILLDOWNLOADING,
			controller = f7_arg0,
			anyControllerAllowed = true,
			unusedControllerAllowed = true,
		}
	end
	Engine[@"activateprimarylocalclient"](f7_arg0)
	local f7_local1 = 0
	if Engine[@"hash_5CB675CA7856DA25"]() then
		local f7_local2 = Engine[@"hash_5451F40A2FEDDF88"](f7_local1)
		if f7_local2.trialStatus == Enum[@"trialstatus"][@"hash_4A54EF2EE4F4C6FC"] then
			if Engine[@"hash_25AE97B58D7132F3"]() == "pc" then
				LuaUtils.UI_ShowErrorMessageDialog(f7_local1, @"hash_6B08A9FC8EFFADD1", @"hash_10123D1968A0DA1")
			else
				LobbyVM.ExecuteLobbyVMCreateOverlay(f7_local1, "TrialNotAvailable")
			end
			return
		end
	end
	if (LuaDefine.isPS4 or LuaDefine.isXbox) and Engine[@"getdvarbool"]("tu18_removeOutdatedDLC") == true and Engine[@"hash_3E2EF26361C0D480"]() == true then
		LuaUtils.UI_ShowWarningMessageDialog(nil, @"hash_A95BE7EF489CDE0")
	end
	if not f7_local0 then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "PressStart - BeginLocalPlay.\n")
		Lobby.ProcessNavigate.BeginLocalPlay(self, f7_local1)
	elseif Lobby.ProcessNavigate.ShouldBeginLAN(f7_local1) then
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "PressStart - BeginLANPlay.\n")
		Lobby.ProcessNavigate.BeginLANPlay(self, f7_local1)
	else
		Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_lobby"], "PressStart - BeginLivePlay.\n")
		Lobby.ProcessNavigate.BeginLivePlay(self, f7_local1, f7_arg1)
	end
	LobbyVM.PlaySound(LobbyData.Sounds.Action, 0)
end
Lobby.ProcessNavigate.ChangeNetworkMode = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = LuaUtils.ConnectingToDemonwareMaxWaitTime()
	local f8_local1 = function()
		Lobby.Timer.HostingLobbyEnd({
			lobbyType = Enum[@"lobbytype"][@"lobby_type_game"],
		})
	end
	local f8_local2 = function()
		Engine[@"hash_58E4D0FBCB7D81DC"]()
	end
	local f8_local3 = function()
		Engine[@"hash_7CB496883ED6DB62"]()
	end
	local f8_local4 = Lobby.Actions.ExecuteScript(f8_local1)
	local f8_local5 = Lobby.Actions.OpenSpinner()
	local f8_local6 = Lobby.Actions.CloseSpinner()
	local f8_local7 = Lobby.Actions.LobbySettings(f8_arg0, f8_arg2)
	local f8_local8 = Lobby.Actions.UpdateUI(f8_arg0, f8_arg2)
	local f8_local9 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f8_local10 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f8_local11 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f8_local12 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f8_local13 = Lobby.Actions.SetNetworkMode(f8_arg0, f8_arg2[@"networkmode"])
	local f8_local14 = Lobby.Actions.LobbyHostStart(f8_arg0, f8_arg2[@"mainmode"], f8_arg2[@"lobbytype"], f8_arg2[@"lobbymode"], f8_arg2[@"maxclients"], "", "")
	local f8_local15 = Lobby.Actions.LobbyHostAddPrimary(f8_arg2[@"lobbytype"])
	local f8_local16 = Lobby.Actions.LobbyClientStart(f8_arg2[@"lobbytype"])
	local f8_local17 = Lobby.Actions.SignUserInToLive(f8_arg0)
	local f8_local18 = LobbyData.GetLobbyMenuByName(LuaEnum.UI.DIRECTOR_LAN_SELECT)
	local f8_local19 = Lobby.Process.ReloadPrivateLobby(f8_arg0, Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"])
	local f8_local20 = Lobby.Actions.LobbySettings(f8_arg0, f8_local18)
	local f8_local21 = Lobby.Actions.UpdateUI(f8_arg0, f8_local18)
	local f8_local22 = Lobby.Actions.ErrorPopupMsg(@"hash_6632F97C36A01BD6")
	local f8_local23 = Lobby.Actions.CloseSpinnerAllowJoining()
	f8_local23.name = f8_local23.name .. "DemonwareConnect"
	local f8_local24 = {}
	if Engine[@"getusedcontrollercount"]() > 1 then
		local f8_local25 = 1
		for f8_local26 = 1, LuaDefine.MAX_CONTROLLER_COUNT, 1 do
			local f8_local29 = f8_local26 - 1
			if Engine[@"isuseractive"](f8_local29) then
				f8_local24[f8_local25] = Lobby.Actions.CanPlayOnline(f8_local29)
				f8_local25 = f8_local25 + 1
			end
		end
	else
		f8_local24[1] = Lobby.Actions.CanPlayOnline(f8_arg0)
	end
	local f8_local25 = Lobby.Actions.ExecuteScript(f8_local2)
	local f8_local26 = Lobby.Actions.ConnectingToDemonware(f8_arg0, f8_local0, false)
	local f8_local27 = Lobby.Actions.ExecuteScript(f8_local3)
	local f8_local28 = Lobby.Actions.ExecuteScript(f8_local3)
	f8_local27.name = "postDemonwareConnectSuccess"
	f8_local28.name = "postDemonwareConnectFailure"
	local f8_local30 = Lobby.Actions.DirectTelemetryStart(f8_arg0, f8_arg2)
	local f8_local29 = Lobby.Actions.EmptyAction()
	local f8_local31 = {
		head = f8_local5,
		tail = f8_local6,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = true,
	}
	if f8_arg2[@"networkmode"] == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		f8_local31.head = f8_local24[1]
		lastAction = f8_local24[1]
		for f8_local32 = 2, #f8_local24, 1 do
			Lobby.Process.AddActions(lastAction, f8_local24[f8_local32])
			lastAction = f8_local24[f8_local32]
		end
		Lobby.Process.AddActions(lastAction, f8_local5)
	end
	Lobby.Process.AddActions(f8_local5, f8_local4)
	Lobby.Process.AddActions(f8_local4, f8_local9)
	Lobby.Process.AddActions(f8_local9, f8_local10)
	Lobby.Process.AddActions(f8_local10, f8_local11)
	Lobby.Process.AddActions(f8_local11, f8_local12)
	Lobby.Process.AddActions(f8_local12, f8_local13)
	if f8_arg2[@"networkmode"] == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		Lobby.Process.AddActions(f8_local13, f8_local17)
		Lobby.Process.AddActions(f8_local17, f8_local25)
		Lobby.Process.AddActions(f8_local25, f8_local26)
		Lobby.Process.AddActions(f8_local26, f8_local27, f8_local28, f8_local28)
		Lobby.Process.AddActions(f8_local27, f8_local14)
	else
		Lobby.Process.AddActions(f8_local13, f8_local30)
		Lobby.Process.AddActions(f8_local30, f8_local14)
	end
	Lobby.Process.AddActions(f8_local14, f8_local15)
	Lobby.Process.AddActions(f8_local15, f8_local16)
	Lobby.Process.AddActions(f8_local16, f8_local7)
	Lobby.Process.AddActions(f8_local7, f8_local8)
	Lobby.Process.AddActions(f8_local8, f8_local6)
	Lobby.Process.ForceAction(f8_local28, f8_local23)
	Lobby.Process.ForceAction(f8_local23, f8_local19.head)
	Lobby.Process.ForceAction(f8_local19.tail, f8_local20)
	Lobby.Process.ForceAction(f8_local20, f8_local21)
	Lobby.Process.ForceAction(f8_local21, f8_local22)
	return f8_local31
end
Lobby.ProcessNavigate.MoveToScreen = function(f12_arg0, f12_arg1, f12_arg2)
	return {
		head = Lobby.Actions.UpdateUI(f12_arg0, f12_arg2),
		interrupt = nil,
		force = false,
		cancellable = false,
	}
end
Lobby.ProcessNavigate.PrivateLobbyInterrupt = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = f13_arg1.controller
	local f13_local1 = f13_arg1.errorTarget
	local f13_local2 = Lobby.Actions.OpenSpinner()
	local f13_local3 = Lobby.Actions.LobbySettings(f13_local0, f13_local1)
	local f13_local4 = Lobby.Actions.UpdateUI(f13_local0, f13_local1)
	local f13_local5 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f13_local6 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f13_local7 = Lobby.Actions.CloseSpinner()
	local f13_local8 = {
		head = f13_local2,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false,
	}
	Lobby.Process.ForceAction(f13_local2, f13_local3)
	Lobby.Process.ForceAction(f13_local3, f13_local4)
	Lobby.Process.ForceAction(f13_local4, f13_local5)
	Lobby.Process.ForceAction(f13_local5, f13_local6)
	Lobby.Process.ForceAction(f13_local6, f13_local7)
	if f13_arg0 == Lobby.Interrupt.BACK then
	elseif f13_arg0 == Lobby.Interrupt.FAILED_ACTION and f13_arg2.action ~= nil then
		Lobby.Process.ForceAction(f13_local7, Lobby.Actions.ErrorPopup(f13_arg2.action))
	elseif f13_arg0 == Lobby.Interrupt.ERROR_MSG and f13_arg2.errorMsg ~= nil then
		local f13_local9 = f13_arg2.errorMsg
		if Engine[@"isdevelopmentbuild"]() and f13_arg2.action ~= nil then
			f13_local9 = f13_local9 .. "\n\n(debug info, failed action: " .. f13_arg2.action.name .. ")"
		end
		Lobby.Process.ForceAction(f13_local7, Lobby.Actions.ErrorPopupMsg(f13_local9))
	end
	return f13_local8
end
Lobby.ProcessNavigate.CreatePrivateLobby = function(f14_arg0, f14_arg1, f14_arg2)
	Lobby.ProcessNavigate.RemoveAllBots()
	local f14_local0 = {
		controller = f14_arg0,
		errorTarget = f14_arg1,
	}
	local f14_local1 = Lobby.Interrupt.Back(Lobby.ProcessNavigate.PrivateLobbyInterrupt, f14_local0)
	local f14_local2 = Lobby.Interrupt.ErrorMsg(Lobby.ProcessNavigate.PrivateLobbyInterrupt, f14_local0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"))
	local f14_local3 = Lobby.Actions.OpenSpinner(true)
	local f14_local4 = Lobby.Actions.CloseSpinner()
	local f14_local5 = Lobby.Actions.LobbySettings(f14_arg0, f14_arg2)
	local f14_local6 = Lobby.Actions.LobbyHostStart(f14_arg0, f14_arg2[@"mainmode"], f14_arg2[@"lobbytype"], f14_arg2[@"lobbymode"], f14_arg2[@"maxclients"], "", "")
	local f14_local7 = Lobby.Actions.LobbyHostAddPrimary(f14_local6.lobbyType)
	local f14_local8 = Lobby.Actions.LobbyClientStart(f14_local6.lobbyType)
	local f14_local9 = Lobby.Actions.UpdateUI(f14_arg0, f14_arg2)
	local f14_local10 = Lobby.Actions.DisableConnectingToDemonware(f14_arg0)
	local f14_local11 = Lobby.Actions.DisconnectFromDemonware(f14_arg0, 3)
	local f14_local12 = {
		head = f14_local3,
		interrupt = f14_local1,
		force = false,
		cancellable = false,
	}
	if Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		Lobby.Process.AddActions(f14_local3, f14_local5, f14_local2, f14_local2)
	elseif Dvar[@"lobby_forcelan"]:get() == 0 then
		Lobby.Process.AddActions(f14_local3, f14_local10, f14_local2, f14_local2)
		Lobby.Process.AddActions(f14_local10, f14_local5, f14_local2, f14_local2)
	elseif Dvar[@"lobby_forcelan"]:get() == 1 then
		Lobby.Process.AddActions(f14_local3, f14_local11, f14_local2, f14_local2)
		Lobby.Process.AddActions(f14_local11, f14_local5, f14_local2, f14_local2)
	elseif Dvar[@"lobby_forcelan"]:get() == 2 then
		Lobby.Process.AddActions(f14_local3, f14_local5, f14_local2, f14_local2)
	end
	Lobby.Process.AddActions(f14_local5, f14_local6, f14_local2, f14_local2)
	Lobby.Process.AddActions(f14_local6, f14_local7, f14_local2, f14_local2)
	Lobby.Process.AddActions(f14_local7, f14_local8, f14_local2, f14_local2)
	Lobby.Process.AddActions(f14_local8, f14_local9, f14_local2, f14_local2)
	Lobby.Process.AddActions(f14_local9, f14_local4, f14_local2, f14_local2)
	Lobby.Process.AddActions(f14_local4, nil, f14_local2, f14_local2)
	return f14_local12
end
Lobby.ProcessNavigate.LeavePrivateLobby = function(f15_arg0, f15_arg1, f15_arg2)
	Engine[@"lobbylaunchclear"]()
	Lobby.ProcessNavigate.RemoveAllBots()
	local f15_local0 = Lobby.Actions.OpenSpinner()
	local f15_local1 = Lobby.Actions.CloseSpinner()
	local f15_local2 = Lobby.Actions.LobbySettings(f15_arg0, f15_arg2)
	local f15_local3 = Lobby.Actions.UpdateUI(f15_arg0, f15_arg2)
	local f15_local4 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f15_local5 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f15_local6 = {
		head = f15_local0,
		interrupt = Lobby.Interrupt.NONE,
		force = false,
		cancellable = false,
	}
	Lobby.Process.AddActions(f15_local0, f15_local4)
	Lobby.Process.AddActions(f15_local4, f15_local5)
	Lobby.Process.AddActions(f15_local5, f15_local2)
	Lobby.Process.AddActions(f15_local2, f15_local3)
	Lobby.Process.AddActions(f15_local3, f15_local1)
	Lobby.Process.AddActions(f15_local1, nil)
	return f15_local6
end
Lobby.ProcessNavigate.GameLobbyInterrupt = function(f16_arg0, f16_arg1, f16_arg2)
	Lobby.ProcessNavigate.RemoveAllBots()
	local f16_local0 = Lobby.Actions.ExecuteScript(function()
		Lobby.Debug.JBMatchmakingEvent(LuaEnum.JB_MATCHMAKING_EVENT.FAILED)
	end)
	local f16_local1 = f16_arg1.controller
	local f16_local2 = f16_arg1.errorTarget
	local f16_local3 = f16_arg1.isPublic
	local f16_local4 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end
	local f16_local5 = Lobby.Actions.OpenSpinner()
	local f16_local6 = Lobby.Actions.ExecuteScript(f16_local4)
	local f16_local7 = Lobby.Actions.LobbyVMCallRetVal(Lobby.Timer.HostingLobbyEnd, {
		controller = f16_local1,
		lobbyType = Enum[@"lobbytype"][@"lobby_type_game"],
		mainMode = f16_local2[@"mainmode"],
	}, true, false, false)
	local f16_local8 = Lobby.Actions.LobbySettings(f16_local1, f16_local2)
	local f16_local9 = Lobby.Actions.UpdateUI(f16_local1, f16_local2)
	local f16_local10 = Lobby.Actions.SwitchMode(f16_local1, Lobby.Core.GetMainModeStr(f16_local2[@"mainmode"]))
	local f16_local11 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f16_local12 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f16_local13 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f16_local14 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f16_local15 = Lobby.Actions.LobbyHostStart(f16_local1, f16_local2[@"mainmode"], Enum[@"lobbytype"][@"lobby_type_private"], f16_local2[@"lobbymode"], f16_local2[@"maxclients"], "", "")
	local f16_local16 = Lobby.Actions.LobbyHostAddPrimary(Enum[@"lobbytype"][@"lobby_type_private"])
	local f16_local17 = Lobby.Actions.LobbyClientStart(Enum[@"lobbytype"][@"lobby_type_private"])
	local f16_local18 = Lobby.Actions.ExecuteScript(function()
		Lobby.Matchmaking.UpdateSearchStatus(Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]), LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE)
	end)
	local f16_local19 = Lobby.Actions.AsyncMatchmakingCancel(f16_local1, Engine[@"numbertouint64"](20000), {
		matchmakingID = Lobby.MMAsync.Info.matchmakingID,
	})
	local f16_local20 = Lobby.Actions.CloseSpinner()
	local f16_local21 = {
		head = f16_local5,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false,
	}
	if f16_local3 == true then
		f16_local21.head = f16_local0
		Lobby.Process.ForceAction(f16_local0, f16_local5)
	end
	Lobby.Process.ForceAction(f16_local5, f16_local6)
	Lobby.Process.ForceAction(f16_local6, f16_local7)
	Lobby.Process.ForceAction(f16_local7, f16_local19)
	Lobby.Process.ForceAction(f16_local19, f16_local8)
	Lobby.Process.ForceAction(f16_local8, f16_local9)
	Lobby.Process.ForceAction(f16_local9, f16_local10)
	Lobby.Process.ForceAction(f16_local10, f16_local11)
	Lobby.Process.ForceAction(f16_local11, f16_local12)
	Lobby.Process.ForceAction(f16_local12, f16_local13)
	Lobby.Process.ForceAction(f16_local13, f16_local14)
	Lobby.Process.ForceAction(f16_local14, f16_local15)
	Lobby.Process.ForceAction(f16_local15, f16_local16)
	Lobby.Process.ForceAction(f16_local16, f16_local17)
	Lobby.Process.ForceAction(f16_local17, f16_local18)
	Lobby.Process.ForceAction(f16_local18, f16_local20)
	if f16_arg0 == Lobby.Interrupt.BACK then
	elseif f16_arg0 == Lobby.Interrupt.FAILED_ACTION and f16_arg2.action ~= nil then
		Lobby.Process.ForceAction(f16_local20, Lobby.Actions.ErrorPopup(f16_arg2.action))
	elseif f16_arg0 == Lobby.Interrupt.ERROR_MSG and f16_arg2.errorMsg ~= nil then
		local f16_local22 = f16_arg2.errorMsg
		if f16_arg2.action ~= nil and Engine[@"isdevelopmentbuild"]() then
			if f16_arg2.action.errorFuncPtr then
				f16_local22 = f16_local22 .. "\n\ndebug: " .. f16_arg2.action:errorFuncPtr()
			else
				f16_local22 = f16_local22 .. "\n\n(debug info, failed action: " .. f16_arg2.action.name .. ")"
			end
		end
		Lobby.Process.ForceAction(f16_local20, Lobby.Actions.ErrorPopupMsg(f16_local22))
	elseif f16_arg0 == Lobby.Interrupt.ERROR_OVERLAY and f16_arg2.errorOverlay ~= nil then
		Lobby.Process.ForceAction(f16_local20, Lobby.Actions.ErrorOverlay(f16_local1, f16_arg2.errorOverlay))
	end
	return f16_local21
end
Lobby.ProcessNavigate.SearchProcessInterrupt = function(f20_arg0, f20_arg1, f20_arg2)
	Lobby.ProcessNavigate.RemoveAllBots()
	local f20_local0 = Lobby.Actions.ExecuteScript(function()
		Lobby.Debug.JBMatchmakingEvent(LuaEnum.JB_MATCHMAKING_EVENT.FAILED)
	end)
	local f20_local1 = f20_arg1.controller
	local f20_local2 = f20_arg1.errorTarget
	local f20_local3 = f20_arg1.isPublic
	local f20_local4 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end
	local f20_local5 = Lobby.Actions.OpenSpinner()
	local f20_local6 = Lobby.Actions.ExecuteScript(f20_local4)
	local f20_local7 = Lobby.Actions.LobbyVMCallRetVal(Lobby.Timer.HostingLobbyEnd, {
		controller = f20_local1,
		lobbyType = Enum[@"lobbytype"][@"lobby_type_game"],
		mainMode = f20_local2[@"mainmode"],
	}, true, false, false)
	local f20_local8 = Lobby.Actions.LobbySettings(f20_local1, f20_local2)
	local f20_local9 = Lobby.Actions.UpdateUI(f20_local1, f20_local2)
	local f20_local10 = Lobby.Actions.SwitchMode(f20_local1, Lobby.Core.GetMainModeStr(f20_local2[@"mainmode"]))
	local f20_local11 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f20_local12 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f20_local13 = Lobby.Actions.ExecuteScript(function()
		Lobby.Matchmaking.UpdateSearchStatus(Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]), LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE)
	end)
	local f20_local14 = Lobby.Actions.AsyncMatchmakingCancel(f20_local1, Engine[@"numbertouint64"](20000), {
		matchmakingID = Lobby.MMAsync.Info.matchmakingID,
	})
	local f20_local15 = Lobby.Actions.CloseSpinner()
	local f20_local16 = {
		head = f20_local5,
		interrupt = Lobby.Interrupt.NONE,
		force = true,
		cancellable = false,
	}
	if f20_local3 == true then
		f20_local16.head = f20_local0
		Lobby.Process.ForceAction(f20_local0, f20_local5)
	end
	Lobby.Process.ForceAction(f20_local5, f20_local6)
	Lobby.Process.ForceAction(f20_local6, f20_local7)
	Lobby.Process.ForceAction(f20_local7, f20_local14)
	Lobby.Process.ForceAction(f20_local14, f20_local8)
	Lobby.Process.ForceAction(f20_local8, f20_local9)
	Lobby.Process.ForceAction(f20_local9, f20_local10)
	Lobby.Process.ForceAction(f20_local10, f20_local11)
	Lobby.Process.ForceAction(f20_local11, f20_local12)
	Lobby.Process.ForceAction(f20_local12, f20_local13)
	Lobby.Process.ForceAction(f20_local13, f20_local15)
	if f20_arg0 == Lobby.Interrupt.BACK then
	elseif f20_arg0 == Lobby.Interrupt.FAILED_ACTION and f20_arg2.action ~= nil then
		Lobby.Process.ForceAction(f20_local15, Lobby.Actions.ErrorPopup(f20_arg2.action))
	elseif f20_arg0 == Lobby.Interrupt.ERROR_MSG and f20_arg2.errorMsg ~= nil then
		local f20_local17 = f20_arg2.errorMsg
		if f20_arg2.action ~= nil and Engine[@"isdevelopmentbuild"]() then
			if f20_arg2.action.errorFuncPtr then
				f20_local17 = f20_local17 .. "\n\ndebug: " .. f20_arg2.action:errorFuncPtr()
			else
				f20_local17 = f20_local17 .. "\n\n(debug info, failed action: " .. f20_arg2.action.name .. ")"
			end
		end
		Lobby.Process.ForceAction(f20_local15, Lobby.Actions.ErrorPopupMsg(f20_local17))
	end
	return f20_local16
end
Lobby.ProcessNavigate.SwitchLobbiesIsGametypeValid = function(f24_arg0)
	if f24_arg0 == "" then
		return false
	elseif not Engine[@"isgametypevalid"](f24_arg0) then
		return false
	else
		return true
	end
end
Lobby.ProcessNavigate.SwitchLobbiesGetGametype = function(f25_arg0, f25_arg1)
	local f25_local0 = Engine[@"profilevalueasstring"](f25_arg0, "gametype")
	if f25_arg1[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"] then
		local f25_local1 = Engine[@"hash_48D4B2F88BB8D5E7"](Engine[@"converttoxhash"](f25_local0))
		if f25_local1 then
			if f25_arg1[@"egamemodes"] == Enum[@"egamemodes"][@"hash_27B5630CD29180CB"] or f25_arg1[@"egamemodes"] == Enum[@"egamemodes"][@"mode_game_league"] then
				if f25_local1.isLeagueMode ~= true then
					local f25_local2 = f25_local0 .. "_cwl"
					if Engine[@"hash_48D4B2F88BB8D5E7"](Engine[@"converttoxhash"](f25_local2)) then
						f25_local0 = f25_local2
					else
						f25_local0 = ""
					end
				end
			elseif f25_local1.isLeagueMode == true then
				f25_local0 = f25_local1.baseGameType
			end
		end
	end
	if not Lobby.ProcessNavigate.SwitchLobbiesIsGametypeValid(f25_local0) then
		f25_local0 = LuaUtils.GetDefaultGameType(f25_arg1) or "coop"
	end
	return f25_local0
end
Lobby.ProcessNavigate.SwitchLobbiesIsMapValid = function(f26_arg0)
	if f26_arg0 == "" or f26_arg0 == nil then
		return false
	elseif not Engine[@"ismapvalid"](f26_arg0) then
		return false
	else
		return true
	end
end
Lobby.ProcessNavigate.SwitchLobbiesGetMap = function(f27_arg0, f27_arg1)
	local f27_local0 = nil
	if Engine[@"iscampaigngame"]() then
		if f27_arg1[@"name"] == LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY then
			f27_local0 = Engine[@"getsavedmapqueuedmap"]()
			if f27_local0 == nil or f27_local0 == "" then
				f27_local0 = Engine[@"getsavedmap"]("story")
			end
		else
			f27_local0 = Dvar[@"cp_queued_level"]:get()
			if f27_local0 == nil or f27_local0 == "" then
				f27_local0 = LuaUtils.GetDefaultMap(f27_arg1)
			end
		end
	elseif Engine[@"ismultiplayergame"]() then
		f27_local0 = Engine[@"profilevalueasstring"](f27_arg0, "map")
	elseif Engine[@"iszombiesgame"]() then
		f27_local0 = Engine[@"profilevalueasstring"](f27_arg0, "map_zm")
	end
	if not Lobby.ProcessNavigate.SwitchLobbiesIsMapValid(f27_local0) then
		f27_local0 = LuaUtils.GetDefaultMap(f27_arg1)
	end
	if f27_arg1[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f27_arg1[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) or f27_arg1[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM) or f27_arg1[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM) then
		local f27_local1 = Engine[@"converttoxhash"](f27_local0)
		local f27_local2 = LuaUtils.GetMapsTable()
		local f27_local3 = f27_local2[f27_local1]
		if f27_local3 == nil or f27_local3[0xEF53F0B666D343] ~= nil and CoDShared.IsIntDvarNonZero(f27_local3[0xEF53F0B666D343]) == true then
			f27_local0 = LuaUtils.GetDefaultMap(f27_arg1)
		end
	end
	return f27_local0
end
Lobby.ProcessNavigate.SetupLobbyMapAndGameType = function(f28_arg0, f28_arg1)
	if f28_arg1[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_theater"] then
		return
	else
		local f28_local0 = Lobby.ProcessNavigate.SwitchLobbiesGetGametype(f28_arg0, f28_arg1)
		Engine[@"setgametype"](f28_local0)
		local f28_local1 = Lobby.ProcessNavigate.SwitchLobbiesGetMap(f28_arg0, f28_arg1)
		Engine[@"lobbysetmap"](f28_arg1[@"lobbytype"], f28_local1)
		local f28_local2 = Engine[@"getglobalmodel"]()
		local f28_local3 = f28_local2:create("lobbyRoot.selectedMapId")
		f28_local3:set(Engine[@"converttoxhash"](f28_local1))
		f28_local3 = f28_local2:create("lobbyRoot.selectedGameType")
		f28_local3:set(Engine[@"converttoxhash"](f28_local0))
	end
end
Lobby.ProcessNavigate.PrivateLobbyNavigate = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3, f29_arg4)
	if f29_arg2[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE) then
		Dvar[@"hash_4FF45B41C6046F8"]:set(f29_arg2[@"maxclients"])
	end
	Lobby.ProcessNavigate.RemoveAllBots()
	Lobby.Matchmaking.UpdateSearchStatus(Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]), LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE)
	local f29_local0 = Lobby.Interrupt.ErrorMsg(Lobby.ProcessNavigate.GameLobbyInterrupt, {
		controller = f29_arg0,
		errorTarget = f29_arg1,
	}, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"))
	local f29_local1 = f29_arg2[@"lobbytype"]
	f29_arg2[@"lobbytype"] = Enum[@"lobbytype"][@"lobby_type_private"]
	local f29_local2 = function()
		Lobby.PartyPrivacy.OnSessionStart({
			lobbyModule = Enum[@"lobbymodule"][@"lobby_module_host"],
			lobbyType = f29_arg2[@"lobbytype"],
			lobbyMode = f29_arg2[@"lobbymode"],
			toTarget = f29_arg2,
		})
		Lobby.ProcessNavigate.SetupLobbyMapAndGameType(f29_arg0, f29_arg2)
	end
	local f29_local3 = function()
		return f29_arg3 ~= nil
	end
	local f29_local4 = function()
		if Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) then
			local f32_local0
			if Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_remote"]) <= 0 or f29_arg3 ~= LuaEnum.LEAVE_WITH_PARTY.WITHOUT then
				f32_local0 = false
			else
				f32_local0 = true
			end
			return f32_local0
		else
			return true
		end
	end
	local f29_local5 = function()
		return Engine[@"hash_7CF8B1723D782C24"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_private"])
	end
	local f29_local6 = function()
		Lobby.TeamSelection.AutoAssignPlayers()
	end
	local f29_local7 = function()
		if f29_arg4 ~= nil then
			Engine[@"setplaylistid"](f29_arg4)
			LuaUtils.SetQuickplayPlaylistID(f29_arg4)
			local f35_local0 = Lobby.Core.GetMainModeStr(f29_arg2[@"mainmode"])
			local f35_local1
			if f29_arg2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_arena"] then
				f35_local1 = "playlist_arena"
				if not f35_local1 then
				else
					Engine[@"setprofilevar"](f29_arg0, f35_local1, f29_arg4)
				end
			end
			f35_local1 = "playlist_" .. f35_local0
		end
	end
	local f29_local8 = Lobby.Actions.OpenSpinner(true)
	local f29_local9 = Lobby.Actions.CloseSpinner()
	local f29_local10 = Lobby.Actions.LobbyVMCallRetVal(Lobby.Timer.HostingLobbyEnd, {
		controller = f29_arg0,
		lobbyType = f29_arg1[@"lobbytype"],
		mainMode = f29_arg1[@"mainmode"],
	}, true, false, false)
	local f29_local11 = Lobby.Actions.EvaluateFunction(f29_local3)
	local f29_local12 = Lobby.Actions.EvaluateFunction(f29_local4)
	local f29_local13 = Lobby.Actions.EvaluateFunction(f29_local5)
	local f29_local14 = Lobby.Actions.EvaluateFunction(f29_local7)
	local f29_local15 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f29_local16 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f29_local17 = Lobby.Actions.LobbyHostStart(f29_arg0, f29_arg2[@"mainmode"], f29_arg2[@"lobbytype"], f29_arg2[@"lobbymode"], f29_arg2[@"maxclients"], "", "")
	local f29_local18 = Lobby.Actions.LobbyHostAddPrimary(Enum[@"lobbytype"][@"lobby_type_private"])
	local f29_local19 = Lobby.Actions.LobbyClientStart(Enum[@"lobbytype"][@"lobby_type_private"])
	local f29_local20 = Lobby.Actions.SwitchMode(f29_arg0, Lobby.Core.GetMainModeStr(f29_arg2[@"mainmode"]))
	local f29_local21 = Lobby.Actions.LobbySettings(f29_arg0, f29_arg2)
	local f29_local22 = Lobby.Actions.ExecuteScript(f29_local2)
	local f29_local23 = Lobby.Actions.SetSavedOrDefaultMap(f29_arg0, f29_arg2)
	local f29_local24 = Lobby.Actions.UpdateUI(f29_arg0, f29_arg2)
	local f29_local25 = Lobby.Actions.SetDefaultArenaPlaylist(f29_arg0)
	local f29_local26 = Lobby.Actions.RunPlaylistRules(f29_arg0)
	local f29_local27 = Lobby.Actions.ExecuteScript(f29_local6)
	local f29_local28 = Lobby.Actions.CheckRestrictedClients(f29_arg0, nil, f29_arg2[@"mainmode"])
	local f29_local29 = Lobby.Actions.LobbyVMCall(Lobby.Timer.HostingLobby, {
		controller = f29_arg0,
		lobbyType = f29_arg2[@"lobbytype"],
		mainMode = f29_arg2[@"mainmode"],
		lobbyTimerType = f29_arg2[@"hash_5558B67A321D1120"],
	})
	local f29_local30 = Lobby.Actions.DirectTelemetryStart(f29_arg0, f29_arg2)
	local f29_local31 = Lobby.Actions.OpenSurvey(f29_arg0, f29_arg1)
	local f29_local32 = {
		head = f29_local8,
		interrupt = Lobby.Interrupt.NONE,
		force = false,
		cancellable = false,
	}
	Lobby.Process.AddActions(f29_local8, f29_local10, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local10, f29_local11, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local11, f29_local12, f29_local20, f29_local0)
	Lobby.Process.AddActions(f29_local12, f29_local15, f29_local20, f29_local0)
	Lobby.Process.AddActions(f29_local15, f29_local13, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local13, f29_local16, f29_local17, f29_local0)
	Lobby.Process.AddActions(f29_local16, f29_local17, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local17, f29_local18, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local18, f29_local19, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local19, f29_local20, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local20, f29_local14, f29_local0, f29_local0)
	Lobby.Process.ForceAction(f29_local14, f29_local21)
	Lobby.Process.AddActions(f29_local21, f29_local22, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local22, f29_local23, f29_local0, f29_local0)
	local f29_local33 = f29_local23
	if f29_arg2[@"hash_5558B67A321D1120"] ~= LuaEnum.TIMER_TYPE.INVALID and f29_local1 == Enum[@"lobbytype"][@"lobby_type_private"] then
		Lobby.Process.AddActions(f29_local23, f29_local29, f29_local0, f29_local0)
		f29_local33 = f29_local29
	end
	if LuaDefine.isPC and f29_local1 == Enum[@"lobbytype"][@"lobby_type_private"] then
		Lobby.Process.AddActions(f29_local33, f29_local28, f29_local0, f29_local0)
		f29_local33 = f29_local28
	end
	if f29_arg2[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_arena"] then
		Lobby.Process.ForceAction(f29_local33, f29_local26)
		f29_local33 = f29_local26
	end
	Lobby.Process.AddActions(f29_local33, f29_local30, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local30, f29_local24, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local24, f29_local27, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local27, f29_local9, f29_local0, f29_local0)
	Lobby.Process.AddActions(f29_local9, f29_local31)
	return f29_local32
end
Lobby.ProcessNavigate.CreateGameLobbyNONMatchmaking = function(f36_arg0, f36_arg1, f36_arg2)
	Lobby.ProcessNavigate.RemoveAllBots()
	local f36_local0 = Engine[@"getplaylistinfobyid"](Engine[@"getplaylistid"]())
	Engine[@"hash_6BFA89F119C70916"](f36_local0.usedDLCMask)
	local f36_local1 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"])
	local f36_local2 = {
		controller = f36_arg0,
		errorTarget = f36_arg1,
		isPublic = true,
	}
	local f36_local3 = Lobby.Interrupt.Back(Lobby.ProcessNavigate.GameLobbyInterrupt, f36_local2)
	local f36_local4 = Lobby.Interrupt.ErrorMsg(Lobby.ProcessNavigate.GameLobbyInterrupt, f36_local2, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"))
	local f36_local5 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_join"])
	end
	local f36_local6 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end
	local f36_local7 = function()
		Lobby.Timer.HostingLobby({
			controller = f36_arg0,
			lobbyType = f36_arg2[@"lobbytype"],
			mainMode = f36_arg2[@"mainmode"],
			lobbyTimerType = f36_arg2[@"hash_5558B67A321D1120"],
		})
		Lobby.Matchmaking.ClearSearchInfo()
	end
	local f36_local8 = Lobby.Actions.OpenSpinner(true)
	local f36_local9 = Lobby.Actions.CloseSpinner()
	local f36_local10 = Lobby.Actions.WaitForJoiningClients(5000)
	local f36_local11 = Lobby.Actions.ExecuteScript(f36_local5)
	local f36_local12 = Lobby.Actions.ExecuteScript(f36_local6)
	local f36_local13 = Lobby.Actions.LobbyHostStart(f36_arg0, f36_arg2[@"mainmode"], f36_arg2[@"lobbytype"], f36_arg2[@"lobbymode"], f36_arg2[@"maxclients"], "", "")
	local f36_local14 = Lobby.Actions.ExecuteScript(f36_local7)
	local f36_local15 = Lobby.Actions.LobbyInfoProbe(f36_arg0, {
		xuid = Engine[@"getxuid64"](f36_arg0),
	})
	local f36_local16 = Lobby.Actions.CheckRestrictedClients(f36_arg0, f36_local15)
	local f36_local17 = Lobby.Actions.LobbyJoinXUID(f36_arg0, {
		xuid = Engine[@"getxuid64"](f36_arg0),
	}, Enum[@"jointype"][@"join_type_party"])
	local f36_local18 = Lobby.Actions.LobbySettings(f36_arg0, f36_arg2)
	local f36_local19 = Lobby.Actions.UpdateUI(f36_arg0, f36_arg2)
	local f36_local20 = Lobby.Actions.RunPlaylistSettings(f36_arg0)
	local f36_local21 = {
		head = f36_local8,
		interrupt = f36_local3,
		force = false,
		cancellable = false,
	}
	Lobby.Process.AddActions(f36_local8, f36_local10, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local10, f36_local11, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local11, f36_local13, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local13, f36_local18, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local18, f36_local20, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local20, f36_local14, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local14, f36_local15, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local15, f36_local16, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local16, f36_local17, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local17, f36_local19, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local19, f36_local12, f36_local4, f36_local4)
	Lobby.Process.AddActions(f36_local12, f36_local9, f36_local4, f36_local4)
	return f36_local21
end
Lobby.ProcessNavigate.CreatePublicGameLobby = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3)
	Lobby.ProcessNavigate.RemoveAllBots()
	local f40_local0 = Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"])
	local f40_local1 = function()
		Lobby.Debug.JBMatchmakingEvent(LuaEnum.JB_MATCHMAKING_EVENT.END)
	end
	local f40_local2 = Lobby.Actions.ExecuteScript(f40_local1)
	local f40_local3 = Lobby.Actions.ExecuteScript(f40_local1)
	local f40_local4 = {
		controller = f40_arg0,
		errorTarget = f40_arg1,
		isPublic = true,
	}
	local f40_local5 = Lobby.Interrupt.Back(Lobby.ProcessNavigate.GameLobbyInterrupt, f40_local4)
	local f40_local6 = Lobby.Interrupt.ErrorMsg(Lobby.ProcessNavigate.GameLobbyInterrupt, f40_local4, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"))
	local f40_local7 = function() end
	local f40_local8 = function()
		Lobby.Timer.HostingLobby({
			controller = f40_arg0,
			lobbyType = f40_arg2[@"lobbytype"],
			mainMode = f40_arg2[@"mainmode"],
			lobbyTimerType = f40_arg2[@"hash_5558B67A321D1120"],
		})
		Lobby.Matchmaking.ClearSearchInfo()
	end
	local f40_local9 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_join"])
	end
	local f40_local10 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end
	local f40_local11 = function(f46_arg0)
		if LuaUtils.IsArenaPublicGame() then
			Lobby.Matchmaking.SetupMatchmakingQuery(f40_arg0, Lobby.Matchmaking.SearchMode.ARENA, f46_arg0)
		else
			Lobby.Matchmaking.SetupMatchmakingQuery(f40_arg0, Lobby.Matchmaking.SearchMode.PUBLIC, f46_arg0)
		end
	end
	local f40_local12 = function()
		Lobby.Matchmaking.UpdatePublicLobby({
			stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1,
			stageTitle = @"hash_7EE23E72D89E24F1",
			stageDetails = Engine[@"hash_4F9F1239CFD921FE"](LuaEnum.SEARCH_DESCRIPTION_STRING[LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1]),
		})
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.isMatchmaking"), true)
	end
	local f40_local13 = function()
		Lobby.Matchmaking.UpdatePublicLobby({
			stage = LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4,
			stageTitle = @"hash_4D62495C7EEE7626",
			stageDetails = Engine[@"hash_4F9F1239CFD921FE"](LuaEnum.SEARCH_DESCRIPTION_STRING[LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4]),
		})
		Engine[@"setmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.isMatchmaking"), false)
	end
	f40_local11(true)
	local f40_local14 = Lobby.Actions.OpenSpinner(true)
	local f40_local15 = Lobby.Actions.CloseSpinner()
	local f40_local16 = Lobby.Actions.WaitForJoiningClients(5000)
	local f40_local17 = Lobby.Actions.ExecuteScript(f40_local9)
	local f40_local18 = Lobby.Actions.ExecuteScript(f40_local10)
	local f40_local19 = Lobby.Actions.SetQueueCancellable(true)
	local f40_local20 = Lobby.Actions.LobbyHostStart(f40_arg0, f40_arg2[@"mainmode"], f40_arg2[@"lobbytype"], f40_arg2[@"lobbymode"], f40_arg2[@"maxclients"], "", "")
	local f40_local21 = Lobby.Actions.LobbyInfoProbe(f40_arg0, {
		xuid = Engine[@"getxuid64"](f40_arg0),
	})
	local f40_local22 = Lobby.Actions.LobbyJoinXUID(f40_arg0, {
		xuid = Engine[@"getxuid64"](f40_arg0),
	}, Enum[@"jointype"][@"join_type_party"])
	local f40_local23 = Lobby.Actions.LobbySettings(f40_arg0, f40_arg2)
	local f40_local24 = Lobby.Actions.UpdateUI(f40_arg0, f40_arg2)
	local f40_local25 = Lobby.Actions.RunPlaylistSettings(f40_arg0)
	local f40_local26 = Lobby.Actions.IsButtonPressed(f40_arg0, "BUTTON_X")
	local f40_local27 = Lobby.Actions.IsDvarSet("lobbySearchSkip", true)
	local f40_local28 = Lobby.Actions.IsDvarSet("lobbyAdvertiseSkip", true)
	local f40_local29 = Lobby.Actions.EvaluateFunction(f40_local12)
	local f40_local30 = Lobby.Actions.EvaluateFunction(f40_local13)
	local f40_local31 = 0
	if f40_arg3 and f40_arg3 > 0 then
		f40_local31 = f40_arg3
	end
	local f40_local32 = Lobby.Actions.TimeDelay(f40_local31)
	local f40_local33 = Lobby.Actions.SearchForLobby(f40_arg0, f40_local0)
	local f40_local34 = Lobby.Actions.SearchForLobby(f40_arg0, f40_local0)
	local f40_local35 = Lobby.Actions.SearchForLobby(f40_arg0, f40_local0)
	local f40_local36 = Lobby.Actions.SearchForLobby(f40_arg0, f40_local0)
	local f40_local37 = Lobby.Actions.SearchForLobby(f40_arg0, f40_local0)
	local f40_local38 = Lobby.Actions.SearchForLobby(f40_arg0, f40_local0)
	local f40_local39 = Lobby.Actions.QoSJoinSearchResults(f40_arg0, f40_local33)
	local f40_local40 = Lobby.Actions.QoSJoinSearchResults(f40_arg0, f40_local34)
	local f40_local41 = Lobby.Actions.QoSJoinSearchResults(f40_arg0, f40_local35)
	local f40_local42 = Lobby.Actions.QoSJoinSearchResults(f40_arg0, f40_local36)
	local f40_local43 = Lobby.Actions.QoSJoinSearchResults(f40_arg0, f40_local37)
	local f40_local44 = Lobby.Actions.QoSJoinSearchResults(f40_arg0, f40_local38)
	local f40_local45 = Lobby.Actions.TimeDelay(Dvar[@"lobbysearchdelay"]:get())
	local f40_local46 = Lobby.Actions.TimeDelay(Dvar[@"lobbysearchdelay"]:get())
	local f40_local47 = Lobby.Actions.TimeDelay(Dvar[@"lobbysearchdelay"]:get())
	local f40_local48 = Lobby.Actions.TimeDelay(Dvar[@"lobbysearchdelay"]:get())
	local f40_local49 = Lobby.Actions.TimeDelay(Dvar[@"lobbysearchdelay"]:get())
	f40_local33.name = f40_local33.name .. "_1"
	f40_local34.name = f40_local34.name .. "_2"
	f40_local35.name = f40_local35.name .. "_3"
	f40_local36.name = f40_local36.name .. "_4"
	f40_local37.name = f40_local37.name .. "_5"
	f40_local38.name = f40_local38.name .. "_6"
	f40_local39.name = f40_local39.name .. "_1"
	f40_local40.name = f40_local40.name .. "_2"
	f40_local41.name = f40_local41.name .. "_3"
	f40_local42.name = f40_local42.name .. "_4"
	f40_local43.name = f40_local43.name .. "_5"
	f40_local44.name = f40_local44.name .. "_6"
	local f40_local50 = Lobby.Actions.CanHostServer(f40_arg0, f40_arg2)
	local f40_local51 = Lobby.Actions.TimeDelay(1500)
	local f40_local52 = Lobby.Actions.ExecuteScript(f40_local11, false)
	local f40_local53 = Lobby.Actions.AdvertiseLobby(true)
	local f40_local54 = Lobby.Actions.ExecuteScript(f40_local7)
	local f40_local55 = Lobby.Actions.ExecuteScript(f40_local8)
	local f40_local56 = {
		head = f40_local14,
		interrupt = f40_local5,
		force = false,
		cancellable = false,
	}
	Lobby.Process.AddActions(f40_local14, f40_local16, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local16, f40_local17, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local17, f40_local20, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local20, f40_local23, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local23, f40_local25, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local25, f40_local54, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local54, f40_local21, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local21, f40_local22, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local22, f40_local24, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local24, f40_local15, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local15, f40_local18, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local18, f40_local19, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local19, f40_local26, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local26, f40_local28, f40_local27, f40_local27)
	Lobby.Process.AddActions(f40_local27, f40_local28, f40_local32, f40_local32)
	Lobby.Process.ForceAction(f40_local32, f40_local29)
	Lobby.Process.ForceAction(f40_local29, f40_local33)
	Lobby.Process.AddActions(f40_local33, f40_local39, f40_local45, f40_local6)
	Lobby.Process.AddActions(f40_local39, f40_local2, f40_local45, f40_local6)
	Lobby.Process.ForceAction(f40_local45, f40_local34)
	Lobby.Process.AddActions(f40_local34, f40_local40, f40_local46, f40_local6)
	Lobby.Process.AddActions(f40_local40, f40_local2, f40_local46, f40_local6)
	Lobby.Process.ForceAction(f40_local46, f40_local35)
	Lobby.Process.AddActions(f40_local35, f40_local41, f40_local47, f40_local6)
	Lobby.Process.AddActions(f40_local41, f40_local2, f40_local47, f40_local6)
	Lobby.Process.ForceAction(f40_local47, f40_local36)
	Lobby.Process.AddActions(f40_local36, f40_local42, f40_local48, f40_local6)
	Lobby.Process.AddActions(f40_local42, f40_local2, f40_local48, f40_local6)
	Lobby.Process.ForceAction(f40_local48, f40_local37)
	Lobby.Process.AddActions(f40_local37, f40_local43, f40_local49, f40_local6)
	Lobby.Process.AddActions(f40_local43, f40_local2, f40_local49, f40_local6)
	Lobby.Process.ForceAction(f40_local49, f40_local38)
	Lobby.Process.AddActions(f40_local38, f40_local44, f40_local50, f40_local6)
	Lobby.Process.AddActions(f40_local44, f40_local2, f40_local50, f40_local6)
	Lobby.Process.ForceAction(f40_local2, f40_local30)
	Lobby.Process.AddActions(f40_local50, f40_local28, f40_local51, f40_local6)
	Lobby.Process.AddActions(f40_local51, f40_local52, f40_local52, f40_local52)
	Lobby.Process.AddActions(f40_local52, f40_local33, f40_local33, f40_local33)
	Lobby.Process.AddActions(f40_local28, f40_local55, f40_local3, f40_local3)
	Lobby.Process.AddActions(f40_local3, f40_local53, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local53, f40_local55, f40_local6, f40_local6)
	Lobby.Process.AddActions(f40_local55, f40_local30, f40_local6, f40_local6)
	return f40_local56
end
Lobby.ProcessNavigate.LeaveGameLobby = function(f49_arg0, f49_arg1, f49_arg2, f49_arg3, f49_arg4)
	Lobby.ProcessNavigate.RemoveAllBots()
	local f49_local0 = Lobby.Interrupt.ErrorMsg(Lobby.ProcessNavigate.GameLobbyInterrupt, {
		controller = f49_arg0,
		errorTarget = f49_arg2,
	}, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"))
	Engine[@"lobbylaunchclear"]()
	local f49_local1 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end
	local f49_local2 = Lobby.Actions.LobbyVMCallRetVal(Lobby.Timer.HostingLobbyEnd, {
		controller = f49_arg0,
		lobbyType = Enum[@"lobbytype"][@"lobby_type_game"],
		mainMode = f49_arg2[@"mainmode"],
	}, true, false, false)
	local f49_local3 = Lobby.Actions.ExecuteScript(f49_local1)
	local f49_local4 = Lobby.Actions.EmptyAction()
	local f49_local5 = Lobby.Actions.OpenSpinner()
	local f49_local6 = Lobby.Actions.CloseSpinner()
	local f49_local7 = Lobby.Actions.LeaveWithParty(3000)
	local f49_local8 = Lobby.Actions.LobbySettings(f49_arg0, f49_arg2)
	local f49_local9 = Lobby.Actions.SwitchMode(f49_arg0, f49_arg4)
	local f49_local10 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f49_local11 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f49_local12 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f49_local13 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f49_local14 = Lobby.Actions.LobbyHostStart(f49_arg0, f49_arg2[@"mainmode"], f49_arg2[@"lobbytype"], f49_arg2[@"lobbymode"], f49_arg2[@"maxclients"], "", "")
	local f49_local15 = Lobby.Actions.LobbyHostAddPrimary(Enum[@"lobbytype"][@"lobby_type_private"])
	local f49_local16 = Lobby.Actions.LobbyClientStart(Enum[@"lobbytype"][@"lobby_type_private"])
	local f49_local17 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"])
	local f49_local18 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"])
	local f49_local19 = Engine[@"getlobbyclientcount"](Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) and Enum[@"lobbymodule"][@"lobby_module_host"] or Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	local f49_local20 = Lobby.Actions.UpdateUI(f49_arg0, f49_arg2)
	local f49_local21 = {
		head = nil,
		interrupt = Lobby.Interrupt.NONE,
		force = false,
		cancellable = false,
	}
	local f49_local22 = nil
	if f49_local17 == true then
		f49_local21.head = f49_local5
		Lobby.Process.AddActions(f49_local5, f49_local2, f49_local0, f49_local0)
		Lobby.Process.AddActions(f49_local2, f49_local4, f49_local6, f49_local0)
		f49_local22 = f49_local4
		if f49_local18 == true and f49_local19 > 1 and f49_arg3 == LuaEnum.LEAVE_WITH_PARTY.WITH then
			Lobby.Process.AddActions(f49_local22, f49_local7, f49_local0, f49_local0)
			f49_local22 = f49_local7
		end
		Lobby.Process.AddActions(f49_local22, f49_local3, f49_local0, f49_local0)
		Lobby.Process.AddActions(f49_local3, f49_local12, f49_local0, f49_local0)
		Lobby.Process.AddActions(f49_local12, f49_local13, f49_local0, f49_local0)
		f49_local22 = f49_local13
	else
		f49_local21.head = f49_local5
		f49_local22 = f49_local5
		if f49_local18 == true and f49_local19 > 1 and f49_arg3 == LuaEnum.LEAVE_WITH_PARTY.WITH then
			Lobby.Process.AddActions(f49_local22, f49_local7, f49_local0, f49_local0)
			f49_local22 = f49_local7
		end
		Lobby.Process.AddActions(f49_local22, f49_local12, f49_local0, f49_local0)
		f49_local22 = f49_local12
	end
	if f49_local18 == true then
		if f49_local19 > 1 and f49_arg3 == LuaEnum.LEAVE_WITH_PARTY.WITHOUT then
			Lobby.Process.AddActions(f49_local22, f49_local10, f49_local0, f49_local0)
			Lobby.Process.AddActions(f49_local10, f49_local11, f49_local0, f49_local0)
			Lobby.Process.AddActions(f49_local11, f49_local14, f49_local0, f49_local0)
			Lobby.Process.AddActions(f49_local14, f49_local15, f49_local0, f49_local0)
			Lobby.Process.AddActions(f49_local15, f49_local16, f49_local0, f49_local0)
			f49_local22 = f49_local16
		end
	else
		Lobby.Process.AddActions(f49_local22, f49_local10, f49_local0, f49_local0)
		Lobby.Process.AddActions(f49_local10, f49_local14, f49_local0, f49_local0)
		Lobby.Process.AddActions(f49_local14, f49_local15, f49_local0, f49_local0)
		Lobby.Process.AddActions(f49_local15, f49_local16, f49_local0, f49_local0)
		f49_local22 = f49_local16
	end
	Lobby.Process.AddActions(f49_local22, f49_local8, f49_local0, f49_local0)
	Lobby.Process.AddActions(f49_local8, f49_local20, f49_local0, f49_local0)
	Lobby.Process.AddActions(f49_local20, f49_local6, f49_local0, f49_local0)
	return f49_local21
end
Lobby.ProcessNavigate.CreatePublicGameLobbyAsyncMatchmaking = function(f51_arg0, f51_arg1, f51_arg2)
	Lobby.ProcessNavigate.RemoveAllBots()
	Lobby.MapVote.Hide()
	Lobby.Matchmaking.UpdateSearchStatus(Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]), LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE)
	local f51_local0 = {
		controller = f51_arg0,
		errorTarget = f51_arg1,
		isPublic = true,
	}
	local f51_local1 = Lobby.Interrupt.Back(Lobby.ProcessNavigate.GameLobbyInterrupt, f51_local0)
	local f51_local2 = Lobby.Interrupt.ErrorMsg(Lobby.ProcessNavigate.GameLobbyInterrupt, f51_local0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"))
	local f51_local3 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_join"])
	end
	local f51_local4 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end
	local f51_local5 = function()
		Lobby.Matchmaking.UpdateSearchStatus(Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_1, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_1_DESCRIPTION_1)
	end
	local f51_local6 = function()
		Lobby.Matchmaking.UpdateSearchStatus(Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]), LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_2, LuaEnum.SEARCH_DESCRIPTION.SEARCH_STAGE_2_DESCRIPTION_1)
	end
	local f51_local7 = Lobby.Actions.OpenSpinner(true)
	local f51_local8 = Lobby.Actions.CloseSpinner()
	local f51_local9 = Lobby.Actions.WaitForDSPingsToBeDone(f51_arg0)
	local f51_local10 = Lobby.Actions.WaitForJoiningClients(5000)
	local f51_local11 = Lobby.Actions.ExecuteScript(f51_local3)
	local f51_local12 = Lobby.Actions.ExecuteScript(f51_local4)
	local f51_local13 = Lobby.Actions.ExecuteScript(f51_local3)
	local f51_local14 = Lobby.Actions.SetQueueCancellable(true)
	local f51_local15 = Lobby.Actions.LobbySettings(f51_arg0, f51_arg2)
	local f51_local16 = Lobby.Actions.UpdateUI(f51_arg0, f51_arg2)
	local f51_local17 = Lobby.Actions.RunPlaylistSettings(f51_arg0)
	local f51_local18 = Lobby.Actions.ExecuteScript(f51_local5)
	local f51_local19 = Lobby.Actions.ExecuteScript(f51_local6)
	local f51_local20 = Lobby.Actions.AsyncMatchmakingWaitTillHostHasAllTokens(10000)
	local f51_local21 = Lobby.Actions.IsButtonPressed(f51_arg0, "BUTTON_X")
	local f51_local22 = Lobby.Actions.ExecuteScript(function()
		Dvar[@"hash_24BAF85486280784"]:set(true)
	end)
	local f51_local23 = Lobby.Actions.AsyncMatchmakingStartSearch(f51_arg0, Engine[@"numbertouint64"](40000), nil)
	local f51_local24 = Lobby.Actions.AsyncMatchmakingWaitToComplete(f51_local23)
	local f51_local25 = Lobby.Actions.AsyncMatchmakingCancel(f51_arg0, Engine[@"numbertouint64"](40000), f51_local23)
	local f51_local26 = Lobby.Interrupt.AsyncMatchmakingErrorMsg(Lobby.ProcessNavigate.GameLobbyInterrupt, f51_local0, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"), f51_local24)
	local f51_local27 = {
		head = f51_local7,
		interrupt = f51_local1,
		force = false,
		cancellable = false,
	}
	Lobby.Process.AddActions(f51_local7, f51_local15, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local15, f51_local17, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local17, f51_local16, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local16, f51_local18, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local18, f51_local14, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local14, f51_local8, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local8, f51_local9, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local9, f51_local10, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local10, f51_local11, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local11, f51_local20, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local20, f51_local21, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local21, f51_local22, f51_local23, f51_local23)
	Lobby.Process.AddActions(f51_local22, f51_local23, f51_local23, f51_local23)
	Lobby.Process.AddActions(f51_local23, f51_local19, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local19, f51_local12, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local12, f51_local24, f51_local2, f51_local2)
	Lobby.Process.AddActions(f51_local24, f51_local13, f51_local25, f51_local26)
	Lobby.Process.AddActions(f51_local25, f51_local10, f51_local2, f51_local2)
	return f51_local27
end
Lobby.ProcessNavigate.LeaveGameLobbyAsyncMatchmaking = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4)
	Lobby.ProcessNavigate.RemoveAllBots()
	local f57_local0 = Lobby.Actions.ExecuteScript(function()
		Lobby.Matchmaking.UpdateSearchStatus(Enum[@"lobbytype"][@"lobby_type_private"], LuaEnum.PUBLIC_LOBBY.INVALID, LuaEnum.SEARCH_DESCRIPTION.NONE)
	end)
	local f57_local1 = Lobby.Interrupt.ErrorMsg(Lobby.ProcessNavigate.GameLobbyInterrupt, {
		controller = f57_arg0,
		errorTarget = f57_arg2,
	}, Engine[@"hash_4F9F1239CFD921FE"](@"hash_649A850B933FDBD2"))
	Engine[@"lobbylaunchclear"]()
	local f57_local2 = function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end
	local f57_local3 = Lobby.Actions.LobbyVMCallRetVal(Lobby.Timer.HostingLobbyEnd, {
		controller = f57_arg0,
		lobbyType = Enum[@"lobbytype"][@"lobby_type_game"],
		mainMode = f57_arg2[@"mainmode"],
	}, true, false, false)
	local f57_local4 = Lobby.Actions.ExecuteScript(f57_local2)
	local f57_local5 = Lobby.Actions.EmptyAction()
	local f57_local6 = Lobby.Actions.OpenSpinner()
	local f57_local7 = Lobby.Actions.CloseSpinner()
	local f57_local8 = Lobby.Actions.LeaveWithParty(3000)
	local f57_local9 = Lobby.Actions.LobbySettings(f57_arg0, f57_arg2)
	local f57_local10 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f57_local11 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_private"])
	local f57_local12 = Lobby.Actions.LobbyClientEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f57_local13 = Lobby.Actions.LobbyHostEnd(Enum[@"lobbytype"][@"lobby_type_game"])
	local f57_local14 = Lobby.Actions.LobbyHostStart(f57_arg0, f57_arg2[@"mainmode"], Enum[@"lobbytype"][@"lobby_type_private"], f57_arg2[@"lobbymode"], f57_arg2[@"maxclients"], "", "")
	local f57_local15 = Lobby.Actions.LobbyHostAddPrimary(Enum[@"lobbytype"][@"lobby_type_private"])
	local f57_local16 = Lobby.Actions.LobbyClientStart(Enum[@"lobbytype"][@"lobby_type_private"])
	local f57_local17 = function()
		local f60_local0 = Engine[@"getplaylistid"]()
		if f57_arg2[@"egamemodes"] == Enum[@"egamemodes"][@"mode_game_matchmaking_playlist"] and f60_local0 ~= LuaDefine.INVALID_PLAYLIST_ID then
			local f60_local1 = Engine[@"getplaylistinfobyid"](f60_local0)
			Engine[@"setlobbymaxclients"](Enum[@"lobbytype"][@"lobby_type_private"], f60_local1.maxPartySize)
		else
			Engine[@"setlobbymaxclients"](f57_arg2[@"lobbytype"], f57_arg2[@"maxclients"])
		end
	end
	local f57_local18 = Lobby.Actions.ExecuteScript(function()
		Engine[@"setsessionstatus"](Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"sessionstatus"][@"session_status_idle"])
	end)
	local f57_local19 = Lobby.Actions.ExecuteScript(f57_local17)
	local f57_local20 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"])
	local f57_local21 = Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"])
	local f57_local22 = Engine[@"getlobbyclientcount"](Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) and Enum[@"lobbymodule"][@"lobby_module_host"] or Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
	local f57_local23 = Lobby.Actions.UpdateUI(f57_arg0, f57_arg2)
	local f57_local24 = Lobby.Actions.AsyncMatchmakingCancel(f57_arg0, Engine[@"numbertouint64"](20000), {
		matchmakingID = Lobby.MMAsync.Info.matchmakingID,
	})
	local f57_local25 = Lobby.Actions.ExecuteScript(function()
		Lobby.MatchmakingAsync.ClearCacheAsyncInfo()
	end)
	local f57_local26 = {
		head = nil,
		interrupt = Lobby.Interrupt.NONE,
		force = false,
		cancellable = false,
	}
	local f57_local27 = nil
	f57_local26.head = f57_local6
	Lobby.Process.AddActions(f57_local6, f57_local24, f57_local1, f57_local1)
	Lobby.Process.AddActions(f57_local24, f57_local0, f57_local1, f57_local1)
	Lobby.Process.AddActions(f57_local0, f57_local18, f57_local1, f57_local1)
	f57_local27 = f57_local18
	if f57_local20 == true then
		local f57_local28 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"])
		local f57_local29 = Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"hash_7A40FFF6EA235901"])
		Lobby.Process.AddActions(f57_local27, f57_local3, f57_local1, f57_local1)
		Lobby.Process.AddActions(f57_local3, f57_local5, f57_local7, f57_local1)
		f57_local27 = f57_local5
		if f57_local21 == true and f57_local22 > 1 and f57_arg3 == LuaEnum.LEAVE_WITH_PARTY.WITH then
			Lobby.Process.AddActions(f57_local27, f57_local8, f57_local1, f57_local1)
			f57_local27 = f57_local8
		end
		Lobby.Process.AddActions(f57_local27, f57_local4, f57_local1, f57_local1)
		Lobby.Process.AddActions(f57_local4, f57_local12, f57_local1, f57_local1)
		Lobby.Process.AddActions(f57_local12, f57_local13, f57_local1, f57_local1)
		f57_local27 = f57_local13
	else
		if f57_local21 == true and f57_local22 > 1 and f57_arg3 == LuaEnum.LEAVE_WITH_PARTY.WITH and f57_arg4 == nil then
			Lobby.Process.AddActions(f57_local27, f57_local8, f57_local1, f57_local1)
			f57_local27 = f57_local8
		end
		Lobby.Process.AddActions(f57_local27, f57_local12, f57_local1, f57_local1)
		f57_local27 = f57_local12
	end
	if f57_local21 == true then
		if f57_local22 > 1 and f57_arg3 == LuaEnum.LEAVE_WITH_PARTY.WITHOUT then
			Lobby.Process.AddActions(f57_local27, f57_local10, f57_local1, f57_local1)
			Lobby.Process.AddActions(f57_local10, f57_local11, f57_local1, f57_local1)
			Lobby.Process.AddActions(f57_local11, f57_local14, f57_local1, f57_local1)
			Lobby.Process.AddActions(f57_local14, f57_local19, f57_local1, f57_local1)
			Lobby.Process.AddActions(f57_local19, f57_local15, f57_local1, f57_local1)
			Lobby.Process.AddActions(f57_local15, f57_local16, f57_local1, f57_local1)
			f57_local27 = f57_local16
		end
	elseif f57_arg4 == nil then
		Lobby.Process.AddActions(f57_local27, f57_local10, f57_local1, f57_local1)
		Lobby.Process.AddActions(f57_local10, f57_local14, f57_local1, f57_local1)
		Lobby.Process.AddActions(f57_local14, f57_local19, f57_local1, f57_local1)
		Lobby.Process.AddActions(f57_local19, f57_local15, f57_local1, f57_local1)
		Lobby.Process.AddActions(f57_local15, f57_local16, f57_local1, f57_local1)
		f57_local27 = f57_local16
	end
	Lobby.Process.AddActions(f57_local27, f57_local25, f57_local1, f57_local1)
	Lobby.Process.AddActions(f57_local25, f57_local9, f57_local1, f57_local1)
	Lobby.Process.AddActions(f57_local9, f57_local23, f57_local1, f57_local1)
	Lobby.Process.AddActions(f57_local23, f57_local7, f57_local1, f57_local1)
	return f57_local26
end
Lobby.ProcessNavigate.ReloadGameLobby = function(f63_arg0, f63_arg1, f63_arg2)
	Lobby.ProcessNavigate.RemoveAllBots()
	local f63_local0 = LobbyData.GetCurrentMenuTarget()
	local f63_local1 = LobbyData.GetLobbyMenuByName(f63_local0[@"backtarget"])
	local f63_local2 = Lobby.ProcessNavigate.LeaveGameLobby(f63_arg0, f63_local0, f63_local0, LuaEnum.LEAVE_WITH_PARTY.WITH)
	local f63_local3 = 0
	if f63_arg1 > 0 and f63_arg2 > 0 and f63_arg1 <= f63_arg2 then
		f63_local3 = math.random(f63_arg1, f63_arg2)
	end
	local f63_local4 = Lobby.ProcessNavigate.CreatePublicGameLobby(f63_arg0, f63_local1, f63_local0, f63_local3)
	local f63_local5 = f63_local2
	Lobby.Process.AppendProcess(f63_local5, f63_local4)
	return f63_local5
end
Lobby.ProcessNavigate.RemoveAllBots = function()
	if Dvar[0x26CEEEE32A2C62]:get() == false then
		local f64_local0 = Enum[@"lobbymodule"][@"lobby_module_host"]
		local f64_local1 = Engine[@"lobbygetcontrollinglobbysession"](f64_local0)
		local f64_local2 = Engine[@"getlobbyclientcount"](f64_local0, f64_local1, Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_bot"])
		if f64_local2 > 0 then
			Engine[@"removelobbybot"](f64_local1, f64_local2)
		end
	end
end
Lobby.ProcessNavigate.OnPostExecFFOTD = function(f65_arg0)
	if f65_arg0.navToMenu ~= nil then
		LobbyVM.OnGoForward(f65_arg0)
	end
end
