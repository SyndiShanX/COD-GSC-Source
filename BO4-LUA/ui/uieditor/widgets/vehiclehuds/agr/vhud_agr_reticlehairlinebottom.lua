CoD.vhud_agr_ReticleHairlineBottom = InheritFrom(LUI.UIElement)
CoD.vhud_agr_ReticleHairlineBottom.__defaultWidth = 24
CoD.vhud_agr_ReticleHairlineBottom.__defaultHeight = 60
CoD.vhud_agr_ReticleHairlineBottom.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_ReticleHairlineBottom)
	self.id = "vhud_agr_ReticleHairlineBottom"
	self.soundSet = "default"
	local agrReticleHairlineBottom0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleHairlineBottom0:setAlpha(0.15)
	agrReticleHairlineBottom0:setZRot(-180)
	agrReticleHairlineBottom0:setZoom(-50)
	agrReticleHairlineBottom0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticlehairlinetop"))
	agrReticleHairlineBottom0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleHairlineBottom0)
	self.agrReticleHairlineBottom0 = agrReticleHairlineBottom0
	local agrReticleHairlineBottom = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleHairlineBottom:setAlpha(0.8)
	agrReticleHairlineBottom:setZRot(-180)
	agrReticleHairlineBottom:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticlehairlinetop"))
	agrReticleHairlineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleHairlineBottom)
	self.agrReticleHairlineBottom = agrReticleHairlineBottom
	local agrReticleHairlineBottomBlur = LUI.UIImage.new(0, 1, -6, 6, 1, 1, 0, 90)
	agrReticleHairlineBottomBlur:setAlpha(0.15)
	agrReticleHairlineBottomBlur:setZRot(-180)
	agrReticleHairlineBottomBlur:setZoom(100)
	agrReticleHairlineBottomBlur:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticlehairlinetopblur"))
	agrReticleHairlineBottomBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleHairlineBottomBlur)
	self.agrReticleHairlineBottomBlur = agrReticleHairlineBottomBlur
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
