CoD.callingcards_loot2_circusclown_fire01 = InheritFrom(LUI.UIElement)
CoD.callingcards_loot2_circusclown_fire01.__defaultWidth = 120
CoD.callingcards_loot2_circusclown_fire01.__defaultHeight = 264
CoD.callingcards_loot2_circusclown_fire01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_loot2_circusclown_fire01)
	self.id = "callingcards_loot2_circusclown_fire01"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fire01 = LUI.UIImage.new(0, 0, 0, 120, 0, 0, 0, 264)
	fire01:setImage(RegisterImage(@"uie_ui_menu_callingcards_circusclown_fire01"))
	fire01:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(fire01)
	self.fire01 = fire01
	local fire02 = LUI.UIImage.new(0, 0, 0, 120, 0, 0, 0, 264)
	fire02:setAlpha(0.6)
	fire02:setImage(RegisterImage(@"uie_ui_menu_callingcards_circusclown_fire03"))
	fire02:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(fire02)
	self.fire02 = fire02
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_loot2_circusclown_fire01.__resetProperties = function(f2_arg0)
	f2_arg0.fire01:completeAnimation()
	f2_arg0.fire02:completeAnimation()
	f2_arg0.fire01:setLeftRight(0, 0, 0, 120)
	f2_arg0.fire01:setTopBottom(0, 0, 0, 264)
	f2_arg0.fire01:setAlpha(1)
	f2_arg0.fire01:setScale(1, 1)
	f2_arg0.fire02:setLeftRight(0, 0, 0, 120)
	f2_arg0.fire02:setTopBottom(0, 0, 0, 264)
	f2_arg0.fire02:setAlpha(0.6)
	f2_arg0.fire02:setScale(1, 1)
	f2_arg0.fire02:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
end
CoD.callingcards_loot2_circusclown_fire01.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
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
													f13_arg0:setTopBottom(0, 0, 0, 264)
													f13_arg0:setScale(1, 1)
													f13_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
												end
												f12_arg0:beginAnimation(299)
												f12_arg0:setTopBottom(0, 0, 12, 276)
												f12_arg0:setScale(1, 0.93)
												f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
											end
											f11_arg0:beginAnimation(100)
											f11_arg0:setTopBottom(0, 0, 0, 264)
											f11_arg0:setScale(1, 1)
											f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
										end
										f10_arg0:beginAnimation(500)
										f10_arg0:setTopBottom(0, 0, 12, 276)
										f10_arg0:setScale(1, 0.93)
										f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
									end
									f9_arg0:beginAnimation(299)
									f9_arg0:setTopBottom(0, 0, 0, 264)
									f9_arg0:setScale(1, 1)
									f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
								end
								f8_arg0:beginAnimation(299)
								f8_arg0:setTopBottom(0, 0, 12, 276)
								f8_arg0:setScale(1, 0.93)
								f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
							end
							f7_arg0:beginAnimation(100)
							f7_arg0:setTopBottom(0, 0, 0, 264)
							f7_arg0:setScale(1, 1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
						end
						f6_arg0:beginAnimation(700)
						f6_arg0:setTopBottom(0, 0, 12, 276)
						f6_arg0:setScale(1, 0.93)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(99)
					f5_arg0:setTopBottom(0, 0, 0, 264)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.fire01:beginAnimation(300)
				f3_arg0.fire01:setTopBottom(0, 0, 12, 276)
				f3_arg0.fire01:setScale(1, 0.93)
				f3_arg0.fire01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.fire01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.fire01:completeAnimation()
			f3_arg0.fire01:setLeftRight(0, 0, 0, 120)
			f3_arg0.fire01:setTopBottom(0, 0, 0, 264)
			f3_arg0.fire01:setAlpha(0.5)
			f3_arg0.fire01:setScale(1, 1)
			f3_local0(f3_arg0.fire01)
			local f3_local1 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					local f15_local0 = function(f16_arg0)
						local f16_local0 = function(f17_arg0)
							local f17_local0 = function(f18_arg0)
								local f18_local0 = function(f19_arg0)
									local f19_local0 = function(f20_arg0)
										local f20_local0 = function(f21_arg0)
											local f21_local0 = function(f22_arg0)
												local f22_local0 = function(f23_arg0)
													f23_arg0:beginAnimation(400)
													f23_arg0:setTopBottom(0, 0, 0, 264)
													f23_arg0:setScale(1, 1)
													f23_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
												end
												f22_arg0:beginAnimation(99)
												f22_arg0:setTopBottom(0, 0, 12, 276)
												f22_arg0:setScale(1, 0.93)
												f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
											end
											f21_arg0:beginAnimation(400)
											f21_arg0:setTopBottom(0, 0, 0, 264)
											f21_arg0:setScale(1, 1)
											f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
										end
										f20_arg0:beginAnimation(99)
										f20_arg0:setTopBottom(0, 0, 12, 276)
										f20_arg0:setScale(1, 0.93)
										f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
									end
									f19_arg0:beginAnimation(600)
									f19_arg0:setTopBottom(0, 0, 0, 264)
									f19_arg0:setScale(1, 1)
									f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
								end
								f18_arg0:beginAnimation(100)
								f18_arg0:setTopBottom(0, 0, 12, 276)
								f18_arg0:setScale(1, 0.93)
								f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
							end
							f17_arg0:beginAnimation(499)
							f17_arg0:setTopBottom(0, 0, 0, 264)
							f17_arg0:setScale(1, 1)
							f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
						end
						f16_arg0:beginAnimation(100)
						f16_arg0:setTopBottom(0, 0, 12, 276)
						f16_arg0:setScale(1, 0.93)
						f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
					end
					f15_arg0:beginAnimation(599)
					f15_arg0:setTopBottom(0, 0, 0, 264)
					f15_arg0:setScale(1, 1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
				end
				f3_arg0.fire02:beginAnimation(100)
				f3_arg0.fire02:setTopBottom(0, 0, 12, 276)
				f3_arg0.fire02:setScale(1, 0.93)
				f3_arg0.fire02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.fire02:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f3_arg0.fire02:completeAnimation()
			f3_arg0.fire02:setLeftRight(0, 0, 0, 120)
			f3_arg0.fire02:setTopBottom(0, 0, 0, 264)
			f3_arg0.fire02:setAlpha(0.4)
			f3_arg0.fire02:setScale(1, 1)
			f3_arg0.fire02:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
			f3_local1(f3_arg0.fire02)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
