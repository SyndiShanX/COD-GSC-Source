require("x64:103d565b59f1a18")
require("x64:fd740505876fd7b")
CoD.ReserveLarge = InheritFrom(LUI.UIElement)
CoD.ReserveLarge.__defaultWidth = 310
CoD.ReserveLarge.__defaultHeight = 632
CoD.ReserveLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReserveLarge)
	self.id = "ReserveLarge"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Category = LUI.UIText.new(0.5, 0.5, -118, 118, 0, 0, 3, 22)
	Category:setAlpha(0.94)
	Category:setTTF("ttmussels_regular")
	Category:setLetterSpacing(4)
	Category:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Category:linkToElementModel(self, "rarity", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Category:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f2_local0))
		end
	end)
	Category:linkToElementModel(self, "category", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Category:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(Category)
	self.Category = Category
	local UltraCategory = LUI.UIText.new(0.5, 0.5, -118, 118, 0, 0, 3, 22)
	UltraCategory:setAlpha(0)
	UltraCategory:setTTF("ttmussels_regular")
	UltraCategory:setLetterSpacing(4)
	UltraCategory:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	UltraCategory:linkToElementModel(self, "rarity", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			UltraCategory:setRGB(CoD.BlackMarketUtility.LootRarityToColor(f4_local0))
		end
	end)
	UltraCategory:linkToElementModel(self, "category", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			UltraCategory:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(UltraCategory)
	self.UltraCategory = UltraCategory
	local Rarity = LUI.UIText.new(0, 0, 10, 223, 0, 0, 410, 427)
	Rarity:setTTF("ttmussels_demibold")
	Rarity:setLetterSpacing(4)
	Rarity:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Rarity:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Rarity:linkToElementModel(self, "rarity", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Rarity:setRGB(CoD.BlackMarketUtility.LootRarityToColorBright(f6_local0))
		end
	end)
	Rarity:linkToElementModel(self, "rarity", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Rarity:setText(LocalizeToUpperString(CoD.BlackMarketUtility.LootRarityToString(f7_local0)))
		end
	end)
	self:addElement(Rarity)
	self.Rarity = Rarity
	local Name = LUI.UIText.new(0, 0, 9, 302, 1, 1, -197, -173)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(2)
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Name:linkToElementModel(self, "name", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Name:setText(Engine[0xF9F1239CFD921FE](f8_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local Desc = LUI.UIText.new(0, 0, 9, 302, 1, 1, -168, -150)
	Desc:setTTF("dinnext_regular")
	Desc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Desc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Desc:linkToElementModel(self, "desc", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Desc:setText(f9_local0)
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	local mainExtraText = LUI.UIText.new(0, 0, 7, 300, 1, 1, -50, -34)
	mainExtraText:setTTF("dinnext_regular")
	mainExtraText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	mainExtraText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	mainExtraText:linkToElementModel(self, "mainExtraText", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			mainExtraText:setText(f10_local0)
		end
	end)
	self:addElement(mainExtraText)
	self.mainExtraText = mainExtraText
	local subExtraText = LUI.UIText.new(0, 0, 7, 300, 1, 1, -28, -12)
	subExtraText:setTTF("dinnext_regular")
	subExtraText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	subExtraText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	subExtraText:linkToElementModel(self, "subExtraText", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			subExtraText:setText(Engine[0xF9F1239CFD921FE](f11_local0))
		end
	end)
	self:addElement(subExtraText)
	self.subExtraText = subExtraText
	local OldSignaturesBonusExpBadge = CoD.Mark2BonusExpLongBadge.new(f1_arg0, f1_arg1, 0, 0, 10, 270, 0, 0, 560, 578)
	OldSignaturesBonusExpBadge:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f12_local0
				if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
					f12_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
					if f12_local0 then
						f12_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "itemCategory", 0xCC13B0F8EEFF726)
					end
				else
					f12_local0 = false
				end
				return f12_local0
			end,
		},
	})
	OldSignaturesBonusExpBadge:linkToElementModel(OldSignaturesBonusExpBadge, "itemCategory", true, function(model)
		f1_arg0:updateElementState(OldSignaturesBonusExpBadge, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	OldSignaturesBonusExpBadge:linkToElementModel(OldSignaturesBonusExpBadge, "weaponModelSlot", true, function(model)
		f1_arg0:updateElementState(OldSignaturesBonusExpBadge, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponModelSlot",
		})
	end)
	OldSignaturesBonusExpBadge:linkToElementModel(OldSignaturesBonusExpBadge, "itemIndex", true, function(model)
		f1_arg0:updateElementState(OldSignaturesBonusExpBadge, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	OldSignaturesBonusExpBadge:linkToElementModel(self, nil, false, function(model)
		OldSignaturesBonusExpBadge:setModel(model, f1_arg1)
	end)
	self:addElement(OldSignaturesBonusExpBadge)
	self.OldSignaturesBonusExpBadge = OldSignaturesBonusExpBadge
	local MK2BonusExpBadge = CoD.Mark2BonusExpLongBadge.new(f1_arg0, f1_arg1, 0, 0, 10, 270, 0, 0, 560, 578)
	MK2BonusExpBadge:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f17_local0
				if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
					f17_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
					if f17_local0 then
						f17_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "itemCategory", 0x7FB1719175C1461)
					end
				else
					f17_local0 = false
				end
				return f17_local0
			end,
		},
	})
	MK2BonusExpBadge:linkToElementModel(MK2BonusExpBadge, "itemCategory", true, function(model)
		f1_arg0:updateElementState(MK2BonusExpBadge, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemCategory",
		})
	end)
	MK2BonusExpBadge:linkToElementModel(MK2BonusExpBadge, "weaponModelSlot", true, function(model)
		f1_arg0:updateElementState(MK2BonusExpBadge, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponModelSlot",
		})
	end)
	MK2BonusExpBadge:linkToElementModel(MK2BonusExpBadge, "itemIndex", true, function(model)
		f1_arg0:updateElementState(MK2BonusExpBadge, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	MK2BonusExpBadge:linkToElementModel(self, nil, false, function(model)
		MK2BonusExpBadge:setModel(model, f1_arg1)
	end)
	self:addElement(MK2BonusExpBadge)
	self.MK2BonusExpBadge = MK2BonusExpBadge
	local FeaturedImage = CoD.ReservesContentImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -146, 146, 0, 0, 28, 379)
	FeaturedImage:linkToElementModel(self, nil, false, function(model)
		FeaturedImage:setModel(model, f1_arg1)
	end)
	self:addElement(FeaturedImage)
	self.FeaturedImage = FeaturedImage
	self:mergeStateConditions({
		{
			stateName = "Ultra",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "rarity", 4)
			end,
		},
	})
	self:linkToElementModel(self, "rarity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rarity",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReserveLarge.__resetProperties = function(f25_arg0)
	f25_arg0.UltraCategory:completeAnimation()
	f25_arg0.Category:completeAnimation()
	f25_arg0.UltraCategory:setAlpha(0)
	f25_arg0.Category:setAlpha(0.94)
end
CoD.ReserveLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	Ultra = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.Category:completeAnimation()
			f27_arg0.Category:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Category)
			f27_arg0.UltraCategory:completeAnimation()
			f27_arg0.UltraCategory:setAlpha(0.94)
			f27_arg0.clipFinished(f27_arg0.UltraCategory)
		end,
	},
}
CoD.ReserveLarge.__onClose = function(f28_arg0)
	f28_arg0.Category:close()
	f28_arg0.UltraCategory:close()
	f28_arg0.Rarity:close()
	f28_arg0.Name:close()
	f28_arg0.Desc:close()
	f28_arg0.mainExtraText:close()
	f28_arg0.subExtraText:close()
	f28_arg0.OldSignaturesBonusExpBadge:close()
	f28_arg0.MK2BonusExpBadge:close()
	f28_arg0.FeaturedImage:close()
end
