CoD.DupeMarker = InheritFrom(LUI.UIElement)
CoD.DupeMarker.__defaultWidth = 364
CoD.DupeMarker.__defaultHeight = 20
CoD.DupeMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DupeMarker)
	self.id = "DupeMarker"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RerollLabel = LUI.UIText.new(0, 0, 24.5, 361.5, 0, 0, 2, 20)
	RerollLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	RerollLabel:setText(LocalizeToUpperString(0x7A11286F9FD7520))
	RerollLabel:setTTF("dinnext_regular")
	RerollLabel:setLetterSpacing(1)
	RerollLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RerollLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(RerollLabel)
	self.RerollLabel = RerollLabel
	local RerollIcon = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	RerollIcon:setRGB(0.54, 0.87, 0.31)
	RerollIcon:setImage(RegisterImage(0xB259D817A83EFDB))
	self:addElement(RerollIcon)
	self.RerollIcon = RerollIcon
	local DupeLabel = LUI.UIText.new(0, 0, 24.5, 361.5, 0, 0, 2, 20)
	DupeLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	DupeLabel:setText(LocalizeToUpperString(0xA75B4742BD9E4D0))
	DupeLabel:setTTF("dinnext_regular")
	DupeLabel:setLetterSpacing(1)
	DupeLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DupeLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(DupeLabel)
	self.DupeLabel = DupeLabel
	local DupeIcon = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	DupeIcon:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	DupeIcon:setImage(RegisterImage(0xF395928C19E9B99))
	self:addElement(DupeIcon)
	self.DupeIcon = DupeIcon
	local ReserveLabel = LUI.UIText.new(0, 0, 24.5, 361.5, 0, 0, 2, 20)
	ReserveLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ReserveLabel:setText(LocalizeToUpperString(0x27653EDDA8414F2))
	ReserveLabel:setTTF("dinnext_regular")
	ReserveLabel:setLetterSpacing(1)
	ReserveLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ReserveLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ReserveLabel)
	self.ReserveLabel = ReserveLabel
	local ReserveIcon = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	ReserveIcon:setRGB(0.52, 0.6, 0.68)
	ReserveIcon:setImage(RegisterImage(0x3AFA9E5CE99FEDF))
	self:addElement(ReserveIcon)
	self.ReserveIcon = ReserveIcon
	self:mergeStateConditions({
		{
			stateName = "Dupe",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dupe")
			end,
		},
		{
			stateName = "Reroll",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "reroll")
			end,
		},
		{
			stateName = "ReserveItem",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "lootType", LuaEnum.LOOT_TYPE.CONTRABAND)
			end,
		},
	})
	self:linkToElementModel(self, "dupe", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dupe",
		})
	end)
	self:linkToElementModel(self, "reroll", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "reroll",
		})
	end)
	self:linkToElementModel(self, "lootType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lootType",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DupeMarker.__resetProperties = function(f8_arg0)
	f8_arg0.RerollIcon:completeAnimation()
	f8_arg0.DupeIcon:completeAnimation()
	f8_arg0.RerollLabel:completeAnimation()
	f8_arg0.DupeLabel:completeAnimation()
	f8_arg0.ReserveLabel:completeAnimation()
	f8_arg0.ReserveIcon:completeAnimation()
	f8_arg0.RerollIcon:setAlpha(1)
	f8_arg0.DupeIcon:setAlpha(1)
	f8_arg0.RerollLabel:setAlpha(1)
	f8_arg0.DupeLabel:setAlpha(1)
	f8_arg0.ReserveLabel:setAlpha(1)
	f8_arg0.ReserveIcon:setAlpha(1)
end
CoD.DupeMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(6)
			f9_arg0.RerollLabel:completeAnimation()
			f9_arg0.RerollLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RerollLabel)
			f9_arg0.RerollIcon:completeAnimation()
			f9_arg0.RerollIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RerollIcon)
			f9_arg0.DupeLabel:completeAnimation()
			f9_arg0.DupeLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DupeLabel)
			f9_arg0.DupeIcon:completeAnimation()
			f9_arg0.DupeIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DupeIcon)
			f9_arg0.ReserveLabel:completeAnimation()
			f9_arg0.ReserveLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ReserveLabel)
			f9_arg0.ReserveIcon:completeAnimation()
			f9_arg0.ReserveIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ReserveIcon)
		end,
	},
	Dupe = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.RerollLabel:completeAnimation()
			f10_arg0.RerollLabel:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RerollLabel)
			f10_arg0.RerollIcon:completeAnimation()
			f10_arg0.RerollIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.RerollIcon)
			f10_arg0.ReserveLabel:completeAnimation()
			f10_arg0.ReserveLabel:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ReserveLabel)
			f10_arg0.ReserveIcon:completeAnimation()
			f10_arg0.ReserveIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ReserveIcon)
		end,
	},
	Reroll = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.DupeLabel:completeAnimation()
			f11_arg0.DupeLabel:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DupeLabel)
			f11_arg0.DupeIcon:completeAnimation()
			f11_arg0.DupeIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DupeIcon)
			f11_arg0.ReserveLabel:completeAnimation()
			f11_arg0.ReserveLabel:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ReserveLabel)
			f11_arg0.ReserveIcon:completeAnimation()
			f11_arg0.ReserveIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ReserveIcon)
		end,
	},
	ReserveItem = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(6)
			f12_arg0.RerollLabel:completeAnimation()
			f12_arg0.RerollLabel:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RerollLabel)
			f12_arg0.RerollIcon:completeAnimation()
			f12_arg0.RerollIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RerollIcon)
			f12_arg0.DupeLabel:completeAnimation()
			f12_arg0.DupeLabel:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DupeLabel)
			f12_arg0.DupeIcon:completeAnimation()
			f12_arg0.DupeIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.DupeIcon)
			f12_arg0.ReserveLabel:completeAnimation()
			f12_arg0.ReserveLabel:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ReserveLabel)
			f12_arg0.ReserveIcon:completeAnimation()
			f12_arg0.ReserveIcon:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ReserveIcon)
		end,
	},
}
