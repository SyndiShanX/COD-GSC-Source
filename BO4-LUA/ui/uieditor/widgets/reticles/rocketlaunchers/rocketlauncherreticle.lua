require("x64:5412ea4a44b3d66")
CoD.rocketLauncherReticle = InheritFrom(LUI.UIElement)
CoD.rocketLauncherReticle.__defaultWidth = 150
CoD.rocketLauncherReticle.__defaultHeight = 150
CoD.rocketLauncherReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.HUDUtility.SetUpReticle(self, f1_arg1)
	self:setClass(CoD.rocketLauncherReticle)
	self.id = "rocketLauncherReticle"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local rocketLauncherReticleUI3D0 = CoD.rocketLauncherReticle_UI3D.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 0, 0, 0, 300)
	self:addElement(rocketLauncherReticleUI3D0)
	self.rocketLauncherReticleUI3D0 = rocketLauncherReticleUI3D0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.rocketLauncherReticle.__onClose = function(f2_arg0)
	f2_arg0.rocketLauncherReticleUI3D0:close()
end
