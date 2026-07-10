require("x64:f3c5259f470592d")
if not CoD.PCUtil then
	CoD.PCUtil = {}
end
if not CoD.PCUtility then
	CoD.PCUtility = {}
end
CoD.PCUtility.PreventUIMenuShortcuts = false
CoD.PCUtility.HasContextualMenuActionInStack = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = false
	while f1_arg0 do
		if f1_arg0.__doNotPassButtonPressToGridLayout then
			f1_local0 = true
		end
		if f1_local0 and f1_arg0.isGridLayout then
			f1_local0 = false
		elseif f1_arg0.__contextualMenuActions then
			local f1_local1 = f1_arg0
			local f1_local2, f1_local3 = f1_arg1:FindElementInLastFocusedEvent(f1_arg0)
			if f1_local2 and f1_local3 then
				f1_local1 = f1_arg1:GetLastFocusedEventElementForFn(f1_arg0, f1_local2, f1_local3)
			end
			local f1_local4 = CoD.PCWidgetUtility.PrepareContextualMenuActions
			local f1_local5 = f1_local1
			local f1_local6 = f1_arg1
			local f1_local7 = f1_arg2
			local f1_local8 = f1_arg1.keyModel
			if f1_local8 then
				f1_local8 = f1_arg1.keyModel.MOUSE2
			end
			if f1_local4(f1_local5, f1_local6, f1_local7, f1_local8, f1_arg0.__contextualMenuActions, true) > 0 then
				return true
			end
		end
		f1_arg0 = f1_arg0:getParent()
	end
	return false
end
CoD.PCUtil.GetModelValues = function(f2_arg0, f2_arg1)
	local f2_local0 = {}
	if type(f2_arg1) == "string" then
		return CoD.SafeGetModelValue(f2_arg0, f2_arg1)
	elseif type(f2_arg1) == "table" then
		for f2_local4, f2_local5 in ipairs(f2_arg1) do
			f2_local0[f2_local5] = CoD.SafeGetModelValue(f2_arg0, f2_local5)
		end
		return f2_local0
	end
	return nil
end
CoD.PCUtil.GetElementModelValues = function(f3_arg0, f3_arg1)
	local f3_local0 = f3_arg0:getModel()
	if f3_local0 then
		return CoD.PCUtil.GetModelValues(f3_local0, f3_arg1)
	else
		return nil
	end
end
CoD.PCUtility.IsUnavailable = function(f4_arg0, f4_arg1)
	local f4_local0 = f4_arg0:getModel()
	if f4_local0 == nil then
		return false
	end
	f4_arg0._unavailable = false
	local f4_local1 = CoD.SafeGetModelValue(f4_local0, "unavailableFunction")
	if f4_local1 then
		local f4_local2 = f4_arg0._unavailable
		if not f4_local2 then
			f4_local2 = f4_local1(f4_arg1)
		end
		f4_arg0._unavailable = f4_local2
	end
	f4_local1 = CoD.SafeGetModelValue(f4_local0, "unavailable") or CoD.SafeGetModelValue(f4_local0, "available") == false
	if f4_local1 then
		f4_arg0._unavailable = f4_arg0._unavailable or f4_local1
	end
	return f4_arg0._unavailable
end
CoD.PCUtility.UIMenuShortcutTable = {
	ui_opensocial = {
		menu = "Social_Main",
		canOpen = function(f5_arg0, f5_arg1)
			return CoD.PCUtility.CanOpenSocialMenu(f5_arg0, f5_arg1)
		end,
	},
	ui_opensettings = {
		menu = "PC_StartMenu_Options_New",
		canOpen = function(f6_arg0)
			return true
		end,
	},
	ui_openstore = {
		menu = "PC_BnetStore",
		canOpen = function(f7_arg0)
			return not BattlenetStoreDisabled(f7_arg0)
		end,
	},
	ui_openPlayerAccount = {
		menu = "PC_PlayerAccount",
		canOpen = function(f8_arg0)
			return not Engine[0x7B48C1ABFF0F764]()
		end,
	},
	ui_openfriends = {
		canOpen = function(f9_arg0, f9_arg1)
			if CoD.isWarzone then
				local f9_local0 = Engine[0x4DF5CFBC1771947](f9_arg0)
				f9_local0 = f9_local0.gameScore
				if f9_local0 then
					f9_local0 = Engine[0x4DF5CFBC1771947](f9_arg0)
					f9_local0 = f9_local0.gameScore.currentState
					if f9_local0 then
						f9_local0 = Engine[0x4DF5CFBC1771947](f9_arg0)
						f9_local0 = f9_local0.gameScore.currentState:get()
					end
				end
				if f9_local0 and f9_local0 ~= "" then
					return true
				end
			end
			return f9_arg1.id ~= "Menu.HUD"
		end,
		isOpen = function(f10_arg0, f10_arg1)
			local f10_local0 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel(f10_arg0)
			return f10_local0:get()
		end,
		openFunc = function(f11_arg0, f11_arg1)
			local f11_local0 = CoD.PCBattlenetUtility.GetBattlenetMenuVisibilityModel(f11_arg0)
			if not f11_local0:get() then
				CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility(f11_arg1, f11_arg1, f11_arg0)
			end
		end,
		closeFunc = function(f12_arg0, f12_arg1)
			CoD.PCBattlenetUtility.CloseBattlenetMenu(f12_arg1, f12_arg1, f12_arg0, true)
		end,
		keepShortcutMenuOpened = true,
	},
	ui_openQuarterMaster = {
		menu = "QuarterMasterMenu",
		canOpen = function(f13_arg0)
			return not BattlenetStoreDisabled(f13_arg0)
		end,
	},
}
if not CoD.PCUtility.__lockUIShortcutInputList then
	CoD.PCUtility.__lockUIShortcutInputList = {}
end
CoD.PCUtility.ClearLockUIShortcutInputInternal = function(f14_arg0)
	local f14_local0 = f14_arg0:getOwner()
	for f14_local4, f14_local5 in pairs(CoD.PCUtility.__lockUIShortcutInputList) do
		if f14_local5 == f14_arg0 then
			table.remove(CoD.PCUtility.__lockUIShortcutInputList, f14_local4)
			break
		end
	end
	if table.getn(CoD.PCUtility.__lockUIShortcutInputList) == 0 then
		f14_local1 = Engine[0x4DF5CFBC1771947](f14_local0)
		f14_local1.LockUIShortcutInput:set(false)
	end
end
CoD.PCUtility.ResetLockUIShortcutModelForController = function(f15_arg0)
	local f15_local0 = Engine[0x4DF5CFBC1771947](f15_arg0)
	f15_local0 = f15_local0.LockUIShortcutInput
	if f15_local0 then
		f15_local0:set(false)
	end
end
CoD.PCUtility.LockUIShortcutInput = function(f16_arg0, f16_arg1)
	for f16_local3, f16_local4 in pairs(CoD.PCUtility.__lockUIShortcutInputList) do
		if f16_local4 == f16_arg0 then
			return
		end
	end
	table.insert(CoD.PCUtility.__lockUIShortcutInputList, f16_arg0)
	if not LuaUtils.FindItemInArray(LUI.OverrideFunction_GetFunctionTable(f16_arg0, "close"), CoD.PCUtility.ClearLockUIShortcutInputInternal) then
		LUI.OverrideFunction_CallOriginalSecond(f16_arg0, "close", CoD.PCUtility.ClearLockUIShortcutInputInternal)
	end
	f16_local2 = Engine[0x4DF5CFBC1771947](f16_arg1)
	f16_local2.LockUIShortcutInput:set(true)
end
CoD.PCUtility.UnlockUIShortcutInput = function(f17_arg0, f17_arg1)
	CoD.PCUtility.ClearLockUIShortcutInputInternal(f17_arg0)
end
CoD.PCUtility.AreUIShortcutInputLocked = function(f18_arg0)
	local f18_local0 = Engine[0x4DF5CFBC1771947](f18_arg0)
	return f18_local0.LockUIShortcutInput:get()
end
CoD.PCUtility.ShorcutMenuUnsupportedParent = {
	"Armory",
	"Armory_AttachmentSelect",
	"SinglePlayerInspection",
}
CoD.PCUtility.ShortcutSpamCooldown = 250
CoD.PCUtility.SpamLastTimeShortcutPressed = 0
CoD.PCUtility.ToggleShortcutMenu = function(f19_arg0, f19_arg1, f19_arg2)
	if CoD.PCUtility.AreUIShortcutInputLocked(f19_arg1) then
		return
	elseif CoD.StartMenuUtility.IsClassSelectSlideoutOpen(f19_arg1) then
		CoD.StartMenuUtility.HideClassSelectSlideout(f19_arg0, f19_arg1)
		return
	end
	local f19_local0 = CoD.PCUtility.UIMenuShortcutTable[f19_arg2]
	if f19_local0 and not f19_local0.keepShortcutMenuOpened then
		local f19_local1 = Engine[0x9D33D652B9B0F3B]()
		if f19_local1 - CoD.PCUtility.SpamLastTimeShortcutPressed < CoD.PCUtility.ShortcutSpamCooldown then
			return
		end
		CoD.PCUtility.SpamLastTimeShortcutPressed = f19_local1
	end
	local f19_local1 = f19_arg0
	local f19_local2 = f19_arg0
	while f19_local1 and f19_local1.occludedMenu do
		f19_local1 = f19_local1.occludedMenu
	end
	while f19_local2 and f19_local2.occludedBy do
		f19_local2 = f19_local2.occludedBy
	end
	CoD.PCWidgetUtility.CloseContextualMenu(f19_local2, f19_arg1)
	for f19_local6, f19_local7 in pairs(CoD.PCUtility.UIMenuShortcutTable) do
		if f19_local7.keepShortcutMenuOpened then
			if f19_arg2 == f19_local6 then
				if f19_local7.isOpen and f19_local7.isOpen(f19_arg1, f19_local2) then
					if f19_local7.closeFunc then
						f19_local7.closeFunc(f19_arg1, f19_local2)
					end
				elseif f19_local7.canOpen and f19_local7.canOpen(f19_arg1, f19_local2) and f19_local7.openFunc then
					f19_local7.openFunc(f19_arg1, f19_local2)
				end
				return
			elseif f19_local7.closeFunc then
				f19_local7.closeFunc(f19_arg1, f19_local2)
			end
		end
	end
	if f19_local0 and f19_local0.canOpen and f19_local0.canOpen(f19_arg1, f19_local2) then
		for f19_local6, f19_local7 in ipairs(CoD.PCUtility.ShorcutMenuUnsupportedParent) do
			if f19_local2.menuName == f19_local7 then
				f19_local2 = GoBackToMenu(f19_local2, f19_arg1, "Director")
				break
			end
		end
		f19_local3, f19_local4 = nil
		for f19_local12, f19_local13 in pairs(CoD.PCUtility.UIMenuShortcutTable) do
			if f19_local13.menu then
				local f19_local8 = f19_local13.menu
				local f19_local9 = "Menu." .. f19_local8
				local f19_local10, f19_local11 = CoD.Menu.GetNavigationForMenu(f19_arg1, f19_local8)
				if f19_local10 then
					f19_local3 = f19_local1
					while f19_local3 ~= nil and f19_local3.id ~= f19_local9 do
						f19_local3 = f19_local3.occludedBy
					end
					if f19_local3 then
						f19_local4 = f19_local8
					end
				end
			end
		end
		f19_local5 = CoD.PCOptionsUtility.AreOptionsDirty(f19_arg1)
		if f19_local5 then
			f19_local5 = CoD.PCOptionsUtility.IsGraphicsOptions(f19_arg1)
		end
		if not CoD.CraftUtility.IsEmblemEmpty(f19_arg1) then
			f19_local6 = CoD.CraftUtility.Emblems_HasChanges(nil, f19_arg1)
		else
			f19_local6 = false
		end
		f19_local7 = function()
			local f20_local0 = f19_local1
			while f20_local0 and f20_local0.occludedBy do
				f20_local0 = f20_local0.occludedBy
			end
			if not f19_local0.menu or f19_local4 ~= f19_local0.menu then
				local f20_local1 = OpenOverlay(f20_local0, f19_local0.menu, f19_arg1, nil)
				if f20_local1 and not InFrontend() and IsInGame() and Engine[0xC9ACE8D8FE6136]() and Dvar[0xBF32EA04B74B241]:get() ~= 1 then
					Dvar[0xBF32EA04B74B241]:set(1)
					if not f20_local1._pauseGameGoBackOverride then
						f20_local1._pauseGameGoBackOverride = function(f21_arg0)
							Dvar[0xBF32EA04B74B241]:set(0)
							LUI.OverrideFunction_Remove(f21_arg0, "goBack", f21_arg0._pauseGameGoBackOverride)
							f21_arg0._pauseGameGoBackOverride = nil
						end
						LUI.OverrideFunction_CallOriginalFirst(f20_local1, "goBack", f20_local1._pauseGameGoBackOverride)
					end
				end
			end
		end
		f19_local12 = function(f22_arg0, f22_arg1)
			CoD.PCWidgetUtility.CloseChat(f22_arg0, f22_arg1)
			GoBack(f22_arg0, f22_arg1)
		end
		if f19_local3 and not f19_local0.keepShortcutMenuOpened then
			if f19_local6 then
				f19_local13 = function(f23_arg0)
					if not f23_arg0 then
						f23_arg0 = f19_arg0
					end
					CoD.CraftUtility.EditorCloseFromFooter(nil, f19_arg1)
					CoD.PCUtility.ToggleShortcutMenu(f23_arg0, f19_arg1, f19_arg2)
				end
				if IsPaintshop(f19_arg1) then
					CoD.OverlayUtility.CreateOverlay(f19_arg1, f19_local2, "PaintjobSave", f19_arg1, CoD.perController[f19_arg1].selectedPaintjobModel, false, f19_local13)
				else
					CoD.OverlayUtility.CreateOverlay(f19_arg1, f19_local2, "EmblemSave", f19_arg1, CoD.perController[f19_arg1].selectedEmblemModel, false, f19_local13)
				end
				return true
			elseif f19_local3.occludedBy then
				GoBackToMenu(f19_local2, f19_arg1, f19_local4)
			end
			if not f19_local5 then
				f19_local12(f19_local3, f19_arg1)
			else
				CoD.OverlayUtility.CreateOverlay(f19_arg1, f19_arg0, "PendingChangesOnQuitOptionsMenu", function()
					f19_local12(f19_local3, f19_arg1)
					f19_local7()
				end)
				return true
			end
		end
		f19_local7()
		return true
	end
	return false
end
CoD.PCUtility.ShortcutMenuGoBack = function(f25_arg0, f25_arg1)
	if not f25_arg0:getParent() then
		return
	end
	assert(f25_arg0.occludedMenu)
	if f25_arg0.occludedMenu.menuName ~= "StartMenu_Main" then
		local f25_local0 = f25_arg0
		while f25_local0 and f25_local0.occludedBy do
			f25_local0 = f25_local0.occludedBy
		end
		GoBackToMenu(f25_local0, f25_arg1, f25_arg0.occludedMenu.menuName)
	end
end
CoD.PCUtility.SetupUIMenuShortcuts = function(f26_arg0, f26_arg1)
	for f26_local3, f26_local4 in pairs(CoD.PCUtility.UIMenuShortcutTable) do
		f26_arg0:subscribeToModel(Engine[0xA9FCAD7BE6FA349](f26_local3, f26_arg1), function(model)
			local f27_local0
			if not CoD.PCUtility.PreventUIMenuShortcuts and (not CoD.Menu.IsPriorityMenuOpen(f26_arg1) or f26_arg0._isPriorityMenu) and not CoD.Menu.SpinnerIsActive then
				f27_local0 = CoD.BitUtility.IsBitwiseAndNonZero(Engine[0x614D394F6F9A18D](model), Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464])
				if f27_local0 then
					f27_local0 = not f26_arg0.m_disableAllButtonActions
				end
			else
				f27_local0 = false
			end
			if f27_local0 and not CoD.BitUtility.IsBitwiseAndNonZero(model:get(), Enum[0xE29E259801BC1A4][0x3DC8FC0E6AB543F]) and not CoD.PCUtility.AreUIShortcutInputLocked(f26_arg1) and CoD.PCUtility.ToggleShortcutMenu(f26_arg0, f26_arg1, f26_local3) and not InFrontend() then
				CoD.ScoreboardUtility.HideScoreboard(nil, f26_arg1)
			end
		end, false)
	end
end
CoD.PCUtility.ConfirmChangeClass = function(f28_arg0, f28_arg1)
	if f28_arg0 and f28_arg0.ChooseClassSlideOut and f28_arg0.ChooseClassSlideOut.customClassInternal then
		local f28_local0 = f28_arg0.ChooseClassSlideOut.customClassInternal
		local f28_local1 = f28_arg0:getParent()
		if f28_local1 then
			ChangeClass(f28_arg0, f28_local0, f28_local0.ClassList, f28_arg1)
			CoD.StartMenuUtility.HideClassSelectSlideout(f28_arg0, f28_arg1)
			if f28_local1.id == "Menu.ChooseSpecialistMidMatch" then
				GoBack()
			elseif f28_local1.id ~= "Menu.PositionDraft" then
				StartMenuGoBack(f28_local1, f28_arg1)
			end
		end
	end
end
CoD.PCUtility.SetMouseFocusedElementModelToOtherElementModel = function(f29_arg0, f29_arg1)
	local f29_local0 = CoD.GetMouseFocus(f29_arg1)
	if f29_local0 then
		CoD.BaseUtility.SetElementModelToOtherElementModel(f29_arg1, f29_arg0, f29_local0)
	end
end
CoD.PCUtility.SetMouseFocusedElementModelToMenuModel = function(f30_arg0, f30_arg1)
	local f30_local0 = CoD.GetMouseFocus(f30_arg1)
	if f30_local0 then
		CoD.BaseUtility.SetMenuModelToElementModel(f30_arg0, f30_local0)
	end
end
CoD.PCUtility.CanOpenSocialMenu = function(f31_arg0, f31_arg1)
	local f31_local0
	if not IsLAN() and not IsPlayerAGuest(f31_arg0) then
		f31_local0 = IsPlayerAllowedToPlayOnline(f31_arg0)
		if f31_local0 then
			if not IsCurrentMenu(f31_arg1, "SinglePlayerInspection") then
				if Engine[0x573048F8D3B4E25]() then
					f31_local0 = CoD.PCUtility.IsBGSEnabled()
					if f31_local0 then
					else
						return f31_local0
					end
				end
				f31_local0 = not CoD.PCUtility.AreUIShortcutInputLocked(f31_arg0)
			else
				f31_local0 = false
			end
		end
	else
		f31_local0 = false
	end
	return f31_local0
end
CoD.PCUtility.CanOpenPlayerAccount = function(f32_arg0, f32_arg1)
	return not CoD.PCUtility.AreUIShortcutInputLocked(f32_arg0)
end
CoD.PCUtility.CanOpenSettings = function(f33_arg0, f33_arg1)
	return not CoD.PCUtility.AreUIShortcutInputLocked(f33_arg0)
end
CoD.PCUtility.CanOpenStore = function(f34_arg0, f34_arg1)
	return not CoD.PCUtility.AreUIShortcutInputLocked(f34_arg0)
end
CoD.PCUtility.CanOpenFriends = function(f35_arg0, f35_arg1)
	return CoD.PCUtility.IsBGSEnabled() and not CoD.PCUtility.AreUIShortcutInputLocked(f35_arg0)
end
CoD.PCUtility.CallValueUpdateIfExist = function(f36_arg0, f36_arg1)
	if f36_arg0._optionProperties and f36_arg0._optionProperties._valueUpdated then
		f36_arg0._optionProperties:_valueUpdated(f36_arg1)
	end
end
CoD.PCUtil.SimulateButtonPress = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
	local f37_local0 = Engine[0x614D394F6F9A18D](f37_arg3.Button)
	local f37_local1 = f37_arg3.KeyShortcut
	if f37_local1 then
		f37_local1 = f37_arg3.KeyShortcut:get()
	end
	local f37_local2 = Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464]
	if f37_local1 and not f37_arg4 and f37_arg0.keyModel[f37_local1] then
		f37_arg3 = f37_arg0.keyModel[f37_local1]
	end
	if f37_arg3 and f37_arg3.flags then
		local f37_local3 = f37_arg3.flags:get()
		local f37_local4 = CoD.BitUtility.IsBitwiseAndNonZero(f37_local3, Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0])
		if CoD.BitUtility.IsBitwiseAndNonZero(f37_local3, Enum[0xBEBDBAEEB3ECCCA][0x71B04FAC5BE0E35]) then
			f37_local2 = f37_local2 + Enum[0xE29E259801BC1A4][0xDD6E7E17ACBF288]
		end
		if f37_local4 then
			f37_local2 = f37_local2 + Enum[0xE29E259801BC1A4][0x715085B24AAB606]
		end
		if f37_local1 and not f37_arg4 then
			local f37_local5 = CoD.Menu.HandlePCKeyPress
			local f37_local6 = f37_arg0
			local f37_local7 = f37_arg2
			local f37_local8 = f37_local1
			local f37_local9 = Engine[0x4DF5CFBC1771947](f37_arg2)
			f37_local9 = f37_local9.KeyPressBits[f37_local1]
			if not f37_local9 then
				f37_local9 = Engine[0x4DF5CFBC1771947](f37_arg2)
				f37_local9 = f37_local9.BindingBits[f37_local1]
			end
			f37_local5(f37_local6, f37_local7, f37_local8, f37_local9, f37_local0, f37_local2)
		else
			local f37_local5 = CoD.Menu.HandleButtonPress
			local f37_local6 = f37_arg0
			local f37_local7 = f37_arg2
			local f37_local8 = f37_local0
			local f37_local9 = Engine[0x4DF5CFBC1771947](f37_arg2)
			f37_local5(f37_local6, f37_local7, f37_local8, f37_local9.ButtonBits[f37_local0], f37_local2)
		end
	end
end
CoD.PCUtil.SimulateButtonPressUsingElement = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3)
	local f38_local0 = f38_arg1:getModel()
	if f38_local0 and f38_local0.Button then
		CoD.PCUtil.SimulateButtonPress(f38_arg0, f38_arg1, f38_arg2, f38_local0, f38_arg3)
	end
end
CoD.PCUtil.SimulateDPadButtonPress = function(f39_arg0, f39_arg1)
	local f39_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f39_arg0), "ButtonBits." .. f39_arg1)
	if f39_local0 then
		Engine[0x83C9B5DE1D9371](f39_local0, Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464] | Enum[0xE29E259801BC1A4][0xBAF13F65A51F649])
	end
end
CoD.PCUtility.ReplaceButtonLabelForPC = function(f40_arg0, f40_arg1)
	if f40_arg1 == 0x70A9FDC87CD3D48 or f40_arg1 == 0x78D439E1B360368 or f40_arg1 == 0xEF2D3320785B51A or f40_arg1 == 0x3996BAAC73C3F6D then
		return 0xFE8B7EA55114B2A
	elseif f40_arg1 == 0xC2E92C54C2BE289 then
		return 0xF30BC90052E4F39
	elseif f40_arg1 == 0xB2EF56B4AF147B8 then
		return 0xA4D5CCF602C652E
	else
		return f40_arg1
	end
end
CoD.PCUtil.SetupButtonLabelForPC = function(f41_arg0, f41_arg1)
	local f41_local0 = f41_arg1.Label
	f41_arg1.TooltipLabel:set(Engine[0xF9F1239CFD921FE](f41_arg0) or nil)
	if f41_arg0 == 0x70A9FDC87CD3D48 or f41_arg0 == 0x78D439E1B360368 or f41_arg0 == 0xEF2D3320785B51A or f41_arg0 == 0x3996BAAC73C3F6D or f41_arg0 == 0xC2E92C54C2BE289 then
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f41_arg1, "TooltipKeyShortcut"), 0x605DAF0D67709A)
	end
end
CoD.PCUtility.RegisterPCSmallCloseButtonWidget = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
	f42_arg2.__pcSmallCloseButtonWidget = f42_arg3
end
CoD.PCUtility.LinkPCSmallCloseButtonToInput = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3)
	if not f43_arg2.__pcSmallCloseButtonWidget then
		return
	elseif f43_arg2.__pcSmallCloseButtonSubscription then
		f43_arg2.__pcSmallCloseButtonWidget:removeSubscription(f43_arg2.__pcSmallCloseButtonSubscription)
	end
	f43_arg2.__pcSmallCloseButtonLinkedInput = f43_arg3
	UpdateSelfElementState(f43_arg0, f43_arg2.__pcSmallCloseButtonWidget, f43_arg1)
	local f43_local0 = f43_arg2.__pcSmallCloseButtonWidget
	local f43_local1 = f43_local0
	f43_local0 = f43_local0.subscribeToModel
	local f43_local2 = Engine[0x4DF5CFBC1771947](f43_arg1)
	f43_arg2.__pcSmallCloseButtonSubscription = f43_local0(f43_local1, f43_local2[f43_arg0.menuName .. ".buttonPrompts." .. f43_arg3], function(f44_arg0)
		UpdateSelfElementState(f43_arg0, f43_arg2.__pcSmallCloseButtonWidget, f43_arg1)
	end, false)
