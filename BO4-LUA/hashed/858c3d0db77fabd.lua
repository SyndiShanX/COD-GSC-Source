require("x64:aa44494b051bf23")
require("x64:c4e49820c5fffc4")
CoD.WeaponPickup = InheritFrom(LUI.UIElement)
CoD.WeaponPickup.__defaultWidth = 1100
CoD.WeaponPickup.__defaultHeight = 250
CoD.WeaponPickup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "interactivePrompt.activeObjectiveID")
	self:setClass(CoD.WeaponPickup)
	self.id = "WeaponPickup"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LineImage = LUI.UIImage.new(0.5, 0.5, -4, 4, 1, 1, -180, 0)
	LineImage:setAlpha(0.25)
	LineImage:setImage(RegisterImage(0x6C9564494BB3117))
	self:addElement(LineImage)
	self.LineImage = LineImage
	local ArrowImage = LUI.UIImage.new(0.5, 0.5, -22.5, 22.5, 1, 1, -77.5, -32.5)
	ArrowImage:setImage(RegisterImage(0x83BC30BE75FC25A))
	self:addElement(ArrowImage)
	self.ArrowImage = ArrowImage
	local PickupHintImage = CoD.WeaponPickupWeaponIcon.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0, 0, 40, 121)
	self:addElement(PickupHintImage)
	self.PickupHintImage = PickupHintImage
	local WeaponPickupPrompt = CoD.WeaponPickupPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -550, 550, 0, 0, 0, 40)
	WeaponPickupPrompt:linkToElementModel(self, nil, false, function(model)
		WeaponPickupPrompt:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponPickupPrompt)
	self.WeaponPickupPrompt = WeaponPickupPrompt
	self:mergeStateConditions({
		{
			stateName = "ThirdPersonHidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsMultiplayer() and CoD.WeaponUtility.ShouldHidePickupsForThirdPersonWeapon(f1_arg1)
			end,
		},
		{
			stateName = "GameModeHidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.ShouldHideWeaponPickup()
			end,
		},
		{
			stateName = "Hacked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0)
			end,
		},
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				return IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
			end,
		},
		{
			stateName = "ActiveSnap",
			condition = function(menu, element, event)
				local f7_local0 = CoD.WaypointUtility.IsWeaponPickupActive(f1_arg1, self)
				if f7_local0 then
					f7_local0 = CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isOffscreen")
					if f7_local0 then
						if
							not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
							and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
						then
							f7_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
						else
							f7_local0 = false
						end
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "Active",
			condition = function(menu, element, event)
				local f8_local0 = CoD.WaypointUtility.IsWeaponPickupActive(f1_arg1, self)
				if f8_local0 then
					if
						not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
					then
						f8_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "InRangeFar",
			condition = function(menu, element, event)
				local f9_local0 = CoD.WaypointUtility.IsWeaponPickupInRange(f1_arg1, self)
				if f9_local0 then
					f9_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gamemodeFlags", 1)
					if f9_local0 then
						if
							not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
							and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
						then
							f9_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
						else
							f9_local0 = false
						end
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "InRange",
			condition = function(menu, element, event)
				local f10_local0 = CoD.WaypointUtility.IsWeaponPickupInRange(f1_arg1, self)
				if f10_local0 then
					if
						not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
					then
						f10_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					else
						f10_local0 = false
					end
				end
				return f10_local0
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x79E684E90DF4625]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x79E684E90DF4625],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["hudItems.hacked"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.showPickupHint, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "showPickupHint",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7["inventory.open"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "inventory.open",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["interactivePrompt.activeObjectiveID"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "interactivePrompt.activeObjectiveID",
		})
	end, false)
	self:linkToElementModel(self, "isOffscreen", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isOffscreen",
		})
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x49AC9E07ED19EB6],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD567EDB5609CCEC],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA77EB9347BE4DFF],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f30_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f31_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f32_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	self:linkToElementModel(self, "gamemodeFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gamemodeFlags",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPickup.__resetProperties = function(f36_arg0)
	f36_arg0.WeaponPickupPrompt:completeAnimation()
	f36_arg0.LineImage:completeAnimation()
	f36_arg0.ArrowImage:completeAnimation()
	f36_arg0.PickupHintImage:completeAnimation()
	f36_arg0.WeaponPickupPrompt:setTopBottom(0, 0, 0, 40)
	f36_arg0.WeaponPickupPrompt:setAlpha(1)
	f36_arg0.LineImage:setTopBottom(1, 1, -180, 0)
	f36_arg0.LineImage:setAlpha(0.25)
	f36_arg0.ArrowImage:setTopBottom(1, 1, -77.5, -32.5)
	f36_arg0.ArrowImage:setAlpha(1)
	f36_arg0.ArrowImage:setScale(1, 1)
	f36_arg0.PickupHintImage:setTopBottom(0, 0, 40, 121)
	f36_arg0.PickupHintImage:setAlpha(1)
	f36_arg0.PickupHintImage:setScale(1, 1)
end
CoD.WeaponPickup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(4)
			f37_arg0.LineImage:completeAnimation()
			f37_arg0.LineImage:setTopBottom(1, 1, -155, 0)
			f37_arg0.LineImage:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.LineImage)
			f37_arg0.ArrowImage:completeAnimation()
			f37_arg0.ArrowImage:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ArrowImage)
			f37_arg0.PickupHintImage:completeAnimation()
			f37_arg0.PickupHintImage:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.PickupHintImage)
			f37_arg0.WeaponPickupPrompt:completeAnimation()
			f37_arg0.WeaponPickupPrompt:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.WeaponPickupPrompt)
		end,
		Active = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.ArrowImage:completeAnimation()
			f38_arg0.ArrowImage:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.ArrowImage)
		end,
		InRangeFar = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(4)
			local f39_local0 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					f41_arg0:beginAnimation(49)
					f41_arg0:setTopBottom(1, 1, -34, 0)
					f41_arg0:setAlpha(1)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.LineImage:beginAnimation(150)
				f39_arg0.LineImage:setTopBottom(1, 1, -30.5, 0)
				f39_arg0.LineImage:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.LineImage:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f39_arg0.LineImage:completeAnimation()
			f39_arg0.LineImage:setTopBottom(1, 1, -20, 0)
			f39_arg0.LineImage:setAlpha(0)
			f39_local0(f39_arg0.LineImage)
			local f39_local1 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					f43_arg0:beginAnimation(49)
					f43_arg0:setAlpha(1)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
				end
				f39_arg0.ArrowImage:beginAnimation(150)
				f39_arg0.ArrowImage:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.ArrowImage:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f39_arg0.ArrowImage:completeAnimation()
			f39_arg0.ArrowImage:setAlpha(0)
			f39_local1(f39_arg0.ArrowImage)
			f39_arg0.PickupHintImage:completeAnimation()
			f39_arg0.PickupHintImage:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.PickupHintImage)
			f39_arg0.WeaponPickupPrompt:completeAnimation()
			f39_arg0.WeaponPickupPrompt:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.WeaponPickupPrompt)
		end,
	},
	ThirdPersonHidden = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(4)
			f44_arg0.LineImage:completeAnimation()
			f44_arg0.LineImage:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.LineImage)
			f44_arg0.ArrowImage:completeAnimation()
			f44_arg0.ArrowImage:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.ArrowImage)
			f44_arg0.PickupHintImage:completeAnimation()
			f44_arg0.PickupHintImage:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.PickupHintImage)
			f44_arg0.WeaponPickupPrompt:completeAnimation()
			f44_arg0.WeaponPickupPrompt:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.WeaponPickupPrompt)
		end,
	},
	GameModeHidden = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(4)
			f45_arg0.LineImage:completeAnimation()
			f45_arg0.LineImage:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.LineImage)
			f45_arg0.ArrowImage:completeAnimation()
			f45_arg0.ArrowImage:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.ArrowImage)
			f45_arg0.PickupHintImage:completeAnimation()
			f45_arg0.PickupHintImage:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.PickupHintImage)
			f45_arg0.WeaponPickupPrompt:completeAnimation()
			f45_arg0.WeaponPickupPrompt:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.WeaponPickupPrompt)
		end,
	},
	Hacked = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(4)
			f46_arg0.LineImage:completeAnimation()
			f46_arg0.LineImage:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.LineImage)
			f46_arg0.ArrowImage:completeAnimation()
			f46_arg0.ArrowImage:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.ArrowImage)
			f46_arg0.PickupHintImage:completeAnimation()
			f46_arg0.PickupHintImage:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.PickupHintImage)
			f46_arg0.WeaponPickupPrompt:completeAnimation()
			f46_arg0.WeaponPickupPrompt:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.WeaponPickupPrompt)
		end,
	},
	EMP = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			f47_arg0.LineImage:completeAnimation()
			f47_arg0.LineImage:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.LineImage)
			f47_arg0.ArrowImage:completeAnimation()
			f47_arg0.ArrowImage:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.ArrowImage)
			f47_arg0.PickupHintImage:completeAnimation()
			f47_arg0.PickupHintImage:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.PickupHintImage)
			f47_arg0.WeaponPickupPrompt:completeAnimation()
			f47_arg0.WeaponPickupPrompt:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.WeaponPickupPrompt)
		end,
	},
	ActiveSnap = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(4)
			f48_arg0.LineImage:completeAnimation()
			f48_arg0.LineImage:setAlpha(0)
			f48_arg0.clipFinished(f48_arg0.LineImage)
			f48_arg0.ArrowImage:completeAnimation()
			f48_arg0.ArrowImage:setAlpha(0)
			f48_arg0.ArrowImage:setScale(0.15, 0.15)
			f48_arg0.clipFinished(f48_arg0.ArrowImage)
			f48_arg0.PickupHintImage:completeAnimation()
			f48_arg0.PickupHintImage:setTopBottom(0, 0, 125, 206)
			f48_arg0.clipFinished(f48_arg0.PickupHintImage)
			f48_arg0.WeaponPickupPrompt:completeAnimation()
			f48_arg0.WeaponPickupPrompt:setTopBottom(0, 0, 85, 125)
			f48_arg0.WeaponPickupPrompt:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.WeaponPickupPrompt)
		end,
	},
	Active = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			f49_arg0.LineImage:completeAnimation()
			f49_arg0.LineImage:setAlpha(0.25)
			f49_arg0.clipFinished(f49_arg0.LineImage)
			f49_arg0.ArrowImage:completeAnimation()
			f49_arg0.ArrowImage:setAlpha(0)
			f49_arg0.clipFinished(f49_arg0.ArrowImage)
			f49_arg0.WeaponPickupPrompt:completeAnimation()
			f49_arg0.WeaponPickupPrompt:setAlpha(1)
			f49_arg0.clipFinished(f49_arg0.WeaponPickupPrompt)
		end,
		InRange = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(3)
			f50_arg0.LineImage:completeAnimation()
			f50_arg0.LineImage:setTopBottom(1, 1, -180, 0)
			f50_arg0.LineImage:setAlpha(0.25)
			f50_arg0.clipFinished(f50_arg0.LineImage)
			f50_arg0.ArrowImage:completeAnimation()
			f50_arg0.ArrowImage:setAlpha(0)
			f50_arg0.clipFinished(f50_arg0.ArrowImage)
			local f50_local0 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(120)
					f52_arg0:setTopBottom(0, 0, 10, 50)
					f52_arg0:setAlpha(0)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
				end
				f50_arg0.WeaponPickupPrompt:beginAnimation(60)
				f50_arg0.WeaponPickupPrompt:setAlpha(0.67)
				f50_arg0.WeaponPickupPrompt:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.WeaponPickupPrompt:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f50_arg0.WeaponPickupPrompt:completeAnimation()
			f50_arg0.WeaponPickupPrompt:setTopBottom(0, 0, 0, 40)
			f50_arg0.WeaponPickupPrompt:setAlpha(1)
			f50_local0(f50_arg0.WeaponPickupPrompt)
		end,
	},
	InRangeFar = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(4)
			f53_arg0.LineImage:completeAnimation()
			f53_arg0.LineImage:setTopBottom(1, 1, -34, 0)
			f53_arg0.LineImage:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.LineImage)
			f53_arg0.ArrowImage:completeAnimation()
			f53_arg0.ArrowImage:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.ArrowImage)
			f53_arg0.PickupHintImage:completeAnimation()
			f53_arg0.PickupHintImage:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.PickupHintImage)
			f53_arg0.WeaponPickupPrompt:completeAnimation()
			f53_arg0.WeaponPickupPrompt:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.WeaponPickupPrompt)
		end,
		Active = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(4)
			local f54_local0 = function(f55_arg0)
				f54_arg0.LineImage:beginAnimation(100)
				f54_arg0.LineImage:setTopBottom(1, 1, -180, 0)
				f54_arg0.LineImage:setAlpha(0.25)
				f54_arg0.LineImage:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.LineImage:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.LineImage:completeAnimation()
			f54_arg0.LineImage:setTopBottom(1, 1, -34, 0)
			f54_arg0.LineImage:setAlpha(1)
			f54_local0(f54_arg0.LineImage)
			local f54_local1 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					f57_arg0:beginAnimation(59)
					f57_arg0:setAlpha(0)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
				end
				f54_arg0.ArrowImage:beginAnimation(100)
				f54_arg0.ArrowImage:setTopBottom(1, 1, -222.5, -177.5)
				f54_arg0.ArrowImage:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.ArrowImage:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f54_arg0.ArrowImage:completeAnimation()
			f54_arg0.ArrowImage:setTopBottom(1, 1, -77.5, -32.5)
			f54_arg0.ArrowImage:setAlpha(1)
			f54_local1(f54_arg0.ArrowImage)
			local f54_local2 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					f59_arg0:beginAnimation(59)
					f59_arg0:setAlpha(1)
					f59_arg0:setScale(1, 1)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
				end
				f54_arg0.PickupHintImage:beginAnimation(100)
				f54_arg0.PickupHintImage:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.PickupHintImage:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f54_arg0.PickupHintImage:completeAnimation()
			f54_arg0.PickupHintImage:setAlpha(0)
			f54_arg0.PickupHintImage:setScale(0.5, 0.5)
			f54_local2(f54_arg0.PickupHintImage)
			local f54_local3 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					local f61_local0 = function(f62_arg0)
						f62_arg0:beginAnimation(60)
						f62_arg0:setAlpha(1)
						f62_arg0:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
					end
					f61_arg0:beginAnimation(120)
					f61_arg0:setTopBottom(0, 0, 0, 40)
					f61_arg0:setAlpha(0.67)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
				end
				f54_arg0.WeaponPickupPrompt:beginAnimation(160)
				f54_arg0.WeaponPickupPrompt:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.WeaponPickupPrompt:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f54_arg0.WeaponPickupPrompt:completeAnimation()
			f54_arg0.WeaponPickupPrompt:setTopBottom(0, 0, 10, 50)
			f54_arg0.WeaponPickupPrompt:setAlpha(0)
			f54_local3(f54_arg0.WeaponPickupPrompt)
		end,
		DefaultState = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(4)
			local f63_local0 = function(f64_arg0)
				f63_arg0.LineImage:beginAnimation(50)
				f63_arg0.LineImage:setAlpha(0)
				f63_arg0.LineImage:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.LineImage:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
			end
			f63_arg0.LineImage:completeAnimation()
			f63_arg0.LineImage:setTopBottom(1, 1, -34, 0)
			f63_arg0.LineImage:setAlpha(1)
			f63_local0(f63_arg0.LineImage)
			local f63_local1 = function(f65_arg0)
				f63_arg0.ArrowImage:beginAnimation(50)
				f63_arg0.ArrowImage:setAlpha(0)
				f63_arg0.ArrowImage:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.ArrowImage:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
			end
			f63_arg0.ArrowImage:completeAnimation()
			f63_arg0.ArrowImage:setAlpha(1)
			f63_local1(f63_arg0.ArrowImage)
			f63_arg0.PickupHintImage:completeAnimation()
			f63_arg0.PickupHintImage:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.PickupHintImage)
			f63_arg0.WeaponPickupPrompt:completeAnimation()
			f63_arg0.WeaponPickupPrompt:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.WeaponPickupPrompt)
		end,
		InRange = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(4)
			local f66_local0 = function(f67_arg0)
				f66_arg0.LineImage:beginAnimation(100)
				f66_arg0.LineImage:setTopBottom(1, 1, -180, 0)
				f66_arg0.LineImage:setAlpha(0.25)
				f66_arg0.LineImage:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.LineImage:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.LineImage:completeAnimation()
			f66_arg0.LineImage:setTopBottom(1, 1, -34, 0)
			f66_arg0.LineImage:setAlpha(1)
			f66_local0(f66_arg0.LineImage)
			local f66_local1 = function(f68_arg0)
				local f68_local0 = function(f69_arg0)
					f69_arg0:beginAnimation(59)
					f69_arg0:setAlpha(0)
					f69_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.ArrowImage:beginAnimation(100)
				f66_arg0.ArrowImage:setTopBottom(1, 1, -222.5, -177.5)
				f66_arg0.ArrowImage:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.ArrowImage:registerEventHandler("transition_complete_keyframe", f68_local0)
			end
			f66_arg0.ArrowImage:completeAnimation()
			f66_arg0.ArrowImage:setTopBottom(1, 1, -77.5, -32.5)
			f66_arg0.ArrowImage:setAlpha(1)
			f66_local1(f66_arg0.ArrowImage)
			local f66_local2 = function(f70_arg0)
				local f70_local0 = function(f71_arg0)
					f71_arg0:beginAnimation(59)
					f71_arg0:setAlpha(1)
					f71_arg0:setScale(1, 1)
					f71_arg0:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
				end
				f66_arg0.PickupHintImage:beginAnimation(100)
				f66_arg0.PickupHintImage:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.PickupHintImage:registerEventHandler("transition_complete_keyframe", f70_local0)
			end
			f66_arg0.PickupHintImage:completeAnimation()
			f66_arg0.PickupHintImage:setAlpha(0)
			f66_arg0.PickupHintImage:setScale(0.5, 0.5)
			f66_local2(f66_arg0.PickupHintImage)
			local f66_local3 = function(f72_arg0)
				f66_arg0.WeaponPickupPrompt:beginAnimation(160)
				f66_arg0.WeaponPickupPrompt:registerEventHandler("interrupted_keyframe", f66_arg0.clipInterrupted)
				f66_arg0.WeaponPickupPrompt:registerEventHandler("transition_complete_keyframe", f66_arg0.clipFinished)
			end
			f66_arg0.WeaponPickupPrompt:completeAnimation()
			f66_arg0.WeaponPickupPrompt:setTopBottom(0, 0, 10, 50)
			f66_arg0.WeaponPickupPrompt:setAlpha(0)
			f66_local3(f66_arg0.WeaponPickupPrompt)
		end,
	},
	InRange = {
		DefaultClip = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(3)
			f73_arg0.LineImage:completeAnimation()
			f73_arg0.LineImage:setAlpha(0.25)
			f73_arg0.clipFinished(f73_arg0.LineImage)
			f73_arg0.ArrowImage:completeAnimation()
			f73_arg0.ArrowImage:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.ArrowImage)
			f73_arg0.WeaponPickupPrompt:completeAnimation()
			f73_arg0.WeaponPickupPrompt:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.WeaponPickupPrompt)
		end,
		Active = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(3)
			f74_arg0.LineImage:completeAnimation()
			f74_arg0.LineImage:setTopBottom(1, 1, -180, 0)
			f74_arg0.LineImage:setAlpha(0.25)
			f74_arg0.clipFinished(f74_arg0.LineImage)
			f74_arg0.ArrowImage:completeAnimation()
			f74_arg0.ArrowImage:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.ArrowImage)
			f74_arg0.WeaponPickupPrompt:completeAnimation()
			f74_arg0.WeaponPickupPrompt:setAlpha(1)
			f74_arg0.clipFinished(f74_arg0.WeaponPickupPrompt)
		end,
		InRangeFar = function(f75_arg0, f75_arg1)
			f75_arg0:__resetProperties()
			f75_arg0:setupElementClipCounter(4)
			local f75_local0 = function(f76_arg0)
				local f76_local0 = function(f77_arg0)
					f77_arg0:beginAnimation(100)
					f77_arg0:setTopBottom(1, 1, -34, 0)
					f77_arg0:setAlpha(1)
					f77_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.LineImage:beginAnimation(59)
				f75_arg0.LineImage:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.LineImage:registerEventHandler("transition_complete_keyframe", f76_local0)
			end
			f75_arg0.LineImage:completeAnimation()
			f75_arg0.LineImage:setTopBottom(1, 1, -180, 0)
			f75_arg0.LineImage:setAlpha(0.25)
			f75_local0(f75_arg0.LineImage)
			local f75_local1 = function(f78_arg0)
				local f78_local0 = function(f79_arg0)
					f79_arg0:beginAnimation(100)
					f79_arg0:setTopBottom(1, 1, -77.5, -32.5)
					f79_arg0:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
				end
				f75_arg0.ArrowImage:beginAnimation(59)
				f75_arg0.ArrowImage:setAlpha(1)
				f75_arg0.ArrowImage:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.ArrowImage:registerEventHandler("transition_complete_keyframe", f78_local0)
			end
			f75_arg0.ArrowImage:completeAnimation()
			f75_arg0.ArrowImage:setTopBottom(1, 1, -222.5, -177.5)
			f75_arg0.ArrowImage:setAlpha(0)
			f75_local1(f75_arg0.ArrowImage)
			local f75_local2 = function(f80_arg0)
				f75_arg0.PickupHintImage:beginAnimation(60)
				f75_arg0.PickupHintImage:setAlpha(0)
				f75_arg0.PickupHintImage:setScale(0.5, 0.5)
				f75_arg0.PickupHintImage:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.PickupHintImage:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
			end
			f75_arg0.PickupHintImage:completeAnimation()
			f75_arg0.PickupHintImage:setAlpha(1)
			f75_arg0.PickupHintImage:setScale(1, 1)
			f75_local2(f75_arg0.PickupHintImage)
			local f75_local3 = function(f81_arg0)
				f75_arg0.WeaponPickupPrompt:beginAnimation(160)
				f75_arg0.WeaponPickupPrompt:registerEventHandler("interrupted_keyframe", f75_arg0.clipInterrupted)
				f75_arg0.WeaponPickupPrompt:registerEventHandler("transition_complete_keyframe", f75_arg0.clipFinished)
			end
			f75_arg0.WeaponPickupPrompt:completeAnimation()
			f75_arg0.WeaponPickupPrompt:setTopBottom(0, 0, 10, 50)
			f75_arg0.WeaponPickupPrompt:setAlpha(0)
			f75_local3(f75_arg0.WeaponPickupPrompt)
		end,
	},
}
CoD.WeaponPickup.__onClose = function(f82_arg0)
	f82_arg0.PickupHintImage:close()
	f82_arg0.WeaponPickupPrompt:close()
end
