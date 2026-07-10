CoD.SpectreLockLineWidgetGlow = InheritFrom(LUI.UIElement)
CoD.SpectreLockLineWidgetGlow.__defaultWidth = 24
CoD.SpectreLockLineWidgetGlow.__defaultHeight = 24
CoD.SpectreLockLineWidgetGlow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpectreLockLineWidgetGlow)
	self.id = "SpectreLockLineWidgetGlow"
	self.soundSet = "default"
	local Line = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 24)
	Line:setImage(RegisterImage(@"uie_spectre_blade_cornerline_glow"))
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Line)
	self.Line = Line
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
