CoD.TabletIcePickGadget_BgWindow = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_BgWindow.__defaultWidth = 240
CoD.TabletIcePickGadget_BgWindow.__defaultHeight = 240
CoD.TabletIcePickGadget_BgWindow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_BgWindow)
	self.id = "TabletIcePickGadget_BgWindow"
	self.soundSet = "default"
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGrid:setAlpha(0.1)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(256, 256)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.02, 0.08, 0.12)
	BG:setAlpha(0.8)
	self:addElement(BG)
	self.BG = BG
	local Frame = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	Frame:setAlpha(0.5)
	Frame:setImage(RegisterImage(@"hash_110AC7DF3E5F3B8B"))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Frame:setShaderVector(0, 0, 0, 0.38, 0.21)
	Frame:setupNineSliceShader(64, 46)
	self:addElement(Frame)
	self.Frame = Frame
	local BlurFrame = LUI.UIImage.new(0, 1, -5, 5, 0, 1, -5, 5)
	BlurFrame:setAlpha(0.5)
	BlurFrame:setImage(RegisterImage(@"hash_2517E94C3B16A2CB"))
	BlurFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	BlurFrame:setShaderVector(0, 0, 0, 0.38, 0.21)
	BlurFrame:setupNineSliceShader(64, 64)
	self:addElement(BlurFrame)
	self.BlurFrame = BlurFrame
	local Box01 = LUI.UIImage.new(0, 0, 5, 15, 0, 0, 1.5, 11.5)
	Box01:setRGB(0.46, 0.85, 1)
	Box01:setAlpha(0.5)
	Box01:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	Box01:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Box01:setShaderVector(0, 0, 0, 0, 0)
	Box01:setupNineSliceShader(24, 24)
	self:addElement(Box01)
	self.Box01 = Box01
	local Box02 = LUI.UIImage.new(0, 0, 19.5, 29.5, 0, 0, 1.5, 11.5)
	Box02:setRGB(0.46, 0.85, 1)
	Box02:setAlpha(0.5)
	Box02:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	Box02:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Box02:setShaderVector(0, 0, 0, 0, 0)
	Box02:setupNineSliceShader(24, 24)
	self:addElement(Box02)
	self.Box02 = Box02
	local Box03 = LUI.UIImage.new(0, 0, 34, 44, 0, 0, 1.5, 11.5)
	Box03:setRGB(0.46, 0.85, 1)
	Box03:setAlpha(0.5)
	Box03:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	Box03:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Box03:setShaderVector(0, 0, 0, 0, 0)
	Box03:setupNineSliceShader(24, 24)
	self:addElement(Box03)
	self.Box03 = Box03
	local FrontendFrameSelected = LUI.UIImage.new(0, 0, 18, 31, 0, 0, 0, 13)
	FrontendFrameSelected:setRGB(0.46, 0.85, 1)
	FrontendFrameSelected:setAlpha(0.5)
	FrontendFrameSelected:setImage(RegisterImage(@"uie_ui_menu_store_focus_frame"))
	FrontendFrameSelected:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrameSelected:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrameSelected:setupNineSliceShader(28, 28)
	self:addElement(FrontendFrameSelected)
	self.FrontendFrameSelected = FrontendFrameSelected
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
