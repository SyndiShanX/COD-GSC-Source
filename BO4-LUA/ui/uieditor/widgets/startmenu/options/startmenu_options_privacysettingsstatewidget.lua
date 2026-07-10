CoD.StartMenu_Options_PrivacySettingsStateWidget = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PrivacySettingsStateWidget.__defaultWidth = 886
CoD.StartMenu_Options_PrivacySettingsStateWidget.__defaultHeight = 150
CoD.StartMenu_Options_PrivacySettingsStateWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.StartMenu_Options_PrivacySettingsStateWidget)
	self.id = "StartMenu_Options_PrivacySettingsStateWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpinnerFlipbook = LUI.UIImage.new(0.5, 0.5, -443, -293, 0.5, 0.5, -75, 75)
	SpinnerFlipbook:setRGB(1, 0.63, 0)
	SpinnerFlipbook:setImage(RegisterImage(0xD7107421B53850D))
	SpinnerFlipbook:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	SpinnerFlipbook:setShaderVector(0, 28, 0, 0, 0)
	SpinnerFlipbook:setShaderVector(1, 22, 0, 0, 0)
	self:addElement(SpinnerFlipbook)
	self.SpinnerFlipbook = SpinnerFlipbook
	local StateText = LUI.UIText.new(0.5, 0.5, -293, 443, 0.5, 0.5, -27, 27)
	StateText:setText(Engine[0xF9F1239CFD921FE](0xC1A66EFE0E4A93D))
	StateText:setTTF("ttmussels_regular")
	StateText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(StateText)
	self.StateText = StateText
	self:mergeStateConditions({
		{
			stateName = "InProgress",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0xB9DF5339B289B88])
			end,
		},
		{
			stateName = "Success",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0xDE287BA1764B6AE])
			end,
		},
		{
			stateName = "Failure",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "PrivacySettingManagementForm", "updateProgressState", Enum[0x65887EAAB38F9F8][0xF100F564F11A910])
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.PrivacySettingManagementForm.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.updateProgressState, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "updateProgressState",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PrivacySettingsStateWidget.__resetProperties = function(f6_arg0)
	f6_arg0.StateText:completeAnimation()
	f6_arg0.SpinnerFlipbook:completeAnimation()
	f6_arg0.StateText:setAlpha(1)
	f6_arg0.StateText:setText(Engine[0xF9F1239CFD921FE](0xC1A66EFE0E4A93D))
	f6_arg0.SpinnerFlipbook:setAlpha(1)
end
CoD.StartMenu_Options_PrivacySettingsStateWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.SpinnerFlipbook:completeAnimation()
			f7_arg0.SpinnerFlipbook:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.SpinnerFlipbook)
			f7_arg0.StateText:completeAnimation()
			f7_arg0.StateText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.StateText)
		end,
	},
	InProgress = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Success = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.SpinnerFlipbook:completeAnimation()
			f9_arg0.SpinnerFlipbook:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.SpinnerFlipbook)
			f9_arg0.StateText:completeAnimation()
			f9_arg0.StateText:setText(Engine[0xF9F1239CFD921FE](0x4B5DCFB002087D))
			f9_arg0.clipFinished(f9_arg0.StateText)
		end,
	},
	Failure = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.SpinnerFlipbook:completeAnimation()
			f10_arg0.SpinnerFlipbook:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.SpinnerFlipbook)
			f10_arg0.StateText:completeAnimation()
			f10_arg0.StateText:setText(Engine[0xF9F1239CFD921FE](0x296E6ABEFDAC42C))
			f10_arg0.clipFinished(f10_arg0.StateText)
		end,
	},
}
