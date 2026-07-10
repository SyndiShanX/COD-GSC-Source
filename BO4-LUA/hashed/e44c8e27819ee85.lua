require("x64:dab8c3a6f5b136c")
CoD.IGRPerksListTitle = InheritFrom(LUI.UIElement)
CoD.IGRPerksListTitle.__defaultWidth = 300
CoD.IGRPerksListTitle.__defaultHeight = 60
CoD.IGRPerksListTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IGRPerksListTitle)
	self.id = "IGRPerksListTitle"
	self.soundSet = "default"
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 48)
	bg:setRGB(0.09, 0.09, 0.09)
	bg:setAlpha(0.5)
	self:addElement(bg)
	self.bg = bg
	local BGTexture = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGTexture:setImage(RegisterImage(0x34839E8065B1E53))
	BGTexture:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BGTexture:setShaderVector(0, 0, 0, 0, 0)
	BGTexture:setupNineSliceShader(64, 64)
	self:addElement(BGTexture)
	self.BGTexture = BGTexture
	local CommonPixelBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonPixelBacking:setRGB(1, 0.88, 0.05)
	CommonPixelBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	CommonPixelBacking.NoiseBacking:setAlpha(1)
	CommonPixelBacking.TiledShaderImage:setRGB(1, 0.54, 0)
	CommonPixelBacking.TiledShaderImage:setAlpha(0.15)
	CommonPixelBacking.TiledShaderImage:setupNineSliceShader(32, 32)
	self:addElement(CommonPixelBacking)
	self.CommonPixelBacking = CommonPixelBacking
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setImage(RegisterImage(0x15BB65132BCEED9))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(8, 8)
	self:addElement(Border)
	self.Border = Border
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IGRPerksListTitle.__onClose = function(f2_arg0)
	f2_arg0.CommonPixelBacking:close()
end
