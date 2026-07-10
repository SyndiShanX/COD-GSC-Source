CoD.ui_icon_callingcards_dystopian_headglow = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_dystopian_headglow.__defaultWidth = 96
CoD.ui_icon_callingcards_dystopian_headglow.__defaultHeight = 112
CoD.ui_icon_callingcards_dystopian_headglow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_dystopian_headglow)
	self.id = "ui_icon_callingcards_dystopian_headglow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local face = LUI.UIImage.new(0, 0, 0, 96, 0, 0, 0, 112)
	face:setImage(RegisterImage(0x1ECF9AC837D919C))
	self:addElement(face)
	self.face = face
	local faceglow = LUI.UIImage.new(0, 0, 0, 96, 0, 0, 0, 112)
	faceglow:setImage(RegisterImage(0xAB452A73A419F64))
	self:addElement(faceglow)
	self.faceglow = faceglow
	local eyeglow = LUI.UIImage.new(0, 0, -3.5, 60.5, 0, 0, 20, 84)
	eyeglow:setImage(RegisterImage(0x6DE7B21C34ECCEE))
	eyeglow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(eyeglow)
	self.eyeglow = eyeglow
	local eyeglow2 = LUI.UIImage.new(0, 0, 20.5, 84.5, 0, 0, 22, 86)
	eyeglow2:setImage(RegisterImage(0x6DE7B21C34ECCEE))
	eyeglow2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(eyeglow2)
	self.eyeglow2 = eyeglow2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_dystopian_headglow.__resetProperties = function(f2_arg0)
	f2_arg0.faceglow:completeAnimation()
	f2_arg0.eyeglow:completeAnimation()
	f2_arg0.eyeglow2:completeAnimation()
	f2_arg0.faceglow:setAlpha(1)
	f2_arg0.eyeglow:setAlpha(1)
	f2_arg0.eyeglow2:setAlpha(1)
end
CoD.ui_icon_callingcards_dystopian_headglow.__clipsPerState = {
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
															local f15_local0 = function(f16_arg0)
																local f16_local0 = function(f17_arg0)
																	local f17_local0 = function(f18_arg0)
																		local f18_local0 = function(f19_arg0)
																			local f19_local0 = function(f20_arg0)
																				local f20_local0 = function(f21_arg0)
																					local f21_local0 = function(f22_arg0)
																						local f22_local0 = function(f23_arg0)
																							local f23_local0 = function(f24_arg0)
																								f24_arg0:beginAnimation(39)
																								f24_arg0:setAlpha(0)
																								f24_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																							end
																							f23_arg0:beginAnimation(39)
																							f23_arg0:setAlpha(1)
																							f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
																						end
																						f22_arg0:beginAnimation(90)
																						f22_arg0:setAlpha(0)
																						f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
																					end
																					f21_arg0:beginAnimation(39)
																					f21_arg0:setAlpha(1)
																					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
																				end
																				f20_arg0:beginAnimation(100)
																				f20_arg0:setAlpha(0)
																				f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
																			end
																			f19_arg0:beginAnimation(39)
																			f19_arg0:setAlpha(1)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																		end
																		f18_arg0:beginAnimation(100)
																		f18_arg0:setAlpha(0)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(39)
																	f17_arg0:setAlpha(1)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(100)
																f16_arg0:setAlpha(0)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(39)
															f15_arg0:setAlpha(1)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(950)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(40)
													f13_arg0:setAlpha(0)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(39)
												f12_arg0:setAlpha(1)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(90)
											f11_arg0:setAlpha(0)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(40)
										f10_arg0:setAlpha(1)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(99)
									f9_arg0:setAlpha(0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(39)
								f8_arg0:setAlpha(1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(99)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(40)
						f6_arg0:setAlpha(1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(100)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.faceglow:beginAnimation(40)
				f3_arg0.faceglow:setAlpha(1)
				f3_arg0.faceglow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.faceglow:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.faceglow:completeAnimation()
			f3_arg0.faceglow:setAlpha(0)
			f3_local0(f3_arg0.faceglow)
			local f3_local1 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						local f27_local0 = function(f28_arg0)
							f28_arg0:beginAnimation(599)
							f28_arg0:setAlpha(0)
							f28_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f27_arg0:beginAnimation(1000)
						f27_arg0:setAlpha(1)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
					end
					f26_arg0:beginAnimation(700)
					f26_arg0:setAlpha(0)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f3_arg0.eyeglow:beginAnimation(700)
				f3_arg0.eyeglow:setAlpha(1)
				f3_arg0.eyeglow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.eyeglow:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f3_arg0.eyeglow:completeAnimation()
			f3_arg0.eyeglow:setAlpha(0)
			f3_local1(f3_arg0.eyeglow)
			local f3_local2 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						local f31_local0 = function(f32_arg0)
							f32_arg0:beginAnimation(400)
							f32_arg0:setAlpha(0)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f31_arg0:beginAnimation(1409)
						f31_arg0:setAlpha(1)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(680)
					f30_arg0:setAlpha(0)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f3_arg0.eyeglow2:beginAnimation(510)
				f3_arg0.eyeglow2:setAlpha(1)
				f3_arg0.eyeglow2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.eyeglow2:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f3_arg0.eyeglow2:completeAnimation()
			f3_arg0.eyeglow2:setAlpha(0)
			f3_local2(f3_arg0.eyeglow2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
