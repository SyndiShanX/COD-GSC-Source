require("x64:7e7985b5baca412")
CoD.InGameTrialsRulesBackgroundTall = InheritFrom(LUI.UIElement)
CoD.InGameTrialsRulesBackgroundTall.__defaultWidth = 1188
CoD.InGameTrialsRulesBackgroundTall.__defaultHeight = 805
CoD.InGameTrialsRulesBackgroundTall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.InGameTrialsRulesBackgroundTall)
	self.id = "InGameTrialsRulesBackgroundTall"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bronze = CoD.InGameTrialsRulesColumnTall.new(f1_arg0, f1_arg1, 0.5, 0.5, -594, -206, 0.5, 0.5, -402.5, 402.5)
	Bronze:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsHighestTrialRoundSurvivedGreaterThanOrEqualTo(f1_arg1, 10)
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
	Silver = CoD.InGameTrialsRulesColumnTall.new(f1_arg0, f1_arg1, 0.5, 0.5, -196, 192, 0.5, 0.5, -402.5, 402.5)
	Silver:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsHighestTrialRoundSurvivedGreaterThanOrEqualTo(f1_arg1, 20)
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
	Silver.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_silver_normal"))
	Silver.Medal:setImage(RegisterImage(@"uie_trial_medal_silver"))
	self:addElement(Silver)
	self.Silver = Silver
	Gold = CoD.InGameTrialsRulesColumnTall.new(f1_arg0, f1_arg1, 0.5, 0.5, 202, 590, 0.5, 0.5, -402.5, 402.5)
	Gold:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsHighestTrialRoundSurvivedGreaterThanOrEqualTo(f1_arg1, 30)
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
	Gold.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
	Gold.Medal:setImage(RegisterImage(@"uie_trial_medal_gold"))
	self:addElement(Gold)
	self.Gold = Gold
	self:mergeStateConditions({
		{
			stateName = "Variant1",
			condition = function(menu, element, event)
				return IsGametypeSettingsValue("zmTrialsVariant", 1)
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InGameTrialsRulesBackgroundTall.__resetProperties = function(f12_arg0)
	f12_arg0.Bronze:completeAnimation()
	f12_arg0.Silver:completeAnimation()
	f12_arg0.Gold:completeAnimation()
	f12_arg0.Bronze.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_bronze_normal"))
	f12_arg0.Bronze.Medal:setImage(RegisterImage(@"uie_trial_medal_bronze"))
	f12_arg0.Silver.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_silver_normal"))
	f12_arg0.Silver.Medal:setImage(RegisterImage(@"uie_trial_medal_silver"))
	f12_arg0.Gold.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
	f12_arg0.Gold.Medal:setImage(RegisterImage(@"uie_trial_medal_gold"))
end
CoD.InGameTrialsRulesBackgroundTall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.Bronze:completeAnimation()
			f13_arg0.Bronze.BackgroundTall:completeAnimation()
			f13_arg0.Bronze.Medal:completeAnimation()
			f13_arg0.Bronze.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_bronze_normal"))
			f13_arg0.Bronze.Medal:setImage(RegisterImage(@"uie_trial_medal_bronze"))
			f13_arg0.clipFinished(f13_arg0.Bronze)
			f13_arg0.Silver:completeAnimation()
			f13_arg0.Silver.BackgroundTall:completeAnimation()
			f13_arg0.Silver.Medal:completeAnimation()
			f13_arg0.Silver.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_silver_normal"))
			f13_arg0.Silver.Medal:setImage(RegisterImage(@"uie_trial_medal_silver"))
			f13_arg0.clipFinished(f13_arg0.Silver)
			f13_arg0.Gold:completeAnimation()
			f13_arg0.Gold.BackgroundTall:completeAnimation()
			f13_arg0.Gold.Medal:completeAnimation()
			f13_arg0.Gold.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
			f13_arg0.Gold.Medal:setImage(RegisterImage(@"uie_trial_medal_gold"))
			f13_arg0.clipFinished(f13_arg0.Gold)
		end,
	},
	Variant1 = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.Bronze:completeAnimation()
			f14_arg0.Bronze.BackgroundTall:completeAnimation()
			f14_arg0.Bronze.Medal:completeAnimation()
			f14_arg0.Bronze.BackgroundTall:setImage(RegisterImage(@"hash_3BD93EB9B6EAD186"))
			f14_arg0.Bronze.Medal:setImage(RegisterImage(0x772C55AAA62BD0))
			f14_arg0.clipFinished(f14_arg0.Bronze)
			f14_arg0.Silver:completeAnimation()
			f14_arg0.Silver.BackgroundTall:completeAnimation()
			f14_arg0.Silver.Medal:completeAnimation()
			f14_arg0.Silver.BackgroundTall:setImage(RegisterImage(@"hash_34230D3A2AA576B2"))
			f14_arg0.Silver.Medal:setImage(RegisterImage(@"hash_FD6B3DF8A0BA964"))
			f14_arg0.clipFinished(f14_arg0.Silver)
			f14_arg0.Gold:completeAnimation()
			f14_arg0.Gold.BackgroundTall:completeAnimation()
			f14_arg0.Gold.Medal:completeAnimation()
			f14_arg0.Gold.BackgroundTall:setImage(RegisterImage(@"hash_3C026AC93C711B7D"))
			f14_arg0.Gold.Medal:setImage(RegisterImage(@"hash_18F9261A2CAA7739"))
			f14_arg0.clipFinished(f14_arg0.Gold)
		end,
	},
}
CoD.InGameTrialsRulesBackgroundTall.__onClose = function(f15_arg0)
	f15_arg0.Bronze:close()
	f15_arg0.Silver:close()
	f15_arg0.Gold:close()
end
