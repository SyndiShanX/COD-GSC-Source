CoD.CommonPixelBacking = InheritFrom(LUI.UIElement)
CoD.CommonPixelBacking.__defaultWidth = 324
CoD.CommonPixelBacking.__defaultHeight = 53
CoD.CommonPixelBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonPixelBacking)
	self.id = "CommonPixelBacking"
	self.soundSet = "default"
	local NoiseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseBacking:setAlpha(0.85)
	NoiseBacking:setImage(RegisterImage("uie_ui_menu_store_price_bg"))
	NoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseBacking:setupNineSliceShader(24, 24)
	self:addElement(NoiseBacking)
	self.NoiseBacking = NoiseBacking
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledShaderImage:setImage(RegisterImage("uie_ui_menu_common_repeat_dot_pattern"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
