CoD.WeaponCACPersonalizationName = InheritFrom(LUI.UIElement)
CoD.WeaponCACPersonalizationName.__defaultWidth = 500
CoD.WeaponCACPersonalizationName.__defaultHeight = 40
CoD.WeaponCACPersonalizationName.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponCACPersonalizationName)
	self.id = "WeaponCACPersonalizationName"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BaseName = LUI.UIText.new(0.5, 0.5, -250, 443, 0, 0, 0, 32)
	BaseName:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	BaseName:setTTF("ttmussels_regular")
	BaseName:setLetterSpacing(12)
	BaseName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	BaseName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	BaseName:linkToElementModel(self, "weaponItemIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BaseName:setText(LocalizeToUpperString(CoD.CACUtility.GetItemNameFromIndex(f1_arg0, Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], f2_local0)))
		end
	end)
	self:addElement(BaseName)
	self.BaseName = BaseName
	self:mergeStateConditions({
		{
			stateName = "HideName",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsBaseSignatureWeapon(menu, element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "weaponItemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponItemIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponCACPersonalizationName.__resetProperties = function(f5_arg0)
	f5_arg0.BaseName:completeAnimation()
	f5_arg0.BaseName:setAlpha(1)
end
CoD.WeaponCACPersonalizationName.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	HideName = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.BaseName:completeAnimation()
			f7_arg0.BaseName:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BaseName)
		end,
	},
}
CoD.WeaponCACPersonalizationName.__onClose = function(f8_arg0)
	f8_arg0.BaseName:close()
end
