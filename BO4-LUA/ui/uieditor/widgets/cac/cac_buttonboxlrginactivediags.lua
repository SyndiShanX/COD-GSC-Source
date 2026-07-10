CoD.cac_ButtonBoxLrgInactiveDiags = InheritFrom(LUI.UIElement)
CoD.cac_ButtonBoxLrgInactiveDiags.__defaultWidth = 168
CoD.cac_ButtonBoxLrgInactiveDiags.__defaultHeight = 168
CoD.cac_ButtonBoxLrgInactiveDiags.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cac_ButtonBoxLrgInactiveDiags)
	self.id = "cac_ButtonBoxLrgInactiveDiags"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, -3, 3, 0, 1, -2, 2)
	Image:setImage(RegisterImage(0x969C9BD28349534))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Image:setShaderVector(0, 0, 0, 0, 0)
	Image:setupNineSliceShader(36, 36)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
