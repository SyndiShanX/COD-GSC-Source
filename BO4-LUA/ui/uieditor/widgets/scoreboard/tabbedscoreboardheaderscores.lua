require("x64:d92655a9482f98a")
require("x64:346d2bf5ef9d12a")
require("x64:64fdf03bb9ae249")
CoD.TabbedScoreboardHeaderScores = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeaderScores.__defaultWidth = 435
CoD.TabbedScoreboardHeaderScores.__defaultHeight = 69
CoD.TabbedScoreboardHeaderScores.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.TabbedScoreboardHeaderScores)
	self.id = "TabbedScoreboardHeaderScores"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FriendlyKills = CoD.TabbedScoreboardHeaderScoreFriendly.new(f1_arg0, f1_arg1, 0, 0, -158.5, -1.5, 0, 0, 2, 66)
	FriendlyKills:subscribeToGlobalModel(f1_arg1, "Factions", "playerFactionModel", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FriendlyKills:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(FriendlyKills)
	self.FriendlyKills = FriendlyKills
	local FriendlyControlRoundPips = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	FriendlyControlRoundPips:mergeStateConditions({
		{
			stateName = "JustComplete",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	FriendlyControlRoundPips:linkToElementModel(FriendlyControlRoundPips, "isComplete", true, function(model)
		f1_arg0:updateElementState(FriendlyControlRoundPips, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isComplete",
		})
	end)
	FriendlyControlRoundPips:setLeftRight(0, 0, -1.5, 182.5)
	FriendlyControlRoundPips:setTopBottom(0, 0, 9, 57)
	FriendlyControlRoundPips:setZRot(180)
	FriendlyControlRoundPips:setScale(0.8, 0.8)
	FriendlyControlRoundPips:setWidgetType(CoD.GameEndScoreRoundPip)
	FriendlyControlRoundPips:setSpacing(20)
	FriendlyControlRoundPips:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FriendlyControlRoundPips:setDataSource("PlayerTeamRoundPips")
	FriendlyControlRoundPips:subscribeToGlobalModel(f1_arg1, "GameScore", "roundWinLimit", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			FriendlyControlRoundPips:setHorizontalCount(f5_local0)
		end
	end)
	self:addElement(FriendlyControlRoundPips)
	self.FriendlyControlRoundPips = FriendlyControlRoundPips
	local spacer = LUI.UIImage.new(0, 0, 182.5, 256.5, 0, 0, -31, 97)
	spacer:setImage(RegisterImage(@"blacktransparent"))
	self:addElement(spacer)
	self.spacer = spacer
	local EnemyControlRoundPips = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	EnemyControlRoundPips:mergeStateConditions({
		{
			stateName = "JustComplete",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	EnemyControlRoundPips:linkToElementModel(EnemyControlRoundPips, "isComplete", true, function(model)
		f1_arg0:updateElementState(EnemyControlRoundPips, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isComplete",
		})
	end)
	EnemyControlRoundPips:setLeftRight(0, 0, 256.5, 440.5)
	EnemyControlRoundPips:setTopBottom(0, 0, 9, 57)
	EnemyControlRoundPips:setScale(0.8, 0.8)
	EnemyControlRoundPips:setWidgetType(CoD.GameEndScoreRoundPip)
	EnemyControlRoundPips:setSpacing(20)
	EnemyControlRoundPips:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EnemyControlRoundPips:setDataSource("EnemyTeamRoundPips")
	EnemyControlRoundPips:subscribeToGlobalModel(f1_arg1, "GameScore", "roundWinLimit", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			EnemyControlRoundPips:setHorizontalCount(f8_local0)
		end
	end)
	self:addElement(EnemyControlRoundPips)
	self.EnemyControlRoundPips = EnemyControlRoundPips
	local EnemyKills = CoD.TabbedScoreboardHeaderScoreEnemy.new(f1_arg0, f1_arg1, 0, 0, 440.5, 593.5, 0, 0, 2, 66)
	EnemyKills:subscribeToGlobalModel(f1_arg1, "Factions", "enemyFactionModel", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			EnemyKills:setModel(f9_local0, f1_arg1)
		end
	end)
	self:addElement(EnemyKills)
	self.EnemyKills = EnemyKills
	self:mergeStateConditions({
		{
			stateName = "NoRounds",
			condition = function(menu, element, event)
				return not CoD.GameTypeUtility.ShowRoundPips()
			end,
		},
		{
			stateName = "HideFactionScore",
			condition = function(menu, element, event)
				return CoD.GameTypeUtility.HideFactionScore()
			end,
		},
	})
	FriendlyControlRoundPips.id = "FriendlyControlRoundPips"
	EnemyControlRoundPips.id = "EnemyControlRoundPips"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardHeaderScores.__resetProperties = function(f12_arg0)
	f12_arg0.EnemyControlRoundPips:completeAnimation()
	f12_arg0.FriendlyControlRoundPips:completeAnimation()
	f12_arg0.spacer:completeAnimation()
	f12_arg0.FriendlyKills:completeAnimation()
	f12_arg0.EnemyKills:completeAnimation()
	f12_arg0.EnemyControlRoundPips:setAlpha(1)
	f12_arg0.FriendlyControlRoundPips:setAlpha(1)
	f12_arg0.spacer:setLeftRight(0, 0, 182.5, 256.5)
	f12_arg0.FriendlyKills:setAlpha(1)
	f12_arg0.EnemyKills:setAlpha(1)
end
CoD.TabbedScoreboardHeaderScores.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	NoRounds = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.FriendlyControlRoundPips:completeAnimation()
			f14_arg0.FriendlyControlRoundPips:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.FriendlyControlRoundPips)
			f14_arg0.spacer:completeAnimation()
			f14_arg0.spacer:setLeftRight(0, 0, 169.5, 269.5)
			f14_arg0.clipFinished(f14_arg0.spacer)
			f14_arg0.EnemyControlRoundPips:completeAnimation()
			f14_arg0.EnemyControlRoundPips:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.EnemyControlRoundPips)
		end,
	},
	HideFactionScore = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.FriendlyKills:completeAnimation()
			f15_arg0.FriendlyKills:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.FriendlyKills)
			f15_arg0.EnemyKills:completeAnimation()
			f15_arg0.EnemyKills:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.EnemyKills)
		end,
	},
}
CoD.TabbedScoreboardHeaderScores.__onClose = function(f16_arg0)
	f16_arg0.FriendlyKills:close()
	f16_arg0.FriendlyControlRoundPips:close()
	f16_arg0.EnemyControlRoundPips:close()
	f16_arg0.EnemyKills:close()
end
