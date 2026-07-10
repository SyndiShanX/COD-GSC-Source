CoD.ScytheReticle = InheritFrom(LUI.UIElement)
CoD.ScytheReticle.__defaultWidth = 100
CoD.ScytheReticle.__defaultHeight = 100
CoD.ScytheReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.HUDUtility.SetUpReticle(self, f1_arg1)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ScytheReticle)
	self.id = "ScytheReticle"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CenterChevronRight = LUI.UIImage.new(0.5, 0.5, -42.5, 57.5, 0.5, 0.5, -50, 50)
	CenterChevronRight:setImage(RegisterImage(0x35FFF2503E1CA12))
	self:addElement(CenterChevronRight)
	self.CenterChevronRight = CenterChevronRight
	local CenterChevronLeft = LUI.UIImage.new(0.5, 0.5, -57.5, 42.5, 0.5, 0.5, -50, 50)
	CenterChevronLeft:setZRot(180)
	CenterChevronLeft:setImage(RegisterImage(0x35FFF2503E1CA12))
	self:addElement(CenterChevronLeft)
	self.CenterChevronLeft = CenterChevronLeft
	local HipReticle = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	HipReticle:setAlpha(0)
	HipReticle:setImage(RegisterImage(0x3624B2A192E1340))
	self:addElement(HipReticle)
	self.HipReticle = HipReticle
	local OuterCircle = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	OuterCircle:setImage(RegisterImage(0x152F217D0C21DEB))
	self:addElement(OuterCircle)
	self.OuterCircle = OuterCircle
	local SupportingElements = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -50, 50)
	SupportingElements:setAlpha(0.1)
	SupportingElements:setImage(RegisterImage(0x3203EADC3279210))
	self:addElement(SupportingElements)
	self.SupportingElements = SupportingElements
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0
				if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644]) then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					if not f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						if not f2_local0 then
							if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
								f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
								if not f2_local0 then
									f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6])
									if not f2_local0 then
										f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
										if not f2_local0 then
											f2_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
										end
									end
								end
							else
								f2_local0 = true
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
			stateName = "HiddenUsingOffhand",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "usingOffhand")
			end,
		},
		{
			stateName = "ADS",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "lookingDownSights")
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.usingOffhand, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "usingOffhand",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.lookingDownSights, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "lookingDownSights",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScytheReticle.__resetProperties = function(f15_arg0)
	f15_arg0.SupportingElements:completeAnimation()
	f15_arg0.OuterCircle:completeAnimation()
	f15_arg0.CenterChevronLeft:completeAnimation()
	f15_arg0.CenterChevronRight:completeAnimation()
	f15_arg0.HipReticle:completeAnimation()
	f15_arg0.SupportingElements:setLeftRight(0.5, 0.5, -50, 50)
	f15_arg0.SupportingElements:setTopBottom(0.5, 0.5, -50, 50)
	f15_arg0.SupportingElements:setAlpha(0.1)
	f15_arg0.OuterCircle:setLeftRight(0.5, 0.5, -50, 50)
	f15_arg0.OuterCircle:setTopBottom(0.5, 0.5, -50, 50)
	f15_arg0.OuterCircle:setAlpha(1)
	f15_arg0.CenterChevronLeft:setLeftRight(0.5, 0.5, -57.5, 42.5)
	f15_arg0.CenterChevronLeft:setAlpha(1)
	f15_arg0.CenterChevronRight:setLeftRight(0.5, 0.5, -42.5, 57.5)
	f15_arg0.CenterChevronRight:setAlpha(1)
	f15_arg0.HipReticle:setAlpha(0)
