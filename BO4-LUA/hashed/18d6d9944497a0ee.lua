CoD.ItemShopRarityBackgroundStream_Ultra = InheritFrom(LUI.UIElement)
CoD.ItemShopRarityBackgroundStream_Ultra.__defaultWidth = 600
CoD.ItemShopRarityBackgroundStream_Ultra.__defaultHeight = 600
CoD.ItemShopRarityBackgroundStream_Ultra.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopRarityBackgroundStream_Ultra)
	self.id = "ItemShopRarityBackgroundStream_Ultra"
	self.soundSet = "none"
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.85)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local CommonOuterGlow = LUI.UIImage.new(0, 1, -11, 11, 0, 1, -12, 12)
	CommonOuterGlow:setImage(RegisterImage(0xAE13B63B2001396))
	CommonOuterGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	CommonOuterGlow:setShaderVector(0, 0, 0, 0, 0)
	CommonOuterGlow:setupNineSliceShader(32, 32)
	CommonOuterGlow:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonOuterGlow:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f2_local0))
		end
	end)
	self:addElement(CommonOuterGlow)
	self.CommonOuterGlow = CommonOuterGlow
	local BGBrighten = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBrighten:setAlpha(0.1)
	BGBrighten:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BGBrighten:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f3_local0))
		end
	end)
	self:addElement(BGBrighten)
	self.BGBrighten = BGBrighten
	local BGPatternThin = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGPatternThin:setAlpha(0.3)
	BGPatternThin:setImage(RegisterImage(0xC740F3CC5928DAB))
	BGPatternThin:setMaterial(LUI.UIImage.GetCachedMaterial(0xC221B51E4063E3D))
	BGPatternThin:setShaderVector(0, 0, 0, 0, 0)
	BGPatternThin:setShaderVector(1, 1, 1, 0, 0)
	BGPatternThin:setShaderVector(2, 0, 0, 0, 0)
	BGPatternThin:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BGPatternThin:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f4_local0))
		end
	end)
	self:addElement(BGPatternThin)
	self.BGPatternThin = BGPatternThin
	local Wipe = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Wipe:setRGB(0, 0, 0)
	Wipe:setAlpha(0.9)
	Wipe:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	Wipe:setShaderVector(0, 0, 1, 0, 0)
	Wipe:setShaderVector(1, 0, 0, 0, 0)
	Wipe:setShaderVector(2, 0.36, 1, 0, 0)
	Wipe:setShaderVector(3, 0.56, 0, 0, 0)
	Wipe:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(Wipe)
	self.Wipe = Wipe
	local Gradient = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Gradient:setRGB(0, 0, 0)
	Gradient:setImage(RegisterImage(0x8F71B593239CEE7))
	self:addElement(Gradient)
	self.Gradient = Gradient
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopRarityBackgroundStream_Ultra.__onClose = function(f5_arg0)
	f5_arg0.CommonOuterGlow:close()
	f5_arg0.BGBrighten:close()
	f5_arg0.BGPatternThin:close()
end
