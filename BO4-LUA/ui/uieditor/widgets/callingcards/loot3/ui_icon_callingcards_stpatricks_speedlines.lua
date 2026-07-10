CoD.ui_icon_callingcards_stpatricks_speedlines = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_stpatricks_speedlines.__defaultWidth = 1230
CoD.ui_icon_callingcards_stpatricks_speedlines.__defaultHeight = 728
CoD.ui_icon_callingcards_stpatricks_speedlines.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_stpatricks_speedlines)
	self.id = "ui_icon_callingcards_stpatricks_speedlines"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local speedlines = LUI.UIImage.new(0, 0, 0, 1230, 0, 0, 0, 728)
	speedlines:setImage(RegisterImage(@"uie_ui_menu_callingcards_stpatricks_f1_speedlines1"))
	self:addElement(speedlines)
	self.speedlines = speedlines
	local speedlines2 = LUI.UIImage.new(0, 0, 0, 1230, 0, 0, 0, 728)
	speedlines2:setImage(RegisterImage(@"uie_ui_menu_callingcards_stpatricks_f1_speedlines2"))
	self:addElement(speedlines2)
	self.speedlines2 = speedlines2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_stpatricks_speedlines.__resetProperties = function(f2_arg0)
	f2_arg0.speedlines2:completeAnimation()
	f2_arg0.speedlines:completeAnimation()
	f2_arg0.speedlines2:setAlpha(1)
	f2_arg0.speedlines2:setScale(1, 1)
	f2_arg0.speedlines:setAlpha(1)
	f2_arg0.speedlines:setScale(1, 1)
end
CoD.ui_icon_callingcards_stpatricks_speedlines.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setAlpha(0)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.speedlines:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.speedlines:setAlpha(1)
				f3_arg0.speedlines:setScale(0.9, 0.9)
				f3_arg0.speedlines:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.speedlines:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.speedlines:completeAnimation()
			f3_arg0.speedlines:setAlpha(0)
			f3_arg0.speedlines:setScale(1, 1)
			f3_local0(f3_arg0.speedlines)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
					f7_arg0:setAlpha(1)
					f7_arg0:setScale(0.9, 0.9)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.speedlines2:beginAnimation(500, Enum[@"luitween"][@"luitween_ease_both"])
				f3_arg0.speedlines2:setAlpha(0)
				f3_arg0.speedlines2:setScale(1, 1)
				f3_arg0.speedlines2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.speedlines2:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.speedlines2:completeAnimation()
			f3_arg0.speedlines2:setAlpha(1)
			f3_arg0.speedlines2:setScale(0.9, 0.9)
			f3_local1(f3_arg0.speedlines2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
