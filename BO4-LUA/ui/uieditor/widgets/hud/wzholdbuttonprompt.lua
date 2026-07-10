require("x64:f65b3780508b5c7")
require("x64:ef0585bf703baa8")
CoD.WZHoldButtonPrompt = InheritFrom(LUI.UIElement)
CoD.WZHoldButtonPrompt.__defaultWidth = 89
CoD.WZHoldButtonPrompt.__defaultHeight = 42
CoD.WZHoldButtonPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZHoldButtonPrompt)
	self.id = "WZHoldButtonPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonProgressRing = CoD.ButtonProgressRing.new(f1_arg0, f1_arg1, 0.5, 0.5, -21, 21, 0.5, 0.5, -21, 21)
	ButtonProgressRing:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	ButtonProgressRing:setScale(0.7, 0.7)
	ButtonProgressRing.progressRing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(ButtonProgressRing)
	self.ButtonProgressRing = ButtonProgressRing
	local ControllerDependentTextBox = CoD.ControllerDependent_TextBoxLargeGamepad.new(f1_arg0, f1_arg1, 0.5, 0.5, -44.5, 44.5, 0.5, 0.5, -11, 11)
	ControllerDependentTextBox.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+activate}]"))
	ControllerDependentTextBox.KBMText:setLetterSpacing(0)
	ControllerDependentTextBox.GamepadText:setText(CoD.BaseUtility.AlreadyLocalized("[{+usereload}]"))
	ControllerDependentTextBox.GamepadText:setLetterSpacing(0)
	ControllerDependentTextBox.GamepadText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "HideHold",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "PlayerSettingsUpdate", function(model)
		local f7_local0 = self
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "PlayerSettingsUpdate", "warzone_instant_pickups") then
			UpdateSelfState(self, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZHoldButtonPrompt.__resetProperties = function(f8_arg0)
	f8_arg0.ControllerDependentTextBox:completeAnimation()
	f8_arg0.ButtonProgressRing:completeAnimation()
	f8_arg0.ControllerDependentTextBox:setLeftRight(0.5, 0.5, -44.5, 44.5)
	f8_arg0.ControllerDependentTextBox:setTopBottom(0.5, 0.5, -11, 11)
	f8_arg0.ButtonProgressRing:setAlpha(1)
end
CoD.WZHoldButtonPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.ButtonProgressRing:completeAnimation()
			f10_arg0.ButtonProgressRing:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ButtonProgressRing)
			f10_arg0.ControllerDependentTextBox:completeAnimation()
			f10_arg0.ControllerDependentTextBox:setLeftRight(0.5, 0.5, -49.5, 39.5)
			f10_arg0.clipFinished(f10_arg0.ControllerDependentTextBox)
		end,
	},
	HideHold = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.ButtonProgressRing:completeAnimation()
			f11_arg0.ButtonProgressRing:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ButtonProgressRing)
			f11_arg0.ControllerDependentTextBox:completeAnimation()
			f11_arg0.ControllerDependentTextBox:setTopBottom(0.5, 0.5, -16, 16)
			f11_arg0.clipFinished(f11_arg0.ControllerDependentTextBox)
		end,
	},
}
CoD.WZHoldButtonPrompt.__onClose = function(f12_arg0)
	f12_arg0.ButtonProgressRing:close()
	f12_arg0.ControllerDependentTextBox:close()
end
