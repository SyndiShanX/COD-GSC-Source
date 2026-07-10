CoD.ListLabel = InheritFrom(LUI.UIElement)
CoD.ListLabel.__defaultWidth = 355
CoD.ListLabel.__defaultHeight = 50
CoD.ListLabel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 24, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ListLabel)
	self.id = "ListLabel"
	self.soundSet = "none"
	local TextBox2 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 14, 32)
	TextBox2:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	TextBox2:setText("")
	TextBox2:setTTF("ttmussels_regular")
	TextBox2:setLetterSpacing(2)
	TextBox2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(TextBox2)
	self.TextBox2 = TextBox2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
