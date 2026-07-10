CoD.ListLabelHideable = InheritFrom(LUI.UIElement)
CoD.ListLabelHideable.__defaultWidth = 355
CoD.ListLabelHideable.__defaultHeight = 50
CoD.ListLabelHideable.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 24, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ListLabelHideable)
	self.id = "ListLabelHideable"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox2 = LUI.UIText.new(0, 1, 0, 0, 0, 0, 14, 32)
	TextBox2:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	TextBox2:setText("")
	TextBox2:setTTF("ttmussels_regular")
	TextBox2:setLetterSpacing(2)
	TextBox2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(TextBox2)
	self.TextBox2 = TextBox2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ListLabelHideable.__resetProperties = function(f2_arg0)
	f2_arg0.TextBox2:completeAnimation()
	f2_arg0.TextBox2:setAlpha(1)
end
CoD.ListLabelHideable.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.TextBox2:completeAnimation()
			f4_arg0.TextBox2:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TextBox2)
		end,
	},
}
