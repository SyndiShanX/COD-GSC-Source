require("x64:2f48341d0fd505e")
CoD.VHUDHawk = InheritFrom(CoD.Menu)
LUI.createMenu.VHUDHawk = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUDHawk", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUDHawk)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local Internal = CoD.VHUDHawkInternal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	Internal:subscribeToGlobalModel(f1_arg0, "PerController", "vehicle", function(model)
		Internal:setModel(model, f1_arg0)
	end)
	self:addElement(Internal)
	self.Internal = Internal
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.VHUDHawk.__onClose = function(f3_arg0)
	f3_arg0.Internal:close()
end
