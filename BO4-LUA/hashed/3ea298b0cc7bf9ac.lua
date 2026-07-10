require("x64:e95c2762ac5b4eb")
CoD.VHUD_Attack_Helicopter = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_Attack_Helicopter = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_Attack_Helicopter", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_Attack_Helicopter)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local internal = CoD.vhud_attack_helicopter_internal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	internal:linkToElementModel(self, nil, false, function(model)
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
CoD.VHUD_Attack_Helicopter.__onClose = function(f3_arg0)
	f3_arg0.internal:close()
end
