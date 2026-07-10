CoD.BlackTransitionFade = InheritFrom(LUI.UIElement)
CoD.BlackTransitionFade.__defaultWidth = 1920
CoD.BlackTransitionFade.__defaultHeight = 1080
CoD.BlackTransitionFade.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BlackTransitionFade)
	self.id = "BlackTransitionFade"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackFade = LUI.UIImage.new(-0.1, 1.1, 0, 0, -0.15, 1.15, 0, 0)
	BlackFade:setRGB(0, 0, 0)
	BlackFade:setAlpha(0)
	self:addElement(BlackFade)
	self.BlackFade = BlackFade
	local CrosshairOccluder = LUI.UIImage.new(0, 0, 1859, 1987, 0, 0, 243, 371)
	CrosshairOccluder:setAlpha(0)
	CrosshairOccluder:setupCrosshairOccluder(f1_arg1)
	self:addElement(CrosshairOccluder)
	self.CrosshairOccluder = CrosshairOccluder
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f2_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"quick_fade") then
			PlayClip(self, "QuickFade", f1_arg1)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_175F8739ED7A932") then
			PlayClip(self, "MediumLengthFade", f1_arg1)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_5B2D65A026DE792D") then
			PlayClip(self, "QuickFadeUp", f1_arg1)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"post_potm") then
			PlayClip(self, "PostPOTM", f1_arg1)
		elseif CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_21B9CFC69E007BC4") then
			PlayClip(self, "InfectionFade", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	f1_local3 = BlackFade
	if IsPC() then
		SizeToWidthOfScreen(f1_local3, f1_arg1)
	elseif IsSplitscreenAndInGame(f1_arg1) then
		SizeToWidthOfScreen(f1_local3, f1_arg1)
	end
	return self
end
CoD.BlackTransitionFade.__resetProperties = function(f3_arg0)
	f3_arg0.BlackFade:completeAnimation()
	f3_arg0.CrosshairOccluder:completeAnimation()
	f3_arg0.BlackFade:setAlpha(0)
	f3_arg0.CrosshairOccluder:setAlpha(0)
end
CoD.BlackTransitionFade.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		MediumLengthFade = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(500)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(500)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.BlackFade:beginAnimation(500)
				f5_arg0.BlackFade:setAlpha(1)
				f5_arg0.BlackFade:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.BlackFade:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.BlackFade:completeAnimation()
			f5_arg0.BlackFade:setAlpha(0)
			f5_local0(f5_arg0.BlackFade)
			local f5_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(500)
						f11_arg0:setAlpha(0)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(500)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f5_arg0.CrosshairOccluder:beginAnimation(500)
				f5_arg0.CrosshairOccluder:setAlpha(1)
				f5_arg0.CrosshairOccluder:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CrosshairOccluder:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f5_arg0.CrosshairOccluder:completeAnimation()
			f5_arg0.CrosshairOccluder:setAlpha(0)
			f5_local1(f5_arg0.CrosshairOccluder)
		end,
		QuickFade = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(250)
						f15_arg0:setAlpha(0)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(250)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f12_arg0.BlackFade:beginAnimation(250)
				f12_arg0.BlackFade:setAlpha(1)
				f12_arg0.BlackFade:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.BlackFade:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.BlackFade:completeAnimation()
			f12_arg0.BlackFade:setAlpha(0)
			f12_local0(f12_arg0.BlackFade)
			local f12_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						f18_arg0:beginAnimation(250)
						f18_arg0:setAlpha(0)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f17_arg0:beginAnimation(250)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f12_arg0.CrosshairOccluder:beginAnimation(250)
				f12_arg0.CrosshairOccluder:setAlpha(1)
				f12_arg0.CrosshairOccluder:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CrosshairOccluder:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f12_arg0.CrosshairOccluder:completeAnimation()
			f12_arg0.CrosshairOccluder:setAlpha(0)
			f12_local1(f12_arg0.CrosshairOccluder)
		end,
		QuickFadeUp = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				f19_arg0.BlackFade:beginAnimation(250)
				f19_arg0.BlackFade:setAlpha(0)
				f19_arg0.BlackFade:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.BlackFade:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.BlackFade:completeAnimation()
			f19_arg0.BlackFade:setAlpha(1)
			f19_local0(f19_arg0.BlackFade)
			local f19_local1 = function(f21_arg0)
				f19_arg0.CrosshairOccluder:beginAnimation(250)
				f19_arg0.CrosshairOccluder:setAlpha(0)
				f19_arg0.CrosshairOccluder:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CrosshairOccluder:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.CrosshairOccluder:completeAnimation()
			f19_arg0.CrosshairOccluder:setAlpha(1)
			f19_local1(f19_arg0.CrosshairOccluder)
		end,
		SolidBlackNoFade = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.BlackFade:completeAnimation()
			f22_arg0.BlackFade:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.BlackFade)
			f22_arg0.CrosshairOccluder:completeAnimation()
			f22_arg0.CrosshairOccluder:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.CrosshairOccluder)
		end,
		PostPOTM = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			local f23_local0 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						f26_arg0:beginAnimation(250)
						f26_arg0:setAlpha(0)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
					end
					f25_arg0:beginAnimation(350)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f23_arg0.BlackFade:beginAnimation(250)
				f23_arg0.BlackFade:setAlpha(1)
				f23_arg0.BlackFade:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.BlackFade:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f23_arg0.BlackFade:completeAnimation()
			f23_arg0.BlackFade:setAlpha(0)
			f23_local0(f23_arg0.BlackFade)
			local f23_local1 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					local f28_local0 = function(f29_arg0)
						f29_arg0:beginAnimation(250)
						f29_arg0:setAlpha(0)
						f29_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
					end
					f28_arg0:beginAnimation(350)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
				end
				f23_arg0.CrosshairOccluder:beginAnimation(250)
				f23_arg0.CrosshairOccluder:setAlpha(1)
				f23_arg0.CrosshairOccluder:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.CrosshairOccluder:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f23_arg0.CrosshairOccluder:completeAnimation()
			f23_arg0.CrosshairOccluder:setAlpha(0)
			f23_local1(f23_arg0.CrosshairOccluder)
		end,
		InfectionFade = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						f33_arg0:beginAnimation(500)
						f33_arg0:setAlpha(0)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
					end
					f32_arg0:beginAnimation(1410)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f30_arg0.BlackFade:beginAnimation(90)
				f30_arg0.BlackFade:setAlpha(1)
				f30_arg0.BlackFade:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.BlackFade:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.BlackFade:completeAnimation()
			f30_arg0.BlackFade:setAlpha(0)
			f30_local0(f30_arg0.BlackFade)
			local f30_local1 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						f36_arg0:beginAnimation(500)
						f36_arg0:setAlpha(0)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
					end
					f35_arg0:beginAnimation(1410)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f30_arg0.CrosshairOccluder:beginAnimation(90)
				f30_arg0.CrosshairOccluder:setAlpha(1)
				f30_arg0.CrosshairOccluder:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.CrosshairOccluder:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f30_arg0.CrosshairOccluder:completeAnimation()
			f30_arg0.CrosshairOccluder:setAlpha(0)
			f30_local1(f30_arg0.CrosshairOccluder)
		end,
	},
}
CoD.BlackTransitionFade.__onClose = function(f37_arg0)
	f37_arg0.BlackFade:close()
end
