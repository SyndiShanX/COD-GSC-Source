CoD.FE_ButtonPanel = InheritFrom(LUI.UIElement)
CoD.FE_ButtonPanel.__defaultWidth = 123
CoD.FE_ButtonPanel.__defaultHeight = 30
CoD.FE_ButtonPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_ButtonPanel)
	self.id = "FE_ButtonPanel"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -3, 3)
	Image:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setupNineSliceShader(12, 12)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
