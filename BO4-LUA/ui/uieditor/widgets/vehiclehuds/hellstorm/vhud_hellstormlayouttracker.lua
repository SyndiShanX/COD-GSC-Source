CoD.vhud_HellstormLayoutTracker = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormLayoutTracker.__defaultWidth = 592
CoD.vhud_HellstormLayoutTracker.__defaultHeight = 68
CoD.vhud_HellstormLayoutTracker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormLayoutTracker)
	self.id = "vhud_HellstormLayoutTracker"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LayoutTracker = LUI.UIImage.new(0, 0, 0, 592, 0, 0, 0, 68)
	LayoutTracker:setAlpha(0.5)
	LayoutTracker:setScale(0.5, 0.5)
	LayoutTracker:setImage(RegisterImage(0xAA63CDB31348F4))
	LayoutTracker:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	LayoutTracker:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(LayoutTracker)
	self.LayoutTracker = LayoutTracker
	local TrackingBar = LUI.UIImage.new(0, 0, 365.5, 377.5, 0, 0, 34, 50)
	TrackingBar:setImage(RegisterImage(0x4B7002AD21F76C7))
	TrackingBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TrackingBar:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(TrackingBar)
	self.TrackingBar = TrackingBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_HellstormLayoutTracker.__resetProperties = function(f2_arg0)
	f2_arg0.TrackingBar:completeAnimation()
	f2_arg0.TrackingBar:setAlpha(1)
	f2_arg0.TrackingBar:setZRot(0)
end
CoD.vhud_HellstormLayoutTracker.__clipsPerState = {
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
																				f20_arg0:beginAnimation(9)
																				f20_arg0:setAlpha(0.9)
																				f20_arg0:setZRot(360)
																				f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																			end
																			f19_arg0:beginAnimation(240)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																		end
																		f18_arg0:beginAnimation(9)
																		f18_arg0:setZRot(315)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(240)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(9)
																f16_arg0:setZRot(270)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(240)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(9)
														f14_arg0:setZRot(225)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(240)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(9)
												f12_arg0:setZRot(180)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(240)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(9)
										f10_arg0:setZRot(135)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(240)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(9)
								f8_arg0:setZRot(90)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(240)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(10)
						f6_arg0:setZRot(45)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(229)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.TrackingBar:beginAnimation(10)
				f3_arg0.TrackingBar:setAlpha(0.3)
				f3_arg0.TrackingBar:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TrackingBar:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.TrackingBar:completeAnimation()
			f3_arg0.TrackingBar:setAlpha(0.9)
			f3_arg0.TrackingBar:setZRot(0)
			f3_local0(f3_arg0.TrackingBar)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
