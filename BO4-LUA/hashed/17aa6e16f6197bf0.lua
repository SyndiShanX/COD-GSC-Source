require("x64:24adaf674659a70")
CoD.ContractItemCostMultiCurrency = InheritFrom(LUI.UIElement)
CoD.ContractItemCostMultiCurrency.__defaultWidth = 185
CoD.ContractItemCostMultiCurrency.__defaultHeight = 21
CoD.ContractItemCostMultiCurrency.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 20, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ContractItemCostMultiCurrency)
	self.id = "ContractItemCostMultiCurrency"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CostCP = LUI.UIText.new(0, 0, 7.5, 70.5, 0, 0, 0, 21)
	CostCP:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	CostCP:setTTF("ttmussels_demibold")
	CostCP:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	CostCP:setShaderVector(0, 1, 0, 0, 0)
	CostCP:setShaderVector(1, 0, 0, 0, 0)
	CostCP:setShaderVector(2, 1, 0, 0, 0.3)
	CostCP:setLetterSpacing(2)
	CostCP:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CostCP:linkToElementModel(self, "price", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CostCP:setText(LocalizeIntoString(0x6A3CC7BE3008989, f2_local0))
		end
	end)
	self:addElement(CostCP)
	self.CostCP = CostCP
	local divider = LUI.UIImage.new(0, 0, 90.5, 94.5, 0, 0, -11.5, 32.5)
	divider:setImage(RegisterImage(0x6DDA4086EA0EF02))
	divider:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(divider)
	self.divider = divider
	local CostCase = LUI.UIText.new(0, 0, 114.5, 177.5, 0, 0, 0, 21)
	CostCase:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CostCase:setTTF("ttmussels_demibold")
	CostCase:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	CostCase:setShaderVector(0, 1, 0, 0, 0)
	CostCase:setShaderVector(1, 0, 0, 0, 0)
	CostCase:setShaderVector(2, 1, 1, 1, 0.3)
	CostCase:setLetterSpacing(2)
	CostCase:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CostCase:linkToElementModel(self, "casePrice", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CostCase:setText(LocalizeIntoString(0x9CBD79D3C8A2BED, f3_local0))
		end
	end)
	self:addElement(CostCase)
	self.CostCase = CostCase
	self:mergeStateConditions({
		{
			stateName = "CaseOnlyInsufficientCases",
			condition = function(menu, element, event)
				local f4_local0
				if not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "price", 0) then
					f4_local0 = not CoD.BlackMarketUtility.CanExchangeLootCases(f1_arg1, element)
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "CaseOnly",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "price", 0)
			end,
		},
		{
			stateName = "CPOnly",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "casePrice", 0)
			end,
		},
		{
			stateName = "InsufficientCases",
			condition = function(menu, element, event)
				return not CoD.BlackMarketUtility.CanExchangeLootCases(f1_arg1, element)
			end,
		},
	})
	self:linkToElementModel(self, "price", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "price",
		})
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.ReservesItemCounts.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.lootCaseCount, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
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
CoD.ContractItemCostMultiCurrency.__resetProperties = function(f11_arg0)
	f11_arg0.CostCP:completeAnimation()
	f11_arg0.CostCase:completeAnimation()
	f11_arg0.divider:completeAnimation()
	f11_arg0.CostCP:setAlpha(1)
	f11_arg0.CostCase:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f11_arg0.CostCase:setAlpha(1)
	f11_arg0.CostCase:setShaderVector(0, 1, 0, 0, 0)
	f11_arg0.CostCase:setShaderVector(1, 0, 0, 0, 0)
	f11_arg0.CostCase:setShaderVector(2, 1, 1, 1, 0.3)
	f11_arg0.divider:setAlpha(1)
end
CoD.ContractItemCostMultiCurrency.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	CaseOnlyInsufficientCases = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.CostCP:completeAnimation()
			f13_arg0.CostCP:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.CostCP)
			f13_arg0.divider:completeAnimation()
			f13_arg0.divider:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.divider)
			f13_arg0.CostCase:completeAnimation()
			f13_arg0.CostCase:setRGB(ColorSet.InsufficientFunds.r, ColorSet.InsufficientFunds.g, ColorSet.InsufficientFunds.b)
			f13_arg0.CostCase:setShaderVector(0, 1, 0, 0, 0)
			f13_arg0.CostCase:setShaderVector(1, 0, 0, 0, 0)
			f13_arg0.CostCase:setShaderVector(2, 1, 0, 0, 0.3)
			f13_arg0.clipFinished(f13_arg0.CostCase)
		end,
	},
	CaseOnly = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.CostCP:completeAnimation()
			f14_arg0.CostCP:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CostCP)
			f14_arg0.divider:completeAnimation()
			f14_arg0.divider:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.divider)
		end,
	},
	CPOnly = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.divider:completeAnimation()
			f15_arg0.divider:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.divider)
			f15_arg0.CostCase:completeAnimation()
			f15_arg0.CostCase:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CostCase)
		end,
	},
	InsufficientCases = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.CostCase:completeAnimation()
			f16_arg0.CostCase:setRGB(ColorSet.InsufficientFunds.r, ColorSet.InsufficientFunds.g, ColorSet.InsufficientFunds.b)
			f16_arg0.CostCase:setShaderVector(0, 1, 0, 0, 0)
			f16_arg0.CostCase:setShaderVector(1, 0, 0, 0, 0)
			f16_arg0.CostCase:setShaderVector(2, 1, 0, 0, 0.3)
			f16_arg0.clipFinished(f16_arg0.CostCase)
		end,
	},
}
CoD.ContractItemCostMultiCurrency.__onClose = function(f17_arg0)
	f17_arg0.CostCP:close()
	f17_arg0.CostCase:close()
end
