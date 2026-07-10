CoD.VehicleGround_HashIcon = InheritFrom(LUI.UIElement)
CoD.VehicleGround_HashIcon.__defaultWidth = 48
CoD.VehicleGround_HashIcon.__defaultHeight = 24
CoD.VehicleGround_HashIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_HashIcon)
	self.id = "VehicleGround_HashIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HashIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	HashIcon:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_hashringsmallicon"))
	HashIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(HashIcon)
	self.HashIcon = HashIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_HashIcon.__resetProperties = function(f2_arg0)
	f2_arg0.HashIcon:completeAnimation()
	f2_arg0.HashIcon:setRGB(1, 1, 1)
end
CoD.VehicleGround_HashIcon.__clipsPerState = {
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
																		f18_arg0:beginAnimation(540)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																	end
																	f17_arg0:beginAnimation(9)
																	f17_arg0:setRGB(1, 1, 1)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(60)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(9)
															f15_arg0:setRGB(0, 0, 0)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(49)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(9)
													f13_arg0:setRGB(1, 0, 0)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(50)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(9)
											f11_arg0:setRGB(0, 0, 0)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(49)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(9)
									f9_arg0:setRGB(1, 1, 1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(520)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(9)
							f7_arg0:setRGB(1, 0, 0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(60)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(9)
					f5_arg0:setRGB(0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.HashIcon:beginAnimation(1000)
				f3_arg0.HashIcon:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.HashIcon:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.HashIcon:completeAnimation()
			f3_arg0.HashIcon:setRGB(1, 1, 1)
			f3_local0(f3_arg0.HashIcon)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
