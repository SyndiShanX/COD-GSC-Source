CoD.AARTierRewardBackground_Epic = InheritFrom(LUI.UIElement)
CoD.AARTierRewardBackground_Epic.__defaultWidth = 600
CoD.AARTierRewardBackground_Epic.__defaultHeight = 600
CoD.AARTierRewardBackground_Epic.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARTierRewardBackground_Epic)
	self.id = "AARTierRewardBackground_Epic"
	self.soundSet = "none"
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, -0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.85)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local CommonOuterGlow01 = LUI.UIImage.new(0, 1, -11, 11, 0, 1, -12, 12)
	CommonOuterGlow01:setImage(RegisterImage(@"uie_ui_menu_common_outer_glow01"))
	CommonOuterGlow01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
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
	local BGBrighten = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBrighten:setAlpha(0.5)
	BGBrighten:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BGBrighten:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f3_local0))
		end
	end)
	self:addElement(BGBrighten)
	self.BGBrighten = BGBrighten
	local RadialGlow = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RadialGlow:setAlpha(0.5)
	RadialGlow:setImage(RegisterImage(@"uie_ui_menu_common_radial_glow01"))
	RadialGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	RadialGlow:setShaderVector(0, 0.5, 0, 0, 0)
	RadialGlow:setShaderVector(1, 1, 2, 0, 0)
	RadialGlow:setShaderVector(2, 0, 0, 0, 0)
	RadialGlow:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RadialGlow:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f4_local0))
		end
	end)
	self:addElement(RadialGlow)
	self.RadialGlow = RadialGlow
	local RadialGlow2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	RadialGlow2:setAlpha(0.4)
	RadialGlow2:setImage(RegisterImage(@"uie_ui_menu_common_radial_glow01"))
	RadialGlow2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_1A02C44161370F6D"))
	RadialGlow2:setShaderVector(0, 0.5, 0, 0, 0)
	RadialGlow2:setShaderVector(1, 1, 2, 0, 0)
	RadialGlow2:setShaderVector(2, 0, 0, 0, 0)
	RadialGlow2:linkToElementModel(self, "rarity", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RadialGlow2:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f5_local0))
		end
	end)
	self:addElement(RadialGlow2)
	self.RadialGlow2 = RadialGlow2
	local BottomGradient = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BottomGradient:setAlpha(0.15)
	BottomGradient:setZRot(180)
	BottomGradient:setImage(RegisterImage(@"uie_ui_menu_common_gradient"))
	self:addElement(BottomGradient)
	self.BottomGradient = BottomGradient
	local BGPatternThin = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGPatternThin:setAlpha(0.2)
	BGPatternThin:setImage(RegisterImage(@"uie_ui_menu_common_mtx_button_bg_epic_thin"))
	BGPatternThin:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_C221B51E4063E3D"))
	BGPatternThin:setShaderVector(0, 0, 0, 0, 0)
	BGPatternThin:setShaderVector(1, 1, 1, 0, 0)
	BGPatternThin:setShaderVector(2, 0, 0, 0, 0)
	BGPatternThin:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			BGPatternThin:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f6_local0))
		end
	end)
	self:addElement(BGPatternThin)
	self.BGPatternThin = BGPatternThin
	self.BottomGradient:linkToElementModel(self, "rarity", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			BottomGradient:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f7_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARTierRewardBackground_Epic.__onClose = function(f8_arg0)
	f8_arg0.CommonOuterGlow01:close()
	f8_arg0.BGBrighten:close()
	f8_arg0.RadialGlow:close()
	f8_arg0.RadialGlow2:close()
	f8_arg0.BottomGradient:close()
	f8_arg0.BGPatternThin:close()
end
