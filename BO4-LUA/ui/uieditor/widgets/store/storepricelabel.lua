require("x64:19c1945d2e472b0")
CoD.StorePriceLabel = InheritFrom(LUI.UIElement)
CoD.StorePriceLabel.__defaultWidth = 156
CoD.StorePriceLabel.__defaultHeight = 32
CoD.StorePriceLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StorePriceLabel)
	self.id = "StorePriceLabel"
	self.soundSet = "default"
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local itemName = LUI.UIText.new(1, 1, -163, -15, 0.5, 0.5, -9.5, 11.5)
	itemName:setRGB(0.82, 0.85, 0.88)
	itemName:setText("")
	itemName:setTTF("ttmussels_regular")
	itemName:setLetterSpacing(1.5)
	itemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	itemName:setBackingType(1)
	itemName:setBackingXPadding(5)
	itemName:setBackingYPadding(4)
	LUI.OverrideFunction_CallOriginalFirst(itemName, "setText", function(element, controller)
		ScaleWidgetToLabelRightAligned(self, element, 6)
	end)
	self:addElement(itemName)
	self.itemName = itemName
	local Glow = LUI.UIImage.new(1, 2, -202, -110, 0.5, 2.34, -29.5, -29.5)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_t7_core_hud_mapwidget_panelglow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StorePriceLabel.__onClose = function(f3_arg0)
	f3_arg0.StoreCommonTextBacking:close()
end
