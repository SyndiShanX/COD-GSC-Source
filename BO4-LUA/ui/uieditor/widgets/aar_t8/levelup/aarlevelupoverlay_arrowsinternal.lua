CoD.AARLevelUpOverlay_ArrowsInternal = InheritFrom(LUI.UIElement)
CoD.AARLevelUpOverlay_ArrowsInternal.__defaultWidth = 24
CoD.AARLevelUpOverlay_ArrowsInternal.__defaultHeight = 53
CoD.AARLevelUpOverlay_ArrowsInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARLevelUpOverlay_ArrowsInternal)
	self.id = "AARLevelUpOverlay_ArrowsInternal"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local arrow1 = LUI.UIImage.new(0.5, 0.5, -12, 12, 1, 1, -24, 0)
	arrow1:setRGB(0.89, 0.69, 0.04)
	arrow1:setAlpha(0.15)
	arrow1:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_arrow"))
	self:addElement(arrow1)
	self.arrow1 = arrow1
	local arrow2 = LUI.UIImage.new(0.5, 0.5, -12, 12, 1, 1, -38.5, -14.5)
	arrow2:setRGB(0.89, 0.69, 0.04)
	arrow2:setAlpha(0.1)
	arrow2:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_arrow"))
	self:addElement(arrow2)
	self.arrow2 = arrow2
	local arrow3 = LUI.UIImage.new(0.5, 0.5, -12, 12, 1, 1, -53, -29)
	arrow3:setRGB(0.89, 0.69, 0.04)
	arrow3:setAlpha(0.05)
	arrow3:setImage(RegisterImage(@"uie_ui_menu_aar_levelup_arrow"))
	self:addElement(arrow3)
	self.arrow3 = arrow3
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARLevelUpOverlay_ArrowsInternal.__resetProperties = function(f2_arg0)
	f2_arg0.arrow1:completeAnimation()
	f2_arg0.arrow2:completeAnimation()
	f2_arg0.arrow3:completeAnimation()
	f2_arg0.arrow1:setAlpha(0.15)
	f2_arg0.arrow2:setAlpha(0.1)
	f2_arg0.arrow3:setAlpha(0.05)
end
CoD.AARLevelUpOverlay_ArrowsInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								f8_arg0:beginAnimation(289)
								f8_arg0:setAlpha(0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f7_arg0:beginAnimation(300)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(299)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(300)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.arrow1:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.arrow1:setAlpha(0.15)
				f3_arg0.arrow1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.arrow1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.arrow1:completeAnimation()
			f3_arg0.arrow1:setAlpha(0)
			f3_local0(f3_arg0.arrow1)
			local f3_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							local f12_local0 = function(f13_arg0)
								f13_arg0:beginAnimation(289)
								f13_arg0:setAlpha(0)
								f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f12_arg0:beginAnimation(300)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
						end
						f11_arg0:beginAnimation(299)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_in"])
					f10_arg0:setAlpha(0.1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f3_arg0.arrow2:beginAnimation(300)
				f3_arg0.arrow2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.arrow2:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.arrow2:completeAnimation()
			f3_arg0.arrow2:setAlpha(0)
			f3_local1(f3_arg0.arrow2)
			local f3_local2 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							local f17_local0 = function(f18_arg0)
								local f18_local0 = function(f19_arg0)
									f19_arg0:beginAnimation(510)
									f19_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
								end
								f18_arg0:beginAnimation(289)
								f18_arg0:setAlpha(0)
								f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
							end
							f17_arg0:beginAnimation(300)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
						end
						f16_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_in"])
						f16_arg0:setAlpha(0.05)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(300)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f3_arg0.arrow3:beginAnimation(300)
				f3_arg0.arrow3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.arrow3:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.arrow3:completeAnimation()
			f3_arg0.arrow3:setAlpha(0)
			f3_local2(f3_arg0.arrow3)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
