CoD.vhud_turret_reticle_center = InheritFrom(LUI.UIElement)
CoD.vhud_turret_reticle_center.__defaultWidth = 81
CoD.vhud_turret_reticle_center.__defaultHeight = 97
CoD.vhud_turret_reticle_center.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_turret_reticle_center)
	self.id = "vhud_turret_reticle_center"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReticleU = LUI.UIImage.new(0.5, 0.5, -12, 12, 0.5, 0.5, -48, -12)
	ReticleU:setRGB(1, 0.83, 0.39)
	ReticleU:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_reticleu"))
	ReticleU:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ReticleU)
	self.ReticleU = ReticleU
	local ReticleLL = LUI.UIImage.new(0.5, 0.5, -40, -4, 0.5, 0.5, 12, 48)
	ReticleLL:setRGB(1, 0.83, 0.39)
	ReticleLL:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_reticlell"))
	ReticleLL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ReticleLL)
	self.ReticleLL = ReticleLL
	local ReticleLR = LUI.UIImage.new(0.5, 0.5, 4, 40, 0.5, 0.5, 12, 48)
	ReticleLR:setRGB(1, 0.83, 0.39)
	ReticleLR:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_ground_reticlelr"))
	ReticleLR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ReticleLR)
	self.ReticleLR = ReticleLR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
