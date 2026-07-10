require("x64:d596b8a923ef2ce")
CoD.EmblemEditorColorMixerContainer = InheritFrom(LUI.UIElement)
CoD.EmblemEditorColorMixerContainer.__defaultWidth = 880
CoD.EmblemEditorColorMixerContainer.__defaultHeight = 240
CoD.EmblemEditorColorMixerContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorColorMixerContainer)
	self.id = "EmblemEditorColorMixerContainer"
	self.soundSet = "SelectColor_ColorMixer"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local colorMixer = CoD.EmblemEditorColorMixer.new(f1_arg0, f1_arg1, 0, 0, 0, 880, 0, 0, 0, 240)
	colorMixer:subscribeToGlobalModel(f1_arg1, "EmblemSelectedLayerEdittingColor", nil, function(model)
		colorMixer:setModel(model, f1_arg1)
	end)
	self:addElement(colorMixer)
	self.colorMixer = colorMixer
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg1, "colorMode", Enum[0xC594B064FEDD0D6][0xC6A5FECEA7EADAA])
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.EmblemProperties.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.colorMode, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "colorMode",
		})
	end, false)
	colorMixer.id = "colorMixer"
	self.__defaultFocus = colorMixer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorColorMixerContainer.__resetProperties = function(f5_arg0)
	f5_arg0.colorMixer:completeAnimation()
	f5_arg0.colorMixer:setAlpha(1)
end
CoD.EmblemEditorColorMixerContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.colorMixer:completeAnimation()
			f6_arg0.colorMixer:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.colorMixer)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.EmblemEditorColorMixerContainer.__onClose = function(f8_arg0)
	f8_arg0.colorMixer:close()
end
