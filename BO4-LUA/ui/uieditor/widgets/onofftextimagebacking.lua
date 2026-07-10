CoD.onOffTextImageBacking = InheritFrom(LUI.UIElement)
CoD.onOffTextImageBacking.__defaultWidth = 750
CoD.onOffTextImageBacking.__defaultHeight = 37
CoD.onOffTextImageBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.onOffTextImageBacking)
	self.id = "onOffTextImageBacking"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBox = LUI.UIText.new(0, 1, 0, 0, 0, 1, 0, 0)
	TextBox:setText("")
	TextBox:setTTF("dinnext_regular")
	TextBox:setLetterSpacing(3)
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TextBox:setBackingType(2)
	TextBox:setBackingColor(0.08, 0.08, 0.08)
	self:addElement(TextBox)
	self.TextBox = TextBox
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.onOffTextImageBacking.__resetProperties = function(f2_arg0)
	f2_arg0.TextBox:completeAnimation()
	f2_arg0.TextBox:setAlpha(1)
end
CoD.onOffTextImageBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.TextBox:completeAnimation()
			f5_arg0.TextBox:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TextBox)
		end,
	},
}
