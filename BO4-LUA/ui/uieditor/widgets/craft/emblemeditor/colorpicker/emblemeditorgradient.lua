require("x64:f94c92ca68ec385")
require("x64:7f43d779dfa5a22")
require("x64:a235d83c28a3a66")
CoD.EmblemEditorGradient = InheritFrom(LUI.UIElement)
CoD.EmblemEditorGradient.__defaultWidth = 880
CoD.EmblemEditorGradient.__defaultHeight = 240
CoD.EmblemEditorGradient.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorGradient)
	self.id = "EmblemEditorGradient"
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
	local BarBacking = LUI.UIImage.new(0, 0, 0, 880, 0, 0, 0, 240)
	BarBacking:setRGB(0, 0, 0)
	BarBacking:setAlpha(0.3)
	self:addElement(BarBacking)
	self.BarBacking = BarBacking
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local gradientSliderWidget = CoD.EmblemEditorGradientTypeButton.new(f1_arg0, f1_arg1, 0, 0, 37.5, 844.5, 0, 0, 160, 240)
	gradientSliderWidget:mergeStateConditions({
		{
			stateName = "SingleSliderState",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemSelectedLayerProperties.gradient_type", Enum[0xCA0CB02B4A12602][0xA7C637A09DA3D16])
			end,
		},
		{
			stateName = "ContourState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemSelectedLayerProperties.gradient_type", Enum[0xCA0CB02B4A12602][0xA7C637A09DA3D16])
			end,
		},
	})
	local gradientColor1 = gradientSliderWidget
	local gradientColor0 = gradientSliderWidget.subscribeToModel
	local GradientTypeList = Engine[0x4DF5CFBC1771947](f1_arg1)
	gradientColor0(gradientColor1, GradientTypeList["Emblem.EmblemSelectedLayerProperties.gradient_type"], function(f4_arg0)
		f1_arg0:updateElementState(gradientSliderWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "Emblem.EmblemSelectedLayerProperties.gradient_type",
		})
	end, false)
	self:addElement(gradientSliderWidget)
	self.gradientSliderWidget = gradientSliderWidget
	gradientColor0 = CoD.EmblemGradientColorButton.new(f1_arg0, f1_arg1, 0, 0, 37.5, 417.5, 0, 0, 96, 144)
	gradientColor0:mergeStateConditions({
		{
			stateName = "NoColor",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Emblem.EmblemProperties.isColor0NoColor", 1)
			end,
		},
	})
	GradientTypeList = gradientColor0
	gradientColor1 = gradientColor0.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	gradientColor1(GradientTypeList, f1_local8["Emblem.EmblemProperties.isColor0NoColor"], function(f6_arg0)
		f1_arg0:updateElementState(gradientColor0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "Emblem.EmblemProperties.isColor0NoColor",
		})
	end, false)
	gradientColor0:subscribeToGlobalModel(f1_arg1, "EmblemSelectedLayerColor", "color", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			gradientColor0.color:setRGB(f7_local0)
		end
	end)
	GradientTypeList = gradientColor0
	gradientColor1 = gradientColor0.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	gradientColor1(GradientTypeList, f1_local8["Emblem.EmblemProperties.isGradientMode"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	GradientTypeList = gradientColor0
	gradientColor1 = gradientColor0.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	gradientColor1(GradientTypeList, f1_local8["Emblem.EmblemProperties.colorMode"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	gradientColor0:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.CraftUtility.EmblemGradient_Color0GainFocus(self, self.gradientColor0, f1_arg1)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(gradientColor0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.CraftUtility.EmblemGradient_BackFromColorPicker(self, element, menu, controller)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.CraftUtility.EmblemGradient_ShowSwatchContainer(self, element, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(gradientColor0)
	self.gradientColor0 = gradientColor0
	gradientColor1 = CoD.EmblemGradientColorButton.new(f1_arg0, f1_arg1, 0, 0, 464.5, 844.5, 0, 0, 96, 144)
	gradientColor1:mergeStateConditions({
		{
			stateName = "NoColor",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Emblem.EmblemProperties.isColor1NoColor", 1)
			end,
		},
	})
	f1_local8 = gradientColor1
	GradientTypeList = gradientColor1.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	GradientTypeList(f1_local8, f1_local9["Emblem.EmblemProperties.isColor1NoColor"], function(f14_arg0)
		f1_arg0:updateElementState(gradientColor1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "Emblem.EmblemProperties.isColor1NoColor",
		})
	end, false)
	gradientColor1:subscribeToGlobalModel(f1_arg1, "EmblemSelectedLayerColor1", "color", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			gradientColor1.color:setRGB(f15_local0)
		end
	end)
	f1_local8 = gradientColor1
	GradientTypeList = gradientColor1.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	GradientTypeList(f1_local8, f1_local9["Emblem.EmblemProperties.isGradientMode"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local8 = gradientColor1
	GradientTypeList = gradientColor1.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	GradientTypeList(f1_local8, f1_local9["Emblem.EmblemProperties.colorMode"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	gradientColor1:registerEventHandler("gain_focus", function(element, event)
		local f18_local0 = nil
		if element.gainFocus then
			f18_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f18_local0 = element.super:gainFocus(event)
		end
		CoD.CraftUtility.EmblemGradient_Color1GainFocus(self, self.gradientColor1, f1_arg1)
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f18_local0
	end)
	f1_arg0:AddButtonCallbackFunction(gradientColor1, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.CraftUtility.EmblemGradient_BackFromColorPicker(self, element, menu, controller)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.CraftUtility.EmblemGradient_ShowSwatchContainer(self, element, menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and not CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		elseif CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 1) and CoD.ModelUtility.IsModelValueEqualToEnum(controller, "Emblem.EmblemProperties.colorMode", Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(gradientColor1)
	self.gradientColor1 = gradientColor1
	GradientTypeList = LUI.UIList.new(f1_arg0, f1_arg1, 21, 0, nil, false, false, false, false)
	GradientTypeList:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsGradientButtonSelected(self, element, f1_arg1) and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	f1_local9 = GradientTypeList
	f1_local8 = GradientTypeList.subscribeToModel
	local f1_local10 = DataSources.EmblemSelectedLayerProperties.getModel(f1_arg1)
	f1_local8(f1_local9, f1_local10.gradient_type, function(f23_arg0)
		f1_arg0:updateElementState(GradientTypeList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "gradient_type",
		})
	end, false)
	GradientTypeList:appendEventHandler("input_source_changed", function(f24_arg0, f24_arg1)
		f24_arg1.menu = f24_arg1.menu or f1_arg0
		f1_arg0:updateElementState(GradientTypeList, f24_arg1)
	end)
	f1_local9 = GradientTypeList
	f1_local8 = GradientTypeList.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local9, f1_local10.LastInput, function(f25_arg0)
		f1_arg0:updateElementState(GradientTypeList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	GradientTypeList:setLeftRight(0, 0, 37.5, 844.5)
	GradientTypeList:setTopBottom(0, 0, 32.5, 72.5)
	GradientTypeList:setWidgetType(CoD.CraftGradientButton)
	GradientTypeList:setHorizontalCount(3)
	GradientTypeList:setSpacing(21)
	GradientTypeList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	GradientTypeList:setDataSource("GradientButtonList")
	GradientTypeList:linkToElementModel(GradientTypeList, "disabled", true, function(model, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	GradientTypeList:registerEventHandler("gain_focus", function(element, event)
		local f27_local0 = nil
		if element.gainFocus then
			f27_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f27_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f27_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GradientTypeList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(GradientTypeList)
	self.GradientTypeList = GradientTypeList
	self:mergeStateConditions({
		{
			stateName = "Color0State",
			condition = function(menu, element, event)
				local f30_local0 = CoD.CraftUtility.IsEmblemEditorPropertyEqualTo(f1_arg1, "isGradientMode", 1)
				if f30_local0 then
					f30_local0 = CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg1, "colorContainerState", Enum[0x5B86390D74F3997][0x83372F1C29BD7F3])
					if f30_local0 then
						f30_local0 = CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg1, "colorMode", Enum[0x5B86390D74F3997][0x2EFDD03AB2AE52D])
					end
				end
				return f30_local0
			end,
		},
		{
			stateName = "Color1State",
			condition = function(menu, element, event)
				local f31_local0 = CoD.CraftUtility.IsEmblemEditorPropertyEqualTo(f1_arg1, "isGradientMode", 1)
				if f31_local0 then
					f31_local0 = CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg1, "colorContainerState", Enum[0x5B86390D74F3997][0x83372F1C29BD7F3])
					if f31_local0 then
						f31_local0 = CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg1, "colorMode", Enum[0x5B86390D74F3997][0x2EFDC03AB2AE37A])
					end
				end
				return f31_local0
			end,
		},
		{
			stateName = "Visible_NotEditing",
			condition = function(menu, element, event)
				return CoD.CraftUtility.IsEmblemEditorPropertyEqualTo(f1_arg1, "isGradientMode", 1) and CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg1, "colorContainerState", Enum[0x5B86390D74F3997][0x83372F1C29BD7F3])
			end,
		},
	})
	f1_local9 = self
	f1_local8 = self.subscribeToModel
	f1_local10 = DataSources.EmblemProperties.getModel(f1_arg1)
	f1_local8(f1_local9, f1_local10.isGradientMode, function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "isGradientMode",
		})
	end, false)
	f1_local9 = self
	f1_local8 = self.subscribeToModel
	f1_local10 = DataSources.EmblemProperties.getModel(f1_arg1)
	f1_local8(f1_local9, f1_local10.colorContainerState, function(f34_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "colorContainerState",
		})
	end, false)
	f1_local9 = self
	f1_local8 = self.subscribeToModel
	f1_local10 = DataSources.EmblemProperties.getModel(f1_arg1)
	f1_local8(f1_local9, f1_local10.colorMode, function(f35_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "colorMode",
		})
	end, false)
	gradientSliderWidget.id = "gradientSliderWidget"
	gradientColor0.id = "gradientColor0"
	gradientColor1.id = "gradientColor1"
	GradientTypeList.id = "GradientTypeList"
	self.__defaultFocus = gradientColor1
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorGradient.__resetProperties = function(f36_arg0)
	f36_arg0.gradientSliderWidget:completeAnimation()
	f36_arg0.gradientColor1:completeAnimation()
	f36_arg0.gradientColor0:completeAnimation()
	f36_arg0.ColorPickerBkgd0:completeAnimation()
	f36_arg0.Frame:completeAnimation()
	f36_arg0.BarBacking:completeAnimation()
	f36_arg0.GradientTypeList:completeAnimation()
	f36_arg0.gradientSliderWidget:setAlpha(1)
	f36_arg0.gradientColor1:setAlpha(1)
	f36_arg0.gradientColor0:setAlpha(1)
	f36_arg0.ColorPickerBkgd0:setAlpha(0.5)
	f36_arg0.Frame:setAlpha(0.2)
	f36_arg0.BarBacking:setAlpha(0.3)
	f36_arg0.GradientTypeList:setAlpha(1)
end
CoD.EmblemEditorGradient.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(7)
			f37_arg0.ColorPickerBkgd0:completeAnimation()
			f37_arg0.ColorPickerBkgd0:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.ColorPickerBkgd0)
			f37_arg0.BarBacking:completeAnimation()
			f37_arg0.BarBacking:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.BarBacking)
			f37_arg0.Frame:completeAnimation()
			f37_arg0.Frame:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.Frame)
			f37_arg0.gradientSliderWidget:completeAnimation()
			f37_arg0.gradientSliderWidget:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.gradientSliderWidget)
			f37_arg0.gradientColor0:completeAnimation()
			f37_arg0.gradientColor0:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.gradientColor0)
			f37_arg0.gradientColor1:completeAnimation()
			f37_arg0.gradientColor1:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.gradientColor1)
			f37_arg0.GradientTypeList:completeAnimation()
			f37_arg0.GradientTypeList:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.GradientTypeList)
		end,
	},
	Color0State = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(2)
			f38_arg0.gradientSliderWidget:completeAnimation()
			f38_arg0.gradientSliderWidget:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.gradientSliderWidget)
			f38_arg0.gradientColor1:completeAnimation()
			f38_arg0.gradientColor1:setAlpha(0.1)
			f38_arg0.clipFinished(f38_arg0.gradientColor1)
		end,
	},
	Color1State = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.gradientSliderWidget:completeAnimation()
			f39_arg0.gradientSliderWidget:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.gradientSliderWidget)
			f39_arg0.gradientColor0:completeAnimation()
			f39_arg0.gradientColor0:setAlpha(0.1)
			f39_arg0.clipFinished(f39_arg0.gradientColor0)
		end,
	},
	Visible_NotEditing = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.EmblemEditorGradient.__onClose = function(f41_arg0)
	f41_arg0.gradientSliderWidget:close()
	f41_arg0.gradientColor0:close()
	f41_arg0.gradientColor1:close()
	f41_arg0.GradientTypeList:close()
end
