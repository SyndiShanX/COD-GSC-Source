require("x64:c33c440fae6bf85")
require("x64:3317d177bae2759")
require("x64:9e7be51d884ab71")
require("x64:3634797dcb3880a")
require("x64:59770670213dba2")
CoD.PrematchCountdown = InheritFrom(LUI.UIElement)
CoD.PrematchCountdown.__defaultWidth = 1920
CoD.PrematchCountdown.__defaultHeight = 1080
CoD.PrematchCountdown.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PrematchCountdown)
	self.id = "PrematchCountdown"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowPanel = CoD.PrematchCountdown_IconGlowPanel.new(f1_arg0, f1_arg1, 0, 0, 743, 1182, 0, 0, -37, 402)
	GlowPanel:setAlpha(0)
	self:addElement(GlowPanel)
	self.GlowPanel = GlowPanel
	local PrematchCountdownNumbers = CoD.PrematchCountdown_Numbers.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -45, 30)
	PrematchCountdownNumbers:setAlpha(0)
	PrematchCountdownNumbers:subscribeToGlobalModel(f1_arg1, "GameScore", "roundsPlayed", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PrematchCountdownNumbers.MatchText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.HUDUtility.MatchOrRoundBeginsIn(f2_local0)))
		end
	end)
	self.__on_menuOpened_PrematchCountdownNumbers = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = PrematchCountdownNumbers
		PlayClipOnElement(self, {
			elementName = "PrematchCountdownNumbers",
			clipName = "Start",
		}, f3_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_PrematchCountdownNumbers)
	self:addElement(PrematchCountdownNumbers)
	self.PrematchCountdownNumbers = PrematchCountdownNumbers
	local FactionIcon0 = LUI.UIImage.new(0, 0, 866, 1058, 0, 0, 54, 246)
	FactionIcon0:setRGB(0, 0, 0)
	FactionIcon0:setAlpha(0)
	FactionIcon0:subscribeToGlobalModel(f1_arg1, "Factions", "playerFactionIcon", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			FactionIcon0:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(FactionIcon0)
	self.FactionIcon0 = FactionIcon0
	local FactionIcon = LUI.UIImage.new(0, 0, 866, 1058, 0, 0, 54, 246)
	FactionIcon:setAlpha(0)
	FactionIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	FactionIcon:subscribeToGlobalModel(f1_arg1, "Factions", "playerFactionIcon", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			FactionIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(FactionIcon)
	self.FactionIcon = FactionIcon
	local GameTypeIcon = LUI.UIImage.new(0, 0, 864, 1056, 0, 0, 73, 265)
	GameTypeIcon:setAlpha(0)
	self:addElement(GameTypeIcon)
	self.GameTypeIcon = GameTypeIcon
	local GameTypeHintText = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -280, 276, 0, 0, 305, 353)
	GameTypeHintText:setAlpha(0)
	GameTypeHintText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_17E04861C952E4AB"))
	GameTypeHintText.MatchText:setBackingAlpha(0.7)
	self:addElement(GameTypeHintText)
	self.GameTypeHintText = GameTypeHintText
	local FactionName = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -351, 327, 0.5, 0.5, -259, -211)
	FactionName:setAlpha(0)
	FactionName.MatchText:setText(LocalizeToUpperString(@"hash_18E58CC95DB34427"))
	self:addElement(FactionName)
	self.FactionName = FactionName
	local Sound = LUI.UIElement.new(0, 0, -87, -15, 0, 0, 73, 142)
	self:addElement(Sound)
	self.Sound = Sound
	local DoubleLoot = CoD.DoubleLoot.new(f1_arg0, f1_arg1, 0, 0, 898, 1018, 0, 0, 109, 229)
	DoubleLoot:setAlpha(0)
	DoubleLoot:setScale(1.5, 1.5)
	self:addElement(DoubleLoot)
	self.DoubleLoot = DoubleLoot
	local DoubleXPNotification = CoD.PrematchCountdown_2xpNotification.new(f1_arg0, f1_arg1, 0.5, 0.5, -200, 200, 0, 0, 0, 255)
	DoubleXPNotification:setAlpha(0)
	self:addElement(DoubleXPNotification)
	self.DoubleXPNotification = DoubleXPNotification
	self:mergeStateConditions({
		{
			stateName = "Codcaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["factions.isCoDCaster"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_PrematchCountdownNumbers)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	CoD.HUDUtility.PrematchCountdownPostLoad(self, f1_arg1)
	return self
end
CoD.PrematchCountdown.__resetProperties = function(f9_arg0)
	f9_arg0.PrematchCountdownNumbers:completeAnimation()
	f9_arg0.GameTypeHintText:completeAnimation()
	f9_arg0.FactionIcon:completeAnimation()
	f9_arg0.FactionName:completeAnimation()
	f9_arg0.FactionIcon0:completeAnimation()
	f9_arg0.Sound:completeAnimation()
	f9_arg0.GameTypeIcon:completeAnimation()
	f9_arg0.DoubleXPNotification:completeAnimation()
	f9_arg0.DoubleLoot:completeAnimation()
	f9_arg0.PrematchCountdownNumbers:setAlpha(0)
	f9_arg0.GameTypeHintText:setLeftRight(0.5, 0.5, -280, 276)
	f9_arg0.GameTypeHintText:setTopBottom(0, 0, 305, 353)
	f9_arg0.GameTypeHintText:setAlpha(0)
	f9_arg0.FactionIcon:setAlpha(0)
	f9_arg0.FactionName:setLeftRight(0.5, 0.5, -351, 327)
	f9_arg0.FactionName:setTopBottom(0.5, 0.5, -259, -211)
	f9_arg0.FactionName:setAlpha(0)
	f9_arg0.FactionIcon0:setAlpha(0)
	f9_arg0.GameTypeIcon:setAlpha(0)
	f9_arg0.DoubleXPNotification:setAlpha(0)
	f9_arg0.DoubleLoot:setAlpha(0)
end
CoD.PrematchCountdown.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.PrematchCountdownNumbers:completeAnimation()
			f10_arg0.PrematchCountdownNumbers:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.PrematchCountdownNumbers)
			f10_arg0.GameTypeHintText:completeAnimation()
			f10_arg0.GameTypeHintText:setLeftRight(0.5, 0.5, -221.5, 221.5)
			f10_arg0.GameTypeHintText:setTopBottom(0, 0, 305, 353)
			f10_arg0.clipFinished(f10_arg0.GameTypeHintText)
		end,
		Start = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			local f11_local0 = function(f12_arg0)
				f11_arg0.PrematchCountdownNumbers:beginAnimation(1000)
				f11_arg0.PrematchCountdownNumbers:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.PrematchCountdownNumbers:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.PrematchCountdownNumbers:completeAnimation()
			f11_arg0.PrematchCountdownNumbers:setAlpha(1)
			f11_local0(f11_arg0.PrematchCountdownNumbers)
			f11_arg0.FactionIcon0:completeAnimation()
			f11_arg0.FactionIcon0:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.FactionIcon0)
			f11_arg0.FactionIcon:completeAnimation()
			f11_arg0.FactionIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.FactionIcon)
			f11_arg0.FactionName:completeAnimation()
			f11_arg0.FactionName:setLeftRight(0.5, 0.5, -321, 357)
			f11_arg0.FactionName:setTopBottom(0.5, 0.5, -260, -212)
			f11_arg0.FactionName:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.FactionName)
			f11_arg0.Sound:completeAnimation()
			f11_arg0.Sound:playSound("faction_in", f11_arg1)
			f11_arg0.clipFinished(f11_arg0.Sound)
		end,
		Stop = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(50)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.PrematchCountdownNumbers:beginAnimation(700)
				f13_arg0.PrematchCountdownNumbers:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.PrematchCountdownNumbers:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.PrematchCountdownNumbers:completeAnimation()
			f13_arg0.PrematchCountdownNumbers:setAlpha(1)
			f13_local0(f13_arg0.PrematchCountdownNumbers)
			f13_arg0.FactionIcon0:completeAnimation()
			f13_arg0.FactionIcon0:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FactionIcon0)
			f13_arg0.FactionIcon:completeAnimation()
			f13_arg0.FactionIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FactionIcon)
			f13_arg0.FactionName:completeAnimation()
			f13_arg0.FactionName:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FactionName)
			f13_arg0.Sound:completeAnimation()
			f13_arg0.Sound:playSound("faction_out", f13_arg1)
			f13_arg0.clipFinished(f13_arg0.Sound)
		end,
		ShowObjectiveHint = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.GameTypeIcon:completeAnimation()
			f16_arg0.GameTypeIcon:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.GameTypeIcon)
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
																	local f30_local0 = function(f31_arg0)
																		local f31_local0 = function(f32_arg0)
																			local f32_local0 = function(f33_arg0)
																				local f33_local0 = function(f34_arg0)
																					local f34_local0 = function(f35_arg0)
																						local f35_local0 = function(f36_arg0)
																							local f36_local0 = function(f37_arg0)
																								local f37_local0 = function(f38_arg0)
																									f38_arg0:beginAnimation(299)
																									f38_arg0:setAlpha(0)
																									f38_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
																								end
																								f37_arg0:beginAnimation(20)
																								f37_arg0:setAlpha(0.32)
																								f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
																							end
																							f36_arg0:beginAnimation(49)
																							f36_arg0:setAlpha(0.13)
																							f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
																						end
																						f35_arg0:beginAnimation(240)
																						f35_arg0:setAlpha(0.39)
																						f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
																					end
																					f34_arg0:beginAnimation(29)
																					f34_arg0:setAlpha(0.64)
																					f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
																				end
																				f33_arg0:beginAnimation(30)
																				f33_arg0:setAlpha(0.35)
																				f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
																			end
																			f32_arg0:beginAnimation(119)
																			f32_arg0:setAlpha(0.7)
																			f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
																		end
																		f31_arg0:beginAnimation(19)
																		f31_arg0:setAlpha(0.83)
																		f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
																	end
																	f30_arg0:beginAnimation(30)
																	f30_arg0:setAlpha(0.45)
																	f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
																end
																f29_arg0:beginAnimation(119)
																f29_arg0:setAlpha(0.88)
																f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
															end
															f28_arg0:beginAnimation(3270)
															f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
														end
														f27_arg0:beginAnimation(9)
														f27_arg0:setAlpha(1)
														f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
													end
													f26_arg0:beginAnimation(19)
													f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
												end
												f25_arg0:beginAnimation(9)
												f25_arg0:setAlpha(0.7)
												f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
											end
											f24_arg0:beginAnimation(30)
											f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
										end
										f23_arg0:beginAnimation(9)
										f23_arg0:setAlpha(1)
										f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
									end
									f22_arg0:beginAnimation(19)
									f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
								end
								f21_arg0:beginAnimation(9)
								f21_arg0:setAlpha(0.5)
								f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
							end
							f20_arg0:beginAnimation(20)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
						end
						f19_arg0:beginAnimation(9)
						f19_arg0:setAlpha(1)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(199)
					f18_arg0:setAlpha(0.57)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f16_arg0.GameTypeHintText:beginAnimation(490)
				f16_arg0.GameTypeHintText:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.GameTypeHintText:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f16_arg0.GameTypeHintText:completeAnimation()
			f16_arg0.GameTypeHintText:setAlpha(0)
			f16_local0(f16_arg0.GameTypeHintText)
			local f16_local1 = function(f39_arg0)
				f16_arg0.Sound:playSound("obj_in", f16_arg1)
				f16_arg0.Sound:beginAnimation(3950)
				f16_arg0.Sound:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Sound:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("obj_out", f16_arg1)
					f16_arg0.clipFinished(element, event)
				end)
			end
			f16_arg0.Sound:completeAnimation()
			f16_local1(f16_arg0.Sound)
			local f16_local2 = function(f41_arg0)
				f16_arg0.DoubleXPNotification:beginAnimation(900)
				f16_arg0.DoubleXPNotification:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.DoubleXPNotification:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playClip("Notify")
					f16_arg0.clipFinished(element, event)
				end)
			end
			f16_arg0.DoubleXPNotification:completeAnimation()
			f16_arg0.DoubleXPNotification:setAlpha(1)
			f16_local2(f16_arg0.DoubleXPNotification)
		end,
		ShowDoubleLootIcon = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(2)
			local f43_local0 = function(f44_arg0)
				f43_arg0.Sound:playSound("xp_in", f43_arg1)
				f43_arg0.Sound:beginAnimation(1450)
				f43_arg0.Sound:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.Sound:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("xp_out", f43_arg1)
					f43_arg0.clipFinished(element, event)
				end)
			end
			f43_arg0.Sound:completeAnimation()
			f43_local0(f43_arg0.Sound)
			local f43_local1 = function(f46_arg0)
				local f46_local0 = function(f47_arg0)
					local f47_local0 = function(f48_arg0)
						local f48_local0 = function(f49_arg0)
							local f49_local0 = function(f50_arg0)
								local f50_local0 = function(f51_arg0)
									local f51_local0 = function(f52_arg0)
										local f52_local0 = function(f53_arg0)
											local f53_local0 = function(f54_arg0)
												f54_arg0:beginAnimation(69, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
												f54_arg0:setAlpha(0)
												f54_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
											end
											f53_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
											f53_arg0:setAlpha(0.92)
											f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
										end
										f52_arg0:beginAnimation(90, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
										f52_arg0:setAlpha(0.13)
										f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
									end
									f51_arg0:beginAnimation(1160)
									f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
								end
								f50_arg0:beginAnimation(139, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
								f50_arg0:setAlpha(1)
								f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
							end
							f49_arg0:beginAnimation(110, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
							f49_arg0:setAlpha(0.25)
							f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
						end
						f48_arg0:beginAnimation(100, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_out"])
						f48_arg0:setAlpha(1)
						f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
					end
					f47_arg0:beginAnimation(89)
					f47_arg0:setAlpha(0.25)
					f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
				end
				f43_arg0.DoubleLoot:beginAnimation(40)
				f43_arg0.DoubleLoot:setAlpha(1)
				f43_arg0.DoubleLoot:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.DoubleLoot:registerEventHandler("transition_complete_keyframe", f46_local0)
			end
			f43_arg0.DoubleLoot:completeAnimation()
			f43_arg0.DoubleLoot:setAlpha(0)
			f43_local1(f43_arg0.DoubleLoot)
		end,
		ShowOnlyFactionInfo = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(4)
			local f55_local0 = function(f56_arg0)
				local f56_local0 = function(f57_arg0)
					local f57_local0 = function(f58_arg0)
						f58_arg0:beginAnimation(599)
						f58_arg0:setAlpha(0)
						f58_arg0:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
					end
					f57_arg0:beginAnimation(1840)
					f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
				end
				f55_arg0.FactionIcon0:beginAnimation(560)
				f55_arg0.FactionIcon0:setAlpha(1)
				f55_arg0.FactionIcon0:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.FactionIcon0:registerEventHandler("transition_complete_keyframe", f56_local0)
			end
			f55_arg0.FactionIcon0:completeAnimation()
			f55_arg0.FactionIcon0:setAlpha(0)
			f55_local0(f55_arg0.FactionIcon0)
			local f55_local1 = function(f59_arg0)
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
																				f75_arg0:beginAnimation(160)
																				f75_arg0:setAlpha(0)
																				f75_arg0:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
																			end
																			f74_arg0:beginAnimation(29)
																			f74_arg0:setAlpha(0.34)
																			f74_arg0:registerEventHandler("transition_complete_keyframe", f74_local0)
																		end
																		f73_arg0:beginAnimation(19)
																		f73_arg0:setAlpha(0.19)
																		f73_arg0:registerEventHandler("transition_complete_keyframe", f73_local0)
																	end
																	f72_arg0:beginAnimation(69)
																	f72_arg0:setAlpha(0.44)
																	f72_arg0:registerEventHandler("transition_complete_keyframe", f72_local0)
																end
																f71_arg0:beginAnimation(19)
																f71_arg0:setAlpha(0.58)
																f71_arg0:registerEventHandler("transition_complete_keyframe", f71_local0)
															end
															f70_arg0:beginAnimation(29)
															f70_arg0:setAlpha(0.35)
															f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
														end
														f69_arg0:beginAnimation(269)
														f69_arg0:setAlpha(0.68)
														f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
													end
													f68_arg0:beginAnimation(1840)
													f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
												end
												f67_arg0:beginAnimation(9)
												f67_arg0:setAlpha(1)
												f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
											end
											f66_arg0:beginAnimation(20)
											f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
										end
										f65_arg0:beginAnimation(9)
										f65_arg0:setAlpha(0.76)
										f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
									end
									f64_arg0:beginAnimation(29)
									f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
								end
								f63_arg0:beginAnimation(10)
								f63_arg0:setAlpha(1)
								f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
							end
							f62_arg0:beginAnimation(19)
							f62_arg0:setAlpha(0.41)
							f62_arg0:registerEventHandler("transition_complete_keyframe", f62_local0)
						end
						f61_arg0:beginAnimation(10)
						f61_arg0:setAlpha(0.4)
						f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
					end
					f60_arg0:beginAnimation(9)
					f60_arg0:setAlpha(0.87)
					f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
				end
				f55_arg0.FactionIcon:beginAnimation(440)
				f55_arg0.FactionIcon:setAlpha(0.57)
				f55_arg0.FactionIcon:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.FactionIcon:registerEventHandler("transition_complete_keyframe", f59_local0)
			end
			f55_arg0.FactionIcon:completeAnimation()
			f55_arg0.FactionIcon:setAlpha(0)
			f55_local1(f55_arg0.FactionIcon)
			local f55_local2 = function(f76_arg0)
				local f76_local0 = function(f77_arg0)
					local f77_local0 = function(f78_arg0)
						local f78_local0 = function(f79_arg0)
							local f79_local0 = function(f80_arg0)
								local f80_local0 = function(f81_arg0)
									local f81_local0 = function(f82_arg0)
										local f82_local0 = function(f83_arg0)
											local f83_local0 = function(f84_arg0)
												local f84_local0 = function(f85_arg0)
													local f85_local0 = function(f86_arg0)
														local f86_local0 = function(f87_arg0)
															local f87_local0 = function(f88_arg0)
																local f88_local0 = function(f89_arg0)
																	local f89_local0 = function(f90_arg0)
																		local f90_local0 = function(f91_arg0)
																			local f91_local0 = function(f92_arg0)
																				local f92_local0 = function(f93_arg0)
																					f93_arg0:beginAnimation(119)
																					f93_arg0:setAlpha(0)
																					f93_arg0:registerEventHandler("transition_complete_keyframe", f55_arg0.clipFinished)
																				end
																				f92_arg0:beginAnimation(20)
																				f92_arg0:setAlpha(0.21)
																				f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
																			end
																			f91_arg0:beginAnimation(19)
																			f91_arg0:setAlpha(0.02)
																			f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
																		end
																		f90_arg0:beginAnimation(199)
																		f90_arg0:setAlpha(0.28)
																		f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
																	end
																	f89_arg0:beginAnimation(19)
																	f89_arg0:setAlpha(0.63)
																	f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
																end
																f88_arg0:beginAnimation(20)
																f88_arg0:setAlpha(0.36)
																f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
															end
															f87_arg0:beginAnimation(139)
															f87_arg0:setAlpha(0.7)
															f87_arg0:registerEventHandler("transition_complete_keyframe", f87_local0)
														end
														f86_arg0:beginAnimation(39)
														f86_arg0:setAlpha(0.94)
														f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
													end
													f85_arg0:beginAnimation(1770)
													f85_arg0:setAlpha(1)
													f85_arg0:registerEventHandler("transition_complete_keyframe", f85_local0)
												end
												f84_arg0:beginAnimation(10)
												f84_arg0:setAlpha(0.64)
												f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
											end
											f83_arg0:beginAnimation(9)
											f83_arg0:setAlpha(1)
											f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
										end
										f82_arg0:beginAnimation(9)
										f82_arg0:setAlpha(0.64)
										f82_arg0:registerEventHandler("transition_complete_keyframe", f82_local0)
									end
									f81_arg0:beginAnimation(29)
									f81_arg0:registerEventHandler("transition_complete_keyframe", f81_local0)
								end
								f80_arg0:beginAnimation(10)
								f80_arg0:setAlpha(0.98)
								f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
							end
							f79_arg0:beginAnimation(19)
							f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
						end
						f78_arg0:beginAnimation(9)
						f78_arg0:setAlpha(0.41)
						f78_arg0:registerEventHandler("transition_complete_keyframe", f78_local0)
					end
					f77_arg0:beginAnimation(9)
					f77_arg0:setAlpha(0.85)
					f77_arg0:registerEventHandler("transition_complete_keyframe", f77_local0)
				end
				f55_arg0.FactionName:beginAnimation(550)
				f55_arg0.FactionName:setAlpha(0.45)
				f55_arg0.FactionName:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
				f55_arg0.FactionName:registerEventHandler("transition_complete_keyframe", f76_local0)
			end
			f55_arg0.FactionName:completeAnimation()
			f55_arg0.FactionName:setAlpha(0)
			f55_local2(f55_arg0.FactionName)
			local f55_local3 = function(f94_arg0)
				f94_arg0:playSound("faction_in", f55_arg1)
				f94_arg0:beginAnimation(2320)
				f94_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
					element:playSound("faction_out", f55_arg1)
					f55_arg0.clipFinished(element, event)
				end)
			end
			f55_arg0.Sound:beginAnimation(150)
			f55_arg0.Sound:registerEventHandler("interrupted_keyframe", f55_arg0.clipInterrupted)
			f55_arg0.Sound:registerEventHandler("transition_complete_keyframe", f55_local3)
		end,
	},
	Codcaster = {
		DefaultClip = function(f96_arg0, f96_arg1)
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.PrematchCountdown.__onClose = function(f97_arg0)
	f97_arg0.__on_close_removeOverrides()
	f97_arg0.GlowPanel:close()
	f97_arg0.PrematchCountdownNumbers:close()
	f97_arg0.FactionIcon0:close()
	f97_arg0.FactionIcon:close()
	f97_arg0.GameTypeHintText:close()
	f97_arg0.FactionName:close()
	f97_arg0.DoubleLoot:close()
	f97_arg0.DoubleXPNotification:close()
end
