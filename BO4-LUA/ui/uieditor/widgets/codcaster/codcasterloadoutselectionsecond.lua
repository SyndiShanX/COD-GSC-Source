CoD.CodCasterLoadoutSelectionSecond = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutSelectionSecond.__defaultWidth = 114
CoD.CodCasterLoadoutSelectionSecond.__defaultHeight = 76
CoD.CodCasterLoadoutSelectionSecond.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutSelectionSecond)
	self.id = "CodCasterLoadoutSelectionSecond"
	self.soundSet = "none"
	local Center = LUI.UIImage.new(0.5, 0.5, -55, 57, 0.5, 0.5, -36, 31)
	Center:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Center:setAlpha(0.8)
	Center:setScale(0.95, 0.95)
	Center:setImage(RegisterImage(0x51741269C73828))
	self:addElement(Center)
	self.Center = Center
	local ItemName = LUI.UIText.new(0.5, 0.5, -85.5, 85.5, 0, 0, -23.5, -5.5)
	ItemName:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	ItemName:setTTF("default")
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ItemName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ItemName:setBackingType(2)
	ItemName:setBackingColor(0, 0, 0)
	ItemName:setBackingAlpha(0.9)
	ItemName:setBackingXPadding(10)
	ItemName:setBackingYPadding(3)
	ItemName:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0xE8F55203998700A))
	self:addElement(ItemName)
	self.ItemName = ItemName
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
