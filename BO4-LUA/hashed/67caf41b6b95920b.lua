require("x64:25acac8f33a8459")
CoD.InGameTrialsRulesBackground = InheritFrom(LUI.UIElement)
CoD.InGameTrialsRulesBackground.__defaultWidth = 1188
CoD.InGameTrialsRulesBackground.__defaultHeight = 696
CoD.InGameTrialsRulesBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.InGameTrialsRulesBackground)
	self.id = "InGameTrialsRulesBackground"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Bronze = CoD.InGameTrialsRulesColumn.new(f1_arg0, f1_arg1, 0.5, 0.5, -594, -206, 0.5, 0.5, -348, 348)
	Bronze:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsHighestRoundSurvivedGreaterThanOrEqualTo(f1_arg1, 10)
			end,
		},
		{
			stateName = "Awarded",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "ZMHudGlobal", "trials.roundNumber", 10)
			end,
		},
	})
	local Gold = Bronze
	local Silver = Bronze.subscribeToModel
	local f1_local4 = DataSources.ZMHudGlobal.getModel(f1_arg1)
	Silver(Gold, f1_local4["trials.roundNumber"], function(f4_arg0)
		f1_arg0:updateElementState(Bronze, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "trials.roundNumber",
		})
	end, false)
	self:addElement(Bronze)
	self.Bronze = Bronze
	Silver = CoD.InGameTrialsRulesColumn.new(f1_arg0, f1_arg1, 0.5, 0.5, -196, 192, 0.5, 0.5, -348, 348)
	Silver:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsHighestRoundSurvivedGreaterThanOrEqualTo(f1_arg1, 20)
			end,
		},
		{
			stateName = "Awarded",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "ZMHudGlobal", "trials.roundNumber", 20)
			end,
		},
	})
	f1_local4 = Silver
	Gold = Silver.subscribeToModel
	local f1_local5 = DataSources.ZMHudGlobal.getModel(f1_arg1)
	Gold(f1_local4, f1_local5["trials.roundNumber"], function(f7_arg0)
		f1_arg0:updateElementState(Silver, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "trials.roundNumber",
		})
	end, false)
	Silver.Background:setImage(RegisterImage(@"uie_trial_rules_silver_normal"))
	Silver.Medal:setImage(RegisterImage(@"uie_trial_medal_silver"))
	self:addElement(Silver)
	self.Silver = Silver
	Gold = CoD.InGameTrialsRulesColumn.new(f1_arg0, f1_arg1, 0.5, 0.5, 202, 590, 0.5, 0.5, -348, 348)
	Gold:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsHighestRoundSurvivedGreaterThanOrEqualTo(f1_arg1, 30)
			end,
		},
		{
			stateName = "Awarded",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "ZMHudGlobal", "trials.roundNumber", 30)
			end,
		},
	})
	f1_local5 = Gold
	f1_local4 = Gold.subscribeToModel
	local f1_local6 = DataSources.ZMHudGlobal.getModel(f1_arg1)
	f1_local4(f1_local5, f1_local6["trials.roundNumber"], function(f10_arg0)
		f1_arg0:updateElementState(Gold, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "trials.roundNumber",
		})
	end, false)
	Gold.Background:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
	Gold.Medal:setImage(RegisterImage(@"uie_trial_medal_gold"))
	self:addElement(Gold)
	self.Gold = Gold
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InGameTrialsRulesBackground.__onClose = function(f11_arg0)
	f11_arg0.Bronze:close()
	f11_arg0.Silver:close()
	f11_arg0.Gold:close()
end
