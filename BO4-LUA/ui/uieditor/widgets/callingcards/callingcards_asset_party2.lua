CoD.CallingCards_Asset_party2 = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_party2.__defaultWidth = 600
CoD.CallingCards_Asset_party2.__defaultHeight = 240
CoD.CallingCards_Asset_party2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_party2)
	self.id = "CallingCards_Asset_party2"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local party2 = LUI.UIImage.new(0, 0, 0, 600, 0, 0, 0, 240)
	party2:setRGB(0.29, 0, 0)
	party2:setAlpha(0.5)
	party2:setImage(RegisterImage(0xF3BE6C7DE036CD))
	self:addElement(party2)
	self.party2 = party2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_party2.__resetProperties = function(f2_arg0)
	f2_arg0.party2:completeAnimation()
	f2_arg0.party2:setTopBottom(0, 0, 0, 240)
	f2_arg0.party2:setScale(1, 1)
end
CoD.CallingCards_Asset_party2.__clipsPerState = {
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
																			f19_arg0:beginAnimation(260)
																			f19_arg0:setTopBottom(0, 0, 0, 240)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																		end
																		f18_arg0:beginAnimation(240)
																		f18_arg0:setTopBottom(0, 0, -10, 230)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(260)
																	f17_arg0:setTopBottom(0, 0, 0, 240)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(240)
																f16_arg0:setTopBottom(0, 0, -10, 230)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(260)
															f15_arg0:setTopBottom(0, 0, 0, 240)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(260)
														f14_arg0:setTopBottom(0, 0, -10, 230)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(260)
													f13_arg0:setTopBottom(0, 0, 0, 240)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(250)
												f12_arg0:setTopBottom(0, 0, -10, 230)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(260)
											f11_arg0:setTopBottom(0, 0, 0, 240)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(220)
										f10_arg0:setTopBottom(0, 0, -10, 230)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(260)
									f9_arg0:setTopBottom(0, 0, 0, 240)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(250)
								f8_arg0:setTopBottom(0, 0, -10, 230)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(270)
							f7_arg0:setTopBottom(0, 0, 0, 240)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(269)
						f6_arg0:setTopBottom(0, 0, -10, 230)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(260)
					f5_arg0:setTopBottom(0, 0, 0, 240)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.party2:beginAnimation(180)
				f3_arg0.party2:setTopBottom(0, 0, -10, 230)
				f3_arg0.party2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.party2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.party2:completeAnimation()
			f3_arg0.party2:setTopBottom(0, 0, 0, 240)
			f3_arg0.party2:setScale(1.02, 1.02)
			f3_local0(f3_arg0.party2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
