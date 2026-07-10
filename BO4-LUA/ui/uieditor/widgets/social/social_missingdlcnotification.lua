require("x64:22394f0b69871b4")
CoD.Social_MissingDLCNotification = InheritFrom(LUI.UIElement)
CoD.Social_MissingDLCNotification.__defaultWidth = 40
CoD.Social_MissingDLCNotification.__defaultHeight = 40
CoD.Social_MissingDLCNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_MissingDLCNotification)
	self.id = "Social_MissingDLCNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local SocialMissingDLCNotificationInternal = CoD.Social_MissingDLCNotification_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 0, 0, 0, 40)
	SocialMissingDLCNotificationInternal:linkToElementModel(self, nil, false, function(model)
		SocialMissingDLCNotificationInternal:setModel(model, f1_arg1)
	end)
	self:addElement(SocialMissingDLCNotificationInternal)
	self.SocialMissingDLCNotificationInternal = SocialMissingDLCNotificationInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_MissingDLCNotification.__onClose = function(f3_arg0)
	f3_arg0.SocialMissingDLCNotificationInternal:close()
end
