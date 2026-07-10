CoD.vhud_HellstormReticleFocus = InheritFrom(LUI.UIElement)
CoD.vhud_HellstormReticleFocus.__defaultWidth = 220
CoD.vhud_HellstormReticleFocus.__defaultHeight = 220
CoD.vhud_HellstormReticleFocus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_HellstormReticleFocus)
	self.id = "vhud_HellstormReticleFocus"
	self.soundSet = "default"
	local L = LUI.UIImage.new(0, 0, 0, 110, 0, 0, 0, 110)
	L:setImage(RegisterImage(0xC49ECB87DAA4E82))
	self:addElement(L)
	self.L = L
	local LAdd = LUI.UIImage.new(0, 0, 0, 110, 0, 0, 0, 110)
	LAdd:setAlpha(0.2)
	LAdd:setImage(RegisterImage(0xC49ECB87DAA4E82))
	LAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(LAdd)
	self.LAdd = LAdd
	local R = LUI.UIImage.new(0.5, 0.5, 110, 0, 0, 0, 0, 110)
	R:setImage(RegisterImage(0xC49ECB87DAA4E82))
	self:addElement(R)
	self.R = R
	local RAdd = LUI.UIImage.new(0.5, 0.5, 110, 0, 0, 0, 0, 110)
	RAdd:setAlpha(0.2)
	RAdd:setImage(RegisterImage(0xC49ECB87DAA4E82))
	RAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(RAdd)
	self.RAdd = RAdd
	local Glow = LUI.UIImage.new(0, 0, 0, 220, 0, 0, 0, 110)
	Glow:setRGB(ColorSet.EnemyOrange_Bright.r, ColorSet.EnemyOrange_Bright.g, ColorSet.EnemyOrange_Bright.b)
	Glow:setImage(RegisterImage(0x2C5D89A2DB53AB2))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Glow:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(Glow)
	self.Glow = Glow
	local PinBot = LUI.UIImage.new(0, 0, 98.5, 122.5, 0, 0, 200, 220)
	PinBot:setZRot(90)
	PinBot:setImage(RegisterImage(0x99A8C3E368A2195))
	PinBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PinBot)
	self.PinBot = PinBot
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
