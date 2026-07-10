require("x64:1ff27ba8f489b41")
require("x64:5f956420e83938")
require("x64:91ac5934d0654c2")
require("x64:e181f9ba51cb7e8")
CoD.ZMAARTrialTabInternal = InheritFrom(LUI.UIElement)
CoD.ZMAARTrialTabInternal.__defaultWidth = 1920
CoD.ZMAARTrialTabInternal.__defaultHeight = 900
CoD.ZMAARTrialTabInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARTrialTabInternal)
	self.id = "ZMAARTrialTabInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RoundColumns = LUI.UIList.new(f1_arg0, f1_arg1, 5, 0, nil, false, false, false, false)
	RoundColumns:setLeftRight(0, 0, 629, 1803)
	RoundColumns:setTopBottom(0, 0, 123.5, 758.5)
	RoundColumns:setScale(0.98, 0.98)
	RoundColumns:setWidgetType(CoD.ZMAARTrialTabRoundList)
	RoundColumns:setHorizontalCount(3)
	RoundColumns:setSpacing(5)
	RoundColumns:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RoundColumns:setDataSource("ZmAarTrialRoundColumn")
	self:addElement(RoundColumns)
	self.RoundColumns = RoundColumns
	local RoundDescriptionGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 9, 0, nil, nil, false, false, false, false)
	RoundDescriptionGrid:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsZmTrialTabGridChildIdNumLessThanOrEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.roundsCompleted", "AAR.trialStats.roundReached")
			end,
		},
		{
			stateName = "Focused",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsZmTrialTabGridChildIdNumEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.roundReached")
			end,
		},
		{
			stateName = "PreviouslyCompleted",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsZmTrialTabGridChildIdNumGreaterThanOrEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.roundReached")
				if f4_local0 then
					if not CoD.ModelUtility.IsZmTrialTabGridChildIdNumEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.roundReached") then
						f4_local0 = CoD.ModelUtility.IsZmTrialTabGridChildIdNumLessThanOrEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.highestRound", "")
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Incomplete",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsZmTrialTabGridChildIdNumGreaterThanOrEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.roundReached")
				if f5_local0 then
					if not CoD.ModelUtility.IsZmTrialTabGridChildIdNumEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.roundReached") then
						f5_local0 = CoD.ModelUtility.IsZmTrialTabGridChildIdNumGreaterThanOrEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.highestRound")
						if f5_local0 then
							f5_local0 = not CoD.ModelUtility.IsZmTrialTabGridChildIdNumEqualToControllerModelValue(element, f1_arg1, "AAR.trialStats.highestRound")
						end
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
	})
	local ZMAARGameInfo = RoundDescriptionGrid
	local MatchTimeText = RoundDescriptionGrid.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	MatchTimeText(ZMAARGameInfo, f1_local5["AAR.trialStats.roundsCompleted"], function(f6_arg0)
		f1_arg0:updateElementState(RoundDescriptionGrid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "AAR.trialStats.roundsCompleted",
		})
	end, false)
	ZMAARGameInfo = RoundDescriptionGrid
	MatchTimeText = RoundDescriptionGrid.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	MatchTimeText(ZMAARGameInfo, f1_local5["AAR.trialStats.roundReached"], function(f7_arg0)
		f1_arg0:updateElementState(RoundDescriptionGrid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "AAR.trialStats.roundReached",
		})
	end, false)
	ZMAARGameInfo = RoundDescriptionGrid
	MatchTimeText = RoundDescriptionGrid.subscribeToModel
	f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	MatchTimeText(ZMAARGameInfo, f1_local5["AAR.trialStats.highestRound"], function(f8_arg0)
		f1_arg0:updateElementState(RoundDescriptionGrid, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "AAR.trialStats.highestRound",
		})
	end, false)
	RoundDescriptionGrid:setLeftRight(0, 0, 632, 1820)
	RoundDescriptionGrid:setTopBottom(0, 0, 269, 850)
	RoundDescriptionGrid:setScale(0.95, 0.95)
	RoundDescriptionGrid:setWidgetType(CoD.ZMAARTrialTabRoundStat)
	RoundDescriptionGrid:setHorizontalCount(3)
	RoundDescriptionGrid:setVerticalCount(10)
	RoundDescriptionGrid:setSpacing(9)
	RoundDescriptionGrid:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RoundDescriptionGrid:setDataSource("ZmAarTrialRoundGrid")
	self:addElement(RoundDescriptionGrid)
	self.RoundDescriptionGrid = RoundDescriptionGrid
	MatchTimeText = CoD.ZMAARTrialTime.new(f1_arg0, f1_arg1, 0, 0, 1640, 1840, 0, 0, 70, 152)
	MatchTimeText:setScale(0.75, 0.75)
	self:addElement(MatchTimeText)
	self.MatchTimeText = MatchTimeText
	ZMAARGameInfo = CoD.ZMAARGameInfo.new(f1_arg0, f1_arg1, 0, 0, 615, 1589, 0, 0, 48.5, 161.5)
	ZMAARGameInfo:linkToElementModel(self, nil, false, function(model)
		ZMAARGameInfo:setModel(model, f1_arg1)
	end)
	self:addElement(ZMAARGameInfo)
	self.ZMAARGameInfo = ZMAARGameInfo
	self:mergeStateConditions({
		{
			stateName = "ShowNewHighestRound",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "AAR.trialStats.isNewHighestRound")
			end,
		},
		{
			stateName = "ShowNewBestTime",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "AAR.trialStats.isNewBestTime")
			end,
		},
	})
	local f1_local6 = self
	f1_local5 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local6, f1_local7["AAR.trialStats.isNewHighestRound"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "AAR.trialStats.isNewHighestRound",
		})
	end, false)
	f1_local6 = self
	f1_local5 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local6, f1_local7["AAR.trialStats.isNewBestTime"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "AAR.trialStats.isNewBestTime",
		})
	end, false)
	RoundColumns.id = "RoundColumns"
	RoundDescriptionGrid.id = "RoundDescriptionGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARTrialTabInternal.__resetProperties = function(f14_arg0)
	f14_arg0.ZMAARGameInfo:completeAnimation()
	f14_arg0.RoundColumns:completeAnimation()
	f14_arg0.RoundDescriptionGrid:completeAnimation()
	f14_arg0.MatchTimeText:completeAnimation()
	f14_arg0.ZMAARGameInfo:setAlpha(1)
	f14_arg0.RoundColumns:setAlpha(1)
	f14_arg0.RoundDescriptionGrid:setAlpha(1)
	f14_arg0.MatchTimeText:setAlpha(1)
