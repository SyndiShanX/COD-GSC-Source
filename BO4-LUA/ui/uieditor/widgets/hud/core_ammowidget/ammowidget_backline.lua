CoD.AmmoWidget_BackLine = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_BackLine.__defaultWidth = 223
CoD.AmmoWidget_BackLine.__defaultHeight = 4
CoD.AmmoWidget_BackLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_BackLine)
	self.id = "AmmoWidget_BackLine"
	self.soundSet = "default"
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -2, 2)
	Image0:setRGB(0.24, 0.49, 0.65)
	Image0:setAlpha(0.3)
	Image0:setImage(RegisterImage(@"uie_t7_core_hud_ammowidget_backline"))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
