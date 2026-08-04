CoD.CallingCards_Asset_falconfly = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_falconfly.__defaultWidth = 440
CoD.CallingCards_Asset_falconfly.__defaultHeight = 242
CoD.CallingCards_Asset_falconfly.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_falconfly)
	self.id = "CallingCards_Asset_falconfly"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backwing = LUI.UIImage.new(0, 0, 255.5, 439.5, 0, 0, 0, 112)
	backwing:setScale(1, 1.06)
	backwing:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_backwing"))
	self:addElement(backwing)
	self.backwing = backwing
	local bottomtalon1 = LUI.UIImage.new(0, 0, 302, 422, 0, 0, 178, 242)
	bottomtalon1:setAlpha(0)
	bottomtalon1:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_bottomtalon1"))
	self:addElement(bottomtalon1)
	self.bottomtalon1 = bottomtalon1
	local bottomtalon2 = LUI.UIImage.new(0, 0, 302, 422, 0, 0, 178, 242)
	bottomtalon2:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_bottomtalon2"))
	self:addElement(bottomtalon2)
	self.bottomtalon2 = bottomtalon2
	local birdbody = LUI.UIImage.new(0, 0, 0, 400, 0, 0, 78, 238)
	birdbody:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_body"))
	self:addElement(birdbody)
	self.birdbody = birdbody
	local bottomtalon3 = LUI.UIImage.new(0, 0, 302, 422, 0, 0, 178, 242)
	bottomtalon3:setAlpha(0)
	bottomtalon3:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_bottomtalon3"))
	self:addElement(bottomtalon3)
	self.bottomtalon3 = bottomtalon3
	local toptalon1 = LUI.UIImage.new(0, 0, 302, 422, 0, 0, 178, 242)
	toptalon1:setAlpha(0)
	toptalon1:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_toptalon1"))
	self:addElement(toptalon1)
	self.toptalon1 = toptalon1
	local toptalon2 = LUI.UIImage.new(0, 0, 302, 422, 0, 0, 178, 242)
	toptalon2:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_toptalon2"))
	self:addElement(toptalon2)
	self.toptalon2 = toptalon2
	local toptalon3 = LUI.UIImage.new(0, 0, 302, 422, 0, 0, 178, 242)
	toptalon3:setAlpha(0)
	toptalon3:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_toptalon3"))
	self:addElement(toptalon3)
	self.toptalon3 = toptalon3
	local topwing = LUI.UIImage.new(0, 0, 18, 314, 0, 0, 2.5, 146.5)
	topwing:setScale(1, 1.03)
	topwing:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_bird_topwing"))
	self:addElement(topwing)
	self.topwing = topwing
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_falconfly.__resetProperties = function(f2_arg0)
	f2_arg0.toptalon1:completeAnimation()
	f2_arg0.bottomtalon1:completeAnimation()
	f2_arg0.backwing:completeAnimation()
	f2_arg0.topwing:completeAnimation()
	f2_arg0.toptalon2:completeAnimation()
	f2_arg0.bottomtalon2:completeAnimation()
	f2_arg0.bottomtalon3:completeAnimation()
	f2_arg0.toptalon3:completeAnimation()
	f2_arg0.toptalon1:setAlpha(0)
	f2_arg0.bottomtalon1:setAlpha(0)
	f2_arg0.backwing:setLeftRight(0, 0, 255.5, 439.5)
	f2_arg0.backwing:setTopBottom(0, 0, 0, 112)
	f2_arg0.backwing:setScale(1, 1.06)
	f2_arg0.topwing:setLeftRight(0, 0, 18, 314)
	f2_arg0.topwing:setTopBottom(0, 0, 2.5, 146.5)
	f2_arg0.topwing:setScale(1, 1.03)
	f2_arg0.toptalon2:setAlpha(1)
	f2_arg0.bottomtalon2:setAlpha(1)
	f2_arg0.bottomtalon3:setAlpha(0)
	f2_arg0.toptalon3:setAlpha(0)
