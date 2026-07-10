CoD.zm_red_challenge_text = InheritFrom(LUI.UIElement)
CoD.zm_red_challenge_text.__defaultWidth = 360
CoD.zm_red_challenge_text.__defaultHeight = 19
CoD.zm_red_challenge_text.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.zm_red_challenge_text)
	self.id = "zm_red_challenge_text"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChallengeText = LUI.UIText.new(0, 0, 0, 360, 0, 0, 0, 20)
	ChallengeText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ChallengeText:setText("")
	ChallengeText:setTTF("skorzhen")
	ChallengeText:setLetterSpacing(1)
	ChallengeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ChallengeText:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(ChallengeText)
	self.ChallengeText = ChallengeText
	self:mergeStateConditions({
		{
			stateName = "ChallengeFailing",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueEqualToEitherValue(element, f1_arg1, "challengeFailing", 0, nil)
			end,
		},
	})
	self:linkToElementModel(self, "challengeFailing", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "challengeFailing",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.zm_red_challenge_text.__resetProperties = function(f4_arg0)
	f4_arg0.ChallengeText:completeAnimation()
	f4_arg0.ChallengeText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
end
CoD.zm_red_challenge_text.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	ChallengeFailing = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_out"])
					f8_arg0:setRGB(0.93, 0.17, 0.17)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.ChallengeText:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_in"])
				f6_arg0.ChallengeText:setRGB(0.91, 0.71, 0.71)
				f6_arg0.ChallengeText:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ChallengeText:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.ChallengeText:completeAnimation()
			f6_arg0.ChallengeText:setRGB(0.93, 0.17, 0.17)
			f6_local0(f6_arg0.ChallengeText)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
}
