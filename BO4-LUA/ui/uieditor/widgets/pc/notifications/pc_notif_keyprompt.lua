require("ui/uieditor/widgets/keyprompt")
CoD.PC_Notif_keyprompt = InheritFrom(LUI.UIElement)
CoD.PC_Notif_keyprompt.__defaultWidth = 150
CoD.PC_Notif_keyprompt.__defaultHeight = 28
CoD.PC_Notif_keyprompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, true)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.PC_Notif_keyprompt)
	self.id = "PC_Notif_keyprompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setAlpha(0)
	self:addElement(Image)
	self.Image = Image
	local KeyPrompt = CoD.KeyPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 27, 0, 0, 1, 28)
	KeyPrompt:setRGB(0.84, 0.84, 0.84)
	KeyPrompt.keybind:setText("")
	self:addElement(KeyPrompt)
	self.KeyPrompt = KeyPrompt
	local AcceptText = LUI.UIText.new(0, 0, 37, 152, 0.5, 0.5, -8.5, 8.5)
	AcceptText:setRGB(0.64, 0.64, 0.64)
	AcceptText:setText(LocalizeToUpperString(@"menu/new"))
	AcceptText:setTTF("ttmussels_regular")
	AcceptText:setLetterSpacing(4)
	AcceptText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	AcceptText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(AcceptText, "setText", function(element, controller)
		ScaleWidgetToLabel(self, self.AcceptText, 0)
	end)
	self:addElement(AcceptText)
	self.AcceptText = AcceptText
	self:mergeStateConditions({
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
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f5_arg0)
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
CoD.PC_Notif_keyprompt.__resetProperties = function(f6_arg0)
	f6_arg0.AcceptText:completeAnimation()
	f6_arg0.Image:completeAnimation()
	f6_arg0.KeyPrompt:completeAnimation()
	f6_arg0.AcceptText:setRGB(0.64, 0.64, 0.64)
	f6_arg0.Image:setAlpha(0)
	f6_arg0.KeyPrompt:setAlpha(1)
end
CoD.PC_Notif_keyprompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Image:completeAnimation()
			f8_arg0.Image:setAlpha(0.01)
			f8_arg0.clipFinished(f8_arg0.Image)
			f8_arg0.AcceptText:completeAnimation()
			f8_arg0.AcceptText:setRGB(1, 1, 1)
			f8_arg0.clipFinished(f8_arg0.AcceptText)
		end,
		GainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Image:beginAnimation(80)
				f9_arg0.Image:setAlpha(0.01)
				f9_arg0.Image:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Image:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setAlpha(0)
			f9_local0(f9_arg0.Image)
			local f9_local1 = function(f11_arg0)
				f9_arg0.AcceptText:beginAnimation(80)
				f9_arg0.AcceptText:setRGB(1, 1, 1)
				f9_arg0.AcceptText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.AcceptText:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.AcceptText:completeAnimation()
			f9_arg0.AcceptText:setRGB(0.64, 0.64, 0.64)
			f9_local1(f9_arg0.AcceptText)
		end,
		LoseFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Image:beginAnimation(120)
				f12_arg0.Image:setAlpha(0)
				f12_arg0.Image:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Image:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Image:completeAnimation()
			f12_arg0.Image:setAlpha(0.01)
			f12_local0(f12_arg0.Image)
			local f12_local1 = function(f14_arg0)
				f12_arg0.AcceptText:beginAnimation(120)
				f12_arg0.AcceptText:setRGB(0.64, 0.64, 0.64)
				f12_arg0.AcceptText:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.AcceptText:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.AcceptText:completeAnimation()
			f12_arg0.AcceptText:setRGB(1, 1, 1)
			f12_local1(f12_arg0.AcceptText)
		end,
	},
	Gamepad = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.KeyPrompt:completeAnimation()
			f15_arg0.KeyPrompt:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.KeyPrompt)
		end,
		Focus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.Image:completeAnimation()
			f16_arg0.Image:setAlpha(0.01)
			f16_arg0.clipFinished(f16_arg0.Image)
			f16_arg0.KeyPrompt:completeAnimation()
			f16_arg0.KeyPrompt:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.KeyPrompt)
			f16_arg0.AcceptText:completeAnimation()
			f16_arg0.AcceptText:setRGB(1, 1, 1)
			f16_arg0.clipFinished(f16_arg0.AcceptText)
		end,
		GainFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			local f17_local0 = function(f18_arg0)
				f17_arg0.Image:beginAnimation(80)
				f17_arg0.Image:setAlpha(0.01)
				f17_arg0.Image:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Image:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Image:completeAnimation()
			f17_arg0.Image:setAlpha(0)
			f17_local0(f17_arg0.Image)
			f17_arg0.KeyPrompt:completeAnimation()
			f17_arg0.KeyPrompt:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.KeyPrompt)
			local f17_local1 = function(f19_arg0)
				f17_arg0.AcceptText:beginAnimation(80)
				f17_arg0.AcceptText:setRGB(1, 1, 1)
				f17_arg0.AcceptText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.AcceptText:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.AcceptText:completeAnimation()
			f17_arg0.AcceptText:setRGB(0.64, 0.64, 0.64)
			f17_local1(f17_arg0.AcceptText)
		end,
		LoseFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			local f20_local0 = function(f21_arg0)
				f20_arg0.Image:beginAnimation(120)
				f20_arg0.Image:setAlpha(0)
				f20_arg0.Image:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.Image:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.Image:completeAnimation()
			f20_arg0.Image:setAlpha(0.01)
			f20_local0(f20_arg0.Image)
			f20_arg0.KeyPrompt:completeAnimation()
			f20_arg0.KeyPrompt:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.KeyPrompt)
			local f20_local1 = function(f22_arg0)
				f20_arg0.AcceptText:beginAnimation(120)
				f20_arg0.AcceptText:setRGB(0.64, 0.64, 0.64)
				f20_arg0.AcceptText:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.AcceptText:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.AcceptText:completeAnimation()
			f20_arg0.AcceptText:setRGB(1, 1, 1)
			f20_local1(f20_arg0.AcceptText)
		end,
	},
}
CoD.PC_Notif_keyprompt.__onClose = function(f23_arg0)
	f23_arg0.KeyPrompt:close()
end
