require("x64:d4550113ea4f7d2")
CoD.rocketLauncherLockon = InheritFrom(LUI.UIElement)
CoD.rocketLauncherLockon.__defaultWidth = 105
CoD.rocketLauncherLockon.__defaultHeight = 105
CoD.rocketLauncherLockon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.rocketLauncherLockon)
	self.id = "rocketLauncherLockon"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local rocketLauncherLockonInternal0 = CoD.rocketLauncherLockon_Internal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	rocketLauncherLockonInternal0:mergeStateConditions({
		{
			stateName = "LockedOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumBitSet(element, f1_arg1, "status", Enum[0xF041D1802ECFE69][0x86864C292F49B19])
			end,
		},
		{
			stateName = "AcquiringLock",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumBitSet(element, f1_arg1, "status", Enum[0xF041D1802ECFE69][0x8C8B89F7D1690F0])
			end,
		},
	})
	rocketLauncherLockonInternal0:linkToElementModel(rocketLauncherLockonInternal0, "status", true, function(model)
		f1_arg0:updateElementState(rocketLauncherLockonInternal0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "status",
		})
	end)
	rocketLauncherLockonInternal0:linkToElementModel(self, nil, false, function(model)
		rocketLauncherLockonInternal0:setModel(model, f1_arg1)
	end)
	self:addElement(rocketLauncherLockonInternal0)
	self.rocketLauncherLockonInternal0 = rocketLauncherLockonInternal0
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		CallCustomElementFunction_Element(element, "setupRocketLauncherTarget", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.rocketLauncherLockon.__onClose = function(f7_arg0)
	f7_arg0.rocketLauncherLockonInternal0:close()
end