end
CoD.ScytheReticle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							local f20_local0 = function(f21_arg0)
								local f21_local0 = function(f22_arg0)
									f22_arg0:beginAnimation(50)
									f22_arg0:setAlpha(1)
									f22_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
								end
								f21_arg0:beginAnimation(49)
								f21_arg0:setAlpha(0)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
							end
							f20_arg0:beginAnimation(70)
							f20_arg0:setAlpha(1)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(79)
						f19_arg0:setAlpha(0)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(99)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f16_arg0.CenterChevronRight:beginAnimation(350)
				f16_arg0.CenterChevronRight:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.CenterChevronRight:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.CenterChevronRight:completeAnimation()
			f16_arg0.CenterChevronRight:setAlpha(0)
			f16_local0(f16_arg0.CenterChevronRight)
			local f16_local1 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						local f25_local0 = function(f26_arg0)
							local f26_local0 = function(f27_arg0)
								local f27_local0 = function(f28_arg0)
									f28_arg0:beginAnimation(50)
									f28_arg0:setAlpha(1)
									f28_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
								end
								f27_arg0:beginAnimation(49)
								f27_arg0:setAlpha(0)
								f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
							end
							f26_arg0:beginAnimation(70)
							f26_arg0:setAlpha(1)
							f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
						end
						f25_arg0:beginAnimation(79)
						f25_arg0:setAlpha(0)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
					end
					f24_arg0:beginAnimation(99)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f16_arg0.CenterChevronLeft:beginAnimation(350)
				f16_arg0.CenterChevronLeft:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.CenterChevronLeft:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f16_arg0.CenterChevronLeft:completeAnimation()
			f16_arg0.CenterChevronLeft:setAlpha(0)
			f16_local1(f16_arg0.CenterChevronLeft)
			local f16_local2 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(110)
					f30_arg0:setLeftRight(0.5, 0.5, -50, 50)
					f30_arg0:setTopBottom(0.5, 0.5, -50, 50)
					f30_arg0:setAlpha(1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.OuterCircle:beginAnimation(240)
				f16_arg0.OuterCircle:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.OuterCircle:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f16_arg0.OuterCircle:completeAnimation()
			f16_arg0.OuterCircle:setLeftRight(0.5, 0.5, -100, 100)
			f16_arg0.OuterCircle:setTopBottom(0.5, 0.5, -100, 100)
			f16_arg0.OuterCircle:setAlpha(0)
			f16_local2(f16_arg0.OuterCircle)
			local f16_local3 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						local f33_local0 = function(f34_arg0)
							f34_arg0:beginAnimation(60)
							f34_arg0:setAlpha(0.08)
							f34_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
						end
						f33_arg0:beginAnimation(99)
						f33_arg0:setLeftRight(0.5, 0.5, -50, 50)
						f33_arg0:setTopBottom(0.5, 0.5, -50, 50)
						f33_arg0:setAlpha(0.15)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
					end
					f32_arg0:beginAnimation(270)
					f32_arg0:setAlpha(0.08)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f16_arg0.SupportingElements:beginAnimation(330)
				f16_arg0.SupportingElements:setAlpha(0.03)
				f16_arg0.SupportingElements:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SupportingElements:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f16_arg0.SupportingElements:completeAnimation()
			f16_arg0.SupportingElements:setLeftRight(0.5, 0.5, -37.5, 37.5)
			f16_arg0.SupportingElements:setTopBottom(0.5, 0.5, -37.5, 37.5)
			f16_arg0.SupportingElements:setAlpha(0)
			f16_local3(f16_arg0.SupportingElements)
		end,
	},
	Hidden = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.HipReticle:completeAnimation()
			f35_arg0.HipReticle:setAlpha(0)
			f35_arg0.clipFinished(f35_arg0.HipReticle)
		end,
	},
	HiddenUsingOffhand = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.HipReticle:completeAnimation()
			f36_arg0.HipReticle:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.HipReticle)
		end,
	},
	ADS = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			local f37_local0 = function(f38_arg0)
				f37_arg0.CenterChevronRight:beginAnimation(210)
				f37_arg0.CenterChevronRight:setLeftRight(0.5, 0.5, -44, 56)
				f37_arg0.CenterChevronRight:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.CenterChevronRight:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.CenterChevronRight:completeAnimation()
			f37_arg0.CenterChevronRight:setLeftRight(0.5, 0.5, -42.5, 57.5)
			f37_local0(f37_arg0.CenterChevronRight)
			local f37_local1 = function(f39_arg0)
				f37_arg0.CenterChevronLeft:beginAnimation(210)
				f37_arg0.CenterChevronLeft:setLeftRight(0.5, 0.5, -56, 44)
				f37_arg0.CenterChevronLeft:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.CenterChevronLeft:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.CenterChevronLeft:completeAnimation()
			f37_arg0.CenterChevronLeft:setLeftRight(0.5, 0.5, -57.5, 42.5)
			f37_local1(f37_arg0.CenterChevronLeft)
			local f37_local2 = function(f40_arg0)
				f37_arg0.OuterCircle:beginAnimation(210)
				f37_arg0.OuterCircle:setLeftRight(0.5, 0.5, -37.5, 37.5)
				f37_arg0.OuterCircle:setTopBottom(0.5, 0.5, -37.5, 37.5)
				f37_arg0.OuterCircle:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.OuterCircle:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.OuterCircle:completeAnimation()
			f37_arg0.OuterCircle:setLeftRight(0.5, 0.5, -50, 50)
			f37_arg0.OuterCircle:setTopBottom(0.5, 0.5, -50, 50)
			f37_local2(f37_arg0.OuterCircle)
			local f37_local3 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(110)
					f42_arg0:setAlpha(0)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
				end
				f37_arg0.SupportingElements:beginAnimation(210)
				f37_arg0.SupportingElements:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.SupportingElements:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f37_arg0.SupportingElements:completeAnimation()
			f37_arg0.SupportingElements:setAlpha(0.08)
			f37_local3(f37_arg0.SupportingElements)
		end,
	},
}
