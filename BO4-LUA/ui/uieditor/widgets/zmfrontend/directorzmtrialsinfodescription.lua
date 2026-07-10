require("x64:91ac5934d0654c2")
require("x64:25acac8f33a8459")
CoD.DirectorZMTrialsInfoDescription = InheritFrom(LUI.UIElement)
CoD.DirectorZMTrialsInfoDescription.__defaultWidth = 1190
CoD.DirectorZMTrialsInfoDescription.__defaultHeight = 696
CoD.DirectorZMTrialsInfoDescription.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorZMTrialsInfoDescription)
	self.id = "DirectorZMTrialsInfoDescription"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Bronze = CoD.InGameTrialsRulesColumn.new(f1_arg0, f1_arg1, 0.5, 0.5, -582, -194, 0.5, 0.5, -348, 348)
	Bronze:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DirectorZMPlaylistInfo", "bronzeComplete")
			end,
		},
		{
			stateName = "Awarded",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local Gold = Bronze
	local Silver = Bronze.subscribeToModel
	local RoundDescriptionGrid = DataSources.DirectorZMPlaylistInfo.getModel(f1_arg1)
	Silver(Gold, RoundDescriptionGrid.bronzeComplete, function(f4_arg0)
		f1_arg0:updateElementState(Bronze, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "bronzeComplete",
		})
	end, false)
	Bronze:setScale(0.95, 0.95)
	self:addElement(Bronze)
	self.Bronze = Bronze
	Silver = CoD.InGameTrialsRulesColumn.new(f1_arg0, f1_arg1, 0.5, 0.5, -205, 183, 0.5, 0.5, -348, 348)
	Silver:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DirectorZMPlaylistInfo", "silverComplete")
			end,
		},
		{
			stateName = "Awarded",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	RoundDescriptionGrid = Silver
	Gold = Silver.subscribeToModel
	local f1_local5 = DataSources.DirectorZMPlaylistInfo.getModel(f1_arg1)
	Gold(RoundDescriptionGrid, f1_local5.silverComplete, function(f7_arg0)
		f1_arg0:updateElementState(Silver, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "silverComplete",
		})
	end, false)
	Silver:setScale(0.95, 0.95)
	Silver.Background:setImage(RegisterImage(@"uie_trial_rules_silver_normal"))
	Silver.Medal:setImage(RegisterImage(@"uie_trial_medal_silver"))
	self:addElement(Silver)
	self.Silver = Silver
	Gold = CoD.InGameTrialsRulesColumn.new(f1_arg0, f1_arg1, 0.5, 0.5, 173, 561, 0.5, 0.5, -348, 348)
	Gold:mergeStateConditions({
		{
			stateName = "AwardedCopy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DirectorZMPlaylistInfo", "goldComplete")
			end,
		},
		{
			stateName = "Awarded",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	f1_local5 = Gold
	RoundDescriptionGrid = Gold.subscribeToModel
	local f1_local6 = DataSources.DirectorZMPlaylistInfo.getModel(f1_arg1)
	RoundDescriptionGrid(f1_local5, f1_local6.goldComplete, function(f10_arg0)
		f1_arg0:updateElementState(Gold, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "goldComplete",
		})
	end, false)
	Gold:setScale(0.95, 0.95)
	Gold.Background:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
	Gold.Medal:setImage(RegisterImage(@"uie_trial_medal_gold"))
	self:addElement(Gold)
	self.Gold = Gold
	RoundDescriptionGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 6, 0, nil, nil, false, false, false, false)
	RoundDescriptionGrid:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Focused",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "PreviouslyCompleted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "shown")
			end,
		},
		{
			stateName = "Incomplete",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	RoundDescriptionGrid:linkToElementModel(RoundDescriptionGrid, "shown", true, function(model)
		f1_arg0:updateElementState(RoundDescriptionGrid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "shown",
		})
	end)
	RoundDescriptionGrid:setLeftRight(0.5, 0.5, -595, 587)
	RoundDescriptionGrid:setTopBottom(0.5, 0.5, -251, 303)
	RoundDescriptionGrid:setScale(0.95, 0.95)
	RoundDescriptionGrid:setWidgetType(CoD.ZMAARTrialTabRoundStat)
	RoundDescriptionGrid:setHorizontalCount(3)
	RoundDescriptionGrid:setVerticalCount(10)
	RoundDescriptionGrid:setSpacing(6)
	RoundDescriptionGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RoundDescriptionGrid:setDataSource("ZMTrialInfoRoundStat")
	self:addElement(RoundDescriptionGrid)
	self.RoundDescriptionGrid = RoundDescriptionGrid
	RoundDescriptionGrid.id = "RoundDescriptionGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorZMTrialsInfoDescription.__onClose = function(f16_arg0)
	f16_arg0.Bronze:close()
	f16_arg0.Silver:close()
	f16_arg0.Gold:close()
	f16_arg0.RoundDescriptionGrid:close()
end
