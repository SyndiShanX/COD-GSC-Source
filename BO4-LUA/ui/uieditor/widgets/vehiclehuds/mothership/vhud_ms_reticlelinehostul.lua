CoD.vhud_ms_ReticleLineHostUL = InheritFrom(LUI.UIElement)
CoD.vhud_ms_ReticleLineHostUL.__defaultWidth = 232
CoD.vhud_ms_ReticleLineHostUL.__defaultHeight = 85
CoD.vhud_ms_ReticleLineHostUL.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_ReticleLineHostUL)
	self.id = "vhud_ms_ReticleLineHostUL"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setRGB(0.74, 0.94, 0.99)
	Image0:setAlpha(0.07)
	Image0:setYRot(180)
	Image0:setZoom(-40)
	Image0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_reticlehost"))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image0)
	self.Image0 = Image0
	local msReticleHostUpperL = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msReticleHostUpperL:setRGB(0.74, 0.94, 0.99)
	msReticleHostUpperL:setAlpha(0.4)
	msReticleHostUpperL:setYRot(180)
	msReticleHostUpperL:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_reticlehost"))
	msReticleHostUpperL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(msReticleHostUpperL)
	self.msReticleHostUpperL = msReticleHostUpperL
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
