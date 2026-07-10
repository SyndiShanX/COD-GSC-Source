CoD.vhud_ms_OutsideLine = InheritFrom(LUI.UIElement)
CoD.vhud_ms_OutsideLine.__defaultWidth = 66
CoD.vhud_ms_OutsideLine.__defaultHeight = 22
CoD.vhud_ms_OutsideLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_OutsideLine)
	self.id = "vhud_ms_OutsideLine"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local msOuterLineR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msOuterLineR:setRGB(0.74, 0.94, 0.99)
	msOuterLineR:setAlpha(0.3)
	msOuterLineR:setZoom(50)
	msOuterLineR:setImage(RegisterImage(0xE3F52EB8D22B16D))
	msOuterLineR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msOuterLineR)
	self.msOuterLineR = msOuterLineR
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setRGB(0.74, 0.94, 0.99)
	Image0:setAlpha(0.1)
	Image0:setImage(RegisterImage(0xE3F52EB8D22B16D))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
