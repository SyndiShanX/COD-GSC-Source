CoD.vhud_ms_GridDotsHostR = InheritFrom(LUI.UIElement)
CoD.vhud_ms_GridDotsHostR.__defaultWidth = 178
CoD.vhud_ms_GridDotsHostR.__defaultHeight = 178
CoD.vhud_ms_GridDotsHostR.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_GridDotsHostR)
	self.id = "vhud_ms_GridDotsHostR"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local msGridDotsHostR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msGridDotsHostR:setAlpha(0.4)
	msGridDotsHostR:setZoom(40)
	msGridDotsHostR:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_sidedotsgridhost"))
	msGridDotsHostR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(msGridDotsHostR)
	self.msGridDotsHostR = msGridDotsHostR
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setAlpha(0.1)
	Image0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_sidedotsgridhost"))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
