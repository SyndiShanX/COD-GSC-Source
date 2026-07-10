CoD.RestrictedItemWarningText = InheritFrom(LUI.UIElement)
CoD.RestrictedItemWarningText.__defaultWidth = 494
CoD.RestrictedItemWarningText.__defaultHeight = 30
CoD.RestrictedItemWarningText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.RestrictedItemWarningText)
	self.id = "RestrictedItemWarningText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(-0.03, 1.02, 0, 0, 0, 1, 0, 0)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0)
	self:addElement(bg)
	self.bg = bg
	local Warning = LUI.UIImage.new(0, 0, 0, 38, 0.5, 0.5, -15, 15)
	Warning:setRGB(0.82, 0.08, 0.17)
	Warning:setAlpha(0)
	Warning:setImage(RegisterImage(0xDF501A88BB578F))
	Warning:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Warning)
	self.Warning = Warning
	local Text = LUI.UIText.new(0.5, 0.5, -204, 247, 0.5, 0.5, -10, 10)
	Text:setAlpha(0)
	Text:setText(LocalizeToUpperString(0x3293C2F8FE5A04C))
	Text:setTTF("ttmussels_regular")
	Text:setLetterSpacing(2)
	Text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Text)
	self.Text = Text
	local CharacterText = LUI.UIText.new(0.5, 0.5, -204, 247, 0.5, 0.5, -10, 10)
	CharacterText:setAlpha(0)
	CharacterText:setText(Engine[0xF9F1239CFD921FE](AddLocalizeGameModeToString(0x3C8AC9335AFAA5E)))
	CharacterText:setTTF("ttmussels_regular")
	CharacterText:setLetterSpacing(2)
	CharacterText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(CharacterText)
	self.CharacterText = CharacterText
	self:mergeStateConditions({
		{
			stateName = "CharacterRestricted",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f3_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isRestricted")
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, "isRestricted", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isRestricted",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	ScaleWidgetToLabelCentered(self, Text, 15)
	ScaleWidgetToLabelCentered(self, CharacterText, 15)
	return self
end
CoD.RestrictedItemWarningText.__resetProperties = function(f6_arg0)
	f6_arg0.Text:completeAnimation()
	f6_arg0.Warning:completeAnimation()
	f6_arg0.bg:completeAnimation()
	f6_arg0.CharacterText:completeAnimation()
	f6_arg0.Text:setAlpha(0)
	f6_arg0.Text:setText(LocalizeToUpperString(0x3293C2F8FE5A04C))
	f6_arg0.Warning:setLeftRight(0, 0, 0, 38)
	f6_arg0.Warning:setTopBottom(0.5, 0.5, -15, 15)
	f6_arg0.Warning:setRGB(0.82, 0.08, 0.17)
	f6_arg0.Warning:setAlpha(0)
	f6_arg0.Warning:setImage(RegisterImage(0xDF501A88BB578F))
	f6_arg0.bg:setAlpha(0)
	f6_arg0.CharacterText:setAlpha(0)
	f6_arg0.CharacterText:setText(Engine[0xF9F1239CFD921FE](AddLocalizeGameModeToString(0x3C8AC9335AFAA5E)))
end
CoD.RestrictedItemWarningText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	CharacterRestricted = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.bg:completeAnimation()
			f8_arg0.bg:setAlpha(0.8)
			f8_arg0.clipFinished(f8_arg0.bg)
			f8_arg0.Warning:completeAnimation()
			f8_arg0.Warning:setAlpha(1)
			f8_arg0.Warning:setImage(RegisterImage(0xDF501A88BB578F))
			f8_arg0.clipFinished(f8_arg0.Warning)
			f8_arg0.Text:completeAnimation()
			f8_arg0.Text:setAlpha(0)
			f8_arg0.Text:setText(LocalizeToUpperString(0x3293C2F8FE5A04C))
			f8_arg0.clipFinished(f8_arg0.Text)
			f8_arg0.CharacterText:completeAnimation()
			f8_arg0.CharacterText:setAlpha(1)
			f8_arg0.CharacterText:setText(Engine[0xF9F1239CFD921FE](AddLocalizeGameModeToString(0x3C8AC9335AFAA5E)))
			f8_arg0.clipFinished(f8_arg0.CharacterText)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.bg:completeAnimation()
			f9_arg0.bg:setAlpha(0.8)
			f9_arg0.clipFinished(f9_arg0.bg)
			f9_arg0.Warning:completeAnimation()
			f9_arg0.Warning:setLeftRight(0, 0, 0, 40)
			f9_arg0.Warning:setTopBottom(0.5, 0.5, -18.5, 14.5)
			f9_arg0.Warning:setRGB(0.82, 0.08, 0.17)
			f9_arg0.Warning:setAlpha(1)
			f9_arg0.Warning:setImage(RegisterImage(0xDF501A88BB578F))
			f9_arg0.clipFinished(f9_arg0.Warning)
			f9_arg0.Text:completeAnimation()
			f9_arg0.Text:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.Text)
			f9_arg0.CharacterText:completeAnimation()
			f9_arg0.CharacterText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CharacterText)
		end,
	},
}
CoD.RestrictedItemWarningText.__onClose = function(f10_arg0)
	f10_arg0.Text:close()
	f10_arg0.CharacterText:close()
end
