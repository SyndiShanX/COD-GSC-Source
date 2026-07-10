CoD[@"hash_28A9D1228888C8CB"] = InheritFrom(LUI.UIElement)
CoD[@"hash_28A9D1228888C8CB"].__defaultWidth = 960
CoD[@"hash_28A9D1228888C8CB"].__defaultHeight = 240
CoD[@"hash_28A9D1228888C8CB"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_28A9D1228888C8CB"])
	self.id = "CallingCards_Global_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local clouds = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	clouds:setImage(RegisterImage(@"uie_callingcards_global_master_clouds"))
	clouds:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	clouds:setShaderVector(0, 1, 1, 0, 0)
	clouds:setShaderVector(1, 0.02, 0, 0, 0)
	self:addElement(clouds)
	self.clouds = clouds
	local rocks = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	rocks:setImage(RegisterImage(@"uie_callingcards_global_master_rocks"))
	self:addElement(rocks)
	self.rocks = rocks
	local dragonWing = LUI.UIImage.new(0, 0, 320.5, 792.5, 0, 0, -8.5, 103.5)
	dragonWing:setImage(RegisterImage(@"uie_callingcards_global_master_dragonbackwing"))
	self:addElement(dragonWing)
	self.dragonWing = dragonWing
	local dragonbody = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	dragonbody:setImage(RegisterImage(@"uie_callingcards_global_master_dragonbody"))
	self:addElement(dragonbody)
	self.dragonbody = dragonbody
	local dragonneckStill = LUI.UIImage.new(0, 0, 502.5, 782.5, 0, 0, -3, 213)
	dragonneckStill:setImage(RegisterImage(@"uie_callingcards_global_master_placeholder_dragonneck_still"))
	self:addElement(dragonneckStill)
	self.dragonneckStill = dragonneckStill
	local dragonneckbackward2 = LUI.UIImage.new(0, 0, 507, 787, 0, 0, -3, 213)
	dragonneckbackward2:setImage(RegisterImage(@"uie_callingcards_global_master_placeholder_dragonneck_backward2"))
	self:addElement(dragonneckbackward2)
	self.dragonneckbackward2 = dragonneckbackward2
	local dragonneckbackward3 = LUI.UIImage.new(0, 0, 508, 788, 0, 0, 0, 216)
	dragonneckbackward3:setImage(RegisterImage(@"uie_callingcards_global_master_placeholder_dragonneck_backward3"))
	self:addElement(dragonneckbackward3)
	self.dragonneckbackward3 = dragonneckbackward3
	local dragonneckforward2 = LUI.UIImage.new(0, 0, 507, 787, 0, 0, 1, 217)
	dragonneckforward2:setImage(RegisterImage(@"uie_callingcards_global_master_placeholder_dragonneck_forward2"))
	self:addElement(dragonneckforward2)
	self.dragonneckforward2 = dragonneckforward2
	local dragonneckforward3 = LUI.UIImage.new(0, 0, 517.5, 797.5, 0, 0, 6.5, 222.5)
	dragonneckforward3:setImage(RegisterImage(@"uie_callingcards_global_master_placeholder_dragonneck_forward3"))
	self:addElement(dragonneckforward3)
	self.dragonneckforward3 = dragonneckforward3
	local dragonmouthOpen = LUI.UIImage.new(0, 0, 433.5, 713.5, 0, 0, -22, 218)
	dragonmouthOpen:setImage(RegisterImage(@"uie_callingcards_global_master_placeholder_dragonmouth_open"))
	self:addElement(dragonmouthOpen)
	self.dragonmouthOpen = dragonmouthOpen
	local dragonmouthMid = LUI.UIImage.new(0, 0, 437.5, 717.5, 0, 0, -27, 213)
	dragonmouthMid:setImage(RegisterImage(@"uie_callingcards_global_master_placeholder_dragonmouth_midopen"))
	self:addElement(dragonmouthMid)
	self.dragonmouthMid = dragonmouthMid
	local dragonmouthclosed = LUI.UIImage.new(0, 0, 437.5, 717.5, 0, 0, -22, 218)
	dragonmouthclosed:setImage(RegisterImage(@"uie_callingcards_global_master_placeholder_dragonmouth_closed"))
	self:addElement(dragonmouthclosed)
	self.dragonmouthclosed = dragonmouthclosed
	local mist = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	mist:setImage(RegisterImage(@"uie_ui_icon_callingcards_zm_elixirs_talismans_mist"))
	mist:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	mist:setShaderVector(0, 1, 1, 0, 0)
	mist:setShaderVector(1, -0.01, 0, 0, 0)
	self:addElement(mist)
	self.mist = mist
	local spotlightColor = LUI.UIImage.new(0, 0, -230, 821, 0, 0, 6.5, 518.5)
	spotlightColor:setRGB(0.98, 0.87, 0)
	spotlightColor:setImage(RegisterImage(@"uie_callingcards_global_master_spotlight"))
	spotlightColor:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(spotlightColor)
	self.spotlightColor = spotlightColor
	local fire = LUI.UIImage.new(0, 0, -364, 596, 0, 0, 171, 411)
	fire:setZRot(21)
	fire:setImage(RegisterImage(@"uie_callingcards_global_master_firebreath"))
	fire:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	fire:setShaderVector(0, 0, 5, 0, 0)
	fire:setShaderVector(1, 12, 0, 0, 0)
	self:addElement(fire)
	self.fire = fire
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_28A9D1228888C8CB"].__resetProperties = function(f2_arg0)
	f2_arg0.dragonWing:completeAnimation()
	f2_arg0.dragonbody:completeAnimation()
	f2_arg0.dragonneckStill:completeAnimation()
	f2_arg0.dragonneckbackward2:completeAnimation()
	f2_arg0.dragonneckforward2:completeAnimation()
	f2_arg0.dragonneckbackward3:completeAnimation()
	f2_arg0.dragonneckforward3:completeAnimation()
	f2_arg0.dragonmouthOpen:completeAnimation()
	f2_arg0.dragonmouthMid:completeAnimation()
	f2_arg0.dragonmouthclosed:completeAnimation()
	f2_arg0.spotlightColor:completeAnimation()
	f2_arg0.fire:completeAnimation()
	f2_arg0.dragonWing:setLeftRight(0, 0, 320.5, 792.5)
	f2_arg0.dragonWing:setTopBottom(0, 0, -8.5, 103.5)
	f2_arg0.dragonWing:setScale(1, 1)
	f2_arg0.dragonbody:setScale(1, 1)
	f2_arg0.dragonneckStill:setAlpha(1)
	f2_arg0.dragonneckbackward2:setAlpha(1)
	f2_arg0.dragonneckforward2:setTopBottom(0, 0, 1, 217)
	f2_arg0.dragonneckforward2:setAlpha(1)
	f2_arg0.dragonneckbackward3:setAlpha(1)
	f2_arg0.dragonneckforward3:setTopBottom(0, 0, 6.5, 222.5)
	f2_arg0.dragonneckforward3:setAlpha(1)
	f2_arg0.dragonmouthOpen:setLeftRight(0, 0, 433.5, 713.5)
	f2_arg0.dragonmouthOpen:setTopBottom(0, 0, -22, 218)
	f2_arg0.dragonmouthOpen:setAlpha(1)
	f2_arg0.dragonmouthMid:setLeftRight(0, 0, 437.5, 717.5)
	f2_arg0.dragonmouthMid:setTopBottom(0, 0, -27, 213)
	f2_arg0.dragonmouthMid:setAlpha(1)
	f2_arg0.dragonmouthclosed:setLeftRight(0, 0, 437.5, 717.5)
	f2_arg0.dragonmouthclosed:setTopBottom(0, 0, -22, 218)
	f2_arg0.dragonmouthclosed:setAlpha(1)
	f2_arg0.spotlightColor:setRGB(0.98, 0.87, 0)
	f2_arg0.spotlightColor:setAlpha(1)
	f2_arg0.fire:setLeftRight(0, 0, -364, 596)
	f2_arg0.fire:setTopBottom(0, 0, 171, 411)
	f2_arg0.fire:setAlpha(1)
end
CoD[@"hash_28A9D1228888C8CB"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(12)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(589)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(1500)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.dragonWing:beginAnimation(1500)
				f3_arg0.dragonWing:setScale(1.04, 0.79)
				f3_arg0.dragonWing:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonWing:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.dragonWing:completeAnimation()
			f3_arg0.dragonWing:setLeftRight(0, 0, 325.5, 797.5)
			f3_arg0.dragonWing:setTopBottom(0, 0, 1.5, 113.5)
			f3_arg0.dragonWing:setScale(1, 1)
			f3_local0(f3_arg0.dragonWing)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							local f10_local0 = function(f11_arg0)
								local f11_local0 = function(f12_arg0)
									local f12_local0 = function(f13_arg0)
										f13_arg0:beginAnimation(2310)
										f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
									end
									f12_arg0:beginAnimation(100)
									f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
								end
								f11_arg0:beginAnimation(149)
								f11_arg0:setScale(1, 1)
								f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
							end
							f10_arg0:beginAnimation(99)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
						end
						f9_arg0:beginAnimation(220)
						f9_arg0:setScale(1.01, 1.02)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(9)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.dragonbody:beginAnimation(700)
				f3_arg0.dragonbody:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonbody:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.dragonbody:completeAnimation()
			f3_arg0.dragonbody:setScale(1, 1)
			f3_local1(f3_arg0.dragonbody)
			local f3_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							local f17_local0 = function(f18_arg0)
								local f18_local0 = function(f19_arg0)
									local f19_local0 = function(f20_arg0)
										local f20_local0 = function(f21_arg0)
											local f21_local0 = function(f22_arg0)
												f22_arg0:beginAnimation(659)
												f22_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f21_arg0:beginAnimation(9)
											f21_arg0:setAlpha(1)
											f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
										end
										f20_arg0:beginAnimation(1780)
										f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
									end
									f19_arg0:beginAnimation(9)
									f19_arg0:setAlpha(0)
									f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
								end
								f18_arg0:beginAnimation(90)
								f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
							end
							f17_arg0:beginAnimation(9)
							f17_arg0:setAlpha(1)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
						end
						f16_arg0:beginAnimation(320)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(9)
					f15_arg0:setAlpha(0)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f3_arg0.dragonneckStill:beginAnimation(700)
				f3_arg0.dragonneckStill:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonneckStill:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.dragonneckStill:completeAnimation()
			f3_arg0.dragonneckStill:setAlpha(1)
			f3_local2(f3_arg0.dragonneckStill)
			local f3_local3 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						local f25_local0 = function(f26_arg0)
							local f26_local0 = function(f27_arg0)
								local f27_local0 = function(f28_arg0)
									local f28_local0 = function(f29_arg0)
										local f29_local0 = function(f30_arg0)
											local f30_local0 = function(f31_arg0)
												f31_arg0:beginAnimation(2550)
												f31_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f30_arg0:beginAnimation(9)
											f30_arg0:setAlpha(0)
											f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
										end
										f29_arg0:beginAnimation(89)
										f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
									end
									f28_arg0:beginAnimation(9)
									f28_arg0:setAlpha(1)
									f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
								end
								f27_arg0:beginAnimation(100)
								f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
							end
							f26_arg0:beginAnimation(9)
							f26_arg0:setAlpha(0)
							f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
						end
						f25_arg0:beginAnimation(110)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
					end
					f24_arg0:beginAnimation(9)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f3_arg0.dragonneckbackward2:beginAnimation(700)
				f3_arg0.dragonneckbackward2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonneckbackward2:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f3_arg0.dragonneckbackward2:completeAnimation()
			f3_arg0.dragonneckbackward2:setAlpha(0)
			f3_local3(f3_arg0.dragonneckbackward2)
			local f3_local4 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							local f35_local0 = function(f36_arg0)
								f36_arg0:beginAnimation(2649)
								f36_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f35_arg0:beginAnimation(9)
							f35_arg0:setAlpha(0)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
						end
						f34_arg0:beginAnimation(100)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(9)
					f33_arg0:setAlpha(1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f3_arg0.dragonneckbackward3:beginAnimation(820)
				f3_arg0.dragonneckbackward3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonneckbackward3:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f3_arg0.dragonneckbackward3:completeAnimation()
			f3_arg0.dragonneckbackward3:setAlpha(0)
			f3_local4(f3_arg0.dragonneckbackward3)
			local f3_local5 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					local f38_local0 = function(f39_arg0)
						local f39_local0 = function(f40_arg0)
							local f40_local0 = function(f41_arg0)
								local f41_local0 = function(f42_arg0)
									local f42_local0 = function(f43_arg0)
										local f43_local0 = function(f44_arg0)
											local f44_local0 = function(f45_arg0)
												local f45_local0 = function(f46_arg0)
													f46_arg0:beginAnimation(659)
													f46_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
												end
												f45_arg0:beginAnimation(9)
												f45_arg0:setAlpha(0)
												f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
											end
											f44_arg0:beginAnimation(60)
											f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
										end
										f43_arg0:beginAnimation(9)
										f43_arg0:setAlpha(1)
										f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
									end
									f42_arg0:beginAnimation(1409)
									f42_arg0:setTopBottom(0, 0, 1, 217)
									f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
								end
								f41_arg0:beginAnimation(200)
								f41_arg0:setTopBottom(0, 0, -2, 214)
								f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
							end
							f40_arg0:beginAnimation(9)
							f40_arg0:setAlpha(0)
							f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
						end
						f39_arg0:beginAnimation(90)
						f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
					end
					f38_arg0:beginAnimation(9)
					f38_arg0:setAlpha(1)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
				end
				f3_arg0.dragonneckforward2:beginAnimation(1130)
				f3_arg0.dragonneckforward2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonneckforward2:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f3_arg0.dragonneckforward2:completeAnimation()
			f3_arg0.dragonneckforward2:setTopBottom(0, 0, 1, 217)
			f3_arg0.dragonneckforward2:setAlpha(0)
			f3_local5(f3_arg0.dragonneckforward2)
			local f3_local6 = function(f47_arg0)
				local f47_local0 = function(f48_arg0)
					local f48_local0 = function(f49_arg0)
						local f49_local0 = function(f50_arg0)
							local f50_local0 = function(f51_arg0)
								local f51_local0 = function(f52_arg0)
									f52_arg0:beginAnimation(730)
									f52_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f51_arg0:beginAnimation(9)
								f51_arg0:setTopBottom(0, 0, 6.5, 222.5)
								f51_arg0:setAlpha(0)
								f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
							end
							f50_arg0:beginAnimation(1409)
							f50_arg0:setTopBottom(0, 0, 0.5, 216.5)
							f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
						end
						f49_arg0:beginAnimation(200)
						f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
					end
					f48_arg0:beginAnimation(9)
					f48_arg0:setTopBottom(0, 0, 1.5, 217.5)
					f48_arg0:setAlpha(1)
					f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
				end
				f3_arg0.dragonneckforward3:beginAnimation(1230)
				f3_arg0.dragonneckforward3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonneckforward3:registerEventHandler("transition_complete_keyframe", f47_local0)
			end
			f3_arg0.dragonneckforward3:completeAnimation()
			f3_arg0.dragonneckforward3:setTopBottom(0, 0, 6.5, 222.5)
			f3_arg0.dragonneckforward3:setAlpha(0)
			f3_local6(f3_arg0.dragonneckforward3)
			local f3_local7 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					local f54_local0 = function(f55_arg0)
						local f55_local0 = function(f56_arg0)
							local f56_local0 = function(f57_arg0)
								local f57_local0 = function(f58_arg0)
									local f58_local0 = function(f59_arg0)
										local f59_local0 = function(f60_arg0)
											local f60_local0 = function(f61_arg0)
												f61_arg0:beginAnimation(659)
												f61_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f60_arg0:beginAnimation(9)
											f60_arg0:setAlpha(0)
											f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
										end
										f59_arg0:beginAnimation(60)
										f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
									end
									f58_arg0:beginAnimation(9)
									f58_arg0:setLeftRight(0, 0, 432.5, 712.5)
									f58_arg0:setTopBottom(0, 0, -33, 207)
									f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
								end
								f57_arg0:beginAnimation(1609)
								f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
							end
							f56_arg0:beginAnimation(9)
							f56_arg0:setLeftRight(0, 0, 422.5, 702.5)
							f56_arg0:setTopBottom(0, 0, -39, 201)
							f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
						end
						f55_arg0:beginAnimation(100)
						f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
					end
					f54_arg0:beginAnimation(9)
					f54_arg0:setAlpha(1)
					f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
				end
				f3_arg0.dragonmouthOpen:beginAnimation(1120)
				f3_arg0.dragonmouthOpen:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonmouthOpen:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f3_arg0.dragonmouthOpen:completeAnimation()
			f3_arg0.dragonmouthOpen:setLeftRight(0, 0, 433.5, 713.5)
			f3_arg0.dragonmouthOpen:setTopBottom(0, 0, -22, 218)
			f3_arg0.dragonmouthOpen:setAlpha(0)
			f3_local7(f3_arg0.dragonmouthOpen)
			local f3_local8 = function(f62_arg0)
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
														f72_arg0:beginAnimation(589)
														f72_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
													end
													f71_arg0:beginAnimation(9)
													f71_arg0:setAlpha(0)
													f71_arg0:registerEventHandler("transition_complete_keyframe", f71_local0)
												end
												f70_arg0:beginAnimation(59)
												f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
											end
											f69_arg0:beginAnimation(9)
											f69_arg0:setAlpha(1)
											f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
										end
										f68_arg0:beginAnimation(1680)
										f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
									end
									f67_arg0:beginAnimation(110)
									f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
								end
								f66_arg0:beginAnimation(9)
								f66_arg0:setAlpha(0)
								f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
							end
							f65_arg0:beginAnimation(80)
							f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
						end
						f64_arg0:beginAnimation(99)
						f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
					end
					f63_arg0:beginAnimation(9)
					f63_arg0:setLeftRight(0, 0, 463.5, 743.5)
					f63_arg0:setTopBottom(0, 0, -27, 213)
					f63_arg0:setAlpha(1)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
				end
				f3_arg0.dragonmouthMid:beginAnimation(930)
				f3_arg0.dragonmouthMid:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonmouthMid:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f3_arg0.dragonmouthMid:completeAnimation()
			f3_arg0.dragonmouthMid:setLeftRight(0, 0, 472.5, 752.5)
			f3_arg0.dragonmouthMid:setTopBottom(0, 0, -24, 216)
			f3_arg0.dragonmouthMid:setAlpha(0)
			f3_local8(f3_arg0.dragonmouthMid)
			local f3_local9 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					local f74_local0 = function(f75_arg0)
						local f75_local0 = function(f76_arg0)
							local f76_local0 = function(f77_arg0)
								local f77_local0 = function(f78_arg0)
									local f78_local0 = function(f79_arg0)
										local f79_local0 = function(f80_arg0)
											local f80_local0 = function(f81_arg0)
												f81_arg0:beginAnimation(589)
												f81_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f80_arg0:beginAnimation(9)
											f80_arg0:setAlpha(1)
											f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
										end
										f79_arg0:beginAnimation(2050)
										f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
									end
									f78_arg0:beginAnimation(9)
									f78_arg0:setAlpha(0)
									f78_arg0:registerEventHandler("transition_complete_keyframe", f78_local0)
								end
								f77_arg0:beginAnimation(100)
								f77_arg0:setLeftRight(0, 0, 469.5, 749.5)
								f77_arg0:registerEventHandler("transition_complete_keyframe", f77_local0)
							end
							f76_arg0:beginAnimation(9)
							f76_arg0:setLeftRight(0, 0, 475.5, 755.5)
							f76_arg0:registerEventHandler("transition_complete_keyframe", f76_local0)
						end
						f75_arg0:beginAnimation(110)
						f75_arg0:registerEventHandler("transition_complete_keyframe", f75_local0)
					end
					f74_arg0:beginAnimation(9)
					f74_arg0:setLeftRight(0, 0, 480, 760)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f74_local0)
				end
				f3_arg0.dragonmouthclosed:beginAnimation(700)
				f3_arg0.dragonmouthclosed:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dragonmouthclosed:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f3_arg0.dragonmouthclosed:completeAnimation()
			f3_arg0.dragonmouthclosed:setLeftRight(0, 0, 469.5, 749.5)
			f3_arg0.dragonmouthclosed:setTopBottom(0, 0, -12, 228)
			f3_arg0.dragonmouthclosed:setAlpha(1)
			f3_local9(f3_arg0.dragonmouthclosed)
			local f3_local10 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					local f83_local0 = function(f84_arg0)
						local f84_local0 = function(f85_arg0)
							local f85_local0 = function(f86_arg0)
								f86_arg0:beginAnimation(730)
								f86_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f85_arg0:beginAnimation(9)
							f85_arg0:setAlpha(0)
							f85_arg0:registerEventHandler("transition_complete_keyframe", f85_local0)
						end
						f84_arg0:beginAnimation(1569)
						f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
					end
					f83_arg0:beginAnimation(9)
					f83_arg0:setAlpha(1)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
				end
				f3_arg0.spotlightColor:beginAnimation(1270)
				f3_arg0.spotlightColor:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.spotlightColor:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f3_arg0.spotlightColor:completeAnimation()
			f3_arg0.spotlightColor:setRGB(0.98, 0.87, 0)
			f3_arg0.spotlightColor:setAlpha(0)
			f3_local10(f3_arg0.spotlightColor)
			local f3_local11 = function(f87_arg0)
				local f87_local0 = function(f88_arg0)
					local f88_local0 = function(f89_arg0)
						local f89_local0 = function(f90_arg0)
							local f90_local0 = function(f91_arg0)
								f91_arg0:beginAnimation(589)
								f91_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f90_arg0:beginAnimation(150)
							f90_arg0:setAlpha(0)
							f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
						end
						f89_arg0:beginAnimation(1569)
						f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
					end
					f88_arg0:beginAnimation(9)
					f88_arg0:setAlpha(1)
					f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
				end
				f3_arg0.fire:beginAnimation(1270)
				f3_arg0.fire:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.fire:registerEventHandler("transition_complete_keyframe", f87_local0)
			end
			f3_arg0.fire:completeAnimation()
			f3_arg0.fire:setLeftRight(0, 0, -379, 581)
			f3_arg0.fire:setTopBottom(0, 0, 156, 396)
			f3_arg0.fire:setAlpha(0)
			f3_local11(f3_arg0.fire)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
