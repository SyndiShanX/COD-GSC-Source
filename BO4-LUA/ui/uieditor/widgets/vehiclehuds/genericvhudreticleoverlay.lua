require("x64:65054b8f0650c5d")
require("x64:a8d56a316c6ad40")
require("x64:9c40147e90bec2c")
require("x64:d84206e83dbcd1d")
require("x64:93547a1e84ec106")
require("x64:89111f3cd54c92f")
require("x64:95d15a81bcb0281")
CoD.genericVHUDReticleOverlay = InheritFrom(LUI.UIElement)
CoD.genericVHUDReticleOverlay.__defaultWidth = 1920
CoD.genericVHUDReticleOverlay.__defaultHeight = 1080
CoD.genericVHUDReticleOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.genericVHUDReticleOverlay)
	self.id = "genericVHUDReticleOverlay"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local genericVHUDdamageArea = CoD.genericVHUDdamageArea.new(f1_arg0, f1_arg1, 1, 1, -246, -96, 0, 0, 54, 204)
	genericVHUDdamageArea:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(f1_arg1, "VehicleInfo", "damageFillImage")
			end,
		},
	})
	local timeRemainingBar = genericVHUDdamageArea
	local genericVHUDRightContainer = genericVHUDdamageArea.subscribeToModel
	local missileProximityAlert = DataSources.VehicleInfo.getModel(f1_arg1)
	genericVHUDRightContainer(timeRemainingBar, missileProximityAlert.damageFillImage, function(f3_arg0)
		f1_arg0:updateElementState(genericVHUDdamageArea, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "damageFillImage",
		})
	end, false)
	genericVHUDdamageArea:linkToElementModel(self, nil, false, function(model)
		genericVHUDdamageArea:setModel(model, f1_arg1)
	end)
	genericVHUDdamageArea:linkToElementModel(self, "bindings.color", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			genericVHUDdamageArea.lineBack:setRGB(f5_local0)
		end
	end)
	genericVHUDdamageArea:linkToElementModel(self, "overlayImage", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			genericVHUDdamageArea.lineBack:setImage(RegisterImage(f6_local0))
		end
	end)
	genericVHUDdamageArea:linkToElementModel(self, "damageFillImage", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			genericVHUDdamageArea.fill:setImage(RegisterImage(f7_local0))
		end
	end)
	genericVHUDdamageArea:linkToElementModel(self, "bindings.color", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			genericVHUDdamageArea.lineFront:setRGB(f8_local0)
		end
	end)
	genericVHUDdamageArea:linkToElementModel(self, "overlayImage", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			genericVHUDdamageArea.lineFront:setImage(RegisterImage(f9_local0))
		end
	end)
	self:addElement(genericVHUDdamageArea)
	self.genericVHUDdamageArea = genericVHUDdamageArea
	genericVHUDRightContainer = CoD.genericVHUDRightContainer.new(f1_arg0, f1_arg1, 0, 0, 1691, 1824, 0.5, 0.5, -350, 350)
	genericVHUDRightContainer:linkToElementModel(self, nil, false, function(model)
		genericVHUDRightContainer:setModel(model, f1_arg1)
	end)
	self:addElement(genericVHUDRightContainer)
	self.genericVHUDRightContainer = genericVHUDRightContainer
	timeRemainingBar = CoD.genericVHUDTimeBar.new(f1_arg0, f1_arg1, 0, 0, 1452, 1824, 0, 0, 18, 104)
	timeRemainingBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "showTimeRemaining")
			end,
		},
	})
	timeRemainingBar:linkToElementModel(timeRemainingBar, "showTimeRemaining", true, function(model)
		f1_arg0:updateElementState(timeRemainingBar, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "showTimeRemaining",
		})
	end)
	timeRemainingBar:linkToElementModel(self, "bindings.color", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			timeRemainingBar:setRGB(f13_local0)
		end
	end)
	timeRemainingBar:linkToElementModel(self, nil, false, function(model)
		timeRemainingBar:setModel(model, f1_arg1)
	end)
	self:addElement(timeRemainingBar)
	self.timeRemainingBar = timeRemainingBar
	missileProximityAlert = CoD.missileProximityAlert.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 170, 1, 1, -241, -200)
	missileProximityAlert:linkToElementModel(self, nil, false, function(model)
		missileProximityAlert:setModel(model, f1_arg1)
	end)
	self:addElement(missileProximityAlert)
	self.missileProximityAlert = missileProximityAlert
	local vehicleCollisionWarning = CoD.vehicleCollisionWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -125, 125, 1, 1, -291, -250)
	vehicleCollisionWarning:linkToElementModel(self, nil, false, function(model)
		vehicleCollisionWarning:setModel(model, f1_arg1)
	end)
	self:addElement(vehicleCollisionWarning)
	self.vehicleCollisionWarning = vehicleCollisionWarning
	local PooledVehicleHealthWidget = CoD.genericVHUDHealthAndRadar.new(f1_arg0, f1_arg1, 1, 1, -293, 0, 1, 1, -749, 0)
	PooledVehicleHealthWidget:linkToElementModel(self, nil, false, function(model)
		PooledVehicleHealthWidget:setModel(model, f1_arg1)
	end)
	self:addElement(PooledVehicleHealthWidget)
	self.PooledVehicleHealthWidget = PooledVehicleHealthWidget
	local vehicleMalfunctionWarning = CoD.vehicleMalfunctionWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -151, 99, 0, 0, 216.5, 257.5)
	vehicleMalfunctionWarning:linkToElementModel(self, nil, false, function(model)
		vehicleMalfunctionWarning:setModel(model, f1_arg1)
	end)
	self:addElement(vehicleMalfunctionWarning)
	self.vehicleMalfunctionWarning = vehicleMalfunctionWarning
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsCampaign() and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.genericVHUDReticleOverlay.__resetProperties = function(f22_arg0)
	f22_arg0.PooledVehicleHealthWidget:completeAnimation()
	f22_arg0.vehicleCollisionWarning:completeAnimation()
	f22_arg0.missileProximityAlert:completeAnimation()
	f22_arg0.timeRemainingBar:completeAnimation()
	f22_arg0.genericVHUDRightContainer:completeAnimation()
	f22_arg0.genericVHUDdamageArea:completeAnimation()
	f22_arg0.PooledVehicleHealthWidget:setAlpha(1)
	f22_arg0.vehicleCollisionWarning:setAlpha(1)
	f22_arg0.missileProximityAlert:setAlpha(1)
	f22_arg0.timeRemainingBar:setAlpha(1)
	f22_arg0.genericVHUDRightContainer:setAlpha(1)
	f22_arg0.genericVHUDdamageArea:setAlpha(1)
