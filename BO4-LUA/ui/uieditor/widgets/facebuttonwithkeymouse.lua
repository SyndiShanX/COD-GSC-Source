local PostLoadFunc = function(self, controller, menu)
	self:setHandleMouse(true)
end
CoD.FaceButtonWithKeyMouse = InheritFrom(LUI.UIElement)
CoD.FaceButtonWithKeyMouse.__defaultWidth = 30
CoD.FaceButtonWithKeyMouse.__defaultHeight = 30
CoD.FaceButtonWithKeyMouse.new = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	local self = LUI.UIElement.new(f2_arg2, f2_arg3, f2_arg4, f2_arg5, f2_arg6, f2_arg7, f2_arg8, f2_arg9)
	self:setClass(CoD.FaceButtonWithKeyMouse)
	self.id = "FaceButtonWithKeyMouse"
	self.soundSet = "Special_widgets"
	f2_arg0:addElementToPendingUpdateStateList(self)
	local KeyMouseImage = nil
	KeyMouseImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	KeyMouseImage:setImage(RegisterImage(0xE84DB39761B4029))
	self:addElement(KeyMouseImage)
	self.KeyMouseImage = KeyMouseImage
	local ControllerImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ControllerImage:subscribeToGlobalModel(f2_arg1, "Controller", "alt1_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ControllerImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(ControllerImage)
	self.ControllerImage = ControllerImage
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "KeyMouse",
			condition = function(menu, element, event)
				local f5_local0
				if not IsGamepad(f2_arg1) then
					f5_local0 = IsPC()
					if f5_local0 then
						f5_local0 = AlwaysFalse()
					end
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f2_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f2_arg0
		f2_arg0:updateElementState(self, f7_arg1)
	end)
	local f2_local3 = self
	local f2_local4 = self.subscribeToModel
	local f2_local5 = Engine[0x4DF5CFBC1771947](f2_arg1)
	f2_local4(f2_local3, f2_local5.LastInput, function(f8_arg0)
		f2_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f2_arg0,
			controller = f2_arg1,
			modelValue = f8_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg1, f2_arg0)
	end
	return self
end
CoD.FaceButtonWithKeyMouse.__resetProperties = function(f9_arg0)
	f9_arg0.KeyMouseImage:completeAnimation()
	f9_arg0.ControllerImage:completeAnimation()
	f9_arg0.KeyMouseImage:setRGB(1, 1, 1)
	f9_arg0.KeyMouseImage:setAlpha(1)
	f9_arg0.ControllerImage:setAlpha(1)
end
CoD.FaceButtonWithKeyMouse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.KeyMouseImage:completeAnimation()
			f10_arg0.KeyMouseImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.KeyMouseImage)
			f10_arg0.ControllerImage:completeAnimation()
			f10_arg0.ControllerImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ControllerImage)
		end,
	},
	Hide = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.KeyMouseImage:completeAnimation()
			f11_arg0.KeyMouseImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.KeyMouseImage)
			f11_arg0.ControllerImage:completeAnimation()
			f11_arg0.ControllerImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ControllerImage)
		end,
	},
	KeyMouse = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.ControllerImage:completeAnimation()
			f12_arg0.ControllerImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ControllerImage)
		end,
		Focus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.KeyMouseImage:completeAnimation()
			f13_arg0.KeyMouseImage:setRGB(1, 0.41, 0)
			f13_arg0.clipFinished(f13_arg0.KeyMouseImage)
			f13_arg0.ControllerImage:completeAnimation()
			f13_arg0.ControllerImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ControllerImage)
		end,
	},
	Gamepad = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.KeyMouseImage:completeAnimation()
			f14_arg0.KeyMouseImage:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.KeyMouseImage)
			f14_arg0.ControllerImage:completeAnimation()
			f14_arg0.ControllerImage:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ControllerImage)
		end,
	},
}
CoD.FaceButtonWithKeyMouse.__onClose = function(f15_arg0)
	f15_arg0.ControllerImage:close()
end
