
CoD.vhud_sentinel_outOfRangeLabels = InheritFrom( LUI.UIElement )
CoD.vhud_sentinel_outOfRangeLabels.__defaultWidth = 790
CoD.vhud_sentinel_outOfRangeLabels.__defaultHeight = 367
CoD.vhud_sentinel_outOfRangeLabels.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.vhud_sentinel_outOfRangeLabels )
	self.id = "vhud_sentinel_outOfRangeLabels"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local outOfRangeLabel = LUI.UIText.new( 0.5, 0.5, -395, 395, 0, 0, 323, 368 )
	outOfRangeLabel:setRGB( 1, 0, 0 )
	outOfRangeLabel:setAlpha( 0 )
	outOfRangeLabel:setText( Engine[0xF9F1239CFD921FE]( 0xC247D7EC67112E2 ) )
	outOfRangeLabel:setTTF( "default" )
	outOfRangeLabel:setRFTMaterial( LUI.UIImage.GetCachedMaterial( 0xFAEF6B981087FCE ) )
	outOfRangeLabel:setShaderVector( 0, 0.2, 0, 0, 0 )
	outOfRangeLabel:setShaderVector( 1, 0, 0, 0, 0 )
	outOfRangeLabel:setShaderVector( 2, 0, 0, 0, 0 )
	outOfRangeLabel:setShaderVector( 3, 0, 0, 0, 0 )
	outOfRangeLabel:setShaderVector( 4, 0, 0, 0, 0 )
	outOfRangeLabel:setLetterSpacing( 6.7 )
	outOfRangeLabel:setAlignment( Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041] )
	self:addElement( outOfRangeLabel )
	self.outOfRangeLabel = outOfRangeLabel
	
	local outOfRangeTitle = LUI.UIText.new( 0.5, 0.5, -176, 176, 0, 0, 0, 45 )
	outOfRangeTitle:setRGB( 1, 0, 0 )
	outOfRangeTitle:setAlpha( 0 )
	outOfRangeTitle:setText( Engine[0xF9F1239CFD921FE]( 0xE08EA7B79681E9C ) )
	outOfRangeTitle:setTTF( "ttmussels_demibold" )
	outOfRangeTitle:setRFTMaterial( LUI.UIImage.GetCachedMaterial( 0xFAEF6B981087FCE ) )
	outOfRangeTitle:setShaderVector( 0, 0.2, 0, 0, 0 )
	outOfRangeTitle:setShaderVector( 1, 0, 0, 0, 0 )
	outOfRangeTitle:setShaderVector( 2, 0, 0, 0, 0 )
	outOfRangeTitle:setShaderVector( 3, 0, 0, 0, 0 )
	outOfRangeTitle:setShaderVector( 4, 0, 0, 0, 0 )
	outOfRangeTitle:setLetterSpacing( 8.6 )
	outOfRangeTitle:setAlignment( Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041] )
	self:addElement( outOfRangeTitle )
	self.outOfRangeTitle = outOfRangeTitle
	
	self:mergeStateConditions( {
		{
			stateName = "LeavingOperationalZone",
			condition = function ( menu, element, event )
				return IsCampaign() and CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "outOfRange" )
			end
		}
	} )
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4( f1_local3, f1_local5["lobbyRoot.lobbyNav"], function ( f3_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav"
		} )
	end, false )
	self:linkToElementModel( self, "outOfRange", true, function ( model )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "outOfRange"
		} )
	end )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.vhud_sentinel_outOfRangeLabels.__resetProperties = function ( f5_arg0 )
	f5_arg0.outOfRangeTitle:completeAnimation()
	f5_arg0.outOfRangeLabel:completeAnimation()
	f5_arg0.outOfRangeTitle:setAlpha( 0 )
	f5_arg0.outOfRangeLabel:setAlpha( 0 )
