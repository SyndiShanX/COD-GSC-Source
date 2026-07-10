CoD.AARTierRewardItemEmpty = InheritFrom(LUI.UIElement)
CoD.AARTierRewardItemEmpty.__defaultWidth = 105
CoD.AARTierRewardItemEmpty.__defaultHeight = 136
CoD.AARTierRewardItemEmpty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardItemEmpty)
	self.id = "AARTierRewardItemEmpty"
	self.soundSet = "default"
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.33)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Image = LUI.UIFixedAspectRatioImage.new(0, 0, 6, 99, 0, 0, 6, 130)
	Image:setAlpha(0)
	Image:setStretchedDimension(4)
	Image:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local CommonFrame01 = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	CommonFrame01:setRGB(ColorSet.BlackMarketCommon.r, ColorSet.BlackMarketCommon.g, ColorSet.BlackMarketCommon.b)
	CommonFrame01:setAlpha(0.5)
	CommonFrame01:setImage(RegisterImage(0xCA6E5C175806396))
	CommonFrame01:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	CommonFrame01:setShaderVector(0, 0, 0, 0, 0)
	CommonFrame01:setupNineSliceShader(8, 8)
	self:addElement(CommonFrame01)
	self.CommonFrame01 = CommonFrame01
	local EmptyCrossPattern = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	EmptyCrossPattern:setRGB(0.26, 0.26, 0.26)
	EmptyCrossPattern:setAlpha(0.4)
	EmptyCrossPattern:setImage(RegisterImage(0x7CE2B4A880C99EE))
	self:addElement(EmptyCrossPattern)
	self.EmptyCrossPattern = EmptyCrossPattern
	local Darken = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Darken:setRGB(0, 0, 0)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardItemEmpty.__onClose = function(f3_arg0)
	f3_arg0.Image:close()
end
