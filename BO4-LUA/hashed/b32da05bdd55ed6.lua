CoD.MeritBoardItem = InheritFrom(LUI.UIElement)
CoD.MeritBoardItem.__defaultWidth = 520
CoD.MeritBoardItem.__defaultHeight = 60
CoD.MeritBoardItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MeritBoardItem)
	self.id = "MeritBoardItem"
	self.soundSet = "none"
	local ItemLabel = LUI.UIText.new(0, 0, 0, 342, 0.5, 0.5, -18, 18)
	ItemLabel:setText("")
	ItemLabel:setTTF("default")
	ItemLabel:setLetterSpacing(2)
	ItemLabel:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ItemLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ItemLabel)
	self.ItemLabel = ItemLabel
	local ItemValue = LUI.UIText.new(0, 0, 370, 520, 0.5, 0.5, -18, 18)
	ItemValue:setRGB(ColorSet.Orange.r, ColorSet.Orange.g, ColorSet.Orange.b)
	ItemValue:setText("")
	ItemValue:setTTF("default")
	ItemValue:setLetterSpacing(2)
	ItemValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ItemValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ItemValue)
	self.ItemValue = ItemValue
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
