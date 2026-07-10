CoD.ContractTallDescContainer = InheritFrom(LUI.UIElement)
CoD.ContractTallDescContainer.__defaultWidth = 218
CoD.ContractTallDescContainer.__defaultHeight = 50
CoD.ContractTallDescContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractTallDescContainer)
	self.id = "ContractTallDescContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OutfitName = LUI.UIText.new(0.5, 0.5, -109, 109, 0, 0, 0, 20)
	OutfitName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OutfitName:setTTF("ttmussels_demibold")
	OutfitName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	OutfitName:setShaderVector(0, 1, 0, 0, 0)
	OutfitName:setShaderVector(1, 0, 0, 0, 0)
	OutfitName:setShaderVector(2, 0, 0, 0, 0.6)
	OutfitName:setLetterSpacing(2)
	OutfitName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	OutfitName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	OutfitName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			OutfitName:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(OutfitName)
	self.OutfitName = OutfitName
	local ThemeName = LUI.UIText.new(0.5, 0.5, -109, 109, 0, 0, 22, 36)
	ThemeName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ThemeName:setTTF("dinnext_regular")
	ThemeName:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ThemeName:setShaderVector(0, 1, 0, 0, 0)
	ThemeName:setShaderVector(1, 0, 0, 0, 0)
	ThemeName:setShaderVector(2, 0, 0, 0, 0.6)
	ThemeName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ThemeName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ThemeName:linkToElementModel(self, "mainExtraText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ThemeName:setText(f3_local0)
		end
	end)
	self:addElement(ThemeName)
	self.ThemeName = ThemeName
	local SpecialistName = LUI.UIText.new(0.5, 0.5, -109, 109, 0, 0, 36, 50)
	SpecialistName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SpecialistName:setAlpha(0)
	SpecialistName:setTTF("default")
	SpecialistName:setMaterial(LUI.UIImage.GetCachedMaterial(0x336C1AE82B1520A))
	SpecialistName:setLetterSpacing(1)
	SpecialistName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SpecialistName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	SpecialistName:linkToElementModel(self, "relatedItemName", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			SpecialistName:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
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
CoD.ContractTallDescContainer.__resetProperties = function(f6_arg0)
	f6_arg0.OutfitName:completeAnimation()
	f6_arg0.ThemeName:completeAnimation()
	f6_arg0.SpecialistName:completeAnimation()
	f6_arg0.OutfitName:setTopBottom(0, 0, 0, 20)
	f6_arg0.ThemeName:setTopBottom(0, 0, 22, 36)
	f6_arg0.SpecialistName:setTopBottom(0, 0, 36, 50)
end
CoD.ContractTallDescContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLang = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.OutfitName:completeAnimation()
			f8_arg0.OutfitName:setTopBottom(0, 0, 5, 19)
			f8_arg0.clipFinished(f8_arg0.OutfitName)
			f8_arg0.ThemeName:completeAnimation()
			f8_arg0.ThemeName:setTopBottom(0, 0, 25, 35)
			f8_arg0.clipFinished(f8_arg0.ThemeName)
			f8_arg0.SpecialistName:completeAnimation()
			f8_arg0.SpecialistName:setTopBottom(0, 0, 39, 49)
			f8_arg0.clipFinished(f8_arg0.SpecialistName)
		end,
	},
}
CoD.ContractTallDescContainer.__onClose = function(f9_arg0)
	f9_arg0.OutfitName:close()
	f9_arg0.ThemeName:close()
	f9_arg0.SpecialistName:close()
end
