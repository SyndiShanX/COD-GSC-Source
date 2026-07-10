CoD.SeperationLine = InheritFrom(LUI.UIElement)
CoD.SeperationLine.__defaultWidth = 673
CoD.SeperationLine.__defaultHeight = 1
CoD.SeperationLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SeperationLine)
	self.id = "SeperationLine"
	self.soundSet = "default"
	local DotLeft = LUI.UIImage.new(0, 0, 0, 1, 1, 1, -1, 0)
	DotLeft:setAlpha(0.3)
	self:addElement(DotLeft)
	self.DotLeft = DotLeft
	local DotRight = LUI.UIImage.new(1, 1, -1, 0, 1, 1, -1, 0)
	DotRight:setAlpha(0.3)
	self:addElement(DotRight)
	self.DotRight = DotRight
	local Line = LUI.UIImage.new(0, 1, 1, -1, 1, 1, -1, 0)
	Line:setRGB(0.38, 0.36, 0.33)
	Line:setAlpha(0.3)
	self:addElement(Line)
	self.Line = Line
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
