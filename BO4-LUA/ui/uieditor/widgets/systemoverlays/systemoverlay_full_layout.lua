require("x64:d7ba7c36104672")
require("x64:87edb7802d72c0e")
require("x64:68279aab0622ac8")
CoD.systemOverlay_Full_Layout = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Full_Layout.__defaultWidth = 1920
CoD.systemOverlay_Full_Layout.__defaultHeight = 1080
CoD.systemOverlay_Full_Layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Full_Layout)
	self.id = "systemOverlay_Full_Layout"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -247.5, 247.5)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local darkbg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	darkbg:setRGB(0, 0, 0)
	darkbg:setAlpha(0.9)
	self:addElement(darkbg)
	self.darkbg = darkbg
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -247.5, 247.5)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.7)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -247.5, 247.5)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BlackBarBGBtm = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, 229, 245)
	BlackBarBGBtm:setRGB(0, 0, 0)
	BlackBarBGBtm:setAlpha(0.85)
	self:addElement(BlackBarBGBtm)
	self.BlackBarBGBtm = BlackBarBGBtm
	local BlackBarBGTop = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -245, -229)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local alertStatusBar = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -246, -240)
	alertStatusBar:linkToElementModel(self, nil, false, function(model)
		alertStatusBar:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar)
	self.alertStatusBar = alertStatusBar
	local alertStatusBar2 = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, 239, 245)
	alertStatusBar2:linkToElementModel(self, nil, false, function(model)
		alertStatusBar2:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar2)
	self.alertStatusBar2 = alertStatusBar2
	local frameWidget = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	frameWidget:setLeftRight(0, 1, 0, 0)
	frameWidget:setTopBottom(0.5, 0.5, -229, 229)
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
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0, 0, 614, 1262, 1, 1, -367, -319)
	self:addElement(buttons)
	self.buttons = buttons
	self:mergeStateConditions({
		{
			stateName = "isPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	frameWidget.id = "frameWidget"
	if CoD.isPC then
		buttons.id = "buttons"
	end
	self.__defaultFocus = frameWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_Full_Layout.__resetProperties = function(f7_arg0)
	f7_arg0.buttons:completeAnimation()
	f7_arg0.buttons:setAlpha(1)
end
CoD.systemOverlay_Full_Layout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	isPC = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.buttons:completeAnimation()
			f9_arg0.buttons:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.buttons)
		end,
	},
}
CoD.systemOverlay_Full_Layout.__onClose = function(f10_arg0)
	f10_arg0.alertStatusBar:close()
	f10_arg0.alertStatusBar2:close()
	f10_arg0.frameWidget:close()
	f10_arg0.buttons:close()
end
