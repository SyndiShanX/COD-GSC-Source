require("x64:d210adadabcfe9f")
CoD.FullScreenSpinner = InheritFrom(CoD.Menu)
LUI.createMenu.FullScreenSpinner = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FullScreenSpinner", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.FullScreenSpinner)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0, 0, 0)
	self:addElement(BG)
	self.BG = BG
	local AnimationLoadingWidget = CoD.AnimationLoadingWidget.new(f1_local1, f1_arg0, 1, 1, -282, -66, 1, 1, -270, -54)
	AnimationLoadingWidget:setScale(0.65, 0.65)
	self:addElement(AnimationLoadingWidget)
	self.AnimationLoadingWidget = AnimationLoadingWidget
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local4 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.FullScreenSpinner.__onClose = function(f2_arg0)
	f2_arg0.AnimationLoadingWidget:close()
end
