CoD.onOffText = InheritFrom(LUI.UIElement)
CoD.onOffText.__defaultWidth = 750
CoD.onOffText.__defaultHeight = 37
CoD.onOffText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.onOffText)
	self.id = "onOffText"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 1, 0, 0, 0, 0, 9, 30)
	TextBox:setText("")
	TextBox:setTTF("notosans_regular")
	TextBox:setLetterSpacing(3)
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	TextBox:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.onOffText.__resetProperties = function(f2_arg0)
	f2_arg0.TextBox:completeAnimation()
	f2_arg0.TextBox:setAlpha(1)
end
CoD.onOffText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TextBox:completeAnimation()
			f4_arg0.TextBox:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TextBox)
		end,
	},
}
