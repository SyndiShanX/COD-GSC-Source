CoD.callingcards_bootcamp_master = InheritFrom(LUI.UIElement)
CoD.callingcards_bootcamp_master.__defaultWidth = 960
CoD.callingcards_bootcamp_master.__defaultHeight = 240
CoD.callingcards_bootcamp_master.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_bootcamp_master)
	self.id = "CallingCards_Bootcamp_Master"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage("uie_ui_icon_callingcards_bootcamp_master_background"))
	background:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	background:setShaderVector(0, 1, 1, 0, 0)
	background:setShaderVector(1, 0.03, 0, 0, 0)
	self:addElement(background)
	self.background = background
	local city = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	city:setImage(RegisterImage("uie_ui_icon_callingcards_bootcamp_master_city"))
	city:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	city:setShaderVector(0, 1, 1, 0, 0)
	city:setShaderVector(1, -0, 0, 0, 0)
	self:addElement(city)
	self.city = city
	local wings = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	wings:setImage(RegisterImage("uie_ui_icon_callingcards_bootcamp_master_wings"))
	self:addElement(wings)
	self.wings = wings
	local bathand = LUI.UIImage.new(0, 0, 629.5, 893.5, 0, 0, 38.5, 142.5)
	bathand:setImage(RegisterImage("uie_ui_icon_callingcards_bootcamp_master_bathand"))
	self:addElement(bathand)
	self.bathand = bathand
	local moon = LUI.UIImage.new(0, 0, 172.5, 292.5, 0, 0, 9.5, 129.5)
	moon:setRGB(0.98, 1, 0.4)
	moon:setAlpha(0.95)
	moon:setImage(RegisterImage("uie_ui_icon_callingcards_bootcamp_master_moon"))
	self:addElement(moon)
	self.moon = moon
	local dude = LUI.UIImage.new(0, 0, 660.5, 900.5, 0, 0, 0, 240)
	dude:setImage(RegisterImage("uie_ui_icon_callingcards_bootcamp_master_dude"))
	self:addElement(dude)
	self.dude = dude
	local lightening = LUI.UIImage.new(0, 0, 0, 320, 0, 0, 0, 240)
	lightening:setImage(RegisterImage("uie_ui_icon_callingcards_bootcamp_master_lightening"))
	self:addElement(lightening)
	self.lightening = lightening
	local dudeLighting = LUI.UIImage.new(0, 0, 661.5, 901.5, 0, 0, 0, 240)
	dudeLighting:setImage(RegisterImage("uie_ui_icon_callingcards_bootcamp_master_dude_light"))
	self:addElement(dudeLighting)
	self.dudeLighting = dudeLighting
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_bootcamp_master.__resetProperties = function(f2_arg0)
	f2_arg0.wings:completeAnimation()
	f2_arg0.bathand:completeAnimation()
	f2_arg0.dudeLighting:completeAnimation()
	f2_arg0.lightening:completeAnimation()
	f2_arg0.wings:setTopBottom(0, 0, 0, 240)
	f2_arg0.bathand:setLeftRight(0, 0, 629.5, 893.5)
	f2_arg0.bathand:setTopBottom(0, 0, 38.5, 142.5)
	f2_arg0.bathand:setZRot(0)
	f2_arg0.dudeLighting:setAlpha(1)
	f2_arg0.lightening:setAlpha(1)
	f2_arg0.lightening:setMaterial(LUI.UIImage.GetCachedMaterial("ui_normal"))
