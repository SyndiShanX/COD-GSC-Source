require("x64:d7e092479c7b82c")
require("x64:2158ca38a1e604b")
require("x64:80816b11e0416bd")
CoD.uplinkBallReticle = InheritFrom(LUI.UIElement)
CoD.uplinkBallReticle.__defaultWidth = 1920
CoD.uplinkBallReticle.__defaultHeight = 1080
CoD.uplinkBallReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.HUDUtility.SetUpReticle(self, f1_arg1)
	CoD.HUDUtility.UplinkBallReticlePreLoad(f1_arg1)
	self:setClass(CoD.uplinkBallReticle)
	self.id = "uplinkBallReticle"
	self.soundSet = "CAC_PrimaryWeapon"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackFrame = LUI.UIImage.new(0.5, 0.5, -205, 219, 0.5, 0.5, 262, 288)
	BlackFrame:setRGB(0, 0, 0)
	BlackFrame:setAlpha(0.3)
	self:addElement(BlackFrame)
	self.BlackFrame = BlackFrame
	local BallArmorWidget = CoD.uplink_IconandTextArmorbg.new(f1_arg0, f1_arg1, 0.5, 0.5, -24, 38, 0.5, 0.5, 288, 318)
	self:addElement(BallArmorWidget)
	self.BallArmorWidget = BallArmorWidget
	local armorBorder = CoD.Border.new(f1_arg0, f1_arg1, 0.5, 0.5, -136, 135, 0.5, 0.5, 273, 278)
	armorBorder:setAlpha(0.4)
	self:addElement(armorBorder)
	self.armorBorder = armorBorder
	local armorFill = LUI.UIImage.new(0.5, 0.5, -135, 133, 0.5, 0.5, 274, 276)
	armorFill:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	armorFill:setShaderVector(1, 0, 0, 0, 0)
	armorFill:setShaderVector(2, 1, 0, 0, 0)
	armorFill:setShaderVector(3, 0, 0, 0, 0)
	armorFill:setShaderVector(4, 0, 0, 0, 0)
	armorFill:subscribeToGlobalModel(f1_arg1, "HUDItems", "armorPercent", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			armorFill:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(armorFill)
	self.armorFill = armorFill
	local passIcon = LUI.UIImage.new(0.5, 0.5, -305, -254, 0.5, 0.5, 252, 303)
	passIcon:subscribeToGlobalModel(f1_arg1, "ReticleBindings", "speed_throw", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			passIcon:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(passIcon)
	self.passIcon = passIcon
	local throwIcon = LUI.UIImage.new(0.5, 0.5, 253, 304, 0.5, 0.5, 252, 303)
	throwIcon:subscribeToGlobalModel(f1_arg1, "ReticleBindings", "attack", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			throwIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(throwIcon)
	self.throwIcon = throwIcon
	local uplinkReticle = CoD.uplinkReticle.new(f1_arg0, f1_arg1, 0.5, 0.5, -98, 98, 0.5, 0.5, -98, 98)
	self:addElement(uplinkReticle)
	self.uplinkReticle = uplinkReticle
	local Trow = LUI.UIText.new(0, 0, 1107, 1212, 0, 0, 800, 830)
	Trow:setText(Engine[0xF9F1239CFD921FE](0xB416BCD1752EC4D))
	Trow:setTTF("default")
	Trow:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Trow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Trow)
	self.Trow = Trow
	local Pass = LUI.UIText.new(0, 0, 711, 815, 0, 0, 799, 829)
	Pass:setText(Engine[0xF9F1239CFD921FE](0xE42DC5C81202D0E))
	Pass:setTTF("default")
	Pass:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Pass:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Pass)
	self.Pass = Pass
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f5_local0
				if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644]) then
					f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					if not f5_local0 then
						f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						if not f5_local0 then
							if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
								f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
								if not f5_local0 then
									f5_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
								end
							else
								f5_local0 = true
							end
						end
					end
				else
					f5_local0 = true
				end
				return f5_local0
			end,
		},
		{
			stateName = "HiddenOffhand",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "usingOffhand")
			end,
		},
		{
			stateName = "KeyMouse",
			condition = function(menu, element, event)
				local f7_local0
				if not IsGamepad(f1_arg1) then
					f7_local0 = IsPC()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBFB2BDEC98D0644],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local11(f1_local10, f1_local12.usingOffhand, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "usingOffhand",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f15_arg1)
	end)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.uplinkBallReticle.__resetProperties = function(f17_arg0)
	f17_arg0.passIcon:completeAnimation()
	f17_arg0.throwIcon:completeAnimation()
	f17_arg0.Trow:completeAnimation()
	f17_arg0.Pass:completeAnimation()
	f17_arg0.BlackFrame:completeAnimation()
	f17_arg0.uplinkReticle:completeAnimation()
	f17_arg0.armorBorder:completeAnimation()
	f17_arg0.armorFill:completeAnimation()
	f17_arg0.BallArmorWidget:completeAnimation()
	f17_arg0.passIcon:setLeftRight(0.5, 0.5, -305, -254)
	f17_arg0.passIcon:setTopBottom(0.5, 0.5, 252, 303)
	f17_arg0.passIcon:setAlpha(1)
	f17_arg0.throwIcon:setLeftRight(0.5, 0.5, 253, 304)
	f17_arg0.throwIcon:setTopBottom(0.5, 0.5, 252, 303)
	f17_arg0.throwIcon:setAlpha(1)
	f17_arg0.Trow:setLeftRight(0, 0, 1107, 1212)
	f17_arg0.Trow:setTopBottom(0, 0, 800, 830)
	f17_arg0.Trow:setAlpha(1)
	f17_arg0.Pass:setLeftRight(0, 0, 711, 815)
	f17_arg0.Pass:setTopBottom(0, 0, 799, 829)
	f17_arg0.Pass:setAlpha(1)
	f17_arg0.BlackFrame:setLeftRight(0.5, 0.5, -205, 219)
	f17_arg0.BlackFrame:setTopBottom(0.5, 0.5, 262, 288)
	f17_arg0.BlackFrame:setAlpha(0.3)
	f17_arg0.uplinkReticle:setAlpha(1)
	f17_arg0.armorBorder:setAlpha(0.4)
	f17_arg0.armorFill:setAlpha(1)
	f17_arg0.BallArmorWidget:setAlpha(1)
