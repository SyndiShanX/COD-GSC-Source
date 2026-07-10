require("x64:8fff0bee99d54df")
CoD.LauncherMultiReticle = InheritFrom(LUI.UIElement)
CoD.LauncherMultiReticle.__defaultWidth = 150
CoD.LauncherMultiReticle.__defaultHeight = 150
CoD.LauncherMultiReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LauncherMultiReticle)
	self.id = "LauncherMultiReticle"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local LauncherMultiReticleUI3D = CoD.LauncherMultiReticle_UI3D.new(f1_arg0, f1_arg1, 0, 0, 0, 300, 0, 0, 0, 300)
	self:addElement(LauncherMultiReticleUI3D)
	self.LauncherMultiReticleUI3D = LauncherMultiReticleUI3D
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LauncherMultiReticle.__onClose = function(f2_arg0)
	f2_arg0.LauncherMultiReticleUI3D:close()
end
