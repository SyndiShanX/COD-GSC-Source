CoD.CallingCards_Asset_superheroes_speed_lightning = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_superheroes_speed_lightning.__defaultWidth = 960
CoD.CallingCards_Asset_superheroes_speed_lightning.__defaultHeight = 240
CoD.CallingCards_Asset_superheroes_speed_lightning.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_superheroes_speed_lightning)
	self.id = "CallingCards_Asset_superheroes_speed_lightning"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lightning01 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightning01:setImage(RegisterImage(@"hash_1A9147915A4E8EC9"))
	self:addElement(lightning01)
	self.lightning01 = lightning01
	local lightning02 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightning02:setImage(RegisterImage(@"hash_1A9144915A4E89B0"))
	self:addElement(lightning02)
	self.lightning02 = lightning02
	local lightning03 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightning03:setImage(RegisterImage(@"hash_1A9145915A4E8B63"))
	self:addElement(lightning03)
	self.lightning03 = lightning03
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_superheroes_speed_lightning.__resetProperties = function(f2_arg0)
	f2_arg0.lightning01:completeAnimation()
	f2_arg0.lightning02:completeAnimation()
	f2_arg0.lightning03:completeAnimation()
	f2_arg0.lightning01:setAlpha(1)
	f2_arg0.lightning02:setAlpha(1)
	f2_arg0.lightning03:setAlpha(1)
end
CoD.CallingCards_Asset_superheroes_speed_lightning.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							local f7_local0 = function(f8_arg0)
								local f8_local0 = function(f9_arg0)
									local f9_local0 = function(f10_arg0)
										local f10_local0 = function(f11_arg0)
											local f11_local0 = function(f12_arg0)
												f12_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_out"])
												f12_arg0:setAlpha(1)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f11_arg0:beginAnimation(399, Enum[@"luitween"][@"luitween_ease_out"])
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(340, Enum[@"luitween"][@"luitween_ease_out"])
										f10_arg0:setAlpha(0)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(360, Enum[@"luitween"][@"luitween_ease_out"])
									f9_arg0:setAlpha(1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_out"])
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
							f7_arg0:setAlpha(0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_out"])
						f6_arg0:setAlpha(1)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.lightning01:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.lightning01:setAlpha(0)
				f3_arg0.lightning01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lightning01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.lightning01:completeAnimation()
			f3_arg0.lightning01:setAlpha(1)
			f3_local0(f3_arg0.lightning01)
			local f3_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								local f17_local0 = function(f18_arg0)
									local f18_local0 = function(f19_arg0)
										local f19_local0 = function(f20_arg0)
											local f20_local0 = function(f21_arg0)
												f21_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_out"])
												f21_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f20_arg0:beginAnimation(399, Enum[@"luitween"][@"luitween_ease_out"])
											f20_arg0:setAlpha(0)
											f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
										end
										f19_arg0:beginAnimation(340, Enum[@"luitween"][@"luitween_ease_out"])
										f19_arg0:setAlpha(1)
										f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
									end
									f18_arg0:beginAnimation(360, Enum[@"luitween"][@"luitween_ease_out"])
									f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
								end
								f17_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_out"])
								f17_arg0:setAlpha(0)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
							end
							f16_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
							f16_arg0:setAlpha(1)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_out"])
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
					f14_arg0:setAlpha(0)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f3_arg0.lightning02:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.lightning02:setAlpha(1)
				f3_arg0.lightning02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lightning02:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.lightning02:completeAnimation()
			f3_arg0.lightning02:setAlpha(0)
			f3_local1(f3_arg0.lightning02)
			local f3_local2 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							local f25_local0 = function(f26_arg0)
								local f26_local0 = function(f27_arg0)
									local f27_local0 = function(f28_arg0)
										local f28_local0 = function(f29_arg0)
											local f29_local0 = function(f30_arg0)
												f30_arg0:beginAnimation(400, Enum[@"luitween"][@"luitween_ease_out"])
												f30_arg0:setAlpha(0)
												f30_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
											end
											f29_arg0:beginAnimation(399, Enum[@"luitween"][@"luitween_ease_out"])
											f29_arg0:setAlpha(1)
											f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
										end
										f28_arg0:beginAnimation(340, Enum[@"luitween"][@"luitween_ease_out"])
										f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
									end
									f27_arg0:beginAnimation(360, Enum[@"luitween"][@"luitween_ease_out"])
									f27_arg0:setAlpha(0)
									f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
								end
								f26_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_out"])
								f26_arg0:setAlpha(1)
								f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
							end
							f25_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
							f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
						end
						f24_arg0:beginAnimation(299, Enum[@"luitween"][@"luitween_ease_out"])
						f24_arg0:setAlpha(0)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f3_arg0.lightning03:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.lightning03:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lightning03:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f3_arg0.lightning03:completeAnimation()
			f3_arg0.lightning03:setAlpha(0)
			f3_local2(f3_arg0.lightning03)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
