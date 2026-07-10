require("x64:4dd810316f738ee")
require("x64:d18f710d30d4ebf")
require("x64:7935bd4c2250126")
require("x64:a88a37ef6ee1162")
require("x64:19c1945d2e472b0")
CoD.ShopItemTall = InheritFrom(LUI.UIElement)
CoD.ShopItemTall.__defaultWidth = 236
CoD.ShopItemTall.__defaultHeight = 506
CoD.ShopItemTall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ShopItemTall)
	self.id = "ShopItemTall"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ImageBacking = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	ImageBacking:setImage(RegisterImage(@"hash_765F59B19E1CE1C7"))
	self:addElement(ImageBacking)
	self.ImageBacking = ImageBacking
	local FeaturedImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -118, 118, 0, 0, 0, 506)
	FeaturedImage:setStretchedDimension(6)
	FeaturedImage:linkToElementModel(self, "primaryImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FeaturedImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(FeaturedImage)
	self.FeaturedImage = FeaturedImage
	local TextBacking = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -94, 0)
	TextBacking:setRGB(0, 0, 0)
	TextBacking:setAlpha(0.95)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 1, 1, -91, -4)
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
	ContractCost.Free:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ContractCost.ContractCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ContractCost:linkToElementModel(self, nil, false, function(model)
		ContractCost:setModel(model, f1_arg1)
	end)
	self:addElement(ContractCost)
	self.ContractCost = ContractCost
	local TabBottomLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -96, -92)
	TabBottomLine:setAlpha(0.09)
	TabBottomLine:setImage(RegisterImage(@"uie_ui_menu_common_tab_line_bottom"))
	TabBottomLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	local Darken = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local PurchasedBanner = CoD.ContractPurchasedBanner.new(f1_arg0, f1_arg1, 0.5, 0.5, -75, 75, 1, 1, -33.5, -8.5)
	PurchasedBanner:setAlpha(0)
	PurchasedBanner.PurchasedTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(PurchasedBanner)
	self.PurchasedBanner = PurchasedBanner
	local shopCategory = CoD.ShopItemTallDescContainer.new(f1_arg0, f1_arg1, 0, 0, 9, 227, 0, 0, 415, 452)
	shopCategory:linkToElementModel(self, nil, false, function(model)
		shopCategory:setModel(model, f1_arg1)
	end)
	self:addElement(shopCategory)
	self.shopCategory = shopCategory
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.ITEMSHOP)
			end,
		},
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "storePreview")
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ShopItemTall.__resetProperties = function(f13_arg0)
	f13_arg0.FeaturedImage:completeAnimation()
	f13_arg0.ContractRarityHeaderBackground:completeAnimation()
	f13_arg0.ContractRarityHeaderTile:completeAnimation()
	f13_arg0.ContractCost:completeAnimation()
	f13_arg0.TextBacking:completeAnimation()
	f13_arg0.DotTiledBacking:completeAnimation()
	f13_arg0.TabBottomLine:completeAnimation()
	f13_arg0.shopCategory:completeAnimation()
	f13_arg0.ImageBacking:completeAnimation()
	f13_arg0.Darken:completeAnimation()
	f13_arg0.PurchasedBanner:completeAnimation()
	f13_arg0.FeaturedImage:setAlpha(1)
	f13_arg0.ContractRarityHeaderBackground:setAlpha(0.7)
	f13_arg0.ContractRarityHeaderTile:setAlpha(1)
	f13_arg0.ContractCost:setAlpha(1)
	f13_arg0.TextBacking:setAlpha(0.95)
	f13_arg0.DotTiledBacking:setAlpha(0.5)
	f13_arg0.TabBottomLine:setAlpha(0.09)
	f13_arg0.shopCategory:setAlpha(1)
	f13_arg0.ImageBacking:setAlpha(1)
	f13_arg0.Darken:setAlpha(0)
	f13_arg0.PurchasedBanner:setAlpha(0)
end
CoD.ShopItemTall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(9)
			f15_arg0.ImageBacking:completeAnimation()
			f15_arg0.ImageBacking:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ImageBacking)
			f15_arg0.FeaturedImage:completeAnimation()
			f15_arg0.FeaturedImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.FeaturedImage)
			f15_arg0.TextBacking:completeAnimation()
			f15_arg0.TextBacking:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TextBacking)
			f15_arg0.DotTiledBacking:completeAnimation()
			f15_arg0.DotTiledBacking:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DotTiledBacking)
			f15_arg0.ContractRarityHeaderBackground:completeAnimation()
			f15_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ContractRarityHeaderBackground)
			f15_arg0.ContractRarityHeaderTile:completeAnimation()
			f15_arg0.ContractRarityHeaderTile:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ContractRarityHeaderTile)
			f15_arg0.ContractCost:completeAnimation()
			f15_arg0.ContractCost:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ContractCost)
			f15_arg0.TabBottomLine:completeAnimation()
			f15_arg0.TabBottomLine:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TabBottomLine)
			f15_arg0.shopCategory:completeAnimation()
			f15_arg0.shopCategory:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.shopCategory)
		end,
	},
	Purchased = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.ContractCost:completeAnimation()
			f16_arg0.ContractCost:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ContractCost)
			f16_arg0.Darken:completeAnimation()
			f16_arg0.Darken:setAlpha(0.7)
			f16_arg0.clipFinished(f16_arg0.Darken)
			f16_arg0.PurchasedBanner:completeAnimation()
			f16_arg0.PurchasedBanner:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.PurchasedBanner)
		end,
	},
	Owned = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.ContractCost:completeAnimation()
			f17_arg0.ContractCost:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ContractCost)
		end,
	},
}
CoD.ShopItemTall.__onClose = function(f18_arg0)
	f18_arg0.FeaturedImage:close()
	f18_arg0.DotTiledBacking:close()
	f18_arg0.ContractRarityHeaderBackground:close()
	f18_arg0.ContractRarityHeaderTile:close()
	f18_arg0.ContractCost:close()
	f18_arg0.PurchasedBanner:close()
	f18_arg0.shopCategory:close()
end
