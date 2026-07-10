CoD.ShopItemTallDescContainer = InheritFrom(LUI.UIElement)
CoD.ShopItemTallDescContainer.__defaultWidth = 218
CoD.ShopItemTallDescContainer.__defaultHeight = 37
CoD.ShopItemTallDescContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ShopItemTallDescContainer)
	self.id = "ShopItemTallDescContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Name = LUI.UIText.new(0.5, 0.5, -109, 109, 0, 0, 0, 20)
	Name:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(1.6)
	Name:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Name:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Name:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local shopCategory = LUI.UIText.new(0.5, 0.5, -109, 109, 0, 0, 23, 37)
	shopCategory:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	shopCategory:setTTF("dinnext_regular")
	shopCategory:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	shopCategory:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	shopCategory:linkToElementModel(self, "shopCategory", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			shopCategory:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(shopCategory)
	self.shopCategory = shopCategory
	self:mergeStateConditions({
		{
			stateName = "AsianLang",
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
CoD.ShopItemTallDescContainer.__resetProperties = function(f5_arg0)
	f5_arg0.Name:completeAnimation()
	f5_arg0.shopCategory:completeAnimation()
	f5_arg0.Name:setTopBottom(0, 0, 0, 20)
	f5_arg0.shopCategory:setTopBottom(0, 0, 23, 37)
end
CoD.ShopItemTallDescContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLang = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Name:completeAnimation()
			f7_arg0.Name:setTopBottom(0, 0, 4, 18)
			f7_arg0.clipFinished(f7_arg0.Name)
			f7_arg0.shopCategory:completeAnimation()
			f7_arg0.shopCategory:setTopBottom(0, 0, 24, 36)
			f7_arg0.clipFinished(f7_arg0.shopCategory)
		end,
	},
}
CoD.ShopItemTallDescContainer.__onClose = function(f8_arg0)
	f8_arg0.Name:close()
	f8_arg0.shopCategory:close()
end
