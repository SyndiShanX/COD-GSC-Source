require("x64:683120446682173")
require("x64:f72d4606ccc678a")
require("x64:6d8b28cbda2f13e")
require("x64:7553d3c19005336")
CoD.DoubleXPCardIconsInternal = InheritFrom(LUI.UIElement)
CoD.DoubleXPCardIconsInternal.__defaultWidth = 129
CoD.DoubleXPCardIconsInternal.__defaultHeight = 43
CoD.DoubleXPCardIconsInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.DoubleXPCardIconsInternal)
	self.id = "DoubleXPCardIconsInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DoubleXPIcon = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0, 0, 0, 43, 0, 0, 0, 43)
	DoubleXPIcon:mergeStateConditions({
		{
			stateName = "VisibleWZ",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasDoubleXP(f1_arg1, element) and CoD.DoubleXPUtility.HasMainMode(f1_arg1, element, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39])
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasDoubleXPOrPromotionalDoubleXP(f1_arg1, element)
			end,
		},
	})
	DoubleXPIcon:linkToElementModel(DoubleXPIcon, "hasDoubleXP", true, function(model)
		f1_arg0:updateElementState(DoubleXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasDoubleXP",
		})
	end)
	local TierBoost = DoubleXPIcon
	local DoubleWeaponXPIcon = DoubleXPIcon.subscribeToModel
	local ZMDoubleNPWidget = DataSources.PromotionalDoubleXP.getModel(f1_arg1)
	DoubleWeaponXPIcon(TierBoost, ZMDoubleNPWidget.dailyDoubleXPTimeLeft, function(f5_arg0)
		f1_arg0:updateElementState(DoubleXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "dailyDoubleXPTimeLeft",
		})
	end, false)
	TierBoost = DoubleXPIcon
	DoubleWeaponXPIcon = DoubleXPIcon.subscribeToModel
	ZMDoubleNPWidget = DataSources.AutoEvents.getModel(f1_arg1)
	DoubleWeaponXPIcon(TierBoost, ZMDoubleNPWidget.cycled, function(f6_arg0)
		f1_arg0:updateElementState(DoubleXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	DoubleXPIcon:linkToElementModel(self, nil, false, function(model)
		DoubleXPIcon:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	DoubleWeaponXPIcon = CoD.Notification2xpWeaponReward.new(f1_arg0, f1_arg1, 0, 0, 43, 86, 0, 0, 0, 43)
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
	ZMDoubleNPWidget = DoubleWeaponXPIcon
	TierBoost = DoubleWeaponXPIcon.subscribeToModel
	local f1_local5 = DataSources.AutoEvents.getModel(f1_arg1)
	TierBoost(ZMDoubleNPWidget, f1_local5.cycled, function(f10_arg0)
		f1_arg0:updateElementState(DoubleWeaponXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	DoubleWeaponXPIcon:linkToElementModel(self, nil, false, function(model)
		DoubleWeaponXPIcon:setModel(model, f1_arg1)
	end)
	self:addElement(DoubleWeaponXPIcon)
	self.DoubleWeaponXPIcon = DoubleWeaponXPIcon
	TierBoost = CoD.Notification2xpBlackMarketReward.new(f1_arg0, f1_arg1, 0, 0, 86, 129, 0, 0, 0, 43)
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
	ZMDoubleNPWidget = TierBoost.subscribeToModel
	local f1_local6 = DataSources.AutoEvents.getModel(f1_arg1)
	ZMDoubleNPWidget(f1_local5, f1_local6.cycled, function(f14_arg0)
		f1_arg0:updateElementState(TierBoost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	TierBoost:linkToElementModel(self, nil, false, function(model)
		TierBoost:setModel(model, f1_arg1)
	end)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	ZMDoubleNPWidget = CoD.ZMDoubleNPWidget.new(f1_arg0, f1_arg1, 0, 0, 129, 172, 0, 0, 0, 43)
	ZMDoubleNPWidget:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.HasDoubleNP(f1_arg1, element)
			end,
		},
	})
	f1_local6 = ZMDoubleNPWidget
	f1_local5 = ZMDoubleNPWidget.subscribeToModel
	local f1_local7 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local5(f1_local6, f1_local7.cycled, function(f17_arg0)
		f1_arg0:updateElementState(ZMDoubleNPWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	ZMDoubleNPWidget:linkToElementModel(self, nil, false, function(model)
		ZMDoubleNPWidget:setModel(model, f1_arg1)
	end)
	self:addElement(ZMDoubleNPWidget)
	self.ZMDoubleNPWidget = ZMDoubleNPWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPCardIconsInternal.__onClose = function(f19_arg0)
	f19_arg0.DoubleXPIcon:close()
	f19_arg0.DoubleWeaponXPIcon:close()
	f19_arg0.TierBoost:close()
	f19_arg0.ZMDoubleNPWidget:close()
end
