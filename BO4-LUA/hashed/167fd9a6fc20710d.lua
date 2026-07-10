require("x64:58c18133f12be4a")
require("x64:a86bdd41c06859a")
require("x64:bce07fcd345de2a")
CoD.EmblemEditorMaterialControls = InheritFrom(LUI.UIElement)
CoD.EmblemEditorMaterialControls.__defaultWidth = 420
CoD.EmblemEditorMaterialControls.__defaultHeight = 190
CoD.EmblemEditorMaterialControls.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemEditorMaterialControls)
	self.id = "EmblemEditorMaterialControls"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingTop = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 0, 190)
	BackingTop:setImage(RegisterImage(0x34839E8065B1E53))
	BackingTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingTop:setShaderVector(0, 0, 0, 0, 0)
	BackingTop:setupNineSliceShader(196, 88)
	self:addElement(BackingTop)
	self.BackingTop = BackingTop
	local rotateText = LUI.UIText.new(0, 0, 82, 360, 0, 0, 117.5, 142.5)
	rotateText:setText(Engine[0xF9F1239CFD921FE](0xC718AEEBB3E6B97))
	rotateText:setTTF("ttmussels_regular")
	rotateText:setLetterSpacing(2)
	rotateText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	rotateText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(rotateText)
	self.rotateText = rotateText
	local rightTriggerButton = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 39, 73, 0, 0, 109, 155)
	rightTriggerButton.label:setText("")
	rightTriggerButton:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			rightTriggerButton.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(rightTriggerButton)
	self.rightTriggerButton = rightTriggerButton
	local leftTriggerButton = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 3, 39, 0, 0, 109, 155)
	leftTriggerButton.label:setText("")
	leftTriggerButton:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			leftTriggerButton.buttonPromptImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(leftTriggerButton)
	self.leftTriggerButton = leftTriggerButton
	local FreeScale = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 380, 0, 0, 71, 117)
	FreeScale.label:setText(Engine[0xF9F1239CFD921FE](0xDD45E7A84A50DF9))
	FreeScale:subscribeToGlobalModel(f1_arg1, "Controller", "right_stick_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			FreeScale.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(FreeScale)
	self.FreeScale = FreeScale
	local FixedScale = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 380, 0, 0, 71, 117)
	FixedScale:setAlpha(0)
	FixedScale.label:setText(Engine[0xF9F1239CFD921FE](0xAD2AED6D89BCC15))
	FixedScale:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			FixedScale.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(FixedScale)
	self.FixedScale = FixedScale
	local ChangeColor = CoD.PaintshopButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 20, 370, 0, 0, 33, 79)
	ChangeColor.label:setText(Engine[0xF9F1239CFD921FE](0xC74469D97E52F55))
	ChangeColor:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ChangeColor.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(ChangeColor)
	self.ChangeColor = ChangeColor
	local dividerH = LUI.UIImage.new(0, 0, 0, 420, 0, 0, 22.5, 26.5)
	dividerH:setAlpha(0.2)
	dividerH:setImage(RegisterImage(0x84B43D5B04D263A))
	dividerH:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	dividerH:setShaderVector(0, 0, 0, 0, 0)
	dividerH:setupNineSliceShader(8, 4)
	self:addElement(dividerH)
	self.dividerH = dividerH
	local Frame01 = LUI.UIImage.new(0, 0, -1, 421, 0, 0, 0, 190)
	Frame01:setAlpha(0.2)
	Frame01:setImage(RegisterImage(0x185E11D74ECA3D7))
	Frame01:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Frame01:setShaderVector(0, 0, 0, 0, 0)
	Frame01:setupNineSliceShader(16, 16)
	self:addElement(Frame01)
	self.Frame01 = Frame01
	local PaintshopChooseSide = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 0, 6, 426, 0, 0, 4.5, 36.5)
	PaintshopChooseSide.text:setText(Engine[0xF9F1239CFD921FE](0xE6011EEF766C653))
	self:addElement(PaintshopChooseSide)
	self.PaintshopChooseSide = PaintshopChooseSide
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemEditorMaterialControls.__resetProperties = function(f7_arg0)
	f7_arg0.FixedScale:completeAnimation()
	f7_arg0.FreeScale:completeAnimation()
	f7_arg0.FixedScale:setAlpha(0)
	f7_arg0.FreeScale:setAlpha(1)
end
CoD.EmblemEditorMaterialControls.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.FreeScale:completeAnimation()
			f8_arg0.FreeScale:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.FreeScale)
			f8_arg0.FixedScale:completeAnimation()
			f8_arg0.FixedScale:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.FixedScale)
		end,
	},
	FixedScale = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.FreeScale:completeAnimation()
			f9_arg0.FreeScale:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.FreeScale)
			f9_arg0.FixedScale:completeAnimation()
			f9_arg0.FixedScale:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.FixedScale)
		end,
	},
	FreeScale = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.EmblemEditorMaterialControls.__onClose = function(f11_arg0)
	f11_arg0.rightTriggerButton:close()
	f11_arg0.leftTriggerButton:close()
	f11_arg0.FreeScale:close()
	f11_arg0.FixedScale:close()
	f11_arg0.ChangeColor:close()
	f11_arg0.PaintshopChooseSide:close()
end
