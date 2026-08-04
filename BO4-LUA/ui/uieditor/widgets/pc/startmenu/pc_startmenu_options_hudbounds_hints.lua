require("ui/uieditor/widgets/systemoverlays/featureoverlay_button")
require("ui/uieditor/widgets/pc/startmenu/pc_flexibleverticaltextblock")
require("ui/uieditor/widgets/pc/startmenu/pc_flexibleverticaltextblock_title")
CoD.PC_StartMenu_Options_HUDBounds_Hints = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_HUDBounds_Hints.__defaultWidth = 762
CoD.PC_StartMenu_Options_HUDBounds_Hints.__defaultHeight = 1080
CoD.PC_StartMenu_Options_HUDBounds_Hints.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_HUDBounds_Hints)
	self.id = "PC_StartMenu_Options_HUDBounds_Hints"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Title = nil
	Title = CoD.PC_FlexibleVerticalTextBlock_Title.new(f1_arg0, f1_arg1, 0, 0, 0, 762, 0, 0, 384, 449)
	Title:setRGB(0.88, 0.88, 0.88)
	Title.Text:setText(Engine[@"hash_4F9F1239CFD921FE"]("options/pc_hud_bounds"))
	self:addElement(Title)
	self.Title = Title
	local Description = nil
	Description = CoD.PC_FlexibleVerticalTextBlock.new(f1_arg0, f1_arg1, 0, 0, 0, 762, 0, 0, 499, 524)
	Description:setRGB(0.51, 0.51, 0.51)
	Description.Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_31595AE9DC82ED99"))
	self:addElement(Description)
	self.Description = Description
	local Hints = nil
	Hints = CoD.PC_FlexibleVerticalTextBlock.new(f1_arg0, f1_arg1, 0, 0, 0, 762, 0, 0, 574, 584)
	Hints:setRGB(0.51, 0.51, 0.51)
	Hints:setAlpha(0)
	Hints.Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_710C2584D47698D1"))
	self:addElement(Hints)
	self.Hints = Hints
	local confirmButton = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 0, 0, 25.5, 255.5, 0, 0, 624, 684)
	confirmButton.ButtonContainer.Blur:setAlpha(0)
	confirmButton.ButtonContainer.Title:setText(LocalizeToUpperString(@"hash_67D14DF1D6CBE990"))
	confirmButton.ButtonContainer.Icon:setRGB(0.4, 0.55, 0.22)
	confirmButton.ButtonContainer.Icon:setImage(RegisterImage("uie_success_icon"))
	confirmButton:registerEventHandler("gain_focus", function(element, event)
		local f2_local0 = nil
		if element.gainFocus then
			f2_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f2_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(confirmButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		DispatchEventToRoot(self, "update_safe_area", f3_arg2)
		GoBack(self, f3_arg2)
		return true
	end, function(f4_arg0, f4_arg1, f4_arg2)
		CoD.Menu.SetButtonLabel(f4_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(confirmButton)
	self.confirmButton = confirmButton
	local cancelButton = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 0.5, 0.5, -115.5, 114.5, 0, 0, 624, 684)
	cancelButton.ButtonContainer.Blur:setAlpha(0)
	cancelButton.ButtonContainer.Title:setText(LocalizeToUpperString(@"menu/cancel"))
	cancelButton.ButtonContainer.Icon:setRGB(0.72, 0.21, 0.21)
	cancelButton.ButtonContainer.Icon:setImage(RegisterImage("uie_error_icon"))
	cancelButton:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(cancelButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
		SetSafeArea(self, f6_arg1, f6_arg2, "HUDBoundsTweakable_vertical", CoD.SafeArea.InitialY)
		SetSafeArea(self, f6_arg1, f6_arg2, "HUDBoundsTweakable_horizontal", CoD.SafeArea.InitialX)
		DispatchEventToRoot(self, "update_safe_area", f6_arg2)
		GoBack(self, f6_arg2)
		return true
	end, function(f7_arg0, f7_arg1, f7_arg2)
		CoD.Menu.SetButtonLabel(f7_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(cancelButton)
	self.cancelButton = cancelButton
	local resetButton = CoD.featureOverlay_Button.new(f1_arg0, f1_arg1, 1, 1, -255.5, -25.5, 0, 0, 624, 684)
	resetButton.ButtonContainer.Blur:setAlpha(0)
	resetButton.ButtonContainer.Title:setText(LocalizeToUpperString("options/reset"))
	resetButton.ButtonContainer.Icon:setRGB(0.42, 0.42, 0.42)
	resetButton.ButtonContainer.Icon:setImage(RegisterImage("uie_reset_icon"))
	resetButton:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(resetButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		ResetSafeAreaHorizontal(self, self, f9_arg2)
		SetSafeArea(self, self, f9_arg2, "HUDBoundsTweakable_vertical", CoD.SafeArea.Maximum)
		DispatchEventToRoot(f9_arg0, "update_safe_area", f9_arg2)
		GoBack(self, f9_arg2)
		return true
	end, function(f10_arg0, f10_arg1, f10_arg2)
		CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(resetButton)
	self.resetButton = resetButton
	self:mergeStateConditions({
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f12_arg1)
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	confirmButton.id = "confirmButton"
	cancelButton.id = "cancelButton"
	resetButton.id = "resetButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_HUDBounds_Hints.__resetProperties = function(f14_arg0)
	f14_arg0.Hints:completeAnimation()
	f14_arg0.confirmButton:completeAnimation()
	f14_arg0.cancelButton:completeAnimation()
	f14_arg0.resetButton:completeAnimation()
	f14_arg0.Hints:setAlpha(0)
	f14_arg0.Hints.Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_710C2584D47698D1"))
	f14_arg0.confirmButton:setAlpha(1)
	f14_arg0.cancelButton:setAlpha(1)
	f14_arg0.resetButton:setAlpha(1)
end
CoD.PC_StartMenu_Options_HUDBounds_Hints.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.Title:completeAnimation()
			f15_arg0.clipFinished(f15_arg0.Title)
			f15_arg0.Hints:completeAnimation()
			f15_arg0.Hints:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Hints)
		end,
	},
	Gamepad = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.Hints:completeAnimation()
			f16_arg0.Hints.Text:completeAnimation()
			f16_arg0.Hints:setAlpha(1)
			f16_arg0.Hints.Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_61F6665A4B327348"))
			f16_arg0.clipFinished(f16_arg0.Hints)
			f16_arg0.confirmButton:completeAnimation()
			f16_arg0.confirmButton:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.confirmButton)
			f16_arg0.cancelButton:completeAnimation()
			f16_arg0.cancelButton:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.cancelButton)
			f16_arg0.resetButton:completeAnimation()
			f16_arg0.resetButton:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.resetButton)
		end,
	},
}
CoD.PC_StartMenu_Options_HUDBounds_Hints.__onClose = function(f17_arg0)
	f17_arg0.Title:close()
	f17_arg0.Description:close()
	f17_arg0.Hints:close()
	f17_arg0.confirmButton:close()
	f17_arg0.cancelButton:close()
	f17_arg0.resetButton:close()
end
