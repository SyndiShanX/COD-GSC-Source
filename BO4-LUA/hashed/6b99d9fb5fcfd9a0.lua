require("x64:a693da86360e253")
CoD.VHUD_Sentinel = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_Sentinel = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_Sentinel", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_Sentinel)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local VHUDSentinelInternal = CoD.VHUD_Sentinel_Internal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	VHUDSentinelInternal:subscribeToGlobalModel(f1_arg0, "PerController", "vehicle", function(model)
		VHUDSentinelInternal:setModel(model, f1_arg0)
	end)
	self:addElement(VHUDSentinelInternal)
	self.VHUDSentinelInternal = VHUDSentinelInternal
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
CoD.VHUD_Sentinel.__onClose = function(f3_arg0)
	f3_arg0.VHUDSentinelInternal:close()
end
