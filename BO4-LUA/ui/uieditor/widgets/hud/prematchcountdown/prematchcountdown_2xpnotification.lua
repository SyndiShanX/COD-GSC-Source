require("x64:182408ff493d0c1")
require("x64:ccda226110a5e1")
require("x64:9e7be51d884ab71")
require("x64:683120446682173")
CoD.PrematchCountdown_2xpNotification = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_2xpNotification.__defaultWidth = 400
CoD.PrematchCountdown_2xpNotification.__defaultHeight = 255
CoD.PrematchCountdown_2xpNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown_2xpNotification)
	self.id = "PrematchCountdown_2xpNotification"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXPText = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -213, 213, 0, 0, 177, 225)
	DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_xp"))
	DoubleXPText.MatchText:setBackingAlpha(0.7)
	self:addElement(DoubleXPText)
	self.DoubleXPText = DoubleXPText
	local PrematchCountdown2xpBadge = CoD.PrematchCountdown_2xpBadge.new(f1_arg0, f1_arg1, 0.5, 0.5, -192, 0, 0, 0, 0, 192)
	PrematchCountdown2xpBadge:setScale(0.75, 0.75)
	self:addElement(PrematchCountdown2xpBadge)
	self.PrematchCountdown2xpBadge = PrematchCountdown2xpBadge
	local PrematchCountdown2xpWeaponBadge = CoD.PrematchCountdown_2xpWeaponBadge.new(f1_arg0, f1_arg1, 0.5, 0.5, 0, 192, 0, 0, 0, 192)
	PrematchCountdown2xpWeaponBadge:setScale(0.75, 0.75)
	self:addElement(PrematchCountdown2xpWeaponBadge)
	self.PrematchCountdown2xpWeaponBadge = PrematchCountdown2xpWeaponBadge
	local TierBoost = CoD.Notification2xpBlackMarketReward.new(f1_arg0, f1_arg1, 0, 0, 104, 296, 0, 0, 0, 192)
	TierBoost:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsTierBoostActive(f1_arg1) and CoD.HUDUtility.IsFirstRound(f1_arg1)
			end,
		},
	})
	local f1_local5 = TierBoost
	local f1_local6 = TierBoost.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["gameScore.roundsPlayed"], function(f3_arg0)
		f1_arg0:updateElementState(TierBoost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "gameScore.roundsPlayed",
		})
	end, false)
	TierBoost:setAlpha(0)
	TierBoost:setScale(0.75, 0.75)
	TierBoost.XpSmall:setImage(RegisterImage(@"ui_icon_2xp_blackmarket"))
	self:addElement(TierBoost)
	self.TierBoost = TierBoost
	self:mergeStateConditions({
		{
			stateName = "All",
			condition = function(menu, element, event)
				local f4_local0 = CoD.HUDUtility.IsFirstRound(f1_arg1)
				if f4_local0 then
					f4_local0 = IsDoubleXP(f1_arg1)
					if f4_local0 then
						f4_local0 = IsDoubleWeaponXP(f1_arg1)
						if f4_local0 then
							f4_local0 = IsTierBoostActive(f1_arg1)
						end
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "XpAndWeapon",
			condition = function(menu, element, event)
				local f5_local0 = CoD.HUDUtility.IsFirstRound(f1_arg1)
				if f5_local0 then
					f5_local0 = IsDoubleXP(f1_arg1)
					if f5_local0 then
						f5_local0 = IsDoubleWeaponXP(f1_arg1)
						if f5_local0 then
							f5_local0 = not IsTierBoostActive(f1_arg1)
						end
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "XpAndTier",
			condition = function(menu, element, event)
				local f6_local0 = CoD.HUDUtility.IsFirstRound(f1_arg1)
				if f6_local0 then
					f6_local0 = IsDoubleXP(f1_arg1)
					if f6_local0 then
						if not IsDoubleWeaponXP(f1_arg1) then
							f6_local0 = IsTierBoostActive(f1_arg1)
						else
							f6_local0 = false
						end
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "WeaponAndTier",
			condition = function(menu, element, event)
				local f7_local0 = CoD.HUDUtility.IsFirstRound(f1_arg1)
				if f7_local0 then
					if not IsDoubleXP(f1_arg1) then
						f7_local0 = IsDoubleWeaponXP(f1_arg1)
						if f7_local0 then
							f7_local0 = IsTierBoostActive(f1_arg1)
						end
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "DoubleXP",
			condition = function(menu, element, event)
				local f8_local0 = CoD.HUDUtility.IsFirstRound(f1_arg1)
				if f8_local0 then
					f8_local0 = IsDoubleXP(f1_arg1)
					if f8_local0 then
						f8_local0 = not IsWarzone()
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "WZDoubleXP",
			condition = function(menu, element, event)
				local f9_local0 = CoD.HUDUtility.IsFirstRound(f1_arg1)
				if f9_local0 then
					f9_local0 = IsDoubleXP(f1_arg1)
					if f9_local0 then
						f9_local0 = IsWarzone()
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "DoubleWeaponXP",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsFirstRound(f1_arg1) and IsDoubleWeaponXP(f1_arg1)
			end,
		},
		{
			stateName = "TierBoost",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsFirstRound(f1_arg1) and IsTierBoostActive(f1_arg1)
			end,
		},
	})
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7["gameScore.roundsPlayed"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "gameScore.roundsPlayed",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["lobbyRoot.lobbyNav"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PrematchCountdown_2xpNotification.__resetProperties = function(f14_arg0)
	f14_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
	f14_arg0.PrematchCountdown2xpBadge:completeAnimation()
	f14_arg0.DoubleXPText:completeAnimation()
	f14_arg0.TierBoost:completeAnimation()
	f14_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 0, 192)
	f14_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
	f14_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -192, 0)
	f14_arg0.PrematchCountdown2xpBadge:setAlpha(1)
	f14_arg0.DoubleXPText:setAlpha(1)
	f14_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_xp"))
	f14_arg0.TierBoost:setLeftRight(0, 0, 104, 296)
	f14_arg0.TierBoost:setAlpha(0)
