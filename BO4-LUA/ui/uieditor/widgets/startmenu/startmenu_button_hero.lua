require("ui/uieditor/widgets/startmenu/startmenu_button_hero_internal")
CoD.StartMenu_Button_Hero = InheritFrom(LUI.UIElement)
CoD.StartMenu_Button_Hero.__defaultWidth = 1096
CoD.StartMenu_Button_Hero.__defaultHeight = 492
CoD.StartMenu_Button_Hero.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Button_Hero)
	self.id = "StartMenu_Button_Hero"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonInternal = CoD.StartMenu_Button_Hero_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
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
CoD.StartMenu_Button_Hero.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonInternal:completeAnimation()
	f2_arg0.ButtonInternal:setScale(1, 1)
end
CoD.StartMenu_Button_Hero.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ButtonInternal:completeAnimation()
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
				f5_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.ButtonInternal:completeAnimation()
			f5_arg0.ButtonInternal:setScale(1, 1)
			f5_local0(f5_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ButtonInternal:beginAnimation(200)
				f7_arg0.ButtonInternal:setScale(1, 1)
				f7_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ButtonInternal:completeAnimation()
			f7_arg0.ButtonInternal:setScale(1.05, 1.05)
			f7_local0(f7_arg0.ButtonInternal)
		end,
	},
	WZTrialUpsell = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ButtonInternal:completeAnimation()
			f10_arg0.ButtonInternal:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.ButtonInternal:beginAnimation(200)
				f11_arg0.ButtonInternal:setScale(1.05, 1.05)
				f11_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.ButtonInternal:completeAnimation()
			f11_arg0.ButtonInternal:setScale(1, 1)
			f11_local0(f11_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.ButtonInternal:beginAnimation(200)
				f13_arg0.ButtonInternal:setScale(1, 1)
				f13_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ButtonInternal:completeAnimation()
			f13_arg0.ButtonInternal:setScale(1.05, 1.05)
			f13_local0(f13_arg0.ButtonInternal)
		end,
	},
	Disabled = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.ButtonInternal:completeAnimation()
			f16_arg0.ButtonInternal:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.ButtonInternal:beginAnimation(200)
				f17_arg0.ButtonInternal:setScale(1.05, 1.05)
				f17_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.ButtonInternal:completeAnimation()
			f17_arg0.ButtonInternal:setScale(1, 1)
			f17_local0(f17_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.ButtonInternal:beginAnimation(200)
				f19_arg0.ButtonInternal:setScale(1, 1)
				f19_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ButtonInternal:completeAnimation()
			f19_arg0.ButtonInternal:setScale(1.05, 1.05)
			f19_local0(f19_arg0.ButtonInternal)
		end,
	},
	OnlineOnly = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.ButtonInternal:completeAnimation()
			f22_arg0.ButtonInternal:setScale(1.05, 1.05)
			f22_arg0.clipFinished(f22_arg0.ButtonInternal)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.ButtonInternal:beginAnimation(200)
				f23_arg0.ButtonInternal:setScale(1.05, 1.05)
				f23_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.ButtonInternal:completeAnimation()
			f23_arg0.ButtonInternal:setScale(1, 1)
			f23_local0(f23_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.ButtonInternal:beginAnimation(200)
				f25_arg0.ButtonInternal:setScale(1, 1)
				f25_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.ButtonInternal:completeAnimation()
			f25_arg0.ButtonInternal:setScale(1.05, 1.05)
			f25_local0(f25_arg0.ButtonInternal)
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
				f29_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.ButtonInternal:completeAnimation()
			f29_arg0.ButtonInternal:setScale(1, 1)
			f29_local0(f29_arg0.ButtonInternal)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.ButtonInternal:beginAnimation(200)
				f31_arg0.ButtonInternal:setScale(1, 1)
				f31_arg0.ButtonInternal:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ButtonInternal:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ButtonInternal:completeAnimation()
			f31_arg0.ButtonInternal:setScale(1.05, 1.05)
			f31_local0(f31_arg0.ButtonInternal)
		end,
	},
	UGCDisabled = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.StartMenu_Button_Hero.__onClose = function(f34_arg0)
	f34_arg0.ButtonInternal:close()
end
