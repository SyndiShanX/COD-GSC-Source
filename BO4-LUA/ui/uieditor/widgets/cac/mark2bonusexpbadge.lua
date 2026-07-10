CoD.Mark2BonusExpBadge = InheritFrom(LUI.UIElement)
CoD.Mark2BonusExpBadge.__defaultWidth = 260
CoD.Mark2BonusExpBadge.__defaultHeight = 18
CoD.Mark2BonusExpBadge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Mark2BonusExpBadge)
	self.id = "Mark2BonusExpBadge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Text = LUI.UIText.new(0, 0, 0, 260, 0, 0, 1, 16)
	Text:setRGB(0.22, 0.93, 1)
	Text:setZoom(3)
	Text:setScale(LanguageOverrideNumberForScale("korean", 0.9, LanguageOverrideNumberForScale("chinese", 0.9, 1, 1)))
	Text:setText(LocalizeToUpperString(0xDF923C238938C67))
	Text:setTTF("ttmussels_demibold")
	Text:setLetterSpacing(2)
	Text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Text:setBackingType(2)
	Text:setBackingColor(0.13, 0.25, 0.6)
	Text:setBackingXPadding(3)
	Text:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0xDE760AC0E801E57))
	Text:setBackingShaderVector(0, 1, 1, 1, 1)
	Text:setBackingShaderVector(1, 0, 0, 0, 0)
	Text:setBackingShaderVector(2, 0.5, 0, 0, 0)
	self:addElement(Text)
	self.Text = Text
	self:mergeStateConditions({
		{
			stateName = "VisibleDoubleExpAsianLanguage",
			condition = function(menu, element, event)
				local f2_local0 = CoD.CACUtility.IsMark2Weapon(f1_arg1, self)
				if f2_local0 then
					if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
						f2_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
						if f2_local0 then
							f2_local0 = IsDoubleXP(f1_arg1)
							if f2_local0 then
								f2_local0 = CoD.BaseUtility.IsCurrentLanguageAsian()
							end
						end
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "VisibleAsianLanguage",
			condition = function(menu, element, event)
				local f3_local0 = CoD.CACUtility.IsMark2Weapon(f1_arg1, self)
				if f3_local0 then
					if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
						f3_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
						if f3_local0 then
							f3_local0 = CoD.BaseUtility.IsCurrentLanguageAsian()
						end
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "VisibleDoubleExp",
			condition = function(menu, element, event)
				local f4_local0 = CoD.CACUtility.IsMark2Weapon(f1_arg1, self)
				if f4_local0 then
					if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
						f4_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
						if f4_local0 then
							f4_local0 = IsDoubleXP(f1_arg1)
						end
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f5_local0 = CoD.CACUtility.IsMark2Weapon(f1_arg1, self)
				if f5_local0 then
					if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
						f5_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
	})
	self:linkToElementModel(self, "weaponModelSlot", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponModelSlot",
		})
	end)
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		UpdateSelfState(self, f1_arg1)
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Mark2BonusExpBadge.__resetProperties = function(f9_arg0)
	f9_arg0.Text:completeAnimation()
	f9_arg0.Text:setTopBottom(0, 0, 1, 16)
	f9_arg0.Text:setRGB(0.22, 0.93, 1)
	f9_arg0.Text:setAlpha(1)
	f9_arg0.Text:setText(LocalizeToUpperString(0xDF923C238938C67))
end
CoD.Mark2BonusExpBadge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Text:completeAnimation()
			f10_arg0.Text:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Text)
		end,
	},
	VisibleDoubleExpAsianLanguage = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Text:completeAnimation()
			f11_arg0.Text:setTopBottom(0, 0, 3, 16)
			f11_arg0.Text:setRGB(0.22, 0.94, 1)
			f11_arg0.Text:setText(LocalizeToUpperString(0x8DC8ECEFEBF1515))
			f11_arg0.clipFinished(f11_arg0.Text)
		end,
	},
	VisibleAsianLanguage = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Text:completeAnimation()
			f12_arg0.Text:setTopBottom(0, 0, 3, 16)
			f12_arg0.Text:setRGB(0.22, 0.94, 1)
			f12_arg0.clipFinished(f12_arg0.Text)
		end,
	},
	VisibleDoubleExp = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Text:completeAnimation()
			f13_arg0.Text:setTopBottom(0, 0, -2, 16)
			f13_arg0.Text:setText(LocalizeToUpperString(0x8DC8ECEFEBF1515))
			f13_arg0.clipFinished(f13_arg0.Text)
		end,
	},
	Visible = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Text:completeAnimation()
			f14_arg0.Text:setTopBottom(0, 0, -2, 16)
			f14_arg0.Text:setRGB(0.22, 0.94, 1)
			f14_arg0.clipFinished(f14_arg0.Text)
		end,
	},
}
