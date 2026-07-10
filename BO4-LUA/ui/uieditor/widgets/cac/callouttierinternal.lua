CoD.CalloutTierInternal = InheritFrom(LUI.UIElement)
CoD.CalloutTierInternal.__defaultWidth = 28
CoD.CalloutTierInternal.__defaultHeight = 24
CoD.CalloutTierInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CalloutTierInternal)
	self.id = "CalloutTierInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Tier2Available = LUI.UIImage.new(0, 0, 0, 28, 0, 0, 0, 24)
	Tier2Available:setAlpha(0)
	Tier2Available:setImage(RegisterImage(0xFB71537B267BFD))
	self:addElement(Tier2Available)
	self.Tier2Available = Tier2Available
	local Tier2Equipped = LUI.UIImage.new(0, 0, 0, 28, 0, 0, 0, 24)
	Tier2Equipped:setAlpha(0)
	Tier2Equipped:setImage(RegisterImage(@"hash_4F15F03862B81BBB"))
	self:addElement(Tier2Equipped)
	self.Tier2Equipped = Tier2Equipped
	local Tier2Disabled = LUI.UIImage.new(0, 0, 0, 28, 0, 0, 0, 24)
	Tier2Disabled:setAlpha(0)
	Tier2Disabled:setImage(RegisterImage(@"hash_2BAE34FCD1DEBFBE"))
	self:addElement(Tier2Disabled)
	self.Tier2Disabled = Tier2Disabled
	local Tier1Equipped = LUI.UIImage.new(0, 0, 0, 28, 0, 0, 0, 24)
	Tier1Equipped:setAlpha(0)
	Tier1Equipped:setImage(RegisterImage(@"hash_C005ACBC777835C"))
	self:addElement(Tier1Equipped)
	self.Tier1Equipped = Tier1Equipped
	local Tier1Available = LUI.UIImage.new(0, 0, 0, 28, 0, 0, 0, 24)
	Tier1Available:setAlpha(0)
	Tier1Available:setImage(RegisterImage(@"hash_13F9E00D9473234C"))
	self:addElement(Tier1Available)
	self.Tier1Available = Tier1Available
	local Tier1Disabled = LUI.UIImage.new(0, 0, 0, 28, 0, 0, 0, 24)
	Tier1Disabled:setAlpha(0)
	Tier1Disabled:setImage(RegisterImage(@"hash_425EE16A8A5B0FE1"))
	self:addElement(Tier1Disabled)
	self.Tier1Disabled = Tier1Disabled
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	SetElementProperty(self, "m_preventFromBeingActive", true)
	return self
end
CoD.CalloutTierInternal.__resetProperties = function(f2_arg0)
	f2_arg0.Tier1Available:completeAnimation()
	f2_arg0.Tier1Disabled:completeAnimation()
	f2_arg0.Tier1Equipped:completeAnimation()
	f2_arg0.Tier2Available:completeAnimation()
	f2_arg0.Tier2Disabled:completeAnimation()
	f2_arg0.Tier2Equipped:completeAnimation()
	f2_arg0.Tier1Available:setAlpha(0)
	f2_arg0.Tier1Disabled:setAlpha(0)
	f2_arg0.Tier1Equipped:setAlpha(0)
	f2_arg0.Tier2Available:setAlpha(0)
	f2_arg0.Tier2Available:setImage(RegisterImage(0xFB71537B267BFD))
	f2_arg0.Tier2Disabled:setAlpha(0)
	f2_arg0.Tier2Equipped:setAlpha(0)
