require("x64:15940ad1a20c27c")
CoD.prestigeRewardWidget = InheritFrom(LUI.UIElement)
CoD.prestigeRewardWidget.__defaultWidth = 187
CoD.prestigeRewardWidget.__defaultHeight = 37
CoD.prestigeRewardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.prestigeRewardWidget)
	self.id = "prestigeRewardWidget"
	self.soundSet = "CAC_EditLoadout"
	local internal = CoD.prestigeRewardWidget_UI3D.new(f1_arg0, f1_arg1, 0, 0, 0, 188, 0, 0, 0, 38)
	Engine[@"setupui3dwindow"](f1_arg1, 5, 188, 38)
	internal:setUI3DWindow(5)
	internal:setRGB(0, 0.59, 0.96)
	self:addElement(internal)
	self.internal = internal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.prestigeRewardWidget.__onClose = function(f2_arg0)
	f2_arg0.internal:close()
end
