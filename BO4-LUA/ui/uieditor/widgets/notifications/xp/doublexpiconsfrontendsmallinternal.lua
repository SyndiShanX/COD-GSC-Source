require("x64:683120446682173")
require("x64:f72d4606ccc678a")
require("x64:6d8b28cbda2f13e")
require("x64:7553d3c19005336")
CoD.DoubleXPIconsFrontendSmallInternal = InheritFrom(LUI.UIElement)
CoD.DoubleXPIconsFrontendSmallInternal.__defaultWidth = 216
CoD.DoubleXPIconsFrontendSmallInternal.__defaultHeight = 48
CoD.DoubleXPIconsFrontendSmallInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.DoubleXPIconsFrontendSmallInternal)
	self.id = "DoubleXPIconsFrontendSmallInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local DoubleXPIcon = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0, 0, 0, 48, 0, 0, 0, 48)
	DoubleXPIcon:mergeStateConditions({
		{
			stateName = "VisibleWZ",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f1_arg1) and CoD.DoubleXPUtility.CurrentPlaylistHasMainMode(f1_arg1, Enum[@"emodes"][@"mode_warzone"])
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.CurrentPlaylistHasDoubleXP(f1_arg1)
			end,
		},
	})
	local TierBoost = DoubleXPIcon
	local DoubleWeaponXPIcon = DoubleXPIcon.subscribeToModel
	local ZMDoubleNPWidget = Engine[@"getglobalmodel"]()
	DoubleWeaponXPIcon(TierBoost, ZMDoubleNPWidget["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(DoubleXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	TierBoost = DoubleXPIcon
	DoubleWeaponXPIcon = DoubleXPIcon.subscribeToModel
	ZMDoubleNPWidget = Engine[@"getglobalmodel"]()
	DoubleWeaponXPIcon(TierBoost, ZMDoubleNPWidget["lobbyRoot.playlistId"], function(f5_arg0)
		f1_arg0:updateElementState(DoubleXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.playlistId",
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
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	DoubleWeaponXPIcon = CoD.Notification2xpWeaponReward.new(f1_arg0, f1_arg1, 0, 0, 48, 96, 0, 0, 0, 48)
	DoubleWeaponXPIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.CurrentPlaylistHasDoubleWeaponXP(f1_arg1)
			end,
		},
	})
	ZMDoubleNPWidget = DoubleWeaponXPIcon
	TierBoost = DoubleWeaponXPIcon.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	TierBoost(ZMDoubleNPWidget, f1_local5["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(DoubleWeaponXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ZMDoubleNPWidget = DoubleWeaponXPIcon
	TierBoost = DoubleWeaponXPIcon.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	TierBoost(ZMDoubleNPWidget, f1_local5["lobbyRoot.playlistId"], function(f9_arg0)
		f1_arg0:updateElementState(DoubleWeaponXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.playlistId",
		})
	end, false)
	ZMDoubleNPWidget = DoubleWeaponXPIcon
	TierBoost = DoubleWeaponXPIcon.subscribeToModel
	f1_local5 = DataSources.AutoEvents.getModel(f1_arg1)
	TierBoost(ZMDoubleNPWidget, f1_local5.cycled, function(f10_arg0)
		f1_arg0:updateElementState(DoubleWeaponXPIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	self:addElement(DoubleWeaponXPIcon)
	self.DoubleWeaponXPIcon = DoubleWeaponXPIcon
	TierBoost = CoD.Notification2xpBlackMarketReward.new(f1_arg0, f1_arg1, 0, 0, 96, 144, 0, 0, 0, 48)
	TierBoost:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DoubleXPUtility.CurrentLobbyHasTierBoost(f1_arg1)
			end,
		},
	})
	f1_local5 = TierBoost
	ZMDoubleNPWidget = TierBoost.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	ZMDoubleNPWidget(f1_local5, f1_local6["lobbyRoot.lobbyMainMode"], function(f12_arg0)
		f1_arg0:updateElementState(TierBoost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	ZMDoubleNPWidget = CoD.ZMDoubleNPWidget.new(f1_arg0, f1_arg1, 0, 0, 144, 192, 0, 0, 0, 48)
	self:addElement(ZMDoubleNPWidget)
	self.ZMDoubleNPWidget = ZMDoubleNPWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DoubleXPIconsFrontendSmallInternal.__onClose = function(f13_arg0)
	f13_arg0.DoubleXPIcon:close()
	f13_arg0.DoubleWeaponXPIcon:close()
	f13_arg0.TierBoost:close()
	f13_arg0.ZMDoubleNPWidget:close()
end
