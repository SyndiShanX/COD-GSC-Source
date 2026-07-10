require("x64:478f2bd71f935fd")
CoD.WarzoneQuickInventoryMenuItemSmall_Internal = InheritFrom(LUI.UIElement)
CoD.WarzoneQuickInventoryMenuItemSmall_Internal.__defaultWidth = 92
CoD.WarzoneQuickInventoryMenuItemSmall_Internal.__defaultHeight = 90
CoD.WarzoneQuickInventoryMenuItemSmall_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneQuickInventoryMenuItemSmall_Internal)
	self.id = "WarzoneQuickInventoryMenuItemSmall_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 11, 78, 0, 0, 13, 75)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backing = LUI.UIImage.new(0.5, 0.5, -35, 32, 0.5, 0.5, -32, 30)
	Backing:setRGB(0.34, 0.32, 0.2)
	Backing:setAlpha(0.95)
	self:addElement(Backing)
	self.Backing = Backing
	local Icon = LUI.UIImage.new(0.5, 0.5, -38, 38, 0.5, 0.5, -42, 34)
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
	local StackCount = CoD.WarzoneInventoryCounter.new(f1_arg0, f1_arg1, 0.5, 0.5, 20, 40, 0.5, 0.5, 21, 41)
	StackCount:setAlpha(0)
	StackCount:linkToElementModel(self, nil, false, function(model)
		StackCount:setModel(model, f1_arg1)
	end)
	StackCount:linkToElementModel(self, "stackCount", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			StackCount.Counter:setText(f4_local0)
		end
	end)
	self:addElement(StackCount)
	self.StackCount = StackCount
	local Border = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 0.5, 88.5)
	Border:setRGB(0, 0, 0)
	Border:setImage(RegisterImage(0x144D4B98D6C5F71))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Border:setShaderVector(0, 0.01, 0.1, 0.01, 0.1)
	self:addElement(Border)
	self.Border = Border
	local triangles = LUI.UIImage.new(0, 0, 0.5, 88.5, 0, 0, 0.5, 88.5)
	triangles:setRGB(0, 0, 0)
	triangles:setImage(RegisterImage(0x8CF82F4676A49D8))
	self:addElement(triangles)
	self.triangles = triangles
	local LED = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 0.5, 88.5)
	LED:setRGB(0.29, 0.28, 0.22)
	LED:setAlpha(0.08)
	LED:setImage(RegisterImage(0x4EF5361D0A84EE8))
	self:addElement(LED)
	self.LED = LED
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE)
			end,
		},
	})
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
CoD.WarzoneQuickInventoryMenuItemSmall_Internal.__resetProperties = function(f7_arg0)
	f7_arg0.Icon:completeAnimation()
	f7_arg0.StackCount:completeAnimation()
	f7_arg0.Icon:setAlpha(1)
	f7_arg0.StackCount:setAlpha(0)
end
CoD.WarzoneQuickInventoryMenuItemSmall_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Icon:completeAnimation()
			f8_arg0.Icon:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Icon)
		end,
		GainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Icon:completeAnimation()
			f9_arg0.Icon:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Icon)
		end,
		LoseFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Icon:completeAnimation()
			f10_arg0.Icon:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Icon)
		end,
	},
	Empty = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Icon:completeAnimation()
			f11_arg0.Icon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Icon)
			f11_arg0.StackCount:completeAnimation()
			f11_arg0.StackCount:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.StackCount)
		end,
		Focus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.Icon:completeAnimation()
			f12_arg0.Icon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Icon)
			f12_arg0.StackCount:completeAnimation()
			f12_arg0.StackCount:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.StackCount)
		end,
		GainFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.Icon:completeAnimation()
			f13_arg0.Icon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Icon)
			f13_arg0.StackCount:completeAnimation()
			f13_arg0.StackCount:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.StackCount)
		end,
		LoseFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.Icon:completeAnimation()
			f14_arg0.Icon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Icon)
			f14_arg0.StackCount:completeAnimation()
			f14_arg0.StackCount:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.StackCount)
		end,
	},
}
CoD.WarzoneQuickInventoryMenuItemSmall_Internal.__onClose = function(f15_arg0)
	f15_arg0.Icon:close()
	f15_arg0.StackCount:close()
end
