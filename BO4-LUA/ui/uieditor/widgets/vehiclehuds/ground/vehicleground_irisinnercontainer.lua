require("x64:1bb85314c024c24")
CoD.VehicleGround_IrisInnerContainer = InheritFrom(LUI.UIElement)
CoD.VehicleGround_IrisInnerContainer.__defaultWidth = 1920
CoD.VehicleGround_IrisInnerContainer.__defaultHeight = 1080
CoD.VehicleGround_IrisInnerContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VehicleGround_IrisInnerContainer)
	self.id = "VehicleGround_IrisInnerContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VehicleGroundIrisInner0 = CoD.VehicleGround_IrisInner.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	VehicleGroundIrisInner0:setRGB(1, 0.64, 0.35)
	VehicleGroundIrisInner0:setZRot(-18)
	VehicleGroundIrisInner0:setZoom(-190)
	self:addElement(VehicleGroundIrisInner0)
	self.VehicleGroundIrisInner0 = VehicleGroundIrisInner0
	self:mergeStateConditions({
		{
			stateName = "LeavingOperationalZone",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "outOfRange")
			end,
		},
	})
	self:linkToElementModel(self, "outOfRange", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "outOfRange",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VehicleGround_IrisInnerContainer.__resetProperties = function(f4_arg0)
	f4_arg0.VehicleGroundIrisInner0:completeAnimation()
	f4_arg0.VehicleGroundIrisInner0:setRGB(1, 0.64, 0.35)
	f4_arg0.VehicleGroundIrisInner0:setZRot(-18)
	f4_arg0.VehicleGroundIrisInner0:setZoom(-190)
end
CoD.VehicleGround_IrisInnerContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
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
																			f21_arg0:beginAnimation(2239, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
																			f21_arg0:setZRot(0)
																			f21_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
																		end
																		f20_arg0:beginAnimation(779)
																		f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
																	end
																	f19_arg0:beginAnimation(2010, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																	f19_arg0:setRGB(1, 1, 1)
																	f19_arg0:setZoom(-149)
																	f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																end
																f18_arg0:beginAnimation(540)
																f18_arg0:setZRot(-10)
																f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
															end
															f17_arg0:beginAnimation(2939, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
															f17_arg0:setZRot(-12)
															f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
														end
														f16_arg0:beginAnimation(2840)
														f16_arg0:setZRot(-10)
														f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
													end
													f15_arg0:beginAnimation(1920, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
													f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
												end
												f14_arg0:beginAnimation(760, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
												f14_arg0:setRGB(1, 0.64, 0.35)
												f14_arg0:setZRot(-15)
												f14_arg0:setZoom(-190)
												f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
											end
											f13_arg0:beginAnimation(489)
											f13_arg0:setZRot(-14)
											f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
										end
										f12_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
										f12_arg0:setRGB(1, 1, 1)
										f12_arg0:setZRot(-14)
										f12_arg0:setZoom(-150)
										f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
									end
									f11_arg0:beginAnimation(2370)
									f11_arg0:setZRot(-18)
									f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
								end
								f10_arg0:beginAnimation(970, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
								f10_arg0:setZRot(-20)
								f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
							end
							f9_arg0:beginAnimation(1069)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
						end
						f8_arg0:beginAnimation(600, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f8_arg0:setRGB(1, 0.64, 0.35)
						f8_arg0:setZoom(-190)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(1569, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f7_arg0:setZRot(-15)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.VehicleGroundIrisInner0:beginAnimation(1710)
				f5_arg0.VehicleGroundIrisInner0:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.VehicleGroundIrisInner0:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.VehicleGroundIrisInner0:completeAnimation()
			f5_arg0.VehicleGroundIrisInner0:setRGB(1, 1, 1)
			f5_arg0.VehicleGroundIrisInner0:setZRot(0)
			f5_arg0.VehicleGroundIrisInner0:setZoom(-149)
			f5_local0(f5_arg0.VehicleGroundIrisInner0)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	LeavingOperationalZone = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.VehicleGround_IrisInnerContainer.__onClose = function(f23_arg0)
	f23_arg0.VehicleGroundIrisInner0:close()
end
