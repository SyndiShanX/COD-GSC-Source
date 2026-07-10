CoD.ZMAARTrialTabRoundListInternal = InheritFrom(LUI.UIElement)
CoD.ZMAARTrialTabRoundListInternal.__defaultWidth = 388
CoD.ZMAARTrialTabRoundListInternal.__defaultHeight = 635
CoD.ZMAARTrialTabRoundListInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARTrialTabRoundListInternal)
	self.id = "ZMAARTrialTabRoundListInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ListBg = LUI.UIImage.new(0, 0, 0, 388, 0, 0, 68, 764)
	ListBg:setImage(RegisterImage(@"uie_trial_rules_gold_normal"))
	self:addElement(ListBg)
	self.ListBg = ListBg
	local Medal = LUI.UIImage.new(0, 0, 148, 240, 0, 0, 64, 156)
	Medal:setAlpha(0.9)
	Medal:setImage(RegisterImage(@"uie_trial_medal_gold"))
	self:addElement(Medal)
	self.Medal = Medal
	local MedalText = LUI.UIText.new(0, 0, 4.5, 370.5, 0, 0, 47, 65)
	MedalText:setText(LocalizeToUpperString(@"hash_4F2A2FD2DB27D84"))
	MedalText:setTTF("skorzhen")
	MedalText:setLetterSpacing(2)
	MedalText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MedalText:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(MedalText)
	self.MedalText = MedalText
	local MedalAchievedText = LUI.UIText.new(0, 0, 4.5, 370.5, 0, 0, 47, 65)
	MedalAchievedText:setAlpha(0)
	MedalAchievedText:setText(LocalizeToUpperString(@"hash_677E29E95B5D6719"))
	MedalAchievedText:setTTF("skorzhen")
	MedalAchievedText:setLetterSpacing(2)
	MedalAchievedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MedalAchievedText:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(MedalAchievedText)
	self.MedalAchievedText = MedalAchievedText
	self:mergeStateConditions({
		{
			stateName = "MedalAlreadyComplete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueGreaterThanOrEqualToSelfModelValue(element, f1_arg1, "AAR.trialStats.prevHighestRoundCompleted", "roundCompleteRequirement")
			end,
		},
		{
			stateName = "MedalReward",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueGreaterThanOrEqualToSelfModelValue(element, f1_arg1, "AAR.trialStats.roundsCompleted", "roundCompleteRequirement") and not CoD.ModelUtility.IsControllerModelValueGreaterThanOrEqualToSelfModelValue(element, f1_arg1, "AAR.trialStats.prevHighestRoundCompleted", "roundCompleteRequirement")
			end,
		},
		{
			stateName = "MedalEmpty",
			condition = function(menu, element, event)
				local f4_local0
				if not CoD.ModelUtility.IsControllerModelValueGreaterThanOrEqualToSelfModelValue(element, f1_arg1, "AAR.trialStats.roundsCompleted", "roundCompleteRequirement") then
					f4_local0 = not CoD.ModelUtility.IsControllerModelValueGreaterThanOrEqualToSelfModelValue(element, f1_arg1, "AAR.trialStats.prevHighestRoundCompleted", "roundCompleteRequirement")
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["AAR.trialStats.prevHighestRoundCompleted"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "AAR.trialStats.prevHighestRoundCompleted",
		})
	end, false)
	self:linkToElementModel(self, "roundCompleteRequirement", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "roundCompleteRequirement",
		})
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["AAR.trialStats.roundsCompleted"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "AAR.trialStats.roundsCompleted",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARTrialTabRoundListInternal.__resetProperties = function(f8_arg0)
	f8_arg0.ListBg:completeAnimation()
	f8_arg0.Medal:completeAnimation()
	f8_arg0.MedalText:completeAnimation()
	f8_arg0.MedalAchievedText:completeAnimation()
	f8_arg0.ListBg:setTopBottom(0, 0, 68, 764)
	f8_arg0.Medal:setAlpha(0.9)
	f8_arg0.MedalText:setAlpha(1)
	f8_arg0.MedalAchievedText:setAlpha(0)
end
CoD.ZMAARTrialTabRoundListInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ListBg:completeAnimation()
			f9_arg0.ListBg:setTopBottom(0, 0, 68, 754)
			f9_arg0.clipFinished(f9_arg0.ListBg)
		end,
	},
	MedalAlreadyComplete = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			local f10_local0 = function(f11_arg0)
				f10_arg0.Medal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f10_arg0.Medal:setAlpha(1)
				f10_arg0.Medal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Medal:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Medal:completeAnimation()
			f10_arg0.Medal:setAlpha(0)
			f10_local0(f10_arg0.Medal)
			local f10_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(200)
					f13_arg0:setAlpha(1)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.MedalText:beginAnimation(200)
				f10_arg0.MedalText:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.MedalText:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f10_arg0.MedalText:completeAnimation()
			f10_arg0.MedalText:setAlpha(0)
			f10_local1(f10_arg0.MedalText)
		end,
	},
	MedalReward = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			local f14_local0 = function(f15_arg0)
				f14_arg0.Medal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.Medal:setAlpha(1)
				f14_arg0.Medal:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Medal:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.Medal:completeAnimation()
			f14_arg0.Medal:setAlpha(0)
			f14_local0(f14_arg0.Medal)
			f14_arg0.MedalText:completeAnimation()
			f14_arg0.MedalText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.MedalText)
			local f14_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(200)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.MedalAchievedText:beginAnimation(200)
				f14_arg0.MedalAchievedText:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.MedalAchievedText:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f14_arg0.MedalAchievedText:completeAnimation()
			f14_arg0.MedalAchievedText:setAlpha(0)
			f14_local1(f14_arg0.MedalAchievedText)
		end,
	},
	MedalEmpty = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				f18_arg0.Medal:beginAnimation(200, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f18_arg0.Medal:setAlpha(0.5)
				f18_arg0.Medal:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.Medal:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.Medal:completeAnimation()
			f18_arg0.Medal:setAlpha(0)
			f18_local0(f18_arg0.Medal)
			local f18_local1 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(200)
					f21_arg0:setAlpha(0.3)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.MedalText:beginAnimation(200)
				f18_arg0.MedalText:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.MedalText:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f18_arg0.MedalText:completeAnimation()
			f18_arg0.MedalText:setAlpha(0)
			f18_local1(f18_arg0.MedalText)
		end,
	},
}
