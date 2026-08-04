CoD.ObituaryBlurBacking = InheritFrom(LUI.UIElement)
CoD.ObituaryBlurBacking.__defaultWidth = 325
CoD.ObituaryBlurBacking.__defaultHeight = 50
CoD.ObituaryBlurBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ObituaryBlurBacking)
	self.id = "ObituaryBlurBacking"
	self.soundSet = "default"
	local BlurBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlurBacking:setRGB(0, 0, 0)
	BlurBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlurBacking:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlurBacking)
	self.BlurBacking = BlurBacking
	local NoiseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseBacking:setRGB(0.2, 0.2, 0.2)
	NoiseBacking:setAlpha(0.85)
	NoiseBacking:setImage(RegisterImage("uie_ui_menu_store_price_bg"))
	NoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseBacking:setupNineSliceShader(24, 24)
	self:addElement(NoiseBacking)
	self.NoiseBacking = NoiseBacking
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
