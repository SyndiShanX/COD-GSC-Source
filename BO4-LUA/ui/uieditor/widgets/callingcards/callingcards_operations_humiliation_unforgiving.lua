require("x64:4217923ce9c1614")
require("x64:5f067625bb89e44")
CoD[@"hash_44D725BD127611CA"] = InheritFrom(LUI.UIElement)
CoD[@"hash_44D725BD127611CA"].__defaultWidth = 960
CoD[@"hash_44D725BD127611CA"].__defaultHeight = 240
CoD[@"hash_44D725BD127611CA"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_44D725BD127611CA"])
	self.id = "CallingCards_Operations_Humiliation_Unforgiving"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_icon_callingcards_operations_humiliation_unforgiving_background"))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	bg:setShaderVector(0, 1, 1, 0, 0)
	bg:setShaderVector(1, -0.01, 0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local rays = CoD.CallingCards_Asset_graphic_burstspin.new(f1_arg0, f1_arg1, 0, 0, -32, 992, 0, 0, -272, 752)
	self:addElement(rays)
	self.rays = rays
	local clouds = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	clouds:setImage(RegisterImage(@"uie_ui_icon_callingcards_operations_humiliation_unforgiving_animated_clouds"))
	clouds:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	clouds:setShaderVector(0, 0, 5, 0, 0)
	clouds:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(clouds)
	self.clouds = clouds
	local gang3 = CoD.CallingCards_Asset_swordstab.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	gang3:setScale(1.05, 1.05)
	self:addElement(gang3)
	self.gang3 = gang3
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(@"uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_44D725BD127611CA"].__resetProperties = function(f2_arg0)
	f2_arg0.gang3:completeAnimation()
	f2_arg0.rays:completeAnimation()
	f2_arg0.gang3:setTopBottom(0, 0, 0, 240)
end
CoD[@"hash_44D725BD127611CA"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.rays:completeAnimation()
			f3_arg0.rays:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.rays)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
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
																			f19_arg0:beginAnimation(489)
																			f19_arg0:setTopBottom(0, 0, 0, 240)
																			f19_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
																				element:playClip("DefaultClip")
																				f3_arg0.clipFinished(element, event)
																			end)
																		end
																		f18_arg0:beginAnimation(520)
																		f18_arg0:setTopBottom(0, 0, 6, 246)
																		f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
																	end
																	f17_arg0:beginAnimation(489)
																	f17_arg0:setTopBottom(0, 0, 0, 240)
																	f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
																end
																f16_arg0:beginAnimation(500)
																f16_arg0:setTopBottom(0, 0, 6, 246)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
															end
															f15_arg0:beginAnimation(500)
															f15_arg0:setTopBottom(0, 0, 0, 240)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(500)
														f14_arg0:setTopBottom(0, 0, 6, 246)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(500)
													f13_arg0:setTopBottom(0, 0, 0, 240)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(500)
												f12_arg0:setTopBottom(0, 0, 6, 246)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(510)
											f11_arg0:setTopBottom(0, 0, 0, 240)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(490)
										f10_arg0:setTopBottom(0, 0, 6, 246)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(510)
									f9_arg0:setTopBottom(0, 0, 0, 240)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(490)
								f8_arg0:setTopBottom(0, 0, 6, 246)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(500)
							f7_arg0:setTopBottom(0, 0, 0, 240)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(500)
						f6_arg0:setTopBottom(0, 0, 6, 246)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setTopBottom(0, 0, 0, 240)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.gang3:playClip("DefaultClip")
				f3_arg0.gang3:beginAnimation(500)
				f3_arg0.gang3:setTopBottom(0, 0, 6, 246)
				f3_arg0.gang3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.gang3:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.gang3:completeAnimation()
			f3_arg0.gang3:setTopBottom(0, 0, 0, 240)
			f3_local0(f3_arg0.gang3)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_44D725BD127611CA"].__onClose = function(f21_arg0)
	f21_arg0.rays:close()
	f21_arg0.gang3:close()
end
