CoD.ui_icon_callingcards_robber_laser = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_robber_laser.__defaultWidth = 960
CoD.ui_icon_callingcards_robber_laser.__defaultHeight = 240
CoD.ui_icon_callingcards_robber_laser.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_robber_laser)
	self.id = "ui_icon_callingcards_robber_laser"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lasers = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lasers:setImage(RegisterImage(@"uie_ui_menu_callingcards_robbery_lasers"))
	lasers:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(lasers)
	self.lasers = lasers
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_robber_laser.__resetProperties = function(f2_arg0)
	f2_arg0.lasers:completeAnimation()
	f2_arg0.lasers:setAlpha(1)
	f2_arg0.lasers:setZRot(0)
end
CoD.ui_icon_callingcards_robber_laser.__clipsPerState = {
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
																					f21_arg0:beginAnimation(69)
																					f21_arg0:setAlpha(0.5)
																					f21_arg0:setZRot(0)
																					f21_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																				end
																				f20_arg0:beginAnimation(70)
																				f20_arg0:setAlpha(1)
																				f20_arg0:setZRot(0)
																				f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
																			end
																			f19_arg0:beginAnimation(359, Enum[@"luitween"][@"luitween_ease_out"])
																			f19_arg0:setAlpha(0.3)
																			f19_arg0:setZRot(-1)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																		end
																		f18_arg0:beginAnimation(69)
																		f18_arg0:setAlpha(1)
																		f18_arg0:setZRot(-3)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(70)
																	f17_arg0:setAlpha(0.5)
																	f17_arg0:setZRot(-3)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(359)
																f16_arg0:setAlpha(1)
																f16_arg0:setZRot(-2)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(360)
															f15_arg0:setAlpha(0.75)
															f15_arg0:setZRot(0)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(69)
														f14_arg0:setAlpha(0.5)
														f14_arg0:setZRot(4)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(70)
													f13_arg0:setAlpha(1)
													f13_arg0:setZRot(4)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(360)
												f12_arg0:setAlpha(0.3)
												f12_arg0:setZRot(5)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(69)
											f11_arg0:setAlpha(1)
											f11_arg0:setZRot(1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(70)
										f10_arg0:setAlpha(0.5)
										f10_arg0:setZRot(1)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(360)
									f9_arg0:setAlpha(1)
									f9_arg0:setZRot(0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(69)
								f8_arg0:setAlpha(0.5)
								f8_arg0:setZRot(-4)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(69)
							f7_arg0:setAlpha(1)
							f7_arg0:setZRot(-4)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(360, Enum[@"luitween"][@"luitween_ease_in"])
						f6_arg0:setAlpha(0.3)
						f6_arg0:setZRot(-5)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(70)
					f5_arg0:setAlpha(1)
					f5_arg0:setZRot(-1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.lasers:beginAnimation(70)
				f3_arg0.lasers:setAlpha(0.5)
				f3_arg0.lasers:setZRot(0)
				f3_arg0.lasers:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lasers:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.lasers:completeAnimation()
			f3_arg0.lasers:setAlpha(1)
			f3_arg0.lasers:setZRot(0)
			f3_local0(f3_arg0.lasers)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
