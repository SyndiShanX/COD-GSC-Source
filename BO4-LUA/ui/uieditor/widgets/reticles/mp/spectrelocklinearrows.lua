CoD.SpectreLockLineArrows = InheritFrom(LUI.UIElement)
CoD.SpectreLockLineArrows.__defaultWidth = 24
CoD.SpectreLockLineArrows.__defaultHeight = 24
CoD.SpectreLockLineArrows.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpectreLockLineArrows)
	self.id = "SpectreLockLineArrows"
	self.soundSet = "default"
	local Arrows = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 8, 24)
	Arrows:setRGB(1, 0.01, 0)
	Arrows:setImage(RegisterImage(@"hash_4A00921BA335191F"))
	Arrows:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Arrows)
	self.Arrows = Arrows
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
