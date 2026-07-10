require("x64:1cca917a07b5398")
require("x64:137536a88aabf64")
CoD.vhud_ms_LockOnNotification = InheritFrom(LUI.UIElement)
CoD.vhud_ms_LockOnNotification.__defaultWidth = 60
CoD.vhud_ms_LockOnNotification.__defaultHeight = 60
CoD.vhud_ms_LockOnNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_LockOnNotification)
	self.id = "vhud_ms_LockOnNotification"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local vhudmsLockBox = CoD.vhud_ms_LockBox.new(f1_arg0, f1_arg1, 0.5, 0.5, -41.5, 41.5, 0.5, 0.5, -36, 47)
	vhudmsLockBox:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueTrue(element, f1_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_center"])
			end,
		},
		{
			stateName = "HasLock",
			condition = function(menu, element, event)
				return VehicleHasEnemyLock(element, f1_arg1)
			end,
		},
	})
	vhudmsLockBox:linkToElementModel(vhudmsLockBox, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_center"], true, function(model)
		f1_arg0:updateElementState(vhudmsLockBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"missilelockedondirection"][@"missile_locked_on_direction_center"],
		})
	end)
	vhudmsLockBox:linkToElementModel(vhudmsLockBox, nil, true, function(model)
		f1_arg0:updateElementState(vhudmsLockBox, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	vhudmsLockBox:linkToElementModel(self, nil, false, function(model)
		vhudmsLockBox:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsLockBox)
	self.vhudmsLockBox = vhudmsLockBox
	local vhudmsLockArrow = CoD.vhud_ms_LockArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -77, -23, 0.5, 0.5, -29, 25)
	vhudmsLockArrow:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueTrue(element, f1_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_left"])
			end,
		},
	})
	vhudmsLockArrow:linkToElementModel(vhudmsLockArrow, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_left"], true, function(model)
		f1_arg0:updateElementState(vhudmsLockArrow, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"missilelockedondirection"][@"missile_locked_on_direction_left"],
		})
	end)
	vhudmsLockArrow:linkToElementModel(self, nil, false, function(model)
		vhudmsLockArrow:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsLockArrow)
	self.vhudmsLockArrow = vhudmsLockArrow
	local vhudmsLockArrow0 = CoD.vhud_ms_LockArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, 23, 77, 0.5, 0.5, -27, 27)
	vhudmsLockArrow0:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueTrue(element, f1_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_right"])
			end,
		},
	})
	vhudmsLockArrow0:linkToElementModel(vhudmsLockArrow0, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_right"], true, function(model)
		f1_arg0:updateElementState(vhudmsLockArrow0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"missilelockedondirection"][@"missile_locked_on_direction_right"],
		})
	end)
	vhudmsLockArrow0:setZRot(180)
	vhudmsLockArrow0:linkToElementModel(self, nil, false, function(model)
		vhudmsLockArrow0:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsLockArrow0)
	self.vhudmsLockArrow0 = vhudmsLockArrow0
	local vhudmsLockArrow1 = CoD.vhud_ms_LockArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -29, 25, 0.5, 0.5, -1, 53)
	vhudmsLockArrow1:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueTrue(element, f1_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_down"])
			end,
		},
	})
	vhudmsLockArrow1:linkToElementModel(vhudmsLockArrow1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_down"], true, function(model)
		f1_arg0:updateElementState(vhudmsLockArrow1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"missilelockedondirection"][@"missile_locked_on_direction_down"],
		})
	end)
	vhudmsLockArrow1:setZRot(90)
	vhudmsLockArrow1:linkToElementModel(self, nil, false, function(model)
		vhudmsLockArrow1:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsLockArrow1)
	self.vhudmsLockArrow1 = vhudmsLockArrow1
	local vhudmsLockArrow2 = CoD.vhud_ms_LockArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -27, 27, 0.5, 0.5, -54, 0)
	vhudmsLockArrow2:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfEnumModelValueTrue(element, f1_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_up"])
			end,
		},
	})
	vhudmsLockArrow2:linkToElementModel(vhudmsLockArrow2, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_up"], true, function(model)
		f1_arg0:updateElementState(vhudmsLockArrow2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = Enum[@"missilelockedondirection"][@"missile_locked_on_direction_up"],
		})
	end)
	vhudmsLockArrow2:setZRot(-90)
	vhudmsLockArrow2:linkToElementModel(self, nil, false, function(model)
		vhudmsLockArrow2:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsLockArrow2)
	self.vhudmsLockArrow2 = vhudmsLockArrow2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_LockOnNotification.__onClose = function(f19_arg0)
	f19_arg0.vhudmsLockBox:close()
	f19_arg0.vhudmsLockArrow:close()
	f19_arg0.vhudmsLockArrow0:close()
	f19_arg0.vhudmsLockArrow1:close()
	f19_arg0.vhudmsLockArrow2:close()
end
