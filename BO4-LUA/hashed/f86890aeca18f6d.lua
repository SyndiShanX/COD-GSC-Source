CoD.hud_hacked_ammo_widget = InheritFrom(LUI.UIElement)
CoD.hud_hacked_ammo_widget.__defaultWidth = 310
CoD.hud_hacked_ammo_widget.__defaultHeight = 64
CoD.hud_hacked_ammo_widget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.hud_hacked_ammo_widget)
	self.id = "hud_hacked_ammo_widget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Hacked2 = LUI.UIImage.new(0, 0, 0, 310, 0, 0, 0, 64)
	Hacked2:setRGB(0.32, 0.44, 0.52)
	Hacked2:setAlpha(0.25)
	Hacked2:setZRot(180)
	Hacked2:setImage(RegisterImage(0x74A8C8624AAE4D2))
	Hacked2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	Hacked2:setShaderVector(0, 4, 4, 0, 0)
	Hacked2:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(Hacked2)
	self.Hacked2 = Hacked2
	local Hacked = LUI.UIImage.new(0, 0, 0, 310, 0, 0, 0, 64)
	Hacked:setRGB(0.32, 0.44, 0.52)
	Hacked:setImage(RegisterImage(0x74A8C8624AAE4D2))
	Hacked:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	Hacked:setShaderVector(0, 4, 4, 0, 0)
	Hacked:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(Hacked)
	self.Hacked = Hacked
	self:mergeStateConditions({
		{
			stateName = "Hacked",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "hacked", 1)
				if f2_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]) then
						f2_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.hacked, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hacked",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.hud_hacked_ammo_widget.__resetProperties = function(f8_arg0)
	f8_arg0.Hacked:completeAnimation()
	f8_arg0.Hacked2:completeAnimation()
	f8_arg0.Hacked:setAlpha(1)
	f8_arg0.Hacked2:setAlpha(0.25)
end
CoD.hud_hacked_ammo_widget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.Hacked2:completeAnimation()
			f9_arg0.Hacked2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Hacked2)
			f9_arg0.Hacked:completeAnimation()
			f9_arg0.Hacked:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Hacked)
		end,
	},
	Hacked = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
