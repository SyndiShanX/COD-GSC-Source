CoD.WeaponLevelUpNotification_FooterBacking01 = InheritFrom(LUI.UIElement)
CoD.WeaponLevelUpNotification_FooterBacking01.__defaultWidth = 69
CoD.WeaponLevelUpNotification_FooterBacking01.__defaultHeight = 48
CoD.WeaponLevelUpNotification_FooterBacking01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelUpNotification_FooterBacking01)
	self.id = "WeaponLevelUpNotification_FooterBacking01"
	self.soundSet = "HUD"
	local Image0 = LUI.UIImage.new(0, 0, 0, 24, 0, 0, 0, 48)
	Image0:setImage(RegisterImage(@"uie_t7_hud_notificaiton_footer_left"))
	self:addElement(Image0)
	self.Image0 = Image0
	local Image1 = LUI.UIImage.new(0, 1, 24, -24, 0, 0, 0, 48)
	Image1:setImage(RegisterImage(@"uie_t7_hud_notificaiton_footer_stretch"))
	self:addElement(Image1)
	self.Image1 = Image1
	local Image2 = LUI.UIImage.new(1, 1, -24, 0, 0, 0, 0, 48)
	Image2:setImage(RegisterImage(@"uie_t7_hud_notificaiton_footer_right"))
	self:addElement(Image2)
	self.Image2 = Image2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
