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
	agrReticleHairlineRight0:setImage(RegisterImage(0x77DE57CB7375C22))
	agrReticleHairlineRight0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrReticleHairlineRight0)
	self.agrReticleHairlineRight0 = agrReticleHairlineRight0
	local agrReticleHairlineRight = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleHairlineRight:setAlpha(0.5)
	agrReticleHairlineRight:setImage(RegisterImage(0x77DE57CB7375C22))
	agrReticleHairlineRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrReticleHairlineRight)
	self.agrReticleHairlineRight = agrReticleHairlineRight
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
