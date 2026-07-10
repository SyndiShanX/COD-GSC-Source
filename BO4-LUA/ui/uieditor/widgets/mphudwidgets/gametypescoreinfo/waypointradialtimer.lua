CoD.WaypointRadialTimer = InheritFrom(LUI.UIElement)
CoD.WaypointRadialTimer.__defaultWidth = 60
CoD.WaypointRadialTimer.__defaultHeight = 60
CoD.WaypointRadialTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointRadialTimer)
	self.id = "WaypointRadialTimer"
	self.soundSet = "default"
	local WaypointTimerBacking = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	WaypointTimerBacking:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WaypointTimerBacking:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f2_local0))
		end
	end)
	self:addElement(WaypointTimerBacking)
	self.WaypointTimerBacking = WaypointTimerBacking
	local WaypointTimerImage = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	WaypointTimerImage:linkToElementModel(self, "color", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			WaypointTimerImage:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f3_local0))
		end
	end)
	self:addElement(WaypointTimerImage)
	self.WaypointTimerImage = WaypointTimerImage
	local WaypointTimer = LUI.UIImage.new(0, 0, 0, 60, 0, 0, 0, 60)
	WaypointTimer:setRGB(0, 0, 0)
	WaypointTimer:setAlpha(0.95)
	WaypointTimer:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	WaypointTimer:setShaderVector(0, 0.8, 0, 0, 0)
	WaypointTimer:setShaderVector(1, 0.5, 0, 0, 0)
	WaypointTimer:setShaderVector(2, 0.5, 0, 0, 0)
	WaypointTimer:setShaderVector(3, 0, 0, 0, 0)
	WaypointTimer:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(WaypointTimer)
	self.WaypointTimer = WaypointTimer
	self:linkToElementModel(self, "objectiveModel", true, function(model)
		local f4_local0 = self
		SetElementModelToSelfModelValue(self, self, f1_arg1, "objectiveModel")
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointRadialTimer.__onClose = function(f5_arg0)
	f5_arg0.WaypointTimerBacking:close()
	f5_arg0.WaypointTimerImage:close()
end
