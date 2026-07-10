CoD.vhud_ms_ReticleLineHostUR = InheritFrom(LUI.UIElement)
CoD.vhud_ms_ReticleLineHostUR.__defaultWidth = 232
CoD.vhud_ms_ReticleLineHostUR.__defaultHeight = 85
CoD.vhud_ms_ReticleLineHostUR.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_ReticleLineHostUR)
	self.id = "vhud_ms_ReticleLineHostUR"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setRGB(0.74, 0.94, 0.99)
	Image0:setAlpha(0.07)
	Image0:setZoom(-40)
	Image0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_reticlehost"))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image0)
	self.Image0 = Image0
	local msReticleHostUpperR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msReticleHostUpperR:setRGB(0.74, 0.94, 0.99)
	msReticleHostUpperR:setAlpha(0.4)
	msReticleHostUpperR:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_reticlehost"))
	msReticleHostUpperR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(msReticleHostUpperR)
	self.msReticleHostUpperR = msReticleHostUpperR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
