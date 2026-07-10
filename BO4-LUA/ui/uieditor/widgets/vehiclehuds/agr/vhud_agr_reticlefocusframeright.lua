CoD.vhud_agr_ReticleFocusFrameRight = InheritFrom(LUI.UIElement)
CoD.vhud_agr_ReticleFocusFrameRight.__defaultWidth = 241
CoD.vhud_agr_ReticleFocusFrameRight.__defaultHeight = 132
CoD.vhud_agr_ReticleFocusFrameRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_ReticleFocusFrameRight)
	self.id = "vhud_agr_ReticleFocusFrameRight"
	self.soundSet = "default"
	local agrReticleFocusFrameR0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleFocusFrameR0:setAlpha(0.15)
	agrReticleFocusFrameR0:setZoom(-50)
	agrReticleFocusFrameR0:setImage(RegisterImage(0x58D3A3D902C8C7E))
	agrReticleFocusFrameR0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrReticleFocusFrameR0)
	self.agrReticleFocusFrameR0 = agrReticleFocusFrameR0
	local agrReticleFocusFrameR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleFocusFrameR:setAlpha(0.8)
	agrReticleFocusFrameR:setImage(RegisterImage(0x58D3A3D902C8C7E))
	agrReticleFocusFrameR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(agrReticleFocusFrameR)
	self.agrReticleFocusFrameR = agrReticleFocusFrameR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
