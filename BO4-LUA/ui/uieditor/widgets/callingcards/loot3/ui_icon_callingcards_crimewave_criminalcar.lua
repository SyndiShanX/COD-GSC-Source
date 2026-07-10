
require( "x64:cac53608c125a69" )
require( "x64:cac50608c125550" )
CoD.ui_icon_callingcards_crimewave_criminalcar = InheritFrom( LUI.UIElement )
CoD.ui_icon_callingcards_crimewave_criminalcar.__defaultWidth = 648
CoD.ui_icon_callingcards_crimewave_criminalcar.__defaultHeight = 240
CoD.ui_icon_callingcards_crimewave_criminalcar.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.ui_icon_callingcards_crimewave_criminalcar )
	self.id = "ui_icon_callingcards_crimewave_criminalcar"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local criminalcar = LUI.UIImage.new( 0, 0, 0, 648, 0, 0, 0, 240 )
	criminalcar:setImage( RegisterImage( @"uie_ui_menu_callingcards_crimewave_criminals2" ) )
	self:addElement( criminalcar )
	self.criminalcar = criminalcar
	
	local criminalcar2 = LUI.UIImage.new( 0, 0, 0, 648, 0, 0, 0, 240 )
	criminalcar2:setImage( RegisterImage( @"uie_ui_menu_callingcards_crimewave_criminals1" ) )
	self:addElement( criminalcar2 )
	self.criminalcar2 = criminalcar2
	
	local uiiconcallingcardscrimewavewheelspin = CoD.ui_icon_callingcards_crimewave_wheelspin01.new( f1_arg0, f1_arg1, 0, 0, 284, 364, 0, 0, 101.5, 221.5 )
	self:addElement( uiiconcallingcardscrimewavewheelspin )
	self.uiiconcallingcardscrimewavewheelspin = uiiconcallingcardscrimewavewheelspin
	
	local uiiconcallingcardscrimewavewheelspin2 = CoD.ui_icon_callingcards_crimewave_wheelspin02.new( f1_arg0, f1_arg1, 0, 0, 49.5, 89.5, 0, 0, 189.5, 245.5 )
	uiiconcallingcardscrimewavewheelspin2:setScale( 1.25, 1.4 )
	self:addElement( uiiconcallingcardscrimewavewheelspin2 )
	self.uiiconcallingcardscrimewavewheelspin2 = uiiconcallingcardscrimewavewheelspin2
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.ui_icon_callingcards_crimewave_criminalcar.__resetProperties = function ( f2_arg0 )
	f2_arg0.criminalcar2:completeAnimation()
	f2_arg0.uiiconcallingcardscrimewavewheelspin:completeAnimation()
	f2_arg0.uiiconcallingcardscrimewavewheelspin2:completeAnimation()
	f2_arg0.criminalcar2:setAlpha( 1 )
	f2_arg0.uiiconcallingcardscrimewavewheelspin:setLeftRight( 0, 0, 284, 364 )
	f2_arg0.uiiconcallingcardscrimewavewheelspin:setTopBottom( 0, 0, 101.5, 221.5 )
