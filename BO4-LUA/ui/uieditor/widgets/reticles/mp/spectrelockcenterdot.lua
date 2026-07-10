CoD.SpectreLockCenterDot = InheritFrom(LUI.UIElement)
CoD.SpectreLockCenterDot.__defaultWidth = 8
CoD.SpectreLockCenterDot.__defaultHeight = 8
CoD.SpectreLockCenterDot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpectreLockCenterDot)
	self.id = "SpectreLockCenterDot"
	self.soundSet = "default"
	local SpectreBladeCenterDot = LUI.UIImage.new(0.5, 0.5, -4, 4, 0.5, 0.5, -4, 4)
	SpectreBladeCenterDot:setRGB(1, 0.01, 0)
	SpectreBladeCenterDot:setImage(RegisterImage(@"hash_4638A7C387C3648C"))
	self:addElement(SpectreBladeCenterDot)
	self.SpectreBladeCenterDot = SpectreBladeCenterDot
	local SpectreBladeCenterDotGlow01 = LUI.UIImage.new(0.5, 0.5, -4, 4, 0.5, 0.5, -4, 4)
	SpectreBladeCenterDotGlow01:setRGB(1, 0.01, 0)
	SpectreBladeCenterDotGlow01:setImage(RegisterImage(@"hash_4638A7C387C3648C"))
	SpectreBladeCenterDotGlow01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpectreBladeCenterDotGlow01:setShaderVector(0, 20, 0, 0, 0)
	self:addElement(SpectreBladeCenterDotGlow01)
	self.SpectreBladeCenterDotGlow01 = SpectreBladeCenterDotGlow01
	local SpectreBladeCenterDotGlow02 = LUI.UIImage.new(0.5, 0.5, -4, 4, 0.5, 0.5, -4, 4)
	SpectreBladeCenterDotGlow02:setRGB(1, 0.88, 0.77)
	SpectreBladeCenterDotGlow02:setImage(RegisterImage(@"hash_4638A7C387C3648C"))
	SpectreBladeCenterDotGlow02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SpectreBladeCenterDotGlow02:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpectreBladeCenterDotGlow02)
	self.SpectreBladeCenterDotGlow02 = SpectreBladeCenterDotGlow02
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
