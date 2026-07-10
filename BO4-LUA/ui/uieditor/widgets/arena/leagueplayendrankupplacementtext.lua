require("x64:fa4e13ca8783b9d")
CoD.LeaguePlayEndRankUpPlacementText = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEndRankUpPlacementText.__defaultWidth = 600
CoD.LeaguePlayEndRankUpPlacementText.__defaultHeight = 72
CoD.LeaguePlayEndRankUpPlacementText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEndRankUpPlacementText)
	self.id = "LeaguePlayEndRankUpPlacementText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CurrentRank = LUI.UIText.new(0.5, 0.5, -300, 300, 0, 0, 0, 72)
	CurrentRank:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	CurrentRank:setText(Engine[0xF9F1239CFD921FE](0x6058CDEF9060214))
	CurrentRank:setTTF("ttmussels_demibold")
	CurrentRank:setLetterSpacing(8)
	CurrentRank:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(CurrentRank)
	self.CurrentRank = CurrentRank
	local NewRank = LUI.UIText.new(0.5, 0.5, -300, 300, 0, 0, 0, 72)
	NewRank:setAlpha(0)
	NewRank:setText(Engine[0xF9F1239CFD921FE](0x6058CDEF9060214))
	NewRank:setTTF("ttmussels_demibold")
	NewRank:setLetterSpacing(8)
	NewRank:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(NewRank)
	self.NewRank = NewRank
	local PlacementResult = LUI.UIText.new(0.5, 0.5, -302, 302, 0, 0, 0, 45)
	PlacementResult:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	PlacementResult:setAlpha(0)
	PlacementResult:setTTF("ttmussels_demibold")
	PlacementResult:setLetterSpacing(4)
	PlacementResult:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlacementResult:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	PlacementResult:linkToElementModel(self, "lastLadderRank", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlacementResult:setText(Engine[0xF9F1239CFD921FE](CoD.ArenaUtility.GetLadderPositionRankUpResult(f2_local0)))
		end
	end)
	self:addElement(PlacementResult)
	self.PlacementResult = PlacementResult
	local YouPlacedText = CoD.LeaguePlayYouPlaced.new(f1_arg0, f1_arg1, 0.5, 0.5, -302, 302, 0, 0, 37, 62)
	YouPlacedText:setAlpha(0)
	YouPlacedText:linkToElementModel(self, nil, false, function(model)
		YouPlacedText:setModel(model, f1_arg1)
	end)
	self:addElement(YouPlacedText)
	self.YouPlacedText = YouPlacedText
	local Sound = LUI.UIElement.new(0, 0, 268, 300, 0, 0, -190.5, -158.5)
	self:addElement(Sound)
	self.Sound = Sound
	self:mergeStateConditions({
		{
			stateName = "FirstPlace",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "lastLadderRank", LuaUtils.GetPositionForLeaguePlacementTier(1))
			end,
		},
	})
	self:linkToElementModel(self, "lastLadderRank", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lastLadderRank",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEndRankUpPlacementText.__resetProperties = function(f6_arg0)
	f6_arg0.CurrentRank:completeAnimation()
	f6_arg0.PlacementResult:completeAnimation()
	f6_arg0.YouPlacedText:completeAnimation()
	f6_arg0.Sound:completeAnimation()
	f6_arg0.CurrentRank:setAlpha(1)
	f6_arg0.PlacementResult:setTopBottom(0, 0, 0, 45)
	f6_arg0.PlacementResult:setAlpha(0)
	f6_arg0.PlacementResult:setScale(1, 1)
	f6_arg0.YouPlacedText:setTopBottom(0, 0, 37, 62)
	f6_arg0.YouPlacedText:setAlpha(0)
	f6_arg0.Sound:setPlaySoundDirect(false)
end
CoD.LeaguePlayEndRankUpPlacementText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.CurrentRank:completeAnimation()
			f7_arg0.CurrentRank:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CurrentRank)
			f7_arg0.PlacementResult:completeAnimation()
			f7_arg0.PlacementResult:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.PlacementResult)
			f7_arg0.YouPlacedText:completeAnimation()
			f7_arg0.YouPlacedText:setTopBottom(0, 0, 50, 75)
			f7_arg0.YouPlacedText:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.YouPlacedText)
		end,
		Intro = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(999, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f10_arg0:setAlpha(0)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f9_arg0:beginAnimation(300)
				f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.CurrentRank:beginAnimation(500)
			f8_arg0.CurrentRank:setAlpha(1)
			f8_arg0.CurrentRank:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
			f8_arg0.CurrentRank:registerEventHandler("transition_complete_keyframe", f8_local0)
			local f8_local1 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							f14_arg0:beginAnimation(19)
							f14_arg0:setAlpha(1)
							f14_arg0:setScale(1, 1)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
						end
						f13_arg0:beginAnimation(39)
						f13_arg0:setAlpha(0.9)
						f13_arg0:setScale(1.04, 1.04)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(140, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f12_arg0:setAlpha(0.7)
					f12_arg0:setScale(0.92, 0.92)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f11_arg0:beginAnimation(1500)
				f11_arg0:setScale(3.5, 3.5)
				f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f8_arg0.PlacementResult:beginAnimation(500)
			f8_arg0.PlacementResult:setAlpha(0)
			f8_arg0.PlacementResult:setScale(1, 1)
			f8_arg0.PlacementResult:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
			f8_arg0.PlacementResult:registerEventHandler("transition_complete_keyframe", f8_local1)
			local f8_local2 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f17_arg0:setAlpha(1)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(1900)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f8_arg0.YouPlacedText:beginAnimation(500)
				f8_arg0.YouPlacedText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.YouPlacedText:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f8_arg0.YouPlacedText:completeAnimation()
			f8_arg0.YouPlacedText:setTopBottom(0, 0, 50, 75)
			f8_arg0.YouPlacedText:setAlpha(0)
			f8_local2(f8_arg0.YouPlacedText)
			local f8_local3 = function(f18_arg0)
				f8_arg0.Sound:playSound("uin_wlh_current_rank", f8_arg1)
				f8_arg0.Sound:beginAnimation(2000)
				f8_arg0.Sound:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Sound:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("uin_wlh_placement", f8_arg1)
					f8_arg0.clipFinished(element, event)
				end)
			end
			f8_arg0.Sound:completeAnimation()
			f8_arg0.Sound:setPlaySoundDirect(true)
			f8_local3(f8_arg0.Sound)
		end,
	},
	FirstPlace = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.CurrentRank:completeAnimation()
			f20_arg0.CurrentRank:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.CurrentRank)
			f20_arg0.PlacementResult:completeAnimation()
			f20_arg0.PlacementResult:setTopBottom(0, 0, 0, 72)
			f20_arg0.PlacementResult:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.PlacementResult)
			f20_arg0.YouPlacedText:completeAnimation()
			f20_arg0.YouPlacedText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.YouPlacedText)
		end,
		Intro = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(4)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(499, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f23_arg0:setAlpha(0)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f22_arg0:beginAnimation(300)
				f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.CurrentRank:beginAnimation(500)
			f21_arg0.CurrentRank:setAlpha(1)
			f21_arg0.CurrentRank:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.CurrentRank:registerEventHandler("transition_complete_keyframe", f21_local0)
			local f21_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						local f26_local0 = function(f27_arg0)
							f27_arg0:beginAnimation(19)
							f27_arg0:setAlpha(1)
							f27_arg0:setScale(1, 1)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
						end
						f26_arg0:beginAnimation(40)
						f26_arg0:setAlpha(0.9)
						f26_arg0:setScale(1.04, 1.04)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(139)
					f25_arg0:setAlpha(0.7)
					f25_arg0:setScale(0.92, 0.92)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f24_arg0:beginAnimation(900)
				f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f21_arg0.PlacementResult:beginAnimation(500)
			f21_arg0.PlacementResult:setTopBottom(0, 0, 0, 72)
			f21_arg0.PlacementResult:setAlpha(0)
			f21_arg0.PlacementResult:setScale(3.5, 3.5)
			f21_arg0.PlacementResult:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.PlacementResult:registerEventHandler("transition_complete_keyframe", f21_local1)
			f21_arg0.YouPlacedText:beginAnimation(500)
			f21_arg0.YouPlacedText:setAlpha(0)
			f21_arg0.YouPlacedText:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.YouPlacedText:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			f21_arg0.Sound:beginAnimation(1400)
			f21_arg0.Sound:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.Sound:registerEventHandler("transition_complete_keyframe", function(element, event)
				element:playSound("uin_wlh_placement", f21_arg1)
				f21_arg0.clipFinished(element, event)
			end)
		end,
	},
}
CoD.LeaguePlayEndRankUpPlacementText.__onClose = function(f29_arg0)
	f29_arg0.PlacementResult:close()
	f29_arg0.YouPlacedText:close()
end
