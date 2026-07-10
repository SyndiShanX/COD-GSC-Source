require("x64:473d4ee043e01af")
CoD.lmgInfiniteReticle = InheritFrom(LUI.UIElement)
CoD.lmgInfiniteReticle.__defaultWidth = 324
CoD.lmgInfiniteReticle.__defaultHeight = 139
CoD.lmgInfiniteReticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.lmgInfiniteReticle)
	self.id = "lmgInfiniteReticle"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local lmgInfiniteReticleUI3D = CoD.lmgInfiniteReticle_UI3D.new(f1_arg0, f1_arg1, 0, 0, 2, 324, 0, 0, 0, 140)
	lmgInfiniteReticleUI3D:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", nil, function(model)
		lmgInfiniteReticleUI3D:setModel(model, f1_arg1)
	end)
	self:addElement(lmgInfiniteReticleUI3D)
	self.lmgInfiniteReticleUI3D = lmgInfiniteReticleUI3D
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.lmgInfiniteReticle.__onClose = function(f3_arg0)
	f3_arg0.lmgInfiniteReticleUI3D:close()
end
