CoD.cac_LabelNew = InheritFrom(LUI.UIElement)
CoD.cac_LabelNew.__defaultWidth = 156
CoD.cac_LabelNew.__defaultHeight = 36
CoD.cac_LabelNew.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cac_LabelNew)
	self.id = "cac_LabelNew"
	self.soundSet = "default"
	local Image00 = LUI.UIImage.new(0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	Image00:setImage(RegisterImage(@"uie_t7_menu_cac_iconnewbanner"))
	self:addElement(Image00)
	self.Image00 = Image00
	local itemName = LUI.UIText.new(0.5, 0.5, -33, 34, 0.5, 0.5, -12, 12)
	itemName:setRGB(0, 0, 0)
	itemName:setText(LocalizeToUpperString(@"menu/new"))
	itemName:setTTF("dinnext_regular")
	itemName:setLetterSpacing(1.5)
	itemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	itemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(itemName)
	self.itemName = itemName
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
