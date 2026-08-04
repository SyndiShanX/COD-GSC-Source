CoD.FE_ButtonFocus = InheritFrom(LUI.UIElement)
CoD.FE_ButtonFocus.__defaultWidth = 126
CoD.FE_ButtonFocus.__defaultHeight = 42
CoD.FE_ButtonFocus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_ButtonFocus)
	self.id = "FE_ButtonFocus"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, -12, 12, 0, 1, -9, 9)
	Image:setImage(RegisterImage("uie_t7_menu_frontend_buttonfocusfull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	Image:setShaderVector(0, 0, 0, 0.38, 0.2)
	Image:setupNineSliceShader(18, 18)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
