CoD.AllocationBar = InheritFrom(LUI.UIElement)
CoD.AllocationBar.__defaultWidth = 17
CoD.AllocationBar.__defaultHeight = 17
CoD.AllocationBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AllocationBar)
	self.id = "AllocationBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local dashBacking = LUI.UIImage.new(0, 0, -8, 24, 0, 0, -8, 24)
	dashBacking:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_empty"))
	self:addElement(dashBacking)
	self.dashBacking = dashBacking
	local dash = LUI.UIImage.new(0, 0, -8, 24, 0, 0, -8, 24)
	dash:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_full"))
	self:addElement(dash)
	self.dash = dash
	local Glow = LUI.UIImage.new(0, 0, -12.5, 29.5, 0, 0, -28, 45)
	Glow:setRGB(0.88, 0.8, 0.45)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_t7_menu_cac_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local CornerDots = LUI.UIImage.new(0, 0, -8, 24, 0, 0, -8, 24)
	CornerDots:setImage(RegisterImage(@"uie_ui_menu_cac_allocation_pip_dots"))
	self:addElement(CornerDots)
	self.CornerDots = CornerDots
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AllocationBar.__resetProperties = function(f2_arg0)
	f2_arg0.dash:completeAnimation()
	f2_arg0.dashBacking:completeAnimation()
	f2_arg0.Glow:completeAnimation()
	f2_arg0.dash:setAlpha(1)
	f2_arg0.dashBacking:setAlpha(1)
	f2_arg0.Glow:setAlpha(0)
end
CoD.AllocationBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.dashBacking:completeAnimation()
			f3_arg0.dashBacking:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.dashBacking)
			f3_arg0.dash:completeAnimation()
			f3_arg0.dash:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.dash)
		end,
		PointSpending = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			local f4_local0 = function(f5_arg0)
				f4_arg0.dashBacking:beginAnimation(470)
				f4_arg0.dashBacking:setAlpha(0)
				f4_arg0.dashBacking:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.dashBacking:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.dashBacking:completeAnimation()
			f4_arg0.dashBacking:setAlpha(0.1)
			f4_local0(f4_arg0.dashBacking)
			local f4_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							local f9_local0 = function(f10_arg0)
								local f10_local0 = function(f11_arg0)
									local f11_local0 = function(f12_arg0)
										local f12_local0 = function(f13_arg0)
											local f13_local0 = function(f14_arg0)
												local f14_local0 = function(f15_arg0)
													f15_arg0:beginAnimation(560)
													f15_arg0:setAlpha(1)
													f15_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
												end
												f14_arg0:beginAnimation(10)
												f14_arg0:setAlpha(0.76)
												f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
											end
											f13_arg0:beginAnimation(19)
											f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
										end
										f12_arg0:beginAnimation(9)
										f12_arg0:setAlpha(0.4)
										f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
									end
									f11_arg0:beginAnimation(20)
									f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
								end
								f10_arg0:beginAnimation(9)
								f10_arg0:setAlpha(1)
								f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
							end
							f9_arg0:beginAnimation(20)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
						end
						f8_arg0:beginAnimation(10)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(30)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f4_arg0.dash:beginAnimation(10)
				f4_arg0.dash:setAlpha(0.5)
				f4_arg0.dash:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.dash:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f4_arg0.dash:completeAnimation()
			f4_arg0.dash:setAlpha(0)
			f4_local1(f4_arg0.dash)
			local f4_local2 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(430)
					f17_arg0:setAlpha(0)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f16_arg0:beginAnimation(80)
				f16_arg0:setAlpha(1)
				f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f4_arg0.Glow:beginAnimation(60)
			f4_arg0.Glow:setAlpha(0)
			f4_arg0.Glow:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.Glow:registerEventHandler("transition_complete_keyframe", f4_local2)
		end,
		PointSpent = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.dashBacking:completeAnimation()
			f18_arg0.dashBacking:setAlpha(0.06)
			f18_arg0.clipFinished(f18_arg0.dashBacking)
			f18_arg0.dash:completeAnimation()
			f18_arg0.dash:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.dash)
		end,
	},
}
