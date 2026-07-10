require("x64:b4fe1de41f35ac5")
CoD.ThrustMeterContainer = InheritFrom(LUI.UIElement)
CoD.ThrustMeterContainer.__defaultWidth = 255
CoD.ThrustMeterContainer.__defaultHeight = 60
CoD.ThrustMeterContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ThrustMeterContainer)
	self.id = "ThrustMeterContainer"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ThrustMeter0 = CoD.ThrustMeter.new(f1_arg0, f1_arg1, 0.5, 0.5, -127.5, 127.5, 0.5, 0.5, -30, 30)
	self:addElement(ThrustMeter0)
	self.ThrustMeter0 = ThrustMeter0
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0
				if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]) then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
					if not f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						if not f2_local0 then
							f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
							if not f2_local0 then
								f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
								if not f2_local0 then
									f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
									if not f2_local0 then
										f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
										if not f2_local0 then
											f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
											if not f2_local0 then
												f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
												if not f2_local0 then
													f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
													if not f2_local0 then
														f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
														if not f2_local0 then
															f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
															if not f2_local0 then
																f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
																if not f2_local0 then
																	f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				else
					f2_local0 = true
				end
				return f2_local0
			end,
		},
		{
			stateName = "FullEnergy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "playerAbilities.playerEnergyRatio", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["playerAbilities.playerEnergyRatio"], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "playerAbilities.playerEnergyRatio",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ThrustMeterContainer.__resetProperties = function(f20_arg0)
	f20_arg0.ThrustMeter0:completeAnimation()
	f20_arg0.ThrustMeter0:setAlpha(1)
end
CoD.ThrustMeterContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		Hidden = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						local f25_local0 = function(f26_arg0)
							local f26_local0 = function(f27_arg0)
								local f27_local0 = function(f28_arg0)
									local f28_local0 = function(f29_arg0)
										f29_arg0:beginAnimation(90)
										f29_arg0:setAlpha(0)
										f29_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
									end
									f28_arg0:beginAnimation(29)
									f28_arg0:setAlpha(0.5)
									f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
								end
								f27_arg0:beginAnimation(20)
								f27_arg0:setAlpha(0.54)
								f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
							end
							f26_arg0:beginAnimation(59)
							f26_arg0:setAlpha(0.63)
							f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
						end
						f25_arg0:beginAnimation(20)
						f25_arg0:setAlpha(0.77)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
					end
					f24_arg0:beginAnimation(20)
					f24_arg0:setAlpha(0.59)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f22_arg0.ThrustMeter0:beginAnimation(60)
				f22_arg0.ThrustMeter0:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ThrustMeter0:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.ThrustMeter0:completeAnimation()
			f22_arg0.ThrustMeter0:setAlpha(1)
			f22_local0(f22_arg0.ThrustMeter0)
		end,
		FullEnergy = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						local f33_local0 = function(f34_arg0)
							local f34_local0 = function(f35_arg0)
								local f35_local0 = function(f36_arg0)
									local f36_local0 = function(f37_arg0)
										local f37_local0 = function(f38_arg0)
											f38_arg0:beginAnimation(89)
											f38_arg0:setAlpha(0)
											f38_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
										end
										f37_arg0:beginAnimation(30)
										f37_arg0:setAlpha(0.5)
										f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
									end
									f36_arg0:beginAnimation(19)
									f36_arg0:setAlpha(0.54)
									f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
								end
								f35_arg0:beginAnimation(60)
								f35_arg0:setAlpha(0.63)
								f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
							end
							f34_arg0:beginAnimation(20)
							f34_arg0:setAlpha(0.77)
							f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
						end
						f33_arg0:beginAnimation(19)
						f33_arg0:setAlpha(0.59)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
					end
					f32_arg0:beginAnimation(60)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f30_arg0.ThrustMeter0:beginAnimation(700)
				f30_arg0.ThrustMeter0:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.ThrustMeter0:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.ThrustMeter0:completeAnimation()
			f30_arg0.ThrustMeter0:setAlpha(1)
			f30_local0(f30_arg0.ThrustMeter0)
		end,
	},
	Hidden = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(1)
			f39_arg0.ThrustMeter0:completeAnimation()
			f39_arg0.ThrustMeter0:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.ThrustMeter0)
		end,
		DefaultState = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(1)
			local f40_local0 = function(f41_arg0)
				f40_arg0.ThrustMeter0:beginAnimation(80, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735])
				f40_arg0.ThrustMeter0:setAlpha(1)
				f40_arg0.ThrustMeter0:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.ThrustMeter0:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.ThrustMeter0:completeAnimation()
			f40_arg0.ThrustMeter0:setAlpha(0)
			f40_local0(f40_arg0.ThrustMeter0)
		end,
	},
	FullEnergy = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(1)
			f42_arg0.ThrustMeter0:completeAnimation()
			f42_arg0.ThrustMeter0:setAlpha(0)
			f42_arg0.clipFinished(f42_arg0.ThrustMeter0)
		end,
	},
}
CoD.ThrustMeterContainer.__onClose = function(f43_arg0)
	f43_arg0.ThrustMeter0:close()
end
