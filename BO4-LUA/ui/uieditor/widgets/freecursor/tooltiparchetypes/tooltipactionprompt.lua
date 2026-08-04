require("ui/uieditor/widgets/freecursor/freecursordetaileddescriptioncontainer")
require("ui/uieditor/widgets/freecursor/freecursorheaderlabelcontainer")
require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursorbuttonpromptinfo")
require("ui/uieditor/widgets/showhideimage")
CoD.TooltipActionPrompt = InheritFrom(LUI.UIElement)
CoD.TooltipActionPrompt.__defaultWidth = 405
CoD.TooltipActionPrompt.__defaultHeight = 377
CoD.TooltipActionPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.TooltipActionPrompt)
	self.id = "TooltipActionPrompt"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local titleContainer = CoD.freeCursorHeaderLabelContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 0, 36)
	titleContainer:linkToElementModel(self, nil, false, function(model)
		titleContainer:setModel(model, f1_arg1)
	end)
	self:addElement(titleContainer)
	self.titleContainer = titleContainer
	local detailedDescriptionContainer = CoD.freeCursorDetailedDescriptionContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 36, 236)
	detailedDescriptionContainer:linkToElementModel(self, nil, false, function(model)
		detailedDescriptionContainer:setModel(model, f1_arg1)
	end)
	self:addElement(detailedDescriptionContainer)
	self.detailedDescriptionContainer = detailedDescriptionContainer
	local cautionHintShort = CoD.showHideImage.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 236, 241)
	cautionHintShort:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "cautionDescription")
			end,
		},
	})
	cautionHintShort:linkToElementModel(cautionHintShort, "cautionDescription", true, function(model)
		f1_arg0:updateElementState(cautionHintShort, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "cautionDescription",
		})
	end)
	cautionHintShort:setRGB(0.97, 0.92, 0.1)
	cautionHintShort:linkToElementModel(self, nil, false, function(model)
		cautionHintShort:setModel(model, f1_arg1)
	end)
	self:addElement(cautionHintShort)
	self.cautionHintShort = cautionHintShort
	local buttonPrompts = CoD.freeCursorButtonPromptInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 241, 277)
	buttonPrompts:linkToElementModel(self, nil, false, function(model)
		buttonPrompts:setModel(model, f1_arg1)
	end)
	self:addElement(buttonPrompts)
	self.buttonPrompts = buttonPrompts
	self:mergeStateConditions({
		{
			stateName = "DetailedDescription",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipInDetailedView(element, f1_arg1) and IsGamepad(f1_arg1)
			end,
		},
		{
			stateName = "DetailedDescriptionKBM",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipInDetailedView(element, f1_arg1) and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7["ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"],
		})
	end, false)
	self:linkToElementModel(self, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f13_arg1)
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine.GetModelForController(f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	buttonPrompts.id = "buttonPrompts"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.FreeCursorUtility.UseMaxVisibleChildWidth(self)
	CoD.FreeCursorUtility.UseVisibleChildrenHeight(self)
	return self
end
CoD.TooltipActionPrompt.__resetProperties = function(f15_arg0)
	f15_arg0.buttonPrompts:completeAnimation()
	f15_arg0.detailedDescriptionContainer:completeAnimation()
	f15_arg0.titleContainer:completeAnimation()
	f15_arg0.buttonPrompts:setAlpha(1)
	f15_arg0.detailedDescriptionContainer:setAlpha(1)
	f15_arg0.titleContainer:setAlpha(1)
end
CoD.TooltipActionPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.titleContainer:completeAnimation()
			f16_arg0.titleContainer:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.titleContainer)
			f16_arg0.detailedDescriptionContainer:completeAnimation()
			f16_arg0.detailedDescriptionContainer:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.detailedDescriptionContainer)
			f16_arg0.buttonPrompts:completeAnimation()
			f16_arg0.buttonPrompts:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.buttonPrompts)
		end,
		DetailedDescription = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(49)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.buttonPrompts:beginAnimation(150)
				f17_arg0.buttonPrompts:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.buttonPrompts:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.buttonPrompts:completeAnimation()
			f17_arg0.buttonPrompts:setAlpha(0.01)
			f17_local0(f17_arg0.buttonPrompts)
		end,
	},
	DetailedDescription = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.titleContainer:completeAnimation()
			f20_arg0.titleContainer:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.titleContainer)
			f20_arg0.detailedDescriptionContainer:completeAnimation()
			f20_arg0.detailedDescriptionContainer:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.detailedDescriptionContainer)
			f20_arg0.buttonPrompts:completeAnimation()
			f20_arg0.buttonPrompts:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.buttonPrompts)
		end,
	},
	DetailedDescriptionKBM = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.titleContainer:completeAnimation()
			f21_arg0.titleContainer:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.titleContainer)
			f21_arg0.detailedDescriptionContainer:completeAnimation()
			f21_arg0.detailedDescriptionContainer:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.detailedDescriptionContainer)
			f21_arg0.buttonPrompts:completeAnimation()
			f21_arg0.buttonPrompts:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.buttonPrompts)
		end,
		DefaultState = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.titleContainer:beginAnimation(110)
				f22_arg0.titleContainer:setAlpha(0)
				f22_arg0.titleContainer:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.titleContainer:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.titleContainer:completeAnimation()
			f22_arg0.titleContainer:setAlpha(1)
			f22_local0(f22_arg0.titleContainer)
			f22_arg0.detailedDescriptionContainer:completeAnimation()
			f22_arg0.detailedDescriptionContainer:setAlpha(1)
			f22_arg0.detailedDescriptionContainer:playClip("Closing")
			f22_arg0.clipFinished(f22_arg0.detailedDescriptionContainer)
			local f22_local1 = function(f24_arg0)
				f22_arg0.buttonPrompts:beginAnimation(110)
				f22_arg0.buttonPrompts:setAlpha(1)
				f22_arg0.buttonPrompts:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.buttonPrompts:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.buttonPrompts:completeAnimation()
			f22_arg0.buttonPrompts:setAlpha(0)
			f22_local1(f22_arg0.buttonPrompts)
		end,
	},
}
CoD.TooltipActionPrompt.__onClose = function(f25_arg0)
	f25_arg0.titleContainer:close()
	f25_arg0.detailedDescriptionContainer:close()
	f25_arg0.cautionHintShort:close()
	f25_arg0.buttonPrompts:close()
end
