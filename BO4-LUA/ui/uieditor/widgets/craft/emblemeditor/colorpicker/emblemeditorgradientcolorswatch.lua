require("x64:5670bad185ec52")
require("x64:b6da5f5f17e9c79")
require("x64:a86bdd41c06859a")
CoD.EmblemEditorGradientColorSwatch = InheritFrom(LUI.UIElement)
CoD.EmblemEditorGradientColorSwatch.__defaultWidth = 1020
CoD.EmblemEditorGradientColorSwatch.__defaultHeight = 240
CoD.EmblemEditorGradientColorSwatch.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorGradientColorSwatch)
	self.id = "EmblemEditorGradientColorSwatch"
	self.soundSet = "SelectColor_ColorSwatchPicker"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ColorPickerBkgd0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ColorPickerBkgd0:setAlpha(0.5)
	ColorPickerBkgd0:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	ColorPickerBkgd0:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(ColorPickerBkgd0)
	self.ColorPickerBkgd0 = ColorPickerBkgd0
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 1020, 0, 0, 0, 240)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local BarBacking = LUI.UIImage.new(0, 0, 0, 1020, 0, 0, 0, 240)
	BarBacking:setRGB(0, 0, 0)
	BarBacking:setAlpha(0.3)
	self:addElement(BarBacking)
	self.BarBacking = BarBacking
	local ColorBacking = LUI.UIImage.new(0, 0, 0, 1020, 0, 0, 0, 202)
	ColorBacking:setRGB(0, 0, 0)
	ColorBacking:setAlpha(0.3)
	self:addElement(ColorBacking)
	self.ColorBacking = ColorBacking
	local FooterStripe1 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -38, 0)
	FooterStripe1:setAlpha(0.1)
	FooterStripe1:setImage(RegisterImage(0xC7A051F5EFC70E5))
	FooterStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	FooterStripe1:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe1:setupNineSliceShader(245, 40)
	self:addElement(FooterStripe1)
	self.FooterStripe1 = FooterStripe1
	local lastSavedColor = CoD.EmblemColorSaved.new(f1_arg0, f1_arg1, 0, 0, 69, 126, 0, 0, 6, 196)
	lastSavedColor:linkToElementModel(self, nil, false, function(model)
		lastSavedColor:setModel(model, f1_arg1)
	end)
	lastSavedColor:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		if CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.colorNum", Enum[0x5B86390D74F3997][0x2EFDD03AB2AE52D]) then
			CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, f1_arg1)
			SetProperty(self, "isColor0NoColor", false)
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.colorNum", Enum[0x5B86390D74F3997][0x2EFDC03AB2AE37A]) then
			CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, f1_arg1)
			SetProperty(self, "isColor1NoColor", false)
		end
		return f3_local0
	end)
	self:addElement(lastSavedColor)
	self.lastSavedColor = lastSavedColor
	local emblemColorSwatch = LUI.UIList.new(f1_arg0, f1_arg1, -1, 0, nil, false, false, false, false)
	emblemColorSwatch:setLeftRight(0, 0, 142, 1014)
	emblemColorSwatch:setTopBottom(0, 0, 6, 196)
	emblemColorSwatch:setWidgetType(CoD.EmblemColorElement)
	emblemColorSwatch:setHorizontalCount(13)
	emblemColorSwatch:setVerticalCount(9)
	emblemColorSwatch:setSpacing(-1)
	emblemColorSwatch:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	emblemColorSwatch:setDataSource("EmblemColorList")
	emblemColorSwatch:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		if CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.colorNum", Enum[0x5B86390D74F3997][0x2EFDD03AB2AE52D]) then
			CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, f1_arg1)
			SetProperty(self, "isColor0NoColor", false)
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.colorNum", Enum[0x5B86390D74F3997][0x2EFDC03AB2AE37A]) then
			CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, f1_arg1)
			SetProperty(self, "isColor1NoColor", false)
		end
		return f4_local0
	end)
	self:addElement(emblemColorSwatch)
	self.emblemColorSwatch = emblemColorSwatch
	local toggleColorMixerButton = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 16, 366, 0, 0, 202, 248)
	toggleColorMixerButton:mergeStateConditions({
		{
			stateName = "KM",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	toggleColorMixerButton:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(toggleColorMixerButton, f7_arg1)
	end)
	local dividerV = toggleColorMixerButton
	local noColor = toggleColorMixerButton.subscribeToModel
	local dividerH = Engine[0x4DF5CFBC1771947](f1_arg1)
	noColor(dividerV, dividerH.LastInput, function(f8_arg0)
		f1_arg0:updateElementState(toggleColorMixerButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	toggleColorMixerButton.label:setText(Engine[0xF9F1239CFD921FE](0xC8E4DA2A7FB0D28))
	toggleColorMixerButton:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			toggleColorMixerButton.buttonPromptImage:setImage(RegisterImage(f9_local0))
		end
	end)
	self:addElement(toggleColorMixerButton)
	self.toggleColorMixerButton = toggleColorMixerButton
	noColor = CoD.EmblemColorSaved.new(f1_arg0, f1_arg1, 0, 0, 7.5, 64.5, 0, 0, 6, 196)
	noColor.colorElement:setImage(RegisterImage(0xE392CD3185E82B2))
	noColor:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		if CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.colorNum", Enum[0x5B86390D74F3997][0x2EFDD03AB2AE52D]) then
			CoD.CraftUtility.EmblemChooseColor_SelectNoColor(self, element, f1_arg1)
			SetProperty(self, "isColor0NoColor", true)
		elseif CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.colorNum", Enum[0x5B86390D74F3997][0x2EFDC03AB2AE37A]) then
			CoD.CraftUtility.EmblemChooseColor_SelectNoColor(self, element, f1_arg1)
			SetProperty(self, "isColor1NoColor", true)
		end
		return f10_local0
	end)
	noColor:registerEventHandler("lose_focus", function(element, event)
		local f11_local0 = nil
		if element.loseFocus then
			f11_local0 = element:loseFocus(event)
		elseif element.super.loseFocus then
			f11_local0 = element.super:loseFocus(event)
		end
		CoD.CraftUtility.EmblemChooseColor_NoColorLoseFocus(self, element, f1_arg1)
		return f11_local0
	end)
	self:addElement(noColor)
	self.noColor = noColor
	dividerV = LUI.UIImage.new(0.5, 0.5, -379.5, -375.5, 0, 0, 0, 202)
	dividerV:setAlpha(0.2)
	dividerV:setImage(RegisterImage(0xC49B0C8991A541F))
	dividerV:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	dividerV:setShaderVector(0, 0, 0, 0, 0)
	dividerV:setupNineSliceShader(4, 8)
	self:addElement(dividerV)
	self.dividerV = dividerV
	dividerH = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 201, 205)
	dividerH:setAlpha(0.2)
	dividerH:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH:setShaderVector(0, 0, 0, 0, 0)
	dividerH:setupNineSliceShader(8, 4)
	self:addElement(dividerH)
	self.dividerH = dividerH
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEmblemEditorPropertyEqualTo(f1_arg1, "isGradientMode", 1) and CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg1, "colorMode", Enum[0xC594B064FEDD0D6][0xE692F9BF30BA124])
			end,
		},
	})
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = DataSources.EmblemProperties.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.isGradientMode, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "isGradientMode",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = DataSources.EmblemProperties.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.colorMode, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "colorMode",
		})
	end, false)
	lastSavedColor.id = "lastSavedColor"
	emblemColorSwatch.id = "emblemColorSwatch"
	noColor.id = "noColor"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorGradientColorSwatch.__resetProperties = function(f15_arg0)
	f15_arg0.emblemColorSwatch:completeAnimation()
	f15_arg0.lastSavedColor:completeAnimation()
	f15_arg0.ColorPickerBkgd0:completeAnimation()
	f15_arg0.toggleColorMixerButton:completeAnimation()
	f15_arg0.noColor:completeAnimation()
	f15_arg0.NoiseTiledBacking:completeAnimation()
	f15_arg0.BarBacking:completeAnimation()
	f15_arg0.ColorBacking:completeAnimation()
	f15_arg0.FooterStripe1:completeAnimation()
	f15_arg0.dividerV:completeAnimation()
	f15_arg0.dividerH:completeAnimation()
	f15_arg0.Frame:completeAnimation()
	f15_arg0.emblemColorSwatch:setAlpha(1)
	f15_arg0.lastSavedColor:setAlpha(1)
	f15_arg0.ColorPickerBkgd0:setAlpha(0.5)
	f15_arg0.toggleColorMixerButton:setAlpha(1)
	f15_arg0.noColor:setAlpha(1)
	f15_arg0.NoiseTiledBacking:setAlpha(0.5)
	f15_arg0.BarBacking:setAlpha(0.3)
	f15_arg0.ColorBacking:setAlpha(0.3)
	f15_arg0.FooterStripe1:setAlpha(0.1)
	f15_arg0.dividerV:setAlpha(0.2)
	f15_arg0.dividerH:setAlpha(0.2)
	f15_arg0.Frame:setAlpha(0.2)
