require("x64:40fb87726621244")
CoD.Rejack = InheritFrom(LUI.UIElement)
CoD.Rejack.__defaultWidth = 900
CoD.Rejack.__defaultHeight = 450
CoD.Rejack.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Rejack)
	self.id = "Rejack"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local RejackInternal = CoD.RejackInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Engine[@"setupui3dwindow"](f1_arg1, 4, 900, 450)
	RejackInternal:setUI3DWindow(4)
	self:addElement(RejackInternal)
	self.RejackInternal = RejackInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Rejack.__onClose = function(f2_arg0)
	f2_arg0.RejackInternal:close()
end