end
CoD.PCUtility.SendPCSmallCloseButtonLinkedInput = function(f45_arg0, f45_arg1, f45_arg2)
	if CoD.PCUtility.PCSmallCloseButtonHasLinkedInput(f45_arg0, f45_arg1, f45_arg2) then
		SendButtonPressToMenuEx(f45_arg0, f45_arg1, f45_arg2.__pcSmallCloseButtonLinkedInput)
	end
end
CoD.PCUtility.CanShowPCSmallCloseButton = function(f46_arg0, f46_arg1, f46_arg2)
	if IsGamepad(f46_arg1) then
		return false
	elseif CoD.PCUtility.PCSmallCloseButtonHasLinkedInput(f46_arg0, f46_arg1, f46_arg2) then
		local f46_local0 = Engine[0x4DF5CFBC1771947](f46_arg1)
		f46_local0 = f46_local0[f46_arg0.menuName .. ".buttonPrompts." .. f46_arg2.__pcSmallCloseButtonLinkedInput]
		return f46_local0 and f46_local0:get() == 1
	else
		return true
	end
end
CoD.PCUtility.PCSmallCloseButtonHasLinkedInput = function(f47_arg0, f47_arg1, f47_arg2)
	return f47_arg2.__pcSmallCloseButtonLinkedInput and f47_arg2.__pcSmallCloseButtonLinkedInput ~= Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8]
end
CoD.PCUtility.PCSmallCloseButtonLinkedInputIsValue = function(f48_arg0, f48_arg1, f48_arg2, f48_arg3)
	return f48_arg2.__pcSmallCloseButtonLinkedInput == f48_arg3
end
CoD.PCUtil.Craft_WidgetSelectorFunc = function(f49_arg0, f49_arg1, f49_arg2)
	if f49_arg1 then
		local f49_local0 = Engine[0x40E824FE270E174](f49_arg1, "widgetType")
		if f49_local0 then
			local f49_local1 = Engine[0x614D394F6F9A18D](f49_local0)
			if f49_local1 == "header" then
				return CoD.CraftActionHeader
			elseif f49_local1 == "button" then
				return CoD.CraftActionButton
			elseif f49_local1 == "slider" then
				return CoD.CraftActionSlider
			end
		end
	end
	return nil
end
DataSources.CraftActionsPC = DataSourceHelpers.ListSetup(
	"PC.CraftActionsPC",
	function(f50_arg0, f50_arg1)
		local f50_local0 = {}
		if CoD.CraftUtility.GetEmblemEditorProperties(f50_arg0, "editorMode") == Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD] then
			return CoD.PCUtil.Craft_GetEmblemEditorEditModeActions(f50_arg0, f50_arg1.menu)
		else
			return CoD.PCUtil.Craft_GetEmblemEditorBrowseModeActions(f50_arg0)
		end
	end,
	false,
	{
		getWidgetTypeForItem = CoD.PCUtil.Craft_WidgetSelectorFunc,
	}
)
DataSources.CraftColorActionsPC = DataSourceHelpers.ListSetup(
	"PC.CraftColorActionsPC",
	function(f51_arg0)
		if CoD.ModelUtility.IsModelValueEqualTo(f51_arg0, "Emblem.EmblemProperties.isGradientMode", 0) then
			return CoD.PCUtil.Craft_GetEmblemEditorSolidColorActions(f51_arg0)
		else
			return CoD.PCUtil.Craft_GetEmblemEditorGradientModeActions(f51_arg0)
		end
	end,
	true,
	{
		getWidgetTypeForItem = CoD.PCUtil.Craft_WidgetSelectorFunc,
	}
)
DataSources.CraftMaterialActionsPC = DataSourceHelpers.ListSetup(
	"PC.CraftMaterialActionsPC",
	function(f52_arg0)
		return CoD.PCUtil.Craft_GetEmblemEditorMaterialActions(f52_arg0)
	end,
	true,
	{
		getWidgetTypeForItem = CoD.PCUtil.Craft_WidgetSelectorFunc,
	}
)
CoD.PCUtil.Craft_GetEmblemEditorEditModeActions = function(f53_arg0, f53_arg1)
	local f53_local0 = {}
	local f53_local1
	if not CoD.CraftUtility.Emblem_IsActiveLayerASticker(f53_arg1, f53_arg0) then
		f53_local1 = not CoD.CraftUtility.Emblem_IsActiveLayerGroupedWithSticker(f53_arg1, f53_arg0)
	else
		f53_local1 = false
	end
	if f53_local1 then
		table.insert(f53_local0, {
			models = {
				actionName = 0x85B404E7BD35400,
				widgetType = "header",
			},
		})
		table.insert(f53_local0, {
			models = {
				actionName = 0x3F334E151B36E5C,
				widgetType = "button",
				action = function(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4)
					CoD.CraftUtility.EmblemEditor_EndEdit(f54_arg0, f54_arg1, f54_arg2)
					if IsPaintshop(f54_arg2) then
						OpenOverlay(f54_arg4, "PaintjobIconColorPicker", f54_arg2, nil)
					else
						OpenOverlay(f54_arg4, "EmblemIconColorPicker", f54_arg2, nil)
					end
					CoD.CraftUtility.EmblemChooseColor_ClearSelectedLayerMaterial(f54_arg0, f54_arg1, f54_arg2)
				end,
			},
			properties = {
				m_button = Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09],
			},
		})
		if CoD.BaseUtility.IsDvarEnabled("enable_material_picker") then
			table.insert(f53_local0, {
				models = {
					actionName = 0xE5BDA73054BDF29,
					widgetType = "button",
					action = function(f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4)
						CoD.CraftUtility.EmblemEditor_EndEdit(f55_arg0, f55_arg1, f55_arg2)
						if IsPaintshop(f55_arg2) then
							OpenOverlay(f55_arg4, "PaintjobMaterialPicker", f55_arg2, nil)
						else
							OpenOverlay(f55_arg0, "EmblemEditorMaterialPicker", f55_arg2, nil)
						end
					end,
				},
				properties = {
					m_button = Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F],
					m_isDpad = true,
				},
			})
		end
	end
	table.insert(f53_local0, {
		models = {
			actionName = 0x19352A5A4C9CAC9,
			widgetType = "header",
		},
	})
	local f53_local2 = table.insert
	local f53_local3 = f53_local0
	local f53_local4 = {}
	local f53_local5 = {
		actionName = 0xD73A4C5AED93CF,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.xscale",
		lowValue = -300,
		highValue = 300,
	}
	local f53_local6 = Engine[0x4DF5CFBC1771947](f53_arg0)
	f53_local5.currentValue = f53_local6["Emblem.EmblemSelectedLayerProperties.xscale"].get(f53_local6["Emblem.EmblemSelectedLayerProperties.xscale"])
	f53_local4.models = f53_local5
	f53_local4.properties = {
		updateAction = function(f56_arg0, f56_arg1, f56_arg2, f56_arg3)
			local f56_local0 = CoD.PCUtil.GetElementModelValues(f56_arg1, {
				"lowValue",
				"highValue",
				"perControllerValueModel",
			})
			if f56_local0 then
				local f56_local1 = Engine[0x4DF5CFBC1771947](f56_arg3)
				f56_local1 = f56_local1[f56_local0.perControllerValueModel]:get()
				if f56_local1 then
					Engine[0xAE71EACC5A3B69C](((f56_local0.highValue - f56_local0.lowValue) * f56_arg2 - f56_local1 - f56_local0.lowValue) / 50, 0)
				end
			end
		end,
	}
	f53_local2(f53_local3, f53_local4)
	f53_local2 = table.insert
	f53_local3 = f53_local0
	f53_local4 = {}
	f53_local5 = {
		actionName = 0xD7394C5AED921C,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.yscale",
		lowValue = -300,
		highValue = 300,
	}
	f53_local6 = Engine[0x4DF5CFBC1771947](f53_arg0)
	f53_local5.currentValue = f53_local6["Emblem.EmblemSelectedLayerProperties.yscale"].get(f53_local6["Emblem.EmblemSelectedLayerProperties.yscale"])
	f53_local4.models = f53_local5
	f53_local4.properties = {
		updateAction = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3)
			local f57_local0 = CoD.PCUtil.GetElementModelValues(f57_arg1, {
				"lowValue",
				"highValue",
				"perControllerValueModel",
			})
			if f57_local0 then
				local f57_local1 = Engine[0x4DF5CFBC1771947](f57_arg3)
				f57_local1 = f57_local1[f57_local0.perControllerValueModel]:get()
				if f57_local1 then
					Engine[0xAE71EACC5A3B69C](0, ((f57_local0.highValue - f57_local0.lowValue) * f57_arg2 - f57_local1 - f57_local0.lowValue) / 50)
				end
			end
		end,
	}
	f53_local2(f53_local3, f53_local4)
	table.insert(f53_local0, {
		models = {
			actionName = 0x80DD0DAE2D212DC,
			widgetType = "button",
			action = function(f58_arg0, f58_arg1, f58_arg2, f58_arg3, f58_arg4)
				CoD.CraftUtility.EmblemEditor_FlipIcon(f58_arg0, f58_arg1, f58_arg2)
				PlaySoundSetSound(f58_arg0, "flip_image")
			end,
		},
		properties = {
			m_button = Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1],
		},
	})
	if f53_local1 then
		table.insert(f53_local0, {
			models = {
				actionName = 0xB01D7611E815CFB,
				widgetType = "button",
				action = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3, f59_arg4)
					CoD.CraftUtility.EmblemEditor_ToggleOutline(f59_arg0, f59_arg1, f59_arg2)
					PlaySoundSetSound(f59_arg0, "toggle_outline")
				end,
			},
			properties = {
				m_button = Enum[0x3DD78803F918E9D][0xC083113BC81F23F],
			},
		})
		f53_local2 = table.insert
		f53_local3 = f53_local0
		f53_local4 = {}
		f53_local5 = {
			actionName = 0x611006D6269F87D,
			widgetType = "slider",
			perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.max_opacity",
			lowValue = 0,
			highValue = 100,
		}
		f53_local6 = Engine[0x4DF5CFBC1771947](f53_arg0)
		f53_local5.currentValue = f53_local6["Emblem.EmblemSelectedLayerProperties.max_opacity"].get(f53_local6["Emblem.EmblemSelectedLayerProperties.max_opacity"])
		f53_local4.models = f53_local5
		f53_local4.properties = {
			updateAction = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3)
				Engine[0x6917B85E01FBFC3](f60_arg3, Enum[0x5B86390D74F3997][0xE5C90AB2E168111], f60_arg2)
			end,
		}
		f53_local2(f53_local3, f53_local4)
	end
	f53_local2 = table.insert
	f53_local3 = f53_local0
	f53_local4 = {}
	f53_local5 = {
		actionName = 0x2FFF1300E166617,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.rotation",
		lowValue = 0,
		highValue = 360,
	}
	f53_local6 = Engine[0x4DF5CFBC1771947](f53_arg0)
	f53_local5.currentValue = f53_local6["Emblem.EmblemSelectedLayerProperties.rotation"].get(f53_local6["Emblem.EmblemSelectedLayerProperties.rotation"])
	f53_local4.models = f53_local5
	f53_local4.properties = {
		updateAction = function(f61_arg0, f61_arg1, f61_arg2)
			local f61_local0 = CoD.PCUtil.GetElementModelValues(f61_arg1, {
				"lowValue",
				"highValue",
			})
			if f61_local0 then
				Engine[0x6C7F64E3B41714D]((f61_local0.highValue - f61_local0.lowValue) * f61_arg2)
			end
		end,
	}
	f53_local2(f53_local3, f53_local4)
	table.insert(f53_local0, {
		models = {
			actionName = 0x18BF56C4998FCB2,
			widgetType = "button",
			action = function(f62_arg0, f62_arg1, f62_arg2, f62_arg3, f62_arg4)
				CoD.CraftUtility.EmblemEditor_LinkAllLayers(f62_arg4, f62_arg2)
			end,
		},
		properties = {
			m_button = Enum[0x3DD78803F918E9D][0x22361E23588705A],
		},
	})
	return f53_local0
end
CoD.PCUtil.Craft_GetEmblemEditorBrowseModeActions = function(f63_arg0)
	local f63_local0 = {}
	table.insert(f63_local0, {
		models = {
			actionName = 0x19352A5A4C9CAC9,
			widgetType = "header",
		},
	})
	table.insert(f63_local0, {
		models = {
			actionName = 0x18BF56C4998FCB2,
			widgetType = "button",
			action = function(f64_arg0, f64_arg1, f64_arg2, f64_arg3, f64_arg4)
				CoD.CraftUtility.EmblemEditor_LinkAllLayers(f64_arg4, f64_arg2)
			end,
		},
		properties = {
			m_button = Enum[0x3DD78803F918E9D][0x22361E23588705A],
		},
	})
	return f63_local0
end
CoD.PCUtil.Craft_GetEmblemEditorSolidColorActions = function(f65_arg0)
	local f65_local0 = {}
	table.insert(f65_local0, {
		models = {
			actionName = 0x85B404E7BD35400,
			widgetType = "header",
		},
	})
	table.insert(f65_local0, {
		models = {
			actionName = 0x69A8E3706E3A32C,
			widgetType = "button",
			keyshortcut = "G",
			action = function(f66_arg0, f66_arg1, f66_arg2, f66_arg3, f66_arg4)
				CoD.CraftUtility.EmblemChooseColor_ToggleGradientMode(f66_arg0, f66_arg1, f66_arg2, f66_arg4)
			end,
		},
		properties = {
			m_button = Enum[0x3DD78803F918E9D][0xC083113BC81F23F],
		},
	})
	table.insert(f65_local0, {
		models = {
			actionName = 0x17DC5905C7270D7,
			widgetType = "button",
			keyshortcut = "E",
			perControllerStatusModel = "Emblem.EmblemProperties.colorMode",
			action = function(f67_arg0, f67_arg1, f67_arg2, f67_arg3, f67_arg4)
				CoD.CraftUtility.EmblemChooseColor_ToggleColorMode(f67_arg0, f67_arg1, f67_arg2, f67_arg4)
			end,
			getStatusTable = function()
				return {
					[Enum[0xC594B064FEDD0D6][0xC6A5FECEA7EADAA]] = {
						label = 0xFC662A897EF60AB,
					},
					[Enum[0xC594B064FEDD0D6][0xE692F9BF30BA124]] = {
						label = 0x17DC5905C7270D7,
					},
				}
			end,
		},
		properties = {
			m_button = Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1],
		},
	})
	if IsPaintshop(f65_arg0) then
		table.insert(f65_local0, {
			models = {
				actionName = 0xCB9F26855E3227A,
				widgetType = "button",
				perControllerStatusModel = "Emblem.EmblemSelectedLayerProperties.blend",
				action = function(f69_arg0, f69_arg1, f69_arg2, f69_arg3, f69_arg4)
					CoD.CraftUtility.EmblemChooseColor_ToggleBlend(f69_arg0, f69_arg4, f69_arg2)
				end,
				getStatusTable = function()
					return {
						[0] = {
							label = 0x4336F8BDF41A51E,
						},
						[1] = {
							label = 0xCB9F26855E3227A,
						},
					}
				end,
			},
			properties = {
				m_button = Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09],
			},
		})
	end
	table.insert(f65_local0, {
		models = {
			actionName = 0x19352A5A4C9CAC9,
			widgetType = "header",
		},
	})
	local f65_local1 = table.insert
	local f65_local2 = f65_local0
	local f65_local3 = {}
	local f65_local4 = {
		actionName = 0x611006D6269F87D,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.opacity0",
		lowValue = 0,
		highValue = 100,
	}
	local f65_local5 = Engine[0x4DF5CFBC1771947](f65_arg0)
	f65_local4.currentValue = f65_local5["Emblem.EmblemSelectedLayerProperties.opacity0"].get(f65_local5["Emblem.EmblemSelectedLayerProperties.opacity0"])
	f65_local3.models = f65_local4
	f65_local3.properties = {
		updateAction = function(f71_arg0, f71_arg1, f71_arg2)
			CoD.CraftUtility.EmblemChooseColor_SetOpacity(f71_arg0, f71_arg1, CoD.CraftUtility.GetEmblemEditorProperties(f65_arg0, "colorNum"), f71_arg2, f65_arg0, f71_arg0)
		end,
	}
	f65_local1(f65_local2, f65_local3)
	return f65_local0
end
CoD.PCUtil.Craft_GetEmblemEditorGradientModeActions = function(f72_arg0)
	local f72_local0 = {}
	table.insert(f72_local0, {
		models = {
			actionName = 0x85B404E7BD35400,
			widgetType = "header",
		},
	})
	table.insert(f72_local0, {
		models = {
			actionName = 0x31CA4080F66FECD,
			widgetType = "button",
			keyshortcut = "G",
			action = function(f73_arg0, f73_arg1, f73_arg2, f73_arg3, f73_arg4)
				CoD.CraftUtility.EmblemChooseColor_ToggleGradientMode(f73_arg0, f73_arg1, f73_arg2, f73_arg4)
			end,
		},
		properties = {
			m_button = Enum[0x3DD78803F918E9D][0xC083113BC81F23F],
		},
	})
	table.insert(f72_local0, {
		models = {
			actionName = 0x51DC5128C5593A4,
			widgetType = "button",
			perControllerStatusModel = "Emblem.EmblemSelectedLayerProperties.gradient_type",
			action = function(f74_arg0, f74_arg1, f74_arg2, f74_arg3, f74_arg4)
				CoD.CraftUtility.EmblemGradient_ToggleGradientType(f74_arg0, f74_arg1, f74_arg2)
			end,
			getStatusTable = function()
				return {
					[Enum[0xCA0CB02B4A12602][0x2B2DC60726823DB]] = {
						label = 0x51DC5128C5593A4,
					},
					[Enum[0xCA0CB02B4A12602][0xA00B3A2D53175C1]] = {
						label = 0xC33C8400FCB2D4E,
					},
				}
			end,
		},
		properties = {
			m_button = Enum[0x3DD78803F918E9D][0x29E5695FF1401AD],
		},
	})
	if IsPaintshop(f72_arg0) then
		table.insert(f72_local0, {
			models = {
				actionName = 0xCB9F26855E3227A,
				widgetType = "button",
				perControllerStatusModel = "Emblem.EmblemSelectedLayerProperties.blend",
				action = function(f76_arg0, f76_arg1, f76_arg2, f76_arg3, f76_arg4)
					CoD.CraftUtility.EmblemChooseColor_ToggleBlend(f76_arg0, f76_arg4, f76_arg2)
				end,
				getStatusTable = function()
					return {
						[0] = {
							label = 0x4336F8BDF41A51E,
						},
						[1] = {
							label = 0xCB9F26855E3227A,
						},
					}
				end,
			},
			properties = {
				m_button = Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09],
			},
		})
	end
	table.insert(f72_local0, {
		models = {
			actionName = 0x19352A5A4C9CAC9,
			widgetType = "header",
		},
	})
	local f72_local1 = table.insert
	local f72_local2 = f72_local0
	local f72_local3 = {}
	local f72_local4 = {
		actionName = 0xD919B2D6404B47,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.opacity0",
		perControllerStatusModel = "Emblem.EmblemProperties.isColor0NoColor",
		lowValue = 0,
		highValue = 100,
	}
	local f72_local5 = Engine[0x4DF5CFBC1771947](f72_arg0)
	f72_local4.currentValue = f72_local5["Emblem.EmblemSelectedLayerProperties.opacity0"].get(f72_local5["Emblem.EmblemSelectedLayerProperties.opacity0"])
	f72_local4.getStatusTable = function()
		return {
			{
				disabled = true,
			},
		}
	end
	f72_local3.models = f72_local4
	f72_local3.properties = {
		updateAction = function(f79_arg0, f79_arg1, f79_arg2)
			CoD.CraftUtility.EmblemChooseColor_SetOpacity(f79_arg0, f79_arg1, Enum[0x5B86390D74F3997][0x2EFDD03AB2AE52D], f79_arg2, f72_arg0, f79_arg0)
		end,
	}
	f72_local1(f72_local2, f72_local3)
	f72_local1 = table.insert
	f72_local2 = f72_local0
	f72_local3 = {}
	f72_local4 = {
		actionName = 0xBD45B66EE9ACAD2,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.opacity1",
		perControllerStatusModel = "Emblem.EmblemProperties.isColor1NoColor",
		lowValue = 0,
		highValue = 100,
	}
	f72_local5 = Engine[0x4DF5CFBC1771947](f72_arg0)
	f72_local4.currentValue = f72_local5["Emblem.EmblemSelectedLayerProperties.opacity1"].get(f72_local5["Emblem.EmblemSelectedLayerProperties.opacity1"])
	f72_local4.getStatusTable = function()
		return {
			{
				disabled = true,
			},
		}
	end
	f72_local3.models = f72_local4
	f72_local3.properties = {
		updateAction = function(f81_arg0, f81_arg1, f81_arg2)
			CoD.CraftUtility.EmblemChooseColor_SetOpacity(f81_arg0, f81_arg1, Enum[0x5B86390D74F3997][0x2EFDC03AB2AE37A], f81_arg2, f72_arg0, f81_arg0)
		end,
	}
	f72_local1(f72_local2, f72_local3)
	f72_local1 = table.insert
	f72_local2 = f72_local0
	f72_local3 = {}
	f72_local4 = {
		actionName = 0x12A6450C1991C6D,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.gradient_angle",
		lowValue = 0,
		highValue = 360,
	}
	f72_local5 = Engine[0x4DF5CFBC1771947](f72_arg0)
	f72_local4.currentValue = f72_local5["Emblem.EmblemSelectedLayerProperties.gradient_angle"].get(f72_local5["Emblem.EmblemSelectedLayerProperties.gradient_angle"])
	f72_local3.models = f72_local4
	f72_local3.properties = {
		updateAction = function(f82_arg0, f82_arg1, f82_arg2, f82_arg3)
			local f82_local0 = CoD.PCUtil.GetElementModelValues(f82_arg1, {
				"lowValue",
				"highValue",
			})
			CoD.CraftUtility.EmblemGradient_SetAngle(f82_arg0, f82_arg1, (f82_local0.highValue - f82_local0.lowValue) * f82_arg2, f82_arg3)
		end,
	}
	f72_local1(f72_local2, f72_local3)
	return f72_local0
end
CoD.PCUtil.Craft_GetEmblemEditorMaterialActions = function()
	local f83_local0 = {}
	table.insert(f83_local0, {
		models = {
			actionName = 0x19352A5A4C9CAC9,
			widgetType = "header",
		},
	})
	local f83_local1 = table.insert
	local f83_local2 = f83_local0
	local f83_local3 = {}
	local f83_local4 = {
		actionName = 0xD73A4C5AED93CF,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.material_xscale",
		lowValue = -300,
		highValue = 300,
	}
	local f83_local5 = Engine[0x4DF5CFBC1771947](controller)
	f83_local4.currentValue = f83_local5["Emblem.EmblemSelectedLayerProperties.material_xscale"].get(f83_local5["Emblem.EmblemSelectedLayerProperties.material_xscale"])
	f83_local3.models = f83_local4
	f83_local3.properties = {
		updateAction = function(f84_arg0, f84_arg1, f84_arg2, f84_arg3)
			local f84_local0 = CoD.PCUtil.GetElementModelValues(f84_arg1, {
				"lowValue",
				"highValue",
				"perControllerValueModel",
			})
			if f84_local0 then
				local f84_local1 = Engine[0x4DF5CFBC1771947](f84_arg3)
				f84_local1 = f84_local1[f84_local0.perControllerValueModel]:get()
				if f84_local1 then
					Engine[0x4950DB3952D39A6](f84_arg3, ((f84_local0.highValue - f84_local0.lowValue) * f84_arg2 - f84_local1 - f84_local0.lowValue) / 50)
				end
			end
		end,
	}
	f83_local1(f83_local2, f83_local3)
	f83_local1 = table.insert
	f83_local2 = f83_local0
	f83_local3 = {}
	f83_local4 = {
		actionName = 0xD7394C5AED921C,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.material_yscale",
		lowValue = -300,
		highValue = 300,
	}
	f83_local5 = Engine[0x4DF5CFBC1771947](controller)
	f83_local4.currentValue = f83_local5["Emblem.EmblemSelectedLayerProperties.material_yscale"].get(f83_local5["Emblem.EmblemSelectedLayerProperties.material_yscale"])
	f83_local3.models = f83_local4
	f83_local3.properties = {
		updateAction = function(f85_arg0, f85_arg1, f85_arg2, f85_arg3)
			local f85_local0 = CoD.PCUtil.GetElementModelValues(f85_arg1, {
				"lowValue",
				"highValue",
				"perControllerValueModel",
			})
			if f85_local0 then
				local f85_local1 = Engine[0x4DF5CFBC1771947](f85_arg3)
				f85_local1 = f85_local1[f85_local0.perControllerValueModel]:get()
				if f85_local1 then
					Engine[0xE6ECCE18819CF89](f85_arg3, ((f85_local0.highValue - f85_local0.lowValue) * f85_arg2 - f85_local1 - f85_local0.lowValue) / 50)
				end
			end
		end,
	}
	f83_local1(f83_local2, f83_local3)
	f83_local1 = table.insert
	f83_local2 = f83_local0
	f83_local3 = {}
	f83_local4 = {
		actionName = 0xC718AEEBB3E6B97,
		widgetType = "slider",
		perControllerValueModel = "Emblem.EmblemSelectedLayerProperties.material_angle",
		lowValue = 0,
		highValue = 360,
	}
	f83_local5 = Engine[0x4DF5CFBC1771947](controller)
	f83_local4.currentValue = f83_local5["Emblem.EmblemSelectedLayerProperties.material_angle"].get(f83_local5["Emblem.EmblemSelectedLayerProperties.material_angle"])
	f83_local3.models = f83_local4
	f83_local3.properties = {
		updateAction = function(f86_arg0, f86_arg1, f86_arg2, f86_arg3)
			Engine[0x705D1E7191A66FF](f86_arg3, 359 * f86_arg2)
		end,
	}
	f83_local1(f83_local2, f83_local3)
	return f83_local0
