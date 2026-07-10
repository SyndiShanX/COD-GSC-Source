CoD.HealthBoostNotificationContainer = InheritFrom(LUI.UIElement)
CoD.HealthBoostNotificationContainer.__defaultWidth = 64
CoD.HealthBoostNotificationContainer.__defaultHeight = 26
CoD.HealthBoostNotificationContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBoostNotificationContainer)
	self.id = "HealthBoostNotificationContainer"
	self.soundSet = "none"
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
