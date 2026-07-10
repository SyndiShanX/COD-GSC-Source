CoD.SpawnSelectIconLine = InheritFrom(LUI.UIElement)
CoD.SpawnSelectIconLine.__defaultWidth = 76
CoD.SpawnSelectIconLine.__defaultHeight = 6
CoD.SpawnSelectIconLine.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectIconLine)
	self.id = "SpawnSelectIconLine"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local iconSelectedLine = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 6)
	iconSelectedLine:setImage(RegisterImage(@"uie_ui_hud_selectspawn_selected_line"))
	self:addElement(iconSelectedLine)
	self.iconSelectedLine = iconSelectedLine
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpawnSelectIconLine.__resetProperties = function(f2_arg0)
	f2_arg0.iconSelectedLine:completeAnimation()
	f2_arg0.iconSelectedLine:setLeftRight(0, 0, 0, 12)
end
CoD.SpawnSelectIconLine.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.iconSelectedLine:completeAnimation()
			f3_arg0.iconSelectedLine:setLeftRight(0, 0, 0, 12)
			f3_arg0.clipFinished(f3_arg0.iconSelectedLine)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.iconSelectedLine:completeAnimation()
			f4_arg0.iconSelectedLine:setLeftRight(0, 0, 0, 76)
			f4_arg0.clipFinished(f4_arg0.iconSelectedLine)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.iconSelectedLine:beginAnimation(100)
				f5_arg0.iconSelectedLine:setLeftRight(0, 0, 0, 76)
				f5_arg0.iconSelectedLine:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.iconSelectedLine:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.iconSelectedLine:completeAnimation()
			f5_arg0.iconSelectedLine:setLeftRight(0, 0, 0, 12)
			f5_local0(f5_arg0.iconSelectedLine)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.iconSelectedLine:beginAnimation(100)
				f7_arg0.iconSelectedLine:setLeftRight(0, 0, 0, 12)
				f7_arg0.iconSelectedLine:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.iconSelectedLine:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.iconSelectedLine:completeAnimation()
			f7_arg0.iconSelectedLine:setLeftRight(0, 0, 0, 76)
			f7_local0(f7_arg0.iconSelectedLine)
		end,
	},
}
