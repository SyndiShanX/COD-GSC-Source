require("x64:a2c4a319ea5353")
CoD.BumperButtonWithKeyMouseNoFocus = InheritFrom(LUI.UIElement)
CoD.BumperButtonWithKeyMouseNoFocus.__defaultWidth = 67
CoD.BumperButtonWithKeyMouseNoFocus.__defaultHeight = 45
CoD.BumperButtonWithKeyMouseNoFocus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BumperButtonWithKeyMouseNoFocus)
	self.id = "BumperButtonWithKeyMouseNoFocus"
	self.soundSet = "MultiplayerMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KeyMouseImage = nil
	KeyMouseImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	KeyMouseImage:setScale(0.5, 0.5)
	KeyMouseImage:setImage(RegisterImage(0x68630CE404D04A1))
	self:addElement(KeyMouseImage)
	self.KeyMouseImage = KeyMouseImage
	local ControllerImage = LUI.UIImage.new(0, 0, 1.5, 65.5, 0, 0, -9.5, 54.5)
	ControllerImage:setScale(0.6, 0.6)
	ControllerImage:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ControllerImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(ControllerImage)
	self.ControllerImage = ControllerImage
	local FETitleNumBrdr0 = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 1, 16, -16, 0, 1, 2, -2)
	FETitleNumBrdr0:setAlpha(0)
	FETitleNumBrdr0:setScale(0.9, 0.9)
	self:addElement(FETitleNumBrdr0)
	self.FETitleNumBrdr0 = FETitleNumBrdr0
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "KeyMouse",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BumperButtonWithKeyMouseNoFocus.__resetProperties = function(f8_arg0)
	f8_arg0.KeyMouseImage:completeAnimation()
	f8_arg0.ControllerImage:completeAnimation()
	f8_arg0.KeyMouseImage:setRGB(1, 1, 1)
	f8_arg0.KeyMouseImage:setAlpha(1)
	f8_arg0.KeyMouseImage:setScale(0.5, 0.5)
	f8_arg0.ControllerImage:setAlpha(1)
end
CoD.BumperButtonWithKeyMouseNoFocus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.KeyMouseImage:completeAnimation()
			f9_arg0.KeyMouseImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KeyMouseImage)
			f9_arg0.ControllerImage:completeAnimation()
			f9_arg0.ControllerImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ControllerImage)
		end,
	},
	Hidden = {
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
	KeyMouse = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.KeyMouseImage:completeAnimation()
			f11_arg0.KeyMouseImage:setRGB(0.96, 0.93, 0.84)
			f11_arg0.KeyMouseImage:setAlpha(0.4)
			f11_arg0.clipFinished(f11_arg0.KeyMouseImage)
			f11_arg0.ControllerImage:completeAnimation()
			f11_arg0.ControllerImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ControllerImage)
		end,
		CustomFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.KeyMouseImage:completeAnimation()
			f12_arg0.KeyMouseImage:setRGB(0.96, 0.93, 0.84)
			f12_arg0.KeyMouseImage:setScale(0.6, 0.6)
			f12_arg0.clipFinished(f12_arg0.KeyMouseImage)
			f12_arg0.ControllerImage:completeAnimation()
			f12_arg0.ControllerImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ControllerImage)
		end,
	},
	Gamepad = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.KeyMouseImage:completeAnimation()
			f13_arg0.KeyMouseImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.KeyMouseImage)
		end,
	},
}
if not CoD.isPC then
	CoD.BumperButtonWithKeyMouseNoFocus.__clipsPerState.KeyMouse.DefaultClip = nil
	CoD.BumperButtonWithKeyMouseNoFocus.__clipsPerState.KeyMouse.CustomFocus = nil
end
CoD.BumperButtonWithKeyMouseNoFocus.__onClose = function(f14_arg0)
	f14_arg0.ControllerImage:close()
	f14_arg0.FETitleNumBrdr0:close()
end
