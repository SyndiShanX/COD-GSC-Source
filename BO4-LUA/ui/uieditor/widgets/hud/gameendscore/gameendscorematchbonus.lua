require("x64:f5a6fba96d34893")
require("x64:f72d4606ccc678a")
CoD.GameEndScoreMatchBonus = InheritFrom(LUI.UIElement)
CoD.GameEndScoreMatchBonus.__defaultWidth = 500
CoD.GameEndScoreMatchBonus.__defaultHeight = 180
CoD.GameEndScoreMatchBonus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreMatchBonus)
	self.id = "GameEndScoreMatchBonus"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXPIcon = CoD.Notification2xpReward.new(f1_arg0, f1_arg1, 0.5, 0.5, -36, 36, 0, 0, 0, 72)
	DoubleXPIcon:setAlpha(0)
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	local XpIcon = LUI.UIImage.new(0.5, 0.5, -36, 36, 0, 0, 0, 72)
	XpIcon:setImage(RegisterImage(@"uie_t7_hud_mp_notifications_xp"))
	self:addElement(XpIcon)
	self.XpIcon = XpIcon
	local MatchBonusValue = LUI.UIText.new(0.5, 0.5, -250, 250, 0, 0, 130.5, 175.5)
	MatchBonusValue:setRGB(ColorSet.RewardRankup.r, ColorSet.RewardRankup.g, ColorSet.RewardRankup.b)
	MatchBonusValue:setTTF("ttmussels_demibold")
	MatchBonusValue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	MatchBonusValue:setShaderVector(0, 0.3, 0, 0, 0)
	MatchBonusValue:setShaderVector(1, 0, 0, 0, 0)
	MatchBonusValue:setShaderVector(2, 0, 0.2, 0.7, 0.8)
	MatchBonusValue:setLetterSpacing(4)
	MatchBonusValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MatchBonusValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	MatchBonusValue:subscribeToGlobalModel(f1_arg1, "GameScore", "matchBonus", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MatchBonusValue:setText(f2_local0)
		end
	end)
	self:addElement(MatchBonusValue)
	self.MatchBonusValue = MatchBonusValue
	local MatchBonusValueAdd = LUI.UIText.new(0.5, 0.5, -250, 250, 0, 0, 130.5, 175.5)
	MatchBonusValueAdd:setRGB(ColorSet.RewardRankup.r, ColorSet.RewardRankup.g, ColorSet.RewardRankup.b)
	MatchBonusValueAdd:setAlpha(0)
	MatchBonusValueAdd:setTTF("ttmussels_demibold")
	MatchBonusValueAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_593F361CC41C94AF"))
	MatchBonusValueAdd:setShaderVector(0, 0.15, 0, 0, 0)
	MatchBonusValueAdd:setShaderVector(1, 0, 0, 0, 0)
	MatchBonusValueAdd:setShaderVector(2, 0, 1, 0.7, 0.5)
	MatchBonusValueAdd:setLetterSpacing(4)
	MatchBonusValueAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	MatchBonusValueAdd:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	MatchBonusValueAdd:subscribeToGlobalModel(f1_arg1, "GameScore", "matchBonus", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MatchBonusValueAdd:setText(f3_local0)
		end
	end)
	self:addElement(MatchBonusValueAdd)
	self.MatchBonusValueAdd = MatchBonusValueAdd
	local MatchBonusTitle = CoD.GameEndScoreMatchBonusTitle.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0, 0, 72, 125)
	self:addElement(MatchBonusTitle)
	self.MatchBonusTitle = MatchBonusTitle
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.GameEndScoreUtility.ShowMatchBonus(element, f1_arg1)
			end,
		},
		{
			stateName = "DoubleXP",
			condition = function(menu, element, event)
				return IsDoubleXP(f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["gameScore.isRoundEnd"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "gameScore.isRoundEnd",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["gameScore.matchBonus"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "gameScore.matchBonus",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreMatchBonus.__resetProperties = function(f8_arg0)
	f8_arg0.MatchBonusValueAdd:completeAnimation()
	f8_arg0.MatchBonusValue:completeAnimation()
	f8_arg0.XpIcon:completeAnimation()
	f8_arg0.MatchBonusTitle:completeAnimation()
	f8_arg0.DoubleXPIcon:completeAnimation()
	f8_arg0.MatchBonusValueAdd:setAlpha(0)
	f8_arg0.MatchBonusValueAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_593F361CC41C94AF"))
	f8_arg0.MatchBonusValue:setAlpha(1)
	f8_arg0.XpIcon:setAlpha(1)
	f8_arg0.MatchBonusTitle:setAlpha(1)
	f8_arg0.DoubleXPIcon:setAlpha(0)
end
CoD.GameEndScoreMatchBonus.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(500)
					f11_arg0:setAlpha(0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.MatchBonusValueAdd:beginAnimation(500)
				f9_arg0.MatchBonusValueAdd:setAlpha(1)
				f9_arg0.MatchBonusValueAdd:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.MatchBonusValueAdd:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.MatchBonusValueAdd:completeAnimation()
			f9_arg0.MatchBonusValueAdd:setAlpha(0)
			f9_arg0.MatchBonusValueAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_3336C1AE82B1520A"))
			f9_local0(f9_arg0.MatchBonusValueAdd)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.XpIcon:completeAnimation()
			f12_arg0.XpIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.XpIcon)
			f12_arg0.MatchBonusValue:completeAnimation()
			f12_arg0.MatchBonusValue:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.MatchBonusValue)
			f12_arg0.MatchBonusTitle:completeAnimation()
			f12_arg0.MatchBonusTitle:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.MatchBonusTitle)
		end,
	},
	DoubleXP = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.DoubleXPIcon:completeAnimation()
			f13_arg0.DoubleXPIcon:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.DoubleXPIcon)
			f13_arg0.XpIcon:completeAnimation()
			f13_arg0.XpIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.XpIcon)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							local f17_local0 = function(f18_arg0)
								local f18_local0 = function(f19_arg0)
									local f19_local0 = function(f20_arg0)
										local f20_local0 = function(f21_arg0)
											local f21_local0 = function(f22_arg0)
												local f22_local0 = function(f23_arg0)
													local f23_local0 = function(f24_arg0)
														local f24_local0 = function(f25_arg0)
															local f25_local0 = function(f26_arg0)
																local f26_local0 = function(f27_arg0)
																	f27_arg0:beginAnimation(1000)
																	f27_arg0:setAlpha(0.2)
																	f27_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
																end
																f26_arg0:beginAnimation(580)
																f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
															end
															f25_arg0:beginAnimation(19)
															f25_arg0:setAlpha(1)
															f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
														end
														f24_arg0:beginAnimation(20)
														f24_arg0:setAlpha(0)
														f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
													end
													f23_arg0:beginAnimation(19)
													f23_arg0:setAlpha(1)
													f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
												end
												f22_arg0:beginAnimation(20)
												f22_arg0:setAlpha(0)
												f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
											end
											f21_arg0:beginAnimation(20)
											f21_arg0:setAlpha(1)
											f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
										end
										f20_arg0:beginAnimation(19)
										f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
									end
									f19_arg0:beginAnimation(20)
									f19_arg0:setAlpha(0)
									f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
								end
								f18_arg0:beginAnimation(20)
								f18_arg0:setAlpha(0.5)
								f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
							end
							f17_arg0:beginAnimation(19)
							f17_arg0:setAlpha(0)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
						end
						f16_arg0:beginAnimation(19)
						f16_arg0:setAlpha(1)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(19)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.MatchBonusValueAdd:beginAnimation(200)
				f13_arg0.MatchBonusValueAdd:setAlpha(1)
				f13_arg0.MatchBonusValueAdd:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.MatchBonusValueAdd:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.MatchBonusValueAdd:completeAnimation()
			f13_arg0.MatchBonusValueAdd:setAlpha(0)
			f13_local0(f13_arg0.MatchBonusValueAdd)
		end,
	},
}
CoD.GameEndScoreMatchBonus.__onClose = function(f28_arg0)
	f28_arg0.DoubleXPIcon:close()
	f28_arg0.MatchBonusValue:close()
	f28_arg0.MatchBonusValueAdd:close()
	f28_arg0.MatchBonusTitle:close()
end
