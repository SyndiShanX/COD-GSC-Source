require("x64:e201e7e41431aa7")
CoD.ContextNotification_HealNag = InheritFrom(LUI.UIElement)
CoD.ContextNotification_HealNag.__defaultWidth = 300
CoD.ContextNotification_HealNag.__defaultHeight = 39
CoD.ContextNotification_HealNag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContextNotification_HealNag)
	self.id = "ContextNotification_HealNag"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NotificationText = LUI.UIText.new(0, 0, 0, 300, 0, 0, 0, 30)
	NotificationText:setText(Engine[0xF9F1239CFD921FE](0xF4432A789BDCA7C))
	NotificationText:setTTF("ttmussels_regular")
	NotificationText:setLetterSpacing(1)
	NotificationText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NotificationText:setBackingType(1)
	NotificationText:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationText:setBackingColor(0, 0, 0)
	NotificationText:setBackingAlpha(0.62)
	NotificationText:setBackingXPadding(12)
	LUI.OverrideFunction_CallOriginalFirst(NotificationText, "setText", function(element, controller) end)
	self:addElement(NotificationText)
	self.NotificationText = NotificationText
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.playerIsShocked", 0)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["hudItems.playerIsShocked"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.playerIsShocked",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	CoD.NotificationUtility.InitHealNagNotification(self, f1_arg1)
	return self
end
CoD.ContextNotification_HealNag.__resetProperties = function(f5_arg0)
	f5_arg0.NotificationText:completeAnimation()
	f5_arg0.NotificationText:setRGB(1, 1, 1)
	f5_arg0.NotificationText:setAlpha(1)
	f5_arg0.NotificationText:setBackingAlpha(0.62)
