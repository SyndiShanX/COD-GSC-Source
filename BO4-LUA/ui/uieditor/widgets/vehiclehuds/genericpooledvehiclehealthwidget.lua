require("x64:b270dba58a72446")
CoD.genericPooledVehicleHealthWidget = InheritFrom(LUI.UIElement)
CoD.genericPooledVehicleHealthWidget.__defaultWidth = 94
CoD.genericPooledVehicleHealthWidget.__defaultHeight = 216
CoD.genericPooledVehicleHealthWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericPooledVehicleHealthWidget)
	self.id = "genericPooledVehicleHealthWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HealthBarBlur = LUI.UIImage.new(0, 0, 0, 94, 0, 0, 0, 216)
	HealthBarBlur:setImage(RegisterImage(0xC74271FF9631F7D))
	HealthBarBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	HealthBarBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(HealthBarBlur)
	self.HealthBarBlur = HealthBarBlur
	local HealthBarBacking = LUI.UIImage.new(0, 0, 0, 94, 0, 0, 0, 216)
	HealthBarBacking:setRGB(0, 0, 0)
	HealthBarBacking:setAlpha(0.75)
	HealthBarBacking:setImage(RegisterImage(0xC74271FF9631F7D))
	self:addElement(HealthBarBacking)
	self.HealthBarBacking = HealthBarBacking
	local VehicleIconBacking = LUI.UIImage.new(0, 0, 19, 91, 0, 0, 181, 215)
	VehicleIconBacking:setImage(RegisterImage(0x8226750AF58416B))
	self:addElement(VehicleIconBacking)
	self.VehicleIconBacking = VehicleIconBacking
	local HealthBar = CoD.genericPooledVehicleHealthBar.new(f1_arg0, f1_arg1, 0, 0, 6, 60, 0, 0, 12, 186)
	HealthBar:linkToElementModel(self, nil, false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local VehicleIcon = LUI.UIImage.new(0, 0, 29, 89, 0, 0, 168, 228)
	VehicleIcon:linkToElementModel(self, "vehicleIcon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			VehicleIcon:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f3_local0)))
		end
	end)
	self:addElement(VehicleIcon)
	self.VehicleIcon = VehicleIcon
	self:mergeStateConditions({
		{
			stateName = "LowHealth",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showPooledHealthBar") and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "damage", 0.85)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showPooledHealthBar") and CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "damage", 1)
			end,
		},
	})
	self:linkToElementModel(self, "showPooledHealthBar", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showPooledHealthBar",
		})
	end)
	self:linkToElementModel(self, "damage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "damage",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericPooledVehicleHealthWidget.__resetProperties = function(f8_arg0)
	f8_arg0.VehicleIcon:completeAnimation()
	f8_arg0.HealthBar:completeAnimation()
	f8_arg0.VehicleIconBacking:completeAnimation()
	f8_arg0.HealthBarBacking:completeAnimation()
	f8_arg0.HealthBarBlur:completeAnimation()
	f8_arg0.VehicleIcon:setRGB(1, 1, 1)
	f8_arg0.VehicleIcon:setAlpha(1)
	f8_arg0.HealthBar:setAlpha(1)
	f8_arg0.HealthBar.currentPool:setRGB(0.53, 0.53, 0.53)
	f8_arg0.HealthBar.currentDamage:setRGB(1, 1, 1)
	f8_arg0.VehicleIconBacking:setAlpha(1)
	f8_arg0.HealthBarBacking:setAlpha(0.75)
	f8_arg0.HealthBarBlur:setAlpha(1)
end
CoD.genericPooledVehicleHealthWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.HealthBarBlur:completeAnimation()
			f9_arg0.HealthBarBlur:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.HealthBarBlur)
			f9_arg0.HealthBarBacking:completeAnimation()
			f9_arg0.HealthBarBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.HealthBarBacking)
			f9_arg0.VehicleIconBacking:completeAnimation()
			f9_arg0.VehicleIconBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.VehicleIconBacking)
			f9_arg0.HealthBar:completeAnimation()
			f9_arg0.HealthBar:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.HealthBar)
			f9_arg0.VehicleIcon:completeAnimation()
			f9_arg0.VehicleIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.VehicleIcon)
		end,
	},
	LowHealth = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.HealthBar:completeAnimation()
			f10_arg0.HealthBar.currentPool:completeAnimation()
			f10_arg0.HealthBar.currentDamage:completeAnimation()
			f10_arg0.HealthBar.currentPool:setRGB(0.53, 0, 0)
			f10_arg0.HealthBar.currentDamage:setRGB(1, 0, 0)
			f10_arg0.clipFinished(f10_arg0.HealthBar)
			f10_arg0.VehicleIcon:completeAnimation()
			f10_arg0.VehicleIcon:setRGB(1, 0, 0)
			f10_arg0.clipFinished(f10_arg0.VehicleIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.genericPooledVehicleHealthWidget.__onClose = function(f12_arg0)
	f12_arg0.HealthBar:close()
	f12_arg0.VehicleIcon:close()
end
