require("x64:182408ff493d0c1")
require("x64:ccda226110a5e1")
require("x64:9e7be51d884ab71")
require("x64:7553d3c19005336")
CoD.PrematchCountdown_2xpNotificationZM = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown_2xpNotificationZM.__defaultWidth = 400
CoD.PrematchCountdown_2xpNotificationZM.__defaultHeight = 255
CoD.PrematchCountdown_2xpNotificationZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "DoubleXpNotification", false)
	self:setClass(CoD.PrematchCountdown_2xpNotificationZM)
	self.id = "PrematchCountdown_2xpNotificationZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DoubleXPText = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -213, 213, 0, 0, 177, 225)
	DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xA2F4D3BF4BFC6E7))
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
	local ZMDoubleNPWidget = CoD.ZMDoubleNPWidget.new(f1_arg0, f1_arg1, 0, 0, 104, 296, 0, 0, 0, 192)
	ZMDoubleNPWidget:setAlpha(0)
	ZMDoubleNPWidget:setScale(0.75, 0.75)
	self:addElement(ZMDoubleNPWidget)
	self.ZMDoubleNPWidget = ZMDoubleNPWidget
	self:mergeStateConditions({
		{
			stateName = "All",
			condition = function(menu, element, event)
				local f2_local0 = IsDoubleXP(f1_arg1)
				if f2_local0 then
					f2_local0 = IsDoubleWeaponXP(f1_arg1)
					if f2_local0 then
						f2_local0 = CoD.ZombieUtility.IsDoubleNP(f1_arg1)
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "XpAndWeapon",
			condition = function(menu, element, event)
				local f3_local0 = IsDoubleXP(f1_arg1)
				if f3_local0 then
					f3_local0 = IsDoubleWeaponXP(f1_arg1)
					if f3_local0 then
						f3_local0 = not CoD.ZombieUtility.IsDoubleNP(f1_arg1)
					end
				end
				return f3_local0
			end,
		},
		{
			stateName = "XpAndNP",
			condition = function(menu, element, event)
				local f4_local0 = IsDoubleXP(f1_arg1)
				if f4_local0 then
					if not IsDoubleWeaponXP(f1_arg1) then
						f4_local0 = CoD.ZombieUtility.IsDoubleNP(f1_arg1)
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "WeaponAndNP",
			condition = function(menu, element, event)
				local f5_local0
				if not IsDoubleXP(f1_arg1) then
					f5_local0 = IsDoubleWeaponXP(f1_arg1)
					if f5_local0 then
						f5_local0 = CoD.ZombieUtility.IsDoubleNP(f1_arg1)
					end
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "DoubleXP",
			condition = function(menu, element, event)
				return IsDoubleXP(f1_arg1)
			end,
		},
		{
			stateName = "DoubleWeaponXP",
			condition = function(menu, element, event)
				return IsDoubleWeaponXP(f1_arg1)
			end,
		},
		{
			stateName = "NP",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsDoubleNP(f1_arg1)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.cycled, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PrematchCountdown_2xpNotificationZM.__resetProperties = function(f10_arg0)
	f10_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
	f10_arg0.PrematchCountdown2xpBadge:completeAnimation()
	f10_arg0.DoubleXPText:completeAnimation()
	f10_arg0.ZMDoubleNPWidget:completeAnimation()
	f10_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 0, 192)
	f10_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
	f10_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -192, 0)
	f10_arg0.PrematchCountdown2xpBadge:setAlpha(1)
	f10_arg0.DoubleXPText:setAlpha(1)
	f10_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xA2F4D3BF4BFC6E7))
	f10_arg0.ZMDoubleNPWidget:setLeftRight(0, 0, 104, 296)
	f10_arg0.ZMDoubleNPWidget:setAlpha(0)
