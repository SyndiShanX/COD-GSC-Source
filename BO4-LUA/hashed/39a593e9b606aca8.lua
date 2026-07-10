CoD.WeaponPickupWeaponIcon = InheritFrom(LUI.UIElement)
CoD.WeaponPickupWeaponIcon.__defaultWidth = 156
CoD.WeaponPickupWeaponIcon.__defaultHeight = 81
CoD.WeaponPickupWeaponIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPickupWeaponIcon)
	self.id = "WeaponPickupWeaponIcon"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PickupHintImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 156, 0, 0, 0, 81)
	PickupHintImage:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupHintImage", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PickupHintImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PickupHintImage)
	self.PickupHintImage = PickupHintImage
	local WeaponIndexBasedImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 156, 0, 0, 0, 81)
	WeaponIndexBasedImage:setAlpha(0)
	WeaponIndexBasedImage:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupHintWeaponIndex", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			WeaponIndexBasedImage:setImage(RegisterImage(GetWeaponItemImageFromIndex(f3_local0)))
		end
	end)
	self:addElement(WeaponIndexBasedImage)
	self.WeaponIndexBasedImage = WeaponIndexBasedImage
	self:mergeStateConditions({
		{
			stateName = "DualPromptActive",
			condition = function(menu, element, event)
				return CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(f1_arg1)
			end,
		},
		{
			stateName = "WeaponIndexBased",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "pickupHintWeaponIndex", 0)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.weapon3dHintState, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "weapon3dHintState",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.inventory.filledSlots"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.inventory.filledSlots",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.pickupHintWeaponIndex, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "pickupHintWeaponIndex",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPickupWeaponIcon.__resetProperties = function(f9_arg0)
	f9_arg0.PickupHintImage:completeAnimation()
	f9_arg0.WeaponIndexBasedImage:completeAnimation()
	f9_arg0.PickupHintImage:setTopBottom(0, 0, 0, 81)
	f9_arg0.PickupHintImage:setAlpha(1)
	f9_arg0.WeaponIndexBasedImage:setAlpha(0)
end
CoD.WeaponPickupWeaponIcon.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	DualPromptActive = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.PickupHintImage:completeAnimation()
			f11_arg0.PickupHintImage:setTopBottom(0, 0, 40.5, 121.5)
			f11_arg0.clipFinished(f11_arg0.PickupHintImage)
		end,
	},
	WeaponIndexBased = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.PickupHintImage:completeAnimation()
			f12_arg0.PickupHintImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PickupHintImage)
			f12_arg0.WeaponIndexBasedImage:completeAnimation()
			f12_arg0.WeaponIndexBasedImage:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.WeaponIndexBasedImage)
		end,
	},
}
CoD.WeaponPickupWeaponIcon.__onClose = function(f13_arg0)
	f13_arg0.PickupHintImage:close()
	f13_arg0.WeaponIndexBasedImage:close()
end
