require("x64:8628de2b911edaa")
CoD.VHUD_Turret = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_Turret = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_Turret", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_Turret)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local internal = CoD.vhud_turret_internal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	internal:subscribeToGlobalModel(f1_arg0, "PerController", "vehicle", function(model)
		internal:setModel(model, f1_arg0)
	end)
	self:addElement(internal)
	self.internal = internal
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
CoD.VHUD_Turret.__onClose = function(f3_arg0)
	f3_arg0.internal:close()
end
