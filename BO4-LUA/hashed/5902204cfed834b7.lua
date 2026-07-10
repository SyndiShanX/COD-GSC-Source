CoD.FTUEDescriptionWidget = InheritFrom(LUI.UIElement)
CoD.FTUEDescriptionWidget.__defaultWidth = 301
CoD.FTUEDescriptionWidget.__defaultHeight = 59
CoD.FTUEDescriptionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FTUEDescriptionWidget)
	self.id = "FTUEDescriptionWidget"
	self.soundSet = "default"
	local InventoryTitleLabel = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 23)
	InventoryTitleLabel:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	InventoryTitleLabel:setText(LocalizeToUpperString(0xF5027E25ECEDB35))
	InventoryTitleLabel:setTTF("ttmussels_demibold")
	InventoryTitleLabel:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	InventoryTitleLabel:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7]))
	self:addElement(InventoryTitleLabel)
	self.InventoryTitleLabel = InventoryTitleLabel
	local AmmoTextBox = LUI.UIText.new(0, 1, 0, 0, 0, 0, 37, 55)
	AmmoTextBox:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	AmmoTextBox:setText(Engine[0xF9F1239CFD921FE](0x4B0EEFF4D432726))
	AmmoTextBox:setTTF("dinnext_regular")
	AmmoTextBox:setLineSpacing(5)
	AmmoTextBox:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	AmmoTextBox:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(AmmoTextBox)
	self.AmmoTextBox = AmmoTextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
