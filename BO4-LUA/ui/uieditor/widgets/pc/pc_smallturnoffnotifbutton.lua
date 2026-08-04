CoD.PC_SmallTurnOffNotifButton = InheritFrom(LUI.UIElement)
CoD.PC_SmallTurnOffNotifButton.__defaultWidth = 20
CoD.PC_SmallTurnOffNotifButton.__defaultHeight = 20
CoD.PC_SmallTurnOffNotifButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_SmallTurnOffNotifButton)
	self.id = "PC_SmallTurnOffNotifButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CloseIcon = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CloseIcon:setAlpha(0.5)
	CloseIcon:setImage(RegisterImage(@"hash_4C4AFD9753DCB356"))
	self:addElement(CloseIcon)
	self.CloseIcon = CloseIcon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_SmallTurnOffNotifButton.__resetProperties = function(f2_arg0)
	f2_arg0.CloseIcon:completeAnimation()
	f2_arg0.CloseIcon:setAlpha(0.5)
	f2_arg0.CloseIcon:setScale(1, 1)
end
CoD.PC_SmallTurnOffNotifButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.CloseIcon:completeAnimation()
			f4_arg0.CloseIcon:setAlpha(1)
			f4_arg0.CloseIcon:setScale(1.3, 1.3)
			f4_arg0.clipFinished(f4_arg0.CloseIcon)
		end,
		GainFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.CloseIcon:beginAnimation(80)
				f5_arg0.CloseIcon:setScale(1.3, 1.3)
				f5_arg0.CloseIcon:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.CloseIcon:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.CloseIcon:completeAnimation()
			f5_arg0.CloseIcon:setAlpha(1)
			f5_arg0.CloseIcon:setScale(1, 1)
			f5_local0(f5_arg0.CloseIcon)
		end,
		LoseFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.CloseIcon:beginAnimation(80)
				f7_arg0.CloseIcon:setScale(1, 1)
				f7_arg0.CloseIcon:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.CloseIcon:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.CloseIcon:completeAnimation()
			f7_arg0.CloseIcon:setAlpha(1)
			f7_arg0.CloseIcon:setScale(1.3, 1.3)
			f7_local0(f7_arg0.CloseIcon)
		end,
	},
}
