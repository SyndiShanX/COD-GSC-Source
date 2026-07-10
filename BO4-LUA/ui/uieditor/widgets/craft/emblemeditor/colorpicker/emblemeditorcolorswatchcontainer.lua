require("x64:acbf06924421e35")
require("x64:5670bad185ec52")
require("x64:b6da5f5f17e9c79")
require("x64:953788fb3fdb295")
require("x64:a86bdd41c06859a")
CoD.EmblemEditorColorSwatchContainer = InheritFrom(LUI.UIElement)
CoD.EmblemEditorColorSwatchContainer.__defaultWidth = 960
CoD.EmblemEditorColorSwatchContainer.__defaultHeight = 240
CoD.EmblemEditorColorSwatchContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorColorSwatchContainer)
	self.id = "EmblemEditorColorSwatchContainer"
	self.soundSet = "SelectColor_ColorSwatchPicker"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ColorPickerBkgd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ColorPickerBkgd:setAlpha(0.5)
	ColorPickerBkgd:setZRot(180)
	ColorPickerBkgd:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	ColorPickerBkgd:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(ColorPickerBkgd)
	self.ColorPickerBkgd = ColorPickerBkgd
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BarBacking = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	BarBacking:setRGB(0, 0, 0)
	BarBacking:setAlpha(0.3)
	self:addElement(BarBacking)
	self.BarBacking = BarBacking
	local ColorBacking = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 202)
	ColorBacking:setRGB(0, 0, 0)
	ColorBacking:setAlpha(0.3)
	self:addElement(ColorBacking)
	self.ColorBacking = ColorBacking
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local FooterStripe1 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -38, 0)
	FooterStripe1:setAlpha(0.1)
	FooterStripe1:setImage(RegisterImage(0xC7A051F5EFC70E5))
	FooterStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	FooterStripe1:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe1:setupNineSliceShader(245, 40)
	self:addElement(FooterStripe1)
	self.FooterStripe1 = FooterStripe1
	local lastSavedColor = CoD.EmblemColorSaved.new(f1_arg0, f1_arg1, 0, 0, 7.5, 61.5, 0, 0, 10, 190)
	lastSavedColor:setScale(1, 1.02)
	lastSavedColor:linkToElementModel(self, nil, false, function(model)
		lastSavedColor:setModel(model, f1_arg1)
	end)
	local EmblemEditorFrame0 = lastSavedColor
	local emblemColorSwatch = lastSavedColor.subscribeToModel
	local toggleColorMixerButton = Engine[0x4DF5CFBC1771947](f1_arg1)
	emblemColorSwatch(EmblemEditorFrame0, toggleColorMixerButton["Emblem.EmblemProperties.isGradientMode"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	lastSavedColor:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		if IsGamepad(f1_arg1) then
			CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, f1_arg1)
		else
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		end
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(lastSavedColor, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) then
			GoBack(self, controller)
			ClearMenuSavedState(menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "Emblem.EmblemProperties.isGradientMode", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(lastSavedColor, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(lastSavedColor)
	self.lastSavedColor = lastSavedColor
	emblemColorSwatch = LUI.UIList.new(f1_arg0, f1_arg1, -1, 0, nil, false, false, false, false)
	emblemColorSwatch:setLeftRight(0, 0, 82, 954)
	emblemColorSwatch:setTopBottom(0, 0, 6, 196)
	emblemColorSwatch:setWidgetType(CoD.EmblemColorElement)
	emblemColorSwatch:setHorizontalCount(13)
	emblemColorSwatch:setVerticalCount(9)
	emblemColorSwatch:setSpacing(-1)
	emblemColorSwatch:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	emblemColorSwatch:setDataSource("EmblemColorList")
	emblemColorSwatch:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		if IsGamepad(f1_arg1) then
			CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, f1_arg1)
		end
		return f9_local0
	end)
	emblemColorSwatch:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f10_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emblemColorSwatch, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if IsPC() then
			CoD.CraftUtility.EmblemChooseColor_SelectionChanged(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(emblemColorSwatch)
	self.emblemColorSwatch = emblemColorSwatch
	EmblemEditorFrame0 = CoD.EmblemEditorFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(EmblemEditorFrame0)
	self.EmblemEditorFrame0 = EmblemEditorFrame0
	toggleColorMixerButton = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 16, 1010, 0, 0, 202, 248)
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
	toggleColorMixerButton:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(toggleColorMixerButton, f15_arg1)
	end)
	local ColorFrame = toggleColorMixerButton
	local ColorCornerPips = toggleColorMixerButton.subscribeToModel
	local dividerV = Engine[0x4DF5CFBC1771947](f1_arg1)
	ColorCornerPips(ColorFrame, dividerV.LastInput, function(f16_arg0)
		f1_arg0:updateElementState(toggleColorMixerButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	toggleColorMixerButton.label:setText(Engine[0xF9F1239CFD921FE](0xC8E4DA2A7FB0D28))
	toggleColorMixerButton:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			toggleColorMixerButton.buttonPromptImage:setImage(RegisterImage(f17_local0))
		end
	end)
	self:addElement(toggleColorMixerButton)
	self.toggleColorMixerButton = toggleColorMixerButton
	ColorCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 6.5, 62.5, 0, 0, 6.5, 196.5)
	self:addElement(ColorCornerPips)
	self.ColorCornerPips = ColorCornerPips
	ColorFrame = LUI.UIImage.new(0, 0, 6, 63, 0, 0, 6.5, 196.5)
	ColorFrame:setAlpha(0.5)
	ColorFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	ColorFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ColorFrame:setShaderVector(0, 0, 0, 0, 0)
	ColorFrame:setupNineSliceShader(4, 4)
	self:addElement(ColorFrame)
	self.ColorFrame = ColorFrame
	dividerV = LUI.UIImage.new(0.5, 0.5, -409.5, -405.5, 0, 0, 0.5, 202.5)
	dividerV:setAlpha(0.1)
	dividerV:setImage(RegisterImage(0xC49B0C8991A541F))
	dividerV:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	dividerV:setShaderVector(0, 0, 0, 0, 0)
	dividerV:setupNineSliceShader(4, 8)
	self:addElement(dividerV)
	self.dividerV = dividerV
	local dividerH = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 201, 205)
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
				return CoD.CraftUtility.IsEmblemEditorPropertyEqualTo(f1_arg1, "isGradientMode", 0) and CoD.CraftUtility.IsEmblemEditorPropertyEqualToEnum(f1_arg1, "colorMode", Enum[0xC594B064FEDD0D6][0xE692F9BF30BA124])
			end,
		},
	})
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = DataSources.EmblemProperties.getModel(f1_arg1)
	f1_local16(f1_local15, f1_local17.isGradientMode, function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "isGradientMode",
		})
	end, false)
	f1_local15 = self
	f1_local16 = self.subscribeToModel
	f1_local17 = DataSources.EmblemProperties.getModel(f1_arg1)
	f1_local16(f1_local15, f1_local17.colorMode, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "colorMode",
		})
	end, false)
	lastSavedColor.id = "lastSavedColor"
	emblemColorSwatch.id = "emblemColorSwatch"
	self.__defaultFocus = lastSavedColor
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorColorSwatchContainer.__resetProperties = function(f21_arg0)
	f21_arg0.toggleColorMixerButton:completeAnimation()
	f21_arg0.EmblemEditorFrame0:completeAnimation()
	f21_arg0.emblemColorSwatch:completeAnimation()
	f21_arg0.lastSavedColor:completeAnimation()
	f21_arg0.dividerH:completeAnimation()
	f21_arg0.dividerV:completeAnimation()
	f21_arg0.ColorFrame:completeAnimation()
	f21_arg0.ColorCornerPips:completeAnimation()
	f21_arg0.ColorBacking:completeAnimation()
	f21_arg0.FooterStripe1:completeAnimation()
	f21_arg0.BarBacking:completeAnimation()
	f21_arg0.NoiseTiledBacking:completeAnimation()
	f21_arg0.ColorPickerBkgd:completeAnimation()
	f21_arg0.Frame:completeAnimation()
	f21_arg0.toggleColorMixerButton:setAlpha(1)
	f21_arg0.EmblemEditorFrame0:setAlpha(1)
	f21_arg0.emblemColorSwatch:setAlpha(1)
	f21_arg0.lastSavedColor:setAlpha(1)
	f21_arg0.dividerH:setAlpha(0.2)
	f21_arg0.dividerV:setAlpha(0.1)
	f21_arg0.ColorFrame:setAlpha(0.5)
	f21_arg0.ColorCornerPips:setAlpha(1)
	f21_arg0.ColorBacking:setAlpha(0.3)
	f21_arg0.FooterStripe1:setAlpha(0.1)
	f21_arg0.BarBacking:setAlpha(0.3)
	f21_arg0.NoiseTiledBacking:setAlpha(0.5)
	f21_arg0.ColorPickerBkgd:setAlpha(0.5)
	f21_arg0.Frame:setAlpha(0.2)
