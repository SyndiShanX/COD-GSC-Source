require("x64:6265b1592d6654f")
CoD.MagnifierReticle_UI3D = InheritFrom(LUI.UIElement)
CoD.MagnifierReticle_UI3D.__defaultWidth = 600
CoD.MagnifierReticle_UI3D.__defaultHeight = 600
CoD.MagnifierReticle_UI3D.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MagnifierReticle_UI3D)
	self.id = "MagnifierReticle_UI3D"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local MagnifierReticleInternal = CoD.MagnifierReticle_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Engine[@"setupui3dwindow"](f1_arg1, 3, 600, 600)
	MagnifierReticleInternal:setUI3DWindow(3)
	MagnifierReticleInternal:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", nil, function(model)
		MagnifierReticleInternal:setModel(model, f1_arg1)
	end)
	self:addElement(MagnifierReticleInternal)
	self.MagnifierReticleInternal = MagnifierReticleInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MagnifierReticle_UI3D.__onClose = function(f3_arg0)
	f3_arg0.MagnifierReticleInternal:close()
end
