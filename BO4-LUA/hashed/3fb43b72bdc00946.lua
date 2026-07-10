require("x64:56e8c38e3407db2")
CoD.SwipeTak5 = InheritFrom(LUI.UIElement)
CoD.SwipeTak5.__defaultWidth = 750
CoD.SwipeTak5.__defaultHeight = 450
CoD.SwipeTak5.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SwipeTak5)
	self.id = "SwipeTak5"
	self.soundSet = "none"
	Engine[@"setupui3dwindow"](f1_arg1, 3, 750, 450)
	self:setUI3DWindow(3)
	self.anyChildUsesUpdateState = true
	local SwipeTak5Internal = CoD.SwipeTak5_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 750, 0, 0, 0, 450)
	self:addElement(SwipeTak5Internal)
	self.SwipeTak5Internal = SwipeTak5Internal
	SwipeTak5Internal.id = "SwipeTak5Internal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SwipeTak5.__onClose = function(f2_arg0)
	f2_arg0.SwipeTak5Internal:close()
end
