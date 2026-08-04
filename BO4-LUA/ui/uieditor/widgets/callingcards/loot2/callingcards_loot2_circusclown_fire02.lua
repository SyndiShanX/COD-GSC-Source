CoD.callingcards_loot2_circusclown_fire02 = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_circusclown_fire02.__defaultWidth = 96
CoD.callingcards_loot2_circusclown_fire02.__defaultHeight = 176
CoD.callingcards_loot2_circusclown_fire02.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_circusclown_fire02)
	self.id = "callingcards_loot2_circusclown_fire02"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fire02 = LUI.UIImage.new(0, 0, 0, 96, 0, 0, 0, 176)
	fire02:setImage(RegisterImage("uie_ui_menu_callingcards_circusclown_fire02"))
	fire02:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(fire02)
	self.fire02 = fire02
	local fire = LUI.UIImage.new(0, 0, -12, 108, 0, 0, -97, 167)
	fire:setAlpha(0.4)
	fire:setImage(RegisterImage("uie_ui_menu_callingcards_circusclown_fire03"))
	fire:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(fire)
	self.fire = fire
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_loot2_circusclown_fire02.__resetProperties = function(f2_arg0)
	f2_arg0.fire02:completeAnimation()
	f2_arg0.fire:completeAnimation()
	f2_arg0.fire02:setLeftRight(0, 0, 0, 96)
	f2_arg0.fire02:setTopBottom(0, 0, 0, 176)
	f2_arg0.fire02:setAlpha(1)
	f2_arg0.fire02:setScale(1, 1)
	f2_arg0.fire:setLeftRight(0, 0, -12, 108)
	f2_arg0.fire:setTopBottom(0, 0, -97, 167)
	f2_arg0.fire:setScale(1, 1)
end
CoD.callingcards_loot2_circusclown_fire02.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
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
																	f17_arg0:beginAnimation(99)
																	f17_arg0:setTopBottom(0, 0, 25, 201)
																	f17_arg0:setScale(1, 1)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																end
																f16_arg0:beginAnimation(400)
																f16_arg0:setTopBottom(0, 0, 32, 208)
																f16_arg0:setScale(1, 0.9)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(99)
															f15_arg0:setTopBottom(0, 0, 26, 202)
															f15_arg0:setScale(1, 1)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(200)
														f14_arg0:setTopBottom(0, 0, 29.5, 205.5)
														f14_arg0:setScale(1, 0.95)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(100)
													f13_arg0:setTopBottom(0, 0, 23, 199)
													f13_arg0:setScale(1, 1.05)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(199)
												f12_arg0:setTopBottom(0, 0, 30.5, 206.5)
												f12_arg0:setScale(1, 0.93)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(100)
											f11_arg0:setTopBottom(0, 0, 25.5, 201.5)
											f11_arg0:setScale(1, 1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(399)
										f10_arg0:setTopBottom(0, 0, 29, 205)
										f10_arg0:setScale(1, 0.95)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(199)
									f9_arg0:setTopBottom(0, 0, 26.5, 202.5)
									f9_arg0:setScale(1, 1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(300)
								f8_arg0:setTopBottom(0, 0, 32.5, 208.5)
								f8_arg0:setScale(1, 0.9)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(199)
							f7_arg0:setTopBottom(0, 0, 20.5, 196.5)
							f7_arg0:setScale(1, 1.1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(199)
						f6_arg0:setTopBottom(0, 0, 32, 208)
						f6_arg0:setScale(1, 0.9)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(99)
					f5_arg0:setTopBottom(0, 0, 26, 202)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.fire02:beginAnimation(400)
				f3_arg0.fire02:setTopBottom(0, 0, 29, 205)
				f3_arg0.fire02:setScale(1, 0.95)
				f3_arg0.fire02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.fire02:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.fire02:completeAnimation()
			f3_arg0.fire02:setLeftRight(0, 0, 0, 96)
			f3_arg0.fire02:setTopBottom(0, 0, 25, 201)
			f3_arg0.fire02:setAlpha(0.5)
			f3_arg0.fire02:setScale(1, 1)
			f3_local0(f3_arg0.fire02)
			local f3_local1 = function(f18_arg0)
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
																	f31_arg0:beginAnimation(400)
																	f31_arg0:setTopBottom(0, 0, 25, 201)
																	f31_arg0:setScale(1, 1)
																	f31_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																end
																f30_arg0:beginAnimation(99)
																f30_arg0:setTopBottom(0, 0, 29, 205)
																f30_arg0:setScale(1, 0.95)
																f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
															end
															f29_arg0:beginAnimation(200)
															f29_arg0:setTopBottom(0, 0, 26, 202)
															f29_arg0:setScale(1, 1)
															f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
														end
														f28_arg0:beginAnimation(200)
														f28_arg0:setTopBottom(0, 0, 32, 208)
														f28_arg0:setScale(1, 0.9)
														f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
													end
													f27_arg0:beginAnimation(299)
													f27_arg0:setTopBottom(0, 0, 20.5, 196.5)
													f27_arg0:setScale(1, 1.1)
													f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
												end
												f26_arg0:beginAnimation(199)
												f26_arg0:setTopBottom(0, 0, 32.5, 208.5)
												f26_arg0:setScale(1, 0.9)
												f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
											end
											f25_arg0:beginAnimation(399)
											f25_arg0:setTopBottom(0, 0, 26.5, 202.5)
											f25_arg0:setScale(1, 1)
											f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
										end
										f24_arg0:beginAnimation(100)
										f24_arg0:setTopBottom(0, 0, 29, 205)
										f24_arg0:setScale(1, 0.95)
										f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
									end
									f23_arg0:beginAnimation(199)
									f23_arg0:setTopBottom(0, 0, 25.5, 201.5)
									f23_arg0:setScale(1, 1)
									f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
								end
								f22_arg0:beginAnimation(100)
								f22_arg0:setTopBottom(0, 0, 30.5, 206.5)
								f22_arg0:setScale(1, 0.93)
								f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
							end
							f21_arg0:beginAnimation(200)
							f21_arg0:setTopBottom(0, 0, 23, 199)
							f21_arg0:setScale(1, 1.05)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
						end
						f20_arg0:beginAnimation(99)
						f20_arg0:setTopBottom(0, 0, 29.5, 205.5)
						f20_arg0:setScale(1, 0.95)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(400)
					f19_arg0:setTopBottom(0, 0, 26, 202)
					f19_arg0:setScale(1, 1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f3_arg0.fire:beginAnimation(99)
				f3_arg0.fire:setTopBottom(0, 0, 32, 208)
				f3_arg0.fire:setScale(1, 0.9)
				f3_arg0.fire:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.fire:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f3_arg0.fire:completeAnimation()
			f3_arg0.fire:setLeftRight(0, 0, 0, 96)
			f3_arg0.fire:setTopBottom(0, 0, 25, 201)
			f3_arg0.fire:setScale(1, 1)
			f3_local1(f3_arg0.fire)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
