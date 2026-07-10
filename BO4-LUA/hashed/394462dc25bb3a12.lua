require("x64:d83bfcc93279126")
local PostLoadFunc = function(self, controller)
	self.m_inputDisabled = true
end
CoD.VHUD_MS_Gunner = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_MS_Gunner = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_MS_Gunner", f2_arg0)
	local f2_local1 = self
	self:setClass(CoD.VHUD_MS_Gunner)
	self.soundSet = "default"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local vhudmsGunnerInternal0 = CoD.vhud_ms_GunnerInternal.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudmsGunnerInternal0:subscribeToGlobalModel(f2_arg0, "PerController", "vehicle", function(model)
		vhudmsGunnerInternal0:setModel(model, f2_arg0)
	end)
	self:addElement(vhudmsGunnerInternal0)
	self.vhudmsGunnerInternal0 = vhudmsGunnerInternal0
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.VHUD_MS_Gunner.__onClose = function(f4_arg0)
	f4_arg0.vhudmsGunnerInternal0:close()
end
