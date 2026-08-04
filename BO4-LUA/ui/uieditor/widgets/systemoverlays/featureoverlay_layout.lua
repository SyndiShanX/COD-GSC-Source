require("ui/uieditor/widgets/systemoverlays/featureoverlay_framevlayout")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_alertstatusbar")
CoD.featureOverlay_Layout = InheritFrom(LUI.UIElement)
CoD.featureOverlay_Layout.__defaultWidth = 1920
CoD.featureOverlay_Layout.__defaultHeight = 1080
CoD.featureOverlay_Layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.featureOverlay_Layout)
	self.id = "featureOverlay_Layout"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0, 0, 0)
	background:setAlpha(0.85)
	self:addElement(background)
	self.background = background
	local blackbkg = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 222, 920)
	blackbkg:setAlpha(0.8)
	blackbkg:setImage(RegisterImage("uie_ui_icon_master_overlays_bkg"))
	self:addElement(blackbkg)
	self.blackbkg = blackbkg
	local vlayout = CoD.featureOverlay_frameVLayout.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 222, 972)
	vlayout:linkToElementModel(self, nil, false, function(model)
		vlayout:setModel(model, f1_arg1)
	end)
	self:addElement(vlayout)
	self.vlayout = vlayout
	local alertStatusBar = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 216, 222)
	alertStatusBar:linkToElementModel(self, nil, false, function(model)
		alertStatusBar:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar)
	self.alertStatusBar = alertStatusBar
	vlayout.id = "vlayout"
	self.__defaultFocus = vlayout
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.featureOverlay_Layout.__onClose = function(f4_arg0)
	f4_arg0.vlayout:close()
	f4_arg0.alertStatusBar:close()
end
