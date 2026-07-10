require("x64:74e2ffcde193001")
require("x64:a3eb44c55e76ee9")
require("x64:48da4c2d03c4d74")
require("x64:1cde412e3e33842")
require("x64:c9231c3099ddbc8")
CoD.PC_Korea_Event_Frame = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Frame.__defaultWidth = 1920
CoD.PC_Korea_Event_Frame.__defaultHeight = 1080
CoD.PC_Korea_Event_Frame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	InitDataSourceModel(f1_arg1, "PCKoreaEventProgression")
	self:setClass(CoD.PC_Korea_Event_Frame)
	self.id = "PC_Korea_Event_Frame"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.38, 0.38, 0.38)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local BlackScreen = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackScreen:setRGB(0, 0, 0)
	BlackScreen:setAlpha(0.85)
	self:addElement(BlackScreen)
	self.BlackScreen = BlackScreen
	local PCKoreaEventMonthProgression = CoD.PC_Korea_Event_Month_Progression.new(f1_arg0, f1_arg1, 0.5, 0.5, 140, 840, 0.5, 0.5, -205.5, 241.5)
	self:addElement(PCKoreaEventMonthProgression)
	self.PCKoreaEventMonthProgression = PCKoreaEventMonthProgression
	local PCKoreaEventTierProgress = CoD.PC_Korea_Event_TierProgress.new(f1_arg0, f1_arg1, 0.5, 0.5, -931, -25, 0.5, 0.5, -195, 265)
	self:addElement(PCKoreaEventTierProgress)
	self.PCKoreaEventTierProgress = PCKoreaEventTierProgress
	local EventName = LUI.UIText.new(0.5, 0.5, -837, -123, 0.5, 0.5, -366, -336)
	EventName:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EventName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_648B6358827FB817"))
	EventName:setTTF("ttmussels_regular")
	EventName:setLetterSpacing(4)
	EventName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EventName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EventName)
	self.EventName = EventName
	local Bracket = LUI.UIImage.new(0.5, 0.5, -836.5, -123.5, 0.5, 0.5, -319, -307)
	Bracket:setZRot(180)
	Bracket:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	Bracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	Bracket:setShaderVector(0, 0, 0, 0, 0)
	Bracket:setupNineSliceShader(20, 8)
	self:addElement(Bracket)
	self.Bracket = Bracket
	local EventEnding = LUI.UIText.new(0.5, 0.5, -811, -143, 0.5, 0.5, -290.5, -275.5)
	EventEnding:setTTF("dinnext_regular")
	EventEnding:setLetterSpacing(3)
	EventEnding:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EventEnding:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	EventEnding:subscribeToGlobalModel(f1_arg1, "PCKoreaEventProgression", "timeRemaining", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EventEnding:setText(f2_local0)
		end
	end)
	self:addElement(EventEnding)
	self.EventEnding = EventEnding
	local TierDescription = CoD.PC_Korea_Event_Tier_Description.new(f1_arg0, f1_arg1, 0.5, 0.5, -830.5, -129.5, 0.5, 0.5, 265.5, 424.5)
	self:addElement(TierDescription)
	self.TierDescription = TierDescription
	local MonthlyRewardDescription = CoD.PC_Korea_Event_Tier_Description.new(f1_arg0, f1_arg1, 0.5, 0.5, 137.5, 838.5, 0.5, 0.5, 265.5, 424.5)
	MonthlyRewardDescription.TierUpgradeDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_522D499CE14DA97C"))
	MonthlyRewardDescription.TierTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3B1618F7EFE3E57D"))
	MonthlyRewardDescription:subscribeToGlobalModel(f1_arg1, "PCKoreaEventProgression", "currentWeekRewardImage", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MonthlyRewardDescription.TierToken:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(MonthlyRewardDescription)
	self.MonthlyRewardDescription = MonthlyRewardDescription
	local WeekTitleImage = CoD.PC_Korea_Event_Week_WeekProgress_Title.new(f1_arg0, f1_arg1, 0.5, 0.5, 136.5, 841.5, 0.5, 0.5, -363.5, -266.5)
	self:addElement(WeekTitleImage)
	self.WeekTitleImage = WeekTitleImage
	local RewardBG = LUI.UIImage.new(0.5, 0.5, 586.5, 843.5, 0.5, 0.5, -237, -205)
	RewardBG:setImage(RegisterImage(@"uie_pc_igrevent_weekprogression_reward_bg"))
	self:addElement(RewardBG)
	self.RewardBG = RewardBG
	local RewardTitle = LUI.UIText.new(0.5, 0.5, 595.5, 834.5, 0.5, 0.5, -225, -207)
	RewardTitle:setRGB(0, 0, 0)
	RewardTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5EBE7E1D4C88CDB1"))
	RewardTitle:setTTF("ttmussels_demibold")
	RewardTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RewardTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(RewardTitle)
	self.RewardTitle = RewardTitle
	local Darkened = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Darkened:setRGB(0, 0, 0)
	Darkened:setAlpha(0)
	self:addElement(Darkened)
	self.Darkened = Darkened
	local RewardPopUp = CoD.PC_Korea_Event_PopUp_Reward.new(f1_arg0, f1_arg1, 0.5, 0.5, -362, 362, 0.5, 0.5, -362, 362)
	RewardPopUp:setAlpha(0)
	RewardPopUp:subscribeToGlobalModel(f1_arg1, "PCKoreaEventProgression", "rewardPopUpImage", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RewardPopUp.RewardItemImage:setImage(RegisterImage(f4_local0))
		end
	end)
	RewardPopUp:subscribeToGlobalModel(f1_arg1, "PCKoreaEventProgression", "rewardPopUpText", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			RewardPopUp.ItemNameTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(RewardPopUp)
	self.RewardPopUp = RewardPopUp
	local MontlhyRewardPopUp = CoD.PC_Korea_Event_PopUp_Reward.new(f1_arg0, f1_arg1, 0.5, 0.5, -362, 362, 0.5, 0.5, -362, 362)
	MontlhyRewardPopUp:setAlpha(0)
	MontlhyRewardPopUp.ItemNameTextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7965FE64C4307AD1"))
	self:addElement(MontlhyRewardPopUp)
	self.MontlhyRewardPopUp = MontlhyRewardPopUp
	local PopUpRewardSound = LUI.UIElement.new(0, 0, 1853, 1885, 0, 0, 1077.5, 1109.5)
	self:addElement(PopUpRewardSound)
	self.PopUpRewardSound = PopUpRewardSound
	self:mergeStateConditions({
		{
			stateName = "ReceiveReward",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventProgression.isCurrentWeekCompleted")
			end,
		},
		{
			stateName = "ReceiveMonthlyReward",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "PCKoreaEventProgression.showCompletedMonthPopUp")
			end,
		},
	})
	local f1_local17 = self
	local f1_local18 = self.subscribeToModel
	local f1_local19 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local18(f1_local17, f1_local19["PCKoreaEventProgression.isCurrentWeekCompleted"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "PCKoreaEventProgression.isCurrentWeekCompleted",
		})
	end, false)
	f1_local17 = self
	f1_local18 = self.subscribeToModel
	f1_local19 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local18(f1_local17, f1_local19["PCKoreaEventProgression.showCompletedMonthPopUp"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "PCKoreaEventProgression.showCompletedMonthPopUp",
		})
	end, false)
	PCKoreaEventMonthProgression.id = "PCKoreaEventMonthProgression"
	PCKoreaEventTierProgress.id = "PCKoreaEventTierProgress"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local18 = self
	CoD.PCKoreaEventUtility.SetupKoreaEventRemainingTime(self, f1_arg1)
	CoD.PCKoreaEventUtility.AnimateKoreaEventBar(f1_arg0, f1_arg1, self.PCKoreaEventMonthProgression, self.PCKoreaEventTierProgress)
	return self