end
CoD.ui_icon_callingcards_crimewave_criminalcar.__clipsPerState = {
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
																																		f34_arg0:beginAnimation( 39 )
																																		f34_arg0:setAlpha( 0 )
																																		f34_arg0:registerEventHandler( "transition_complete_keyframe", f3_arg0.clipFinished )
																																	end
																																	
																																	f33_arg0:beginAnimation( 39 )
																																	f33_arg0:setAlpha( 1 )
																																	f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
																																end
																																
																																f32_arg0:beginAnimation( 39 )
																																f32_arg0:setAlpha( 0 )
																																f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
																															end
																															
																															f31_arg0:beginAnimation( 40 )
																															f31_arg0:setAlpha( 1 )
																															f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
																														end
																														
																														f30_arg0:beginAnimation( 199 )
																														f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
																													end
																													
																													f29_arg0:beginAnimation( 40 )
																													f29_arg0:setAlpha( 0 )
																													f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
																												end
																												
																												f28_arg0:beginAnimation( 39 )
																												f28_arg0:setAlpha( 1 )
																												f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
																											end
																											
																											f27_arg0:beginAnimation( 39 )
																											f27_arg0:setAlpha( 0 )
																											f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
																										end
																										
																										f26_arg0:beginAnimation( 39 )
																										f26_arg0:setAlpha( 1 )
																										f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
																									end
																									
																									f25_arg0:beginAnimation( 210 )
																									f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
																								end
																								
																								f24_arg0:beginAnimation( 39 )
																								f24_arg0:setAlpha( 0 )
																								f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
																							end
																							
																							f23_arg0:beginAnimation( 39 )
																							f23_arg0:setAlpha( 1 )
																							f23_arg0:registerEventHandler( "transition_complete_keyframe", f23_local0 )
																						end
																						
																						f22_arg0:beginAnimation( 40 )
																						f22_arg0:setAlpha( 0 )
																						f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
																					end
																					
																					f21_arg0:beginAnimation( 39 )
																					f21_arg0:setAlpha( 1 )
																					f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
																				end
																				
																				f20_arg0:beginAnimation( 130 )
																				f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
																			end
																			
																			f19_arg0:beginAnimation( 309 )
																			f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
																		end
																		
																		f18_arg0:beginAnimation( 40 )
																		f18_arg0:setAlpha( 0 )
																		f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
																	end
																	
																	f17_arg0:beginAnimation( 39 )
																	f17_arg0:setAlpha( 1 )
																	f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
																end
																
																f16_arg0:beginAnimation( 39 )
																f16_arg0:setAlpha( 0 )
																f16_arg0:registerEventHandler( "transition_complete_keyframe", f16_local0 )
															end
															
															f15_arg0:beginAnimation( 40 )
															f15_arg0:setAlpha( 1 )
															f15_arg0:registerEventHandler( "transition_complete_keyframe", f15_local0 )
														end
														
														f14_arg0:beginAnimation( 400 )
														f14_arg0:registerEventHandler( "transition_complete_keyframe", f14_local0 )
													end
													
													f13_arg0:beginAnimation( 39 )
													f13_arg0:setAlpha( 0 )
													f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
												end
												
												f12_arg0:beginAnimation( 39 )
												f12_arg0:setAlpha( 1 )
												f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
											end
											
											f11_arg0:beginAnimation( 40 )
											f11_arg0:setAlpha( 0 )
											f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
										end
										
										f10_arg0:beginAnimation( 69 )
										f10_arg0:setAlpha( 1 )
										f10_arg0:registerEventHandler( "transition_complete_keyframe", f10_local0 )
									end
									
									f9_arg0:beginAnimation( 39 )
									f9_arg0:setAlpha( 0 )
									f9_arg0:registerEventHandler( "transition_complete_keyframe", f9_local0 )
								end
								
								f8_arg0:beginAnimation( 39 )
								f8_arg0:setAlpha( 1 )
								f8_arg0:registerEventHandler( "transition_complete_keyframe", f8_local0 )
							end
							
							f7_arg0:beginAnimation( 210 )
							f7_arg0:registerEventHandler( "transition_complete_keyframe", f7_local0 )
						end
						
						f6_arg0:beginAnimation( 50 )
						f6_arg0:setAlpha( 0 )
						f6_arg0:registerEventHandler( "transition_complete_keyframe", f6_local0 )
					end
					
					f5_arg0:beginAnimation( 50 )
					f5_arg0:setAlpha( 1 )
					f5_arg0:registerEventHandler( "transition_complete_keyframe", f5_local0 )
				end
				
				f3_arg0.criminalcar2:beginAnimation( 50 )
				f3_arg0.criminalcar2:setAlpha( 0 )
				f3_arg0.criminalcar2:registerEventHandler( "interrupted_keyframe", f3_arg0.clipInterrupted )
				f3_arg0.criminalcar2:registerEventHandler( "transition_complete_keyframe", f4_local0 )
			end
			
			f3_arg0.criminalcar2:completeAnimation()
			f3_arg0.criminalcar2:setAlpha( 1 )
			f3_local0( f3_arg0.criminalcar2 )
			f3_arg0.uiiconcallingcardscrimewavewheelspin:completeAnimation()
			f3_arg0.uiiconcallingcardscrimewavewheelspin:setLeftRight( 0, 0, 284, 364 )
			f3_arg0.uiiconcallingcardscrimewavewheelspin:setTopBottom( 0, 0, 100.5, 220.5 )
			f3_arg0.uiiconcallingcardscrimewavewheelspin:playClip( "DefaultClip" )
			f3_arg0.clipFinished( f3_arg0.uiiconcallingcardscrimewavewheelspin )
			f3_arg0.uiiconcallingcardscrimewavewheelspin2:completeAnimation()
			f3_arg0.uiiconcallingcardscrimewavewheelspin2:playClip( "DefaultClip" )
			f3_arg0.clipFinished( f3_arg0.uiiconcallingcardscrimewavewheelspin2 )
			f3_arg0.nextClip = "DefaultClip"
		end
	}
}
CoD.ui_icon_callingcards_crimewave_criminalcar.__onClose = function ( f35_arg0 )
	f35_arg0.uiiconcallingcardscrimewavewheelspin:close()
	f35_arg0.uiiconcallingcardscrimewavewheelspin2:close()
end
