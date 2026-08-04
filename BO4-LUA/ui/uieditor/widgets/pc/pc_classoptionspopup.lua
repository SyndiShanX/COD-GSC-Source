require("ui/uieditor/widgets/systemoverlays/systemoverlay_alertstatusbar")
CoD.PC_ClassOptionsPopup = InheritFrom(LUI.UIElement)
CoD.PC_ClassOptionsPopup.__defaultWidth = 800
CoD.PC_ClassOptionsPopup.__defaultHeight = 1090
CoD.PC_ClassOptionsPopup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_ClassOptionsPopup)
	self.id = "PC_ClassOptionsPopup"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local BlackfadeBlurB = LUI.UIImage.new(0.5, 0.5, -400, 400, -0.1, 1.1, -5, 5)
	BlackfadeBlurB:setRGB(0, 0, 0)
	BlackfadeBlurB:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BlackfadeBlurB:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BlackfadeBlurB)
	self.BlackfadeBlurB = BlackfadeBlurB
	local RightBackground = LUI.UIImage.new(0.5, 0.5, -400, 400, -0.1, 1.1, 0, 0)
	RightBackground:setRGB(0.09, 0.09, 0.09)
	RightBackground:setAlpha(0.9)
	self:addElement(RightBackground)
	self.RightBackground = RightBackground
	local RightTiledBacking = LUI.UIImage.new(0.5, 0.5, -400, 400, -0.1, 1.1, 0, 0)
	RightTiledBacking:setAlpha(0.25)
	RightTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	RightTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	RightTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	RightTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(RightTiledBacking)
	self.RightTiledBacking = RightTiledBacking
	local BlackBarBGTopL = LUI.UIImage.new(-0.28, 1.52, -486, -486, 0.5, 0.5, 0, 16)
	BlackBarBGTopL:setRGB(0, 0, 0)
	BlackBarBGTopL:setAlpha(0.85)
	BlackBarBGTopL:setZRot(90)
	BlackBarBGTopL:setScale(1, 0.9)
	self:addElement(BlackBarBGTopL)
	self.BlackBarBGTopL = BlackBarBGTopL
	local alertStatusBarL = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, -0.93, 1.92, -398, -398, 0.5, 0.5, -3, 3)
	alertStatusBarL:setZRot(90)
	alertStatusBarL:setScale(1, 0.56)
	alertStatusBarL:linkToElementModel(self, nil, false, function(model)
		alertStatusBarL:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBarL)
	self.alertStatusBarL = alertStatusBarL
	local BlackBarBGTopR = LUI.UIImage.new(-0.4, 1.4, 391, 391, 0.5, 0.5, 0, 16)
	BlackBarBGTopR:setRGB(0, 0, 0)
	BlackBarBGTopR:setAlpha(0.85)
	BlackBarBGTopR:setZRot(90)
	BlackBarBGTopR:setScale(1, 0.9)
	self:addElement(BlackBarBGTopR)
	self.BlackBarBGTopR = BlackBarBGTopR
	local alertStatusBarR = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, -0.93, 1.92, 398, 398, 0.5, 0.5, -3, 3)
	alertStatusBarR:setYRot(180)
	alertStatusBarR:setZRot(90)
	alertStatusBarR:setScale(1, 0.56)
	alertStatusBarR:linkToElementModel(self, nil, false, function(model)
		alertStatusBarR:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBarR)
	self.alertStatusBarR = alertStatusBarR
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_ClassOptionsPopup.__onClose = function(f4_arg0)
	f4_arg0.alertStatusBarL:close()
	f4_arg0.alertStatusBarR:close()
end
