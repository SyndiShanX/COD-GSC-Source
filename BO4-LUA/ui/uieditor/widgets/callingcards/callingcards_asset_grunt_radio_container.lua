CoD.CallingCards_Asset_grunt_radio_container = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_grunt_radio_container.__defaultWidth = 216
CoD.CallingCards_Asset_grunt_radio_container.__defaultHeight = 193
CoD.CallingCards_Asset_grunt_radio_container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_grunt_radio_container)
	self.id = "CallingCards_Asset_grunt_radio_container"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local radio = LUI.UIImage.new(0, 0, 0, 216, 0, 0, 0, 192)
	radio:setImage(RegisterImage(@"uie_grunt_radio"))
	self:addElement(radio)
	self.radio = radio
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_grunt_radio_container.__resetProperties = function(f2_arg0)
	f2_arg0.radio:completeAnimation()
	f2_arg0.radio:setLeftRight(0, 0, 0, 216)
	f2_arg0.radio:setTopBottom(0, 0, 0, 192)
end
CoD.CallingCards_Asset_grunt_radio_container.__clipsPerState = {
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
												f12_arg0:beginAnimation(359)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f11_arg0:beginAnimation(370)
											f11_arg0:setTopBottom(0, 0, -1.5, 190.5)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(360)
										f10_arg0:setTopBottom(0, 0, 2.5, 194.5)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(339)
									f9_arg0:setTopBottom(0, 0, -1.5, 190.5)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(310)
								f8_arg0:setTopBottom(0, 0, 2.5, 194.5)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(300)
							f7_arg0:setTopBottom(0, 0, -1.5, 190.5)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(329)
						f6_arg0:setTopBottom(0, 0, 2.5, 194.5)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(329)
					f5_arg0:setTopBottom(0, 0, -1.5, 190.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.radio:beginAnimation(300)
				f3_arg0.radio:setTopBottom(0, 0, 2.5, 194.5)
				f3_arg0.radio:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.radio:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.radio:completeAnimation()
			f3_arg0.radio:setLeftRight(0, 0, 0, 216)
			f3_arg0.radio:setTopBottom(0, 0, -1.5, 190.5)
			f3_local0(f3_arg0.radio)
		end,
	},
}
