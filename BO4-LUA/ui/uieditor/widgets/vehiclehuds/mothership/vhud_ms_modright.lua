
require( "x64:4152790a5661949" )
require( "x64:4152690a5661796" )
CoD.vhud_ms_ModRight = InheritFrom( LUI.UIElement )
CoD.vhud_ms_ModRight.__defaultWidth = 966
CoD.vhud_ms_ModRight.__defaultHeight = 114
CoD.vhud_ms_ModRight.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.vhud_ms_ModRight )
	self.id = "vhud_ms_ModRight"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local ModT1 = CoD.VehicleGround_ModT5.new( f1_arg0, f1_arg1, 0, 0, 586, 754, 0, 0, 0, 54 )
	self:addElement( ModT1 )
	self.ModT1 = ModT1
	
	local ModT2 = CoD.VehicleGround_ModT4.new( f1_arg0, f1_arg1, 0, 0, 429.5, 645.5, 0, 0, 0, 54 )
	ModT2:setAlpha( 0 )
	self:addElement( ModT2 )
	self.ModT2 = ModT2
	
	self:mergeStateConditions( {
		{
			stateName = "Hidden",
			condition = function ( menu, element, event )
				return HideVehicleReticle( self, f1_arg1, event )
			end
		}
	} )
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.VehicleInfo.getModel( f1_arg1 )
	f1_local4( f1_local3, f1_local5.vehicleType, function ( f3_arg0 )
		f1_arg0:updateElementState( self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "vehicleType"
		} )
	end, false )
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.vhud_ms_ModRight.__resetProperties = function ( f4_arg0 )
	f4_arg0.ModT1:completeAnimation()
	f4_arg0.ModT2:completeAnimation()
	f4_arg0.ModT1:setLeftRight( 0, 0, 586, 754 )
	f4_arg0.ModT1:setTopBottom( 0, 0, 0, 54 )
	f4_arg0.ModT1:setAlpha( 1 )
	f4_arg0.ModT2:setLeftRight( 0, 0, 429.5, 645.5 )
	f4_arg0.ModT2:setTopBottom( 0, 0, 0, 54 )
	f4_arg0.ModT2:setAlpha( 0 )
