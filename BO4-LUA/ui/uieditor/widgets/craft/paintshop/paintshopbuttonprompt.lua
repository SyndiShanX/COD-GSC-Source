CoD.PaintshopButtonPrompt = InheritFrom(LUI.UIElement)
CoD.PaintshopButtonPrompt.__defaultWidth = 400
CoD.PaintshopButtonPrompt.__defaultHeight = 36
CoD.PaintshopButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintshopButtonPrompt)
	self.id = "PaintshopButtonPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPromptImage = LUI.UIImage.new(0, 0, 0, 36, 0, 0, 0, 36)
	self:addElement(buttonPromptImage)
	self.buttonPromptImage = buttonPromptImage
	local label = LUI.UIText.new(0, 1, 60, -8, 0, 0, 4, 29)
	label:setText("")
	label:setTTF("ttmussels_regular")
	label:setLetterSpacing(2)
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	label:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(label)
	self.label = label
	self:mergeStateConditions({
		{
			stateName = "KM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintshopButtonPrompt.__resetProperties = function(f7_arg0)
	f7_arg0.label:completeAnimation()
	f7_arg0.buttonPromptImage:completeAnimation()
	f7_arg0.label:setAlpha(1)
	f7_arg0.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	f7_arg0.buttonPromptImage:setLeftRight(0, 0, 0, 36)
	f7_arg0.buttonPromptImage:setTopBottom(0, 0, 0, 36)
	f7_arg0.buttonPromptImage:setAlpha(1)
end
CoD.PaintshopButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		Hide = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.buttonPromptImage:completeAnimation()
			f9_arg0.buttonPromptImage:setLeftRight(0, 0, 0, 48)
			f9_arg0.buttonPromptImage:setTopBottom(0, 0, 0, 46)
			f9_arg0.buttonPromptImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttonPromptImage)
			f9_arg0.label:completeAnimation()
			f9_arg0.label:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.label)
		end,
	},
	KM = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.buttonPromptImage:completeAnimation()
			f10_arg0.buttonPromptImage:setAlpha(0.99)
			f10_arg0.clipFinished(f10_arg0.buttonPromptImage)
			f10_arg0.label:completeAnimation()
			f10_arg0.label:setAlpha(1)
			f10_arg0.label:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f10_arg0.clipFinished(f10_arg0.label)
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.buttonPromptImage:completeAnimation()
			f11_arg0.buttonPromptImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.buttonPromptImage)
			f11_arg0.label:completeAnimation()
			f11_arg0.label:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.label)
		end,
	},
	Disabled = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.buttonPromptImage:completeAnimation()
			f12_arg0.buttonPromptImage:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.buttonPromptImage)
			f12_arg0.label:completeAnimation()
			f12_arg0.label:setAlpha(0.2)
			f12_arg0.clipFinished(f12_arg0.label)
		end,
	},
}
