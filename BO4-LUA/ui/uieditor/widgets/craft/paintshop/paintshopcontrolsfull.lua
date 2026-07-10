require("x64:58c18133f12be4a")
require("x64:4d90108dbbf039d")
require("x64:a86bdd41c06859a")
require("x64:bce07fcd345de2a")
CoD.PaintshopControlsFull = InheritFrom(LUI.UIElement)
CoD.PaintshopControlsFull.__defaultWidth = 420
CoD.PaintshopControlsFull.__defaultHeight = 540
CoD.PaintshopControlsFull.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintshopControlsFull)
	self.id = "PaintshopControlsFull"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBot = LUI.UIImage.new(0, 0, 1, 421, 0, 0, 412, 525)
	BackingBot:setImage(RegisterImage(0x34839E8065B1E53))
	BackingBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingBot:setShaderVector(0, 0, 0, 0, 0)
	BackingBot:setupNineSliceShader(196, 88)
	self:addElement(BackingBot)
	self.BackingBot = BackingBot
	local BackingMid = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 230, 377)
	BackingMid:setImage(RegisterImage(0x34839E8065B1E53))
	BackingMid:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingMid:setShaderVector(0, 0, 0, 0, 0)
	BackingMid:setupNineSliceShader(196, 88)
	self:addElement(BackingMid)
	self.BackingMid = BackingMid
	local BackingTop = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 0, 190)
	BackingTop:setImage(RegisterImage(0x34839E8065B1E53))
	BackingTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingTop:setShaderVector(0, 0, 0, 0, 0)
	BackingTop:setupNineSliceShader(196, 88)
	self:addElement(BackingTop)
	self.BackingTop = BackingTop
	local ColorPicker = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 21, 421, 0, 0, 441, 481)
	ColorPicker:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self, f1_arg1)
			end,
		},
	})
	ColorPicker:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ColorPicker, f3_arg1)
	end)
	local PaintshopChooseSide0 = ColorPicker
	local materialPicker = ColorPicker.subscribeToModel
	local rsOpacity = Engine[0x4DF5CFBC1771947](f1_arg1)
	materialPicker(PaintshopChooseSide0, rsOpacity.LastInput, function(f4_arg0)
		f1_arg0:updateElementState(ColorPicker, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ColorPicker:linkToElementModel(ColorPicker, "isGrouped", true, function(model)
		f1_arg0:updateElementState(ColorPicker, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isGrouped",
		})
	end)
	ColorPicker.label:setText(Engine[0xF9F1239CFD921FE](0x3F334E151B36E5C))
	ColorPicker:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ColorPicker.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(ColorPicker)
	self.ColorPicker = ColorPicker
	materialPicker = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 21, 421, 0, 0, 481, 517)
	materialPicker:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BaseUtility.IsDvarEnabled("enable_material_picker")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblem_IsGroupedLayerWithSticker(self, f1_arg1)
			end,
		},
	})
	materialPicker:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(materialPicker, f9_arg1)
	end)
	rsOpacity = materialPicker
	PaintshopChooseSide0 = materialPicker.subscribeToModel
	local lsOpacity = Engine[0x4DF5CFBC1771947](f1_arg1)
	PaintshopChooseSide0(rsOpacity, lsOpacity.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(materialPicker, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	materialPicker:linkToElementModel(materialPicker, "isGrouped", true, function(model)
		f1_arg0:updateElementState(materialPicker, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isGrouped",
		})
	end)
	materialPicker.label:setText(Engine[0xF9F1239CFD921FE](0xE5BDA73054BDF29))
	materialPicker:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_up_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			materialPicker.buttonPromptImage:setImage(RegisterImage(f12_local0))
		end
	end)
	self:addElement(materialPicker)
	self.materialPicker = materialPicker
	PaintshopChooseSide0 = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 0, 6, 326, 0, 0, 415, 447)
	PaintshopChooseSide0:setScale(LanguageOverrideNumberForScale("korean", 0.8, LanguageOverrideNumberForScale("japanese", 0.8, LanguageOverrideNumberForScale("chinese", 0.8, 1, 1))))
	PaintshopChooseSide0.text:setText(LocalizeToUpperString(0xD9555D6F5A195F2))
	self:addElement(PaintshopChooseSide0)
	self.PaintshopChooseSide0 = PaintshopChooseSide0
	rsOpacity = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 39, 75, 0, 0, 256, 292)
	rsOpacity.label:setText("")
	rsOpacity:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			rsOpacity.buttonPromptImage:setImage(RegisterImage(f13_local0))
		end
	end)
	self:addElement(rsOpacity)
	self.rsOpacity = rsOpacity
	lsOpacity = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 3, 39, 0, 0, 256, 292)
	lsOpacity.label:setText("")
	lsOpacity:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			lsOpacity.buttonPromptImage:setImage(RegisterImage(f14_local0))
		end
	end)
	self:addElement(lsOpacity)
	self.lsOpacity = lsOpacity
	local opacity = LUI.UIText.new(0, 0, 82, 370, 0, 0, 260, 285)
	opacity:setText(Engine[0xF9F1239CFD921FE](0x611006D6269F87D))
	opacity:setTTF("ttmussels_regular")
	opacity:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	opacity:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(opacity)
	self.opacity = opacity
	local ToggleOutline = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 292, 332)
	ToggleOutline:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_IsLayerGroupedOrLinked(element, f1_arg1)
			end,
		},
	})
	ToggleOutline:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ToggleOutline, f16_arg1)
	end)
	local overrides = ToggleOutline
	local Clip = ToggleOutline.subscribeToModel
	local rightTriggerButton = Engine[0x4DF5CFBC1771947](f1_arg1)
	Clip(overrides, rightTriggerButton.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(ToggleOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ToggleOutline:linkToElementModel(ToggleOutline, "isLinked", true, function(model)
		f1_arg0:updateElementState(ToggleOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLinked",
		})
	end)
	ToggleOutline:linkToElementModel(ToggleOutline, "isGrouped", true, function(model)
		f1_arg0:updateElementState(ToggleOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isGrouped",
		})
	end)
	ToggleOutline.label:setText(Engine[0xF9F1239CFD921FE](0xB01D7611E815CFB))
	ToggleOutline:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			ToggleOutline.buttonPromptImage:setImage(RegisterImage(f20_local0))
		end
	end)
	self:addElement(ToggleOutline)
	self.ToggleOutline = ToggleOutline
	Clip = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 332, 372)
	Clip:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.BaseUtility.IsDvarEnabled("enable_clip_mask")
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.CraftUtility.Emblems_IsLayerGroupedOrLinked(element, f1_arg1)
			end,
		},
	})
	Clip:appendEventHandler("input_source_changed", function(f23_arg0, f23_arg1)
		f23_arg1.menu = f23_arg1.menu or f1_arg0
		f1_arg0:updateElementState(Clip, f23_arg1)
	end)
	rightTriggerButton = Clip
	overrides = Clip.subscribeToModel
	local leftTriggerButton = Engine[0x4DF5CFBC1771947](f1_arg1)
	overrides(rightTriggerButton, leftTriggerButton.LastInput, function(f24_arg0)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	Clip:linkToElementModel(Clip, "isLinked", true, function(model)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLinked",
		})
	end)
	Clip:linkToElementModel(Clip, "isGrouped", true, function(model)
		f1_arg0:updateElementState(Clip, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isGrouped",
		})
	end)
	Clip.label:setText(Engine[0xF9F1239CFD921FE](0xAB63F65EEE8AB3C))
	Clip:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_down_button_image", function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			Clip.buttonPromptImage:setImage(RegisterImage(f27_local0))
		end
	end)
	self:addElement(Clip)
	self.Clip = Clip
	overrides = CoD.EmblemEditorHeaderRight.new(f1_arg0, f1_arg1, 0, 0, 5, 325, 0, 0, 232, 269)
	overrides:setScale(LanguageOverrideNumberForScale("korean", 0.8, LanguageOverrideNumberForScale("japanese", 0.8, LanguageOverrideNumberForScale("chinese", 0.8, 1, 1))))
	overrides.text:setText(Engine[0xF9F1239CFD921FE](0x1EE153317E38FB5))
	self:addElement(overrides)
	self.overrides = overrides
	rightTriggerButton = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 39, 73, 0, 0, 109, 155)
	rightTriggerButton.label:setText("")
	rightTriggerButton:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			rightTriggerButton.buttonPromptImage:setImage(RegisterImage(f28_local0))
		end
	end)
	self:addElement(rightTriggerButton)
	self.rightTriggerButton = rightTriggerButton
	leftTriggerButton = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 3, 39, 0, 0, 109, 155)
	leftTriggerButton.label:setText("")
	leftTriggerButton:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			leftTriggerButton.buttonPromptImage:setImage(RegisterImage(f29_local0))
		end
	end)
	self:addElement(leftTriggerButton)
	self.leftTriggerButton = leftTriggerButton
	local rotateText = LUI.UIText.new(0, 0, 82, 370, 0, 0, 117, 142)
	rotateText:setText(Engine[0xF9F1239CFD921FE](0x2FFF1300E166617))
	rotateText:setTTF("ttmussels_regular")
	rotateText:setLetterSpacing(2)
	rotateText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rotateText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(rotateText)
	self.rotateText = rotateText
	local Flip = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 371, 0, 0, 148, 194)
	Flip.label:setText(Engine[0xF9F1239CFD921FE](0x80DD0DAE2D212DC))
	Flip:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			Flip.buttonPromptImage:setImage(RegisterImage(f30_local0))
		end
	end)
	self:addElement(Flip)
	self.Flip = Flip
	local FixedScale = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 71, 117)
	FixedScale.label:setText(Engine[0xF9F1239CFD921FE](0xAD2AED6D89BCC15))
	FixedScale:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			FixedScale.buttonPromptImage:setImage(RegisterImage(f31_local0))
		end
	end)
	self:addElement(FixedScale)
	self.FixedScale = FixedScale
	local FreeScale = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 71, 117)
	FreeScale.label:setText(Engine[0xF9F1239CFD921FE](0xDD45E7A84A50DF9))
	FreeScale:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			FreeScale.buttonPromptImage:setImage(RegisterImage(f32_local0))
		end
	end)
	self:addElement(FreeScale)
	self.FreeScale = FreeScale
	local Move = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 33, 79)
	Move.label:setText(Engine[0xF9F1239CFD921FE](0x507A3A71D9218BE))
	Move:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			Move.buttonPromptImage:setImage(RegisterImage(f33_local0))
		end
	end)
	self:addElement(Move)
	self.Move = Move
	local PaintshopChooseSide = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 0, 5, 325, 0, 0, 4, 36)
	PaintshopChooseSide:setScale(LanguageOverrideNumberForScale("korean", 0.8, LanguageOverrideNumberForScale("japanese", 0.8, LanguageOverrideNumberForScale("chinese", 0.8, 1, 1))))
	PaintshopChooseSide.text:setText(LocalizeToUpperString(0xF5CA503839CA925))
	self:addElement(PaintshopChooseSide)
	self.PaintshopChooseSide = PaintshopChooseSide
	local dividerH01 = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 22, 26)
	dividerH01:setAlpha(0.2)
	dividerH01:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH01:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH01:setShaderVector(0, 0, 0, 0, 0)
	dividerH01:setupNineSliceShader(8, 4)
	self:addElement(dividerH01)
	self.dividerH01 = dividerH01
	local dividerH02 = LUI.UIImage.new(0, 0, 1, 420, 0, 0, 253, 257)
	dividerH02:setAlpha(0.2)
	dividerH02:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH02:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH02:setShaderVector(0, 0, 0, 0, 0)
	dividerH02:setupNineSliceShader(8, 4)
	self:addElement(dividerH02)
	self.dividerH02 = dividerH02
	local dividerH03 = LUI.UIImage.new(0, 0, 1, 421, 0, 0, 433, 437)
	dividerH03:setAlpha(0.2)
	dividerH03:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH03:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH03:setShaderVector(0, 0, 0, 0, 0)
	dividerH03:setupNineSliceShader(8, 4)
	self:addElement(dividerH03)
	self.dividerH03 = dividerH03
	local Frame01 = LUI.UIImage.new(0, 1, -1, 1, 0, 0, 0, 190)
	Frame01:setAlpha(0.2)
	Frame01:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame01:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame01:setShaderVector(0, 0, 0, 0, 0)
	Frame01:setupNineSliceShader(16, 16)
	self:addElement(Frame01)
	self.Frame01 = Frame01
	local Frame02 = LUI.UIImage.new(0, 1, -1, 1, 0, 0, 230, 377)
	Frame02:setAlpha(0.2)
	Frame02:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame02:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame02:setShaderVector(0, 0, 0, 0, 0)
	Frame02:setupNineSliceShader(16, 16)
	self:addElement(Frame02)
	self.Frame02 = Frame02
	local Frame03 = LUI.UIImage.new(0, 1, -1, 1, 0, 0, 412, 525)
	Frame03:setAlpha(0.2)
	Frame03:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame03:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame03:setShaderVector(0, 0, 0, 0, 0)
	Frame03:setupNineSliceShader(16, 16)
	self:addElement(Frame03)
	self.Frame03 = Frame03
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintshopControlsFull.__resetProperties = function(f34_arg0)
	f34_arg0.rotateText:completeAnimation()
	f34_arg0.leftTriggerButton:completeAnimation()
	f34_arg0.rightTriggerButton:completeAnimation()
	f34_arg0.opacity:completeAnimation()
	f34_arg0.lsOpacity:completeAnimation()
	f34_arg0.rsOpacity:completeAnimation()
	f34_arg0.Move:completeAnimation()
	f34_arg0.FreeScale:completeAnimation()
	f34_arg0.Flip:completeAnimation()
	f34_arg0.ToggleOutline:completeAnimation()
	f34_arg0.ColorPicker:completeAnimation()
	f34_arg0.materialPicker:completeAnimation()
	f34_arg0.overrides:completeAnimation()
	f34_arg0.PaintshopChooseSide0:completeAnimation()
	f34_arg0.PaintshopChooseSide:completeAnimation()
	f34_arg0.BackingTop:completeAnimation()
	f34_arg0.BackingMid:completeAnimation()
	f34_arg0.BackingBot:completeAnimation()
	f34_arg0.FixedScale:completeAnimation()
	f34_arg0.Frame03:completeAnimation()
	f34_arg0.Frame02:completeAnimation()
	f34_arg0.Frame01:completeAnimation()
	f34_arg0.dividerH02:completeAnimation()
	f34_arg0.dividerH03:completeAnimation()
	f34_arg0.dividerH01:completeAnimation()
	f34_arg0.Clip:completeAnimation()
	f34_arg0.rotateText:setAlpha(1)
	f34_arg0.leftTriggerButton:setAlpha(1)
	f34_arg0.rightTriggerButton:setAlpha(1)
	f34_arg0.opacity:setAlpha(1)
	f34_arg0.lsOpacity:setAlpha(1)
	f34_arg0.rsOpacity:setAlpha(1)
	f34_arg0.Move:setAlpha(1)
	f34_arg0.FreeScale:setAlpha(1)
	f34_arg0.Flip:setAlpha(1)
	f34_arg0.ToggleOutline:setAlpha(1)
	f34_arg0.ColorPicker:setAlpha(1)
	f34_arg0.materialPicker:setAlpha(1)
	f34_arg0.overrides:setLeftRight(0, 0, 5, 325)
	f34_arg0.overrides:setTopBottom(0, 0, 232, 269)
	f34_arg0.overrides:setAlpha(1)
	f34_arg0.PaintshopChooseSide0:setAlpha(1)
	f34_arg0.PaintshopChooseSide:setAlpha(1)
	f34_arg0.BackingTop:setAlpha(1)
	f34_arg0.BackingMid:setAlpha(1)
	f34_arg0.BackingBot:setAlpha(1)
	f34_arg0.FixedScale:setAlpha(1)
	f34_arg0.FixedScale.label:setText(Engine[0xF9F1239CFD921FE](0xAD2AED6D89BCC15))
	f34_arg0.Frame03:setAlpha(0.2)
	f34_arg0.Frame02:setAlpha(0.2)
	f34_arg0.Frame01:setAlpha(0.2)
	f34_arg0.dividerH02:setAlpha(0.2)
	f34_arg0.dividerH03:setAlpha(0.2)
	f34_arg0.dividerH01:setAlpha(0.2)
	f34_arg0.Clip:setAlpha(1)
