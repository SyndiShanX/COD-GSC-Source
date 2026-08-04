CoD.AARLevelCommonBoxes = InheritFrom(LUI.UIElement)
CoD.AARLevelCommonBoxes.__defaultWidth = 48
CoD.AARLevelCommonBoxes.__defaultHeight = 13
CoD.AARLevelCommonBoxes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARLevelCommonBoxes)
	self.id = "AARLevelCommonBoxes"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SquareOthers = LUI.UIImage.new(0, 0, 0, 48, 0, 0, 0.5, 12.5)
	SquareOthers:setAlpha(0.8)
	SquareOthers:setImage(RegisterImage("uie_ui_menu_aar_common_progress_boxes"))
	SquareOthers:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SquareOthers:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SquareOthers)
	self.SquareOthers = SquareOthers
	local SquareFocus = LUI.UIImage.new(0, 0, 1, 13, 0, 0, 0, 12)
	SquareFocus:setImage(RegisterImage("uie_ui_menu_aar_common_square"))
	SquareFocus:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	SquareFocus:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SquareFocus)
	self.SquareFocus = SquareFocus
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARLevelCommonBoxes.__resetProperties = function(f2_arg0)
	f2_arg0.SquareFocus:completeAnimation()
	f2_arg0.SquareOthers:completeAnimation()
	f2_arg0.SquareFocus:setLeftRight(0, 0, 1, 13)
	f2_arg0.SquareFocus:setAlpha(1)
	f2_arg0.SquareOthers:setAlpha(0.8)
end
CoD.AARLevelCommonBoxes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.SquareOthers:completeAnimation()
			f3_arg0.SquareOthers:setAlpha(0.8)
			f3_arg0.clipFinished(f3_arg0.SquareOthers)
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
																f16_arg0:beginAnimation(1000)
																f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
															end
															f15_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
															f15_arg0:setAlpha(0)
															f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
														end
														f14_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
														f14_arg0:setAlpha(1)
														f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
													end
													f13_arg0:beginAnimation(500)
													f13_arg0:setLeftRight(0, 0, 37, 49)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
												end
												f12_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
												f12_arg0:setAlpha(0)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
											f11_arg0:setAlpha(1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(500)
										f10_arg0:setLeftRight(0, 0, 25, 37)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
									f9_arg0:setAlpha(0)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
								f8_arg0:setAlpha(1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(500)
							f7_arg0:setLeftRight(0, 0, 13, 25)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.SquareFocus:beginAnimation(500)
				f3_arg0.SquareFocus:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.SquareFocus:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.SquareFocus:completeAnimation()
			f3_arg0.SquareFocus:setLeftRight(0, 0, 1, 13)
			f3_arg0.SquareFocus:setAlpha(0)
			f3_local0(f3_arg0.SquareFocus)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
