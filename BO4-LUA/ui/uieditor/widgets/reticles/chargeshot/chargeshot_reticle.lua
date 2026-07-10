require("x64:ea851187c83fb56")
CoD.ChargeShot_reticle = InheritFrom(LUI.UIElement)
CoD.ChargeShot_reticle.__defaultWidth = 900
CoD.ChargeShot_reticle.__defaultHeight = 900
CoD.ChargeShot_reticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChargeShot_reticle)
	self.id = "ChargeShot_reticle"
	self.soundSet = "ChooseDecal"
	local ui3d = CoD.ChargeShot_reticle_ui3d.new(f1_arg0, f1_arg1, 0.5, 0.5, -524, 524, 0.5, 0.5, -444, 442)
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 3, 1048, 886)
	ui3d:setUI3DWindow(3)
	ui3d:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", nil, function(model)
		ui3d:setModel(model, f1_arg1)
	end)
	self:addElement(ui3d)
	self.ui3d = ui3d
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChargeShot_reticle.__onClose = function(f3_arg0)
	f3_arg0.ui3d:close()
end
