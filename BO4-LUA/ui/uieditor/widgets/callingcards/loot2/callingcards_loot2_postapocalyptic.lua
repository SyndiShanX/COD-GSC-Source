CoD[@"hash_6A9B99FD1C2A5E41"] = InheritFrom(LUI.UIElement)
CoD[@"hash_6A9B99FD1C2A5E41"].__defaultWidth = 960
CoD[@"hash_6A9B99FD1C2A5E41"].__defaultHeight = 240
CoD[@"hash_6A9B99FD1C2A5E41"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_6A9B99FD1C2A5E41"])
	self.id = "callingcards_loot2_postapocalyptic"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_menu_callingcards_postapocalyptic_bg"))
	self:addElement(bg)
	self.bg = bg
	local light = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	light:setImage(RegisterImage(@"uie_ui_menu_callingcards_postapocalyptic_light"))
	self:addElement(light)
	self.light = light
	local smoke = LUI.UIImage.new(0, 0, 150, 1110, 0, 0, 0, 240)
	smoke:setImage(RegisterImage(@"uie_ui_menu_callingcards_postapocalyptic_smoke"))
	smoke:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(smoke)
	self.smoke = smoke
	local smoke2 = LUI.UIImage.new(0, 0, -50, 910, 0, 0, 90, 240)
	smoke2:setScale(-1, 1)
	smoke2:setImage(RegisterImage(@"uie_ui_menu_callingcards_postapocalyptic_smoke"))
	smoke2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(smoke2)
	self.smoke2 = smoke2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_6A9B99FD1C2A5E41"].__resetProperties = function(f2_arg0)
	f2_arg0.light:completeAnimation()
	f2_arg0.smoke:completeAnimation()
	f2_arg0.smoke2:completeAnimation()
	f2_arg0.light:setAlpha(1)
	f2_arg0.smoke:setLeftRight(0, 0, 150, 1110)
	f2_arg0.smoke:setAlpha(1)
	f2_arg0.smoke2:setLeftRight(0, 0, -50, 910)
	f2_arg0.smoke2:setAlpha(1)
end
CoD[@"hash_6A9B99FD1C2A5E41"].__clipsPerState = {
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
																		f18_arg0:beginAnimation(209)
																		f18_arg0:setAlpha(0)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																	end
																	f17_arg0:beginAnimation(49)
																	f17_arg0:setAlpha(1)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(540)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(99)
															f15_arg0:setAlpha(0)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(50)
														f14_arg0:setAlpha(1)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(100)
													f13_arg0:setAlpha(0)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(49)
												f12_arg0:setAlpha(1)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(269)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(110)
										f10_arg0:setAlpha(0)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(50)
									f9_arg0:setAlpha(1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(269)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(100)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(49)
						f6_arg0:setAlpha(1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(100)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.light:beginAnimation(50)
				f3_arg0.light:setAlpha(1)
				f3_arg0.light:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.light:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.light:completeAnimation()
			f3_arg0.light:setAlpha(0)
			f3_local0(f3_arg0.light)
			local f3_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(599, Enum[@"luitween"][@"luitween_ease_both"])
					f20_arg0:setLeftRight(0, 0, -50, 910)
					f20_arg0:setAlpha(0)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.smoke:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.smoke:setLeftRight(0, 0, -31.17, 928.83)
				f3_arg0.smoke:setAlpha(1)
				f3_arg0.smoke:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.smoke:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f3_arg0.smoke:completeAnimation()
			f3_arg0.smoke:setLeftRight(0, 0, 50, 1010)
			f3_arg0.smoke:setAlpha(0)
			f3_local1(f3_arg0.smoke)
			local f3_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(1599, Enum[@"luitween"][@"luitween_ease_both"])
					f22_arg0:setLeftRight(0, 0, 50, 1010)
					f22_arg0:setAlpha(0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.smoke2:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.smoke2:setLeftRight(0, 0, -36.65, 923.35)
				f3_arg0.smoke2:setAlpha(0.8)
				f3_arg0.smoke2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.smoke2:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f3_arg0.smoke2:completeAnimation()
			f3_arg0.smoke2:setLeftRight(0, 0, -50, 910)
			f3_arg0.smoke2:setAlpha(0)
			f3_local2(f3_arg0.smoke2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
