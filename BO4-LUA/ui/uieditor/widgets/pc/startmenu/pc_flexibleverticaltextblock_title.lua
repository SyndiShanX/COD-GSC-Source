CoD.PC_FlexibleVerticalTextBlock_Title = InheritFrom(LUI.UIElement)
CoD.PC_FlexibleVerticalTextBlock_Title.__defaultWidth = 760
CoD.PC_FlexibleVerticalTextBlock_Title.__defaultHeight = 52
CoD.PC_FlexibleVerticalTextBlock_Title.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_FlexibleVerticalTextBlock_Title)
	self.id = "PC_FlexibleVerticalTextBlock_Title"
	self.soundSet = "default"
	local Text = LUI.UIText.new(0.5, 0.5, -380, 380, 0.5, 0.5, -26, 26)
	Text:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Text:setTTF("ttmussels_regular")
	Text:setLetterSpacing(1)
	Text:setLineSpacing(4)
	Text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Text:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	Text:setBackingType(2)
	Text:setBackingAlpha(0)
	LUI.OverrideFunction_CallOriginalFirst(Text, "setText", function(element, controller)
		ScaleWidgetToLabelCenteredWrapped(self, element, 0, 0)
	end)
	self:addElement(Text)
	self.Text = Text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
