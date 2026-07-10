CoD.GameEndScoreSubtitle = InheritFrom(LUI.UIElement)
CoD.GameEndScoreSubtitle.__defaultWidth = 750
CoD.GameEndScoreSubtitle.__defaultHeight = 37
CoD.GameEndScoreSubtitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreSubtitle)
	self.id = "GameEndScoreSubtitle"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SubtitleText = LUI.UIText.new(0.5, 0.5, -460, 460, 0, 0, 2.5, 26.5)
	SubtitleText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	SubtitleText:setText("")
	SubtitleText:setTTF("0arame_mono_stencil")
	SubtitleText:setLetterSpacing(4)
	SubtitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SubtitleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SubtitleText)
	self.SubtitleText = SubtitleText
	local SwitchingSidesText = LUI.UIText.new(0.5, 0.5, -460, 460, 0, 0, 2.5, 26.5)
	SwitchingSidesText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	SwitchingSidesText:setAlpha(0)
	SwitchingSidesText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_29034D05CE32DB88"))
	SwitchingSidesText:setTTF("0arame_mono_stencil")
	SwitchingSidesText:setLetterSpacing(4)
	SwitchingSidesText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	SwitchingSidesText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SwitchingSidesText)
	self.SwitchingSidesText = SwitchingSidesText
	self:mergeStateConditions({
		{
			stateName = "SubtitleTransition",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "SubtitleBase",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(f1_arg1, "GameScore", "subtitleString")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.GameScore.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.subtitleString, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "subtitleString",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreSubtitle.__resetProperties = function(f5_arg0)
	f5_arg0.SwitchingSidesText:completeAnimation()
	f5_arg0.SubtitleText:completeAnimation()
	f5_arg0.SwitchingSidesText:setAlpha(0)
	f5_arg0.SubtitleText:setAlpha(1)
end
CoD.GameEndScoreSubtitle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.SubtitleText:completeAnimation()
			f6_arg0.SubtitleText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.SubtitleText)
			f6_arg0.SwitchingSidesText:completeAnimation()
			f6_arg0.SwitchingSidesText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.SwitchingSidesText)
		end,
	},
	SubtitleTransition = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.SubtitleText:beginAnimation(200)
				f7_arg0.SubtitleText:setAlpha(0)
				f7_arg0.SubtitleText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SubtitleText:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.SubtitleText:completeAnimation()
			f7_arg0.SubtitleText:setAlpha(1)
			f7_local0(f7_arg0.SubtitleText)
			local f7_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							f12_arg0:beginAnimation(399, Enum[@"luitween"][@"luitween_ease_both"])
							f12_arg0:setAlpha(0.8)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
						end
						f11_arg0:beginAnimation(199)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(199, Enum[@"luitween"][@"luitween_ease_in"])
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f7_arg0.SwitchingSidesText:beginAnimation(600)
				f7_arg0.SwitchingSidesText:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.SwitchingSidesText:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f7_arg0.SwitchingSidesText:completeAnimation()
			f7_arg0.SwitchingSidesText:setAlpha(0)
			f7_local1(f7_arg0.SwitchingSidesText)
		end,
	},
	SubtitleBase = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_both"])
						f16_arg0:setAlpha(0.8)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(200)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.SubtitleText:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_in"])
				f13_arg0.SubtitleText:setAlpha(1)
				f13_arg0.SubtitleText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SubtitleText:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.SubtitleText:completeAnimation()
			f13_arg0.SubtitleText:setAlpha(0.5)
			f13_local0(f13_arg0.SubtitleText)
			f13_arg0.SwitchingSidesText:completeAnimation()
			f13_arg0.SwitchingSidesText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.SwitchingSidesText)
		end,
	},
}
