require("x64:9c7ca07e64b6632")
CoD.VHUD_AI_Tank = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_AI_Tank = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_AI_Tank", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_AI_Tank)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local vhud_ai_tank_internal = CoD.vhud_ai_tank_internal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	vhud_ai_tank_internal:subscribeToGlobalModel(f1_arg0, "PerController", "vehicle", function(model)
		vhud_ai_tank_internal:setModel(model, f1_arg0)
	end)
	self:addElement(vhud_ai_tank_internal)
	self.vhud_ai_tank_internal = vhud_ai_tank_internal
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
CoD.VHUD_AI_Tank.__onClose = function(f3_arg0)
	f3_arg0.vhud_ai_tank_internal:close()
end
