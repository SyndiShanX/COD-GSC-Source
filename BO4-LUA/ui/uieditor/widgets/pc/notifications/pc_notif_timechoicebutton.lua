CoD.PC_Notif_TimeChoiceButton = InheritFrom(LUI.UIElement)
CoD.PC_Notif_TimeChoiceButton.__defaultWidth = 200
CoD.PC_Notif_TimeChoiceButton.__defaultHeight = 32
CoD.PC_Notif_TimeChoiceButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Notif_TimeChoiceButton)
	self.id = "PC_Notif_TimeChoiceButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Focus = LUI.UIImage.new(0, 1, -12, 0, 0, 1, 0, 0)
	Focus:setAlpha(0)
	self:addElement(Focus)
	self.Focus = Focus
	local TimeChoice = LUI.UIText.new(0, 0, 0, 200, 0.5, 0.5, -9, 9)
	TimeChoice:setRGB(0.64, 0.64, 0.64)
	TimeChoice:setText(Engine[@"hash_4F9F1239CFD921FE"](0x54B3A8ECBF13A67))
	TimeChoice:setTTF("ttmussels_regular")
	TimeChoice:setLetterSpacing(4)
	TimeChoice:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(TimeChoice, "setText", function(element, controller)
		ScaleWidgetToLabelCentered(self, element, 12)
	end)
	self:addElement(TimeChoice)
	self.TimeChoice = TimeChoice
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Notif_TimeChoiceButton.__resetProperties = function(f3_arg0)
	f3_arg0.Focus:completeAnimation()
	f3_arg0.TimeChoice:completeAnimation()
	f3_arg0.Focus:setAlpha(0)
	f3_arg0.TimeChoice:setRGB(0.64, 0.64, 0.64)
end
CoD.PC_Notif_TimeChoiceButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Focus:completeAnimation()
			f5_arg0.Focus:setAlpha(0.01)
			f5_arg0.clipFinished(f5_arg0.Focus)
			f5_arg0.TimeChoice:completeAnimation()
			f5_arg0.TimeChoice:setRGB(1, 1, 1)
			f5_arg0.clipFinished(f5_arg0.TimeChoice)
		end,
		GainFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Focus:beginAnimation(80)
				f6_arg0.Focus:setAlpha(0.01)
				f6_arg0.Focus:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Focus:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Focus:completeAnimation()
			f6_arg0.Focus:setAlpha(0)
			f6_local0(f6_arg0.Focus)
			local f6_local1 = function(f8_arg0)
				f6_arg0.TimeChoice:beginAnimation(80)
				f6_arg0.TimeChoice:setRGB(1, 1, 1)
				f6_arg0.TimeChoice:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.TimeChoice:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.TimeChoice:completeAnimation()
			f6_arg0.TimeChoice:setRGB(0.64, 0.64, 0.64)
			f6_local1(f6_arg0.TimeChoice)
		end,
		LoseFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Focus:beginAnimation(80)
				f9_arg0.Focus:setAlpha(0)
				f9_arg0.Focus:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Focus:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Focus:completeAnimation()
			f9_arg0.Focus:setAlpha(0.01)
			f9_local0(f9_arg0.Focus)
			local f9_local1 = function(f11_arg0)
				f9_arg0.TimeChoice:beginAnimation(80)
				f9_arg0.TimeChoice:setRGB(0.64, 0.64, 0.64)
				f9_arg0.TimeChoice:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.TimeChoice:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.TimeChoice:completeAnimation()
			f9_arg0.TimeChoice:setRGB(1, 1, 1)
			f9_local1(f9_arg0.TimeChoice)
		end,
	},
}
