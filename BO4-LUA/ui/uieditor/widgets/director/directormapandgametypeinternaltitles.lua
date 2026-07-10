CoD.DirectorMapAndGameTypeInternalTitles = InheritFrom(LUI.UIElement)
CoD.DirectorMapAndGameTypeInternalTitles.__defaultWidth = 384
CoD.DirectorMapAndGameTypeInternalTitles.__defaultHeight = 52
CoD.DirectorMapAndGameTypeInternalTitles.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorMapAndGameTypeInternalTitles)
	self.id = "DirectorMapAndGameTypeInternalTitles"
	self.soundSet = "default"
	local Label = LUI.UIText.new(0, 1, 9, -9, 0, 0, 0, 22)
	Label:setRGB(0.63, 0.62, 0.61)
	Label:setText("")
	Label:setTTF("ttmussels_regular")
	Label:setLetterSpacing(4)
	Label:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Label:setBackingType(2)
	Label:setBackingColor(0, 0, 0)
	Label:setBackingAlpha(0.9)
	Label:setBackingXPadding(4)
	self:addElement(Label)
	self.Label = Label
	local SubTitle = LUI.UIText.new(0, 0, 9, 347, 0, 0, 22, 52)
	SubTitle:setRGB(0.86, 0.74, 0.25)
	SubTitle:setText("")
	SubTitle:setTTF("ttmussels_regular")
	SubTitle:setLetterSpacing(6)
	SubTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SubTitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	SubTitle:setBackingType(2)
	SubTitle:setBackingColor(0, 0, 0)
	SubTitle:setBackingAlpha(0.95)
	SubTitle:setBackingXPadding(4)
	self:addElement(SubTitle)
	self.SubTitle = SubTitle
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
