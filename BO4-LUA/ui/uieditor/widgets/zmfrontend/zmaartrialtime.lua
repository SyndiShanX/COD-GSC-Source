require("x64:b8cab39e4234d59")
CoD.ZMAARTrialTime = InheritFrom(LUI.UIElement)
CoD.ZMAARTrialTime.__defaultWidth = 200
CoD.ZMAARTrialTime.__defaultHeight = 82
CoD.ZMAARTrialTime.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARTrialTime)
	self.id = "ZMAARTrialTime"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RedDivider = LUI.UIImage.new(0, 0, -364, 200, 0, 0, -2.5, 81.5)
	RedDivider:setImage(RegisterImage(0x2B4D9F66374906A))
	self:addElement(RedDivider)
	self.RedDivider = RedDivider
	local MatchTimeValue = LUI.UIText.new(0, 0, 3, 176, 0, 0, 24.5, 57.5)
	MatchTimeValue:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	MatchTimeValue:setTTF("skorzhen")
	MatchTimeValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MatchTimeValue:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MatchTimeValue:subscribeToGlobalModel(f1_arg1, "AARTrialStats", "time", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MatchTimeValue:setText(f2_local0)
		end
	end)
	self:addElement(MatchTimeValue)
	self.MatchTimeValue = MatchTimeValue
	local MatchRoundValue = LUI.UIText.new(0, 0, 134, 176, 0, 0, 24.5, 57.5)
	MatchRoundValue:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	MatchRoundValue:setAlpha(0)
	MatchRoundValue:setTTF("skorzhen")
	MatchRoundValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MatchRoundValue:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	MatchRoundValue:subscribeToGlobalModel(f1_arg1, "AARTrialStats", "roundReached", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MatchRoundValue:setText(f3_local0)
		end
	end)
	self:addElement(MatchRoundValue)
	self.MatchRoundValue = MatchRoundValue
	local MatchRoundText = LUI.UIText.new(0, 0, -202, 118, 0, 0, 24.5, 57.5)
	MatchRoundText:setAlpha(0)
	MatchRoundText:setText(LocalizeToUpperString(0xD2E1A7BC904E98F))
	MatchRoundText:setTTF("skorzhen")
	MatchRoundText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	MatchRoundText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(MatchRoundText)
	self.MatchRoundText = MatchRoundText
	local MatchTimeText = CoD.ZMAARTimeText.new(f1_arg0, f1_arg1, 0, 0, -236, -3, 0, 0, 24.5, 57.5)
	MatchTimeText:mergeStateConditions({
		{
			stateName = "ShowNewBestTimeLeftAligned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "AAR.trialStats.isNewBestTime") and IsCurrentLanguageArabic()
			end,
		},
		{
			stateName = "LeftAligned",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	local f1_local6 = MatchTimeText
	local f1_local7 = MatchTimeText.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["AAR.trialStats.isNewBestTime"], function(f6_arg0)
		f1_arg0:updateElementState(MatchTimeText, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "AAR.trialStats.isNewBestTime",
		})
	end, false)
	self:addElement(MatchTimeText)
	self.MatchTimeText = MatchTimeText
	self:mergeStateConditions({
		{
			stateName = "ShowBestTimeAndRoundFlipped",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "AAR.trialStats.isNewHighestRound") and IsCurrentLanguageArabic()
			end,
		},
		{
			stateName = "ShowBestTimeAndRound",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "AAR.trialStats.isNewHighestRound")
			end,
		},
		{
			stateName = "DefaultStateFlipped",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["AAR.trialStats.isNewHighestRound"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "AAR.trialStats.isNewHighestRound",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARTrialTime.__resetProperties = function(f11_arg0)
	f11_arg0.MatchRoundValue:completeAnimation()
	f11_arg0.MatchTimeValue:completeAnimation()
	f11_arg0.MatchRoundText:completeAnimation()
	f11_arg0.MatchTimeText:completeAnimation()
	f11_arg0.MatchRoundValue:setLeftRight(0, 0, 134, 176)
	f11_arg0.MatchRoundValue:setAlpha(0)
	f11_arg0.MatchRoundValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	f11_arg0.MatchTimeValue:setLeftRight(0, 0, 3, 176)
	f11_arg0.MatchTimeValue:setAlpha(1)
	f11_arg0.MatchTimeValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	f11_arg0.MatchTimeValue:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	f11_arg0.MatchRoundText:setLeftRight(0, 0, -202, 118)
	f11_arg0.MatchRoundText:setAlpha(0)
	f11_arg0.MatchRoundText:setText(LocalizeToUpperString(0xD2E1A7BC904E98F))
	f11_arg0.MatchRoundText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	f11_arg0.MatchTimeText:setLeftRight(0, 0, -236, -3)
	f11_arg0.MatchTimeText:setAlpha(1)
end
CoD.ZMAARTrialTime.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	ShowBestTimeAndRoundFlipped = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						f16_arg0:beginAnimation(390)
						f16_arg0:setAlpha(0)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
					end
					f15_arg0:beginAnimation(989)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.MatchTimeValue:beginAnimation(310)
				f13_arg0.MatchTimeValue:setAlpha(1)
				f13_arg0.MatchTimeValue:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.MatchTimeValue:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.MatchTimeValue:completeAnimation()
			f13_arg0.MatchTimeValue:setLeftRight(0, 0, -178, -5)
			f13_arg0.MatchTimeValue:setAlpha(0)
			f13_arg0.MatchTimeValue:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
			f13_local0(f13_arg0.MatchTimeValue)
			local f13_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							local f20_local0 = function(f21_arg0)
								f21_arg0:beginAnimation(339)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
							end
							f20_arg0:beginAnimation(370)
							f20_arg0:setAlpha(0)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(1010)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(299)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f13_arg0.MatchRoundValue:beginAnimation(2000)
				f13_arg0.MatchRoundValue:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.MatchRoundValue:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f13_arg0.MatchRoundValue:completeAnimation()
			f13_arg0.MatchRoundValue:setLeftRight(0, 0, -55, -13)
			f13_arg0.MatchRoundValue:setAlpha(0)
			f13_arg0.MatchRoundValue:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
			f13_local1(f13_arg0.MatchRoundValue)
			local f13_local2 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							local f25_local0 = function(f26_arg0)
								f26_arg0:beginAnimation(339)
								f26_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
							end
							f25_arg0:beginAnimation(370)
							f25_arg0:setAlpha(0)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
						end
						f24_arg0:beginAnimation(1010)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(299)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f13_arg0.MatchRoundText:beginAnimation(2000)
				f13_arg0.MatchRoundText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.MatchRoundText:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f13_arg0.MatchRoundText:completeAnimation()
			f13_arg0.MatchRoundText:setLeftRight(0, 0, 3, 323)
			f13_arg0.MatchRoundText:setAlpha(0)
			f13_arg0.MatchRoundText:setText(LocalizeToUpperString(0xD2E1A7BC904E98F))
			f13_arg0.MatchRoundText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
			f13_local2(f13_arg0.MatchRoundText)
			local f13_local3 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					local f28_local0 = function(f29_arg0)
						f29_arg0:beginAnimation(390)
						f29_arg0:setAlpha(0)
						f29_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
					end
					f28_arg0:beginAnimation(989)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
				end
				f13_arg0.MatchTimeText:beginAnimation(310)
				f13_arg0.MatchTimeText:setAlpha(1)
				f13_arg0.MatchTimeText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.MatchTimeText:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f13_arg0.MatchTimeText:completeAnimation()
			f13_arg0.MatchTimeText:setLeftRight(0, 0, 3, 236)
			f13_arg0.MatchTimeText:setAlpha(0)
			f13_local3(f13_arg0.MatchTimeText)
			f13_arg0.nextClip = "DefaultClip"
		end,
	},
	ShowBestTimeAndRound = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(4)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						f33_arg0:beginAnimation(390)
						f33_arg0:setAlpha(0)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
					end
					f32_arg0:beginAnimation(989)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f30_arg0.MatchTimeValue:beginAnimation(310)
				f30_arg0.MatchTimeValue:setAlpha(1)
				f30_arg0.MatchTimeValue:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.MatchTimeValue:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.MatchTimeValue:completeAnimation()
			f30_arg0.MatchTimeValue:setLeftRight(0, 0, 3, 176)
			f30_arg0.MatchTimeValue:setAlpha(0)
			f30_arg0.MatchTimeValue:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
			f30_local0(f30_arg0.MatchTimeValue)
			local f30_local1 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						local f36_local0 = function(f37_arg0)
							local f37_local0 = function(f38_arg0)
								f38_arg0:beginAnimation(339)
								f38_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
							end
							f37_arg0:beginAnimation(370)
							f37_arg0:setAlpha(0)
							f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
						end
						f36_arg0:beginAnimation(1010)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
					end
					f35_arg0:beginAnimation(299)
					f35_arg0:setAlpha(1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f30_arg0.MatchRoundValue:beginAnimation(2000)
				f30_arg0.MatchRoundValue:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.MatchRoundValue:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f30_arg0.MatchRoundValue:completeAnimation()
			f30_arg0.MatchRoundValue:setLeftRight(0, 0, 134, 176)
			f30_arg0.MatchRoundValue:setAlpha(0)
			f30_local1(f30_arg0.MatchRoundValue)
			local f30_local2 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					local f40_local0 = function(f41_arg0)
						local f41_local0 = function(f42_arg0)
							local f42_local0 = function(f43_arg0)
								f43_arg0:beginAnimation(339)
								f43_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
							end
							f42_arg0:beginAnimation(370)
							f42_arg0:setAlpha(0)
							f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
						end
						f41_arg0:beginAnimation(1010)
						f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
					end
					f40_arg0:beginAnimation(299)
					f40_arg0:setAlpha(1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
				end
				f30_arg0.MatchRoundText:beginAnimation(2000)
				f30_arg0.MatchRoundText:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.MatchRoundText:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f30_arg0.MatchRoundText:completeAnimation()
			f30_arg0.MatchRoundText:setLeftRight(0, 0, -202, 118)
			f30_arg0.MatchRoundText:setAlpha(0)
			f30_arg0.MatchRoundText:setText(LocalizeToUpperString(0xD2E1A7BC904E98F))
			f30_local2(f30_arg0.MatchRoundText)
			local f30_local3 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						f46_arg0:beginAnimation(390)
						f46_arg0:setAlpha(0)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
					end
					f45_arg0:beginAnimation(989)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f30_arg0.MatchTimeText:beginAnimation(310)
				f30_arg0.MatchTimeText:setAlpha(1)
				f30_arg0.MatchTimeText:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.MatchTimeText:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f30_arg0.MatchTimeText:completeAnimation()
			f30_arg0.MatchTimeText:setLeftRight(0, 0, -236, -3)
			f30_arg0.MatchTimeText:setAlpha(0)
			f30_local3(f30_arg0.MatchTimeText)
			f30_arg0.nextClip = "DefaultClip"
		end,
	},
	DefaultStateFlipped = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(2)
			f47_arg0.MatchTimeValue:completeAnimation()
			f47_arg0.MatchTimeValue:setLeftRight(0, 0, -178, -5)
			f47_arg0.MatchTimeValue:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
			f47_arg0.clipFinished(f47_arg0.MatchTimeValue)
			f47_arg0.MatchTimeText:completeAnimation()
			f47_arg0.MatchTimeText:setLeftRight(0, 0, 3, 236)
			f47_arg0.clipFinished(f47_arg0.MatchTimeText)
		end,
	},
}
CoD.ZMAARTrialTime.__onClose = function(f48_arg0)
	f48_arg0.MatchTimeValue:close()
	f48_arg0.MatchRoundValue:close()
	f48_arg0.MatchTimeText:close()
end
