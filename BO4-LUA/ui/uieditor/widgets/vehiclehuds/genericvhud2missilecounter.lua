require("x64:8614cd331d8118b")
CoD.genericVHUD2MissileCounter = InheritFrom(LUI.UIElement)
CoD.genericVHUD2MissileCounter.__defaultWidth = 75
CoD.genericVHUD2MissileCounter.__defaultHeight = 46
CoD.genericVHUD2MissileCounter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericVHUD2MissileCounter)
	self.id = "genericVHUD2MissileCounter"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Missile1 = CoD.vhud_agr_missile.new(f1_arg0, f1_arg1, 0, 0, 0, 49, 0, 0, 0, 46)
	Missile1:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "rocketAmmo", 0)
			end,
		},
	})
	Missile1:linkToElementModel(Missile1, "rocketAmmo", true, function(model)
		f1_arg0:updateElementState(Missile1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketAmmo",
		})
	end)
	Missile1:setZRot(90)
	Missile1:linkToElementModel(self, nil, false, function(model)
		Missile1:setModel(model, f1_arg1)
	end)
	self:addElement(Missile1)
	self.Missile1 = Missile1
	local Missile2 = CoD.vhud_agr_missile.new(f1_arg0, f1_arg1, 0, 0, 26, 75, 0, 0, 0, 46)
	Missile2:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg1, "rocketAmmo", 1)
			end,
		},
	})
	Missile2:linkToElementModel(Missile2, "rocketAmmo", true, function(model)
		f1_arg0:updateElementState(Missile2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketAmmo",
		})
	end)
	Missile2:setZRot(90)
	Missile2:linkToElementModel(self, nil, false, function(model)
		Missile2:setModel(model, f1_arg1)
	end)
	self:addElement(Missile2)
	self.Missile2 = Missile2
	self:mergeStateConditions({
		{
			stateName = "Docked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.remoteMissilePhase2", 0)
			end,
		},
		{
			stateName = "LowAltitude",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 1) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "altitude", 5000)
			end,
		},
		{
			stateName = "MediumAltitude",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 1) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "altitude", 9000)
			end,
		},
		{
			stateName = "HighAltitude",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.remoteMissilePhase2"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.remoteMissilePhase2",
		})
	end, false)
	self:linkToElementModel(self, "rocketAmmo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketAmmo",
		})
	end)
	self:linkToElementModel(self, "altitude", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "altitude",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUD2MissileCounter.__onClose = function(f15_arg0)
	f15_arg0.Missile1:close()
	f15_arg0.Missile2:close()
end
