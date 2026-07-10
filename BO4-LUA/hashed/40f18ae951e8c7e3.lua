CoD.Prestige_LoadoutInfoRow = InheritFrom(LUI.UIElement)
CoD.Prestige_LoadoutInfoRow.__defaultWidth = 400
CoD.Prestige_LoadoutInfoRow.__defaultHeight = 20
CoD.Prestige_LoadoutInfoRow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_LoadoutInfoRow)
	self.id = "Prestige_LoadoutInfoRow"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CategoryName = LUI.UIText.new(0, 0, 0, 150, 0, 0, 1, 19)
	CategoryName:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	CategoryName:setAlpha(0.5)
	CategoryName:setTTF("ttmussels_regular")
	CategoryName:setLetterSpacing(1)
	CategoryName:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	CategoryName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	CategoryName:linkToElementModel(self, "loadoutEntryCategory", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CategoryName:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(CategoryName)
	self.CategoryName = CategoryName
	local EntryName = LUI.UIText.new(1, 1, -240, 0, 0, 0, 1, 19)
	EntryName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	EntryName:setTTF("ttmussels_demibold")
	EntryName:setLetterSpacing(1)
	EntryName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EntryName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	EntryName:linkToElementModel(self, "loadoutEntryName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EntryName:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(EntryName)
	self.EntryName = EntryName
	self:mergeStateConditions({
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_LoadoutInfoRow.__resetProperties = function(f5_arg0)
	f5_arg0.CategoryName:completeAnimation()
	f5_arg0.EntryName:completeAnimation()
	f5_arg0.CategoryName:setLeftRight(0, 0, 0, 150)
	f5_arg0.CategoryName:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	f5_arg0.EntryName:setLeftRight(1, 1, -240, 0)
	f5_arg0.EntryName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
end
CoD.Prestige_LoadoutInfoRow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Arabic = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.CategoryName:completeAnimation()
			f7_arg0.CategoryName:setLeftRight(0, 0, 220, 400)
			f7_arg0.CategoryName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
			f7_arg0.clipFinished(f7_arg0.CategoryName)
			f7_arg0.EntryName:completeAnimation()
			f7_arg0.EntryName:setLeftRight(0, 0, 0, 210)
			f7_arg0.EntryName:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
			f7_arg0.clipFinished(f7_arg0.EntryName)
		end,
	},
}
CoD.Prestige_LoadoutInfoRow.__onClose = function(f8_arg0)
	f8_arg0.CategoryName:close()
	f8_arg0.EntryName:close()
end
