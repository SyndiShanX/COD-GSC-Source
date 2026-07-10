require("x64:a969a8392712433")
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
	currentItem:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	currentItem:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
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
	dividor:setText(Engine[0xF9F1239CFD921FE](0x993C1A7DD3452BA))
	dividor:setTTF("ttmussels_regular")
	dividor:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(dividor)
	self.dividor = dividor
	local count = LUI.UIText.new(0.5, 0.5, 12, 57, 0.5, 0.5, -9, 9)
	count:setAlpha(0.65)
	count:setTTF("ttmussels_regular")
	count:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	count:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	count:subscribeToGlobalModel(f1_arg1, "PrivacySettingManagementForm", "lastPage", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			count:setText(f3_local0)
		end
	end)
	self:addElement(count)
	self.count = count
	local RightPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, 34.5, 101.5, 0, 0, -4, 31)
	RightPageOver.KeyMouseImage:setImage(RegisterImage(0x49AC5C845C7E582))
	RightPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RightPageOver.ControllerImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(RightPageOver)
	self.RightPageOver = RightPageOver
	local LeftPageOver = CoD.BumperButtonWithKeyMouse.new(f1_arg0, f1_arg1, 0.5, 0.5, -101.5, -34.5, 0, 0, -4, 31)
	LeftPageOver:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			LeftPageOver.ControllerImage:setImage(RegisterImage(f5_local0))
		end
	end)
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
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.lastPage, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lastPage",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.currentPage, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "currentPage",
		})
	end, false)
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
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.__resetProperties = function(f11_arg0)
	f11_arg0.currentItem:completeAnimation()
	f11_arg0.dividor:completeAnimation()
	f11_arg0.count:completeAnimation()
	f11_arg0.LeftPageOver:completeAnimation()
	f11_arg0.RightPageOver:completeAnimation()
	f11_arg0.currentItem:setAlpha(0.65)
	f11_arg0.dividor:setAlpha(0.65)
	f11_arg0.count:setAlpha(0.65)
	f11_arg0.LeftPageOver:setAlpha(1)
	f11_arg0.RightPageOver:setAlpha(1)
end
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.currentItem:completeAnimation()
			f12_arg0.currentItem:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.currentItem)
			f12_arg0.dividor:completeAnimation()
			f12_arg0.dividor:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.dividor)
			f12_arg0.count:completeAnimation()
			f12_arg0.count:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.count)
		end,
	},
	AtLeftAndRight = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			f13_arg0.currentItem:completeAnimation()
			f13_arg0.currentItem:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.currentItem)
			f13_arg0.dividor:completeAnimation()
			f13_arg0.dividor:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.dividor)
			f13_arg0.count:completeAnimation()
			f13_arg0.count:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.count)
			f13_arg0.RightPageOver:completeAnimation()
			f13_arg0.RightPageOver:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RightPageOver)
			f13_arg0.LeftPageOver:completeAnimation()
			f13_arg0.LeftPageOver:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LeftPageOver)
		end,
	},
	AtLeft = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.currentItem:completeAnimation()
			f14_arg0.currentItem:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.currentItem)
			f14_arg0.dividor:completeAnimation()
			f14_arg0.dividor:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.dividor)
			f14_arg0.count:completeAnimation()
			f14_arg0.count:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.count)
			f14_arg0.LeftPageOver:completeAnimation()
			f14_arg0.LeftPageOver:setAlpha(0.3)
			f14_arg0.clipFinished(f14_arg0.LeftPageOver)
		end,
	},
	AtRight = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.currentItem:completeAnimation()
			f15_arg0.currentItem:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.currentItem)
			f15_arg0.dividor:completeAnimation()
			f15_arg0.dividor:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.dividor)
			f15_arg0.count:completeAnimation()
			f15_arg0.count:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.count)
			f15_arg0.RightPageOver:completeAnimation()
			f15_arg0.RightPageOver:setAlpha(0.3)
			f15_arg0.clipFinished(f15_arg0.RightPageOver)
		end,
	},
}
CoD.StartMenu_Options_PrivacySettingsScrollPrompt.__onClose = function(f16_arg0)
	f16_arg0.currentItem:close()
	f16_arg0.count:close()
	f16_arg0.RightPageOver:close()
	f16_arg0.LeftPageOver:close()
end
