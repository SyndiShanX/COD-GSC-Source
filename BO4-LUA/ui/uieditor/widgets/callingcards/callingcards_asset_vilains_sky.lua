CoD.CallingCards_Asset_vilains_sky = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_vilains_sky.__defaultWidth = 960
CoD.CallingCards_Asset_vilains_sky.__defaultHeight = 240
CoD.CallingCards_Asset_vilains_sky.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_vilains_sky)
	self.id = "CallingCards_Asset_vilains_sky"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(0x6990A27E3DE26BC))
	self:addElement(bg)
	self.bg = bg
	local bg2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg2:setZRot(180)
	bg2:setImage(RegisterImage(0x6990A27E3DE26BC))
	self:addElement(bg2)
	self.bg2 = bg2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_vilains_sky.__resetProperties = function(f2_arg0)
	f2_arg0.bg2:completeAnimation()
	f2_arg0.bg2:setAlpha(1)
end
CoD.CallingCards_Asset_vilains_sky.__clipsPerState = {
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
										local f10_local0 = function(f11_arg0)
											local f11_local0 = function(f12_arg0)
												local f12_local0 = function(f13_arg0)
													f13_arg0:beginAnimation(299)
													f13_arg0:setAlpha(1)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
												end
												f12_arg0:beginAnimation(299)
												f12_arg0:setAlpha(0)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(300)
											f11_arg0:setAlpha(1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(299)
										f10_arg0:setAlpha(0)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(299)
									f9_arg0:setAlpha(1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(299)
								f8_arg0:setAlpha(0)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(300)
							f7_arg0:setAlpha(1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(299)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(300)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.bg2:beginAnimation(300)
				f3_arg0.bg2:setAlpha(0)
				f3_arg0.bg2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bg2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.bg2:completeAnimation()
			f3_arg0.bg2:setAlpha(1)
			f3_local0(f3_arg0.bg2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