end
CoD.PrematchCountdown_2xpNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			f15_arg0.DoubleXPText:completeAnimation()
			f15_arg0.DoubleXPText:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DoubleXPText)
			f15_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f15_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PrematchCountdown2xpBadge)
			f15_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f15_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PrematchCountdown2xpWeaponBadge)
			f15_arg0.TierBoost:completeAnimation()
			f15_arg0.TierBoost:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TierBoost)
		end,
	},
	All = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.DoubleXPText:completeAnimation()
			f16_arg0.DoubleXPText.MatchText:completeAnimation()
			f16_arg0.DoubleXPText:setAlpha(0)
			f16_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/triple_double"))
			f16_arg0.clipFinished(f16_arg0.DoubleXPText)
			f16_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f16_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f16_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.PrematchCountdown2xpBadge)
			f16_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f16_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 96, 288)
			f16_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.PrematchCountdown2xpWeaponBadge)
			f16_arg0.TierBoost:completeAnimation()
			f16_arg0.TierBoost:setLeftRight(0, 0, -88, 104)
			f16_arg0.TierBoost:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TierBoost)
		end,
		Notify = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(4)
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
													local f27_local0 = function(f28_arg0)
														local f28_local0 = function(f29_arg0)
															local f29_local0 = function(f30_arg0)
																local f30_local0 = function(f31_arg0)
																	local f31_local0 = function(f32_arg0)
																		local f32_local0 = function(f33_arg0)
																			local f33_local0 = function(f34_arg0)
																				f34_arg0:beginAnimation(189)
																				f34_arg0:setAlpha(0)
																				f34_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
																			end
																			f33_arg0:beginAnimation(19)
																			f33_arg0:setAlpha(0.45)
																			f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
																		end
																		f32_arg0:beginAnimation(19)
																		f32_arg0:setAlpha(0.34)
																		f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
																	end
																	f31_arg0:beginAnimation(70)
																	f31_arg0:setAlpha(0.55)
																	f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
																end
																f30_arg0:beginAnimation(19)
																f30_arg0:setAlpha(0.71)
																f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
															end
															f29_arg0:beginAnimation(29)
															f29_arg0:setAlpha(0.44)
															f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
														end
														f28_arg0:beginAnimation(70)
														f28_arg0:setAlpha(0.83)
														f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
													end
													f27_arg0:beginAnimation(1150)
													f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
												end
												f26_arg0:beginAnimation(9)
												f26_arg0:setAlpha(1)
												f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
											end
											f25_arg0:beginAnimation(20)
											f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
										end
										f24_arg0:beginAnimation(9)
										f24_arg0:setAlpha(0.76)
										f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
									end
									f23_arg0:beginAnimation(39)
									f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
								end
								f22_arg0:beginAnimation(10)
								f22_arg0:setAlpha(1)
								f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
							end
							f21_arg0:beginAnimation(19)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
						end
						f20_arg0:beginAnimation(9)
						f20_arg0:setAlpha(0.45)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(160)
					f19_arg0:setAlpha(0.95)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f17_arg0.DoubleXPText:beginAnimation(200)
				f17_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.DoubleXPText:completeAnimation()
			f17_arg0.DoubleXPText.MatchText:completeAnimation()
			f17_arg0.DoubleXPText:setAlpha(0)
			f17_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/triple_double"))
			f17_local0(f17_arg0.DoubleXPText)
			local f17_local1 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					local f36_local0 = function(f37_arg0)
						local f37_local0 = function(f38_arg0)
							local f38_local0 = function(f39_arg0)
								local f39_local0 = function(f40_arg0)
									local f40_local0 = function(f41_arg0)
										local f41_local0 = function(f42_arg0)
											local f42_local0 = function(f43_arg0)
												f43_arg0:beginAnimation(69)
												f43_arg0:setAlpha(0)
												f43_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
											end
											f42_arg0:beginAnimation(90)
											f42_arg0:setAlpha(1)
											f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
										end
										f41_arg0:beginAnimation(90)
										f41_arg0:setAlpha(0.2)
										f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
									end
									f40_arg0:beginAnimation(1160)
									f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
								end
								f39_arg0:beginAnimation(139)
								f39_arg0:setAlpha(1)
								f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
							end
							f38_arg0:beginAnimation(110)
							f38_arg0:setAlpha(0.2)
							f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
						end
						f37_arg0:beginAnimation(100)
						f37_arg0:setAlpha(1)
						f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
					end
					f36_arg0:beginAnimation(89)
					f36_arg0:setAlpha(0.2)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
				end
				f17_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f17_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f17_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f17_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f17_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f17_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f17_local1(f17_arg0.PrematchCountdown2xpBadge)
			local f17_local2 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						local f46_local0 = function(f47_arg0)
							local f47_local0 = function(f48_arg0)
								local f48_local0 = function(f49_arg0)
									local f49_local0 = function(f50_arg0)
										local f50_local0 = function(f51_arg0)
											local f51_local0 = function(f52_arg0)
												f52_arg0:beginAnimation(69)
												f52_arg0:setAlpha(0)
												f52_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
											end
											f51_arg0:beginAnimation(90)
											f51_arg0:setAlpha(1)
											f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
										end
										f50_arg0:beginAnimation(90)
										f50_arg0:setAlpha(0.2)
										f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
									end
									f49_arg0:beginAnimation(1160)
									f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
								end
								f48_arg0:beginAnimation(139)
								f48_arg0:setAlpha(1)
								f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
							end
							f47_arg0:beginAnimation(110)
							f47_arg0:setAlpha(0.2)
							f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
						end
						f46_arg0:beginAnimation(100)
						f46_arg0:setAlpha(1)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
					end
					f45_arg0:beginAnimation(89)
					f45_arg0:setAlpha(0.2)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f17_arg0.PrematchCountdown2xpWeaponBadge:beginAnimation(40)
				f17_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
				f17_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f17_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f17_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 96, 288)
			f17_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f17_local2(f17_arg0.PrematchCountdown2xpWeaponBadge)
			local f17_local3 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					local f54_local0 = function(f55_arg0)
						local f55_local0 = function(f56_arg0)
							local f56_local0 = function(f57_arg0)
								local f57_local0 = function(f58_arg0)
									local f58_local0 = function(f59_arg0)
										local f59_local0 = function(f60_arg0)
											local f60_local0 = function(f61_arg0)
												f61_arg0:beginAnimation(69)
												f61_arg0:setAlpha(0)
												f61_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
											end
											f60_arg0:beginAnimation(90)
											f60_arg0:setAlpha(1)
											f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
										end
										f59_arg0:beginAnimation(90)
										f59_arg0:setAlpha(0.2)
										f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
									end
									f58_arg0:beginAnimation(1160)
									f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
								end
								f57_arg0:beginAnimation(139)
								f57_arg0:setAlpha(1)
								f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
							end
							f56_arg0:beginAnimation(110)
							f56_arg0:setAlpha(0.2)
							f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
						end
						f55_arg0:beginAnimation(100)
						f55_arg0:setAlpha(1)
						f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
					end
					f54_arg0:beginAnimation(89)
					f54_arg0:setAlpha(0.2)
					f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
				end
				f17_arg0.TierBoost:beginAnimation(40)
				f17_arg0.TierBoost:setAlpha(1)
				f17_arg0.TierBoost:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.TierBoost:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f17_arg0.TierBoost:completeAnimation()
			f17_arg0.TierBoost:setLeftRight(0, 0, -88, 104)
			f17_arg0.TierBoost:setAlpha(0)
			f17_local3(f17_arg0.TierBoost)
		end,
	},
	XpAndWeapon = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(3)
			f62_arg0.DoubleXPText:completeAnimation()
			f62_arg0.DoubleXPText.MatchText:completeAnimation()
			f62_arg0.DoubleXPText:setAlpha(0)
			f62_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_double"))
			f62_arg0.clipFinished(f62_arg0.DoubleXPText)
			f62_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f62_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.PrematchCountdown2xpBadge)
			f62_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f62_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.PrematchCountdown2xpWeaponBadge)
		end,
		Notify = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(3)
			local f63_local0 = function(f64_arg0)
				local f64_local0 = function(f65_arg0)
					local f65_local0 = function(f66_arg0)
						local f66_local0 = function(f67_arg0)
							local f67_local0 = function(f68_arg0)
								local f68_local0 = function(f69_arg0)
									local f69_local0 = function(f70_arg0)
										local f70_local0 = function(f71_arg0)
											local f71_local0 = function(f72_arg0)
												local f72_local0 = function(f73_arg0)
													local f73_local0 = function(f74_arg0)
														local f74_local0 = function(f75_arg0)
															local f75_local0 = function(f76_arg0)
																local f76_local0 = function(f77_arg0)
																	local f77_local0 = function(f78_arg0)
																		local f78_local0 = function(f79_arg0)
																			local f79_local0 = function(f80_arg0)
																				f80_arg0:beginAnimation(189)
																				f80_arg0:setAlpha(0)
																				f80_arg0:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
																			end
																			f79_arg0:beginAnimation(19)
																			f79_arg0:setAlpha(0.45)
																			f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
																		end
																		f78_arg0:beginAnimation(19)
																		f78_arg0:setAlpha(0.34)
																		f78_arg0:registerEventHandler("transition_complete_keyframe", f78_local0)
																	end
																	f77_arg0:beginAnimation(70)
																	f77_arg0:setAlpha(0.55)
																	f77_arg0:registerEventHandler("transition_complete_keyframe", f77_local0)
																end
																f76_arg0:beginAnimation(19)
																f76_arg0:setAlpha(0.71)
																f76_arg0:registerEventHandler("transition_complete_keyframe", f76_local0)
															end
															f75_arg0:beginAnimation(29)
															f75_arg0:setAlpha(0.44)
															f75_arg0:registerEventHandler("transition_complete_keyframe", f75_local0)
														end
														f74_arg0:beginAnimation(70)
														f74_arg0:setAlpha(0.83)
														f74_arg0:registerEventHandler("transition_complete_keyframe", f74_local0)
													end
													f73_arg0:beginAnimation(1150)
													f73_arg0:registerEventHandler("transition_complete_keyframe", f73_local0)
												end
												f72_arg0:beginAnimation(9)
												f72_arg0:setAlpha(1)
												f72_arg0:registerEventHandler("transition_complete_keyframe", f72_local0)
											end
											f71_arg0:beginAnimation(20)
											f71_arg0:registerEventHandler("transition_complete_keyframe", f71_local0)
										end
										f70_arg0:beginAnimation(9)
										f70_arg0:setAlpha(0.76)
										f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
									end
									f69_arg0:beginAnimation(39)
									f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
								end
								f68_arg0:beginAnimation(10)
								f68_arg0:setAlpha(1)
								f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
							end
							f67_arg0:beginAnimation(19)
							f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
						end
						f66_arg0:beginAnimation(9)
						f66_arg0:setAlpha(0.45)
						f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
					end
					f65_arg0:beginAnimation(160)
					f65_arg0:setAlpha(0.95)
					f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
				end
				f63_arg0.DoubleXPText:beginAnimation(200)
				f63_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f64_local0)
			end
			f63_arg0.DoubleXPText:completeAnimation()
			f63_arg0.DoubleXPText.MatchText:completeAnimation()
			f63_arg0.DoubleXPText:setAlpha(0)
			f63_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_double"))
			f63_local0(f63_arg0.DoubleXPText)
			local f63_local1 = function(f81_arg0)
				local f81_local0 = function(f82_arg0)
					local f82_local0 = function(f83_arg0)
						local f83_local0 = function(f84_arg0)
							local f84_local0 = function(f85_arg0)
								local f85_local0 = function(f86_arg0)
									local f86_local0 = function(f87_arg0)
										local f87_local0 = function(f88_arg0)
											local f88_local0 = function(f89_arg0)
												f89_arg0:beginAnimation(69, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
												f89_arg0:setAlpha(0)
												f89_arg0:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
											end
											f88_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
											f88_arg0:setAlpha(1)
											f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
										end
										f87_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
										f87_arg0:setAlpha(0.2)
										f87_arg0:registerEventHandler("transition_complete_keyframe", f87_local0)
									end
									f86_arg0:beginAnimation(1160)
									f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
								end
								f85_arg0:beginAnimation(139, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
								f85_arg0:setAlpha(1)
								f85_arg0:registerEventHandler("transition_complete_keyframe", f85_local0)
							end
							f84_arg0:beginAnimation(110, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
							f84_arg0:setAlpha(0.2)
							f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
						end
						f83_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
						f83_arg0:setAlpha(1)
						f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
					end
					f82_arg0:beginAnimation(89)
					f82_arg0:setAlpha(0.2)
					f82_arg0:registerEventHandler("transition_complete_keyframe", f82_local0)
				end
				f63_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f63_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f63_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f81_local0)
			end
			f63_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f63_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f63_local1(f63_arg0.PrematchCountdown2xpBadge)
			local f63_local2 = function(f90_arg0)
				local f90_local0 = function(f91_arg0)
					local f91_local0 = function(f92_arg0)
						local f92_local0 = function(f93_arg0)
							local f93_local0 = function(f94_arg0)
								local f94_local0 = function(f95_arg0)
									local f95_local0 = function(f96_arg0)
										local f96_local0 = function(f97_arg0)
											local f97_local0 = function(f98_arg0)
												f98_arg0:beginAnimation(69)
												f98_arg0:setAlpha(0)
												f98_arg0:registerEventHandler("transition_complete_keyframe", f63_arg0.clipFinished)
											end
											f97_arg0:beginAnimation(90)
											f97_arg0:setAlpha(1)
											f97_arg0:registerEventHandler("transition_complete_keyframe", f97_local0)
										end
										f96_arg0:beginAnimation(90)
										f96_arg0:setAlpha(0.2)
										f96_arg0:registerEventHandler("transition_complete_keyframe", f96_local0)
									end
									f95_arg0:beginAnimation(1160)
									f95_arg0:registerEventHandler("transition_complete_keyframe", f95_local0)
								end
								f94_arg0:beginAnimation(139)
								f94_arg0:setAlpha(1)
								f94_arg0:registerEventHandler("transition_complete_keyframe", f94_local0)
							end
							f93_arg0:beginAnimation(110)
							f93_arg0:setAlpha(0.2)
							f93_arg0:registerEventHandler("transition_complete_keyframe", f93_local0)
						end
						f92_arg0:beginAnimation(100)
						f92_arg0:setAlpha(1)
						f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
					end
					f91_arg0:beginAnimation(89)
					f91_arg0:setAlpha(0.2)
					f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
				end
				f63_arg0.PrematchCountdown2xpWeaponBadge:beginAnimation(40)
				f63_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
				f63_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("interrupted_keyframe", f63_arg0.clipInterrupted)
				f63_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("transition_complete_keyframe", f90_local0)
			end
			f63_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f63_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f63_local2(f63_arg0.PrematchCountdown2xpWeaponBadge)
		end,
	},
	XpAndTier = {
		DefaultClip = function(f99_arg0, f99_arg1)
			f99_arg0:__resetProperties()
			f99_arg0:setupElementClipCounter(4)
			f99_arg0.DoubleXPText:completeAnimation()
			f99_arg0.DoubleXPText.MatchText:completeAnimation()
			f99_arg0.DoubleXPText:setAlpha(0)
			f99_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_double"))
			f99_arg0.clipFinished(f99_arg0.DoubleXPText)
			f99_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f99_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.PrematchCountdown2xpBadge)
			f99_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f99_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.PrematchCountdown2xpWeaponBadge)
			f99_arg0.TierBoost:completeAnimation()
			f99_arg0.TierBoost:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.TierBoost)
		end,
		Notify = function(f100_arg0, f100_arg1)
			f100_arg0:__resetProperties()
			f100_arg0:setupElementClipCounter(4)
			local f100_local0 = function(f101_arg0)
				local f101_local0 = function(f102_arg0)
					local f102_local0 = function(f103_arg0)
						local f103_local0 = function(f104_arg0)
							local f104_local0 = function(f105_arg0)
								local f105_local0 = function(f106_arg0)
									local f106_local0 = function(f107_arg0)
										local f107_local0 = function(f108_arg0)
											local f108_local0 = function(f109_arg0)
												local f109_local0 = function(f110_arg0)
													local f110_local0 = function(f111_arg0)
														local f111_local0 = function(f112_arg0)
															local f112_local0 = function(f113_arg0)
																local f113_local0 = function(f114_arg0)
																	local f114_local0 = function(f115_arg0)
																		local f115_local0 = function(f116_arg0)
																			local f116_local0 = function(f117_arg0)
																				f117_arg0:beginAnimation(189)
																				f117_arg0:setAlpha(0)
																				f117_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
																			end
																			f116_arg0:beginAnimation(19)
																			f116_arg0:setAlpha(0.45)
																			f116_arg0:registerEventHandler("transition_complete_keyframe", f116_local0)
																		end
																		f115_arg0:beginAnimation(19)
																		f115_arg0:setAlpha(0.34)
																		f115_arg0:registerEventHandler("transition_complete_keyframe", f115_local0)
																	end
																	f114_arg0:beginAnimation(70)
																	f114_arg0:setAlpha(0.55)
																	f114_arg0:registerEventHandler("transition_complete_keyframe", f114_local0)
																end
																f113_arg0:beginAnimation(19)
																f113_arg0:setAlpha(0.71)
																f113_arg0:registerEventHandler("transition_complete_keyframe", f113_local0)
															end
															f112_arg0:beginAnimation(29)
															f112_arg0:setAlpha(0.44)
															f112_arg0:registerEventHandler("transition_complete_keyframe", f112_local0)
														end
														f111_arg0:beginAnimation(70)
														f111_arg0:setAlpha(0.83)
														f111_arg0:registerEventHandler("transition_complete_keyframe", f111_local0)
													end
													f110_arg0:beginAnimation(1150)
													f110_arg0:registerEventHandler("transition_complete_keyframe", f110_local0)
												end
												f109_arg0:beginAnimation(9)
												f109_arg0:setAlpha(1)
												f109_arg0:registerEventHandler("transition_complete_keyframe", f109_local0)
											end
											f108_arg0:beginAnimation(20)
											f108_arg0:registerEventHandler("transition_complete_keyframe", f108_local0)
										end
										f107_arg0:beginAnimation(9)
										f107_arg0:setAlpha(0.76)
										f107_arg0:registerEventHandler("transition_complete_keyframe", f107_local0)
									end
									f106_arg0:beginAnimation(39)
									f106_arg0:registerEventHandler("transition_complete_keyframe", f106_local0)
								end
								f105_arg0:beginAnimation(10)
								f105_arg0:setAlpha(1)
								f105_arg0:registerEventHandler("transition_complete_keyframe", f105_local0)
							end
							f104_arg0:beginAnimation(19)
							f104_arg0:registerEventHandler("transition_complete_keyframe", f104_local0)
						end
						f103_arg0:beginAnimation(9)
						f103_arg0:setAlpha(0.45)
						f103_arg0:registerEventHandler("transition_complete_keyframe", f103_local0)
					end
					f102_arg0:beginAnimation(160)
					f102_arg0:setAlpha(0.95)
					f102_arg0:registerEventHandler("transition_complete_keyframe", f102_local0)
				end
				f100_arg0.DoubleXPText:beginAnimation(200)
				f100_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f101_local0)
			end
			f100_arg0.DoubleXPText:completeAnimation()
			f100_arg0.DoubleXPText.MatchText:completeAnimation()
			f100_arg0.DoubleXPText:setAlpha(0)
			f100_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_double"))
			f100_local0(f100_arg0.DoubleXPText)
			local f100_local1 = function(f118_arg0)
				local f118_local0 = function(f119_arg0)
					local f119_local0 = function(f120_arg0)
						local f120_local0 = function(f121_arg0)
							local f121_local0 = function(f122_arg0)
								local f122_local0 = function(f123_arg0)
									local f123_local0 = function(f124_arg0)
										local f124_local0 = function(f125_arg0)
											local f125_local0 = function(f126_arg0)
												f126_arg0:beginAnimation(69)
												f126_arg0:setAlpha(0)
												f126_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
											end
											f125_arg0:beginAnimation(90)
											f125_arg0:setAlpha(1)
											f125_arg0:registerEventHandler("transition_complete_keyframe", f125_local0)
										end
										f124_arg0:beginAnimation(90)
										f124_arg0:setAlpha(0.2)
										f124_arg0:registerEventHandler("transition_complete_keyframe", f124_local0)
									end
									f123_arg0:beginAnimation(1160)
									f123_arg0:registerEventHandler("transition_complete_keyframe", f123_local0)
								end
								f122_arg0:beginAnimation(139)
								f122_arg0:setAlpha(1)
								f122_arg0:registerEventHandler("transition_complete_keyframe", f122_local0)
							end
							f121_arg0:beginAnimation(110)
							f121_arg0:setAlpha(0.2)
							f121_arg0:registerEventHandler("transition_complete_keyframe", f121_local0)
						end
						f120_arg0:beginAnimation(100)
						f120_arg0:setAlpha(1)
						f120_arg0:registerEventHandler("transition_complete_keyframe", f120_local0)
					end
					f119_arg0:beginAnimation(89)
					f119_arg0:setAlpha(0.2)
					f119_arg0:registerEventHandler("transition_complete_keyframe", f119_local0)
				end
				f100_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f100_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f100_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f118_local0)
			end
			f100_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f100_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, 0, 192)
			f100_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f100_local1(f100_arg0.PrematchCountdown2xpBadge)
			f100_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f100_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 96, 288)
			f100_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.PrematchCountdown2xpWeaponBadge)
			local f100_local2 = function(f127_arg0)
				local f127_local0 = function(f128_arg0)
					local f128_local0 = function(f129_arg0)
						local f129_local0 = function(f130_arg0)
							local f130_local0 = function(f131_arg0)
								local f131_local0 = function(f132_arg0)
									local f132_local0 = function(f133_arg0)
										local f133_local0 = function(f134_arg0)
											local f134_local0 = function(f135_arg0)
												f135_arg0:beginAnimation(69)
												f135_arg0:setAlpha(0)
												f135_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
											end
											f134_arg0:beginAnimation(90)
											f134_arg0:setAlpha(1)
											f134_arg0:registerEventHandler("transition_complete_keyframe", f134_local0)
										end
										f133_arg0:beginAnimation(90)
										f133_arg0:setAlpha(0.2)
										f133_arg0:registerEventHandler("transition_complete_keyframe", f133_local0)
									end
									f132_arg0:beginAnimation(1160)
									f132_arg0:registerEventHandler("transition_complete_keyframe", f132_local0)
								end
								f131_arg0:beginAnimation(139)
								f131_arg0:setAlpha(1)
								f131_arg0:registerEventHandler("transition_complete_keyframe", f131_local0)
							end
							f130_arg0:beginAnimation(110)
							f130_arg0:setAlpha(0.2)
							f130_arg0:registerEventHandler("transition_complete_keyframe", f130_local0)
						end
						f129_arg0:beginAnimation(100)
						f129_arg0:setAlpha(1)
						f129_arg0:registerEventHandler("transition_complete_keyframe", f129_local0)
					end
					f128_arg0:beginAnimation(89)
					f128_arg0:setAlpha(0.2)
					f128_arg0:registerEventHandler("transition_complete_keyframe", f128_local0)
				end
				f100_arg0.TierBoost:beginAnimation(40)
				f100_arg0.TierBoost:setAlpha(1)
				f100_arg0.TierBoost:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.TierBoost:registerEventHandler("transition_complete_keyframe", f127_local0)
			end
			f100_arg0.TierBoost:completeAnimation()
			f100_arg0.TierBoost:setLeftRight(0, 0, 8, 200)
			f100_arg0.TierBoost:setAlpha(0)
			f100_local2(f100_arg0.TierBoost)
		end,
	},
	WeaponAndTier = {
		DefaultClip = function(f136_arg0, f136_arg1)
			f136_arg0:__resetProperties()
			f136_arg0:setupElementClipCounter(4)
			f136_arg0.DoubleXPText:completeAnimation()
			f136_arg0.DoubleXPText.MatchText:completeAnimation()
			f136_arg0.DoubleXPText:setAlpha(0)
			f136_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_double"))
			f136_arg0.clipFinished(f136_arg0.DoubleXPText)
			f136_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f136_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f136_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f136_arg0.clipFinished(f136_arg0.PrematchCountdown2xpBadge)
			f136_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f136_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 96, 288)
			f136_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f136_arg0.clipFinished(f136_arg0.PrematchCountdown2xpWeaponBadge)
			f136_arg0.TierBoost:completeAnimation()
			f136_arg0.TierBoost:setLeftRight(0, 0, -88, 104)
			f136_arg0.TierBoost:setAlpha(0)
			f136_arg0.clipFinished(f136_arg0.TierBoost)
		end,
		Notify = function(f137_arg0, f137_arg1)
			f137_arg0:__resetProperties()
			f137_arg0:setupElementClipCounter(4)
			local f137_local0 = function(f138_arg0)
				local f138_local0 = function(f139_arg0)
					local f139_local0 = function(f140_arg0)
						local f140_local0 = function(f141_arg0)
							local f141_local0 = function(f142_arg0)
								local f142_local0 = function(f143_arg0)
									local f143_local0 = function(f144_arg0)
										local f144_local0 = function(f145_arg0)
											local f145_local0 = function(f146_arg0)
												local f146_local0 = function(f147_arg0)
													local f147_local0 = function(f148_arg0)
														local f148_local0 = function(f149_arg0)
															local f149_local0 = function(f150_arg0)
																local f150_local0 = function(f151_arg0)
																	local f151_local0 = function(f152_arg0)
																		local f152_local0 = function(f153_arg0)
																			local f153_local0 = function(f154_arg0)
																				f154_arg0:beginAnimation(189)
																				f154_arg0:setAlpha(0)
																				f154_arg0:registerEventHandler("transition_complete_keyframe", f137_arg0.clipFinished)
																			end
																			f153_arg0:beginAnimation(19)
																			f153_arg0:setAlpha(0.45)
																			f153_arg0:registerEventHandler("transition_complete_keyframe", f153_local0)
																		end
																		f152_arg0:beginAnimation(19)
																		f152_arg0:setAlpha(0.34)
																		f152_arg0:registerEventHandler("transition_complete_keyframe", f152_local0)
																	end
																	f151_arg0:beginAnimation(70)
																	f151_arg0:setAlpha(0.55)
																	f151_arg0:registerEventHandler("transition_complete_keyframe", f151_local0)
																end
																f150_arg0:beginAnimation(19)
																f150_arg0:setAlpha(0.71)
																f150_arg0:registerEventHandler("transition_complete_keyframe", f150_local0)
															end
															f149_arg0:beginAnimation(29)
															f149_arg0:setAlpha(0.44)
															f149_arg0:registerEventHandler("transition_complete_keyframe", f149_local0)
														end
														f148_arg0:beginAnimation(70)
														f148_arg0:setAlpha(0.83)
														f148_arg0:registerEventHandler("transition_complete_keyframe", f148_local0)
													end
													f147_arg0:beginAnimation(1150)
													f147_arg0:registerEventHandler("transition_complete_keyframe", f147_local0)
												end
												f146_arg0:beginAnimation(9)
												f146_arg0:setAlpha(1)
												f146_arg0:registerEventHandler("transition_complete_keyframe", f146_local0)
											end
											f145_arg0:beginAnimation(20)
											f145_arg0:registerEventHandler("transition_complete_keyframe", f145_local0)
										end
										f144_arg0:beginAnimation(9)
										f144_arg0:setAlpha(0.76)
										f144_arg0:registerEventHandler("transition_complete_keyframe", f144_local0)
									end
									f143_arg0:beginAnimation(39)
									f143_arg0:registerEventHandler("transition_complete_keyframe", f143_local0)
								end
								f142_arg0:beginAnimation(10)
								f142_arg0:setAlpha(1)
								f142_arg0:registerEventHandler("transition_complete_keyframe", f142_local0)
							end
							f141_arg0:beginAnimation(19)
							f141_arg0:registerEventHandler("transition_complete_keyframe", f141_local0)
						end
						f140_arg0:beginAnimation(9)
						f140_arg0:setAlpha(0.45)
						f140_arg0:registerEventHandler("transition_complete_keyframe", f140_local0)
					end
					f139_arg0:beginAnimation(160)
					f139_arg0:setAlpha(0.95)
					f139_arg0:registerEventHandler("transition_complete_keyframe", f139_local0)
				end
				f137_arg0.DoubleXPText:beginAnimation(200)
				f137_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f137_arg0.clipInterrupted)
				f137_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f138_local0)
			end
			f137_arg0.DoubleXPText:completeAnimation()
			f137_arg0.DoubleXPText.MatchText:completeAnimation()
			f137_arg0.DoubleXPText:setAlpha(0)
			f137_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_double"))
			f137_local0(f137_arg0.DoubleXPText)
			f137_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f137_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f137_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f137_arg0.clipFinished(f137_arg0.PrematchCountdown2xpBadge)
			local f137_local1 = function(f155_arg0)
				local f155_local0 = function(f156_arg0)
					local f156_local0 = function(f157_arg0)
						local f157_local0 = function(f158_arg0)
							local f158_local0 = function(f159_arg0)
								local f159_local0 = function(f160_arg0)
									local f160_local0 = function(f161_arg0)
										local f161_local0 = function(f162_arg0)
											local f162_local0 = function(f163_arg0)
												f163_arg0:beginAnimation(69)
												f163_arg0:setAlpha(0)
												f163_arg0:registerEventHandler("transition_complete_keyframe", f137_arg0.clipFinished)
											end
											f162_arg0:beginAnimation(90)
											f162_arg0:setAlpha(1)
											f162_arg0:registerEventHandler("transition_complete_keyframe", f162_local0)
										end
										f161_arg0:beginAnimation(90)
										f161_arg0:setAlpha(0.2)
										f161_arg0:registerEventHandler("transition_complete_keyframe", f161_local0)
									end
									f160_arg0:beginAnimation(1160)
									f160_arg0:registerEventHandler("transition_complete_keyframe", f160_local0)
								end
								f159_arg0:beginAnimation(139)
								f159_arg0:setAlpha(1)
								f159_arg0:registerEventHandler("transition_complete_keyframe", f159_local0)
							end
							f158_arg0:beginAnimation(110)
							f158_arg0:setAlpha(0.2)
							f158_arg0:registerEventHandler("transition_complete_keyframe", f158_local0)
						end
						f157_arg0:beginAnimation(100)
						f157_arg0:setAlpha(1)
						f157_arg0:registerEventHandler("transition_complete_keyframe", f157_local0)
					end
					f156_arg0:beginAnimation(89)
					f156_arg0:setAlpha(0.2)
					f156_arg0:registerEventHandler("transition_complete_keyframe", f156_local0)
				end
				f137_arg0.PrematchCountdown2xpWeaponBadge:beginAnimation(40)
				f137_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
				f137_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("interrupted_keyframe", f137_arg0.clipInterrupted)
				f137_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("transition_complete_keyframe", f155_local0)
			end
			f137_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f137_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 0, 192)
			f137_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f137_local1(f137_arg0.PrematchCountdown2xpWeaponBadge)
			local f137_local2 = function(f164_arg0)
				local f164_local0 = function(f165_arg0)
					local f165_local0 = function(f166_arg0)
						local f166_local0 = function(f167_arg0)
							local f167_local0 = function(f168_arg0)
								local f168_local0 = function(f169_arg0)
									local f169_local0 = function(f170_arg0)
										local f170_local0 = function(f171_arg0)
											local f171_local0 = function(f172_arg0)
												f172_arg0:beginAnimation(69)
												f172_arg0:setAlpha(0)
												f172_arg0:registerEventHandler("transition_complete_keyframe", f137_arg0.clipFinished)
											end
											f171_arg0:beginAnimation(90)
											f171_arg0:setAlpha(1)
											f171_arg0:registerEventHandler("transition_complete_keyframe", f171_local0)
										end
										f170_arg0:beginAnimation(90)
										f170_arg0:setAlpha(0.2)
										f170_arg0:registerEventHandler("transition_complete_keyframe", f170_local0)
									end
									f169_arg0:beginAnimation(1160)
									f169_arg0:registerEventHandler("transition_complete_keyframe", f169_local0)
								end
								f168_arg0:beginAnimation(139)
								f168_arg0:setAlpha(1)
								f168_arg0:registerEventHandler("transition_complete_keyframe", f168_local0)
							end
							f167_arg0:beginAnimation(110)
							f167_arg0:setAlpha(0.2)
							f167_arg0:registerEventHandler("transition_complete_keyframe", f167_local0)
						end
						f166_arg0:beginAnimation(100)
						f166_arg0:setAlpha(1)
						f166_arg0:registerEventHandler("transition_complete_keyframe", f166_local0)
					end
					f165_arg0:beginAnimation(89)
					f165_arg0:setAlpha(0.2)
					f165_arg0:registerEventHandler("transition_complete_keyframe", f165_local0)
				end
				f137_arg0.TierBoost:beginAnimation(40)
				f137_arg0.TierBoost:setAlpha(1)
				f137_arg0.TierBoost:registerEventHandler("interrupted_keyframe", f137_arg0.clipInterrupted)
				f137_arg0.TierBoost:registerEventHandler("transition_complete_keyframe", f164_local0)
			end
			f137_arg0.TierBoost:completeAnimation()
			f137_arg0.TierBoost:setLeftRight(0, 0, 8, 200)
			f137_arg0.TierBoost:setAlpha(0)
			f137_local2(f137_arg0.TierBoost)
		end,
	},
	DoubleXP = {
		DefaultClip = function(f173_arg0, f173_arg1)
			f173_arg0:__resetProperties()
			f173_arg0:setupElementClipCounter(3)
			f173_arg0.DoubleXPText:completeAnimation()
			f173_arg0.DoubleXPText.MatchText:completeAnimation()
			f173_arg0.DoubleXPText:setAlpha(0)
			f173_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_xp"))
			f173_arg0.clipFinished(f173_arg0.DoubleXPText)
			f173_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f173_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f173_arg0.clipFinished(f173_arg0.PrematchCountdown2xpBadge)
			f173_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f173_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f173_arg0.clipFinished(f173_arg0.PrematchCountdown2xpWeaponBadge)
		end,
		Notify = function(f174_arg0, f174_arg1)
			f174_arg0:__resetProperties()
			f174_arg0:setupElementClipCounter(3)
			local f174_local0 = function(f175_arg0)
				local f175_local0 = function(f176_arg0)
					local f176_local0 = function(f177_arg0)
						local f177_local0 = function(f178_arg0)
							local f178_local0 = function(f179_arg0)
								local f179_local0 = function(f180_arg0)
									local f180_local0 = function(f181_arg0)
										local f181_local0 = function(f182_arg0)
											local f182_local0 = function(f183_arg0)
												local f183_local0 = function(f184_arg0)
													local f184_local0 = function(f185_arg0)
														local f185_local0 = function(f186_arg0)
															local f186_local0 = function(f187_arg0)
																local f187_local0 = function(f188_arg0)
																	local f188_local0 = function(f189_arg0)
																		local f189_local0 = function(f190_arg0)
																			local f190_local0 = function(f191_arg0)
																				f191_arg0:beginAnimation(189)
																				f191_arg0:setAlpha(0)
																				f191_arg0:registerEventHandler("transition_complete_keyframe", f174_arg0.clipFinished)
																			end
																			f190_arg0:beginAnimation(19)
																			f190_arg0:setAlpha(0.45)
																			f190_arg0:registerEventHandler("transition_complete_keyframe", f190_local0)
																		end
																		f189_arg0:beginAnimation(19)
																		f189_arg0:setAlpha(0.34)
																		f189_arg0:registerEventHandler("transition_complete_keyframe", f189_local0)
																	end
																	f188_arg0:beginAnimation(70)
																	f188_arg0:setAlpha(0.55)
																	f188_arg0:registerEventHandler("transition_complete_keyframe", f188_local0)
																end
																f187_arg0:beginAnimation(19)
																f187_arg0:setAlpha(0.71)
																f187_arg0:registerEventHandler("transition_complete_keyframe", f187_local0)
															end
															f186_arg0:beginAnimation(29)
															f186_arg0:setAlpha(0.44)
															f186_arg0:registerEventHandler("transition_complete_keyframe", f186_local0)
														end
														f185_arg0:beginAnimation(70)
														f185_arg0:setAlpha(0.83)
														f185_arg0:registerEventHandler("transition_complete_keyframe", f185_local0)
													end
													f184_arg0:beginAnimation(1150)
													f184_arg0:registerEventHandler("transition_complete_keyframe", f184_local0)
												end
												f183_arg0:beginAnimation(9)
												f183_arg0:setAlpha(1)
												f183_arg0:registerEventHandler("transition_complete_keyframe", f183_local0)
											end
											f182_arg0:beginAnimation(20)
											f182_arg0:registerEventHandler("transition_complete_keyframe", f182_local0)
										end
										f181_arg0:beginAnimation(9)
										f181_arg0:setAlpha(0.76)
										f181_arg0:registerEventHandler("transition_complete_keyframe", f181_local0)
									end
									f180_arg0:beginAnimation(39)
									f180_arg0:registerEventHandler("transition_complete_keyframe", f180_local0)
								end
								f179_arg0:beginAnimation(10)
								f179_arg0:setAlpha(1)
								f179_arg0:registerEventHandler("transition_complete_keyframe", f179_local0)
							end
							f178_arg0:beginAnimation(19)
							f178_arg0:registerEventHandler("transition_complete_keyframe", f178_local0)
						end
						f177_arg0:beginAnimation(9)
						f177_arg0:setAlpha(0.45)
						f177_arg0:registerEventHandler("transition_complete_keyframe", f177_local0)
					end
					f176_arg0:beginAnimation(160)
					f176_arg0:setAlpha(0.95)
					f176_arg0:registerEventHandler("transition_complete_keyframe", f176_local0)
				end
				f174_arg0.DoubleXPText:beginAnimation(200)
				f174_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f174_arg0.clipInterrupted)
				f174_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f175_local0)
			end
			f174_arg0.DoubleXPText:completeAnimation()
			f174_arg0.DoubleXPText.MatchText:completeAnimation()
			f174_arg0.DoubleXPText:setAlpha(0)
			f174_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_xp"))
			f174_local0(f174_arg0.DoubleXPText)
			local f174_local1 = function(f192_arg0)
				local f192_local0 = function(f193_arg0)
					local f193_local0 = function(f194_arg0)
						local f194_local0 = function(f195_arg0)
							local f195_local0 = function(f196_arg0)
								local f196_local0 = function(f197_arg0)
									local f197_local0 = function(f198_arg0)
										local f198_local0 = function(f199_arg0)
											local f199_local0 = function(f200_arg0)
												f200_arg0:beginAnimation(69, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
												f200_arg0:setAlpha(0)
												f200_arg0:registerEventHandler("transition_complete_keyframe", f174_arg0.clipFinished)
											end
											f199_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
											f199_arg0:setAlpha(1)
											f199_arg0:registerEventHandler("transition_complete_keyframe", f199_local0)
										end
										f198_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
										f198_arg0:setAlpha(0.2)
										f198_arg0:registerEventHandler("transition_complete_keyframe", f198_local0)
									end
									f197_arg0:beginAnimation(1160)
									f197_arg0:registerEventHandler("transition_complete_keyframe", f197_local0)
								end
								f196_arg0:beginAnimation(139, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
								f196_arg0:setAlpha(1)
								f196_arg0:registerEventHandler("transition_complete_keyframe", f196_local0)
							end
							f195_arg0:beginAnimation(110, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
							f195_arg0:setAlpha(0.2)
							f195_arg0:registerEventHandler("transition_complete_keyframe", f195_local0)
						end
						f194_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
						f194_arg0:setAlpha(1)
						f194_arg0:registerEventHandler("transition_complete_keyframe", f194_local0)
					end
					f193_arg0:beginAnimation(89)
					f193_arg0:setAlpha(0.2)
					f193_arg0:registerEventHandler("transition_complete_keyframe", f193_local0)
				end
				f174_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f174_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f174_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f174_arg0.clipInterrupted)
				f174_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f192_local0)
			end
			f174_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f174_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f174_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f174_local1(f174_arg0.PrematchCountdown2xpBadge)
			f174_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f174_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f174_arg0.clipFinished(f174_arg0.PrematchCountdown2xpWeaponBadge)
		end,
	},
	WZDoubleXP = {
		DefaultClip = function(f201_arg0, f201_arg1)
			f201_arg0:__resetProperties()
			f201_arg0:setupElementClipCounter(3)
			f201_arg0.DoubleXPText:completeAnimation()
			f201_arg0.DoubleXPText.MatchText:completeAnimation()
			f201_arg0.DoubleXPText:setAlpha(0)
			f201_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_FF550687ED9925D"))
			f201_arg0.clipFinished(f201_arg0.DoubleXPText)
			f201_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f201_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f201_arg0.clipFinished(f201_arg0.PrematchCountdown2xpBadge)
			f201_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f201_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f201_arg0.clipFinished(f201_arg0.PrematchCountdown2xpWeaponBadge)
		end,
		Notify = function(f202_arg0, f202_arg1)
			f202_arg0:__resetProperties()
			f202_arg0:setupElementClipCounter(3)
			local f202_local0 = function(f203_arg0)
				local f203_local0 = function(f204_arg0)
					local f204_local0 = function(f205_arg0)
						local f205_local0 = function(f206_arg0)
							local f206_local0 = function(f207_arg0)
								local f207_local0 = function(f208_arg0)
									local f208_local0 = function(f209_arg0)
										local f209_local0 = function(f210_arg0)
											local f210_local0 = function(f211_arg0)
												local f211_local0 = function(f212_arg0)
													local f212_local0 = function(f213_arg0)
														local f213_local0 = function(f214_arg0)
															local f214_local0 = function(f215_arg0)
																local f215_local0 = function(f216_arg0)
																	local f216_local0 = function(f217_arg0)
																		local f217_local0 = function(f218_arg0)
																			local f218_local0 = function(f219_arg0)
																				f219_arg0:beginAnimation(189)
																				f219_arg0:setAlpha(0)
																				f219_arg0:registerEventHandler("transition_complete_keyframe", f202_arg0.clipFinished)
																			end
																			f218_arg0:beginAnimation(19)
																			f218_arg0:setAlpha(0.45)
																			f218_arg0:registerEventHandler("transition_complete_keyframe", f218_local0)
																		end
																		f217_arg0:beginAnimation(19)
																		f217_arg0:setAlpha(0.34)
																		f217_arg0:registerEventHandler("transition_complete_keyframe", f217_local0)
																	end
																	f216_arg0:beginAnimation(70)
																	f216_arg0:setAlpha(0.55)
																	f216_arg0:registerEventHandler("transition_complete_keyframe", f216_local0)
																end
																f215_arg0:beginAnimation(19)
																f215_arg0:setAlpha(0.71)
																f215_arg0:registerEventHandler("transition_complete_keyframe", f215_local0)
															end
															f214_arg0:beginAnimation(29)
															f214_arg0:setAlpha(0.44)
															f214_arg0:registerEventHandler("transition_complete_keyframe", f214_local0)
														end
														f213_arg0:beginAnimation(70)
														f213_arg0:setAlpha(0.83)
														f213_arg0:registerEventHandler("transition_complete_keyframe", f213_local0)
													end
													f212_arg0:beginAnimation(1150)
													f212_arg0:registerEventHandler("transition_complete_keyframe", f212_local0)
												end
												f211_arg0:beginAnimation(9)
												f211_arg0:setAlpha(1)
												f211_arg0:registerEventHandler("transition_complete_keyframe", f211_local0)
											end
											f210_arg0:beginAnimation(20)
											f210_arg0:registerEventHandler("transition_complete_keyframe", f210_local0)
										end
										f209_arg0:beginAnimation(9)
										f209_arg0:setAlpha(0.76)
										f209_arg0:registerEventHandler("transition_complete_keyframe", f209_local0)
									end
									f208_arg0:beginAnimation(39)
									f208_arg0:registerEventHandler("transition_complete_keyframe", f208_local0)
								end
								f207_arg0:beginAnimation(10)
								f207_arg0:setAlpha(1)
								f207_arg0:registerEventHandler("transition_complete_keyframe", f207_local0)
							end
							f206_arg0:beginAnimation(19)
							f206_arg0:registerEventHandler("transition_complete_keyframe", f206_local0)
						end
						f205_arg0:beginAnimation(9)
						f205_arg0:setAlpha(0.45)
						f205_arg0:registerEventHandler("transition_complete_keyframe", f205_local0)
					end
					f204_arg0:beginAnimation(160)
					f204_arg0:setAlpha(0.95)
					f204_arg0:registerEventHandler("transition_complete_keyframe", f204_local0)
				end
				f202_arg0.DoubleXPText:beginAnimation(200)
				f202_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
				f202_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f203_local0)
			end
			f202_arg0.DoubleXPText:completeAnimation()
			f202_arg0.DoubleXPText.MatchText:completeAnimation()
			f202_arg0.DoubleXPText:setAlpha(0)
			f202_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_FF550687ED9925D"))
			f202_local0(f202_arg0.DoubleXPText)
			local f202_local1 = function(f220_arg0)
				local f220_local0 = function(f221_arg0)
					local f221_local0 = function(f222_arg0)
						local f222_local0 = function(f223_arg0)
							local f223_local0 = function(f224_arg0)
								local f224_local0 = function(f225_arg0)
									local f225_local0 = function(f226_arg0)
										local f226_local0 = function(f227_arg0)
											local f227_local0 = function(f228_arg0)
												f228_arg0:beginAnimation(69, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
												f228_arg0:setAlpha(0)
												f228_arg0:registerEventHandler("transition_complete_keyframe", f202_arg0.clipFinished)
											end
											f227_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
											f227_arg0:setAlpha(1)
											f227_arg0:registerEventHandler("transition_complete_keyframe", f227_local0)
										end
										f226_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
										f226_arg0:setAlpha(0.2)
										f226_arg0:registerEventHandler("transition_complete_keyframe", f226_local0)
									end
									f225_arg0:beginAnimation(1160)
									f225_arg0:registerEventHandler("transition_complete_keyframe", f225_local0)
								end
								f224_arg0:beginAnimation(139, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
								f224_arg0:setAlpha(1)
								f224_arg0:registerEventHandler("transition_complete_keyframe", f224_local0)
							end
							f223_arg0:beginAnimation(110, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
							f223_arg0:setAlpha(0.2)
							f223_arg0:registerEventHandler("transition_complete_keyframe", f223_local0)
						end
						f222_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
						f222_arg0:setAlpha(1)
						f222_arg0:registerEventHandler("transition_complete_keyframe", f222_local0)
					end
					f221_arg0:beginAnimation(89)
					f221_arg0:setAlpha(0.2)
					f221_arg0:registerEventHandler("transition_complete_keyframe", f221_local0)
				end
				f202_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f202_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f202_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f202_arg0.clipInterrupted)
				f202_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f220_local0)
			end
			f202_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f202_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f202_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f202_local1(f202_arg0.PrematchCountdown2xpBadge)
			f202_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f202_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f202_arg0.clipFinished(f202_arg0.PrematchCountdown2xpWeaponBadge)
		end,
	},
	DoubleWeaponXP = {
		DefaultClip = function(f229_arg0, f229_arg1)
			f229_arg0:__resetProperties()
			f229_arg0:setupElementClipCounter(3)
			f229_arg0.DoubleXPText:completeAnimation()
			f229_arg0.DoubleXPText.MatchText:completeAnimation()
			f229_arg0.DoubleXPText:setAlpha(0)
			f229_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_xp"))
			f229_arg0.clipFinished(f229_arg0.DoubleXPText)
			f229_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f229_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f229_arg0.clipFinished(f229_arg0.PrematchCountdown2xpBadge)
			f229_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f229_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f229_arg0.clipFinished(f229_arg0.PrematchCountdown2xpWeaponBadge)
		end,
		Notify = function(f230_arg0, f230_arg1)
			f230_arg0:__resetProperties()
			f230_arg0:setupElementClipCounter(3)
			local f230_local0 = function(f231_arg0)
				local f231_local0 = function(f232_arg0)
					local f232_local0 = function(f233_arg0)
						local f233_local0 = function(f234_arg0)
							local f234_local0 = function(f235_arg0)
								local f235_local0 = function(f236_arg0)
									local f236_local0 = function(f237_arg0)
										local f237_local0 = function(f238_arg0)
											local f238_local0 = function(f239_arg0)
												local f239_local0 = function(f240_arg0)
													local f240_local0 = function(f241_arg0)
														local f241_local0 = function(f242_arg0)
															local f242_local0 = function(f243_arg0)
																local f243_local0 = function(f244_arg0)
																	local f244_local0 = function(f245_arg0)
																		local f245_local0 = function(f246_arg0)
																			local f246_local0 = function(f247_arg0)
																				f247_arg0:beginAnimation(189)
																				f247_arg0:setAlpha(0)
																				f247_arg0:registerEventHandler("transition_complete_keyframe", f230_arg0.clipFinished)
																			end
																			f246_arg0:beginAnimation(19)
																			f246_arg0:setAlpha(0.45)
																			f246_arg0:registerEventHandler("transition_complete_keyframe", f246_local0)
																		end
																		f245_arg0:beginAnimation(19)
																		f245_arg0:setAlpha(0.34)
																		f245_arg0:registerEventHandler("transition_complete_keyframe", f245_local0)
																	end
																	f244_arg0:beginAnimation(70)
																	f244_arg0:setAlpha(0.55)
																	f244_arg0:registerEventHandler("transition_complete_keyframe", f244_local0)
																end
																f243_arg0:beginAnimation(19)
																f243_arg0:setAlpha(0.71)
																f243_arg0:registerEventHandler("transition_complete_keyframe", f243_local0)
															end
															f242_arg0:beginAnimation(29)
															f242_arg0:setAlpha(0.44)
															f242_arg0:registerEventHandler("transition_complete_keyframe", f242_local0)
														end
														f241_arg0:beginAnimation(70)
														f241_arg0:setAlpha(0.83)
														f241_arg0:registerEventHandler("transition_complete_keyframe", f241_local0)
													end
													f240_arg0:beginAnimation(1150)
													f240_arg0:registerEventHandler("transition_complete_keyframe", f240_local0)
												end
												f239_arg0:beginAnimation(9)
												f239_arg0:setAlpha(1)
												f239_arg0:registerEventHandler("transition_complete_keyframe", f239_local0)
											end
											f238_arg0:beginAnimation(20)
											f238_arg0:registerEventHandler("transition_complete_keyframe", f238_local0)
										end
										f237_arg0:beginAnimation(9)
										f237_arg0:setAlpha(0.76)
										f237_arg0:registerEventHandler("transition_complete_keyframe", f237_local0)
									end
									f236_arg0:beginAnimation(39)
									f236_arg0:registerEventHandler("transition_complete_keyframe", f236_local0)
								end
								f235_arg0:beginAnimation(10)
								f235_arg0:setAlpha(1)
								f235_arg0:registerEventHandler("transition_complete_keyframe", f235_local0)
							end
							f234_arg0:beginAnimation(19)
							f234_arg0:registerEventHandler("transition_complete_keyframe", f234_local0)
						end
						f233_arg0:beginAnimation(9)
						f233_arg0:setAlpha(0.45)
						f233_arg0:registerEventHandler("transition_complete_keyframe", f233_local0)
					end
					f232_arg0:beginAnimation(160)
					f232_arg0:setAlpha(0.95)
					f232_arg0:registerEventHandler("transition_complete_keyframe", f232_local0)
				end
				f230_arg0.DoubleXPText:beginAnimation(200)
				f230_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f230_arg0.clipInterrupted)
				f230_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f231_local0)
			end
			f230_arg0.DoubleXPText:completeAnimation()
			f230_arg0.DoubleXPText.MatchText:completeAnimation()
			f230_arg0.DoubleXPText:setAlpha(0)
			f230_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/double_xp"))
			f230_local0(f230_arg0.DoubleXPText)
			f230_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f230_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f230_arg0.clipFinished(f230_arg0.PrematchCountdown2xpBadge)
			local f230_local1 = function(f248_arg0)
				local f248_local0 = function(f249_arg0)
					local f249_local0 = function(f250_arg0)
						local f250_local0 = function(f251_arg0)
							local f251_local0 = function(f252_arg0)
								local f252_local0 = function(f253_arg0)
									local f253_local0 = function(f254_arg0)
										local f254_local0 = function(f255_arg0)
											local f255_local0 = function(f256_arg0)
												f256_arg0:beginAnimation(69, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
												f256_arg0:setAlpha(0)
												f256_arg0:registerEventHandler("transition_complete_keyframe", f230_arg0.clipFinished)
											end
											f255_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
											f255_arg0:setAlpha(1)
											f255_arg0:registerEventHandler("transition_complete_keyframe", f255_local0)
										end
										f254_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
										f254_arg0:setAlpha(0.2)
										f254_arg0:registerEventHandler("transition_complete_keyframe", f254_local0)
									end
									f253_arg0:beginAnimation(1160)
									f253_arg0:registerEventHandler("transition_complete_keyframe", f253_local0)
								end
								f252_arg0:beginAnimation(139, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
								f252_arg0:setAlpha(1)
								f252_arg0:registerEventHandler("transition_complete_keyframe", f252_local0)
							end
							f251_arg0:beginAnimation(110, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
							f251_arg0:setAlpha(0.2)
							f251_arg0:registerEventHandler("transition_complete_keyframe", f251_local0)
						end
						f250_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
						f250_arg0:setAlpha(1)
						f250_arg0:registerEventHandler("transition_complete_keyframe", f250_local0)
					end
					f249_arg0:beginAnimation(89)
					f249_arg0:setAlpha(0.2)
					f249_arg0:registerEventHandler("transition_complete_keyframe", f249_local0)
				end
				f230_arg0.PrematchCountdown2xpWeaponBadge:beginAnimation(40)
				f230_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
				f230_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("interrupted_keyframe", f230_arg0.clipInterrupted)
				f230_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("transition_complete_keyframe", f248_local0)
			end
			f230_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f230_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, -96, 96)
			f230_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f230_local1(f230_arg0.PrematchCountdown2xpWeaponBadge)
		end,
	},
	TierBoost = {
		DefaultClip = function(f257_arg0, f257_arg1)
			f257_arg0:__resetProperties()
			f257_arg0:setupElementClipCounter(4)
			f257_arg0.DoubleXPText:completeAnimation()
			f257_arg0.DoubleXPText.MatchText:completeAnimation()
			f257_arg0.DoubleXPText:setAlpha(0)
			f257_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/tier_boost"))
			f257_arg0.clipFinished(f257_arg0.DoubleXPText)
			f257_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f257_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f257_arg0.clipFinished(f257_arg0.PrematchCountdown2xpBadge)
			f257_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f257_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f257_arg0.clipFinished(f257_arg0.PrematchCountdown2xpWeaponBadge)
			f257_arg0.TierBoost:completeAnimation()
			f257_arg0.TierBoost:setAlpha(0)
			f257_arg0.clipFinished(f257_arg0.TierBoost)
		end,
		Notify = function(f258_arg0, f258_arg1)
			f258_arg0:__resetProperties()
			f258_arg0:setupElementClipCounter(4)
			local f258_local0 = function(f259_arg0)
				local f259_local0 = function(f260_arg0)
					local f260_local0 = function(f261_arg0)
						local f261_local0 = function(f262_arg0)
							local f262_local0 = function(f263_arg0)
								local f263_local0 = function(f264_arg0)
									local f264_local0 = function(f265_arg0)
										local f265_local0 = function(f266_arg0)
											local f266_local0 = function(f267_arg0)
												local f267_local0 = function(f268_arg0)
													local f268_local0 = function(f269_arg0)
														local f269_local0 = function(f270_arg0)
															local f270_local0 = function(f271_arg0)
																local f271_local0 = function(f272_arg0)
																	local f272_local0 = function(f273_arg0)
																		local f273_local0 = function(f274_arg0)
																			local f274_local0 = function(f275_arg0)
																				f275_arg0:beginAnimation(189)
																				f275_arg0:setAlpha(0)
																				f275_arg0:registerEventHandler("transition_complete_keyframe", f258_arg0.clipFinished)
																			end
																			f274_arg0:beginAnimation(19)
																			f274_arg0:setAlpha(0.45)
																			f274_arg0:registerEventHandler("transition_complete_keyframe", f274_local0)
																		end
																		f273_arg0:beginAnimation(19)
																		f273_arg0:setAlpha(0.34)
																		f273_arg0:registerEventHandler("transition_complete_keyframe", f273_local0)
																	end
																	f272_arg0:beginAnimation(70)
																	f272_arg0:setAlpha(0.55)
																	f272_arg0:registerEventHandler("transition_complete_keyframe", f272_local0)
																end
																f271_arg0:beginAnimation(19)
																f271_arg0:setAlpha(0.71)
																f271_arg0:registerEventHandler("transition_complete_keyframe", f271_local0)
															end
															f270_arg0:beginAnimation(29)
															f270_arg0:setAlpha(0.44)
															f270_arg0:registerEventHandler("transition_complete_keyframe", f270_local0)
														end
														f269_arg0:beginAnimation(70)
														f269_arg0:setAlpha(0.83)
														f269_arg0:registerEventHandler("transition_complete_keyframe", f269_local0)
													end
													f268_arg0:beginAnimation(1150)
													f268_arg0:registerEventHandler("transition_complete_keyframe", f268_local0)
												end
												f267_arg0:beginAnimation(9)
												f267_arg0:setAlpha(1)
												f267_arg0:registerEventHandler("transition_complete_keyframe", f267_local0)
											end
											f266_arg0:beginAnimation(20)
											f266_arg0:registerEventHandler("transition_complete_keyframe", f266_local0)
										end
										f265_arg0:beginAnimation(9)
										f265_arg0:setAlpha(0.76)
										f265_arg0:registerEventHandler("transition_complete_keyframe", f265_local0)
									end
									f264_arg0:beginAnimation(39)
									f264_arg0:registerEventHandler("transition_complete_keyframe", f264_local0)
								end
								f263_arg0:beginAnimation(10)
								f263_arg0:setAlpha(1)
								f263_arg0:registerEventHandler("transition_complete_keyframe", f263_local0)
							end
							f262_arg0:beginAnimation(19)
							f262_arg0:registerEventHandler("transition_complete_keyframe", f262_local0)
						end
						f261_arg0:beginAnimation(9)
						f261_arg0:setAlpha(0.45)
						f261_arg0:registerEventHandler("transition_complete_keyframe", f261_local0)
					end
					f260_arg0:beginAnimation(160)
					f260_arg0:setAlpha(0.95)
					f260_arg0:registerEventHandler("transition_complete_keyframe", f260_local0)
				end
				f258_arg0.DoubleXPText:beginAnimation(200)
				f258_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f258_arg0.clipInterrupted)
				f258_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f259_local0)
			end
			f258_arg0.DoubleXPText:completeAnimation()
			f258_arg0.DoubleXPText.MatchText:completeAnimation()
			f258_arg0.DoubleXPText:setAlpha(0)
			f258_arg0.DoubleXPText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/tier_boost"))
			f258_local0(f258_arg0.DoubleXPText)
			f258_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f258_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f258_arg0.clipFinished(f258_arg0.PrematchCountdown2xpBadge)
			f258_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f258_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f258_arg0.clipFinished(f258_arg0.PrematchCountdown2xpWeaponBadge)
			local f258_local1 = function(f276_arg0)
				local f276_local0 = function(f277_arg0)
					local f277_local0 = function(f278_arg0)
						local f278_local0 = function(f279_arg0)
							local f279_local0 = function(f280_arg0)
								local f280_local0 = function(f281_arg0)
									local f281_local0 = function(f282_arg0)
										local f282_local0 = function(f283_arg0)
											local f283_local0 = function(f284_arg0)
												f284_arg0:beginAnimation(69)
												f284_arg0:setAlpha(0)
												f284_arg0:registerEventHandler("transition_complete_keyframe", f258_arg0.clipFinished)
											end
											f283_arg0:beginAnimation(90)
											f283_arg0:setAlpha(1)
											f283_arg0:registerEventHandler("transition_complete_keyframe", f283_local0)
										end
										f282_arg0:beginAnimation(90)
										f282_arg0:setAlpha(0.2)
										f282_arg0:registerEventHandler("transition_complete_keyframe", f282_local0)
									end
									f281_arg0:beginAnimation(1160)
									f281_arg0:registerEventHandler("transition_complete_keyframe", f281_local0)
								end
								f280_arg0:beginAnimation(139)
								f280_arg0:setAlpha(1)
								f280_arg0:registerEventHandler("transition_complete_keyframe", f280_local0)
							end
							f279_arg0:beginAnimation(110)
							f279_arg0:setAlpha(0.2)
							f279_arg0:registerEventHandler("transition_complete_keyframe", f279_local0)
						end
						f278_arg0:beginAnimation(100)
						f278_arg0:setAlpha(1)
						f278_arg0:registerEventHandler("transition_complete_keyframe", f278_local0)
					end
					f277_arg0:beginAnimation(89)
					f277_arg0:setAlpha(0.2)
					f277_arg0:registerEventHandler("transition_complete_keyframe", f277_local0)
				end
				f258_arg0.TierBoost:beginAnimation(40)
				f258_arg0.TierBoost:setAlpha(1)
				f258_arg0.TierBoost:registerEventHandler("interrupted_keyframe", f258_arg0.clipInterrupted)
				f258_arg0.TierBoost:registerEventHandler("transition_complete_keyframe", f276_local0)
			end
			f258_arg0.TierBoost:completeAnimation()
			f258_arg0.TierBoost:setLeftRight(0.5, 0.5, -96, 96)
			f258_arg0.TierBoost:setAlpha(0)
			f258_local1(f258_arg0.TierBoost)
		end,
	},
}
CoD.PrematchCountdown_2xpNotification.__onClose = function(f285_arg0)
	f285_arg0.DoubleXPText:close()
	f285_arg0.PrematchCountdown2xpBadge:close()
	f285_arg0.PrematchCountdown2xpWeaponBadge:close()
	f285_arg0.TierBoost:close()
end
