
CoD.CommonBgLayoutElement03 = InheritFrom( LUI.UIElement )
CoD.CommonBgLayoutElement03.__defaultWidth = 76
CoD.CommonBgLayoutElement03.__defaultHeight = 380
CoD.CommonBgLayoutElement03.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.CommonBgLayoutElement03 )
	self.id = "CommonBgLayoutElement03"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local BlurBgBoxes01 = LUI.UIImage.new( 0, 0, 0, 76, 0, 0, 0, 380 )
	BlurBgBoxes01:setAlpha( 0.5 )
	BlurBgBoxes01:setImage( RegisterImage( 0x5985039BA568039 ) )
	BlurBgBoxes01:setMaterial( LUI.UIImage.GetCachedMaterial( 0x7EA4827662D4CD4 ) )
	BlurBgBoxes01:setShaderVector( 0, 1, 5, 0, 0 )
	BlurBgBoxes01:setShaderVector( 1, 0, 1, 0, 1 )
	self:addElement( BlurBgBoxes01 )
	self.BlurBgBoxes01 = BlurBgBoxes01
	
	local BoxHighlighted = LUI.UIImage.new( 0, 0, 1, 37, 0, 0, 1, 37 )
	BoxHighlighted:setAlpha( 0.2 )
	BoxHighlighted:setImage( RegisterImage( 0xE24C99B4ACB5275 ) )
	BoxHighlighted:setMaterial( LUI.UIImage.GetCachedMaterial( 0x1CC85D0A86303B0 ) )
	BoxHighlighted:setShaderVector( 0, 2, 0, 0, 0 )
	self:addElement( BoxHighlighted )
	self.BoxHighlighted = BoxHighlighted
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.CommonBgLayoutElement03.__resetProperties = function ( f2_arg0 )
	f2_arg0.BoxHighlighted:completeAnimation()
	f2_arg0.BlurBgBoxes01:completeAnimation()
	f2_arg0.BoxHighlighted:setLeftRight( 0, 0, 1, 37 )
	f2_arg0.BoxHighlighted:setTopBottom( 0, 0, 1, 37 )
	f2_arg0.BoxHighlighted:setAlpha( 0.2 )
	f2_arg0.BlurBgBoxes01:setAlpha( 0.5 )
