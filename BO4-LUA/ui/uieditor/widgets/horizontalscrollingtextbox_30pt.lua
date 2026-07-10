CoD.horizontalScrollingTextBox_30pt = InheritFrom(LUI.UIElement)
CoD.horizontalScrollingTextBox_30pt.__defaultWidth = 900
CoD.horizontalScrollingTextBox_30pt.__defaultHeight = 51
CoD.horizontalScrollingTextBox_30pt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.horizontalScrollingTextBox_30pt)
	self.id = "horizontalScrollingTextBox_30pt"
	self.soundSet = "default"
	local textBox = LUI.UIText.new(0, 0, 0, 900, 1, 1, -45, 0)
	textBox:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	textBox:setTTF("default")
	textBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	textBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	textBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(textBox)
	self.textBox = textBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.TextUtility.SetupHorizontalScrollingWidget(self, f1_arg1)
	return self
end
