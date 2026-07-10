CoD.PC_BnetStore_Keyart = InheritFrom(LUI.UIElement)
CoD.PC_BnetStore_Keyart.__defaultWidth = 1920
CoD.PC_BnetStore_Keyart.__defaultHeight = 1305
CoD.PC_BnetStore_Keyart.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_BnetStore_Keyart)
	self.id = "PC_BnetStore_Keyart"
	self.soundSet = "default"
	local KeyArtBG = LUI.UIFixedAspectRatioImage.new(0, 1, 0, 0, 0, 0, 224.5, 1304.5)
	KeyArtBG:setImage(RegisterImage(0xA994C621186678C))
	self:addElement(KeyArtBG)
	self.KeyArtBG = KeyArtBG
	local KeyArtfix = nil
	KeyArtfix = LUI.UIImage.new(0, 1.09, -87.5, -87.5, 0, 0, -2, 448)
	KeyArtfix:setImage(RegisterImage(0xBBEA8E879C76D6F))
	self:addElement(KeyArtfix)
	self.KeyArtfix = KeyArtfix
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