end
CoD.PC_Korea_Event_Frame.__resetProperties = function(f10_arg0)
	f10_arg0.RewardPopUp:completeAnimation()
	f10_arg0.Darkened:completeAnimation()
	f10_arg0.PopUpRewardSound:completeAnimation()
	f10_arg0.MontlhyRewardPopUp:completeAnimation()
	f10_arg0.RewardPopUp:setAlpha(0)
	f10_arg0.RewardPopUp:setScale(1, 1)
	f10_arg0.Darkened:setAlpha(0)
	f10_arg0.PopUpRewardSound:setPlaySoundDirect(false)
	f10_arg0.MontlhyRewardPopUp:setAlpha(0)
	f10_arg0.MontlhyRewardPopUp:setScale(1, 1)
end
CoD.PC_Korea_Event_Frame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	ReceiveReward = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						f15_arg0:beginAnimation(210)
						f15_arg0:setAlpha(0)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f14_arg0:beginAnimation(3050)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f12_arg0.Darkened:beginAnimation(190)
				f12_arg0.Darkened:setAlpha(0.7)
				f12_arg0.Darkened:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Darkened:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.Darkened:completeAnimation()
			f12_arg0.Darkened:setAlpha(0)
			f12_local0(f12_arg0.Darkened)
			local f12_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						local f18_local0 = function(f19_arg0)
							local f19_local0 = function(f20_arg0)
								f20_arg0:beginAnimation(210)
								f20_arg0:setAlpha(0)
								f20_arg0:setScale(0.5, 0.5)
								f20_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
							end
							f19_arg0:beginAnimation(69)
							f19_arg0:setScale(1.2, 1.2)
							f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
						end
						f18_arg0:beginAnimation(2910)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
					end
					f17_arg0:beginAnimation(69)
					f17_arg0:setScale(1, 1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f12_arg0.RewardPopUp:beginAnimation(190)
				f12_arg0.RewardPopUp:setAlpha(1)
				f12_arg0.RewardPopUp:setScale(1.2, 1.2)
				f12_arg0.RewardPopUp:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.RewardPopUp:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f12_arg0.RewardPopUp:completeAnimation()
			f12_arg0.RewardPopUp:setAlpha(0)
			f12_arg0.RewardPopUp:setScale(0.5, 0.5)
			f12_local1(f12_arg0.RewardPopUp)
			local f12_local2 = function(f21_arg0)
				f12_arg0.PopUpRewardSound:playSound("uin_igr_receivereward_in", f12_arg1)
				f12_arg0.PopUpRewardSound:beginAnimation(3170)
				f12_arg0.PopUpRewardSound:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.PopUpRewardSound:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("uin_igr_receivereward_out", f12_arg1)
					f12_arg0.clipFinished(element, event)
				end)
			end
			f12_arg0.PopUpRewardSound:completeAnimation()
			f12_arg0.PopUpRewardSound:setPlaySoundDirect(true)
			f12_local2(f12_arg0.PopUpRewardSound)
		end,
	},
	ReceiveMonthlyReward = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(3)
			local f23_local0 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						local f26_local0 = function(f27_arg0)
							local f27_local0 = function(f28_arg0)
								local f28_local0 = function(f29_arg0)
									local f29_local0 = function(f30_arg0)
										f30_arg0:beginAnimation(210)
										f30_arg0:setAlpha(0)
										f30_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
									end
									f29_arg0:beginAnimation(3050)
									f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
								end
								f28_arg0:beginAnimation(190)
								f28_arg0:setAlpha(0.7)
								f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
							end
							f27_arg0:beginAnimation(130)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
						end
						f26_arg0:beginAnimation(210)
						f26_arg0:setAlpha(0)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(3050)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f24_arg0:beginAnimation(190)
				f24_arg0:setAlpha(0.7)
				f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f23_arg0.Darkened:beginAnimation(2320)
			f23_arg0.Darkened:setAlpha(0)
			f23_arg0.Darkened:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
			f23_arg0.Darkened:registerEventHandler("transition_complete_keyframe", f23_local0)
			local f23_local1 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						local f33_local0 = function(f34_arg0)
							local f34_local0 = function(f35_arg0)
								f35_arg0:beginAnimation(210)
								f35_arg0:setAlpha(0)
								f35_arg0:setScale(0.5, 0.5)
								f35_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
							end
							f34_arg0:beginAnimation(70)
							f34_arg0:setScale(1.2, 1.2)
							f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
						end
						f33_arg0:beginAnimation(2909)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
					end
					f32_arg0:beginAnimation(69)
					f32_arg0:setScale(1, 1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f31_arg0:beginAnimation(190)
				f31_arg0:setAlpha(1)
				f31_arg0:setScale(1.2, 1.2)
				f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f23_arg0.RewardPopUp:beginAnimation(2320)
			f23_arg0.RewardPopUp:setAlpha(0)
			f23_arg0.RewardPopUp:setScale(0.5, 0.5)
			f23_arg0.RewardPopUp:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
			f23_arg0.RewardPopUp:registerEventHandler("transition_complete_keyframe", f23_local1)
			local f23_local2 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					local f37_local0 = function(f38_arg0)
						local f38_local0 = function(f39_arg0)
							local f39_local0 = function(f40_arg0)
								f40_arg0:beginAnimation(210)
								f40_arg0:setAlpha(0)
								f40_arg0:setScale(0.5, 0.5)
								f40_arg0:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
							end
							f39_arg0:beginAnimation(70)
							f39_arg0:setScale(1.2, 1.2)
							f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
						end
						f38_arg0:beginAnimation(2909)
						f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
					end
					f37_arg0:beginAnimation(69)
					f37_arg0:setScale(1, 1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
				end
				f36_arg0:beginAnimation(190)
				f36_arg0:setAlpha(1)
				f36_arg0:setScale(1.2, 1.2)
				f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f23_arg0.MontlhyRewardPopUp:beginAnimation(5900)
			f23_arg0.MontlhyRewardPopUp:setAlpha(0)
			f23_arg0.MontlhyRewardPopUp:setScale(1, 1)
			f23_arg0.MontlhyRewardPopUp:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
			f23_arg0.MontlhyRewardPopUp:registerEventHandler("transition_complete_keyframe", f23_local2)
		end,
	},
}
CoD.PC_Korea_Event_Frame.__onClose = function(f41_arg0)
	f41_arg0.PCKoreaEventMonthProgression:close()
	f41_arg0.PCKoreaEventTierProgress:close()
	f41_arg0.EventEnding:close()
	f41_arg0.TierDescription:close()
	f41_arg0.MonthlyRewardDescription:close()
	f41_arg0.WeekTitleImage:close()
	f41_arg0.RewardPopUp:close()
	f41_arg0.MontlhyRewardPopUp:close()
end
