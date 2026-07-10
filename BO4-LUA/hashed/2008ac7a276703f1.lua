require("x64:478f2bd71f935fd")
CoD.WarzoneInventoryMenuItemSmall_Internal_QE = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryMenuItemSmall_Internal_QE.__defaultWidth = 88
CoD.WarzoneInventoryMenuItemSmall_Internal_QE.__defaultHeight = 88
CoD.WarzoneInventoryMenuItemSmall_Internal_QE.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryMenuItemSmall_Internal_QE)
	self.id = "WarzoneInventoryMenuItemSmall_Internal_QE"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 11, 78, 0, 0, 13, 75)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backing = LUI.UIImage.new(0.5, 0.5, -33, 34, 0.5, 0.5, -31, 31)
	Backing:setRGB(0.09, 0.09, 0.07)
	Backing:setAlpha(0.95)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Backing:setShaderVector(0, 0.01, 0.01, 0.01, 0.01)
	self:addElement(Backing)
	self.Backing = Backing
	local LED = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 0.5, 88.5)
	LED:setRGB(0.29, 0.28, 0.22)
	LED:setAlpha(0.08)
	LED:setImage(RegisterImage(0x4EF5361D0A84EE8))
	self:addElement(LED)
	self.LED = LED
	local Icon = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -41, 35)
	Icon:setScale(0.72, 0.72)
	Icon:setMaterial(LUI.UIImage.GetCachedMaterial(0x67D1E3A3D2D1BF))
	Icon:setShaderVector(0, 1, 0, 0, 0)
	Icon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Border = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 0.5, 88.5)
	Border:setRGB(0.36, 0.34, 0.23)
	Border:setImage(RegisterImage(0x144D4B98D6C5F71))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Border:setShaderVector(0, 0.01, 0.05, 0.01, 0.1)
	self:addElement(Border)
	self.Border = Border
	local StackCount = CoD.WarzoneInventoryCounter.new(f1_arg0, f1_arg1, 0.5, 0.5, 9, 29, 0.5, 0.5, 9, 29)
	StackCount:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "stackCount", 1) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "totalCount", 1)
			end,
		},
	})
	StackCount:linkToElementModel(StackCount, "stackCount", true, function(model)
		f1_arg0:updateElementState(StackCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "stackCount",
		})
	end)
	StackCount:linkToElementModel(StackCount, "totalCount", true, function(model)
		f1_arg0:updateElementState(StackCount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "totalCount",
		})
	end)
	StackCount.Counter:setBackingColor(0.36, 0.34, 0.23)
	StackCount:linkToElementModel(self, nil, false, function(model)
		StackCount:setModel(model, f1_arg1)
	end)
	StackCount:linkToElementModel(self, "totalCount", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			StackCount.Counter:setText(f7_local0)
		end
	end)
	self:addElement(StackCount)
	self.StackCount = StackCount
	local triangles = LUI.UIImage.new(0, 0, 1, 89, 0, 0, 0.5, 88.5)
	triangles:setRGB(0, 0, 0)
	triangles:setAlpha(0)
	triangles:setImage(RegisterImage(0x8CF82F4676A49D8))
	self:addElement(triangles)
	self.triangles = triangles
	self:mergeStateConditions({
		{
			stateName = "QuickInventoryClosed",
			condition = function(menu, element, event)
				return not CoD.WZUtility.IsQuickInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["hudItems.inventory.open"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.inventory.open",
		})
	end, false)
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryMenuItemSmall_Internal_QE.__resetProperties = function(f12_arg0)
	f12_arg0.Icon:completeAnimation()
	f12_arg0.Backing:completeAnimation()
	f12_arg0.Blur:completeAnimation()
	f12_arg0.triangles:completeAnimation()
	f12_arg0.StackCount:completeAnimation()
	f12_arg0.Border:completeAnimation()
	f12_arg0.LED:completeAnimation()
	f12_arg0.Icon:setAlpha(1)
	f12_arg0.Backing:setRGB(0.09, 0.09, 0.07)
	f12_arg0.Backing:setAlpha(0.95)
	f12_arg0.Blur:setAlpha(1)
	f12_arg0.triangles:setAlpha(0)
	f12_arg0.StackCount:setAlpha(1)
	f12_arg0.Border:setAlpha(1)
	f12_arg0.LED:setAlpha(0.08)
end
CoD.WarzoneInventoryMenuItemSmall_Internal_QE.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Icon:completeAnimation()
			f13_arg0.Icon:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.Icon)
		end,
		Focus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Backing:completeAnimation()
			f14_arg0.Backing:setRGB(0.09, 0.09, 0.07)
			f14_arg0.clipFinished(f14_arg0.Backing)
		end,
	},
	QuickInventoryClosed = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			f15_arg0.Blur:completeAnimation()
			f15_arg0.Blur:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Blur)
			f15_arg0.Backing:completeAnimation()
			f15_arg0.Backing:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Backing)
			f15_arg0.LED:completeAnimation()
			f15_arg0.LED:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.LED)
			f15_arg0.Icon:completeAnimation()
			f15_arg0.Icon:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Icon)
			f15_arg0.Border:completeAnimation()
			f15_arg0.Border:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Border)
			f15_arg0.StackCount:completeAnimation()
			f15_arg0.StackCount:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.StackCount)
			f15_arg0.triangles:completeAnimation()
			f15_arg0.triangles:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.triangles)
		end,
	},
	Empty = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.Icon:completeAnimation()
			f16_arg0.Icon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Icon)
			f16_arg0.StackCount:completeAnimation()
			f16_arg0.StackCount:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.StackCount)
		end,
		Focus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.Icon:completeAnimation()
			f17_arg0.Icon:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Icon)
			f17_arg0.StackCount:completeAnimation()
			f17_arg0.StackCount:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.StackCount)
		end,
		GainFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.Icon:completeAnimation()
			f18_arg0.Icon:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Icon)
			f18_arg0.StackCount:completeAnimation()
			f18_arg0.StackCount:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.StackCount)
		end,
		LoseFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.Icon:completeAnimation()
			f19_arg0.Icon:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.Icon)
			f19_arg0.StackCount:completeAnimation()
			f19_arg0.StackCount:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.StackCount)
		end,
	},
}
CoD.WarzoneInventoryMenuItemSmall_Internal_QE.__onClose = function(f20_arg0)
	f20_arg0.Icon:close()
	f20_arg0.StackCount:close()
end
