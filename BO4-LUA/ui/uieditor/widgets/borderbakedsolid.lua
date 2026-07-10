CoD.BorderBakedSolid = InheritFrom(LUI.UIElement)
CoD.BorderBakedSolid.__defaultWidth = 180
CoD.BorderBakedSolid.__defaultHeight = 180
CoD.BorderBakedSolid.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BorderBakedSolid)
	self.id = "BorderBakedSolid"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setImage(RegisterImage(0x5AF002D5D24FFE3))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Image:setShaderVector(0, 0, 0, 0.36, 0.36)
	Image:setupNineSliceShader(24, 24)
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
