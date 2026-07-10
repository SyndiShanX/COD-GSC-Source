require("x64:7ec83d585bc77b3")
CoD.TabletLocationSelector = InheritFrom(LUI.UIElement)
CoD.TabletLocationSelector.__defaultWidth = 1140
CoD.TabletLocationSelector.__defaultHeight = 740
CoD.TabletLocationSelector.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletLocationSelector)
	self.id = "TabletLocationSelector"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local internal = CoD.TabletLocationSelector_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.07, 0.93, 55, 55)
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 1, 1140, 740)
	internal:setUI3DWindow(1)
	self:addElement(internal)
	self.internal = internal
	internal.id = "internal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletLocationSelector.__onClose = function(f2_arg0)
	f2_arg0.internal:close()
end
