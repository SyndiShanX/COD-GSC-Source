CoD.ui_icon_callingcards_invasion_lamb3 = InheritFrom(LUI.UIElement)
CoD.ui_icon_callingcards_invasion_lamb3.__defaultWidth = 48
CoD.ui_icon_callingcards_invasion_lamb3.__defaultHeight = 48
CoD.ui_icon_callingcards_invasion_lamb3.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ui_icon_callingcards_invasion_lamb3)
	self.id = "ui_icon_callingcards_invasion_lamb3"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local lamb3 = LUI.UIImage.new(0, 0, 0, 48, 0, 0, 0, 48)
	lamb3:setImage(RegisterImage(@"uie_ui_menu_callingcards_invasion_lamb3"))
	self:addElement(lamb3)
	self.lamb3 = lamb3
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ui_icon_callingcards_invasion_lamb3.__resetProperties = function(f2_arg0)
	f2_arg0.lamb3:completeAnimation()
	f2_arg0.lamb3:setZRot(0)
end
CoD.ui_icon_callingcards_invasion_lamb3.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setZRot(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.lamb3:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.lamb3:setZRot(53)
				f3_arg0.lamb3:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lamb3:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.lamb3:completeAnimation()
			f3_arg0.lamb3:setZRot(0)
			f3_local0(f3_arg0.lamb3)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