end
CoD.ZMAARTrialTabInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	ShowNewHighestRound = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(149)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.RoundColumns:beginAnimation(200)
				f16_arg0.RoundColumns:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.RoundColumns:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.RoundColumns:completeAnimation()
			f16_arg0.RoundColumns:setAlpha(0)
			f16_local0(f16_arg0.RoundColumns)
			local f16_local1 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(150)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.RoundDescriptionGrid:beginAnimation(250)
				f16_arg0.RoundDescriptionGrid:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.RoundDescriptionGrid:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f16_arg0.RoundDescriptionGrid:completeAnimation()
			f16_arg0.RoundDescriptionGrid:setAlpha(0)
			f16_local1(f16_arg0.RoundDescriptionGrid)
			local f16_local2 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_both"])
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.MatchTimeText:beginAnimation(800)
				f16_arg0.MatchTimeText:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.MatchTimeText:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f16_arg0.MatchTimeText:completeAnimation()
			f16_arg0.MatchTimeText:setAlpha(0)
			f16_local2(f16_arg0.MatchTimeText)
			local f16_local3 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.ZMAARGameInfo:beginAnimation(50)
				f16_arg0.ZMAARGameInfo:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ZMAARGameInfo:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f16_arg0.ZMAARGameInfo:completeAnimation()
			f16_arg0.ZMAARGameInfo:setAlpha(0)
			f16_local3(f16_arg0.ZMAARGameInfo)
		end,
	},
	ShowNewBestTime = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					f27_arg0:beginAnimation(149)
					f27_arg0:setAlpha(1)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.RoundColumns:beginAnimation(200)
				f25_arg0.RoundColumns:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.RoundColumns:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.RoundColumns:completeAnimation()
			f25_arg0.RoundColumns:setAlpha(0)
			f25_local0(f25_arg0.RoundColumns)
			local f25_local1 = function(f28_arg0)
				local f28_local0 = function(f29_arg0)
					f29_arg0:beginAnimation(150)
					f29_arg0:setAlpha(1)
					f29_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.RoundDescriptionGrid:beginAnimation(250)
				f25_arg0.RoundDescriptionGrid:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.RoundDescriptionGrid:registerEventHandler("transition_complete_keyframe", f28_local0)
			end
			f25_arg0.RoundDescriptionGrid:completeAnimation()
			f25_arg0.RoundDescriptionGrid:setAlpha(0)
			f25_local1(f25_arg0.RoundDescriptionGrid)
			local f25_local2 = function(f30_arg0)
				f30_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_out"])
				f30_arg0:setAlpha(1)
				f30_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.MatchTimeText:beginAnimation(800)
			f25_arg0.MatchTimeText:setAlpha(0)
			f25_arg0.MatchTimeText:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
			f25_arg0.MatchTimeText:registerEventHandler("transition_complete_keyframe", f25_local2)
			local f25_local3 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
				end
				f25_arg0.ZMAARGameInfo:beginAnimation(50)
				f25_arg0.ZMAARGameInfo:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ZMAARGameInfo:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f25_arg0.ZMAARGameInfo:completeAnimation()
			f25_arg0.ZMAARGameInfo:setAlpha(0)
			f25_local3(f25_arg0.ZMAARGameInfo)
		end,
	},
}
CoD.ZMAARTrialTabInternal.__onClose = function(f33_arg0)
	f33_arg0.RoundColumns:close()
	f33_arg0.RoundDescriptionGrid:close()
	f33_arg0.MatchTimeText:close()
	f33_arg0.ZMAARGameInfo:close()
end
