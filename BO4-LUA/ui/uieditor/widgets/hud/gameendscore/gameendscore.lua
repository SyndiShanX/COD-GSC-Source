require("x64:a70e8c3b3266263")
require("x64:f6f77ad298c6619")
require("x64:bc472e86b1eed0")
require("x64:66fd4726ae62457")
require("x64:cffe63547e8848b")
require("x64:e923077648d54b")
CoD.GameEndScore = InheritFrom(LUI.UIElement)
CoD.GameEndScore.__defaultWidth = 1920
CoD.GameEndScore.__defaultHeight = 1080
CoD.GameEndScore.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.GameEndScoreUtility.SetupGameEndScoreWidget(self, f1_arg1)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.GameEndScore)
	self.id = "GameEndScore"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Bg:setRGB(0, 0, 0)
	Bg:setAlpha(0.5)
	self:addElement(Bg)
	self.Bg = Bg
	local Title = CoD.GameEndScoreTitle.new(f1_arg0, f1_arg1, 0.5, 0.5, -480, 480, 0.5, 0.5, -459, -362)
	Title:subscribeToGlobalModel(f1_arg1, "GameScore", nil, function(model)
		Title:setModel(model, f1_arg1)
	end)
	Title:subscribeToGlobalModel(f1_arg1, "GameScore", "titleString", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title.MatchInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Subtitle = CoD.GameEndScoreSubtitle.new(f1_arg0, f1_arg1, 0.5, 0.5, -375, 375, 0.5, 0.5, -351, -314)
	Subtitle:subscribeToGlobalModel(f1_arg1, "GameScore", "subtitleString", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Subtitle.SubtitleText:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(Subtitle)
	self.Subtitle = Subtitle
	local MatchBonus = CoD.GameEndScoreMatchBonus.new(f1_arg0, f1_arg1, 0.5, 0.5, -250, 250, 0.5, 0.5, 308, 488)
	self:addElement(MatchBonus)
	self.MatchBonus = MatchBonus
	local PlayerRoundPipList = CoD.GameEndScoreOutcome.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -95, 125)
	self:addElement(PlayerRoundPipList)
	self.PlayerRoundPipList = PlayerRoundPipList
	local GameEndScoreOutcomeFFA = CoD.GameEndScoreOutcomeFFA.new(f1_arg0, f1_arg1, 0.5, 0.5, -480, 480, 0.5, 0.5, -200, 200)
	self:addElement(GameEndScoreOutcomeFFA)
	self.GameEndScoreOutcomeFFA = GameEndScoreOutcomeFFA
	local MPJoinedInProgressLoss = CoD.MPJoinedInProgressLoss.new(f1_arg0, f1_arg1, 0.5, 0.5, -959.5, 959.5, 0.5, 0.5, -294.5, -246.5)
	self:addElement(MPJoinedInProgressLoss)
	self.MPJoinedInProgressLoss = MPJoinedInProgressLoss
	self:mergeStateConditions({
		{
			stateName = "Outcome",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowOutcomeTransition(f1_arg1)
			end,
		},
		{
			stateName = "OutcomeWithScoreFFA",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowOutcomeWithScoreTransition(f1_arg1) and not IsGametypeTeambased()
			end,
		},
		{
			stateName = "OutcomeWithScore",
			condition = function(menu, element, event)
				return CoD.GameEndScoreUtility.ShowOutcomeWithScoreTransition(f1_arg1)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["gameScore.currentState"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "gameScore.currentState",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_final_killcam"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.forceScoreboard, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		if CoD.BaseUtility.IsSelfInState(self, "OutcomeWithScore") and not IsCodCaster(controller) then
			PlaySoundAlias("uin_mp_end_score")
		end
	end)
	PlayerRoundPipList.id = "PlayerRoundPipList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore.__resetProperties = function(f15_arg0)
	f15_arg0.Subtitle:completeAnimation()
	f15_arg0.Title:completeAnimation()
	f15_arg0.Bg:completeAnimation()
	f15_arg0.MatchBonus:completeAnimation()
	f15_arg0.GameEndScoreOutcomeFFA:completeAnimation()
	f15_arg0.MPJoinedInProgressLoss:completeAnimation()
	f15_arg0.PlayerRoundPipList:completeAnimation()
	f15_arg0.Subtitle:setAlpha(1)
	f15_arg0.Title:setAlpha(1)
	f15_arg0.Bg:setAlpha(0.5)
	f15_arg0.MatchBonus:setAlpha(1)
	f15_arg0.GameEndScoreOutcomeFFA:setAlpha(1)
	f15_arg0.MPJoinedInProgressLoss:setAlpha(1)
	f15_arg0.PlayerRoundPipList:setAlpha(1)
end
CoD.GameEndScore.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(6)
			f16_arg0.Bg:completeAnimation()
			f16_arg0.Bg:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Bg)
			f16_arg0.Title:completeAnimation()
			f16_arg0.Title:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Title)
			f16_arg0.Subtitle:completeAnimation()
			f16_arg0.Subtitle:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Subtitle)
			f16_arg0.MatchBonus:completeAnimation()
			f16_arg0.MatchBonus:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.MatchBonus)
			f16_arg0.GameEndScoreOutcomeFFA:completeAnimation()
			f16_arg0.GameEndScoreOutcomeFFA:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.GameEndScoreOutcomeFFA)
			f16_arg0.MPJoinedInProgressLoss:completeAnimation()
			f16_arg0.MPJoinedInProgressLoss:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.MPJoinedInProgressLoss)
		end,
	},
	Outcome = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(5)
			local f17_local0 = function(f18_arg0)
				f17_arg0.Bg:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_in"])
				f17_arg0.Bg:setAlpha(0.4)
				f17_arg0.Bg:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Bg:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.Bg:completeAnimation()
			f17_arg0.Bg:setAlpha(0)
			f17_local0(f17_arg0.Bg)
			local f17_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(200)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.Title:beginAnimation(400)
				f17_arg0.Title:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Title:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f17_arg0.Title:completeAnimation()
			f17_arg0.Title:setAlpha(0)
			f17_local1(f17_arg0.Title)
			local f17_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						f23_arg0:beginAnimation(199)
						f23_arg0:setAlpha(0.8)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
					end
					f22_arg0:beginAnimation(200)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f17_arg0.Subtitle:beginAnimation(400)
				f17_arg0.Subtitle:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Subtitle:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f17_arg0.Subtitle:completeAnimation()
			f17_arg0.Subtitle:setAlpha(0)
			f17_local2(f17_arg0.Subtitle)
			f17_arg0.MatchBonus:completeAnimation()
			f17_arg0.MatchBonus:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.MatchBonus)
			f17_arg0.GameEndScoreOutcomeFFA:completeAnimation()
			f17_arg0.GameEndScoreOutcomeFFA:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.GameEndScoreOutcomeFFA)
		end,
	},
	OutcomeWithScoreFFA = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(6)
			f24_arg0.Bg:completeAnimation()
			f24_arg0.Bg:setAlpha(0.8)
			f24_arg0.clipFinished(f24_arg0.Bg)
			local f24_local0 = function(f25_arg0)
				f24_arg0.Title:beginAnimation(200)
				f24_arg0.Title:setAlpha(1)
				f24_arg0.Title:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Title:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.Title:completeAnimation()
			f24_arg0.Title:setAlpha(0)
			f24_local0(f24_arg0.Title)
			local f24_local1 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(210)
					f27_arg0:setAlpha(0.8)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.Subtitle:beginAnimation(200)
				f24_arg0.Subtitle:setAlpha(1)
				f24_arg0.Subtitle:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.Subtitle:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f24_arg0.Subtitle:completeAnimation()
			f24_arg0.Subtitle:setAlpha(0)
			f24_local1(f24_arg0.Subtitle)
			local f24_local2 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_in"])
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.MatchBonus:beginAnimation(1000)
				f24_arg0.MatchBonus:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.MatchBonus:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f24_arg0.MatchBonus:completeAnimation()
			f24_arg0.MatchBonus:setAlpha(0)
			f24_local2(f24_arg0.MatchBonus)
			f24_arg0.PlayerRoundPipList:completeAnimation()
			f24_arg0.PlayerRoundPipList:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PlayerRoundPipList)
			local f24_local3 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					f31_arg0:beginAnimation(800)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
				end
				f24_arg0.GameEndScoreOutcomeFFA:beginAnimation(200)
				f24_arg0.GameEndScoreOutcomeFFA:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.GameEndScoreOutcomeFFA:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f24_arg0.GameEndScoreOutcomeFFA:completeAnimation()
			f24_arg0.GameEndScoreOutcomeFFA:setAlpha(0)
			f24_local3(f24_arg0.GameEndScoreOutcomeFFA)
		end,
	},
	OutcomeWithScore = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(5)
			f32_arg0.Bg:completeAnimation()
			f32_arg0.Bg:setAlpha(0.8)
			f32_arg0.clipFinished(f32_arg0.Bg)
			local f32_local0 = function(f33_arg0)
				f32_arg0.Title:beginAnimation(200)
				f32_arg0.Title:setAlpha(1)
				f32_arg0.Title:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.Title:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.Title:completeAnimation()
			f32_arg0.Title:setAlpha(0)
			f32_local0(f32_arg0.Title)
			local f32_local1 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					f35_arg0:beginAnimation(210)
					f35_arg0:setAlpha(0.8)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.Subtitle:beginAnimation(200)
				f32_arg0.Subtitle:setAlpha(1)
				f32_arg0.Subtitle:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.Subtitle:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f32_arg0.Subtitle:completeAnimation()
			f32_arg0.Subtitle:setAlpha(0)
			f32_local1(f32_arg0.Subtitle)
			local f32_local2 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(450, Enum[@"luitween"][@"luitween_ease_in"])
					f37_arg0:setAlpha(1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.MatchBonus:beginAnimation(1000)
				f32_arg0.MatchBonus:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.MatchBonus:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f32_arg0.MatchBonus:completeAnimation()
			f32_arg0.MatchBonus:setAlpha(0)
			f32_local2(f32_arg0.MatchBonus)
			f32_arg0.GameEndScoreOutcomeFFA:completeAnimation()
			f32_arg0.GameEndScoreOutcomeFFA:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.GameEndScoreOutcomeFFA)
		end,
	},
}
CoD.GameEndScore.__onClose = function(f38_arg0)
	f38_arg0.Title:close()
	f38_arg0.Subtitle:close()
	f38_arg0.MatchBonus:close()
	f38_arg0.PlayerRoundPipList:close()
	f38_arg0.GameEndScoreOutcomeFFA:close()
	f38_arg0.MPJoinedInProgressLoss:close()
end
