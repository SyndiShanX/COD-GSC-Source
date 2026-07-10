CoD.CallingCards_Asset_party1 = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_party1.__defaultWidth = 624
CoD.CallingCards_Asset_party1.__defaultHeight = 240
CoD.CallingCards_Asset_party1.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_party1)
	self.id = "CallingCards_Asset_party1"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local party1 = LUI.UIImage.new(0, 0, 0, 624, 0, 0, 0, 240)
	party1:setRGB(0.29, 0, 0)
	party1:setAlpha(0.5)
	party1:setImage(RegisterImage(@"uie_ui_icon_callingcards_prestige_master_lightlaser_party1"))
	self:addElement(party1)
	self.party1 = party1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_party1.__resetProperties = function(f2_arg0)
	f2_arg0.party1:completeAnimation()
	f2_arg0.party1:setTopBottom(0, 0, 0, 240)
	f2_arg0.party1:setScale(1, 1)
end
CoD.CallingCards_Asset_party1.__clipsPerState = {
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
																	f17_arg0:beginAnimation(319)
																	f17_arg0:setTopBottom(0, 0, 10, 250)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																end
																f16_arg0:beginAnimation(350)
																f16_arg0:setTopBottom(0, 0, 1, 241)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(319)
															f15_arg0:setTopBottom(0, 0, 10, 250)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(279)
														f14_arg0:setTopBottom(0, 0, 1, 241)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(269)
													f13_arg0:setTopBottom(0, 0, 10, 250)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(260)
												f12_arg0:setTopBottom(0, 0, 1, 241)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(270)
											f11_arg0:setTopBottom(0, 0, 10, 250)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(279)
										f10_arg0:setTopBottom(0, 0, 1, 241)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(260)
									f9_arg0:setTopBottom(0, 0, 10, 250)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(269)
								f8_arg0:setTopBottom(0, 0, 1, 241)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(290)
							f7_arg0:setTopBottom(0, 0, 10, 250)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(300)
						f6_arg0:setTopBottom(0, 0, 1, 241)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(269)
					f5_arg0:setTopBottom(0, 0, 10, 250)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.party1:beginAnimation(260)
				f3_arg0.party1:setTopBottom(0, 0, 1, 241)
				f3_arg0.party1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.party1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.party1:completeAnimation()
			f3_arg0.party1:setTopBottom(0, 0, 10, 250)
			f3_arg0.party1:setScale(1.02, 1.02)
			f3_local0(f3_arg0.party1)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
