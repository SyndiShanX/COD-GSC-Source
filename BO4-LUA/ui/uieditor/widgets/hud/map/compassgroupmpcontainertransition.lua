require("x64:50ce70a16679544")
require("x64:cb6e5e515b30cfd")
CoD.CompassGroupMPContainerTransition = InheritFrom(LUI.UIElement)
CoD.CompassGroupMPContainerTransition.__defaultWidth = 350
CoD.CompassGroupMPContainerTransition.__defaultHeight = 350
CoD.CompassGroupMPContainerTransition.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassGroupMPContainerTransition)
	self.id = "CompassGroupMPContainerTransition"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CompassGroupContainer = CoD.CompassGroupMPContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 350, 0, 0, 0, 350)
	self:addElement(CompassGroupContainer)
	self.CompassGroupContainer = CompassGroupContainer
	local CompassHacked = LUI.UIImage.new(0, 0, 17, 333, 0, 0, 19, 331)
	CompassHacked:setAlpha(0)
	CompassHacked:setImage(RegisterImage(0x330E5EA57874A60))
	CompassHacked:setMaterial(LUI.UIImage.GetCachedMaterial(0xC284ECCBDADEF0B))
	CompassHacked:setShaderVector(0, 50, 0, 0, 0)
	CompassHacked:setShaderVector(1, 1, 0, 0, 0)
	CompassHacked:setShaderVector(2, 1, 0, 0, 0)
	self:addElement(CompassHacked)
	self.CompassHacked = CompassHacked
	local hudhackedmapwidget = CoD.hud_hacked_map_widget.new(f1_arg0, f1_arg1, 0, 0, 1, 349, 0, 0, 5, 353)
	hudhackedmapwidget:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(hudhackedmapwidget)
	self.hudhackedmapwidget = hudhackedmapwidget
	self:mergeStateConditions({
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				local f2_local0
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
					and not IsCodCaster(f1_arg1)
				then
					f2_local0 = CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.playerSpawned")
					if f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
					end
				else
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				local f3_local0 = IsPC()
				if f3_local0 then
					if
						Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
					then
						f3_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f4_local0
				if
					Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
				then
					f4_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["factions.isCoDCaster"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.playerSpawned"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompassGroupMPContainerTransition.__resetProperties = function(f26_arg0)
	f26_arg0.CompassGroupContainer:completeAnimation()
	f26_arg0.CompassHacked:completeAnimation()
	f26_arg0.CompassGroupContainer:setLeftRight(0, 0, 0, 350)
	f26_arg0.CompassGroupContainer:setAlpha(1)
	f26_arg0.CompassHacked:setAlpha(0)
end
CoD.CompassGroupMPContainerTransition.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			f27_arg0.CompassGroupContainer:completeAnimation()
			f27_arg0.CompassGroupContainer:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.CompassGroupContainer)
		end,
		Visible = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.CompassGroupContainer:beginAnimation(600, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f28_arg0.CompassGroupContainer:setLeftRight(0, 0, 0, 350)
				f28_arg0.CompassGroupContainer:setAlpha(1)
				f28_arg0.CompassGroupContainer:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.CompassGroupContainer:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.CompassGroupContainer:completeAnimation()
			f28_arg0.CompassGroupContainer:setLeftRight(0, 0, -20, 330)
			f28_arg0.CompassGroupContainer:setAlpha(0)
			f28_local0(f28_arg0.CompassGroupContainer)
		end,
		VisiblePC = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				f30_arg0.CompassGroupContainer:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f30_arg0.CompassGroupContainer:setLeftRight(0, 0, 0, 350)
				f30_arg0.CompassGroupContainer:setAlpha(1)
				f30_arg0.CompassGroupContainer:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.CompassGroupContainer:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.CompassGroupContainer:completeAnimation()
			f30_arg0.CompassGroupContainer:setLeftRight(0, 0, -20, 330)
			f30_arg0.CompassGroupContainer:setAlpha(0)
			f30_local0(f30_arg0.CompassGroupContainer)
		end,
	},
	EMP = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.CompassGroupContainer:completeAnimation()
			f32_arg0.CompassGroupContainer:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.CompassGroupContainer)
			f32_arg0.CompassHacked:completeAnimation()
			f32_arg0.CompassHacked:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.CompassHacked)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.CompassGroupMPContainerTransition.__onClose = function(f35_arg0)
	f35_arg0.CompassGroupContainer:close()
	f35_arg0.hudhackedmapwidget:close()
end
