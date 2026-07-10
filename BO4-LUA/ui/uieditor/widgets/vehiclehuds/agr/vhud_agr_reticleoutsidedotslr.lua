CoD.vhud_agr_ReticleOutsideDotsLR = InheritFrom(LUI.UIElement)
CoD.vhud_agr_ReticleOutsideDotsLR.__defaultWidth = 96
CoD.vhud_agr_ReticleOutsideDotsLR.__defaultHeight = 48
CoD.vhud_agr_ReticleOutsideDotsLR.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_ReticleOutsideDotsLR)
	self.id = "vhud_agr_ReticleOutsideDotsLR"
	self.soundSet = "default"
	local agrReticleOutsideDotsLR0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleOutsideDotsLR0:setAlpha(0.15)
	agrReticleOutsideDotsLR0:setXRot(-180)
	agrReticleOutsideDotsLR0:setZoom(-50)
	agrReticleOutsideDotsLR0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticleoutsidedots"))
	agrReticleOutsideDotsLR0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleOutsideDotsLR0)
	self.agrReticleOutsideDotsLR0 = agrReticleOutsideDotsLR0
	local agrReticleOutsideDotsLR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleOutsideDotsLR:setAlpha(0.7)
	agrReticleOutsideDotsLR:setXRot(-180)
	agrReticleOutsideDotsLR:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticleoutsidedots"))
	agrReticleOutsideDotsLR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleOutsideDotsLR)
	self.agrReticleOutsideDotsLR = agrReticleOutsideDotsLR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