end
CoD.PCUtility.SetSliderValueModel = function(f87_arg0, f87_arg1, f87_arg2, f87_arg3)
	f87_arg1:linkToElementModel(f87_arg0, "perControllerValueModel", true, function(model)
		if f87_arg0._perControllerValueModelSubscription then
			f87_arg0:removeSubscription(f87_arg0._perControllerValueModelSubscription)
			f87_arg0._perControllerValueModelSubscription = nil
		end
		local f88_local0 = f87_arg0:getModel()
		if f88_local0.lowValue and f88_local0.highValue then
			local f88_local1 = model:get()
			local f88_local2 = Engine[0x4DF5CFBC1771947](f87_arg2)
			f88_local2 = f88_local2[f88_local1]
			if f88_local0.currentValue then
				f88_local0.currentValue:set(f88_local2:get())
			end
			f87_arg0._perControllerValueModelSubscription = f87_arg0:subscribeToModel(f88_local0.currentValue, function(model)
				local f89_local0 = model:get()
				local f89_local1 = f87_arg0:getModel()
				f89_local0 = f89_local0 - f89_local1.lowValue:get()
				f89_local1 = f87_arg0:getModel()
				f89_local1 = f89_local1.highValue:get()
				local f89_local2 = f87_arg0:getModel()
				f89_local0 = f89_local0 / (f89_local1 - f89_local2.lowValue:get())
				CoD.PCUtility.UpdateCraftSliderVisuals(f87_arg1, f89_local0)
				if f87_arg0.EditBox ~= nil then
					f87_arg0.EditBox.TextBox:setText(model:get())
				end
				if type(f87_arg0.updateAction) == "function" then
					f87_arg0.updateAction(f87_arg3, f87_arg0, f89_local0, f87_arg2)
				end
			end)
			if f87_arg0.EditBox ~= nil then
				CoD.PCUtility.SetupEditSliderValueModel(f87_arg0.EditBox, f87_arg2, f87_arg3, f88_local0.currentValue, f88_local0)
			end
		end
	end)
end
CoD.PCUtility.SetupEditSliderValueModel = function(f90_arg0, f90_arg1, f90_arg2, f90_arg3, f90_arg4)
	f90_arg0.__editboxGainInputFocus = function(f91_arg0, f91_arg1)
		f91_arg0.super:gainInputFocus(f91_arg1)
		Engine[0x75723E517F6CE67](f90_arg1, f91_arg0, f91_arg0.TextBox, f90_arg3:get(), f91_arg0.__editControlMaxChar, true)
		Engine[0xA0D0734CB6CC146](f90_arg1, f90_arg4.lowValue:get(), f90_arg4.highValue:get(), tonumber(f90_arg3:get()), true)
		return true
	end
	f90_arg0:registerEventHandler("gain_input_focus", f90_arg0.__editboxGainInputFocus)
	f90_arg0.__onEditClose = function(f92_arg0)
		if Engine[0x7272CF98D12ADE1](f90_arg1) and f90_arg2.currentInputFocus == f92_arg0 then
			Engine[0xD806200988BA3EB](f90_arg1)
		end
	end
	LUI.OverrideFunction_CallOriginalSecond(f90_arg0, "close", f90_arg0.__onEditClose)
	CoD.Menu.AddButtonCallbackFunction(f90_arg2, f90_arg0, f90_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu)
		f90_arg2:ChangeInputFocus(f90_arg1, element)
		return true
	end)
	f90_arg0.__editboxLoseInputFocus = function(f94_arg0, f94_arg1)
		local f94_local0 = Engine[0x7272CF98D12ADE1](f90_arg1)
		local f94_local1 = Engine[0xD806200988BA3EB](f90_arg1)
		if f94_local0 then
			f94_arg0.TextBox:setText(f90_arg3:get())
		end
		f94_arg0.super:loseInputFocus(f94_arg1)
		return true
	end
	f90_arg0:registerEventHandler("lose_input_focus", f90_arg0.__editboxLoseInputFocus)
	f90_arg0.__editboxDone = function(f95_arg0, f95_arg1)
		local f95_local0 = Engine[0x7272CF98D12ADE1](f90_arg1)
		local f95_local1 = Engine[0xD806200988BA3EB](f90_arg1)
		if f95_local0 then
			assert(f95_local1 ~= nil)
			f90_arg3:set(tonumber(f95_local1))
		end
		local f95_local2 = f95_arg0:getMenu()
		f95_local2:ChangeInputFocus(f90_arg1, nil)
	end
	f90_arg0:registerEventHandler("textbox_editdone", f90_arg0.__editboxDone)
end
CoD.PCUtility.SetCraftActionStatusModel = function(f96_arg0, f96_arg1, f96_arg2, f96_arg3)
	f96_arg0:linkToElementModel(f96_arg0, "perControllerStatusModel", true, function(model)
		if f96_arg0._perControllerStatusModelSubscription then
			f96_arg0:removeSubscription(f96_arg0._perControllerStatusModelSubscription)
			f96_arg0._perControllerStatusModelSubscription = nil
		end
		local f97_local0 = f96_arg0:getModel()
		if f97_local0.getStatusTable then
			local f97_local1 = model:get()
			local f97_local2 = Engine[0x4DF5CFBC1771947](f96_arg2)
			f96_arg0._perControllerStatusModelSubscription = f96_arg0:subscribeToModel(f97_local2[f97_local1], function(model)
				local f98_local0 = Engine[0x614D394F6F9A18D](model)
				local f98_local1 = f96_arg0:getModel()
				f98_local1 = f98_local1.getStatusTable:get()
				f98_local1 = f98_local1()
				local f98_local2 = f98_local1 and f98_local1[f98_local0]
				if f98_local2 then
					if f98_local2.disabled then
						f96_arg0.disabled = f98_local2.disabled
					end
					if f98_local2.label then
						f96_arg0.actionName:setText(Engine[0xED84C33EC5F01EA](f98_local2.label))
					end
				else
					f96_arg0.disabled = nil
				end
				f96_arg0:processEvent({
					name = "update_state",
					controller = f96_arg2,
					menu = f96_arg3,
					forceDispatch = true,
				})
			end)
		end
	end)
end
CoD.PCUtility.CraftActionSliderSetInputBox = function(f99_arg0, f99_arg1, f99_arg2, f99_arg3)
	if f99_arg0.EditBox ~= nil then
		DisableKeyboardNavigationByElement(f99_arg0.EditBox)
		CoD.Menu.AddButtonCallbackFunction(f99_arg3, f99_arg0, f99_arg2, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu, controller, f100_arg3)
			CoD.PCWidgetUtility.BringIntoView(f99_arg0, controller)
			menu:ChangeInputFocus(controller, f99_arg0.EditBox)
			return true
		end)
	end
end
CoD.PCUtility.CraftActionSliderBindDrag = function(f101_arg0, f101_arg1, f101_arg2, f101_arg3)
	local f101_local0, f101_local1, f101_local2, f101_local3 = f101_arg1.sliderBar:getLocalRect()
	f101_arg1.m_markerHalfWidth = (f101_local2 - f101_local0) / 2
	f101_arg1:registerEventHandler("leftmousedrag", function(element, event)
		local f102_local0, f102_local1, f102_local2, f102_local3 = element.sliderBack:getRect()
		local f102_local4 = f102_local2 - f102_local0
		local f102_local5 = CoD.ColorUtility.ClampColor(event.x - f102_local0, 0, f102_local4) / f102_local4
		local f102_local6 = element:getModel()
		f102_local6.currentValue:set(math.floor((f102_local6.highValue:get() - f102_local6.lowValue:get()) * f102_local5 + f102_local6.lowValue:get()))
	end)
end
CoD.PCUtility.UpdateCraftSliderVisuals = function(f103_arg0, f103_arg1)
	local f103_local0, f103_local1, f103_local2, f103_local3 = f103_arg0.sliderBack:getLocalRect()
	local f103_local4 = f103_arg1 * (f103_local2 - f103_local0)
	f103_arg0.sliderBar:setLeftRight(true, false, f103_local0 + f103_local4 - f103_arg0.m_markerHalfWidth, f103_local0 + f103_local4 + f103_arg0.m_markerHalfWidth)
	f103_arg0.sliderFill:setLeftRight(true, false, f103_local0, f103_local0 + f103_local4)
end
CoD.PCUtility.SetColorMixerSliderDrag = function(f104_arg0, f104_arg1)
	f104_arg0.m_forceMouseEventDispatch = true
	local f104_local0 = function(f105_arg0, f105_arg1)
		local f105_local0, f105_local1, f105_local2, f105_local3 = f104_arg0:getRect()
		local f105_local4 = f105_local2 - f105_local0
		return math.floor(CoD.ColorUtility.ClampColor(f105_arg1.x - f105_local0, 0, f105_local4) / f105_local4 * 255 + 0.5)
	end
	f104_arg0:registerEventHandler("leftmouseup", function(element, event)
		CoD.CraftUtility.EmblemChooseColor_SetColorComponent(element.m_colorMixer, element, f104_arg1, element.m_color, f104_local0(element, event))
		return true
	end)
	f104_arg0:registerEventHandler("leftmousedrag", function(element, event)
		CoD.CraftUtility.EmblemChooseColor_SetColorComponent(element.m_colorMixer, element, f104_arg1, element.m_color, f104_local0(element, event))
		return true
	end)
end
CoD.PCUtility.SetGradientSliderDrag = function(f108_arg0, f108_arg1)
	f108_arg0.m_forceMouseEventDispatch = true
	local f108_local0 = function(f109_arg0, f109_arg1)
		local f109_local0, f109_local1, f109_local2, f109_local3 = f108_arg0:getRect()
		local f109_local4 = f109_local2 - f109_local0
		return CoD.ColorUtility.ClampColor(f109_arg1.x - f109_local0, 0, f109_local4) / f109_local4
	end
	f108_arg0:registerEventHandler("leftmouseup", function(element, event)
		CoD.CraftUtility.EmblemGradient_SetGradientFill(element, element, f108_local0(element, event), f108_arg1)
		return true
	end)
	f108_arg0:registerEventHandler("leftmousedrag", function(element, event)
		CoD.CraftUtility.EmblemGradient_SetGradientFill(element, element, f108_local0(element, event), f108_arg1)
		return true
	end)
end
CoD.PCUtility.EmblemEditor_RenameEmblem = function(f112_arg0, f112_arg1)
	local f112_local0 = CoD.perController[f112_arg1].selectedEmblemModel
	if not f112_local0 then
		return
	end
	local f112_local1 = Engine[0x4DF5CFBC1771947](f112_arg1)
	f112_local1 = f112_local1.RenameEmblemText
	local f112_local2 = f112_local1:get()
	if not Engine[0xE3FC4BECF450A06](f112_arg1, f112_local2, Enum[0x85FCE2AA5391A7C][0xAB07E25FDAE82CD]) then
		local f112_local3 = Engine[0x40E824FE270E174](f112_local0, "emblemTextEntry")
		if f112_local3 then
			Engine[0x83C9B5DE1D9371](f112_local3, f112_local2)
		end
		local f112_local4 = f112_arg0:getModel(f112_arg1, "inputText")
		if f112_local4 then
			Engine[0x83C9B5DE1D9371](f112_local4, f112_local2)
		end
	elseif CoD.isPC then
		CoD.PCUtility.EmblemEditor_ClearRenameTextBox(f112_arg0, f112_arg0.EmblemRenameTextBox, f112_arg1, f112_local1)
	end
end
CoD.PCUtility.EmblemEditor_RenameGroup = function(f113_arg0, f113_arg1)
	local f113_local0 = CoD.perController[f113_arg1].selectedDecalGroupModel
	if not f113_local0 then
		return
	end
	local f113_local1 = Engine[0x4DF5CFBC1771947](f113_arg1)
	f113_local1 = f113_local1.RenameEmblemText
	if not Engine[0xE3FC4BECF450A06](f113_arg1, f113_local1:get(), Enum[0x85FCE2AA5391A7C][0xFE81C2839DE0D30]) then
		local f113_local2 = Engine[0x40E824FE270E174](f113_local0, "emblemTextEntry")
		if f113_local2 then
			Engine[0x83C9B5DE1D9371](f113_local2, f113_local1:get())
		end
		local f113_local3 = f113_arg0:getModel(f113_arg1, "inputText")
		if f113_local3 then
			Engine[0x83C9B5DE1D9371](f113_local3, f113_local1:get())
		end
	elseif CoD.isPC then
		CoD.PCUtility.EmblemEditor_ClearRenameTextBox(f113_arg0, f113_arg0.GroupRenameTextBox, f113_arg1, f113_local1)
	end
end
CoD.PCUtility.EmblemEditor_ClearRenameTextBox = function(f114_arg0, f114_arg1, f114_arg2, f114_arg3)
	f114_arg1:processEvent({
		name = "lose_input_focus",
		controller = f114_arg2,
		isMouse = true,
		isMouseFocus = f114_arg0.currentInputFocus == CoD.GetMouseFocus(f114_arg2),
	})
	f114_arg1:processEvent({
		name = "textbox_editdone",
		controller = f114_arg2,
	})
	f114_arg3:set("")
end
CoD.PCUtility.PaintjobEditor_RenamePaintjob = function(f115_arg0, f115_arg1)
	local f115_local0 = CoD.perController[f115_arg1].selectedPaintjobModel
	if not f115_local0 then
		return
	end
	local f115_local1 = Engine[0x4DF5CFBC1771947](f115_arg1)
	f115_local1 = f115_local1.RenameEmblemText
	local f115_local2 = f115_local1:get()
	if not Engine[0xE3FC4BECF450A06](f115_arg1, f115_local2, Enum[0x85FCE2AA5391A7C][0xD8A95D32ACF41D1]) then
		local f115_local3 = Engine[0x40E824FE270E174](f115_local0, "paintjobTextEntry")
		if f115_local3 then
			Engine[0x83C9B5DE1D9371](f115_local3, f115_local2)
		end
		local f115_local4 = f115_arg0:getModel(f115_arg1, "inputText")
		if f115_local4 then
			Engine[0x83C9B5DE1D9371](f115_local4, f115_local2)
		end
	elseif CoD.isPC then
		CoD.PCUtility.EmblemEditor_ClearRenameTextBox(f115_arg0, f115_arg0.PaintjobRenameTextBox, f115_arg1, f115_local1)
	end
end
CoD.PCUtility.EmblemEditor_ResetRenameEmblemValue = function(f116_arg0, f116_arg1)
	local f116_local0 = Engine[0x4DF5CFBC1771947](f116_arg1)
	f116_local0.RenameEmblemText:set("")
end
CoD.PCUtil.KeyboardTextFieldUpdate = function(f117_arg0, f117_arg1)
	local f117_local0 = Dvar[0x9BA994593CFF9D]:get()
	if f117_local0 ~= nil then
		f117_arg0.header:setText(f117_local0)
	end
	local f117_local1 = Dvar[0x1FF91986A2313BC]:get()
	if f117_arg0.isPassword then
		f117_local1 = string.rep("*", string.len(f117_local1))
	end
	if f117_local1 ~= nil then
		f117_arg0.inputContainer.inputText:setText(f117_local1)
		local f117_local2 = 0
		if f117_arg1.overstrike then
			f117_arg0.cursor = "_"
		else
			f117_arg0.cursor = "|"
			f117_local2 = -GetTextWidth(f117_arg0.cursor, f117_arg0.inputContainer.cursorText.text:getTTF(), f117_arg0.inputContainerHeight, 0) / 2
		end
		if not f117_arg1.cursorPos then
			f117_arg1.cursorPos = string.len(f117_local1)
		end
		local f117_local3 = GetTextWidth(string.sub(f117_local1, 1, f117_arg1.cursorPos), f117_arg0.inputContainer.inputText:getTTF(), f117_arg0.inputContainerHeight, 0)
		f117_arg0.inputContainer.cursorText.text:setText(f117_arg0.cursor)
		f117_arg0.inputContainer.cursorText:setLeftRight(true, false, f117_arg0.inputTextLeft + f117_local3 + f117_local2, 0)
	end
end
CoD.PCUtility.ResizeButtonWithButtonPromptImage = function(f118_arg0, f118_arg1, f118_arg2)
	local f118_local0 = 25
	local f118_local1 = 25
	if not f118_arg2 or not f118_arg0.buttonPromptImage then
		return
	end
	local f118_local2, f118_local3, f118_local4, f118_local5 = f118_arg0.buttonPromptImage:getLocalLeftRight()
	local f118_local6, f118_local7 = f118_arg0.buttonPromptImage:getLocalSize()
	local f118_local8 = f118_arg2:getText()
	if f118_local8 then
		f118_local8 = string.find(f118_arg2:getText(), "BFOOTER")
	end
	local f118_local9 = 10
	if f118_local8 then
		f118_local6 = f118_local6 - f118_local9
	end
	if IsMouseOrKeyboard(f118_arg1) then
		f118_local4 = 0
		f118_local6 = 0
		if f118_local8 then
			f118_local1 = f118_local1 + f118_local9
		end
	end
	local f118_local10, f118_local11, f118_local12, f118_local13 = f118_arg2:getLocalLeftRight()
	local f118_local14 = f118_local4 + f118_local6 + f118_local0
	local f118_local15 = f118_arg2:getTextWidth() + f118_local14
	f118_arg2:setLeftRight(0, 0, f118_local14, f118_local15)
	local f118_local16, f118_local17, f118_local18, f118_local19 = f118_arg0:getLocalLeftRight()
	f118_arg0:setLeftRight(f118_local16, f118_local17, f118_local18, f118_local18 + f118_local15 + f118_local4 + f118_local1)
end
CoD.PCUtility.CraftLockFocusOnDrag = function(f119_arg0, f119_arg1, f119_arg2)
	f119_arg0:setHandleMouse(true)
	local f119_local0 = function(f120_arg0, f120_arg1)
		if f120_arg0.__lockedFocus then
			f119_arg2:CaptureMouseAndLockFocus(f120_arg1, nil)
			f120_arg0.__lockedFocus = false
		end
	end
	local f119_local1 = function(f121_arg0, f121_arg1)
		f119_arg2:CaptureMouseAndLockFocus(f121_arg1, f121_arg0)
		f121_arg0.__lockedFocus = true
	end
	LUI.OverrideFunction_CallOriginalSecond(f119_arg0, "close", function(element)
		if element.__lockedFocus then
			local f122_local0 = element:getMenu()
			if f122_local0 then
				f122_local0:CaptureMouseAndLockFocus(f119_arg1, nil)
			end
			element.__lockedFocus = false
		end
	end)
	f119_arg0:registerEventHandler("leftmousedown", function(element, event)
		f119_local1(element, f119_arg1)
	end)
	f119_arg0:registerEventHandler("leftmouseup", function(element, event)
		f119_local0(element, f119_arg1)
	end)
	f119_arg0:registerEventHandler("mouse_capture_lost", function(element, event)
		f119_local0(element, f119_arg1)
	end)
	f119_arg0:appendEventHandler("lose_focus", function(f126_arg0, f126_arg1)
		f119_local0(f126_arg0, f119_arg1)
	end)
end
CoD.PCUtility.ResizeButtonWithKeyPrompt = function(f127_arg0, f127_arg1)
	local f127_local0 = 4
	if not f127_arg0.label or not f127_arg0.keyPrompt or not f127_arg0.buttonPromptImage then
		return
	end
	local f127_local1, f127_local2, f127_local3 = nil
	if Engine[0xBFCB46AE6026E3]() then
		f127_local3, f127_local3, f127_local1, f127_local3 = f127_arg0.buttonPromptImage:getLocalLeftRight()
		f127_local2, f127_local3 = f127_arg0.buttonPromptImage:getLocalSize()
	else
		f127_local3, f127_local3, f127_local1, f127_local3 = f127_arg0.keyPrompt:getLocalLeftRight()
		f127_local2, f127_local3 = f127_arg0.keyPrompt:getLocalSize()
	end
	local f127_local4, f127_local5, f127_local6, f127_local7 = f127_arg0.label:getLocalLeftRight()
	local f127_local8 = f127_arg0.label:getTextWidth()
	local f127_local9 = f127_local1 + f127_local2 + f127_local0
	f127_arg0.label:setLeftRight(f127_local4, f127_local5, f127_local9, f127_local9 + f127_local8)
	local f127_local10, f127_local11, f127_local12, f127_local13 = f127_arg0:getLocalLeftRight()
	f127_arg0:setLeftRight(f127_local10, f127_local11, f127_local12, f127_local12 + f127_local9 + f127_local8 + f127_local1)
end
CoD.PCUtility.IsContextualMousePrompt = function(f128_arg0, f128_arg1)
	local f128_local0 = f128_arg0:getText()
	if f128_local0 and string.find(Engine[0xB03220D3A4F3E38](f128_local0), "MOUSE") then
		return true
	else
		return false
	end
end
CoD.PCUtility.ScaleDownKeyPromptIfMouseIcon = function(f129_arg0, f129_arg1, f129_arg2)
	if not f129_arg0.__mouseImageAdjustmentDone then
		f129_arg0.__mouseImageAdjustmentDone = true
		local f129_local0 = 0.8
		local f129_local1 = 0.06
		local f129_local2, f129_local3, f129_local4, f129_local5 = f129_arg0:getLocalTopBottom()
		local f129_local6, f129_local7, f129_local8, f129_local9 = f129_arg0:getLocalLeftRight()
		local f129_local10 = f129_local5 - f129_local4
		local f129_local11 = f129_local9 - f129_local8
		local f129_local12 = f129_local4 + f129_local10 * f129_local1
		local f129_local13 = f129_local5 + f129_local10 * f129_local1
		local f129_local14 = f129_local8 + f129_local11 * f129_local1
		local f129_local15 = f129_local9 - f129_local11 * f129_local1
		f129_arg0:setScale(f129_local0, f129_local0)
		f129_arg0.keybind:setTopBottom(f129_local2, f129_local3, f129_local12, f129_local13)
		f129_arg0:setLeftRight(f129_local6, f129_local7, f129_local14, f129_local15)
		f129_arg2:setAlpha(0)
	end
end
CoD.PCUtility.OnWZOcclusionChange = function(f130_arg0, f130_arg1)
	local f130_local0 = f130_arg1.controller
	if f130_arg1.occluded then
		DisableAllMenuInput(f130_arg0, true)
	else
		DisableAllMenuInput(f130_arg0, false)
	end
	if not f130_arg0.GameEndScoreWZ or f130_arg1.occluded or f130_local0 == nil then
		return
	else
		local f130_local1 = Engine[0x4DF5CFBC1771947](f130_local0)
		if f130_local1.gameScore.currentState:get() == "" then
			return
		elseif Engine[0xA55C3ACD0D2BCF0]() then
			return
		else
			CoD.PCUtility.GameEndScoreWZShowCursor(f130_arg0.GameEndScoreWZ, f130_local0, f130_arg0)
		end
	end
end
local f0_local0 = CoD.OverlayUtility
local f0_local1 = LuaUtils.OverrideTable
local f0_local2 = CoD.OverlayUtility.Overlays
local f0_local3 = {}
local f0_local4 = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x10A724241848AC8),
}
if CoD.isPublicOnlineGame() then
	local f0_local5 = IsMultiplayer()
	local f0_local6 = Engine[0xF9F1239CFD921FE](0xFC9034400BFB613)
