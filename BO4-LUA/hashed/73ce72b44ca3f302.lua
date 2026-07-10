CoD.ItemDetailsCasePrice = InheritFrom(LUI.UIElement)
CoD.ItemDetailsCasePrice.__defaultWidth = 200
CoD.ItemDetailsCasePrice.__defaultHeight = 28
CoD.ItemDetailsCasePrice.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemDetailsCasePrice)
	self.id = "ItemDetailsCasePrice"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CasePriceText = LUI.UIText.new(0, 1, 0, 0, 0, 0, 0, 28)
	CasePriceText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CasePriceText:setTTF("ttmussels_demibold")
	CasePriceText:setLetterSpacing(2)
	CasePriceText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CasePriceText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CasePriceText:linkToElementModel(self, "casePrice", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CasePriceText:setText(LocalizeIntoString(0x9CBD79D3C8A2BED, f2_local0))
		end
	end)
	self:addElement(CasePriceText)
	self.CasePriceText = CasePriceText
	self:mergeStateConditions({
		{
			stateName = "InsufficientFunds",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.CanExchangeLootCases(f1_arg1, element)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.ReservesItemCounts.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.lootCaseCount, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lootCaseCount",
		})
	end, false)
	self:linkToElementModel(self, "casePrice", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "casePrice",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemDetailsCasePrice.__resetProperties = function(f6_arg0)
	f6_arg0.CasePriceText:completeAnimation()
	f6_arg0.CasePriceText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
end
CoD.ItemDetailsCasePrice.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	InsufficientFunds = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.CasePriceText:completeAnimation()
			f8_arg0.CasePriceText:setRGB(ColorSet.InsufficientFunds.r, ColorSet.InsufficientFunds.g, ColorSet.InsufficientFunds.b)
			f8_arg0.clipFinished(f8_arg0.CasePriceText)
		end,
	},
}
CoD.ItemDetailsCasePrice.__onClose = function(f9_arg0)
	f9_arg0.CasePriceText:close()
end
