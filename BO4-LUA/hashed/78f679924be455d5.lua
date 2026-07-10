require("x64:42d705a8804a00b")
require("x64:fd740505876fd7b")
CoD.ReserveTall = InheritFrom(LUI.UIElement)
CoD.ReserveTall.__defaultWidth = 236
CoD.ReserveTall.__defaultHeight = 506
CoD.ReserveTall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReserveTall)
	self.id = "ReserveTall"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 0, 506)
	ContractRarityHeaderBackground:setAlpha(0.7)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f2_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local ContractRarityHeaderBackground2 = LUI.UIImage.new(0, 0, 0, 236, 0, 0, 293, 319)
	ContractRarityHeaderBackground2:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContractRarityHeaderBackground2:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f3_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground2)
	self.ContractRarityHeaderBackground2 = ContractRarityHeaderBackground2
	local HeaderBGDarken = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 21)
	HeaderBGDarken:setRGB(0, 0, 0)
	HeaderBGDarken:setAlpha(0.3)
	self:addElement(HeaderBGDarken)
	self.HeaderBGDarken = HeaderBGDarken
	local Category = LUI.UIText.new(0, 0, 0, 236, 0, 0, 2, 20)
	Category:setTTF("ttmussels_regular")
	Category:setLetterSpacing(2)
	Category:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Category:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Category:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Category:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f4_local0))
		end
	end)
	Category:linkToElementModel(self, "category", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Category:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(Category)
	self.Category = Category
	local UltraCategoryHeader = CoD.ItemHistoryReservesHeader.new(f1_arg0, f1_arg1, 0, 0, 0, 236, 0, 0, 0, 21)
	UltraCategoryHeader:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rarity", 4) and not CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
		{
			stateName = "VisibleAsianLang",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rarity", 4)
			end,
		},
	})
	UltraCategoryHeader:linkToElementModel(UltraCategoryHeader, "rarity", true, function(model)
		f1_arg0:updateElementState(UltraCategoryHeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
		})
	end)
	UltraCategoryHeader:linkToElementModel(self, nil, false, function(model)
		UltraCategoryHeader:setModel(model, f1_arg1)
	end)
	self:addElement(UltraCategoryHeader)
	self.UltraCategoryHeader = UltraCategoryHeader
	local Rarity = LUI.UIText.new(0, 0, 7, 230, 0, 0, 298, 315)
	Rarity:setTTF("ttmussels_demibold")
	Rarity:setLetterSpacing(2)
	Rarity:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Rarity:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Rarity:linkToElementModel(self, "rarity", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Rarity:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f10_local0))
		end
	end)
	Rarity:linkToElementModel(self, "rarity", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Rarity:setText(LocalizeToUpperString(CoD.BlackMarketUtility.LootRarityToString(f11_local0)))
		end
	end)
	self:addElement(Rarity)
	self.Rarity = Rarity
	local Name = LUI.UIText.new(0, 0, 7, 230, 0, 0, 325, 349)
	Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Name:linkToElementModel(self, "name", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Name:setText(Engine[0xF9F1239CFD921FE](f12_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Desc = LUI.UIText.new(0, 0, 7, 230, 0, 0, 352, 369)
	Desc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Desc:setTTF("dinnext_regular")
	Desc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Desc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Desc:linkToElementModel(self, "desc", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Desc:setText(f13_local0)
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	local mainExtraText = LUI.UIText.new(0, 0, 7, 230, 0, 0, 467, 483)
	mainExtraText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	mainExtraText:setTTF("dinnext_regular")
	mainExtraText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	mainExtraText:linkToElementModel(self, "mainExtraText", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			mainExtraText:setText(f14_local0)
		end
	end)
	self:addElement(mainExtraText)
	self.mainExtraText = mainExtraText
	local subExtraText = LUI.UIText.new(0, 0, 7, 230, 0, 0, 488, 504)
	subExtraText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	subExtraText:setTTF("dinnext_regular")
	subExtraText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	subExtraText:linkToElementModel(self, "subExtraText", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			subExtraText:setText(Engine[0xF9F1239CFD921FE](f15_local0))
		end
	end)
	self:addElement(subExtraText)
	self.subExtraText = subExtraText
	local FeaturedImage = CoD.ReservesContentImage.new(f1_arg0, f1_arg1, 0, 0, -28, 264, 0, 0, -32, 319)
	FeaturedImage:setScale(0.7, 0.7)
	FeaturedImage:linkToElementModel(self, nil, false, function(model)
		FeaturedImage:setModel(model, f1_arg1)
	end)
	self:addElement(FeaturedImage)
	self.FeaturedImage = FeaturedImage
	self:mergeStateConditions({
		{
			stateName = "AsianLang",
			condition = function(menu, element, event)
				local f17_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRABAND)
				if f17_local0 then
					f17_local0 = CoD.BaseUtility.IsCurrentLanguageAsian()
					if f17_local0 then
						f17_local0 = not CoD.BlackMarketUtility.ShowShopReserveItem(f1_arg1, element)
					end
				end
				return f17_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRABAND) and not CoD.BlackMarketUtility.ShowShopReserveItem(f1_arg1, element)
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReserveTall.__resetProperties = function(f20_arg0)
	f20_arg0.UltraCategoryHeader:completeAnimation()
	f20_arg0.Category:completeAnimation()
	f20_arg0.HeaderBGDarken:completeAnimation()
	f20_arg0.ContractRarityHeaderBackground2:completeAnimation()
	f20_arg0.ContractRarityHeaderBackground:completeAnimation()
	f20_arg0.Rarity:completeAnimation()
	f20_arg0.Name:completeAnimation()
	f20_arg0.Desc:completeAnimation()
	f20_arg0.mainExtraText:completeAnimation()
	f20_arg0.subExtraText:completeAnimation()
	f20_arg0.FeaturedImage:completeAnimation()
	f20_arg0.UltraCategoryHeader:setAlpha(1)
	f20_arg0.Category:setTopBottom(0, 0, 2, 20)
	f20_arg0.Category:setAlpha(1)
	f20_arg0.HeaderBGDarken:setAlpha(0.3)
	f20_arg0.ContractRarityHeaderBackground2:setAlpha(1)
	f20_arg0.ContractRarityHeaderBackground:setAlpha(0.7)
	f20_arg0.Rarity:setTopBottom(0, 0, 298, 315)
	f20_arg0.Rarity:setAlpha(1)
	f20_arg0.Name:setTopBottom(0, 0, 325, 349)
	f20_arg0.Name:setAlpha(1)
	f20_arg0.Desc:setTopBottom(0, 0, 352, 369)
	f20_arg0.Desc:setAlpha(1)
	f20_arg0.mainExtraText:setTopBottom(0, 0, 467, 483)
	f20_arg0.mainExtraText:setAlpha(1)
	f20_arg0.subExtraText:setTopBottom(0, 0, 488, 504)
	f20_arg0.subExtraText:setAlpha(1)
	f20_arg0.FeaturedImage:setAlpha(1)
end
CoD.ReserveTall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(11)
			f21_arg0.ContractRarityHeaderBackground:completeAnimation()
			f21_arg0.ContractRarityHeaderBackground:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ContractRarityHeaderBackground)
			f21_arg0.ContractRarityHeaderBackground2:completeAnimation()
			f21_arg0.ContractRarityHeaderBackground2:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ContractRarityHeaderBackground2)
			f21_arg0.HeaderBGDarken:completeAnimation()
			f21_arg0.HeaderBGDarken:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.HeaderBGDarken)
			f21_arg0.Category:completeAnimation()
			f21_arg0.Category:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Category)
			f21_arg0.UltraCategoryHeader:completeAnimation()
			f21_arg0.UltraCategoryHeader:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.UltraCategoryHeader)
			f21_arg0.Rarity:completeAnimation()
			f21_arg0.Rarity:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Rarity)
			f21_arg0.Name:completeAnimation()
			f21_arg0.Name:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Name)
			f21_arg0.Desc:completeAnimation()
			f21_arg0.Desc:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Desc)
			f21_arg0.mainExtraText:completeAnimation()
			f21_arg0.mainExtraText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.mainExtraText)
			f21_arg0.subExtraText:completeAnimation()
			f21_arg0.subExtraText:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.subExtraText)
			f21_arg0.FeaturedImage:completeAnimation()
			f21_arg0.FeaturedImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.FeaturedImage)
		end,
	},
	AsianLang = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(6)
			f22_arg0.Category:completeAnimation()
			f22_arg0.Category:setTopBottom(0, 0, 6, 20)
			f22_arg0.clipFinished(f22_arg0.Category)
			f22_arg0.Rarity:completeAnimation()
			f22_arg0.Rarity:setTopBottom(0, 0, 302, 316)
			f22_arg0.clipFinished(f22_arg0.Rarity)
			f22_arg0.Name:completeAnimation()
			f22_arg0.Name:setTopBottom(0, 0, 326, 346)
			f22_arg0.clipFinished(f22_arg0.Name)
			f22_arg0.Desc:completeAnimation()
			f22_arg0.Desc:setTopBottom(0, 0, 355, 369)
			f22_arg0.clipFinished(f22_arg0.Desc)
			f22_arg0.mainExtraText:completeAnimation()
			f22_arg0.mainExtraText:setTopBottom(0, 0, 467, 481)
			f22_arg0.clipFinished(f22_arg0.mainExtraText)
			f22_arg0.subExtraText:completeAnimation()
			f22_arg0.subExtraText:setTopBottom(0, 0, 487, 501)
			f22_arg0.clipFinished(f22_arg0.subExtraText)
		end,
	},
	Visible = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ReserveTall.__onClose = function(f24_arg0)
	f24_arg0.ContractRarityHeaderBackground:close()
	f24_arg0.ContractRarityHeaderBackground2:close()
	f24_arg0.Category:close()
	f24_arg0.UltraCategoryHeader:close()
	f24_arg0.Rarity:close()
	f24_arg0.Name:close()
	f24_arg0.Desc:close()
	f24_arg0.mainExtraText:close()
	f24_arg0.subExtraText:close()
	f24_arg0.FeaturedImage:close()
end
