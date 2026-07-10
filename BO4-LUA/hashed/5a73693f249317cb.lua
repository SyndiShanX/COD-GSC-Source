CoD.TimerRight = InheritFrom(LUI.UIElement)
CoD.TimerRight.__defaultWidth = 355
CoD.TimerRight.__defaultHeight = 50
CoD.TimerRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TimerRight)
	self.id = "TimerRight"
	self.soundSet = "none"
	local TextBox2 = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextBox2:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	TextBox2:setText("")
	TextBox2:setTTF("dinnext_regular")
	TextBox2:setLetterSpacing(-1)
	TextBox2:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	self:addElement(TextBox2)
	self.TextBox2 = TextBox2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
