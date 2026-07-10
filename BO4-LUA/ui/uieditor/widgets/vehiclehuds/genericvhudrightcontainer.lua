require("x64:a711f5c262e7f92")
require("x64:77282d98e20da30")
require("x64:2ce116d9485ec2b")
CoD.genericVHUDRightContainer = InheritFrom(LUI.UIElement)
CoD.genericVHUDRightContainer.__defaultWidth = 133
CoD.genericVHUDRightContainer.__defaultHeight = 700
CoD.genericVHUDRightContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Middle)
	self:setClass(CoD.genericVHUDRightContainer)
	self.id = "genericVHUDRightContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local speed = CoD.genericVHUDInfoArea.new(f1_arg0, f1_arg1, 0, 0, 0, 133, 0, 0, 219, 282)
	speed:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showSpeed")
			end,
		},
	})
	speed:linkToElementModel(speed, "showSpeed", true, function(model)
		f1_arg0:updateElementState(speed, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showSpeed",
		})
	end)
	speed:setYRot(-30)
	speed:linkToElementModel(self, "bindings.color", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			speed:setRGB(f4_local0)
		end
	end)
	speed:linkToElementModel(self, nil, false, function(model)
		speed:setModel(model, f1_arg1)
	end)
	speed:linkToElementModel(self, "speed", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			speed.value:setText(f6_local0)
		end
	end)
	self:addElement(speed)
	self.speed = speed
	local vhudagrNotificationMissiles = CoD.genericVHUD3MissileCounter.new(f1_arg0, f1_arg1, 0, 0, -28.5, 161.5, 0, 0, 292, 432)
	vhudagrNotificationMissiles:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "rocketTitle")
			end,
		},
	})
	vhudagrNotificationMissiles:linkToElementModel(vhudagrNotificationMissiles, "rocketTitle", true, function(model)
		f1_arg0:updateElementState(vhudagrNotificationMissiles, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketTitle",
		})
	end)
	vhudagrNotificationMissiles:linkToElementModel(self, "bindings.color", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			vhudagrNotificationMissiles:setRGB(f9_local0)
		end
	end)
	vhudagrNotificationMissiles:linkToElementModel(self, nil, false, function(model)
		vhudagrNotificationMissiles:setModel(model, f1_arg1)
	end)
	self:addElement(vhudagrNotificationMissiles)
	self.vhudagrNotificationMissiles = vhudagrNotificationMissiles
	local genericVHUDProgressBar = CoD.genericVHUDProgressBar.new(f1_arg0, f1_arg1, 0, 0, 3, 133, 0, 0, 442, 481)
	genericVHUDProgressBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "secondaryAmmoTitle")
			end,
		},
		{
			stateName = "Recharging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "ammo2Reloading", 1)
			end,
		},
	})
	genericVHUDProgressBar:linkToElementModel(genericVHUDProgressBar, "secondaryAmmoTitle", true, function(model)
		f1_arg0:updateElementState(genericVHUDProgressBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "secondaryAmmoTitle",
		})
	end)
	genericVHUDProgressBar:linkToElementModel(genericVHUDProgressBar, "ammo2Reloading", true, function(model)
		f1_arg0:updateElementState(genericVHUDProgressBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammo2Reloading",
		})
	end)
	genericVHUDProgressBar:setYRot(-30)
	genericVHUDProgressBar:linkToElementModel(self, "bindings.color", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			genericVHUDProgressBar:setRGB(f15_local0)
		end
	end)
	genericVHUDProgressBar:linkToElementModel(self, nil, false, function(model)
		genericVHUDProgressBar:setModel(model, f1_arg1)
	end)
	genericVHUDProgressBar:linkToElementModel(self, "secondaryAmmoSecondaryText", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			genericVHUDProgressBar.flashingText:setText(f17_local0)
		end
	end)
	genericVHUDProgressBar:linkToElementModel(self, "secondaryAmmoTitle", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			genericVHUDProgressBar.SignalText:setText(f18_local0)
		end
	end)
	self:addElement(genericVHUDProgressBar)
	self.genericVHUDProgressBar = genericVHUDProgressBar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUDRightContainer.__onClose = function(f19_arg0)
	f19_arg0.speed:close()
	f19_arg0.vhudagrNotificationMissiles:close()
	f19_arg0.genericVHUDProgressBar:close()
end