end
CoD.CalloutTierInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Tier1 = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Tier1Available:completeAnimation()
			f4_arg0.Tier1Available:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Tier1Available)
		end,
		Disabled = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Tier1Disabled:completeAnimation()
			f5_arg0.Tier1Disabled:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.Tier1Disabled)
		end,
		Equipped = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Tier1Equipped:completeAnimation()
			f6_arg0.Tier1Equipped:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.Tier1Equipped)
		end,
		Available = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.Tier1Available:completeAnimation()
			f7_arg0.Tier1Available:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.Tier1Available)
		end,
		AvailableFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Tier1Equipped:completeAnimation()
			f8_arg0.Tier1Equipped:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Tier1Equipped)
			f8_arg0.Tier1Available:completeAnimation()
			f8_arg0.Tier1Available:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Tier1Available)
		end,
		AvailableGainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Tier1Equipped:beginAnimation(200)
				f9_arg0.Tier1Equipped:setAlpha(1)
				f9_arg0.Tier1Equipped:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Tier1Equipped:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Tier1Equipped:completeAnimation()
			f9_arg0.Tier1Equipped:setAlpha(0)
			f9_local0(f9_arg0.Tier1Equipped)
			local f9_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(150)
					f12_arg0:setAlpha(0)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.Tier1Available:beginAnimation(50)
				f9_arg0.Tier1Available:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Tier1Available:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f9_arg0.Tier1Available:completeAnimation()
			f9_arg0.Tier1Available:setAlpha(1)
			f9_local1(f9_arg0.Tier1Available)
		end,
		AvailableLoseFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				f13_arg0.Tier1Equipped:beginAnimation(200)
				f13_arg0.Tier1Equipped:setAlpha(0)
				f13_arg0.Tier1Equipped:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Tier1Equipped:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Tier1Equipped:completeAnimation()
			f13_arg0.Tier1Equipped:setAlpha(1)
			f13_local0(f13_arg0.Tier1Equipped)
			local f13_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(100)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.Tier1Available:beginAnimation(100)
				f13_arg0.Tier1Available:setAlpha(1)
				f13_arg0.Tier1Available:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Tier1Available:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f13_arg0.Tier1Available:completeAnimation()
			f13_arg0.Tier1Available:setAlpha(0)
			f13_local1(f13_arg0.Tier1Available)
		end,
	},
	Tier2 = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.Tier2Available:completeAnimation()
			f17_arg0.Tier2Available:setAlpha(1)
			f17_arg0.Tier2Available:setImage(RegisterImage(0xFB71537B267BFD))
			f17_arg0.clipFinished(f17_arg0.Tier2Available)
		end,
		Disabled = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.Tier2Disabled:completeAnimation()
			f18_arg0.Tier2Disabled:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Tier2Disabled)
		end,
		Equipped = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.Tier2Equipped:completeAnimation()
			f19_arg0.Tier2Equipped:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Tier2Equipped)
		end,
		Available = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.Tier2Available:completeAnimation()
			f20_arg0.Tier2Available:setAlpha(1)
			f20_arg0.Tier2Available:setImage(RegisterImage(0xFB71537B267BFD))
			f20_arg0.clipFinished(f20_arg0.Tier2Available)
		end,
		AvailableFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.Tier2Available:completeAnimation()
			f21_arg0.Tier2Available:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Tier2Available)
			f21_arg0.Tier2Equipped:completeAnimation()
			f21_arg0.Tier2Equipped:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Tier2Equipped)
		end,
		AvailableGainFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(150)
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.Tier2Available:beginAnimation(50)
				f22_arg0.Tier2Available:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Tier2Available:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.Tier2Available:completeAnimation()
			f22_arg0.Tier2Available:setAlpha(1)
			f22_local0(f22_arg0.Tier2Available)
			local f22_local1 = function(f25_arg0)
				f22_arg0.Tier2Equipped:beginAnimation(200)
				f22_arg0.Tier2Equipped:setAlpha(1)
				f22_arg0.Tier2Equipped:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Tier2Equipped:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Tier2Equipped:completeAnimation()
			f22_arg0.Tier2Equipped:setAlpha(0)
			f22_local1(f22_arg0.Tier2Equipped)
		end,
		AvailableLoseFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(100)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.Tier2Available:beginAnimation(100)
				f26_arg0.Tier2Available:setAlpha(1)
				f26_arg0.Tier2Available:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Tier2Available:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.Tier2Available:completeAnimation()
			f26_arg0.Tier2Available:setAlpha(0)
			f26_local0(f26_arg0.Tier2Available)
			local f26_local1 = function(f29_arg0)
				f26_arg0.Tier2Equipped:beginAnimation(200)
				f26_arg0.Tier2Equipped:setAlpha(0)
				f26_arg0.Tier2Equipped:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Tier2Equipped:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Tier2Equipped:completeAnimation()
			f26_arg0.Tier2Equipped:setAlpha(1)
			f26_local1(f26_arg0.Tier2Equipped)
		end,
	},
}
