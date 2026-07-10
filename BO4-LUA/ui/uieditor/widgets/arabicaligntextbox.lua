CoD.ArabicAlignTextBox = InheritFrom(LUI.UIElement)
CoD.ArabicAlignTextBox.__defaultWidth = 198
CoD.ArabicAlignTextBox.__defaultHeight = 33
CoD.ArabicAlignTextBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArabicAlignTextBox)
	self.id = "ArabicAlignTextBox"
	self.soundSet = "default"
	local textBox = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -16.5, 16.5)
	textBox:setText("")
	textBox:setTTF("default")
	textBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	textBox:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(textBox)
	self.textBox = textBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
