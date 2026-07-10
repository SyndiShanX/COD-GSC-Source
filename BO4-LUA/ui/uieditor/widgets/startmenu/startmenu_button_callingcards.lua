require("x64:2f83d4f91282174")
CoD.StartMenu_Button_CallingCards = InheritFrom(LUI.UIElement)
CoD.StartMenu_Button_CallingCards.__defaultWidth = 420
CoD.StartMenu_Button_CallingCards.__defaultHeight = 113
CoD.StartMenu_Button_CallingCards.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Button_CallingCards)
	self.id = "StartMenu_Button_CallingCards"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.StartMenu_Button_CallingCards_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	Backing.id = "Backing"
	self.__defaultFocus = Backing
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SyncChildStateToSelfState(self, f1_arg1, self.Backing)
	return self
end
CoD.StartMenu_Button_CallingCards.__resetProperties = function(f2_arg0)
	f2_arg0.Backing:completeAnimation()
	f2_arg0.Backing:setScale(1, 1)
end
CoD.StartMenu_Button_CallingCards.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Backing:completeAnimation()
			f4_arg0.Backing:setScale(1.05, 1.05)
			f4_arg0.clipFinished(f4_arg0.Backing)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Backing:beginAnimation(200)
				f5_arg0.Backing:setScale(1.05, 1.05)
				f5_arg0.Backing:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Backing:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Backing:completeAnimation()
			f5_arg0.Backing:setScale(1, 1)
			f5_local0(f5_arg0.Backing)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Backing:beginAnimation(200)
				f7_arg0.Backing:setScale(1, 1)
				f7_arg0.Backing:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Backing:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setScale(1.05, 1.05)
			f7_local0(f7_arg0.Backing)
		end,
	},
	Disabled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setScale(1.05, 1.05)
			f10_arg0.clipFinished(f10_arg0.Backing)
		end,
		GainChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Backing:beginAnimation(200)
				f11_arg0.Backing:setScale(1.05, 1.05)
				f11_arg0.Backing:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Backing:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setScale(1, 1)
			f11_local0(f11_arg0.Backing)
		end,
		LoseChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.Backing:beginAnimation(200)
				f13_arg0.Backing:setScale(1, 1)
				f13_arg0.Backing:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Backing:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Backing:completeAnimation()
			f13_arg0.Backing:setScale(1.05, 1.05)
			f13_local0(f13_arg0.Backing)
		end,
	},
	Spinning = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Backing:completeAnimation()
			f16_arg0.Backing:setScale(1.05, 1.05)
			f16_arg0.clipFinished(f16_arg0.Backing)
		end,
		GainChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.Backing:beginAnimation(200)
				f17_arg0.Backing:setScale(1.05, 1.05)
				f17_arg0.Backing:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Backing:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Backing:completeAnimation()
			f17_arg0.Backing:setScale(1, 1)
			f17_local0(f17_arg0.Backing)
		end,
		LoseChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.Backing:beginAnimation(200)
				f19_arg0.Backing:setScale(1, 1)
				f19_arg0.Backing:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Backing:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.Backing:completeAnimation()
			f19_arg0.Backing:setScale(1.05, 1.05)
			f19_local0(f19_arg0.Backing)
		end,
	},
}
CoD.StartMenu_Button_CallingCards.__onClose = function(f21_arg0)
	f21_arg0.Backing:close()
end