end
CoD.vhud_ms_ModRight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f5_arg0, f5_arg1 )
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter( 2 )
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
																											f29_arg0:beginAnimation( 1699 )
																											f29_arg0:registerEventHandler( "transition_complete_keyframe", f5_arg0.clipFinished )
																										end
																										
																										f28_arg0:beginAnimation( 199, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
																										f28_arg0:setLeftRight( 0, 0, 286, 454 )
																										f28_arg0:setAlpha( 0 )
																										f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
																									end
																									
																									f27_arg0:beginAnimation( 500 )
																									f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
																								end
																								
																								f26_arg0:beginAnimation( 300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
																								f26_arg0:setLeftRight( 0, 0, 414, 582 )
																								f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
																							end
																							
																							f25_arg0:beginAnimation( 1500 )
																							f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
																						end
																						
																						f24_arg0:beginAnimation( 300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
																						f24_arg0:setLeftRight( 0, 0, 582, 750 )
																						f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
																					end
																					
																					f23_arg0:beginAnimation( 1909 )
																					f23_arg0:registerEventHandler( "transition_complete_keyframe", f23_local0 )
																				end
																				
																				f22_arg0:beginAnimation( 10 )
																				f22_arg0:setAlpha( 1 )
																				f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
																			end
																			
																			f21_arg0:beginAnimation( 50 )
																			f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
																		end
																		
																		f20_arg0:beginAnimation( 9 )
																		f20_arg0:setAlpha( 0 )
																		f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
																	end
																	
																	f19_arg0:beginAnimation( 50 )
																	f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
																end
																
																f18_arg0:beginAnimation( 10 )
																f18_arg0:setAlpha( 0.5 )
																f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
															end
															
															f17_arg0:beginAnimation( 50 )
															f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
														end
														
														f16_arg0:beginAnimation( 10 )
														f16_arg0:setAlpha( 0 )
														f16_arg0:registerEventHandler( "transition_complete_keyframe", f16_local0 )
													end
													
													f15_arg0:beginAnimation( 189 )
													f15_arg0:setLeftRight( 0, 0, 798, 966 )
													f15_arg0:registerEventHandler( "transition_complete_keyframe", f15_local0 )
												end
												
												f14_arg0:beginAnimation( 10 )
												f14_arg0:setLeftRight( 0, 0, 798, 806 )
												f14_arg0:setAlpha( 1 )
												f14_arg0:registerEventHandler( "transition_complete_keyframe", f14_local0 )
											end
											
											f13_arg0:beginAnimation( 2899 )
											f13_arg0:setLeftRight( 0, 0, 798, 966 )
											f13_arg0:registerEventHandler( "transition_complete_keyframe", f13_local0 )
										end
										
										f12_arg0:beginAnimation( 140, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
										f12_arg0:setLeftRight( 0, 0, 516, 684 )
										f12_arg0:setAlpha( 0 )
										f12_arg0:registerEventHandler( "transition_complete_keyframe", f12_local0 )
									end
									
									f11_arg0:beginAnimation( 159 )
									f11_arg0:setLeftRight( 0, 0, 547.34, 715.34 )
									f11_arg0:registerEventHandler( "transition_complete_keyframe", f11_local0 )
								end
								
								f10_arg0:beginAnimation( 3300 )
								f10_arg0:registerEventHandler( "transition_complete_keyframe", f10_local0 )
							end
							
							f9_arg0:beginAnimation( 299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
							f9_arg0:setLeftRight( 0, 0, 586, 754 )
							f9_arg0:registerEventHandler( "transition_complete_keyframe", f9_local0 )
						end
						
						f8_arg0:beginAnimation( 1900 )
						f8_arg0:registerEventHandler( "transition_complete_keyframe", f8_local0 )
					end
					
					f7_arg0:beginAnimation( 299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
					f7_arg0:setLeftRight( 0, 0, 744, 912 )
					f7_arg0:registerEventHandler( "transition_complete_keyframe", f7_local0 )
				end
				
				f5_arg0.ModT1:beginAnimation( 1200 )
				f5_arg0.ModT1:registerEventHandler( "interrupted_keyframe", f5_arg0.clipInterrupted )
				f5_arg0.ModT1:registerEventHandler( "transition_complete_keyframe", f6_local0 )
			end
			
			f5_arg0.ModT1:completeAnimation()
			f5_arg0.ModT1:setLeftRight( 0, 0, 798, 966 )
			f5_arg0.ModT1:setTopBottom( 0, 0, 0, 54 )
			f5_arg0.ModT1:setAlpha( 1 )
			f5_local0( f5_arg0.ModT1 )
			local f5_local1 = function ( f30_arg0 )
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
																			f45_arg0:beginAnimation( 300, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
																			f45_arg0:setLeftRight( 0, 0, 582, 798 )
																			f45_arg0:registerEventHandler( "transition_complete_keyframe", f5_arg0.clipFinished )
																		end
																		
																		f44_arg0:beginAnimation( 1110 )
																		f44_arg0:registerEventHandler( "transition_complete_keyframe", f44_local0 )
																	end
																	
																	f43_arg0:beginAnimation( 9 )
																	f43_arg0:setAlpha( 1 )
																	f43_arg0:registerEventHandler( "transition_complete_keyframe", f43_local0 )
																end
																
																f42_arg0:beginAnimation( 50 )
																f42_arg0:registerEventHandler( "transition_complete_keyframe", f42_local0 )
															end
															
															f41_arg0:beginAnimation( 10 )
															f41_arg0:setAlpha( 0 )
															f41_arg0:registerEventHandler( "transition_complete_keyframe", f41_local0 )
														end
														
														f40_arg0:beginAnimation( 50 )
														f40_arg0:registerEventHandler( "transition_complete_keyframe", f40_local0 )
													end
													
													f39_arg0:beginAnimation( 9 )
													f39_arg0:setAlpha( 0.5 )
													f39_arg0:registerEventHandler( "transition_complete_keyframe", f39_local0 )
												end
												
												f38_arg0:beginAnimation( 50 )
												f38_arg0:registerEventHandler( "transition_complete_keyframe", f38_local0 )
											end
											
											f37_arg0:beginAnimation( 10 )
											f37_arg0:setAlpha( 0 )
											f37_arg0:registerEventHandler( "transition_complete_keyframe", f37_local0 )
										end
										
										f36_arg0:beginAnimation( 189 )
										f36_arg0:setLeftRight( 0, 0, 750, 966 )
										f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
									end
									
									f35_arg0:beginAnimation( 10 )
									f35_arg0:setLeftRight( 0, 0, 750, 758 )
									f35_arg0:setAlpha( 1 )
									f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
								end
								
								f34_arg0:beginAnimation( 9100 )
								f34_arg0:setLeftRight( 0, 0, 750, 966 )
								f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
							end
							
							f33_arg0:beginAnimation( 150, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
							f33_arg0:setLeftRight( 0, 0, 370, 586 )
							f33_arg0:setAlpha( 0 )
							f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
						end
						
						f32_arg0:beginAnimation( 149 )
						f32_arg0:setLeftRight( 0, 0, 449, 665 )
						f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
					end
					
					f31_arg0:beginAnimation( 1900 )
					f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
				end
				
				f30_arg0:beginAnimation( 299, Enum[0xF50FFF429AB1890][0x6F6186B702830BC] )
				f30_arg0:setLeftRight( 0, 0, 528, 744 )
				f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
			end
			
			f5_arg0.ModT2:beginAnimation( 1200 )
			f5_arg0.ModT2:setLeftRight( 0, 0, 582, 798 )
			f5_arg0.ModT2:setTopBottom( 0, 0, 0, 54 )
			f5_arg0.ModT2:setAlpha( 1 )
			f5_arg0.ModT2:registerEventHandler( "interrupted_keyframe", f5_arg0.clipInterrupted )
			f5_arg0.ModT2:registerEventHandler( "transition_complete_keyframe", f5_local1 )
			f5_arg0.nextClip = "DefaultClip"
		end
	},
	Hidden = {
		DefaultClip = function ( f46_arg0, f46_arg1 )
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter( 0 )
		end
	}
}
CoD.vhud_ms_ModRight.__onClose = function ( f47_arg0 )
	f47_arg0.ModT1:close()
	f47_arg0.ModT2:close()
end
