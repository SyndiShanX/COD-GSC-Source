CoD.MPWheelPrompt = InheritFrom(LUI.UIElement)
CoD.MPWheelPrompt.__defaultWidth = 80
CoD.MPWheelPrompt.__defaultHeight = 80
CoD.MPWheelPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MPWheelPrompt)
	self.id = "MPWheelPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RStick = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40)
	RStick:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RStick:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(RStick)
	self.RStick = RStick
	self:mergeStateConditions({
		{
			stateName = "Keyboard",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MPWheelPrompt.__resetProperties = function(f6_arg0)
	f6_arg0.RStick:completeAnimation()
	f6_arg0.RStick:setAlpha(1)
end
CoD.MPWheelPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.RStick:completeAnimation()
			f7_arg0.RStick:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.RStick)
		end,
	},
	Keyboard = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.RStick:completeAnimation()
			f8_arg0.RStick:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.RStick)
		end,
	},
}
CoD.MPWheelPrompt.__onClose = function(f9_arg0)
	f9_arg0.RStick:close()
end
