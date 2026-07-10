CoD.ContractSeasonalBacker = InheritFrom(LUI.UIElement)
CoD.ContractSeasonalBacker.__defaultWidth = 60
CoD.ContractSeasonalBacker.__defaultHeight = 29
CoD.ContractSeasonalBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractSeasonalBacker)
	self.id = "ContractSeasonalBacker"
	self.soundSet = "none"
	local NineSliceShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -7, 24)
	NineSliceShaderImage:setImage(RegisterImage(@"hash_32F868891484B77"))
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(26, 26)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
