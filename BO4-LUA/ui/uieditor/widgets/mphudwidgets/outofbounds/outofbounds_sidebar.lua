CoD.outofbounds_sidebar = InheritFrom(LUI.UIElement)
CoD.outofbounds_sidebar.__defaultWidth = 392
CoD.outofbounds_sidebar.__defaultHeight = 108
CoD.outofbounds_sidebar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_sidebar)
	self.id = "outofbounds_sidebar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RightBar = LUI.UIImage.new(0, 0, -0.5, 391.5, 0, 0, 0, 108)
	RightBar:setImage(RegisterImage(0x58E45222EA3A7EF))
	RightBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(RightBar)
	self.RightBar = RightBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.outofbounds_sidebar.__resetProperties = function(f2_arg0)
	f2_arg0.RightBar:completeAnimation()
	f2_arg0.RightBar:setAlpha(1)
end
CoD.outofbounds_sidebar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										f10_arg0:beginAnimation(490)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
									end
									f9_arg0:beginAnimation(90)
									f9_arg0:setAlpha(0.5)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(89)
								f8_arg0:setAlpha(0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(90)
							f7_arg0:setAlpha(0.5)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(89)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(80)
					f5_arg0:setAlpha(0.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.RightBar:beginAnimation(70)
				f3_arg0.RightBar:setAlpha(0)
				f3_arg0.RightBar:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.RightBar:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.RightBar:completeAnimation()
			f3_arg0.RightBar:setAlpha(0.5)
			f3_local0(f3_arg0.RightBar)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
	IsOutOfBounds = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
}
