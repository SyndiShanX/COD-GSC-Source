require("x64:d24e4a6046a91b2")
CoD.VHUDHawkHealth = InheritFrom(LUI.UIElement)
CoD.VHUDHawkHealth.__defaultWidth = 353
CoD.VHUDHawkHealth.__defaultHeight = 180
CoD.VHUDHawkHealth.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VHUDHawkHealth)
	self.id = "VHUDHawkHealth"
	self.soundSet = "default"
	local vhudmsTimebar = CoD.vhud_ms_Timebar.new(f1_arg0, f1_arg1, 1, 1, -350, 0, 0, 0, 160, 173)
	vhudmsTimebar:linkToElementModel(self, nil, false, function(model)
		vhudmsTimebar:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsTimebar)
	self.vhudmsTimebar = vhudmsTimebar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.VHUDHawkHealth.__onClose = function(f3_arg0)
	f3_arg0.vhudmsTimebar:close()
end
