require("x64:3a06c735b413259")
require("x64:7e7985b5baca412")
CoD.DirectorZMTrialsInfoDescriptionTall = InheritFrom(LUI.UIElement)
CoD.DirectorZMTrialsInfoDescriptionTall.__defaultWidth = 1190
CoD.DirectorZMTrialsInfoDescriptionTall.__defaultHeight = 696
CoD.DirectorZMTrialsInfoDescriptionTall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorZMTrialsInfoDescriptionTall)
	self.id = "DirectorZMTrialsInfoDescriptionTall"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bronze = CoD.InGameTrialsRulesColumnTall.new(f1_arg0, f1_arg1, 0.5, 0.5, -582, -194, 0.5, 0.5, -348, 457)
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
	Silver = CoD.InGameTrialsRulesColumnTall.new(f1_arg0, f1_arg1, 0.5, 0.5, -205, 183, 0.5, 0.5, -348, 457)
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
	Silver.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_silver_normal"))
	Silver.Medal:setImage(RegisterImage(@"uie_trial_medal_silver"))
	self:addElement(Silver)
	self.Silver = Silver
	Gold = CoD.InGameTrialsRulesColumnTall.new(f1_arg0, f1_arg1, 0.5, 0.5, 173, 561, 0.5, 0.5, -348, 457)
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
	Gold.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
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
	RoundDescriptionGrid:setTopBottom(0.5, 0.5, -251, 403)
	RoundDescriptionGrid:setScale(0.95, 0.95)
	RoundDescriptionGrid:setWidgetType(CoD.ZMAARTrialTabRoundStatTall)
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
CoD.DirectorZMTrialsInfoDescriptionTall.__resetProperties = function(f16_arg0)
	f16_arg0.Bronze:completeAnimation()
	f16_arg0.Silver:completeAnimation()
	f16_arg0.Gold:completeAnimation()
	f16_arg0.Bronze.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_bronze_normal"))
	f16_arg0.Bronze.Medal:setImage(RegisterImage(@"uie_trial_medal_bronze"))
	f16_arg0.Silver.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_silver_normal"))
	f16_arg0.Silver.Medal:setImage(RegisterImage(@"uie_trial_medal_silver"))
	f16_arg0.Gold.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
	f16_arg0.Gold.Medal:setImage(RegisterImage(@"uie_trial_medal_gold"))
end
CoD.DirectorZMTrialsInfoDescriptionTall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.Bronze:completeAnimation()
			f17_arg0.Bronze.BackgroundTall:completeAnimation()
			f17_arg0.Bronze.Medal:completeAnimation()
			f17_arg0.Bronze.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_bronze_normal"))
			f17_arg0.Bronze.Medal:setImage(RegisterImage(@"uie_trial_medal_bronze"))
			f17_arg0.clipFinished(f17_arg0.Bronze)
			f17_arg0.Silver:completeAnimation()
			f17_arg0.Silver.BackgroundTall:completeAnimation()
			f17_arg0.Silver.Medal:completeAnimation()
			f17_arg0.Silver.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_silver_normal"))
			f17_arg0.Silver.Medal:setImage(RegisterImage(@"uie_trial_medal_silver"))
			f17_arg0.clipFinished(f17_arg0.Silver)
			f17_arg0.Gold:completeAnimation()
			f17_arg0.Gold.BackgroundTall:completeAnimation()
			f17_arg0.Gold.Medal:completeAnimation()
			f17_arg0.Gold.BackgroundTall:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
			f17_arg0.Gold.Medal:setImage(RegisterImage(@"uie_trial_medal_gold"))
			f17_arg0.clipFinished(f17_arg0.Gold)
		end,
	},
	Variant1 = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.Bronze:completeAnimation()
			f18_arg0.Bronze.BackgroundTall:completeAnimation()
			f18_arg0.Bronze.Medal:completeAnimation()
			f18_arg0.Bronze.BackgroundTall:setImage(RegisterImage(@"hash_3BD93EB9B6EAD186"))
			f18_arg0.Bronze.Medal:setImage(RegisterImage(0x772C55AAA62BD0))
			f18_arg0.clipFinished(f18_arg0.Bronze)
			f18_arg0.Silver:completeAnimation()
			f18_arg0.Silver.BackgroundTall:completeAnimation()
			f18_arg0.Silver.Medal:completeAnimation()
			f18_arg0.Silver.BackgroundTall:setImage(RegisterImage(@"hash_34230D3A2AA576B2"))
			f18_arg0.Silver.Medal:setImage(RegisterImage(@"hash_FD6B3DF8A0BA964"))
			f18_arg0.clipFinished(f18_arg0.Silver)
			f18_arg0.Gold:completeAnimation()
			f18_arg0.Gold.BackgroundTall:completeAnimation()
			f18_arg0.Gold.Medal:completeAnimation()
			f18_arg0.Gold.BackgroundTall:setImage(RegisterImage(@"hash_3C026AC93C711B7D"))
			f18_arg0.Gold.Medal:setImage(RegisterImage(@"hash_18F9261A2CAA7739"))
			f18_arg0.clipFinished(f18_arg0.Gold)
		end,
	},
}
CoD.DirectorZMTrialsInfoDescriptionTall.__onClose = function(f19_arg0)
	f19_arg0.Bronze:close()
	f19_arg0.Silver:close()
	f19_arg0.Gold:close()
	f19_arg0.RoundDescriptionGrid:close()
end
