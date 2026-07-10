CoD.callingcards_loot2_surrealistlandscapes_ball = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_surrealistlandscapes_ball.__defaultWidth = 48
CoD.callingcards_loot2_surrealistlandscapes_ball.__defaultHeight = 48
CoD.callingcards_loot2_surrealistlandscapes_ball.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_surrealistlandscapes_ball)
	self.id = "callingcards_loot2_surrealistlandscapes_ball"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ball = LUI.UIImage.new(0, 0, 0, 48, 0, 0, 0, 48)
	ball:setImage(RegisterImage(0x677E544F069DB17))
	self:addElement(ball)
	self.ball = ball
	local ball2 = LUI.UIImage.new(0, 0, -28, 76, 0, 0, -28, 76)
	ball2:setImage(RegisterImage(0xFFBEF2D5D94F063))
	ball2:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ball2)
	self.ball2 = ball2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_loot2_surrealistlandscapes_ball.__resetProperties = function(f2_arg0)
	f2_arg0.ball2:completeAnimation()
	f2_arg0.ball2:setAlpha(1)
end
CoD.callingcards_loot2_surrealistlandscapes_ball.__clipsPerState = {
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
												f12_arg0:beginAnimation(480)
												f12_arg0:setAlpha(0.1)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f11_arg0:beginAnimation(119)
											f11_arg0:setAlpha(0.4)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(750)
										f10_arg0:setAlpha(0.1)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(149)
									f9_arg0:setAlpha(0.4)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(299)
								f8_arg0:setAlpha(0.1)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(140)
							f7_arg0:setAlpha(0.4)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(459)
						f6_arg0:setAlpha(0.1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(300)
					f5_arg0:setAlpha(0.4)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.ball2:beginAnimation(300)
				f3_arg0.ball2:setAlpha(0.1)
				f3_arg0.ball2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ball2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ball2:completeAnimation()
			f3_arg0.ball2:setAlpha(0.4)
			f3_local0(f3_arg0.ball2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
