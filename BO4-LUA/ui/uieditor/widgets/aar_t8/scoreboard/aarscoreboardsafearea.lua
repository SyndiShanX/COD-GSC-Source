require("x64:38716dffd7a5258")
CoD.AARScoreboardSafeArea = InheritFrom(LUI.UIElement)
CoD.AARScoreboardSafeArea.__defaultWidth = 1920
CoD.AARScoreboardSafeArea.__defaultHeight = 800
CoD.AARScoreboardSafeArea.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARScoreboardSafeArea)
	self.id = "AARScoreboardSafeArea"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local ScoreboardGameStatusScores = CoD.ScoreboardGameStatusScores.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -178.5, 21.5)
	ScoreboardGameStatusScores:mergeStateConditions({
		{
			stateName = "HiddenByEvent",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "TDM",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("tdm", f1_arg1)
			end,
		},
		{
			stateName = "Dom",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("dom", f1_arg1)
			end,
		},
		{
			stateName = "Control",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("control", f1_arg1)
			end,
		},
		{
			stateName = "Hardpoint",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("koth", f1_arg1)
			end,
		},
		{
			stateName = "SearchDestroy",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("sd", f1_arg1)
			end,
		},
		{
			stateName = "Bounty",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("bounty", f1_arg1)
			end,
		},
		{
			stateName = "FFA",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("dm", f1_arg1)
			end,
		},
		{
			stateName = "Gun",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("gun", f1_arg1)
			end,
		},
		{
			stateName = "Escort",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("escort", f1_arg1)
			end,
		},
		{
			stateName = "Infect",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGameTypeEqualToString("infect", f1_arg1)
			end,
		},
	})
	local f1_local2 = ScoreboardGameStatusScores
	local f1_local3 = ScoreboardGameStatusScores.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["factions.isCoDCaster"], function(f13_arg0)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local2 = ScoreboardGameStatusScores
	f1_local3 = ScoreboardGameStatusScores.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["scoreboard.team1.count"], function(f14_arg0)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "scoreboard.team1.count",
		})
	end, false)
	f1_local2 = ScoreboardGameStatusScores
	f1_local3 = ScoreboardGameStatusScores.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["scoreboard.team2.count"], function(f15_arg0)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "scoreboard.team2.count",
		})
	end, false)
	ScoreboardGameStatusScores:linkToElementModel(ScoreboardGameStatusScores, "scoreboard.characterIndex", true, function(model)
		f1_arg0:updateElementState(ScoreboardGameStatusScores, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "scoreboard.characterIndex",
		})
	end)
	ScoreboardGameStatusScores.ScoreboardButtonPrompts:setAlpha(0)
	self:addElement(ScoreboardGameStatusScores)
	self.ScoreboardGameStatusScores = ScoreboardGameStatusScores
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.ScoreboardUtility.SetupFooterSubscription(self.ScoreboardGameStatusScores, f1_arg1)
	return self
end
CoD.AARScoreboardSafeArea.__onClose = function(f17_arg0)
	f17_arg0.ScoreboardGameStatusScores:close()
end
