require("x64:de9094801b2bcf4")
CoD.TempestReticle_UI3D = InheritFrom(LUI.UIElement)
CoD.TempestReticle_UI3D.__defaultWidth = 450
CoD.TempestReticle_UI3D.__defaultHeight = 300
CoD.TempestReticle_UI3D.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TempestReticle_UI3D)
	self.id = "TempestReticle_UI3D"
	self.soundSet = "default"
	local internal = CoD.TempestReticle_UI3D_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Engine[@"setupui3dwindow"](f1_arg1, 3, 450, 300)
	internal:setUI3DWindow(3)
	self:addElement(internal)
	self.internal = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TempestReticle_UI3D.__onClose = function(f2_arg0)
	f2_arg0.internal:close()
end
