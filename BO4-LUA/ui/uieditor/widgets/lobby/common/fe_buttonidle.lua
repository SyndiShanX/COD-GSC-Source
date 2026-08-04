CoD.FE_ButtonIdle = InheritFrom(LUI.UIElement)
CoD.FE_ButtonIdle.__defaultWidth = 123
CoD.FE_ButtonIdle.__defaultHeight = 30
CoD.FE_ButtonIdle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_ButtonIdle)
	self.id = "FE_ButtonIdle"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -3, 3)
	Image:setImage(RegisterImage("uie_t7_menu_frontend_buttonidlefull"))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setupNineSliceShader(12, 12)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
