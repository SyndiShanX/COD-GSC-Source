require("x64:b3d63c2af91409d")
CoD.vhud_attack_helicopter_minigun_reticle = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_minigun_reticle.__defaultWidth = 10
CoD.vhud_attack_helicopter_minigun_reticle.__defaultHeight = 10
CoD.vhud_attack_helicopter_minigun_reticle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_minigun_reticle)
	self.id = "vhud_attack_helicopter_minigun_reticle"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local msCenterDiamondT = CoD.duplicateStateImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -24.5, 24.5, 0, 0, -134, 0)
	msCenterDiamondT:mergeStateConditions({
		{
			stateName = "State2",
			condition = function(menu, element, event)
				local f2_local0 = IsCampaign()
				if f2_local0 then
					f2_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "weaponOverEnemy")
					if f2_local0 then
						f2_local0 = IsVehicleOfType(f1_arg1, "bo4_player_air_vehicle1")
					end
				end
				return f2_local0
			end,
		},
	})
	local msCenterDiamondSideL = msCenterDiamondT
	local msCenterDiamondB = msCenterDiamondT.subscribeToModel
	local msCenterDiamondSideR = Engine[0x8DF2E5447F384B9]()
	msCenterDiamondB(msCenterDiamondSideL, msCenterDiamondSideR["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(msCenterDiamondT, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	msCenterDiamondSideL = msCenterDiamondT
	msCenterDiamondB = msCenterDiamondT.subscribeToModel
	msCenterDiamondSideR = DataSources.CurrentWeapon.getModel(f1_arg1)
	msCenterDiamondB(msCenterDiamondSideL, msCenterDiamondSideR.weaponOverEnemy, function(f4_arg0)
		f1_arg0:updateElementState(msCenterDiamondT, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "weaponOverEnemy",
		})
	end, false)
	msCenterDiamondSideL = msCenterDiamondT
	msCenterDiamondB = msCenterDiamondT.subscribeToModel
	msCenterDiamondSideR = DataSources.VehicleInfo.getModel(f1_arg1)
	msCenterDiamondB(msCenterDiamondSideL, msCenterDiamondSideR.vehicleType, function(f5_arg0)
		f1_arg0:updateElementState(msCenterDiamondT, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	msCenterDiamondT.state1Image:setImage(RegisterImage(0x3C917B68C1D560E))
	msCenterDiamondT.state1Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	msCenterDiamondT.state2Image:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	self:addElement(msCenterDiamondT)
	self.msCenterDiamondT = msCenterDiamondT
	msCenterDiamondB = CoD.duplicateStateImage.new(f1_arg0, f1_arg1, 0.5, 0.5, -24.5, 24.5, 1, 1, 0, 134)
	msCenterDiamondB:mergeStateConditions({
		{
			stateName = "State2",
			condition = function(menu, element, event)
				local f6_local0 = IsCampaign()
				if f6_local0 then
					f6_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "weaponOverEnemy")
					if f6_local0 then
						f6_local0 = IsVehicleOfType(f1_arg1, "bo4_player_air_vehicle1")
					end
				end
				return f6_local0
			end,
		},
	})
	msCenterDiamondSideR = msCenterDiamondB
	msCenterDiamondSideL = msCenterDiamondB.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	msCenterDiamondSideL(msCenterDiamondSideR, f1_local5["lobbyRoot.lobbyNav"], function(f7_arg0)
		f1_arg0:updateElementState(msCenterDiamondB, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	msCenterDiamondSideR = msCenterDiamondB
	msCenterDiamondSideL = msCenterDiamondB.subscribeToModel
	f1_local5 = DataSources.CurrentWeapon.getModel(f1_arg1)
	msCenterDiamondSideL(msCenterDiamondSideR, f1_local5.weaponOverEnemy, function(f8_arg0)
		f1_arg0:updateElementState(msCenterDiamondB, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "weaponOverEnemy",
		})
	end, false)
	msCenterDiamondSideR = msCenterDiamondB
	msCenterDiamondSideL = msCenterDiamondB.subscribeToModel
	f1_local5 = DataSources.VehicleInfo.getModel(f1_arg1)
	msCenterDiamondSideL(msCenterDiamondSideR, f1_local5.vehicleType, function(f9_arg0)
		f1_arg0:updateElementState(msCenterDiamondB, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	msCenterDiamondB:setZRot(180)
	msCenterDiamondB.state1Image:setImage(RegisterImage(0x3C917B68C1D560E))
	msCenterDiamondB.state1Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	msCenterDiamondB.state2Image:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	self:addElement(msCenterDiamondB)
	self.msCenterDiamondB = msCenterDiamondB
	msCenterDiamondSideL = CoD.duplicateStateImage.new(f1_arg0, f1_arg1, 0, 0, -73.5, -0.5, 0.5, 0.5, -24.5, 24.5)
	msCenterDiamondSideL:mergeStateConditions({
		{
			stateName = "State2",
			condition = function(menu, element, event)
				local f10_local0 = IsCampaign()
				if f10_local0 then
					f10_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "weaponOverEnemy")
					if f10_local0 then
						f10_local0 = IsVehicleOfType(f1_arg1, "bo4_player_air_vehicle1")
					end
				end
				return f10_local0
			end,
		},
	})
	f1_local5 = msCenterDiamondSideL
	msCenterDiamondSideR = msCenterDiamondSideL.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	msCenterDiamondSideR(f1_local5, f1_local6["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(msCenterDiamondSideL, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local5 = msCenterDiamondSideL
	msCenterDiamondSideR = msCenterDiamondSideL.subscribeToModel
	f1_local6 = DataSources.CurrentWeapon.getModel(f1_arg1)
	msCenterDiamondSideR(f1_local5, f1_local6.weaponOverEnemy, function(f12_arg0)
		f1_arg0:updateElementState(msCenterDiamondSideL, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "weaponOverEnemy",
		})
	end, false)
	f1_local5 = msCenterDiamondSideL
	msCenterDiamondSideR = msCenterDiamondSideL.subscribeToModel
	f1_local6 = DataSources.VehicleInfo.getModel(f1_arg1)
	msCenterDiamondSideR(f1_local5, f1_local6.vehicleType, function(f13_arg0)
		f1_arg0:updateElementState(msCenterDiamondSideL, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	msCenterDiamondSideL.state1Image:setImage(RegisterImage(0x75D443C057C1AB4))
	msCenterDiamondSideL.state1Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	msCenterDiamondSideL.state2Image:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	self:addElement(msCenterDiamondSideL)
	self.msCenterDiamondSideL = msCenterDiamondSideL
	msCenterDiamondSideR = CoD.duplicateStateImage.new(f1_arg0, f1_arg1, 1, 1, 0, 74, 0.5, 0.5, -24.5, 24.5)
	msCenterDiamondSideR:mergeStateConditions({
		{
			stateName = "State2",
			condition = function(menu, element, event)
				local f14_local0 = IsCampaign()
				if f14_local0 then
					f14_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "weaponOverEnemy")
					if f14_local0 then
						f14_local0 = IsVehicleOfType(f1_arg1, "bo4_player_air_vehicle1")
					end
				end
				return f14_local0
			end,
		},
	})
	f1_local6 = msCenterDiamondSideR
	f1_local5 = msCenterDiamondSideR.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local6, f1_local7["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(msCenterDiamondSideR, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local6 = msCenterDiamondSideR
	f1_local5 = msCenterDiamondSideR.subscribeToModel
	f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.weaponOverEnemy, function(f16_arg0)
		f1_arg0:updateElementState(msCenterDiamondSideR, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "weaponOverEnemy",
		})
	end, false)
	f1_local6 = msCenterDiamondSideR
	f1_local5 = msCenterDiamondSideR.subscribeToModel
	f1_local7 = DataSources.VehicleInfo.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.vehicleType, function(f17_arg0)
		f1_arg0:updateElementState(msCenterDiamondSideR, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	msCenterDiamondSideR:setZRot(180)
	msCenterDiamondSideR.state1Image:setImage(RegisterImage(0x75D443C057C1AB4))
	msCenterDiamondSideR.state1Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	msCenterDiamondSideR.state2Image:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	self:addElement(msCenterDiamondSideR)
	self.msCenterDiamondSideR = msCenterDiamondSideR
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CallCustomElementFunction_Self(self, "setupBulletSpreadReticle")
	return self
end
CoD.vhud_attack_helicopter_minigun_reticle.__onClose = function(f18_arg0)
	f18_arg0.msCenterDiamondT:close()
	f18_arg0.msCenterDiamondB:close()
	f18_arg0.msCenterDiamondSideL:close()
	f18_arg0.msCenterDiamondSideR:close()
end
