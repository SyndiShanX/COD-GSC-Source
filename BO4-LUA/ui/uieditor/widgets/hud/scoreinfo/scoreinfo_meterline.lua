CoD.ScoreInfo_MeterLine = InheritFrom(LUI.UIElement)
CoD.ScoreInfo_MeterLine.__defaultWidth = 76
CoD.ScoreInfo_MeterLine.__defaultHeight = 34
CoD.ScoreInfo_MeterLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfo_MeterLine)
	self.id = "ScoreInfo_MeterLine"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Line = LUI.UIImage.new(0, 0, 0, 76, 0, 0, 0, 34)
	Line:setRGB(1, 0.76, 0)
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(Line)
	self.Line = Line
	self:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return not HideScoreMeterDueToGameType()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfo_MeterLine.__resetProperties = function(f3_arg0)
	f3_arg0.Line:completeAnimation()
	f3_arg0.Line:setRGB(1, 0.76, 0)
	f3_arg0.Line:setAlpha(1)
end
CoD.ScoreInfo_MeterLine.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Line:completeAnimation()
			f4_arg0.Line:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Line)
		end,
	},
	Active = {
		DefaultClip = function(f5_arg0, f5_arg1)
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
													f15_arg0:beginAnimation(300)
													f15_arg0:setRGB(0, 0, 0)
													f15_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
												end
												f14_arg0:beginAnimation(60)
												f14_arg0:registerEventHandler("transition_complete_keyframe", f14_local0)
											end
											f13_arg0:beginAnimation(10)
											f13_arg0:setAlpha(1)
											f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
										end
										f12_arg0:beginAnimation(19)
										f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
									end
									f11_arg0:beginAnimation(9)
									f11_arg0:setAlpha(0.3)
									f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
								end
								f10_arg0:beginAnimation(20)
								f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
							end
							f9_arg0:beginAnimation(9)
							f9_arg0:setAlpha(1)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
						end
						f8_arg0:beginAnimation(30)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(10)
					f7_arg0:setAlpha(0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.Line:beginAnimation(30)
				f5_arg0.Line:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Line:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.Line:completeAnimation()
			f5_arg0.Line:setRGB(1, 0.76, 0)
			f5_arg0.Line:setAlpha(1)
			f5_local0(f5_arg0.Line)
		end,
	},
}
