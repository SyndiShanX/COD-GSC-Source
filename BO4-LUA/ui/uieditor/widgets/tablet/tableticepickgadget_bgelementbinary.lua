CoD.TabletIcePickGadget_BgElementBinary = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_BgElementBinary.__defaultWidth = 656
CoD.TabletIcePickGadget_BgElementBinary.__defaultHeight = 120
CoD.TabletIcePickGadget_BgElementBinary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_BgElementBinary)
	self.id = "TabletIcePickGadget_BgElementBinary"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local binary05 = LUI.UIImage.new(0, 0, 30, 342, 0, 0, 14, 134)
	binary05:setAlpha(0)
	binary05:setImage(RegisterImage(0xD5F0B06802219AA))
	binary05:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	binary05:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary05)
	self.binary05 = binary05
	local binary04 = LUI.UIImage.new(0, 0, 0, 632, 0, 0, 15, 135)
	binary04:setAlpha(0)
	binary04:setImage(RegisterImage(0xD5F0C0680221B5D))
	binary04:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	binary04:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary04)
	self.binary04 = binary04
	local binary03 = LUI.UIImage.new(0, 0, 0, 336, 0, 0, -14, 106)
	binary03:setAlpha(0)
	binary03:setImage(RegisterImage(0xD5F050680220F78))
	binary03:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	binary03:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary03)
	self.binary03 = binary03
	local binary02 = LUI.UIImage.new(0, 0, 0, 656, 0, 0, 0, 120)
	binary02:setAlpha(0)
	binary02:setImage(RegisterImage(0xD5F06068022112B))
	binary02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	binary02:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary02)
	self.binary02 = binary02
	local binary01 = LUI.UIImage.new(0, 0, 0, 304, 0, 0, 0, 120)
	binary01:setImage(RegisterImage(0xD5F080680221491))
	binary01:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	binary01:setShaderVector(0, 5, 0, 0, 0)
	self:addElement(binary01)
	self.binary01 = binary01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePickGadget_BgElementBinary.__resetProperties = function(f2_arg0)
	f2_arg0.binary02:completeAnimation()
	f2_arg0.binary03:completeAnimation()
	f2_arg0.binary04:completeAnimation()
	f2_arg0.binary01:completeAnimation()
	f2_arg0.binary05:completeAnimation()
	f2_arg0.binary02:setAlpha(0)
	f2_arg0.binary03:setAlpha(0)
	f2_arg0.binary04:setAlpha(0)
	f2_arg0.binary01:setAlpha(1)
	f2_arg0.binary05:setAlpha(0)
end
CoD.TabletIcePickGadget_BgElementBinary.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(5)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											f11_arg0:beginAnimation(19)
											f11_arg0:setAlpha(0)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f10_arg0:beginAnimation(60)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(19)
									f9_arg0:setAlpha(0.7)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(369)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(20)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(60)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(19)
					f5_arg0:setAlpha(0.6)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.binary05:beginAnimation(560)
				f3_arg0.binary05:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.binary05:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.binary05:completeAnimation()
			f3_arg0.binary05:setAlpha(0)
			f3_local0(f3_arg0.binary05)
			local f3_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									local f17_local0 = function(f18_arg0)
										local f18_local0 = function(f19_arg0)
											local f19_local0 = function(f20_arg0)
												f20_arg0:beginAnimation(69)
												f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f19_arg0:beginAnimation(19)
											f19_arg0:setAlpha(0)
											f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
										end
										f18_arg0:beginAnimation(60)
										f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
									end
									f17_arg0:beginAnimation(19)
									f17_arg0:setAlpha(0.8)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
								end
								f16_arg0:beginAnimation(669)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(20)
							f15_arg0:setAlpha(0)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(120)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(19)
					f13_arg0:setAlpha(0.8)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f3_arg0.binary04:beginAnimation(300)
				f3_arg0.binary04:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.binary04:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.binary04:completeAnimation()
			f3_arg0.binary04:setAlpha(0)
			f3_local1(f3_arg0.binary04)
			local f3_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						local f23_local0 = function(f24_arg0)
							local f24_local0 = function(f25_arg0)
								local f25_local0 = function(f26_arg0)
									local f26_local0 = function(f27_arg0)
										local f27_local0 = function(f28_arg0)
											f28_arg0:beginAnimation(19)
											f28_arg0:setAlpha(0)
											f28_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f27_arg0:beginAnimation(130)
										f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
									end
									f26_arg0:beginAnimation(19)
									f26_arg0:setAlpha(0.8)
									f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
								end
								f25_arg0:beginAnimation(360)
								f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
							end
							f24_arg0:beginAnimation(20)
							f24_arg0:setAlpha(0)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
						end
						f23_arg0:beginAnimation(60)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(19)
					f22_arg0:setAlpha(0.8)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f3_arg0.binary03:beginAnimation(200)
				f3_arg0.binary03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.binary03:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f3_arg0.binary03:completeAnimation()
			f3_arg0.binary03:setAlpha(0)
			f3_local2(f3_arg0.binary03)
			local f3_local3 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						local f31_local0 = function(f32_arg0)
							local f32_local0 = function(f33_arg0)
								local f33_local0 = function(f34_arg0)
									local f34_local0 = function(f35_arg0)
										local f35_local0 = function(f36_arg0)
											local f36_local0 = function(f37_arg0)
												local f37_local0 = function(f38_arg0)
													local f38_local0 = function(f39_arg0)
														local f39_local0 = function(f40_arg0)
															f40_arg0:beginAnimation(19)
															f40_arg0:setAlpha(0)
															f40_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f39_arg0:beginAnimation(60)
														f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
													end
													f38_arg0:beginAnimation(19)
													f38_arg0:setAlpha(0.85)
													f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
												end
												f37_arg0:beginAnimation(370)
												f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
											end
											f36_arg0:beginAnimation(19)
											f36_arg0:setAlpha(0)
											f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
										end
										f35_arg0:beginAnimation(60)
										f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
									end
									f34_arg0:beginAnimation(19)
									f34_arg0:setAlpha(0.7)
									f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
								end
								f33_arg0:beginAnimation(260)
								f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
							end
							f32_arg0:beginAnimation(19)
							f32_arg0:setAlpha(0)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
						end
						f31_arg0:beginAnimation(60)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(19)
					f30_arg0:setAlpha(0.9)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f3_arg0.binary02:beginAnimation(100)
				f3_arg0.binary02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.binary02:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f3_arg0.binary02:completeAnimation()
			f3_arg0.binary02:setAlpha(0)
			f3_local3(f3_arg0.binary02)
			local f3_local4 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					local f42_local0 = function(f43_arg0)
						local f43_local0 = function(f44_arg0)
							local f44_local0 = function(f45_arg0)
								local f45_local0 = function(f46_arg0)
									local f46_local0 = function(f47_arg0)
										f47_arg0:beginAnimation(19)
										f47_arg0:setAlpha(0)
										f47_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
									end
									f46_arg0:beginAnimation(60)
									f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
								end
								f45_arg0:beginAnimation(20)
								f45_arg0:setAlpha(0.7)
								f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
							end
							f44_arg0:beginAnimation(729)
							f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
						end
						f43_arg0:beginAnimation(20)
						f43_arg0:setAlpha(0)
						f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
					end
					f42_arg0:beginAnimation(60)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
				end
				f3_arg0.binary01:beginAnimation(20)
				f3_arg0.binary01:setAlpha(0.6)
				f3_arg0.binary01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.binary01:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f3_arg0.binary01:completeAnimation()
			f3_arg0.binary01:setAlpha(0)
			f3_local4(f3_arg0.binary01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
