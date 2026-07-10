require("x64:d7ba7c36104672")
require("x64:ee57f1194687f12")
require("x64:afc19d5a265543e")
require("x64:87edb7802d72c0e")
CoD.CACFullPopupBackground = InheritFrom(LUI.UIElement)
CoD.CACFullPopupBackground.__defaultWidth = 1920
CoD.CACFullPopupBackground.__defaultHeight = 1080
CoD.CACFullPopupBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CACFullPopupBackground)
	self.id = "CACFullPopupBackground"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local BlackBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBG:setRGB(0, 0, 0)
	BlackBG:setAlpha(0.9)
	self:addElement(BlackBG)
	self.BlackBG = BlackBG
	local blur = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 295, 813)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 295, 814)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.7)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.09, 0.09, 199, 718)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local CategoryListLineTopBottom0 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 799, 811)
	CategoryListLineTopBottom0:setRGB(0.9, 0.9, 0.9)
	CategoryListLineTopBottom0:setAlpha(0)
	CategoryListLineTopBottom0:setImage(RegisterImage(@"uie_t7_menu_cac_tabline"))
	self:addElement(CategoryListLineTopBottom0)
	self.CategoryListLineTopBottom0 = CategoryListLineTopBottom0
	local CategoryListLineTopTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 196, 208)
	CategoryListLineTopTop:setRGB(0.9, 0.9, 0.9)
	CategoryListLineTopTop:setAlpha(0)
	CategoryListLineTopTop:setImage(RegisterImage(@"uie_t7_menu_cac_tabline"))
	self:addElement(CategoryListLineTopTop)
	self.CategoryListLineTopTop = CategoryListLineTopTop
	local CategoryListLineTopBottom = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 289, 301)
	CategoryListLineTopBottom:setRGB(0.9, 0.9, 0.9)
	CategoryListLineTopBottom:setImage(RegisterImage(@"uie_t7_menu_cac_tabline"))
	self:addElement(CategoryListLineTopBottom)
	self.CategoryListLineTopBottom = CategoryListLineTopBottom
	local CategoryListLineBottomBottom = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 872, 884)
	CategoryListLineBottomBottom:setRGB(0.9, 0.9, 0.9)
	CategoryListLineBottomBottom:setAlpha(0)
	CategoryListLineBottomBottom:setImage(RegisterImage(@"uie_t7_menu_cac_tabline"))
	self:addElement(CategoryListLineBottomBottom)
	self.CategoryListLineBottomBottom = CategoryListLineBottomBottom
	local CategoryListLineBottomTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 801, 813)
	CategoryListLineBottomTop:setRGB(0.9, 0.9, 0.9)
	CategoryListLineBottomTop:setAlpha(0)
	CategoryListLineBottomTop:setImage(RegisterImage(@"uie_t7_menu_cac_tabline"))
	self:addElement(CategoryListLineBottomTop)
	self.CategoryListLineBottomTop = CategoryListLineBottomTop
	local scorestreakVignetteContainer = CoD.scorestreakVignetteContainer.new(f1_arg0, f1_arg1, 0, 1, 4, 0, 0, 1, 0, 0)
	scorestreakVignetteContainer:setAlpha(0)
	self:addElement(scorestreakVignetteContainer)
	self.scorestreakVignetteContainer = scorestreakVignetteContainer
	local FEButtonPanel = CoD.FE_ButtonPanelShader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 201, -227)
	FEButtonPanel:setRGB(0.5, 0.5, 0.5)
	FEButtonPanel:setAlpha(0)
	FEButtonPanel:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"uie_scene_blur_pass_2_highquality"))
	FEButtonPanel:setShaderVector(0, 30, 10, 0, 0)
	self:addElement(FEButtonPanel)
	self.FEButtonPanel = FEButtonPanel
	local topBar = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 271, 285)
	topBar:setRGB(0, 0, 0)
	topBar:setAlpha(0.5)
	self:addElement(topBar)
	self.topBar = topBar
	local bottomBar = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 824, 874)
	bottomBar:setRGB(0, 0, 0)
	bottomBar:setAlpha(0.5)
	self:addElement(bottomBar)
	self.bottomBar = bottomBar
	local BlackBarBGTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 291, 307)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local BlackBarBGBtm = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 800, 816)
	BlackBarBGBtm:setRGB(0, 0, 0)
	BlackBarBGBtm:setAlpha(0.85)
	self:addElement(BlackBarBGBtm)
	self.BlackBarBGBtm = BlackBarBGBtm
	local alertStatusBar2 = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 810, 817)
	alertStatusBar2:linkToElementModel(self, nil, false, function(model)
		alertStatusBar2:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar2)
	self.alertStatusBar2 = alertStatusBar2
	local alertStatusBar = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 292, 299)
	alertStatusBar:linkToElementModel(self, nil, false, function(model)
		alertStatusBar:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar)
	self.alertStatusBar = alertStatusBar
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0.5, 0.5, -440, 208, 0, 0, 753, 801)
	buttons:linkToElementModel(self, nil, false, function(model)
		buttons:setModel(model, f1_arg1)
	end)
	self:addElement(buttons)
	self.buttons = buttons
	if CoD.isPC then
		buttons.id = "buttons"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CACFullPopupBackground.__onClose = function(f5_arg0)
	f5_arg0.scorestreakVignetteContainer:close()
	f5_arg0.FEButtonPanel:close()
	f5_arg0.alertStatusBar2:close()
	f5_arg0.alertStatusBar:close()
	f5_arg0.buttons:close()
end
