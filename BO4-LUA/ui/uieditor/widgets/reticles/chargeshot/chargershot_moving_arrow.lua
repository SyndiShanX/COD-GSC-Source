CoD.ChargerShot_Moving_Arrow = InheritFrom(LUI.UIElement)
CoD.ChargerShot_Moving_Arrow.__defaultWidth = 72
CoD.ChargerShot_Moving_Arrow.__defaultHeight = 72
CoD.ChargerShot_Moving_Arrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargerShot_Moving_Arrow)
	self.id = "ChargerShot_Moving_Arrow"
	self.soundSet = "ChooseDecal"
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setRGB(0.29, 0.69, 0.95)
	Image0:setImage(RegisterImage(@"uie_t7_hud_chargeshot_moving_arrow"))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
