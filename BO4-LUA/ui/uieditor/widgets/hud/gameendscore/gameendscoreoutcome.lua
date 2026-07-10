require("x64:c792dff66efd1a2")
require("x64:795a0c7c6fc136d")
require("x64:c0e5e43ea9f279d")
require("x64:429130902fd2672")
require("x64:1938733d0061a46")
CoD.GameEndScoreOutcome = InheritFrom(LUI.UIElement)
CoD.GameEndScoreOutcome.__defaultWidth = 1920
CoD.GameEndScoreOutcome.__defaultHeight = 220
CoD.GameEndScoreOutcome.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	DataSourceHelperGetModel(f1_arg1, "CTFLevelInfo")
	self:setClass(CoD.GameEndScoreOutcome)
	self.id = "GameEndScoreOutcome"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CenterWidget = CoD.GameEndScoreCenterWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -110, 110)
	CenterWidget:setAlpha(0.5)
	self:addElement(CenterWidget)
	self.CenterWidget = CenterWidget
	local PlayerRoundScore = CoD.GameEndScoreRoundText.new(f1_arg0, f1_arg1, 0.5, 0.5, -936, -722, 0.5, 0.5, -64.5, 64.5)
	PlayerRoundScore:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PlayerRoundScore:subscribeToGlobalModel(f1_arg1, "GameScore", "playerScoreOrTime", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerRoundScore.RoundScore:setText(f2_local0)
		end
	end)
	self:addElement(PlayerRoundScore)
	self.PlayerRoundScore = PlayerRoundScore
	local EnemyRoundScore = CoD.GameEndScoreRoundText.new(f1_arg0, f1_arg1, 0.5, 0.5, 722, 936, 0.5, 0.5, -64.5, 64.5)
	EnemyRoundScore:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EnemyRoundScore:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScoreOrTime", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EnemyRoundScore.RoundScore:setText(f3_local0)
		end
	end)
	self:addElement(EnemyRoundScore)
	self.EnemyRoundScore = EnemyRoundScore
	local EnemyRoundPipList = CoD.GameEndScoreRoundList.new(f1_arg0, f1_arg1, 0.5, 0.5, 384, 700, 0.5, 0.5, -42, 32)
	EnemyRoundPipList.RoundPipList:setDataSource("EnemyTeamRoundPips")
	EnemyRoundPipList:subscribeToGlobalModel(f1_arg1, "GameScore", "enemyScoreOrTime", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			EnemyRoundPipList.Score:setText(f4_local0)
		end
	end)
	self:addElement(EnemyRoundPipList)
	self.EnemyRoundPipList = EnemyRoundPipList
	local PlayerRoundPipList = CoD.GameEndScoreRoundListReverse.new(f1_arg0, f1_arg1, 0.5, 0.5, -700, -384, 0.5, 0.5, -42, 32)
	PlayerRoundPipList.RoundPipList:setDataSource("PlayerTeamRoundPips")
	PlayerRoundPipList:subscribeToGlobalModel(f1_arg1, "GameScore", "playerScoreOrTime", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			PlayerRoundPipList.Score:setText(f5_local0)
		end
	end)
	self:addElement(PlayerRoundPipList)
	self.PlayerRoundPipList = PlayerRoundPipList
	local PlayerRoundTime = CoD.GameEndTime.new(f1_arg0, f1_arg1, 0, 0, 260, 576, 0, 0, 68, 142)
	PlayerRoundTime:setAlpha(0)
	PlayerRoundTime:subscribeToGlobalModel(f1_arg1, "CTFLevelInfo", "BestTimeAllies", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			PlayerRoundTime.Score:setText(SecondsAsTimeDashedZero(f6_local0))
		end
	end)
	self:addElement(PlayerRoundTime)
	self.PlayerRoundTime = PlayerRoundTime
	local EnemyRoundTime = CoD.GameEndTime.new(f1_arg0, f1_arg1, 0, 0, 1344, 1660, 0, 0, 68, 142)
	EnemyRoundTime:setAlpha(0)
	EnemyRoundTime:subscribeToGlobalModel(f1_arg1, "CTFLevelInfo", "bestTimeAxis", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			EnemyRoundTime.Score:setText(SecondsAsTimeDashedZero(f7_local0))
		end
	end)
	self:addElement(EnemyRoundTime)
	self.EnemyRoundTime = EnemyRoundTime
	self:mergeStateConditions({
		{
			stateName = "Outcome",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowOutcomeTransition(f1_arg1)
			end,
		},
		{
			stateName = "OutcomeWithScore",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowOutcomeWithScoreTransition(f1_arg1)
			end,
		},
		{
			stateName = "OutcomeWithTimeAxis",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowOutcomeWithTimeTransition(f1_arg1) and CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "factions.actualTeam", Enum[@"team_t"][@"team_axis"])
			end,
		},
		{
			stateName = "OutcomeWithTime",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowOutcomeWithTimeTransition(f1_arg1)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["gameScore.currentState"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "gameScore.currentState",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.forceScoreboard, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["factions.actualTeam"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "factions.actualTeam",
		})
	end, false)
	EnemyRoundPipList.id = "EnemyRoundPipList"
	PlayerRoundPipList.id = "PlayerRoundPipList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreOutcome.__resetProperties = function(f19_arg0)
	f19_arg0.EnemyRoundPipList:completeAnimation()
	f19_arg0.CenterWidget:completeAnimation()
	f19_arg0.EnemyRoundScore:completeAnimation()
	f19_arg0.PlayerRoundScore:completeAnimation()
	f19_arg0.PlayerRoundPipList:completeAnimation()
	f19_arg0.PlayerRoundTime:completeAnimation()
	f19_arg0.EnemyRoundTime:completeAnimation()
	f19_arg0.EnemyRoundPipList:setAlpha(1)
	f19_arg0.CenterWidget:setAlpha(0.5)
	f19_arg0.EnemyRoundScore:setAlpha(1)
	f19_arg0.PlayerRoundScore:setAlpha(1)
	f19_arg0.PlayerRoundPipList:setAlpha(1)
	f19_arg0.PlayerRoundTime:setLeftRight(0, 0, 260, 576)
	f19_arg0.PlayerRoundTime:setAlpha(0)
	f19_arg0.EnemyRoundTime:setLeftRight(0, 0, 1344, 1660)
	f19_arg0.EnemyRoundTime:setAlpha(0)
end
CoD.GameEndScoreOutcome.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(5)
			f20_arg0.CenterWidget:completeAnimation()
			f20_arg0.CenterWidget:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CenterWidget)
			f20_arg0.PlayerRoundScore:completeAnimation()
			f20_arg0.PlayerRoundScore:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PlayerRoundScore)
			f20_arg0.EnemyRoundScore:completeAnimation()
			f20_arg0.EnemyRoundScore:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.EnemyRoundScore)
			f20_arg0.EnemyRoundPipList:completeAnimation()
			f20_arg0.EnemyRoundPipList:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.EnemyRoundPipList)
			f20_arg0.PlayerRoundPipList:completeAnimation()
			f20_arg0.PlayerRoundPipList:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PlayerRoundPipList)
		end,
	},
	Outcome = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(5)
			f21_arg0.CenterWidget:completeAnimation()
			f21_arg0.CenterWidget:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.CenterWidget)
			f21_arg0.PlayerRoundScore:completeAnimation()
			f21_arg0.PlayerRoundScore:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PlayerRoundScore)
			f21_arg0.EnemyRoundScore:completeAnimation()
			f21_arg0.EnemyRoundScore:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.EnemyRoundScore)
			f21_arg0.EnemyRoundPipList:completeAnimation()
			f21_arg0.EnemyRoundPipList:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.EnemyRoundPipList)
			f21_arg0.PlayerRoundPipList:completeAnimation()
			f21_arg0.PlayerRoundPipList:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PlayerRoundPipList)
		end,
	},
	OutcomeWithScore = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(5)
			f22_arg0.CenterWidget:completeAnimation()
			f22_arg0.CenterWidget:setAlpha(1)
			f22_arg0.CenterWidget:playClip("DefaultClip")
			f22_arg0.clipFinished(f22_arg0.CenterWidget)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_in"])
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.PlayerRoundScore:beginAnimation(1000)
				f22_arg0.PlayerRoundScore:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.PlayerRoundScore:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.PlayerRoundScore:completeAnimation()
			f22_arg0.PlayerRoundScore:setAlpha(0)
			f22_local0(f22_arg0.PlayerRoundScore)
			local f22_local1 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_in"])
					f26_arg0:setAlpha(1)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.EnemyRoundScore:beginAnimation(1000)
				f22_arg0.EnemyRoundScore:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.EnemyRoundScore:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f22_arg0.EnemyRoundScore:completeAnimation()
			f22_arg0.EnemyRoundScore:setAlpha(0)
			f22_local1(f22_arg0.EnemyRoundScore)
			local f22_local2 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_in"])
					f28_arg0:setAlpha(1)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.EnemyRoundPipList:beginAnimation(1000)
				f22_arg0.EnemyRoundPipList:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.EnemyRoundPipList:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f22_arg0.EnemyRoundPipList:completeAnimation()
			f22_arg0.EnemyRoundPipList:setAlpha(0)
			f22_local2(f22_arg0.EnemyRoundPipList)
			local f22_local3 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_in"])
					f30_arg0:setAlpha(1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
				end
				f22_arg0.PlayerRoundPipList:beginAnimation(1000)
				f22_arg0.PlayerRoundPipList:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.PlayerRoundPipList:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f22_arg0.PlayerRoundPipList:completeAnimation()
			f22_arg0.PlayerRoundPipList:setAlpha(0)
			f22_local3(f22_arg0.PlayerRoundPipList)
		end,
	},
	OutcomeWithTimeAxis = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(7)
			f31_arg0.CenterWidget:completeAnimation()
			f31_arg0.CenterWidget:setAlpha(1)
			f31_arg0.CenterWidget:playClip("DefaultClip")
			f31_arg0.clipFinished(f31_arg0.CenterWidget)
			f31_arg0.PlayerRoundScore:completeAnimation()
			f31_arg0.PlayerRoundScore:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.PlayerRoundScore)
			f31_arg0.EnemyRoundScore:completeAnimation()
			f31_arg0.EnemyRoundScore:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EnemyRoundScore)
			f31_arg0.EnemyRoundPipList:completeAnimation()
			f31_arg0.EnemyRoundPipList:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EnemyRoundPipList)
			f31_arg0.PlayerRoundPipList:completeAnimation()
			f31_arg0.PlayerRoundPipList:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.PlayerRoundPipList)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(450)
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.PlayerRoundTime:beginAnimation(1000)
				f31_arg0.PlayerRoundTime:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.PlayerRoundTime:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.PlayerRoundTime:completeAnimation()
			f31_arg0.PlayerRoundTime:setLeftRight(0, 0, 1344, 1660)
			f31_arg0.PlayerRoundTime:setAlpha(0)
			f31_local0(f31_arg0.PlayerRoundTime)
			local f31_local1 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(450)
					f35_arg0:setAlpha(1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.EnemyRoundTime:beginAnimation(1000)
				f31_arg0.EnemyRoundTime:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.EnemyRoundTime:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f31_arg0.EnemyRoundTime:completeAnimation()
			f31_arg0.EnemyRoundTime:setLeftRight(0, 0, 238, 554)
			f31_arg0.EnemyRoundTime:setAlpha(0)
			f31_local1(f31_arg0.EnemyRoundTime)
		end,
	},
	OutcomeWithTime = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(7)
			f36_arg0.CenterWidget:completeAnimation()
			f36_arg0.CenterWidget:setAlpha(1)
			f36_arg0.CenterWidget:playClip("DefaultClip")
			f36_arg0.clipFinished(f36_arg0.CenterWidget)
			f36_arg0.PlayerRoundScore:completeAnimation()
			f36_arg0.PlayerRoundScore:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.PlayerRoundScore)
			f36_arg0.EnemyRoundScore:completeAnimation()
			f36_arg0.EnemyRoundScore:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.EnemyRoundScore)
			f36_arg0.EnemyRoundPipList:completeAnimation()
			f36_arg0.EnemyRoundPipList:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.EnemyRoundPipList)
			f36_arg0.PlayerRoundPipList:completeAnimation()
			f36_arg0.PlayerRoundPipList:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.PlayerRoundPipList)
			local f36_local0 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(450)
					f38_arg0:setAlpha(1)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.PlayerRoundTime:beginAnimation(1000)
				f36_arg0.PlayerRoundTime:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.PlayerRoundTime:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f36_arg0.PlayerRoundTime:completeAnimation()
			f36_arg0.PlayerRoundTime:setAlpha(0)
			f36_local0(f36_arg0.PlayerRoundTime)
			local f36_local1 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(450)
					f40_arg0:setAlpha(1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.EnemyRoundTime:beginAnimation(1000)
				f36_arg0.EnemyRoundTime:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.EnemyRoundTime:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f36_arg0.EnemyRoundTime:completeAnimation()
			f36_arg0.EnemyRoundTime:setAlpha(0)
			f36_local1(f36_arg0.EnemyRoundTime)
		end,
	},
}
CoD.GameEndScoreOutcome.__onClose = function(f41_arg0)
	f41_arg0.CenterWidget:close()
	f41_arg0.PlayerRoundScore:close()
	f41_arg0.EnemyRoundScore:close()
	f41_arg0.EnemyRoundPipList:close()
	f41_arg0.PlayerRoundPipList:close()
	f41_arg0.PlayerRoundTime:close()
	f41_arg0.EnemyRoundTime:close()
end
