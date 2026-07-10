
CoD.CallingCards_Asset_grunt_gun = InheritFrom( LUI.UIElement )
CoD.CallingCards_Asset_grunt_gun.__defaultWidth = 608
CoD.CallingCards_Asset_grunt_gun.__defaultHeight = 240
CoD.CallingCards_Asset_grunt_gun.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.CallingCards_Asset_grunt_gun )
	self.id = "CallingCards_Asset_grunt_gun"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local gun = LUI.UIImage.new( 0, 0, 0, 304, 0, 0, 0, 240 )
	gun:setImage( RegisterImage( @"uie_grunt_gun" ) )
	self:addElement( gun )
	self.gun = gun
	
	local gunFirelight = LUI.UIImage.new( 0, 0, 0, 304, 0, 0, 0, 240 )
	gunFirelight:setAlpha( 0 )
	gunFirelight:setImage( RegisterImage( @"uie_grunt_gun_light" ) )
	self:addElement( gunFirelight )
	self.gunFirelight = gunFirelight
	
	local bullets = LUI.UIImage.new( 0, 0, -211, 180, 0, 0, -81, 180 )
	bullets:setAlpha( 0 )
	bullets:setImage( RegisterImage( @"uie_grunt_bullet_shot" ) )
	bullets:setMaterial( LUI.UIImage.GetCachedMaterial( @"uie_flipbook" ) )
	bullets:setShaderVector( 0, 0, 6, 0, 0 )
	bullets:setShaderVector( 1, 12, 0, 0, 0 )
	self:addElement( bullets )
	self.bullets = bullets
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.CallingCards_Asset_grunt_gun.__resetProperties = function ( f2_arg0 )
	f2_arg0.gun:completeAnimation()
	f2_arg0.bullets:completeAnimation()
	f2_arg0.gunFirelight:completeAnimation()
	f2_arg0.gun:setTopBottom( 0, 0, 0, 240 )
	f2_arg0.gun:setZRot( 0 )
	f2_arg0.bullets:setLeftRight( 0, 0, -211, 180 )
	f2_arg0.bullets:setTopBottom( 0, 0, -81, 180 )
	f2_arg0.bullets:setAlpha( 0 )
	f2_arg0.bullets:setZRot( 0 )
	f2_arg0.bullets:setShaderVector( 0, 0, 6, 0, 0 )
	f2_arg0.bullets:setShaderVector( 1, 12, 0, 0, 0 )
	f2_arg0.gunFirelight:setLeftRight( 0, 0, 0, 304 )
	f2_arg0.gunFirelight:setTopBottom( 0, 0, 0, 240 )
	f2_arg0.gunFirelight:setAlpha( 0 )
	f2_arg0.gunFirelight:setZRot( 0 )
