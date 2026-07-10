require("x64:ac7b4e6db1cf2f6")
CoD.CallingCards_replacer_scooter = InheritFrom(LUI.UIElement)
CoD.CallingCards_replacer_scooter.__defaultWidth = 496
CoD.CallingCards_replacer_scooter.__defaultHeight = 240
CoD.CallingCards_replacer_scooter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_replacer_scooter)
	self.id = "CallingCards_replacer_scooter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local scooter = LUI.UIImage.new(0, 0, 0, 496, 0, 0, 0, 240)
	scooter:setImage(RegisterImage(@"hash_5992AED67DBD0726"))
	self:addElement(scooter)
	self.scooter = scooter
	local smoke = CoD.CallingCards_replacer_smoke.new(f1_arg0, f1_arg1, 0, 0, 474.5, 484.5, 0, 0, 224.5, 234.5)
	self:addElement(smoke)
	self.smoke = smoke
	local smoke2 = CoD.CallingCards_replacer_smoke.new(f1_arg0, f1_arg1, 0, 0, 456.5, 466.5, 0, 0, 240, 250)
	smoke2:setAlpha(0.1)
	smoke2:setScale(0.25, 0.5)
	self:addElement(smoke2)
	self.smoke2 = smoke2
	local smoke3 = CoD.CallingCards_replacer_smoke.new(f1_arg0, f1_arg1, 0, 0, 456.5, 466.5, 0, 0, 240, 250)
	smoke3:setAlpha(0)
	self:addElement(smoke3)
	self.smoke3 = smoke3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_replacer_scooter.__resetProperties = function(f2_arg0)
	f2_arg0.smoke:completeAnimation()
	f2_arg0.smoke2:completeAnimation()
	f2_arg0.smoke3:completeAnimation()
	f2_arg0.smoke:setLeftRight(0, 0, 474.5, 484.5)
	f2_arg0.smoke:setTopBottom(0, 0, 224.5, 234.5)
	f2_arg0.smoke:setAlpha(1)
	f2_arg0.smoke:setScale(1, 1)
	f2_arg0.smoke2:setLeftRight(0, 0, 456.5, 466.5)
	f2_arg0.smoke2:setTopBottom(0, 0, 240, 250)
	f2_arg0.smoke2:setAlpha(0.1)
	f2_arg0.smoke2:setScale(0.25, 0.5)
	f2_arg0.smoke3:setLeftRight(0, 0, 456.5, 466.5)
	f2_arg0.smoke3:setTopBottom(0, 0, 240, 250)
	f2_arg0.smoke3:setAlpha(0)
	f2_arg0.smoke3:setScale(1, 1)
