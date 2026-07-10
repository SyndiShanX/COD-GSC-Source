require("x64:6c2d0068c093e84")
require("x64:24adaf674659a70")
require("x64:e4ab7898d6eef2c")
CoD.ContractItemCost = InheritFrom(LUI.UIElement)
CoD.ContractItemCost.__defaultWidth = 185
CoD.ContractItemCost.__defaultHeight = 21
CoD.ContractItemCost.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractItemCost)
	self.id = "ContractItemCost"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Free = LUI.UIText.new(0, 0, 0, 185, 0, 0, 0, 21)
	Free:setRGB(0, 0.96, 1)
	Free:setText(LocalizeToUpperString(0x29E2B68E48757AD))
	Free:setTTF("ttmussels_demibold")
	Free:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Free:setShaderVector(0, 1, 0, 0, 0)
	Free:setShaderVector(1, 0, 0, 0, 0)
	Free:setShaderVector(2, 0, 0.1, 1, 0)
	Free:setLetterSpacing(2)
	Free:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Free:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Free:setBackingType(1)
	Free:setBackingWidget(CoD.ContractActiveBannerBacker, f1_arg0, f1_arg1)
	Free:setBackingColor(0.92, 0.92, 0.92)
	Free:setBackingXPadding(8)
	Free:setBackingYPadding(2)
	Free._backingElement.Frame:setRGB(0, 0.96, 1)
	self:addElement(Free)
	self.Free = Free
	local ContractCost = LUI.UIText.new(0, 0, -9, 176, 0, 0, 0, 21)
	ContractCost:setRGB(ColorSet.CodPointsNumber.r, ColorSet.CodPointsNumber.g, ColorSet.CodPointsNumber.b)
	ContractCost:setTTF("ttmussels_demibold")
	ContractCost:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ContractCost:setShaderVector(0, 1, 0, 0, 0)
	ContractCost:setShaderVector(1, 0, 0, 0, 0)
	ContractCost:setShaderVector(2, 1, 0, 0, 0.3)
	ContractCost:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ContractCost:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ContractCost:linkToElementModel(self, "price", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContractCost:setText(LocalizeIntoString(0x6A3CC7BE3008989, f2_local0))
		end
	end)
	self:addElement(ContractCost)
	self.ContractCost = ContractCost
	local DiscountCost = LUI.UIText.new(0, 0, 70, 185, 0, 0, 0, 21)
	DiscountCost:setRGB(ColorSet.InsufficientFunds.r, ColorSet.InsufficientFunds.g, ColorSet.InsufficientFunds.b)
	DiscountCost:setTTF("ttmussels_demibold")
	DiscountCost:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	DiscountCost:setShaderVector(0, 1, 0, 0, 0)
	DiscountCost:setShaderVector(1, 0, 0, 0, 0)
	DiscountCost:setShaderVector(2, 1, 0, 0, 0.3)
	DiscountCost:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DiscountCost:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	DiscountCost:linkToElementModel(self, "price", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DiscountCost:setText(LocalizeIntoString(0x6A3CC7BE3008989, f3_local0))
		end
	end)
	self:addElement(DiscountCost)
	self.DiscountCost = DiscountCost
	local CostMultiCurrency = CoD.ContractItemCostMultiCurrency.new(f1_arg0, f1_arg1, 0, 0, 0, 185, 0, 0, 0, 21)
	CostMultiCurrency:linkToElementModel(self, nil, false, function(model)
		CostMultiCurrency:setModel(model, f1_arg1)
	end)
	self:addElement(CostMultiCurrency)
	self.CostMultiCurrency = CostMultiCurrency
	local fxEmber = CoD.fx_Ember.new(f1_arg0, f1_arg1, 0, 0, -106, 182, 0, 0, -135, 225)
	fxEmber:setRGB(0, 0.48, 1)
	fxEmber:setAlpha(0)
	fxEmber:setScale(0.6, 0.6)
	fxEmber:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(fxEmber)
	self.fxEmber = fxEmber
	local fxEmber2 = CoD.fx_Ember.new(f1_arg0, f1_arg1, 0, 0, -106, 182, 0, 0, -135, 225)
	fxEmber2:setRGB(0, 0.82, 1)
	fxEmber2:setAlpha(0)
	fxEmber2:setScale(0.6, 0.6)
	fxEmber2:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(fxEmber2)
	self.fxEmber2 = fxEmber2
	self:mergeStateConditions({
		{
			stateName = "Free",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "price", 0)
			end,
		},
		{
			stateName = "Discount",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "MultiCurrency",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "casePrice", 0)
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
CoD.ContractItemCost.__resetProperties = function(f10_arg0)
	f10_arg0.ContractCost:completeAnimation()
	f10_arg0.fxEmber2:completeAnimation()
	f10_arg0.fxEmber:completeAnimation()
	f10_arg0.Free:completeAnimation()
	f10_arg0.DiscountCost:completeAnimation()
	f10_arg0.CostMultiCurrency:completeAnimation()
	f10_arg0.ContractCost:setAlpha(1)
	f10_arg0.fxEmber2:setAlpha(0)
	f10_arg0.fxEmber:setAlpha(0)
	f10_arg0.Free:setAlpha(1)
	f10_arg0.DiscountCost:setAlpha(1)
	f10_arg0.CostMultiCurrency:setAlpha(1)
end
CoD.ContractItemCost.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			f11_arg0.Free:completeAnimation()
			f11_arg0.Free:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Free)
			f11_arg0.ContractCost:completeAnimation()
			f11_arg0.ContractCost:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.ContractCost)
			f11_arg0.DiscountCost:completeAnimation()
			f11_arg0.DiscountCost:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DiscountCost)
			f11_arg0.CostMultiCurrency:completeAnimation()
			f11_arg0.CostMultiCurrency:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.CostMultiCurrency)
			f11_arg0.fxEmber:completeAnimation()
			f11_arg0.fxEmber:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.fxEmber)
			f11_arg0.fxEmber2:completeAnimation()
			f11_arg0.fxEmber2:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.fxEmber2)
		end,
	},
	Free = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(6)
			f12_arg0.Free:completeAnimation()
			f12_arg0.Free:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Free)
			f12_arg0.ContractCost:completeAnimation()
			f12_arg0.ContractCost:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ContractCost)
			f12_arg0.DiscountCost:completeAnimation()
			f12_arg0.DiscountCost:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DiscountCost)
			f12_arg0.CostMultiCurrency:completeAnimation()
			f12_arg0.CostMultiCurrency:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CostMultiCurrency)
			f12_arg0.fxEmber:completeAnimation()
			f12_arg0.fxEmber:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.fxEmber)
			f12_arg0.fxEmber2:completeAnimation()
			f12_arg0.fxEmber2:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.fxEmber2)
		end,
	},
	Discount = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.Free:completeAnimation()
			f13_arg0.Free:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Free)
			f13_arg0.ContractCost:completeAnimation()
			f13_arg0.ContractCost:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ContractCost)
			f13_arg0.DiscountCost:completeAnimation()
			f13_arg0.DiscountCost:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.DiscountCost)
			f13_arg0.CostMultiCurrency:completeAnimation()
			f13_arg0.CostMultiCurrency:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.CostMultiCurrency)
		end,
	},
	MultiCurrency = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.Free:completeAnimation()
			f14_arg0.Free:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Free)
			f14_arg0.ContractCost:completeAnimation()
			f14_arg0.ContractCost:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ContractCost)
			f14_arg0.DiscountCost:completeAnimation()
			f14_arg0.DiscountCost:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.DiscountCost)
		end,
	},
}
CoD.ContractItemCost.__onClose = function(f15_arg0)
	f15_arg0.ContractCost:close()
	f15_arg0.DiscountCost:close()
	f15_arg0.CostMultiCurrency:close()
	f15_arg0.fxEmber:close()
	f15_arg0.fxEmber2:close()
end
