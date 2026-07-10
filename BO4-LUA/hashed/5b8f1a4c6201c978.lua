CoD.AARTierRewardBackground_Rare = InheritFrom(LUI.UIElement)
CoD.AARTierRewardBackground_Rare.__defaultWidth = 600
CoD.AARTierRewardBackground_Rare.__defaultHeight = 600
CoD.AARTierRewardBackground_Rare.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardBackground_Rare)
	self.id = "AARTierRewardBackground_Rare"
	self.soundSet = "none"
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.85)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local CommonOuterGlow01 = LUI.UIImage.new(0, 1, -11, 11, 0, 1, -12, 12)
	CommonOuterGlow01:setImage(RegisterImage(0xAE13B63B2001396))
	CommonOuterGlow01:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	CommonOuterGlow01:setShaderVector(0, 0, 0, 0, 0)
	CommonOuterGlow01:setupNineSliceShader(32, 32)
	CommonOuterGlow01:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonOuterGlow01:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f2_local0))
		end
	end)
	self:addElement(CommonOuterGlow01)
	self.CommonOuterGlow01 = CommonOuterGlow01
	local RadialGlow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RadialGlow:setAlpha(0.12)
	RadialGlow:setImage(RegisterImage(0x74F13AE9F5148FE))
	RadialGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	RadialGlow:setShaderVector(0, 0.5, 0, 0, 0)
	RadialGlow:setShaderVector(1, 1, 2, 0, 0)
	RadialGlow:setShaderVector(2, 0, 0, 0, 0)
	RadialGlow:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RadialGlow:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f3_local0))
		end
	end)
	self:addElement(RadialGlow)
	self.RadialGlow = RadialGlow
	local BGBrighten = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBrighten:setAlpha(0.05)
	BGBrighten:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BGBrighten:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f4_local0))
		end
	end)
	self:addElement(BGBrighten)
	self.BGBrighten = BGBrighten
	local BottomGradient = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BottomGradient:setAlpha(0.15)
	BottomGradient:setZRot(180)
	BottomGradient:setImage(RegisterImage(0xB646BE73FB8838C))
	BottomGradient:linkToElementModel(self, "rarity", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			BottomGradient:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f5_local0))
		end
	end)
	self:addElement(BottomGradient)
	self.BottomGradient = BottomGradient
	local BGPatternThin = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGPatternThin:setAlpha(0.6)
	BGPatternThin:setImage(RegisterImage(0x817450E3AF39C23))
	BGPatternThin:setMaterial(LUI.UIImage.GetCachedMaterial(0xC221B51E4063E3D))
	BGPatternThin:setShaderVector(0, 0, 0, 0, 0)
	BGPatternThin:setShaderVector(1, 1, 1, 0, 0)
	BGPatternThin:setShaderVector(2, 0, 0, 0, 0)
	BGPatternThin:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			BGPatternThin:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f6_local0))
		end
	end)
	self:addElement(BGPatternThin)
	self.BGPatternThin = BGPatternThin
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardBackground_Rare.__onClose = function(f7_arg0)
	f7_arg0.CommonOuterGlow01:close()
	f7_arg0.RadialGlow:close()
	f7_arg0.BGBrighten:close()
	f7_arg0.BottomGradient:close()
	f7_arg0.BGPatternThin:close()
end
