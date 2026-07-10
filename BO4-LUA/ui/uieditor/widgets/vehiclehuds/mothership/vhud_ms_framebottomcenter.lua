CoD.vhud_ms_FrameBottomCenter = InheritFrom(LUI.UIElement)
CoD.vhud_ms_FrameBottomCenter.__defaultWidth = 778
CoD.vhud_ms_FrameBottomCenter.__defaultHeight = 96
CoD.vhud_ms_FrameBottomCenter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_FrameBottomCenter)
	self.id = "vhud_ms_FrameBottomCenter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local msBottomFrameCenter = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msBottomFrameCenter:setRGB(0.74, 0.94, 0.99)
	msBottomFrameCenter:setAlpha(0.6)
	msBottomFrameCenter:setXRot(180)
	msBottomFrameCenter:setImage(RegisterImage(0x27790B8D32A1115))
	msBottomFrameCenter:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msBottomFrameCenter)
	self.msBottomFrameCenter = msBottomFrameCenter
	local msBottomFrameCenterDepth = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msBottomFrameCenterDepth:setRGB(0.74, 0.94, 0.99)
	msBottomFrameCenterDepth:setAlpha(0.1)
	msBottomFrameCenterDepth:setXRot(180)
	msBottomFrameCenterDepth:setZoom(-50)
	msBottomFrameCenterDepth:setImage(RegisterImage(0x27790B8D32A1115))
	msBottomFrameCenterDepth:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msBottomFrameCenterDepth)
	self.msBottomFrameCenterDepth = msBottomFrameCenterDepth
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
