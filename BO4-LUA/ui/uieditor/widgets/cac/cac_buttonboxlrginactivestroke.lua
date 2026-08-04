CoD.cac_ButtonBoxLrgInactiveStroke = InheritFrom(LUI.UIElement)
CoD.cac_ButtonBoxLrgInactiveStroke.__defaultWidth = 168
CoD.cac_ButtonBoxLrgInactiveStroke.__defaultHeight = 168
CoD.cac_ButtonBoxLrgInactiveStroke.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cac_ButtonBoxLrgInactiveStroke)
	self.id = "cac_ButtonBoxLrgInactiveStroke"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setImage(RegisterImage("uie_t7_menu_cac_buttonboxlrgstrokefull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setupNineSliceShader(24, 24)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
