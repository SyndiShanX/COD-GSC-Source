CoD.CardGlowRectangleAnim = InheritFrom(LUI.UIElement)
CoD.CardGlowRectangleAnim.__defaultWidth = 348
CoD.CardGlowRectangleAnim.__defaultHeight = 676
CoD.CardGlowRectangleAnim.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CardGlowRectangleAnim)
	self.id = "CardGlowRectangleAnim"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowRectangle01 = LUI.UIImage.new(0.5, 0.5, -174, 174, 0.5, 0.5, -338, 338)
	GlowRectangle01:setImage(RegisterImage(@"hash_65FB66FE8D39135"))
	GlowRectangle01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowRectangle01:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(GlowRectangle01)
	self.GlowRectangle01 = GlowRectangle01
	local GlowRectangle02 = LUI.UIImage.new(0.5, 0.5, -174, 174, 0.5, 0.5, -338, 338)
	GlowRectangle02:setImage(RegisterImage(@"hash_65FB66FE8D39135"))
	GlowRectangle02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowRectangle02:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(GlowRectangle02)
	self.GlowRectangle02 = GlowRectangle02
	local GlowRectangle03 = LUI.UIImage.new(0.5, 0.5, -174, 174, 0.5, 0.5, -338, 338)
	GlowRectangle03:setImage(RegisterImage(@"hash_65FB66FE8D39135"))
	GlowRectangle03:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowRectangle03:setShaderVector(0, 4, 0, 0, 0)
	self:addElement(GlowRectangle03)
	self.GlowRectangle03 = GlowRectangle03
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CardGlowRectangleAnim.__resetProperties = function(f2_arg0)
	f2_arg0.GlowRectangle01:completeAnimation()
	f2_arg0.GlowRectangle02:completeAnimation()
	f2_arg0.GlowRectangle03:completeAnimation()
	f2_arg0.GlowRectangle01:setAlpha(1)
	f2_arg0.GlowRectangle01:setScale(1, 1)
	f2_arg0.GlowRectangle02:setAlpha(1)
	f2_arg0.GlowRectangle02:setScale(1, 1)
	f2_arg0.GlowRectangle03:setAlpha(1)
	f2_arg0.GlowRectangle03:setScale(1, 1)
end
CoD.CardGlowRectangleAnim.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											f11_arg0:beginAnimation(760)
											f11_arg0:setAlpha(0)
											f11_arg0:setScale(1.2, 1.2)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f10_arg0:beginAnimation(9)
										f10_arg0:setAlpha(1)
										f10_arg0:setScale(1, 1)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(370)
									f9_arg0:setScale(1.01, 1.01)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(760)
								f8_arg0:setAlpha(0)
								f8_arg0:setScale(1.2, 1.2)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(9)
							f7_arg0:setAlpha(1)
							f7_arg0:setScale(1, 1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(370)
						f6_arg0:setScale(1.01, 1.01)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(760)
					f5_arg0:setAlpha(0)
					f5_arg0:setScale(1.2, 1.2)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.GlowRectangle01:beginAnimation(10)
				f3_arg0.GlowRectangle01:setAlpha(1)
				f3_arg0.GlowRectangle01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowRectangle01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GlowRectangle01:completeAnimation()
			f3_arg0.GlowRectangle01:setAlpha(0)
			f3_arg0.GlowRectangle01:setScale(1, 1)
			f3_local0(f3_arg0.GlowRectangle01)
			local f3_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									local f17_local0 = function(f18_arg0)
										local f18_local0 = function(f19_arg0)
											local f19_local0 = function(f20_arg0)
												f20_arg0:beginAnimation(760)
												f20_arg0:setAlpha(0)
												f20_arg0:setScale(1.2, 1.2)
												f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f19_arg0:beginAnimation(9)
											f19_arg0:setAlpha(1)
											f19_arg0:setScale(1, 1)
											f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
										end
										f18_arg0:beginAnimation(370)
										f18_arg0:setScale(1.01, 1.01)
										f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
									end
									f17_arg0:beginAnimation(760)
									f17_arg0:setAlpha(0)
									f17_arg0:setScale(1.2, 1.2)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
								end
								f16_arg0:beginAnimation(9)
								f16_arg0:setAlpha(1)
								f16_arg0:setScale(1, 1)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(370)
							f15_arg0:setScale(1.01, 1.01)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(760)
						f14_arg0:setAlpha(0)
						f14_arg0:setScale(1.2, 1.2)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(9)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.GlowRectangle02:beginAnimation(380)
				f3_arg0.GlowRectangle02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowRectangle02:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.GlowRectangle02:completeAnimation()
			f3_arg0.GlowRectangle02:setAlpha(0)
			f3_arg0.GlowRectangle02:setScale(1, 1)
			f3_local1(f3_arg0.GlowRectangle02)
			local f3_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						local f23_local0 = function(f24_arg0)
							local f24_local0 = function(f25_arg0)
								local f25_local0 = function(f26_arg0)
									local f26_local0 = function(f27_arg0)
										local f27_local0 = function(f28_arg0)
											local f28_local0 = function(f29_arg0)
												f29_arg0:beginAnimation(760)
												f29_arg0:setAlpha(0)
												f29_arg0:setScale(1.2, 1.2)
												f29_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f28_arg0:beginAnimation(9)
											f28_arg0:setAlpha(1)
											f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
										end
										f27_arg0:beginAnimation(369)
										f27_arg0:setScale(1, 1)
										f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
									end
									f26_arg0:beginAnimation(760)
									f26_arg0:setAlpha(0)
									f26_arg0:setScale(1.2, 1.2)
									f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
								end
								f25_arg0:beginAnimation(9)
								f25_arg0:setAlpha(1)
								f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
							end
							f24_arg0:beginAnimation(370)
							f24_arg0:setScale(1, 1)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
						end
						f23_arg0:beginAnimation(760)
						f23_arg0:setAlpha(0)
						f23_arg0:setScale(1.2, 1.2)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(9)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f3_arg0.GlowRectangle03:beginAnimation(760)
				f3_arg0.GlowRectangle03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GlowRectangle03:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f3_arg0.GlowRectangle03:completeAnimation()
			f3_arg0.GlowRectangle03:setAlpha(0)
			f3_arg0.GlowRectangle03:setScale(1, 1)
			f3_local2(f3_arg0.GlowRectangle03)
		end,
	},
}
