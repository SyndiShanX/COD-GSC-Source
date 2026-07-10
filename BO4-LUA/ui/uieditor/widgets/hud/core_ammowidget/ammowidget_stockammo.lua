require("x64:7a4af8bd7568030")
require("x64:30b6383c771416e")
require("x64:6f26d6ebdb5208b")
require("x64:8eec6df22fcc7f")
require("x64:3c40ae98a19ddf5")
require("x64:16839327b099be7")
require("x64:84a65387ed01e9b")
CoD.AmmoWidget_StockAmmo = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_StockAmmo.__defaultWidth = 312
CoD.AmmoWidget_StockAmmo.__defaultHeight = 112
CoD.AmmoWidget_StockAmmo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_StockAmmo)
	self.id = "AmmoWidget_StockAmmo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AmmoWidgetVehicleReloadMeter = CoD.AmmoWidgetVehicleReloadMeter.new(f1_arg0, f1_arg1, 0, 0, 41, 152, 0, 0, 14, 126)
	AmmoWidgetVehicleReloadMeter:setAlpha(0)
	self:addElement(AmmoWidgetVehicleReloadMeter)
	self.AmmoWidgetVehicleReloadMeter = AmmoWidgetVehicleReloadMeter
	local OverheatMeter = CoD.AmmoWidget_OverheatMeter.new(f1_arg0, f1_arg1, 0, 0, 41, 152, 0, 0, 14, 126)
	OverheatMeter:setAlpha(0)
	OverheatMeter:linkToElementModel(self, nil, false, function(model)
		OverheatMeter:setModel(model, f1_arg1)
	end)
	self:addElement(OverheatMeter)
	self.OverheatMeter = OverheatMeter
	local clipGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -3, 0, nil, nil, false, false, false, false)
	clipGrid:setLeftRight(0, 0, 49, 137)
	clipGrid:setTopBottom(0, 0, 32, 92)
	clipGrid:setWidgetType(CoD.AmmoWidget_StockAmmoPip)
	clipGrid:setHorizontalCount(5)
	clipGrid:setSpacing(-3)
	clipGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	clipGrid:setDataSource("CurrentWeaponStockAmmo")
	clipGrid:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "ammoStock", function(model)
		local f3_local0 = clipGrid
		if not IsSegmentedReloadWeapon(f1_arg1) and WeaponUsesAmmo(f1_arg1) then
			CoD.GridAndListUtility.UpdateDataSource(f3_local0, false, false, true)
		end
	end)
	clipGrid:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weapon", function(model)
		local f4_local0 = clipGrid
		if not IsSegmentedReloadWeapon(f1_arg1) and WeaponUsesAmmo(f1_arg1) then
			CoD.GridAndListUtility.UpdateDataSource(f4_local0, false, false, true)
		end
	end)
	self:addElement(clipGrid)
	self.clipGrid = clipGrid
	local singleShotGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 1, 0, nil, nil, false, false, false, false)
	singleShotGrid:setLeftRight(0, 0, 52, 141)
	singleShotGrid:setTopBottom(0, 0, 66, 89)
	singleShotGrid:setAlpha(0)
	singleShotGrid:setWidgetType(CoD.AmmoWidget_SingleShotPip)
	singleShotGrid:setHorizontalCount(6)
	singleShotGrid:setVerticalCount(3)
	singleShotGrid:setSpacing(1)
	singleShotGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	singleShotGrid:setDataSource("CurrentWeaponSingleShotAmmo")
	singleShotGrid:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "ammoStock", function(model)
		local f5_local0 = singleShotGrid
		if not CoD.HUDUtility.UsingPlayerGadgetWithBar(f1_arg1) and WeaponUsesAmmo(f1_arg1) and IsSegmentedReloadWeapon(f1_arg1) then
			CoD.GridAndListUtility.UpdateDataSource(f5_local0, false, false, true)
		end
	end)
	singleShotGrid:subscribeToGlobalModel(f1_arg1, "CurrentWeapon", "weapon", function(model)
		local f6_local0 = singleShotGrid
		if not CoD.HUDUtility.UsingPlayerGadgetWithBar(f1_arg1) and WeaponUsesAmmo(f1_arg1) and IsSegmentedReloadWeapon(f1_arg1) then
			CoD.GridAndListUtility.UpdateDataSource(f6_local0, false, false, true)
		end
	end)
	self:addElement(singleShotGrid)
	self.singleShotGrid = singleShotGrid
	local AmmoWidgetCurrentClipPip = CoD.AmmoWidget_CurrentClipPip.new(f1_arg0, f1_arg1, 0, 0, 23, 46, 0, 0, 18, 90)
	self:addElement(AmmoWidgetCurrentClipPip)
	self.AmmoWidgetCurrentClipPip = AmmoWidgetCurrentClipPip
	local emptyPulse = CoD.AmmoWidget_StockAmmo_EmptyPulse.new(f1_arg0, f1_arg1, 0, 0, 55, 155, 0, 0, 67, 91)
	self:addElement(emptyPulse)
	self.emptyPulse = emptyPulse
	local ammoType = CoD.AmmoWidget_AmmoCaliber.new(f1_arg0, f1_arg1, 0, 0, 52, 216, 0, 0, 48, 62)
	ammoType:linkToElementModel(self, nil, false, function(model)
		ammoType:setModel(model, f1_arg1)
	end)
	self:addElement(ammoType)
	self.ammoType = ammoType
	self:mergeStateConditions({
		{
			stateName = "OverheatWeapon",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "weaponIsOverheatWeapon")
			end,
		},
		{
			stateName = "UsingPowerWeapon",
			condition = function(menu, element, event)
				return CoD.HUDUtility.UsingPlayerGadgetWithBar(f1_arg1)
			end,
		},
		{
			stateName = "NoAmmoWeapon",
			condition = function(menu, element, event)
				return not WeaponUsesAmmo(f1_arg1)
			end,
		},
		{
			stateName = "SingleLoadWeapon",
			condition = function(menu, element, event)
				return IsSegmentedReloadWeapon(f1_arg1)
			end,
		},
		{
			stateName = "TankGunWZ",
			condition = function(menu, element, event)
				return IsWarzone() and CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "equippedWeaponReference", @"hash_78A462F65A5A2A09")
			end,
		},
	})
	self:linkToElementModel(self, "weaponIsOverheatWeapon", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "weaponIsOverheatWeapon",
		})
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = DataSources.PlayerAbilities.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10["playerGadget2.state"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "playerGadget2.state",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.PlayerAbilities.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10["playerGadget3.state"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "playerGadget3.state",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.viewmodelWeaponName, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "viewmodelWeaponName",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.weapon, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "weapon",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getglobalmodel"]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, "equippedWeaponReference", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "equippedWeaponReference",
		})
	end)
	clipGrid.id = "clipGrid"
	singleShotGrid.id = "singleShotGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_StockAmmo.__resetProperties = function(f20_arg0)
	f20_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
	f20_arg0.clipGrid:completeAnimation()
	f20_arg0.OverheatMeter:completeAnimation()
	f20_arg0.emptyPulse:completeAnimation()
	f20_arg0.singleShotGrid:completeAnimation()
	f20_arg0.AmmoWidgetVehicleReloadMeter:completeAnimation()
	f20_arg0.AmmoWidgetCurrentClipPip:setTopBottom(0, 0, 18, 90)
	f20_arg0.AmmoWidgetCurrentClipPip:setAlpha(1)
	f20_arg0.clipGrid:setAlpha(1)
	f20_arg0.OverheatMeter:setAlpha(0)
	f20_arg0.emptyPulse:setAlpha(1)
	f20_arg0.singleShotGrid:setAlpha(0)
	f20_arg0.AmmoWidgetVehicleReloadMeter:setAlpha(0)