end
CoD.EmblemEditorColorSwatchContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(14)
			f22_arg0.ColorPickerBkgd:completeAnimation()
			f22_arg0.ColorPickerBkgd:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ColorPickerBkgd)
			f22_arg0.NoiseTiledBacking:completeAnimation()
			f22_arg0.NoiseTiledBacking:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.NoiseTiledBacking)
			f22_arg0.BarBacking:completeAnimation()
			f22_arg0.BarBacking:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BarBacking)
			f22_arg0.ColorBacking:completeAnimation()
			f22_arg0.ColorBacking:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ColorBacking)
			f22_arg0.Frame:completeAnimation()
			f22_arg0.Frame:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Frame)
			f22_arg0.FooterStripe1:completeAnimation()
			f22_arg0.FooterStripe1:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.FooterStripe1)
			f22_arg0.lastSavedColor:completeAnimation()
			f22_arg0.lastSavedColor:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.lastSavedColor)
			f22_arg0.emblemColorSwatch:completeAnimation()
			f22_arg0.emblemColorSwatch:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.emblemColorSwatch)
			f22_arg0.EmblemEditorFrame0:completeAnimation()
			f22_arg0.EmblemEditorFrame0:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.EmblemEditorFrame0)
			f22_arg0.toggleColorMixerButton:completeAnimation()
			f22_arg0.toggleColorMixerButton:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.toggleColorMixerButton)
			f22_arg0.ColorCornerPips:completeAnimation()
			f22_arg0.ColorCornerPips:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ColorCornerPips)
			f22_arg0.ColorFrame:completeAnimation()
			f22_arg0.ColorFrame:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ColorFrame)
			f22_arg0.dividerV:completeAnimation()
			f22_arg0.dividerV:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.dividerV)
			f22_arg0.dividerH:completeAnimation()
			f22_arg0.dividerH:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.dividerH)
		end,
	},
	Visible = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.EmblemEditorColorSwatchContainer.__onClose = function(f24_arg0)
	f24_arg0.lastSavedColor:close()
	f24_arg0.emblemColorSwatch:close()
	f24_arg0.EmblemEditorFrame0:close()
	f24_arg0.toggleColorMixerButton:close()
	f24_arg0.ColorCornerPips:close()
end
