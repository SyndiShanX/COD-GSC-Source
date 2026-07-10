CoD.ZM_Promo_Banner = InheritFrom(LUI.UIElement)
CoD.ZM_Promo_Banner.__defaultWidth = 40
CoD.ZM_Promo_Banner.__defaultHeight = 30
CoD.ZM_Promo_Banner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZM_Promo_Banner)
	self.id = "ZM_Promo_Banner"
	self.soundSet = "none"
	local NineSliceShaderImage = LUI.UIImage.new(0, 1, -9, 9, 0, 1, 0, 0)
	NineSliceShaderImage:setImage(RegisterImage(@"uie_ui_zm_laboratory_promo_banner"))
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(20, 20)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
