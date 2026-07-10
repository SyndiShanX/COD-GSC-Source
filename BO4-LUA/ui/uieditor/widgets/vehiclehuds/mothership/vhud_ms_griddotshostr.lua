CoD.vhud_ms_GridDotsHostR = InheritFrom(LUI.UIElement)
CoD.vhud_ms_GridDotsHostR.__defaultWidth = 178
CoD.vhud_ms_GridDotsHostR.__defaultHeight = 178
CoD.vhud_ms_GridDotsHostR.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_GridDotsHostR)
	self.id = "vhud_ms_GridDotsHostR"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local msGridDotsHostR = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	msGridDotsHostR:setAlpha(0.4)
	msGridDotsHostR:setZoom(40)
	msGridDotsHostR:setImage(RegisterImage(0x9E7CA7A1D0949B9))
	msGridDotsHostR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(msGridDotsHostR)
	self.msGridDotsHostR = msGridDotsHostR
	local Image0 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image0:setAlpha(0.1)
	Image0:setImage(RegisterImage(0x9E7CA7A1D0949B9))
	Image0:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image0)
	self.Image0 = Image0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
