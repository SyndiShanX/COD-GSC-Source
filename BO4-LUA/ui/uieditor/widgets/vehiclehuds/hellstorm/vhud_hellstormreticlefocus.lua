CoD.vhud_HellstormReticleFocus = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormReticleFocus.__defaultWidth = 220
CoD.vhud_HellstormReticleFocus.__defaultHeight = 220
CoD.vhud_HellstormReticleFocus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormReticleFocus)
	self.id = "vhud_HellstormReticleFocus"
	self.soundSet = "default"
	local L = LUI.UIImage.new(0, 0, 0, 110, 0, 0, 0, 110)
	L:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ringreticle"))
	self:addElement(L)
	self.L = L
	local LAdd = LUI.UIImage.new(0, 0, 0, 110, 0, 0, 0, 110)
	LAdd:setAlpha(0.2)
	LAdd:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ringreticle"))
	LAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(LAdd)
	self.LAdd = LAdd
	local R = LUI.UIImage.new(0.5, 0.5, 110, 0, 0, 0, 0, 110)
	R:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ringreticle"))
	self:addElement(R)
	self.R = R
	local RAdd = LUI.UIImage.new(0.5, 0.5, 110, 0, 0, 0, 0, 110)
	RAdd:setAlpha(0.2)
	RAdd:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ringreticle"))
	RAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(RAdd)
	self.RAdd = RAdd
	local Glow = LUI.UIImage.new(0, 0, 0, 220, 0, 0, 0, 110)
	Glow:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	Glow:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_ringreticle_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	Glow:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Glow)
	self.Glow = Glow
	local PinBot = LUI.UIImage.new(0, 0, 98.5, 122.5, 0, 0, 200, 220)
	PinBot:setZRot(90)
	PinBot:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_indicator"))
	PinBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PinBot)
	self.PinBot = PinBot
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
