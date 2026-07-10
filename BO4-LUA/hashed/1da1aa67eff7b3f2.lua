require("x64:2abde9eba54acd9")
CoD.WarScoreInfo_Deliver_ProgressBar = InheritFrom(LUI.UIElement)
CoD.WarScoreInfo_Deliver_ProgressBar.__defaultWidth = 400
CoD.WarScoreInfo_Deliver_ProgressBar.__defaultHeight = 20
CoD.WarScoreInfo_Deliver_ProgressBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarScoreInfo_Deliver_ProgressBar)
	self.id = "WarScoreInfo_Deliver_ProgressBar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local FlagStateWidget1 = CoD.WarScoreInfo_Deliver_FlagStateWidget.new(f1_arg0, f1_arg1, 0, 0, 5, 195, 0, 0, 0, 20)
	FlagStateWidget1:mergeStateConditions({
		{
			stateName = "Home",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState1", CoD.HUDUtility.BATTERY_STATE_HOME)
			end,
		},
		{
			stateName = "Delivered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState1", CoD.HUDUtility.BATTERY_STATE_DELIVERED)
			end,
		},
		{
			stateName = "Carried",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState1", CoD.HUDUtility.BATTERY_STATE_CARRIED) and CoD.ModelUtility.IsGlobalModelValueEqualToSelfTeam(f1_arg1, "hudItems.war.attackingTeam")
			end,
		},
		{
			stateName = "Away",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState1", CoD.HUDUtility.BATTERY_STATE_AWAY)
			end,
		},
		{
			stateName = "Destroy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState1", CoD.HUDUtility.BATTERY_STATE_ATTACKED)
			end,
		},
		{
			stateName = "CarriedDefender",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState1", CoD.HUDUtility.BATTERY_STATE_CARRIED) and not CoD.ModelUtility.IsGlobalModelValueEqualToSelfTeam(f1_arg1, "hudItems.war.attackingTeam")
			end,
		},
	})
	local f1_local2 = FlagStateWidget1
	local FlagStateWidget2 = FlagStateWidget1.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	FlagStateWidget2(f1_local2, f1_local4["hudItems.war.batteryState1"], function(f8_arg0)
		f1_arg0:updateElementState(FlagStateWidget1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.war.batteryState1",
		})
	end, false)
	f1_local2 = FlagStateWidget1
	FlagStateWidget2 = FlagStateWidget1.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	FlagStateWidget2(f1_local2, f1_local4["hudItems.war.attackingTeam"], function(f9_arg0)
		f1_arg0:updateElementState(FlagStateWidget1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.war.attackingTeam",
		})
	end, false)
	f1_local2 = FlagStateWidget1
	FlagStateWidget2 = FlagStateWidget1.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	FlagStateWidget2(f1_local2, f1_local4["factions.playerFactionTeamEnum"], function(f10_arg0)
		f1_arg0:updateElementState(FlagStateWidget1, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "factions.playerFactionTeamEnum",
		})
	end, false)
	self:addElement(FlagStateWidget1)
	self.FlagStateWidget1 = FlagStateWidget1
	FlagStateWidget2 = CoD.WarScoreInfo_Deliver_FlagStateWidget.new(f1_arg0, f1_arg1, 0, 0, 205, 395, 0, 0, 0, 20)
	FlagStateWidget2:mergeStateConditions({
		{
			stateName = "Home",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState2", CoD.HUDUtility.BATTERY_STATE_HOME)
			end,
		},
		{
			stateName = "Delivered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState2", CoD.HUDUtility.BATTERY_STATE_DELIVERED)
			end,
		},
		{
			stateName = "Carried",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState2", CoD.HUDUtility.BATTERY_STATE_CARRIED) and CoD.ModelUtility.IsGlobalModelValueEqualToSelfTeam(f1_arg1, "hudItems.war.attackingTeam")
			end,
		},
		{
			stateName = "Away",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState2", CoD.HUDUtility.BATTERY_STATE_AWAY)
			end,
		},
		{
			stateName = "Destroy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState2", CoD.HUDUtility.BATTERY_STATE_ATTACKED)
			end,
		},
		{
			stateName = "CarriedDefender",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.war.batteryState2", CoD.HUDUtility.BATTERY_STATE_CARRIED) and not CoD.ModelUtility.IsGlobalModelValueEqualToSelfTeam(f1_arg1, "hudItems.war.attackingTeam")
			end,
		},
	})
	f1_local4 = FlagStateWidget2
	f1_local2 = FlagStateWidget2.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["hudItems.war.batteryState2"], function(f17_arg0)
		f1_arg0:updateElementState(FlagStateWidget2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "hudItems.war.batteryState2",
		})
	end, false)
	f1_local4 = FlagStateWidget2
	f1_local2 = FlagStateWidget2.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["hudItems.war.attackingTeam"], function(f18_arg0)
		f1_arg0:updateElementState(FlagStateWidget2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "hudItems.war.attackingTeam",
		})
	end, false)
	f1_local4 = FlagStateWidget2
	f1_local2 = FlagStateWidget2.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5["factions.playerFactionTeamEnum"], function(f19_arg0)
		f1_arg0:updateElementState(FlagStateWidget2, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "factions.playerFactionTeamEnum",
		})
	end, false)
	self:addElement(FlagStateWidget2)
	self.FlagStateWidget2 = FlagStateWidget2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarScoreInfo_Deliver_ProgressBar.__onClose = function(f20_arg0)
	f20_arg0.FlagStateWidget1:close()
	f20_arg0.FlagStateWidget2:close()
end
