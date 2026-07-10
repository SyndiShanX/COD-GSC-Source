require("x64:c5ba073329f007a")
require("x64:9cb1900193778bc")
CoD.ControllerDependent_TextBoxLargeGamepad = InheritFrom(LUI.UIElement)
CoD.ControllerDependent_TextBoxLargeGamepad.__defaultWidth = 89
CoD.ControllerDependent_TextBoxLargeGamepad.__defaultHeight = 22
CoD.ControllerDependent_TextBoxLargeGamepad.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ControllerDependent_TextBoxLargeGamepad)
	self.id = "ControllerDependent_TextBoxLargeGamepad"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = nil
	Frame = CoD.HUD_KeyPromptFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -50, 22, 0.5, 0.5, -20, 20)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local KBMText = nil
	KBMText = LUI.UIText.new(0.5, 0.5, -46.5, 18.5, 0.5, 0.5, -9, 9)
	KBMText:setAlpha(0)
	KBMText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	KBMText:setTTF("ttmussels_demibold")
	KBMText:setLetterSpacing(-2)
	KBMText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KBMText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(KBMText)
	self.KBMText = KBMText
	local GamepadText = LUI.UIText.new(-0.2, 1.2, 0, 0, -0.2, 1.2, 0, 0)
	GamepadText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	GamepadText:setTTF("default")
	GamepadText:setLetterSpacing(-1)
	GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GamepadText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GamepadText)
	self.GamepadText = GamepadText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
				if not f2_local0 then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
				end
				return f2_local0
			end,
		},
		{
			stateName = "KeyboardAndMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
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
CoD.ControllerDependent_TextBoxLargeGamepad.__resetProperties = function(f8_arg0)
	f8_arg0.GamepadText:completeAnimation()
	f8_arg0.KBMText:completeAnimation()
	f8_arg0.Frame:completeAnimation()
	f8_arg0.GamepadText:setAlpha(1)
	f8_arg0.KBMText:setAlpha(0)
	f8_arg0.Frame:setAlpha(0)
end
CoD.ControllerDependent_TextBoxLargeGamepad.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.GamepadText:completeAnimation()
			f10_arg0.GamepadText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.GamepadText)
		end,
	},
	KeyboardAndMouse = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Frame:completeAnimation()
			f11_arg0.Frame:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Frame)
			f11_arg0.KBMText:completeAnimation()
			f11_arg0.KBMText:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.KBMText)
			f11_arg0.GamepadText:completeAnimation()
			f11_arg0.GamepadText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.GamepadText)
		end,
	},
}
if not CoD.isPC then
	CoD.ControllerDependent_TextBoxLargeGamepad.__clipsPerState.KeyboardAndMouse.DefaultClip = nil
end
CoD.ControllerDependent_TextBoxLargeGamepad.__onClose = function(f12_arg0)
	f12_arg0.Frame:close()
end
