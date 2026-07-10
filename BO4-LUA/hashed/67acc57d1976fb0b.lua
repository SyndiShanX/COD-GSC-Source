require("x64:cf5b4cc5bf2971b")
require("x64:14cf3f0705aae36")
require("x64:c23f7217f33f15c")
require("x64:bce07fcd345de2a")
CoD.EmblemEditorMaterialInfo = InheritFrom(LUI.UIElement)
CoD.EmblemEditorMaterialInfo.__defaultWidth = 540
CoD.EmblemEditorMaterialInfo.__defaultHeight = 68
CoD.EmblemEditorMaterialInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorMaterialInfo)
	self.id = "EmblemEditorMaterialInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -270, 270, 0.5, 0.5, -34, 34)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local cacButtonBoxLrgInactiveStroke0 = CoD.cac_ButtonBoxLrgInactiveStroke.new(f1_arg0, f1_arg1, 0, 1, -3, 3, 0, 1, 42, 2)
	cacButtonBoxLrgInactiveStroke0:setAlpha(0)
	self:addElement(cacButtonBoxLrgInactiveStroke0)
	self.cacButtonBoxLrgInactiveStroke0 = cacButtonBoxLrgInactiveStroke0
	local layerUsedValue = CoD.GroupFractionLabel.new(f1_arg0, f1_arg1, 0, 0, 5, 239, 0, 0, 33, 68)
	layerUsedValue:mergeStateConditions({
		{
			stateName = "GroupsFull",
			condition = function(menu, element, event)
				return not IsEmptyLayerAvailable(f1_arg1)
			end,
		},
	})
	local choosePaintSide = layerUsedValue
	local TextBox4 = layerUsedValue.subscribeToModel
	local PaintshopChooseSide = Engine[0x4DF5CFBC1771947](f1_arg1)
	TextBox4(choosePaintSide, PaintshopChooseSide["Emblem.EmblemProperties.layersUsed"], function(f3_arg0)
		f1_arg0:updateElementState(layerUsedValue, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "Emblem.EmblemProperties.layersUsed",
		})
	end, false)
	layerUsedValue:subscribeToGlobalModel(f1_arg1, "EmblemProperties", "layersUsedFraction", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			layerUsedValue.groupsUsedValue:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(layerUsedValue)
	self.layerUsedValue = layerUsedValue
	TextBox4 = LUI.UIText.new(0, 0, 5, 225, 0, 0, 3.5, 28.5)
	TextBox4:setRGB(0.92, 0.89, 0.72)
	TextBox4:setText(Engine[0xF9F1239CFD921FE](0x3357A304FD698FC))
	TextBox4:setTTF("ttmussels_regular")
	TextBox4:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox4:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox4)
	self.TextBox4 = TextBox4
	choosePaintSide = CoD.PaintshopChoosePaintSide.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 40)
	choosePaintSide:mergeStateConditions({
		{
			stateName = "BrowseModeControlsState",
			condition = function(menu, element, event)
				return IsPaintshop(f1_arg1) and not CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "Emblem.EmblemProperties.editorMode", Enum[0x3ED85BA45B1D650][0xE2FFAEFF67F59AD])
			end,
		},
	})
	local rotationText = choosePaintSide
	PaintshopChooseSide = choosePaintSide.subscribeToModel
	local rotationValue = Engine[0x4DF5CFBC1771947](f1_arg1)
	PaintshopChooseSide(rotationText, rotationValue["Emblem.EmblemProperties.editorMode"], function(f6_arg0)
		f1_arg0:updateElementState(choosePaintSide, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "Emblem.EmblemProperties.editorMode",
		})
	end, false)
	choosePaintSide:setAlpha(0)
	choosePaintSide:subscribeToGlobalModel(f1_arg1, "Customization", "view_string_ref", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			choosePaintSide.PaintshopChooseSide.text:setText(Engine[0xF9F1239CFD921FE](f7_local0))
		end
	end)
	self:addElement(choosePaintSide)
	self.choosePaintSide = choosePaintSide
	PaintshopChooseSide = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 0, 7, 327, 0, 0, 5, 37)
	PaintshopChooseSide:setAlpha(0)
	PaintshopChooseSide:setScale(LanguageOverrideNumberForScale("korean", 0.8, LanguageOverrideNumberForScale("japanese", 0.8, LanguageOverrideNumberForScale("chinese", 0.8, 1, 1))))
	PaintshopChooseSide.text:setText(LocalizeToUpperString(0xF5CA503839CA925))
	self:addElement(PaintshopChooseSide)
	self.PaintshopChooseSide = PaintshopChooseSide
	rotationText = LUI.UIText.new(0, 0, 345.5, 541.5, 0, 0, 3, 28)
	rotationText:setRGB(0.92, 0.89, 0.72)
	rotationText:setText(Engine[0xF9F1239CFD921FE](0x925F93629C148F6))
	rotationText:setTTF("ttmussels_regular")
	rotationText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rotationText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(rotationText)
	self.rotationText = rotationText
	rotationValue = LUI.UIText.new(0, 0, 345.5, 534.5, 0, 0, 36, 64)
	rotationValue:setTTF("dinnext_regular")
	rotationValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rotationValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	rotationValue:linkToElementModel(self, "material_angle", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			rotationValue:setText(f8_local0)
		end
	end)
	self:addElement(rotationValue)
	self.rotationValue = rotationValue
	local scaleText = LUI.UIText.new(0, 0, 172.5, 391.5, 0, 0, 3.5, 28.5)
	scaleText:setRGB(0.92, 0.89, 0.72)
	scaleText:setText(Engine[0xF9F1239CFD921FE](0x39B482734C22440))
	scaleText:setTTF("ttmussels_regular")
	scaleText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	scaleText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(scaleText)
	self.scaleText = scaleText
	local xScaleValue = LUI.UIText.new(0, 0, 192.5, 250.5, 0, 0, 38, 63)
	xScaleValue:setTTF("dinnext_regular")
	xScaleValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	xScaleValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	xScaleValue:linkToElementModel(self, "material_xscale", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			xScaleValue:setText(f9_local0)
		end
	end)
	self:addElement(xScaleValue)
	self.xScaleValue = xScaleValue
	local yScaleValue = LUI.UIText.new(0, 0, 269, 488, 0, 0, 38, 63)
	yScaleValue:setTTF("dinnext_regular")
	yScaleValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	yScaleValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	yScaleValue:linkToElementModel(self, "material_yscale", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			yScaleValue:setText(f10_local0)
		end
	end)
	self:addElement(yScaleValue)
	self.yScaleValue = yScaleValue
	local scaleX = LUI.UIText.new(0, 0, 173, 245, 0, 0, 37.5, 62.5)
	scaleX:setRGB(0.92, 0.89, 0.72)
	scaleX:setText(Engine[0xF9F1239CFD921FE](0x9BAB2C368028BBC))
	scaleX:setTTF("ttmussels_regular")
	scaleX:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	scaleX:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(scaleX)
	self.scaleX = scaleX
	local scaleY = LUI.UIText.new(0, 0, 250, 390, 0, 0, 37.5, 62.5)
	scaleY:setRGB(0.92, 0.89, 0.72)
	scaleY:setText(Engine[0xF9F1239CFD921FE](0xC8E669F24C21949))
	scaleY:setTTF("ttmussels_regular")
	scaleY:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	scaleY:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(scaleY)
	self.scaleY = scaleY
	local dividerH = LUI.UIImage.new(0, 0, 0, 539, 0, 0, 29, 33)
	dividerH:setAlpha(0.2)
	dividerH:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH:setShaderVector(0, 0, 0, 0, 0)
	dividerH:setupNineSliceShader(8, 4)
	self:addElement(dividerH)
	self.dividerH = dividerH
	local Frame = LUI.UIImage.new(0, 0, -1, 540, 0, 0, -1, 69)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local Divider01 = LUI.UIImage.new(0, 0, 166, 170, 0, 0, 0, 68)
	Divider01:setRGB(0.92, 0.92, 0.92)
	Divider01:setAlpha(0.1)
	Divider01:setImage(RegisterImage(0xC49B0C8991A541F))
	Divider01:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Divider01:setShaderVector(0, 0, 0, 0, 0)
	Divider01:setupNineSliceShader(4, 8)
	self:addElement(Divider01)
	self.Divider01 = Divider01
	local Divider = LUI.UIImage.new(0, 0, 339.5, 343.5, 0, 0, 0, 68)
	Divider:setRGB(0.92, 0.92, 0.92)
	Divider:setAlpha(0.1)
	Divider:setImage(RegisterImage(0xC49B0C8991A541F))
	Divider:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	Divider:setShaderVector(0, 0, 0, 0, 0)
	Divider:setupNineSliceShader(4, 8)
	self:addElement(Divider)
	self.Divider = Divider
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorMaterialInfo.__onClose = function(f11_arg0)
	f11_arg0.cacButtonBoxLrgInactiveStroke0:close()
	f11_arg0.layerUsedValue:close()
	f11_arg0.choosePaintSide:close()
	f11_arg0.PaintshopChooseSide:close()
	f11_arg0.rotationValue:close()
	f11_arg0.xScaleValue:close()
	f11_arg0.yScaleValue:close()
end
