require("x64:4fb5d5732c72812")
require("x64:246178cf189051b")
CoD.CodCasterButtonPrompt = InheritFrom(LUI.UIElement)
CoD.CodCasterButtonPrompt.__defaultWidth = 150
CoD.CodCasterButtonPrompt.__defaultHeight = 48
CoD.CodCasterButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CodCasterButtonPrompt)
	self.id = "CodCasterButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local progressRing = CoD.ButtonProgressRingContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 42, 0, 0, 3, 45)
	progressRing:linkToElementModel(self, nil, false, function(model)
		progressRing:setModel(model, f1_arg1)
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local buttonPromptImage = LUI.UIImage.new(0, 0, 42, 72, 0, 0, 9, 39)
	buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 72, 108, 0, 0, 6, 42)
	KeyPrompt:setAlpha(0)
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	local label = LUI.UIText.new(0, 0, 108, 177, 0, 0, 14, 34)
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
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_disable_prompts"]) and not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
			end,
		},
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"]) and not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
			end,
		},
		{
			stateName = "InitialState",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum[@"luibuttonpromptstates"][@"flag_enable_prompts"]) and not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1)
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
	f1_local6(f1_local5, f1_local7.usingCursorInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.hidden, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.activeKeys, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
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
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		if IsSelfInState(self, "DefaultState") and not IsPC() then
			HideWidget(element)
		elseif not IsPC() then
			ShowWidget(element)
		end
	end)
	self.__on_menuOpened_self = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		local f15_local0 = self
		if IsPC() then
			HideWidget(self.buttonPromptImage)
			HideWidget(self.progressRing)
			ShowWidget(self.KeyPrompt)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "LastInput", function(model)
		local f16_local0 = self
		if IsCodCaster(f1_arg1) and IsMouseOrKeyboard(f1_arg1) then
			HideWidget(self.buttonPromptImage)
			HideWidget(self.progressRing)
			ShowWidget(self.KeyPrompt)
		elseif IsCodCaster(f1_arg1) and IsGamepad(f1_arg1) then
			ShowWidget(self.buttonPromptImage)
			ShowWidget(self.progressRing)
			HideWidget(self.KeyPrompt)
		end
	end)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
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
CoD.CodCasterButtonPrompt.__resetProperties = function(f18_arg0)
	f18_arg0.buttonPromptImage:completeAnimation()
	f18_arg0.label:completeAnimation()
	f18_arg0.progressRing:completeAnimation()
	f18_arg0.KeyPrompt:completeAnimation()
	f18_arg0.buttonPromptImage:setRGB(1, 1, 1)
	f18_arg0.buttonPromptImage:setAlpha(1)
	f18_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
	f18_arg0.buttonPromptImage:setShaderVector(0, 1, 0, 0, 0)
	f18_arg0.label:setLeftRight(0, 0, 108, 177)
	f18_arg0.label:setRGB(1, 1, 1)
	f18_arg0.label:setAlpha(1)
	f18_arg0.progressRing:setLeftRight(0, 0, 0, 42)
	f18_arg0.progressRing:setAlpha(1)
	f18_arg0.KeyPrompt:setAlpha(0)
end
CoD.CodCasterButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.progressRing:completeAnimation()
			f19_arg0.progressRing:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.progressRing)
			f19_arg0.buttonPromptImage:completeAnimation()
			f19_arg0.buttonPromptImage:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.buttonPromptImage)
			f19_arg0.KeyPrompt:completeAnimation()
			f19_arg0.KeyPrompt:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.KeyPrompt)
			f19_arg0.label:completeAnimation()
			f19_arg0.label:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.label)
		end,
	},
	Disabled = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.buttonPromptImage:completeAnimation()
			f20_arg0.buttonPromptImage:setRGB(0.5, 0.5, 0.5)
			f20_arg0.buttonPromptImage:setAlpha(0.5)
			f20_arg0.buttonPromptImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_saturation_normal"))
			f20_arg0.buttonPromptImage:setShaderVector(0, 0, 0, 0, 0)
			f20_arg0.clipFinished(f20_arg0.buttonPromptImage)
			f20_arg0.label:completeAnimation()
			f20_arg0.label:setRGB(0.5, 0.5, 0.5)
			f20_arg0.label:setAlpha(0.5)
			f20_arg0.clipFinished(f20_arg0.label)
		end,
	},
	Enabled = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		Hide = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.buttonPromptImage:completeAnimation()
			f22_arg0.buttonPromptImage:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.buttonPromptImage)
			f22_arg0.label:completeAnimation()
			f22_arg0.label:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.label)
		end,
		Focus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.label:completeAnimation()
			f23_arg0.label:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.label)
		end,
	},
	InitialState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	Gamepad = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.progressRing:completeAnimation()
			f25_arg0.progressRing:setLeftRight(0, 0, 0, 0)
			f25_arg0.progressRing:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.progressRing)
			f25_arg0.KeyPrompt:completeAnimation()
			f25_arg0.KeyPrompt:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.KeyPrompt)
			f25_arg0.label:completeAnimation()
			f25_arg0.label:setLeftRight(0, 0, 142.5, 142.5)
			f25_arg0.label:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.label)
		end,
	},
}
if not CoD.isPC then
	CoD.CodCasterButtonPrompt.__clipsPerState.Enabled.Focus = nil
end
CoD.CodCasterButtonPrompt.__onClose = function(f26_arg0)
	f26_arg0.__on_close_removeOverrides()
	f26_arg0.progressRing:close()
	f26_arg0.buttonPromptImage:close()
	f26_arg0.KeyPrompt:close()
	f26_arg0.label:close()
end
