require("x64:246178cf189051b")
require("x64:a6bff704f5a0dc4")
CoD.PC_Theater_Keyboard_Shortcut = InheritFrom(LUI.UIElement)
CoD.PC_Theater_Keyboard_Shortcut.__defaultWidth = 260
CoD.PC_Theater_Keyboard_Shortcut.__defaultHeight = 60
CoD.PC_Theater_Keyboard_Shortcut.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.PC_Theater_Keyboard_Shortcut)
	self.id = "PC_Theater_Keyboard_Shortcut"
	self.soundSet = "default"
	local KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 36, 0.5, 0.5, -11.5, 11.5)
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	local Text = CoD.PC_Theater_Keyboard_Shortcut_Text.new(f1_arg0, f1_arg1, 0, 1, 36, 0, 0.5, 0.5, -8, 8)
	Text.Text:setText(LocalizeToUpperString(0xA61241CD7E3DE2B))
	self:addElement(Text)
	self.Text = Text
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Theater_Keyboard_Shortcut.__onClose = function(f2_arg0)
	f2_arg0.KeyPrompt:close()
	f2_arg0.Text:close()
end
