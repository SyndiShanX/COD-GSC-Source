CoD.PC_StartMenu_Options_Description_TextBacking = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Description_TextBacking.__defaultWidth = 60
CoD.PC_StartMenu_Options_Description_TextBacking.__defaultHeight = 60
CoD.PC_StartMenu_Options_Description_TextBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Description_TextBacking)
	self.id = "PC_StartMenu_Options_Description_TextBacking"
	self.soundSet = "default"
	local LineT = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 1)
	LineT:setAlpha(0.3)
	self:addElement(LineT)
	self.LineT = LineT
	local LineB = LUI.UIImage.new(0, 0, 0, 12, 1, 1, -1, 0)
	LineB:setAlpha(0)
	self:addElement(LineB)
	self.LineB = LineB
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
