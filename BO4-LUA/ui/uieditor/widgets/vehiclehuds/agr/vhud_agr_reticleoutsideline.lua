CoD.vhud_agr_ReticleOutsideLine = InheritFrom(LUI.UIElement)
CoD.vhud_agr_ReticleOutsideLine.__defaultWidth = 108
CoD.vhud_agr_ReticleOutsideLine.__defaultHeight = 84
CoD.vhud_agr_ReticleOutsideLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_ReticleOutsideLine)
	self.id = "vhud_agr_ReticleOutsideLine"
	self.soundSet = "default"
	local agrReticleOutsideLineUR0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleOutsideLineUR0:setAlpha(0.15)
	agrReticleOutsideLineUR0:setZoom(-50)
	agrReticleOutsideLineUR0:setImage(RegisterImage(0x14E775656A19FFC))
	agrReticleOutsideLineUR0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrReticleOutsideLineUR0)
	self.agrReticleOutsideLineUR0 = agrReticleOutsideLineUR0
	local agrReticleOutsideLineUR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleOutsideLineUR:setAlpha(0.8)
	agrReticleOutsideLineUR:setImage(RegisterImage(0x14E775656A19FFC))
	agrReticleOutsideLineUR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrReticleOutsideLineUR)
	self.agrReticleOutsideLineUR = agrReticleOutsideLineUR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
