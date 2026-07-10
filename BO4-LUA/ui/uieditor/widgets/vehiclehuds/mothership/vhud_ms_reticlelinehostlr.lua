CoD.vhud_ms_ReticleLineHostLR = InheritFrom(LUI.UIElement)
CoD.vhud_ms_ReticleLineHostLR.__defaultWidth = 232
CoD.vhud_ms_ReticleLineHostLR.__defaultHeight = 85
CoD.vhud_ms_ReticleLineHostLR.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_ReticleLineHostLR)
	self.id = "vhud_ms_ReticleLineHostLR"
	self.soundSet = "default"
	local Host = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Host:setRGB(0.74, 0.94, 0.99)
	Host:setAlpha(0.07)
	Host:setXRot(180)
	Host:setZoom(-40)
	Host:setImage(RegisterImage(0xF28657F590B16FE))
	Host:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Host)
	self.Host = Host
	local msReticleHostLowerR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msReticleHostLowerR:setRGB(0.74, 0.94, 0.99)
	msReticleHostLowerR:setAlpha(0.4)
	msReticleHostLowerR:setXRot(180)
	msReticleHostLowerR:setImage(RegisterImage(0xF28657F590B16FE))
	msReticleHostLowerR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msReticleHostLowerR)
	self.msReticleHostLowerR = msReticleHostLowerR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
