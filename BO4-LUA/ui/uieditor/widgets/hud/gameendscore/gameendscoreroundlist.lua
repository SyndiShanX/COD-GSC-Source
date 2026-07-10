require("x64:d92655a9482f98a")
CoD.GameEndScoreRoundList = InheritFrom(LUI.UIElement)
CoD.GameEndScoreRoundList.__defaultWidth = 316
CoD.GameEndScoreRoundList.__defaultHeight = 74
CoD.GameEndScoreRoundList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreRoundList)
	self.id = "GameEndScoreRoundList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RoundPipList = LUI.UIList.new(f1_arg0, f1_arg1, 47, 0, nil, false, false, false, false)
	RoundPipList:mergeStateConditions({
		{
			stateName = "JustComplete",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "justComplete")
				if f2_local0 then
					f2_local0 = CoD.GameEndScoreUtility.IsGameScoreCurrentState(f1_arg1, "outcome_with_score")
					if f2_local0 then
						f2_local0 = not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "GameScore", "showSwitchingSides")
					end
				end
				return f2_local0
			end,
		},
	})
	RoundPipList:linkToElementModel(RoundPipList, "justComplete", true, function(model)
		f1_arg0:updateElementState(RoundPipList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "justComplete",
		})
	end)
	local f1_local2 = RoundPipList
	local Score = RoundPipList.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	Score(f1_local2, f1_local4["gameScore.currentState"], function(f4_arg0)
		f1_arg0:updateElementState(RoundPipList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "gameScore.currentState",
		})
	end, false)
	f1_local2 = RoundPipList
	Score = RoundPipList.subscribeToModel
	f1_local4 = DataSources.GameScore.getModel(f1_arg1)
	Score(f1_local2, f1_local4.showSwitchingSides, function(f5_arg0)
		f1_arg0:updateElementState(RoundPipList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "showSwitchingSides",
		})
	end, false)
	RoundPipList:linkToElementModel(RoundPipList, "isComplete", true, function(model)
		f1_arg0:updateElementState(RoundPipList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isComplete",
		})
	end)
	RoundPipList:setLeftRight(0.5, 0.5, -119, 119)
	RoundPipList:setTopBottom(0, 0, 13, 61)
	RoundPipList:setWidgetType(CoD.GameEndScoreRoundPip)
	RoundPipList:setSpacing(47)
	RoundPipList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RoundPipList:subscribeToGlobalModel(f1_arg1, "GameScore", "roundWinLimit", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RoundPipList:setHorizontalCount(f7_local0)
		end
	end)
	self:addElement(RoundPipList)
	self.RoundPipList = RoundPipList
	Score = LUI.UIText.new(0.5, 0.5, -158, 158, 0, 0, -5, 85)
	Score:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Score:setText(4)
	Score:setTTF("0arame_mono_stencil")
	Score:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	Score:setLetterSpacing(10)
	Score:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Score:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Score)
	self.Score = Score
	self:mergeStateConditions({
		{
			stateName = "ShowNumber",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowScoreInsteadOfPips(f1_arg1) and CoD.GameEndScoreUtility.ShowOutcomeWithScoreOrTimeTransition(f1_arg1)
			end,
		},
	})
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5["gameScore.roundWinLimit"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "gameScore.roundWinLimit",
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5.forceScoreboard, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5["gameScore.currentState"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "gameScore.currentState",
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local2(f1_local4, f1_local5["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	RoundPipList.id = "RoundPipList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreRoundList.__resetProperties = function(f16_arg0)
	f16_arg0.RoundPipList:completeAnimation()
	f16_arg0.Score:completeAnimation()
	f16_arg0.RoundPipList:setAlpha(1)
	f16_arg0.Score:setAlpha(1)
	f16_arg0.Score:setZoom(0)
end
CoD.GameEndScoreRoundList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.RoundPipList:completeAnimation()
			f17_arg0.RoundPipList:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.RoundPipList)
			f17_arg0.Score:completeAnimation()
			f17_arg0.Score:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Score)
		end,
	},
	ShowNumber = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.RoundPipList:completeAnimation()
			f18_arg0.RoundPipList:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.RoundPipList)
			local f18_local0 = function(f19_arg0)
				f18_arg0.Score:beginAnimation(300)
				f18_arg0.Score:setZoom(0)
				f18_arg0.Score:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Score:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Score:completeAnimation()
			f18_arg0.Score:setZoom(750)
			f18_local0(f18_arg0.Score)
		end,
	},
}
CoD.GameEndScoreRoundList.__onClose = function(f20_arg0)
	f20_arg0.RoundPipList:close()
end
