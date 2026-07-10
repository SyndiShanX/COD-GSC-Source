require("x64:b363529a2e34794")
require("x64:34778f864da9dda")
CoD.BountyHunterOpenPrompt = InheritFrom(LUI.UIElement)
CoD.BountyHunterOpenPrompt.__defaultWidth = 300
CoD.BountyHunterOpenPrompt.__defaultHeight = 30
CoD.BountyHunterOpenPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterOpenPrompt)
	self.id = "BountyHunterOpenPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 0, 0, 300, 0.5, 0.5, -20, 20)
	Backing:setRGB(0.15, 0.15, 0.15)
	Backing:setAlpha(0.85)
	self:addElement(Backing)
	self.Backing = Backing
	local Prompt = LUI.UIText.new(0.5, 0.5, -150, 150, 0.5, 0.5, -15, 15)
	Prompt:setText(Engine[0xF9F1239CFD921FE](0x8CFE818E4F35809))
	Prompt:setTTF("ttmussels_regular")
	Prompt:setLetterSpacing(4)
	Prompt:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Prompt:setBackingType(1)
	Prompt:setBackingWidget(CoD.TextBackingCommonWithBlur, f1_arg0, f1_arg1)
	Prompt:setBackingXPadding(6)
	self:addElement(Prompt)
	self.Prompt = Prompt
	local PCPromptText = nil
	PCPromptText = LUI.UIText.new(0, 0, 66, 300, 0.5, 0.5, -15, 15)
	PCPromptText:setAlpha(0)
	PCPromptText:setText(Engine[0xF9F1239CFD921FE](0xA2CE63A1E424223))
	PCPromptText:setTTF("ttmussels_regular")
	PCPromptText:setLetterSpacing(4)
	PCPromptText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PCPromptText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	PCPromptText:setBackingType(1)
	PCPromptText:setBackingWidget(CoD.TextBackingCommonWithBlur, f1_arg0, f1_arg1)
	PCPromptText:setBackingXPadding(6)
	LUI.OverrideFunction_CallOriginalFirst(PCPromptText, "setText", function(element, controller)
		if IsPC() then
			ScaleWidgetToLabel(self, element, 0)
		end
	end)
	self:addElement(PCPromptText)
	self.PCPromptText = PCPromptText
	local ControllerDependentTextBox = nil
	ControllerDependentTextBox = CoD.ControllerDependent_TextBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, -91, 0.5, 0.5, -2, 20)
	ControllerDependentTextBox:mergeStateConditions({
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysTrue()
			end,
		},
	})
	local f1_local5 = ControllerDependentTextBox
	local f1_local6 = ControllerDependentTextBox.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f4_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local5 = ControllerDependentTextBox
	f1_local6 = ControllerDependentTextBox.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f5_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	ControllerDependentTextBox:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ControllerDependentTextBox, f6_arg1)
	end)
	f1_local5 = ControllerDependentTextBox
	f1_local6 = ControllerDependentTextBox.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(ControllerDependentTextBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ControllerDependentTextBox:setAlpha(0)
	ControllerDependentTextBox.KBMText:setText(CoD.BaseUtility.AlreadyLocalized("[{+activate}]"))
	ControllerDependentTextBox.GamepadText:setText(CoD.BaseUtility.AlreadyLocalized("^BBUTTON_CANCEL^"))
	ControllerDependentTextBox.GamepadText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ControllerDependentTextBox.GamepadText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(ControllerDependentTextBox)
	self.ControllerDependentTextBox = ControllerDependentTextBox
	self:mergeStateConditions({
		{
			stateName = "KeyboardMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	f1_local6 = ControllerDependentTextBox
	if IsGamepad(f1_arg1) then
		HideWidget(f1_local6)
	end
	return self
end
CoD.BountyHunterOpenPrompt.__resetProperties = function(f11_arg0)
	f11_arg0.Prompt:completeAnimation()
	f11_arg0.ControllerDependentTextBox:completeAnimation()
	f11_arg0.PCPromptText:completeAnimation()
	f11_arg0.Prompt:setAlpha(1)
	f11_arg0.ControllerDependentTextBox:setAlpha(0)
	f11_arg0.PCPromptText:setAlpha(0)
end
CoD.BountyHunterOpenPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	KeyboardMouse = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.Prompt:completeAnimation()
			f13_arg0.Prompt:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Prompt)
			f13_arg0.PCPromptText:completeAnimation()
			f13_arg0.PCPromptText:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.PCPromptText)
			f13_arg0.ControllerDependentTextBox:completeAnimation()
			f13_arg0.ControllerDependentTextBox:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.ControllerDependentTextBox)
		end,
	},
}
CoD.BountyHunterOpenPrompt.__onClose = function(f14_arg0)
	f14_arg0.ControllerDependentTextBox:close()
end
