require("x64:4152a90a5661e62")
require("x64:4152990a5661caf")
require("x64:4152890a5661afc")
require("x64:4152790a5661949")
require("x64:4152690a5661796")
require("x64:4152590a56615e3")
CoD.vhud_ms_ModLeft = InheritFrom(LUI.UIElement)
CoD.vhud_ms_ModLeft.__defaultWidth = 966
CoD.vhud_ms_ModLeft.__defaultHeight = 114
CoD.vhud_ms_ModLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_ModLeft)
	self.id = "vhud_ms_ModLeft"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VehicleGroundModT60 = CoD.VehicleGround_ModT6.new(f1_arg0, f1_arg1, 0, 0, 534, 690, 0, 0, 0, 54)
	VehicleGroundModT60:setAlpha(0)
	self:addElement(VehicleGroundModT60)
	self.VehicleGroundModT60 = VehicleGroundModT60
	local VehicleGroundModT50 = CoD.VehicleGround_ModT5.new(f1_arg0, f1_arg1, 0, 0, 366, 534, 0, 0, 0, 54)
	self:addElement(VehicleGroundModT50)
	self.VehicleGroundModT50 = VehicleGroundModT50
	local VehicleGroundModT40 = CoD.VehicleGround_ModT4.new(f1_arg0, f1_arg1, 0, 0, 150, 366, 0, 0, 0, 54)
	self:addElement(VehicleGroundModT40)
	self.VehicleGroundModT40 = VehicleGroundModT40
	local VehicleGroundModT30 = CoD.VehicleGround_ModT3.new(f1_arg0, f1_arg1, 0, 0, 78, 150, 0, 0, 0, 54)
	self:addElement(VehicleGroundModT30)
	self.VehicleGroundModT30 = VehicleGroundModT30
	local VehicleGroundModT20 = CoD.VehicleGround_ModT2.new(f1_arg0, f1_arg1, 0, 0, 153, 225, 0, 0, 0, 54)
	VehicleGroundModT20:setAlpha(0)
	self:addElement(VehicleGroundModT20)
	self.VehicleGroundModT20 = VehicleGroundModT20
	local VehicleGroundModT10 = CoD.VehicleGround_ModT1.new(f1_arg0, f1_arg1, 0, 0, 376, 448, 0, 0, 0, 54)
	VehicleGroundModT10:setAlpha(0)
	self:addElement(VehicleGroundModT10)
	self.VehicleGroundModT10 = VehicleGroundModT10
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return HideVehicleReticle(self, f1_arg1, event)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.VehicleInfo.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.vehicleType, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_ModLeft.__resetProperties = function(f4_arg0)
	f4_arg0.VehicleGroundModT10:completeAnimation()
	f4_arg0.VehicleGroundModT20:completeAnimation()
	f4_arg0.VehicleGroundModT30:completeAnimation()
	f4_arg0.VehicleGroundModT40:completeAnimation()
	f4_arg0.VehicleGroundModT50:completeAnimation()
	f4_arg0.VehicleGroundModT60:completeAnimation()
	f4_arg0.VehicleGroundModT10:setLeftRight(0, 0, 376, 448)
	f4_arg0.VehicleGroundModT10:setTopBottom(0, 0, 0, 54)
	f4_arg0.VehicleGroundModT10:setAlpha(0)
	f4_arg0.VehicleGroundModT20:setLeftRight(0, 0, 153, 225)
	f4_arg0.VehicleGroundModT20:setTopBottom(0, 0, 0, 54)
	f4_arg0.VehicleGroundModT20:setAlpha(0)
	f4_arg0.VehicleGroundModT30:setLeftRight(0, 0, 78, 150)
	f4_arg0.VehicleGroundModT30:setTopBottom(0, 0, 0, 54)
	f4_arg0.VehicleGroundModT30:setAlpha(1)
	f4_arg0.VehicleGroundModT40:setLeftRight(0, 0, 150, 366)
	f4_arg0.VehicleGroundModT40:setTopBottom(0, 0, 0, 54)
	f4_arg0.VehicleGroundModT40:setAlpha(1)
	f4_arg0.VehicleGroundModT50:setLeftRight(0, 0, 366, 534)
	f4_arg0.VehicleGroundModT50:setTopBottom(0, 0, 0, 54)
	f4_arg0.VehicleGroundModT50:setAlpha(1)
	f4_arg0.VehicleGroundModT60:setLeftRight(0, 0, 534, 690)
	f4_arg0.VehicleGroundModT60:setTopBottom(0, 0, 0, 54)
	f4_arg0.VehicleGroundModT60:setAlpha(0)
