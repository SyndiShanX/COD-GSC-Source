CoD.CommonHeaderBG = InheritFrom(LUI.UIElement)
CoD.CommonHeaderBG.__defaultWidth = 2304
CoD.CommonHeaderBG.__defaultHeight = 73
CoD.CommonHeaderBG.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonHeaderBG)
	self.id = "CommonHeaderBG"
	self.soundSet = "default"
	local BGSceneBlur = LUI.UIImage.new(-0.1, 1.1, 230.5, 230.5, 0, 0, 0, 73)
	BGSceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BGSceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGSceneBlur)
	self.BGSceneBlur = BGSceneBlur
	local background2 = LUI.UIImage.new(-0.1, 1.1, 230.5, 230.5, 0, 0, 0, 73)
	background2:setRGB(0, 0, 0)
	background2:setAlpha(0.2)
	self:addElement(background2)
	self.background2 = background2
	local background1 = LUI.UIImage.new(-0.1, 1.1, 230.5, 230.5, 0, 0, 0, 67)
	background1:setRGB(0, 0, 0)
	background1:setAlpha(0.2)
	self:addElement(background1)
	self.background1 = background1
	local PixelGrid = LUI.UIImage.new(0, 0, 0, 2304, 0, 0, 25, 67)
	PixelGrid:setAlpha(0.5)
	PixelGrid:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(64, 64)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local TopBar = LUI.UIImage.new(0.5, 0.5, -1152, 1152, 0, 0, 24.5, 27.5)
	TopBar:setAlpha(0.2)
	TopBar:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBar)
	self.TopBar = TopBar
	local TopBar2 = LUI.UIImage.new(0.5, 0.5, -1152, 1152, 0, 0, 65, 68)
	TopBar2:setRGB(0.27, 0.27, 0.3)
	TopBar2:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	TopBar2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(TopBar2)
	self.TopBar2 = TopBar2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
