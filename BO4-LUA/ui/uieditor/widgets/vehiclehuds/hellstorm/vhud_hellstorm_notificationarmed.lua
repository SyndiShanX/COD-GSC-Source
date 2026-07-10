require("x64:a9255c570c68aa8")
CoD.vhud_hellstorm_NotificationArmed = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_NotificationArmed.__defaultWidth = 220
CoD.vhud_hellstorm_NotificationArmed.__defaultHeight = 22
CoD.vhud_hellstorm_NotificationArmed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_NotificationArmed)
	self.id = "vhud_hellstorm_NotificationArmed"
	self.soundSet = "default"
	local Base = LUI.UIImage.new(0, 0, 0, 220, 0, 0, 0, 22)
	Base:setAlpha(0.15)
	self:addElement(Base)
	self.Base = Base
	local InnerGlow = LUI.UIImage.new(0.5, 0.5, -110, 110, 0.5, 0.5, -30, 15)
	InnerGlow:setAlpha(0)
	InnerGlow:setImage(RegisterImage(@"uie_director_frontend_glow"))
	InnerGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InnerGlow)
	self.InnerGlow = InnerGlow
	local ARMED = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -11, 11)
	ARMED:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6ABD1D3FD0CE6DE2"))
	ARMED:setTTF("0arame_mono_stencil")
	ARMED:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	ARMED:setShaderVector(0, 0, 1, 0, 0)
	ARMED:setShaderVector(1, 0, 0, 0, 0)
	ARMED:setShaderVector(2, 0, 0, 0, 0)
	ARMED:setShaderVector(3, 0, 0, 0, 0)
	ARMED:setShaderVector(4, 0, 0, 0, 0)
	ARMED:setLetterSpacing(2)
	ARMED:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ARMED:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ARMED)
	self.ARMED = ARMED
	local ARMED0 = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -11, 11)
	ARMED0:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6ABD1D3FD0CE6DE2"))
	ARMED0:setTTF("0arame_mono_stencil")
	ARMED0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	ARMED0:setLetterSpacing(2)
	ARMED0:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ARMED0:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ARMED0)
	self.ARMED0 = ARMED0
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 220, 0, 0, 0, 22)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local GlowBot = LUI.UIImage.new(0.5, 0.5, -113, 113, 0, 0, 15, 35)
	GlowBot:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	GlowBot:setAlpha(0)
	GlowBot:setImage(RegisterImage(@"uie_icon_frontend_navigation_glowmed"))
	GlowBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowBot)
	self.GlowBot = GlowBot
	local GlowTop = LUI.UIImage.new(0.5, 0.5, -113, 113, 0, 0, 7, -13)
	GlowTop:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	GlowTop:setAlpha(0)
	GlowTop:setImage(RegisterImage(@"uie_icon_frontend_navigation_glowmed"))
	GlowTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(GlowTop)
	self.GlowTop = GlowTop
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_hellstorm_NotificationArmed.__onClose = function(f2_arg0)
	f2_arg0.Frame:close()
end
