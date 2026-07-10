CoD.ui_icon_callingcards_crimewave_wheelspin01 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_crimewave_wheelspin01.__defaultWidth = 80
CoD.ui_icon_callingcards_crimewave_wheelspin01.__defaultHeight = 120
CoD.ui_icon_callingcards_crimewave_wheelspin01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_crimewave_wheelspin01)
	self.id = "ui_icon_callingcards_crimewave_wheelspin01"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local wheel1 = LUI.UIImage.new(0, 0, 0, 80, 0, 0, 0, 120)
	wheel1:setImage(RegisterImage(0x85DA172DC012DA1))
	self:addElement(wheel1)
	self.wheel1 = wheel1
	local wheel2 = LUI.UIImage.new(0, 0, 0, 80, 0, 0, 0, 120)
	wheel2:setImage(RegisterImage(0x85D9E72DC012888))
	self:addElement(wheel2)
	self.wheel2 = wheel2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_crimewave_wheelspin01.__resetProperties = function(f2_arg0)
	f2_arg0.wheel2:completeAnimation()
	f2_arg0.wheel2:setAlpha(1)
end
CoD.ui_icon_callingcards_crimewave_wheelspin01.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
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
																							f23_arg0:beginAnimation(100)
																							f23_arg0:setAlpha(0)
																							f23_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																						end
																						f22_arg0:beginAnimation(100)
																						f22_arg0:setAlpha(1)
																						f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
																					end
																					f21_arg0:beginAnimation(99)
																					f21_arg0:setAlpha(0)
																					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
																				end
																				f20_arg0:beginAnimation(100)
																				f20_arg0:setAlpha(1)
																				f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
																			end
																			f19_arg0:beginAnimation(100)
																			f19_arg0:setAlpha(0)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																		end
																		f18_arg0:beginAnimation(100)
																		f18_arg0:setAlpha(1)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(100)
																	f17_arg0:setAlpha(0)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(99)
																f16_arg0:setAlpha(1)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(100)
															f15_arg0:setAlpha(0)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(100)
														f14_arg0:setAlpha(1)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(100)
													f13_arg0:setAlpha(0)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(99)
												f12_arg0:setAlpha(1)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(100)
											f11_arg0:setAlpha(0)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(99)
										f10_arg0:setAlpha(1)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(100)
									f9_arg0:setAlpha(0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(99)
								f8_arg0:setAlpha(1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(99)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(100)
						f6_arg0:setAlpha(1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(100)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.wheel2:beginAnimation(100)
				f3_arg0.wheel2:setAlpha(1)
				f3_arg0.wheel2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.wheel2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.wheel2:completeAnimation()
			f3_arg0.wheel2:setAlpha(0)
			f3_local0(f3_arg0.wheel2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