end
CoD.genericVHUDReticleOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(6)
			f23_arg0.genericVHUDdamageArea:completeAnimation()
			f23_arg0.genericVHUDdamageArea:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.genericVHUDdamageArea)
			f23_arg0.genericVHUDRightContainer:completeAnimation()
			f23_arg0.genericVHUDRightContainer:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.genericVHUDRightContainer)
			f23_arg0.timeRemainingBar:completeAnimation()
			f23_arg0.timeRemainingBar:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.timeRemainingBar)
			f23_arg0.missileProximityAlert:completeAnimation()
			f23_arg0.missileProximityAlert:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.missileProximityAlert)
			f23_arg0.vehicleCollisionWarning:completeAnimation()
			f23_arg0.vehicleCollisionWarning:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.vehicleCollisionWarning)
			f23_arg0.PooledVehicleHealthWidget:completeAnimation()
			f23_arg0.PooledVehicleHealthWidget:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PooledVehicleHealthWidget)
		end,
	},
	Visible = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(6)
			f24_arg0.genericVHUDdamageArea:completeAnimation()
			f24_arg0.genericVHUDdamageArea:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.genericVHUDdamageArea)
			f24_arg0.genericVHUDRightContainer:completeAnimation()
			f24_arg0.genericVHUDRightContainer:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.genericVHUDRightContainer)
			f24_arg0.timeRemainingBar:completeAnimation()
			f24_arg0.timeRemainingBar:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.timeRemainingBar)
			f24_arg0.missileProximityAlert:completeAnimation()
			f24_arg0.missileProximityAlert:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.missileProximityAlert)
			f24_arg0.vehicleCollisionWarning:completeAnimation()
			f24_arg0.vehicleCollisionWarning:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.vehicleCollisionWarning)
			f24_arg0.PooledVehicleHealthWidget:completeAnimation()
			f24_arg0.PooledVehicleHealthWidget:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.PooledVehicleHealthWidget)
		end,
	},
}
CoD.genericVHUDReticleOverlay.__onClose = function(f25_arg0)
	f25_arg0.genericVHUDdamageArea:close()
	f25_arg0.genericVHUDRightContainer:close()
	f25_arg0.timeRemainingBar:close()
	f25_arg0.missileProximityAlert:close()
	f25_arg0.vehicleCollisionWarning:close()
	f25_arg0.PooledVehicleHealthWidget:close()
	f25_arg0.vehicleMalfunctionWarning:close()
end