end
CoD.AmmoWidget_StockAmmo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.clipGrid:completeAnimation()
			f21_arg0.clipGrid:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.clipGrid)
			f21_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f21_arg0.AmmoWidgetCurrentClipPip:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.AmmoWidgetCurrentClipPip)
		end,
		UsingPowerWeapon = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			local f22_local0 = function(f23_arg0)
				f22_arg0.clipGrid:beginAnimation(200)
				f22_arg0.clipGrid:setAlpha(0)
				f22_arg0.clipGrid:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.clipGrid:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.clipGrid:completeAnimation()
			f22_arg0.clipGrid:setAlpha(1)
			f22_local0(f22_arg0.clipGrid)
			local f22_local1 = function(f24_arg0)
				f22_arg0.AmmoWidgetCurrentClipPip:beginAnimation(200)
				f22_arg0.AmmoWidgetCurrentClipPip:setAlpha(0)
				f22_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f22_arg0.AmmoWidgetCurrentClipPip:setAlpha(1)
			f22_local1(f22_arg0.AmmoWidgetCurrentClipPip)
		end,
	},
	OverheatWeapon = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.OverheatMeter:completeAnimation()
			f25_arg0.OverheatMeter:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.OverheatMeter)
			f25_arg0.clipGrid:completeAnimation()
			f25_arg0.clipGrid:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.clipGrid)
			f25_arg0.emptyPulse:completeAnimation()
			f25_arg0.emptyPulse:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.emptyPulse)
		end,
	},
	UsingPowerWeapon = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.clipGrid:completeAnimation()
			f26_arg0.clipGrid:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.clipGrid)
			f26_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f26_arg0.AmmoWidgetCurrentClipPip:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.AmmoWidgetCurrentClipPip)
		end,
		DefaultState = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			local f27_local0 = function(f28_arg0)
				f27_arg0.clipGrid:beginAnimation(200)
				f27_arg0.clipGrid:setAlpha(1)
				f27_arg0.clipGrid:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.clipGrid:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.clipGrid:completeAnimation()
			f27_arg0.clipGrid:setAlpha(0)
			f27_local0(f27_arg0.clipGrid)
			local f27_local1 = function(f29_arg0)
				f27_arg0.AmmoWidgetCurrentClipPip:beginAnimation(200)
				f27_arg0.AmmoWidgetCurrentClipPip:setAlpha(1)
				f27_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f27_arg0.AmmoWidgetCurrentClipPip:setAlpha(0)
			f27_local1(f27_arg0.AmmoWidgetCurrentClipPip)
		end,
	},
	NoAmmoWeapon = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.clipGrid:completeAnimation()
			f30_arg0.clipGrid:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.clipGrid)
			f30_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f30_arg0.AmmoWidgetCurrentClipPip:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.AmmoWidgetCurrentClipPip)
		end,
		DefaultState = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			local f31_local0 = function(f32_arg0)
				f31_arg0.clipGrid:beginAnimation(200)
				f31_arg0.clipGrid:setAlpha(1)
				f31_arg0.clipGrid:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.clipGrid:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.clipGrid:completeAnimation()
			f31_arg0.clipGrid:setAlpha(0)
			f31_local0(f31_arg0.clipGrid)
			local f31_local1 = function(f33_arg0)
				f31_arg0.AmmoWidgetCurrentClipPip:beginAnimation(200)
				f31_arg0.AmmoWidgetCurrentClipPip:setAlpha(1)
				f31_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f31_arg0.AmmoWidgetCurrentClipPip:setAlpha(0)
			f31_local1(f31_arg0.AmmoWidgetCurrentClipPip)
		end,
	},
	SingleLoadWeapon = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(3)
			f34_arg0.clipGrid:completeAnimation()
			f34_arg0.clipGrid:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.clipGrid)
			f34_arg0.singleShotGrid:completeAnimation()
			f34_arg0.singleShotGrid:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.singleShotGrid)
			f34_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f34_arg0.AmmoWidgetCurrentClipPip:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.AmmoWidgetCurrentClipPip)
		end,
		ClipDropped = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			local f35_local0 = function(f36_arg0)
				f35_arg0.AmmoWidgetCurrentClipPip:beginAnimation(200)
				f35_arg0.AmmoWidgetCurrentClipPip:setTopBottom(0, 0, 115, 187)
				f35_arg0.AmmoWidgetCurrentClipPip:setAlpha(0)
				f35_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f35_arg0.AmmoWidgetCurrentClipPip:setTopBottom(0, 0, 10, 82)
			f35_arg0.AmmoWidgetCurrentClipPip:setAlpha(1)
			f35_local0(f35_arg0.AmmoWidgetCurrentClipPip)
		end,
		UsingPowerWeapon = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			local f37_local0 = function(f38_arg0)
				f37_arg0.clipGrid:beginAnimation(200)
				f37_arg0.clipGrid:setAlpha(0)
				f37_arg0.clipGrid:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.clipGrid:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.clipGrid:completeAnimation()
			f37_arg0.clipGrid:setAlpha(1)
			f37_local0(f37_arg0.clipGrid)
			local f37_local1 = function(f39_arg0)
				f37_arg0.AmmoWidgetCurrentClipPip:beginAnimation(200)
				f37_arg0.AmmoWidgetCurrentClipPip:setAlpha(0)
				f37_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.AmmoWidgetCurrentClipPip:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.AmmoWidgetCurrentClipPip:completeAnimation()
			f37_arg0.AmmoWidgetCurrentClipPip:setAlpha(1)
			f37_local1(f37_arg0.AmmoWidgetCurrentClipPip)
		end,
	},
	TankGunWZ = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(3)
			f40_arg0.AmmoWidgetVehicleReloadMeter:completeAnimation()
			f40_arg0.AmmoWidgetVehicleReloadMeter:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.AmmoWidgetVehicleReloadMeter)
			f40_arg0.clipGrid:completeAnimation()
			f40_arg0.clipGrid:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.clipGrid)
			f40_arg0.emptyPulse:completeAnimation()
			f40_arg0.emptyPulse:setAlpha(0)
			f40_arg0.clipFinished(f40_arg0.emptyPulse)
		end,
	},
}
CoD.AmmoWidget_StockAmmo.__onClose = function(f41_arg0)
	f41_arg0.AmmoWidgetVehicleReloadMeter:close()
	f41_arg0.OverheatMeter:close()
	f41_arg0.clipGrid:close()
	f41_arg0.singleShotGrid:close()
	f41_arg0.AmmoWidgetCurrentClipPip:close()
	f41_arg0.emptyPulse:close()
	f41_arg0.ammoType:close()
end
