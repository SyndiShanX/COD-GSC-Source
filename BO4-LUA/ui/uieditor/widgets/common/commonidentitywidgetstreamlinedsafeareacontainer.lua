require("ui/uieditor/widgets/common/commonidentitywidgetstreamlined")
CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.__defaultWidth = 1920
CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.__defaultHeight = 1080
CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.id = "CommonIdentityWidgetStreamlinedSafeAreaContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local CommonIdentityWidgetStreamlined = CoD.CommonIdentityWidgetStreamlined.new(f1_arg0, f1_arg1, 0.5, 0.5, 388, 918, 0, 0, 9, 49)
	CommonIdentityWidgetStreamlined:subscribeToGlobalModel(f1_arg1, "PerController", "identityBadge", function(model)
		CommonIdentityWidgetStreamlined:setModel(model, f1_arg1)
	end)
	self:addElement(CommonIdentityWidgetStreamlined)
	self.CommonIdentityWidgetStreamlined = CommonIdentityWidgetStreamlined
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.__onClose = function(f3_arg0)
	f3_arg0.CommonIdentityWidgetStreamlined:close()
end
