CoD.TabbedScoreboardLayoutTopLine = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardLayoutTopLine.__defaultWidth = 1438
CoD.TabbedScoreboardLayoutTopLine.__defaultHeight = 516
CoD.TabbedScoreboardLayoutTopLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardLayoutTopLine)
	self.id = "TabbedScoreboardLayoutTopLine"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MapLayoutTopLineBlur = LUI.UIImage.new(0, 0, 2.5, 1440.5, 0, 0, 2.5, 24.5)
	MapLayoutTopLineBlur:setRGB(0, 0, 0)
	MapLayoutTopLineBlur:setAlpha(0)
	MapLayoutTopLineBlur:setImage(RegisterImage(0x752078DE5A2A3AC))
	self:addElement(MapLayoutTopLineBlur)
	self.MapLayoutTopLineBlur = MapLayoutTopLineBlur
	local MapLayoutTopLine = LUI.UIImage.new(0, 0, 721, 721, 0, 0, 0, 22)
	MapLayoutTopLine:setImage(RegisterImage(0x752078DE5A2A3AC))
	self:addElement(MapLayoutTopLine)
	self.MapLayoutTopLine = MapLayoutTopLine
	local MapLayoutBotLine = LUI.UIImage.new(0, 0, 241, 241, 0, 0, 512, 516)
	MapLayoutBotLine:setImage(RegisterImage(0x4E3A97DAEE8B86A))
	self:addElement(MapLayoutBotLine)
	self.MapLayoutBotLine = MapLayoutBotLine
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardLayoutTopLine.__resetProperties = function(f2_arg0)
	f2_arg0.MapLayoutTopLine:completeAnimation()
	f2_arg0.MapLayoutTopLineBlur:completeAnimation()
	f2_arg0.MapLayoutBotLine:completeAnimation()
	f2_arg0.MapLayoutTopLine:setLeftRight(0, 0, 721, 721)
	f2_arg0.MapLayoutTopLine:setAlpha(1)
	f2_arg0.MapLayoutTopLineBlur:setAlpha(0)
	f2_arg0.MapLayoutBotLine:setLeftRight(0, 0, 241, 241)
	f2_arg0.MapLayoutBotLine:setAlpha(1)
end
CoD.TabbedScoreboardLayoutTopLine.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(200)
						f6_arg0:setAlpha(0.15)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(399)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.MapLayoutTopLineBlur:beginAnimation(1000)
				f3_arg0.MapLayoutTopLineBlur:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.MapLayoutTopLineBlur:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.MapLayoutTopLineBlur:completeAnimation()
			f3_arg0.MapLayoutTopLineBlur:setAlpha(0)
			f3_local0(f3_arg0.MapLayoutTopLineBlur)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(199)
						f9_arg0:setLeftRight(0, 0, 0, 1438)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f8_arg0:setLeftRight(0, 0, 359.5, 1078.5)
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f3_arg0.MapLayoutTopLine:beginAnimation(1000)
				f3_arg0.MapLayoutTopLine:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.MapLayoutTopLine:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.MapLayoutTopLine:completeAnimation()
			f3_arg0.MapLayoutTopLine:setLeftRight(0, 0, 719, 719)
			f3_arg0.MapLayoutTopLine:setAlpha(0)
			f3_local1(f3_arg0.MapLayoutTopLine)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						f12_arg0:beginAnimation(199)
						f12_arg0:setLeftRight(0, 0, 241, 1197)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f11_arg0:beginAnimation(200)
					f11_arg0:setLeftRight(0, 0, 241, 719)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f3_arg0.MapLayoutBotLine:beginAnimation(1000)
				f3_arg0.MapLayoutBotLine:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.MapLayoutBotLine:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.MapLayoutBotLine:completeAnimation()
			f3_arg0.MapLayoutBotLine:setLeftRight(0, 0, 241, 241)
			f3_arg0.MapLayoutBotLine:setAlpha(1)
			f3_local2(f3_arg0.MapLayoutBotLine)
		end,
	},
}
