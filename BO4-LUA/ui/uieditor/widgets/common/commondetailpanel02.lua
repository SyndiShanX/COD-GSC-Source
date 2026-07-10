CoD.CommonDetailPanel02 = InheritFrom(LUI.UIElement)
CoD.CommonDetailPanel02.__defaultWidth = 474
CoD.CommonDetailPanel02.__defaultHeight = 578
CoD.CommonDetailPanel02.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonDetailPanel02)
	self.id = "CommonDetailPanel02"
	self.soundSet = "default"
	local BackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local BackingTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingTint:setRGB(0.09, 0.09, 0.09)
	BackingTint:setAlpha(0.9)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local BackingNoise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingNoise:setAlpha(0.5)
	BackingNoise:setImage(RegisterImage(0x34839E8065B1E53))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local HeaderStripe1 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -17, -1)
	HeaderStripe1:setImage(RegisterImage(0xC7A051F5EFC70E5))
	HeaderStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	HeaderStripe1:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripe1:setupNineSliceShader(88, 16)
	self:addElement(HeaderStripe1)
	self.HeaderStripe1 = HeaderStripe1
	local FooterStripe1 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, 1, 17)
	FooterStripe1:setImage(RegisterImage(0xC7A051F5EFC70E5))
	FooterStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	FooterStripe1:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe1:setupNineSliceShader(88, 16)
	self:addElement(FooterStripe1)
	self.FooterStripe1 = FooterStripe1
	local BraketBottom = LUI.UIImage.new(0, 1, -3.5, 2.5, 1, 1, -28, 1)
	BraketBottom:setZRot(180)
	BraketBottom:setImage(RegisterImage(0x81D4EAAB75120FF))
	BraketBottom:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BraketBottom:setShaderVector(0, 0, 0, 0, 0)
	BraketBottom:setupNineSliceShader(350, 20)
	self:addElement(BraketBottom)
	self.BraketBottom = BraketBottom
	local BraketTop = LUI.UIImage.new(0, 1, -2.5, 3.5, 0, 0, -1, 28)
	BraketTop:setImage(RegisterImage(0x81D4EAAB75120FF))
	BraketTop:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BraketTop:setShaderVector(0, 0, 0, 0, 0)
	BraketTop:setupNineSliceShader(350, 20)
	self:addElement(BraketTop)
	self.BraketTop = BraketTop
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
