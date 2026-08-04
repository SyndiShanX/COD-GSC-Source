require("ui/uieditor/widgets/customgames/customgames_settingbutton_internal")
CoD.CustomGames_SettingButton = InheritFrom(LUI.UIElement)
CoD.CustomGames_SettingButton.__defaultWidth = 500
CoD.CustomGames_SettingButton.__defaultHeight = 60
CoD.CustomGames_SettingButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomGames_SettingButton)
	self.id = "CustomGames_SettingButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuOptionsSettingSlider = CoD.CustomGames_SettingButton_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 0, 60)
	StartMenuOptionsSettingSlider:linkToElementModel(self, nil, false, function(model)
		StartMenuOptionsSettingSlider:setModel(model, f1_arg1)
	end)
	self:addElement(StartMenuOptionsSettingSlider)
	self.StartMenuOptionsSettingSlider = StartMenuOptionsSettingSlider
	StartMenuOptionsSettingSlider.id = "StartMenuOptionsSettingSlider"
	self.__defaultFocus = StartMenuOptionsSettingSlider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomGames_SettingButton.__resetProperties = function(f3_arg0)
	f3_arg0.StartMenuOptionsSettingSlider:completeAnimation()
	f3_arg0.StartMenuOptionsSettingSlider:setScale(1, 1)
end
CoD.CustomGames_SettingButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.StartMenuOptionsSettingSlider:completeAnimation()
			f5_arg0.StartMenuOptionsSettingSlider:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.StartMenuOptionsSettingSlider)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.StartMenuOptionsSettingSlider:beginAnimation(200)
				f6_arg0.StartMenuOptionsSettingSlider:setScale(1.05, 1.05)
				f6_arg0.StartMenuOptionsSettingSlider:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.StartMenuOptionsSettingSlider:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.StartMenuOptionsSettingSlider:completeAnimation()
			f6_arg0.StartMenuOptionsSettingSlider:setScale(1, 1)
			f6_local0(f6_arg0.StartMenuOptionsSettingSlider)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.StartMenuOptionsSettingSlider:beginAnimation(200)
				f8_arg0.StartMenuOptionsSettingSlider:setScale(1, 1)
				f8_arg0.StartMenuOptionsSettingSlider:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.StartMenuOptionsSettingSlider:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.StartMenuOptionsSettingSlider:completeAnimation()
			f8_arg0.StartMenuOptionsSettingSlider:setScale(1.05, 1.05)
			f8_local0(f8_arg0.StartMenuOptionsSettingSlider)
		end,
	},
}
CoD.CustomGames_SettingButton.__onClose = function(f10_arg0)
	f10_arg0.StartMenuOptionsSettingSlider:close()
end
