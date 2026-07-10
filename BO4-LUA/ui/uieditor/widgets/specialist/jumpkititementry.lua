require("x64:98b4302d64420a0")
CoD.JumpkitItemEntry = InheritFrom(LUI.UIElement)
CoD.JumpkitItemEntry.__defaultWidth = 152
CoD.JumpkitItemEntry.__defaultHeight = 152
CoD.JumpkitItemEntry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.JumpkitItemEntry)
	self.id = "JumpkitItemEntry"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local JumpkitButtonInternal = CoD.JumpkitButton_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 152, 0, 0, 0, 152)
	JumpkitButtonInternal:linkToElementModel(self, nil, false, function(model)
		JumpkitButtonInternal:setModel(model, f1_arg1)
	end)
	self:addElement(JumpkitButtonInternal)
	self.JumpkitButtonInternal = JumpkitButtonInternal
	JumpkitButtonInternal.id = "JumpkitButtonInternal"
	self.__defaultFocus = JumpkitButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.JumpkitItemEntry.__resetProperties = function(f3_arg0)
	f3_arg0.JumpkitButtonInternal:completeAnimation()
	f3_arg0.JumpkitButtonInternal:setScale(1, 1)
end
CoD.JumpkitItemEntry.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.JumpkitButtonInternal:completeAnimation()
			f5_arg0.JumpkitButtonInternal:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.JumpkitButtonInternal)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.JumpkitButtonInternal:beginAnimation(200)
				f6_arg0.JumpkitButtonInternal:setScale(1.05, 1.05)
				f6_arg0.JumpkitButtonInternal:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.JumpkitButtonInternal:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.JumpkitButtonInternal:completeAnimation()
			f6_arg0.JumpkitButtonInternal:setScale(1, 1)
			f6_local0(f6_arg0.JumpkitButtonInternal)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.JumpkitButtonInternal:beginAnimation(200)
				f8_arg0.JumpkitButtonInternal:setScale(1, 1)
				f8_arg0.JumpkitButtonInternal:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.JumpkitButtonInternal:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.JumpkitButtonInternal:completeAnimation()
			f8_arg0.JumpkitButtonInternal:setScale(1.05, 1.05)
			f8_local0(f8_arg0.JumpkitButtonInternal)
		end,
	},
}
CoD.JumpkitItemEntry.__onClose = function(f10_arg0)
	f10_arg0.JumpkitButtonInternal:close()
end
