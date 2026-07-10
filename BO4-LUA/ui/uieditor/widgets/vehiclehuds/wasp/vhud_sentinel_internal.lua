
require( "x64:cacf05396a4a836" )
require( "x64:36bb2bc11c13e35" )
require( "x64:42a47e92dfaccef" )
require( "x64:1ca2a624101dfea" )
CoD.VHUD_Sentinel_Internal = InheritFrom( LUI.UIElement )
CoD.VHUD_Sentinel_Internal.__defaultWidth = 1920
CoD.VHUD_Sentinel_Internal.__defaultHeight = 1080
CoD.VHUD_Sentinel_Internal.new = function ( f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	local self = LUI.UIElement.new( f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9 )
	self:setClass( CoD.VHUD_Sentinel_Internal )
	self.id = "VHUD_Sentinel_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList( self )
	
	local vhudsentineliris0 = CoD.vhud_sentinel_iris.new( f1_arg0, f1_arg1, 0, 1, -304, 304, 0, 1, -172, 172 )
	vhudsentineliris0:linkToElementModel( self, nil, false, function ( model )
		vhudsentineliris0:setModel( model, f1_arg1 )
	end )
	self:addElement( vhudsentineliris0 )
	self.vhudsentineliris0 = vhudsentineliris0
	
	local TextureOverlayDots = LUI.UIImage.new( 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540 )
	TextureOverlayDots:setAlpha( 0.9 )
	TextureOverlayDots:setImage( RegisterImage( @"uie_t7_cp_hud_vehicle_wasp_textureoverlaydots" ) )
	TextureOverlayDots:setMaterial( LUI.UIImage.GetCachedMaterial( @"ui_add" ) )
	self:addElement( TextureOverlayDots )
	self.TextureOverlayDots = TextureOverlayDots
	
	local VHUDSentinelReticle = CoD.VHUD_Sentinel_Reticle.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0 )
	VHUDSentinelReticle:mergeStateConditions( {
		{
			stateName = "ZoomCP",
			condition = function ( menu, element, event )
				return IsCampaign() and CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "zoomed" )
			end
		},
		{
			stateName = "CP",
			condition = function ( menu, element, event )
				return IsCampaign()
			end
		},
		{
			stateName = "Zoom",
			condition = function ( menu, element, event )
				return CoD.ModelUtility.IsSelfModelValueTrue( element, f1_arg1, "zoomed" )
			end
		}
	} )
	local vhudsentineloutOfRangeLabels0 = VHUDSentinelReticle
	local vhudButtonContainer = VHUDSentinelReticle.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	vhudButtonContainer( vhudsentineloutOfRangeLabels0, f1_local6["lobbyRoot.lobbyNav"], function ( f6_arg0 )
		f1_arg0:updateElementState( VHUDSentinelReticle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav"
		} )
	end, false )
	VHUDSentinelReticle:linkToElementModel( VHUDSentinelReticle, "zoomed", true, function ( model )
		f1_arg0:updateElementState( VHUDSentinelReticle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "zoomed"
		} )
	end )
	VHUDSentinelReticle:linkToElementModel( self, nil, false, function ( model )
		VHUDSentinelReticle:setModel( model, f1_arg1 )
	end )
	VHUDSentinelReticle:registerEventHandler( "menu_loaded", function ( element, event )
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded( event )
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded( event )
		end
		PlayClipOnElement( self, {
			elementName = "VHUDSentinelReticle",
			clipName = "StartUp"
		}, f1_arg1 )
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren( event )
		end
		return f9_local0
	end )
	self:addElement( VHUDSentinelReticle )
	self.VHUDSentinelReticle = VHUDSentinelReticle
	
	vhudButtonContainer = CoD.vhud_generic_button_layout.new( f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, -4, -4 )
	vhudButtonContainer:linkToElementModel( self, "bindings", false, function ( model )
		vhudButtonContainer:setModel( model, f1_arg1 )
	end )
	self.__on_menuOpened_vhudButtonContainer = function ( f11_arg0, f11_arg1, f11_arg2, f11_arg3 )
		SizeToSafeArea( vhudButtonContainer, f11_arg1 )
	end
	
	f1_arg0:addMenuOpenedCallback( self.__on_menuOpened_vhudButtonContainer )
	self:addElement( vhudButtonContainer )
	self.vhudButtonContainer = vhudButtonContainer
	
	vhudsentineloutOfRangeLabels0 = CoD.vhud_sentinel_outOfRangeLabels.new( f1_arg0, f1_arg1, 0.5, 0.5, -395, 395, 0.5, 0.5, -184.5, 184.5 )
	vhudsentineloutOfRangeLabels0:linkToElementModel( self, nil, false, function ( model )
		vhudsentineloutOfRangeLabels0:setModel( model, f1_arg1 )
	end )
	self:addElement( vhudsentineloutOfRangeLabels0 )
	self.vhudsentineloutOfRangeLabels0 = vhudsentineloutOfRangeLabels0
	
	self.__on_close_removeOverrides = function ()
		f1_arg0:removeMenuOpenedCallback( self.__on_menuOpened_vhudButtonContainer )
	end
	
	LUI.OverrideFunction_CallOriginalSecond( self, "close", self.__onClose )
	
	if PostLoadFunc then
		PostLoadFunc( self, f1_arg1, f1_arg0 )
	end
	
	return self