end
CoD.PrematchCountdown_2xpNotificationZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(4)
			f11_arg0.DoubleXPText:completeAnimation()
			f11_arg0.DoubleXPText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DoubleXPText)
			f11_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f11_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PrematchCountdown2xpBadge)
			f11_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f11_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.PrematchCountdown2xpWeaponBadge)
			f11_arg0.ZMDoubleNPWidget:completeAnimation()
			f11_arg0.ZMDoubleNPWidget:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ZMDoubleNPWidget)
		end,
	},
	All = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.DoubleXPText:completeAnimation()
			f12_arg0.DoubleXPText.MatchText:completeAnimation()
			f12_arg0.DoubleXPText:setAlpha(0)
			f12_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xBACB4D078E5C949))
			f12_arg0.clipFinished(f12_arg0.DoubleXPText)
			f12_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f12_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f12_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PrematchCountdown2xpBadge)
			f12_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f12_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 96, 288)
			f12_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PrematchCountdown2xpWeaponBadge)
			f12_arg0.ZMDoubleNPWidget:completeAnimation()
			f12_arg0.ZMDoubleNPWidget:setLeftRight(0, 0, 104, 296)
			f12_arg0.ZMDoubleNPWidget:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ZMDoubleNPWidget)
		end,
		Notify = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
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
																	local f27_local0 = function(f28_arg0)
																		local f28_local0 = function(f29_arg0)
																			local f29_local0 = function(f30_arg0)
																				f30_arg0:beginAnimation(189)
																				f30_arg0:setAlpha(0)
																				f30_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
																			end
																			f29_arg0:beginAnimation(19)
																			f29_arg0:setAlpha(0.45)
																			f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
																		end
																		f28_arg0:beginAnimation(19)
																		f28_arg0:setAlpha(0.34)
																		f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
																	end
																	f27_arg0:beginAnimation(70)
																	f27_arg0:setAlpha(0.55)
																	f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
																end
																f26_arg0:beginAnimation(19)
																f26_arg0:setAlpha(0.71)
																f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
															end
															f25_arg0:beginAnimation(29)
															f25_arg0:setAlpha(0.44)
															f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
														end
														f24_arg0:beginAnimation(70)
														f24_arg0:setAlpha(0.83)
														f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
													end
													f23_arg0:beginAnimation(1150)
													f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
												end
												f22_arg0:beginAnimation(9)
												f22_arg0:setAlpha(1)
												f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
											end
											f21_arg0:beginAnimation(20)
											f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
										end
										f20_arg0:beginAnimation(9)
										f20_arg0:setAlpha(0.76)
										f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
									end
									f19_arg0:beginAnimation(39)
									f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
								end
								f18_arg0:beginAnimation(10)
								f18_arg0:setAlpha(1)
								f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
							end
							f17_arg0:beginAnimation(19)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
						end
						f16_arg0:beginAnimation(9)
						f16_arg0:setAlpha(0.45)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(160)
					f15_arg0:setAlpha(0.95)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f13_arg0.DoubleXPText:beginAnimation(200)
				f13_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.DoubleXPText:completeAnimation()
			f13_arg0.DoubleXPText.MatchText:completeAnimation()
			f13_arg0.DoubleXPText:setAlpha(0)
			f13_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xBACB4D078E5C949))
			f13_local0(f13_arg0.DoubleXPText)
			local f13_local1 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						local f33_local0 = function(f34_arg0)
							local f34_local0 = function(f35_arg0)
								local f35_local0 = function(f36_arg0)
									local f36_local0 = function(f37_arg0)
										local f37_local0 = function(f38_arg0)
											local f38_local0 = function(f39_arg0)
												f39_arg0:beginAnimation(69)
												f39_arg0:setAlpha(0)
												f39_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
											end
											f38_arg0:beginAnimation(90)
											f38_arg0:setAlpha(1)
											f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
										end
										f37_arg0:beginAnimation(90)
										f37_arg0:setAlpha(0.2)
										f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
									end
									f36_arg0:beginAnimation(1160)
									f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
								end
								f35_arg0:beginAnimation(139)
								f35_arg0:setAlpha(1)
								f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
							end
							f34_arg0:beginAnimation(110)
							f34_arg0:setAlpha(0.2)
							f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
						end
						f33_arg0:beginAnimation(100)
						f33_arg0:setAlpha(1)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
					end
					f32_arg0:beginAnimation(89)
					f32_arg0:setAlpha(0.2)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f13_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f13_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f13_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f13_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f13_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f13_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f13_local1(f13_arg0.PrematchCountdown2xpBadge)
			local f13_local2 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					local f41_local0 = function(f42_arg0)
						local f42_local0 = function(f43_arg0)
							local f43_local0 = function(f44_arg0)
								local f44_local0 = function(f45_arg0)
									local f45_local0 = function(f46_arg0)
										local f46_local0 = function(f47_arg0)
											local f47_local0 = function(f48_arg0)
												f48_arg0:beginAnimation(69)
												f48_arg0:setAlpha(0)
												f48_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
											end
											f47_arg0:beginAnimation(90)
											f47_arg0:setAlpha(1)
											f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
										end
										f46_arg0:beginAnimation(90)
										f46_arg0:setAlpha(0.2)
										f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
									end
									f45_arg0:beginAnimation(1160)
									f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
								end
								f44_arg0:beginAnimation(139)
								f44_arg0:setAlpha(1)
								f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
							end
							f43_arg0:beginAnimation(110)
							f43_arg0:setAlpha(0.2)
							f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
						end
						f42_arg0:beginAnimation(100)
						f42_arg0:setAlpha(1)
						f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
					end
					f41_arg0:beginAnimation(89)
					f41_arg0:setAlpha(0.2)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
				end
				f13_arg0.PrematchCountdown2xpWeaponBadge:beginAnimation(40)
				f13_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
				f13_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f13_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f13_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 96, 288)
			f13_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f13_local2(f13_arg0.PrematchCountdown2xpWeaponBadge)
			local f13_local3 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					local f50_local0 = function(f51_arg0)
						local f51_local0 = function(f52_arg0)
							local f52_local0 = function(f53_arg0)
								local f53_local0 = function(f54_arg0)
									local f54_local0 = function(f55_arg0)
										local f55_local0 = function(f56_arg0)
											local f56_local0 = function(f57_arg0)
												f57_arg0:beginAnimation(69)
												f57_arg0:setAlpha(0)
												f57_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
											end
											f56_arg0:beginAnimation(90)
											f56_arg0:setAlpha(1)
											f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
										end
										f55_arg0:beginAnimation(90)
										f55_arg0:setAlpha(0.2)
										f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
									end
									f54_arg0:beginAnimation(1160)
									f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
								end
								f53_arg0:beginAnimation(139)
								f53_arg0:setAlpha(1)
								f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
							end
							f52_arg0:beginAnimation(110)
							f52_arg0:setAlpha(0.2)
							f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
						end
						f51_arg0:beginAnimation(100)
						f51_arg0:setAlpha(1)
						f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
					end
					f50_arg0:beginAnimation(89)
					f50_arg0:setAlpha(0.2)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
				end
				f13_arg0.ZMDoubleNPWidget:beginAnimation(40)
				f13_arg0.ZMDoubleNPWidget:setAlpha(1)
				f13_arg0.ZMDoubleNPWidget:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ZMDoubleNPWidget:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f13_arg0.ZMDoubleNPWidget:completeAnimation()
			f13_arg0.ZMDoubleNPWidget:setLeftRight(0, 0, -88, 104)
			f13_arg0.ZMDoubleNPWidget:setAlpha(0)
			f13_local3(f13_arg0.ZMDoubleNPWidget)
		end,
	},
	XpAndWeapon = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(3)
			f58_arg0.DoubleXPText:completeAnimation()
			f58_arg0.DoubleXPText.MatchText:completeAnimation()
			f58_arg0.DoubleXPText:setAlpha(0)
			f58_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x7AF43698F175B3A))
			f58_arg0.clipFinished(f58_arg0.DoubleXPText)
			f58_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f58_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.PrematchCountdown2xpBadge)
			f58_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f58_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.PrematchCountdown2xpWeaponBadge)
		end,
		Notify = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(3)
			local f59_local0 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					local f61_local0 = function(f62_arg0)
						local f62_local0 = function(f63_arg0)
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
																				f76_arg0:beginAnimation(189)
																				f76_arg0:setAlpha(0)
																				f76_arg0:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
																			end
																			f75_arg0:beginAnimation(19)
																			f75_arg0:setAlpha(0.45)
																			f75_arg0:registerEventHandler("transition_complete_keyframe", f75_local0)
																		end
																		f74_arg0:beginAnimation(19)
																		f74_arg0:setAlpha(0.34)
																		f74_arg0:registerEventHandler("transition_complete_keyframe", f74_local0)
																	end
																	f73_arg0:beginAnimation(70)
																	f73_arg0:setAlpha(0.55)
																	f73_arg0:registerEventHandler("transition_complete_keyframe", f73_local0)
																end
																f72_arg0:beginAnimation(19)
																f72_arg0:setAlpha(0.71)
																f72_arg0:registerEventHandler("transition_complete_keyframe", f72_local0)
															end
															f71_arg0:beginAnimation(29)
															f71_arg0:setAlpha(0.44)
															f71_arg0:registerEventHandler("transition_complete_keyframe", f71_local0)
														end
														f70_arg0:beginAnimation(70)
														f70_arg0:setAlpha(0.83)
														f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
													end
													f69_arg0:beginAnimation(1150)
													f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
												end
												f68_arg0:beginAnimation(9)
												f68_arg0:setAlpha(1)
												f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
											end
											f67_arg0:beginAnimation(20)
											f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
										end
										f66_arg0:beginAnimation(9)
										f66_arg0:setAlpha(0.76)
										f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
									end
									f65_arg0:beginAnimation(39)
									f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
								end
								f64_arg0:beginAnimation(10)
								f64_arg0:setAlpha(1)
								f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
							end
							f63_arg0:beginAnimation(19)
							f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
						end
						f62_arg0:beginAnimation(9)
						f62_arg0:setAlpha(0.45)
						f62_arg0:registerEventHandler("transition_complete_keyframe", f62_local0)
					end
					f61_arg0:beginAnimation(160)
					f61_arg0:setAlpha(0.95)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
				end
				f59_arg0.DoubleXPText:beginAnimation(200)
				f59_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f59_arg0.DoubleXPText:completeAnimation()
			f59_arg0.DoubleXPText.MatchText:completeAnimation()
			f59_arg0.DoubleXPText:setAlpha(0)
			f59_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x7AF43698F175B3A))
			f59_local0(f59_arg0.DoubleXPText)
			local f59_local1 = function(f77_arg0)
				local f77_local0 = function(f78_arg0)
					local f78_local0 = function(f79_arg0)
						local f79_local0 = function(f80_arg0)
							local f80_local0 = function(f81_arg0)
								local f81_local0 = function(f82_arg0)
									local f82_local0 = function(f83_arg0)
										local f83_local0 = function(f84_arg0)
											local f84_local0 = function(f85_arg0)
												f85_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
												f85_arg0:setAlpha(0)
												f85_arg0:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
											end
											f84_arg0:beginAnimation(90, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
											f84_arg0:setAlpha(1)
											f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
										end
										f83_arg0:beginAnimation(90, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
										f83_arg0:setAlpha(0.2)
										f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
									end
									f82_arg0:beginAnimation(1160)
									f82_arg0:registerEventHandler("transition_complete_keyframe", f82_local0)
								end
								f81_arg0:beginAnimation(139, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
								f81_arg0:setAlpha(1)
								f81_arg0:registerEventHandler("transition_complete_keyframe", f81_local0)
							end
							f80_arg0:beginAnimation(110, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f80_arg0:setAlpha(0.2)
							f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
						end
						f79_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f79_arg0:setAlpha(1)
						f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
					end
					f78_arg0:beginAnimation(89)
					f78_arg0:setAlpha(0.2)
					f78_arg0:registerEventHandler("transition_complete_keyframe", f78_local0)
				end
				f59_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f59_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f59_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f77_local0)
			end
			f59_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f59_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f59_local1(f59_arg0.PrematchCountdown2xpBadge)
			local f59_local2 = function(f86_arg0)
				local f86_local0 = function(f87_arg0)
					local f87_local0 = function(f88_arg0)
						local f88_local0 = function(f89_arg0)
							local f89_local0 = function(f90_arg0)
								local f90_local0 = function(f91_arg0)
									local f91_local0 = function(f92_arg0)
										local f92_local0 = function(f93_arg0)
											local f93_local0 = function(f94_arg0)
												f94_arg0:beginAnimation(69)
												f94_arg0:setAlpha(0)
												f94_arg0:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
											end
											f93_arg0:beginAnimation(90)
											f93_arg0:setAlpha(1)
											f93_arg0:registerEventHandler("transition_complete_keyframe", f93_local0)
										end
										f92_arg0:beginAnimation(90)
										f92_arg0:setAlpha(0.2)
										f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
									end
									f91_arg0:beginAnimation(1160)
									f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
								end
								f90_arg0:beginAnimation(139)
								f90_arg0:setAlpha(1)
								f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
							end
							f89_arg0:beginAnimation(110)
							f89_arg0:setAlpha(0.2)
							f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
						end
						f88_arg0:beginAnimation(100)
						f88_arg0:setAlpha(1)
						f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
					end
					f87_arg0:beginAnimation(89)
					f87_arg0:setAlpha(0.2)
					f87_arg0:registerEventHandler("transition_complete_keyframe", f87_local0)
				end
				f59_arg0.PrematchCountdown2xpWeaponBadge:beginAnimation(40)
				f59_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
				f59_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("transition_complete_keyframe", f86_local0)
			end
			f59_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f59_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f59_local2(f59_arg0.PrematchCountdown2xpWeaponBadge)
		end,
	},
	XpAndNP = {
		DefaultClip = function(f95_arg0, f95_arg1)
			f95_arg0:__resetProperties()
			f95_arg0:setupElementClipCounter(4)
			f95_arg0.DoubleXPText:completeAnimation()
			f95_arg0.DoubleXPText.MatchText:completeAnimation()
			f95_arg0.DoubleXPText:setAlpha(0)
			f95_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x7AF43698F175B3A))
			f95_arg0.clipFinished(f95_arg0.DoubleXPText)
			f95_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f95_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.PrematchCountdown2xpBadge)
			f95_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f95_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.PrematchCountdown2xpWeaponBadge)
			f95_arg0.ZMDoubleNPWidget:completeAnimation()
			f95_arg0.ZMDoubleNPWidget:setAlpha(0)
			f95_arg0.clipFinished(f95_arg0.ZMDoubleNPWidget)
		end,
		Notify = function(f96_arg0, f96_arg1)
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter(4)
			local f96_local0 = function(f97_arg0)
				local f97_local0 = function(f98_arg0)
					local f98_local0 = function(f99_arg0)
						local f99_local0 = function(f100_arg0)
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
																				f113_arg0:beginAnimation(189)
																				f113_arg0:setAlpha(0)
																				f113_arg0:registerEventHandler("transition_complete_keyframe", f96_arg0.clipFinished)
																			end
																			f112_arg0:beginAnimation(19)
																			f112_arg0:setAlpha(0.45)
																			f112_arg0:registerEventHandler("transition_complete_keyframe", f112_local0)
																		end
																		f111_arg0:beginAnimation(19)
																		f111_arg0:setAlpha(0.34)
																		f111_arg0:registerEventHandler("transition_complete_keyframe", f111_local0)
																	end
																	f110_arg0:beginAnimation(70)
																	f110_arg0:setAlpha(0.55)
																	f110_arg0:registerEventHandler("transition_complete_keyframe", f110_local0)
																end
																f109_arg0:beginAnimation(19)
																f109_arg0:setAlpha(0.71)
																f109_arg0:registerEventHandler("transition_complete_keyframe", f109_local0)
															end
															f108_arg0:beginAnimation(29)
															f108_arg0:setAlpha(0.44)
															f108_arg0:registerEventHandler("transition_complete_keyframe", f108_local0)
														end
														f107_arg0:beginAnimation(70)
														f107_arg0:setAlpha(0.83)
														f107_arg0:registerEventHandler("transition_complete_keyframe", f107_local0)
													end
													f106_arg0:beginAnimation(1150)
													f106_arg0:registerEventHandler("transition_complete_keyframe", f106_local0)
												end
												f105_arg0:beginAnimation(9)
												f105_arg0:setAlpha(1)
												f105_arg0:registerEventHandler("transition_complete_keyframe", f105_local0)
											end
											f104_arg0:beginAnimation(20)
											f104_arg0:registerEventHandler("transition_complete_keyframe", f104_local0)
										end
										f103_arg0:beginAnimation(9)
										f103_arg0:setAlpha(0.76)
										f103_arg0:registerEventHandler("transition_complete_keyframe", f103_local0)
									end
									f102_arg0:beginAnimation(39)
									f102_arg0:registerEventHandler("transition_complete_keyframe", f102_local0)
								end
								f101_arg0:beginAnimation(10)
								f101_arg0:setAlpha(1)
								f101_arg0:registerEventHandler("transition_complete_keyframe", f101_local0)
							end
							f100_arg0:beginAnimation(19)
							f100_arg0:registerEventHandler("transition_complete_keyframe", f100_local0)
						end
						f99_arg0:beginAnimation(9)
						f99_arg0:setAlpha(0.45)
						f99_arg0:registerEventHandler("transition_complete_keyframe", f99_local0)
					end
					f98_arg0:beginAnimation(160)
					f98_arg0:setAlpha(0.95)
					f98_arg0:registerEventHandler("transition_complete_keyframe", f98_local0)
				end
				f96_arg0.DoubleXPText:beginAnimation(200)
				f96_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f96_arg0.clipInterrupted)
				f96_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f97_local0)
			end
			f96_arg0.DoubleXPText:completeAnimation()
			f96_arg0.DoubleXPText.MatchText:completeAnimation()
			f96_arg0.DoubleXPText:setAlpha(0)
			f96_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x7AF43698F175B3A))
			f96_local0(f96_arg0.DoubleXPText)
			local f96_local1 = function(f114_arg0)
				local f114_local0 = function(f115_arg0)
					local f115_local0 = function(f116_arg0)
						local f116_local0 = function(f117_arg0)
							local f117_local0 = function(f118_arg0)
								local f118_local0 = function(f119_arg0)
									local f119_local0 = function(f120_arg0)
										local f120_local0 = function(f121_arg0)
											local f121_local0 = function(f122_arg0)
												f122_arg0:beginAnimation(69)
												f122_arg0:setAlpha(0)
												f122_arg0:registerEventHandler("transition_complete_keyframe", f96_arg0.clipFinished)
											end
											f121_arg0:beginAnimation(90)
											f121_arg0:setAlpha(1)
											f121_arg0:registerEventHandler("transition_complete_keyframe", f121_local0)
										end
										f120_arg0:beginAnimation(90)
										f120_arg0:setAlpha(0.2)
										f120_arg0:registerEventHandler("transition_complete_keyframe", f120_local0)
									end
									f119_arg0:beginAnimation(1160)
									f119_arg0:registerEventHandler("transition_complete_keyframe", f119_local0)
								end
								f118_arg0:beginAnimation(139)
								f118_arg0:setAlpha(1)
								f118_arg0:registerEventHandler("transition_complete_keyframe", f118_local0)
							end
							f117_arg0:beginAnimation(110)
							f117_arg0:setAlpha(0.2)
							f117_arg0:registerEventHandler("transition_complete_keyframe", f117_local0)
						end
						f116_arg0:beginAnimation(100)
						f116_arg0:setAlpha(1)
						f116_arg0:registerEventHandler("transition_complete_keyframe", f116_local0)
					end
					f115_arg0:beginAnimation(89)
					f115_arg0:setAlpha(0.2)
					f115_arg0:registerEventHandler("transition_complete_keyframe", f115_local0)
				end
				f96_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f96_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f96_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f96_arg0.clipInterrupted)
				f96_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f114_local0)
			end
			f96_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f96_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, 0, 192)
			f96_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f96_local1(f96_arg0.PrematchCountdown2xpBadge)
			f96_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f96_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 96, 288)
			f96_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f96_arg0.clipFinished(f96_arg0.PrematchCountdown2xpWeaponBadge)
			local f96_local2 = function(f123_arg0)
				local f123_local0 = function(f124_arg0)
					local f124_local0 = function(f125_arg0)
						local f125_local0 = function(f126_arg0)
							local f126_local0 = function(f127_arg0)
								local f127_local0 = function(f128_arg0)
									local f128_local0 = function(f129_arg0)
										local f129_local0 = function(f130_arg0)
											local f130_local0 = function(f131_arg0)
												f131_arg0:beginAnimation(69)
												f131_arg0:setAlpha(0)
												f131_arg0:registerEventHandler("transition_complete_keyframe", f96_arg0.clipFinished)
											end
											f130_arg0:beginAnimation(90)
											f130_arg0:setAlpha(1)
											f130_arg0:registerEventHandler("transition_complete_keyframe", f130_local0)
										end
										f129_arg0:beginAnimation(90)
										f129_arg0:setAlpha(0.2)
										f129_arg0:registerEventHandler("transition_complete_keyframe", f129_local0)
									end
									f128_arg0:beginAnimation(1160)
									f128_arg0:registerEventHandler("transition_complete_keyframe", f128_local0)
								end
								f127_arg0:beginAnimation(139)
								f127_arg0:setAlpha(1)
								f127_arg0:registerEventHandler("transition_complete_keyframe", f127_local0)
							end
							f126_arg0:beginAnimation(110)
							f126_arg0:setAlpha(0.2)
							f126_arg0:registerEventHandler("transition_complete_keyframe", f126_local0)
						end
						f125_arg0:beginAnimation(100)
						f125_arg0:setAlpha(1)
						f125_arg0:registerEventHandler("transition_complete_keyframe", f125_local0)
					end
					f124_arg0:beginAnimation(89)
					f124_arg0:setAlpha(0.2)
					f124_arg0:registerEventHandler("transition_complete_keyframe", f124_local0)
				end
				f96_arg0.ZMDoubleNPWidget:beginAnimation(40)
				f96_arg0.ZMDoubleNPWidget:setAlpha(1)
				f96_arg0.ZMDoubleNPWidget:registerEventHandler("interrupted_keyframe", f96_arg0.clipInterrupted)
				f96_arg0.ZMDoubleNPWidget:registerEventHandler("transition_complete_keyframe", f123_local0)
			end
			f96_arg0.ZMDoubleNPWidget:completeAnimation()
			f96_arg0.ZMDoubleNPWidget:setLeftRight(0, 0, 8, 200)
			f96_arg0.ZMDoubleNPWidget:setAlpha(0)
			f96_local2(f96_arg0.ZMDoubleNPWidget)
		end,
	},
	WeaponAndNP = {
		DefaultClip = function(f132_arg0, f132_arg1)
			f132_arg0:__resetProperties()
			f132_arg0:setupElementClipCounter(4)
			f132_arg0.DoubleXPText:completeAnimation()
			f132_arg0.DoubleXPText.MatchText:completeAnimation()
			f132_arg0.DoubleXPText:setAlpha(0)
			f132_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x7AF43698F175B3A))
			f132_arg0.clipFinished(f132_arg0.DoubleXPText)
			f132_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f132_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f132_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.PrematchCountdown2xpBadge)
			f132_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f132_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 96, 288)
			f132_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.PrematchCountdown2xpWeaponBadge)
			f132_arg0.ZMDoubleNPWidget:completeAnimation()
			f132_arg0.ZMDoubleNPWidget:setLeftRight(0, 0, 104, 296)
			f132_arg0.ZMDoubleNPWidget:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.ZMDoubleNPWidget)
		end,
		Notify = function(f133_arg0, f133_arg1)
			f133_arg0:__resetProperties()
			f133_arg0:setupElementClipCounter(4)
			local f133_local0 = function(f134_arg0)
				local f134_local0 = function(f135_arg0)
					local f135_local0 = function(f136_arg0)
						local f136_local0 = function(f137_arg0)
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
																				f150_arg0:beginAnimation(189)
																				f150_arg0:setAlpha(0)
																				f150_arg0:registerEventHandler("transition_complete_keyframe", f133_arg0.clipFinished)
																			end
																			f149_arg0:beginAnimation(19)
																			f149_arg0:setAlpha(0.45)
																			f149_arg0:registerEventHandler("transition_complete_keyframe", f149_local0)
																		end
																		f148_arg0:beginAnimation(19)
																		f148_arg0:setAlpha(0.34)
																		f148_arg0:registerEventHandler("transition_complete_keyframe", f148_local0)
																	end
																	f147_arg0:beginAnimation(70)
																	f147_arg0:setAlpha(0.55)
																	f147_arg0:registerEventHandler("transition_complete_keyframe", f147_local0)
																end
																f146_arg0:beginAnimation(19)
																f146_arg0:setAlpha(0.71)
																f146_arg0:registerEventHandler("transition_complete_keyframe", f146_local0)
															end
															f145_arg0:beginAnimation(29)
															f145_arg0:setAlpha(0.44)
															f145_arg0:registerEventHandler("transition_complete_keyframe", f145_local0)
														end
														f144_arg0:beginAnimation(70)
														f144_arg0:setAlpha(0.83)
														f144_arg0:registerEventHandler("transition_complete_keyframe", f144_local0)
													end
													f143_arg0:beginAnimation(1150)
													f143_arg0:registerEventHandler("transition_complete_keyframe", f143_local0)
												end
												f142_arg0:beginAnimation(9)
												f142_arg0:setAlpha(1)
												f142_arg0:registerEventHandler("transition_complete_keyframe", f142_local0)
											end
											f141_arg0:beginAnimation(20)
											f141_arg0:registerEventHandler("transition_complete_keyframe", f141_local0)
										end
										f140_arg0:beginAnimation(9)
										f140_arg0:setAlpha(0.76)
										f140_arg0:registerEventHandler("transition_complete_keyframe", f140_local0)
									end
									f139_arg0:beginAnimation(39)
									f139_arg0:registerEventHandler("transition_complete_keyframe", f139_local0)
								end
								f138_arg0:beginAnimation(10)
								f138_arg0:setAlpha(1)
								f138_arg0:registerEventHandler("transition_complete_keyframe", f138_local0)
							end
							f137_arg0:beginAnimation(19)
							f137_arg0:registerEventHandler("transition_complete_keyframe", f137_local0)
						end
						f136_arg0:beginAnimation(9)
						f136_arg0:setAlpha(0.45)
						f136_arg0:registerEventHandler("transition_complete_keyframe", f136_local0)
					end
					f135_arg0:beginAnimation(160)
					f135_arg0:setAlpha(0.95)
					f135_arg0:registerEventHandler("transition_complete_keyframe", f135_local0)
				end
				f133_arg0.DoubleXPText:beginAnimation(200)
				f133_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f133_arg0.clipInterrupted)
				f133_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f134_local0)
			end
			f133_arg0.DoubleXPText:completeAnimation()
			f133_arg0.DoubleXPText.MatchText:completeAnimation()
			f133_arg0.DoubleXPText:setAlpha(0)
			f133_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x7AF43698F175B3A))
			f133_local0(f133_arg0.DoubleXPText)
			f133_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f133_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f133_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.PrematchCountdown2xpBadge)
			local f133_local1 = function(f151_arg0)
				local f151_local0 = function(f152_arg0)
					local f152_local0 = function(f153_arg0)
						local f153_local0 = function(f154_arg0)
							local f154_local0 = function(f155_arg0)
								local f155_local0 = function(f156_arg0)
									local f156_local0 = function(f157_arg0)
										local f157_local0 = function(f158_arg0)
											local f158_local0 = function(f159_arg0)
												f159_arg0:beginAnimation(69)
												f159_arg0:setAlpha(0)
												f159_arg0:registerEventHandler("transition_complete_keyframe", f133_arg0.clipFinished)
											end
											f158_arg0:beginAnimation(90)
											f158_arg0:setAlpha(1)
											f158_arg0:registerEventHandler("transition_complete_keyframe", f158_local0)
										end
										f157_arg0:beginAnimation(90)
										f157_arg0:setAlpha(0.2)
										f157_arg0:registerEventHandler("transition_complete_keyframe", f157_local0)
									end
									f156_arg0:beginAnimation(1160)
									f156_arg0:registerEventHandler("transition_complete_keyframe", f156_local0)
								end
								f155_arg0:beginAnimation(139)
								f155_arg0:setAlpha(1)
								f155_arg0:registerEventHandler("transition_complete_keyframe", f155_local0)
							end
							f154_arg0:beginAnimation(110)
							f154_arg0:setAlpha(0.2)
							f154_arg0:registerEventHandler("transition_complete_keyframe", f154_local0)
						end
						f153_arg0:beginAnimation(100)
						f153_arg0:setAlpha(1)
						f153_arg0:registerEventHandler("transition_complete_keyframe", f153_local0)
					end
					f152_arg0:beginAnimation(89)
					f152_arg0:setAlpha(0.2)
					f152_arg0:registerEventHandler("transition_complete_keyframe", f152_local0)
				end
				f133_arg0.PrematchCountdown2xpWeaponBadge:beginAnimation(40)
				f133_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
				f133_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("interrupted_keyframe", f133_arg0.clipInterrupted)
				f133_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("transition_complete_keyframe", f151_local0)
			end
			f133_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f133_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, 0, 192)
			f133_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f133_local1(f133_arg0.PrematchCountdown2xpWeaponBadge)
			local f133_local2 = function(f160_arg0)
				local f160_local0 = function(f161_arg0)
					local f161_local0 = function(f162_arg0)
						local f162_local0 = function(f163_arg0)
							local f163_local0 = function(f164_arg0)
								local f164_local0 = function(f165_arg0)
									local f165_local0 = function(f166_arg0)
										local f166_local0 = function(f167_arg0)
											local f167_local0 = function(f168_arg0)
												f168_arg0:beginAnimation(69)
												f168_arg0:setAlpha(0)
												f168_arg0:registerEventHandler("transition_complete_keyframe", f133_arg0.clipFinished)
											end
											f167_arg0:beginAnimation(90)
											f167_arg0:setAlpha(1)
											f167_arg0:registerEventHandler("transition_complete_keyframe", f167_local0)
										end
										f166_arg0:beginAnimation(90)
										f166_arg0:setAlpha(0.2)
										f166_arg0:registerEventHandler("transition_complete_keyframe", f166_local0)
									end
									f165_arg0:beginAnimation(1160)
									f165_arg0:registerEventHandler("transition_complete_keyframe", f165_local0)
								end
								f164_arg0:beginAnimation(139)
								f164_arg0:setAlpha(1)
								f164_arg0:registerEventHandler("transition_complete_keyframe", f164_local0)
							end
							f163_arg0:beginAnimation(110)
							f163_arg0:setAlpha(0.2)
							f163_arg0:registerEventHandler("transition_complete_keyframe", f163_local0)
						end
						f162_arg0:beginAnimation(100)
						f162_arg0:setAlpha(1)
						f162_arg0:registerEventHandler("transition_complete_keyframe", f162_local0)
					end
					f161_arg0:beginAnimation(89)
					f161_arg0:setAlpha(0.2)
					f161_arg0:registerEventHandler("transition_complete_keyframe", f161_local0)
				end
				f133_arg0.ZMDoubleNPWidget:beginAnimation(40)
				f133_arg0.ZMDoubleNPWidget:setAlpha(1)
				f133_arg0.ZMDoubleNPWidget:registerEventHandler("interrupted_keyframe", f133_arg0.clipInterrupted)
				f133_arg0.ZMDoubleNPWidget:registerEventHandler("transition_complete_keyframe", f160_local0)
			end
			f133_arg0.ZMDoubleNPWidget:completeAnimation()
			f133_arg0.ZMDoubleNPWidget:setLeftRight(0, 0, 8, 200)
			f133_arg0.ZMDoubleNPWidget:setAlpha(0)
			f133_local2(f133_arg0.ZMDoubleNPWidget)
		end,
	},
	DoubleXP = {
		DefaultClip = function(f169_arg0, f169_arg1)
			f169_arg0:__resetProperties()
			f169_arg0:setupElementClipCounter(3)
			f169_arg0.DoubleXPText:completeAnimation()
			f169_arg0.DoubleXPText.MatchText:completeAnimation()
			f169_arg0.DoubleXPText:setAlpha(0)
			f169_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xA2F4D3BF4BFC6E7))
			f169_arg0.clipFinished(f169_arg0.DoubleXPText)
			f169_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f169_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f169_arg0.clipFinished(f169_arg0.PrematchCountdown2xpBadge)
			f169_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f169_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f169_arg0.clipFinished(f169_arg0.PrematchCountdown2xpWeaponBadge)
		end,
		Notify = function(f170_arg0, f170_arg1)
			f170_arg0:__resetProperties()
			f170_arg0:setupElementClipCounter(3)
			local f170_local0 = function(f171_arg0)
				local f171_local0 = function(f172_arg0)
					local f172_local0 = function(f173_arg0)
						local f173_local0 = function(f174_arg0)
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
																				f187_arg0:beginAnimation(189)
																				f187_arg0:setAlpha(0)
																				f187_arg0:registerEventHandler("transition_complete_keyframe", f170_arg0.clipFinished)
																			end
																			f186_arg0:beginAnimation(19)
																			f186_arg0:setAlpha(0.45)
																			f186_arg0:registerEventHandler("transition_complete_keyframe", f186_local0)
																		end
																		f185_arg0:beginAnimation(19)
																		f185_arg0:setAlpha(0.34)
																		f185_arg0:registerEventHandler("transition_complete_keyframe", f185_local0)
																	end
																	f184_arg0:beginAnimation(70)
																	f184_arg0:setAlpha(0.55)
																	f184_arg0:registerEventHandler("transition_complete_keyframe", f184_local0)
																end
																f183_arg0:beginAnimation(19)
																f183_arg0:setAlpha(0.71)
																f183_arg0:registerEventHandler("transition_complete_keyframe", f183_local0)
															end
															f182_arg0:beginAnimation(29)
															f182_arg0:setAlpha(0.44)
															f182_arg0:registerEventHandler("transition_complete_keyframe", f182_local0)
														end
														f181_arg0:beginAnimation(70)
														f181_arg0:setAlpha(0.83)
														f181_arg0:registerEventHandler("transition_complete_keyframe", f181_local0)
													end
													f180_arg0:beginAnimation(1150)
													f180_arg0:registerEventHandler("transition_complete_keyframe", f180_local0)
												end
												f179_arg0:beginAnimation(9)
												f179_arg0:setAlpha(1)
												f179_arg0:registerEventHandler("transition_complete_keyframe", f179_local0)
											end
											f178_arg0:beginAnimation(20)
											f178_arg0:registerEventHandler("transition_complete_keyframe", f178_local0)
										end
										f177_arg0:beginAnimation(9)
										f177_arg0:setAlpha(0.76)
										f177_arg0:registerEventHandler("transition_complete_keyframe", f177_local0)
									end
									f176_arg0:beginAnimation(39)
									f176_arg0:registerEventHandler("transition_complete_keyframe", f176_local0)
								end
								f175_arg0:beginAnimation(10)
								f175_arg0:setAlpha(1)
								f175_arg0:registerEventHandler("transition_complete_keyframe", f175_local0)
							end
							f174_arg0:beginAnimation(19)
							f174_arg0:registerEventHandler("transition_complete_keyframe", f174_local0)
						end
						f173_arg0:beginAnimation(9)
						f173_arg0:setAlpha(0.45)
						f173_arg0:registerEventHandler("transition_complete_keyframe", f173_local0)
					end
					f172_arg0:beginAnimation(160)
					f172_arg0:setAlpha(0.95)
					f172_arg0:registerEventHandler("transition_complete_keyframe", f172_local0)
				end
				f170_arg0.DoubleXPText:beginAnimation(200)
				f170_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f170_arg0.clipInterrupted)
				f170_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f171_local0)
			end
			f170_arg0.DoubleXPText:completeAnimation()
			f170_arg0.DoubleXPText.MatchText:completeAnimation()
			f170_arg0.DoubleXPText:setAlpha(0)
			f170_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xA2F4D3BF4BFC6E7))
			f170_local0(f170_arg0.DoubleXPText)
			local f170_local1 = function(f188_arg0)
				local f188_local0 = function(f189_arg0)
					local f189_local0 = function(f190_arg0)
						local f190_local0 = function(f191_arg0)
							local f191_local0 = function(f192_arg0)
								local f192_local0 = function(f193_arg0)
									local f193_local0 = function(f194_arg0)
										local f194_local0 = function(f195_arg0)
											local f195_local0 = function(f196_arg0)
												f196_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
												f196_arg0:setAlpha(0)
												f196_arg0:registerEventHandler("transition_complete_keyframe", f170_arg0.clipFinished)
											end
											f195_arg0:beginAnimation(90, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
											f195_arg0:setAlpha(1)
											f195_arg0:registerEventHandler("transition_complete_keyframe", f195_local0)
										end
										f194_arg0:beginAnimation(90, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
										f194_arg0:setAlpha(0.2)
										f194_arg0:registerEventHandler("transition_complete_keyframe", f194_local0)
									end
									f193_arg0:beginAnimation(1160)
									f193_arg0:registerEventHandler("transition_complete_keyframe", f193_local0)
								end
								f192_arg0:beginAnimation(139, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
								f192_arg0:setAlpha(1)
								f192_arg0:registerEventHandler("transition_complete_keyframe", f192_local0)
							end
							f191_arg0:beginAnimation(110, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f191_arg0:setAlpha(0.2)
							f191_arg0:registerEventHandler("transition_complete_keyframe", f191_local0)
						end
						f190_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f190_arg0:setAlpha(1)
						f190_arg0:registerEventHandler("transition_complete_keyframe", f190_local0)
					end
					f189_arg0:beginAnimation(89)
					f189_arg0:setAlpha(0.2)
					f189_arg0:registerEventHandler("transition_complete_keyframe", f189_local0)
				end
				f170_arg0.PrematchCountdown2xpBadge:beginAnimation(40)
				f170_arg0.PrematchCountdown2xpBadge:setAlpha(1)
				f170_arg0.PrematchCountdown2xpBadge:registerEventHandler("interrupted_keyframe", f170_arg0.clipInterrupted)
				f170_arg0.PrematchCountdown2xpBadge:registerEventHandler("transition_complete_keyframe", f188_local0)
			end
			f170_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f170_arg0.PrematchCountdown2xpBadge:setLeftRight(0.5, 0.5, -96, 96)
			f170_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f170_local1(f170_arg0.PrematchCountdown2xpBadge)
			f170_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f170_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f170_arg0.clipFinished(f170_arg0.PrematchCountdown2xpWeaponBadge)
		end,
	},
	DoubleWeaponXP = {
		DefaultClip = function(f197_arg0, f197_arg1)
			f197_arg0:__resetProperties()
			f197_arg0:setupElementClipCounter(3)
			f197_arg0.DoubleXPText:completeAnimation()
			f197_arg0.DoubleXPText.MatchText:completeAnimation()
			f197_arg0.DoubleXPText:setAlpha(0)
			f197_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xDD7D8B6F4DC3660))
			f197_arg0.clipFinished(f197_arg0.DoubleXPText)
			f197_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f197_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f197_arg0.clipFinished(f197_arg0.PrematchCountdown2xpBadge)
			f197_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f197_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f197_arg0.clipFinished(f197_arg0.PrematchCountdown2xpWeaponBadge)
		end,
		Notify = function(f198_arg0, f198_arg1)
			f198_arg0:__resetProperties()
			f198_arg0:setupElementClipCounter(3)
			local f198_local0 = function(f199_arg0)
				local f199_local0 = function(f200_arg0)
					local f200_local0 = function(f201_arg0)
						local f201_local0 = function(f202_arg0)
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
																				f215_arg0:beginAnimation(189)
																				f215_arg0:setAlpha(0)
																				f215_arg0:registerEventHandler("transition_complete_keyframe", f198_arg0.clipFinished)
																			end
																			f214_arg0:beginAnimation(19)
																			f214_arg0:setAlpha(0.45)
																			f214_arg0:registerEventHandler("transition_complete_keyframe", f214_local0)
																		end
																		f213_arg0:beginAnimation(19)
																		f213_arg0:setAlpha(0.34)
																		f213_arg0:registerEventHandler("transition_complete_keyframe", f213_local0)
																	end
																	f212_arg0:beginAnimation(70)
																	f212_arg0:setAlpha(0.55)
																	f212_arg0:registerEventHandler("transition_complete_keyframe", f212_local0)
																end
																f211_arg0:beginAnimation(19)
																f211_arg0:setAlpha(0.71)
																f211_arg0:registerEventHandler("transition_complete_keyframe", f211_local0)
															end
															f210_arg0:beginAnimation(29)
															f210_arg0:setAlpha(0.44)
															f210_arg0:registerEventHandler("transition_complete_keyframe", f210_local0)
														end
														f209_arg0:beginAnimation(70)
														f209_arg0:setAlpha(0.83)
														f209_arg0:registerEventHandler("transition_complete_keyframe", f209_local0)
													end
													f208_arg0:beginAnimation(1150)
													f208_arg0:registerEventHandler("transition_complete_keyframe", f208_local0)
												end
												f207_arg0:beginAnimation(9)
												f207_arg0:setAlpha(1)
												f207_arg0:registerEventHandler("transition_complete_keyframe", f207_local0)
											end
											f206_arg0:beginAnimation(20)
											f206_arg0:registerEventHandler("transition_complete_keyframe", f206_local0)
										end
										f205_arg0:beginAnimation(9)
										f205_arg0:setAlpha(0.76)
										f205_arg0:registerEventHandler("transition_complete_keyframe", f205_local0)
									end
									f204_arg0:beginAnimation(39)
									f204_arg0:registerEventHandler("transition_complete_keyframe", f204_local0)
								end
								f203_arg0:beginAnimation(10)
								f203_arg0:setAlpha(1)
								f203_arg0:registerEventHandler("transition_complete_keyframe", f203_local0)
							end
							f202_arg0:beginAnimation(19)
							f202_arg0:registerEventHandler("transition_complete_keyframe", f202_local0)
						end
						f201_arg0:beginAnimation(9)
						f201_arg0:setAlpha(0.45)
						f201_arg0:registerEventHandler("transition_complete_keyframe", f201_local0)
					end
					f200_arg0:beginAnimation(160)
					f200_arg0:setAlpha(0.95)
					f200_arg0:registerEventHandler("transition_complete_keyframe", f200_local0)
				end
				f198_arg0.DoubleXPText:beginAnimation(200)
				f198_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f198_arg0.clipInterrupted)
				f198_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f199_local0)
			end
			f198_arg0.DoubleXPText:completeAnimation()
			f198_arg0.DoubleXPText.MatchText:completeAnimation()
			f198_arg0.DoubleXPText:setAlpha(0)
			f198_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0xDD7D8B6F4DC3660))
			f198_local0(f198_arg0.DoubleXPText)
			f198_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f198_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f198_arg0.clipFinished(f198_arg0.PrematchCountdown2xpBadge)
			local f198_local1 = function(f216_arg0)
				local f216_local0 = function(f217_arg0)
					local f217_local0 = function(f218_arg0)
						local f218_local0 = function(f219_arg0)
							local f219_local0 = function(f220_arg0)
								local f220_local0 = function(f221_arg0)
									local f221_local0 = function(f222_arg0)
										local f222_local0 = function(f223_arg0)
											local f223_local0 = function(f224_arg0)
												f224_arg0:beginAnimation(69, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
												f224_arg0:setAlpha(0)
												f224_arg0:registerEventHandler("transition_complete_keyframe", f198_arg0.clipFinished)
											end
											f223_arg0:beginAnimation(90, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
											f223_arg0:setAlpha(1)
											f223_arg0:registerEventHandler("transition_complete_keyframe", f223_local0)
										end
										f222_arg0:beginAnimation(90, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
										f222_arg0:setAlpha(0.2)
										f222_arg0:registerEventHandler("transition_complete_keyframe", f222_local0)
									end
									f221_arg0:beginAnimation(1160)
									f221_arg0:registerEventHandler("transition_complete_keyframe", f221_local0)
								end
								f220_arg0:beginAnimation(139, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
								f220_arg0:setAlpha(1)
								f220_arg0:registerEventHandler("transition_complete_keyframe", f220_local0)
							end
							f219_arg0:beginAnimation(110, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f219_arg0:setAlpha(0.2)
							f219_arg0:registerEventHandler("transition_complete_keyframe", f219_local0)
						end
						f218_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f218_arg0:setAlpha(1)
						f218_arg0:registerEventHandler("transition_complete_keyframe", f218_local0)
					end
					f217_arg0:beginAnimation(89)
					f217_arg0:setAlpha(0.2)
					f217_arg0:registerEventHandler("transition_complete_keyframe", f217_local0)
				end
				f198_arg0.PrematchCountdown2xpWeaponBadge:beginAnimation(40)
				f198_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(1)
				f198_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("interrupted_keyframe", f198_arg0.clipInterrupted)
				f198_arg0.PrematchCountdown2xpWeaponBadge:registerEventHandler("transition_complete_keyframe", f216_local0)
			end
			f198_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f198_arg0.PrematchCountdown2xpWeaponBadge:setLeftRight(0.5, 0.5, -96, 96)
			f198_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f198_local1(f198_arg0.PrematchCountdown2xpWeaponBadge)
		end,
	},
	NP = {
		DefaultClip = function(f225_arg0, f225_arg1)
			f225_arg0:__resetProperties()
			f225_arg0:setupElementClipCounter(3)
			f225_arg0.DoubleXPText:completeAnimation()
			f225_arg0.DoubleXPText.MatchText:completeAnimation()
			f225_arg0.DoubleXPText:setAlpha(0)
			f225_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x9E4493BF47FD4A1))
			f225_arg0.clipFinished(f225_arg0.DoubleXPText)
			f225_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f225_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f225_arg0.clipFinished(f225_arg0.PrematchCountdown2xpBadge)
			f225_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f225_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f225_arg0.clipFinished(f225_arg0.PrematchCountdown2xpWeaponBadge)
		end,
		Notify = function(f226_arg0, f226_arg1)
			f226_arg0:__resetProperties()
			f226_arg0:setupElementClipCounter(4)
			local f226_local0 = function(f227_arg0)
				local f227_local0 = function(f228_arg0)
					local f228_local0 = function(f229_arg0)
						local f229_local0 = function(f230_arg0)
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
																				f243_arg0:beginAnimation(189)
																				f243_arg0:setAlpha(0)
																				f243_arg0:registerEventHandler("transition_complete_keyframe", f226_arg0.clipFinished)
																			end
																			f242_arg0:beginAnimation(19)
																			f242_arg0:setAlpha(0.45)
																			f242_arg0:registerEventHandler("transition_complete_keyframe", f242_local0)
																		end
																		f241_arg0:beginAnimation(19)
																		f241_arg0:setAlpha(0.34)
																		f241_arg0:registerEventHandler("transition_complete_keyframe", f241_local0)
																	end
																	f240_arg0:beginAnimation(70)
																	f240_arg0:setAlpha(0.55)
																	f240_arg0:registerEventHandler("transition_complete_keyframe", f240_local0)
																end
																f239_arg0:beginAnimation(19)
																f239_arg0:setAlpha(0.71)
																f239_arg0:registerEventHandler("transition_complete_keyframe", f239_local0)
															end
															f238_arg0:beginAnimation(29)
															f238_arg0:setAlpha(0.44)
															f238_arg0:registerEventHandler("transition_complete_keyframe", f238_local0)
														end
														f237_arg0:beginAnimation(70)
														f237_arg0:setAlpha(0.83)
														f237_arg0:registerEventHandler("transition_complete_keyframe", f237_local0)
													end
													f236_arg0:beginAnimation(1150)
													f236_arg0:registerEventHandler("transition_complete_keyframe", f236_local0)
												end
												f235_arg0:beginAnimation(9)
												f235_arg0:setAlpha(1)
												f235_arg0:registerEventHandler("transition_complete_keyframe", f235_local0)
											end
											f234_arg0:beginAnimation(20)
											f234_arg0:registerEventHandler("transition_complete_keyframe", f234_local0)
										end
										f233_arg0:beginAnimation(9)
										f233_arg0:setAlpha(0.76)
										f233_arg0:registerEventHandler("transition_complete_keyframe", f233_local0)
									end
									f232_arg0:beginAnimation(39)
									f232_arg0:registerEventHandler("transition_complete_keyframe", f232_local0)
								end
								f231_arg0:beginAnimation(10)
								f231_arg0:setAlpha(1)
								f231_arg0:registerEventHandler("transition_complete_keyframe", f231_local0)
							end
							f230_arg0:beginAnimation(19)
							f230_arg0:registerEventHandler("transition_complete_keyframe", f230_local0)
						end
						f229_arg0:beginAnimation(9)
						f229_arg0:setAlpha(0.45)
						f229_arg0:registerEventHandler("transition_complete_keyframe", f229_local0)
					end
					f228_arg0:beginAnimation(160)
					f228_arg0:setAlpha(0.95)
					f228_arg0:registerEventHandler("transition_complete_keyframe", f228_local0)
				end
				f226_arg0.DoubleXPText:beginAnimation(200)
				f226_arg0.DoubleXPText:registerEventHandler("interrupted_keyframe", f226_arg0.clipInterrupted)
				f226_arg0.DoubleXPText:registerEventHandler("transition_complete_keyframe", f227_local0)
			end
			f226_arg0.DoubleXPText:completeAnimation()
			f226_arg0.DoubleXPText.MatchText:completeAnimation()
			f226_arg0.DoubleXPText:setAlpha(0)
			f226_arg0.DoubleXPText.MatchText:setText(Engine[0xF9F1239CFD921FE](0x9E4493BF47FD4A1))
			f226_local0(f226_arg0.DoubleXPText)
			f226_arg0.PrematchCountdown2xpBadge:completeAnimation()
			f226_arg0.PrematchCountdown2xpBadge:setAlpha(0)
			f226_arg0.clipFinished(f226_arg0.PrematchCountdown2xpBadge)
			f226_arg0.PrematchCountdown2xpWeaponBadge:completeAnimation()
			f226_arg0.PrematchCountdown2xpWeaponBadge:setAlpha(0)
			f226_arg0.clipFinished(f226_arg0.PrematchCountdown2xpWeaponBadge)
			local f226_local1 = function(f244_arg0)
				local f244_local0 = function(f245_arg0)
					local f245_local0 = function(f246_arg0)
						local f246_local0 = function(f247_arg0)
							local f247_local0 = function(f248_arg0)
								local f248_local0 = function(f249_arg0)
									local f249_local0 = function(f250_arg0)
										local f250_local0 = function(f251_arg0)
											local f251_local0 = function(f252_arg0)
												f252_arg0:beginAnimation(69)
												f252_arg0:setAlpha(0)
												f252_arg0:registerEventHandler("transition_complete_keyframe", f226_arg0.clipFinished)
											end
											f251_arg0:beginAnimation(90)
											f251_arg0:setAlpha(1)
											f251_arg0:registerEventHandler("transition_complete_keyframe", f251_local0)
										end
										f250_arg0:beginAnimation(90)
										f250_arg0:setAlpha(0.2)
										f250_arg0:registerEventHandler("transition_complete_keyframe", f250_local0)
									end
									f249_arg0:beginAnimation(1160)
									f249_arg0:registerEventHandler("transition_complete_keyframe", f249_local0)
								end
								f248_arg0:beginAnimation(139)
								f248_arg0:setAlpha(1)
								f248_arg0:registerEventHandler("transition_complete_keyframe", f248_local0)
							end
							f247_arg0:beginAnimation(110)
							f247_arg0:setAlpha(0.2)
							f247_arg0:registerEventHandler("transition_complete_keyframe", f247_local0)
						end
						f246_arg0:beginAnimation(100)
						f246_arg0:setAlpha(1)
						f246_arg0:registerEventHandler("transition_complete_keyframe", f246_local0)
					end
					f245_arg0:beginAnimation(89)
					f245_arg0:setAlpha(0.2)
					f245_arg0:registerEventHandler("transition_complete_keyframe", f245_local0)
				end
				f226_arg0.ZMDoubleNPWidget:beginAnimation(40)
				f226_arg0.ZMDoubleNPWidget:setAlpha(1)
				f226_arg0.ZMDoubleNPWidget:registerEventHandler("interrupted_keyframe", f226_arg0.clipInterrupted)
				f226_arg0.ZMDoubleNPWidget:registerEventHandler("transition_complete_keyframe", f244_local0)
			end
			f226_arg0.ZMDoubleNPWidget:completeAnimation()
			f226_arg0.ZMDoubleNPWidget:setLeftRight(0, 0, 104, 296)
			f226_arg0.ZMDoubleNPWidget:setAlpha(0)
			f226_local1(f226_arg0.ZMDoubleNPWidget)
		end,
	},
}
CoD.PrematchCountdown_2xpNotificationZM.__onClose = function(f253_arg0)
	f253_arg0.DoubleXPText:close()
	f253_arg0.PrematchCountdown2xpBadge:close()
	f253_arg0.PrematchCountdown2xpWeaponBadge:close()
	f253_arg0.ZMDoubleNPWidget:close()
end
