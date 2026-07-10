require("x64:d79c542bbf36987")
CoD.WaypointCapturedPercentMessageContainer = InheritFrom(LUI.UIElement)
CoD.WaypointCapturedPercentMessageContainer.__defaultWidth = 610
CoD.WaypointCapturedPercentMessageContainer.__defaultHeight = 27
CoD.WaypointCapturedPercentMessageContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointCapturedPercentMessageContainer)
	self.id = "WaypointCapturedPercentMessageContainer"
	self.soundSet = "default"
	local Percentage = CoD.WaypointCapturedPercentMessage.new(f1_arg0, f1_arg1, 0.5, 0.5, -305, 305, 0.5, 0.5, -13.5, 13.5)
	Percentage:linkToElementModel(self, nil, false, function(model)
		Percentage:setModel(model, f1_arg1)
	end)
	self:addElement(Percentage)
	self.Percentage = Percentage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointCapturedPercentMessageContainer.__onClose = function(f3_arg0)
	f3_arg0.Percentage:close()
end
