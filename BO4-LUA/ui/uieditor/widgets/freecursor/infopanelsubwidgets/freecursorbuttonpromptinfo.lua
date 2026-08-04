require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursorbuttonpromptarea")
require("ui/uieditor/widgets/onoffimageanimated")
CoD.freeCursorButtonPromptInfo = InheritFrom(LUI.UIElement)
CoD.freeCursorButtonPromptInfo.__defaultWidth = 1076
CoD.freeCursorButtonPromptInfo.__defaultHeight = 36
CoD.freeCursorButtonPromptInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorButtonPromptInfo)
	self.id = "freeCursorButtonPromptInfo"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local buttonPrompts = CoD.freeCursorButtonPromptArea.new(f1_arg0, f1_arg1, 0, 0, 0, 1044, 0, 0, 0, 36)
	buttonPrompts:linkToElementModel(self, nil, false, function(model)
		buttonPrompts:setModel(model, f1_arg1)
	end)
	self:addElement(buttonPrompts)
	self.buttonPrompts = buttonPrompts
	local detailsButton = CoD.onOffImageAnimated.new(f1_arg0, f1_arg1, 0, 0, 1044, 1076, 0, 0, 0, 33)
	detailsButton:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(self, f1_arg1, "detailedDescription")
				if f3_local0 then
					if not CoD.ModelUtility.AreButtonModelValueBitsSet(f1_arg1, Enum.LUIButton[@"lui_key_rtrig"], Enum.LUIButtonFlags[@"flag_down"]) then
						f3_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(self.detailsButton, f1_arg1, "detailedViewPC")
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
	})
	detailsButton:linkToElementModel(detailsButton, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(detailsButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	local f1_local3 = detailsButton
	local f1_local4 = detailsButton.subscribeToModel
	local f1_local5 = Engine.GetModelForController(f1_arg1)
	f1_local4(f1_local3, f1_local5["ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"]], function(f5_arg0)
		f1_arg0:updateElementState(detailsButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ButtonBits." .. Enum.LUIButton[@"lui_key_rtrig"],
		})
	end, false)
	detailsButton:linkToElementModel(detailsButton, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(detailsButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	detailsButton:subscribeToGlobalModel(f1_arg1, "Controller", "mouse_right_button_image", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			detailsButton.promptContainer.KeyMouseImage:setImage(RegisterImage(f7_local0))
		end
	end)
	detailsButton:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			detailsButton.promptContainer.ControllerImage:setImage(RegisterImage(f8_local0))
		end
	end)
	detailsButton:linkToElementModel(self, nil, false, function(model)
		detailsButton:setModel(model, f1_arg1)
	end)
	self:addElement(detailsButton)
	self.detailsButton = detailsButton
	self:subscribeToGlobalModel(f1_arg1, "FreeCursor", "contextualInfo.detailedView", function(model)
		local f10_local0 = self
		CoD.FreeCursorUtility.AnimateToHorizontalLeftLayout(self, 200)
	end)
	self:subscribeToGlobalModel(f1_arg1, "FreeCursor", "contextualInfo.updated", function(model)
		local f11_local0 = self
		CoD.FreeCursorUtility.AnimateToHorizontalLeftLayout(self, 0)
	end)
	buttonPrompts.id = "buttonPrompts"
	detailsButton.id = "detailsButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	CoD.FreeCursorUtility.UseVisibleChildrenWidth(self)
	CoD.FreeCursorUtility.UseVisibleChildrenHeight(self)
	CoD.FreeCursorUtility.SetIgnoredByVerticalLayout(self.detailsButton)
	return self
end
CoD.freeCursorButtonPromptInfo.__onClose = function(f12_arg0)
	f12_arg0.buttonPrompts:close()
	f12_arg0.detailsButton:close()
end
