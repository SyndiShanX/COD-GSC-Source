CoD.vhud_agr_ReticleFocusFrameLeft = InheritFrom(LUI.UIElement)
CoD.vhud_agr_ReticleFocusFrameLeft.__defaultWidth = 241
CoD.vhud_agr_ReticleFocusFrameLeft.__defaultHeight = 132
CoD.vhud_agr_ReticleFocusFrameLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_ReticleFocusFrameLeft)
	self.id = "vhud_agr_ReticleFocusFrameLeft"
	self.soundSet = "default"
	local agrReticleFocusFrameL0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleFocusFrameL0:setAlpha(0.15)
	agrReticleFocusFrameL0:setYRot(-180)
	agrReticleFocusFrameL0:setZoom(-35)
	agrReticleFocusFrameL0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticlefocusframe"))
	agrReticleFocusFrameL0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleFocusFrameL0)
	self.agrReticleFocusFrameL0 = agrReticleFocusFrameL0
	local agrReticleFocusFrameL = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	agrReticleFocusFrameL:setAlpha(0.8)
	agrReticleFocusFrameL:setYRot(-180)
	agrReticleFocusFrameL:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_agr_reticlefocusframe"))
	agrReticleFocusFrameL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(agrReticleFocusFrameL)
	self.agrReticleFocusFrameL = agrReticleFocusFrameL
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
