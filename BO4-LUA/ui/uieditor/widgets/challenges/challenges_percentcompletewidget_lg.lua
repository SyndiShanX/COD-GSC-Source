CoD.Challenges_PercentCompleteWidget_LG = InheritFrom(LUI.UIElement)
CoD.Challenges_PercentCompleteWidget_LG.__defaultWidth = 240
CoD.Challenges_PercentCompleteWidget_LG.__defaultHeight = 240
CoD.Challenges_PercentCompleteWidget_LG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_PercentCompleteWidget_LG)
	self.id = "Challenges_PercentCompleteWidget_LG"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CompleteImage = LUI.UIImage.new(0, 1, -24, 24, 0, 1, -24, 24)
	CompleteImage:setAlpha(0)
	CompleteImage:setImage(RegisterImage(0xBFD3F2DDDC476B1))
	self:addElement(CompleteImage)
	self.CompleteImage = CompleteImage
	local BackgroundRing = LUI.UIImage.new(0, 1, -24, 24, 0, 1, -24, 24)
	BackgroundRing:setRGB(0.36, 0.36, 0.36)
	BackgroundRing:setAlpha(0.35)
	BackgroundRing:setImage(RegisterImage(0x47AA86BE90A2F0C))
	self:addElement(BackgroundRing)
	self.BackgroundRing = BackgroundRing
	local CrossLines = LUI.UIImage.new(0.5, 0.5, -144, 144, 0.5, 0.5, -144, 144)
	CrossLines:setRGB(0.36, 0.36, 0.36)
	CrossLines:setAlpha(0.35)
	CrossLines:setImage(RegisterImage(0xC22CB98493B489B))
	self:addElement(CrossLines)
	self.CrossLines = CrossLines
	local percentCompleteCircle = LUI.UIImage.new(0, 1, -24, 24, 0, 1, -24, 24)
	percentCompleteCircle:setRGB(0.95, 0.91, 0.11)
	percentCompleteCircle:setImage(RegisterImage(0xF00B924BA10A94C))
	percentCompleteCircle:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	percentCompleteCircle:setShaderVector(1, 0.5, 0, 0, 0)
	percentCompleteCircle:setShaderVector(2, 0.5, 0, 0, 0)
	percentCompleteCircle:setShaderVector(3, 0, 0, 0, 0)
	percentCompleteCircle:setShaderVector(4, 0, 0, 0, 0)
	percentCompleteCircle:linkToElementModel(self, "percentComplete", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			percentCompleteCircle:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(percentCompleteCircle)
	self.percentCompleteCircle = percentCompleteCircle
	local percentText = LUI.UIText.new(0.5, 0.5, -120, 118, 0.5, 0.5, 201, 261)
	percentText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	percentText:setAlpha(0.8)
	percentText:setTTF("ttmussels_demibold")
	percentText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	percentText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	percentText:linkToElementModel(self, "percentComplete", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			percentText:setText(NumberAsPercentRounded(f3_local0))
		end
	end)
	self:addElement(percentText)
	self.percentText = percentText
	local Name = LUI.UIText.new(0.5, 0.5, -120, 118, 0.5, 0.5, 160, 185)
	Name:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Name:setAlpha(0.8)
	Name:setText("")
	Name:setTTF("ttmussels_regular")
	Name:setLetterSpacing(3)
	Name:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(Name)
	self.Name = Name
	local Icon = LUI.UIImage.new(0.5, 0.5, -150, 150, 0.5, 0.5, -150, 150)
	Icon:setImage(RegisterImage(0x8F9972AD987B75F))
	self:addElement(Icon)
	self.Icon = Icon
	self:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "percentComplete", 1)
			end,
		},
	})
	self:linkToElementModel(self, "percentComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percentComplete",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_PercentCompleteWidget_LG.__resetProperties = function(f6_arg0)
	f6_arg0.percentCompleteCircle:completeAnimation()
	f6_arg0.BackgroundRing:completeAnimation()
	f6_arg0.CrossLines:completeAnimation()
	f6_arg0.CompleteImage:completeAnimation()
	f6_arg0.percentText:completeAnimation()
	f6_arg0.Name:completeAnimation()
	f6_arg0.percentCompleteCircle:setAlpha(1)
	f6_arg0.BackgroundRing:setAlpha(0.35)
	f6_arg0.CrossLines:setAlpha(0.35)
	f6_arg0.CompleteImage:setLeftRight(0, 1, -24, 24)
	f6_arg0.CompleteImage:setTopBottom(0, 1, -24, 24)
	f6_arg0.CompleteImage:setAlpha(0)
	f6_arg0.CompleteImage:setImage(RegisterImage(0xBFD3F2DDDC476B1))
	f6_arg0.percentText:setLeftRight(0.5, 0.5, -120, 118)
	f6_arg0.percentText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f6_arg0.percentText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	f6_arg0.Name:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
end
CoD.Challenges_PercentCompleteWidget_LG.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Complete = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(6)
			f8_arg0.CompleteImage:completeAnimation()
			f8_arg0.CompleteImage:setLeftRight(0, 0, 3, 93)
			f8_arg0.CompleteImage:setTopBottom(0, 0, 306, 396)
			f8_arg0.CompleteImage:setAlpha(1)
			f8_arg0.CompleteImage:setImage(RegisterImage(0xDF21E31DF98CD9E))
			f8_arg0.clipFinished(f8_arg0.CompleteImage)
			f8_arg0.BackgroundRing:completeAnimation()
			f8_arg0.BackgroundRing:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.BackgroundRing)
			f8_arg0.CrossLines:completeAnimation()
			f8_arg0.CrossLines:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.CrossLines)
			f8_arg0.percentCompleteCircle:completeAnimation()
			f8_arg0.percentCompleteCircle:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.percentCompleteCircle)
			f8_arg0.percentText:completeAnimation()
			f8_arg0.percentText:setLeftRight(0.5, 0.5, -27, 211)
			f8_arg0.percentText:setRGB(ColorSet.T8_PC_CHAT_PARTY.r, ColorSet.T8_PC_CHAT_PARTY.g, ColorSet.T8_PC_CHAT_PARTY.b)
			f8_arg0.percentText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
			f8_arg0.clipFinished(f8_arg0.percentText)
			f8_arg0.Name:completeAnimation()
			f8_arg0.Name:setRGB(ColorSet.T8_PC_CHAT_PARTY.r, ColorSet.T8_PC_CHAT_PARTY.g, ColorSet.T8_PC_CHAT_PARTY.b)
			f8_arg0.clipFinished(f8_arg0.Name)
		end,
	},
}
CoD.Challenges_PercentCompleteWidget_LG.__onClose = function(f9_arg0)
	f9_arg0.percentCompleteCircle:close()
	f9_arg0.percentText:close()
end
