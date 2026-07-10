CoD[@"hash_1A10CE63C9B72BC9"] = InheritFrom(LUI.UIElement)
CoD[@"hash_1A10CE63C9B72BC9"].__defaultWidth = 960
CoD[@"hash_1A10CE63C9B72BC9"].__defaultHeight = 240
CoD[@"hash_1A10CE63C9B72BC9"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_1A10CE63C9B72BC9"])
	self.id = "ui_icon_callingcards_prestigemaster"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0x9D9E5BF4A969074))
	self:addElement(background)
	self.background = background
	local helicopters = LUI.UIImage.new(0, 0, 132, 588, 0, 0, 0, 104)
	helicopters:setAlpha(0.4)
	helicopters:setImage(RegisterImage(@"uie_ui_menu_callingcards_prestigemaster_helicopters"))
	self:addElement(helicopters)
	self.helicopters = helicopters
	local murderer = LUI.UIImage.new(0, 0, 569, 873, 0, 0, 0, 216)
	murderer:setImage(RegisterImage(@"uie_ui_menu_callingcards_prestigemaster_murderer"))
	self:addElement(murderer)
	self.murderer = murderer
	local victim = LUI.UIImage.new(0, 0, 466, 922, 0, 0, 64, 240)
	victim:setImage(RegisterImage(@"uie_ui_menu_callingcards_prestigemaster_victim"))
	self:addElement(victim)
	self.victim = victim
	local knifehand = LUI.UIImage.new(0, 0, 660, 964, 0, 0, 8, 184)
	knifehand:setImage(RegisterImage(@"uie_ui_menu_callingcards_prestigemaster_arm"))
	self:addElement(knifehand)
	self.knifehand = knifehand
	local water = LUI.UIImage.new(0, 0, 360, 960, 0, 0, 24, 240)
	water:setImage(RegisterImage(@"uie_ui_menu_callingcards_prestigemaster_effects"))
	self:addElement(water)
	self.water = water
	local hand = LUI.UIImage.new(0, 0, 429.5, 573.5, 0, 0, 168, 240)
	hand:setImage(RegisterImage(@"uie_ui_menu_callingcards_prestigemaster_hand"))
	self:addElement(hand)
	self.hand = hand
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_1A10CE63C9B72BC9"].__resetProperties = function(f2_arg0)
	f2_arg0.helicopters:completeAnimation()
	f2_arg0.murderer:completeAnimation()
	f2_arg0.victim:completeAnimation()
	f2_arg0.knifehand:completeAnimation()
	f2_arg0.water:completeAnimation()
	f2_arg0.hand:completeAnimation()
	f2_arg0.helicopters:setLeftRight(0, 0, 132, 588)
	f2_arg0.murderer:setLeftRight(0, 0, 569, 873)
	f2_arg0.victim:setLeftRight(0, 0, 466, 922)
	f2_arg0.knifehand:setLeftRight(0, 0, 660, 964)
	f2_arg0.knifehand:setTopBottom(0, 0, 8, 184)
	f2_arg0.water:setLeftRight(0, 0, 360, 960)
	f2_arg0.hand:setLeftRight(0, 0, 429.5, 573.5)
