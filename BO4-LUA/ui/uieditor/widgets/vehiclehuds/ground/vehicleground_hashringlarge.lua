require("x64:2c001532d54f545")
CoD.VehicleGround_HashRingLarge = InheritFrom(LUI.UIElement)
CoD.VehicleGround_HashRingLarge.__defaultWidth = 144
CoD.VehicleGround_HashRingLarge.__defaultHeight = 432
CoD.VehicleGround_HashRingLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_HashRingLarge)
	self.id = "VehicleGround_HashRingLarge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VehicleGroundHashRingLargeInternal0 = CoD.VehicleGround_HashRingLargeInternal.new(f1_arg0, f1_arg1, 0, 0, -568, 144, 0.5, 0.5, -216, 216)
	VehicleGroundHashRingLargeInternal0:setAlpha(0.85)
	self:addElement(VehicleGroundHashRingLargeInternal0)
	self.VehicleGroundHashRingLargeInternal0 = VehicleGroundHashRingLargeInternal0
	local Image5 = LUI.UIImage.new(0, 0, 48, 156, 0.5, 0.5, -56, 4)
	Image5:setRGB(0, 0, 0)
	Image5:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_hashringlargemaskmid"))
	self:addElement(Image5)
	self.Image5 = Image5
	local Image6 = LUI.UIImage.new(0, 0, 48, 156, 0.5, 0.5, -3, 57)
	Image6:setRGB(0, 0, 0)
	Image6:setXRot(-180)
	Image6:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_hashringlargemaskmid"))
	self:addElement(Image6)
	self.Image6 = Image6
	local Image7 = LUI.UIImage.new(0, 0, 0, 120, 0.5, 0.5, 117, 249)
	Image7:setRGB(0, 0, 0)
	Image7:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_hashringlargemaskbase"))
	self:addElement(Image7)
	self.Image7 = Image7
	local Image0 = LUI.UIImage.new(0, 0, 0, 120, 0.5, 0.5, -249, -117)
	Image0:setRGB(0, 0, 0)
	Image0:setXRot(-180)
	Image0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_hashringlargemaskbase"))
	self:addElement(Image0)
	self.Image0 = Image0
	local Image1 = LUI.UIImage.new(0, 0, -15, 180, 0.5, 0.5, -364, -172)
	Image1:setRGB(0, 0, 0)
	self:addElement(Image1)
	self.Image1 = Image1
	local Image10 = LUI.UIImage.new(0, 0, -8, 180, 0.5, 0.5, 183, 375)
	Image10:setRGB(0, 0, 0)
	self:addElement(Image10)
	self.Image10 = Image10
	local Image100 = LUI.UIImage.new(0, 0, -7, 14, 0.5, 0.5, 98, 290)
	Image100:setRGB(0, 0, 0)
	self:addElement(Image100)
	self.Image100 = Image100
	local Image1000 = LUI.UIImage.new(0, 0, -7, 14, 0.5, 0.5, -248, -56)
	Image1000:setRGB(0, 0, 0)
	self:addElement(Image1000)
	self.Image1000 = Image1000
	local Image2 = LUI.UIImage.new(0, 0, -23, 156, 0.5, 0.5, 81, 267)
	Image2:setAlpha(0.6)
	Image2:setZRot(86)
	Image2:setImage(RegisterImage(@"uie_t7_cp_hud_woundedsoldier_sidemask"))
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(0, 0, -23, 156, 0.5, 0.5, -282, -96)
	Image3:setAlpha(0.6)
	Image3:setXRot(-180)
	Image3:setZRot(86)
	Image3:setImage(RegisterImage(@"uie_t7_cp_hud_woundedsoldier_sidemask"))
	self:addElement(Image3)
	self.Image3 = Image3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_HashRingLarge.__resetProperties = function(f2_arg0)
	f2_arg0.VehicleGroundHashRingLargeInternal0:completeAnimation()
	f2_arg0.VehicleGroundHashRingLargeInternal0:setZRot(0)
end
CoD.VehicleGround_HashRingLarge.__clipsPerState = {
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
																			f19_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
																			f19_arg0:setZRot(0)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																		end
																		f18_arg0:beginAnimation(2000)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
																	f17_arg0:setZRot(4)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(1500)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
															f15_arg0:setZRot(9)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
														f14_arg0:setZRot(-10)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(2000, Enum[@"luitween"][@"luitween_ease_both"])
													f13_arg0:setZRot(-7)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(500)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(2000, Enum[@"luitween"][@"luitween_ease_both"])
											f11_arg0:setZRot(-10)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(1500)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
									f9_arg0:setZRot(6)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(2000)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
							f7_arg0:setZRot(-3)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setZRot(-10)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.VehicleGroundHashRingLargeInternal0:beginAnimation(1500)
				f3_arg0.VehicleGroundHashRingLargeInternal0:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.VehicleGroundHashRingLargeInternal0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.VehicleGroundHashRingLargeInternal0:completeAnimation()
			f3_arg0.VehicleGroundHashRingLargeInternal0:setZRot(0)
			f3_local0(f3_arg0.VehicleGroundHashRingLargeInternal0)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.VehicleGround_HashRingLarge.__onClose = function(f20_arg0)
	f20_arg0.VehicleGroundHashRingLargeInternal0:close()
end
