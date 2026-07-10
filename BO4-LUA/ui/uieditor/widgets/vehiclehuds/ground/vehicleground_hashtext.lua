
require( "x64:d26595bfd6c49b5" )
CoD.VehicleGround_HashText = InheritFrom( LUI.UIElement )
CoD.VehicleGround_HashText.__defaultWidth = 159
CoD.VehicleGround_HashText.__defaultHeight = 39
CoD.VehicleGround_HashText.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.VehicleGround_HashText )
	self.id = "VehicleGround_HashText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local Arrow = LUI.UIImage.new( 0.5, 0.5, -30, -6, 0.5, 0.5, -11, 5 )
	Arrow:setRGB( 0.8, 0.82, 0.87 )
	Arrow:setZRot( -90 )
	Arrow:setImage( RegisterImage( @"uie_t7_cp_hud_woundedsoldier_arrowt" ) )
	self:addElement( Arrow )
	self.Arrow = Arrow
	
	local VehicleGroundHashTextInternal0 = CoD.VehicleGround_HashTextInternal.new( f1_arg0, f1_arg1, 0.5, 0.5, -73, -10, 0.5, 0.5, -240, 234 )
	self:addElement( VehicleGroundHashTextInternal0 )
	self.VehicleGroundHashTextInternal0 = VehicleGroundHashTextInternal0
	
	local TextStrike = LUI.UIText.new( 0.5, 0.5, -6, 99, 0.5, 0.5, -12, 6 )
	TextStrike:setRGB( 0.47, 0.51, 0.6 )
	TextStrike:setText( CoD.BaseUtility.AlreadyLocalized( "STRIKE" ) )
	TextStrike:setTTF( "ttmussels_demibold" )
	TextStrike:setLetterSpacing( 1.5 )
	TextStrike:setAlignment( Enum[@"luialignment"][@"lui_alignment_left"] )
	TextStrike:setAlignment( Enum[@"luialignment"][@"lui_alignment_top"] )
	self:addElement( TextStrike )
	self.TextStrike = TextStrike
	
	local Image0 = LUI.UIImage.new( 0.5, 0.5, -55, -40, 0.5, 0.5, -18, 44 )
	Image0:setZRot( 90 )
	Image0:setImage( RegisterImage( @"uie_t7_cp_hud_woundedsoldier_sidemask" ) )
	self:addElement( Image0 )
	self.Image0 = Image0
	
	local Image1 = LUI.UIImage.new( 0.5, 0.5, -55, -46, 0.5, 0.5, -49, 13 )
	Image1:setZRot( -90 )
	Image1:setImage( RegisterImage( @"uie_t7_cp_hud_woundedsoldier_sidemask" ) )
	self:addElement( Image1 )
	self.Image1 = Image1
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.VehicleGround_HashText.__resetProperties = function ( f2_arg0 )
	f2_arg0.VehicleGroundHashTextInternal0:completeAnimation()
	f2_arg0.Arrow:completeAnimation()
	f2_arg0.TextStrike:completeAnimation()
	f2_arg0.VehicleGroundHashTextInternal0:setLeftRight( 0.5, 0.5, -73, -10 )
	f2_arg0.VehicleGroundHashTextInternal0:setTopBottom( 0.5, 0.5, -240, 234 )
	f2_arg0.Arrow:setLeftRight( 0.5, 0.5, -30, -6 )
	f2_arg0.Arrow:setTopBottom( 0.5, 0.5, -11, 5 )
	f2_arg0.Arrow:setAlpha( 1 )
	f2_arg0.TextStrike:setAlpha( 1 )
