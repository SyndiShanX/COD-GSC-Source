CoD.TabletIcePickGadget_BgElementBinary2 = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_BgElementBinary2.__defaultWidth = 531
CoD.TabletIcePickGadget_BgElementBinary2.__defaultHeight = 64
CoD.TabletIcePickGadget_BgElementBinary2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_BgElementBinary2)
	self.id = "TabletIcePickGadget_BgElementBinary2"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local binary01 = LUI.UIImage.new(0, 0, 50.5, 530.5, 0, 0, 12, 68)
	binary01:setImage(RegisterImage(@"hash_2D5F090680221644"))
	binary01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	binary01:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary01)
	self.binary01 = binary01
	local binary02 = LUI.UIImage.new(0, 0, 0, 468, 0, 0, 0, 56)
	binary02:setImage(RegisterImage(@"hash_2D5EFF0680220546"))
	binary02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	binary02:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary02)
	self.binary02 = binary02
	local binary03 = LUI.UIImage.new(0, 0, 8, 400, 0, 0, 4, 60)
	binary03:setImage(RegisterImage(@"hash_37C58A7C71CD2E4E"))
	binary03:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	binary03:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary03)
	self.binary03 = binary03
	local binary04 = LUI.UIImage.new(0, 0, 2.5, 530.5, 0, 0, 4, 64)
	binary04:setImage(RegisterImage(@"hash_2D5F0006802206F9"))
	binary04:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	binary04:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary04)
	self.binary04 = binary04
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePickGadget_BgElementBinary2.__resetProperties = function(f2_arg0)
	f2_arg0.binary04:completeAnimation()
	f2_arg0.binary02:completeAnimation()
	f2_arg0.binary03:completeAnimation()
	f2_arg0.binary01:completeAnimation()
	f2_arg0.binary04:setAlpha(1)
	f2_arg0.binary02:setAlpha(1)
	f2_arg0.binary03:setAlpha(1)
	f2_arg0.binary01:setAlpha(1)
