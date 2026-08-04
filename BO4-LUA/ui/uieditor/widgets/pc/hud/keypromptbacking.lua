CoD.KeyPromptBacking = InheritFrom(LUI.UIElement)
CoD.KeyPromptBacking.__defaultWidth = 80
CoD.KeyPromptBacking.__defaultHeight = 20
CoD.KeyPromptBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KeyPromptBacking)
	self.id = "KeyPromptBacking"
	self.soundSet = "default"
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0, 0, 0)
	Blur:setAlpha(0.4)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backing = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.9)
	self:addElement(Backing)
	self.Backing = Backing
	local TextureExtra = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextureExtra:setAlpha(0.01)
	TextureExtra:setImage(RegisterImage(0x2672072E395DD3F))
	TextureExtra:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TextureExtra:setShaderVector(0, 0, 0, 0, 0)
	TextureExtra:setupNineSliceShader(100, 30)
	self:addElement(TextureExtra)
	self.TextureExtra = TextureExtra
	local NineSliceShaderImage = LUI.UIImage.new(0, 1, -6, 6, 0, 1, -6, 6)
	NineSliceShaderImage:setImage(RegisterImage(@"hash_46BBB6966B2A83CE"))
	NineSliceShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	NineSliceShaderImage:setShaderVector(0, 0, 0, 0, 0)
	NineSliceShaderImage:setupNineSliceShader(15, 15)
	self:addElement(NineSliceShaderImage)
	self.NineSliceShaderImage = NineSliceShaderImage
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
