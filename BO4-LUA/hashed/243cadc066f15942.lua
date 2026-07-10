CoD.RadiationBlastNeedle = InheritFrom(LUI.UIElement)
CoD.RadiationBlastNeedle.__defaultWidth = 10
CoD.RadiationBlastNeedle.__defaultHeight = 272
CoD.RadiationBlastNeedle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.RadiationBlastNeedle)
	self.id = "RadiationBlastNeedle"
	self.soundSet = "default"
	local Needle = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 0, 196)
	Needle:setAlpha(0)
	self:addElement(Needle)
	self.Needle = Needle
	local Line = LUI.UIImage.new(0, 0, -11, 25, 0, 0, -12, 176)
	Line:setImage(RegisterImage(@"uie_hud_radiationmeter_line"))
	self:addElement(Line)
	self.Line = Line
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
