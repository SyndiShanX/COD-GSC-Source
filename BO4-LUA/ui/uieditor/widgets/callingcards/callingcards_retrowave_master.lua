CoD.callingcards_retrowave_master = InheritFrom(LUI.UIElement)
CoD.callingcards_retrowave_master.__defaultWidth = 920
CoD.callingcards_retrowave_master.__defaultHeight = 240
CoD.callingcards_retrowave_master.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_retrowave_master)
	self.id = "CallingCards_Retrowave_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackgroundFlipbook = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BackgroundFlipbook:setImage(RegisterImage("uie_carbackgroud_flipbook"))
	BackgroundFlipbook:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	BackgroundFlipbook:setShaderVector(0, 0, 4, 0, 0)
	BackgroundFlipbook:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(BackgroundFlipbook)
	self.BackgroundFlipbook = BackgroundFlipbook
	local streetlights = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	streetlights:setImage(RegisterImage("uie_streetlights_flipbook"))
	streetlights:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_add"))
	streetlights:setShaderVector(0, 0, 4, 0, 0)
	streetlights:setShaderVector(1, 24, 0, 0, 0)
	self:addElement(streetlights)
	self.streetlights = streetlights
	local carSmoke = LUI.UIImage.new(0, 0, 766, 920, 0, 0, 42, 196)
	carSmoke:setImage(RegisterImage("uie_car_smoke"))
	carSmoke:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook_add"))
	carSmoke:setShaderVector(0, 0, 4, 0, 0)
	carSmoke:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(carSmoke)
	self.carSmoke = carSmoke
	local car = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	car:setImage(RegisterImage("uie_car"))
	self:addElement(car)
	self.car = car
	local headlights = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	headlights:setImage(RegisterImage("uie_headlights_car"))
	headlights:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(headlights)
	self.headlights = headlights
	local gunfireFlash = LUI.UIImage.new(0, 0, 456, 736, 0, 0, -12, 128)
	gunfireFlash:setImage(RegisterImage("uie_gunfire_highlight"))
	gunfireFlash:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(gunfireFlash)
	self.gunfireFlash = gunfireFlash
	local hubcaps = LUI.UIImage.new(0, 0, 697, 851, 0, 0, 119, 232)
	hubcaps:setScale(0.75, 0.75)
	hubcaps:setImage(RegisterImage("uie_hubcaps"))
	hubcaps:setMaterial(LUI.UIImage.GetCachedMaterial("uie_flipbook"))
	hubcaps:setShaderVector(0, 0, 2, 0, 0)
	hubcaps:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(hubcaps)
	self.hubcaps = hubcaps
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_retrowave_master.__resetProperties = function(f2_arg0)
	f2_arg0.headlights:completeAnimation()
	f2_arg0.BackgroundFlipbook:completeAnimation()
	f2_arg0.hubcaps:completeAnimation()
	f2_arg0.gunfireFlash:completeAnimation()
	f2_arg0.headlights:setAlpha(1)
	f2_arg0.BackgroundFlipbook:setLeftRight(0, 0, 0, 960)
	f2_arg0.BackgroundFlipbook:setTopBottom(0, 0, 0, 240)
	f2_arg0.BackgroundFlipbook:setScale(1, 1)
	f2_arg0.hubcaps:setShaderVector(0, 0, 2, 0, 0)
	f2_arg0.hubcaps:setShaderVector(1, 0, 0, 0, 0)
	f2_arg0.gunfireFlash:setAlpha(1)
end
CoD.callingcards_retrowave_master.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(130)
						f6_arg0:setTopBottom(0, 0, 0, 180)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(199)
					f5_arg0:setTopBottom(0, 0, 0, 240)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.BackgroundFlipbook:beginAnimation(360)
				f3_arg0.BackgroundFlipbook:setTopBottom(0, 0, -5, 175)
				f3_arg0.BackgroundFlipbook:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BackgroundFlipbook:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.BackgroundFlipbook:completeAnimation()
			f3_arg0.BackgroundFlipbook:setLeftRight(0, 0, 0, 920)
			f3_arg0.BackgroundFlipbook:setTopBottom(0, 0, 0, 180)
			f3_arg0.BackgroundFlipbook:setScale(1.05, 1.05)
			f3_local0(f3_arg0.BackgroundFlipbook)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(329)
					f8_arg0:setAlpha(0.5)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.headlights:beginAnimation(360)
				f3_arg0.headlights:setAlpha(1)
				f3_arg0.headlights:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.headlights:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.headlights:completeAnimation()
			f3_arg0.headlights:setAlpha(0.5)
			f3_local1(f3_arg0.headlights)
			local f3_local2 = function(f9_arg0)
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
																			local f24_local0 = function(f25_arg0)
																				local f25_local0 = function(f26_arg0)
																					local f26_local0 = function(f27_arg0)
																						f27_arg0:beginAnimation(19)
																						f27_arg0:setAlpha(0)
																						f27_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																					end
																					f26_arg0:beginAnimation(30)
																					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
																				end
																				f25_arg0:beginAnimation(19)
																				f25_arg0:setAlpha(1)
																				f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
																			end
																			f24_arg0:beginAnimation(40)
																			f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
																		end
																		f23_arg0:beginAnimation(19)
																		f23_arg0:setAlpha(0)
																		f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
																	end
																	f22_arg0:beginAnimation(30)
																	f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
																end
																f21_arg0:beginAnimation(19)
																f21_arg0:setAlpha(1)
																f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
															end
															f20_arg0:beginAnimation(49)
															f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
														end
														f19_arg0:beginAnimation(20)
														f19_arg0:setAlpha(0)
														f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
													end
													f18_arg0:beginAnimation(30)
													f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
												end
												f17_arg0:beginAnimation(20)
												f17_arg0:setAlpha(1)
												f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
											end
											f16_arg0:beginAnimation(59)
											f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
										end
										f15_arg0:beginAnimation(20)
										f15_arg0:setAlpha(0)
										f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
									end
									f14_arg0:beginAnimation(30)
									f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
								end
								f13_arg0:beginAnimation(20)
								f13_arg0:setAlpha(1)
								f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
							end
							f12_arg0:beginAnimation(79)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
						end
						f11_arg0:beginAnimation(20)
						f11_arg0:setAlpha(0)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(30)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f9_arg0:beginAnimation(19)
				f9_arg0:setAlpha(1)
				f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.gunfireFlash:beginAnimation(110)
			f3_arg0.gunfireFlash:setAlpha(0)
			f3_arg0.gunfireFlash:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.gunfireFlash:registerEventHandler("transition_complete_keyframe", f3_local2)
			f3_arg0.hubcaps:completeAnimation()
			f3_arg0.hubcaps:setShaderVector(0, 0, 2, 0, 0)
			f3_arg0.hubcaps:setShaderVector(1, 15, 0, 0, 0)
			f3_arg0.clipFinished(f3_arg0.hubcaps)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
