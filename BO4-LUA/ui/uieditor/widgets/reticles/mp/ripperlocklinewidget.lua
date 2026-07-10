CoD.RipperLockLineWidget = InheritFrom(LUI.UIElement)
CoD.RipperLockLineWidget.__defaultWidth = 24
CoD.RipperLockLineWidget.__defaultHeight = 24
CoD.RipperLockLineWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.RipperLockLineWidget)
	self.id = "RipperLockLineWidget"
	self.soundSet = "default"
	local Line = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 24)
	Line:setRGB(1, 0.01, 0)
	Line:setImage(RegisterImage(@"uie_spectre_blade_cornerline_notadd"))
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Line)
	self.Line = Line
	local LineGlow01UR = LUI.UIImage.new(0.5, 0.5, -12, 12, 0.5, 0.5, -12, 12)
	LineGlow01UR:setRGB(1, 0.02, 0)
	LineGlow01UR:setImage(RegisterImage(@"uie_spectre_blade_cornerline_glow"))
	LineGlow01UR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	LineGlow01UR:setShaderVector(0, 10, 0, 0, 0)
	self:addElement(LineGlow01UR)
	self.LineGlow01UR = LineGlow01UR
	local LineGlow02UR = LUI.UIImage.new(0.5, 0.5, -12, 12, 0.5, 0.5, -12, 12)
	LineGlow02UR:setRGB(1, 0.88, 0.77)
	LineGlow02UR:setImage(RegisterImage(@"uie_spectre_blade_cornerline_glow02"))
	LineGlow02UR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	LineGlow02UR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(LineGlow02UR)
	self.LineGlow02UR = LineGlow02UR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
