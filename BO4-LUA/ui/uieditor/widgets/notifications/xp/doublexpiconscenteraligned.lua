require("x64:683120446682173")
require("x64:6d8b28cbda2f13e")
require("x64:48e413a7c2e7936")
CoD.DoubleXPIconsCenterAligned = InheritFrom(LUI.UIElement)
CoD.DoubleXPIconsCenterAligned.__defaultWidth = 216
CoD.DoubleXPIconsCenterAligned.__defaultHeight = 72
CoD.DoubleXPIconsCenterAligned.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.DoubleXPIconsCenterAligned)
	self.id = "DoubleXPIconsCenterAligned"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DoubleXPIcon = CoD.DoubleXPPromotionalIcon.new(f1_arg0, f1_arg1, 0, 0, 0, 72, 0, 0, 0, 72)
	DoubleXPIcon:linkToElementModel(self, nil, false, function(model)
		DoubleXPIcon:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	local DoubleWeaponXPIcon = CoD.Notification2xpWeaponReward.new(f1_arg0, f1_arg1, 0, 0, 72, 144, 0, 0, 0, 72)
	DoubleWeaponXPIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasDoubleWeaponXP(f1_arg1, element)
			end,
		},
	})
	DoubleWeaponXPIcon:linkToElementModel(DoubleWeaponXPIcon, "hasDoubleWeaponXP", true, function(model)
		f1_arg0:updateElementState(DoubleWeaponXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasDoubleWeaponXP",
		})
	end)
	local f1_local3 = DoubleWeaponXPIcon
	local TierBoost = DoubleWeaponXPIcon.subscribeToModel
	local f1_local5 = DataSources.AutoEvents.getModel(f1_arg1)
	TierBoost(f1_local3, f1_local5.cycled, function(f5_arg0)
		f1_arg0:updateElementState(DoubleWeaponXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	DoubleWeaponXPIcon:linkToElementModel(self, nil, false, function(model)
		DoubleWeaponXPIcon:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleWeaponXPIcon)
	self.DoubleWeaponXPIcon = DoubleWeaponXPIcon
	TierBoost = CoD.Notification2xpBlackMarketReward.new(f1_arg0, f1_arg1, 0, 0, 144, 216, 0, 0, 0, 72)
	TierBoost:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasTierBoost(f1_arg1, element)
			end,
		},
	})
	TierBoost:linkToElementModel(TierBoost, "hasTierBoost", true, function(model)
		f1_arg0:updateElementState(TierBoost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasTierBoost",
		})
	end)
	f1_local5 = TierBoost
	f1_local3 = TierBoost.subscribeToModel
	local f1_local6 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local3(f1_local5, f1_local6.cycled, function(f9_arg0)
		f1_arg0:updateElementState(TierBoost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	TierBoost:linkToElementModel(self, nil, false, function(model)
		TierBoost:setModel(model, f1_arg1)
	end)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPIconsCenterAligned.__onClose = function(f11_arg0)
	f11_arg0.DoubleXPIcon:close()
	f11_arg0.DoubleWeaponXPIcon:close()
	f11_arg0.TierBoost:close()
end
