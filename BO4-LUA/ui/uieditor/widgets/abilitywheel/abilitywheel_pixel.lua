CoD.AbilityWheel_Pixel = InheritFrom(LUI.UIElement)
CoD.AbilityWheel_Pixel.__defaultWidth = 12
CoD.AbilityWheel_Pixel.__defaultHeight = 12
CoD.AbilityWheel_Pixel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AbilityWheel_Pixel)
	self.id = "AbilityWheel_Pixel"
	self.soundSet = "default"
	local Image19 = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 12)
	Image19:setImage(RegisterImage(@"uie_t7_cp_hud_abilitywheel_pixel"))
	Image19:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image19)
	self.Image19 = Image19
	local Image20 = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 12)
	Image20:setZoom(20)
	Image20:setImage(RegisterImage(@"uie_t7_cp_hud_abilitywheel_pixelblur"))
	Image20:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image20)
	self.Image20 = Image20
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
