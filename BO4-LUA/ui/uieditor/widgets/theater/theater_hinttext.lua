CoD.Theater_HintText = InheritFrom(LUI.UIElement)
CoD.Theater_HintText.__defaultWidth = 400
CoD.Theater_HintText.__defaultHeight = 20
CoD.Theater_HintText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Theater_HintText)
	self.id = "Theater_HintText"
	self.soundSet = "default"
	local ItemHintText = LUI.UIText.new(0, 0, 22, 420, 0, 0, 0.5, 20.5)
	ItemHintText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ItemHintText:setAlpha(0.8)
	ItemHintText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	ItemHintText:setTTF("dinnext_regular")
	ItemHintText:setLetterSpacing(1)
	ItemHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ItemHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	local Arrow = LUI.UIImage.new(0, 0, 3, 18, 0.5, 0.5, -7.5, 7.5)
	Arrow:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Arrow:setAlpha(0.6)
	Arrow:setImage(RegisterImage(@"uie_t7_menu_gunsmith_arrow_white"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
