require("x64:f802502abb9fd2c")
CoD.VehicleGround_IrisOutterThinInternal = InheritFrom(LUI.UIElement)
CoD.VehicleGround_IrisOutterThinInternal.__defaultWidth = 2131
CoD.VehicleGround_IrisOutterThinInternal.__defaultHeight = 1414
CoD.VehicleGround_IrisOutterThinInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_IrisOutterThinInternal)
	self.id = "VehicleGround_IrisOutterThinInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VehicleGroundIrisOutterThin0 = CoD.VehicleGround_IrisOutterThin.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(VehicleGroundIrisOutterThin0)
	self.VehicleGroundIrisOutterThin0 = VehicleGroundIrisOutterThin0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_IrisOutterThinInternal.__resetProperties = function(f2_arg0)
	f2_arg0.VehicleGroundIrisOutterThin0:completeAnimation()
	f2_arg0.VehicleGroundIrisOutterThin0:setZRot(0)
	f2_arg0.VehicleGroundIrisOutterThin0:setZoom(0)
end
CoD.VehicleGround_IrisOutterThinInternal.__clipsPerState = {
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
																f16_arg0:beginAnimation(1579, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
																f16_arg0:setZRot(0)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
															end
															f15_arg0:beginAnimation(1840, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
															f15_arg0:setZRot(-1)
															f15_arg0:setZoom(0)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(439)
														f14_arg0:setZRot(-2)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(3360, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
													f13_arg0:setZRot(-2)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(520)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(879, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
											f11_arg0:setZoom(-20)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(2740)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(3859, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
									f9_arg0:setZRot(3)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(1500)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(1220, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f7_arg0:setZoom(-40)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(559)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(3020, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setZRot(-4)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.VehicleGroundIrisOutterThin0:beginAnimation(2620)
				f3_arg0.VehicleGroundIrisOutterThin0:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.VehicleGroundIrisOutterThin0:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.VehicleGroundIrisOutterThin0:completeAnimation()
			f3_arg0.VehicleGroundIrisOutterThin0:setZRot(0)
			f3_arg0.VehicleGroundIrisOutterThin0:setZoom(0)
			f3_local0(f3_arg0.VehicleGroundIrisOutterThin0)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.VehicleGround_IrisOutterThinInternal.__onClose = function(f17_arg0)
	f17_arg0.VehicleGroundIrisOutterThin0:close()
end