end
f0_local4.description = f0_local5 and f0_local6 or Engine[0xF9F1239CFD921FE](0xE600BD476A84DE9)
f0_local4.categoryType = CoD.OverlayUtility.OverlayTypes.Quit
f0_local4.listDatasource = function(f131_arg0)
	DataSources.QuitGamePopup_List = DataSourceHelpers.ListSetup("QuitGamePopup_List", function(f132_arg0)
		local f132_local0 = {
			{
				models = {
					displayText = Engine[0xF9F1239CFD921FE](0x7163F6214A962C7),
				},
				properties = {
					action = function(f133_arg0, f133_arg1, f133_arg2, f133_arg3, f133_arg4)
						CloseStartMenu(f133_arg4, f133_arg2)
						CoDShared.QuitGame(f133_arg2)
					end,
				},
			},
			{
				models = {
					displayText = Engine[0xF9F1239CFD921FE](0x4C0687F40244FFF),
				},
				properties = {
					action = function(f134_arg0, f134_arg1, f134_arg2, f134_arg3, f134_arg4)
						GoBack(f134_arg4, f134_arg2)
					end,
				},
			},
		}
		if f131_arg0 then
			table.insert(f132_local0, {
				models = {
					displayText = Engine[0xF9F1239CFD921FE](0x1762CBFBF851D22),
				},
				properties = {
					action = function(f135_arg0, f135_arg1, f135_arg2, f135_arg3, f135_arg4)
						GoBack(f135_arg4, f135_arg2)
						CoD.PCUtility.ToggleShortcutMenu(f135_arg4, f135_arg2, "ui_opensettings")
					end,
				},
			})
		end
		return f132_local0
	end, true, nil)
	return "QuitGamePopup_List"
end
f0_local4[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack
f0_local4[CoD.OverlayUtility.aCrossPromptFn] = function(f136_arg0)
	return function(f137_arg0, f137_arg1)
		CloseStartMenu(f137_arg0, f137_arg1)
		CoDShared.QuitGame(f137_arg1)
	end
end
f0_local4[CoD.OverlayUtility.aCrossPromptText] = 0x7163F6214A962C7
f0_local4[CoD.OverlayUtility.bCirclePromptFn] = function(f138_arg0)
	return function(f139_arg0, f139_arg1)
		GoBack(f139_arg0, f139_arg1)
	end
end
f0_local4[CoD.OverlayUtility.bCirclePromptText] = 0x4C0687F40244FFF
f0_local4[CoD.OverlayUtility.xSquarePromptFn] = function(f140_arg0)
	local f140_local0
	if f140_arg0 then
		f140_local0 = function(f141_arg0, f141_arg1)
			GoBack(f141_arg0, f141_arg1)
			CoD.PCUtility.ToggleShortcutMenu(f141_arg0, f141_arg1, "ui_opensettings")
		end
		if not f140_local0 then
		else
			return f140_local0
		end
	end
	f140_local0 = nil
end
f0_local4[CoD.OverlayUtility.xSquarePromptText] = function(f142_arg0)
	local f142_local0
	if f142_arg0 then
		f142_local0 = 0x1762CBFBF851D22
		if not f142_local0 then
		else
			return f142_local0
		end
	end
	f142_local0 = nil
end
f0_local3.QuitPCMatchPopup = f0_local4
f0_local3.QuitPCArenaMatchPopup = {
	menuName = "SystemOverlay_Compact",
	frameWidget = LuaUtils.IsArenaPublicGame() and "CoD.systemOverlay_QuitLeaguePlay" or nil,
	title = Engine[0xF9F1239CFD921FE](0x10A724241848AC8),
	description = CoD.isPublicOnlineGame() and Engine[0xF9F1239CFD921FE](0x896B29D6A289A61) or Engine[0xF9F1239CFD921FE](0xE600BD476A84DE9),
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	listDatasource = function(f143_arg0)
		DataSources.QuitGamePopup_List = DataSourceHelpers.ListSetup("QuitGamePopup_List", function(f144_arg0)
			local f144_local0 = {
				{
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x7163F6214A962C7),
					},
					properties = {
						action = function(f145_arg0, f145_arg1, f145_arg2, f145_arg3, f145_arg4)
							CloseStartMenu(f145_arg4, f145_arg2)
							CoDShared.QuitGame(f145_arg2, not CoD.StartMenuUtility.GetArenaQuitDeservesExtraPenalty(f145_arg2))
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x4C0687F40244FFF),
					},
					properties = {
						action = function(f146_arg0, f146_arg1, f146_arg2, f146_arg3, f146_arg4)
							GoBack(f146_arg4, f146_arg2)
						end,
					},
				},
			}
			if f143_arg0 then
				table.insert(f144_local0, {
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x1762CBFBF851D22),
					},
					properties = {
						action = function(f147_arg0, f147_arg1, f147_arg2, f147_arg3, f147_arg4)
							GoBack(f147_arg4, f147_arg2)
							CoD.PCUtility.ToggleShortcutMenu(f147_arg4, f147_arg2, "ui_opensettings")
						end,
					},
				})
			end
			return f144_local0
		end, true, nil)
		return "QuitGamePopup_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f148_arg0)
		return function(f149_arg0, f149_arg1)
			CloseStartMenu(f149_arg0, f149_arg1)
			CoDShared.QuitGame(f149_arg1, not CoD.StartMenuUtility.GetArenaQuitDeservesExtraPenalty(f149_arg1))
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = 0x7163F6214A962C7,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f150_arg0)
		return function(f151_arg0, f151_arg1)
			GoBack(f151_arg0, f151_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = 0x4C0687F40244FFF,
	[CoD.OverlayUtility.xSquarePromptFn] = function(f152_arg0)
		local f152_local0
		if f152_arg0 then
			f152_local0 = function(f153_arg0, f153_arg1)
				GoBack(f153_arg0, f153_arg1)
				CoD.PCUtility.ToggleShortcutMenu(f153_arg0, f153_arg1, "ui_opensettings")
			end
			if not f152_local0 then
			else
				return f152_local0
			end
		end
		f152_local0 = nil
	end,
	[CoD.OverlayUtility.xSquarePromptText] = function(f154_arg0)
		local f154_local0
		if f154_arg0 then
			f154_local0 = 0x1762CBFBF851D22
			if not f154_local0 then
			else
				return f154_local0
			end
		end
		f154_local0 = nil
	end,
}
f0_local3.QuitPCMatchWhileSpectatingPopup = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x10A724241848AC8),
	description = Engine[0xF9F1239CFD921FE](0x0),
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	listDatasource = function(f155_arg0)
		DataSources.QuitGamePopup_List = DataSourceHelpers.ListSetup("QuitGamePopup_List", function(f156_arg0)
			local f156_local0 = {
				{
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x7163F6214A962C7),
					},
					properties = {
						action = function(f157_arg0, f157_arg1, f157_arg2, f157_arg3, f157_arg4)
							CloseStartMenu(f157_arg4, f157_arg2)
							CoDShared.QuitGame(f157_arg2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x4C0687F40244FFF),
					},
					properties = {
						action = function(f158_arg0, f158_arg1, f158_arg2, f158_arg3, f158_arg4)
							GoBack(f158_arg4, f158_arg2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0xBFDFFB24824DEE6),
					},
					properties = {
						action = function(f159_arg0, f159_arg1, f159_arg2, f159_arg3, f159_arg4)
							Engine[0x7C75E608EA39B5C](f159_arg2, "quit")
						end,
					},
				},
			}
			table.insert(f156_local0, {
				models = {
					displayText = Engine[0xF9F1239CFD921FE](0x1762CBFBF851D22),
				},
				properties = {
					action = function(f160_arg0, f160_arg1, f160_arg2, f160_arg3, f160_arg4)
						GoBack(f160_arg4, f160_arg2)
						CoD.PCUtility.ToggleShortcutMenu(f160_arg4, f160_arg2, "ui_opensettings")
					end,
				},
			})
			return f156_local0
		end, true, nil)
		return "QuitGamePopup_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f161_arg0)
		return function(f162_arg0, f162_arg1)
			CloseStartMenu(f162_arg0, f162_arg1)
			CoDShared.QuitGame(f162_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = 0x7163F6214A962C7,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f163_arg0)
		return function(f164_arg0, f164_arg1)
			GoBack(f164_arg0, f164_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = 0x4C0687F40244FFF,
	[CoD.OverlayUtility.yTrianglePromptFn] = function(f165_arg0)
		return function()
			Engine[0x7C75E608EA39B5C](f165_arg0, "quit")
		end
	end,
	[CoD.OverlayUtility.yTrianglePromptText] = 0xBFDFFB24824DEE6,
	[CoD.OverlayUtility.xSquarePromptFn] = function(f167_arg0)
		return function(f168_arg0, f168_arg1)
			GoBack(f168_arg0, f168_arg1)
			CoD.PCUtility.ToggleShortcutMenu(f168_arg0, f168_arg1, "ui_opensettings")
		end or nil
	end,
	[CoD.OverlayUtility.xSquarePromptText] = function(f169_arg0)
		return 0x1762CBFBF851D22 or nil
	end,
}
f0_local4 = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x89E88D593CFB09),
}
if CoD.isPublicOnlineGame() then
	local f0_local7 = IsMultiplayer()
	local f0_local8 = Engine[0xF9F1239CFD921FE](0x9439ED4B6B6C69A) .. "\n\n" .. Engine[0xF9F1239CFD921FE](0xFC9034400BFB613)
end
f0_local4.description = f0_local7 and f0_local8 or Engine[0xF9F1239CFD921FE](0x9439ED4B6B6C69A) .. "\n\n" .. Engine[0xF9F1239CFD921FE](0xE600BD476A84DE9)
f0_local4.categoryType = CoD.OverlayUtility.OverlayTypes.Quit
f0_local4.listDatasource = function()
	DataSources.QuitPCGamePopup_List = DataSourceHelpers.ListSetup("QuitPCGamePopup_List", function(f171_arg0)
		return {
			{
				models = {
					displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x9F068337F7FD41D)),
				},
				properties = {
					action = function(f172_arg0, f172_arg1, f172_arg2, f172_arg3, f172_arg4)
						Engine[0x7C75E608EA39B5C](f172_arg2, "quit")
					end,
				},
			},
			{
				models = {
					displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x154915937098D9E)),
				},
				properties = {
					action = function(f173_arg0, f173_arg1, f173_arg2, f173_arg3, f173_arg4)
						local f173_local0 = GoBack(f173_arg4, f173_arg2)
						if f173_local0.pcQuitOverlayActive ~= nil then
							f173_local0.pcQuitOverlayActive = false
						end
					end,
				},
			},
		}
	end, true, nil)
	return "QuitPCGamePopup_List"
end
f0_local4[CoD.OverlayUtility.GoBackPropertyName] = function()
	return function(f175_arg0, f175_arg1)
		local f175_local0 = GoBack(f175_arg0, f175_arg1)
		if f175_local0.pcQuitOverlayActive ~= nil then
			f175_local0.pcQuitOverlayActive = false
		end
	end
end
f0_local4[CoD.OverlayUtility.aCrossPromptFn] = function(f176_arg0)
	return function()
		Engine[0x7C75E608EA39B5C](f176_arg0, "quit")
	end
end
f0_local4[CoD.OverlayUtility.aCrossPromptText] = 0xB2EF56B4AF147B8
f0_local4[CoD.OverlayUtility.bCirclePromptFn] = function(f178_arg0)
	return function(f179_arg0, f179_arg1)
		local f179_local0 = GoBack(f179_arg0, f179_arg1)
		if f179_local0.pcQuitOverlayActive ~= nil then
			f179_local0.pcQuitOverlayActive = false
		end
	end
