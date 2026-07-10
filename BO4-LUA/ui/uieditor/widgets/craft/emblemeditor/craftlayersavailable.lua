CoD.CraftLayersAvailable = InheritFrom(LUI.UIElement)
CoD.CraftLayersAvailable.__defaultWidth = 1016
CoD.CraftLayersAvailable.__defaultHeight = 20
CoD.CraftLayersAvailable.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CraftLayersAvailable)
	self.id = "CraftLayersAvailable"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local temporary = LUI.UIText.new(0, 0, 0, 567, 0, 0, 1.5, 21.5)
	temporary:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	temporary:setText(LocalizeStringWithDatasource("Emblem.EmblemProperties.layersAvailable", f1_arg1, 0x3C805518F0500BA))
	temporary:setTTF("dinnext_regular")
	temporary:setLetterSpacing(1)
	temporary:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	temporary:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(temporary)
	self.temporary = temporary
	local notEnoughLayersText = LUI.UIText.new(0, 0, 405, 972, 0, 0, 1.5, 21.5)
	notEnoughLayersText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	notEnoughLayersText:setText(Engine[0xF9F1239CFD921FE](0xA5A029CEE54E27D))
	notEnoughLayersText:setTTF("dinnext_regular")
	notEnoughLayersText:setLetterSpacing(1)
	notEnoughLayersText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	notEnoughLayersText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(notEnoughLayersText)
	self.notEnoughLayersText = notEnoughLayersText
	self:mergeStateConditions({
		{
			stateName = "NotEnoughLayers",
			condition = function(menu, element, event)
				return not CoD.CraftUtility.EmblemChooseIcon_CanFitSelectedDecalGroup(self, f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["Emblem.EmblemProperties.layersAvailable"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersAvailable",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CraftLayersAvailable.__resetProperties = function(f4_arg0)
	f4_arg0.notEnoughLayersText:completeAnimation()
	f4_arg0.temporary:completeAnimation()
	f4_arg0.notEnoughLayersText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	f4_arg0.notEnoughLayersText:setAlpha(1)
	f4_arg0.temporary:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
end
CoD.CraftLayersAvailable.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.notEnoughLayersText:completeAnimation()
			f5_arg0.notEnoughLayersText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.notEnoughLayersText)
		end,
	},
	NotEnoughLayers = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.temporary:completeAnimation()
			f6_arg0.temporary:setRGB(1, 0, 0)
			f6_arg0.clipFinished(f6_arg0.temporary)
			f6_arg0.notEnoughLayersText:completeAnimation()
			f6_arg0.notEnoughLayersText:setRGB(1, 0, 0)
			f6_arg0.notEnoughLayersText:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.notEnoughLayersText)
		end,
	},
}
