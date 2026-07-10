CoD.vhud_ms_FrameTopCenter = InheritFrom(LUI.UIElement)
CoD.vhud_ms_FrameTopCenter.__defaultWidth = 778
CoD.vhud_ms_FrameTopCenter.__defaultHeight = 96
CoD.vhud_ms_FrameTopCenter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_FrameTopCenter)
	self.id = "vhud_ms_FrameTopCenter"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setRGB(0.74, 0.94, 0.99)
	Image0:setAlpha(0.1)
	Image0:setZoom(-50)
	Image0:setImage(RegisterImage(0x27790B8D32A1115))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	local msTopFrameCenter = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msTopFrameCenter:setRGB(0.74, 0.94, 0.99)
	msTopFrameCenter:setAlpha(0.6)
	msTopFrameCenter:setImage(RegisterImage(0x27790B8D32A1115))
	msTopFrameCenter:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msTopFrameCenter)
	self.msTopFrameCenter = msTopFrameCenter
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
