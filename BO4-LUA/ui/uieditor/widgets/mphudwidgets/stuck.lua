
CoD.Stuck = InheritFrom( LUI.UIElement )
CoD.Stuck.__defaultWidth = 256
CoD.Stuck.__defaultHeight = 256
CoD.Stuck.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	CoD.BaseUtility.InitControllerModelIfNotSet( f1_arg1, "hudItems.stuckImageIndex", 0 )
	self:setClass( CoD.Stuck )
	self.id = "Stuck"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local graphicflare = LUI.UIImage.new( 0.5, 0.5, -128, 128, 0.5, 0.5, -128, 128 )
	graphicflare:setRGB( 0.47, 0.08, 0.08 )
	graphicflare:setAlpha( 0 )
	graphicflare:setScale( 0.01, 0.01 )
	graphicflare:setImage( RegisterImage( 0xA95C65FF6596C99 ) )
	self:addElement( graphicflare )
	self.graphicflare = graphicflare
	
	local stuckImage = LUI.UIImage.new( 0.5, 0.5, -64, 64, 0.5, 0.5, -64, 64 )
	stuckImage:setAlpha( 0 )
	stuckImage:setScale( 0.15, 0.15 )
	stuckImage:setImage( RegisterImage( 0x67ED81974932916 ) )
	self:addElement( stuckImage )
	self.stuckImage = stuckImage
	
	self:mergeStateConditions( {
		{
			stateName = "StuckSemtex",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsModelValueEqualToEnum( f1_arg1, "hudItems.stuckImageIndex", CoD.HUDUtility.StuckImages.SEMTEX )
			end
		},
		{
			stateName = "StuckSparrow",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsModelValueEqualToEnum( f1_arg1, "hudItems.stuckImageIndex", CoD.HUDUtility.StuckImages.SPARROW )
			end
		}
	} )
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947]( f1_arg1 )
	f1_local4( f1_local3, f1_local5["hudItems.stuckImageIndex"], function ( f4_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "hudItems.stuckImageIndex"
		} )
	end, false )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.Stuck.__resetProperties = function ( f5_arg0 )
	f5_arg0.stuckImage:completeAnimation()
	f5_arg0.graphicflare:completeAnimation()
	f5_arg0.stuckImage:setLeftRight( 0.5, 0.5, -64, 64 )
	f5_arg0.stuckImage:setTopBottom( 0.5, 0.5, -64, 64 )
	f5_arg0.stuckImage:setRGB( 1, 1, 1 )
	f5_arg0.stuckImage:setAlpha( 0 )
	f5_arg0.stuckImage:setScale( 0.15, 0.15 )
	f5_arg0.stuckImage:setImage( RegisterImage( 0x67ED81974932916 ) )
	f5_arg0.graphicflare:setLeftRight( 0.5, 0.5, -128, 128 )
	f5_arg0.graphicflare:setTopBottom( 0.5, 0.5, -128, 128 )
	f5_arg0.graphicflare:setRGB( 0.47, 0.08, 0.08 )
	f5_arg0.graphicflare:setAlpha( 0 )
	f5_arg0.graphicflare:setScale( 0.01, 0.01 )
