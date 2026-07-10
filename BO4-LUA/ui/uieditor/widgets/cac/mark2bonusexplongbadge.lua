CoD.Mark2BonusExpLongBadge = InheritFrom(LUI.UIElement)
CoD.Mark2BonusExpLongBadge.__defaultWidth = 260
CoD.Mark2BonusExpLongBadge.__defaultHeight = 18
CoD.Mark2BonusExpLongBadge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Mark2BonusExpLongBadge)
	self.id = "Mark2BonusExpLongBadge"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Text = LUI.UIText.new(0, 0, 0, 260, 0, 0, 0, 18)
	Text:setRGB(0.54, 0.98, 1)
	Text:setZoom(3)
	Text:setScale(LanguageOverrideNumberForScale("korean", 0.9, LanguageOverrideNumberForScale("chinese", 0.9, 1, 1)))
	Text:setText(LocalizeToUpperString(0xBBAD8A3AF74F8F6))
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
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = CoD.CACUtility.IsMark2Weapon(f1_arg1, self)
				if f2_local0 then
					if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
						f2_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "VisibleDoubleExp",
			condition = function(menu, element, event)
				local f3_local0 = CoD.CACUtility.IsMark2Weapon(f1_arg1, self)
				if f3_local0 then
					if not IsCurrentMenu(menu, "PaintjobWeaponSelect") then
						f3_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
						if f3_local0 then
							f3_local0 = IsDoubleXP(f1_arg1)
						end
					else
						f3_local0 = false
					end
				end
				return f3_local0
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
CoD.Mark2BonusExpLongBadge.__resetProperties = function(f7_arg0)
	f7_arg0.Text:completeAnimation()
	f7_arg0.Text:setAlpha(1)
	f7_arg0.Text:setText(LocalizeToUpperString(0xBBAD8A3AF74F8F6))
end
CoD.Mark2BonusExpLongBadge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Text:completeAnimation()
			f8_arg0.Text:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Text)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	VisibleDoubleExp = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Text:completeAnimation()
			f10_arg0.Text:setText(LocalizeToUpperString(0x418ACAE8409A0B8))
			f10_arg0.clipFinished(f10_arg0.Text)
		end,
	},
}
