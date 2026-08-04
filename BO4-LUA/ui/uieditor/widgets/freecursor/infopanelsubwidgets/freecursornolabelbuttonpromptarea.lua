require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursornolabelbuttonpromptcontainer")
CoD.freeCursorNoLabelButtonPromptArea = InheritFrom(LUI.UIElement)
CoD.freeCursorNoLabelButtonPromptArea.__defaultWidth = 300
CoD.freeCursorNoLabelButtonPromptArea.__defaultHeight = 36
CoD.freeCursorNoLabelButtonPromptArea.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.freeCursorNoLabelButtonPromptArea)
	self.id = "freeCursorNoLabelButtonPromptArea"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local buttonPrompts = CoD.freeCursorNoLabelButtonPromptContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 1.5, -18, -18)
	self:addElement(buttonPrompts)
	self.buttonPrompts = buttonPrompts
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.FreeCursorUtility.IsTooltipInDetailedView(self, f1_arg1)
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
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetModelForController(f1_arg1)
	f1_local3(f1_local2, f1_local4["ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
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
	self:linkToElementModel(self, "buttonPrompts", true, function(model)
		local f6_local0 = self
		CoD.FreeCursorUtility.RecreateNoLabelButtonPromptContainerAndLinkToSelfModelValue(self, f1_arg1, f1_arg0, "buttonPrompts", model)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.FreeCursorUtility.MakeResizingHorizontalLayout(self)
	return self
end
CoD.freeCursorNoLabelButtonPromptArea.__resetProperties = function(f7_arg0)
	f7_arg0.buttonPrompts:completeAnimation()
	f7_arg0.buttonPrompts:setAlpha(1)
end
CoD.freeCursorNoLabelButtonPromptArea.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.buttonPrompts:completeAnimation()
			f8_arg0.buttonPrompts:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.buttonPrompts)
		end,
	},
	Visible = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.buttonPrompts:completeAnimation()
			f9_arg0.buttonPrompts:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.buttonPrompts)
		end,
	},
}
CoD.freeCursorNoLabelButtonPromptArea.__onClose = function(f10_arg0)
	f10_arg0.buttonPrompts:close()
end
