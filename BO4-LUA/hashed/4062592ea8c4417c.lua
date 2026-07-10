require("x64:a7a13e373e49761")
CoD.RadiationBlastHealthBar = InheritFrom(LUI.UIElement)
CoD.RadiationBlastHealthBar.__defaultWidth = 142
CoD.RadiationBlastHealthBar.__defaultHeight = 11
CoD.RadiationBlastHealthBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.RadiationBlastHealthBar)
	self.id = "RadiationBlastHealthBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HealthBar = CoD.HealthBarWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -71, 81, 0.5, 0.5, -5.5, 5.5)
	HealthBar:linkToElementModel(self, "health", false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local HealthValue = LUI.UIText.new(0, 0, 140, 204, 0, 0, -7.5, 18.5)
	HealthValue:setTTF("0arame_mono_stencil")
	HealthValue:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	HealthValue:setLetterSpacing(2)
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	HealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HealthValue:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	self:mergeStateConditions({
		{
			stateName = "Boom",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "progress", 1)
			end,
		},
		{
			stateName = "High",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "progress", 0.7)
			end,
		},
		{
			stateName = "Medium",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "progress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "progress",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
	return self
end
CoD.RadiationBlastHealthBar.__onClose = function(f8_arg0)
	f8_arg0.HealthBar:close()
	f8_arg0.HealthValue:close()
end