end
CoD.EmblemEditorGradientColorSwatch.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(12)
			f16_arg0.ColorPickerBkgd0:completeAnimation()
			f16_arg0.ColorPickerBkgd0:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ColorPickerBkgd0)
			f16_arg0.NoiseTiledBacking:completeAnimation()
			f16_arg0.NoiseTiledBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.NoiseTiledBacking)
			f16_arg0.Frame:completeAnimation()
			f16_arg0.Frame:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Frame)
			f16_arg0.BarBacking:completeAnimation()
			f16_arg0.BarBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.BarBacking)
			f16_arg0.ColorBacking:completeAnimation()
			f16_arg0.ColorBacking:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ColorBacking)
			f16_arg0.FooterStripe1:completeAnimation()
			f16_arg0.FooterStripe1:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.FooterStripe1)
			f16_arg0.lastSavedColor:completeAnimation()
			f16_arg0.lastSavedColor:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.lastSavedColor)
			f16_arg0.emblemColorSwatch:completeAnimation()
			f16_arg0.emblemColorSwatch:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.emblemColorSwatch)
			f16_arg0.toggleColorMixerButton:completeAnimation()
			f16_arg0.toggleColorMixerButton:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.toggleColorMixerButton)
			f16_arg0.noColor:completeAnimation()
			f16_arg0.noColor:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.noColor)
			f16_arg0.dividerV:completeAnimation()
			f16_arg0.dividerV:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.dividerV)
			f16_arg0.dividerH:completeAnimation()
			f16_arg0.dividerH:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.dividerH)
		end,
	},
	Visible = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.EmblemEditorGradientColorSwatch.__onClose = function(f18_arg0)
	f18_arg0.lastSavedColor:close()
	f18_arg0.emblemColorSwatch:close()
	f18_arg0.toggleColorMixerButton:close()
	f18_arg0.noColor:close()
end
