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
	InnerGlow:setImage(RegisterImage(0x3CCB8ACC43F6BDC))
	InnerGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(InnerGlow)
	self.InnerGlow = InnerGlow
	local CLUSTER = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -11, 11)
	CLUSTER:setText(Engine[0xF9F1239CFD921FE](0xCBC1B6252C70EE6))
	CLUSTER:setTTF("0arame_mono_stencil")
	CLUSTER:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0xD756CD9A5F1F1B4))
	CLUSTER:setShaderVector(0, 0, 1, 0, 0)
	CLUSTER:setShaderVector(1, 0, 0, 0, 0)
	CLUSTER:setShaderVector(2, 0, 0, 0, 0)
	CLUSTER:setShaderVector(3, 0, 0, 0, 0)
	CLUSTER:setShaderVector(4, 0, 0, 0, 0)
	CLUSTER:setLetterSpacing(2)
	CLUSTER:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CLUSTER:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CLUSTER)
	self.CLUSTER = CLUSTER
	local CLUSTER0 = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -11, 11)
	CLUSTER0:setText(Engine[0xF9F1239CFD921FE](0xCBC1B6252C70EE6))
	CLUSTER0:setTTF("0arame_mono_stencil")
	CLUSTER0:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	CLUSTER0:setLetterSpacing(2)
	CLUSTER0:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CLUSTER0:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CLUSTER0)
	self.CLUSTER0 = CLUSTER0
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0.5, 220.5, 0, 0, -0.5, 21.5)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local GlowBot = LUI.UIImage.new(0.5, 0.5, -113, 113, 0, 0, 15, 35)
	GlowBot:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	GlowBot:setAlpha(0)
	GlowBot:setImage(RegisterImage(0xAD405802E3EEE94))
	GlowBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowBot)
	self.GlowBot = GlowBot
	local GlowTop = LUI.UIImage.new(0.5, 0.5, -113, 113, 0, 0, 7, -13)
	GlowTop:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	GlowTop:setAlpha(0)
	GlowTop:setImage(RegisterImage(0xAD405802E3EEE94))
	GlowTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
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
