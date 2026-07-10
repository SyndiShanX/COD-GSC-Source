CoD.TabletIcePickGadget_BgElementFui2 = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget_BgElementFui2.__defaultWidth = 248
CoD.TabletIcePickGadget_BgElementFui2.__defaultHeight = 38
CoD.TabletIcePickGadget_BgElementFui2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget_BgElementFui2)
	self.id = "TabletIcePickGadget_BgElementFui2"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ConnectedText = LUI.UIImage.new(0, 0, 11.5, 111.5, 0, 0, 6, 38)
	ConnectedText:setRGB(0.22, 0.77, 1)
	ConnectedText:setAlpha(0.5)
	ConnectedText:setImage(RegisterImage(@"uie_ui_menu_inspection_connected_text"))
	ConnectedText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ConnectedText:setShaderVector(0, 1.62, 0, 0, 0)
	self:addElement(ConnectedText)
	self.ConnectedText = ConnectedText
	local AnalysingBacking = LUI.UIImage.new(0, 0, 0, 248, 0, 0, 0, 28)
	AnalysingBacking:setRGB(0.02, 0.82, 0.99)
	AnalysingBacking:setImage(RegisterImage(@"uie_ui_menu_inspection_analysing_stripe"))
	self:addElement(AnalysingBacking)
	self.AnalysingBacking = AnalysingBacking
	local AnalysingBackingAdd = LUI.UIImage.new(0, 0, 0, 248, 0, 0, 0, 28)
	AnalysingBackingAdd:setRGB(0.02, 0.59, 0.99)
	AnalysingBackingAdd:setImage(RegisterImage(@"uie_ui_menu_inspection_analysing_stripe"))
	self:addElement(AnalysingBackingAdd)
	self.AnalysingBackingAdd = AnalysingBackingAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePickGadget_BgElementFui2.__resetProperties = function(f2_arg0)
	f2_arg0.AnalysingBacking:completeAnimation()
	f2_arg0.ConnectedText:completeAnimation()
	f2_arg0.AnalysingBackingAdd:completeAnimation()
	f2_arg0.AnalysingBacking:setAlpha(1)
	f2_arg0.AnalysingBacking:setZoom(0)
	f2_arg0.ConnectedText:setLeftRight(0, 0, 11.5, 111.5)
	f2_arg0.ConnectedText:setAlpha(0.5)
	f2_arg0.AnalysingBackingAdd:setAlpha(1)
end
CoD.TabletIcePickGadget_BgElementFui2.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
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
																					f21_arg0:beginAnimation(600)
																					f21_arg0:setAlpha(0.5)
																					f21_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																				end
																				f20_arg0:beginAnimation(189)
																				f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
																			end
																			f19_arg0:beginAnimation(30)
																			f19_arg0:setAlpha(1)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																		end
																		f18_arg0:beginAnimation(29)
																		f18_arg0:setAlpha(0)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(29)
																	f17_arg0:setAlpha(1)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(29)
																f16_arg0:setAlpha(0)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(30)
															f15_arg0:setAlpha(1)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(29)
														f14_arg0:setAlpha(0)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(29)
													f13_arg0:setAlpha(0.5)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(600)
												f12_arg0:setAlpha(0)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(219)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(30)
										f10_arg0:setAlpha(1)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(29)
									f9_arg0:setAlpha(0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(30)
								f8_arg0:setAlpha(1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(29)
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(30)
						f6_arg0:setAlpha(1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(29)
					f5_arg0:setAlpha(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.ConnectedText:beginAnimation(500)
				f3_arg0.ConnectedText:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ConnectedText:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ConnectedText:completeAnimation()
			f3_arg0.ConnectedText:setAlpha(0.5)
			f3_local0(f3_arg0.ConnectedText)
			local f3_local1 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						f24_arg0:beginAnimation(1000)
						f24_arg0:setZoom(0)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f23_arg0:beginAnimation(1000)
					f23_arg0:setZoom(30)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f3_arg0.AnalysingBacking:beginAnimation(500)
				f3_arg0.AnalysingBacking:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.AnalysingBacking:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f3_arg0.AnalysingBacking:completeAnimation()
			f3_arg0.AnalysingBacking:setAlpha(1)
			f3_arg0.AnalysingBacking:setZoom(0)
			f3_local1(f3_arg0.AnalysingBacking)
			local f3_local2 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						f27_arg0:beginAnimation(1000)
						f27_arg0:setAlpha(0.5)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f26_arg0:beginAnimation(1000)
					f26_arg0:setAlpha(0.8)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f3_arg0.AnalysingBackingAdd:beginAnimation(500)
				f3_arg0.AnalysingBackingAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.AnalysingBackingAdd:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f3_arg0.AnalysingBackingAdd:completeAnimation()
			f3_arg0.AnalysingBackingAdd:setAlpha(0.5)
			f3_local2(f3_arg0.AnalysingBackingAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
		Intro = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(3)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						local f31_local0 = function(f32_arg0)
							f32_arg0:beginAnimation(309)
							f32_arg0:setAlpha(0.5)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
						end
						f31_arg0:beginAnimation(90)
						f31_arg0:setAlpha(1)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
					f30_arg0:setLeftRight(0, 0, 11.5, 111.5)
					f30_arg0:setAlpha(0.77)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f28_arg0.ConnectedText:beginAnimation(1300)
				f28_arg0.ConnectedText:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ConnectedText:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.ConnectedText:completeAnimation()
			f28_arg0.ConnectedText:setLeftRight(0, 0, 300, 400)
			f28_arg0.ConnectedText:setAlpha(0)
			f28_local0(f28_arg0.ConnectedText)
			local f28_local1 = function(f33_arg0)
				f28_arg0.AnalysingBacking:beginAnimation(1000)
				f28_arg0.AnalysingBacking:setAlpha(1)
				f28_arg0.AnalysingBacking:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.AnalysingBacking:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.AnalysingBacking:completeAnimation()
			f28_arg0.AnalysingBacking:setAlpha(0)
			f28_local1(f28_arg0.AnalysingBacking)
			local f28_local2 = function(f34_arg0)
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
														f44_arg0:beginAnimation(600)
														f44_arg0:setAlpha(0.5)
														f44_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
													end
													f43_arg0:beginAnimation(130)
													f43_arg0:setAlpha(1)
													f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
												end
												f42_arg0:beginAnimation(49)
												f42_arg0:setAlpha(0)
												f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
											end
											f41_arg0:beginAnimation(40)
											f41_arg0:setAlpha(1)
											f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
										end
										f40_arg0:beginAnimation(29)
										f40_arg0:setAlpha(0)
										f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
									end
									f39_arg0:beginAnimation(29)
									f39_arg0:setAlpha(1)
									f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
								end
								f38_arg0:beginAnimation(29)
								f38_arg0:setAlpha(0)
								f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
							end
							f37_arg0:beginAnimation(30)
							f37_arg0:setAlpha(1)
							f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
						end
						f36_arg0:beginAnimation(29)
						f36_arg0:setAlpha(0)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
					end
					f35_arg0:beginAnimation(29)
					f35_arg0:setAlpha(1)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f28_arg0.AnalysingBackingAdd:beginAnimation(1000)
				f28_arg0.AnalysingBackingAdd:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.AnalysingBackingAdd:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f28_arg0.AnalysingBackingAdd:completeAnimation()
			f28_arg0.AnalysingBackingAdd:setAlpha(0)
			f28_local2(f28_arg0.AnalysingBackingAdd)
		end,
	},
}
