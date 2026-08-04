CoD.CallingCards_Asset_steampunkwarriors_shoulder = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_steampunkwarriors_shoulder.__defaultWidth = 200
CoD.CallingCards_Asset_steampunkwarriors_shoulder.__defaultHeight = 120
CoD.CallingCards_Asset_steampunkwarriors_shoulder.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_steampunkwarriors_shoulder)
	self.id = "CallingCards_Asset_steampunkwarriors_shoulder"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local shoulder = LUI.UIImage.new(0, 0, 0, 200, 0, 0, 0, 120)
	shoulder:setImage(RegisterImage(@"hash_19E4EEFF9D420C85"))
	self:addElement(shoulder)
	self.shoulder = shoulder
	local light = LUI.UIImage.new(0, 0, 80.5, 175.5, 0, 0, -15.5, 79.5)
	light:setImage(RegisterImage(@"hash_7ADBF2ABD5CCB0FC"))
	light:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(light)
	self.light = light
	local light2 = LUI.UIImage.new(0, 0, 128, 201, 0, 0, 12, 85)
	light2:setImage(RegisterImage(@"hash_7ADBF2ABD5CCB0FC"))
	light2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(light2)
	self.light2 = light2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_steampunkwarriors_shoulder.__resetProperties = function(f2_arg0)
	f2_arg0.light2:completeAnimation()
	f2_arg0.light:completeAnimation()
	f2_arg0.light2:setAlpha(1)
	f2_arg0.light:setAlpha(1)
end
CoD.CallingCards_Asset_steampunkwarriors_shoulder.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
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
																f16_arg0:beginAnimation(299)
																f16_arg0:setAlpha(0.8)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
															end
															f15_arg0:beginAnimation(110)
															f15_arg0:setAlpha(1)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(470)
														f14_arg0:setAlpha(0.5)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(239)
													f13_arg0:setAlpha(1)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(80)
												f12_arg0:setAlpha(0.8)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(299)
											f11_arg0:setAlpha(1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(179)
										f10_arg0:setAlpha(0.5)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(200)
									f9_arg0:setAlpha(0.8)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(90)
								f8_arg0:setAlpha(1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(309)
							f7_arg0:setAlpha(0.5)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(240)
						f6_arg0:setAlpha(1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(79)
					f5_arg0:setAlpha(0.8)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.light:beginAnimation(400)
				f3_arg0.light:setAlpha(1)
				f3_arg0.light:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.light:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.light:completeAnimation()
			f3_arg0.light:setAlpha(0.5)
			f3_local0(f3_arg0.light)
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
															f28_arg0:beginAnimation(359)
															f28_arg0:setAlpha(0.3)
															f28_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
														end
														f27_arg0:beginAnimation(120)
														f27_arg0:setAlpha(0.8)
														f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
													end
													f26_arg0:beginAnimation(260)
													f26_arg0:setAlpha(0.5)
													f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
												end
												f25_arg0:beginAnimation(520)
												f25_arg0:setAlpha(0.3)
												f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
											end
											f24_arg0:beginAnimation(110)
											f24_arg0:setAlpha(0.8)
											f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
										end
										f23_arg0:beginAnimation(320)
										f23_arg0:setAlpha(0.3)
										f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
									end
									f22_arg0:beginAnimation(119)
									f22_arg0:setAlpha(0.8)
									f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
								end
								f21_arg0:beginAnimation(390)
								f21_arg0:setAlpha(0.5)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
							end
							f20_arg0:beginAnimation(250)
							f20_arg0:setAlpha(0.3)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(230)
						f19_arg0:setAlpha(0.8)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(119)
					f18_arg0:setAlpha(0.5)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f3_arg0.light2:beginAnimation(200)
				f3_arg0.light2:setAlpha(0.9)
				f3_arg0.light2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.light2:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f3_arg0.light2:completeAnimation()
			f3_arg0.light2:setAlpha(0.3)
			f3_local1(f3_arg0.light2)
		end,
	},
}