end
CoD.callingcards_bootcamp_master.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(2000)
					f5_arg0:setTopBottom(0, 0, 0, 240)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.wings:beginAnimation(2000)
				f3_arg0.wings:setTopBottom(0, 0, -10, 230)
				f3_arg0.wings:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.wings:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.wings:completeAnimation()
			f3_arg0.wings:setTopBottom(0, 0, 0, 240)
			f3_local0(f3_arg0.wings)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							local f9_local0 = function(f10_arg0)
								local f10_local0 = function(f11_arg0)
									local f11_local0 = function(f12_arg0)
										local f12_local0 = function(f13_arg0)
											f13_arg0:beginAnimation(500)
											f13_arg0:setLeftRight(0, 0, 628.5, 892.5)
											f13_arg0:setTopBottom(0, 0, 36.5, 140.5)
											f13_arg0:setZRot(0)
											f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
										end
										f12_arg0:beginAnimation(500)
										f12_arg0:setLeftRight(0, 0, 627.5, 891.5)
										f12_arg0:setTopBottom(0, 0, 32.5, 136.5)
										f12_arg0:setZRot(2)
										f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
									end
									f11_arg0:beginAnimation(500)
									f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
								end
								f10_arg0:beginAnimation(500)
								f10_arg0:setLeftRight(0, 0, 628.5, 892.5)
								f10_arg0:setTopBottom(0, 0, 36.5, 140.5)
								f10_arg0:setZRot(0)
								f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
							end
							f9_arg0:beginAnimation(500)
							f9_arg0:setLeftRight(0, 0, 627.5, 891.5)
							f9_arg0:setTopBottom(0, 0, 32.5, 136.5)
							f9_arg0:setZRot(2)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
						end
						f8_arg0:beginAnimation(500)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(500)
					f7_arg0:setLeftRight(0, 0, 628.5, 892.5)
					f7_arg0:setTopBottom(0, 0, 36.5, 140.5)
					f7_arg0:setZRot(0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.bathand:beginAnimation(500)
				f3_arg0.bathand:setLeftRight(0, 0, 627.5, 891.5)
				f3_arg0.bathand:setTopBottom(0, 0, 32.5, 136.5)
				f3_arg0.bathand:setZRot(2)
				f3_arg0.bathand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bathand:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.bathand:completeAnimation()
			f3_arg0.bathand:setLeftRight(0, 0, 628.5, 892.5)
			f3_arg0.bathand:setTopBottom(0, 0, 36.5, 140.5)
			f3_arg0.bathand:setZRot(0)
			f3_local1(f3_arg0.bathand)
			local f3_local2 = function(f14_arg0)
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
																			f29_arg0:beginAnimation(9)
																			f29_arg0:setAlpha(0)
																			f29_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																		end
																		f28_arg0:beginAnimation(69)
																		f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
																	end
																	f27_arg0:beginAnimation(9)
																	f27_arg0:setAlpha(1)
																	f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
																end
																f26_arg0:beginAnimation(640)
																f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
															end
															f25_arg0:beginAnimation(9)
															f25_arg0:setAlpha(0)
															f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
														end
														f24_arg0:beginAnimation(69)
														f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
													end
													f23_arg0:beginAnimation(9)
													f23_arg0:setAlpha(1)
													f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
												end
												f22_arg0:beginAnimation(70)
												f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
											end
											f21_arg0:beginAnimation(1040)
											f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
										end
										f20_arg0:beginAnimation(9)
										f20_arg0:setAlpha(0)
										f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
									end
									f19_arg0:beginAnimation(69)
									f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
								end
								f18_arg0:beginAnimation(9)
								f18_arg0:setAlpha(1)
								f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
							end
							f17_arg0:beginAnimation(130)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
						end
						f16_arg0:beginAnimation(9)
						f16_arg0:setAlpha(0)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(70)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f14_arg0:beginAnimation(9)
				f14_arg0:setAlpha(1)
				f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.lightening:beginAnimation(1000)
			f3_arg0.lightening:setAlpha(0)
			f3_arg0.lightening:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
			f3_arg0.lightening:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.lightening:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f30_arg0)
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
																			f45_arg0:beginAnimation(9)
																			f45_arg0:setAlpha(0)
																			f45_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
																		end
																		f44_arg0:beginAnimation(69)
																		f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
																	end
																	f43_arg0:beginAnimation(9)
																	f43_arg0:setAlpha(1)
																	f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
																end
																f42_arg0:beginAnimation(640)
																f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
															end
															f41_arg0:beginAnimation(9)
															f41_arg0:setAlpha(0)
															f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
														end
														f40_arg0:beginAnimation(69)
														f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
													end
													f39_arg0:beginAnimation(9)
													f39_arg0:setAlpha(1)
													f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
												end
												f38_arg0:beginAnimation(1110)
												f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
											end
											f37_arg0:beginAnimation(9)
											f37_arg0:setAlpha(0)
											f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
										end
										f36_arg0:beginAnimation(69)
										f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
									end
									f35_arg0:beginAnimation(9)
									f35_arg0:setAlpha(1)
									f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
								end
								f34_arg0:beginAnimation(130)
								f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
							end
							f33_arg0:beginAnimation(9)
							f33_arg0:setAlpha(0)
							f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
						end
						f32_arg0:beginAnimation(70)
						f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
					end
					f31_arg0:beginAnimation(9)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
				end
				f3_arg0.dudeLighting:beginAnimation(1000)
				f3_arg0.dudeLighting:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.dudeLighting:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f3_arg0.dudeLighting:completeAnimation()
			f3_arg0.dudeLighting:setAlpha(0)
			f3_local3(f3_arg0.dudeLighting)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
