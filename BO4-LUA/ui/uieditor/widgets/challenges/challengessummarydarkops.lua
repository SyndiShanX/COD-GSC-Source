require("x64:d8954dabf937655")
CoD.ChallengesSummaryDarkOps = InheritFrom(LUI.UIElement)
CoD.ChallengesSummaryDarkOps.__defaultWidth = 200
CoD.ChallengesSummaryDarkOps.__defaultHeight = 225
CoD.ChallengesSummaryDarkOps.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesSummaryDarkOps)
	self.id = "ChallengesSummaryDarkOps"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SummaryCategoryBlackOps = CoD.ChallengesSummaryDarkOps_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0.5, 0.5, -112.5, 112.5)
	SummaryCategoryBlackOps.Classfied:setText(Engine[0xF9F1239CFD921FE](0x79E6AFC975F6E86))
	self:addElement(SummaryCategoryBlackOps)
	self.SummaryCategoryBlackOps = SummaryCategoryBlackOps
	self:mergeStateConditions({
		{
			stateName = "Zombie",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	SummaryCategoryBlackOps.id = "SummaryCategoryBlackOps"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesSummaryDarkOps.__resetProperties = function(f4_arg0)
	f4_arg0.SummaryCategoryBlackOps:completeAnimation()
	f4_arg0.SummaryCategoryBlackOps:setScale(1, 1)
end
CoD.ChallengesSummaryDarkOps.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.SummaryCategoryBlackOps:completeAnimation()
			f6_arg0.SummaryCategoryBlackOps:setScale(1.05, 1.05)
			f6_arg0.clipFinished(f6_arg0.SummaryCategoryBlackOps)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.SummaryCategoryBlackOps:beginAnimation(200)
				f7_arg0.SummaryCategoryBlackOps:setScale(1.05, 1.05)
				f7_arg0.SummaryCategoryBlackOps:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SummaryCategoryBlackOps:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.SummaryCategoryBlackOps:completeAnimation()
			f7_arg0.SummaryCategoryBlackOps:setScale(1, 1)
			f7_local0(f7_arg0.SummaryCategoryBlackOps)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.SummaryCategoryBlackOps:beginAnimation(200)
				f9_arg0.SummaryCategoryBlackOps:setScale(1, 1)
				f9_arg0.SummaryCategoryBlackOps:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.SummaryCategoryBlackOps:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.SummaryCategoryBlackOps:completeAnimation()
			f9_arg0.SummaryCategoryBlackOps:setScale(1.05, 1.05)
			f9_local0(f9_arg0.SummaryCategoryBlackOps)
		end,
	},
	Zombie = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.SummaryCategoryBlackOps:completeAnimation()
			f12_arg0.SummaryCategoryBlackOps:setScale(1.05, 1.05)
			f12_arg0.clipFinished(f12_arg0.SummaryCategoryBlackOps)
		end,
		GainChildFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.SummaryCategoryBlackOps:beginAnimation(200)
				f13_arg0.SummaryCategoryBlackOps:setScale(1.05, 1.05)
				f13_arg0.SummaryCategoryBlackOps:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SummaryCategoryBlackOps:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SummaryCategoryBlackOps:completeAnimation()
			f13_arg0.SummaryCategoryBlackOps:setScale(1, 1)
			f13_local0(f13_arg0.SummaryCategoryBlackOps)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.SummaryCategoryBlackOps:beginAnimation(200)
				f15_arg0.SummaryCategoryBlackOps:setScale(1, 1)
				f15_arg0.SummaryCategoryBlackOps:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.SummaryCategoryBlackOps:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.SummaryCategoryBlackOps:completeAnimation()
			f15_arg0.SummaryCategoryBlackOps:setScale(1.05, 1.05)
			f15_local0(f15_arg0.SummaryCategoryBlackOps)
		end,
	},
}
CoD.ChallengesSummaryDarkOps.__onClose = function(f17_arg0)
	f17_arg0.SummaryCategoryBlackOps:close()
end