end
f0_local4[CoD.OverlayUtility.bCirclePromptText] = 0x154915937098D9E
f0_local3.QuitPCGamePopup = f0_local4
f0_local3.QuitPCArenaGamePopup = {
	menuName = "SystemOverlay_Compact",
	frameWidget = LuaUtils.IsArenaPublicGame() and "CoD.systemOverlay_QuitLeaguePlay" or nil,
	title = Engine[0xF9F1239CFD921FE](0x89E88D593CFB09),
	description = CoD.isPublicOnlineGame() and Engine[0xF9F1239CFD921FE](0x9439ED4B6B6C69A) .. "\n\n" .. Engine[0xF9F1239CFD921FE](0x896B29D6A289A61) or Engine[0xF9F1239CFD921FE](0x9439ED4B6B6C69A) .. "\n\n" .. Engine[0xF9F1239CFD921FE](0xE600BD476A84DE9),
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	listDatasource = function()
		DataSources.QuitPCGamePopup_List = DataSourceHelpers.ListSetup("QuitPCGamePopup_List", function(f181_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x9F068337F7FD41D)),
					},
					properties = {
						action = function(f182_arg0, f182_arg1, f182_arg2, f182_arg3, f182_arg4)
							Engine[0x7C75E608EA39B5C](f182_arg2, "quit")
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x154915937098D9E)),
					},
					properties = {
						action = function(f183_arg0, f183_arg1, f183_arg2, f183_arg3, f183_arg4)
							local f183_local0 = GoBack(f183_arg4, f183_arg2)
							if f183_local0.pcQuitOverlayActive ~= nil then
								f183_local0.pcQuitOverlayActive = false
							end
						end,
					},
				},
			}
		end, true, nil)
		return "QuitPCGamePopup_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = function()
		return function(f185_arg0, f185_arg1)
			local f185_local0 = GoBack(f185_arg0, f185_arg1)
			if f185_local0.pcQuitOverlayActive ~= nil then
				f185_local0.pcQuitOverlayActive = false
			end
		end
	end,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f186_arg0)
		return function()
			Engine[0x7C75E608EA39B5C](f186_arg0, "quit")
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = 0xB2EF56B4AF147B8,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f188_arg0)
		return function(f189_arg0, f189_arg1)
			local f189_local0 = GoBack(f189_arg0, f189_arg1)
			if f189_local0.pcQuitOverlayActive ~= nil then
				f189_local0.pcQuitOverlayActive = false
			end
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = 0x154915937098D9E,
}
f0_local3.OutsideCorePCPlayingHoursPopup = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x3848FB4FF0D17C2),
	description = 0x330BAB29A2FC015,
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	listDatasource = function()
		DataSources.OutsideCorePCPlayingHoursPopup_List = DataSourceHelpers.ListSetup("OutsideCorePCPlayingHoursPopup_List", function(f191_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xB2EF56B4AF147B8)),
					},
					properties = {
						action = function(f192_arg0, f192_arg1, f192_arg2, f192_arg3, f192_arg4)
							Engine[0x7C75E608EA39B5C](f192_arg2, "quit")
						end,
					},
				},
			}
		end, true, nil)
		return "OutsideCorePCPlayingHoursPopup_List"
	end,
}
f0_local3.LeaveLobbyPopupPC = {
	menuName = "SystemOverlay_Compact",
	title = function(f193_arg0)
		local f193_local0 = 0x0
		if f193_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY then
			f193_local0 = 0xB69F71ABEAEC777
		elseif f193_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			f193_local0 = 0xE6679EE5787CB48
		elseif f193_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY then
			f193_local0 = 0x318119895303B4B
		elseif f193_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			f193_local0 = 0xB69F71ABEAEC777
		elseif f193_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE then
			f193_local0 = 0x318119895303B4B
		elseif f193_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			f193_local0 = 0x7992FB2AE130417
		end
		return Engine[0xF9F1239CFD921FE](f193_local0)
	end,
	description = function(f194_arg0)
		local f194_local0 = 0x0
		if f194_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY then
			f194_local0 = 0xB543EF9A1104B6E
		elseif f194_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			f194_local0 = 0xEF7BFBB3912534B
		elseif f194_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			f194_local0 = 0xB543EF9A1104B6E
		elseif f194_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			f194_local0 = 0xE47086DBA25578E
		end
		return Engine[0xF9F1239CFD921FE](f194_local0)
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	postCreateStep = function(f195_arg0, f195_arg1)
		f195_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.lobbyLockedIn"), function(model)
			if Engine[0x614D394F6F9A18D](model) == true then
				GoBack(f195_arg0, f195_arg1)
			end
		end)
		f195_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.publicLobby.stage"), function(model)
			if LuaUtils.IsArenaPublicGame() and Engine[0x614D394F6F9A18D](model) == LuaEnum.PUBLIC_LOBBY.START_MATCH then
				GoBack(f195_arg0, f195_arg1)
			end
		end)
	end,
	getGoBackFn = function(f198_arg0, f198_arg1)
		return function(f199_arg0, f199_arg1)
			if f198_arg0 == nil then
				GoBack(f199_arg0, f199_arg1)
				return
			else
				GoBackAndLeaveParty(f199_arg0, f199_arg1, f198_arg0)
			end
		end
	end,
	options = function(f200_arg0, f200_arg1)
		local f200_local0 = {}
		if f200_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_PARTY then
			table.insert(f200_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = 0x4BE8031E505109A,
			})
		elseif f200_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_AND_DISBAND_PARTY then
			table.insert(f200_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = 0xEA3B4895763DFF0,
			})
		elseif f200_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY then
			table.insert(f200_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = 0xF420F9DB5188F96,
			})
		elseif f200_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.LEAVE_LOBBY_AND_PARTY then
			table.insert(f200_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT, f200_arg1),
				text = 0xACDE687F90ACD0B,
			})
		elseif f200_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.BRING_PARTY_LEAVE_ALONE then
			table.insert(f200_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITH),
				text = 0x7D920DBE7BE3E1D,
			})
			table.insert(f200_local0, {
				action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(LuaEnum.LEAVE_WITH_PARTY.WITHOUT),
				text = 0x7C57347FF991141,
			})
		elseif f200_arg0 == LuaEnum.LEAVE_LOBBY_POPUP.MANAGE_PARTY_LEAVE then
			table.insert(f200_local0, {
				action = function(f201_arg0, f201_arg1)
					GoBack(f201_arg0, f201_arg1)
					Engine[0x87AE7E64BA5AD61]("OnManagePartyLeave", {
						controller = f201_arg1,
					})
				end,
				text = 0x349737B0BDAA763,
			})
		end
		table.insert(f200_local0, {
			action = CoD.OverlayUtility.Overlays.LobbyLeavePopup.getGoBackFn(nil),
			text = 0x154915937098D9E,
			isCancelOption = true,
		})
		return f200_local0
	end,
	listDatasource = CoD.OverlayUtility.CreateOverlayDataSourceFromOptions("LeaveLobbyPopupPC"),
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(...)
		local f202_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays.LeaveLobbyPopupPC.options, {
			n = select("#", ...),
			...,
		})
		if f202_local0 then
			local f202_local1 = f202_local0[1]
			if f202_local1 then
				return function(f203_arg0, f203_arg1)
					f202_local1.action(f203_arg0, f203_arg1)
				end
			end
		end
		return nil
	end,
	[CoD.OverlayUtility.aCrossPromptText] = function(...)
		local f204_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays.LeaveLobbyPopupPC.options, {
			n = select("#", ...),
			...,
		})
		if f204_local0 then
			local f204_local1 = f204_local0[1]
			if f204_local1 then
				return f204_local1.text
			end
		end
		return 0x0
	end,
	[CoD.OverlayUtility.xSquarePromptFn] = function(...)
		local f205_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays.LeaveLobbyPopupPC.options, {
			n = select("#", ...),
			...,
		})
		if not f205_local0[3] then
			return
		elseif f205_local0 then
			local f205_local1 = f205_local0[2]
			if f205_local1 then
				return function(f206_arg0, f206_arg1)
					f205_local1.action(f206_arg0, f206_arg1)
				end
			end
		end
		return nil
	end,
	[CoD.OverlayUtility.xSquarePromptText] = function(...)
		local f207_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays.LeaveLobbyPopupPC.options, {
			n = select("#", ...),
			...,
		})
		if not f207_local0[3] then
			return
		elseif f207_local0 then
			local f207_local1 = f207_local0[2]
			if f207_local1 then
				return f207_local1.text
			end
		end
		return 0x0
	end,
	[CoD.OverlayUtility.bCirclePromptFn] = function(...)
		local f208_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays.LeaveLobbyPopupPC.options, {
			n = select("#", ...),
			...,
		})
		if f208_local0 then
			local f208_local1 = f208_local0[3] or f208_local0[2]
			if f208_local1 then
				return function(f209_arg0, f209_arg1)
					f208_local1.action(f209_arg0, f209_arg1)
				end
			end
		end
		return nil
	end,
	[CoD.OverlayUtility.bCirclePromptText] = function(...)
		local f210_local0 = CoD.OverlayUtility.callFnOrGetValue(CoD.OverlayUtility.Overlays.LeaveLobbyPopupPC.options, {
			n = select("#", ...),
			...,
		})
		if f210_local0 then
			local f210_local1 = f210_local0[3] or f210_local0[2]
			if f210_local1 then
				return f210_local1.text
			end
		end
		return 0x0
	end,
}
f0_local3.ResetCustomGameSettingsPC = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x8DA07D8AFA13097),
	description = 0x9C4B0F90AB92689,
	categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
	listDatasource = function()
		DataSources.ResetCustomGameSettingsPC_List = DataSourceHelpers.ListSetup("ResetCustomGameSettingsPC_List", function(f212_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x9947780A0E1251E)),
					},
					properties = {
						action = function(f213_arg0, f213_arg1, f213_arg2, f213_arg3, f213_arg4)
							ResetGameSettings(f213_arg4, f213_arg2)
							GoBack(f213_arg4, f213_arg2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x37C39B4D7F22B61)),
					},
					properties = {
						action = function(f214_arg0, f214_arg1, f214_arg2, f214_arg3, f214_arg4)
							GoBack(f214_arg4, f214_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "ResetCustomGameSettingsPC_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f215_arg0)
		return function(f216_arg0, f216_arg1)
			ResetGameSettings(f216_arg0, f216_arg1)
			GoBack(f216_arg0, f216_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = 0x9947780A0E1251E,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f217_arg0)
		return function(f218_arg0, f218_arg1)
			GoBack(f218_arg0, f218_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = 0x4A93EC78F54644E,
}
f0_local3.ResetPCSettings = {
	menuName = "SystemOverlay_Compact",
	title = function(f219_arg0)
		local f219_local0 = {
			[CoD.PCOptionsUtility.OptionTabIds.Gameplay] = 0xBF7A114B59AC127,
			[CoD.PCOptionsUtility.OptionTabIds.Keybind] = 0x2ED467C88B5EA7E,
			[CoD.PCOptionsUtility.OptionTabIds.Graphic] = 0x66BA2F85FD1A5CF,
			[CoD.PCOptionsUtility.OptionTabIds.Interface] = 0x6CA3CF0CA3D8332,
			[CoD.PCOptionsUtility.OptionTabIds.Audio] = 0x932CF9C29A0208F,
			[CoD.PCOptionsUtility.OptionTabIds.Gamepad] = 0x568A2A6981B5F56,
		}
		local f219_local1 = f219_local0[f219_arg0]
		assert(f219_local1)
		return Engine[0xF9F1239CFD921FE](f219_local1)
	end,
	description = function(f220_arg0)
		local f220_local0
		if f220_arg0 == CoD.PCOptionsUtility.OptionTabIds.Graphic then
			f220_local0 = 0x0
			if not f220_local0 then
			else
				return Engine[0xF9F1239CFD921FE](f220_local0)
			end
		end
		f220_local0 = 0xC5F255F9788B3A1
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
	listDatasource = function(f221_arg0)
		DataSources.ResetPCSettings_List = DataSourceHelpers.ListSetup("PC.ResetPCSettings_List", function(f222_arg0)
			return {
				{
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x19BF0EA1BC7E75E),
					},
					properties = {
						action = function(f223_arg0, f223_arg1, f223_arg2, f223_arg3, f223_arg4)
							if f223_arg3 == CoD.PCOptionsUtility.OptionTabIds.Gameplay then
								ResetPCControlsToDefault(f223_arg4, f223_arg2)
							elseif f223_arg3 == CoD.PCOptionsUtility.OptionTabIds.Keybind then
								ResetPCBindingsToDefault(f223_arg4, f223_arg2)
							elseif f223_arg3 == CoD.PCOptionsUtility.OptionTabIds.Graphic then
								ResetPCGraphicsOptions(f223_arg4, f223_arg1, f223_arg2, f223_arg4)
							elseif f223_arg3 == CoD.PCOptionsUtility.OptionTabIds.Interface then
								Engine[0xAD0088407D9A946](f223_arg2)
							elseif f223_arg3 == CoD.PCOptionsUtility.OptionTabIds.Audio then
								Engine[0xFC09178D42E34C1](f223_arg2)
								CoD.PCOptionsUtility.RefreshVoiceChatTelemetryDisplay(f223_arg2)
							elseif f223_arg3 == CoD.PCOptionsUtility.OptionTabIds.Gamepad then
								Engine[0xDEDEA32909E3ED6](f223_arg2)
							end
							UpdateGamerprofile(f223_arg4, f223_arg1, f223_arg2)
							CoD.PCOptionsUtility.SyncAllOptionModels(f223_arg2)
							if CoD.PCOptionsUtility.SettingsSession[f223_arg2] then
								CoD.PCOptionsUtility.SettingsSession[f223_arg2].optionsChangedInTab[f223_arg3] = true
							end
							if f223_arg3 == CoD.PCOptionsUtility.OptionTabIds.Gamepad then
								DataSourceHelperRecreate(f223_arg2, "ButtonLayoutLabels")
								DataSourceHelperRecreate(f223_arg2, "StickLayoutLabels")
							end
							GoBack(f223_arg4, f223_arg2)
						end,
						actionParam = f221_arg0,
					},
				},
				{
					models = {
						displayText = Engine[0xF9F1239CFD921FE](0x4A93EC78F54644E),
					},
					properties = {
						action = function(f224_arg0, f224_arg1, f224_arg2, f224_arg3, f224_arg4)
							GoBack(f224_arg4, f224_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "ResetPCSettings_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f225_arg0)
		return function(f226_arg0, f226_arg1)
			if f225_arg0 == CoD.PCOptionsUtility.OptionTabIds.Gameplay then
				ResetPCControlsToDefault(f226_arg0, f226_arg1)
			elseif f225_arg0 == CoD.PCOptionsUtility.OptionTabIds.Keybind then
				ResetPCBindingsToDefault(f226_arg0, f226_arg1)
			elseif f225_arg0 == CoD.PCOptionsUtility.OptionTabIds.Graphic then
				ResetPCGraphicsOptions(f226_arg0, f226_arg0, f226_arg1, f226_arg0)
			elseif f225_arg0 == CoD.PCOptionsUtility.OptionTabIds.Interface then
				Engine[0xAD0088407D9A946](f226_arg1)
			elseif f225_arg0 == CoD.PCOptionsUtility.OptionTabIds.Audio then
				Engine[0xFC09178D42E34C1](f226_arg1)
				CoD.PCOptionsUtility.SyncAudioDeviceModel(f226_arg1)
			elseif f225_arg0 == CoD.PCOptionsUtility.OptionTabIds.Gamepad then
				Engine[0xDEDEA32909E3ED6](f226_arg1)
			end
			UpdateGamerprofile(f226_arg0, f226_arg0, f226_arg1)
			CoD.PCOptionsUtility.SyncAllOptionModels(f226_arg1)
			if CoD.PCOptionsUtility.SettingsSession[f226_arg1] then
				CoD.PCOptionsUtility.SettingsSession[f226_arg1].optionsChangedInTab[f225_arg0] = true
			end
			GoBack(f226_arg0, f226_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = 0x19BF0EA1BC7E75E,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f227_arg0)
		return function(f228_arg0, f228_arg1)
			GoBack(f228_arg0, f228_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = 0x4A93EC78F54644E,
}
f0_local3.ResetAllPCOptions = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x97B6997ACC73953),
	description = 0x0,
	categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
	listDatasource = function()
		DataSources.ResetPCControls_List = DataSourceHelpers.ListSetup("ResetPCControls_List", function(f230_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xDFD294FC69F682)),
					},
					properties = {
						action = function(f231_arg0, f231_arg1, f231_arg2, f231_arg3, f231_arg4)
							ResetEverythingOnPC(f231_arg0, f231_arg2)
							for f231_local3, f231_local4 in pairs(CoD.PCOptionsUtility.OptionTabIds) do
								CoD.PCOptionsUtility.SettingsSession[f231_arg2].optionsChangedInTab[f231_local4] = true
							end
							GoBack(f231_arg4, f231_arg2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x5C16E02B211A4F4)),
					},
					properties = {
						action = function(f232_arg0, f232_arg1, f232_arg2, f232_arg3, f232_arg4)
							GoBack(f232_arg4, f232_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "ResetPCControls_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
}
f0_local3.ApplyPresetConfirmation = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x882A1A6F5CEA710),
	description = 0x6BDE0AFEE56C838,
	categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
	listDatasource = function()
		DataSources.ResetPCControls_List = DataSourceHelpers.ListSetup("ResetPCControls_List", function(f234_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xC26F0C4EC974DD9)),
					},
					properties = {
						action = function(f235_arg0, f235_arg1, f235_arg2, f235_arg3, f235_arg4)
							if f235_arg4._goToSettingsAfter then
								CoD.PCWidgetUtility.ApplyOptionsKeysetBindingsDropdownProperties(f235_arg0, f235_arg2, f235_arg4._dropdown)
								CoD.PCWidgetUtility.GoBackAndOpenSettingsMenuOnTabId(f235_arg0, f235_arg2, 2, CoD.PCWidgetUtility.PCKeybindingsTabId)
							else
								CoD.PCWidgetUtility.ApplyOnDropdownConfirmationPopup(f235_arg0, f235_arg2, f235_arg4._dropdown, f235_arg4._multipleGoBackOnApply)
							end
							f235_arg4._dropdown = nil
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x9A80F8994FCC97E)),
					},
					properties = {
						action = function(f236_arg0, f236_arg1, f236_arg2, f236_arg3, f236_arg4)
							if f236_arg4._resetDropdownOnCancel then
								CoD.PCWidgetUtility.ResetOptionsKeysetBindingsDropdownToDvars(f236_arg0, f236_arg2, f236_arg4._dropdown, false)
							end
							f236_arg4._dropdown = nil
							GoBackMultiple(f236_arg0, f236_arg2, 2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x44AB10808B9509E)),
					},
					properties = {
						action = function(f237_arg0, f237_arg1, f237_arg2, f237_arg3, f237_arg4)
							GoBack(f237_arg4, f237_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "ResetPCControls_List"
	end,
	preCreateStep = function(f238_arg0, f238_arg1, f238_arg2)
		f238_arg0._dropdown = f238_arg2._dropdown
		f238_arg0._multipleGoBackOnApply = f238_arg2._multipleGoBackOnApply
		f238_arg0._resetDropdownOnCancel = f238_arg2._resetDropdownOnCancel
		f238_arg0._goToSettingsAfter = f238_arg2._goToSettingsAfter
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f239_arg0)
		return function(f240_arg0, f240_arg1)
			if f240_arg0._goToSettingsAfter then
				CoD.PCWidgetUtility.ApplyOptionsKeysetBindingsDropdownProperties(nil, f240_arg1, f240_arg0._dropdown)
				CoD.PCWidgetUtility.GoBackAndOpenSettingsMenuOnTabId(f240_arg0, f240_arg1, 2, CoD.PCWidgetUtility.PCKeybindingsTabId)
			else
				CoD.PCWidgetUtility.ApplyOnDropdownConfirmationPopup(f240_arg0, f240_arg1, f240_arg0._dropdown, f240_arg0._multipleGoBackOnApply)
			end
			f240_arg0._dropdown = nil
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = 0xC26F0C4EC974DD9,
	[CoD.OverlayUtility.xSquarePromptFn] = function(f241_arg0)
		return function(f242_arg0, f242_arg1)
			if f242_arg0._resetDropdownOnCancel then
				CoD.PCWidgetUtility.ResetOptionsKeysetBindingsDropdownToDvars(nil, f242_arg1, f242_arg0._dropdown, false)
			end
			f242_arg0._dropdown = nil
			GoBackMultiple(f242_arg0, f242_arg1, 2)
		end
	end,
	[CoD.OverlayUtility.xSquarePromptText] = 0x9A80F8994FCC97E,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f243_arg0)
		return function(f244_arg0, f244_arg1)
			GoBack(f244_arg0, f244_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = 0x4A93EC78F54644E,
}
f0_local3.ResetPCControls = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0xBF7A114B59AC127),
	description = 0xC5F255F9788B3A1,
	categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
	listDatasource = function()
		DataSources.ResetPCControls_List = DataSourceHelpers.ListSetup("ResetPCControls_List", function(f246_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x19BF0EA1BC7E75E)),
					},
					properties = {
						action = function(f247_arg0, f247_arg1, f247_arg2, f247_arg3, f247_arg4)
							ResetPCControlsToDefault(f247_arg4, f247_arg2)
							CoD.PCOptionsUtility.SyncAllOptionModels(f247_arg2)
							GoBack(f247_arg4, f247_arg2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x44AB10808B9509E)),
					},
					properties = {
						action = function(f248_arg0, f248_arg1, f248_arg2, f248_arg3, f248_arg4)
							GoBack(f248_arg4, f248_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "ResetPCControls_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
}
f0_local3.ApplyPCGraphics = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x713A32CF64F9F58),
	description = 0xC5F255F9788B3A1,
	categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
	listDatasource = function()
		DataSources.ApplyPCGraphics_List = DataSourceHelpers.ListSetup("ApplyPCGraphics_List", function(f250_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0xDFD294FC69F682)),
					},
					properties = {
						action = function(f251_arg0, f251_arg1, f251_arg2, f251_arg3, f251_arg4)
							CoD.PCOptionsUtility.ApplyAllPCChangedOptions(f251_arg0, f251_arg2)
							UpdateGamerprofile(f251_arg4, f251_arg1, f251_arg2)
							GoBackMultiple(f251_arg4, f251_arg2, 2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x5C16E02B211A4F4)),
					},
					properties = {
						action = function(f252_arg0, f252_arg1, f252_arg2, f252_arg3, f252_arg4)
							CoD.PCOptionsUtility.RevertPCHardwareChanges(f252_arg0, f252_arg2)
							GoBackMultiple(f252_arg4, f252_arg2, 2)
						end,
					},
				},
			}
		end, true, nil)
		return "ApplyPCGraphics_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
}
f0_local3.PendingChangesOnQuitOptionsMenu = {
	menuName = "SystemOverlay_Compact",
	title = Engine[0xF9F1239CFD921FE](0x1AABECCBA2CDFD4),
	description = 0xD0FDA3A9D90649C,
	categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
	listDatasource = function(f253_arg0)
		DataSources.PendingChangesOnQuitOptionsMenu_List = DataSourceHelpers.ListSetup("PendingChangesOnQuitOptionsMenu_List", function(f254_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x7D14DF1D6CBE990)),
					},
					properties = {
						action = function(f255_arg0, f255_arg1, f255_arg2, f255_arg3, f255_arg4)
							CoD.PCOptionsUtility.ApplyAllPCChangedOptions(f255_arg0, f255_arg2)
							UpdateGamerprofile(f255_arg4, f255_arg1, f255_arg2)
							if f253_arg0 ~= nil then
								f253_arg0()
							end
							GoBack(f255_arg4, f255_arg2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x9A80F8994FCC97E)),
					},
					properties = {
						action = function(f256_arg0, f256_arg1, f256_arg2, f256_arg3, f256_arg4)
							CoD.PCOptionsUtility.RevertPCHardwareChanges(f256_arg0, f256_arg2)
							if f253_arg0 ~= nil then
								f253_arg0()
							end
							GoBack(f256_arg4, f256_arg2)
						end,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x44AB10808B9509E)),
					},
					properties = {
						action = function(f257_arg0, f257_arg1, f257_arg2, f257_arg3, f257_arg4)
							GoBack(f257_arg4, f257_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "PendingChangesOnQuitOptionsMenu_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f258_arg0)
		return function(f259_arg0, f259_arg1)
			CoD.PCOptionsUtility.ApplyAllPCChangedOptions(f259_arg0, f259_arg1)
			UpdateGamerprofile(f259_arg0, f259_arg0, f259_arg1)
			if f258_arg0 ~= nil then
				f258_arg0()
			end
			GoBack(f259_arg0, f259_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = 0x7D14DF1D6CBE990,
	[CoD.OverlayUtility.xSquarePromptFn] = function(f260_arg0)
		return function(f261_arg0, f261_arg1)
			CoD.PCOptionsUtility.RevertPCHardwareChanges(f261_arg0, f261_arg1)
			if f260_arg0 ~= nil then
				f260_arg0()
			end
			GoBack(f261_arg0, f261_arg1)
		end
	end,
	[CoD.OverlayUtility.xSquarePromptText] = 0x9A80F8994FCC97E,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f262_arg0)
		return function(f263_arg0, f263_arg1)
			GoBack(f263_arg0, f263_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = 0x44AB10808B9509E,
}
f0_local3.ResetCodCasterSettingsPC = {
	menuName = "SystemOverlay_Compact",
	title = function(f264_arg0)
		local f264_local0 = {
			DirectorCodCasterSettings = 0x836ADC028ADD9BC,
			CodCasterQuickSettingsSideBar = 0x518141D2FC4D708,
			CodCasterSettingsSideBar = 0x9969E4A34D3F82E,
		}
		local f264_local1 = f264_local0[f264_arg0]
		assert(f264_local1)
		return Engine[0xF9F1239CFD921FE](f264_local1)
	end,
	description = 0x93C3C9DAAC68F44,
	categoryType = CoD.OverlayUtility.OverlayTypes.Settings,
	listDatasource = function(f265_arg0)
		DataSources.ResetCodCasterSettingsPC_List = DataSourceHelpers.ListSetup("ResetCodCasterSettingsPC_List", function(f266_arg0)
			return {
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x9947780A0E1251E)),
					},
					properties = {
						action = function(f267_arg0, f267_arg1, f267_arg2, f267_arg3, f267_arg4)
							CoD.CodCasterUtility.ResetCodcasterSettings(f267_arg2, f267_arg3)
							GoBack(f267_arg4, f267_arg2)
						end,
						actionParam = f265_arg0,
					},
				},
				{
					models = {
						displayText = Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x37C39B4D7F22B61)),
					},
					properties = {
						action = function(f268_arg0, f268_arg1, f268_arg2, f268_arg3, f268_arg4)
							GoBack(f268_arg4, f268_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "ResetCodCasterSettingsPC_List"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.aCrossPromptFn] = function(f269_arg0)
		return function(f270_arg0, f270_arg1)
			CoD.CodCasterUtility.ResetCodcasterSettings(f270_arg1, f269_arg0)
			GoBack(f270_arg0, f270_arg1)
		end
	end,
	[CoD.OverlayUtility.aCrossPromptText] = 0x9947780A0E1251E,
	[CoD.OverlayUtility.bCirclePromptFn] = function(f271_arg0)
		return function(f272_arg0, f272_arg1)
			GoBack(f272_arg0, f272_arg1)
		end
	end,
	[CoD.OverlayUtility.bCirclePromptText] = 0x4A93EC78F54644E,
}
f0_local0.Overlays = f0_local1(f0_local2, f0_local3)
CoD.PCUtility.GameEventStrings = {
	PARTY_INVITE_TO_PLAYER = 0x95686DF00A98B45,
	PARTY_ERROR_UNAVAILABLE = 0x60B2BECB16317B7,
	PARTY_PLAYER_KICKED = 0x890D8D242702701,
	PARTY_INVITE_ACCEPTED = 0x9E628C08F7D168B,
	PARTY_INVITE_DISMISS = 0xD0E7C749DA710E,
	PARTY_INVITE_TIMEOUT = 0xE1457696DE45FFD,
}
CoD.PCUtility.ShowGameEventFromEnum = function(f273_arg0)
	CoD.PCUtility.ShowGameEvent(Engine[0xED84C33EC5F01EA](f273_arg0))
end
CoD.PCUtility.ShowGameEvent = function(f274_arg0)
	Engine[0x9B57C0F0680848E](Engine[0xF4AC963487AA68C](Enum[0xF6296F5D7A38AD2][0x59073B959F68608]), f274_arg0)
end
CoD.PCUtility.RegisterPlaytimeLeftWatcher = function(f275_arg0)
	local f275_local0 = {
		60,
		30,
		15,
		5,
	}
	local f275_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "PC.PlaytimeLastMessageIndex")
	if not f275_local1:get() then
		f275_local1:set(0)
	end
	local f275_local2 = Engine[0x8DF2E5447F384B9]()
	f275_local2 = f275_local2["PC.PlaytimeMinutesRemaining"]
	if f275_local2 then
		f275_arg0:subscribeToModel(f275_local2, function(model)
			local f276_local0 = model:get()
			if f276_local0 > 0 then
				local f276_local1 = nil
				for f276_local5, f276_local6 in ipairs(f275_local0) do
					if f276_local6 <= f276_local0 then
						break
					end
					f276_local1 = f276_local5
				end
				if f276_local1 and f276_local1 ~= f275_local1:get() then
					f276_local2 = f275_local0[f276_local1]
					if f275_local1:get() == 0 then
						f276_local2 = f276_local0
					end
					CoD.PCUtility.ShowGameEvent(Engine[0xF9F1239CFD921FE](0x2227542A63F7E17, f276_local2))
					f275_local1:set(f276_local1)
				end
			end
		end)
	end
end
CoD.PCUtility.InitCurrentCategoryModel = function(f277_arg0)
	CoD.PCOptionsUtility.GetCurrentCategoryModel(f277_arg0)
end
CoD.PCUtility.OverrideCustomSpacingOnList = function(f278_arg0, f278_arg1, f278_arg2)
	f278_arg0:setSpacing(f278_arg2)
end
CoD.PCUtility.KeyboardTextFieldFunctionality = function(f279_arg0, f279_arg1)
	local f279_local0, f279_local1, f279_local2, f279_local3 = f279_arg0:getLocalLeftRight()
	local f279_local4, f279_local5, f279_local6, f279_local7 = f279_arg0.inputContainer:getLocalLeftRight()
	f279_arg0.inputContainerWidth = f279_local3 - f279_local2 + f279_local7 - f279_local6
	local f279_local8, f279_local9, f279_local10, f279_local11 = f279_arg0.inputContainer:getLocalTopBottom()
	f279_arg0.inputContainerHeight = f279_local11 - f279_local10
	local f279_local12, f279_local13, f279_local14, f279_local15 = f279_arg0.inputContainer.inputText:getLocalLeftRight()
	f279_arg0.inputTextLeft = f279_local14
	f279_arg0:addElement(LUI.UITimer.new(50, {
		name = "ui_keyboard_update",
		controller = f279_arg1,
		overstrike = false,
	}, true, f279_arg0))
	f279_arg0:registerEventHandler("ui_keyboard_update", CoD.PCUtil.KeyboardTextFieldUpdate)
end
CoD.PCUtility.ResizeFooterTooltip = function(f280_arg0, f280_arg1)
	if not f280_arg0.label then
		return
	else
		local f280_local0, f280_local1 = f280_arg0.keyPrompt:getLocalSize()
		local f280_local2, f280_local3, f280_local4, f280_local5 = f280_arg0:getLocalLeftRight()
		local f280_local6, f280_local7, f280_local8, f280_local9 = f280_arg0.label:getLocalLeftRight()
		f280_arg0.keyPrompt:setLeftRight(f280_local2, f280_local3, f280_local5, f280_local5 + f280_local0)
		f280_arg0:setLeftRight(f280_local2, f280_local3, f280_local4, f280_local5 + f280_local8 + f280_local0)
		f280_arg0.bg:setLeftRight(f280_local2, f280_local3, f280_local4, f280_local5 + f280_local8 + f280_local0)
	end
end
CoD.PCUtility.SetupButtonPromptForPC = function(f281_arg0, f281_arg1, f281_arg2)
	f281_arg0:setHandleMouse(true)
	if f281_arg2 ~= nil then
		CoD.Menu.AddButtonCallbackFunction(f281_arg2, f281_arg0, f281_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu)
			if not CoD.Menu.SpinnerIsActive then
				local f282_local0, f282_local1 = nil
				local f282_local2 = element:getModel()
				if f282_local2 then
					f282_local0 = f282_local2.Button and f282_local2.Button:get()
					f282_local1 = f282_local2.KeyShortcut and f282_local2.KeyShortcut:get()
				end
				element:playClip("DefaultClip")
				CoD.PCUtil.SimulateButtonPressUsingElement(f281_arg2, element, f281_arg1, f282_local1 == "ui_confirm")
				return true
			else
			end
		end)
		CoD.Menu.AddButtonCallbackFunction(f281_arg2, f281_arg0, f281_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu)
			if not CoD.Menu.SpinnerIsActive then
				local f283_local0, f283_local1 = nil
				local f283_local2 = element:getModel()
				if f283_local2 then
					f283_local0 = f283_local2.Button and f283_local2.Button:get()
					f283_local1 = f283_local2.KeyShortcut and f283_local2.KeyShortcut:get()
				end
				element:playClip("DefaultClip")
				if f283_local0 == Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F] then
					return false
				else
					CoD.PCUtil.SimulateButtonPressUsingElement(f281_arg2, element, f281_arg1, f283_local1 == "ui_confirm")
					return true
				end
			else
			end
		end)
	end
	if f281_arg0.keyPrompt then
		f281_arg0.keyPrompt:linkToElementModel(f281_arg0, "Button", true, function(model)
			if model then
				CoD.PCUtility.ResizeButtonWithKeyPrompt(f281_arg0, f281_arg1)
			end
		end)
	end
	if f281_arg0.footerTooltip then
		f281_arg0.footerTooltip.keyPrompt:linkToElementModel(f281_arg0, "KeyShortcut", true, function(model)
			local f285_local0 = Engine[0x614D394F6F9A18D](model)
			if f285_local0 then
				if not Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f281_arg1), "KeyPressBits." .. f285_local0) then
					local f285_local1 = nil
					f285_local0 = "[{" .. f285_local0 .. "}]"
				elseif #f285_local0 > 1 then
					f285_local0 = Engine[0xF9F1239CFD921FE](0x819ABD75CBD7B59 .. f285_local0)
				end
				if f281_arg0.footerTooltip and f281_arg0.footerTooltip.keyPrompt then
					f281_arg0.footerTooltip.keyPrompt.keybind:setText(f285_local0)
				end
			end
		end)
		local f281_local0 = f281_arg0.footerTooltip.keyPrompt
		local f281_local1 = f281_local0
		f281_local0 = f281_local0.subscribeToModel
		local f281_local2 = DataSources.KeybindMessages.getModel(f281_arg1)
		f281_local0(f281_local1, f281_local2.isBindingKey, function(f286_arg0)
			f281_arg0.footerTooltip.keyPrompt.keybind:setText(f281_arg0.footerTooltip.keyPrompt.keybind:getText())
		end)
	end
end
CoD.PCUtility.RestrictButtonFooterTooltipToScreenSafe = function(f287_arg0, f287_arg1, f287_arg2, f287_arg3)
	local f287_local0 = function()
		if f287_arg1 then
			local f288_local0, f288_local1, f288_local2, f288_local3 = f287_arg3:getRect()
			local f288_local4, f288_local5, f288_local6, f288_local7 = Engine[0x695399A0E06EC35](f287_arg2, f287_arg1)
			if f288_local0 ~= nil then
				local f288_local8, f288_local9 = Engine[0x1A28BE9919661FA](f287_arg2)
				f288_local4 = f288_local4 * f288_local8 / (f288_local2 - f288_local0)
				f288_local6 = f288_local6 * f288_local8 / (f288_local2 - f288_local0)
				f288_local5 = f288_local5 * f288_local9 / (f288_local3 - f288_local1)
				f288_local7 = f288_local7 * f288_local9 / (f288_local3 - f288_local1)
				local f288_local10 = f287_arg1:getLocalSize()
				local f288_local11 = math.floor(f288_local8)
				local f288_local12 = 0
				if f288_local8 < f288_local4 + f288_local10 then
					f288_local12 = f288_local4 + f288_local10 - f288_local8
					local f288_local13, f288_local14, f288_local15, f288_local16 = f287_arg1:getLocalLeftRight()
					f287_arg1:setLeftRight(f288_local13, f288_local14, f288_local15 - f288_local12, f288_local16 - f288_local12)
				end
			end
		end
	end
	f287_arg0:appendEventHandler("gain_focus", function(f289_arg0, f289_arg1)
		if f287_arg3 then
			if f287_arg3.__adjustTooltipPositionOnFocusTimer then
				f287_arg3.__adjustTooltipPositionOnFocusTimer:close()
				f287_arg3.__adjustTooltipPositionOnFocusTimer = nil
			end
			f287_arg3.__adjustTooltipPositionOnFocusTimer = LUI.UITimer.newElementTimer(0, true, function()
				f287_arg3.__adjustTooltipPositionOnFocusTimer = nil
				f287_local0()
			end)
			f287_arg3:addElement(f287_arg3.__adjustTooltipPositionOnFocusTimer)
		end
	end)
end
CoD.PCUtility.ResizeButtonWithImageAndLabel = function(f291_arg0, f291_arg1, f291_arg2, f291_arg3)
	local f291_local0 = 4
	if not f291_arg0.label then
		return
	else
		local f291_local1, f291_local2, f291_local3, f291_local4 = f291_arg2:getLocalLeftRight()
		local f291_local5, f291_local6 = f291_arg2:getLocalSize()
		local f291_local7, f291_local8, f291_local9, f291_local10 = f291_arg0.label:getLocalLeftRight()
		local f291_local11 = f291_arg0.label:getTextWidth()
		local f291_local12 = f291_local3 + f291_local5 + f291_local0
		f291_arg0.label:setLeftRight(0, 0, f291_local12, f291_local12 + f291_local11)
		local f291_local13, f291_local14, f291_local15, f291_local16 = f291_arg0:getLocalLeftRight()
		f291_arg0:setLeftRight(f291_local13, f291_local14, f291_local15, f291_local15 + f291_local12 + f291_local11 + f291_local3 + (f291_arg3 or 0))
	end
