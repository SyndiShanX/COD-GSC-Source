require("x64:30c1a62ca1c0f66")
CoD.DirectorSimpleButton = InheritFrom(LUI.UIElement)
CoD.DirectorSimpleButton.__defaultWidth = 374
CoD.DirectorSimpleButton.__defaultHeight = 92
CoD.DirectorSimpleButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorSimpleButton)
	self.id = "DirectorSimpleButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomStartButton = CoD.DirectorSelectButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
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
	DirectorCustomStartButton.LeaderActivityText:setAlpha(0)
	DirectorCustomStartButton.LeaderActivityText:setText("")
	DirectorCustomStartButton.Header:setAlpha(0)
	DirectorCustomStartButton.Header:setText(LocalizeToUpperString(0x0))
	DirectorCustomStartButton.MiddleText:setAlpha(0)
	DirectorCustomStartButton.MiddleText:setText("")
	DirectorCustomStartButton:linkToElementModel(self, "iconBackground", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DirectorCustomStartButton.ImageNotFocus:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	local PlayText = LUI.UIText.new(0, 1, 0, 0, 0.56, 0.56, -12, 12)
	PlayText:setText(LocalizeToUpperString(@"menu/play"))
	PlayText:setTTF("ttmussels_demibold")
	PlayText:setLetterSpacing(6)
	PlayText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PlayText)
	self.PlayText = PlayText
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Available",
			condition = function(menu, element, event)
				return true
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
CoD.DirectorSimpleButton.__resetProperties = function(f8_arg0)
	f8_arg0.DirectorCustomStartButton:completeAnimation()
	f8_arg0.PlayText:completeAnimation()
	f8_arg0.DirectorCustomStartButton:setRGB(1, 1, 1)
	f8_arg0.DirectorCustomStartButton:setAlpha(1)
	f8_arg0.DirectorCustomStartButton:setScale(1, 1)
	f8_arg0.PlayText:setRGB(1, 1, 1)
	f8_arg0.PlayText:setAlpha(1)
	f8_arg0.PlayText:setScale(1, 1)
end
CoD.DirectorSimpleButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.DirectorCustomStartButton:completeAnimation()
			f10_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.DirectorCustomStartButton)
			f10_arg0.PlayText:completeAnimation()
			f10_arg0.PlayText:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.PlayText)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f11_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f11_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DirectorCustomStartButton:completeAnimation()
			f11_arg0.DirectorCustomStartButton:setScale(1, 1)
			f11_local0(f11_arg0.DirectorCustomStartButton)
			local f11_local1 = function(f13_arg0)
				f11_arg0.PlayText:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f11_arg0.PlayText:setScale(1.05, 1.05)
				f11_arg0.PlayText:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.PlayText:completeAnimation()
			f11_arg0.PlayText:setScale(1, 1)
			f11_local1(f11_arg0.PlayText)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f14_arg0.DirectorCustomStartButton:setScale(1, 1)
				f14_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.DirectorCustomStartButton:completeAnimation()
			f14_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f14_local0(f14_arg0.DirectorCustomStartButton)
			local f14_local1 = function(f16_arg0)
				f14_arg0.PlayText:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f14_arg0.PlayText:setScale(1, 1)
				f14_arg0.PlayText:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.PlayText:completeAnimation()
			f14_arg0.PlayText:setScale(1.05, 1.05)
			f14_local1(f14_arg0.PlayText)
		end,
	},
	Disabled = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.DirectorCustomStartButton:completeAnimation()
			f17_arg0.DirectorCustomStartButton:setRGB(0.58, 0.58, 0.58)
			f17_arg0.clipFinished(f17_arg0.DirectorCustomStartButton)
			f17_arg0.PlayText:completeAnimation()
			f17_arg0.PlayText:setRGB(0.59, 0.59, 0.59)
			f17_arg0.PlayText:setAlpha(0.15)
			f17_arg0.clipFinished(f17_arg0.PlayText)
		end,
	},
	Hidden = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.DirectorCustomStartButton:completeAnimation()
			f18_arg0.DirectorCustomStartButton:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.DirectorCustomStartButton)
			f18_arg0.PlayText:completeAnimation()
			f18_arg0.PlayText:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.PlayText)
		end,
	},
	Available = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.DirectorCustomStartButton:completeAnimation()
			f20_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f20_arg0.clipFinished(f20_arg0.DirectorCustomStartButton)
			f20_arg0.PlayText:completeAnimation()
			f20_arg0.PlayText:setScale(1.05, 1.05)
			f20_arg0.clipFinished(f20_arg0.PlayText)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f21_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f21_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.DirectorCustomStartButton:completeAnimation()
			f21_arg0.DirectorCustomStartButton:setScale(1, 1)
			f21_local0(f21_arg0.DirectorCustomStartButton)
			local f21_local1 = function(f23_arg0)
				f21_arg0.PlayText:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f21_arg0.PlayText:setScale(1.05, 1.05)
				f21_arg0.PlayText:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.PlayText:completeAnimation()
			f21_arg0.PlayText:setScale(1, 1)
			f21_local1(f21_arg0.PlayText)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.DirectorCustomStartButton:setScale(1, 1)
				f24_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.DirectorCustomStartButton:completeAnimation()
			f24_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f24_local0(f24_arg0.DirectorCustomStartButton)
			local f24_local1 = function(f26_arg0)
				f24_arg0.PlayText:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.PlayText:setScale(1, 1)
				f24_arg0.PlayText:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.PlayText:completeAnimation()
			f24_arg0.PlayText:setScale(1.05, 1.05)
			f24_local1(f24_arg0.PlayText)
		end,
	},
}
CoD.DirectorSimpleButton.__onClose = function(f27_arg0)
	f27_arg0.DirectorCustomStartButton:close()
end
