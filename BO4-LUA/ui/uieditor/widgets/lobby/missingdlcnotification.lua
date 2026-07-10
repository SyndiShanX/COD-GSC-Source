require("x64:b818d70090d42bb")
CoD.MissingDLCNotification = InheritFrom(LUI.UIElement)
CoD.MissingDLCNotification.__defaultWidth = 384
CoD.MissingDLCNotification.__defaultHeight = 50
CoD.MissingDLCNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MissingDLCNotification)
	self.id = "MissingDLCNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local MissingDLCNotificationInternal = CoD.MissingDLCNotification_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 0, 50)
	MissingDLCNotificationInternal:linkToElementModel(self, nil, false, function(model)
		MissingDLCNotificationInternal:setModel(model, f1_arg1)
	end)
	self:addElement(MissingDLCNotificationInternal)
	self.MissingDLCNotificationInternal = MissingDLCNotificationInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MissingDLCNotification.__onClose = function(f3_arg0)
	f3_arg0.MissingDLCNotificationInternal:close()
end
