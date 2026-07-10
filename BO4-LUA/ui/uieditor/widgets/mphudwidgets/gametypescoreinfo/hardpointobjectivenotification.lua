require("x64:9be650a0062d524")
require("x64:dbca055e95781f8")
CoD.HardpointObjectiveNotification = InheritFrom(LUI.UIElement)
CoD.HardpointObjectiveNotification.__defaultWidth = 60
CoD.HardpointObjectiveNotification.__defaultHeight = 60
CoD.HardpointObjectiveNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HardpointObjectiveNotification)
	self.id = "HardpointObjectiveNotification"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local HardpointTimer = CoD.WaypointRadialTimer.new(f1_arg0, f1_arg1, 0, 0, 0, 60, 0, 0, 0, 60)
	HardpointTimer.WaypointTimerImage:setImage(RegisterImage(0x48ED8422CAFED83))
	HardpointTimer:subscribeToGlobalModel(f1_arg1, "WaypointObjectiveHardpoint", nil, function(model)
		HardpointTimer:setModel(model, f1_arg1)
	end)
	HardpointTimer:subscribeToGlobalModel(f1_arg1, "BombTimer", "bomb0.timeRemainingMilliSec", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HardpointTimer.WaypointTimer:setShaderVector(0, SubtractVectorComponentFrom(1, 1, CoD.HUDUtility.DivideByBombTimeLimit(f1_arg1, 1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))))
		end
	end)
	self:addElement(HardpointTimer)
	self.HardpointTimer = HardpointTimer
	local WaypointTimerCountdown = CoD.WaypointTimerCountdown.new(f1_arg0, f1_arg1, 0.5, 0.5, -16.5, 16.5, 0.5, 0.5, -16.5, 16.5)
	WaypointTimerCountdown:subscribeToGlobalModel(f1_arg1, "BombTimer", "bomb0", function(model)
		WaypointTimerCountdown:setModel(model, f1_arg1)
	end)
	self:addElement(WaypointTimerCountdown)
	self.WaypointTimerCountdown = WaypointTimerCountdown
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HardpointObjectiveNotification.__onClose = function(f5_arg0)
	f5_arg0.HardpointTimer:close()
	f5_arg0.WaypointTimerCountdown:close()
end
