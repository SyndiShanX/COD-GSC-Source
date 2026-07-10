require("x64:8614cd331d8118b")
CoD.vhud_agr_NotificationMissiles = InheritFrom(LUI.UIElement)
CoD.vhud_agr_NotificationMissiles.__defaultWidth = 126
CoD.vhud_agr_NotificationMissiles.__defaultHeight = 124
CoD.vhud_agr_NotificationMissiles.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_agr_NotificationMissiles)
	self.id = "vhud_agr_NotificationMissiles"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local firstMissile0 = CoD.vhud_agr_missile.new(f1_arg0, f1_arg1, 0.5, 0.5, -63, 63, 0.5, 0.5, -58, -7)
	firstMissile0:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 3)
			end,
		},
	})
	firstMissile0:linkToElementModel(firstMissile0, "rocketAmmo", true, function(model)
		f1_arg0:updateElementState(firstMissile0, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketAmmo",
		})
	end)
	firstMissile0:linkToElementModel(self, nil, false, function(model)
		firstMissile0:setModel(model, f1_arg1)
	end)
	self:addElement(firstMissile0)
	self.firstMissile0 = firstMissile0
	local secondMissile = CoD.vhud_agr_missile.new(f1_arg0, f1_arg1, 0.5, 0.5, -63, 63, 0.5, 0.5, -31, 16)
	secondMissile:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 2)
			end,
		},
	})
	secondMissile:linkToElementModel(secondMissile, "rocketAmmo", true, function(model)
		f1_arg0:updateElementState(secondMissile, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketAmmo",
		})
	end)
	secondMissile:linkToElementModel(self, nil, false, function(model)
		secondMissile:setModel(model, f1_arg1)
	end)
	self:addElement(secondMissile)
	self.secondMissile = secondMissile
	local thirdMissile = CoD.vhud_agr_missile.new(f1_arg0, f1_arg1, 0.5, 0.5, -63, 63, 0.5, 0.5, -7, 41)
	thirdMissile:mergeStateConditions({
		{
			stateName = "Armed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 1)
			end,
		},
	})
	thirdMissile:linkToElementModel(thirdMissile, "rocketAmmo", true, function(model)
		f1_arg0:updateElementState(thirdMissile, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketAmmo",
		})
	end)
	thirdMissile:linkToElementModel(self, nil, false, function(model)
		thirdMissile:setModel(model, f1_arg1)
	end)
	self:addElement(thirdMissile)
	self.thirdMissile = thirdMissile
	local Bar = LUI.UIImage.new(0.5, 0.5, -28, 28, 0.5, 0.5, 36, 43)
	Bar:setRGB(0.74, 0.99, 0.84)
	Bar:setYRot(130)
	Bar:setImage(RegisterImage(0x5534C48D872A06A))
	Bar:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Bar)
	self.Bar = Bar
	local solidbar = LUI.UIImage.new(0.5, 0.5, -28, 28, 0.5, 0.5, 36, 43)
	solidbar:setRGB(0.74, 0.99, 0.84)
	solidbar:setYRot(-50)
	solidbar:setImage(RegisterImage(0x7EA3B14064D93ED))
	solidbar:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	solidbar:setShaderVector(1, 0, 0, 0, 0)
	solidbar:setShaderVector(2, 1, 0, 0, 0)
	solidbar:setShaderVector(3, 0, 0, 0, 0)
	solidbar:setShaderVector(4, 0, 0, 0, 0)
	solidbar:linkToElementModel(self, "ammoReady", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			solidbar:setShaderVector(0, CoD.GetVectorComponentFromString(f11_local0, 1), CoD.GetVectorComponentFromString(f11_local0, 2), CoD.GetVectorComponentFromString(f11_local0, 3), CoD.GetVectorComponentFromString(f11_local0, 4))
		end
	end)
	self:addElement(solidbar)
	self.solidbar = solidbar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_agr_NotificationMissiles.__onClose = function(f12_arg0)
	f12_arg0.firstMissile0:close()
	f12_arg0.secondMissile:close()
	f12_arg0.thirdMissile:close()
	f12_arg0.solidbar:close()
end
