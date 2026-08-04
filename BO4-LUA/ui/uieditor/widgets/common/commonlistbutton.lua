require("ui/uieditor/widgets/director/directorselectbuttonminiinternal")
CoD.CommonListButton = InheritFrom(LUI.UIElement)
CoD.CommonListButton.__defaultWidth = 360
CoD.CommonListButton.__defaultHeight = 40
CoD.CommonListButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonListButton)
	self.id = "CommonListButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 360, 0, 0, 0, 40)
	DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	DirectorSelectButtonMiniInternal:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	DirectorSelectButtonMiniInternal:linkToElementModel(self, "displayText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsDisabled(element, f1_arg1) and not PropertyIsTrue(self, "hideHelpItemLabel")
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
	self.__defaultFocus = DirectorSelectButtonMiniInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonListButton.__onClose = function(f6_arg0)
	f6_arg0.DirectorSelectButtonMiniInternal:close()
end