end
CoD[@"hash_1A10CE63C9B72BC9"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(6)
			local f3_local0 = function(f4_arg0)
				f3_arg0.helicopters:beginAnimation(6000)
				f3_arg0.helicopters:setLeftRight(0, 0, -408, 48)
				f3_arg0.helicopters:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.helicopters:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.helicopters:completeAnimation()
			f3_arg0.helicopters:setLeftRight(0, 0, 873, 1329)
			f3_local0(f3_arg0.helicopters)
			local f3_local1 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							f8_arg0:beginAnimation(1500)
							f8_arg0:setLeftRight(0, 0, 569, 873)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f7_arg0:beginAnimation(1500)
						f7_arg0:setLeftRight(0, 0, 594, 898)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(1500)
					f6_arg0:setLeftRight(0, 0, 569, 873)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f3_arg0.murderer:beginAnimation(1500)
				f3_arg0.murderer:setLeftRight(0, 0, 594, 898)
				f3_arg0.murderer:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.murderer:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f3_arg0.murderer:completeAnimation()
			f3_arg0.murderer:setLeftRight(0, 0, 569, 873)
			f3_local1(f3_arg0.murderer)
			local f3_local2 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						local f11_local0 = function(f12_arg0)
							f12_arg0:beginAnimation(1500)
							f12_arg0:setLeftRight(0, 0, 466, 922)
							f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f11_arg0:beginAnimation(1500)
						f11_arg0:setLeftRight(0, 0, 476, 932)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
					end
					f10_arg0:beginAnimation(1500)
					f10_arg0:setLeftRight(0, 0, 466, 922)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f3_arg0.victim:beginAnimation(1500)
				f3_arg0.victim:setLeftRight(0, 0, 476, 932)
				f3_arg0.victim:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.victim:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f3_arg0.victim:completeAnimation()
			f3_arg0.victim:setLeftRight(0, 0, 466, 922)
			f3_local2(f3_arg0.victim)
			local f3_local3 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							f16_arg0:beginAnimation(1500)
							f16_arg0:setLeftRight(0, 0, 660, 988)
							f16_arg0:setTopBottom(0, 0, 8, 232)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f15_arg0:beginAnimation(1500)
						f15_arg0:setLeftRight(0, 0, 607, 935)
						f15_arg0:setTopBottom(0, 0, 52, 276)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(1500)
					f14_arg0:setLeftRight(0, 0, 659.5, 987.5)
					f14_arg0:setTopBottom(0, 0, 8.5, 232.5)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f3_arg0.knifehand:beginAnimation(1500)
				f3_arg0.knifehand:setLeftRight(0, 0, 607, 935)
				f3_arg0.knifehand:setTopBottom(0, 0, 52, 276)
				f3_arg0.knifehand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.knifehand:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.knifehand:completeAnimation()
			f3_arg0.knifehand:setLeftRight(0, 0, 660, 988)
			f3_arg0.knifehand:setTopBottom(0, 0, 8, 232)
			f3_local3(f3_arg0.knifehand)
			local f3_local4 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					local f18_local0 = function(f19_arg0)
						local f19_local0 = function(f20_arg0)
							f20_arg0:beginAnimation(1500)
							f20_arg0:setLeftRight(0, 0, 385, 985)
							f20_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f19_arg0:beginAnimation(1500)
						f19_arg0:setLeftRight(0, 0, 360, 960)
						f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
					end
					f18_arg0:beginAnimation(1500)
					f18_arg0:setLeftRight(0, 0, 385, 985)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
				end
				f3_arg0.water:beginAnimation(1500)
				f3_arg0.water:setLeftRight(0, 0, 360, 960)
				f3_arg0.water:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.water:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f3_arg0.water:completeAnimation()
			f3_arg0.water:setLeftRight(0, 0, 385, 985)
			f3_local4(f3_arg0.water)
			local f3_local5 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						local f23_local0 = function(f24_arg0)
							f24_arg0:beginAnimation(1500)
							f24_arg0:setLeftRight(0, 0, 429.5, 573.5)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f23_arg0:beginAnimation(1500)
						f23_arg0:setLeftRight(0, 0, 464.5, 608.5)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(1500)
					f22_arg0:setLeftRight(0, 0, 429.5, 573.5)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f3_arg0.hand:beginAnimation(1500)
				f3_arg0.hand:setLeftRight(0, 0, 464.5, 608.5)
				f3_arg0.hand:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.hand:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f3_arg0.hand:completeAnimation()
			f3_arg0.hand:setLeftRight(0, 0, 429.5, 573.5)
			f3_local5(f3_arg0.hand)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
