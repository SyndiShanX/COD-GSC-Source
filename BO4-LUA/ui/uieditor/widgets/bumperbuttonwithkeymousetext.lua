require("ui/uieditor/widgets/keyprompt")
CoD.BumperButtonWithKeyMouseText = InheritFrom(LUI.UIElement)
CoD.BumperButtonWithKeyMouseText.__defaultWidth = 200
CoD.BumperButtonWithKeyMouseText.__defaultHeight = 34
CoD.BumperButtonWithKeyMouseText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BumperButtonWithKeyMouseText)
	self.id = "BumperButtonWithKeyMouseText"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GamepadPrompt = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 34)
	GamepadPrompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	GamepadPrompt:setTTF("default")
	GamepadPrompt:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	GamepadPrompt:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(GamepadPrompt)
	self.GamepadPrompt = GamepadPrompt
	local KeyPrompt = nil
	KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 36, 0.5, 0.5, -18, 18)
	KeyPrompt.keybind:setText("")
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and AlwaysFalse()
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine.GetModelForController(f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f5_arg0)
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
CoD.BumperButtonWithKeyMouseText.__resetProperties = function(f6_arg0)
	f6_arg0.KeyPrompt:completeAnimation()
	f6_arg0.GamepadPrompt:completeAnimation()
	f6_arg0.KeyPrompt:setAlpha(1)
	f6_arg0.GamepadPrompt:setAlpha(1)
end
CoD.BumperButtonWithKeyMouseText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.GamepadPrompt:completeAnimation()
			f7_arg0.GamepadPrompt:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.GamepadPrompt)
			f7_arg0.KeyPrompt:completeAnimation()
			f7_arg0.KeyPrompt:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.KeyPrompt)
		end,
	},
	KBM = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.GamepadPrompt:completeAnimation()
			f8_arg0.GamepadPrompt:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.GamepadPrompt)
			f8_arg0.KeyPrompt:completeAnimation()
			f8_arg0.KeyPrompt:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.KeyPrompt)
		end,
	},
	Gamepad = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.GamepadPrompt:completeAnimation()
			f9_arg0.GamepadPrompt:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.GamepadPrompt)
			f9_arg0.KeyPrompt:completeAnimation()
			f9_arg0.KeyPrompt:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KeyPrompt)
		end,
	},
}
CoD.BumperButtonWithKeyMouseText.__onClose = function(f10_arg0)
	f10_arg0.KeyPrompt:close()
end
