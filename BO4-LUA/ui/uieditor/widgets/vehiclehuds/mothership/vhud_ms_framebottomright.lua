CoD.vhud_ms_FrameBottomRight = InheritFrom(LUI.UIElement)
CoD.vhud_ms_FrameBottomRight.__defaultWidth = 721
CoD.vhud_ms_FrameBottomRight.__defaultHeight = 217
CoD.vhud_ms_FrameBottomRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_FrameBottomRight)
	self.id = "vhud_ms_FrameBottomRight"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setRGB(0.74, 0.94, 0.99)
	Image0:setAlpha(0.06)
	Image0:setXRot(180)
	Image0:setZoom(-40)
	Image0:setImage(RegisterImage(0xC5B13A17382E497))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	local msBottomFrameRight = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msBottomFrameRight:setRGB(0.74, 0.94, 0.99)
	msBottomFrameRight:setAlpha(0.5)
	msBottomFrameRight:setXRot(180)
	msBottomFrameRight:setImage(RegisterImage(0xC5B13A17382E497))
	msBottomFrameRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msBottomFrameRight)
	self.msBottomFrameRight = msBottomFrameRight
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
