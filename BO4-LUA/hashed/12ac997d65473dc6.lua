require("x64:ee2ad4f22d3a2c3")
CoD.ZMInventoryList = InheritFrom(LUI.UIElement)
CoD.ZMInventoryList.__defaultWidth = 1400
CoD.ZMInventoryList.__defaultHeight = 80
CoD.ZMInventoryList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMInventoryList)
	self.id = "ZMInventoryList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Inventory = CoD.ZMInventoryListInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, 500, 0.5, 0.5, -40, 40)
	self:addElement(Inventory)
	self.Inventory = Inventory
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and not CoD.HUDUtility.IsAnyGameType(f1_arg1, "zstandard")
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	Inventory.id = "Inventory"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMInventoryList.__resetProperties = function(f4_arg0)
	f4_arg0.Inventory:completeAnimation()
	f4_arg0.Inventory:setAlpha(1)
end
CoD.ZMInventoryList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Inventory:completeAnimation()
			f5_arg0.Inventory:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Inventory)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ZMInventoryList.__onClose = function(f7_arg0)
	f7_arg0.Inventory:close()
end