end
CoD.VehicleGround_HashText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f3_arg0, f3_arg1 )
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter( 3 )
			local f3_local0 = function ( f4_arg0 )
				local f4_local0 = function ( f5_arg0 )
					local f5_local0 = function ( f6_arg0 )
						local f6_local0 = function ( f7_arg0 )
							local f7_local0 = function ( f8_arg0 )
								local f8_local0 = function ( f9_arg0 )
									local f9_local0 = function ( f10_arg0 )
										local f10_local0 = function ( f11_arg0 )
											local f11_local0 = function ( f12_arg0 )
												local f12_local0 = function ( f13_arg0 )
													local f13_local0 = function ( f14_arg0 )
														local f14_local0 = function ( f15_arg0 )
															local f15_local0 = function ( f16_arg0 )
																local f16_local0 = function ( f17_arg0 )
																	local f17_local0 = function ( f18_arg0 )
																		local f18_local0 = function ( f19_arg0 )
																			local f19_local0 = function ( f20_arg0 )
																				local f20_local0 = function ( f21_arg0 )
																					local f21_local0 = function ( f22_arg0 )
																						local f22_local0 = function ( f23_arg0 )
																							local f23_local0 = function ( f24_arg0 )
																								local f24_local0 = function ( f25_arg0 )
																									local f25_local0 = function ( f26_arg0 )
																										local f26_local0 = function ( f27_arg0 )
																											local f27_local0 = function ( f28_arg0 )
																												local f28_local0 = function ( f29_arg0 )
																													local f29_local0 = function ( f30_arg0 )
																														local f30_local0 = function ( f31_arg0 )
																															local f31_local0 = function ( f32_arg0 )
																																local f32_local0 = function ( f33_arg0 )
																																	local f33_local0 = function ( f34_arg0 )
																																		local f34_local0 = function ( f35_arg0 )
																																			local f35_local0 = function ( f36_arg0 )
																																				local f36_local0 = function ( f37_arg0 )
																																					local f37_local0 = function ( f38_arg0 )
																																						local f38_local0 = function ( f39_arg0 )
																																							local f39_local0 = function ( f40_arg0 )
																																								local f40_local0 = function ( f41_arg0 )
																																									local f41_local0 = function ( f42_arg0 )
																																										f42_arg0:beginAnimation( 290, Enum[@"luitween"][@"luitween_ease_both"] )
																																										f42_arg0:setLeftRight( 0.5, 0.5, -30, -6 )
																																										f42_arg0:setAlpha( 1 )
																																										f42_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
																																									end
																																									
																																									f41_arg0:beginAnimation( 39 )
																																									f41_arg0:setLeftRight( 0.5, 0.5, -39.64, -15.64 )
																																									f41_arg0:setAlpha( 0.2 )
																																									f41_arg0:registerEventHandler( "transition_complete_keyframe", f41_local0 )
																																								end
																																								
																																								f40_arg0:beginAnimation( 260, Enum[@"luitween"][@"luitween_ease_both"] )
																																								f40_arg0:setLeftRight( 0.5, 0.5, -40, -16 )
																																								f40_arg0:setAlpha( 0.28 )
																																								f40_arg0:registerEventHandler( "transition_complete_keyframe", f40_local0 )
																																							end
																																							
																																							f39_arg0:beginAnimation( 79 )
																																							f39_arg0:setAlpha( 0.83 )
																																							f39_arg0:registerEventHandler( "transition_complete_keyframe", f39_local0 )
																																						end
																																						
																																						f38_arg0:beginAnimation( 1729 )
																																						f38_arg0:registerEventHandler( "transition_complete_keyframe", f38_local0 )
																																					end
																																					
																																					f37_arg0:beginAnimation( 30 )
																																					f37_arg0:setAlpha( 1 )
																																					f37_arg0:registerEventHandler( "transition_complete_keyframe", f37_local0 )
																																				end
																																				
																																				f36_arg0:beginAnimation( 340, Enum[@"luitween"][@"luitween_ease_both"] )
																																				f36_arg0:setLeftRight( 0.5, 0.5, -30, -6 )
																																				f36_arg0:setAlpha( 0.97 )
																																				f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
																																			end
																																			
																																			f35_arg0:beginAnimation( 449 )
																																			f35_arg0:setAlpha( 0.64 )
																																			f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
																																		end
																																		
																																		f34_arg0:beginAnimation( 429 )
																																		f34_arg0:setAlpha( 0.2 )
																																		f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
																																	end
																																	
																																	f33_arg0:beginAnimation( 310, Enum[@"luitween"][@"luitween_ease_both"] )
																																	f33_arg0:setLeftRight( 0.5, 0.5, -40, -16 )
																																	f33_arg0:setAlpha( 0.61 )
																																	f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
																																end
																																
																																f32_arg0:beginAnimation( 100 )
																																f32_arg0:setAlpha( 0.9 )
																																f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
																															end
																															
																															f31_arg0:beginAnimation( 1329 )
																															f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
																														end
																														
																														f30_arg0:beginAnimation( 500, Enum[@"luitween"][@"luitween_ease_both"] )
																														f30_arg0:setLeftRight( 0.5, 0.5, -30, -6 )
																														f30_arg0:setAlpha( 1 )
																														f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
																													end
																													
																													f29_arg0:beginAnimation( 739 )
																													f29_arg0:setAlpha( 0.72 )
																													f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
																												end
																												
																												f28_arg0:beginAnimation( 1059 )
																												f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
																											end
																											
																											f27_arg0:beginAnimation( 360 )
																											f27_arg0:setAlpha( 0.2 )
																											f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
																										end
																										
																										f26_arg0:beginAnimation( 809, Enum[@"luitween"][@"luitween_ease_both"] )
																										f26_arg0:setLeftRight( 0.5, 0.5, -40, -16 )
																										f26_arg0:setAlpha( 0.44 )
																										f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
																									end
																									
																									f25_arg0:beginAnimation( 10 )
																									f25_arg0:setAlpha( 0.99 )
																									f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
																								end
																								
																								f24_arg0:beginAnimation( 359 )
																								f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
																							end
																							
																							f23_arg0:beginAnimation( 10 )
																							f23_arg0:setAlpha( 1 )
																							f23_arg0:registerEventHandler( "transition_complete_keyframe", f23_local0 )
																						end
																						
																						f22_arg0:beginAnimation( 989, Enum[@"luitween"][@"luitween_ease_both"] )
																						f22_arg0:setLeftRight( 0.5, 0.5, -30, -6 )
																						f22_arg0:setAlpha( 0.99 )
																						f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
																					end
																					
																					f21_arg0:beginAnimation( 90 )
																					f21_arg0:setAlpha( 0.27 )
																					f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
																				end
																				
																				f20_arg0:beginAnimation( 320 )
																				f20_arg0:setAlpha( 0.2 )
																				f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
																			end
																			
																			f19_arg0:beginAnimation( 689, Enum[@"luitween"][@"luitween_ease_both"] )
																			f19_arg0:setLeftRight( 0.5, 0.5, -40, -16 )
																			f19_arg0:setAlpha( 0.45 )
																			f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
																		end
																		
																		f18_arg0:beginAnimation( 1510 )
																		f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
																	end
																	
																	f17_arg0:beginAnimation( 49 )
																	f17_arg0:setAlpha( 1 )
																	f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
																end
																
																f16_arg0:beginAnimation( 250, Enum[@"luitween"][@"luitween_ease_both"] )
																f16_arg0:setLeftRight( 0.5, 0.5, -30, -6 )
																f16_arg0:setAlpha( 0.89 )
																f16_arg0:registerEventHandler( "transition_complete_keyframe", f16_local0 )
															end
															
															f15_arg0:beginAnimation( 70 )
															f15_arg0:setAlpha( 0.35 )
															f15_arg0:registerEventHandler( "transition_complete_keyframe", f15_local0 )
														end
														
														f14_arg0:beginAnimation( 59 )
														f14_arg0:setAlpha( 0.2 )
														f14_arg0:registerEventHandler( "transition_complete_keyframe", f14_local0 )
													end
													
													f13_arg0:beginAnimation( 240, Enum[@"luitween"][@"luitween_ease_both"] )
													f13_arg0:setLeftRight( 0.5, 0.5, -40, -16 )
													f13_arg0:setAlpha( 0.35 )
													f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
												end
												
												f12_arg0:beginAnimation( 9, Enum[@"luitween"][@"luitween_ease_both"] )
												f12_arg0:setAlpha( 0.97 )
												f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
											end
											
											f11_arg0:beginAnimation( 1980 )
											f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
										end
										
										f10_arg0:beginAnimation( 940, Enum[@"luitween"][@"luitween_ease_both"] )
										f10_arg0:registerEventHandler( "transition_complete_keyframe", f10_local0 )
									end
									
									f9_arg0:beginAnimation( 470 )
									f9_arg0:registerEventHandler( "transition_complete_keyframe", f9_local0 )
								end
								
								f8_arg0:beginAnimation( 179, Enum[@"luitween"][@"luitween_ease_both"] )
								f8_arg0:setLeftRight( 0.5, 0.5, -30, -6 )
								f8_arg0:setAlpha( 1 )
								f8_arg0:registerEventHandler( "transition_complete_keyframe", f8_local0 )
							end
							
							f7_arg0:beginAnimation( 110 )
							f7_arg0:setAlpha( 0.45 )
							f7_arg0:registerEventHandler( "transition_complete_keyframe", f7_local0 )
						end
						
						f6_arg0:beginAnimation( 99 )
						f6_arg0:setAlpha( 0.2 )
						f6_arg0:registerEventHandler( "transition_complete_keyframe", f6_local0 )
					end
					
					f5_arg0:beginAnimation( 200, Enum[@"luitween"][@"luitween_ease_both"] )
					f5_arg0:setLeftRight( 0.5, 0.5, -40, -16 )
					f5_arg0:setAlpha( 0.47 )
					f5_arg0:registerEventHandler( "transition_complete_keyframe", f5_local0 )
				end
				
				f3_arg0.Arrow:beginAnimation( 1500 )
				f3_arg0.Arrow:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.Arrow:registerEventHandler( "transition_complete_keyframe", f4_local0 )
			end
			
			f3_arg0.Arrow:completeAnimation()
			f3_arg0.Arrow:setLeftRight( 0.5, 0.5, -30, -6 )
			f3_arg0.Arrow:setTopBottom( 0.5, 0.5, -11, 5 )
			f3_arg0.Arrow:setAlpha( 1 )
			f3_local0( f3_arg0.Arrow )
			local f3_local1 = function ( f43_arg0 )
				local f43_local0 = function ( f44_arg0 )
					local f44_local0 = function ( f45_arg0 )
						local f45_local0 = function ( f46_arg0 )
							local f46_local0 = function ( f47_arg0 )
								local f47_local0 = function ( f48_arg0 )
									local f48_local0 = function ( f49_arg0 )
										local f49_local0 = function ( f50_arg0 )
											local f50_local0 = function ( f51_arg0 )
												local f51_local0 = function ( f52_arg0 )
													local f52_local0 = function ( f53_arg0 )
														local f53_local0 = function ( f54_arg0 )
															local f54_local0 = function ( f55_arg0 )
																local f55_local0 = function ( f56_arg0 )
																	local f56_local0 = function ( f57_arg0 )
																		local f57_local0 = function ( f58_arg0 )
																			f58_arg0:beginAnimation( 500, Enum[@"luitween"][@"luitween_ease_both"] )
																			f58_arg0:setTopBottom( 0.5, 0.5, -240, 234 )
																			f58_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
																		end
																		
																		f57_arg0:beginAnimation( 2000 )
																		f57_arg0:registerEventHandler( "transition_complete_keyframe", f57_local0 )
																	end
																	
																	f56_arg0:beginAnimation( 1500, Enum[@"luitween"][@"luitween_ease_both"] )
																	f56_arg0:setTopBottom( 0.5, 0.5, -277, 197 )
																	f56_arg0:registerEventHandler( "transition_complete_keyframe", f56_local0 )
																end
																
																f55_arg0:beginAnimation( 1500 )
																f55_arg0:registerEventHandler( "transition_complete_keyframe", f55_local0 )
															end
															
															f54_arg0:beginAnimation( 500, Enum[@"luitween"][@"luitween_ease_both"] )
															f54_arg0:setTopBottom( 0.5, 0.5, -353, 121 )
															f54_arg0:registerEventHandler( "transition_complete_keyframe", f54_local0 )
														end
														
														f53_arg0:beginAnimation( 1000, Enum[@"luitween"][@"luitween_ease_both"] )
														f53_arg0:setTopBottom( 0.5, 0.5, -277, 197 )
														f53_arg0:registerEventHandler( "transition_complete_keyframe", f53_local0 )
													end
													
													f52_arg0:beginAnimation( 2000, Enum[@"luitween"][@"luitween_ease_both"] )
													f52_arg0:setTopBottom( 0.5, 0.5, -390, 84 )
													f52_arg0:registerEventHandler( "transition_complete_keyframe", f52_local0 )
												end
												
												f51_arg0:beginAnimation( 500 )
												f51_arg0:registerEventHandler( "transition_complete_keyframe", f51_local0 )
											end
											
											f50_arg0:beginAnimation( 2000, Enum[@"luitween"][@"luitween_ease_both"] )
											f50_arg0:setTopBottom( 0.5, 0.5, -315, 159 )
											f50_arg0:registerEventHandler( "transition_complete_keyframe", f50_local0 )
										end
										
										f49_arg0:beginAnimation( 1500 )
										f49_arg0:registerEventHandler( "transition_complete_keyframe", f49_local0 )
									end
									
									f48_arg0:beginAnimation( 500, Enum[@"luitween"][@"luitween_ease_both"] )
									f48_arg0:setTopBottom( 0.5, 0.5, -427, 47 )
									f48_arg0:registerEventHandler( "transition_complete_keyframe", f48_local0 )
								end
								
								f47_arg0:beginAnimation( 2000 )
								f47_arg0:registerEventHandler( "transition_complete_keyframe", f47_local0 )
							end
							
							f46_arg0:beginAnimation( 1000, Enum[@"luitween"][@"luitween_ease_both"] )
							f46_arg0:setTopBottom( 0.5, 0.5, -127, 347 )
							f46_arg0:registerEventHandler( "transition_complete_keyframe", f46_local0 )
						end
						
						f45_arg0:beginAnimation( 500 )
						f45_arg0:registerEventHandler( "transition_complete_keyframe", f45_local0 )
					end
					
					f44_arg0:beginAnimation( 500, Enum[@"luitween"][@"luitween_ease_both"] )
					f44_arg0:setTopBottom( 0.5, 0.5, -53, 421 )
					f44_arg0:registerEventHandler( "transition_complete_keyframe", f44_local0 )
				end
				
				f3_arg0.VehicleGroundHashTextInternal0:beginAnimation( 1500 )
				f3_arg0.VehicleGroundHashTextInternal0:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.VehicleGroundHashTextInternal0:registerEventHandler( "transition_complete_keyframe", f43_local0 )
			end
			
			f3_arg0.VehicleGroundHashTextInternal0:completeAnimation()
			f3_arg0.VehicleGroundHashTextInternal0:setLeftRight( 0.5, 0.5, -73, -10 )
			f3_arg0.VehicleGroundHashTextInternal0:setTopBottom( 0.5, 0.5, -240, 234 )
			f3_local1( f3_arg0.VehicleGroundHashTextInternal0 )
			local f3_local2 = function ( f59_arg0 )
				local f59_local0 = function ( f60_arg0 )
					local f60_local0 = function ( f61_arg0 )
						local f61_local0 = function ( f62_arg0 )
							local f62_local0 = function ( f63_arg0 )
								local f63_local0 = function ( f64_arg0 )
									local f64_local0 = function ( f65_arg0 )
										local f65_local0 = function ( f66_arg0 )
											local f66_local0 = function ( f67_arg0 )
												local f67_local0 = function ( f68_arg0 )
													local f68_local0 = function ( f69_arg0 )
														local f69_local0 = function ( f70_arg0 )
															local f70_local0 = function ( f71_arg0 )
																local f71_local0 = function ( f72_arg0 )
																	local f72_local0 = function ( f73_arg0 )
																		local f73_local0 = function ( f74_arg0 )
																			f74_arg0:beginAnimation( 10 )
																			f74_arg0:setAlpha( 1 )
																			f74_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
																		end
																		
																		f73_arg0:beginAnimation( 49 )
																		f73_arg0:registerEventHandler( "transition_complete_keyframe", f73_local0 )
																	end
																	
																	f72_arg0:beginAnimation( 10 )
																	f72_arg0:setAlpha( 0 )
																	f72_arg0:registerEventHandler( "transition_complete_keyframe", f72_local0 )
																end
																
																f71_arg0:beginAnimation( 49 )
																f71_arg0:registerEventHandler( "transition_complete_keyframe", f71_local0 )
															end
															
															f70_arg0:beginAnimation( 10 )
															f70_arg0:setAlpha( 0.5 )
															f70_arg0:registerEventHandler( "transition_complete_keyframe", f70_local0 )
														end
														
														f69_arg0:beginAnimation( 49 )
														f69_arg0:registerEventHandler( "transition_complete_keyframe", f69_local0 )
													end
													
													f68_arg0:beginAnimation( 10 )
													f68_arg0:setAlpha( 0 )
													f68_arg0:registerEventHandler( "transition_complete_keyframe", f68_local0 )
												end
												
												f67_arg0:beginAnimation( 3800 )
												f67_arg0:registerEventHandler( "transition_complete_keyframe", f67_local0 )
											end
											
											f66_arg0:beginAnimation( 9 )
											f66_arg0:setAlpha( 1 )
											f66_arg0:registerEventHandler( "transition_complete_keyframe", f66_local0 )
										end
										
										f65_arg0:beginAnimation( 49 )
										f65_arg0:registerEventHandler( "transition_complete_keyframe", f65_local0 )
									end
									
									f64_arg0:beginAnimation( 9 )
									f64_arg0:setAlpha( 0 )
									f64_arg0:registerEventHandler( "transition_complete_keyframe", f64_local0 )
								end
								
								f63_arg0:beginAnimation( 60 )
								f63_arg0:registerEventHandler( "transition_complete_keyframe", f63_local0 )
							end
							
							f62_arg0:beginAnimation( 9 )
							f62_arg0:setAlpha( 0.5 )
							f62_arg0:registerEventHandler( "transition_complete_keyframe", f62_local0 )
						end
						
						f61_arg0:beginAnimation( 49 )
						f61_arg0:registerEventHandler( "transition_complete_keyframe", f61_local0 )
					end
					
					f60_arg0:beginAnimation( 9 )
					f60_arg0:setAlpha( 0 )
					f60_arg0:registerEventHandler( "transition_complete_keyframe", f60_local0 )
				end
				
				f3_arg0.TextStrike:beginAnimation( 2000 )
				f3_arg0.TextStrike:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.TextStrike:registerEventHandler( "transition_complete_keyframe", f59_local0 )
			end
			
			f3_arg0.TextStrike:completeAnimation()
			f3_arg0.TextStrike:setAlpha( 1 )
			f3_local2( f3_arg0.TextStrike )
			f3_arg0.nextClip = "DefaultClip"
		end
	}
}
CoD.VehicleGround_HashText.__onClose = function ( f75_arg0 )
	f75_arg0.VehicleGroundHashTextInternal0:close()
end
