CoD.vhud_agr_ReticleCenterHairline = InheritFrom(LUI.UIElement)
CoD.vhud_agr_ReticleCenterHairline.__defaultWidth = 25
CoD.vhud_agr_ReticleCenterHairline.__defaultHeight = 13
CoD.vhud_agr_ReticleCenterHairline.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_ReticleCenterHairline)
	self.id = "vhud_agr_ReticleCenterHairline"
	self.soundSet = "default"
	local agrReticleHairlineRight0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleHairlineRight0:setAlpha(0.15)
	agrReticleHairlineRight0:setZoom(-50)
	agrReticleHairlineRight0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticlehairlineside"))
	agrReticleHairlineRight0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleHairlineRight0)
	self.agrReticleHairlineRight0 = agrReticleHairlineRight0
	local agrReticleHairlineRight = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleHairlineRight:setAlpha(0.5)
	agrReticleHairlineRight:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticlehairlineside"))
	agrReticleHairlineRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleHairlineRight)
	self.agrReticleHairlineRight = agrReticleHairlineRight
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
