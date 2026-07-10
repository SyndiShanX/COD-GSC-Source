CoD.vhud_ms_FrameBottomLeft = InheritFrom(LUI.UIElement)
CoD.vhud_ms_FrameBottomLeft.__defaultWidth = 721
CoD.vhud_ms_FrameBottomLeft.__defaultHeight = 217
CoD.vhud_ms_FrameBottomLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_FrameBottomLeft)
	self.id = "vhud_ms_FrameBottomLeft"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setRGB(0.74, 0.94, 0.99)
	Image0:setAlpha(0.06)
	Image0:setXRot(180)
	Image0:setYRot(-180)
	Image0:setZoom(-40)
	Image0:setImage(RegisterImage(0xC5B13A17382E497))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	local msBottomFrameLeft = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msBottomFrameLeft:setRGB(0.74, 0.94, 0.99)
	msBottomFrameLeft:setAlpha(0.5)
	msBottomFrameLeft:setXRot(180)
	msBottomFrameLeft:setYRot(-180)
	msBottomFrameLeft:setImage(RegisterImage(0xC5B13A17382E497))
	msBottomFrameLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msBottomFrameLeft)
	self.msBottomFrameLeft = msBottomFrameLeft
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
