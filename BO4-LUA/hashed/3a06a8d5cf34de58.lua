require("x64:6735e84e8dd1117")
CoD.ItemShopDiscountBanner = InheritFrom(LUI.UIElement)
CoD.ItemShopDiscountBanner.__defaultWidth = 211
CoD.ItemShopDiscountBanner.__defaultHeight = 26
CoD.ItemShopDiscountBanner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemShopDiscountBanner)
	self.id = "ItemShopDiscountBanner"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Corner = LUI.UIImage.new(0, 0, 195, 211, 0, 0, 0, 16)
	Corner:setRGB(0.45, 0.41, 0.07)
	Corner:setAlpha(0)
	Corner:setImage(RegisterImage(0xB998225BD626F68))
	self:addElement(Corner)
	self.Corner = Corner
	local Promo = LUI.UIText.new(0, 0, 0, 200, 0, 0, 9, 28)
	Promo:setRGB(0, 0, 0)
	Promo:setAlpha(0)
	Promo:setTTF("ttmussels_demibold")
	Promo:setLetterSpacing(2)
	Promo:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Promo:setBackingType(1)
	Promo:setBackingWidget(CoD.ContractSeasonalPromoBacker, f1_arg0, f1_arg1)
	Promo:setBackingXPadding(7)
	Promo:setBackingYPadding(1)
	Promo:linkToElementModel(self, "percentOff", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Promo:setText(ToUpper(LocalizeIntoString(0x4211D07B481977D, f2_local0)))
		end
	end)
	self:addElement(Promo)
	self.Promo = Promo
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "percentOff", 0)
			end,
		},
	})
	self:linkToElementModel(self, "percentOff", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percentOff",
		})
	end)
	self:linkToElementModel(self, "percentOff", true, function(model)
		if CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "percentOff", 0) then
			UpdateSelfState(self, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemShopDiscountBanner.__resetProperties = function(f6_arg0)
	f6_arg0.Promo:completeAnimation()
	f6_arg0.Corner:completeAnimation()
	f6_arg0.Promo:setAlpha(0)
	f6_arg0.Corner:setAlpha(0)
end
CoD.ItemShopDiscountBanner.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Corner:completeAnimation()
			f8_arg0.Corner:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Corner)
			f8_arg0.Promo:completeAnimation()
			f8_arg0.Promo:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Promo)
		end,
	},
}
CoD.ItemShopDiscountBanner.__onClose = function(f9_arg0)
	f9_arg0.Promo:close()
end