end
CoD.PCUtility.UpscaleFooterLabelIfStringIcon = function(f292_arg0)
	local f292_local0, f292_local1, f292_local2, f292_local3 = f292_arg0:getLocalTopBottom()
	local f292_local4 = 0.6
	local f292_local5 = f292_local3 - f292_local2
	if string.find(f292_arg0:getText(), "BFOOTER") and f292_arg0.scaleDoneTest == nil then
		f292_arg0:setTopBottom(f292_local0, f292_local1, f292_local2 - f292_local5 * f292_local4, f292_local3 + f292_local5 * f292_local4)
		f292_arg0.scaleDoneTest = true
	end
end
CoD.PCUtility.YieldToolTipArea = function(f293_arg0, f293_arg1)
	f293_arg0.tooltipArea = f293_arg1
end
CoD.PCUtility.SetHandleMouse = function(f294_arg0, f294_arg1)
	f294_arg0:setHandleMouse(f294_arg1)
end
CoD.PCUtility.SetForceMouseEventDispatch = function(f295_arg0, f295_arg1)
	f295_arg0:setForceMouseEventDispatch(f295_arg1)
end
CoD.PCUtility.SetElementForceMouseEventDispatch = function(f296_arg0, f296_arg1)
	f296_arg0:setForceMouseEventDispatch(f296_arg1)
end
CoD.PCUtility.SetListOrGridAsAcceptingFocusToActiveElement = function(f297_arg0)
	if not CoD.isPC then
		return
	else
		f297_arg0.__focusNavigationElementCallback = function(f298_arg0)
			if f298_arg0.activeWidget and f298_arg0.activeWidget:isFocusable() then
				return f298_arg0.activeWidget
			else
				return nil
			end
		end
	end
end
CoD.PCUtility.DisableKeyboardNavigationInMenu = function(f299_arg0)
	f299_arg0.disableKeyboardNavigation = true
end
CoD.PCUtility.SetAsRedirectItem = function(f300_arg0)
	f300_arg0.m_mouseDisabled = true
	f300_arg0.m_disableKeyboardNavigation = true
	f300_arg0.__isKeyboardnavigationRedirect = true
end
CoD.PCUtility.ActivateListPCSelectionBehavior = function(f301_arg0)
	f301_arg0.__enablePCListSelectionBehavior = true
end
CoD.PCUtility.IsBGSEnabled = function()
	return Engine[0x9CCDC21D9493A84]()
end
CoD.PCUtility.FriendRequestPopup = function(f303_arg0, f303_arg1, f303_arg2)
	local f303_local0 = function()
		if f303_arg0.FriendRequestPopup and f303_arg0.FriendRequestPopup.FriendName then
			f303_arg0.FriendRequestPopup.FriendName.FriendName:setText(CoD.SocialUtility.CleanGamerTag(f303_arg2))
			f303_arg0.FriendRequestPopup.RequestSentText:setText(Engine[0xF9F1239CFD921FE](0x1AE94021C967D51))
			f303_arg0.FriendRequestPopup:playClip("FriendRequestSent")
		end
	end
	local f303_local1 = function()
		if f303_arg0.FriendRequestPopup and f303_arg0.FriendRequestPopup.FriendName then
			f303_arg0.FriendRequestPopup.FriendName.FriendName:setText("")
			f303_arg0.FriendRequestPopup.RequestSentText:setText(Engine[0xF9F1239CFD921FE](0x8972DCD4EB4DF61))
			f303_arg0.FriendRequestPopup:playClip("InvalidFriendRequestSent")
		end
	end
	if string.find(f303_arg2, "#") or string.find(f303_arg2, "@") then
		f303_local0()
	else
		f303_local1()
	end
end
CoD.PCUtility.SetupSocialAddFriendEditControl = function(f306_arg0, f306_arg1, f306_arg2, f306_arg3)
	CoD.PCUtility.SetupEditControlWithControllerModel(f306_arg0, f306_arg1, f306_arg2, f306_arg3)
	f306_arg0:appendEventHandler("textbox_editdone", function(f307_arg0, f307_arg1)
		if f307_arg1.validinput and not f307_arg1.canceled then
			CoD.PCUtility.SocialAddFriend(f307_arg0:getParent(), f306_arg1, f306_arg3)
		end
	end)
end
CoD.PCUtility.SocialAddFriend = function(f308_arg0, f308_arg1, f308_arg2)
	local f308_local0 = Engine[0x4DF5CFBC1771947](f308_arg1)
	f308_local0 = f308_local0[f308_arg2]
	local f308_local1 = f308_local0:get()
	if f308_local1 ~= "" then
		local f308_local2, f308_local3 = string.find(f308_local1, "@")
		Engine[0x7668C12403745AC](f308_local1, f308_local2 ~= nil)
		CoD.PCUtility.FriendRequestPopup(f308_arg0, f308_arg1, f308_local1)
	end
	f308_local0:set("")
end
CoD.PCUtility.SocialAddFriendWithElement = function(f309_arg0, f309_arg1, f309_arg2)
	CoD.PCUtility.SocialAddFriend(f309_arg0, f309_arg1, f309_arg2)
end
CoD.PCUtility.CloseFriendPopupOnClipOver = function(f310_arg0, f310_arg1)
	f310_arg0:appendEventHandler("clip_over", function(f311_arg0, f311_arg1)
		if not f311_arg0.nextClip and f311_arg0.__lastClipPlayedName and f311_arg0.__lastClipPlayedName == "FriendRequestSent" and not CoD.ModelUtility.IsControllerModelValueNonEmptyString(f310_arg1, "EditBoxGlobal.BattlenetAddFriend") then
			CoD.PCBattlenetUtility.ToggleBattlenetAddFriendMenuVisibility(f310_arg1)
		end
	end)
end
CoD.PCUtility.AcceptFriendRequest = function(f312_arg0, f312_arg1)
	local f312_local0 = f312_arg0:getModel()
	if f312_local0.requestIndex ~= nil then
		CoD.PCUtility.AcceptFriendRequestWrapper(f312_local0.requestIndex:get())
	end
end
CoD.PCUtility.AcceptFriendRequestWrapper = function(f313_arg0)
	local f313_local0 = Engine[0x558E88FD7072266](f313_arg0)
	if f313_local0 then
		CoD.PCUtility.ShowGameEvent(Engine[0xF9F1239CFD921FE](0x93668A760B1CB97, CoD.PCBattlenetUtility.StripBattleTagNumber(f313_local0)))
	else
		CoD.PCUtility.ShowGameEvent(Engine[0xF9F1239CFD921FE](0x3F4A6D642604E19))
	end
end
CoD.PCUtility.ShowPlayerKickGameEvent = function(f314_arg0)
	local f314_local0 = Engine[0x1FB3481C8114A9A](f314_arg0)
	if f314_local0 and f314_local0 ~= "" then
		CoD.PCUtility.ShowGameEvent(Engine[0xF9F1239CFD921FE](0x5F3D04EDD02F7C0, CoD.PCBattlenetUtility.StripBattleTagNumber(f314_local0)))
	else
		CoD.PCUtility.ShowGameEventFromEnum(CoD.PCUtility.GameEventStrings.PARTY_PLAYER_KICKED)
	end
end
CoD.PCUtility.IsTrackingFriends = function()
	return Engine[0x660D433D226C4B5]()
end
CoD.PCUtility.StartTrackingFriendUpdate = function(f316_arg0, f316_arg1)
	if not CoD.PCUtility.IsTrackingFriends() then
		Engine[0xEAE31B1644BF1F7]()
	end
end
CoD.PCUtility.StopTrackingFriendUpdate = function()
	Engine[0x9B4361D8A71A9B5]()
end
CoD.PCUtility.IgnoreFriendRequest = function(f318_arg0, f318_arg1)
	local f318_local0 = f318_arg0:getModel()
	if f318_local0.requestIndex ~= nil then
		Engine[0x1AE51B8C2493C18](f318_local0.requestIndex:get())
	end
end
CoD.PCUtility.RemoveFriend = function(f319_arg0, f319_arg1)
	local f319_local0 = f319_arg0:getModel()
	if f319_local0.identityBadge and f319_local0.identityBadge.xuid ~= nil then
		Engine[0xADC882994DEE8E5](f319_local0.identityBadge.xuid:get())
	end
end
CoD.PCUtility.RevokeSentFriendRequest = function(f320_arg0, f320_arg1)
	local f320_local0 = f320_arg0:getModel()
	if f320_local0.requestIndex ~= nil then
		Engine[0x31187BBD4D74E1A](f320_local0.requestIndex:get())
	end
end
CoD.PCUtility.SetFilterUsingControllerModel = function(f321_arg0, f321_arg1, f321_arg2, f321_arg3, f321_arg4, f321_arg5, f321_arg6)
	CoD.BaseUtility.InitControllerModelIfNotSet(f321_arg1, f321_arg4, f321_arg5 or "")
	if f321_arg6 ~= "0" then
		local f321_local0 = f321_arg6
	end
	local f321_local1 = f321_local0 or nil
	local f321_local2 = f321_arg0[f321_arg2]
	if not f321_local2.isGridLayout then
		f321_local2 = f321_local2.ScrollView.View
	end
	f321_local2:setFilter(function(f322_arg0)
		local f322_local0 = Engine[0x4DF5CFBC1771947](f321_arg1)
		f322_local0 = f322_local0[f321_arg4]
		local f322_local1 = f322_arg0[f321_arg3]
		if f322_local0 and f322_local0:get() and f322_local1 and f322_local1:get() then
			local f322_local2 = string.find
			local f322_local3 = f322_local1:get()
			f322_local3 = f322_local3:lower()
			local f322_local4 = f322_local0:get()
			f322_local2, f322_local3 = f322_local2(f322_local3, f322_local4:lower(), 1, true)
			if (f321_local1 ~= nil or f322_local2 == nil) and f322_local2 ~= 1 then
				f322_local4 = false
			else
				f322_local4 = true
			end
			return f322_local4
		else
			return true
		end
	end)
	local f321_local3 = f321_arg0
	local f321_local4 = f321_arg0.subscribeToModel
	local f321_local5 = Engine[0x4DF5CFBC1771947](f321_arg1)
	f321_local4(f321_local3, f321_local5[f321_arg4], function(f323_arg0)
		f321_local2:updateDataSource(true)
	end, false)
end
CoD.PCUtility.SetLoadoutKeypadShortcut = function(f324_arg0, f324_arg1, f324_arg2, f324_arg3)
	for f324_local0 = 1, 5, 1 do
		local f324_local3 = f324_local0
		local f324_local4 = f324_arg1
		local f324_local5 = f324_arg1.subscribeToModel
		local f324_local6 = Engine[0x4DF5CFBC1771947](f324_arg2)
		f324_local5(f324_local4, f324_local6["KeyPressBits." .. f324_local3], function(f325_arg0)
			if CoD.Menu.CanProcessPCKeyPress(f324_arg0, f325_arg0, f324_arg2) then
				CoD.CACUtility.SetCustomClassFromButtonPrompt(f324_arg0, f324_arg2, f324_arg1, f324_local3 - 1)
				CoD.CACUtility.SetActiveListItemToSelectedClass(f324_arg2, f324_arg0, f324_arg3)
			end
		end, false)
	end
end
CoD.PCUtility.SetupEditControlWithControllerModel = function(f326_arg0, f326_arg1, f326_arg2, f326_arg3)
	local f326_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f326_arg1), f326_arg3)
	if f326_local0:get() == nil then
		f326_local0:set("")
	end
	CoD.PCUtility.SetupEditControlWithModel(f326_arg0, f326_arg1, f326_arg2, f326_local0)
end
CoD.PCUtility.SetupElementEditControlWithControllerModel = function(f327_arg0, f327_arg1, f327_arg2, f327_arg3)
	local f327_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f327_arg1), f327_arg3)
	if f327_local0:get() == nil then
		f327_local0:set("")
	end
	CoD.PCUtility.SetupEditControlWithModel(f327_arg0, f327_arg1, f327_arg2, f327_local0)
end
CoD.PCUtility.SetupEditControlWithGlobalModel = function(f328_arg0, f328_arg1, f328_arg2, f328_arg3)
	local f328_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f328_arg3)
	if f328_local0:get() == nil then
		f328_local0:set("")
	end
	CoD.PCUtility.SetupEditControlWithModel(f328_arg0, f328_arg1, f328_arg2, f328_local0)
end
CoD.PCUtility.SetupEditControlWithGlobalModelAndCallback = function(f329_arg0, f329_arg1, f329_arg2, f329_arg3, f329_arg4)
	local f329_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f329_arg3)
	if f329_local0:get() == nil then
		f329_local0:set("")
	end
	local f329_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f329_arg4)
	CoD.PCUtility.SetupEditControlWithModel(f329_arg0, f329_arg1, f329_arg2, f329_local0, f329_local1:get())
end
CoD.PCUtility.SetupEditClanTagWithControllerModelAndCallback = function(f330_arg0, f330_arg1, f330_arg2, f330_arg3)
	local f330_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f330_arg1), f330_arg3)
	if f330_local0:get() == nil then
		f330_local0:set("")
	end
	CoD.PCUtility.SetupEditControlWithModel(f330_arg0, f330_arg1, f330_arg2, f330_local0, function(f331_arg0, f331_arg1, f331_arg2)
		if not f331_arg2.canceled and f331_arg2.name == "textbox_editdone" then
			local f331_local0 = f331_arg0:get()
			if not Engine[0xE3FC4BECF450A06](f330_arg1, f331_local0, Enum[0x85FCE2AA5391A7C][0xA542EE0A79EAA41]) then
				Engine[0xAD99866B0C8E1](f330_arg1, f331_local0)
			end
		end
		f331_arg0:set("")
	end)
end
CoD.PCUtility.SetupEditControlChat = function(f332_arg0, f332_arg1, f332_arg2, f332_arg3)
	local f332_local0 = CoD.ChatClientUtility.GetStaticChatAllowedModel(f332_arg1)
	f332_local0:set(true)
	f332_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f332_arg1), f332_arg3)
	if f332_local0:get() == nil then
		f332_local0:set("")
	end
	if CoD.isFrontend then
		f332_arg0:subscribeToModel(CoD.ChatClientUtility.GetCurrentChattingModel(f332_arg1), function(model, f333_arg1)
			if model and model:get() then
				local f333_local0 = f333_arg1:getMenu() or f332_arg2
				if f333_local0 and f333_local0.occludedBy == nil and f333_local0.currentInputFocus ~= f333_arg1 then
					f333_local0:ChangeInputFocus(f332_arg1, f333_arg1)
				end
			end
		end)
	else
		f332_arg0:subscribeToModel(CoD.ChatClientUtility.GetCurrentChattingModel(f332_arg1), function(model, f334_arg1)
			if model then
				local f334_local0 = f334_arg1:getMenu() or f332_arg2
				if model:get() then
					if not CoD.PCWidgetUtility.CanShowMenuStyleChat(f332_arg1) then
						SetAllowCursorMovement(f334_local0, true)
						if CoD.isZombie and f334_local0.m_inputDisabled then
							f334_local0.m_inputDisabled = false
							f334_local0.__inputDisabledBypassedByChat = true
						end
						if CoD.isWarzone and f334_local0.__ignoreContextualMenu then
							f334_local0.__ignoreContextualMenu = false
							f334_local0.__ignoreContextualMenuBypassedByChat = true
						end
					end
					if f334_local0 and f334_local0.occludedBy == nil and f334_local0.currentInputFocus ~= f334_arg1 then
						f334_local0:ChangeInputFocus(f332_arg1, f334_arg1)
					end
				else
					if not CoD.PCWidgetUtility.CanShowMenuStyleChat(f332_arg1) then
						SetAllowCursorMovement(f334_local0, false)
						if CoD.isZombie and f334_local0.__inputDisabledBypassedByChat then
							f334_local0.m_inputDisabled = true
							f334_local0.__inputDisabledBypassedByChat = nil
						end
						if CoD.isWarzone and f334_local0.__ignoreContextualMenuBypassedByChat then
							f334_local0.__ignoreContextualMenu = true
							f334_local0.__ignoreContextualMenuBypassedByChat = nil
						end
					end
					CoD.PCWidgetUtility.CloseContextualMenu(f334_local0, f332_arg1)
				end
			end
		end)
	end
	CoD.BaseUtility.InitControllerModelIfNotSet(f332_arg1, "EditBoxGlobal.CurrentChatTextRealTime", "")
	CoD.PCUtility.SetupEditControlWithModel(f332_arg0, f332_arg1, f332_arg2, f332_local0, nil, function(f335_arg0, f335_arg1)
		local f335_local0 = false
		local f335_local1 = false
		local f335_local2 = false
		if f335_arg1.canceled then
			f335_local0 = true
			f335_local1 = true
		else
			f335_local0, f335_local1, f335_local2 = CoD.ChatClientUtility.TrySendLine(f332_arg1, f335_arg1.finalvalue)
		end
		if f335_local0 then
			local f335_local3 = Engine[0x7272CF98D12ADE1](f332_arg1)
			Engine[0xD806200988BA3EB](f332_arg1)
			if f335_local3 then
				local f335_local4 = CoD.ChatClientUtility.GetEventModel(f332_arg1)
				f335_local4:set("textInputEnd")
				Engine[0x6A489878620F3BC](CoD.ChatClientUtility.GetEventModel(f332_arg1))
				assert(f335_arg1.finalvalue ~= nil)
				f332_local0:set("")
				f332_arg0.TextBox:setText("")
			end
			if f335_local2 or not CoD.PCWidgetUtility.CanShowMenuStyleChat(f332_arg1) then
				local f335_local4 = CoD.ChatClientUtility.GetCurrentChattingModel(f332_arg1)
				f335_local4:set(false)
			end
			local f335_local4 = f332_arg0:getMenu()
			f335_local4:ChangeInputFocus(f332_arg1, nil)
		elseif f335_local1 then
			f332_local0:set("")
			f332_arg0.TextBox:setText("")
			Engine[0xDB3C4FD727ED616](f332_arg1)
		end
	end)
	CoD.PCUtility.MakeEditBoxRealTime(f332_arg0, "EditBoxGlobal.CurrentChatTextRealTime")
end
CoD.PCUtility.SetupEditControlWithModel = function(f336_arg0, f336_arg1, f336_arg2, f336_arg3, f336_arg4, f336_arg5, f336_arg6)
	local f336_local0 = function(f337_arg0)
		local f337_local0 = f337_arg0:get()
		if f336_arg6 then
			f337_local0 = string.gsub(f337_local0, ".", "*")
		end
		f336_arg0.TextBox:setText(f337_local0)
	end
	f336_local0(f336_arg3)
	if f336_arg0.__editControlModelSubscription then
		f336_arg0:removeSubscription(f336_arg0.__editControlModelSubscription)
		f336_arg0.__editControlModelSubscription = nil
	end
	f336_arg0.__editControlModelSubscription = f336_arg0:subscribeToModel(f336_arg3, f336_local0)
	f336_arg0.__onEditClose = function(f338_arg0)
		if Engine[0x7272CF98D12ADE1](f336_arg1) and f336_arg2.currentInputFocus == f338_arg0 then
			Engine[0xD806200988BA3EB](f336_arg1)
		end
		if not CoD.isFrontend and not CoD.PCWidgetUtility.CanShowMenuStyleChat(f336_arg1) then
			local f338_local0 = CoD.ChatClientUtility.GetCurrentChattingModel(f336_arg1)
			if f338_local0:get() then
				f338_local0:set(false)
			end
		end
		if f338_arg0.__editControlModelSubscription then
			f338_arg0:removeSubscription(f336_arg3)
			f338_arg0.__editControlModelSubscription = nil
		end
	end
	LUI.OverrideFunction_CallOriginalSecond(f336_arg0, "close", f336_arg0.__onEditClose)
	CoD.Menu.AddButtonCallbackFunction(f336_arg2, f336_arg0, f336_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_confirm", function(element, menu)
		f336_arg2:ChangeInputFocus(f336_arg1, element)
		return true
	end)
	f336_arg0.__editboxGainInputFocus = function(f340_arg0, f340_arg1)
		f340_arg0.super:gainInputFocus(f340_arg1)
		Engine[0x75723E517F6CE67](f336_arg1, f340_arg0, f340_arg0.TextBox, f336_arg3:get(), f340_arg0.__editControlMaxChar, true)
		if f336_arg6 then
			Engine[0x439F7B5E8CFCEA9](f336_arg1)
		elseif f340_arg0.__editControlNumerical then
			local f340_local0
			if f340_arg0.__editControlIsInteger == nil or f340_arg0.__editControlIsInteger ~= true then
				f340_local0 = false
			else
				f340_local0 = true
			end
			local f340_local1 = tonumber(f336_arg3:get())
			local f340_local2 = 0
			if f340_arg0.__editControlMaxChar ~= nil then
				f340_local2 = f340_arg0.__editControlMaxChar
			end
			Engine[0xA0D0734CB6CC146](f336_arg1, f340_arg0.__editControlMin, f340_arg0.__editControlMax, LUI.clamp(f340_local1 or f340_arg0.__editControlMin, f340_arg0.__editControlMin, f340_arg0.__editControlMax), f340_local0)
		elseif f340_arg0.__editControlChat then
			Engine[0xD5BDC7FB6DC8F6](f336_arg1, f340_arg0.__editControlMaxPixelWidth, f340_arg0.__editControlScrollStep)
			local f340_local0 = CoD.ChatClientUtility.GetEventModel(f336_arg1)
			f340_local0:set("textInputStart")
			Engine[0x6A489878620F3BC](CoD.ChatClientUtility.GetEventModel(f336_arg1))
			if not CoD.isFrontend and not CoD.PCWidgetUtility.CanShowMenuStyleChat(f336_arg1) then
				Engine[0x10BF7D7C03EECE6](f336_arg1, true, Enum[0x9061B48916076D5][0x2334BDF2E4222EA])
			end
		elseif f340_arg0.__editControlMaxPixelWidth and f340_arg0.__editControlScrollStep then
			local f340_local0 = f340_arg0.__editControlDefaultXOffset
			if not f340_local0 then
				f340_local0 = 0
			end
			f340_arg0.__editControlDefaultXOffset = f340_local0
			Engine[0xF806830BC57FC8A](f336_arg1, f340_arg0.__editControlDefaultXOffset, f340_arg0.__editControlMaxPixelWidth, f340_arg0.__editControlScrollStep)
		elseif f340_arg0.__editControlDefaultXOffset then
			Engine[0xAC471719670AFC4](f336_arg1, f340_arg0.__editControlDefaultXOffset)
		end
		if f340_arg0.__realTimeModelName then
			Engine[0xE01391D44D50DA](f336_arg1, f340_arg0.__realTimeModelName)
		end
		return true
	end
	f336_arg0.__editboxLoseInputFocus = function(f341_arg0, f341_arg1)
		local f341_local0 = Engine[0x7272CF98D12ADE1](f336_arg1)
		local f341_local1 = Engine[0xD806200988BA3EB](f336_arg1)
		if f341_local0 then
			if f341_arg0.__editControlChat then
				f336_arg3:set("")
				f336_local0(f336_arg3)
				local f341_local2 = CoD.ChatClientUtility.GetEventModel(f336_arg1)
				f341_local2:set("textInputEnd")
				Engine[0x6A489878620F3BC](CoD.ChatClientUtility.GetEventModel(f336_arg1))
			else
				f336_arg3:set(f341_local1)
				f336_local0(f336_arg3)
			end
			if f336_arg4 ~= nil then
				f336_arg4(f336_arg3, "loseInputFocus", f341_arg1)
			end
		end
		f341_arg0.super:loseInputFocus(f341_arg1)
		return true
	end
	f336_arg0:registerEventHandler("gain_input_focus", f336_arg0.__editboxGainInputFocus)
	f336_arg0:registerEventHandler("lose_input_focus", f336_arg0.__editboxLoseInputFocus)
	if f336_arg5 == nil then
		f336_arg5 = function(f342_arg0, f342_arg1)
			local f342_local0 = Engine[0x7272CF98D12ADE1](f336_arg1)
			local f342_local1 = Engine[0xD806200988BA3EB](f336_arg1)
			if f342_local0 then
				assert(f342_local1 ~= nil)
				f336_arg3:set(f342_local1)
				f336_local0(f336_arg3)
				if f336_arg4 ~= nil then
					f336_arg4(f336_arg3, "textbox_editdone", f342_arg1)
				end
			end
			local f342_local2 = CoD.ChatClientUtility.GetCurrentChattingModel(f336_arg1)
			f342_local2:set(false)
			f342_local2 = f336_arg0:getMenu()
			f342_local2:ChangeInputFocus(f336_arg1, nil)
		end
	end
	f336_arg0:registerEventHandler("textbox_editdone", f336_arg5)
end
CoD.PCUtility.StickyElements = {}
CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner = nil
CoD.PCUtility.StartAddingSticky = function(f343_arg0, f343_arg1)
	assert(CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner == nil)
	CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner = f343_arg1
	CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner.callbacks = {}
end
CoD.PCUtility.StopAddingSticky = function(f344_arg0)
	CoD.PCUtility.StickyElements.currentStickyButtonCallbacksOwner = nil
