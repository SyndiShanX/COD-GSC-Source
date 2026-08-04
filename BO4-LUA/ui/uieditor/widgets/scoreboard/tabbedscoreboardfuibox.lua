CoD.TabbedScoreboardFuiBox = InheritFrom( LUI.UIElement )
CoD.TabbedScoreboardFuiBox.__defaultWidth = 112
CoD.TabbedScoreboardFuiBox.__defaultHeight = 16
CoD.TabbedScoreboardFuiBox.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.TabbedScoreboardFuiBox )
	self.id = "TabbedScoreboardFuiBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local TopFuiBoxBg = LUI.UIImage.new( 0, 0, 0, 112, 0, 0, 0, 16 )
	TopFuiBoxBg:setImage( RegisterImage( "uie_ui_menu_mp_scoreboard_map_topbox2" ) )
	self:addElement( TopFuiBoxBg )
	self.TopFuiBoxBg = TopFuiBoxBg
	
	local TopFuiBox = LUI.UIImage.new( 0, 0, 0, 10, 0, 0, 1, 15 )
	TopFuiBox:setImage( RegisterImage( "uie_ui_menu_mp_scoreboard_map_topbox" ) )
	self:addElement( TopFuiBox )
	self.TopFuiBox = TopFuiBox
	
	local TopFuiBoxAdd = LUI.UIImage.new( 0, 0, 0, 10, 0, 0, 1, 15 )
	TopFuiBoxAdd:setImage( RegisterImage( "uie_ui_menu_mp_scoreboard_map_topbox" ) )
	TopFuiBoxAdd:setMaterial( LUI.UIImage.GetCachedMaterial( @"hash_31CC85D0A86303B0" ) )
	TopFuiBoxAdd:setShaderVector( 0, 1, 0, 0, 0 )
	self:addElement( TopFuiBoxAdd )
	self.TopFuiBoxAdd = TopFuiBoxAdd
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.TabbedScoreboardFuiBox.__resetProperties = function ( f2_arg0 )
	f2_arg0.TopFuiBoxAdd:completeAnimation()
	f2_arg0.TopFuiBox:completeAnimation()
	f2_arg0.TopFuiBoxAdd:setLeftRight( 0, 0, 0, 10 )
	f2_arg0.TopFuiBoxAdd:setAlpha( 1 )
	f2_arg0.TopFuiBox:setLeftRight( 0, 0, 0, 10 )
	f2_arg0.TopFuiBox:setAlpha( 1 )
