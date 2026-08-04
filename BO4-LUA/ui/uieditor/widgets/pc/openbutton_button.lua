require("ui/uieditor/widgets/pc/startmenu/pc_highlightborder")
CoD.OpenButton_Button = InheritFrom(LUI.UIElement)
CoD.OpenButton_Button.__defaultWidth = 336
CoD.OpenButton_Button.__defaultHeight = 65
CoD.OpenButton_Button.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OpenButton_Button)
	self.id = "OpenButton_Button"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Text = LUI.UIText.new(0, 1, 8, -8, 0.5, 0.5, -9, 9)
	Text:setRGB(0.76, 0.76, 0.76)
	Text:setText(LocalizeToUpperString(@"menu/edit"))
	Text:setTTF("ttmussels_regular")
	Text:setLetterSpacing(2)
	Text:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Text:setAlignment(Enum.LUIAlignment[@"lui_alignment_middle"])
	self:addElement(Text)
	self.Text = Text
	local PCHighlightBorder = CoD.PC_HighlightBorder.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PCHighlightBorder)
	self.PCHighlightBorder = PCHighlightBorder
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OpenButton_Button.__resetProperties = function(f2_arg0)
	f2_arg0.Text:completeAnimation()
	f2_arg0.PCHighlightBorder:completeAnimation()
	f2_arg0.Text:setRGB(0.76, 0.76, 0.76)
	f2_arg0.Text:setAlpha(1)
end
CoD.OpenButton_Button.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.Text:completeAnimation()
			f4_arg0.Text:setRGB(1, 1, 1)
			f4_arg0.clipFinished(f4_arg0.Text)
			f4_arg0.PCHighlightBorder:completeAnimation()
			f4_arg0.PCHighlightBorder:playClip("cFocus")
			f4_arg0.clipFinished(f4_arg0.PCHighlightBorder)
		end,
		LoseFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Text:beginAnimation(150)
				f5_arg0.Text:setRGB(0.76, 0.76, 0.76)
				f5_arg0.Text:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Text:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Text:completeAnimation()
			f5_arg0.Text:setRGB(1, 1, 1)
			f5_local0(f5_arg0.Text)
			f5_arg0.PCHighlightBorder:completeAnimation()
			f5_arg0.PCHighlightBorder:playClip("cLoseFocus")
			f5_arg0.clipFinished(f5_arg0.PCHighlightBorder)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Text:beginAnimation(150)
				f7_arg0.Text:setRGB(1, 1, 1)
				f7_arg0.Text:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Text:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Text:completeAnimation()
			f7_arg0.Text:setRGB(0.76, 0.76, 0.76)
			f7_local0(f7_arg0.Text)
			f7_arg0.PCHighlightBorder:completeAnimation()
			f7_arg0.PCHighlightBorder:playClip("cGainFocus")
			f7_arg0.clipFinished(f7_arg0.PCHighlightBorder)
		end,
	},
	Unavailable = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Text:completeAnimation()
			f9_arg0.Text:setAlpha(0.25)
			f9_arg0.clipFinished(f9_arg0.Text)
		end,
	},
}
CoD.OpenButton_Button.__onClose = function(f10_arg0)
	f10_arg0.PCHighlightBorder:close()
end
