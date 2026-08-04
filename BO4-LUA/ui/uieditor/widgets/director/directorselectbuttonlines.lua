CoD.DirectorSelectButtonLines = InheritFrom(LUI.UIElement)
CoD.DirectorSelectButtonLines.__defaultWidth = 288
CoD.DirectorSelectButtonLines.__defaultHeight = 214
CoD.DirectorSelectButtonLines.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorSelectButtonLines)
	self.id = "DirectorSelectButtonLines"
	self.soundSet = "FrontendMain"
	local TopBracket = LUI.UIImage.new(0, 1, -2, 2, 1, 1, -26.5, 3.5)
	TopBracket:setZRot(180)
	TopBracket:setImage(RegisterImage("uie_ui_menu_common_button_bracket"))
	TopBracket:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	TopBracket:setShaderVector(0, 0, 0, 0, 0)
	TopBracket:setupNineSliceShader(12, 12)
	self:addElement(TopBracket)
	self.TopBracket = TopBracket
	local TopLine = LUI.UIImage.new(0, 1, -2, 2, 0, 0, -3, 9)
	TopLine:setImage(RegisterImage(0xFF35E5F3948F398))
	TopLine:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	TopLine:setShaderVector(0, 0, 0, 0, 0)
	TopLine:setupNineSliceShader(12, 6)
	self:addElement(TopLine)
	self.TopLine = TopLine
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
