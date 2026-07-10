CoD.Lobbysubheader = InheritFrom(LUI.UIElement)
CoD.Lobbysubheader.__defaultWidth = 1920
CoD.Lobbysubheader.__defaultHeight = 622
CoD.Lobbysubheader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Lobbysubheader)
	self.id = "Lobbysubheader"
	self.soundSet = "default"
	local background3 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -624, -154)
	background3:setRGB(0, 0, 0)
	background3:setAlpha(0.2)
	self:addElement(background3)
	self.background3 = background3
	local background1 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -618, -154)
	background1:setRGB(0, 0, 0)
	background1:setAlpha(0.2)
	self:addElement(background1)
	self.background1 = background1
	local background2 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -582, -114)
	background2:setRGB(0.14, 0.14, 0.14)
	background2:setAlpha(0.7)
	self:addElement(background2)
	self.background2 = background2
	local BackgroundGlow = LUI.UIImage.new(-0.5, 1.5, 0, 0, 1, 1, -582, 30)
	BackgroundGlow:setRGB(0, 0, 0)
	BackgroundGlow:setImage(RegisterImage(@"uie_ui_menu_cac_glow_half"))
	self:addElement(BackgroundGlow)
	self.BackgroundGlow = BackgroundGlow
	local GrainBGPattern = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -582, -114)
	GrainBGPattern:setAlpha(0.25)
	GrainBGPattern:setImage(RegisterImage(@"uie_ui_menu_cac_grain_pattern_bg"))
	GrainBGPattern:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GrainBGPattern:setShaderVector(0, 0, 0, 0, 0)
	GrainBGPattern:setupNineSliceShader(256, 256)
	self:addElement(GrainBGPattern)
	self.GrainBGPattern = GrainBGPattern
	local TriangleBGPattern01 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -582, -114)
	TriangleBGPattern01:setAlpha(0.04)
	TriangleBGPattern01:setImage(RegisterImage(@"uie_ui_menu_cac_grid_pattern_bg01"))
	TriangleBGPattern01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	TriangleBGPattern01:setShaderVector(0, 0, 0, 0, 0)
	TriangleBGPattern01:setupNineSliceShader(256, 256)
	self:addElement(TriangleBGPattern01)
	self.TriangleBGPattern01 = TriangleBGPattern01
	local VerticalBGPattern2 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -618, -582)
	VerticalBGPattern2:setAlpha(0.02)
	VerticalBGPattern2:setImage(RegisterImage(@"uie_ui_menu_cac_vertical_pattern_bg"))
	VerticalBGPattern2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	VerticalBGPattern2:setShaderVector(0, 0, 0, 0, 0)
	VerticalBGPattern2:setupNineSliceShader(256, 256)
	self:addElement(VerticalBGPattern2)
	self.VerticalBGPattern2 = VerticalBGPattern2
	local TopBar = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, 39, 42)
	TopBar:setAlpha(0.2)
	TopBar:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBar)
	self.TopBar = TopBar
	local TopBar2 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, 3, 6)
	TopBar2:setAlpha(0.12)
	TopBar2:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBar2)
	self.TopBar2 = TopBar2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
