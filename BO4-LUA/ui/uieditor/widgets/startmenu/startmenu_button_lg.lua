require("x64:b5f9bf60f47a122")
CoD.StartMenu_Button_LG = InheritFrom(LUI.UIElement)
CoD.StartMenu_Button_LG.__defaultWidth = 543
CoD.StartMenu_Button_LG.__defaultHeight = 444
CoD.StartMenu_Button_LG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Button_LG)
	self.id = "StartMenu_Button_LG"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonInternal = CoD.StartMenu_Button_LG_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(ButtonInternal)
	self.ButtonInternal = ButtonInternal
	ButtonInternal.id = "ButtonInternal"
	self.__defaultFocus = ButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SyncChildStateToSelfState(self, f1_arg1, self.ButtonInternal)
	return self
end
CoD.StartMenu_Button_LG.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonInternal:completeAnimation()
	f2_arg0.ButtonInternal:setScale(1, 1)
end
CoD.StartMenu_Button_LG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ButtonInternal:completeAnimation()
			f4_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f4_arg0.ButtonInternal:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.ButtonInternal:beginAnimation(200)
				f5_arg0.ButtonInternal:setScale(1.05, 1.05)
				f5_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f5_arg0.clipFinished(element, event)
				end)
			end
			f5_arg0.ButtonInternal:completeAnimation()
			f5_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f5_arg0.ButtonInternal:setScale(1, 1)
			f5_local0(f5_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.ButtonInternal:beginAnimation(200)
				f8_arg0.ButtonInternal:setScale(1, 1)
				f8_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f8_arg0.clipFinished(element, event)
				end)
			end
			f8_arg0.ButtonInternal:completeAnimation()
			f8_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f8_arg0.ButtonInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.ButtonInternal)
		end,
	},
	Disabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.ButtonInternal:completeAnimation()
			f12_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f12_arg0.ButtonInternal:setScale(1.05, 1.05)
			f12_arg0.clipFinished(f12_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.ButtonInternal:beginAnimation(200)
				f13_arg0.ButtonInternal:setScale(1.05, 1.05)
				f13_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f13_arg0.clipFinished(element, event)
				end)
			end
			f13_arg0.ButtonInternal:completeAnimation()
			f13_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f13_arg0.ButtonInternal:setScale(1, 1)
			f13_local0(f13_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.ButtonInternal:beginAnimation(200)
				f16_arg0.ButtonInternal:setScale(1, 1)
				f16_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f16_arg0.clipFinished(element, event)
				end)
			end
			f16_arg0.ButtonInternal:completeAnimation()
			f16_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f16_arg0.ButtonInternal:setScale(1.05, 1.05)
			f16_local0(f16_arg0.ButtonInternal)
		end,
	},
	OnlineOnly = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.ButtonInternal:completeAnimation()
			f20_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f20_arg0.ButtonInternal:setScale(1.05, 1.05)
			f20_arg0.clipFinished(f20_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.ButtonInternal:beginAnimation(200)
				f21_arg0.ButtonInternal:setScale(1.05, 1.05)
				f21_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f21_arg0.clipFinished(element, event)
				end)
			end
			f21_arg0.ButtonInternal:completeAnimation()
			f21_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f21_arg0.ButtonInternal:setScale(1, 1)
			f21_local0(f21_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.ButtonInternal:beginAnimation(200)
				f24_arg0.ButtonInternal:setScale(1, 1)
				f24_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f24_arg0.clipFinished(element, event)
				end)
			end
			f24_arg0.ButtonInternal:completeAnimation()
			f24_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f24_arg0.ButtonInternal:setScale(1.05, 1.05)
			f24_local0(f24_arg0.ButtonInternal)
		end,
	},
	ComingSoon = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.ButtonInternal:completeAnimation()
			f28_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f28_arg0.ButtonInternal:setScale(1.05, 1.05)
			f28_arg0.clipFinished(f28_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.ButtonInternal:beginAnimation(200)
				f29_arg0.ButtonInternal:setScale(1.05, 1.05)
				f29_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f29_arg0.clipFinished(element, event)
				end)
			end
			f29_arg0.ButtonInternal:completeAnimation()
			f29_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f29_arg0.ButtonInternal:setScale(1, 1)
			f29_local0(f29_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			local f32_local0 = function(f33_arg0)
				f32_arg0.ButtonInternal:beginAnimation(200)
				f32_arg0.ButtonInternal:setScale(1, 1)
				f32_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", function(element, event)
					f32_arg0.clipFinished(element, event)
				end)
			end
			f32_arg0.ButtonInternal:completeAnimation()
			f32_arg0.ButtonInternal.StartMenuButtonFrame:completeAnimation()
			f32_arg0.ButtonInternal:setScale(1.05, 1.05)
			f32_local0(f32_arg0.ButtonInternal)
		end,
	},
}
CoD.StartMenu_Button_LG.__onClose = function(f35_arg0)
	f35_arg0.ButtonInternal:close()
end
