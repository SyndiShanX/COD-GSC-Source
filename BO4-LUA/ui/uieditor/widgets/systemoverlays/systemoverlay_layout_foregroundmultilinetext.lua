CoD.systemOverlay_Layout_ForegroundMultilineText = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Layout_ForegroundMultilineText.__defaultWidth = 1122
CoD.systemOverlay_Layout_ForegroundMultilineText.__defaultHeight = 36
CoD.systemOverlay_Layout_ForegroundMultilineText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Layout_ForegroundMultilineText)
	self.id = "systemOverlay_Layout_ForegroundMultilineText"
	self.soundSet = "default"
	local text = LUI.UIText.new(0, 0, 0, 1122, 0, 0, 8, 29)
	text:setRGB(0.92, 0.92, 0.92)
	text:setText(LocalizeToUpperString(@"menu/new"))
	text:setTTF("notosans_regular")
	text:setLetterSpacing(1)
	text:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	text:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(text, "setText", function(element, controller)
		UpdateWidgetHeightToMultilineTextWithMinimum(self, element, 0, 20)
	end)
	self:addElement(text)
	self.text = text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
