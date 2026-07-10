CoD.blackhatEmp = InheritFrom(LUI.UIElement)
CoD.blackhatEmp.__defaultWidth = 303
CoD.blackhatEmp.__defaultHeight = 252
CoD.blackhatEmp.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.blackhatEmp)
	self.id = "blackhatEmp"
	self.soundSet = "default"
	local Image0 = LUI.UIImage.new(0, 0, 0, 304, 0, 0, 0, 252)
	Image0:setImage(RegisterImage(@"uie_hud_t7_blackhat_emp"))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_emp"))
	Image0:setShaderVector(0, 17.69, 0, 0, 0)
	Image0:setShaderVector(1, 1.63, 0, 0, 0)
	Image0:setShaderVector(2, 2.21, 0, 0, 0)
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
