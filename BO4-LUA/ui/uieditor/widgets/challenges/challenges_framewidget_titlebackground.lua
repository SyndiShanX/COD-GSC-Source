require("ui/uieditor/widgets/startmenu/options/startmenuoptionsmainframe")
require("ui/uieditor/widgets/store/storecommontextbacking")
CoD.Challenges_FrameWidget_TitleBackground = InheritFrom(LUI.UIElement)
CoD.Challenges_FrameWidget_TitleBackground.__defaultWidth = 525
CoD.Challenges_FrameWidget_TitleBackground.__defaultHeight = 732
CoD.Challenges_FrameWidget_TitleBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_FrameWidget_TitleBackground)
	self.id = "Challenges_FrameWidget_TitleBackground"
	self.soundSet = "FrontendMain"
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	NoiseTiledBacking:setAlpha(0.3)
	NoiseTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local LightOverlay = LUI.UIImage.new(0, 1, 4, -4, 0, 1, 4, -4)
	LightOverlay:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LightOverlay:setAlpha(0.01)
	self:addElement(LightOverlay)
	self.LightOverlay = LightOverlay
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(0.34, 0.33, 0.33)
	Frame:setAlpha(0.02)
	self:addElement(Frame)
	self.Frame = Frame
	local TiledPlusGrid2 = LUI.UIImage.new(0.5, 0.5, -320.5, 320.5, 0.5, 0.5, -542.5, 422.5)
	TiledPlusGrid2:setAlpha(0.04)
	TiledPlusGrid2:setImage(RegisterImage("uie_ui_hud_vehicle_hellstorm_repeat_plusgrid"))
	TiledPlusGrid2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TiledPlusGrid2:setShaderVector(0, 0, 0, 0, 0)
	TiledPlusGrid2:setupNineSliceShader(220, 220)
	self:addElement(TiledPlusGrid2)
	self.TiledPlusGrid2 = TiledPlusGrid2
	local CornerPip2 = LUI.UIImage.new(1, 1, -20, 0, 0, 0, 0, 20)
	CornerPip2:setAlpha(0.1)
	CornerPip2:setZRot(90)
	CornerPip2:setImage(RegisterImage("uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip2)
	self.CornerPip2 = CornerPip2
	local CornerPip3 = LUI.UIImage.new(1, 1, -20, 0, 1, 1, -20, 0)
	CornerPip3:setAlpha(0.1)
	CornerPip3:setImage(RegisterImage("uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip3)
	self.CornerPip3 = CornerPip3
	local CornerPip4 = LUI.UIImage.new(0, 0, 0, 20, 1, 1, -20, 0)
	CornerPip4:setAlpha(0.1)
	CornerPip4:setZRot(-90)
	CornerPip4:setImage(RegisterImage("uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip4)
	self.CornerPip4 = CornerPip4
	local CornerPip = LUI.UIImage.new(0, 0, 0, 20, 0, 0, 0, 20)
	CornerPip:setAlpha(0.1)
	CornerPip:setZRot(180)
	CornerPip:setImage(RegisterImage("uie_ui_menu_specialist_hub_window_corner"))
	self:addElement(CornerPip)
	self.CornerPip = CornerPip
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0.25, 0.75, 0, 0, 0.18, 0.82, 0, 0)
	DotTiledBacking:setAlpha(0)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local HeaderStripeTop = LUI.UIImage.new(0, 1, 6, -6, 0, 0, 5, 18)
	HeaderStripeTop:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderStripeTop:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	HeaderStripeTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderStripeTop:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripeTop:setupNineSliceShader(90, 16)
	self:addElement(HeaderStripeTop)
	self.HeaderStripeTop = HeaderStripeTop
	local HeaderStripeBot = LUI.UIImage.new(0, 1, 6, -6, 1, 1, -18, -5)
	HeaderStripeBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderStripeBot:setImage(RegisterImage(@"hash_2C7A051F5EFC70E5"))
	HeaderStripeBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	HeaderStripeBot:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripeBot:setupNineSliceShader(90, 16)
	self:addElement(HeaderStripeBot)
	self.HeaderStripeBot = HeaderStripeBot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_FrameWidget_TitleBackground.__onClose = function(f2_arg0)
	f2_arg0.Frame:close()
	f2_arg0.DotTiledBacking:close()
end
