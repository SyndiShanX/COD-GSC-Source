CoD[0xDF24394E064A5D7] = InheritFrom(LUI.UIElement)
CoD[0xDF24394E064A5D7].__defaultWidth = 960
CoD[0xDF24394E064A5D7].__defaultHeight = 240
CoD[0xDF24394E064A5D7].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0xDF24394E064A5D7])
	self.id = "CallingCards_MP_100percent"
	self.soundSet = "default"
	local clouds = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 238)
	clouds:setImage(RegisterImage(0xD1299062323139))
	clouds:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	clouds:setShaderVector(0, 1, 1, 0, 0)
	clouds:setShaderVector(1, 0.04, 0, 0, 0)
	self:addElement(clouds)
	self.clouds = clouds
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0x88FD6A86243C457))
	self:addElement(bg)
	self.bg = bg
	local swordSheen = LUI.UIImage.new(0, 0, 643, 707, 0, 0, 0, 240)
	swordSheen:setAlpha(0.15)
	swordSheen:setImage(RegisterImage(0x58441FFB2F0BD7C))
	swordSheen:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	swordSheen:setShaderVector(0, 0, 4, 0, 0)
	swordSheen:setShaderVector(1, 2, 0, 0, 0)
	self:addElement(swordSheen)
	self.swordSheen = swordSheen
	local ArmorShine = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	ArmorShine:setAlpha(0.3)
	ArmorShine:setImage(RegisterImage(0x280C77C84EA5EFA))
	ArmorShine:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	ArmorShine:setShaderVector(0, 0, 3, 0, 0)
	ArmorShine:setShaderVector(1, 6, 0, 0, 0)
	self:addElement(ArmorShine)
	self.ArmorShine = ArmorShine
	local goldShader = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	goldShader:setAlpha(0.2)
	goldShader:setImage(RegisterImage(0x5D6D23AB95CD33B))
	goldShader:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	goldShader:setShaderVector(0, 0, 3, 0, 0)
	goldShader:setShaderVector(1, 18, 0, 0, 0)
	self:addElement(goldShader)
	self.goldShader = goldShader
	local coinShimmer = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	coinShimmer:setAlpha(0.25)
	coinShimmer:setImage(RegisterImage(0x88AC9577E390BA6))
	coinShimmer:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	coinShimmer:setShaderVector(0, 0, 3, 0, 0)
	coinShimmer:setShaderVector(1, 9, 0, 0, 0)
	self:addElement(coinShimmer)
	self.coinShimmer = coinShimmer
	local snarl = LUI.UIImage.new(0, 0, 201, 273, 0, 0, -2, 238)
	snarl:setImage(RegisterImage(0x83A7EAA75D7D257))
	snarl:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	snarl:setShaderVector(0, 0, 4, 0, 0)
	snarl:setShaderVector(1, 4.01, 0, 0, 0)
	self:addElement(snarl)
	self.snarl = snarl
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(0x7EEE1693E39382A))
	self:addElement(cropper)
	self.cropper = cropper
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
