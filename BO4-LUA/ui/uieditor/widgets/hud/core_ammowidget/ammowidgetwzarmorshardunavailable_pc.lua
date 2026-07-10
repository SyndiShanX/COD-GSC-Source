CoD.AmmoWidgetWZArmorShardUnavailable_PC = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetWZArmorShardUnavailable_PC.__defaultWidth = 64
CoD.AmmoWidgetWZArmorShardUnavailable_PC.__defaultHeight = 59
CoD.AmmoWidgetWZArmorShardUnavailable_PC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetWZArmorShardUnavailable_PC)
	self.id = "AmmoWidgetWZArmorShardUnavailable_PC"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Inactive = LUI.UIImage.new(0.5, 0.5, -26, 26, 0.5, 0.5, -24.5, 22.5)
	Inactive:setRGB(0.88, 0.07, 0.07)
	Inactive:setAlpha(0.25)
	Inactive:setScale(1.4, 1.4)
	Inactive:setImage(RegisterImage(0x8440A4FA2F1A6DC))
	self:addElement(Inactive)
	self.Inactive = Inactive
	self:mergeStateConditions({
		{
			stateName = "IconHidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.WZUtility.SetupAnimateArmorShardSlotWhenUnavailable(self, f1_arg1)
	return self
end
CoD.AmmoWidgetWZArmorShardUnavailable_PC.__resetProperties = function(f3_arg0)
	f3_arg0.Inactive:completeAnimation()
	f3_arg0.Inactive:setAlpha(0.25)
end
CoD.AmmoWidgetWZArmorShardUnavailable_PC.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Inactive:completeAnimation()
			f4_arg0.Inactive:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Inactive)
		end,
		Empty = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
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
													f15_arg0:beginAnimation(210)
													f15_arg0:setAlpha(0)
													f15_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
												end
												f14_arg0:beginAnimation(10)
												f14_arg0:setAlpha(0.76)
												f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
											end
											f13_arg0:beginAnimation(19)
											f13_arg0:setAlpha(0.5)
											f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
										end
										f12_arg0:beginAnimation(9)
										f12_arg0:setAlpha(0.51)
										f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
									end
									f11_arg0:beginAnimation(30)
									f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
								end
								f10_arg0:beginAnimation(10)
								f10_arg0:setAlpha(0.75)
								f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
							end
							f9_arg0:beginAnimation(20)
							f9_arg0:setAlpha(0.11)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
						end
						f8_arg0:beginAnimation(10)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(20)
					f7_arg0:setAlpha(0.71)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.Inactive:beginAnimation(10)
				f5_arg0.Inactive:setAlpha(0.75)
				f5_arg0.Inactive:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Inactive:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.Inactive:completeAnimation()
			f5_arg0.Inactive:setAlpha(0)
			f5_local0(f5_arg0.Inactive)
		end,
	},
	IconHidden = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Inactive:completeAnimation()
			f16_arg0.Inactive:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Inactive)
		end,
		Empty = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							local f21_local0 = function(f22_arg0)
								local f22_local0 = function(f23_arg0)
									local f23_local0 = function(f24_arg0)
										local f24_local0 = function(f25_arg0)
											local f25_local0 = function(f26_arg0)
												local f26_local0 = function(f27_arg0)
													f27_arg0:beginAnimation(210)
													f27_arg0:setAlpha(0)
													f27_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
												end
												f26_arg0:beginAnimation(10)
												f26_arg0:setAlpha(0.76)
												f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
											end
											f25_arg0:beginAnimation(19)
											f25_arg0:setAlpha(0.5)
											f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
										end
										f24_arg0:beginAnimation(9)
										f24_arg0:setAlpha(0.51)
										f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
									end
									f23_arg0:beginAnimation(30)
									f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
								end
								f22_arg0:beginAnimation(10)
								f22_arg0:setAlpha(0.75)
								f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
							end
							f21_arg0:beginAnimation(20)
							f21_arg0:setAlpha(0.11)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
						end
						f20_arg0:beginAnimation(10)
						f20_arg0:setAlpha(0)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(20)
					f19_arg0:setAlpha(0.71)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f17_arg0.Inactive:beginAnimation(10)
				f17_arg0.Inactive:setAlpha(0.75)
				f17_arg0.Inactive:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.Inactive:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.Inactive:completeAnimation()
			f17_arg0.Inactive:setAlpha(0)
			f17_local0(f17_arg0.Inactive)
		end,
	},
}