end
CoD.uplinkBallReticle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(5)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(399)
					f20_arg0:setLeftRight(0.5, 0.5, -171.5, 171.5)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.BlackFrame:beginAnimation(1100)
				f18_arg0.BlackFrame:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.BlackFrame:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.BlackFrame:completeAnimation()
			f18_arg0.BlackFrame:setLeftRight(0.5, 0.5, -243.5, 247.5)
			f18_arg0.BlackFrame:setTopBottom(0.5, 0.5, 262.5, 287.5)
			f18_arg0.BlackFrame:setAlpha(0.3)
			f18_local0(f18_arg0.BlackFrame)
			local f18_local1 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(399)
					f22_arg0:setAlpha(0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.passIcon:beginAnimation(1100)
				f18_arg0.passIcon:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.passIcon:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f18_arg0.passIcon:completeAnimation()
			f18_arg0.passIcon:setLeftRight(0.5, 0.5, -288, -237)
			f18_arg0.passIcon:setTopBottom(0.5, 0.5, 252, 303)
			f18_arg0.passIcon:setAlpha(1)
			f18_local1(f18_arg0.passIcon)
			local f18_local2 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(399)
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.throwIcon:beginAnimation(1100)
				f18_arg0.throwIcon:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.throwIcon:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f18_arg0.throwIcon:completeAnimation()
			f18_arg0.throwIcon:setLeftRight(0.5, 0.5, 241, 292)
			f18_arg0.throwIcon:setTopBottom(0.5, 0.5, 252, 303)
			f18_arg0.throwIcon:setAlpha(1)
			f18_local2(f18_arg0.throwIcon)
			local f18_local3 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(179)
					f26_arg0:setAlpha(0)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.Trow:beginAnimation(1100)
				f18_arg0.Trow:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Trow:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f18_arg0.Trow:completeAnimation()
			f18_arg0.Trow:setLeftRight(0, 0, 1090, 1195)
			f18_arg0.Trow:setTopBottom(0, 0, 800, 830)
			f18_arg0.Trow:setAlpha(1)
			f18_local3(f18_arg0.Trow)
			local f18_local4 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(179)
					f28_arg0:setAlpha(0)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.Pass:beginAnimation(1100)
				f18_arg0.Pass:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Pass:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f18_arg0.Pass:completeAnimation()
			f18_arg0.Pass:setLeftRight(0, 0, 729, 833)
			f18_arg0.Pass:setTopBottom(0, 0, 799, 829)
			f18_arg0.Pass:setAlpha(1)
			f18_local4(f18_arg0.Pass)
		end,
	},
	Hidden = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(9)
			f29_arg0.BlackFrame:completeAnimation()
			f29_arg0.BlackFrame:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.BlackFrame)
			f29_arg0.BallArmorWidget:completeAnimation()
			f29_arg0.BallArmorWidget:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.BallArmorWidget)
			f29_arg0.armorBorder:completeAnimation()
			f29_arg0.armorBorder:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.armorBorder)
			f29_arg0.armorFill:completeAnimation()
			f29_arg0.armorFill:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.armorFill)
			f29_arg0.passIcon:completeAnimation()
			f29_arg0.passIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.passIcon)
			f29_arg0.throwIcon:completeAnimation()
			f29_arg0.throwIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.throwIcon)
			f29_arg0.uplinkReticle:completeAnimation()
			f29_arg0.uplinkReticle:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.uplinkReticle)
			f29_arg0.Trow:completeAnimation()
			f29_arg0.Trow:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.Trow)
			f29_arg0.Pass:completeAnimation()
			f29_arg0.Pass:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.Pass)
		end,
	},
	HiddenOffhand = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(8)
			f30_arg0.BlackFrame:completeAnimation()
			f30_arg0.BlackFrame:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.BlackFrame)
			f30_arg0.armorBorder:completeAnimation()
			f30_arg0.armorBorder:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.armorBorder)
			f30_arg0.armorFill:completeAnimation()
			f30_arg0.armorFill:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.armorFill)
			f30_arg0.passIcon:completeAnimation()
			f30_arg0.passIcon:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.passIcon)
			f30_arg0.throwIcon:completeAnimation()
			f30_arg0.throwIcon:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.throwIcon)
			f30_arg0.uplinkReticle:completeAnimation()
			f30_arg0.uplinkReticle:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.uplinkReticle)
			f30_arg0.Trow:completeAnimation()
			f30_arg0.Trow:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Trow)
			f30_arg0.Pass:completeAnimation()
			f30_arg0.Pass:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Pass)
		end,
	},
	KeyMouse = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(5)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(399)
					f33_arg0:setLeftRight(0.5, 0.5, -180, 180)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.BlackFrame:beginAnimation(1600)
				f31_arg0.BlackFrame:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.BlackFrame:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.BlackFrame:completeAnimation()
			f31_arg0.BlackFrame:setLeftRight(0.5, 0.5, -270, 270)
			f31_arg0.BlackFrame:setTopBottom(0.5, 0.5, 262.5, 287.5)
			f31_local0(f31_arg0.BlackFrame)
			f31_arg0.passIcon:completeAnimation()
			f31_arg0.passIcon:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.passIcon)
			f31_arg0.throwIcon:completeAnimation()
			f31_arg0.throwIcon:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.throwIcon)
			f31_arg0.Trow:completeAnimation()
			f31_arg0.Trow:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Trow)
			f31_arg0.Pass:completeAnimation()
			f31_arg0.Pass:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Pass)
		end,
	},
}
CoD.uplinkBallReticle.__onClose = function(f34_arg0)
	f34_arg0.BallArmorWidget:close()
	f34_arg0.armorBorder:close()
	f34_arg0.armorFill:close()
	f34_arg0.passIcon:close()
	f34_arg0.throwIcon:close()
	f34_arg0.uplinkReticle:close()
end
