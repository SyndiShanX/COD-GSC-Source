require("x64:1f846296f1a1b81")
CoD.StartMenu_Options_PrivacySettingsButton = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_PrivacySettingsButton.__defaultWidth = 514
CoD.StartMenu_Options_PrivacySettingsButton.__defaultHeight = 69
CoD.StartMenu_Options_PrivacySettingsButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_PrivacySettingsButton)
	self.id = "StartMenu_Options_PrivacySettingsButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomStartButton = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorCustomStartButton:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	DirectorCustomStartButton.SceneBlur:setAlpha(0)
	DirectorCustomStartButton.Tint:setRGB(0.05, 0.08, 0.11)
	DirectorCustomStartButton.Tint:setAlpha(0.25)
	DirectorCustomStartButton.LeaderActivityText:setText("")
	DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x5EB6FED86163697))
	DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x5EB6FED86163697))
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.OptionsUtility.ShowPrivacySettingsButton(f1_arg1)
			end,
		},
	})
	DirectorCustomStartButton.id = "DirectorCustomStartButton"
	self.__defaultFocus = DirectorCustomStartButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_PrivacySettingsButton.__resetProperties = function(f5_arg0)
	f5_arg0.DirectorCustomStartButton:completeAnimation()
	f5_arg0.DirectorCustomStartButton:setAlpha(1)
	f5_arg0.DirectorCustomStartButton:setScale(1, 1)
end
CoD.StartMenu_Options_PrivacySettingsButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DirectorCustomStartButton:completeAnimation()
			f6_arg0.DirectorCustomStartButton:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.DirectorCustomStartButton)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.DirectorCustomStartButton:completeAnimation()
			f8_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.DirectorCustomStartButton)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f9_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f9_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.DirectorCustomStartButton:completeAnimation()
			f9_arg0.DirectorCustomStartButton:setScale(1, 1)
			f9_local0(f9_arg0.DirectorCustomStartButton)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f11_arg0.DirectorCustomStartButton:setScale(1, 1)
				f11_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DirectorCustomStartButton:completeAnimation()
			f11_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f11_local0(f11_arg0.DirectorCustomStartButton)
		end,
	},
}
CoD.StartMenu_Options_PrivacySettingsButton.__onClose = function(f13_arg0)
	f13_arg0.DirectorCustomStartButton:close()
end