end
CoD.ContextNotification_HealNag.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.NotificationText:completeAnimation()
			f6_arg0.NotificationText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.NotificationText)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.NotificationText:completeAnimation()
			f7_arg0.NotificationText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.NotificationText)
		end,
		FirstPromptDelay = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.NotificationText:beginAnimation(3000)
				f8_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.NotificationText:completeAnimation()
			f8_arg0.NotificationText:setAlpha(0)
			f8_local0(f8_arg0.NotificationText)
		end,
		FirstPrompt = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
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
																f23_arg0:beginAnimation(250, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																f23_arg0:setRGB(1, 1, 1)
																f23_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
															end
															f22_arg0:beginAnimation(250)
															f22_arg0:setRGB(1, 0.1, 0.1)
															f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
														end
														f21_arg0:beginAnimation(260)
														f21_arg0:setRGB(1, 1, 1)
														f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
													end
													f20_arg0:beginAnimation(240)
													f20_arg0:setRGB(1, 0.1, 0.1)
													f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
												end
												f19_arg0:beginAnimation(250)
												f19_arg0:setRGB(1, 1, 1)
												f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
											end
											f18_arg0:beginAnimation(250)
											f18_arg0:setRGB(1, 0.1, 0.1)
											f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
										end
										f17_arg0:beginAnimation(250)
										f17_arg0:setRGB(1, 1, 1)
										f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
									end
									f16_arg0:beginAnimation(250)
									f16_arg0:setRGB(1, 0.1, 0.1)
									f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
								end
								f15_arg0:beginAnimation(250)
								f15_arg0:setRGB(1, 1, 1)
								f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
							end
							f14_arg0:beginAnimation(250)
							f14_arg0:setRGB(1, 0.1, 0.1)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
						end
						f13_arg0:beginAnimation(250)
						f13_arg0:setRGB(1, 1, 1)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(49)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f10_arg0.NotificationText:beginAnimation(200)
				f10_arg0.NotificationText:setAlpha(1)
				f10_arg0.NotificationText:setBackingAlpha(0.9)
				f10_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.NotificationText:completeAnimation()
			f10_arg0.NotificationText:setRGB(1, 0.1, 0.1)
			f10_arg0.NotificationText:setAlpha(0)
			f10_arg0.NotificationText:setBackingAlpha(0.62)
			f10_local0(f10_arg0.NotificationText)
		end,
		FirstPromptOut = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						f27_arg0:beginAnimation(139)
						f27_arg0:setAlpha(0)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
					end
					f26_arg0:beginAnimation(179)
					f26_arg0:setAlpha(0.8)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f24_arg0.NotificationText:beginAnimation(200)
				f24_arg0.NotificationText:setAlpha(0.3)
				f24_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f24_arg0.NotificationText:completeAnimation()
			f24_arg0.NotificationText:setRGB(1, 0.1, 0.1)
			f24_arg0.NotificationText:setAlpha(1)
			f24_local0(f24_arg0.NotificationText)
		end,
		ExtraPromptDelay = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			local f28_local0 = function(f29_arg0)
				f28_arg0.NotificationText:beginAnimation(5000)
				f28_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.NotificationText:completeAnimation()
			f28_arg0.NotificationText:setAlpha(0)
			f28_local0(f28_arg0.NotificationText)
		end,
		ExtraPrompt = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						local f33_local0 = function(f34_arg0)
							local f34_local0 = function(f35_arg0)
								local f35_local0 = function(f36_arg0)
									local f36_local0 = function(f37_arg0)
										local f37_local0 = function(f38_arg0)
											local f38_local0 = function(f39_arg0)
												local f39_local0 = function(f40_arg0)
													local f40_local0 = function(f41_arg0)
														local f41_local0 = function(f42_arg0)
															local f42_local0 = function(f43_arg0)
																local f43_local0 = function(f44_arg0)
																	local f44_local0 = function(f45_arg0)
																		local f45_local0 = function(f46_arg0)
																			local f46_local0 = function(f47_arg0)
																				local f47_local0 = function(f48_arg0)
																					local f48_local0 = function(f49_arg0)
																						local f49_local0 = function(f50_arg0)
																							local f50_local0 = function(f51_arg0)
																								local f51_local0 = function(f52_arg0)
																									f52_arg0:beginAnimation(239)
																									f52_arg0:setRGB(1, 1, 1)
																									f52_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
																								end
																								f51_arg0:beginAnimation(260)
																								f51_arg0:setRGB(1, 0.1, 0.1)
																								f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
																							end
																							f50_arg0:beginAnimation(250)
																							f50_arg0:setRGB(1, 1, 1)
																							f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
																						end
																						f49_arg0:beginAnimation(250)
																						f49_arg0:setRGB(1, 0.1, 0.1)
																						f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
																					end
																					f48_arg0:beginAnimation(250)
																					f48_arg0:setRGB(1, 1, 1)
																					f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
																				end
																				f47_arg0:beginAnimation(250)
																				f47_arg0:setRGB(1, 0.1, 0.1)
																				f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
																			end
																			f46_arg0:beginAnimation(250)
																			f46_arg0:setRGB(1, 1, 1)
																			f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
																		end
																		f45_arg0:beginAnimation(250)
																		f45_arg0:setRGB(1, 0.1, 0.1)
																		f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
																	end
																	f44_arg0:beginAnimation(250)
																	f44_arg0:setRGB(1, 1, 1)
																	f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
																end
																f43_arg0:beginAnimation(250)
																f43_arg0:setRGB(1, 0.1, 0.1)
																f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
															end
															f42_arg0:beginAnimation(250)
															f42_arg0:setRGB(1, 1, 1)
															f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
														end
														f41_arg0:beginAnimation(250)
														f41_arg0:setRGB(1, 0.1, 0.1)
														f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
													end
													f40_arg0:beginAnimation(250)
													f40_arg0:setRGB(1, 1, 1)
													f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
												end
												f39_arg0:beginAnimation(250)
												f39_arg0:setRGB(1, 0.1, 0.1)
												f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
											end
											f38_arg0:beginAnimation(250)
											f38_arg0:setRGB(1, 1, 1)
											f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
										end
										f37_arg0:beginAnimation(260)
										f37_arg0:setRGB(1, 0.1, 0.1)
										f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
									end
									f36_arg0:beginAnimation(240)
									f36_arg0:setRGB(1, 1, 1)
									f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
								end
								f35_arg0:beginAnimation(250)
								f35_arg0:setRGB(1, 0.1, 0.1)
								f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
							end
							f34_arg0:beginAnimation(250)
							f34_arg0:setRGB(1, 1, 1)
							f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
						end
						f33_arg0:beginAnimation(250)
						f33_arg0:setRGB(1, 0.1, 0.1)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
					end
					f32_arg0:beginAnimation(49)
					f32_arg0:setRGB(1, 1, 1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f30_arg0.NotificationText:beginAnimation(200)
				f30_arg0.NotificationText:setRGB(1, 0.82, 0.82)
				f30_arg0.NotificationText:setAlpha(1)
				f30_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.NotificationText:completeAnimation()
			f30_arg0.NotificationText:setRGB(1, 0.1, 0.1)
			f30_arg0.NotificationText:setAlpha(0)
			f30_local0(f30_arg0.NotificationText)
		end,
		ExtraPromptOut = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(1)
			local f53_local0 = function(f54_arg0)
				local f54_local0 = function(f55_arg0)
					local f55_local0 = function(f56_arg0)
						f56_arg0:beginAnimation(139)
						f56_arg0:setAlpha(0)
						f56_arg0:registerEventHandler("transition_complete_keyframe", f53_arg0.clipFinished)
					end
					f55_arg0:beginAnimation(179)
					f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
				end
				f53_arg0.NotificationText:beginAnimation(200)
				f53_arg0.NotificationText:setAlpha(0.8)
				f53_arg0.NotificationText:registerEventHandler("interrupted_keyframe", f53_arg0.clipInterrupted)
				f53_arg0.NotificationText:registerEventHandler("transition_complete_keyframe", f54_local0)
			end
			f53_arg0.NotificationText:completeAnimation()
			f53_arg0.NotificationText:setRGB(1, 0.1, 0.1)
			f53_arg0.NotificationText:setAlpha(1)
			f53_local0(f53_arg0.NotificationText)
		end,
	},
}
