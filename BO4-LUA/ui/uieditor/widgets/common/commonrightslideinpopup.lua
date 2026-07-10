require("x64:87edb7802d72c0e")
CoD.CommonRightSlideInPopup = InheritFrom(LUI.UIElement)
CoD.CommonRightSlideInPopup.__defaultWidth = 1920
CoD.CommonRightSlideInPopup.__defaultHeight = 1080
CoD.CommonRightSlideInPopup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonRightSlideInPopup)
	self.id = "CommonRightSlideInPopup"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local BlackfadeBlurB = LUI.UIImage.new(1, 1, -550, 249, 0, 1, -5, 5)
	BlackfadeBlurB:setRGB(0, 0, 0)
	BlackfadeBlurB:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlackfadeBlurB:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlackfadeBlurB)
	self.BlackfadeBlurB = BlackfadeBlurB
	local RightBackground = LUI.UIImage.new(1, 1, -550, 248, 0, 1, 0, 0)
	RightBackground:setRGB(0.09, 0.09, 0.09)
	RightBackground:setAlpha(0.9)
	self:addElement(RightBackground)
	self.RightBackground = RightBackground
	local RightTiledBacking = LUI.UIImage.new(1, 1, -550, 248, 0, 1, 0, 0)
	RightTiledBacking:setAlpha(0.25)
	RightTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	RightTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	RightTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	RightTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(RightTiledBacking)
	self.RightTiledBacking = RightTiledBacking
	local BlackBarBGTop = LUI.UIImage.new(0.31, 0.94, 182, 182, 0, 0, 531, 547)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	BlackBarBGTop:setZRot(90)
	BlackBarBGTop:setScale(1, 0.9)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local alertStatusBar = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0.11, 1.11, 215, 215, 0, 0, 539, 545)
	alertStatusBar:setZRot(90)
	alertStatusBar:setScale(1, 0.56)
	alertStatusBar:linkToElementModel(self, nil, false, function(model)
		alertStatusBar:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar)
	self.alertStatusBar = alertStatusBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonRightSlideInPopup.__onClose = function(f3_arg0)
	f3_arg0.alertStatusBar:close()
end