end
CoD.CommonBgLayoutElement03.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f3_arg0, f3_arg1 )
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter( 2 )
			local f3_local0 = function ( f4_arg0 )
				local f4_local0 = function ( f5_arg0 )
					local f5_local0 = function ( f6_arg0 )
						local f6_local0 = function ( f7_arg0 )
							local f7_local0 = function ( f8_arg0 )
								f8_arg0:beginAnimation( 2000 )
								f8_arg0:setAlpha( 0.3 )
								f8_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
							end
							
							f7_arg0:beginAnimation( 3000 )
							f7_arg0:setAlpha( 0.15 )
							f7_arg0:registerEventHandler( "transition_complete_keyframe", f7_local0 )
						end
						
						f6_arg0:beginAnimation( 3000 )
						f6_arg0:setAlpha( 0.3 )
						f6_arg0:registerEventHandler( "transition_complete_keyframe", f6_local0 )
					end
					
					f5_arg0:beginAnimation( 3000 )
					f5_arg0:registerEventHandler( "transition_complete_keyframe", f5_local0 )
				end
				
				f3_arg0.BlurBgBoxes01:beginAnimation( 1000 )
				f3_arg0.BlurBgBoxes01:setAlpha( 0.15 )
				f3_arg0.BlurBgBoxes01:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.BlurBgBoxes01:registerEventHandler( "transition_complete_keyframe", f4_local0 )
			end
			
			f3_arg0.BlurBgBoxes01:completeAnimation()
			f3_arg0.BlurBgBoxes01:setAlpha( 0.3 )
			f3_local0( f3_arg0.BlurBgBoxes01 )
			local f3_local1 = function ( f9_arg0 )
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
																																	f38_arg0:beginAnimation( 699 )
																																	f38_arg0:setLeftRight( 0, 0, 1, 37 )
																																	f38_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
																																end
																																
																																f37_arg0:beginAnimation( 199 )
																																f37_arg0:setAlpha( 0 )
																																f37_arg0:registerEventHandler( "transition_complete_keyframe", f37_local0 )
																															end
																															
																															f36_arg0:beginAnimation( 200 )
																															f36_arg0:setAlpha( 0.2 )
																															f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
																														end
																														
																														f35_arg0:beginAnimation( 99 )
																														f35_arg0:setTopBottom( 0, 0, 1, 37 )
																														f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
																													end
																													
																													f34_arg0:beginAnimation( 200 )
																													f34_arg0:setAlpha( 0 )
																													f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
																												end
																												
																												f33_arg0:beginAnimation( 199 )
																												f33_arg0:setAlpha( 0.2 )
																												f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
																											end
																											
																											f32_arg0:beginAnimation( 599 )
																											f32_arg0:setLeftRight( 0, 0, 38, 74 )
																											f32_arg0:setTopBottom( 0, 0, 40, 76 )
																											f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
																										end
																										
																										f31_arg0:beginAnimation( 200 )
																										f31_arg0:setAlpha( 0 )
																										f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
																									end
																									
																									f30_arg0:beginAnimation( 199 )
																									f30_arg0:setAlpha( 0.2 )
																									f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
																								end
																								
																								f29_arg0:beginAnimation( 599 )
																								f29_arg0:setLeftRight( 0, 0, 1, 37 )
																								f29_arg0:setTopBottom( 0, 0, 116, 152 )
																								f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
																							end
																							
																							f28_arg0:beginAnimation( 200 )
																							f28_arg0:setAlpha( 0 )
																							f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
																						end
																						
																						f27_arg0:beginAnimation( 199 )
																						f27_arg0:setAlpha( 0.2 )
																						f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
																					end
																					
																					f26_arg0:beginAnimation( 500 )
																					f26_arg0:setLeftRight( 0, 0, 38, 74 )
																					f26_arg0:setTopBottom( 0, 0, 230, 266 )
																					f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
																				end
																				
																				f25_arg0:beginAnimation( 200 )
																				f25_arg0:setAlpha( 0 )
																				f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
																			end
																			
																			f24_arg0:beginAnimation( 199 )
																			f24_arg0:setAlpha( 0.25 )
																			f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
																		end
																		
																		f23_arg0:beginAnimation( 99 )
																		f23_arg0:setLeftRight( 0, 0, 39, 75 )
																		f23_arg0:setTopBottom( 0, 0, 306, 342 )
																		f23_arg0:registerEventHandler( "transition_complete_keyframe", f23_local0 )
																	end
																	
																	f22_arg0:beginAnimation( 200 )
																	f22_arg0:setAlpha( 0 )
																	f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
																end
																
																f21_arg0:beginAnimation( 199 )
																f21_arg0:setAlpha( 0.2 )
																f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
															end
															
															f20_arg0:beginAnimation( 599 )
															f20_arg0:setTopBottom( 0, 0, 344, 380 )
															f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
														end
														
														f19_arg0:beginAnimation( 200 )
														f19_arg0:setAlpha( 0 )
														f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
													end
													
													f18_arg0:beginAnimation( 200 )
													f18_arg0:setAlpha( 0.2 )
													f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
												end
												
												f17_arg0:beginAnimation( 99 )
												f17_arg0:setLeftRight( 0, 0, 1, 37 )
												f17_arg0:setTopBottom( 0, 0, 77, 113 )
												f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
											end
											
											f16_arg0:beginAnimation( 200 )
											f16_arg0:setAlpha( 0 )
											f16_arg0:registerEventHandler( "transition_complete_keyframe", f16_local0 )
										end
										
										f15_arg0:beginAnimation( 200 )
										f15_arg0:setAlpha( 0.2 )
										f15_arg0:registerEventHandler( "transition_complete_keyframe", f15_local0 )
									end
									
									f14_arg0:beginAnimation( 1100 )
									f14_arg0:setLeftRight( 0, 0, 38, 74 )
									f14_arg0:setTopBottom( 0, 0, 115, 151 )
									f14_arg0:registerEventHandler( "transition_complete_keyframe", f14_local0 )
								end
								
								f13_arg0:beginAnimation( 199 )
								f13_arg0:setAlpha( 0 )
								f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
							end
							
							f12_arg0:beginAnimation( 200 )
							f12_arg0:setAlpha( 0.2 )
							f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
						end
						
						f11_arg0:beginAnimation( 600 )
						f11_arg0:setLeftRight( 0, 0, 39, 75 )
						f11_arg0:setTopBottom( 0, 0, 229, 265 )
						f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
					end
					
					f10_arg0:beginAnimation( 200 )
					f10_arg0:setAlpha( 0 )
					f10_arg0:registerEventHandler( "transition_complete_keyframe", f10_local0 )
				end
				
				f3_arg0.BoxHighlighted:beginAnimation( 200 )
				f3_arg0.BoxHighlighted:setAlpha( 0.2 )
				f3_arg0.BoxHighlighted:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.BoxHighlighted:registerEventHandler( "transition_complete_keyframe", f9_local0 )
			end
			
			f3_arg0.BoxHighlighted:completeAnimation()
			f3_arg0.BoxHighlighted:setLeftRight( 0, 0, 1, 37 )
			f3_arg0.BoxHighlighted:setTopBottom( 0, 0, 1, 37 )
			f3_arg0.BoxHighlighted:setAlpha( 0 )
			f3_local1( f3_arg0.BoxHighlighted )
			f3_arg0.nextClip = "DefaultClip"
		end,
		Intro = function ( f39_arg0, f39_arg1 )
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter( 2 )
			local f39_local0 = function ( f40_arg0 )
				f39_arg0.BlurBgBoxes01:beginAnimation( 1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097] )
				f39_arg0.BlurBgBoxes01:setAlpha( 0.3 )
				f39_arg0.BlurBgBoxes01:registerEventHandler( "interrupted_keyframe", f39_arg0.clipInterrupted )
				f39_arg0.BlurBgBoxes01:registerEventHandler( "transition_complete_keyframe", f39_arg0.clipFinished )
			end
			
			f39_arg0.BlurBgBoxes01:completeAnimation()
			f39_arg0.BlurBgBoxes01:setAlpha( 0 )
			f39_local0( f39_arg0.BlurBgBoxes01 )
			f39_arg0.BoxHighlighted:completeAnimation()
			f39_arg0.BoxHighlighted:setAlpha( 0 )
			f39_arg0.clipFinished( f39_arg0.BoxHighlighted )
		end
	}
}
