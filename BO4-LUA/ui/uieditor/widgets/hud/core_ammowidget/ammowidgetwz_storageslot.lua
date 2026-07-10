CoD.AmmoWidgetWZ_StorageSlot = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetWZ_StorageSlot.__defaultWidth = 98
CoD.AmmoWidgetWZ_StorageSlot.__defaultHeight = 68
CoD.AmmoWidgetWZ_StorageSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetWZ_StorageSlot)
	self.id = "AmmoWidgetWZ_StorageSlot"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0, 0, 8, 64, 0, 0, 5, 61)
	Icon:setImage(RegisterImage(0xFC6DC76D7FCC7A8))
	Icon:setMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(Icon)
	self.Icon = Icon
	self:mergeStateConditions({
		{
			stateName = "HasBackpack",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.hasBackpack", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.hasBackpack"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.hasBackpack",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetWZ_StorageSlot.__resetProperties = function(f4_arg0)
	f4_arg0.Icon:completeAnimation()
	f4_arg0.Icon:setAlpha(1)
end
CoD.AmmoWidgetWZ_StorageSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Icon:completeAnimation()
			f5_arg0.Icon:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Icon)
		end,
	},
	HasBackpack = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
