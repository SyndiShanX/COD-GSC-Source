require("x64:ace2f852bdebb88")
CoD.GenericProjectedTablet = InheritFrom(LUI.UIElement)
CoD.GenericProjectedTablet.__defaultWidth = 1080
CoD.GenericProjectedTablet.__defaultHeight = 608
CoD.GenericProjectedTablet.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GenericProjectedTablet)
	self.id = "GenericProjectedTablet"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local GenericProjectedTabletInternal = CoD.GenericProjectedTabletInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Engine[@"setupui3dwindow"](f1_arg1, 1, 1080, 608)
	GenericProjectedTabletInternal:setUI3DWindow(1)
	self:addElement(GenericProjectedTabletInternal)
	self.GenericProjectedTabletInternal = GenericProjectedTabletInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GenericProjectedTablet.__onClose = function(f2_arg0)
	f2_arg0.GenericProjectedTabletInternal:close()
end
