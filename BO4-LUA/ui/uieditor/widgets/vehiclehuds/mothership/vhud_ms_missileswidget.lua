require("x64:e37b7a08fb554d4")
CoD.vhud_ms_missilesWidget = InheritFrom(LUI.UIElement)
CoD.vhud_ms_missilesWidget.__defaultWidth = 93
CoD.vhud_ms_missilesWidget.__defaultHeight = 85
CoD.vhud_ms_missilesWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_missilesWidget)
	self.id = "vhud_ms_missilesWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vhudmsmissile = CoD.vhud_ms_missile.new(f1_arg0, f1_arg1, 0.5, 0.5, -46, 26, 0.5, 0.5, -42.5, -15.5)
	vhudmsmissile:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "ammoReady", 1)
			end,
		},
	})
	vhudmsmissile:linkToElementModel(vhudmsmissile, "ammoReady", true, function(model)
		f1_arg0:updateElementState(vhudmsmissile, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammoReady",
		})
	end)
	vhudmsmissile:setZRot(-90)
	vhudmsmissile:linkToElementModel(self, nil, false, function(model)
		vhudmsmissile:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsmissile)
	self.vhudmsmissile = vhudmsmissile
	local vhudmsmissile0 = CoD.vhud_ms_missile.new(f1_arg0, f1_arg1, 0.5, 0.5, -25, 47, 0.5, 0.5, -42.5, -15.5)
	vhudmsmissile0:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "ammoReady", 1)
			end,
		},
	})
	vhudmsmissile0:linkToElementModel(vhudmsmissile0, "ammoReady", true, function(model)
		f1_arg0:updateElementState(vhudmsmissile0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammoReady",
		})
	end)
	vhudmsmissile0:setZRot(-90)
	vhudmsmissile0:linkToElementModel(self, nil, false, function(model)
		vhudmsmissile0:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsmissile0)
	self.vhudmsmissile0 = vhudmsmissile0
	local vhudmsmissile1 = CoD.vhud_ms_missile.new(f1_arg0, f1_arg1, 0.5, 0.5, -46, 26, 0.5, 0.5, 15.5, 42.5)
	vhudmsmissile1:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "ammoReady", 1)
			end,
		},
	})
	vhudmsmissile1:linkToElementModel(vhudmsmissile1, "ammoReady", true, function(model)
		f1_arg0:updateElementState(vhudmsmissile1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammoReady",
		})
	end)
	vhudmsmissile1:setZRot(-90)
	vhudmsmissile1:linkToElementModel(self, nil, false, function(model)
		vhudmsmissile1:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsmissile1)
	self.vhudmsmissile1 = vhudmsmissile1
	local vhudmsmissile2 = CoD.vhud_ms_missile.new(f1_arg0, f1_arg1, 0.5, 0.5, -25, 47, 0.5, 0.5, 15.5, 42.5)
	vhudmsmissile2:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "ammoReady", 1)
			end,
		},
	})
	vhudmsmissile2:linkToElementModel(vhudmsmissile2, "ammoReady", true, function(model)
		f1_arg0:updateElementState(vhudmsmissile2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammoReady",
		})
	end)
	vhudmsmissile2:setZRot(-90)
	vhudmsmissile2:linkToElementModel(self, nil, false, function(model)
		vhudmsmissile2:setModel(model, f1_arg1)
	end)
	self:addElement(vhudmsmissile2)
	self.vhudmsmissile2 = vhudmsmissile2
	local Bar = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, 61, 68)
	Bar:setRGB(0.74, 0.94, 0.99)
	Bar:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_timebar"))
	Bar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Bar)
	self.Bar = Bar
	local solidbar = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, 61, 68)
	solidbar:setRGB(0.74, 0.94, 0.99)
	solidbar:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_mothership_timebarsolid"))
	solidbar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	solidbar:setShaderVector(1, 0, 0, 0, 0)
	solidbar:setShaderVector(2, 1, 0, 0, 0)
	solidbar:setShaderVector(3, 0, 0, 0, 0)
	solidbar:setShaderVector(4, 0, 0, 0, 0)
	solidbar:linkToElementModel(self, "ammoReady", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			solidbar:setShaderVector(0, CoD.GetVectorComponentFromString(f14_local0, 1), CoD.GetVectorComponentFromString(f14_local0, 2), CoD.GetVectorComponentFromString(f14_local0, 3), CoD.GetVectorComponentFromString(f14_local0, 4))
		end
	end)
	self:addElement(solidbar)
	self.solidbar = solidbar
	self:mergeStateConditions({
		{
			stateName = "Charging",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueLessThan(element, f1_arg1, "ammoReady", 1)
			end,
		},
	})
	self:linkToElementModel(self, "ammoReady", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "ammoReady",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_missilesWidget.__onClose = function(f17_arg0)
	f17_arg0.vhudmsmissile:close()
	f17_arg0.vhudmsmissile0:close()
	f17_arg0.vhudmsmissile1:close()
	f17_arg0.vhudmsmissile2:close()
	f17_arg0.solidbar:close()
end
