CoD.ObjectiveInfoWidgetContainer = InheritFrom(LUI.UIElement)
CoD.ObjectiveInfoWidgetContainer.__defaultWidth = 430
CoD.ObjectiveInfoWidgetContainer.__defaultHeight = 1080
CoD.ObjectiveInfoWidgetContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.ObjectiveInfoWidgetContainer)
	self.id = "ObjectiveInfoWidgetContainer"
	self.soundSet = "HUD"
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local1 = self
	SetupDynamicContainer(self)
	return self
end