end
CoD.VHUD_Sentinel_Internal.__resetProperties = function ( f14_arg0 )
	f14_arg0.TextureOverlayDots:completeAnimation()
	f14_arg0.TextureOverlayDots:setAlpha( 0.9 )
end
CoD.VHUD_Sentinel_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function ( f15_arg0, f15_arg1 )
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter( 1 )
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
																																								f52_arg0:beginAnimation( 70 )
																																								f52_arg0:setAlpha( 0 )
																																								f52_arg0:registerEventHandler( "transition_complete_keyframe", f15_arg0.clipFinished )
																																							end
																																							
																																							f51_arg0:beginAnimation( 89 )
																																							f51_arg0:setAlpha( 1 )
																																							f51_arg0:registerEventHandler( "transition_complete_keyframe", f51_local0 )
																																						end
																																						
																																						f50_arg0:beginAnimation( 140 )
																																						f50_arg0:setAlpha( 0.2 )
																																						f50_arg0:registerEventHandler( "transition_complete_keyframe", f50_local0 )
																																					end
																																					
																																					f49_arg0:beginAnimation( 460 )
																																					f49_arg0:setAlpha( 0.4 )
																																					f49_arg0:registerEventHandler( "transition_complete_keyframe", f49_local0 )
																																				end
																																				
																																				f48_arg0:beginAnimation( 109 )
																																				f48_arg0:setAlpha( 0.1 )
																																				f48_arg0:registerEventHandler( "transition_complete_keyframe", f48_local0 )
																																			end
																																			
																																			f47_arg0:beginAnimation( 90 )
																																			f47_arg0:setAlpha( 0.4 )
																																			f47_arg0:registerEventHandler( "transition_complete_keyframe", f47_local0 )
																																		end
																																		
																																		f46_arg0:beginAnimation( 79 )
																																		f46_arg0:setAlpha( 0.9 )
																																		f46_arg0:registerEventHandler( "transition_complete_keyframe", f46_local0 )
																																	end
																																	
																																	f45_arg0:beginAnimation( 430 )
																																	f45_arg0:setAlpha( 0.15 )
																																	f45_arg0:registerEventHandler( "transition_complete_keyframe", f45_local0 )
																																end
																																
																																f44_arg0:beginAnimation( 79 )
																																f44_arg0:setAlpha( 1 )
																																f44_arg0:registerEventHandler( "transition_complete_keyframe", f44_local0 )
																															end
																															
																															f43_arg0:beginAnimation( 69 )
																															f43_arg0:setAlpha( 0.2 )
																															f43_arg0:registerEventHandler( "transition_complete_keyframe", f43_local0 )
																														end
																														
																														f42_arg0:beginAnimation( 80 )
																														f42_arg0:setAlpha( 0.5 )
																														f42_arg0:registerEventHandler( "transition_complete_keyframe", f42_local0 )
																													end
																													
																													f41_arg0:beginAnimation( 39 )
																													f41_arg0:setAlpha( 0.3 )
																													f41_arg0:registerEventHandler( "transition_complete_keyframe", f41_local0 )
																												end
																												
																												f40_arg0:beginAnimation( 210 )
																												f40_arg0:setAlpha( 1 )
																												f40_arg0:registerEventHandler( "transition_complete_keyframe", f40_local0 )
																											end
																											
																											f39_arg0:beginAnimation( 230 )
																											f39_arg0:setAlpha( 0.6 )
																											f39_arg0:registerEventHandler( "transition_complete_keyframe", f39_local0 )
																										end
																										
																										f38_arg0:beginAnimation( 39 )
																										f38_arg0:setAlpha( 1 )
																										f38_arg0:registerEventHandler( "transition_complete_keyframe", f38_local0 )
																									end
																									
																									f37_arg0:beginAnimation( 59 )
																									f37_arg0:setAlpha( 0.15 )
																									f37_arg0:registerEventHandler( "transition_complete_keyframe", f37_local0 )
																								end
																								
																								f36_arg0:beginAnimation( 50 )
																								f36_arg0:setAlpha( 0.5 )
																								f36_arg0:registerEventHandler( "transition_complete_keyframe", f36_local0 )
																							end
																							
																							f35_arg0:beginAnimation( 169 )
																							f35_arg0:setAlpha( 1 )
																							f35_arg0:registerEventHandler( "transition_complete_keyframe", f35_local0 )
																						end
																						
																						f34_arg0:beginAnimation( 269 )
																						f34_arg0:setAlpha( 0.2 )
																						f34_arg0:registerEventHandler( "transition_complete_keyframe", f34_local0 )
																					end
																					
																					f33_arg0:beginAnimation( 39 )
																					f33_arg0:setAlpha( 0.7 )
																					f33_arg0:registerEventHandler( "transition_complete_keyframe", f33_local0 )
																				end
																				
																				f32_arg0:beginAnimation( 40 )
																				f32_arg0:setAlpha( 0.4 )
																				f32_arg0:registerEventHandler( "transition_complete_keyframe", f32_local0 )
																			end
																			
																			f31_arg0:beginAnimation( 39 )
																			f31_arg0:setAlpha( 1 )
																			f31_arg0:registerEventHandler( "transition_complete_keyframe", f31_local0 )
																		end
																		
																		f30_arg0:beginAnimation( 200 )
																		f30_arg0:registerEventHandler( "transition_complete_keyframe", f30_local0 )
																	end
																	
																	f29_arg0:beginAnimation( 29 )
																	f29_arg0:setAlpha( 0.1 )
																	f29_arg0:registerEventHandler( "transition_complete_keyframe", f29_local0 )
																end
																
																f28_arg0:beginAnimation( 29 )
																f28_arg0:setAlpha( 0.6 )
																f28_arg0:registerEventHandler( "transition_complete_keyframe", f28_local0 )
															end
															
															f27_arg0:beginAnimation( 90 )
															f27_arg0:setAlpha( 0.25 )
															f27_arg0:registerEventHandler( "transition_complete_keyframe", f27_local0 )
														end
														
														f26_arg0:beginAnimation( 89 )
														f26_arg0:setAlpha( 0.8 )
														f26_arg0:registerEventHandler( "transition_complete_keyframe", f26_local0 )
													end
													
													f25_arg0:beginAnimation( 69 )
													f25_arg0:setAlpha( 1 )
													f25_arg0:registerEventHandler( "transition_complete_keyframe", f25_local0 )
												end
												
												f24_arg0:beginAnimation( 140 )
												f24_arg0:setAlpha( 0.5 )
												f24_arg0:registerEventHandler( "transition_complete_keyframe", f24_local0 )
											end
											
											f23_arg0:beginAnimation( 69 )
											f23_arg0:setAlpha( 0.8 )
											f23_arg0:registerEventHandler( "transition_complete_keyframe", f23_local0 )
										end
										
										f22_arg0:beginAnimation( 120 )
										f22_arg0:setAlpha( 1 )
										f22_arg0:registerEventHandler( "transition_complete_keyframe", f22_local0 )
									end
									
									f21_arg0:beginAnimation( 39 )
									f21_arg0:setAlpha( 0.1 )
									f21_arg0:registerEventHandler( "transition_complete_keyframe", f21_local0 )
								end
								
								f20_arg0:beginAnimation( 30 )
								f20_arg0:setAlpha( 0.2 )
								f20_arg0:registerEventHandler( "transition_complete_keyframe", f20_local0 )
							end
							
							f19_arg0:beginAnimation( 240 )
							f19_arg0:setAlpha( 0.1 )
							f19_arg0:registerEventHandler( "transition_complete_keyframe", f19_local0 )
						end
						
						f18_arg0:beginAnimation( 149 )
						f18_arg0:setAlpha( 0.5 )
						f18_arg0:registerEventHandler( "transition_complete_keyframe", f18_local0 )
					end
					
					f17_arg0:beginAnimation( 40 )
					f17_arg0:setAlpha( 0.25 )
					f17_arg0:registerEventHandler( "transition_complete_keyframe", f17_local0 )
				end
				
				f15_arg0.TextureOverlayDots:beginAnimation( 20 )
				f15_arg0.TextureOverlayDots:setAlpha( 1 )
				f15_arg0.TextureOverlayDots:registerEventHandler( "interrupted_keyframe", f15_arg0.clipInterrupted )
				f15_arg0.TextureOverlayDots:registerEventHandler( "transition_complete_keyframe", f16_local0 )
			end
			
			f15_arg0.TextureOverlayDots:completeAnimation()
			f15_arg0.TextureOverlayDots:setAlpha( 0 )
			f15_local0( f15_arg0.TextureOverlayDots )
			f15_arg0.nextClip = "DefaultClip"
		end
	}
}
CoD.VHUD_Sentinel_Internal.__onClose = function ( f53_arg0 )
	f53_arg0.__on_close_removeOverrides()
	f53_arg0.vhudsentineliris0:close()
	f53_arg0.VHUDSentinelReticle:close()
	f53_arg0.vhudButtonContainer:close()
	f53_arg0.vhudsentineloutOfRangeLabels0:close()
end