end
CoD.CallingCards_replacer_scooter.__clipsPerState = {
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
											local f11_local0 = function(f12_arg0)
												local f12_local0 = function(f13_arg0)
													local f13_local0 = function(f14_arg0)
														local f14_local0 = function(f15_arg0)
															f15_arg0:beginAnimation(1590)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f14_arg0:beginAnimation(59)
														f14_arg0:setAlpha(0)
														f14_arg0:setScale(1, 1)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(349)
													f13_arg0:setAlpha(0.5)
													f13_arg0:setScale(0.89, 0.93)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(1089)
												f12_arg0:setScale(0.25, 0.5)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(400)
											f11_arg0:setScale(0.8, 0.87)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(99)
										f10_arg0:setAlpha(0)
										f10_arg0:setScale(1, 1)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(420)
									f9_arg0:setAlpha(0.58)
									f9_arg0:setScale(0.86, 0.9)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(9)
								f8_arg0:setScale(0.25, 0.5)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(1100)
							f7_arg0:setScale(0.25, 0.5)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(400)
						f6_arg0:setScale(0.8, 0.87)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(99)
					f5_arg0:setAlpha(0)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.smoke:beginAnimation(380)
				f3_arg0.smoke:setAlpha(0.58)
				f3_arg0.smoke:setScale(0.84, 0.9)
				f3_arg0.smoke:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.smoke:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.smoke:completeAnimation()
			f3_arg0.smoke:setLeftRight(0, 0, 456.5, 466.5)
			f3_arg0.smoke:setTopBottom(0, 0, 240, 250)
			f3_arg0.smoke:setAlpha(0)
			f3_arg0.smoke:setScale(0.25, 0.5)
			f3_local0(f3_arg0.smoke)
			local f3_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
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
															f27_arg0:beginAnimation(1090)
															f27_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f26_arg0:beginAnimation(99)
														f26_arg0:setAlpha(0)
														f26_arg0:setScale(1, 1)
														f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
													end
													f25_arg0:beginAnimation(449)
													f25_arg0:setAlpha(0.58)
													f25_arg0:setScale(0.86, 0.91)
													f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
												end
												f24_arg0:beginAnimation(10)
												f24_arg0:setAlpha(0.1)
												f24_arg0:setScale(0.25, 0.5)
												f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
											end
											f23_arg0:beginAnimation(1439)
											f23_arg0:setScale(0.26, 0.5)
											f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
										end
										f22_arg0:beginAnimation(100)
										f22_arg0:setAlpha(0)
										f22_arg0:setScale(1, 1)
										f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
									end
									f21_arg0:beginAnimation(409)
									f21_arg0:setAlpha(0.58)
									f21_arg0:setScale(0.85, 0.9)
									f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
								end
								f20_arg0:beginAnimation(9)
								f20_arg0:setAlpha(0.1)
								f20_arg0:setScale(0.25, 0.5)
								f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
							end
							f19_arg0:beginAnimation(1490)
							f19_arg0:setScale(0.25, 0.5)
							f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
						end
						f18_arg0:beginAnimation(99)
						f18_arg0:setAlpha(0)
						f18_arg0:setScale(1, 1)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
					end
					f17_arg0:beginAnimation(320)
					f17_arg0:setAlpha(0.58)
					f17_arg0:setScale(0.82, 0.88)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f3_arg0.smoke2:beginAnimation(480)
				f3_arg0.smoke2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.smoke2:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f3_arg0.smoke2:completeAnimation()
			f3_arg0.smoke2:setLeftRight(0, 0, 456.5, 466.5)
			f3_arg0.smoke2:setTopBottom(0, 0, 240, 250)
			f3_arg0.smoke2:setAlpha(0)
			f3_arg0.smoke2:setScale(0.25, 0.5)
			f3_local1(f3_arg0.smoke2)
			local f3_local2 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
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
															f39_arg0:beginAnimation(99)
															f39_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f38_arg0:beginAnimation(990)
														f38_arg0:setAlpha(0)
														f38_arg0:setScale(1, 1)
														f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
													end
													f37_arg0:beginAnimation(9)
													f37_arg0:setAlpha(0.58)
													f37_arg0:setScale(0.26, 0.5)
													f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
												end
												f36_arg0:beginAnimation(910)
												f36_arg0:setScale(0.25, 0.5)
												f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
											end
											f35_arg0:beginAnimation(500)
											f35_arg0:setScale(0.73, 0.82)
											f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
										end
										f34_arg0:beginAnimation(99)
										f34_arg0:setAlpha(0)
										f34_arg0:setScale(1, 1)
										f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
									end
									f33_arg0:beginAnimation(460)
									f33_arg0:setAlpha(0.58)
									f33_arg0:setScale(0.87, 0.91)
									f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
								end
								f32_arg0:beginAnimation(19)
								f32_arg0:setScale(0.25, 0.5)
								f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
							end
							f31_arg0:beginAnimation(1510)
							f31_arg0:setScale(0.26, 0.51)
							f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
						end
						f30_arg0:beginAnimation(100)
						f30_arg0:setAlpha(0)
						f30_arg0:setScale(1, 1)
						f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
					end
					f29_arg0:beginAnimation(399)
					f29_arg0:setAlpha(0.58)
					f29_arg0:setScale(0.85, 0.9)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
				end
				f3_arg0.smoke3:beginAnimation(900)
				f3_arg0.smoke3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.smoke3:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f3_arg0.smoke3:completeAnimation()
			f3_arg0.smoke3:setLeftRight(0, 0, 456.5, 466.5)
			f3_arg0.smoke3:setTopBottom(0, 0, 240, 250)
			f3_arg0.smoke3:setAlpha(0)
			f3_arg0.smoke3:setScale(0.25, 0.5)
			f3_local2(f3_arg0.smoke3)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.CallingCards_replacer_scooter.__onClose = function(f40_arg0)
	f40_arg0.smoke:close()
	f40_arg0.smoke2:close()
	f40_arg0.smoke3:close()
end
