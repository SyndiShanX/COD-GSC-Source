require("x64:4dd810316f738ee")
require("x64:7935bd4c2250126")
require("x64:fd740505876fd7b")
require("x64:820f134c35294b3")
require("x64:e3a32b824c5e06")
require("x64:19c1945d2e472b0")
CoD.ShopReserveItemTall = InheritFrom(LUI.UIElement)
CoD.ShopReserveItemTall.__defaultWidth = 236
CoD.ShopReserveItemTall.__defaultHeight = 506
CoD.ShopReserveItemTall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ShopReserveItemTall)
	self.id = "ShopReserveItemTall"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RarityBacking = CoD.ShopReserveItemRarityBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 236, 0, 0, 0, 506)
	RarityBacking:linkToElementModel(self, nil, false, function(model)
		RarityBacking:setModel(model, f1_arg1)
	end)
	self:addElement(RarityBacking)
	self.RarityBacking = RarityBacking
	local TextBacking = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -94, 0)
	TextBacking:setRGB(0, 0, 0)
	TextBacking:setAlpha(0.85)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 1, 1, -91, -4)
	DotTiledBacking:setAlpha(0.5)
	DotTiledBacking.NoiseBacking:setAlpha(0)
	DotTiledBacking.TiledShaderImage:setAlpha(0.5)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(32, 32)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local ContractCost = CoD.ContractItemCost.new(f1_arg0, f1_arg1, 0.5, 0.5, -92.5, 92.5, 1, 1, -31.5, -10.5)
	ContractCost.Free:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ContractCost.ContractCost:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ContractCost:linkToElementModel(self, nil, false, function(model)
		ContractCost:setModel(model, f1_arg1)
	end)
	self:addElement(ContractCost)
	self.ContractCost = ContractCost
	local TabBottomLine = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -96, -92)
	TabBottomLine:setAlpha(0.09)
	TabBottomLine:setImage(RegisterImage(0x5526CF3733E24C4))
	TabBottomLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	local Darken = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	local shopCategory = CoD.ShopReserveItemTallDescContainer.new(f1_arg0, f1_arg1, 0, 0, 9, 227, 0, 0, 415, 469)
	shopCategory:linkToElementModel(self, nil, false, function(model)
		shopCategory:setModel(model, f1_arg1)
	end)
	self:addElement(shopCategory)
	self.shopCategory = shopCategory
	local FeaturedImage = CoD.ReservesContentImage.new(f1_arg0, f1_arg1, 0, 0, -28, 264, 0, 0, -20, 331)
	FeaturedImage:setScale(0.6, 0.6)
	FeaturedImage:linkToElementModel(self, nil, false, function(model)
		FeaturedImage:setModel(model, f1_arg1)
	end)
	self:addElement(FeaturedImage)
	self.FeaturedImage = FeaturedImage
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 7.5, 28.5)
	ContractRarityHeaderBackground:setAlpha(0.7)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f6_local0))
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
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f8_local0 = IsBooleanDvarSet("loot_sunsetBlackjackShopActive")
				if f8_local0 then
					f8_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRABAND)
					if f8_local0 then
						f8_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isInItemShop")
					end
				end
				return f8_local0
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
	self:linkToElementModel(self, "isInItemShop", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isInItemShop",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ShopReserveItemTall.__resetProperties = function(f11_arg0)
	f11_arg0.TabBottomLine:completeAnimation()
	f11_arg0.ContractCost:completeAnimation()
	f11_arg0.DotTiledBacking:completeAnimation()
	f11_arg0.TextBacking:completeAnimation()
	f11_arg0.shopCategory:completeAnimation()
	f11_arg0.FeaturedImage:completeAnimation()
	f11_arg0.RarityBacking:completeAnimation()
	f11_arg0.ContractRarityHeaderTile:completeAnimation()
	f11_arg0.ContractRarityHeaderBackground:completeAnimation()
	f11_arg0.TabBottomLine:setAlpha(0.09)
	f11_arg0.ContractCost:setAlpha(1)
	f11_arg0.DotTiledBacking:setAlpha(0.5)
	f11_arg0.TextBacking:setAlpha(0.85)
	f11_arg0.shopCategory:setAlpha(1)
	f11_arg0.FeaturedImage:setAlpha(1)
	f11_arg0.RarityBacking:setAlpha(1)
	f11_arg0.ContractRarityHeaderTile:setAlpha(1)
	f11_arg0.ContractRarityHeaderBackground:setAlpha(0.7)
end
CoD.ShopReserveItemTall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(9)
			f12_arg0.RarityBacking:completeAnimation()
			f12_arg0.RarityBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RarityBacking)
			f12_arg0.TextBacking:completeAnimation()
			f12_arg0.TextBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TextBacking)
			f12_arg0.DotTiledBacking:completeAnimation()
			f12_arg0.DotTiledBacking:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DotTiledBacking)
			f12_arg0.ContractCost:completeAnimation()
			f12_arg0.ContractCost:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ContractCost)
			f12_arg0.TabBottomLine:completeAnimation()
			f12_arg0.TabBottomLine:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TabBottomLine)
			f12_arg0.shopCategory:completeAnimation()
			f12_arg0.shopCategory:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.shopCategory)
			f12_arg0.FeaturedImage:completeAnimation()
			f12_arg0.FeaturedImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.FeaturedImage)
			f12_arg0.ContractRarityHeaderBackground:completeAnimation()
			f12_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ContractRarityHeaderBackground)
			f12_arg0.ContractRarityHeaderTile:completeAnimation()
			f12_arg0.ContractRarityHeaderTile:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ContractRarityHeaderTile)
		end,
	},
	Visible = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.ContractRarityHeaderBackground:completeAnimation()
			f13_arg0.ContractRarityHeaderBackground:setAlpha(0.7)
			f13_arg0.clipFinished(f13_arg0.ContractRarityHeaderBackground)
			f13_arg0.ContractRarityHeaderTile:completeAnimation()
			f13_arg0.ContractRarityHeaderTile:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.ContractRarityHeaderTile)
		end,
	},
}
CoD.ShopReserveItemTall.__onClose = function(f14_arg0)
	f14_arg0.RarityBacking:close()
	f14_arg0.DotTiledBacking:close()
	f14_arg0.ContractCost:close()
	f14_arg0.shopCategory:close()
	f14_arg0.FeaturedImage:close()
	f14_arg0.ContractRarityHeaderBackground:close()
	f14_arg0.ContractRarityHeaderTile:close()
end