end
CoD.PaintshopControlsFull.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(0)
		end,
	},
	BrowseModeControlsState = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(26)
			f36_arg0.BackingBot:completeAnimation()
			f36_arg0.BackingBot:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.BackingBot)
			f36_arg0.BackingMid:completeAnimation()
			f36_arg0.BackingMid:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.BackingMid)
			f36_arg0.BackingTop:completeAnimation()
			f36_arg0.BackingTop:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.BackingTop)
			f36_arg0.ColorPicker:completeAnimation()
			f36_arg0.ColorPicker:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ColorPicker)
			f36_arg0.materialPicker:completeAnimation()
			f36_arg0.materialPicker:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.materialPicker)
			f36_arg0.PaintshopChooseSide0:completeAnimation()
			f36_arg0.PaintshopChooseSide0:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.PaintshopChooseSide0)
			f36_arg0.rsOpacity:completeAnimation()
			f36_arg0.rsOpacity:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.rsOpacity)
			f36_arg0.lsOpacity:completeAnimation()
			f36_arg0.lsOpacity:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.lsOpacity)
			f36_arg0.opacity:completeAnimation()
			f36_arg0.opacity:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.opacity)
			f36_arg0.ToggleOutline:completeAnimation()
			f36_arg0.ToggleOutline:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.ToggleOutline)
			f36_arg0.Clip:beginAnimation(210)
			f36_arg0.Clip:setAlpha(0)
			f36_arg0.Clip:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
			f36_arg0.Clip:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			f36_arg0.overrides:completeAnimation()
			f36_arg0.overrides:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.overrides)
			f36_arg0.rightTriggerButton:completeAnimation()
			f36_arg0.rightTriggerButton:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.rightTriggerButton)
			f36_arg0.leftTriggerButton:completeAnimation()
			f36_arg0.leftTriggerButton:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.leftTriggerButton)
			f36_arg0.rotateText:completeAnimation()
			f36_arg0.rotateText:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.rotateText)
			f36_arg0.Flip:completeAnimation()
			f36_arg0.Flip:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Flip)
			f36_arg0.FixedScale:completeAnimation()
			f36_arg0.FixedScale:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.FixedScale)
			f36_arg0.FreeScale:completeAnimation()
			f36_arg0.FreeScale:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.FreeScale)
			f36_arg0.Move:completeAnimation()
			f36_arg0.Move:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Move)
			f36_arg0.PaintshopChooseSide:completeAnimation()
			f36_arg0.PaintshopChooseSide:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.PaintshopChooseSide)
			f36_arg0.dividerH01:completeAnimation()
			f36_arg0.dividerH01:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.dividerH01)
			f36_arg0.dividerH02:completeAnimation()
			f36_arg0.dividerH02:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.dividerH02)
			f36_arg0.dividerH03:completeAnimation()
			f36_arg0.dividerH03:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.dividerH03)
			f36_arg0.Frame01:completeAnimation()
			f36_arg0.Frame01:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Frame01)
			f36_arg0.Frame02:completeAnimation()
			f36_arg0.Frame02:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Frame02)
			f36_arg0.Frame03:completeAnimation()
			f36_arg0.Frame03:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.Frame03)
		end,
	},
	FixedScale = {
		DefaultClip = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			f37_arg0.overrides:completeAnimation()
			f37_arg0.overrides:setLeftRight(0, 0, 5, 325)
			f37_arg0.overrides:setTopBottom(0, 0, 232, 269)
			f37_arg0.clipFinished(f37_arg0.overrides)
			f37_arg0.FixedScale:completeAnimation()
			f37_arg0.FixedScale:setAlpha(1)
			f37_arg0.clipFinished(f37_arg0.FixedScale)
			f37_arg0.FreeScale:completeAnimation()
			f37_arg0.FreeScale:setAlpha(0)
			f37_arg0.clipFinished(f37_arg0.FreeScale)
		end,
	},
	FreeScale = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.FixedScale:completeAnimation()
			f38_arg0.FixedScale:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.FixedScale)
		end,
	},
	StickerFixedScale = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(10)
			f39_arg0.ColorPicker:completeAnimation()
			f39_arg0.ColorPicker:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.ColorPicker)
			f39_arg0.materialPicker:completeAnimation()
			f39_arg0.materialPicker:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.materialPicker)
			f39_arg0.rsOpacity:completeAnimation()
			f39_arg0.rsOpacity:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.rsOpacity)
			f39_arg0.lsOpacity:completeAnimation()
			f39_arg0.lsOpacity:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.lsOpacity)
			f39_arg0.opacity:completeAnimation()
			f39_arg0.opacity:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.opacity)
			f39_arg0.ToggleOutline:completeAnimation()
			f39_arg0.ToggleOutline:setAlpha(0.2)
			f39_arg0.clipFinished(f39_arg0.ToggleOutline)
			f39_arg0.Clip:beginAnimation(210)
			f39_arg0.Clip:setAlpha(0.2)
			f39_arg0.Clip:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
			f39_arg0.Clip:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			f39_arg0.overrides:completeAnimation()
			f39_arg0.overrides:setLeftRight(0, 0, 5, 325)
			f39_arg0.overrides:setTopBottom(0, 0, 232, 269)
			f39_arg0.clipFinished(f39_arg0.overrides)
			f39_arg0.FixedScale:completeAnimation()
			f39_arg0.FixedScale:setAlpha(1)
			f39_arg0.clipFinished(f39_arg0.FixedScale)
			f39_arg0.FreeScale:completeAnimation()
			f39_arg0.FreeScale:setAlpha(0)
			f39_arg0.clipFinished(f39_arg0.FreeScale)
		end,
	},
	StickerFreeScale = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(8)
			f40_arg0.ColorPicker:completeAnimation()
			f40_arg0.ColorPicker:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.ColorPicker)
			f40_arg0.materialPicker:completeAnimation()
			f40_arg0.materialPicker:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.materialPicker)
			f40_arg0.rsOpacity:completeAnimation()
			f40_arg0.rsOpacity:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.rsOpacity)
			f40_arg0.lsOpacity:completeAnimation()
			f40_arg0.lsOpacity:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.lsOpacity)
			f40_arg0.opacity:completeAnimation()
			f40_arg0.opacity:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.opacity)
			f40_arg0.ToggleOutline:completeAnimation()
			f40_arg0.ToggleOutline:setAlpha(0.2)
			f40_arg0.clipFinished(f40_arg0.ToggleOutline)
			f40_arg0.Clip:beginAnimation(210)
			f40_arg0.Clip:setAlpha(0.2)
			f40_arg0.Clip:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
			f40_arg0.Clip:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			f40_arg0.FixedScale:completeAnimation()
			f40_arg0.FixedScale:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.FixedScale)
		end,
	},
	FixedScaleOnly = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(3)
			f41_arg0.overrides:completeAnimation()
			f41_arg0.overrides:setLeftRight(0, 0, 5, 325)
			f41_arg0.overrides:setTopBottom(0, 0, 232, 269)
			f41_arg0.clipFinished(f41_arg0.overrides)
			f41_arg0.FixedScale:completeAnimation()
			f41_arg0.FixedScale.label:completeAnimation()
			f41_arg0.FixedScale:setAlpha(1)
			f41_arg0.FixedScale.label:setText(Engine[0xF9F1239CFD921FE](0x4FA615DA76883A8))
			f41_arg0.clipFinished(f41_arg0.FixedScale)
			f41_arg0.FreeScale:completeAnimation()
			f41_arg0.FreeScale:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.FreeScale)
		end,
	},
}
CoD.PaintshopControlsFull.__onClose = function(f42_arg0)
	f42_arg0.ColorPicker:close()
	f42_arg0.materialPicker:close()
	f42_arg0.PaintshopChooseSide0:close()
	f42_arg0.rsOpacity:close()
	f42_arg0.lsOpacity:close()
	f42_arg0.ToggleOutline:close()
	f42_arg0.Clip:close()
	f42_arg0.overrides:close()
	f42_arg0.rightTriggerButton:close()
	f42_arg0.leftTriggerButton:close()
	f42_arg0.Flip:close()
	f42_arg0.FixedScale:close()
	f42_arg0.FreeScale:close()
	f42_arg0.Move:close()
	f42_arg0.PaintshopChooseSide:close()
end
