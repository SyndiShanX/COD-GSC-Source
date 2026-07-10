require("x64:fde866f355717bc")
CoD.Prestige_PlayerLevelButton = InheritFrom(LUI.UIElement)
CoD.Prestige_PlayerLevelButton.__defaultWidth = 346
CoD.Prestige_PlayerLevelButton.__defaultHeight = 57
CoD.Prestige_PlayerLevelButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_PlayerLevelButton)
	self.id = "Prestige_PlayerLevelButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonButtonOutlineThin = CoD.Prestige_PlayerLevelButtonInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 346, 0, 0, 0, 57)
	self:addElement(CommonButtonOutlineThin)
	self.CommonButtonOutlineThin = CommonButtonOutlineThin
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f2_arg2, f2_arg3, f2_arg4)
		if IsSelfInState(self, "UnlockTokenIndicator") then
			SetElementState(self, self.CommonButtonOutlineThin, controller, "UnlockTokenIndicator")
		end
	end)
	CommonButtonOutlineThin.id = "CommonButtonOutlineThin"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SyncChildStateToSelfState(self, f1_arg1, self.CommonButtonOutlineThin)
	return self
end
CoD.Prestige_PlayerLevelButton.__resetProperties = function(f3_arg0)
	f3_arg0.CommonButtonOutlineThin:completeAnimation()
	f3_arg0.CommonButtonOutlineThin:setScale(1, 1)
end
CoD.Prestige_PlayerLevelButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.CommonButtonOutlineThin:completeAnimation()
			f4_arg0.CommonButtonOutlineThin:setScale(0.98, 0.95)
			f4_arg0.clipFinished(f4_arg0.CommonButtonOutlineThin)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.CommonButtonOutlineThin:completeAnimation()
			f5_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
			f5_arg0.clipFinished(f5_arg0.CommonButtonOutlineThin)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.CommonButtonOutlineThin:beginAnimation(150)
				f6_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
				f6_arg0.CommonButtonOutlineThin:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.CommonButtonOutlineThin:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.CommonButtonOutlineThin:completeAnimation()
			f6_arg0.CommonButtonOutlineThin:setScale(0.98, 0.95)
			f6_local0(f6_arg0.CommonButtonOutlineThin)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.CommonButtonOutlineThin:beginAnimation(100)
				f8_arg0.CommonButtonOutlineThin:setScale(0.98, 0.95)
				f8_arg0.CommonButtonOutlineThin:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.CommonButtonOutlineThin:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.CommonButtonOutlineThin:completeAnimation()
			f8_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
			f8_local0(f8_arg0.CommonButtonOutlineThin)
		end,
	},
	TextOnly = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.CommonButtonOutlineThin:completeAnimation()
			f11_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
			f11_arg0.clipFinished(f11_arg0.CommonButtonOutlineThin)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.CommonButtonOutlineThin:beginAnimation(150)
				f12_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
				f12_arg0.CommonButtonOutlineThin:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CommonButtonOutlineThin:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.CommonButtonOutlineThin:completeAnimation()
			f12_arg0.CommonButtonOutlineThin:setScale(1, 1)
			f12_local0(f12_arg0.CommonButtonOutlineThin)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.CommonButtonOutlineThin:beginAnimation(100)
				f14_arg0.CommonButtonOutlineThin:setScale(1, 1)
				f14_arg0.CommonButtonOutlineThin:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.CommonButtonOutlineThin:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.CommonButtonOutlineThin:completeAnimation()
			f14_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
			f14_local0(f14_arg0.CommonButtonOutlineThin)
		end,
	},
	QuantityActive = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.CommonButtonOutlineThin:completeAnimation()
			f17_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
			f17_arg0.clipFinished(f17_arg0.CommonButtonOutlineThin)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.CommonButtonOutlineThin:beginAnimation(150)
				f18_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
				f18_arg0.CommonButtonOutlineThin:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.CommonButtonOutlineThin:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.CommonButtonOutlineThin:completeAnimation()
			f18_arg0.CommonButtonOutlineThin:setScale(1, 1)
			f18_local0(f18_arg0.CommonButtonOutlineThin)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.CommonButtonOutlineThin:beginAnimation(100)
				f20_arg0.CommonButtonOutlineThin:setScale(1, 1)
				f20_arg0.CommonButtonOutlineThin:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.CommonButtonOutlineThin:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.CommonButtonOutlineThin:completeAnimation()
			f20_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
			f20_local0(f20_arg0.CommonButtonOutlineThin)
		end,
	},
	IconOnly = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.CommonButtonOutlineThin:completeAnimation()
			f23_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
			f23_arg0.clipFinished(f23_arg0.CommonButtonOutlineThin)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.CommonButtonOutlineThin:beginAnimation(150)
				f24_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
				f24_arg0.CommonButtonOutlineThin:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.CommonButtonOutlineThin:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.CommonButtonOutlineThin:completeAnimation()
			f24_arg0.CommonButtonOutlineThin:setScale(1, 1)
			f24_local0(f24_arg0.CommonButtonOutlineThin)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.CommonButtonOutlineThin:beginAnimation(100)
				f26_arg0.CommonButtonOutlineThin:setScale(1, 1)
				f26_arg0.CommonButtonOutlineThin:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.CommonButtonOutlineThin:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.CommonButtonOutlineThin:completeAnimation()
			f26_arg0.CommonButtonOutlineThin:setScale(1.03, 1.05)
			f26_local0(f26_arg0.CommonButtonOutlineThin)
		end,
	},
	Hidden = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	UnlockTokenIndicator = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Prestige_PlayerLevelButton.__onClose = function(f30_arg0)
	f30_arg0.CommonButtonOutlineThin:close()
end
