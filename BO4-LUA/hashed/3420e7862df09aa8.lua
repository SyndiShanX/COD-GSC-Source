CoD.PC_Theater_Keyboard_Shortcut_Text = InheritFrom(LUI.UIElement)
CoD.PC_Theater_Keyboard_Shortcut_Text.__defaultWidth = 224
CoD.PC_Theater_Keyboard_Shortcut_Text.__defaultHeight = 16
CoD.PC_Theater_Keyboard_Shortcut_Text.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Theater_Keyboard_Shortcut_Text)
	self.id = "PC_Theater_Keyboard_Shortcut_Text"
	self.soundSet = "default"
	local Text = LUI.UIText.new(0, 1, 12, 0, 0.5, 0.5, -7.5, 7.5)
	Text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Text:setText(LocalizeToUpperString(0xA61241CD7E3DE2B))
	Text:setTTF("dinnext_regular")
	Text:setLineSpacing(2)
	Text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Text:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Text)
	self.Text = Text
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	f1_local2 = Text
	if IsPC() then
		CoD.PCWidgetUtility.EnableShrinkToFit(f1_local2)
	end
	return self
end
CoD.PC_Theater_Keyboard_Shortcut_Text.__onClose = function(f2_arg0)
	f2_arg0.Text:close()
end
