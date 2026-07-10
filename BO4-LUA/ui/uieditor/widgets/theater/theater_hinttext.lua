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
	ItemHintText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	ItemHintText:setTTF("dinnext_regular")
	ItemHintText:setLetterSpacing(1)
	ItemHintText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ItemHintText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	local Arrow = LUI.UIImage.new(0, 0, 3, 18, 0.5, 0.5, -7.5, 7.5)
	Arrow:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Arrow:setAlpha(0.6)
	Arrow:setImage(RegisterImage(0x6961F4FBB41134C))
	self:addElement(Arrow)
	self.Arrow = Arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
