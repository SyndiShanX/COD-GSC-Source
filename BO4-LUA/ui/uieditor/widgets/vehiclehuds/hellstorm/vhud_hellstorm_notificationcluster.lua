require("x64:a9255c570c68aa8")
CoD.vhud_hellstorm_NotificationCluster = InheritFrom(LUI.UIElement)
CoD.vhud_hellstorm_NotificationCluster.__defaultWidth = 220
CoD.vhud_hellstorm_NotificationCluster.__defaultHeight = 22
CoD.vhud_hellstorm_NotificationCluster.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_hellstorm_NotificationCluster)
	self.id = "vhud_hellstorm_NotificationCluster"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Base = LUI.UIImage.new(0, 0, 0, 220, 0, 0, 0, 22)
	Base:setAlpha(0.15)
	self:addElement(Base)
	self.Base = Base
	local InnerGlow = LUI.UIImage.new(0.5, 0.5, -110, 110, 0.5, 0.5, -30.5, 14.5)
	InnerGlow:setAlpha(0)
	InnerGlow:setImage(RegisterImage(@"uie_director_frontend_glow"))
	InnerGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(InnerGlow)
	self.InnerGlow = InnerGlow
	local CLUSTER = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -11, 11)
	CLUSTER:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6CBC1B6252C70EE6"))
	CLUSTER:setTTF("0arame_mono_stencil")
	CLUSTER:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_cheap_blur"))
	CLUSTER:setShaderVector(0, 0, 1, 0, 0)
	CLUSTER:setShaderVector(1, 0, 0, 0, 0)
	CLUSTER:setShaderVector(2, 0, 0, 0, 0)
	CLUSTER:setShaderVector(3, 0, 0, 0, 0)
	CLUSTER:setShaderVector(4, 0, 0, 0, 0)
	CLUSTER:setLetterSpacing(2)
	CLUSTER:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CLUSTER:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CLUSTER)
	self.CLUSTER = CLUSTER
	local CLUSTER0 = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -11, 11)
	CLUSTER0:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6CBC1B6252C70EE6"))
	CLUSTER0:setTTF("0arame_mono_stencil")
	CLUSTER0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	CLUSTER0:setLetterSpacing(2)
	CLUSTER0:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CLUSTER0:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(CLUSTER0)
	self.CLUSTER0 = CLUSTER0
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0.5, 220.5, 0, 0, -0.5, 21.5)
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
CoD.vhud_hellstorm_NotificationCluster.__onClose = function(f2_arg0)
	f2_arg0.Frame:close()
end
