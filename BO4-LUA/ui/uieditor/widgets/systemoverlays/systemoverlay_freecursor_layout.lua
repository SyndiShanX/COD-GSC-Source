require("x64:d7ba7c36104672")
require("x64:87edb7802d72c0e")
require("x64:4e92c2d8034b243")
CoD.systemOverlay_FreeCursor_Layout = InheritFrom(LUI.UIElement)
CoD.systemOverlay_FreeCursor_Layout.__defaultWidth = 1920
CoD.systemOverlay_FreeCursor_Layout.__defaultHeight = 1080
CoD.systemOverlay_FreeCursor_Layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_FreeCursor_Layout)
	self.id = "systemOverlay_FreeCursor_Layout"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0, 0, 0)
	background:setAlpha(0.94)
	self:addElement(background)
	self.background = background
	local blur = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -263, 42)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -270, 35)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.94)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -263, 38)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BlackBarBGBtm = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, 25, 41)
	BlackBarBGBtm:setRGB(0, 0, 0)
	BlackBarBGBtm:setAlpha(0.85)
	self:addElement(BlackBarBGBtm)
	self.BlackBarBGBtm = BlackBarBGBtm
	local BlackBarBGTop = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -269, -253)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local alertStatusBar2 = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, 36, 43)
	alertStatusBar2:linkToElementModel(self, nil, false, function(model)
		alertStatusBar2:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar2)
	self.alertStatusBar2 = alertStatusBar2
	local alertStatusBar3 = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -270, -263)
	alertStatusBar3:linkToElementModel(self, nil, false, function(model)
		alertStatusBar3:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar3)
	self.alertStatusBar3 = alertStatusBar3
	local frameWidget = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	frameWidget:setLeftRight(0.5, 0.5, -960, 960)
	frameWidget:setTopBottom(0.5, 0.5, -264, 26)
	frameWidget:linkToElementModel(self, nil, false, function(model)
		frameWidget:setModel(model, f1_arg1)
	end)
	frameWidget:linkToElementModel(self, "frameWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			frameWidget:changeFrameWidget(f5_local0)
		end
	end)
	self:addElement(frameWidget)
	self.frameWidget = frameWidget
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0.5, 0.5, -348, 300, 0.5, 0.5, -15, 33)
	self:addElement(buttons)
	self.buttons = buttons
	frameWidget.id = "frameWidget"
	if CoD.isPC then
		buttons.id = "buttons"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_FreeCursor_Layout.__onClose = function(f6_arg0)
	f6_arg0.alertStatusBar2:close()
	f6_arg0.alertStatusBar3:close()
	f6_arg0.frameWidget:close()
	f6_arg0.buttons:close()
end
