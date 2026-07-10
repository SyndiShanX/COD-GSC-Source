require("x64:be779d5e87238aa")
CoD.PC_StartMenu_Options_HUDBounds_Buttons = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_HUDBounds_Buttons.__defaultWidth = 711
CoD.PC_StartMenu_Options_HUDBounds_Buttons.__defaultHeight = 60
CoD.PC_StartMenu_Options_HUDBounds_Buttons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.PC_StartMenu_Options_HUDBounds_Buttons)
	self.id = "PC_StartMenu_Options_HUDBounds_Buttons"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local confirmButton = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 0, 0, 0, 230, 0, 0, 0, 60)
	confirmButton.ButtonContainer.Blur:setAlpha(0)
	confirmButton.ButtonContainer.Title:setText(LocalizeToUpperString(@"hash_67D14DF1D6CBE990"))
	confirmButton.ButtonContainer.Icon:setRGB(0.4, 0.55, 0.22)
	confirmButton.ButtonContainer.Icon:setImage(RegisterImage(@"uie_success_icon"))
	confirmButton:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(confirmButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		DispatchEventToRoot(self, "update_safe_area", controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(confirmButton)
	self.confirmButton = confirmButton
	local cancelButton = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 0.5, 0.5, -115, 115, 0, 0, 0, 60)
	cancelButton.ButtonContainer.Blur:setAlpha(0)
	cancelButton.ButtonContainer.Title:setText(LocalizeToUpperString(@"menu/cancel"))
	cancelButton.ButtonContainer.Icon:setRGB(0.72, 0.21, 0.21)
	cancelButton.ButtonContainer.Icon:setImage(RegisterImage(@"uie_error_icon"))
	cancelButton:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(cancelButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		SetSafeArea(self, menu, controller, "HUDBoundsTweakable_vertical", CoD.SafeArea.InitialY)
		SetSafeArea(self, menu, controller, "HUDBoundsTweakable_horizontal", CoD.SafeArea.InitialX)
		DispatchEventToRoot(self, "update_safe_area", controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(cancelButton)
	self.cancelButton = cancelButton
	local resetButton = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 1, 1, -230, 0, 0, 0, 0, 60)
	resetButton.ButtonContainer.Blur:setAlpha(0)
	resetButton.ButtonContainer.Title:setText(LocalizeToUpperString(@"hash_49BC2B49A2A1CCB1"))
	resetButton.ButtonContainer.Icon:setRGB(0.42, 0.42, 0.42)
	resetButton.ButtonContainer.Icon:setImage(RegisterImage(@"uie_reset_icon"))
	resetButton:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(resetButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		ResetSafeAreaHorizontal(self, self, controller)
		SetSafeArea(self, self, controller, "HUDBoundsTweakable_vertical", CoD.SafeArea.Maximum)
		DispatchEventToRoot(element, "update_safe_area", controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "MOUSE1")
		return false
	end, false)
	self:addElement(resetButton)
	self.resetButton = resetButton
	confirmButton.id = "confirmButton"
	cancelButton.id = "cancelButton"
	resetButton.id = "resetButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_HUDBounds_Buttons.__onClose = function(f11_arg0)
	f11_arg0.confirmButton:close()
	f11_arg0.cancelButton:close()
	f11_arg0.resetButton:close()
end
