CoD.RiotShieldHealth = InheritFrom(LUI.UIElement)
CoD.RiotShieldHealth.__defaultWidth = 75
CoD.RiotShieldHealth.__defaultHeight = 90
CoD.RiotShieldHealth.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "ZMInventoryPersonal.shield_health", 0)
	self:setClass(CoD.RiotShieldHealth)
	self.id = "RiotShieldHealth"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bgbGlowOrangeOver = LUI.UIImage.new(0.5, 0.5, -120, 122, 0.5, 0.5, -197, 164)
	bgbGlowOrangeOver:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	bgbGlowOrangeOver:setAlpha(0)
	bgbGlowOrangeOver:setZRot(90)
	bgbGlowOrangeOver:setImage(RegisterImage(0x5BE416E17DAB33B))
	bgbGlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(bgbGlowOrangeOver)
	self.bgbGlowOrangeOver = bgbGlowOrangeOver
	local TutorialHighlight = LUI.UIImage.new(0, 0, -25, 100, 0, 0, -22, 112)
	TutorialHighlight:setRGB(0.87, 0.07, 0.78)
	TutorialHighlight:setAlpha(0)
	self:addElement(TutorialHighlight)
	self.TutorialHighlight = TutorialHighlight
	local ShieldIcon = LUI.UIImage.new(0, 0, -13.5, 88.5, 0, 0, -12, 90)
	ShieldIcon:setImage(RegisterImage(CoD.ZombieUtility.GetShieldIconForCurrentMap(0x43B28F6F4ED2E47)))
	self:addElement(ShieldIcon)
	self.ShieldIcon = ShieldIcon
	local bgbAbilitySwirl = LUI.UIImage.new(0.5, 0.5, -60.5, 60.5, 0, 0, -14.5, 104.5)
	bgbAbilitySwirl:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	bgbAbilitySwirl:setAlpha(0)
	bgbAbilitySwirl:setZRot(330)
	bgbAbilitySwirl:setScale(1.65, 1.65)
	bgbAbilitySwirl:setImage(RegisterImage(0xBBBD54E6E7B4493))
	bgbAbilitySwirl:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(bgbAbilitySwirl)
	self.bgbAbilitySwirl = bgbAbilitySwirl
	local MeterBG = LUI.UIImage.new(0.5, 0.5, -50, 50, 0, 0, 69, 93)
	MeterBG:setImage(RegisterImage(0x1F07F7F87DD52F3))
	self:addElement(MeterBG)
	self.MeterBG = MeterBG
	local HealthBar = LUI.UIImage.new(0.5, 0.5, -50, 50, 0, 0, 69, 93)
	HealthBar:setRGB(0.92, 0.92, 0.17)
	HealthBar:setImage(RegisterImage(0x1FD9F7F87E813AF))
	HealthBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	HealthBar:setShaderVector(1, 0, 0, 0, 0)
	HealthBar:setShaderVector(2, 1, 0, 0, 0)
	HealthBar:setShaderVector(3, 0, 0, 0, 0)
	HealthBar:setShaderVector(4, 0, 0, 0, 0)
	HealthBar:subscribeToGlobalModel(f1_arg1, "ZMInventoryPersonal", "shield_health", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HealthBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	self:mergeStateConditions({
		{
			stateName = "HiddenTutorial",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztutorial") and CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.ztut.showShield", 0)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "ZMInventoryPersonal.shield_health", 0)
				if f4_local0 then
					if
						not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
					then
						f4_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Visible2",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "ZMInventoryPersonal.shield_health", 0)
				if f5_local0 then
					f5_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
					if f5_local0 then
						if
							not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
							and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
						then
							f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
						else
							f5_local0 = false
						end
					end
				end
				return f5_local0
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["hudItems.ztut.showShield"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.ztut.showShield",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["ZMInventoryPersonal.shield_health"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "ZMInventoryPersonal.shield_health",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.RiotShieldHealth.__resetProperties = function(f25_arg0)
	f25_arg0.ShieldIcon:completeAnimation()
	f25_arg0.HealthBar:completeAnimation()
	f25_arg0.MeterBG:completeAnimation()
	f25_arg0.bgbAbilitySwirl:completeAnimation()
	f25_arg0.bgbGlowOrangeOver:completeAnimation()
	f25_arg0.ShieldIcon:setAlpha(1)
	f25_arg0.HealthBar:setAlpha(1)
	f25_arg0.MeterBG:setAlpha(1)
	f25_arg0.bgbAbilitySwirl:setTopBottom(0, 0, -14.5, 104.5)
	f25_arg0.bgbAbilitySwirl:setAlpha(0)
	f25_arg0.bgbAbilitySwirl:setZRot(330)
	f25_arg0.bgbGlowOrangeOver:setAlpha(0)
end
CoD.RiotShieldHealth.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.ShieldIcon:completeAnimation()
			f26_arg0.ShieldIcon:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ShieldIcon)
			f26_arg0.MeterBG:completeAnimation()
			f26_arg0.MeterBG:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.MeterBG)
			f26_arg0.HealthBar:completeAnimation()
			f26_arg0.HealthBar:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.HealthBar)
		end,
	},
	HiddenTutorial = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.ShieldIcon:completeAnimation()
			f27_arg0.ShieldIcon:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ShieldIcon)
			f27_arg0.MeterBG:completeAnimation()
			f27_arg0.MeterBG:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.MeterBG)
			f27_arg0.HealthBar:completeAnimation()
			f27_arg0.HealthBar:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.HealthBar)
		end,
		Visible = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(4)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						local f31_local0 = function(f32_arg0)
							local f32_local0 = function(f33_arg0)
								local f33_local0 = function(f34_arg0)
									local f34_local0 = function(f35_arg0)
										f35_arg0:beginAnimation(250)
										f35_arg0:setAlpha(0)
										f35_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
									end
									f34_arg0:beginAnimation(150)
									f34_arg0:setAlpha(0.7)
									f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
								end
								f33_arg0:beginAnimation(139)
								f33_arg0:setAlpha(0)
								f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
							end
							f32_arg0:beginAnimation(130)
							f32_arg0:setAlpha(0.7)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
						end
						f31_arg0:beginAnimation(130)
						f31_arg0:setAlpha(0)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(199)
					f30_arg0:setAlpha(0.7)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f28_arg0.bgbGlowOrangeOver:beginAnimation(330)
				f28_arg0.bgbGlowOrangeOver:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.bgbGlowOrangeOver:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.bgbGlowOrangeOver:completeAnimation()
			f28_arg0.bgbGlowOrangeOver:setAlpha(0)
			f28_local0(f28_arg0.bgbGlowOrangeOver)
			local f28_local1 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					local f37_local0 = function(f38_arg0)
						f38_arg0:beginAnimation(340)
						f38_arg0:setAlpha(1)
						f38_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f37_arg0:beginAnimation(329)
					f37_arg0:setAlpha(0)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
				end
				f36_arg0:beginAnimation(330)
				f36_arg0:setAlpha(1)
				f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f28_arg0.ShieldIcon:beginAnimation(330)
			f28_arg0.ShieldIcon:setAlpha(0)
			f28_arg0.ShieldIcon:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
			f28_arg0.ShieldIcon:registerEventHandler("transition_complete_keyframe", f28_local1)
			local f28_local2 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(199)
					f40_arg0:setAlpha(0)
					f40_arg0:setZRot(360)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.bgbAbilitySwirl:beginAnimation(330)
				f28_arg0.bgbAbilitySwirl:setAlpha(1)
				f28_arg0.bgbAbilitySwirl:setZRot(240)
				f28_arg0.bgbAbilitySwirl:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.bgbAbilitySwirl:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f28_arg0.bgbAbilitySwirl:completeAnimation()
			f28_arg0.bgbAbilitySwirl:setTopBottom(0, 0, -14.5, 104.5)
			f28_arg0.bgbAbilitySwirl:setAlpha(0)
			f28_arg0.bgbAbilitySwirl:setZRot(0)
			f28_local2(f28_arg0.bgbAbilitySwirl)
			local f28_local3 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					local f42_local0 = function(f43_arg0)
						f43_arg0:beginAnimation(340)
						f43_arg0:setAlpha(1)
						f43_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
					end
					f42_arg0:beginAnimation(329)
					f42_arg0:setAlpha(0)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
				end
				f41_arg0:beginAnimation(330)
				f41_arg0:setAlpha(1)
				f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f28_arg0.HealthBar:beginAnimation(330)
			f28_arg0.HealthBar:setAlpha(0)
			f28_arg0.HealthBar:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
			f28_arg0.HealthBar:registerEventHandler("transition_complete_keyframe", f28_local3)
		end,
	},
	Visible = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(0)
		end,
	},
	Visible2 = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.RiotShieldHealth.__onClose = function(f46_arg0)
	f46_arg0.HealthBar:close()
end
