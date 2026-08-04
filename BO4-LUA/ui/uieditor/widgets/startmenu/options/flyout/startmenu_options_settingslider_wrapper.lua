require("ui/uieditor/widgets/startmenu/options/flyout/startmenu_options_settingslider")
CoD.StartMenu_Options_SettingSlider_Wrapper = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SettingSlider_Wrapper.__defaultWidth = 700
CoD.StartMenu_Options_SettingSlider_Wrapper.__defaultHeight = 46
CoD.StartMenu_Options_SettingSlider_Wrapper.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SettingSlider_Wrapper)
	self.id = "StartMenu_Options_SettingSlider_Wrapper"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuOptionsSettingSlider = CoD.StartMenu_Options_SettingSlider.new(f1_arg0, f1_arg1, 0, 0, 0, 700, 0, 0, 0, 46)
	self:addElement(StartMenuOptionsSettingSlider)
	self.StartMenuOptionsSettingSlider = StartMenuOptionsSettingSlider
	self.StartMenuOptionsSettingSlider:linkToElementModel(self, nil, false, function(model)
		StartMenuOptionsSettingSlider:setModel(model, f1_arg1)
	end)
	StartMenuOptionsSettingSlider.id = "StartMenuOptionsSettingSlider"
	self.__defaultFocus = StartMenuOptionsSettingSlider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SettingSlider_Wrapper.__resetProperties = function(f3_arg0)
	f3_arg0.StartMenuOptionsSettingSlider:completeAnimation()
	f3_arg0.StartMenuOptionsSettingSlider:setScale(1, 1)
end
CoD.StartMenu_Options_SettingSlider_Wrapper.__clipsPerState = {
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
CoD.StartMenu_Options_SettingSlider_Wrapper.__onClose = function(f10_arg0)
	f10_arg0.StartMenuOptionsSettingSlider:close()
end
