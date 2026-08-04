CoD.CommonBgLayoutElement02 = InheritFrom(LUI.UIElement)
CoD.CommonBgLayoutElement02.__defaultWidth = 304
CoD.CommonBgLayoutElement02.__defaultHeight = 76
CoD.CommonBgLayoutElement02.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonBgLayoutElement02)
	self.id = "CommonBgLayoutElement02"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlurBgBoxes02 = LUI.UIImage.new(0, 0, 0, 304, 0, 0, 0, 76)
	BlurBgBoxes02:setAlpha(0.5)
	BlurBgBoxes02:setImage(RegisterImage("uie_ui_menu_inspection_bg_element_boxes01"))
	BlurBgBoxes02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	BlurBgBoxes02:setShaderVector(0, 4, 1, 0, 0)
	BlurBgBoxes02:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(BlurBgBoxes02)
	self.BlurBgBoxes02 = BlurBgBoxes02
	local BoxHighlighted2 = LUI.UIImage.new(0, 0, 40, 76, 0, 0, 1, 37)
	BoxHighlighted2:setAlpha(0.2)
	BoxHighlighted2:setImage(RegisterImage("uie_ui_menu_inspection_bg_element_box_selected"))
	BoxHighlighted2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BoxHighlighted2:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(BoxHighlighted2)
	self.BoxHighlighted2 = BoxHighlighted2
	local BoxHighlighted01 = LUI.UIImage.new(0, 0, 40, 76, 0, 0, 1, 37)
	BoxHighlighted01:setAlpha(0.2)
	BoxHighlighted01:setImage(RegisterImage("uie_ui_menu_inspection_bg_element_box_selected"))
	BoxHighlighted01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	BoxHighlighted01:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(BoxHighlighted01)
	self.BoxHighlighted01 = BoxHighlighted01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonBgLayoutElement02.__resetProperties = function(f2_arg0)
	f2_arg0.BlurBgBoxes02:completeAnimation()
	f2_arg0.BoxHighlighted01:completeAnimation()
	f2_arg0.BoxHighlighted2:completeAnimation()
	f2_arg0.BlurBgBoxes02:setAlpha(0.5)
	f2_arg0.BoxHighlighted01:setLeftRight(0, 0, 40, 76)
	f2_arg0.BoxHighlighted01:setTopBottom(0, 0, 1, 37)
	f2_arg0.BoxHighlighted01:setAlpha(0.2)
	f2_arg0.BoxHighlighted2:setLeftRight(0, 0, 40, 76)
	f2_arg0.BoxHighlighted2:setTopBottom(0, 0, 1, 37)
	f2_arg0.BoxHighlighted2:setAlpha(0.2)
