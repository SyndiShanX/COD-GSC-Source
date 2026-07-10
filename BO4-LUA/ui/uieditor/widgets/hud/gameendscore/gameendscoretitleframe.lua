CoD.GameEndScoreTitleFrame = InheritFrom(LUI.UIElement)
CoD.GameEndScoreTitleFrame.__defaultWidth = 648
CoD.GameEndScoreTitleFrame.__defaultHeight = 156
CoD.GameEndScoreTitleFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreTitleFrame)
	self.id = "GameEndScoreTitleFrame"
	self.soundSet = "default"
	local BgBlurL = LUI.UIImage.new(0.5, 0.5, -320, 0, 0, 0, 4, 152)
	BgBlurL:setAlpha(0.8)
	BgBlurL:setImage(RegisterImage(@"hash_1D63D8122A1F6E1"))
	BgBlurL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BgBlurL:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BgBlurL)
	self.BgBlurL = BgBlurL
	local BgBlurR = LUI.UIImage.new(0.5, 0.5, -1.5, 318.5, 0, 0, 4, 152)
	BgBlurR:setAlpha(0.8)
	BgBlurR:setYRot(180)
	BgBlurR:setImage(RegisterImage(@"hash_1D63D8122A1F6E1"))
	BgBlurR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BgBlurR:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BgBlurR)
	self.BgBlurR = BgBlurR
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -315.5, 315.5, 0.09, 0.09, 83, 104)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local f1_local4 = nil
	self.BgTintR = LUI.UIElement.createFake()
	local f1_local5 = nil
	self.BgTintL = LUI.UIElement.createFake()
	local BgTint = nil
	BgTint = LUI.UIImage.new(0.5, 0.5, -324, 324, 0, 0, 4, 152)
	BgTint:setImage(RegisterImage(@"hash_34602EAD5BB5D6F"))
	self:addElement(BgTint)
	self.BgTint = BgTint
	local PixelGridTiledBacking = LUI.UIImage.new(0.02, 0.02, -1, 629, 0.31, 0.31, -40.5, 47.5)
	PixelGridTiledBacking:setAlpha(0.1)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local PixelGridTiledBacking2 = LUI.UIImage.new(0.02, 0.02, -1, 629, 0.31, 0.31, 68.5, 98.5)
	PixelGridTiledBacking2:setAlpha(0.1)
	PixelGridTiledBacking2:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGridTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking2:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking2)
	self.PixelGridTiledBacking2 = PixelGridTiledBacking2
	local InnerFrameL = LUI.UIImage.new(0.5, 0.5, -320, 0, 0, 0, 4, 152)
	InnerFrameL:setImage(RegisterImage(@"hash_5CE823BC468EF7DC"))
	self:addElement(InnerFrameL)
	self.InnerFrameL = InnerFrameL
	local InnerFrameR = LUI.UIImage.new(0.5, 0.5, 319, -1, 0, 0, 4, 152)
	InnerFrameR:setImage(RegisterImage(@"hash_5CE823BC468EF7DC"))
	self:addElement(InnerFrameR)
	self.InnerFrameR = InnerFrameR
	local OuterFrameR = LUI.UIImage.new(0.5, 0.5, 323, -1, 0, 0, 0, 156)
	OuterFrameR:setImage(RegisterImage(@"hash_62287A6449CD8CB7"))
	self:addElement(OuterFrameR)
	self.OuterFrameR = OuterFrameR
	local OuterFrameL = LUI.UIImage.new(0.5, 0.5, -324, 0, 0, 0, 0, 156)
	OuterFrameL:setImage(RegisterImage(@"hash_62287A6449CD8CB7"))
	self:addElement(OuterFrameL)
	self.OuterFrameL = OuterFrameL
	local arrow01 = LUI.UIImage.new(0, 0, 538.5, 543.5, 0, 0, 6.5, 11.5)
	arrow01:setRGB(0.92, 0.92, 0.92)
	arrow01:setAlpha(0.05)
	arrow01:setImage(RegisterImage(@"uie_ui_hud_common_line_arrow"))
	arrow01:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(arrow01)
	self.arrow01 = arrow01
	local arrow02 = LUI.UIImage.new(0, 0, 105.5, 110.5, 0, 0, 6.5, 11.5)
	arrow02:setRGB(0.92, 0.92, 0.92)
	arrow02:setAlpha(0.05)
	arrow02:setImage(RegisterImage(@"uie_ui_hud_common_line_arrow"))
	arrow02:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(arrow02)
	self.arrow02 = arrow02
	local microtext = LUI.UIImage.new(0, 0, 611.5, 629.5, 0, 0, 6, 10)
	microtext:setAlpha(0.1)
	microtext:setZRot(180)
	microtext:setImage(RegisterImage(@"hash_116C3274D8031268"))
	self:addElement(microtext)
	self.microtext = microtext
	local microtext3 = LUI.UIImage.new(0, 0, 27.5, 45.5, 0, 0, 6.5, 10.5)
	microtext3:setAlpha(0.1)
	microtext3:setZRot(180)
	microtext3:setImage(RegisterImage(@"hash_116C3274D8031268"))
	self:addElement(microtext3)
	self.microtext3 = microtext3
	local microtext4 = LUI.UIImage.new(0, 0, 18.5, 36.5, 0, 0, 7, 11)
	microtext4:setAlpha(0.1)
	microtext4:setImage(RegisterImage(@"hash_116C3274D8031268"))
	microtext4:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	microtext4:setShaderVector(0, 0, 0.38, 0, 0)
	microtext4:setShaderVector(1, 0, 0, 0, 0)
	microtext4:setShaderVector(2, 0, 1, 0, 0)
	microtext4:setShaderVector(3, 0, 0, 0, 0)
	microtext4:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext4)
	self.microtext4 = microtext4
	local microtext2 = LUI.UIImage.new(0, 0, 600.5, 618.5, 0, 0, 6.5, 10.5)
	microtext2:setAlpha(0.1)
	microtext2:setImage(RegisterImage(@"hash_116C3274D8031268"))
	microtext2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	microtext2:setShaderVector(0, 0, 0.38, 0, 0)
	microtext2:setShaderVector(1, 0, 0, 0, 0)
	microtext2:setShaderVector(2, 0, 1, 0, 0)
	microtext2:setShaderVector(3, 0, 0, 0, 0)
	microtext2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext2)
	self.microtext2 = microtext2
	local TiledPlusGrid03 = LUI.UIImage.new(0.5, 0.5, -861, 849, 0, 0, -61.5, 295.5)
	TiledPlusGrid03:setRGB(0, 0, 0)
	TiledPlusGrid03:setScale(0.4, 0.4)
	TiledPlusGrid03:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid03:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledPlusGrid03:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid03:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid03)
	self.TiledPlusGrid03 = TiledPlusGrid03
	local TiledPlusGrid02 = LUI.UIImage.new(0.5, 0.5, -861, 849, 0, 0, -113, 244)
	TiledPlusGrid02:setRGB(0, 0, 0)
	TiledPlusGrid02:setScale(0.4, 0.4)
	TiledPlusGrid02:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledPlusGrid02:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid02:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid02)
	self.TiledPlusGrid02 = TiledPlusGrid02
	local TiledPlusGrid01 = LUI.UIImage.new(0.5, 0.5, -861, 849, 0, 0, -162, 195)
	TiledPlusGrid01:setRGB(0, 0, 0)
	TiledPlusGrid01:setScale(0.4, 0.4)
	TiledPlusGrid01:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledPlusGrid01:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid01:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid01)
	self.TiledPlusGrid01 = TiledPlusGrid01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
