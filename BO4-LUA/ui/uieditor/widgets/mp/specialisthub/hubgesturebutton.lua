require("x64:79fcbfda569a792")
CoD.HubGestureButton = InheritFrom(LUI.UIElement)
CoD.HubGestureButton.__defaultWidth = 152
CoD.HubGestureButton.__defaultHeight = 152
CoD.HubGestureButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubGestureButton)
	self.id = "HubGestureButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusBrackets = CoD.HubGestureButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	FocusBrackets:linkToElementModel(self, nil, false, function(model)
		FocusBrackets:setModel(model, f1_arg1)
	end)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	FocusBrackets.id = "FocusBrackets"
	self.__defaultFocus = FocusBrackets
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubGestureButton.__resetProperties = function(f3_arg0)
	f3_arg0.FocusBrackets:completeAnimation()
	f3_arg0.FocusBrackets:setScale(1, 1)
end
CoD.HubGestureButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.FocusBrackets:completeAnimation()
			f5_arg0.FocusBrackets:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.FocusBrackets)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.FocusBrackets:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f6_arg0.FocusBrackets:setScale(1.05, 1.05)
				f6_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.FocusBrackets:completeAnimation()
			f6_arg0.FocusBrackets:setScale(1, 1)
			f6_local0(f6_arg0.FocusBrackets)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.FocusBrackets:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f8_arg0.FocusBrackets:setScale(1, 1)
				f8_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.FocusBrackets:completeAnimation()
			f8_arg0.FocusBrackets:setScale(1.05, 1.05)
			f8_local0(f8_arg0.FocusBrackets)
		end,
	},
}
CoD.HubGestureButton.__onClose = function(f10_arg0)
	f10_arg0.FocusBrackets:close()
end
