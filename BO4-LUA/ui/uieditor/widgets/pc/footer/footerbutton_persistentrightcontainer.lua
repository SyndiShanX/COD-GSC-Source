require("ui/uieditor/widgets/pc/footer/footerbutton_bnetstore")
require("ui/uieditor/widgets/pc/footer/footerbutton_persistent")
CoD.FooterButton_PersistentRightContainer = InheritFrom(LUI.UIElement)
CoD.FooterButton_PersistentRightContainer.__defaultWidth = 548
CoD.FooterButton_PersistentRightContainer.__defaultHeight = 54
CoD.FooterButton_PersistentRightContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.hasStartedWZMatch", false)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "PositionDraft.stage", 0)
	self:setClass(CoD.FooterButton_PersistentRightContainer)
	self.id = "FooterButton_PersistentRightContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local FooterButtonBnetStore = CoD.FooterButton_BnetStore.new(f1_arg0, f1_arg1, 0, 0, 428, 548, 0, 1, 0, 0)
	FooterButtonBnetStore:setAlpha(0)
	FooterButtonBnetStore:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonBnetStore, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		CoD.PCUtility.ToggleShortcutMenu(f3_arg1, f3_arg2, "ui_openstore")
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonBnetStore, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		CoD.PCUtility.ToggleShortcutMenu(f5_arg1, f5_arg2, "ui_openstore")
		return true
	end, function(f6_arg0, f6_arg1, f6_arg2)
		CoD.Menu.SetButtonLabel(f6_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(FooterButtonBnetStore)
	self.FooterButtonBnetStore = FooterButtonBnetStore
	local FooterButtonStartWarzone = CoD.FooterButton_Persistent.new(f1_arg0, f1_arg1, 0, 0, 308, 428, 0, 1, 0, 0)
	FooterButtonStartWarzone:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1) and CoD.PCUtility.CanShowStartWarzoneButton(menu, f1_arg1)
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.CanShowStartWarzoneButton(menu, f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCUtility.CanShowStartWarzoneButton(menu, f1_arg1)
			end,
		},
	})
	local f1_local3 = FooterButtonStartWarzone
	local FooterButtonQuitGame = FooterButtonStartWarzone.subscribeToModel
	local f1_local5 = Engine.GetModelForController(f1_arg1)
	FooterButtonQuitGame(f1_local3, f1_local5.LockUIShortcutInput, function(f10_arg0)
		f1_arg0:updateElementState(FooterButtonStartWarzone, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	FooterButtonStartWarzone:appendEventHandler("on_session_start", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FooterButtonStartWarzone, f11_arg1)
	end)
	FooterButtonStartWarzone:appendEventHandler("on_session_end", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FooterButtonStartWarzone, f12_arg1)
	end)
	f1_local3 = FooterButtonStartWarzone
	FooterButtonQuitGame = FooterButtonStartWarzone.subscribeToModel
	f1_local5 = Engine.GetGlobalModel()
	FooterButtonQuitGame(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f13_arg0)
		f1_arg0:updateElementState(FooterButtonStartWarzone, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local3 = FooterButtonStartWarzone
	FooterButtonQuitGame = FooterButtonStartWarzone.subscribeToModel
	f1_local5 = Engine.GetModelForController(f1_arg1)
	FooterButtonQuitGame(f1_local3, f1_local5["hudItems.hasStartedWZMatch"], function(f14_arg0)
		f1_arg0:updateElementState(FooterButtonStartWarzone, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "hudItems.hasStartedWZMatch",
		})
	end, false)
	FooterButtonStartWarzone.label:setText(LocalizeToUpperString(@"warzone/start_warzone"))
	FooterButtonStartWarzone.label2:setRGB(1, 0.9, 0.59)
	FooterButtonStartWarzone.label2:setText(LocalizeToUpperString(@"warzone/start_warzone"))
	FooterButtonStartWarzone.footerTooltip.label:setText(LocalizeToUpperString(@"warzone/start_warzone"))
	FooterButtonStartWarzone.footerTooltip.keyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_1}]"))
	FooterButtonStartWarzone:appendEventHandler("on_session_start", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
	end)
	FooterButtonStartWarzone:appendEventHandler("on_session_end", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f16_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f16_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
	end)
	f1_local3 = FooterButtonStartWarzone
	FooterButtonQuitGame = FooterButtonStartWarzone.subscribeToModel
	f1_local5 = Engine.GetGlobalModel()
	FooterButtonQuitGame(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
	end, false)
	f1_local3 = FooterButtonStartWarzone
	FooterButtonQuitGame = FooterButtonStartWarzone.subscribeToModel
	f1_local5 = Engine.GetModelForController(f1_arg1)
	FooterButtonQuitGame(f1_local3, f1_local5["hudItems.hasStartedWZMatch"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
	end, false)
	FooterButtonStartWarzone:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f19_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonStartWarzone, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
		if CoD.PCUtility.CanShowStartWarzoneButton(f20_arg1, f20_arg2) then
			CoD.WZUtility.StartWarzone(f20_arg2)
			SetControllerModelValue(f20_arg2, "hudItems.hasStartedWZMatch", true)
			return true
		else
		end
	end, function(f21_arg0, f21_arg1, f21_arg2)
		if CoD.PCUtility.CanShowStartWarzoneButton(f21_arg1, f21_arg2) then
			CoD.Menu.SetButtonLabel(f21_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonStartWarzone, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
		if CoD.PCUtility.CanShowStartWarzoneButton(f22_arg1, f22_arg2) then
			CoD.WZUtility.StartWarzone(f22_arg2)
			SetControllerModelValue(f22_arg2, "hudItems.hasStartedWZMatch", true)
			return true
		else
		end
	end, function(f23_arg0, f23_arg1, f23_arg2)
		if CoD.PCUtility.CanShowStartWarzoneButton(f23_arg1, f23_arg2) then
			CoD.Menu.SetButtonLabel(f23_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(FooterButtonStartWarzone, "setState", function(element, controller, f24_arg2, f24_arg3, f24_arg4)
		if IsElementInState(element, "Hidden") then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(FooterButtonStartWarzone)
	self.FooterButtonStartWarzone = FooterButtonStartWarzone
	FooterButtonQuitGame = CoD.FooterButton_Persistent.new(f1_arg0, f1_arg1, 0, 0, 188, 308, 0, 1, 0, 0)
	FooterButtonQuitGame:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1) and IsInGame()
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return IsInGame() and CoD.PCUtility.CanShowLeaveGameButton(menu, f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	f1_local5 = FooterButtonQuitGame
	f1_local3 = FooterButtonQuitGame.subscribeToModel
	local f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local5, f1_local6.LockUIShortcutInput, function(f28_arg0)
		f1_arg0:updateElementState(FooterButtonQuitGame, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	f1_local5 = FooterButtonQuitGame
	f1_local3 = FooterButtonQuitGame.subscribeToModel
	f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local5, f1_local6["PositionDraft.stage"], function(f29_arg0)
		f1_arg0:updateElementState(FooterButtonQuitGame, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "PositionDraft.stage",
		})
	end, false)
	FooterButtonQuitGame.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7163F6214A962C7"))
	FooterButtonQuitGame.label2:setRGB(1, 0.9, 0.59)
	FooterButtonQuitGame.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7163F6214A962C7"))
	FooterButtonQuitGame.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7163F6214A962C7"))
	FooterButtonQuitGame.footerTooltip.keyPrompt.keybind:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_2}]"))
	f1_local5 = FooterButtonQuitGame
	f1_local3 = FooterButtonQuitGame.subscribeToModel
	f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local5, f1_local6["PositionDraft.stage"], function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
	end, false)
	FooterButtonQuitGame:registerEventHandler("gain_focus", function(element, event)
		local f31_local0 = nil
		if element.gainFocus then
			f31_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f31_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f31_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonQuitGame, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
		if CoD.PCUtility.CanShowLeaveGameButton(f32_arg1, f32_arg2) then
			QuitPCGame_MP(self, f32_arg2, false)
			return true
		else
		end
	end, function(f33_arg0, f33_arg1, f33_arg2)
		if CoD.PCUtility.CanShowLeaveGameButton(f33_arg1, f33_arg2) then
			CoD.Menu.SetButtonLabel(f33_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonQuitGame, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
		if CoD.PCUtility.CanShowLeaveGameButton(f34_arg1, f34_arg2) then
			QuitPCGame_MP(self, f34_arg2, false)
			return true
		else
		end
	end, function(f35_arg0, f35_arg1, f35_arg2)
		if CoD.PCUtility.CanShowLeaveGameButton(f35_arg1, f35_arg2) then
			CoD.Menu.SetButtonLabel(f35_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(FooterButtonQuitGame)
	self.FooterButtonQuitGame = FooterButtonQuitGame
	if CoD.isPC then
		FooterButtonBnetStore.id = "FooterButtonBnetStore"
	end
	if CoD.isPC then
		FooterButtonStartWarzone.id = "FooterButtonStartWarzone"
	end
	if CoD.isPC then
		FooterButtonQuitGame.id = "FooterButtonQuitGame"
	end
	self.__defaultFocus = FooterButtonBnetStore
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_PersistentRightContainer.__onClose = function(f36_arg0)
	f36_arg0.FooterButtonBnetStore:close()
	f36_arg0.FooterButtonStartWarzone:close()
	f36_arg0.FooterButtonQuitGame:close()
end
