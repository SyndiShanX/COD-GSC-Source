CoD.FallMeter_ParachuteDeployIndicator = InheritFrom(LUI.UIElement)
CoD.FallMeter_ParachuteDeployIndicator.__defaultWidth = 38
CoD.FallMeter_ParachuteDeployIndicator.__defaultHeight = 8
CoD.FallMeter_ParachuteDeployIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FallMeter_ParachuteDeployIndicator)
	self.id = "FallMeter_ParachuteDeployIndicator"
	self.soundSet = "none"
	local Line = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Line:setRGB(0.08, 0.45, 0.21)
	self:addElement(Line)
	self.Line = Line
	local GlowBase = LUI.UIImage.new(0.5, 0.5, -21, 21, 0.5, 0.5, -16, 16)
	GlowBase:setRGB(0.1, 0.74, 0.33)
	GlowBase:setImage(RegisterImage(0x87BE43A2A727AF))
	self:addElement(GlowBase)
	self.GlowBase = GlowBase
	local GlowBase2 = LUI.UIImage.new(0.5, 0.5, -21, 21, 0.5, 0.5, -10, 10)
	GlowBase2:setRGB(0.1, 0.74, 0.61)
	GlowBase2:setAlpha(0.8)
	GlowBase2:setImage(RegisterImage(0x87BE43A2A727AF))
	GlowBase2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	GlowBase2:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(GlowBase2)
	self.GlowBase2 = GlowBase2
	local Glow = LUI.UIImage.new(0.5, 0.5, -50, 50, 0.5, 0.5, -18, 18)
	Glow:setRGB(0.1, 0.74, 0.39)
	Glow:setImage(RegisterImage(0x658B1F463FE7860))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	local ArrowL = LUI.UIImage.new(0, 0, -10, -5, 0.5, 0.5, -5.5, 5.5)
	ArrowL:setRGB(0.1, 0.74, 0.39)
	ArrowL:setScale(1.4, 1.4)
	ArrowL:setImage(RegisterImage(0x1226A0CC6137EEE))
	self:addElement(ArrowL)
	self.ArrowL = ArrowL
	local ArrowGlowL2 = LUI.UIImage.new(0, 0, -10, -5, 0.5, 0.5, -5.5, 5.5)
	ArrowGlowL2:setRGB(0.1, 0.74, 0.39)
	ArrowGlowL2:setScale(1.4, 1.4)
	ArrowGlowL2:setImage(RegisterImage(0x9D7E0FF6D412FC4))
	self:addElement(ArrowGlowL2)
	self.ArrowGlowL2 = ArrowGlowL2
	local ArrowBloomL = LUI.UIImage.new(0, 0, -18, 0, 0, 0, -12, 24)
	ArrowBloomL:setRGB(0.1, 0.74, 0.39)
	ArrowBloomL:setAlpha(0.3)
	ArrowBloomL:setImage(RegisterImage(0x658B1F463FE7860))
	ArrowBloomL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ArrowBloomL)
	self.ArrowBloomL = ArrowBloomL
	local ArrowGlowL3 = LUI.UIImage.new(0, 0, -10, -5, 0.5, 0.5, -5.5, 5.5)
	ArrowGlowL3:setRGB(0.1, 0.74, 0.39)
	ArrowGlowL3:setScale(1.4, 1.4)
	ArrowGlowL3:setImage(RegisterImage(0x9D7E0FF6D412FC4))
	ArrowGlowL3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ArrowGlowL3)
	self.ArrowGlowL3 = ArrowGlowL3
	local ArrowR = LUI.UIImage.new(1, 1, 5, 10, 0.5, 0.5, -5.5, 5.5)
	ArrowR:setRGB(0.1, 0.74, 0.39)
	ArrowR:setZRot(180)
	ArrowR:setScale(1.4, 1.4)
	ArrowR:setImage(RegisterImage(0x1226A0CC6137EEE))
	self:addElement(ArrowR)
	self.ArrowR = ArrowR
	local ArrowR2 = LUI.UIImage.new(1, 1, 5, 10, 0.5, 0.5, -5.5, 5.5)
	ArrowR2:setRGB(0.1, 0.74, 0.39)
	ArrowR2:setZRot(180)
	ArrowR2:setScale(1.4, 1.4)
	ArrowR2:setImage(RegisterImage(0x9D7E0FF6D412FC4))
	self:addElement(ArrowR2)
	self.ArrowR2 = ArrowR2
	local ArrowR3 = LUI.UIImage.new(1, 1, 5, 10, 0.5, 0.5, -5.5, 5.5)
	ArrowR3:setRGB(0.1, 0.74, 0.39)
	ArrowR3:setZRot(180)
	ArrowR3:setScale(1.4, 1.4)
	ArrowR3:setImage(RegisterImage(0x9D7E0FF6D412FC4))
	ArrowR3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ArrowR3)
	self.ArrowR3 = ArrowR3
	local ArrowBloomR = LUI.UIImage.new(0, 0, 38, 56, 0, 0, -13, 23)
	ArrowBloomR:setRGB(0.1, 0.74, 0.39)
	ArrowBloomR:setAlpha(0.3)
	ArrowBloomR:setImage(RegisterImage(0x658B1F463FE7860))
	ArrowBloomR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ArrowBloomR)
	self.ArrowBloomR = ArrowBloomR
	local ParachuteIcon = LUI.UIImage.new(0, 0, 48, 68, 0, 0, -6, 14)
	ParachuteIcon:setRGB(0.1, 0.79, 0.42)
	ParachuteIcon:setImage(RegisterImage(0xA912D9E22E33B69))
	self:addElement(ParachuteIcon)
	self.ParachuteIcon = ParachuteIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
