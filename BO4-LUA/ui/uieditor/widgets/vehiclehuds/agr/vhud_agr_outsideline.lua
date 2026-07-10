CoD.vhud_agr_OutsideLine = InheritFrom(LUI.UIElement)
CoD.vhud_agr_OutsideLine.__defaultWidth = 81
CoD.vhud_agr_OutsideLine.__defaultHeight = 24
CoD.vhud_agr_OutsideLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_OutsideLine)
	self.id = "vhud_agr_OutsideLine"
	self.soundSet = "default"
	local agrOutsideLineR0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrOutsideLineR0:setAlpha(0.15)
	agrOutsideLineR0:setZoom(-50)
	agrOutsideLineR0:setImage(RegisterImage(0x62AFB41EE28F951))
	agrOutsideLineR0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrOutsideLineR0)
	self.agrOutsideLineR0 = agrOutsideLineR0
	local agrOutsideLineR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrOutsideLineR:setAlpha(0.5)
	agrOutsideLineR:setImage(RegisterImage(0x62AFB41EE28F951))
	agrOutsideLineR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrOutsideLineR)
	self.agrOutsideLineR = agrOutsideLineR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
