CoD.SpawnRegionPulse = InheritFrom(LUI.UIElement)
CoD.SpawnRegionPulse.__defaultWidth = 240
CoD.SpawnRegionPulse.__defaultHeight = 228
CoD.SpawnRegionPulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnRegionPulse)
	self.id = "SpawnRegionPulse"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local selectedPulse = LUI.UIImage.new(0, 0, 96, 144, 0, 0, 90, 138)
	selectedPulse:setAlpha(0)
	selectedPulse:setImage(RegisterImage(@"uie_ui_hud_selectspawn_pulse_wave"))
	selectedPulse:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(selectedPulse)
	self.selectedPulse = selectedPulse
	local selectedPulse2 = LUI.UIImage.new(0, 0, 96, 144, 0, 0, 90, 138)
	selectedPulse2:setAlpha(0)
	selectedPulse2:setImage(RegisterImage(@"uie_ui_hud_selectspawn_pulse_wave"))
	selectedPulse2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(selectedPulse2)
	self.selectedPulse2 = selectedPulse2
	local selectedPulse3 = LUI.UIImage.new(0, 0, 96, 144, 0, 0, 90, 138)
	selectedPulse3:setAlpha(0)
	selectedPulse3:setImage(RegisterImage(@"uie_ui_hud_selectspawn_pulse_wave"))
	selectedPulse3:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(selectedPulse3)
	self.selectedPulse3 = selectedPulse3
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnRegionPulse.__resetProperties = function(f2_arg0)
	f2_arg0.selectedPulse3:completeAnimation()
	f2_arg0.selectedPulse2:completeAnimation()
	f2_arg0.selectedPulse:completeAnimation()
	f2_arg0.selectedPulse3:setAlpha(0)
	f2_arg0.selectedPulse3:setScale(1, 1)
	f2_arg0.selectedPulse2:setAlpha(0)
	f2_arg0.selectedPulse2:setScale(1, 1)
	f2_arg0.selectedPulse:setAlpha(0)
	f2_arg0.selectedPulse:setScale(1, 1)
end
CoD.SpawnRegionPulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1300)
						f6_arg0:setAlpha(0)
						f6_arg0:setScale(2.8, 2.8)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(600)
					f5_arg0:setScale(1.57, 1.57)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.selectedPulse:beginAnimation(200)
				f3_arg0.selectedPulse:setAlpha(0.25)
				f3_arg0.selectedPulse:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.selectedPulse:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.selectedPulse:completeAnimation()
			f3_arg0.selectedPulse:setAlpha(0)
			f3_arg0.selectedPulse:setScale(1, 1)
			f3_local0(f3_arg0.selectedPulse)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						local f9_local0 = function(f10_arg0)
							f10_arg0:beginAnimation(1200)
							f10_arg0:setAlpha(0)
							f10_arg0:setScale(2.8, 2.8)
							f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f9_arg0:beginAnimation(600)
						f9_arg0:setScale(1.6, 1.6)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
					end
					f8_arg0:beginAnimation(199)
					f8_arg0:setAlpha(0.25)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.selectedPulse2:beginAnimation(700)
				f3_arg0.selectedPulse2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.selectedPulse2:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.selectedPulse2:completeAnimation()
			f3_arg0.selectedPulse2:setAlpha(0)
			f3_arg0.selectedPulse2:setScale(1, 1)
			f3_local1(f3_arg0.selectedPulse2)
			local f3_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							f14_arg0:beginAnimation(1099)
							f14_arg0:setAlpha(0)
							f14_arg0:setScale(2.8, 2.8)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f13_arg0:beginAnimation(600)
						f13_arg0:setScale(1.64, 1.64)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(200)
					f12_arg0:setAlpha(0.25)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f3_arg0.selectedPulse3:beginAnimation(1400)
				f3_arg0.selectedPulse3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.selectedPulse3:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.selectedPulse3:completeAnimation()
			f3_arg0.selectedPulse3:setAlpha(0)
			f3_arg0.selectedPulse3:setScale(1, 1)
			f3_local2(f3_arg0.selectedPulse3)
			f3_arg0.nextClip = "DefaultClip"
		end,
		Snap = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			local f15_local0 = function(f16_arg0)
				f16_arg0:beginAnimation(250)
				f16_arg0:setScale(1, 1)
				f16_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.selectedPulse:beginAnimation(120)
			f15_arg0.selectedPulse:setScale(18, 18)
			f15_arg0.selectedPulse:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
			f15_arg0.selectedPulse:registerEventHandler("transition_complete_keyframe", f15_local0)
			local f15_local1 = function(f17_arg0)
				f17_arg0:beginAnimation(250)
				f17_arg0:setScale(1, 1)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.selectedPulse2:beginAnimation(50)
			f15_arg0.selectedPulse2:setScale(18, 18)
			f15_arg0.selectedPulse2:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
			f15_arg0.selectedPulse2:registerEventHandler("transition_complete_keyframe", f15_local1)
			local f15_local2 = function(f18_arg0)
				f15_arg0.selectedPulse3:beginAnimation(250, Enum[@"luitween"][@"luitween_ease_both"])
				f15_arg0.selectedPulse3:setScale(1, 1)
				f15_arg0.selectedPulse3:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.selectedPulse3:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.selectedPulse3:completeAnimation()
			f15_arg0.selectedPulse3:setScale(18, 18)
			f15_local2(f15_arg0.selectedPulse3)
		end,
	},
}
