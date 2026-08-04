require("ui/uieditor/widgets/buttonprogressringcontainer")
require("ui/uieditor/widgets/cac/newbreadcrumbcount")
CoD.FooterButtonPrompt = InheritFrom(LUI.UIElement)
CoD.FooterButtonPrompt.__defaultWidth = 150
CoD.FooterButtonPrompt.__defaultHeight = 48
CoD.FooterButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FooterButtonPrompt)
	self.id = "FooterButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 24, 54, 0, 0, 9, 39)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0, 0, 63, 132, 0, 0, 14, 34)
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(6)
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	label:linkToElementModel(self, "Label", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			label:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(label, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, -40)
	end)
	self:addElement(label)
	self.label = label
	local progressRing = CoD.ButtonProgressRingContainer.new(f1_arg0, f1_arg1, 0, 0, 18, 60, 0, 0, 3, 45)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f1_arg1)
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local newIcon = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 0, 0, -11, 8, 0.5, 0.5, -9, 9)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.ShouldShowTheMenuBreadcrumb(element, f1_arg1)
			end,
		},
	})
	newIcon:linkToElementModel(newIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	newIcon:setYRot(180)
	self:addElement(newIcon)
	self.newIcon = newIcon
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_disable_prompts"]) and not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_enable_prompts"]) and not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
			end,
		},
		{
			stateName = "InitialState",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.usingCursorInput, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.hidden, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7.activeKeys, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	self:linkToElementModel(self, "flags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f15_arg2, f15_arg3, f15_arg4)
		if IsSelfInState(self, "DefaultState") and not IsPC() then
			HideWidget(element)
		elseif not IsPC() then
			ShowWidget(element)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	if IsPC() then
		DisableKeyboardNavigationByElement(self)
	end
	return self
end
CoD.FooterButtonPrompt.__resetProperties = function(f16_arg0)
	f16_arg0.buttonPromptImage:completeAnimation()
	f16_arg0.label:completeAnimation()
	f16_arg0.progressRing:completeAnimation()
	f16_arg0.buttonPromptImage:setRGB(1, 1, 1)
	f16_arg0.buttonPromptImage:setAlpha(1)
	f16_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
	f16_arg0.buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	f16_arg0.label:setRGB(1, 1, 1)
	f16_arg0.label:setAlpha(1)
	f16_arg0.progressRing:setAlpha(1)
end
CoD.FooterButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.buttonPromptImage:completeAnimation()
			f17_arg0.buttonPromptImage:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.buttonPromptImage)
			f17_arg0.label:completeAnimation()
			f17_arg0.label:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.label)
			f17_arg0.progressRing:completeAnimation()
			f17_arg0.progressRing:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.progressRing)
		end,
	},
	Disabled = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.buttonPromptImage:completeAnimation()
			f18_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f18_arg0.buttonPromptImage:setAlpha(0.5)
			f18_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial("uie_saturation_normal"))
			f18_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f18_arg0.clipFinished(f18_arg0.buttonPromptImage)
			f18_arg0.label:completeAnimation()
			f18_arg0.label:setRGB(0.5, 0.5, 0.5)
			f18_arg0.label:setAlpha(0.5)
			f18_arg0.clipFinished(f18_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		Hide = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.buttonPromptImage:completeAnimation()
			f20_arg0.buttonPromptImage:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.buttonPromptImage)
			f20_arg0.label:completeAnimation()
			f20_arg0.label:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.label)
		end,
		Focus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.label:completeAnimation()
			f21_arg0.label:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.label)
		end,
	},
	InitialState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
}
if not CoD.isPC then
	CoD.FooterButtonPrompt.__clipsPerState.Enabled.Focus = nil
end
CoD.FooterButtonPrompt.__onClose = function(f23_arg0)
	f23_arg0.label:close()
	f23_arg0.progressRing:close()
	f23_arg0.newIcon:close()
end
