CoD.SeparationLine_Vertical = InheritFrom(LUI.UIElement)
CoD.SeparationLine_Vertical.__defaultWidth = 1
CoD.SeparationLine_Vertical.__defaultHeight = 61
CoD.SeparationLine_Vertical.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SeparationLine_Vertical)
	self.id = "SeparationLine_Vertical"
	self.soundSet = "default"
	local DotT = LUI.UIImage.new(0, 0, 0, 1, 0, 0, 0, 1)
	DotT:setAlpha(0.3)
	self:addElement(DotT)
	self.DotT = DotT
	local DotB = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	DotB:setAlpha(0.3)
	self:addElement(DotB)
	self.DotB = DotB
	local Line = LUI.UIImage.new(0, 0, 0, 1, 0, 1, 0, 0)
	Line:setRGB(0.38, 0.36, 0.33)
	Line:setAlpha(0.3)
	self:addElement(Line)
	self.Line = Line
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
