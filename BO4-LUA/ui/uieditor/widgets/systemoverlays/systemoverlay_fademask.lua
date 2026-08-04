CoD.systemOverlay_FadeMask = InheritFrom(LUI.UIElement)
CoD.systemOverlay_FadeMask.__defaultWidth = 492
CoD.systemOverlay_FadeMask.__defaultHeight = 286
CoD.systemOverlay_FadeMask.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_FadeMask)
	self.id = "systemOverlay_FadeMask"
	self.soundSet = "default"
	local Mask = LUI.UIImage.new(0, 1, 0, -246, 0, 1, 0, 0)
	Mask:setRGB(0, 0, 0)
	Mask:setImage(RegisterImage("uie_t7_icon_mask_overlays_bkg"))
	self:addElement(Mask)
	self.Mask = Mask
	local Mask0 = LUI.UIImage.new(0, 1, 246, 0, 0, 1, 0, 0)
	Mask0:setYRot(180)
	Mask0:setImage(RegisterImage("uie_t7_icon_mask_overlays_bkg"))
	self:addElement(Mask0)
	self.Mask0 = Mask0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
