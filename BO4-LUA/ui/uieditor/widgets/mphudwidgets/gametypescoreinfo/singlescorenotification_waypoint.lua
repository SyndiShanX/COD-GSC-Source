require("x64:6c3c8e6b1823b97")
CoD.SingleScoreNotification_Waypoint = InheritFrom(LUI.UIElement)
CoD.SingleScoreNotification_Waypoint.__defaultWidth = 328
CoD.SingleScoreNotification_Waypoint.__defaultHeight = 60
CoD.SingleScoreNotification_Waypoint.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SingleScoreNotification_Waypoint)
	self.id = "SingleScoreNotification_Waypoint"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local WaypointList = LUI.UIList.new(f1_arg0, f1_arg1, -18, 0, nil, false, false, false, false)
	WaypointList:setLeftRight(0, 0, 0, 328)
	WaypointList:setTopBottom(0, 0, -9, 69)
	WaypointList:setWidgetType(CoD.ScoreNotificationWaypoint)
	WaypointList:setHorizontalCount(5)
	WaypointList:setSpacing(-18)
	WaypointList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	WaypointList:setDataSource("WaypointObjectiveList")
	LUI.OverrideFunction_CallOriginalFirst(WaypointList, "setWidth", function(element, controller)
		ScaleToElementWidth(self, element, 0)
		DispatchEventToParent(element, "update_scale", f1_arg1)
	end)
	self:addElement(WaypointList)
	self.WaypointList = WaypointList
	WaypointList.id = "WaypointList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SingleScoreNotification_Waypoint.__onClose = function(f3_arg0)
	f3_arg0.WaypointList:close()
end