end
CoD.PCUtility.RegisterStickyElement = function(f345_arg0, f345_arg1, f345_arg2, f345_arg3)
	table.insert(CoD.PCUtility.StickyElements, {
		element = f345_arg0,
		parents = {
			f345_arg1,
		},
		allowModel = f345_arg2,
		menusToAvoid = f345_arg3,
	})
	LUI.OverrideFunction_CallOriginalFirst(f345_arg0, "close", function(element)
		for f346_local3, f346_local4 in ipairs(CoD.PCUtility.StickyElements) do
			if f346_local4.element == element then
				table.remove(CoD.PCUtility.StickyElements, f346_local3)
				break
			end
		end
	end)
end
CoD.PCUtility.SetupPositionOverrideForWZEndGame = function(f347_arg0) end
CoD.PCUtility.MigrationProhibitedMenus = {
	"DirectorDiaDeLosMuertosPopup",
	"DiaDeLosMuertosRedemptionPopup",
}
CoD.PCUtility.MigrateStickyElementsForward = function(f348_arg0, f348_arg1)
	if LuaUtils.FindItemInArray(CoD.PCUtility.MigrationProhibitedMenus, f348_arg0.menuName, function(f349_arg0, f349_arg1)
		return f349_arg0 == f349_arg1
	end) then
		return
	end
	for f348_local9, f348_local10 in ipairs(CoD.PCUtility.StickyElements) do
		local f348_local11 = f348_local10.parents[#f348_local10.parents]
		if f348_local10.element ~= nil and f348_arg0 ~= f348_local11 then
			if f348_local10.allowModel and f348_local10.menusToAvoid then
				if LuaUtils.FindItemInArray(f348_local10.menusToAvoid, f348_arg0.menuName, function(f350_arg0, f350_arg1)
					return f350_arg0 == f350_arg1
				end) then
					f348_local10.allowModel:set(false)
				else
					f348_local10.allowModel:set(true)
				end
			end
			if f348_local10.element.callbacks then
				for f348_local7, f348_local8 in ipairs(f348_local10.element.callbacks) do
					if f348_local8.menu == f348_local11 then
						local f348_local6 = f348_local8.element
						if f348_local8.elementIsMenu then
							f348_local6 = f348_arg0
						end
						CoD.Menu.AddButtonCallbackFunction(f348_arg0, f348_local6, f348_local8.controller, f348_local8.luiButton, f348_local8.pcKey, f348_local8.func, f348_local8.conditionFunc, f348_local8.showDisabled)
					end
				end
			end
			local f348_local3 = f348_local10.element:getParent()
			if #f348_local10.parents ~= 1 then
				f348_local11[f348_local10.element.id] = nil
			end
			local f348_local4 = nil
			if f348_local3 then
				if f348_local3.__focusableElementPaths then
					local f348_local5 = LuaUtils.FindItemInArray(f348_local3.__focusableElementPaths, f348_local10.element.id, function(f351_arg0, f351_arg1)
						return f351_arg0 == f351_arg1.id
					end)
					if f348_local5 then
						f348_local4 = f348_local3.__focusableElementPaths[f348_local5]
						table.remove(f348_local3.__focusableElementPaths, f348_local5)
					end
				end
				f348_local3:removeElement(f348_local10.element)
			end
			f348_local10.parents[#f348_local10.parents + 1] = f348_arg0
			f348_arg0:addElement(f348_local10.element)
			f348_arg0[f348_local10.element.id] = f348_local10.element
			if not f348_local4 then
				f348_local10.element:processEvent({
					name = "update_state",
					controller = f348_arg1,
					menu = f348_arg0,
					forceDispatch = true,
				})
			else
				f348_arg0:AppendPrecreatedIdStack(f348_local4)
			end
			if f348_local10.element.__onMigration then
				f348_local10.element:__onMigration(f348_local3, f348_arg0)
			end
		end
	end
end
CoD.PCUtility.PushStickyElementsBeforeSiblings = function(f352_arg0, f352_arg1)
	if LuaUtils.FindItemInArray(CoD.PCUtility.MigrationProhibitedMenus, f352_arg0.menuName, function(f353_arg0, f353_arg1)
		return f353_arg0 == f353_arg1
	end) then
		return
	end
	for f352_local6, f352_local7 in ipairs(CoD.PCUtility.StickyElements) do
		if f352_local7.element ~= nil then
			if f352_local7.allowModel and f352_local7.menusToAvoid then
				if LuaUtils.FindItemInArray(f352_local7.menusToAvoid, f352_arg0.menuName, function(f354_arg0, f354_arg1)
					return f354_arg0 == f354_arg1
				end) then
					f352_local7.allowModel:set(false)
				else
					f352_local7.allowModel:set(true)
				end
			end
			local f352_local3 = f352_local7.element:getParent()
			local f352_local4 = nil
			if f352_local3 and f352_local3.__focusableElementPaths then
				local f352_local5 = LuaUtils.FindItemInArray(f352_local3.__focusableElementPaths, f352_local7.element.id, function(f355_arg0, f355_arg1)
					return f355_arg0 == f355_arg1.id
				end)
				if f352_local5 then
					f352_local4 = f352_local3.__focusableElementPaths[f352_local5]
					table.remove(f352_local3.__focusableElementPaths, f352_local5)
					table.insert(f352_local3.__focusableElementPaths, 1, f352_local4)
				end
			end
		end
	end
end
CoD.PCUtility.MigrateStickyElementsBackwardFromStack = function(f356_arg0, f356_arg1)
	if f356_arg0 == nil or LuaUtils.FindItemInArray(CoD.PCUtility.MigrationProhibitedMenus, f356_arg0.menuName, function(f357_arg0, f357_arg1)
		return f357_arg0 == f357_arg1
	end) then
		return
	end
	for f356_local7, f356_local8 in ipairs(CoD.PCUtility.StickyElements) do
		local f356_local3 = -1
		for f356_local4, f356_local5 in ipairs(f356_local8.parents) do
			if f356_local5 == f356_arg0 then
			else
			end
			while f356_local4 <= #f356_local8.parents and f356_local3 ~= #f356_local8.parents do
				f356_local3 = #f356_local8.parents
				CoD.PCUtility.MigrateSingleStickyElementsBackward(f356_local8.parents[#f356_local8.parents], f356_local8, f356_arg1)
			end
		end
	end
end
CoD.PCUtility.MigrateSingleStickyElementsBackward = function(f358_arg0, f358_arg1, f358_arg2)
	if f358_arg0 == nil or LuaUtils.FindItemInArray(CoD.PCUtility.MigrationProhibitedMenus, f358_arg0.menuName, function(f359_arg0, f359_arg1)
		return f359_arg0 == f359_arg1
	end) then
		return
	elseif f358_arg1.element ~= nil and f358_arg0 == f358_arg1.parents[#f358_arg1.parents] and #f358_arg1.parents > 1 then
		f358_arg0[f358_arg1.element.id] = nil
		local f358_local0 = f358_arg1.element:getParent()
		if f358_arg0 ~= f358_local0 then
			f358_arg0[f358_arg1.element.id] = nil
		else
			f358_local0[f358_arg1.element.id] = nil
		end
		local f358_local1 = nil
		if f358_local0 then
			if f358_local0.__focusableElementPaths then
				local f358_local2 = LuaUtils.FindItemInArray(f358_local0.__focusableElementPaths, f358_arg1.element.id, function(f360_arg0, f360_arg1)
					return f360_arg0 == f360_arg1.id
				end)
				if f358_local2 then
					f358_local1 = f358_local0.__focusableElementPaths[f358_local2]
					table.remove(f358_local0.__focusableElementPaths, f358_local2)
				end
			end
			f358_local0:removeElement(f358_arg1.element)
		end
		f358_arg1.parents[#f358_arg1.parents] = nil
		local f358_local2 = f358_arg1.parents[#f358_arg1.parents]
		f358_local2:addElement(f358_arg1.element)
		f358_local2[f358_arg1.element.id] = f358_arg1.element
		if f358_arg1.allowModel and f358_arg1.menusToAvoid then
			if LuaUtils.FindItemInArray(f358_arg1.menusToAvoid, f358_local2.menuName, function(f361_arg0, f361_arg1)
				return f361_arg0 == f361_arg1
			end) then
				f358_arg1.allowModel:set(false)
			else
				f358_arg1.allowModel:set(true)
			end
		end
		if not f358_local1 then
			f358_arg1.element:processEvent({
				name = "update_state",
				controller = f358_arg2,
				menu = f358_local2,
				forceDispatch = true,
			})
		else
			f358_local2:AppendPrecreatedIdStack(f358_local1)
		end
		if f358_arg1.element.__onMigration then
			f358_arg1.element:__onMigration(f358_local0, f358_local2)
		end
	end
end
CoD.PCUtility.MigrateStickyElementsBackward = function(f362_arg0, f362_arg1)
	for f362_local3, f362_local4 in ipairs(CoD.PCUtility.StickyElements) do
		CoD.PCUtility.MigrateSingleStickyElementsBackward(f362_arg0, f362_local4, f362_arg1)
	end
end
CoD.PCUtility.HasStickyParent = function(f363_arg0, f363_arg1)
	local f363_local0 = false
	if CoD.isPC and IsGamepad(f363_arg1) then
		local f363_local1 = f363_arg0:getParent()
		while f363_local1 ~= nil and f363_local1 ~= f363_arg0:getMenu() do
			if LuaUtils.FindItemInArray(CoD.PCUtility.StickyElements, f363_local1.id, function(f364_arg0, f364_arg1)
				return f364_arg0 == f364_arg1.element.id
			end) then
				f363_local0 = true
				break
			end
			f363_local1 = f363_local1:getParent()
		end
	end
	return f363_local0
end
CoD.PCUtility.MakeEditControlNumerical = function(f365_arg0, f365_arg1, f365_arg2, f365_arg3, f365_arg4)
	f365_arg0.__editControlNumerical = true
	if f365_arg1 <= f365_arg2 then
		f365_arg0.__editControlMin = f365_arg1
		f365_arg0.__editControlMax = f365_arg2
	else
		f365_arg0.__editControlMin = f365_arg2
		f365_arg0.__editControlMax = f365_arg1
	end
	f365_arg0.__editControlIsInteger = f365_arg3 == true
	f365_arg0.__editControlMaxChar = f365_arg4
end
CoD.PCUtility.GetChatChannelName_Internal = function(f366_arg0, f366_arg1, f366_arg2)
	if Engine[0x7272CF98D12ADE1](f366_arg0) and Engine[0x89364092E497C4D](f366_arg0) then
		return Engine[0xE09A39AE156EB71](f366_arg1)
	elseif f366_arg2 and Engine[0x7B48C1ABFF0F764]() then
		return ""
	else
		return Engine[0xE09A39AE156EB71](f366_arg1)
	end
end
CoD.PCUtility.FlashWindowDefault = function()
	Engine[0xC487F6F3339B8B9](5, 0, 3)
end
CoD.PCUtility.ChatChannelNameFromChatId = function(f368_arg0, f368_arg1, f368_arg2)
	local f368_local0 = CoD.PCUtility.GetChatChannelName_Internal(f368_arg1, f368_arg2, f368_arg0)
	if string.len(f368_local0) > 0 then
		f368_local0 = f368_local0 .. ": "
	end
	return f368_local0
end
CoD.PCUtility.MakeEditControlChat = function(f369_arg0, f369_arg1, f369_arg2, f369_arg3)
	f369_arg0.__editControlChat = true
	CoD.PCUtility.SetEditBoxScrollingSteps(f369_arg0, 0, f369_arg2, f369_arg3)
end
CoD.PCUtility.MakeEditBoxRealTime = function(f370_arg0, f370_arg1)
	f370_arg0.__realTimeModelName = f370_arg1
end
CoD.PCUtility.MakeElementEditBoxRealtime = function(f371_arg0, f371_arg1)
	f371_arg0.__realTimeModelName = f371_arg1
end
CoD.PCUtility.SetEditBoxMaxChar = function(f372_arg0, f372_arg1)
	f372_arg0.__editControlMaxChar = f372_arg1
end
CoD.PCUtility.SetElementEditBoxMaxChar = function(f373_arg0, f373_arg1)
	f373_arg0.__editControlMaxChar = f373_arg1
end
CoD.PCUtility.SetEditBoxDefaultXOffset = function(f374_arg0, f374_arg1)
	f374_arg0.__editControlDefaultXOffset = f374_arg1
end
CoD.PCUtility.SetEditBoxScrollingSteps = function(f375_arg0, f375_arg1, f375_arg2, f375_arg3)
	assert(f375_arg2 > 0)
	assert(f375_arg3 >= 0)
	f375_arg0.__editControlDefaultXOffset = f375_arg1
	f375_arg0.__editControlMaxPixelWidth = f375_arg2
	f375_arg0.__editControlScrollStep = f375_arg3
end
CoD.PCUtility.ChatClientInputTextFieldUpdatePrompt = function(f376_arg0, f376_arg1, f376_arg2)
	local f376_local0 = CoD.ChatClientUtility.GetInputTextModel(f376_arg2)
	if Engine[0x7272CF98D12ADE1](f376_arg2) and Engine[0x89364092E497C4D](f376_arg2) then
		local f376_local1 = CoD.ChatClientUtility.GetInputChannelModel(f376_arg2)
		local f376_local2 = f376_local1:get()
		if f376_local2 ~= nil and f376_local2 ~= "" then
			local f376_local3 = Engine[0xE09A39AE156EB71](f376_local2)
			local f376_local4 = CoD.ChatClientUtility.ColorToString(CoD.ChatClientUtility.GetColorForChannelType(Engine[0x5884871F4FF3ACA](f376_local2)))
		end
		return
	elseif not ChatClientEnabled(f376_arg2) then
		Engine[0x83C9B5DE1D9371](f376_local0, Engine[0xF9F1239CFD921FE](0xCC67122F64C7D6A))
		return
	elseif not ChatClientIsAvailable(f376_arg0, f376_arg1, f376_arg2) then
		Engine[0x83C9B5DE1D9371](f376_local0, Engine[0xF9F1239CFD921FE](0xD6681AB0261E81B))
		return
	else
		Engine[0x83C9B5DE1D9371](f376_local0, Engine[0xF9F1239CFD921FE](0xC145B7A0B9AFC02))
		Engine[0x6A489878620F3BC](f376_local0)
	end
end
CoD.PCUtility.DeactivateMenuChat = function(f377_arg0)
	local f377_local0 = CoD.ChatClientUtility.GetMenuChatActiveModeModel(f377_arg0)
	f377_local0:set(false)
end
CoD.PCUtility.ActivateMenuChat = function(f378_arg0)
	local f378_local0 = CoD.ChatClientUtility.GetMenuChatActiveModeModel(f378_arg0)
	f378_local0:set(true)
end
CoD.PCUtility.ChatClientContainer = nil
CoD.PCUtility.MenuChatIsActive = function(f379_arg0)
	local f379_local0 = CoD.ChatClientUtility.GetMenuChatActiveModeModel(f379_arg0)
	return f379_local0:get()
end
CoD.PCUtility.GetChatMenusToAvoid = function()
	return {
		"MPCustomizeClassMenu",
		"WeaponSelectFlyout",
		"EquipmentSelect",
		"SpecialistEquipmentSelect",
		"WeaponAttachmentSelect",
		"PerkTalentSelect",
		"WildcardSelect",
		"SupportSelection",
		"ScorestreakOverCapacity",
		"MPSpecialistHUB",
		"MPSpecialistHUBInspect",
		"MPSpecialistHUBWeapons",
		"VoDPreviewWidgetImage",
		"PC_StartMenu_Options_New",
		"ClassSelectSlideoutPopup",
		"BountyHunterBuy",
		"BountyHunterPackageSelect",
	}
end
CoD.PCUtility.UpdateChatToSafeArea = function(f381_arg0, f381_arg1)
	local f381_local0, f381_local1, f381_local2, f381_local3 = Engine[0x26E31A9FDAA85EB](f381_arg1, true)
	local f381_local4, f381_local5, f381_local6, f381_local7 = f381_arg0:getLocalRect()
	f381_arg0:setLeftRight(false, false, f381_local0, f381_local0 + f381_local6 - f381_local4)
end
CoD.PCUtility.PreSetupMenuChat = function(f382_arg0, f382_arg1, f382_arg2)
	CoD.ChatClientUtility.ChatWidget = f382_arg0
	CoD.PCUtility.ChatClientContainer = f382_arg0
	local f382_local0, f382_local1 = nil
	if not CoD.isFrontend then
		f382_local0 = CoD.ChatClientUtility.GetStaticChatAllowedModel(f382_arg2)
		f382_local1 = CoD.PCUtility.GetChatMenusToAvoid()
		f382_arg0:appendEventHandler("update_safe_area", function(f383_arg0, f383_arg1)
			CoD.PCUtility.UpdateChatToSafeArea(f383_arg0, f382_arg2)
		end)
		CoD.PCUtility.UpdateChatToSafeArea(f382_arg0, f382_arg2)
	end
	CoD.PCUtility.RegisterStickyElement(f382_arg0, f382_arg1, f382_local0, f382_local1)
	local f382_local2 = Engine[0x6A489878620F3BC]
	local f382_local3 = Engine[0x4DF5CFBC1771947](f382_arg2)
	f382_local2(f382_local3["ChatGlobal.ChatAvailableInMenuEvent"])
	f382_arg0:subscribeToModel(CoD.ChatClientUtility.GetCurrentChattingModel(f382_arg2), function(model, f384_arg1)
		f384_arg1:playSound("menu_open", f382_arg2)
	end)
end
CoD.PCUtility.PreSetupPassiveChat = function(f385_arg0, f385_arg1, f385_arg2)
	CoD.PCUtility.RegisterStickyElement(f385_arg0, f385_arg1, CoD.ChatClientUtility.GetStaticChatAllowedModel(f385_arg2), CoD.PCUtility.GetChatMenusToAvoid())
	if not CoD.isFrontend then
		f385_arg0:appendEventHandler("update_safe_area", function(f386_arg0, f386_arg1)
			CoD.PCUtility.UpdateChatToSafeArea(f386_arg0, f385_arg2)
		end)
		CoD.PCUtility.UpdateChatToSafeArea(f385_arg0, f385_arg2)
	end
end
CoD.PCUtility.MenuHasChat = function(f387_arg0, f387_arg1)
	return CoD.PCUtility.ChatClientContainer ~= nil
end
CoD.PCUtility.MenuChatToggleShouldBeVisible = function(f388_arg0, f388_arg1, f388_arg2)
	local f388_local0 = CoD.PCUtility.IsBGSEnabled()
	if f388_local0 then
		f388_local0 = CoD.PCUtility.MenuHasChat(f388_arg1, f388_arg1)
		if f388_local0 then
			f388_local0 = not CoD.PCUtility.AreUIShortcutInputLocked(f388_arg2)
		end
	end
	return f388_local0
end
CoD.PCUtility.ToggleChatVisibility = function(f389_arg0)
	local f389_local0 = CoD.ChatClientUtility.GetCurrentChattingModel(f389_arg0)
	f389_local0:set(not f389_local0:get())
end
CoD.PCUtility.SetupXCamMouseControlWidget = function(f390_arg0)
	f390_arg0:setupXCamMouseControl()
	f390_arg0:setHandleMouse(true)
end
CoD.PCUtility.IsBindingKey = function(f391_arg0, f391_arg1)
	local f391_local0 = DataSources.KeybindMessages.getModel(f391_arg1)
	return f391_local0.isBindingKey:get()
end
CoD.PCUtility.ShowPastKeybind = function(f392_arg0, f392_arg1)
	local f392_local0 = DataSources.KeybindMessages.getModel(f392_arg1)
	return f392_local0.showPastKeybind:get()
end
CoD.PCUtility.ShowErrorMessage = function(f393_arg0, f393_arg1)
	local f393_local0 = DataSources.KeybindMessages.getModel(f393_arg1)
	return f393_local0.showErrorMessage:get()
end
CoD.PCUtility.ShowWarningMessage = function(f394_arg0, f394_arg1)
	local f394_local0 = DataSources.KeybindMessages.getModel(f394_arg1)
	return f394_local0.showWarningMessage:get()
end
CoD.PCUtility.SetActiveIndexInListDependingOnProperty = function(f395_arg0, f395_arg1, f395_arg2, f395_arg3, f395_arg4)
	if not f395_arg3._activeInitialized then
		if f395_arg0[f395_arg4] == nil then
			f395_arg3:getFirstSelectableItem(true)
		else
			f395_arg3:setActiveIndex(1, tonumber(f395_arg0[f395_arg4]), false, false)
		end
	end
	f395_arg3._activeInitialized = true
end
CoD.PCUtility.HideKeybindMessage = function(f396_arg0, f396_arg1)
	local f396_local0 = DataSources.KeybindMessages.getModel(f396_arg1)
	f396_local0.showPastKeybind:set(false)
end
CoD.PCUtility.SetStoreOpenedInTrial = function(f397_arg0)
	local f397_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.StoreOpenedInTrial")
	f397_local0:set(Engine[0xCB675CA7856DA25]())
end
CoD.PCUtility.RefreshPlayerInfo = function(f398_arg0)
	Engine[0x87AE7E64BA5AD61]("UpdatePlayerInfo", {})
end
CoD.PCUtility.OpenBattlenetCheckoutMenu = function(f399_arg0, f399_arg1, f399_arg2, f399_arg3)
	if not CoD.PCUtility.IsBGSEnabled() then
		return
	elseif f399_arg2 then
		local f399_local0 = f399_arg2:getModel()
		if f399_local0 and (f399_local0.productId or f399_local0.giftId) then
			local f399_local1 = f399_local0.productId
			local f399_local2 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f399_arg0), "bnetCheckoutProductID")
			local f399_local3 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f399_arg0), "bnetCheckoutProductIsGift")
			if Dvar[0x466833B3AD6B66A]:get() and (f399_arg3 or f399_local1 == nil) then
				f399_local1 = f399_local0.giftId
			end
			if type(f399_local1) == "number" then
				f399_local2:set(tostring(f399_local1))
			else
				f399_local2:set(f399_local1:get())
			end
			f399_local3:set(f399_arg3)
			OpenPopup(f399_arg1, "PC_Battlenet_Checkout", f399_arg0)
		end
	end
end
CoD.PCUtility.BeginBattlenetCheckout = function(f400_arg0, f400_arg1)
	local f400_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f400_arg1), "bnetCheckoutProductID")
	local f400_local1 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f400_arg1), "bnetCheckoutProductIsGift")
	Engine[0xF2D55B94A18CA3D](f400_arg1, f400_local0:get(), f400_local1:get())
	local f400_local2 = f400_arg0
	local f400_local3 = f400_arg0.subscribeToModel
	local f400_local4 = Engine[0x4DF5CFBC1771947](f400_arg1)
	f400_local3(f400_local2, f400_local4.battlenetCheckoutStatus, function(f401_arg0)
		if f401_arg0:get() == 0 then
			GoBack(f400_arg0, f400_arg1)
			local f401_local0 = Engine[0xF42BE38AAF0C6FB](f400_arg1)
			if f401_local0 ~= nil then
				LuaUtils.ShowMessageDialog(f400_arg1, Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B], Engine[0xF9F1239CFD921FE](0xA6BBF6C8401F36E, f401_local0), Engine[0xF9F1239CFD921FE](0xED7AAC4B721DBBF))
			end
		end
	end, false)
end
CoD.PCUtility.CancelBattlenetCheckout = function(f402_arg0, f402_arg1)
	Engine[0x58E4456725DF268](f402_arg0, f402_arg1)
end
CoD.PCUtility.SetupBattlenetCheckoutElement = function(f403_arg0)
	f403_arg0:setupBNetCheckoutElement()
end
CoD.PCUtility.SetupBattlenetCloseButtonWidget = function(f404_arg0)
	f404_arg0:setupBNetCheckoutElementCloseButtonArea()
end
CoD.PCUtility.SetupBattlenetBackgroundBorderElement = function(f405_arg0)
	f405_arg0:setupBNetCheckoutElementBorderBackground()
end
CoD.PCUtility.ShowBattleNetCatalogError = function(f406_arg0, f406_arg1)
	GoBack(f406_arg0, f406_arg1)
	LuaUtils.ShowMessageDialog(f406_arg1, Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B], Engine[0xF9F1239CFD921FE](0x421AFF727532EEC, Engine[0xF47248634BEA927](f406_arg1)), Engine[0xF9F1239CFD921FE](0xED7AAC4B721DBBF))
end
CoD.PCUtility.ShowBattleNetReconciliationError = function(f407_arg0, f407_arg1)
	LuaUtils.ShowMessageDialog(f407_arg1, Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B], Engine[0xF9F1239CFD921FE](0x4A89E3BABEE02B7), Engine[0xF9F1239CFD921FE](0xED7AAC4B721DBBF))
