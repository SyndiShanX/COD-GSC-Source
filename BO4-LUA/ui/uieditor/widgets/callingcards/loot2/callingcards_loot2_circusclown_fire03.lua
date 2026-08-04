CoD.callingcards_loot2_circusclown_fire03 = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_circusclown_fire03.__defaultWidth = 120
CoD.callingcards_loot2_circusclown_fire03.__defaultHeight = 264
CoD.callingcards_loot2_circusclown_fire03.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_circusclown_fire03)
	self.id = "callingcards_loot2_circusclown_fire03"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fire03 = LUI.UIImage.new(0, 0, 0, 120, 0, 0, 24, 288)
	fire03:setImage(RegisterImage("uie_ui_menu_callingcards_circusclown_fire01"))
	fire03:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(fire03)
	self.fire03 = fire03
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_loot2_circusclown_fire03.__resetProperties = function(f2_arg0)
	f2_arg0.fire03:completeAnimation()
	f2_arg0.fire03:setLeftRight(0, 0, 0, 120)
	f2_arg0.fire03:setTopBottom(0, 0, 24, 288)
	f2_arg0.fire03:setScale(1, 1)
end
CoD.callingcards_loot2_circusclown_fire03.__clipsPerState = {
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
																					f21_arg0:beginAnimation(200)
																					f21_arg0:setTopBottom(0, 0, 24, 288)
																					f21_arg0:setScale(1, 1)
																					f21_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																				end
																				f20_arg0:beginAnimation(200)
																				f20_arg0:setTopBottom(0, 0, 36, 300)
																				f20_arg0:setScale(1, 0.9)
																				f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
																			end
																			f19_arg0:beginAnimation(199)
																			f19_arg0:setTopBottom(0, 0, 26, 290)
																			f19_arg0:setScale(1, 1)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																		end
																		f18_arg0:beginAnimation(400)
																		f18_arg0:setTopBottom(0, 0, 36, 300)
																		f18_arg0:setScale(1, 0.9)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(100)
																	f17_arg0:setTopBottom(0, 0, 26, 290)
																	f17_arg0:setScale(1, 1)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(199)
																f16_arg0:setTopBottom(0, 0, 30.5, 294.5)
																f16_arg0:setScale(1, 0.95)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(100)
															f15_arg0:setTopBottom(0, 0, 26, 290)
															f15_arg0:setScale(1, 1)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(200)
														f14_arg0:setTopBottom(0, 0, 30.5, 294.5)
														f14_arg0:setScale(1, 0.95)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(100)
													f13_arg0:setTopBottom(0, 0, 26, 290)
													f13_arg0:setScale(1, 1)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(229)
												f12_arg0:setTopBottom(0, 0, 35.5, 299.5)
												f12_arg0:setScale(1, 0.9)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(70)
											f11_arg0:setTopBottom(0, 0, 25.5, 289.5)
											f11_arg0:setScale(1, 1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(230)
										f10_arg0:setTopBottom(0, 0, 36, 300)
										f10_arg0:setScale(1, 0.9)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(69)
									f9_arg0:setTopBottom(0, 0, 26, 290)
									f9_arg0:setScale(1, 1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(130)
								f8_arg0:setTopBottom(0, 0, 31, 295)
								f8_arg0:setScale(1, 0.95)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(69)
							f7_arg0:setTopBottom(0, 0, 26, 290)
							f7_arg0:setScale(1, 1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(199)
						f6_arg0:setTopBottom(0, 0, 31, 295)
						f6_arg0:setScale(1, 0.95)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(100)
					f5_arg0:setTopBottom(0, 0, 14.5, 278.5)
					f5_arg0:setScale(1, 1.1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.fire03:beginAnimation(200)
				f3_arg0.fire03:setTopBottom(0, 0, 36, 300)
				f3_arg0.fire03:setScale(1, 0.9)
				f3_arg0.fire03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.fire03:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.fire03:completeAnimation()
			f3_arg0.fire03:setLeftRight(0, 0, 0, 120)
			f3_arg0.fire03:setTopBottom(0, 0, 24, 288)
			f3_arg0.fire03:setScale(1, 1)
			f3_local0(f3_arg0.fire03)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
