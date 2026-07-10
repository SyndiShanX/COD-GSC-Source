require("x64:d11d1df18bd22e6")
require("x64:c99c1dda3f73230")
CoD.vhud_ms_StatusWidgetBottom = InheritFrom(LUI.UIElement)
CoD.vhud_ms_StatusWidgetBottom.__defaultWidth = 208
CoD.vhud_ms_StatusWidgetBottom.__defaultHeight = 45
CoD.vhud_ms_StatusWidgetBottom.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, -20, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.vhud_ms_StatusWidgetBottom)
	self.id = "vhud_ms_StatusWidgetBottom"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vhudmsNotificationOptic = CoD.vhud_ms_NotificationOptic.new(f1_arg0, f1_arg1, 0.5, 0.5, -107, 15, 0.5, 0.5, -22.5, 22.5)
	vhudmsNotificationOptic:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "fullscreenFilter", Enum[@"vehiclefullscreenfilter"][@"vehicle_fullscreen_filter_infrared"])
			end,
		},
	})
	vhudmsNotificationOptic:linkToElementModel(vhudmsNotificationOptic, "fullscreenFilter", true, function(model)
		f1_arg0:updateElementState(vhudmsNotificationOptic, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "fullscreenFilter",
		})
	end)
	vhudmsNotificationOptic:linkToElementModel(self, nil, false, function(model)
		vhudmsNotificationOptic:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsNotificationOptic)
	self.vhudmsNotificationOptic = vhudmsNotificationOptic
	local vhudmsNotificationFlir0 = CoD.vhud_ms_NotificationFlir.new(f1_arg0, f1_arg1, 0.5, 0.5, -15, 107, 0.5, 0.5, -22.5, 22.5)
	vhudmsNotificationFlir0:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "fullscreenFilter", Enum[@"vehiclefullscreenfilter"][@"vehicle_fullscreen_filter_flir"])
			end,
		},
	})
	vhudmsNotificationFlir0:linkToElementModel(vhudmsNotificationFlir0, "fullscreenFilter", true, function(model)
		f1_arg0:updateElementState(vhudmsNotificationFlir0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "fullscreenFilter",
		})
	end)
	vhudmsNotificationFlir0:linkToElementModel(self, nil, false, function(model)
		vhudmsNotificationFlir0:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsNotificationFlir0)
	self.vhudmsNotificationFlir0 = vhudmsNotificationFlir0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_StatusWidgetBottom.__onClose = function(f8_arg0)
	f8_arg0.vhudmsNotificationOptic:close()
	f8_arg0.vhudmsNotificationFlir0:close()
end