end
CoD.PCUtility.ActiveParentElementGrid = function(f408_arg0, f408_arg1, f408_arg2)
	if CoD.GetMouseFocus(f408_arg2) then
		local f408_local0 = CoD.GetMouseFocus(f408_arg2)
		while f408_local0 and not f408_local0.gridInfoTable do
			f408_local0 = f408_local0:getParent()
		end
		if f408_local0 then
			SetCurrentElementAsActive(f408_arg0, f408_local0, f408_arg2)
		end
		return true
	else
		return false
	end
end
CoD.PCUtility.UpdatePurchaseButtonState = function(f409_arg0, f409_arg1, f409_arg2, f409_arg3)
	local f409_local0 = f409_arg3:getModel()
	if f409_local0 and f409_local0.owned and f409_local0.purchased then
		if f409_local0.owned:get() or f409_local0.purchased:get() then
			f409_arg2:setState(f409_arg1, "Disabled")
		else
			f409_arg2:setState(f409_arg1, "DefaultState")
		end
	end
end
CoD.PCUtility.RefreshBnetProductsList = function(f410_arg0, f410_arg1, f410_arg2)
	local f410_local0 = Engine[0x307A0A3BE745017](f410_arg0)
	if table.getn(f410_local0) == 0 then
		GoBack(f410_arg2, f410_arg0)
		LuaUtils.ShowMessageDialog(f410_arg0, Enum[0xEE23F7D18EF525C][0x8BCCDF5038F1B0B], Engine[0xF9F1239CFD921FE](0xE090CBB79C37395), Engine[0xF9F1239CFD921FE](0xED7AAC4B721DBBF))
	else
		DataSources.BnetStore = DataSourceHelpers.ListSetup("PC.BnetStore", function(f411_arg0)
			return CoD.PCUtil.PreparePCBnetStoreCatalog(f411_arg0, f410_local0)
		end, true)
		f410_arg1.List:updateDataSource()
		if Dvar[0x466833B3AD6B66A]:get() then
			f410_arg1:setState(f410_arg0, "DefaultState")
		else
			f410_arg1:setState(f410_arg0, "HideGiftButton")
		end
	end
end
CoD.PCUtility.SetupSettingsApplyButtonPrompt = function(f412_arg0, f412_arg1, f412_arg2)
	f412_arg0:AddButtonCallbackFunction(f412_arg2, f412_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.PCOptionsUtility.IsGraphicsOptions(controller) and CoD.PCOptionsUtility.AreOptionsDirty(controller) then
			CoD.PCOptionsUtility.ApplyOptionsValue(f412_arg2, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		local f414_local0 = CoD.PCOptionsUtility.GetCurrentOptionTabId(controller)
		local f414_local1 = CoD.Menu.SetButtonLabel
		local f414_local2 = menu
		local f414_local3 = Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09]
		local f414_local4
		if f414_local0 == CoD.PCOptionsUtility.OptionTabIds.Graphic then
			f414_local4 = 0x7D14DF1D6CBE990
			if not f414_local4 then
			else
				f414_local1(f414_local2, f414_local3, f414_local4, nil, "ui_contextual_1")
				if CoD.PCOptionsUtility.IsGraphicsOptions(controller) and CoD.PCOptionsUtility.AreOptionsDirty(controller) then
					return true
				else
					return false
				end
			end
		end
		f414_local4 = 0x0
	end, true)
end
CoD.PCUtility.PreparePCBnetStoreListNavigation = function(f415_arg0, f415_arg1, f415_arg2)
	local f415_local0 = function(f416_arg0)
		if not f416_arg0:isFocusable() then
			f416_arg0 = CoD.BaseUtility.FindSingleFocusableDescendant(f416_arg0, true)
		end
		f415_arg2:ChangeFocusedElement(f415_arg1, f416_arg0, true)
	end
	CoD.Menu.AddButtonCallbackFunction(f415_arg2, f415_arg0, f415_arg1, Enum[0x3DD78803F918E9D][0x4B11D2B20C75A7F], "ui_navup", function(element, menu, controller, f417_arg3)
		if not f415_arg0.m_disableNavigation then
			f415_arg0:navigateItemUp()
			f415_local0(f415_arg0.activeWidget)
			return true
		else
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f415_arg2, f415_arg0, f415_arg1, Enum[0x3DD78803F918E9D][0xD4C15FE32148D3A], "ui_navdown", function(element, menu, controller, f418_arg3)
		if not f415_arg0.m_disableNavigation then
			f415_arg0:navigateItemDown()
			f415_local0(f415_arg0.activeWidget)
			return true
		else
		end
	end)
	CoD.Menu.AddButtonCallbackFunction(f415_arg2, f415_arg0, f415_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "SPACE", function(element, menu, controller, f419_arg3)
		CoD.PCUtility.OpenBattlenetCheckoutMenu(controller, menu, f415_arg0)
		return true
	end)
end
CoD.PCUtility.UpdateScoreboardPrompts = function(f420_arg0, f420_arg1)
	assert(f420_arg0.AccessScoreboardPrompt)
	assert(f420_arg0.AccessMapPrompt)
	f420_arg0.AccessScoreboardPrompt:setText(Engine[0xF9F1239CFD921FE](CoD.PCUtility.ChangeScoreboardKeyPrompt(f420_arg1, 0x80F8EB101BEC729)))
	f420_arg0.AccessMapPrompt:setText(Engine[0xF9F1239CFD921FE](CoD.PCUtility.ChangeMapKeyPrompt(f420_arg1, 0x6F8063898C095A4)))
end
CoD.PCUtility.SetupUIMenuShortcutBlocker = function(f421_arg0, f421_arg1)
	CoD.PCUtility.PreventUIMenuShortcuts = true
	LUI.OverrideFunction_CallOriginalFirst(f421_arg0, "close", function(element)
		CoD.PCUtility.PreventUIMenuShortcuts = false
	end)
end
CoD.PCUtility.SetupDismissTimerRewardsAAR = function(f423_arg0, f423_arg1, f423_arg2)
	f423_arg2.__dismissRewardTimer = LUI.UITimer.newElementTimer(350, true, function()
		f423_arg2:AddButtonCallbackFunction(f423_arg0, f423_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
			CoD.AARUtility.InitRewardsPaging(controller)
			GoBack(element, controller)
			return true
		end)
		f423_arg2.__dismissRewardTimer = nil
	end)
	f423_arg2:addElement(f423_arg2.__dismissRewardTimer)
end
CoD.PCUtility.GetKeybind = function(f426_arg0, f426_arg1)
	return Engine[0xDFD7EFA83DD8C75](f426_arg0, f426_arg1)
end
CoD.PCUtility.GetKeyboardKeybindOnly = function(f427_arg0, f427_arg1)
	local f427_local0, f427_local1 = Engine[0x7C4C4DBF61B869E](f427_arg0, f427_arg1, 0, true)
	return f427_local1 or f427_local0 or "[" .. Engine[0xF9F1239CFD921FE](0xB67F7FB585D594C) .. "]"
end
CoD.PCUtility.IsCurrentHudOccluded = function(f428_arg0, f428_arg1)
	local f428_local0 = f428_arg0:getParent()
	return f428_local0.occludedBy or f428_arg0.occludedBy
end
CoD.PCUtility.GameEndScoreWZShowCursor = function(f429_arg0, f429_arg1, f429_arg2)
	SetFocusToElement(f429_arg0, "emptyFocusablePC", f429_arg1)
	LockInput(f429_arg0, f429_arg1, true)
	SetAllowCursorMovement(f429_arg2, true)
end
CoD.PCUtility.SetTextFromTelemetryModel = function(f430_arg0, f430_arg1, f430_arg2, f430_arg3, f430_arg4)
	if not f430_arg0.Label then
		return
	end
	local f430_local0 = Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), f430_arg2))
	if f430_local0 and f430_local0 > 0 then
		f430_arg0.Label:setText(Engine[0xF9F1239CFD921FE](f430_arg3, f430_local0))
	elseif f430_arg4 and f430_arg4 ~= 0x0 then
		f430_arg0.Label:setText(Engine[0xF9F1239CFD921FE](f430_arg4))
	end
end
CoD.PCUtility.SetupSafeAreaBorders = function(f431_arg0, f431_arg1, f431_arg2)
	f431_arg0.safeArea:sizeToSafeArea(f431_arg1, true)
	CoD.SafeArea.InitialX = Engine[0xB75B48400B76AA4](f431_arg1, 0x7664E60A992DFDA)
	CoD.SafeArea.InitialY = Engine[0xB75B48400B76AA4](f431_arg1, 0x803283CE6FF32EC)
	f431_arg0.safeArea.TBorder.emptyFocusableClic:setHandleMouse(true)
	f431_arg0.safeArea.BBorder.emptyFocusableClic:setHandleMouse(true)
	f431_arg0.safeArea.LBorder.emptyFocusableClic:setHandleMouse(true)
	f431_arg0.safeArea.RBorder.emptyFocusableClic:setHandleMouse(true)
	f431_arg0.emptyFocusable:setHandleMouse(true)
	local f431_local0 = function(f432_arg0, f432_arg1, f432_arg2, f432_arg3, f432_arg4, f432_arg5)
		CoD.SafeArea.VerticalBordersClicked = f432_arg4
		CoD.SafeArea.HorizontalBordersClicked = f432_arg5
		if not f432_arg4 and not f432_arg5 and f432_arg1.__lockedFocus then
			f432_arg0:CaptureMouseAndLockFocus(f432_arg2, nil)
			f432_arg1.lockedFocus = false
		end
	end
	local f431_local1 = function(f433_arg0, f433_arg1, f433_arg2, f433_arg3, f433_arg4, f433_arg5, f433_arg6)
		f433_arg0.previousX = f433_arg2.x
		f433_arg0.previousY = f433_arg2.y
		f433_arg0.startX = f433_arg2.x
		f433_arg0.startY = f433_arg2.y
		f433_arg0:CaptureMouseAndLockFocus(f433_arg3, f433_arg1)
		f433_arg1.__lockedFocus = true
		f431_local0(f433_arg0, f433_arg1, f433_arg3, f433_arg4, f433_arg5, f433_arg6)
	end
	local f431_local2 = function(f434_arg0, f434_arg1, f434_arg2, f434_arg3)
		if CoD.SafeArea.HorizontalBordersClicked == true then
			local f434_local0, f434_local1, f434_local2 = Engine[0x6913E41040C17FD](f434_arg2.controller)
			f434_arg0.previousX = f434_arg0.previousX or f434_arg2.x
			f434_arg0.startX = f434_arg0.startX or f434_arg2.x
			if f434_arg2.x < f434_local0 / 2 + 2 and f434_local0 / 2 - 2 < f434_arg0.previousX then
				f434_arg0.previousX = f434_local0 / 2 - 2
				f434_arg0.startX = f434_arg0.previousX
			elseif f434_local0 / 2 - 2 < f434_arg2.x and f434_arg0.previousX < f434_local0 / 2 + 2 then
				f434_arg0.previousX = f434_local0 / 2 + 2
				f434_arg0.startX = f434_arg0.previousX
			end
			AdjustSafeArea(f434_arg0, f434_arg1, f434_arg2.controller, 2 * f434_arg0.startX < f434_local0, 2 * (f434_arg2.x - f434_arg0.previousX) / f434_local0, "HUDBoundsTweakable_horizontal", DecreaseSafeAreaHorizontal, IncreaseSafeAreaHorizontal)
			DispatchEventToRoot(f434_arg0, "update_safe_area", f434_arg3)
			f434_arg0.previousX = f434_arg2.x
			f434_arg0.previousY = f434_arg2.y
		end
	end
	local f431_local3 = function(f435_arg0, f435_arg1, f435_arg2, f435_arg3)
		if CoD.SafeArea.VerticalBordersClicked == true then
			local f435_local0, f435_local1, f435_local2 = Engine[0x6913E41040C17FD](f435_arg2.controller)
			f435_arg0.previousY = f435_arg0.previousY or f435_arg2.y
			f435_arg0.startY = f435_arg0.startY or f435_arg2.y
			if f435_arg2.y < f435_local1 / 2 + 2 and f435_local1 / 2 - 2 < f435_arg0.previousY then
				f435_arg0.previousY = f435_local1 / 2 - 2
				f435_arg0.startY = f435_arg0.previousY
			elseif f435_local1 / 2 - 2 < f435_arg2.y and f435_arg0.previousY < f435_local1 / 2 + 2 then
				f435_arg0.previousY = f435_local1 / 2 + 2
				f435_arg0.startY = f435_arg0.previousY
			end
			AdjustSafeArea(f435_arg0, f435_arg1, f435_arg2.controller, 2 * f435_arg0.startY < f435_local1, 2 * (f435_arg2.y - f435_arg0.previousY) / f435_local1, "HUDBoundsTweakable_vertical", DecreaseSafeAreaVertical, IncreaseSafeAreaVertical)
			DispatchEventToRoot(f435_arg0, "update_safe_area", f435_arg3)
			f435_arg0.previousX = f435_arg2.x
			f435_arg0.previousY = f435_arg2.y
		end
	end
	local f431_local4 = function(f436_arg0, f436_arg1, f436_arg2)
		if f436_arg0.__lockedFocus then
			f436_arg2:CaptureMouseAndLockFocus(f436_arg1, nil)
			f436_arg0.__lockedFocus = false
		end
	end
	local f431_local5 = function(f437_arg0)
		if f437_arg0.__lockedFocus then
			f437_arg0.__lockedFocus = false
		end
	end
	for f431_local9, f431_local10 in ipairs({
		{
			receiver = f431_arg0.safeArea.TBorder,
			dragFunction = f431_local3,
			isVerticalClicked = true,
			isHorizontalClicked = false,
		},
		{
			receiver = f431_arg0.safeArea.BBorder,
			dragFunction = f431_local3,
			isVerticalClicked = true,
			isHorizontalClicked = false,
		},
		{
			receiver = f431_arg0.safeArea.LBorder,
			dragFunction = f431_local2,
			isVerticalClicked = false,
			isHorizontalClicked = true,
		},
		{
			receiver = f431_arg0.safeArea.RBorder,
			dragFunction = f431_local2,
			isVerticalClicked = false,
			isHorizontalClicked = true,
		},
	}) do
		f431_local10.receiver.emptyFocusableClic:registerEventHandler("leftmousedrag", function(element, event)
			f431_local10.dragFunction(f431_arg0, element, event, f431_arg1)
		end)
		f431_local10.receiver.emptyFocusableClic:registerEventHandler("leftmouseup", function(element, event)
			f431_local0(f431_arg0, element, f431_arg1, f431_arg2, false, false)
		end)
		f431_local10.receiver.emptyFocusableClic:registerEventHandler("leftmousedown", function(element, event)
			f431_local1(f431_arg0, element, event, f431_arg1, f431_arg2, f431_local10.isVerticalClicked, f431_local10.isHorizontalClicked)
		end)
		f431_local10.receiver.emptyFocusableClic:registerEventHandler("lose_focus", function(element, event)
			f431_local4(element, f431_arg1, f431_arg2)
		end)
		f431_local10.receiver.emptyFocusableClic:registerEventHandler("mouse_capture_lost", function(element, event)
			f431_local5(element)
		end)
		f431_local10.receiver.__onBorderClose = function(f443_arg0, f443_arg1, f443_arg2)
			if f443_arg0.__lockedFocus then
				f443_arg2:CaptureMouseAndLockFocus(f443_arg1, nil)
				f443_arg0.__lockedFocus = false
			end
		end
		LUI.OverrideFunction_CallOriginalSecond(f431_local10.receiver, "close", f431_local10.receiver.__onBorderClose)
	end
	f431_arg0.emptyFocusable:registerEventHandler("leftmousedown", function(element, event)
		f431_local0(f431_arg0, element, f431_arg1, f431_arg2, false, false)
	end)
	f431_arg0.emptyFocusable:registerEventHandler("leftmouseup", function(element, event)
		f431_local0(f431_arg0, element, f431_arg1, f431_arg2, false, false)
	end)
end
CoD.PCUtility.ParentIDIsEqualTo = function(f446_arg0, f446_arg1)
	local f446_local0 = f446_arg0:getParent()
	return f446_local0.id == f446_arg1
end
CoD.PCUtility.CanCancelBattlenetCheckout = function(f447_arg0)
	return Engine[0x586FE38A91EBC88](f447_arg0)
end
CoD.PCUtility.IsBattlenetCheckoutReady = function(f448_arg0)
	return Engine[0xD88B01FF62D311D](f448_arg0)
end
CoD.PCUtility.IsLeftMouseDown = function(f449_arg0)
	local f449_local0 = Engine[0x4DF5CFBC1771947](f449_arg0)
	return CoD.BitUtility.IsBitwiseAndNonZero(f449_local0["KeyPressBits.MOUSE1"].get(f449_local0["KeyPressBits.MOUSE1"]), Enum[0xE29E259801BC1A4][0x253A6F6CAAAE464])
end
CoD.PCUtility.CanShowLeaveGameButton = function(f450_arg0, f450_arg1)
	local f450_local0 = f450_arg0
	local f450_local1 = IsInGame()
	if f450_local1 then
		if not IsCurrentMenu(f450_arg0, "Hud_WZ") then
			f450_local1 = IsCurrentMenu(f450_arg0, "StartMenu_Main")
			if f450_local1 then
			else
				return f450_local1
			end
		end
		if IsMultiplayer() then
			if not CoD.PlayerRoleUtility.IsPositionDraftStage(f450_arg1, CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_WAITING_FOR_PLAYERS) and not CoD.PlayerRoleUtility.IsPositionDraftStage(f450_arg1, CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_DRAFT) then
				f450_local1 = not CoD.PlayerRoleUtility.IsPositionDraftStage(f450_arg1, CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_ASSIGNMENT)
			else
				f450_local1 = false
			end
		else
			f450_local1 = f450_local0 and true
		end
	end
	return f450_local1
end
CoD.PCUtility.CanShowStartWarzoneButton = function(f451_arg0, f451_arg1)
	local f451_local0 = f451_arg0
	local f451_local1 = IsInGame()
	if f451_local1 then
		f451_local1 = CoD.HUDUtility.IsWarzone()
		if f451_local1 then
			f451_local1 = CoD.WZUtility.AllowWZOffline()
			if f451_local1 then
				f451_local1 = IsLobbyHost()
				if f451_local1 then
					f451_local1 = IsCustomLobby()
					if f451_local1 then
						if not CoD.ModelUtility.IsControllerModelValueTrue(f451_arg1, "hudItems.hasStartedWZMatch") then
							f451_local1 = IsCurrentMenu(f451_arg0, "StartMenu_Main")
						else
							f451_local1 = false
						end
					end
				end
			end
		end
	end
	return f451_local1
end
CoD.PCUtility.PlayOptionDescriptionIntroClip = function(f452_arg0, f452_arg1)
	if f452_arg0 then
		f452_arg0:playClip("DescIntro")
	end
	return f452_arg1
end
CoD.PCUtility.JoinedStateToString = function(f453_arg0)
	if f453_arg0 == 0 then
		return "Create Channel"
	elseif f453_arg0 == 1 then
		return "Join Channel"
	else
		return "Leave Channel"
	end
end
CoD.PCUtility.ChangeScoreboardKeyPrompt = function(f454_arg0, f454_arg1)
	local f454_local0 = Engine[0xDFD7EFA83DD8C75](f454_arg0, "+scores", false)
	local f454_local1 = Engine[0xDFD7EFA83DD8C75](f454_arg0, "togglescores", false)
	local f454_local2 = "(Empty)"
	if f454_local0 ~= f454_local2 and f454_local1 ~= f454_local2 then
		f454_arg1 = 0x591611245686F35
	elseif f454_local0 ~= f454_local2 then
		f454_arg1 = 0xDB09778CA181419
	elseif f454_local1 ~= f454_local2 then
		f454_arg1 = 0x80F8EB101BEC729
	else
		f454_arg1 = 0x2C79EA24AB1A2BA
	end
	return f454_arg1
end
CoD.PCUtility.ChangeMapKeyPrompt = function(f455_arg0, f455_arg1)
	local f455_local0 = Engine[0xDFD7EFA83DD8C75](f455_arg0, "+map", false)
	local f455_local1 = Engine[0xDFD7EFA83DD8C75](f455_arg0, "togglemap", false)
	local f455_local2 = "(Empty)"
	if f455_local0 ~= f455_local2 and f455_local1 ~= f455_local2 then
		f455_arg1 = 0xAB7F4DF5A3E7CF0
	elseif f455_local0 ~= f455_local2 then
		f455_arg1 = 0x41CB1784B1E5EB4
	elseif f455_local1 ~= f455_local2 then
		f455_arg1 = 0x6F8063898C095A4
	else
		f455_arg1 = 0x2C79EA24AB1A2BA
	end
	return f455_arg1
end
CoD.PCUtility.ProgramImages = {
	WoW = "menu_social_friendlist_wow_icon",
	S2 = "menu_social_friendlist_s2_icon",
	D3 = "menu_social_friendlist_diablo3_icon",
	BN = "menu_social_friendlist_bnet_icon",
	App = "menu_social_friendlist_bnet_icon",
	WTCG = "menu_social_friendlist_hearthstone_icon",
	Pro = "menu_social_friendlist_overwatch_icon",
	Hero = "menu_social_friendlist_hots_icon",
	DST2 = "menu_social_friendlist_destiny2_icon",
	BSAp = "menu_social_friendlist_bnet_icon",
	S1 = "menu_social_friendlist_s1_icon",
	W3 = "menu_social_friendlist_warcraft3_icon",
	ODIN = "menu_social_friendlist_mw_icon",
	VIPR = "menu_social_friendlist_bo4_icon",
	DEFAULT = "menu_social_friendlist_bnet_icon",
}
CoD.PCUtility.GetBNetPresenceProgramImage = function(f456_arg0)
	if f456_arg0 ~= nil and CoD.PCUtility.ProgramImages[f456_arg0] ~= nil then
		return CoD.PCUtility.ProgramImages[f456_arg0]
	else
		return CoD.PCUtility.ProgramImages.DEFAULT
	end
end
CoD.PCUtility.LocalizeConnectionQueueMessage = function(f457_arg0, f457_arg1)
	local f457_local0 = DataSources.PCConnectionQueue.getModel(f457_arg0)
	return Engine[0xF9F1239CFD921FE](0x258E1345C190308, f457_local0.ConnectionQueuePosition:get(), string.format("%02d", math.floor(f457_local0.ConnectionQueueRemainingtime:get() / 3600)), string.format("%02d", math.floor(f457_local0.ConnectionQueueRemainingtime:get() / 60 % 60)), string.format("%02d", math.floor(f457_local0.ConnectionQueueRemainingtime:get() % 60)))
end
CoD.PCUtility.ReplaceCircumflex = function(f458_arg0)
	return string.gsub(f458_arg0, "%^", "^^")
end
CoD.PCUtility.ForceSetTextOnRebind = function(f459_arg0)
	return f459_arg0
end
CoD.PCUtility.SetSelfGridOrListIndexInTextBox = function(f460_arg0, f460_arg1)
	if not f460_arg0.gridInfoTable then
		return f460_arg1
	else
		return f460_arg0.gridInfoTable.zeroBasedIndex + 1
	end
end
CoD.PCUtility.DisplayJapanPrePurchasePopup = function(f461_arg0, f461_arg1, f461_arg2, f461_arg3, f461_arg4)
	assert(f461_arg0)
	assert(f461_arg3)
	assert(Engine[0x543F4AF0F31BA06]())
	if f461_arg3.purchaseProductElement then
		local f461_local0 = f461_arg3.purchaseProductElement:getModel()
		local f461_local1 = DataSources.PCKoreaRefundWarning.prepare(f461_arg2, f461_arg0, f461_arg4, f461_local0.fullName and f461_local0.fullName:get() or f461_local0.name:get(), "", f461_local0.price:get(), "Call of Duty Points (CP)?????????????????????CP????????????????????????????????????6?????????????????????1??????????????????????????????\n???????????????CP????????????????????????????????????????????????????????????????????????", "", f461_local0.productImage:get() or 0x7615068F50B3D66, 0x7615068F50B3D66, nil, false, false, false, "", false, 0x85952ACC6D0C1B0)
		if f461_local1 then
			local f461_local2 = OpenPopup(f461_arg1, "PC_Store_Refund_Korea", f461_arg2)
			f461_local2:setModel(f461_local1, f461_arg2)
			return
		end
	end
	f461_arg0()
end
CoD.PCUtility.DisplayPrePurchasePopup = function(f462_arg0, f462_arg1, f462_arg2, f462_arg3, f462_arg4)
	assert(f462_arg0)
	if f462_arg3 then
		if CoD.PCKoreaUtility.IsInKorea() then
			CoD.PCKoreaUtility.DisplayRefundAgreement(f462_arg0, f462_arg1, f462_arg2, f462_arg3, f462_arg4)
			return
		elseif Engine[0x543F4AF0F31BA06]() then
			CoD.PCUtility.DisplayJapanPrePurchasePopup(f462_arg0, f462_arg1, f462_arg2, f462_arg3, f462_arg4)
			return
		end
	end
	f462_arg0()
end
