require("ui/uieditor/widgets/bumperbuttonwithkeymouse")
CoD.StartMenu_Options_PrivacySettingsScrollPrompt = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.__defaultWidth = 300
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.__defaultHeight = 37
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PrivacySettingsScrollPrompt)
	self.id = "StartMenu_Options_PrivacySettingsScrollPrompt"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local currentItem = LUI.UIText.new(0.5, 0.5, -57, -12, 0.5, 0.5, -9, 9)
	currentItem:setAlpha(0.65)
	currentItem:setTTF("ttmussels_regular")
	currentItem:setAlignment(Enum.LUIAlignment[@"lui_alignment_right"])
	currentItem:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	currentItem:subscribeToGlobalModel(f1_arg1, "PrivacySettingManagementForm", "currentPage", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			currentItem:setText(f2_local0)
		end
	end)
	self:addElement(currentItem)
	self.currentItem = currentItem
	local dividor = LUI.UIText.new(0.5, 0.5, -4.5, 4.5, 0.5, 0.5, -9, 9)
	dividor:setAlpha(0.65)
	dividor:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mp/slash"))
	dividor:setTTF("ttmussels_regular")
	dividor:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	self:addElement(dividor)
	self.dividor = dividor
	local count = LUI.UIText.new(0.5, 0.5, 12, 57, 0.5, 0.5, -9, 9)
	count:setAlpha(0.65)
	count:setTTF("ttmussels_regular")
	count:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	count:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	count:subscribeToGlobalModel(f1_arg1, "PrivacySettingManagementForm", "lastPage", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			count:setText(f3_local0)
		end
	end)
	self:addElement(count)
	self.count = count
	local RightPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, 34.5, 101.5, 0, 0, -4, 31)
	RightPageOver.KeyMouseImage:setImage(RegisterImage("uie_bumperright"))
	RightPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RightPageOver.ControllerImage:setImage(RegisterImage(f4_local0))
		end
	end)
	RightPageOver:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	local f1_local5 = RightPageOver
	local LeftPageOver = RightPageOver.subscribeToModel
	local f1_local7 = Engine.GetModelForController(f1_arg1)
	LeftPageOver(f1_local5, f1_local7.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	f1_local5 = RightPageOver
	LeftPageOver = RightPageOver.subscribeToModel
	f1_local7 = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	LeftPageOver(f1_local5, f1_local7.currentPage, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	f1_local5 = RightPageOver
	LeftPageOver = RightPageOver.subscribeToModel
	f1_local7 = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	LeftPageOver(f1_local5, f1_local7.lastPage, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	RightPageOver:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RightPageOver, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		if IsGamepad(f10_arg2) and not CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(f10_arg2) then
			CoD.OptionsUtility.ChangePrivacySettingDescPage(f10_arg2, f10_arg1, "1")
			return true
		elseif IsMouseOrKeyboard(f10_arg2) and not CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(f10_arg2) then
			CoD.OptionsUtility.ChangePrivacySettingDescPage(f10_arg2, f10_arg1, "1")
			return true
		else
		end
	end, function(f11_arg0, f11_arg1, f11_arg2)
		if IsGamepad(f11_arg2) and not CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(f11_arg2) then
			CoD.Menu.SetButtonLabel(f11_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		elseif IsMouseOrKeyboard(f11_arg2) and not CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(f11_arg2) then
			CoD.Menu.SetButtonLabel(f11_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(RightPageOver)
	self.RightPageOver = RightPageOver
	LeftPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, -101.5, -34.5, 0, 0, -4, 31)
	LeftPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			LeftPageOver.ControllerImage:setImage(RegisterImage(f12_local0))
		end
	end)
	LeftPageOver:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f13_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	f1_local7 = LeftPageOver
	f1_local5 = LeftPageOver.subscribeToModel
	local f1_local8 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local7, f1_local8.LastInput, function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	f1_local7 = LeftPageOver
	f1_local5 = LeftPageOver.subscribeToModel
	f1_local8 = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	f1_local5(f1_local7, f1_local8.currentPage, function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	LeftPageOver:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LeftPageOver, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
		if IsGamepad(f17_arg2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f17_arg2, "PrivacySettingManagementForm", "currentPage", 1) then
			CoD.OptionsUtility.ChangePrivacySettingDescPage(f17_arg2, f17_arg1, "-1")
			return true
		elseif IsMouseOrKeyboard(f17_arg2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f17_arg2, "PrivacySettingManagementForm", "currentPage", 1) then
			CoD.OptionsUtility.ChangePrivacySettingDescPage(f17_arg2, f17_arg1, "-1")
			return true
		else
		end
	end, function(f18_arg0, f18_arg1, f18_arg2)
		if IsGamepad(f18_arg2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f18_arg2, "PrivacySettingManagementForm", "currentPage", 1) then
			CoD.Menu.SetButtonLabel(f18_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		elseif IsMouseOrKeyboard(f18_arg2) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f18_arg2, "PrivacySettingManagementForm", "currentPage", 1) then
			CoD.Menu.SetButtonLabel(f18_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(LeftPageOver)
	self.LeftPageOver = LeftPageOver
	self:mergeStateConditions({
		{
			stateName = "AtLeftAndRight",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueLessThan(f1_arg1, "PrivacySettingManagementForm", "lastPage", 2)
			end,
		},
		{
			stateName = "AtLeft",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "PrivacySettingManagementForm", "currentPage", 1)
			end,
		},
		{
			stateName = "AtRight",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.IsOnLastPrivacySettingsDescPage(f1_arg1)
			end,
		},
	})
	f1_local7 = self
	f1_local5 = self.subscribeToModel
	f1_local8 = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	f1_local5(f1_local7, f1_local8.lastPage, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "lastPage",
		})
	end, false)
	f1_local7 = self
	f1_local5 = self.subscribeToModel
	f1_local8 = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	f1_local5(f1_local7, f1_local8.currentPage, function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "currentPage",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f24_arg2, f24_arg3, f24_arg4)
		if IsSelfInState(self, "AtLeft") then
			MakeElementFocusable(self, "RightPageOver", controller)
			MakeElementNotFocusable(self, "LeftPageOver", controller)
		elseif IsSelfInState(self, "AtRight") then
			MakeElementFocusable(self, "LeftPageOver", controller)
			MakeElementNotFocusable(self, "RightPageOver", controller)
		else
			MakeElementFocusable(self, "RightPageOver", controller)
			MakeElementFocusable(self, "LeftPageOver", controller)
		end
	end)
	if CoD.isPC then
		RightPageOver.id = "RightPageOver"
	end
	if CoD.isPC then
		LeftPageOver.id = "LeftPageOver"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.__resetProperties = function(f25_arg0)
	f25_arg0.currentItem:completeAnimation()
	f25_arg0.dividor:completeAnimation()
	f25_arg0.count:completeAnimation()
	f25_arg0.LeftPageOver:completeAnimation()
	f25_arg0.RightPageOver:completeAnimation()
	f25_arg0.currentItem:setAlpha(0.65)
	f25_arg0.dividor:setAlpha(0.65)
	f25_arg0.count:setAlpha(0.65)
	f25_arg0.LeftPageOver:setAlpha(1)
	f25_arg0.RightPageOver:setAlpha(1)
end
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.currentItem:completeAnimation()
			f26_arg0.currentItem:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.currentItem)
			f26_arg0.dividor:completeAnimation()
			f26_arg0.dividor:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.dividor)
			f26_arg0.count:completeAnimation()
			f26_arg0.count:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.count)
		end,
	},
	AtLeftAndRight = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(5)
			f27_arg0.currentItem:completeAnimation()
			f27_arg0.currentItem:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.currentItem)
			f27_arg0.dividor:completeAnimation()
			f27_arg0.dividor:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.dividor)
			f27_arg0.count:completeAnimation()
			f27_arg0.count:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.count)
			f27_arg0.RightPageOver:completeAnimation()
			f27_arg0.RightPageOver:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RightPageOver)
			f27_arg0.LeftPageOver:completeAnimation()
			f27_arg0.LeftPageOver:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.LeftPageOver)
		end,
	},
	AtLeft = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(4)
			f28_arg0.currentItem:completeAnimation()
			f28_arg0.currentItem:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.currentItem)
			f28_arg0.dividor:completeAnimation()
			f28_arg0.dividor:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.dividor)
			f28_arg0.count:completeAnimation()
			f28_arg0.count:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.count)
			f28_arg0.LeftPageOver:completeAnimation()
			f28_arg0.LeftPageOver:setAlpha(0.3)
			f28_arg0.clipFinished(f28_arg0.LeftPageOver)
		end,
	},
	AtRight = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(4)
			f29_arg0.currentItem:completeAnimation()
			f29_arg0.currentItem:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.currentItem)
			f29_arg0.dividor:completeAnimation()
			f29_arg0.dividor:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.dividor)
			f29_arg0.count:completeAnimation()
			f29_arg0.count:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.count)
			f29_arg0.RightPageOver:completeAnimation()
			f29_arg0.RightPageOver:setAlpha(0.3)
			f29_arg0.clipFinished(f29_arg0.RightPageOver)
		end,
	},
}
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.__onClose = function(f30_arg0)
	f30_arg0.currentItem:close()
	f30_arg0.count:close()
	f30_arg0.RightPageOver:close()
	f30_arg0.LeftPageOver:close()
end
