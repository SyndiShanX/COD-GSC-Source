CoD.PC_StartMenu_Options_KeybindMessage_TopLineDeco = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_KeybindMessage_TopLineDeco.__defaultWidth = 1920
CoD.PC_StartMenu_Options_KeybindMessage_TopLineDeco.__defaultHeight = 7
CoD.PC_StartMenu_Options_KeybindMessage_TopLineDeco.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_KeybindMessage_TopLineDeco)
	self.id = "PC_StartMenu_Options_KeybindMessage_TopLineDeco"
	self.soundSet = "default"
	local LineCenter = LUI.UIImage.new(0, 1, 300, -300, 0, 0, 0, 7)
	self:addElement(LineCenter)
	self.LineCenter = LineCenter
	local DecoLeft = LUI.UIImage.new(0, 0, 308, 327, 0, 0, 3, 4)
	DecoLeft:setRGB(0, 0, 0)
	self:addElement(DecoLeft)
	self.DecoLeft = DecoLeft
	local DecoRight = LUI.UIImage.new(1, 1, -327, -308, 0, 0, 3, 4)
	DecoRight:setRGB(0, 0, 0)
	self:addElement(DecoRight)
	self.DecoRight = DecoRight
	local LineLeft = LUI.UIImage.new(0, 0, 0, 291, 0, 0, 0, 7)
	self:addElement(LineLeft)
	self.LineLeft = LineLeft
	local LineRight = LUI.UIImage.new(1, 1, -291, 0, 0, 0, 0, 7)
	self:addElement(LineRight)
	self.LineRight = LineRight
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
