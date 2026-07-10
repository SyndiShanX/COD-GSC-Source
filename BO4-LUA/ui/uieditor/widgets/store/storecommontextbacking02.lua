require("x64:acbf06924421e35")
CoD.StoreCommonTextBacking02 = InheritFrom(LUI.UIElement)
CoD.StoreCommonTextBacking02.__defaultWidth = 324
CoD.StoreCommonTextBacking02.__defaultHeight = 53
CoD.StoreCommonTextBacking02.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StoreCommonTextBacking02)
	self.id = "StoreCommonTextBacking02"
	self.soundSet = "default"
	local NoiseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseBacking:setAlpha(0.85)
	NoiseBacking:setImage(RegisterImage(0xC082CFCA3C180E5))
	NoiseBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseBacking:setupNineSliceShader(24, 24)
	self:addElement(NoiseBacking)
	self.NoiseBacking = NoiseBacking
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledShaderImage:setImage(RegisterImage(0x4B6FFA90272070E))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(24, 24)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local ColorOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ColorOverlay:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	ColorOverlay:setAlpha(0.02)
	self:addElement(ColorOverlay)
	self.ColorOverlay = ColorOverlay
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StoreCommonTextBacking02.__onClose = function(f2_arg0)
	f2_arg0.CommonCornerPips:close()
end
