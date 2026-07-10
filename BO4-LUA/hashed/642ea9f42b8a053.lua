CoD.ContractSeasonalPromoBacker = InheritFrom(LUI.UIElement)
CoD.ContractSeasonalPromoBacker.__defaultWidth = 20
CoD.ContractSeasonalPromoBacker.__defaultHeight = 20
CoD.ContractSeasonalPromoBacker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractSeasonalPromoBacker)
	self.id = "ContractSeasonalPromoBacker"
	self.soundSet = "none"
	local NineSliceShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NineSliceShaderImage:setImage(RegisterImage(0xE5BA786F58D8A47))
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(6, 6)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
