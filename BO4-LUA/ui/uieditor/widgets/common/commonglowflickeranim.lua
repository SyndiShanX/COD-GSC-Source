CoD.CommonGlowFlickerAnim = InheritFrom(LUI.UIElement)
CoD.CommonGlowFlickerAnim.__defaultWidth = 256
CoD.CommonGlowFlickerAnim.__defaultHeight = 256
CoD.CommonGlowFlickerAnim.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonGlowFlickerAnim)
	self.id = "CommonGlowFlickerAnim"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowLarge01 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GlowLarge01:setRGB(1, 0.35, 0)
	GlowLarge01:setImage(RegisterImage(0x3A09C1C0B8DFF4D))
	GlowLarge01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowLarge01:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(GlowLarge01)
	self.GlowLarge01 = GlowLarge01
	local GlowLarge02 = LUI.UIImage.new(0, 1, 40, -40, 0, 1, 40, -40)
	GlowLarge02:setRGB(1, 0.93, 0.4)
	GlowLarge02:setImage(RegisterImage(0x3A09C1C0B8DFF4D))
	GlowLarge02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowLarge02:setShaderVector(0, 1.25, 0, 0, 0)
	self:addElement(GlowLarge02)
	self.GlowLarge02 = GlowLarge02
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonGlowFlickerAnim.__resetProperties = function(f2_arg0)
	f2_arg0.GlowLarge01:completeAnimation()
	f2_arg0.GlowLarge02:completeAnimation()
	f2_arg0.GlowLarge01:setAlpha(1)
	f2_arg0.GlowLarge02:setAlpha(1)
end
CoD.CommonGlowFlickerAnim.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											local f11_local0 = function(f12_arg0)
												local f12_local0 = function(f13_arg0)
													local f13_local0 = function(f14_arg0)
														local f14_local0 = function(f15_arg0)
															local f15_local0 = function(f16_arg0)
																f16_arg0:beginAnimation(440)
																f16_arg0:setAlpha(0.75)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
															end
															f15_arg0:beginAnimation(9)
															f15_arg0:setAlpha(1)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(289)
														f14_arg0:setAlpha(0.75)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(9)
													f13_arg0:setAlpha(1)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(409)
												f12_arg0:setAlpha(0.85)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(9)
											f11_arg0:setAlpha(1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(189)
										f10_arg0:setAlpha(0.8)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(10)
									f9_arg0:setAlpha(1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(419)
								f8_arg0:setAlpha(0.75)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(9)
							f7_arg0:setAlpha(1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(440)
						f6_arg0:setAlpha(0.8)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(9)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.GlowLarge01:beginAnimation(300)
				f3_arg0.GlowLarge01:setAlpha(0.7)
				f3_arg0.GlowLarge01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowLarge01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GlowLarge01:completeAnimation()
			f3_arg0.GlowLarge01:setAlpha(1)
			f3_local0(f3_arg0.GlowLarge01)
			local f3_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							local f20_local0 = function(f21_arg0)
								local f21_local0 = function(f22_arg0)
									local f22_local0 = function(f23_arg0)
										local f23_local0 = function(f24_arg0)
											local f24_local0 = function(f25_arg0)
												local f25_local0 = function(f26_arg0)
													local f26_local0 = function(f27_arg0)
														local f27_local0 = function(f28_arg0)
															local f28_local0 = function(f29_arg0)
																f29_arg0:beginAnimation(440)
																f29_arg0:setAlpha(0.75)
																f29_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
															end
															f28_arg0:beginAnimation(9)
															f28_arg0:setAlpha(1)
															f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
														end
														f27_arg0:beginAnimation(289)
														f27_arg0:setAlpha(0.75)
														f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
													end
													f26_arg0:beginAnimation(9)
													f26_arg0:setAlpha(1)
													f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
												end
												f25_arg0:beginAnimation(409)
												f25_arg0:setAlpha(0.85)
												f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
											end
											f24_arg0:beginAnimation(9)
											f24_arg0:setAlpha(1)
											f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
										end
										f23_arg0:beginAnimation(189)
										f23_arg0:setAlpha(0.8)
										f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
									end
									f22_arg0:beginAnimation(10)
									f22_arg0:setAlpha(1)
									f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
								end
								f21_arg0:beginAnimation(419)
								f21_arg0:setAlpha(0.75)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
							end
							f20_arg0:beginAnimation(9)
							f20_arg0:setAlpha(1)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(440)
						f19_arg0:setAlpha(0.8)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(9)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f3_arg0.GlowLarge02:beginAnimation(300)
				f3_arg0.GlowLarge02:setAlpha(0.7)
				f3_arg0.GlowLarge02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowLarge02:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f3_arg0.GlowLarge02:completeAnimation()
			f3_arg0.GlowLarge02:setAlpha(1)
			f3_local1(f3_arg0.GlowLarge02)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
