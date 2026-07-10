CoD.LaboratoryElixirRarityLabel = InheritFrom(LUI.UIElement)
CoD.LaboratoryElixirRarityLabel.__defaultWidth = 400
CoD.LaboratoryElixirRarityLabel.__defaultHeight = 30
CoD.LaboratoryElixirRarityLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryElixirRarityLabel)
	self.id = "LaboratoryElixirRarityLabel"
	self.soundSet = "default"
	local rarityBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	rarityBackground:setAlpha(0.7)
	rarityBackground:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_smoke"))
	rarityBackground:setShaderVector(0, 0.4, 0, 0, 0)
	rarityBackground:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			rarityBackground:setRGB(CoD.ZMLaboratoryUtility.GetColorSetForIndex(f2_local0))
		end
	end)
	self:addElement(rarityBackground)
	self.rarityBackground = rarityBackground
	local Smoke = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 30)
	Smoke:setImage(RegisterImage(@"uie_zm_hud_inventory_objectivesmoke"))
	Smoke:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_C221B51E4063E3D"))
	Smoke:setShaderVector(0, 0, 0.35, 0, 0)
	Smoke:setShaderVector(1, 1, 1, 0, 0)
	Smoke:setShaderVector(2, 0, 0, 0, 0)
	Smoke:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Smoke:setRGB(CoD.ZMLaboratoryUtility.GetColorSetForIndex(f3_local0))
		end
	end)
	self:addElement(Smoke)
	self.Smoke = Smoke
	local Glow = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 30)
	Glow:setImage(RegisterImage(@"hash_2878403A52310930"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_C221B51E4063E3D"))
	Glow:setShaderVector(0, 0, 0.39, 0, 0)
	Glow:setShaderVector(1, 1, 1, 0, 0)
	Glow:setShaderVector(2, 0, 0, 0, 0)
	Glow:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Glow:setRGB(CoD.ZMLaboratoryUtility.GetColorSetForIndex(f4_local0))
		end
	end)
	self:addElement(Glow)
	self.Glow = Glow
	local GlowCore = LUI.UIImage.new(0.3, 0.7, 0, 0, 1, 1, -30, 0)
	GlowCore:setZRot(180)
	GlowCore:setImage(RegisterImage(@"hash_5A9B7395EF61B994"))
	GlowCore:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowCore:setShaderVector(0, 3.15, 0, 0, 0)
	GlowCore:linkToElementModel(self, "rarity", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GlowCore:setRGB(CoD.ZMLaboratoryUtility.GetColorSetForIndex(f5_local0))
		end
	end)
	self:addElement(GlowCore)
	self.GlowCore = GlowCore
	local rarity = LUI.UIText.new(0.5, 0.5, -200, 200, 0.5, 0.5, -10, 15)
	rarity:setRGB(ColorSet.T8_FactionTier_Completed.r, ColorSet.T8_FactionTier_Completed.g, ColorSet.T8_FactionTier_Completed.b)
	rarity:setTTF("skorzhen")
	rarity:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	rarity:setShaderVector(0, 0.05, 0, 0, 0)
	rarity:setShaderVector(1, 0.05, 0, 0, 0)
	rarity:setShaderVector(2, 1, 0, 0, 0)
	rarity:setLetterSpacing(1)
	rarity:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	rarity:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	rarity:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			rarity:setText(LocalizeToUpperString(CoD.ZMLaboratoryUtility.GetRarityStringForIndex(f6_local0)))
		end
	end)
	self:addElement(rarity)
	self.rarity = rarity
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryElixirRarityLabel.__onClose = function(f7_arg0)
	f7_arg0.rarityBackground:close()
	f7_arg0.Smoke:close()
	f7_arg0.Glow:close()
	f7_arg0.GlowCore:close()
	f7_arg0.rarity:close()
end
