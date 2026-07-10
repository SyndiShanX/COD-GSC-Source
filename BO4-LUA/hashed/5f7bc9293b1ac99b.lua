require("x64:266118fa96f77c8")
require("x64:3c21aa1a96202c9")
require("x64:4dd810316f738ee")
require("x64:68036bda8abbe94")
require("x64:d18f710d30d4ebf")
require("x64:7935bd4c2250126")
require("x64:3cc6addeefa5a0d")
require("x64:5f014b1ac7714f9")
require("x64:2cf29605adab948")
require("x64:19c1945d2e472b0")
CoD.ContractTall = InheritFrom(LUI.UIElement)
CoD.ContractTall.__defaultWidth = 236
CoD.ContractTall.__defaultHeight = 506
CoD.ContractTall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractTall)
	self.id = "ContractTall"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FeaturedImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -118, 118, 0, 0, 0, 506)
	FeaturedImage:setStretchedDimension(6)
	FeaturedImage:linkToElementModel(self, "inventoryIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FeaturedImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FeaturedImage)
	self.FeaturedImage = FeaturedImage
	local TextBacking = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -94, 0)
	TextBacking:setRGB(0, 0, 0)
	TextBacking:setAlpha(0.85)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 1, 1, -90.5, -3.5)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	DotTiledBacking.TiledShaderImage:setAlpha(0.5)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(32, 32)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 7.5, 28.5)
	ContractRarityHeaderBackground:setAlpha(0.7)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f3_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local ContractRarityHeaderTile = CoD.ContractRarityHeaderTile.new(f1_arg0, f1_arg1, 0, 0, 16.5, 216.5, 0, 0, 9.5, 26.5)
	ContractRarityHeaderTile.Contract:setAlpha(0)
	ContractRarityHeaderTile.Contract:setText(LocalizeToUpperString(0x0))
	ContractRarityHeaderTile:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeaderTile:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeaderTile)
	self.ContractRarityHeaderTile = ContractRarityHeaderTile
	local ContractCost = CoD.ContractItemCost.new(f1_arg0, f1_arg1, 0.5, 0.5, -92.5, 92.5, 1, 1, -31.5, -10.5)
	ContractCost.Free:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ContractCost.ContractCost:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ContractCost:linkToElementModel(self, nil, false, function(model)
		ContractCost:setModel(model, f1_arg1)
	end)
	self:addElement(ContractCost)
	self.ContractCost = ContractCost
	local ProgressBarBacking = CoD.ContractProgressBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -110.5, 93.5, 0, 0, 454.5, 466.5)
	ProgressBarBacking:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "complete")
			end,
		},
		{
			stateName = "HideProgress",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased")
			end,
		},
	})
	ProgressBarBacking:linkToElementModel(ProgressBarBacking, "complete", true, function(model)
		f1_arg0:updateElementState(ProgressBarBacking, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	ProgressBarBacking:linkToElementModel(ProgressBarBacking, "purchased", true, function(model)
		f1_arg0:updateElementState(ProgressBarBacking, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	ProgressBarBacking:linkToElementModel(self, nil, false, function(model)
		ProgressBarBacking:setModel(model, f1_arg1)
	end)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local TotalTierCount = LUI.UIText.new(0.5, 0.5, -110.5, -52.5, 0, 0, 455, 473)
	TotalTierCount:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TotalTierCount:setAlpha(0)
	TotalTierCount:setTTF("ttmussels_regular")
	TotalTierCount:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	TotalTierCount:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	TotalTierCount:linkToElementModel(self, "totalRewardCount", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			TotalTierCount:setText(LocalizeIntoString(0x36DDA38F04CEAF, f11_local0))
		end
	end)
	self:addElement(TotalTierCount)
	self.TotalTierCount = TotalTierCount
	local ActiveBanner = CoD.ContractActiveBanner.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 1, 1, -33.5, -8.5)
	ActiveBanner.ActiveTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ActiveBanner:linkToElementModel(self, nil, false, function(model)
		ActiveBanner:setModel(model, f1_arg1)
	end)
	self:addElement(ActiveBanner)
	self.ActiveBanner = ActiveBanner
	local ContractTallSeasonalOverlay = CoD.ContractTallSeasonalOverlay.new(f1_arg0, f1_arg1, 0, 0, 0, 236, 0, 0, 0, 506)
	ContractTallSeasonalOverlay:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "seasonal")
			end,
		},
	})
	ContractTallSeasonalOverlay:linkToElementModel(ContractTallSeasonalOverlay, "seasonal", true, function(model)
		f1_arg0:updateElementState(ContractTallSeasonalOverlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "seasonal",
		})
	end)
	self:addElement(ContractTallSeasonalOverlay)
	self.ContractTallSeasonalOverlay = ContractTallSeasonalOverlay
	local TabBottomLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -96, -92)
	TabBottomLine:setAlpha(0.09)
	TabBottomLine:setImage(RegisterImage(0x5526CF3733E24C4))
	TabBottomLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	local TierBoost = CoD.ItemShopTierBoost.new(f1_arg0, f1_arg1, 0, 0, 36.5, 247.5, 0, 0, 376, 402)
	TierBoost:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.ShowSpecialOrderBoostPercent(f1_arg1, menu)
			end,
		},
	})
	local PurchasedBanner = TierBoost
	local Darken = TierBoost.subscribeToModel
	local CompeletedBanner = Engine[0x4DF5CFBC1771947](f1_arg1)
	Darken(PurchasedBanner, CompeletedBanner["LootStreamProgress.personalTierBoost"], function(f16_arg0)
		f1_arg0:updateElementState(TierBoost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LootStreamProgress.personalTierBoost",
		})
	end, false)
	TierBoost:linkToElementModel(self, nil, false, function(model)
		TierBoost:setModel(model, f1_arg1)
	end)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	Darken = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	PurchasedBanner = CoD.ContractPurchasedBanner.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 1, 1, -33.5, -8.5)
	PurchasedBanner:setAlpha(0)
	PurchasedBanner.PurchasedTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(PurchasedBanner)
	self.PurchasedBanner = PurchasedBanner
	CompeletedBanner = CoD.ContractCompleteBanner.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 1, 1, -33.5, -8.5)
	CompeletedBanner:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	CompeletedBanner:setAlpha(0)
	CompeletedBanner.CompeletedBanner:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(CompeletedBanner)
	self.CompeletedBanner = CompeletedBanner
	local ThemeName = CoD.ContractTallDescContainer.new(f1_arg0, f1_arg1, 0, 0, 9, 227, 0, 0, 416, 466)
	ThemeName:linkToElementModel(self, nil, false, function(model)
		ThemeName:setModel(model, f1_arg1)
	end)
	self:addElement(ThemeName)
	self.ThemeName = ThemeName
	self.ContractTallSeasonalOverlay:linkToElementModel(self, nil, false, function(model)
		ContractTallSeasonalOverlay:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRACT)
			end,
		},
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "storePreview")
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "complete")
			end,
		},
		{
			stateName = "Owned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased")
			end,
		},
	})
	self:linkToElementModel(self, "lootType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lootType",
		})
	end)
	self:linkToElementModel(self, "purchased", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
		})
	end)
	self:linkToElementModel(self, "storePreview", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "storePreview",
		})
	end)
	self:linkToElementModel(self, "complete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "complete",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractTall.__resetProperties = function(f29_arg0)
	f29_arg0.ContractCost:completeAnimation()
	f29_arg0.ActiveBanner:completeAnimation()
	f29_arg0.ProgressBarBacking:completeAnimation()
	f29_arg0.TotalTierCount:completeAnimation()
	f29_arg0.ContractTallSeasonalOverlay:completeAnimation()
	f29_arg0.ContractRarityHeaderTile:completeAnimation()
	f29_arg0.ContractRarityHeaderBackground:completeAnimation()
	f29_arg0.FeaturedImage:completeAnimation()
	f29_arg0.DotTiledBacking:completeAnimation()
	f29_arg0.TextBacking:completeAnimation()
	f29_arg0.TabBottomLine:completeAnimation()
	f29_arg0.TierBoost:completeAnimation()
	f29_arg0.ThemeName:completeAnimation()
	f29_arg0.Darken:completeAnimation()
	f29_arg0.PurchasedBanner:completeAnimation()
	f29_arg0.CompeletedBanner:completeAnimation()
	f29_arg0.ContractCost:setAlpha(1)
	f29_arg0.ActiveBanner:setAlpha(1)
	f29_arg0.ProgressBarBacking:setAlpha(1)
	f29_arg0.TotalTierCount:setAlpha(0)
	f29_arg0.ContractTallSeasonalOverlay:setAlpha(1)
	f29_arg0.ContractRarityHeaderTile:setAlpha(1)
	f29_arg0.ContractRarityHeaderBackground:setAlpha(0.7)
	f29_arg0.FeaturedImage:setAlpha(1)
	f29_arg0.DotTiledBacking:setAlpha(0.5)
	f29_arg0.TextBacking:setAlpha(0.85)
	f29_arg0.TabBottomLine:setAlpha(0.09)
	f29_arg0.TierBoost:setAlpha(1)
	f29_arg0.ThemeName:setAlpha(1)
	f29_arg0.Darken:setAlpha(0)
	f29_arg0.PurchasedBanner:setAlpha(0)
	f29_arg0.CompeletedBanner:setAlpha(0)
end
CoD.ContractTall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(4)
			f30_arg0.ContractCost:completeAnimation()
			f30_arg0.ContractCost:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.ContractCost)
			f30_arg0.ProgressBarBacking:completeAnimation()
			f30_arg0.ProgressBarBacking:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.ProgressBarBacking)
			f30_arg0.TotalTierCount:completeAnimation()
			f30_arg0.TotalTierCount:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TotalTierCount)
			f30_arg0.ActiveBanner:completeAnimation()
			f30_arg0.ActiveBanner:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ActiveBanner)
		end,
	},
	Hidden = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(12)
			f31_arg0.FeaturedImage:completeAnimation()
			f31_arg0.FeaturedImage:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.FeaturedImage)
			f31_arg0.TextBacking:completeAnimation()
			f31_arg0.TextBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TextBacking)
			f31_arg0.DotTiledBacking:completeAnimation()
			f31_arg0.DotTiledBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.DotTiledBacking)
			f31_arg0.ContractRarityHeaderBackground:completeAnimation()
			f31_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ContractRarityHeaderBackground)
			f31_arg0.ContractRarityHeaderTile:completeAnimation()
			f31_arg0.ContractRarityHeaderTile:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ContractRarityHeaderTile)
			f31_arg0.ContractCost:completeAnimation()
			f31_arg0.ContractCost:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ContractCost)
			f31_arg0.ProgressBarBacking:completeAnimation()
			f31_arg0.ProgressBarBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ProgressBarBacking)
			f31_arg0.ActiveBanner:completeAnimation()
			f31_arg0.ActiveBanner:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ActiveBanner)
			f31_arg0.ContractTallSeasonalOverlay:completeAnimation()
			f31_arg0.ContractTallSeasonalOverlay:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ContractTallSeasonalOverlay)
			f31_arg0.TabBottomLine:completeAnimation()
			f31_arg0.TabBottomLine:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TabBottomLine)
			f31_arg0.TierBoost:completeAnimation()
			f31_arg0.TierBoost:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TierBoost)
			f31_arg0.ThemeName:completeAnimation()
			f31_arg0.ThemeName:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ThemeName)
		end,
	},
	Purchased = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(6)
			f32_arg0.ContractCost:completeAnimation()
			f32_arg0.ContractCost:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ContractCost)
			f32_arg0.ProgressBarBacking:completeAnimation()
			f32_arg0.ProgressBarBacking:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ProgressBarBacking)
			f32_arg0.ActiveBanner:completeAnimation()
			f32_arg0.ActiveBanner:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ActiveBanner)
			f32_arg0.TierBoost:completeAnimation()
			f32_arg0.TierBoost:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.TierBoost)
			f32_arg0.Darken:completeAnimation()
			f32_arg0.Darken:setAlpha(0.88)
			f32_arg0.clipFinished(f32_arg0.Darken)
			f32_arg0.PurchasedBanner:completeAnimation()
			f32_arg0.PurchasedBanner:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.PurchasedBanner)
		end,
	},
	Completed = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(6)
			f33_arg0.ContractCost:completeAnimation()
			f33_arg0.ContractCost:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ContractCost)
			f33_arg0.ProgressBarBacking:completeAnimation()
			f33_arg0.ProgressBarBacking:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ProgressBarBacking)
			f33_arg0.ActiveBanner:completeAnimation()
			f33_arg0.ActiveBanner:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ActiveBanner)
			f33_arg0.TierBoost:completeAnimation()
			f33_arg0.TierBoost:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.TierBoost)
			f33_arg0.Darken:completeAnimation()
			f33_arg0.Darken:setAlpha(0.88)
			f33_arg0.clipFinished(f33_arg0.Darken)
			f33_arg0.CompeletedBanner:completeAnimation()
			f33_arg0.CompeletedBanner:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.CompeletedBanner)
		end,
	},
	Owned = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.ContractCost:completeAnimation()
			f34_arg0.ContractCost:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.ContractCost)
			f34_arg0.TierBoost:completeAnimation()
			f34_arg0.TierBoost:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.TierBoost)
		end,
	},
}
CoD.ContractTall.__onClose = function(f35_arg0)
	f35_arg0.FeaturedImage:close()
	f35_arg0.DotTiledBacking:close()
	f35_arg0.ContractRarityHeaderBackground:close()
	f35_arg0.ContractRarityHeaderTile:close()
	f35_arg0.ContractCost:close()
	f35_arg0.ProgressBarBacking:close()
	f35_arg0.TotalTierCount:close()
	f35_arg0.ActiveBanner:close()
	f35_arg0.ContractTallSeasonalOverlay:close()
	f35_arg0.TierBoost:close()
	f35_arg0.PurchasedBanner:close()
	f35_arg0.CompeletedBanner:close()
	f35_arg0.ThemeName:close()
end
