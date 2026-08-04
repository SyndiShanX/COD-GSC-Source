require("ui/uieditor/widgets/mphudwidgets/gametypescoreinfo/waypointtimercountdown")
CoD.WaypointIconTimer = InheritFrom(LUI.UIElement)
CoD.WaypointIconTimer.__defaultWidth = 96
CoD.WaypointIconTimer.__defaultHeight = 96
CoD.WaypointIconTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointIconTimer)
	self.id = "WaypointIconTimer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local waypointCenterImageDarkClock = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	waypointCenterImageDarkClock:setImage(RegisterImage("t7_hud_waypoints_neutral_new"))
	waypointCenterImageDarkClock:setMaterial(LUI.UIImage.GetCachedMaterial("uie_clock_normal"))
	waypointCenterImageDarkClock:setShaderVector(1, 0.5, 0, 0, 0)
	waypointCenterImageDarkClock:setShaderVector(2, 0.5, 0, 0, 0)
	waypointCenterImageDarkClock:setShaderVector(3, 0, 0, 0, 0)
	waypointCenterImageDarkClock:setShaderVector(4, 0, 0, 0, 0)
	waypointCenterImageDarkClock:linkToElementModel(self, "timeRemainingMilliSec", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			waypointCenterImageDarkClock:setShaderVector(0, SubtractVectorComponentFrom(1, 1, CoD.HUDUtility.DivideByBombTimeLimit(f1_arg1, 1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))))
		end
	end)
	self:addElement(waypointCenterImageDarkClock)
	self.waypointCenterImageDarkClock = waypointCenterImageDarkClock
	local WaypointTimerCountdown = CoD.WaypointTimerCountdown.new(f1_arg0, f1_arg1, 0.25, 0.75, 0, 0, 0.25, 0.75, 0, 0)
	WaypointTimerCountdown:linkToElementModel(self, nil, false, function(model)
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
CoD.WaypointIconTimer.__onClose = function(f4_arg0)
	f4_arg0.waypointCenterImageDarkClock:close()
	f4_arg0.WaypointTimerCountdown:close()
end
