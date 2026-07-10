require("x64:d80a7d996408eac")
require("x64:d80aad9964093c5")
require("x64:f204c651fb5cc80")
require("x64:61367168c92655f")
CoD[@"hash_639A2F3C5F2BECC8"] = InheritFrom(LUI.UIElement)
CoD[@"hash_639A2F3C5F2BECC8"].__defaultWidth = 960
CoD[@"hash_639A2F3C5F2BECC8"].__defaultHeight = 240
CoD[@"hash_639A2F3C5F2BECC8"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_639A2F3C5F2BECC8"])
	self.id = "CallingCards_Prestige_Equipment_Master"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_vortex_background"))
	self:addElement(bg)
	self.bg = bg
	local jaw02 = CoD.CallingCards_Asset_jaw02.new(f1_arg0, f1_arg1, 0, 0, 754.5, 823.5, 0, 0, 145.5, 214.5)
	self:addElement(jaw02)
	self.jaw02 = jaw02
	local jaw01 = CoD.CallingCards_Asset_jaw01.new(f1_arg0, f1_arg1, 0, 0, 246, 297, 0, 0, 163.5, 214.5)
	self:addElement(jaw01)
	self.jaw01 = jaw01
	local drool01 = LUI.UIImage.new(0, 0, 254.5, 288.5, 0, 0, 167.5, 214.5)
	drool01:setImage(RegisterImage(@"uie_drool_01"))
	self:addElement(drool01)
	self.drool01 = drool01
	local drool02 = LUI.UIImage.new(0, 0, 767.5, 810.5, 0, 0, 163.5, 206.5)
	drool02:setImage(RegisterImage(@"uie_drool_02"))
	self:addElement(drool02)
	self.drool02 = drool02
	local vortex = CoD.CallingCards_Asset_vortex.new(f1_arg0, f1_arg1, 0, 0, 231, 743, 0, 0, -226.5, 285.5)
	self:addElement(vortex)
	self.vortex = vortex
	local gang = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	gang:setImage(RegisterImage(@"uie_gang"))
	self:addElement(gang)
	self.gang = gang
	local eyeFlareImage = CoD.CallingCards_Asset_skelladog_eyeglow.new(f1_arg0, f1_arg1, 0, 0, 175, 864, 0, 0, 79, 157)
	eyeFlareImage:setScale(1.35, 1.75)
	self:addElement(eyeFlareImage)
	self.eyeFlareImage = eyeFlareImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_639A2F3C5F2BECC8"].__resetProperties = function(f2_arg0)
	f2_arg0.eyeFlareImage:completeAnimation()
	f2_arg0.vortex:completeAnimation()
	f2_arg0.jaw01:completeAnimation()
	f2_arg0.drool01:completeAnimation()
	f2_arg0.drool02:completeAnimation()
	f2_arg0.jaw02:completeAnimation()
	f2_arg0.eyeFlareImage:setLeftRight(0, 0, 175, 864)
	f2_arg0.eyeFlareImage:setAlpha(1)
	f2_arg0.eyeFlareImage:setScale(1.35, 1.75)
	f2_arg0.jaw01:setLeftRight(0, 0, 246, 297)
	f2_arg0.jaw01:setTopBottom(0, 0, 163.5, 214.5)
	f2_arg0.drool01:setLeftRight(0, 0, 254.5, 288.5)
	f2_arg0.drool01:setTopBottom(0, 0, 167.5, 214.5)
	f2_arg0.drool02:setLeftRight(0, 0, 767.5, 810.5)
	f2_arg0.drool02:setTopBottom(0, 0, 163.5, 206.5)
	f2_arg0.jaw02:setTopBottom(0, 0, 145.5, 214.5)
end
CoD[@"hash_639A2F3C5F2BECC8"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(6)
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
															f15_arg0:playClip("DefaultClip")
															f15_arg0:beginAnimation(80)
															f15_arg0:setTopBottom(0, 0, 146.5, 215.5)
															f15_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
																element:playClip("DefaultClip")
																f3_arg0.clipFinished(element, event)
															end)
														end
														f14_arg0:playClip("DefaultClip")
														f14_arg0:beginAnimation(79)
														f14_arg0:setTopBottom(0, 0, 140.5, 209.5)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:playClip("DefaultClip")
													f13_arg0:beginAnimation(79)
													f13_arg0:setTopBottom(0, 0, 146.5, 215.5)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:playClip("DefaultClip")
												f12_arg0:beginAnimation(70)
												f12_arg0:setTopBottom(0, 0, 140.5, 209.5)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:playClip("DefaultClip")
											f11_arg0:beginAnimation(70)
											f11_arg0:setTopBottom(0, 0, 146.5, 215.5)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:playClip("DefaultClip")
										f10_arg0:beginAnimation(69)
										f10_arg0:setTopBottom(0, 0, 140.5, 209.5)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:playClip("DefaultClip")
									f9_arg0:beginAnimation(70)
									f9_arg0:setTopBottom(0, 0, 146.5, 215.5)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:playClip("DefaultClip")
								f8_arg0:beginAnimation(69)
								f8_arg0:setTopBottom(0, 0, 140.5, 209.5)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:playClip("DefaultClip")
							f7_arg0:beginAnimation(70)
							f7_arg0:setTopBottom(0, 0, 146.5, 215.5)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:playClip("DefaultClip")
						f6_arg0:beginAnimation(69)
						f6_arg0:setTopBottom(0, 0, 140.5, 209.5)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:playClip("DefaultClip")
					f5_arg0:beginAnimation(70)
					f5_arg0:setTopBottom(0, 0, 146.5, 215.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f4_arg0:playClip("DefaultClip")
				f4_arg0:beginAnimation(69)
				f4_arg0:setTopBottom(0, 0, 140.5, 209.5)
				f4_arg0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.jaw02:beginAnimation(1320)
			f3_arg0.jaw02:setTopBottom(0, 0, 146.5, 215.5)
			f3_arg0.jaw02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.jaw02:registerEventHandler("transition_complete_keyframe", f3_local0)
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
															f28_arg0:beginAnimation(90)
															f28_arg0:setTopBottom(0, 0, 162.5, 227.5)
															f28_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f27_arg0:beginAnimation(79)
														f27_arg0:setTopBottom(0, 0, 157.5, 222.5)
														f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
													end
													f26_arg0:beginAnimation(79)
													f26_arg0:setTopBottom(0, 0, 162.5, 227.5)
													f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
												end
												f25_arg0:beginAnimation(80)
												f25_arg0:setTopBottom(0, 0, 157.5, 222.5)
												f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
											end
											f24_arg0:beginAnimation(79)
											f24_arg0:setTopBottom(0, 0, 162.5, 227.5)
											f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
										end
										f23_arg0:beginAnimation(79)
										f23_arg0:setTopBottom(0, 0, 157.5, 222.5)
										f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
									end
									f22_arg0:beginAnimation(80)
									f22_arg0:setTopBottom(0, 0, 162.5, 227.5)
									f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
								end
								f21_arg0:beginAnimation(79)
								f21_arg0:setTopBottom(0, 0, 157.5, 222.5)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
							end
							f20_arg0:beginAnimation(80)
							f20_arg0:setTopBottom(0, 0, 162.5, 227.5)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(80)
						f19_arg0:setTopBottom(0, 0, 157.5, 222.5)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(80)
					f18_arg0:setTopBottom(0, 0, 162.5, 227.5)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f3_arg0.jaw01:beginAnimation(90)
				f3_arg0.jaw01:setTopBottom(0, 0, 157.5, 222.5)
				f3_arg0.jaw01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.jaw01:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f3_arg0.jaw01:completeAnimation()
			f3_arg0.jaw01:setLeftRight(0, 0, 247, 312)
			f3_arg0.jaw01:setTopBottom(0, 0, 162.5, 227.5)
			f3_local1(f3_arg0.jaw01)
			local f3_local2 = function(f29_arg0)
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
															f40_arg0:beginAnimation(90)
															f40_arg0:setTopBottom(0, 0, 174, 240)
															f40_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f39_arg0:beginAnimation(79)
														f39_arg0:setTopBottom(0, 0, 174, 221)
														f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
													end
													f38_arg0:beginAnimation(79)
													f38_arg0:setTopBottom(0, 0, 174, 240)
													f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
												end
												f37_arg0:beginAnimation(80)
												f37_arg0:setTopBottom(0, 0, 174, 221)
												f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
											end
											f36_arg0:beginAnimation(79)
											f36_arg0:setTopBottom(0, 0, 174, 240)
											f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
										end
										f35_arg0:beginAnimation(79)
										f35_arg0:setTopBottom(0, 0, 174, 221)
										f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
									end
									f34_arg0:beginAnimation(80)
									f34_arg0:setTopBottom(0, 0, 174, 240)
									f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
								end
								f33_arg0:beginAnimation(79)
								f33_arg0:setTopBottom(0, 0, 174, 221)
								f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
							end
							f32_arg0:beginAnimation(80)
							f32_arg0:setTopBottom(0, 0, 174, 240)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
						end
						f31_arg0:beginAnimation(80)
						f31_arg0:setTopBottom(0, 0, 174, 221)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(80)
					f30_arg0:setTopBottom(0, 0, 174, 240)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f3_arg0.drool01:beginAnimation(90)
				f3_arg0.drool01:setTopBottom(0, 0, 174, 221)
				f3_arg0.drool01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.drool01:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f3_arg0.drool01:completeAnimation()
			f3_arg0.drool01:setLeftRight(0, 0, 247, 281)
			f3_arg0.drool01:setTopBottom(0, 0, 174, 240)
			f3_local2(f3_arg0.drool01)
			local f3_local3 = function(f41_arg0)
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
															f52_arg0:beginAnimation(80)
															f52_arg0:setTopBottom(0, 0, 164.5, 207.5)
															f52_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f51_arg0:beginAnimation(79)
														f51_arg0:setTopBottom(0, 0, 164.5, 222.5)
														f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
													end
													f50_arg0:beginAnimation(69)
													f50_arg0:setTopBottom(0, 0, 164.5, 207.5)
													f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
												end
												f49_arg0:beginAnimation(80)
												f49_arg0:setTopBottom(0, 0, 164.5, 222.5)
												f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
											end
											f48_arg0:beginAnimation(80)
											f48_arg0:setTopBottom(0, 0, 164.5, 207.5)
											f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
										end
										f47_arg0:beginAnimation(69)
										f47_arg0:setTopBottom(0, 0, 164.5, 222.5)
										f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
									end
									f46_arg0:beginAnimation(70)
									f46_arg0:setTopBottom(0, 0, 164.5, 207.5)
									f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
								end
								f45_arg0:beginAnimation(59)
								f45_arg0:setTopBottom(0, 0, 164.5, 222.5)
								f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
							end
							f44_arg0:beginAnimation(70)
							f44_arg0:setTopBottom(0, 0, 164.5, 207.5)
							f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
						end
						f43_arg0:beginAnimation(79)
						f43_arg0:setTopBottom(0, 0, 164.5, 222.5)
						f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
					end
					f42_arg0:beginAnimation(70)
					f42_arg0:setTopBottom(0, 0, 164.5, 207.5)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
				end
				f41_arg0:beginAnimation(70)
				f41_arg0:setTopBottom(0, 0, 164.5, 222.5)
				f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f3_arg0.drool02:beginAnimation(1310)
			f3_arg0.drool02:setLeftRight(0, 0, 767.5, 810.5)
			f3_arg0.drool02:setTopBottom(0, 0, 164.5, 207.5)
			f3_arg0.drool02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.drool02:registerEventHandler("transition_complete_keyframe", f3_local3)
			f3_arg0.vortex:completeAnimation()
			f3_arg0.vortex:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.vortex)
			local f3_local4 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					f54_arg0:beginAnimation(1990)
					f54_arg0:setAlpha(0)
					f54_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.eyeFlareImage:beginAnimation(2000)
				f3_arg0.eyeFlareImage:setAlpha(1)
				f3_arg0.eyeFlareImage:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.eyeFlareImage:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f3_arg0.eyeFlareImage:completeAnimation()
			f3_arg0.eyeFlareImage:setLeftRight(0, 0, 172, 861)
			f3_arg0.eyeFlareImage:setAlpha(0)
			f3_arg0.eyeFlareImage:setScale(1.33, 1.75)
			f3_local4(f3_arg0.eyeFlareImage)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_639A2F3C5F2BECC8"].__onClose = function(f55_arg0)
	f55_arg0.jaw02:close()
	f55_arg0.jaw01:close()
	f55_arg0.vortex:close()
	f55_arg0.eyeFlareImage:close()
end
