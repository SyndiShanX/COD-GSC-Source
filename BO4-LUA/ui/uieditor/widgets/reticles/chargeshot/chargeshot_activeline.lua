CoD.ChargeShot_ActiveLine = InheritFrom(LUI.UIElement)
CoD.ChargeShot_ActiveLine.__defaultWidth = 72
CoD.ChargeShot_ActiveLine.__defaultHeight = 72
CoD.ChargeShot_ActiveLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargeShot_ActiveLine)
	self.id = "ChargeShot_ActiveLine"
	self.soundSet = "ChooseDecal"
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setImage(RegisterImage(0x3A95907399C7A0F))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
