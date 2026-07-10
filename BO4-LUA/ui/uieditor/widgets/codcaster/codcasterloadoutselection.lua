CoD.CodCasterLoadoutSelection = InheritFrom(LUI.UIElement)
CoD.CodCasterLoadoutSelection.__defaultWidth = 60
CoD.CodCasterLoadoutSelection.__defaultHeight = 60
CoD.CodCasterLoadoutSelection.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterLoadoutSelection)
	self.id = "CodCasterLoadoutSelection"
	self.soundSet = "none"
	local Center = LUI.UIImage.new(0, 0, -2, 60, 0, 0, -2, 60)
	Center:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Center:setAlpha(0.8)
	Center:setImage(RegisterImage(@"hash_2A427E97A00EE43C"))
	self:addElement(Center)
	self.Center = Center
	local ItemName = LUI.UIText.new(0.5, 0.5, -85.5, 85.5, 0, 0, -31.5, -13.5)
	ItemName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	ItemName:setTTF("default")
	ItemName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ItemName:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ItemName:setBackingType(2)
	ItemName:setBackingColor(0, 0, 0)
	ItemName:setBackingAlpha(0.9)
	ItemName:setBackingXPadding(10)
	ItemName:setBackingYPadding(3)
	ItemName:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(ItemName)
	self.ItemName = ItemName
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