end
CoD.CallingCards_Asset_falconfly.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(8)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(450)
							f7_arg0:setScale(1, 1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(559)
						f6_arg0:setScale(1, 1.18)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(539)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.backwing:beginAnimation(460)
				f3_arg0.backwing:setScale(1, 1.18)
				f3_arg0.backwing:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.backwing:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.backwing:completeAnimation()
			f3_arg0.backwing:setLeftRight(0, 0, 255.5, 439.5)
			f3_arg0.backwing:setTopBottom(0, 0, 0, 112)
			f3_arg0.backwing:setScale(1, 1)
			f3_local0(f3_arg0.backwing)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(9)
							f11_arg0:setAlpha(1)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(650)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(9)
					f9_arg0:setAlpha(0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.bottomtalon1:beginAnimation(1000)
				f3_arg0.bottomtalon1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bottomtalon1:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.bottomtalon1:completeAnimation()
			f3_arg0.bottomtalon1:setAlpha(1)
			f3_local1(f3_arg0.bottomtalon1)
			local f3_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						local f14_local0 = function(f15_arg0)
							local f15_local0 = function(f16_arg0)
								local f16_local0 = function(f17_arg0)
									local f17_local0 = function(f18_arg0)
										f18_arg0:beginAnimation(9)
										f18_arg0:setAlpha(0)
										f18_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
									end
									f17_arg0:beginAnimation(209)
									f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
								end
								f16_arg0:beginAnimation(9)
								f16_arg0:setAlpha(1)
								f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
							end
							f15_arg0:beginAnimation(210)
							f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
						end
						f14_arg0:beginAnimation(9)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
					end
					f13_arg0:beginAnimation(210)
					f13_arg0:setAlpha(0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f12_arg0:beginAnimation(9)
				f12_arg0:setAlpha(1)
				f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f3_arg0.bottomtalon2:beginAnimation(1000)
			f3_arg0.bottomtalon2:setAlpha(0)
			f3_arg0.bottomtalon2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.bottomtalon2:registerEventHandler("transition_complete_keyframe", f3_local2)
			local f3_local3 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					local f20_local0 = function(f21_arg0)
						local f21_local0 = function(f22_arg0)
							f22_arg0:beginAnimation(9)
							f22_arg0:setAlpha(0)
							f22_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f21_arg0:beginAnimation(210)
						f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
					end
					f20_arg0:beginAnimation(9)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
				end
				f19_arg0:beginAnimation(210)
				f19_arg0:setAlpha(1)
				f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f3_arg0.bottomtalon3:beginAnimation(1010)
			f3_arg0.bottomtalon3:setAlpha(0)
			f3_arg0.bottomtalon3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.bottomtalon3:registerEventHandler("transition_complete_keyframe", f3_local3)
			local f3_local4 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						local f25_local0 = function(f26_arg0)
							f26_arg0:beginAnimation(9)
							f26_arg0:setAlpha(1)
							f26_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f25_arg0:beginAnimation(650)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
					end
					f24_arg0:beginAnimation(9)
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f3_arg0.toptalon1:beginAnimation(1000)
				f3_arg0.toptalon1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.toptalon1:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f3_arg0.toptalon1:completeAnimation()
			f3_arg0.toptalon1:setAlpha(1)
			f3_local4(f3_arg0.toptalon1)
			local f3_local5 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					local f28_local0 = function(f29_arg0)
						local f29_local0 = function(f30_arg0)
							local f30_local0 = function(f31_arg0)
								local f31_local0 = function(f32_arg0)
									local f32_local0 = function(f33_arg0)
										f33_arg0:beginAnimation(9)
										f33_arg0:setAlpha(0)
										f33_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
									end
									f32_arg0:beginAnimation(209)
									f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
								end
								f31_arg0:beginAnimation(9)
								f31_arg0:setAlpha(1)
								f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
							end
							f30_arg0:beginAnimation(210)
							f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
						end
						f29_arg0:beginAnimation(9)
						f29_arg0:setAlpha(0)
						f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
					end
					f28_arg0:beginAnimation(210)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
				end
				f27_arg0:beginAnimation(9)
				f27_arg0:setAlpha(1)
				f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f3_arg0.toptalon2:beginAnimation(1000)
			f3_arg0.toptalon2:setAlpha(0)
			f3_arg0.toptalon2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.toptalon2:registerEventHandler("transition_complete_keyframe", f3_local5)
			local f3_local6 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						f36_arg0:beginAnimation(9)
						f36_arg0:setAlpha(0)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f35_arg0:beginAnimation(210)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f34_arg0:beginAnimation(9)
				f34_arg0:setAlpha(1)
				f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f3_arg0.toptalon3:beginAnimation(1220)
			f3_arg0.toptalon3:setAlpha(0)
			f3_arg0.toptalon3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.toptalon3:registerEventHandler("transition_complete_keyframe", f3_local6)
			local f3_local7 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					local f38_local0 = function(f39_arg0)
						local f39_local0 = function(f40_arg0)
							f40_arg0:beginAnimation(440)
							f40_arg0:setLeftRight(0, 0, 18.5, 314.5)
							f40_arg0:setTopBottom(0, 0, 2, 146)
							f40_arg0:setScale(1, 1)
							f40_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f39_arg0:beginAnimation(559)
						f39_arg0:setLeftRight(0, 0, 16.5, 312.5)
						f39_arg0:setTopBottom(0, 0, 4, 148)
						f39_arg0:setScale(1, 1.08)
						f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
					end
					f38_arg0:beginAnimation(550)
					f38_arg0:setLeftRight(0, 0, 18.5, 314.5)
					f38_arg0:setTopBottom(0, 0, 2, 146)
					f38_arg0:setScale(1, 1)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
				end
				f3_arg0.topwing:beginAnimation(450)
				f3_arg0.topwing:setLeftRight(0, 0, 16.5, 312.5)
				f3_arg0.topwing:setTopBottom(0, 0, 4, 148)
				f3_arg0.topwing:setScale(1, 1.08)
				f3_arg0.topwing:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.topwing:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f3_arg0.topwing:completeAnimation()
			f3_arg0.topwing:setLeftRight(0, 0, 18.5, 314.5)
			f3_arg0.topwing:setTopBottom(0, 0, 2, 146)
			f3_arg0.topwing:setScale(1, 1)
			f3_local7(f3_arg0.topwing)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
