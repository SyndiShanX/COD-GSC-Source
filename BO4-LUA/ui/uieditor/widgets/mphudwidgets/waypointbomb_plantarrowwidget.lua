CoD.WaypointBomb_PlantArrowWidget = InheritFrom(LUI.UIElement)
CoD.WaypointBomb_PlantArrowWidget.__defaultWidth = 24
CoD.WaypointBomb_PlantArrowWidget.__defaultHeight = 24
CoD.WaypointBomb_PlantArrowWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointBomb_PlantArrowWidget)
	self.id = "WaypointBomb_PlantArrowWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Arrow4 = LUI.UIImage.new(0, 0, 71, 135, 0, 0, -4, 28)
	Arrow4:setAlpha(0.1)
	Arrow4:setImage(RegisterImage(0x78C80EBCBB9BAC9))
	self:addElement(Arrow4)
	self.Arrow4 = Arrow4
	local Arrow3 = LUI.UIImage.new(0, 0, 48, 80, 0, 0, -4, 28)
	Arrow3:setAlpha(0.4)
	Arrow3:setImage(RegisterImage(0xA949B4D208E9AAF))
	self:addElement(Arrow3)
	self.Arrow3 = Arrow3
	local Arrow2 = LUI.UIImage.new(0, 0, 25, 57, 0, 0, -4, 28)
	Arrow2:setAlpha(0.7)
	Arrow2:setImage(RegisterImage(0x78C7FEBCBB9B916))
	self:addElement(Arrow2)
	self.Arrow2 = Arrow2
	local Arrow = LUI.UIImage.new(0, 0, 0, 32, 0, 0, -4, 28)
	Arrow:setImage(RegisterImage(0xA949B4D208E9AAF))
	self:addElement(Arrow)
	self.Arrow = Arrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointBomb_PlantArrowWidget.__resetProperties = function(f2_arg0)
	f2_arg0.Arrow4:completeAnimation()
	f2_arg0.Arrow2:completeAnimation()
	f2_arg0.Arrow3:completeAnimation()
	f2_arg0.Arrow:completeAnimation()
	f2_arg0.Arrow4:setAlpha(0.1)
	f2_arg0.Arrow2:setAlpha(0.7)
	f2_arg0.Arrow3:setAlpha(0.4)
	f2_arg0.Arrow:setAlpha(1)
end
CoD.WaypointBomb_PlantArrowWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(290)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(260)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(190)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Arrow4:beginAnimation(240)
				f3_arg0.Arrow4:setAlpha(0.4)
				f3_arg0.Arrow4:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Arrow4:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Arrow4:completeAnimation()
			f3_arg0.Arrow4:setAlpha(0)
			f3_local0(f3_arg0.Arrow4)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							local f11_local0 = function(f12_arg0)
								f12_arg0:beginAnimation(200)
								f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f11_arg0:beginAnimation(260)
							f11_arg0:setAlpha(0)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
						end
						f10_arg0:beginAnimation(189)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(240)
					f9_arg0:setAlpha(0.6)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.Arrow3:beginAnimation(90)
				f3_arg0.Arrow3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Arrow3:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.Arrow3:completeAnimation()
			f3_arg0.Arrow3:setAlpha(0)
			f3_local1(f3_arg0.Arrow3)
			local f3_local2 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					local f14_local0 = function(f15_arg0)
						local f15_local0 = function(f16_arg0)
							local f16_local0 = function(f17_arg0)
								f17_arg0:beginAnimation(100)
								f17_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
							end
							f16_arg0:beginAnimation(260)
							f16_arg0:setAlpha(0)
							f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
						end
						f15_arg0:beginAnimation(190)
						f15_arg0:registerEventHandler("transition_complete_keyframe", f15_local0)
					end
					f14_arg0:beginAnimation(240)
					f14_arg0:setAlpha(0.8)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
				end
				f3_arg0.Arrow2:beginAnimation(190)
				f3_arg0.Arrow2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Arrow2:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f3_arg0.Arrow2:completeAnimation()
			f3_arg0.Arrow2:setAlpha(0)
			f3_local2(f3_arg0.Arrow2)
			local f3_local3 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						local f20_local0 = function(f21_arg0)
							f21_arg0:beginAnimation(260)
							f21_arg0:setAlpha(0)
							f21_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f20_arg0:beginAnimation(190)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f20_local0)
					end
					f19_arg0:beginAnimation(239)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f3_arg0.Arrow:beginAnimation(290)
				f3_arg0.Arrow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Arrow:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f3_arg0.Arrow:completeAnimation()
			f3_arg0.Arrow:setAlpha(0)
			f3_local3(f3_arg0.Arrow)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.Arrow4:completeAnimation()
			f22_arg0.Arrow4:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Arrow4)
			f22_arg0.Arrow3:completeAnimation()
			f22_arg0.Arrow3:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Arrow3)
			f22_arg0.Arrow2:completeAnimation()
			f22_arg0.Arrow2:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Arrow2)
			f22_arg0.Arrow:completeAnimation()
			f22_arg0.Arrow:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Arrow)
		end,
	},
}
