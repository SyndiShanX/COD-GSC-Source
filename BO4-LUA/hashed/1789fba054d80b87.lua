require("x64:66068e99240fb5a")
CoD.VHUD_Tank_Robot = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_Tank_Robot = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_Tank_Robot", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_Tank_Robot)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local vhudtankrobotinternal = CoD.vhud_tank_robot_internal.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	vhudtankrobotinternal:subscribeToGlobalModel(f1_arg0, "PerController", "vehicle", function(model)
		vhudtankrobotinternal:setModel(model, f1_arg0)
	end)
	self:addElement(vhudtankrobotinternal)
	self.vhudtankrobotinternal = vhudtankrobotinternal
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
CoD.VHUD_Tank_Robot.__onClose = function(f3_arg0)
	f3_arg0.vhudtankrobotinternal:close()
end
