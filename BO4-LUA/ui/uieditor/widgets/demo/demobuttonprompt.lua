CoD.DemoButtonPrompt = InheritFrom(LUI.UIElement)
CoD.DemoButtonPrompt.__defaultWidth = 115
CoD.DemoButtonPrompt.__defaultHeight = 30
CoD.DemoButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DemoButtonPrompt)
	self.id = "DemoButtonPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	buttonPromptImage:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0, 0, 45.5, 114.5, 0, 0, 4, 24)
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(6)
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	label:linkToElementModel(self, "Label", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			label:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(label, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, -40)
	end)
	self:addElement(label)
	self.label = label
	local KBMlabel = LUI.UIText.new(0.5, 0.5, -57.5, 57.5, 0, 0, 4, 24)
	KBMlabel:setAlpha(0)
	KBMlabel:setTTF("ttmussels_regular")
	KBMlabel:setLetterSpacing(6)
	KBMlabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	KBMlabel:linkToElementModel(self, "Label", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			KBMlabel:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(KBMlabel, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, -40)
	end)
	self:addElement(KBMlabel)
	self.KBMlabel = KBMlabel
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f8_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DemoButtonPrompt.__resetProperties = function(f10_arg0)
	f10_arg0.buttonPromptImage:completeAnimation()
	f10_arg0.label:completeAnimation()
	f10_arg0.KBMlabel:completeAnimation()
	f10_arg0.buttonPromptImage:setAlpha(1)
	f10_arg0.label:setAlpha(1)
	f10_arg0.KBMlabel:setAlpha(0)
end
CoD.DemoButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.buttonPromptImage:completeAnimation()
			f12_arg0.buttonPromptImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.buttonPromptImage)
			f12_arg0.label:completeAnimation()
			f12_arg0.label:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.label)
			f12_arg0.KBMlabel:completeAnimation()
			f12_arg0.KBMlabel:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.KBMlabel)
		end,
	},
}
CoD.DemoButtonPrompt.__onClose = function(f13_arg0)
	f13_arg0.buttonPromptImage:close()
	f13_arg0.label:close()
	f13_arg0.KBMlabel:close()
end
