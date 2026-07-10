require("x64:b79410dc8d1ea84")
require("x64:2b92e102c99da61")
CoD.ToggleButton_Button = InheritFrom(LUI.UIElement)
CoD.ToggleButton_Button.__defaultWidth = 167
CoD.ToggleButton_Button.__defaultHeight = 70
CoD.ToggleButton_Button.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ToggleButton_Button)
	self.id = "ToggleButton_Button"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local On = LUI.UIText.new(0, 1, 8, -8, 0.5, 0.5, -9, 9)
	On:setRGB(0.76, 0.76, 0.76)
	On:setText(LocalizeToUpperString(0x439156E8D96D245))
	On:setTTF("ttmussels_regular")
	On:setLetterSpacing(2)
	On:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	On:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(On)
	self.On = On
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	local ToggledIndicator = CoD.PC_StartMenu_Options_Pagination.new(f1_arg0, f1_arg1, 0.5, 0.5, -34, 34, 1, 1, -5, -1)
	ToggledIndicator:setAlpha(0)
	self:addElement(ToggledIndicator)
	self.ToggledIndicator = ToggledIndicator
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ToggleButton_Button.__resetProperties = function(f2_arg0)
	f2_arg0.On:completeAnimation()
	f2_arg0.PCHighlightBorder:completeAnimation()
	f2_arg0.ToggledIndicator:completeAnimation()
	f2_arg0.On:setRGB(0.76, 0.76, 0.76)
	f2_arg0.On:setAlpha(1)
	f2_arg0.ToggledIndicator:setAlpha(0)
end
CoD.ToggleButton_Button.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.On:completeAnimation()
			f3_arg0.On:setAlpha(0.4)
			f3_arg0.clipFinished(f3_arg0.On)
			f3_arg0.PCHighlightBorder:completeAnimation()
			f3_arg0.PCHighlightBorder:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.PCHighlightBorder)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.On:completeAnimation()
			f4_arg0.On:setRGB(1, 1, 1)
			f4_arg0.clipFinished(f4_arg0.On)
			f4_arg0.PCHighlightBorder:completeAnimation()
			f4_arg0.PCHighlightBorder:playClip("cFocus")
			f4_arg0.clipFinished(f4_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.On:beginAnimation(150)
				f5_arg0.On:setRGB(1, 1, 1)
				f5_arg0.On:setAlpha(1)
				f5_arg0.On:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.On:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.On:completeAnimation()
			f5_arg0.On:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
			f5_arg0.On:setAlpha(0.4)
			f5_local0(f5_arg0.On)
			f5_arg0.PCHighlightBorder:completeAnimation()
			f5_arg0.PCHighlightBorder:playClip("cGainFocus")
			f5_arg0.clipFinished(f5_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.On:beginAnimation(150)
				f7_arg0.On:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
				f7_arg0.On:setAlpha(0.4)
				f7_arg0.On:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.On:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.On:completeAnimation()
			f7_arg0.On:setRGB(1, 1, 1)
			f7_arg0.On:setAlpha(1)
			f7_local0(f7_arg0.On)
			f7_arg0.PCHighlightBorder:completeAnimation()
			f7_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f7_arg0.clipFinished(f7_arg0.PCHighlightBorder)
		end,
	},
	UnavailableToggled = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.On:completeAnimation()
			f9_arg0.On:setRGB(0.76, 0.76, 0.76)
			f9_arg0.On:setAlpha(0.35)
			f9_arg0.clipFinished(f9_arg0.On)
			f9_arg0.ToggledIndicator:completeAnimation()
			f9_arg0.ToggledIndicator:setAlpha(0.45)
			f9_arg0.clipFinished(f9_arg0.ToggledIndicator)
		end,
	},
	Unavailable = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.On:completeAnimation()
			f10_arg0.On:setAlpha(0.25)
			f10_arg0.clipFinished(f10_arg0.On)
		end,
	},
	Toggled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.ToggledIndicator:completeAnimation()
			f11_arg0.ToggledIndicator:setAlpha(0.75)
			f11_arg0.clipFinished(f11_arg0.ToggledIndicator)
		end,
		Focus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.On:completeAnimation()
			f12_arg0.On:setRGB(1, 1, 1)
			f12_arg0.clipFinished(f12_arg0.On)
			f12_arg0.PCHighlightBorder:completeAnimation()
			f12_arg0.PCHighlightBorder:playClip("cFocus")
			f12_arg0.clipFinished(f12_arg0.PCHighlightBorder)
			f12_arg0.ToggledIndicator:completeAnimation()
			f12_arg0.ToggledIndicator:setAlpha(0.75)
			f12_arg0.clipFinished(f12_arg0.ToggledIndicator)
		end,
		GainFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				f13_arg0.On:beginAnimation(150)
				f13_arg0.On:setRGB(1, 1, 1)
				f13_arg0.On:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.On:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.On:completeAnimation()
			f13_arg0.On:setRGB(0.76, 0.76, 0.76)
			f13_local0(f13_arg0.On)
			f13_arg0.PCHighlightBorder:completeAnimation()
			f13_arg0.PCHighlightBorder:playClip("cGainFocus")
			f13_arg0.clipFinished(f13_arg0.PCHighlightBorder)
			f13_arg0.ToggledIndicator:completeAnimation()
			f13_arg0.ToggledIndicator:setAlpha(0.75)
			f13_arg0.clipFinished(f13_arg0.ToggledIndicator)
		end,
		LoseFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			local f15_local0 = function(f16_arg0)
				f15_arg0.On:beginAnimation(150)
				f15_arg0.On:setRGB(0.76, 0.76, 0.76)
				f15_arg0.On:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.On:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.On:completeAnimation()
			f15_arg0.On:setRGB(1, 1, 1)
			f15_local0(f15_arg0.On)
			f15_arg0.PCHighlightBorder:completeAnimation()
			f15_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f15_arg0.clipFinished(f15_arg0.PCHighlightBorder)
			f15_arg0.ToggledIndicator:completeAnimation()
			f15_arg0.ToggledIndicator:setAlpha(0.75)
			f15_arg0.clipFinished(f15_arg0.ToggledIndicator)
		end,
	},
}
CoD.ToggleButton_Button.__onClose = function(f17_arg0)
	f17_arg0.PCHighlightBorder:close()
	f17_arg0.ToggledIndicator:close()
end
