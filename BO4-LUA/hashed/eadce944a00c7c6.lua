require("x64:5f8cf56752aa71b")
require("x64:266118fa96f77c8")
require("x64:3c21aa1a96202c9")
require("x64:a52bba85c50cc57")
require("x64:4dd810316f738ee")
require("x64:68036bda8abbe94")
require("x64:d18f710d30d4ebf")
require("x64:7935bd4c2250126")
require("x64:f285538eb3b9640")
CoD.ContractItemInternal = InheritFrom(LUI.UIElement)
CoD.ContractItemInternal.__defaultWidth = 418
CoD.ContractItemInternal.__defaultHeight = 189
CoD.ContractItemInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractItemInternal)
	self.id = "ContractItemInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = CoD.ContractItemBacker.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Backer:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Backer:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f2_local0))
		end
	end)
	self:addElement(Backer)
	self.Backer = Backer
	local Desat = LUI.UIImage.new(0, 0, 1, 417, 0, 0, 1, 188)
	Desat:setRGB(0.27, 0.27, 0.27)
	Desat:setAlpha(0.24)
	self:addElement(Desat)
	self.Desat = Desat
	local ContractRarityBar = LUI.UIImage.new(0, 0, -6, -1, 0.5, 0.5, -79, 79)
	ContractRarityBar:setAlpha(0)
	ContractRarityBar:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContractRarityBar:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f3_local0))
		end
	end)
	self:addElement(ContractRarityBar)
	self.ContractRarityBar = ContractRarityBar
	local LED2 = LUI.UIImage.new(0, 1, 3, -1, 0, 1, 3, -1)
	LED2:setRGB(0, 0, 0)
	LED2:setImage(RegisterImage(0x4B6FFA90272070E))
	LED2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	LED2:setShaderVector(0, 0, 0, 0, 0)
	LED2:setupNineSliceShader(24, 24)
	self:addElement(LED2)
	self.LED2 = LED2
	local ContractIcon = LUI.UIImage.new(0, 0, 1, 417, 0, 0, 1, 187)
	ContractIcon:linkToElementModel(self, "icon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ContractIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(ContractIcon)
	self.ContractIcon = ContractIcon
	local TileDots = LUI.UIImage.new(0, 0, 1, 417, 0, 0, 125, 189)
	TileDots:setAlpha(0)
	TileDots:setImage(RegisterImage(0x3C8D2DBD72EBF38))
	TileDots:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TileDots:setShaderVector(0, 0, 0, 0, 0)
	TileDots:setupNineSliceShader(12, 12)
	TileDots:linkToElementModel(self, "rarity", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TileDots:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f5_local0))
		end
	end)
	self:addElement(TileDots)
	self.TileDots = TileDots
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 0, 1, 401, 0, 0, 10.5, 31.5)
	ContractRarityHeaderBackground:setAlpha(0.96)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f6_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 1, 401, 0, 0, 12.5, 29.5)
	PixelGridTiledBacking:setAlpha(0.05)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local SpecialistName = LUI.UIText.new(0, 0, 15, 403, 0, 0, 107, 121)
	SpecialistName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SpecialistName:setAlpha(0.8)
	SpecialistName:setTTF("default")
	SpecialistName:setMaterial(LUI.UIImage.GetCachedMaterial(0x336C1AE82B1520A))
	SpecialistName:setLetterSpacing(2)
	SpecialistName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SpecialistName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SpecialistName:linkToElementModel(self, "relatedItemName", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			SpecialistName:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local ThemeName = LUI.UIText.new(0, 0, 15, 403, 0, 0, 83, 97)
	ThemeName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ThemeName:setTTF("ttmussels_regular")
	ThemeName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ThemeName:setShaderVector(0, 1, 0, 0, 0)
	ThemeName:setShaderVector(1, 0, 0, 0, 0)
	ThemeName:setShaderVector(2, 0, 0, 0, 0.6)
	ThemeName:setLetterSpacing(2)
	ThemeName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ThemeName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	ThemeName:linkToElementModel(self, "mainExtraText", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ThemeName:setText(ToUpper(f8_local0))
		end
	end)
	self:addElement(ThemeName)
	self.ThemeName = ThemeName
	local OutfitName = LUI.UIText.new(0, 0, 14, 400, 0, 0, 47, 73)
	OutfitName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OutfitName:setTTF("ttmussels_demibold")
	OutfitName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	OutfitName:setShaderVector(0, 1, 0, 0, 0)
	OutfitName:setShaderVector(1, 0, 0, 0, 0)
	OutfitName:setShaderVector(2, 0, 0, 0, 0.6)
	OutfitName:setLetterSpacing(3)
	OutfitName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OutfitName:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	OutfitName:linkToElementModel(self, "name", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			OutfitName:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	self:addElement(OutfitName)
	self.OutfitName = OutfitName
	local ActiveBanner = CoD.ContractActiveBanner.new(f1_arg0, f1_arg1, 0, 0, 22, 172, 0, 0, 132, 157)
	ActiveBanner:linkToElementModel(self, nil, false, function(model)
		ActiveBanner:setModel(model, f1_arg1)
	end)
	self:addElement(ActiveBanner)
	self.ActiveBanner = ActiveBanner
	local ProgressBarBacking = CoD.ContractProgressBar.new(f1_arg0, f1_arg1, 0, 0, 15, 359, 0, 0, 164.5, 182.5)
	ProgressBarBacking:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "complete")
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
	ProgressBarBacking:linkToElementModel(self, nil, false, function(model)
		ProgressBarBacking:setModel(model, f1_arg1)
	end)
	self:addElement(ProgressBarBacking)
	self.ProgressBarBacking = ProgressBarBacking
	local ContractRarityHeaderTile = CoD.ContractRarityHeaderTile.new(f1_arg0, f1_arg1, 0, 0, 15, 215, 0, 0, 12.5, 29.5)
	ContractRarityHeaderTile.Contract:setText(LocalizeToUpperString(0x0))
	ContractRarityHeaderTile:linkToElementModel(self, nil, false, function(model)
		ContractRarityHeaderTile:setModel(model, f1_arg1)
	end)
	self:addElement(ContractRarityHeaderTile)
	self.ContractRarityHeaderTile = ContractRarityHeaderTile
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0, 1, 0, 0)
	CommonButtonOutline:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Purchased")
			end,
		},
	})
	local PurchasedBanner = CommonButtonOutline
	local Darken = CommonButtonOutline.subscribeToModel
	local CompeletedBanner = Engine[0x8DF2E5447F384B9]()
	Darken(PurchasedBanner, CompeletedBanner["lobbyRoot.lobbyNav"], function(f16_arg0)
		f1_arg0:updateElementState(CommonButtonOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CommonButtonOutline.Lines:setAlpha(0)
	CommonButtonOutline:linkToElementModel(self, nil, false, function(model)
		CommonButtonOutline:setModel(model, f1_arg1)
	end)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	Darken = LUI.UIImage.new(0, 0, 1, 417, 0, 0, 1, 187)
	Darken:setRGB(0.09, 0.09, 0.09)
	Darken:setAlpha(0)
	self:addElement(Darken)
	self.Darken = Darken
	PurchasedBanner = CoD.ContractPurchasedBanner.new(f1_arg0, f1_arg1, 0, 0, 22, 172, 0, 0, 154, 179)
	PurchasedBanner:setAlpha(0)
	self:addElement(PurchasedBanner)
	self.PurchasedBanner = PurchasedBanner
	CompeletedBanner = CoD.ContractCompleteBanner.new(f1_arg0, f1_arg1, 0, 0, 22, 172, 0, 0, 154, 179)
	CompeletedBanner:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	CompeletedBanner:setAlpha(0)
	self:addElement(CompeletedBanner)
	self.CompeletedBanner = CompeletedBanner
	local SeasonalOverlay = CoD.ContractSeasonalOverlay.new(f1_arg0, f1_arg1, 0, 0, 0, 418, 0, 0, 0, 189)
	SeasonalOverlay:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "seasonal")
			end,
		},
	})
	SeasonalOverlay:linkToElementModel(SeasonalOverlay, "seasonal", true, function(model)
		f1_arg0:updateElementState(SeasonalOverlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "seasonal",
		})
	end)
	SeasonalOverlay:linkToElementModel(self, nil, false, function(model)
		SeasonalOverlay:setModel(model, f1_arg1)
	end)
	self:addElement(SeasonalOverlay)
	self.SeasonalOverlay = SeasonalOverlay
	local ContractCost = CoD.ContractItemCost.new(f1_arg0, f1_arg1, 0, 0, 24, 209, 0, 0, 158, 179)
	ContractCost:linkToElementModel(self, nil, false, function(model)
		ContractCost:setModel(model, f1_arg1)
	end)
	self:addElement(ContractCost)
	self.ContractCost = ContractCost
	self:mergeStateConditions({
		{
			stateName = "Purchased",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchased")
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
	self:linkToElementModel(self, "purchased", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchased",
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
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f28_arg2, f28_arg3, f28_arg4)
		UpdateSelfElementState(f1_arg0, self.CommonButtonOutline, controller)
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractItemInternal.__resetProperties = function(f29_arg0)
	f29_arg0.ProgressBarBacking:completeAnimation()
	f29_arg0.ActiveBanner:completeAnimation()
	f29_arg0.PurchasedBanner:completeAnimation()
	f29_arg0.Darken:completeAnimation()
	f29_arg0.ContractCost:completeAnimation()
	f29_arg0.CompeletedBanner:completeAnimation()
	f29_arg0.ProgressBarBacking:setAlpha(1)
	f29_arg0.ActiveBanner:setAlpha(1)
	f29_arg0.PurchasedBanner:setAlpha(0)
	f29_arg0.Darken:setAlpha(0)
	f29_arg0.ContractCost:setAlpha(1)
	f29_arg0.CompeletedBanner:setAlpha(0)
end
CoD.ContractItemInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.ActiveBanner:completeAnimation()
			f30_arg0.ActiveBanner:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ActiveBanner)
			f30_arg0.ProgressBarBacking:completeAnimation()
			f30_arg0.ProgressBarBacking:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ProgressBarBacking)
		end,
	},
	Purchased = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(5)
			f31_arg0.ActiveBanner:completeAnimation()
			f31_arg0.ActiveBanner:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ActiveBanner)
			f31_arg0.ProgressBarBacking:completeAnimation()
			f31_arg0.ProgressBarBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ProgressBarBacking)
			f31_arg0.Darken:completeAnimation()
			f31_arg0.Darken:setAlpha(0.88)
			f31_arg0.clipFinished(f31_arg0.Darken)
			f31_arg0.PurchasedBanner:completeAnimation()
			f31_arg0.PurchasedBanner:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.PurchasedBanner)
			f31_arg0.ContractCost:completeAnimation()
			f31_arg0.ContractCost:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ContractCost)
		end,
	},
	Completed = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(4)
			f32_arg0.ActiveBanner:completeAnimation()
			f32_arg0.ActiveBanner:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ActiveBanner)
			f32_arg0.ProgressBarBacking:completeAnimation()
			f32_arg0.ProgressBarBacking:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ProgressBarBacking)
			f32_arg0.CompeletedBanner:completeAnimation()
			f32_arg0.CompeletedBanner:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.CompeletedBanner)
			f32_arg0.ContractCost:completeAnimation()
			f32_arg0.ContractCost:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.ContractCost)
		end,
	},
	Owned = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.ContractCost:completeAnimation()
			f33_arg0.ContractCost:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.ContractCost)
		end,
	},
}
CoD.ContractItemInternal.__onClose = function(f34_arg0)
	f34_arg0.Backer:close()
	f34_arg0.ContractRarityBar:close()
	f34_arg0.ContractIcon:close()
	f34_arg0.TileDots:close()
	f34_arg0.ContractRarityHeaderBackground:close()
	f34_arg0.SpecialistName:close()
	f34_arg0.ThemeName:close()
	f34_arg0.OutfitName:close()
	f34_arg0.ActiveBanner:close()
	f34_arg0.ProgressBarBacking:close()
	f34_arg0.ContractRarityHeaderTile:close()
	f34_arg0.CommonButtonOutline:close()
	f34_arg0.PurchasedBanner:close()
	f34_arg0.CompeletedBanner:close()
	f34_arg0.SeasonalOverlay:close()
	f34_arg0.ContractCost:close()
end