end
CoD.TabbedScoreboardFuiBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f3_arg0, f3_arg1 )
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter( 2 )
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
																																					f37_arg0:beginAnimation( 9 )
																																					f37_arg0:setLeftRight( 0, 0, 103, 113 )
																																					f37_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
																																				end
																																				
																																				f36_arg0:beginAnimation( 190 )
																																				f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
																																			end
																																			
																																			f35_arg0:beginAnimation( 9 )
																																			f35_arg0:setLeftRight( 0, 0, 96.5, 106.5 )
																																			f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
																																		end
																																		
																																		f34_arg0:beginAnimation( 189 )
																																		f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
																																	end
																																	
																																	f33_arg0:beginAnimation( 10 )
																																	f33_arg0:setLeftRight( 0, 0, 90, 100 )
																																	f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
																																end
																																
																																f32_arg0:beginAnimation( 189 )
																																f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
																															end
																															
																															f31_arg0:beginAnimation( 9 )
																															f31_arg0:setLeftRight( 0, 0, 84, 94 )
																															f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
																														end
																														
																														f30_arg0:beginAnimation( 190 )
																														f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
																													end
																													
																													f29_arg0:beginAnimation( 9 )
																													f29_arg0:setLeftRight( 0, 0, 77, 87 )
																													f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
																												end
																												
																												f28_arg0:beginAnimation( 190 )
																												f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
																											end
																											
																											f27_arg0:beginAnimation( 9 )
																											f27_arg0:setLeftRight( 0, 0, 70, 80 )
																											f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
																										end
																										
																										f26_arg0:beginAnimation( 190 )
																										f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
																									end
																									
																									f25_arg0:beginAnimation( 9 )
																									f25_arg0:setLeftRight( 0, 0, 64, 74 )
																									f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
																								end
																								
																								f24_arg0:beginAnimation( 189 )
																								f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
																							end
																							
																							f23_arg0:beginAnimation( 10 )
																							f23_arg0:setLeftRight( 0, 0, 58, 68 )
																							f23_arg0:registerEventHandler( "transition_complete_keyframe", f23_local0 )
																						end
																						
																						f22_arg0:beginAnimation( 189 )
																						f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
																					end
																					
																					f21_arg0:beginAnimation( 9 )
																					f21_arg0:setLeftRight( 0, 0, 51, 61 )
																					f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
																				end
																				
																				f20_arg0:beginAnimation( 189 )
																				f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
																			end
																			
																			f19_arg0:beginAnimation( 9 )
																			f19_arg0:setLeftRight( 0, 0, 44, 54 )
																			f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
																		end
																		
																		f18_arg0:beginAnimation( 190 )
																		f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
																	end
																	
																	f17_arg0:beginAnimation( 9 )
																	f17_arg0:setLeftRight( 0, 0, 38, 48 )
																	f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
																end
																
																f16_arg0:beginAnimation( 189 )
																f16_arg0:registerEventHandler( "transition_complete_keyframe", f16_local0 )
															end
															
															f15_arg0:beginAnimation( 9 )
															f15_arg0:setLeftRight( 0, 0, 32, 42 )
															f15_arg0:registerEventHandler( "transition_complete_keyframe", f15_local0 )
														end
														
														f14_arg0:beginAnimation( 190 )
														f14_arg0:registerEventHandler( "transition_complete_keyframe", f14_local0 )
													end
													
													f13_arg0:beginAnimation( 9 )
													f13_arg0:setLeftRight( 0, 0, 24, 34 )
													f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
												end
												
												f12_arg0:beginAnimation( 190 )
												f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
											end
											
											f11_arg0:beginAnimation( 9 )
											f11_arg0:setLeftRight( 0, 0, 18, 28 )
											f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
										end
										
										f10_arg0:beginAnimation( 190 )
										f10_arg0:registerEventHandler( "transition_complete_keyframe", f10_local0 )
									end
									
									f9_arg0:beginAnimation( 9 )
									f9_arg0:setLeftRight( 0, 0, 12, 22 )
									f9_arg0:registerEventHandler( "transition_complete_keyframe", f9_local0 )
								end
								
								f8_arg0:beginAnimation( 190 )
								f8_arg0:registerEventHandler( "transition_complete_keyframe", f8_local0 )
							end
							
							f7_arg0:beginAnimation( 9 )
							f7_arg0:setLeftRight( 0, 0, 6, 16 )
							f7_arg0:registerEventHandler( "transition_complete_keyframe", f7_local0 )
						end
						
						f6_arg0:beginAnimation( 219 )
						f6_arg0:registerEventHandler( "transition_complete_keyframe", f6_local0 )
					end
					
					f5_arg0:beginAnimation( 100 )
					f5_arg0:setAlpha( 1 )
					f5_arg0:registerEventHandler( "transition_complete_keyframe", f5_local0 )
				end
				
				f3_arg0.TopFuiBox:beginAnimation( 200 )
				f3_arg0.TopFuiBox:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.TopFuiBox:registerEventHandler( "transition_complete_keyframe", f4_local0 )
			end
			
			f3_arg0.TopFuiBox:completeAnimation()
			f3_arg0.TopFuiBox:setLeftRight( 0, 0, 0, 10 )
			f3_arg0.TopFuiBox:setAlpha( 0 )
			f3_local0( f3_arg0.TopFuiBox )
			local f3_local1 = function ( f38_arg0 )
				local f38_local0 = function ( f39_arg0 )
					local f39_local0 = function ( f40_arg0 )
						local f40_local0 = function ( f41_arg0 )
							local f41_local0 = function ( f42_arg0 )
								local f42_local0 = function ( f43_arg0 )
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
																								local f58_local0 = function ( f59_arg0 )
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
																																					f71_arg0:beginAnimation( 9 )
																																					f71_arg0:setLeftRight( 0, 0, 103, 113 )
																																					f71_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
																																				end
																																				
																																				f70_arg0:beginAnimation( 190 )
																																				f70_arg0:registerEventHandler( "transition_complete_keyframe", f70_local0 )
																																			end
																																			
																																			f69_arg0:beginAnimation( 9 )
																																			f69_arg0:setLeftRight( 0, 0, 96.5, 106.5 )
																																			f69_arg0:registerEventHandler( "transition_complete_keyframe", f69_local0 )
																																		end
																																		
																																		f68_arg0:beginAnimation( 190 )
																																		f68_arg0:registerEventHandler( "transition_complete_keyframe", f68_local0 )
																																	end
																																	
																																	f67_arg0:beginAnimation( 9 )
																																	f67_arg0:setLeftRight( 0, 0, 90, 100 )
																																	f67_arg0:registerEventHandler( "transition_complete_keyframe", f67_local0 )
																																end
																																
																																f66_arg0:beginAnimation( 189 )
																																f66_arg0:registerEventHandler( "transition_complete_keyframe", f66_local0 )
																															end
																															
																															f65_arg0:beginAnimation( 10 )
																															f65_arg0:setLeftRight( 0, 0, 84, 94 )
																															f65_arg0:registerEventHandler( "transition_complete_keyframe", f65_local0 )
																														end
																														
																														f64_arg0:beginAnimation( 189 )
																														f64_arg0:registerEventHandler( "transition_complete_keyframe", f64_local0 )
																													end
																													
																													f63_arg0:beginAnimation( 9 )
																													f63_arg0:setLeftRight( 0, 0, 77, 87 )
																													f63_arg0:registerEventHandler( "transition_complete_keyframe", f63_local0 )
																												end
																												
																												f62_arg0:beginAnimation( 190 )
																												f62_arg0:registerEventHandler( "transition_complete_keyframe", f62_local0 )
																											end
																											
																											f61_arg0:beginAnimation( 9 )
																											f61_arg0:setLeftRight( 0, 0, 70, 80 )
																											f61_arg0:registerEventHandler( "transition_complete_keyframe", f61_local0 )
																										end
																										
																										f60_arg0:beginAnimation( 190 )
																										f60_arg0:registerEventHandler( "transition_complete_keyframe", f60_local0 )
																									end
																									
																									f59_arg0:beginAnimation( 9 )
																									f59_arg0:setLeftRight( 0, 0, 64, 74 )
																									f59_arg0:registerEventHandler( "transition_complete_keyframe", f59_local0 )
																								end
																								
																								f58_arg0:beginAnimation( 190 )
																								f58_arg0:registerEventHandler( "transition_complete_keyframe", f58_local0 )
																							end
																							
																							f57_arg0:beginAnimation( 9 )
																							f57_arg0:setLeftRight( 0, 0, 58, 68 )
																							f57_arg0:registerEventHandler( "transition_complete_keyframe", f57_local0 )
																						end
																						
																						f56_arg0:beginAnimation( 189 )
																						f56_arg0:registerEventHandler( "transition_complete_keyframe", f56_local0 )
																					end
																					
																					f55_arg0:beginAnimation( 9 )
																					f55_arg0:setLeftRight( 0, 0, 51, 61 )
																					f55_arg0:registerEventHandler( "transition_complete_keyframe", f55_local0 )
																				end
																				
																				f54_arg0:beginAnimation( 190 )
																				f54_arg0:registerEventHandler( "transition_complete_keyframe", f54_local0 )
																			end
																			
																			f53_arg0:beginAnimation( 9 )
																			f53_arg0:setLeftRight( 0, 0, 44, 54 )
																			f53_arg0:registerEventHandler( "transition_complete_keyframe", f53_local0 )
																		end
																		
																		f52_arg0:beginAnimation( 189 )
																		f52_arg0:registerEventHandler( "transition_complete_keyframe", f52_local0 )
																	end
																	
																	f51_arg0:beginAnimation( 9 )
																	f51_arg0:setLeftRight( 0, 0, 38, 48 )
																	f51_arg0:registerEventHandler( "transition_complete_keyframe", f51_local0 )
																end
																
																f50_arg0:beginAnimation( 190 )
																f50_arg0:registerEventHandler( "transition_complete_keyframe", f50_local0 )
															end
															
															f49_arg0:beginAnimation( 9 )
															f49_arg0:setLeftRight( 0, 0, 32, 42 )
															f49_arg0:registerEventHandler( "transition_complete_keyframe", f49_local0 )
														end
														
														f48_arg0:beginAnimation( 189 )
														f48_arg0:registerEventHandler( "transition_complete_keyframe", f48_local0 )
													end
													
													f47_arg0:beginAnimation( 9 )
													f47_arg0:setLeftRight( 0, 0, 24, 34 )
													f47_arg0:registerEventHandler( "transition_complete_keyframe", f47_local0 )
												end
												
												f46_arg0:beginAnimation( 190 )
												f46_arg0:registerEventHandler( "transition_complete_keyframe", f46_local0 )
											end
											
											f45_arg0:beginAnimation( 9 )
											f45_arg0:setLeftRight( 0, 0, 18, 28 )
											f45_arg0:registerEventHandler( "transition_complete_keyframe", f45_local0 )
										end
										
										f44_arg0:beginAnimation( 190 )
										f44_arg0:registerEventHandler( "transition_complete_keyframe", f44_local0 )
									end
									
									f43_arg0:beginAnimation( 9 )
									f43_arg0:setLeftRight( 0, 0, 12, 22 )
									f43_arg0:registerEventHandler( "transition_complete_keyframe", f43_local0 )
								end
								
								f42_arg0:beginAnimation( 190 )
								f42_arg0:registerEventHandler( "transition_complete_keyframe", f42_local0 )
							end
							
							f41_arg0:beginAnimation( 9 )
							f41_arg0:setLeftRight( 0, 0, 6, 16 )
							f41_arg0:registerEventHandler( "transition_complete_keyframe", f41_local0 )
						end
						
						f40_arg0:beginAnimation( 169 )
						f40_arg0:registerEventHandler( "transition_complete_keyframe", f40_local0 )
					end
					
					f39_arg0:beginAnimation( 100 )
					f39_arg0:setAlpha( 1 )
					f39_arg0:registerEventHandler( "transition_complete_keyframe", f39_local0 )
				end
				
				f3_arg0.TopFuiBoxAdd:beginAnimation( 200 )
				f3_arg0.TopFuiBoxAdd:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.TopFuiBoxAdd:registerEventHandler( "transition_complete_keyframe", f38_local0 )
			end
			
			f3_arg0.TopFuiBoxAdd:completeAnimation()
			f3_arg0.TopFuiBoxAdd:setLeftRight( 0, 0, 0, 10 )
			f3_arg0.TopFuiBoxAdd:setAlpha( 0 )
			f3_local1( f3_arg0.TopFuiBoxAdd )
			f3_arg0.nextClip = "DefaultClip"
		end
	}
}
