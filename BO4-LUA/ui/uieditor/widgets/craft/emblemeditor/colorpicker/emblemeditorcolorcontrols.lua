require("x64:58c18133f12be4a")
require("x64:a86bdd41c06859a")
require("x64:bce07fcd345de2a")
CoD.EmblemEditorColorControls = InheritFrom(LUI.UIElement)
CoD.EmblemEditorColorControls.__defaultWidth = 420
CoD.EmblemEditorColorControls.__defaultHeight = 202
CoD.EmblemEditorColorControls.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorColorControls)
	self.id = "EmblemEditorColorControls"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setAlpha(0.5)
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBackingAdd = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 0, 32)
	NoiseTiledBackingAdd:setAlpha(0.2)
	NoiseTiledBackingAdd:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(12, 12)
	self:addElement(Frame)
	self.Frame = Frame
	local rsOpacity = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 40, 76, 0, 0, 84, 120)
	rsOpacity.label:setText("")
	rsOpacity:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			rsOpacity.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(rsOpacity)
	self.rsOpacity = rsOpacity
	local lsOpacity = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 3, 39, 0, 0, 84, 120)
	lsOpacity.label:setText("")
	lsOpacity:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			lsOpacity.buttonPromptImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(lsOpacity)
	self.lsOpacity = lsOpacity
	local opacityText = LUI.UIText.new(1, 1, -339, -119, 0, 0, 89, 113)
	opacityText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6611006D6269F87D"))
	opacityText:setTTF("ttmussels_regular")
	opacityText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	opacityText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(opacityText)
	self.opacityText = opacityText
	local ChangeColor = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 45, 91)
	ChangeColor.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5D9555D6F5A195F2"))
	ChangeColor:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ChangeColor.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(ChangeColor)
	self.ChangeColor = ChangeColor
	local rotateText = LUI.UIText.new(1, 1, -339, -119, 0, 0, 166, 191)
	rotateText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_79327C6CD586A2F6"))
	rotateText:setTTF("ttmussels_regular")
	rotateText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	rotateText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(rotateText)
	self.rotateText = rotateText
	local rightTriggerButton = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 41, 75, 0, 0, 162, 208)
	rightTriggerButton.label:setText("")
	rightTriggerButton:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			rightTriggerButton.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(rightTriggerButton)
	self.rightTriggerButton = rightTriggerButton
	local leftTriggerButton = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 2, 38, 0, 0, 162, 208)
	leftTriggerButton.label:setText("")
	leftTriggerButton:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			leftTriggerButton.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(leftTriggerButton)
	self.leftTriggerButton = leftTriggerButton
	local ToggleOutline = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 420, 0, 0, 123, 169)
	ToggleOutline.label:setText(Engine[@"hash_4F9F1239CFD921FE"](0x219D9DA319169B))
	ToggleOutline:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ToggleOutline.buttonPromptImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(ToggleOutline)
	self.ToggleOutline = ToggleOutline
	local PaintshopChooseSide = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 0, 6, 426, 0, 0, 3.5, 35.5)
	PaintshopChooseSide:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	PaintshopChooseSide.text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7E6011EEF766C653"))
	self:addElement(PaintshopChooseSide)
	self.PaintshopChooseSide = PaintshopChooseSide
	local dividerH = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 30.5, 34.5)
	dividerH:setAlpha(0.2)
	dividerH:setImage(RegisterImage(@"hash_484B43D5B04D263A"))
	dividerH:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	dividerH:setShaderVector(0, 0, 0, 0, 0)
	dividerH:setupNineSliceShader(8, 4)
	self:addElement(dividerH)
	self.dividerH = dividerH
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorColorControls.__resetProperties = function(f8_arg0)
	f8_arg0.leftTriggerButton:completeAnimation()
	f8_arg0.rightTriggerButton:completeAnimation()
	f8_arg0.rotateText:completeAnimation()
	f8_arg0.ToggleOutline:completeAnimation()
	f8_arg0.lsOpacity:completeAnimation()
	f8_arg0.rsOpacity:completeAnimation()
	f8_arg0.opacityText:completeAnimation()
	f8_arg0.leftTriggerButton:setAlpha(1)
	f8_arg0.rightTriggerButton:setAlpha(1)
	f8_arg0.rotateText:setAlpha(1)
	f8_arg0.ToggleOutline.label:setText(Engine[@"hash_4F9F1239CFD921FE"](0x219D9DA319169B))
	f8_arg0.lsOpacity:setAlpha(1)
	f8_arg0.rsOpacity:setAlpha(1)
	f8_arg0.opacityText:setAlpha(1)
end
CoD.EmblemEditorColorControls.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Gradient = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.rotateText:completeAnimation()
			f10_arg0.rotateText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.rotateText)
			f10_arg0.rightTriggerButton:completeAnimation()
			f10_arg0.rightTriggerButton:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.rightTriggerButton)
			f10_arg0.leftTriggerButton:completeAnimation()
			f10_arg0.leftTriggerButton:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.leftTriggerButton)
		end,
	},
	Solid = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ToggleOutline:completeAnimation()
			f11_arg0.ToggleOutline.label:completeAnimation()
			f11_arg0.ToggleOutline.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4F3962C42FF92592"))
			f11_arg0.clipFinished(f11_arg0.ToggleOutline)
		end,
	},
	NoColor = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.rsOpacity:completeAnimation()
			f12_arg0.rsOpacity:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.rsOpacity)
			f12_arg0.lsOpacity:completeAnimation()
			f12_arg0.lsOpacity:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.lsOpacity)
			f12_arg0.opacityText:completeAnimation()
			f12_arg0.opacityText:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.opacityText)
			f12_arg0.ToggleOutline:completeAnimation()
			f12_arg0.ToggleOutline.label:completeAnimation()
			f12_arg0.ToggleOutline.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4F3962C42FF92592"))
			f12_arg0.clipFinished(f12_arg0.ToggleOutline)
		end,
	},
}
CoD.EmblemEditorColorControls.__onClose = function(f13_arg0)
	f13_arg0.rsOpacity:close()
	f13_arg0.lsOpacity:close()
	f13_arg0.ChangeColor:close()
	f13_arg0.rightTriggerButton:close()
	f13_arg0.leftTriggerButton:close()
	f13_arg0.ToggleOutline:close()
	f13_arg0.PaintshopChooseSide:close()
end
