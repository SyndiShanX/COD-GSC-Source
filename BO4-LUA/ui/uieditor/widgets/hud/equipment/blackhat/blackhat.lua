require("x64:a9cddc555b77202")
CoD.BlackHat = InheritFrom(LUI.UIElement)
CoD.BlackHat.__defaultWidth = 384
CoD.BlackHat.__defaultHeight = 384
CoD.BlackHat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BlackHat)
	self.id = "BlackHat"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local internal = CoD.BlackHat_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 0, 384, 384)
	internal:setUI3DWindow(0)
	self:addElement(internal)
	self.internal = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BlackHat.__onClose = function(f2_arg0)
	f2_arg0.internal:close()
end