end
CoD.vhud_sentinel_outOfRangeLabels.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f6_arg0, f6_arg1 )
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter( 0 )
		end
	},
	LeavingOperationalZone = {
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
																			f23_arg0:beginAnimation( 19 )
																			f23_arg0:setAlpha( 1 )
																			f23_arg0:registerEventHandler( "transition_complete_keyframe", f7_arg0.clipFinished )
																		end
																		
																		f22_arg0:beginAnimation( 70 )
																		f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
																	end
																	
																	f21_arg0:beginAnimation( 9 )
																	f21_arg0:setAlpha( 0.4 )
																	f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
																end
																
																f20_arg0:beginAnimation( 390 )
																f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
															end
															
															f19_arg0:beginAnimation( 9 )
															f19_arg0:setAlpha( 1 )
															f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
														end
														
														f18_arg0:beginAnimation( 90 )
														f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
													end
													
													f17_arg0:beginAnimation( 9 )
													f17_arg0:setAlpha( 0.4 )
													f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
												end
												
												f16_arg0:beginAnimation( 390 )
												f16_arg0:registerEventHandler( "transition_complete_keyframe", f16_local0 )
											end
											
											f15_arg0:beginAnimation( 9 )
											f15_arg0:setAlpha( 1 )
											f15_arg0:registerEventHandler( "transition_complete_keyframe", f15_local0 )
										end
										
										f14_arg0:beginAnimation( 89 )
										f14_arg0:registerEventHandler( "transition_complete_keyframe", f14_local0 )
									end
									
									f13_arg0:beginAnimation( 10 )
									f13_arg0:setAlpha( 0.4 )
									f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
								end
								
								f12_arg0:beginAnimation( 390 )
								f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
							end
							
							f11_arg0:beginAnimation( 9 )
							f11_arg0:setAlpha( 1 )
							f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
						end
						
						f10_arg0:beginAnimation( 90 )
						f10_arg0:registerEventHandler( "transition_complete_keyframe", f10_local0 )
					end
					
					f9_arg0:beginAnimation( 9 )
					f9_arg0:setAlpha( 0.4 )
					f9_arg0:registerEventHandler( "transition_complete_keyframe", f9_local0 )
				end
				
				f7_arg0.outOfRangeLabel:beginAnimation( 400 )
				f7_arg0.outOfRangeLabel:registerEventHandler( "interrupted_keyframe", f7_arg0.clipInterrupted )
				f7_arg0.outOfRangeLabel:registerEventHandler( "transition_complete_keyframe", f8_local0 )
			end
			
			f7_arg0.outOfRangeLabel:completeAnimation()
			f7_arg0.outOfRangeLabel:setAlpha( 1 )
			f7_local0( f7_arg0.outOfRangeLabel )
			local f7_local1 = function ( f24_arg0 )
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
																																f52_arg0:beginAnimation( 29 )
																																f52_arg0:setAlpha( 1 )
																																f52_arg0:registerEventHandler( "transition_complete_keyframe", f7_arg0.clipFinished )
																															end
																															
																															f51_arg0:beginAnimation( 29 )
																															f51_arg0:setAlpha( 0.93 )
																															f51_arg0:registerEventHandler( "transition_complete_keyframe", f51_local0 )
																														end
																														
																														f50_arg0:beginAnimation( 140 )
																														f50_arg0:setAlpha( 0.84 )
																														f50_arg0:registerEventHandler( "transition_complete_keyframe", f50_local0 )
																													end
																													
																													f49_arg0:beginAnimation( 49 )
																													f49_arg0:setAlpha( 1 )
																													f49_arg0:registerEventHandler( "transition_complete_keyframe", f49_local0 )
																												end
																												
																												f48_arg0:beginAnimation( 110 )
																												f48_arg0:setAlpha( 0.88 )
																												f48_arg0:registerEventHandler( "transition_complete_keyframe", f48_local0 )
																											end
																											
																											f47_arg0:beginAnimation( 29 )
																											f47_arg0:setAlpha( 1 )
																											f47_arg0:registerEventHandler( "transition_complete_keyframe", f47_local0 )
																										end
																										
																										f46_arg0:beginAnimation( 70 )
																										f46_arg0:setAlpha( 0.92 )
																										f46_arg0:registerEventHandler( "transition_complete_keyframe", f46_local0 )
																									end
																									
																									f45_arg0:beginAnimation( 130 )
																									f45_arg0:setAlpha( 1 )
																									f45_arg0:registerEventHandler( "transition_complete_keyframe", f45_local0 )
																								end
																								
																								f44_arg0:beginAnimation( 69 )
																								f44_arg0:setAlpha( 0.73 )
																								f44_arg0:registerEventHandler( "transition_complete_keyframe", f44_local0 )
																							end
																							
																							f43_arg0:beginAnimation( 80 )
																							f43_arg0:setAlpha( 0.98 )
																							f43_arg0:registerEventHandler( "transition_complete_keyframe", f43_local0 )
																						end
																						
																						f42_arg0:beginAnimation( 49 )
																						f42_arg0:setAlpha( 0.84 )
																						f42_arg0:registerEventHandler( "transition_complete_keyframe", f42_local0 )
																					end
																					
																					f41_arg0:beginAnimation( 210 )
																					f41_arg0:setAlpha( 1 )
																					f41_arg0:registerEventHandler( "transition_complete_keyframe", f41_local0 )
																				end
																				
																				f40_arg0:beginAnimation( 19 )
																				f40_arg0:setAlpha( 0.93 )
																				f40_arg0:registerEventHandler( "transition_complete_keyframe", f40_local0 )
																			end
																			
																			f39_arg0:beginAnimation( 40 )
																			f39_arg0:setAlpha( 1 )
																			f39_arg0:registerEventHandler( "transition_complete_keyframe", f39_local0 )
																		end
																		
																		f38_arg0:beginAnimation( 130 )
																		f38_arg0:setAlpha( 0.85 )
																		f38_arg0:registerEventHandler( "transition_complete_keyframe", f38_local0 )
																	end
																	
																	f37_arg0:beginAnimation( 30 )
																	f37_arg0:setAlpha( 1 )
																	f37_arg0:registerEventHandler( "transition_complete_keyframe", f37_local0 )
																end
																
																f36_arg0:beginAnimation( 29 )
																f36_arg0:setAlpha( 0.68 )
																f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
															end
															
															f35_arg0:beginAnimation( 130 )
															f35_arg0:setAlpha( 1 )
															f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
														end
														
														f34_arg0:beginAnimation( 9 )
														f34_arg0:setAlpha( 0.59 )
														f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
													end
													
													f33_arg0:beginAnimation( 69 )
													f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
												end
												
												f32_arg0:beginAnimation( 10 )
												f32_arg0:setAlpha( 1 )
												f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
											end
											
											f31_arg0:beginAnimation( 119 )
											f31_arg0:setAlpha( 0.84 )
											f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
										end
										
										f30_arg0:beginAnimation( 20 )
										f30_arg0:setAlpha( 1 )
										f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
									end
									
									f29_arg0:beginAnimation( 59 )
									f29_arg0:setAlpha( 0.77 )
									f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
								end
								
								f28_arg0:beginAnimation( 100 )
								f28_arg0:setAlpha( 1 )
								f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
							end
							
							f27_arg0:beginAnimation( 30 )
							f27_arg0:setAlpha( 0.81 )
							f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
						end
						
						f26_arg0:beginAnimation( 110 )
						f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
					end
					
					f25_arg0:beginAnimation( 10 )
					f25_arg0:setAlpha( 1 )
					f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
				end
				
				f7_arg0.outOfRangeTitle:beginAnimation( 80 )
				f7_arg0.outOfRangeTitle:setAlpha( 0.86 )
				f7_arg0.outOfRangeTitle:registerEventHandler( "interrupted_keyframe", f7_arg0.clipInterrupted )
				f7_arg0.outOfRangeTitle:registerEventHandler( "transition_complete_keyframe", f24_local0 )
			end
			
			f7_arg0.outOfRangeTitle:completeAnimation()
			f7_arg0.outOfRangeTitle:setAlpha( 1 )
			f7_local1( f7_arg0.outOfRangeTitle )
			f7_arg0.nextClip = "DefaultClip"
		end
	}
}
