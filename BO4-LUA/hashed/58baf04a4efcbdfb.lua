CoD.PC_Prestige_Arrow = InheritFrom(LUI.UIElement)
CoD.PC_Prestige_Arrow.__defaultWidth = 18
CoD.PC_Prestige_Arrow.__defaultHeight = 22
CoD.PC_Prestige_Arrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Prestige_Arrow)
	self.id = "PC_Prestige_Arrow"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arrow = LUI.UIImage.new(0, 0, 0, 18, 0.01, 0.01, 0, 22)
	arrow:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	arrow:setAlpha(0.8)
	arrow:setImage(RegisterImage(0x50F3B2B4549D1B9))
	self:addElement(arrow)
	self.arrow = arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Prestige_Arrow.__resetProperties = function(f2_arg0)
	f2_arg0.arrow:completeAnimation()
	f2_arg0.arrow:setAlpha(0.8)
end
CoD.PC_Prestige_Arrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.arrow:completeAnimation()
			f4_arg0.arrow:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.arrow)
		end,
	},
}
