require("x64:acbf06924421e35")
require("x64:97c5d41cdace9f7")
require("x64:a86bdd41c06859a")
local f0_local0 = function(f1_arg0, f1_arg1, f1_arg2)
	f1_arg0.redBar.m_colorMixer = f1_arg0
	f1_arg0.redBar.m_color = "red"
	f1_arg0.greenBar.m_colorMixer = f1_arg0
	f1_arg0.greenBar.m_color = "green"
	f1_arg0.blueBar.m_colorMixer = f1_arg0
	f1_arg0.blueBar.m_color = "blue"
end
local PostLoadFunc = function(self, controller, menu)
	if CoD.isPC then
		f0_local0(self, controller, menu)
	end
end
CoD.EmblemEditorColorMixer = InheritFrom(LUI.UIElement)
CoD.EmblemEditorColorMixer.__defaultWidth = 880
CoD.EmblemEditorColorMixer.__defaultHeight = 240
CoD.EmblemEditorColorMixer.new = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	local self = LUI.UIElement.new(f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	self:setClass(CoD.EmblemEditorColorMixer)
	self.id = "EmblemEditorColorMixer"
	self.soundSet = "SelectColor_ColorMixer"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0.5)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BotTiledBackingAdd = LUI.UIImage.new(0, 1, 0, 0, 0.85, 1, 0, 0)
	BotTiledBackingAdd:setAlpha(0.1)
	BotTiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	BotTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	BotTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	BotTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(BotTiledBackingAdd)
	self.BotTiledBackingAdd = BotTiledBackingAdd
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local ColorBacking = LUI.UIImage.new(0, 0, 0, 92, 0, 0, 0, 202)
	ColorBacking:setRGB(0, 0, 0)
	ColorBacking:setAlpha(0.3)
	self:addElement(ColorBacking)
	self.ColorBacking = ColorBacking
	local BarBacking = LUI.UIImage.new(0, 0, 0, 880, 0, 0, 0, 240)
	BarBacking:setRGB(0, 0, 0)
	BarBacking:setAlpha(0.3)
	self:addElement(BarBacking)
	self.BarBacking = BarBacking
	local blueColorValue = LUI.UIText.new(0, 0, 811, 858, 0, 0, 162, 188)
	blueColorValue:setTTF("dinnext_regular")
	blueColorValue:setLetterSpacing(1)
	blueColorValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	blueColorValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	blueColorValue:linkToElementModel(self, "blue", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			blueColorValue:setText(f4_local0)
		end
	end)
	self:addElement(blueColorValue)
	self.blueColorValue = blueColorValue
	local greenColorValue = LUI.UIText.new(0, 0, 811, 858, 0, 0, 95.5, 120.5)
	greenColorValue:setTTF("dinnext_regular")
	greenColorValue:setLetterSpacing(1)
	greenColorValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	greenColorValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	greenColorValue:linkToElementModel(self, "green", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			greenColorValue:setText(f5_local0)
		end
	end)
	self:addElement(greenColorValue)
	self.greenColorValue = greenColorValue
	local redColorValue = LUI.UIText.new(0, 0, 811, 858, 0, 0, 26, 51)
	redColorValue:setTTF("dinnext_regular")
	redColorValue:setLetterSpacing(1)
	redColorValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	redColorValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	redColorValue:linkToElementModel(self, "red", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			redColorValue:setText(f6_local0)
		end
	end)
	self:addElement(redColorValue)
	self.redColorValue = redColorValue
	local ColorPreview = LUI.UIImage.new(0, 0, 21, 73, 0, 0, 24, 186)
	ColorPreview:linkToElementModel(self, "color", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ColorPreview:setRGB(f7_local0)
		end
	end)
	self:addElement(ColorPreview)
	self.ColorPreview = ColorPreview
	local ColorCornerPips = CoD.CommonCornerPips01.new(f3_arg0, f3_arg1, 0, 0, 21, 73, 0, 0, 24, 186)
	self:addElement(ColorCornerPips)
	self.ColorCornerPips = ColorCornerPips
	local ColorFrame = LUI.UIImage.new(0, 0, 20.5, 73.5, 0, 0, 23.5, 186.5)
	ColorFrame:setAlpha(0.5)
	ColorFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	ColorFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ColorFrame:setShaderVector(0, 0, 0, 0, 0)
	ColorFrame:setupNineSliceShader(4, 4)
	self:addElement(ColorFrame)
	self.ColorFrame = ColorFrame
	local redColor = LUI.UIText.new(0, 0, 107.5, 227.5, 0, 0, 24.5, 51.5)
	redColor:setRGB(0.92, 0.92, 0.92)
	redColor:setText(LocalizeToUpperString(0xD6726B93C89AA3D))
	redColor:setTTF("ttmussels_regular")
	redColor:setLetterSpacing(2)
	redColor:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(redColor)
	self.redColor = redColor
	local greenColor = LUI.UIText.new(0, 0, 107.5, 227.5, 0, 0, 93.5, 120.5)
	greenColor:setRGB(0.92, 0.92, 0.92)
	greenColor:setText(LocalizeToUpperString(0xBCBD80A292877C1))
	greenColor:setTTF("ttmussels_regular")
	greenColor:setLetterSpacing(2)
	greenColor:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(greenColor)
	self.greenColor = greenColor
	local blueColor = LUI.UIText.new(0, 0, 107.5, 227.5, 0, 0, 161, 188)
	blueColor:setRGB(0.92, 0.92, 0.92)
	blueColor:setText(LocalizeToUpperString(0x714D845DAF54E6E))
	blueColor:setTTF("ttmussels_regular")
	blueColor:setLetterSpacing(2)
	blueColor:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(blueColor)
	self.blueColor = blueColor
	local redBar = CoD.EmblemEditorColorMixerBar.new(f3_arg0, f3_arg1, 0, 0, 221, 773, 0, 0, 27.5, 47.5)
	local blueBar = redBar
	local greenBar = redBar.subscribeToModel
	local toggleSolidColorButton = Engine[0x4DF5CFBC1771947](f3_arg1)
	greenBar(blueBar, toggleSolidColorButton["Emblem.EmblemProperties.isGradientMode"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	blueBar = redBar
	greenBar = redBar.subscribeToModel
	toggleSolidColorButton = Engine[0x4DF5CFBC1771947](f3_arg1)
	greenBar(blueBar, toggleSolidColorButton["Emblem.EmblemProperties.colorMode"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	redBar:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f10_local0
	end)
	f3_arg0:AddButtonCallbackFunction(redBar, f3_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_DecrementColorComponent(self, element, controller, "red")
		PlaySoundSetSound(self, "manipulate_slider")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], 0x0, nil, nil)
		return false
	end, false)
	f3_arg0:AddButtonCallbackFunction(redBar, f3_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_IncrementColorComponent(self, element, controller, "red")
		PlaySoundSetSound(self, "manipulate_slider")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], 0x0, nil, nil)
		return false
	end, false)
	f3_arg0:AddButtonCallbackFunction(redBar, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
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
	self:addElement(redBar)
	self.redBar = redBar
	greenBar = CoD.EmblemEditorColorMixerBar.new(f3_arg0, f3_arg1, 0, 0, 221, 773, 0, 0, 96.5, 116.5)
	toggleSolidColorButton = greenBar
	blueBar = greenBar.subscribeToModel
	local dividerH = Engine[0x4DF5CFBC1771947](f3_arg1)
	blueBar(toggleSolidColorButton, dividerH["Emblem.EmblemProperties.isGradientMode"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	toggleSolidColorButton = greenBar
	blueBar = greenBar.subscribeToModel
	dividerH = Engine[0x4DF5CFBC1771947](f3_arg1)
	blueBar(toggleSolidColorButton, dividerH["Emblem.EmblemProperties.colorMode"], function(f18_arg0, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	greenBar:registerEventHandler("gain_focus", function(element, event)
		local f19_local0 = nil
		if element.gainFocus then
			f19_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f19_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f19_local0
	end)
	f3_arg0:AddButtonCallbackFunction(greenBar, f3_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_DecrementColorComponent(self, element, controller, "green")
		PlaySoundSetSound(self, "manipulate_slider")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], 0x0, nil, nil)
		return false
	end, false)
	f3_arg0:AddButtonCallbackFunction(greenBar, f3_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_IncrementColorComponent(self, element, controller, "green")
		PlaySoundSetSound(self, "manipulate_slider")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], 0x0, nil, nil)
		return false
	end, false)
	f3_arg0:AddButtonCallbackFunction(greenBar, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
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
	self:addElement(greenBar)
	self.greenBar = greenBar
	blueBar = CoD.EmblemEditorColorMixerBar.new(f3_arg0, f3_arg1, 0, 0, 221, 773, 0, 0, 163.5, 183.5)
	dividerH = blueBar
	toggleSolidColorButton = blueBar.subscribeToModel
	local dividerV = Engine[0x4DF5CFBC1771947](f3_arg1)
	toggleSolidColorButton(dividerH, dividerV["Emblem.EmblemProperties.isGradientMode"], function(f26_arg0, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	dividerH = blueBar
	toggleSolidColorButton = blueBar.subscribeToModel
	dividerV = Engine[0x4DF5CFBC1771947](f3_arg1)
	toggleSolidColorButton(dividerH, dividerV["Emblem.EmblemProperties.colorMode"], function(f27_arg0, f27_arg1)
		CoD.Menu.UpdateButtonShownState(f27_arg1, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	blueBar:registerEventHandler("gain_focus", function(element, event)
		local f28_local0 = nil
		if element.gainFocus then
			f28_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f28_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF])
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0])
		CoD.Menu.UpdateButtonShownState(element, f3_arg0, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f28_local0
	end)
	f3_arg0:AddButtonCallbackFunction(blueBar, f3_arg1, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_DecrementColorComponent(self, element, controller, "blue")
		PlaySoundSetSound(self, "manipulate_slider")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], 0x0, nil, nil)
		return false
	end, false)
	f3_arg0:AddButtonCallbackFunction(blueBar, f3_arg1, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], nil, function(element, menu, controller, model)
		CoD.CraftUtility.EmblemChooseColor_IncrementColorComponent(self, element, controller, "blue")
		PlaySoundSetSound(self, "manipulate_slider")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], 0x0, nil, nil)
		return false
	end, false)
	f3_arg0:AddButtonCallbackFunction(blueBar, f3_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
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
	self:addElement(blueBar)
	self.blueBar = blueBar
	toggleSolidColorButton = CoD.PaintshopButtonPrompt.new(f3_arg0, f3_arg1, 0, 0, 28.5, 378.5, 0, 0, 205, 251)
	toggleSolidColorButton:mergeStateConditions({
		{
			stateName = "KM",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f3_arg1)
			end,
		},
	})
	toggleSolidColorButton:appendEventHandler("input_source_changed", function(f37_arg0, f37_arg1)
		f37_arg1.menu = f37_arg1.menu or f3_arg0
		f3_arg0:updateElementState(toggleSolidColorButton, f37_arg1)
	end)
	dividerV = toggleSolidColorButton
	dividerH = toggleSolidColorButton.subscribeToModel
	local FooterStripe1 = Engine[0x4DF5CFBC1771947](f3_arg1)
	dividerH(dividerV, FooterStripe1.LastInput, function(f38_arg0)
		f3_arg0:updateElementState(toggleSolidColorButton, {
			name = "model_validation",
			menu = f3_arg0,
			controller = f3_arg1,
			modelValue = f38_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	toggleSolidColorButton.label:setText(Engine[0xF9F1239CFD921FE](0xC01001B9AF5D45E))
	toggleSolidColorButton:subscribeToGlobalModel(f3_arg1, "Controller", "back_button_image", function(model)
		local f39_local0 = model:get()
		if f39_local0 ~= nil then
			toggleSolidColorButton.buttonPromptImage:setImage(RegisterImage(f39_local0))
		end
	end)
	self:addElement(toggleSolidColorButton)
	self.toggleSolidColorButton = toggleSolidColorButton
	dividerH = LUI.UIImage.new(0, 0, 0, 880, 0, 0, 201, 205)
	dividerH:setAlpha(0.2)
	dividerH:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH:setShaderVector(0, 0, 0, 0, 0)
	dividerH:setupNineSliceShader(8, 4)
	self:addElement(dividerH)
	self.dividerH = dividerH
	dividerV = LUI.UIImage.new(0, 0, 90, 94, 0, 0, 0, 202)
	dividerV:setAlpha(0.1)
	dividerV:setImage(RegisterImage(0xC49B0C8991A541F))
	dividerV:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	dividerV:setShaderVector(0, 0, 0, 0, 0)
	dividerV:setupNineSliceShader(4, 8)
	self:addElement(dividerV)
	self.dividerV = dividerV
	FooterStripe1 = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -38, 0)
	FooterStripe1:setAlpha(0.1)
	FooterStripe1:setImage(RegisterImage(0xC7A051F5EFC70E5))
	FooterStripe1:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	FooterStripe1:setShaderVector(0, 0, 0, 0, 0)
	FooterStripe1:setupNineSliceShader(245, 40)
	self:addElement(FooterStripe1)
	self.FooterStripe1 = FooterStripe1
	redBar.id = "redBar"
	greenBar.id = "greenBar"
	blueBar.id = "blueBar"
	self.__defaultFocus = redBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg1, f3_arg0)
	end
	return self
end
CoD.EmblemEditorColorMixer.__onClose = function(f40_arg0)
	f40_arg0.blueColorValue:close()
	f40_arg0.greenColorValue:close()
	f40_arg0.redColorValue:close()
	f40_arg0.ColorPreview:close()
	f40_arg0.ColorCornerPips:close()
	f40_arg0.redBar:close()
	f40_arg0.greenBar:close()
	f40_arg0.blueBar:close()
	f40_arg0.toggleSolidColorButton:close()
end
