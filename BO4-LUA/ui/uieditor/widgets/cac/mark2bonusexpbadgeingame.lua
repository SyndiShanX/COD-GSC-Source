CoD.Mark2BonusExpBadgeInGame = InheritFrom(LUI.UIElement)
CoD.Mark2BonusExpBadgeInGame.__defaultWidth = 195
CoD.Mark2BonusExpBadgeInGame.__defaultHeight = 18
CoD.Mark2BonusExpBadgeInGame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Mark2BonusExpBadgeInGame)
	self.id = "Mark2BonusExpBadgeInGame"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 195, 0, 0, 0, 18)
	Background:setRGB(0.13, 0.69, 0.74)
	Background:setAlpha(0.6)
	Background:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Background:setShaderVector(0, 0.21, 0.05, 0.21, 0.05)
	self:addElement(Background)
	self.Background = Background
	local Text = LUI.UIText.new(0, 0, 0, 195, 0, 0, 0, 18)
	Text:setZoom(3)
	Text:setScale(LanguageOverrideNumberForScale("korean", 0.9, LanguageOverrideNumberForScale("chinese", 0.9, 1, 1)))
	Text:setText(LocalizeToUpperString(0xDF923C238938C67))
	Text:setTTF("ttmussels_demibold")
	Text:setLetterSpacing(2)
	Text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Text)
	self.Text = Text
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsMark2Weapon(f1_arg1, self) and CoD.CACUtility.IsProgressionEnabledForMenu(menu)
			end,
		},
		{
			stateName = "VisibleDoubleExp",
			condition = function(menu, element, event)
				local f3_local0 = CoD.CACUtility.IsMark2Weapon(f1_arg1, self)
				if f3_local0 then
					f3_local0 = IsDoubleXP(f1_arg1)
					if f3_local0 then
						f3_local0 = CoD.CACUtility.IsProgressionEnabledForMenu(menu)
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
CoD.Mark2BonusExpBadgeInGame.__resetProperties = function(f7_arg0)
	f7_arg0.Text:completeAnimation()
	f7_arg0.Background:completeAnimation()
	f7_arg0.Text:setAlpha(1)
	f7_arg0.Text:setText(LocalizeToUpperString(0xDF923C238938C67))
	f7_arg0.Background:setAlpha(0.6)
end
CoD.Mark2BonusExpBadgeInGame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Background:completeAnimation()
			f8_arg0.Background:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Background)
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
			f10_arg0.Text:setText(LocalizeToUpperString(0x8DC8ECEFEBF1515))
			f10_arg0.clipFinished(f10_arg0.Text)
		end,
	},
}
