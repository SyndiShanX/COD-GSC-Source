require("x64:25e7124ace30a3d")
CoD.prestigeRewardWidget_v2 = InheritFrom(LUI.UIElement)
CoD.prestigeRewardWidget_v2.__defaultWidth = 229
CoD.prestigeRewardWidget_v2.__defaultHeight = 37
CoD.prestigeRewardWidget_v2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.prestigeRewardWidget_v2)
	self.id = "prestigeRewardWidget_v2"
	self.soundSet = "CAC_EditLoadout"
	local internal = CoD.prestigeRewardWidget_UI3D_v2.new(f1_arg0, f1_arg1, 0, 0, 0, 230, 0, 0, 0, 38)
	Engine[@"setupui3dwindow"](f1_arg1, 5, 230, 38)
	internal:setUI3DWindow(5)
	internal:setRGB(0.78, 0.99, 0.99)
	self:addElement(internal)
	self.internal = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.prestigeRewardWidget_v2.__onClose = function(f2_arg0)
	f2_arg0.internal:close()
end