end
CoD.TabletIcePickGadget_BgElementBinary2.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
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
														f14_arg0:beginAnimation(19)
														f14_arg0:setAlpha(0)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
													end
													f13_arg0:beginAnimation(59)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(20)
												f12_arg0:setAlpha(0.9)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(709)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(20)
										f10_arg0:setAlpha(0)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(60)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(19)
								f8_arg0:setAlpha(1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(250)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(20)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(60)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f4_arg0:beginAnimation(19)
				f4_arg0:setAlpha(0.9)
				f4_arg0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.binary01:beginAnimation(400)
			f3_arg0.binary01:setAlpha(0)
			f3_arg0.binary01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.binary01:registerEventHandler("transition_complete_keyframe", f3_local0)
			local f3_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						local f17_local0 = function(f18_arg0)
							local f18_local0 = function(f19_arg0)
								local f19_local0 = function(f20_arg0)
									local f20_local0 = function(f21_arg0)
										local f21_local0 = function(f22_arg0)
											local f22_local0 = function(f23_arg0)
												local f23_local0 = function(f24_arg0)
													local f24_local0 = function(f25_arg0)
														f25_arg0:beginAnimation(19)
														f25_arg0:setAlpha(0)
														f25_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
													end
													f24_arg0:beginAnimation(120)
													f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
												end
												f23_arg0:beginAnimation(19)
												f23_arg0:setAlpha(0.8)
												f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
											end
											f22_arg0:beginAnimation(750)
											f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
										end
										f21_arg0:beginAnimation(19)
										f21_arg0:setAlpha(0)
										f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
									end
									f20_arg0:beginAnimation(110)
									f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
								end
								f19_arg0:beginAnimation(19)
								f19_arg0:setAlpha(0.8)
								f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
							end
							f18_arg0:beginAnimation(300)
							f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
						end
						f17_arg0:beginAnimation(19)
						f17_arg0:setAlpha(0)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
					end
					f16_arg0:beginAnimation(60)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f15_arg0:beginAnimation(19)
				f15_arg0:setAlpha(0.8)
				f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f3_arg0.binary02:beginAnimation(100)
			f3_arg0.binary02:setAlpha(0)
			f3_arg0.binary02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.binary02:registerEventHandler("transition_complete_keyframe", f3_local1)
			local f3_local2 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						local f28_local0 = function(f29_arg0)
							local f29_local0 = function(f30_arg0)
								local f30_local0 = function(f31_arg0)
									local f31_local0 = function(f32_arg0)
										local f32_local0 = function(f33_arg0)
											local f33_local0 = function(f34_arg0)
												local f34_local0 = function(f35_arg0)
													local f35_local0 = function(f36_arg0)
														local f36_local0 = function(f37_arg0)
															f37_arg0:beginAnimation(19)
															f37_arg0:setAlpha(0)
															f37_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f36_arg0:beginAnimation(159)
														f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
													end
													f35_arg0:beginAnimation(19)
													f35_arg0:setAlpha(0.6)
													f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
												end
												f34_arg0:beginAnimation(250)
												f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
											end
											f33_arg0:beginAnimation(19)
											f33_arg0:setAlpha(0)
											f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
										end
										f32_arg0:beginAnimation(60)
										f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
									end
									f31_arg0:beginAnimation(19)
									f31_arg0:setAlpha(0.8)
									f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
								end
								f30_arg0:beginAnimation(550)
								f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
							end
							f29_arg0:beginAnimation(20)
							f29_arg0:setAlpha(0)
							f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
						end
						f28_arg0:beginAnimation(60)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
					end
					f27_arg0:beginAnimation(19)
					f27_arg0:setAlpha(1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f26_arg0:beginAnimation(100)
				f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f3_arg0.binary03:beginAnimation(100)
			f3_arg0.binary03:setAlpha(0)
			f3_arg0.binary03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.binary03:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						local f40_local0 = function(f41_arg0)
							local f41_local0 = function(f42_arg0)
								local f42_local0 = function(f43_arg0)
									local f43_local0 = function(f44_arg0)
										local f44_local0 = function(f45_arg0)
											local f45_local0 = function(f46_arg0)
												local f46_local0 = function(f47_arg0)
													local f47_local0 = function(f48_arg0)
														local f48_local0 = function(f49_arg0)
															local f49_local0 = function(f50_arg0)
																local f50_local0 = function(f51_arg0)
																	local f51_local0 = function(f52_arg0)
																		local f52_local0 = function(f53_arg0)
																			local f53_local0 = function(f54_arg0)
																				f54_arg0:beginAnimation(19)
																				f54_arg0:setAlpha(0)
																				f54_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																			end
																			f53_arg0:beginAnimation(59)
																			f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
																		end
																		f52_arg0:beginAnimation(19)
																		f52_arg0:setAlpha(0.7)
																		f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
																	end
																	f51_arg0:beginAnimation(650)
																	f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
																end
																f50_arg0:beginAnimation(19)
																f50_arg0:setAlpha(0)
																f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
															end
															f49_arg0:beginAnimation(59)
															f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
														end
														f48_arg0:beginAnimation(20)
														f48_arg0:setAlpha(0.7)
														f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
													end
													f47_arg0:beginAnimation(199)
													f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
												end
												f46_arg0:beginAnimation(19)
												f46_arg0:setAlpha(0)
												f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
											end
											f45_arg0:beginAnimation(60)
											f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
										end
										f44_arg0:beginAnimation(20)
										f44_arg0:setAlpha(1)
										f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
									end
									f43_arg0:beginAnimation(249)
									f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
								end
								f42_arg0:beginAnimation(20)
								f42_arg0:setAlpha(0)
								f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
							end
							f41_arg0:beginAnimation(60)
							f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
						end
						f40_arg0:beginAnimation(19)
						f40_arg0:setAlpha(1)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
					end
					f39_arg0:beginAnimation(200)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f3_arg0.binary04:beginAnimation(100)
				f3_arg0.binary04:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.binary04:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f3_arg0.binary04:completeAnimation()
			f3_arg0.binary04:setAlpha(0)
			f3_local3(f3_arg0.binary04)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