end
CoD.Stuck.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f6_arg0, f6_arg1 )
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter( 0 )
		end
	},
	StuckSemtex = {
		DefaultClip = function ( f7_arg0, f7_arg1 )
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter( 2 )
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
																																				f40_arg0:beginAnimation( 19 )
																																				f40_arg0:setAlpha( 0 )
																																				f40_arg0:registerEventHandler( "transition_complete_keyframe", f7_arg0.clipFinished )
																																			end
																																			
																																			f39_arg0:beginAnimation( 9 )
																																			f39_arg0:setAlpha( 1 )
																																			f39_arg0:registerEventHandler( "transition_complete_keyframe", f39_local0 )
																																		end
																																		
																																		f38_arg0:beginAnimation( 9 )
																																		f38_arg0:registerEventHandler( "transition_complete_keyframe", f38_local0 )
																																	end
																																	
																																	f37_arg0:beginAnimation( 9 )
																																	f37_arg0:setAlpha( 0 )
																																	f37_arg0:registerEventHandler( "transition_complete_keyframe", f37_local0 )
																																end
																																
																																f36_arg0:beginAnimation( 19 )
																																f36_arg0:setAlpha( 1 )
																																f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
																															end
																															
																															f35_arg0:beginAnimation( 20 )
																															f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
																														end
																														
																														f34_arg0:beginAnimation( 9 )
																														f34_arg0:setAlpha( 0 )
																														f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
																													end
																													
																													f33_arg0:beginAnimation( 19 )
																													f33_arg0:setAlpha( 1 )
																													f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
																												end
																												
																												f32_arg0:beginAnimation( 29 )
																												f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
																											end
																											
																											f31_arg0:beginAnimation( 9 )
																											f31_arg0:setAlpha( 0 )
																											f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
																										end
																										
																										f30_arg0:beginAnimation( 40 )
																										f30_arg0:setAlpha( 1 )
																										f30_arg0:setScale( 0.2, 0.2 )
																										f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
																									end
																									
																									f29_arg0:beginAnimation( 29 )
																									f29_arg0:setScale( 0.3, 0.3 )
																									f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
																								end
																								
																								f28_arg0:beginAnimation( 20 )
																								f28_arg0:setAlpha( 0 )
																								f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
																							end
																							
																							f27_arg0:beginAnimation( 39 )
																							f27_arg0:setAlpha( 1 )
																							f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
																						end
																						
																						f26_arg0:beginAnimation( 30 )
																						f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
																					end
																					
																					f25_arg0:beginAnimation( 29 )
																					f25_arg0:setAlpha( 0 )
																					f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
																				end
																				
																				f24_arg0:beginAnimation( 40 )
																				f24_arg0:setAlpha( 1 )
																				f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
																			end
																			
																			f23_arg0:beginAnimation( 29 )
																			f23_arg0:registerEventHandler( "transition_complete_keyframe", f23_local0 )
																		end
																		
																		f22_arg0:beginAnimation( 30 )
																		f22_arg0:setAlpha( 0 )
																		f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
																	end
																	
																	f21_arg0:beginAnimation( 39 )
																	f21_arg0:setAlpha( 1 )
																	f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
																end
																
																f20_arg0:beginAnimation( 30 )
																f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
															end
															
															f19_arg0:beginAnimation( 19 )
															f19_arg0:setAlpha( 0 )
															f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
														end
														
														f18_arg0:beginAnimation( 39 )
														f18_arg0:setAlpha( 1 )
														f18_arg0:setScale( 0.2, 0.2 )
														f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
													end
													
													f17_arg0:beginAnimation( 0 )
													f17_arg0:setScale( 0.3, 0.3 )
													f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
												end
												
												f16_arg0:beginAnimation( 29 )
												f16_arg0:registerEventHandler( "transition_complete_keyframe", f16_local0 )
											end
											
											f15_arg0:beginAnimation( 30 )
											f15_arg0:setAlpha( 0 )
											f15_arg0:registerEventHandler( "transition_complete_keyframe", f15_local0 )
										end
										
										f14_arg0:beginAnimation( 39 )
										f14_arg0:setAlpha( 1 )
										f14_arg0:setScale( 0.2, 0.2 )
										f14_arg0:registerEventHandler( "transition_complete_keyframe", f14_local0 )
									end
									
									f13_arg0:beginAnimation( 30 )
									f13_arg0:setScale( 0.3, 0.3 )
									f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
								end
								
								f12_arg0:beginAnimation( 39 )
								f12_arg0:setAlpha( 0 )
								f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
							end
							
							f11_arg0:beginAnimation( 39 )
							f11_arg0:setAlpha( 1 )
							f11_arg0:setScale( 0.2, 0.2 )
							f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
						end
						
						f10_arg0:beginAnimation( 30 )
						f10_arg0:setAlpha( 0 )
						f10_arg0:setScale( 0.3, 0.3 )
						f10_arg0:registerEventHandler( "transition_complete_keyframe", f10_local0 )
					end
					
					f9_arg0:beginAnimation( 60 )
					f9_arg0:setAlpha( 1 )
					f9_arg0:setScale( 0.4, 0.4 )
					f9_arg0:registerEventHandler( "transition_complete_keyframe", f9_local0 )
				end
				
				f8_arg0:beginAnimation( 100 )
				f8_arg0:setAlpha( 0.8 )
				f8_arg0:setScale( 0.9, 0.9 )
				f8_arg0:registerEventHandler( "transition_complete_keyframe", f8_local0 )
			end
			
			f7_arg0.graphicflare:beginAnimation( 170 )
			f7_arg0.graphicflare:setLeftRight( 0.5, 0.5, -128, 128 )
			f7_arg0.graphicflare:setTopBottom( 0.5, 0.5, -128, 128 )
			f7_arg0.graphicflare:setRGB( 0.63, 0.08, 0.08 )
			f7_arg0.graphicflare:setAlpha( 0 )
			f7_arg0.graphicflare:setScale( 0, 0 )
			f7_arg0.graphicflare:registerEventHandler( "interrupted_keyframe", f7_arg0.clipInterrupted )
			f7_arg0.graphicflare:registerEventHandler( "transition_complete_keyframe", f7_local0 )
			local f7_local1 = function ( f41_arg0 )
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
															f52_arg0:beginAnimation( 30 )
															f52_arg0:setAlpha( 0 )
															f52_arg0:registerEventHandler( "transition_complete_keyframe", f7_arg0.clipFinished )
														end
														
														f51_arg0:beginAnimation( 9 )
														f51_arg0:setAlpha( 1 )
														f51_arg0:registerEventHandler( "transition_complete_keyframe", f51_local0 )
													end
													
													f50_arg0:beginAnimation( 90 )
													f50_arg0:setAlpha( 0.9 )
													f50_arg0:registerEventHandler( "transition_complete_keyframe", f50_local0 )
												end
												
												f49_arg0:beginAnimation( 139 )
												f49_arg0:setAlpha( 0.75 )
												f49_arg0:registerEventHandler( "transition_complete_keyframe", f49_local0 )
											end
											
											f48_arg0:beginAnimation( 140 )
											f48_arg0:setAlpha( 1 )
											f48_arg0:registerEventHandler( "transition_complete_keyframe", f48_local0 )
										end
										
										f47_arg0:beginAnimation( 149 )
										f47_arg0:setAlpha( 0.75 )
										f47_arg0:registerEventHandler( "transition_complete_keyframe", f47_local0 )
									end
									
									f46_arg0:beginAnimation( 160 )
									f46_arg0:setAlpha( 1 )
									f46_arg0:registerEventHandler( "transition_complete_keyframe", f46_local0 )
								end
								
								f45_arg0:beginAnimation( 60 )
								f45_arg0:setAlpha( 0.75 )
								f45_arg0:registerEventHandler( "transition_complete_keyframe", f45_local0 )
							end
							
							f44_arg0:beginAnimation( 9, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
							f44_arg0:setScale( 0.25, 0.25 )
							f44_arg0:registerEventHandler( "transition_complete_keyframe", f44_local0 )
						end
						
						f43_arg0:beginAnimation( 140 )
						f43_arg0:setScale( 0.2, 0.2 )
						f43_arg0:registerEventHandler( "transition_complete_keyframe", f43_local0 )
					end
					
					f42_arg0:beginAnimation( 79 )
					f42_arg0:setScale( 1, 1 )
					f42_arg0:registerEventHandler( "transition_complete_keyframe", f42_local0 )
				end
				
				f41_arg0:beginAnimation( 110, Enum[0xF50FFF429AB1890][0x53CEB9A0427197] )
				f41_arg0:setScale( 0.5, 0.5 )
				f41_arg0:registerEventHandler( "transition_complete_keyframe", f41_local0 )
			end
			
			f7_arg0.stuckImage:beginAnimation( 70 )
			f7_arg0.stuckImage:setLeftRight( 0.5, 0.5, -64, 64 )
			f7_arg0.stuckImage:setTopBottom( 0.5, 0.5, -64, 64 )
			f7_arg0.stuckImage:setRGB( 0.69, 0.08, 0.08 )
			f7_arg0.stuckImage:setAlpha( 1 )
			f7_arg0.stuckImage:setScale( 0, 0 )
			f7_arg0.stuckImage:registerEventHandler( "interrupted_keyframe", f7_arg0.clipInterrupted )
			f7_arg0.stuckImage:registerEventHandler( "transition_complete_keyframe", f7_local1 )
			f7_arg0.nextClip = "DefaultClip"
		end
	},
	StuckSparrow = {
		DefaultClip = function ( f53_arg0, f53_arg1 )
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter( 2 )
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
																					local f71_local0 = function ( f72_arg0 )
																						local f72_local0 = function ( f73_arg0 )
																							local f73_local0 = function ( f74_arg0 )
																								local f74_local0 = function ( f75_arg0 )
																									local f75_local0 = function ( f76_arg0 )
																										local f76_local0 = function ( f77_arg0 )
																											local f77_local0 = function ( f78_arg0 )
																												local f78_local0 = function ( f79_arg0 )
																													local f79_local0 = function ( f80_arg0 )
																														local f80_local0 = function ( f81_arg0 )
																															local f81_local0 = function ( f82_arg0 )
																																local f82_local0 = function ( f83_arg0 )
																																	local f83_local0 = function ( f84_arg0 )
																																		local f84_local0 = function ( f85_arg0 )
																																			local f85_local0 = function ( f86_arg0 )
																																				f86_arg0:beginAnimation( 19 )
																																				f86_arg0:setAlpha( 0 )
																																				f86_arg0:registerEventHandler( "transition_complete_keyframe", f53_arg0.clipFinished )
																																			end
																																			
																																			f85_arg0:beginAnimation( 9 )
																																			f85_arg0:setAlpha( 1 )
																																			f85_arg0:registerEventHandler( "transition_complete_keyframe", f85_local0 )
																																		end
																																		
																																		f84_arg0:beginAnimation( 9 )
																																		f84_arg0:registerEventHandler( "transition_complete_keyframe", f84_local0 )
																																	end
																																	
																																	f83_arg0:beginAnimation( 9 )
																																	f83_arg0:setAlpha( 0 )
																																	f83_arg0:registerEventHandler( "transition_complete_keyframe", f83_local0 )
																																end
																																
																																f82_arg0:beginAnimation( 19 )
																																f82_arg0:setAlpha( 1 )
																																f82_arg0:registerEventHandler( "transition_complete_keyframe", f82_local0 )
																															end
																															
																															f81_arg0:beginAnimation( 20 )
																															f81_arg0:registerEventHandler( "transition_complete_keyframe", f81_local0 )
																														end
																														
																														f80_arg0:beginAnimation( 9 )
																														f80_arg0:setAlpha( 0 )
																														f80_arg0:registerEventHandler( "transition_complete_keyframe", f80_local0 )
																													end
																													
																													f79_arg0:beginAnimation( 19 )
																													f79_arg0:setAlpha( 1 )
																													f79_arg0:registerEventHandler( "transition_complete_keyframe", f79_local0 )
																												end
																												
																												f78_arg0:beginAnimation( 29 )
																												f78_arg0:registerEventHandler( "transition_complete_keyframe", f78_local0 )
																											end
																											
																											f77_arg0:beginAnimation( 9 )
																											f77_arg0:setAlpha( 0 )
																											f77_arg0:registerEventHandler( "transition_complete_keyframe", f77_local0 )
																										end
																										
																										f76_arg0:beginAnimation( 40 )
																										f76_arg0:setAlpha( 1 )
																										f76_arg0:setScale( 0.2, 0.2 )
																										f76_arg0:registerEventHandler( "transition_complete_keyframe", f76_local0 )
																									end
																									
																									f75_arg0:beginAnimation( 29 )
																									f75_arg0:setScale( 0.3, 0.3 )
																									f75_arg0:registerEventHandler( "transition_complete_keyframe", f75_local0 )
																								end
																								
																								f74_arg0:beginAnimation( 20 )
																								f74_arg0:setAlpha( 0 )
																								f74_arg0:registerEventHandler( "transition_complete_keyframe", f74_local0 )
																							end
																							
																							f73_arg0:beginAnimation( 39 )
																							f73_arg0:setAlpha( 1 )
																							f73_arg0:registerEventHandler( "transition_complete_keyframe", f73_local0 )
																						end
																						
																						f72_arg0:beginAnimation( 30 )
																						f72_arg0:registerEventHandler( "transition_complete_keyframe", f72_local0 )
																					end
																					
																					f71_arg0:beginAnimation( 29 )
																					f71_arg0:setAlpha( 0 )
																					f71_arg0:registerEventHandler( "transition_complete_keyframe", f71_local0 )
																				end
																				
																				f70_arg0:beginAnimation( 40 )
																				f70_arg0:setAlpha( 1 )
																				f70_arg0:registerEventHandler( "transition_complete_keyframe", f70_local0 )
																			end
																			
																			f69_arg0:beginAnimation( 29 )
																			f69_arg0:registerEventHandler( "transition_complete_keyframe", f69_local0 )
																		end
																		
																		f68_arg0:beginAnimation( 30 )
																		f68_arg0:setAlpha( 0 )
																		f68_arg0:registerEventHandler( "transition_complete_keyframe", f68_local0 )
																	end
																	
																	f67_arg0:beginAnimation( 39 )
																	f67_arg0:setAlpha( 1 )
																	f67_arg0:registerEventHandler( "transition_complete_keyframe", f67_local0 )
																end
																
																f66_arg0:beginAnimation( 30 )
																f66_arg0:registerEventHandler( "transition_complete_keyframe", f66_local0 )
															end
															
															f65_arg0:beginAnimation( 19 )
															f65_arg0:setAlpha( 0 )
															f65_arg0:registerEventHandler( "transition_complete_keyframe", f65_local0 )
														end
														
														f64_arg0:beginAnimation( 39 )
														f64_arg0:setAlpha( 1 )
														f64_arg0:setScale( 0.2, 0.2 )
														f64_arg0:registerEventHandler( "transition_complete_keyframe", f64_local0 )
													end
													
													f63_arg0:beginAnimation( 0 )
													f63_arg0:setScale( 0.3, 0.3 )
													f63_arg0:registerEventHandler( "transition_complete_keyframe", f63_local0 )
												end
												
												f62_arg0:beginAnimation( 29 )
												f62_arg0:registerEventHandler( "transition_complete_keyframe", f62_local0 )
											end
											
											f61_arg0:beginAnimation( 30 )
											f61_arg0:setAlpha( 0 )
											f61_arg0:registerEventHandler( "transition_complete_keyframe", f61_local0 )
										end
										
										f60_arg0:beginAnimation( 39 )
										f60_arg0:setAlpha( 1 )
										f60_arg0:setScale( 0.2, 0.2 )
										f60_arg0:registerEventHandler( "transition_complete_keyframe", f60_local0 )
									end
									
									f59_arg0:beginAnimation( 30 )
									f59_arg0:setScale( 0.3, 0.3 )
									f59_arg0:registerEventHandler( "transition_complete_keyframe", f59_local0 )
								end
								
								f58_arg0:beginAnimation( 39 )
								f58_arg0:setAlpha( 0 )
								f58_arg0:registerEventHandler( "transition_complete_keyframe", f58_local0 )
							end
							
							f57_arg0:beginAnimation( 39 )
							f57_arg0:setAlpha( 1 )
							f57_arg0:setScale( 0.2, 0.2 )
							f57_arg0:registerEventHandler( "transition_complete_keyframe", f57_local0 )
						end
						
						f56_arg0:beginAnimation( 30 )
						f56_arg0:setAlpha( 0 )
						f56_arg0:setScale( 0.3, 0.3 )
						f56_arg0:registerEventHandler( "transition_complete_keyframe", f56_local0 )
					end
					
					f55_arg0:beginAnimation( 60 )
					f55_arg0:setAlpha( 1 )
					f55_arg0:setScale( 0.4, 0.4 )
					f55_arg0:registerEventHandler( "transition_complete_keyframe", f55_local0 )
				end
				
				f54_arg0:beginAnimation( 100 )
				f54_arg0:setAlpha( 0.8 )
				f54_arg0:setScale( 0.9, 0.9 )
				f54_arg0:registerEventHandler( "transition_complete_keyframe", f54_local0 )
			end
			
			f53_arg0.graphicflare:beginAnimation( 170 )
			f53_arg0.graphicflare:setLeftRight( 0.5, 0.5, -128, 128 )
			f53_arg0.graphicflare:setTopBottom( 0.5, 0.5, -128, 128 )
			f53_arg0.graphicflare:setRGB( 0.63, 0.08, 0.08 )
			f53_arg0.graphicflare:setAlpha( 0 )
			f53_arg0.graphicflare:setScale( 0, 0 )
			f53_arg0.graphicflare:registerEventHandler( "interrupted_keyframe", f53_arg0.clipInterrupted )
			f53_arg0.graphicflare:registerEventHandler( "transition_complete_keyframe", f53_local0 )
			local f53_local1 = function ( f87_arg0 )
				local f87_local0 = function ( f88_arg0 )
					local f88_local0 = function ( f89_arg0 )
						local f89_local0 = function ( f90_arg0 )
							local f90_local0 = function ( f91_arg0 )
								local f91_local0 = function ( f92_arg0 )
									local f92_local0 = function ( f93_arg0 )
										local f93_local0 = function ( f94_arg0 )
											local f94_local0 = function ( f95_arg0 )
												local f95_local0 = function ( f96_arg0 )
													local f96_local0 = function ( f97_arg0 )
														local f97_local0 = function ( f98_arg0 )
															local f98_local0 = function ( f99_arg0 )
																f99_arg0:beginAnimation( 30 )
																f99_arg0:setAlpha( 0 )
																f99_arg0:registerEventHandler( "transition_complete_keyframe", f53_arg0.clipFinished )
															end
															
															f98_arg0:beginAnimation( 9 )
															f98_arg0:setAlpha( 1 )
															f98_arg0:registerEventHandler( "transition_complete_keyframe", f98_local0 )
														end
														
														f97_arg0:beginAnimation( 90 )
														f97_arg0:setAlpha( 0.9 )
														f97_arg0:registerEventHandler( "transition_complete_keyframe", f97_local0 )
													end
													
													f96_arg0:beginAnimation( 139 )
													f96_arg0:setAlpha( 0.75 )
													f96_arg0:registerEventHandler( "transition_complete_keyframe", f96_local0 )
												end
												
												f95_arg0:beginAnimation( 140 )
												f95_arg0:setAlpha( 1 )
												f95_arg0:registerEventHandler( "transition_complete_keyframe", f95_local0 )
											end
											
											f94_arg0:beginAnimation( 149 )
											f94_arg0:setAlpha( 0.75 )
											f94_arg0:registerEventHandler( "transition_complete_keyframe", f94_local0 )
										end
										
										f93_arg0:beginAnimation( 160 )
										f93_arg0:setAlpha( 1 )
										f93_arg0:registerEventHandler( "transition_complete_keyframe", f93_local0 )
									end
									
									f92_arg0:beginAnimation( 60 )
									f92_arg0:setAlpha( 0.75 )
									f92_arg0:registerEventHandler( "transition_complete_keyframe", f92_local0 )
								end
								
								f91_arg0:beginAnimation( 9, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
								f91_arg0:setScale( 0.25, 0.25 )
								f91_arg0:registerEventHandler( "transition_complete_keyframe", f91_local0 )
							end
							
							f90_arg0:beginAnimation( 140 )
							f90_arg0:setScale( 0.2, 0.2 )
							f90_arg0:registerEventHandler( "transition_complete_keyframe", f90_local0 )
						end
						
						f89_arg0:beginAnimation( 79 )
						f89_arg0:setScale( 1, 1 )
						f89_arg0:registerEventHandler( "transition_complete_keyframe", f89_local0 )
					end
					
					f88_arg0:beginAnimation( 110, Enum[0xF50FFF429AB1890][0x53CEB9A0427197] )
					f88_arg0:setScale( 0.5, 0.5 )
					f88_arg0:registerEventHandler( "transition_complete_keyframe", f88_local0 )
				end
				
				f53_arg0.stuckImage:beginAnimation( 70 )
				f53_arg0.stuckImage:registerEventHandler( "interrupted_keyframe", f53_arg0.clipInterrupted )
				f53_arg0.stuckImage:registerEventHandler( "transition_complete_keyframe", f87_local0 )
			end
			
			f53_arg0.stuckImage:completeAnimation()
			f53_arg0.stuckImage:setLeftRight( 0.5, 0.5, -64, 64 )
			f53_arg0.stuckImage:setTopBottom( 0.5, 0.5, -64, 64 )
			f53_arg0.stuckImage:setRGB( 0.69, 0.08, 0.08 )
			f53_arg0.stuckImage:setAlpha( 1 )
			f53_arg0.stuckImage:setScale( 0, 0 )
			f53_arg0.stuckImage:setImage( RegisterImage( 0xCE38EA7E907DBD8 ) )
			f53_local1( f53_arg0.stuckImage )
			f53_arg0.nextClip = "DefaultClip"
		end
	}
}
