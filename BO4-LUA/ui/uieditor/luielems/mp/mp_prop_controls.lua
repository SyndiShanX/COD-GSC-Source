require("x64:7574986257eb14e")
LUI.hudMenuType.mp_prop_controls = "hud"
CoD.mp_prop_controls = InheritFrom(CoD.Menu)
LUI.createMenu.mp_prop_controls = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("mp_prop_controls", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.mp_prop_controls)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local MPPropControlsSafeAreaContainer = CoD.MPPropControlsSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(MPPropControlsSafeAreaContainer)
	self.MPPropControlsSafeAreaContainer = MPPropControlsSafeAreaContainer
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	SetElementPriority(self, -1)
	return self
end
CoD.mp_prop_controls.__onClose = function(f2_arg0)
	f2_arg0.MPPropControlsSafeAreaContainer:close()
end
