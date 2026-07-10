CoD.ChargeShot_CenterReticle = InheritFrom(LUI.UIElement)
CoD.ChargeShot_CenterReticle.__defaultWidth = 144
CoD.ChargeShot_CenterReticle.__defaultHeight = 144
CoD.ChargeShot_CenterReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargeShot_CenterReticle)
	self.id = "ChargeShot_CenterReticle"
	self.soundSet = "ChooseDecal"
	local Center = LUI.UIImage.new(0.5, 0.5, -72, 72, 0.5, 0.5, -72, 72)
	Center:setImage(RegisterImage(0xD506169DE82522A))
	self:addElement(Center)
	self.Center = Center
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