end
CoD.vhud_ms_ModLeft.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(6)
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
																			local f21_local0 = function(f22_arg0)
																				local f22_local0 = function(f23_arg0)
																					f23_arg0:beginAnimation(140, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																					f23_arg0:setLeftRight(0, 0, 534, 690)
																					f23_arg0:setAlpha(0)
																					f23_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
																				end
																				f22_arg0:beginAnimation(159)
																				f22_arg0:setLeftRight(0, 0, 501.76, 657.76)
																				f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
																			end
																			f21_arg0:beginAnimation(1599)
																			f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
																		end
																		f20_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																		f20_arg0:setLeftRight(0, 0, 462, 618)
																		f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
																	end
																	f19_arg0:beginAnimation(2500)
																	f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
																end
																f18_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																f18_arg0:setLeftRight(0, 0, 246, 402)
																f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
															end
															f17_arg0:beginAnimation(710)
															f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
														end
														f16_arg0:beginAnimation(9)
														f16_arg0:setAlpha(1)
														f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
													end
													f15_arg0:beginAnimation(49)
													f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
												end
												f14_arg0:beginAnimation(9)
												f14_arg0:setAlpha(0)
												f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
											end
											f13_arg0:beginAnimation(49)
											f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
										end
										f12_arg0:beginAnimation(9)
										f12_arg0:setAlpha(0.5)
										f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
									end
									f11_arg0:beginAnimation(49)
									f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
								end
								f10_arg0:beginAnimation(9)
								f10_arg0:setAlpha(0)
								f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
							end
							f9_arg0:beginAnimation(190, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f9_arg0:setLeftRight(0, 0, 78, 234)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
						end
						f8_arg0:beginAnimation(9)
						f8_arg0:setLeftRight(0, 0, 78, 84)
						f8_arg0:setAlpha(1)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(299)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.VehicleGroundModT60:beginAnimation(2900)
				f5_arg0.VehicleGroundModT60:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.VehicleGroundModT60:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.VehicleGroundModT60:completeAnimation()
			f5_arg0.VehicleGroundModT60:setLeftRight(0, 0, 78, 234)
			f5_arg0.VehicleGroundModT60:setTopBottom(0, 0, 0, 54)
			f5_arg0.VehicleGroundModT60:setAlpha(0)
			f5_local0(f5_arg0.VehicleGroundModT60)
			local f5_local1 = function(f24_arg0)
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
																		local f38_local0 = function(f39_arg0)
																			local f39_local0 = function(f40_arg0)
																				local f40_local0 = function(f41_arg0)
																					f41_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																					f41_arg0:setLeftRight(0, 0, 438, 606)
																					f41_arg0:setAlpha(0)
																					f41_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
																				end
																				f40_arg0:beginAnimation(150)
																				f40_arg0:setLeftRight(0, 0, 402, 570)
																				f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
																			end
																			f39_arg0:beginAnimation(4899)
																			f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
																		end
																		f38_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																		f38_arg0:setLeftRight(0, 0, 366, 534)
																		f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
																	end
																	f37_arg0:beginAnimation(1599)
																	f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
																end
																f36_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																f36_arg0:setLeftRight(0, 0, 294, 462)
																f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
															end
															f35_arg0:beginAnimation(2110)
															f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
														end
														f34_arg0:beginAnimation(9)
														f34_arg0:setAlpha(1)
														f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
													end
													f33_arg0:beginAnimation(50)
													f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
												end
												f32_arg0:beginAnimation(9)
												f32_arg0:setAlpha(0)
												f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
											end
											f31_arg0:beginAnimation(50)
											f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
										end
										f30_arg0:beginAnimation(9)
										f30_arg0:setAlpha(0.5)
										f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
									end
									f29_arg0:beginAnimation(50)
									f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
								end
								f28_arg0:beginAnimation(9)
								f28_arg0:setAlpha(0)
								f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
							end
							f27_arg0:beginAnimation(190, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f27_arg0:setLeftRight(0, 0, 78, 246)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
						end
						f26_arg0:beginAnimation(10)
						f26_arg0:setLeftRight(0, 0, 78, 82)
						f26_arg0:setAlpha(1)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(299)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f5_arg0.VehicleGroundModT50:beginAnimation(4300)
				f5_arg0.VehicleGroundModT50:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.VehicleGroundModT50:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f5_arg0.VehicleGroundModT50:completeAnimation()
			f5_arg0.VehicleGroundModT50:setLeftRight(0, 0, 78, 246)
			f5_arg0.VehicleGroundModT50:setTopBottom(0, 0, 0, 54)
			f5_arg0.VehicleGroundModT50:setAlpha(0)
			f5_local1(f5_arg0.VehicleGroundModT50)
			local f5_local2 = function(f42_arg0)
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
														local f52_local0 = function(f53_arg0)
															local f53_local0 = function(f54_arg0)
																local f54_local0 = function(f55_arg0)
																	local f55_local0 = function(f56_arg0)
																		local f56_local0 = function(f57_arg0)
																			local f57_local0 = function(f58_arg0)
																				local f58_local0 = function(f59_arg0)
																					local f59_local0 = function(f60_arg0)
																						f60_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																						f60_arg0:setLeftRight(0, 0, 294, 510)
																						f60_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
																					end
																					f59_arg0:beginAnimation(3500)
																					f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
																				end
																				f58_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																				f58_arg0:setLeftRight(0, 0, 222, 438)
																				f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
																			end
																			f57_arg0:beginAnimation(4899)
																			f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
																		end
																		f56_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																		f56_arg0:setLeftRight(0, 0, 150, 366)
																		f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
																	end
																	f55_arg0:beginAnimation(1110)
																	f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
																end
																f54_arg0:beginAnimation(9)
																f54_arg0:setAlpha(1)
																f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
															end
															f53_arg0:beginAnimation(50)
															f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
														end
														f52_arg0:beginAnimation(9)
														f52_arg0:setAlpha(0)
														f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
													end
													f51_arg0:beginAnimation(50)
													f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
												end
												f50_arg0:beginAnimation(9)
												f50_arg0:setAlpha(0.5)
												f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
											end
											f49_arg0:beginAnimation(50)
											f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
										end
										f48_arg0:beginAnimation(10)
										f48_arg0:setAlpha(0)
										f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
									end
									f47_arg0:beginAnimation(289, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
									f47_arg0:setLeftRight(0, 0, 78, 294)
									f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
								end
								f46_arg0:beginAnimation(9)
								f46_arg0:setLeftRight(0, 0, 78, 82)
								f46_arg0:setAlpha(1)
								f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
							end
							f45_arg0:beginAnimation(6100)
							f45_arg0:setLeftRight(0, 0, 78, 294)
							f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
						end
						f44_arg0:beginAnimation(149, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
						f44_arg0:setLeftRight(0, 0, 348, 564)
						f44_arg0:setAlpha(0)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
					end
					f43_arg0:beginAnimation(149)
					f43_arg0:setLeftRight(0, 0, 321, 537)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f5_arg0.VehicleGroundModT40:beginAnimation(1000)
				f5_arg0.VehicleGroundModT40:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.VehicleGroundModT40:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f5_arg0.VehicleGroundModT40:completeAnimation()
			f5_arg0.VehicleGroundModT40:setLeftRight(0, 0, 294, 510)
			f5_arg0.VehicleGroundModT40:setTopBottom(0, 0, 0, 54)
			f5_arg0.VehicleGroundModT40:setAlpha(1)
			f5_local2(f5_arg0.VehicleGroundModT40)
			local f5_local3 = function(f61_arg0)
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
																			local f76_local0 = function(f77_arg0)
																				local f77_local0 = function(f78_arg0)
																					local f78_local0 = function(f79_arg0)
																						local f79_local0 = function(f80_arg0)
																							local f80_local0 = function(f81_arg0)
																								f81_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																								f81_arg0:setLeftRight(0, 0, 222, 294)
																								f81_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
																							end
																							f80_arg0:beginAnimation(3500)
																							f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
																						end
																						f79_arg0:beginAnimation(300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																						f79_arg0:setLeftRight(0, 0, 150, 222)
																						f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
																					end
																					f78_arg0:beginAnimation(4510)
																					f78_arg0:registerEventHandler("transition_complete_keyframe", f78_local0)
																				end
																				f77_arg0:beginAnimation(9)
																				f77_arg0:setAlpha(1)
																				f77_arg0:registerEventHandler("transition_complete_keyframe", f77_local0)
																			end
																			f76_arg0:beginAnimation(50)
																			f76_arg0:registerEventHandler("transition_complete_keyframe", f76_local0)
																		end
																		f75_arg0:beginAnimation(10)
																		f75_arg0:setAlpha(0)
																		f75_arg0:registerEventHandler("transition_complete_keyframe", f75_local0)
																	end
																	f74_arg0:beginAnimation(50)
																	f74_arg0:registerEventHandler("transition_complete_keyframe", f74_local0)
																end
																f73_arg0:beginAnimation(9)
																f73_arg0:setAlpha(0.5)
																f73_arg0:registerEventHandler("transition_complete_keyframe", f73_local0)
															end
															f72_arg0:beginAnimation(50)
															f72_arg0:registerEventHandler("transition_complete_keyframe", f72_local0)
														end
														f71_arg0:beginAnimation(10)
														f71_arg0:setAlpha(0)
														f71_arg0:registerEventHandler("transition_complete_keyframe", f71_local0)
													end
													f70_arg0:beginAnimation(189, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
													f70_arg0:setLeftRight(0, 0, 78, 150)
													f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
												end
												f69_arg0:beginAnimation(10)
												f69_arg0:setLeftRight(0, 0, 78, 82)
												f69_arg0:setAlpha(1)
												f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
											end
											f68_arg0:beginAnimation(4700)
											f68_arg0:setLeftRight(0, 0, 78, 150)
											f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
										end
										f67_arg0:beginAnimation(139, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
										f67_arg0:setLeftRight(0, 0, 600, 672)
										f67_arg0:setAlpha(0)
										f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
									end
									f66_arg0:beginAnimation(159)
									f66_arg0:setLeftRight(0, 0, 524.78, 596.78)
									f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
								end
								f65_arg0:beginAnimation(1100)
								f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
							end
							f64_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f64_arg0:setLeftRight(0, 0, 432, 504)
							f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
						end
						f63_arg0:beginAnimation(1600)
						f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
					end
					f62_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f62_arg0:setLeftRight(0, 0, 276, 348)
					f62_arg0:registerEventHandler("transition_complete_keyframe", f62_local0)
				end
				f5_arg0.VehicleGroundModT30:beginAnimation(1000)
				f5_arg0.VehicleGroundModT30:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.VehicleGroundModT30:registerEventHandler("transition_complete_keyframe", f61_local0)
			end
			f5_arg0.VehicleGroundModT30:completeAnimation()
			f5_arg0.VehicleGroundModT30:setLeftRight(0, 0, 222, 294)
			f5_arg0.VehicleGroundModT30:setTopBottom(0, 0, 0, 54)
			f5_arg0.VehicleGroundModT30:setAlpha(1)
			f5_local3(f5_arg0.VehicleGroundModT30)
			local f5_local4 = function(f82_arg0)
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
															local f93_local0 = function(f94_arg0)
																local f94_local0 = function(f95_arg0)
																	local f95_local0 = function(f96_arg0)
																		local f96_local0 = function(f97_arg0)
																			local f97_local0 = function(f98_arg0)
																				local f98_local0 = function(f99_arg0)
																					local f99_local0 = function(f100_arg0)
																						local f100_local0 = function(f101_arg0)
																							f101_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
																							f101_arg0:setLeftRight(0, 0, 150, 222)
																							f101_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
																						end
																						f100_arg0:beginAnimation(3109)
																						f100_arg0:registerEventHandler("transition_complete_keyframe", f100_local0)
																					end
																					f99_arg0:beginAnimation(10)
																					f99_arg0:setAlpha(1)
																					f99_arg0:registerEventHandler("transition_complete_keyframe", f99_local0)
																				end
																				f98_arg0:beginAnimation(50)
																				f98_arg0:registerEventHandler("transition_complete_keyframe", f98_local0)
																			end
																			f97_arg0:beginAnimation(10)
																			f97_arg0:setAlpha(0)
																			f97_arg0:registerEventHandler("transition_complete_keyframe", f97_local0)
																		end
																		f96_arg0:beginAnimation(49)
																		f96_arg0:registerEventHandler("transition_complete_keyframe", f96_local0)
																	end
																	f95_arg0:beginAnimation(10)
																	f95_arg0:setAlpha(0.5)
																	f95_arg0:registerEventHandler("transition_complete_keyframe", f95_local0)
																end
																f94_arg0:beginAnimation(50)
																f94_arg0:registerEventHandler("transition_complete_keyframe", f94_local0)
															end
															f93_arg0:beginAnimation(10)
															f93_arg0:setAlpha(0)
															f93_arg0:registerEventHandler("transition_complete_keyframe", f93_local0)
														end
														f92_arg0:beginAnimation(189, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
														f92_arg0:setLeftRight(0, 0, 78, 150)
														f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
													end
													f91_arg0:beginAnimation(10)
													f91_arg0:setLeftRight(0, 0, 78.5, 81.5)
													f91_arg0:setAlpha(1)
													f91_arg0:registerEventHandler("transition_complete_keyframe", f91_local0)
												end
												f90_arg0:beginAnimation(9809)
												f90_arg0:setLeftRight(0, 0, 78, 150)
												f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
											end
											f89_arg0:beginAnimation(90)
											f89_arg0:setLeftRight(0, 0, 523.91, 595.91)
											f89_arg0:setAlpha(0)
											f89_arg0:registerEventHandler("transition_complete_keyframe", f89_local0)
										end
										f88_arg0:beginAnimation(59, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
										f88_arg0:setLeftRight(0, 0, 528, 600)
										f88_arg0:setAlpha(0.6)
										f88_arg0:registerEventHandler("transition_complete_keyframe", f88_local0)
									end
									f87_arg0:beginAnimation(239)
									f87_arg0:setLeftRight(0, 0, 511.96, 583.96)
									f87_arg0:registerEventHandler("transition_complete_keyframe", f87_local0)
								end
								f86_arg0:beginAnimation(1100)
								f86_arg0:registerEventHandler("transition_complete_keyframe", f86_local0)
							end
							f85_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f85_arg0:setLeftRight(0, 0, 360, 432)
							f85_arg0:registerEventHandler("transition_complete_keyframe", f85_local0)
						end
						f84_arg0:beginAnimation(1600)
						f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
					end
					f83_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f83_arg0:setLeftRight(0, 0, 204, 276)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
				end
				f5_arg0.VehicleGroundModT20:beginAnimation(1000)
				f5_arg0.VehicleGroundModT20:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.VehicleGroundModT20:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f5_arg0.VehicleGroundModT20:completeAnimation()
			f5_arg0.VehicleGroundModT20:setLeftRight(0, 0, 150, 222)
			f5_arg0.VehicleGroundModT20:setTopBottom(0, 0, 0, 54)
			f5_arg0.VehicleGroundModT20:setAlpha(1)
			f5_local4(f5_arg0.VehicleGroundModT20)
			local f5_local5 = function(f102_arg0)
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
																			local f117_local0 = function(f118_arg0)
																				local f118_local0 = function(f119_arg0)
																					local f119_local0 = function(f120_arg0)
																						local f120_local0 = function(f121_arg0)
																							f121_arg0:beginAnimation(1309)
																							f121_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
																						end
																						f120_arg0:beginAnimation(10)
																						f120_arg0:setAlpha(1)
																						f120_arg0:registerEventHandler("transition_complete_keyframe", f120_local0)
																					end
																					f119_arg0:beginAnimation(50)
																					f119_arg0:registerEventHandler("transition_complete_keyframe", f119_local0)
																				end
																				f118_arg0:beginAnimation(9)
																				f118_arg0:setAlpha(0)
																				f118_arg0:registerEventHandler("transition_complete_keyframe", f118_local0)
																			end
																			f117_arg0:beginAnimation(50)
																			f117_arg0:registerEventHandler("transition_complete_keyframe", f117_local0)
																		end
																		f116_arg0:beginAnimation(10)
																		f116_arg0:setAlpha(0.5)
																		f116_arg0:registerEventHandler("transition_complete_keyframe", f116_local0)
																	end
																	f115_arg0:beginAnimation(49)
																	f115_arg0:registerEventHandler("transition_complete_keyframe", f115_local0)
																end
																f114_arg0:beginAnimation(10)
																f114_arg0:setAlpha(0)
																f114_arg0:registerEventHandler("transition_complete_keyframe", f114_local0)
															end
															f113_arg0:beginAnimation(190, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
															f113_arg0:setLeftRight(0, 0, 78, 150)
															f113_arg0:registerEventHandler("transition_complete_keyframe", f113_local0)
														end
														f112_arg0:beginAnimation(10)
														f112_arg0:setLeftRight(0, 0, 78.5, 81.5)
														f112_arg0:setAlpha(1)
														f112_arg0:registerEventHandler("transition_complete_keyframe", f112_local0)
													end
													f111_arg0:beginAnimation(10900)
													f111_arg0:setLeftRight(0, 0, 78, 150)
													f111_arg0:registerEventHandler("transition_complete_keyframe", f111_local0)
												end
												f110_arg0:beginAnimation(139, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
												f110_arg0:setLeftRight(0, 0, 672, 744)
												f110_arg0:setAlpha(0)
												f110_arg0:registerEventHandler("transition_complete_keyframe", f110_local0)
											end
											f109_arg0:beginAnimation(160)
											f109_arg0:setLeftRight(0, 0, 575.29, 647.29)
											f109_arg0:registerEventHandler("transition_complete_keyframe", f109_local0)
										end
										f108_arg0:beginAnimation(2500)
										f108_arg0:registerEventHandler("transition_complete_keyframe", f108_local0)
									end
									f107_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
									f107_arg0:setLeftRight(0, 0, 456, 528)
									f107_arg0:registerEventHandler("transition_complete_keyframe", f107_local0)
								end
								f106_arg0:beginAnimation(1100)
								f106_arg0:registerEventHandler("transition_complete_keyframe", f106_local0)
							end
							f105_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f105_arg0:setLeftRight(0, 0, 288, 360)
							f105_arg0:registerEventHandler("transition_complete_keyframe", f105_local0)
						end
						f104_arg0:beginAnimation(1600)
						f104_arg0:registerEventHandler("transition_complete_keyframe", f104_local0)
					end
					f103_arg0:beginAnimation(299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f103_arg0:setLeftRight(0, 0, 132, 204)
					f103_arg0:registerEventHandler("transition_complete_keyframe", f103_local0)
				end
				f5_arg0.VehicleGroundModT10:beginAnimation(1000)
				f5_arg0.VehicleGroundModT10:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.VehicleGroundModT10:registerEventHandler("transition_complete_keyframe", f102_local0)
			end
			f5_arg0.VehicleGroundModT10:completeAnimation()
			f5_arg0.VehicleGroundModT10:setLeftRight(0, 0, 78, 150)
			f5_arg0.VehicleGroundModT10:setTopBottom(0, 0, 0, 54)
			f5_arg0.VehicleGroundModT10:setAlpha(1)
			f5_local5(f5_arg0.VehicleGroundModT10)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f122_arg0, f122_arg1)
			f122_arg0:__resetProperties()
			f122_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.vhud_ms_ModLeft.__onClose = function(f123_arg0)
	f123_arg0.VehicleGroundModT60:close()
	f123_arg0.VehicleGroundModT50:close()
	f123_arg0.VehicleGroundModT40:close()
	f123_arg0.VehicleGroundModT30:close()
	f123_arg0.VehicleGroundModT20:close()
	f123_arg0.VehicleGroundModT10:close()
end
