CoD.ItemHistoryReservesHeader = InheritFrom(LUI.UIElement)
CoD.ItemHistoryReservesHeader.__defaultWidth = 236
CoD.ItemHistoryReservesHeader.__defaultHeight = 21
CoD.ItemHistoryReservesHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemHistoryReservesHeader)
	self.id = "ItemHistoryReservesHeader"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ContractRarityHeaderBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ContractRarityHeaderBackground:setAlpha(0)
	ContractRarityHeaderBackground:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContractRarityHeaderBackground:setRGB(CoD.BlackMarketUtility.LootRarityToColorDark(f2_local0))
		end
	end)
	self:addElement(ContractRarityHeaderBackground)
	self.ContractRarityHeaderBackground = ContractRarityHeaderBackground
	local HeaderBGDarken = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	HeaderBGDarken:setRGB(0, 0, 0)
	HeaderBGDarken:setAlpha(0)
	self:addElement(HeaderBGDarken)
	self.HeaderBGDarken = HeaderBGDarken
	local Category = LUI.UIText.new(0, 0, 0, 236, 0, 0, 2, 20)
	Category:setAlpha(0)
	Category:setTTF("ttmussels_regular")
	Category:setLetterSpacing(2)
	Category:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Category:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Category:linkToElementModel(self, "rarity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Category:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f3_local0))
		end
	end)
	Category:linkToElementModel(self, "category", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Category:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(Category)
	self.Category = Category
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "VisibleAsianLang",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemHistoryReservesHeader.__resetProperties = function(f7_arg0)
	f7_arg0.Category:completeAnimation()
	f7_arg0.HeaderBGDarken:completeAnimation()
	f7_arg0.ContractRarityHeaderBackground:completeAnimation()
	f7_arg0.Category:setTopBottom(0, 0, 2, 20)
	f7_arg0.Category:setAlpha(0)
	f7_arg0.HeaderBGDarken:setAlpha(0)
	f7_arg0.ContractRarityHeaderBackground:setAlpha(0)
end
CoD.ItemHistoryReservesHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.ContractRarityHeaderBackground:completeAnimation()
			f9_arg0.ContractRarityHeaderBackground:setAlpha(0.7)
			f9_arg0.clipFinished(f9_arg0.ContractRarityHeaderBackground)
			f9_arg0.HeaderBGDarken:completeAnimation()
			f9_arg0.HeaderBGDarken:setAlpha(0.3)
			f9_arg0.clipFinished(f9_arg0.HeaderBGDarken)
			f9_arg0.Category:completeAnimation()
			f9_arg0.Category:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Category)
		end,
	},
	VisibleAsianLang = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.ContractRarityHeaderBackground:completeAnimation()
			f10_arg0.ContractRarityHeaderBackground:setAlpha(0.7)
			f10_arg0.clipFinished(f10_arg0.ContractRarityHeaderBackground)
			f10_arg0.HeaderBGDarken:completeAnimation()
			f10_arg0.HeaderBGDarken:setAlpha(0.3)
			f10_arg0.clipFinished(f10_arg0.HeaderBGDarken)
			f10_arg0.Category:completeAnimation()
			f10_arg0.Category:setTopBottom(0, 0, 6, 20)
			f10_arg0.Category:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.Category)
		end,
	},
}
CoD.ItemHistoryReservesHeader.__onClose = function(f11_arg0)
	f11_arg0.ContractRarityHeaderBackground:close()
	f11_arg0.Category:close()
end
