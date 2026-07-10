CoD.vhud_agr_ReticleOutsideDotsUR = InheritFrom(LUI.UIElement)
CoD.vhud_agr_ReticleOutsideDotsUR.__defaultWidth = 96
CoD.vhud_agr_ReticleOutsideDotsUR.__defaultHeight = 48
CoD.vhud_agr_ReticleOutsideDotsUR.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_ReticleOutsideDotsUR)
	self.id = "vhud_agr_ReticleOutsideDotsUR"
	self.soundSet = "default"
	local agrReticleOutsideDotsUR0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleOutsideDotsUR0:setAlpha(0.15)
	agrReticleOutsideDotsUR0:setZoom(-50)
	agrReticleOutsideDotsUR0:setImage(RegisterImage(0x313A715108951EA))
	agrReticleOutsideDotsUR0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrReticleOutsideDotsUR0)
	self.agrReticleOutsideDotsUR0 = agrReticleOutsideDotsUR0
	local agrReticleOutsideDotsUR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleOutsideDotsUR:setAlpha(0.7)
	agrReticleOutsideDotsUR:setImage(RegisterImage(0x313A715108951EA))
	agrReticleOutsideDotsUR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrReticleOutsideDotsUR)
	self.agrReticleOutsideDotsUR = agrReticleOutsideDotsUR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