end
CoD.CommonBgLayoutElement02.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				f3_arg0.BlurBgBoxes02:beginAnimation(4000)
				f3_arg0.BlurBgBoxes02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BlurBgBoxes02:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.BlurBgBoxes02:completeAnimation()
			f3_arg0.BlurBgBoxes02:setAlpha(0.5)
			f3_local0(f3_arg0.BlurBgBoxes02)
			local f3_local1 = function(f5_arg0)
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
																				f21_arg0:beginAnimation(1500)
																				f21_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																			end
																			f20_arg0:beginAnimation(600)
																			f20_arg0:setLeftRight(0, 0, 40, 76)
																			f20_arg0:setTopBottom(0, 0, 1, 37)
																			f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
																		end
																		f19_arg0:beginAnimation(199)
																		f19_arg0:setAlpha(0)
																		f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																	end
																	f18_arg0:beginAnimation(199)
																	f18_arg0:setAlpha(0.08)
																	f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																end
																f17_arg0:beginAnimation(3000)
																f17_arg0:setLeftRight(0, 0, 77, 113)
																f17_arg0:setTopBottom(0, 0, 38, 74)
																f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
															end
															f16_arg0:beginAnimation(199)
															f16_arg0:setAlpha(0)
															f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
														end
														f15_arg0:beginAnimation(200)
														f15_arg0:setAlpha(0.04)
														f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
													end
													f14_arg0:beginAnimation(2199)
													f14_arg0:setLeftRight(0, 0, 268, 304)
													f14_arg0:setTopBottom(0, 0, 1, 37)
													f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
												end
												f13_arg0:beginAnimation(200)
												f13_arg0:setAlpha(0)
												f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
											end
											f12_arg0:beginAnimation(200)
											f12_arg0:setAlpha(0.11)
											f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
										end
										f11_arg0:beginAnimation(599)
										f11_arg0:setLeftRight(0, 0, 153, 189)
										f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
									end
									f10_arg0:beginAnimation(200)
									f10_arg0:setAlpha(0)
									f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
								end
								f9_arg0:beginAnimation(200)
								f9_arg0:setAlpha(0.08)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
							end
							f8_arg0:beginAnimation(1500)
							f8_arg0:setLeftRight(0, 0, 115, 151)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:beginAnimation(199)
						f7_arg0:setTopBottom(0, 0, 38, 74)
						f7_arg0:setAlpha(0)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(200)
					f6_arg0:setTopBottom(0, 0, 40, 76)
					f6_arg0:setAlpha(0.1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f3_arg0.BoxHighlighted2:beginAnimation(100)
				f3_arg0.BoxHighlighted2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BoxHighlighted2:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f3_arg0.BoxHighlighted2:completeAnimation()
			f3_arg0.BoxHighlighted2:setLeftRight(0, 0, 193, 229)
			f3_arg0.BoxHighlighted2:setTopBottom(0, 0, 38, 74)
			f3_arg0.BoxHighlighted2:setAlpha(0)
			f3_local1(f3_arg0.BoxHighlighted2)
			local f3_local2 = function(f22_arg0)
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
																			f37_arg0:beginAnimation(1500)
																			f37_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																		end
																		f36_arg0:beginAnimation(399)
																		f36_arg0:setLeftRight(0, 0, 40, 76)
																		f36_arg0:setTopBottom(0, 0, 1, 37)
																		f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
																	end
																	f35_arg0:beginAnimation(200)
																	f35_arg0:setAlpha(0)
																	f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
																end
																f34_arg0:beginAnimation(199)
																f34_arg0:setAlpha(0.08)
																f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
															end
															f33_arg0:beginAnimation(3199)
															f33_arg0:setLeftRight(0, 0, 39, 75)
															f33_arg0:setTopBottom(0, 0, 38, 74)
															f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
														end
														f32_arg0:beginAnimation(199)
														f32_arg0:setAlpha(0)
														f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
													end
													f31_arg0:beginAnimation(200)
													f31_arg0:setAlpha(0.04)
													f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
												end
												f30_arg0:beginAnimation(199)
												f30_arg0:setLeftRight(0, 0, 152, 188)
												f30_arg0:setTopBottom(0, 0, 39, 75)
												f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
											end
											f29_arg0:beginAnimation(200)
											f29_arg0:setAlpha(0)
											f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
										end
										f28_arg0:beginAnimation(199)
										f28_arg0:setAlpha(0.05)
										f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
									end
									f27_arg0:beginAnimation(2200)
									f27_arg0:setLeftRight(0, 0, 230, 266)
									f27_arg0:setTopBottom(0, 0, 1, 37)
									f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
								end
								f26_arg0:beginAnimation(200)
								f26_arg0:setAlpha(0)
								f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
							end
							f25_arg0:beginAnimation(199)
							f25_arg0:setAlpha(0.08)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
						end
						f24_arg0:beginAnimation(2000)
						f24_arg0:setLeftRight(0, 0, 153, 189)
						f24_arg0:setTopBottom(0, 0, 38, 74)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(200)
					f23_arg0:setAlpha(0)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f3_arg0.BoxHighlighted01:beginAnimation(200)
				f3_arg0.BoxHighlighted01:setAlpha(0.1)
				f3_arg0.BoxHighlighted01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BoxHighlighted01:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f3_arg0.BoxHighlighted01:completeAnimation()
			f3_arg0.BoxHighlighted01:setLeftRight(0, 0, 0, 36)
			f3_arg0.BoxHighlighted01:setTopBottom(0, 0, 1, 37)
			f3_arg0.BoxHighlighted01:setAlpha(0)
			f3_local2(f3_arg0.BoxHighlighted01)
			f3_arg0.nextClip = "DefaultClip"
		end,
		Intro = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(3)
			local f38_local0 = function(f39_arg0)
				f38_arg0.BlurBgBoxes02:beginAnimation(1000, Enum[@"luitween"][@"luitween_ease_both"])
				f38_arg0.BlurBgBoxes02:setAlpha(0.5)
				f38_arg0.BlurBgBoxes02:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.BlurBgBoxes02:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.BlurBgBoxes02:completeAnimation()
			f38_arg0.BlurBgBoxes02:setAlpha(0)
			f38_local0(f38_arg0.BlurBgBoxes02)
			f38_arg0.BoxHighlighted2:completeAnimation()
			f38_arg0.BoxHighlighted2:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.BoxHighlighted2)
			f38_arg0.BoxHighlighted01:completeAnimation()
			f38_arg0.BoxHighlighted01:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.BoxHighlighted01)
		end,
	},
}
