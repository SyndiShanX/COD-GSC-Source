require("ui/uieditor/widgets/startgameflow/loadingscreentalkercontainercpzm")
local PostLoadFunc = function(self, controller)
	self.LoadingScreenTalkerContainerCPZM:linkToElementModel(self, "playerxuid", true, function(model)
		local modelValue = Engine.GetModelValue(model)
		if modelValue then
			self.LoadingScreenTalkerContainerCPZM:setupShowIfXUIDTalking(modelValue)
		end
	end)
end
CoD.LoadingScreenTalkerWidgetCPZM = InheritFrom(LUI.UIElement)
CoD.LoadingScreenTalkerWidgetCPZM.__defaultWidth = 330
CoD.LoadingScreenTalkerWidgetCPZM.__defaultHeight = 27
CoD.LoadingScreenTalkerWidgetCPZM.new = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	local self = LUI.UIElement.new(f3_arg2, f3_arg3, f3_arg4, f3_arg5, f3_arg6, f3_arg7, f3_arg8, f3_arg9)
	self:setClass(CoD.LoadingScreenTalkerWidgetCPZM)
	self.id = "LoadingScreenTalkerWidgetCPZM"
	self.soundSet = "default"
	local LoadingScreenTalkerContainerCPZM = CoD.LoadingScreenTalkerContainerCPZM.new(f3_arg0, f3_arg1, 0, 0, -0.5, 329.5, 0, 0, 0, 26)
	LoadingScreenTalkerContainerCPZM:linkToElementModel(self, nil, false, function(model)
		LoadingScreenTalkerContainerCPZM:setModel(model, f3_arg1)
	end)
	self:addElement(LoadingScreenTalkerContainerCPZM)
	self.LoadingScreenTalkerContainerCPZM = LoadingScreenTalkerContainerCPZM
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg1, f3_arg0)
	end
	return self
end
CoD.LoadingScreenTalkerWidgetCPZM.__onClose = function(f5_arg0)
	f5_arg0.LoadingScreenTalkerContainerCPZM:close()
end
