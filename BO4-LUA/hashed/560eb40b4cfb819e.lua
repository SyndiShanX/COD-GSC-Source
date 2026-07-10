require("x64:633412baa5380b8")
CoD.VHUD_AGR = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_AGR = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_AGR", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_AGR)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local vhudagrinternal0 = CoD.vhud_agr_internal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudagrinternal0:subscribeToGlobalModel(f1_arg0, "PerController", "vehicle", function(model)
		vhudagrinternal0:setModel(model, f1_arg0)
	end)
	self:addElement(vhudagrinternal0)
	self.vhudagrinternal0 = vhudagrinternal0
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
CoD.VHUD_AGR.__onClose = function(f3_arg0)
	f3_arg0.vhudagrinternal0:close()
end