end
CoD.CallingCards_Asset_grunt_gun.__clipsPerState = {
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
									f9_arg0:beginAnimation( 850 )
									f9_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
								end
								
								f8_arg0:beginAnimation( 99 )
								f8_arg0:setTopBottom( 0, 0, 0, 240 )
								f8_arg0:setZRot( 0 )
								f8_arg0:registerEventHandler( "transition_complete_keyframe", f8_local0 )
							end
							
							f7_arg0:beginAnimation( 829 )
							f7_arg0:registerEventHandler( "transition_complete_keyframe", f7_local0 )
						end
						
						f6_arg0:beginAnimation( 10 )
						f6_arg0:registerEventHandler( "transition_complete_keyframe", f6_local0 )
					end
					
					f5_arg0:beginAnimation( 169 )
					f5_arg0:setTopBottom( 0, 0, -43, 197 )
					f5_arg0:setZRot( -20 )
					f5_arg0:registerEventHandler( "transition_complete_keyframe", f5_local0 )
				end
				
				f3_arg0.gun:beginAnimation( 1010 )
				f3_arg0.gun:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.gun:registerEventHandler( "transition_complete_keyframe", f4_local0 )
			end
			
			f3_arg0.gun:completeAnimation()
			f3_arg0.gun:setTopBottom( 0, 0, 0, 240 )
			f3_arg0.gun:setZRot( 0 )
			f3_local0( f3_arg0.gun )
			local f3_local1 = function ( f10_arg0 )
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
																																																					f59_arg0:beginAnimation( 19 )
																																																					f59_arg0:setAlpha( 0 )
																																																					f59_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
																																																				end
																																																				
																																																				f58_arg0:beginAnimation( 39 )
																																																				f58_arg0:setAlpha( 1 )
																																																				f58_arg0:registerEventHandler( "transition_complete_keyframe", f58_local0 )
																																																			end
																																																			
																																																			f57_arg0:beginAnimation( 40 )
																																																			f57_arg0:setAlpha( 0 )
																																																			f57_arg0:registerEventHandler( "transition_complete_keyframe", f57_local0 )
																																																		end
																																																		
																																																		f56_arg0:beginAnimation( 39 )
																																																		f56_arg0:setAlpha( 1 )
																																																		f56_arg0:registerEventHandler( "transition_complete_keyframe", f56_local0 )
																																																	end
																																																	
																																																	f55_arg0:beginAnimation( 39 )
																																																	f55_arg0:registerEventHandler( "transition_complete_keyframe", f55_local0 )
																																																end
																																																
																																																f54_arg0:beginAnimation( 39 )
																																																f54_arg0:setAlpha( 0 )
																																																f54_arg0:registerEventHandler( "transition_complete_keyframe", f54_local0 )
																																															end
																																															
																																															f53_arg0:beginAnimation( 39 )
																																															f53_arg0:registerEventHandler( "transition_complete_keyframe", f53_local0 )
																																														end
																																														
																																														f52_arg0:beginAnimation( 39 )
																																														f52_arg0:setAlpha( 1 )
																																														f52_arg0:registerEventHandler( "transition_complete_keyframe", f52_local0 )
																																													end
																																													
																																													f51_arg0:beginAnimation( 39 )
																																													f51_arg0:registerEventHandler( "transition_complete_keyframe", f51_local0 )
																																												end
																																												
																																												f50_arg0:beginAnimation( 40 )
																																												f50_arg0:setAlpha( 0 )
																																												f50_arg0:registerEventHandler( "transition_complete_keyframe", f50_local0 )
																																											end
																																											
																																											f49_arg0:beginAnimation( 39 )
																																											f49_arg0:registerEventHandler( "transition_complete_keyframe", f49_local0 )
																																										end
																																										
																																										f48_arg0:beginAnimation( 39 )
																																										f48_arg0:setAlpha( 1 )
																																										f48_arg0:registerEventHandler( "transition_complete_keyframe", f48_local0 )
																																									end
																																									
																																									f47_arg0:beginAnimation( 39 )
																																									f47_arg0:registerEventHandler( "transition_complete_keyframe", f47_local0 )
																																								end
																																								
																																								f46_arg0:beginAnimation( 39 )
																																								f46_arg0:setAlpha( 0 )
																																								f46_arg0:registerEventHandler( "transition_complete_keyframe", f46_local0 )
																																							end
																																							
																																							f45_arg0:beginAnimation( 39 )
																																							f45_arg0:registerEventHandler( "transition_complete_keyframe", f45_local0 )
																																						end
																																						
																																						f44_arg0:beginAnimation( 40 )
																																						f44_arg0:setAlpha( 1 )
																																						f44_arg0:registerEventHandler( "transition_complete_keyframe", f44_local0 )
																																					end
																																					
																																					f43_arg0:beginAnimation( 39 )
																																					f43_arg0:registerEventHandler( "transition_complete_keyframe", f43_local0 )
																																				end
																																				
																																				f42_arg0:beginAnimation( 39 )
																																				f42_arg0:setAlpha( 0 )
																																				f42_arg0:registerEventHandler( "transition_complete_keyframe", f42_local0 )
																																			end
																																			
																																			f41_arg0:beginAnimation( 29 )
																																			f41_arg0:registerEventHandler( "transition_complete_keyframe", f41_local0 )
																																		end
																																		
																																		f40_arg0:beginAnimation( 39 )
																																		f40_arg0:setAlpha( 1 )
																																		f40_arg0:registerEventHandler( "transition_complete_keyframe", f40_local0 )
																																	end
																																	
																																	f39_arg0:beginAnimation( 39 )
																																	f39_arg0:registerEventHandler( "transition_complete_keyframe", f39_local0 )
																																end
																																
																																f38_arg0:beginAnimation( 40 )
																																f38_arg0:registerEventHandler( "transition_complete_keyframe", f38_local0 )
																															end
																															
																															f37_arg0:beginAnimation( 9 )
																															f37_arg0:registerEventHandler( "transition_complete_keyframe", f37_local0 )
																														end
																														
																														f36_arg0:beginAnimation( 1129 )
																														f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
																													end
																													
																													f35_arg0:beginAnimation( 20 )
																													f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
																												end
																												
																												f34_arg0:beginAnimation( 9 )
																												f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
																											end
																											
																											f33_arg0:beginAnimation( 79 )
																											f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
																										end
																										
																										f32_arg0:beginAnimation( 9 )
																										f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
																									end
																									
																									f31_arg0:beginAnimation( 40 )
																									f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
																								end
																								
																								f30_arg0:beginAnimation( 40 )
																								f30_arg0:setAlpha( 0 )
																								f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
																							end
																							
																							f29_arg0:beginAnimation( 29 )
																							f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
																						end
																						
																						f28_arg0:beginAnimation( 40 )
																						f28_arg0:setAlpha( 1 )
																						f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
																					end
																					
																					f27_arg0:beginAnimation( 39 )
																					f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
																				end
																				
																				f26_arg0:beginAnimation( 40 )
																				f26_arg0:setAlpha( 0 )
																				f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
																			end
																			
																			f25_arg0:beginAnimation( 29 )
																			f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
																		end
																		
																		f24_arg0:beginAnimation( 40 )
																		f24_arg0:setAlpha( 1 )
																		f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
																	end
																	
																	f23_arg0:beginAnimation( 40 )
																	f23_arg0:registerEventHandler( "transition_complete_keyframe", f23_local0 )
																end
																
																f22_arg0:beginAnimation( 39 )
																f22_arg0:setAlpha( 0 )
																f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
															end
															
															f21_arg0:beginAnimation( 39 )
															f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
														end
														
														f20_arg0:beginAnimation( 39 )
														f20_arg0:setAlpha( 1 )
														f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
													end
													
													f19_arg0:beginAnimation( 39 )
													f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
												end
												
												f18_arg0:beginAnimation( 40 )
												f18_arg0:setAlpha( 0 )
												f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
											end
											
											f17_arg0:beginAnimation( 39 )
											f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
										end
										
										f16_arg0:beginAnimation( 40 )
										f16_arg0:setAlpha( 1 )
										f16_arg0:registerEventHandler( "transition_complete_keyframe", f16_local0 )
									end
									
									f15_arg0:beginAnimation( 39 )
									f15_arg0:registerEventHandler( "transition_complete_keyframe", f15_local0 )
								end
								
								f14_arg0:beginAnimation( 40 )
								f14_arg0:setAlpha( 0 )
								f14_arg0:registerEventHandler( "transition_complete_keyframe", f14_local0 )
							end
							
							f13_arg0:beginAnimation( 40 )
							f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
						end
						
						f12_arg0:beginAnimation( 40 )
						f12_arg0:setAlpha( 1 )
						f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
					end
					
					f11_arg0:beginAnimation( 40 )
					f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
				end
				
				f3_arg0.gunFirelight:beginAnimation( 40 )
				f3_arg0.gunFirelight:setAlpha( 0 )
				f3_arg0.gunFirelight:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.gunFirelight:registerEventHandler( "transition_complete_keyframe", f10_local0 )
			end
			
			f3_arg0.gunFirelight:completeAnimation()
			f3_arg0.gunFirelight:setLeftRight( 0, 0, 0, 304 )
			f3_arg0.gunFirelight:setTopBottom( 0, 0, 0, 240 )
			f3_arg0.gunFirelight:setAlpha( 1 )
			f3_arg0.gunFirelight:setZRot( 0 )
			f3_local1( f3_arg0.gunFirelight )
			local f3_local2 = function ( f60_arg0 )
				local f60_local0 = function ( f61_arg0 )
					local f61_local0 = function ( f62_arg0 )
						local f62_local0 = function ( f63_arg0 )
							local f63_local0 = function ( f64_arg0 )
								local f64_local0 = function ( f65_arg0 )
									local f65_local0 = function ( f66_arg0 )
										local f66_local0 = function ( f67_arg0 )
											f67_arg0:beginAnimation( 850 )
											f67_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
										end
										
										f66_arg0:beginAnimation( 29 )
										f66_arg0:setAlpha( 1 )
										f66_arg0:setZRot( 0 )
										f66_arg0:setShaderVector( 1, 12, 0, 0, 0 )
										f66_arg0:registerEventHandler( "transition_complete_keyframe", f66_local0 )
									end
									
									f65_arg0:beginAnimation( 869 )
									f65_arg0:setShaderVector( 1, 12.57, 0, 0, 0 )
									f65_arg0:registerEventHandler( "transition_complete_keyframe", f65_local0 )
								end
								
								f64_arg0:beginAnimation( 29 )
								f64_arg0:setZRot( -19 )
								f64_arg0:setShaderVector( 1, 29.23, 0, 0, 0 )
								f64_arg0:registerEventHandler( "transition_complete_keyframe", f64_local0 )
							end
							
							f63_arg0:beginAnimation( 10 )
							f63_arg0:setShaderVector( 1, 29.81, 0, 0, 0 )
							f63_arg0:registerEventHandler( "transition_complete_keyframe", f63_local0 )
						end
						
						f62_arg0:beginAnimation( 199 )
						f62_arg0:setShaderVector( 1, 30, 0, 0, 0 )
						f62_arg0:registerEventHandler( "transition_complete_keyframe", f62_local0 )
					end
					
					f61_arg0:beginAnimation( 9 )
					f61_arg0:setAlpha( 0 )
					f61_arg0:setShaderVector( 1, 26.95, 0, 0, 0 )
					f61_arg0:registerEventHandler( "transition_complete_keyframe", f61_local0 )
				end
				
				f3_arg0.bullets:beginAnimation( 970 )
				f3_arg0.bullets:setShaderVector( 1, 26.8, 0, 0, 0 )
				f3_arg0.bullets:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.bullets:registerEventHandler( "transition_complete_keyframe", f60_local0 )
			end
			
			f3_arg0.bullets:completeAnimation()
			f3_arg0.bullets:setLeftRight( 0, 0, -211, 180 )
			f3_arg0.bullets:setTopBottom( 0, 0, -81, 180 )
			f3_arg0.bullets:setAlpha( 1 )
			f3_arg0.bullets:setZRot( 0 )
			f3_arg0.bullets:setShaderVector( 0, 0, 6, 0, 0 )
			f3_arg0.bullets:setShaderVector( 1, 12, 0, 0, 0 )
			f3_local2( f3_arg0.bullets )
			f3_arg0.nextClip = "DefaultClip"
		end
	}
}
