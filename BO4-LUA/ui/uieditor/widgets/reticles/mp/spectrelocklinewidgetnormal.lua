CoD.SpectreLockLineWidgetNormal = InheritFrom(LUI.UIElement)
CoD.SpectreLockLineWidgetNormal.__defaultWidth = 24
CoD.SpectreLockLineWidgetNormal.__defaultHeight = 24
CoD.SpectreLockLineWidgetNormal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpectreLockLineWidgetNormal)
	self.id = "SpectreLockLineWidgetNormal"
	self.soundSet = "default"
	local Line = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 24)
	Line:setRGB(1, 0.01, 0)
	Line:setImage(RegisterImage(0xE2F6B35888DF713))
	self:addElement(Line)
	self.Line = Line
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
