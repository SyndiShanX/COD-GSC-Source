require("x64:19c1945d2e472b0")
CoD.StoreProductNameLabel = InheritFrom(LUI.UIElement)
CoD.StoreProductNameLabel.__defaultWidth = 324
CoD.StoreProductNameLabel.__defaultHeight = 21
CoD.StoreProductNameLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StoreProductNameLabel)
	self.id = "StoreProductNameLabel"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local itemName = LUI.UIText.new(0, 0, 11.5, 314.5, 0.5, 0.5, -10.5, 10.5)
	itemName:setRGB(0.82, 0.85, 0.88)
	itemName:setAlpha(0.5)
	itemName:setText("")
	itemName:setTTF("ttmussels_regular")
	itemName:setLetterSpacing(0.5)
	itemName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	itemName:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	LUI.OverrideFunction_CallOriginalFirst(itemName, "setText", function(element, controller)
		ScaleWidgetToLabelWrappedUp(self, element, 1, 1)
	end)
	self:addElement(itemName)
	self.itemName = itemName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StoreProductNameLabel.__resetProperties = function(f3_arg0)
	f3_arg0.itemName:completeAnimation()
	f3_arg0.itemName:setAlpha(0.5)
end
CoD.StoreProductNameLabel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hide = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.itemName:completeAnimation()
			f5_arg0.itemName:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.itemName)
		end,
	},
}
CoD.StoreProductNameLabel.__onClose = function(f6_arg0)
	f6_arg0.StoreCommonTextBacking:close()
end
