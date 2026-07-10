CoD.bleedOutClampedArrow = InheritFrom(LUI.UIElement)
CoD.bleedOutClampedArrow.__defaultWidth = 390
CoD.bleedOutClampedArrow.__defaultHeight = 96
CoD.bleedOutClampedArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.bleedOutClampedArrow)
	self.id = "bleedOutClampedArrow"
	self.soundSet = "default"
	local arrow = LUI.UIImage.new(0, 0, 325, 389, 0, 0, 16, 80)
	arrow:setZRot(90)
	arrow:setScale(1.5, 1.5)
	arrow:setImage(RegisterImage(0xAB17136E34541E3))
	arrow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(arrow)
	self.arrow = arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
