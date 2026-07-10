CoD.ZMLoadoutPreviewActiveClass = InheritFrom(LUI.UIElement)
CoD.ZMLoadoutPreviewActiveClass.__defaultWidth = 245
CoD.ZMLoadoutPreviewActiveClass.__defaultHeight = 33
CoD.ZMLoadoutPreviewActiveClass.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMLoadoutPreviewActiveClass)
	self.id = "ZMLoadoutPreviewActiveClass"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ActiveClassTab = LUI.UIText.new(0, 0, 0, 245, 0, 0, 9, 33)
	ActiveClassTab:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ActiveClassTab:setTTF("ttmussels_demibold")
	ActiveClassTab:setLetterSpacing(2)
	ActiveClassTab:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ActiveClassTab:linkToElementModel(self, "customClassName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ActiveClassTab:setText(f2_local0)
		end
	end)
	self:addElement(ActiveClassTab)
	self.ActiveClassTab = ActiveClassTab
	self:mergeStateConditions({
		{
			stateName = "Selected",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueEqualToSelfModelValue(self, f1_arg1, "selectedCustomClass", "classNum")
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.selectedCustomClass, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "selectedCustomClass",
		})
	end, false)
	self:linkToElementModel(self, "classNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "classNum",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMLoadoutPreviewActiveClass.__resetProperties = function(f6_arg0)
	f6_arg0.ActiveClassTab:completeAnimation()
	f6_arg0.ActiveClassTab:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
end
CoD.ZMLoadoutPreviewActiveClass.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Selected = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ActiveClassTab:completeAnimation()
			f8_arg0.ActiveClassTab:setRGB(1, 0, 0)
			f8_arg0.clipFinished(f8_arg0.ActiveClassTab)
		end,
	},
}
CoD.ZMLoadoutPreviewActiveClass.__onClose = function(f9_arg0)
	f9_arg0.ActiveClassTab:close()
end
