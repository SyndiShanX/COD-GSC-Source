CoD.zm_location = InheritFrom(CoD.Menu)
LUI.createMenu.zm_location = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_location", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_location)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local bgbGlowOrangeOver = LUI.UIImage.new(0.5, 0.5, -923, -764, 0.5, 0.5, -629.5, -356.5)
	bgbGlowOrangeOver:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	bgbGlowOrangeOver:setAlpha(0)
	bgbGlowOrangeOver:setZRot(90)
	bgbGlowOrangeOver:setImage(RegisterImage(0x5BE416E17DAB33B))
	bgbGlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(bgbGlowOrangeOver)
	self.bgbGlowOrangeOver = bgbGlowOrangeOver
	local Location = LUI.UIText.new(0, 0, 37, 237, 0, 0, 37, 69)
	Location:setAlpha(0.55)
	Location:setTTF("skorzhen")
	Location:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Location:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Location:linkToElementModel(self, "location_name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Location:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(Location)
	self.Location = Location
	local bgbAbilitySwirl = LUI.UIImage.new(0.5, 0.5, -904, -796, 0, 0, -5, 101)
	bgbAbilitySwirl:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	bgbAbilitySwirl:setAlpha(0)
	bgbAbilitySwirl:setZRot(330)
	bgbAbilitySwirl:setScale(1.65, 1.65)
	bgbAbilitySwirl:setImage(RegisterImage(0xBBBD54E6E7B4493))
	bgbAbilitySwirl:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(bgbAbilitySwirl)
	self.bgbAbilitySwirl = bgbAbilitySwirl
	self:mergeStateConditions({
		{
			stateName = "hiddenTutorial",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg0, "ztutorial") and CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.ztut.showLocation", 0)
			end,
		},
		{
			stateName = "Trials_HUDDeactivated",
			condition = function(menu, element, event)
				local f4_local0 = CoD.HUDUtility.IsAnyGameType(f1_arg0, "ztrials")
				if f4_local0 then
					f4_local0 = CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.hudDeactivated", 1)
					if f4_local0 then
						f4_local0 = not CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.infoHidden")
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "ShowWithScoreboard",
			condition = function(menu, element, event)
				local f5_local0
				if
					not CoD.HUDUtility.IsAnyGameType(f1_arg0, "zclassic")
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
					and Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
				then
					f5_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f6_local0
				if
					not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
					and Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
					and not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
				then
					f6_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["hudItems.ztut.showLocation"], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.ztut.showLocation",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["ZMHudGlobal.trials.hudDeactivated"], function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "ZMHudGlobal.trials.hudDeactivated",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["ZMHudGlobal.trials.infoHidden"], function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "ZMHudGlobal.trials.infoHidden",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f21_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f22_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f23_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f24_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f25_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f26_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f27_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f28_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	f1_local6 = self
	if not IsPC() then
		SizeToSafeArea(f1_local6, f1_arg0)
	elseif IsPC() then
		SizeToHudArea(f1_local6, f1_arg0)
	end
	return self
end
CoD.zm_location.__resetProperties = function(f29_arg0)
	f29_arg0.Location:completeAnimation()
	f29_arg0.bgbAbilitySwirl:completeAnimation()
	f29_arg0.bgbGlowOrangeOver:completeAnimation()
	f29_arg0.Location:setAlpha(0.55)
	f29_arg0.bgbAbilitySwirl:setAlpha(0)
	f29_arg0.bgbAbilitySwirl:setZRot(330)
	f29_arg0.bgbGlowOrangeOver:setAlpha(0)
end
CoD.zm_location.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			f30_arg0.Location:completeAnimation()
			f30_arg0.Location:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.Location)
		end,
		Trials_HUDDeactivated = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.Location:beginAnimation(3000)
				f31_arg0.Location:setAlpha(0)
				f31_arg0.Location:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Location:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.Location:completeAnimation()
			f31_arg0.Location:setAlpha(0.55)
			f31_local0(f31_arg0.Location)
		end,
	},
	hiddenTutorial = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.Location:completeAnimation()
			f33_arg0.Location:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Location)
		end,
		DefaultState = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(3)
			local f34_local0 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					local f36_local0 = function(f37_arg0)
						local f37_local0 = function(f38_arg0)
							local f38_local0 = function(f39_arg0)
								local f39_local0 = function(f40_arg0)
									local f40_local0 = function(f41_arg0)
										f41_arg0:beginAnimation(230)
										f41_arg0:setAlpha(0)
										f41_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
									end
									f40_arg0:beginAnimation(110)
									f40_arg0:setAlpha(0.7)
									f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
								end
								f39_arg0:beginAnimation(199)
								f39_arg0:setAlpha(0)
								f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
							end
							f38_arg0:beginAnimation(130)
							f38_arg0:setAlpha(0.7)
							f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
						end
						f37_arg0:beginAnimation(140)
						f37_arg0:setAlpha(0)
						f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
					end
					f36_arg0:beginAnimation(189)
					f36_arg0:setAlpha(0.7)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
				end
				f34_arg0.bgbGlowOrangeOver:beginAnimation(330)
				f34_arg0.bgbGlowOrangeOver:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.bgbGlowOrangeOver:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f34_arg0.bgbGlowOrangeOver:completeAnimation()
			f34_arg0.bgbGlowOrangeOver:setAlpha(0)
			f34_local0(f34_arg0.bgbGlowOrangeOver)
			local f34_local1 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						f44_arg0:beginAnimation(340)
						f44_arg0:setAlpha(0.55)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
					end
					f43_arg0:beginAnimation(329)
					f43_arg0:setAlpha(0)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f42_arg0:beginAnimation(330)
				f42_arg0:setAlpha(1)
				f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f34_arg0.Location:beginAnimation(330)
			f34_arg0.Location:setAlpha(0)
			f34_arg0.Location:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
			f34_arg0.Location:registerEventHandler("transition_complete_keyframe", f34_local1)
			local f34_local2 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					f46_arg0:beginAnimation(199)
					f46_arg0:setAlpha(0)
					f46_arg0:setZRot(360)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
				end
				f34_arg0.bgbAbilitySwirl:beginAnimation(330)
				f34_arg0.bgbAbilitySwirl:setAlpha(1)
				f34_arg0.bgbAbilitySwirl:setZRot(240)
				f34_arg0.bgbAbilitySwirl:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.bgbAbilitySwirl:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f34_arg0.bgbAbilitySwirl:completeAnimation()
			f34_arg0.bgbAbilitySwirl:setAlpha(0)
			f34_arg0.bgbAbilitySwirl:setZRot(0)
			f34_local2(f34_arg0.bgbAbilitySwirl)
		end,
	},
	Trials_HUDDeactivated = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(1)
			f47_arg0.Location:completeAnimation()
			f47_arg0.Location:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.Location)
		end,
		ShowWithScoreboard = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(1)
			local f48_local0 = function(f49_arg0)
				f48_arg0.Location:beginAnimation(1000)
				f48_arg0.Location:setAlpha(0.55)
				f48_arg0.Location:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.Location:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.Location:completeAnimation()
			f48_arg0.Location:setAlpha(0)
			f48_local0(f48_arg0.Location)
		end,
	},
	ShowWithScoreboard = {
		DefaultClip = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(0)
		end,
		Trials_HUDDeactivated = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(1)
			local f51_local0 = function(f52_arg0)
				f51_arg0.Location:beginAnimation(3000)
				f51_arg0.Location:setAlpha(0)
				f51_arg0.Location:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.Location:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
			end
			f51_arg0.Location:completeAnimation()
			f51_arg0.Location:setAlpha(0.55)
			f51_local0(f51_arg0.Location)
		end,
	},
	Show = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(0)
		end,
		Trials_HUDDeactivated = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(1)
			local f54_local0 = function(f55_arg0)
				f54_arg0.Location:beginAnimation(3000)
				f54_arg0.Location:setAlpha(0)
				f54_arg0.Location:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.Location:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.Location:completeAnimation()
			f54_arg0.Location:setAlpha(0.55)
			f54_local0(f54_arg0.Location)
		end,
	},
}
CoD.zm_location.__onClose = function(f56_arg0)
	f56_arg0.Location:close()
end
