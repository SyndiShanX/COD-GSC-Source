require("x64:c654dd6298985af")
CoD.CommonButtonGeneric = InheritFrom(LUI.UIElement)
CoD.CommonButtonGeneric.__defaultWidth = 300
CoD.CommonButtonGeneric.__defaultHeight = 70
CoD.CommonButtonGeneric.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonButtonGeneric)
	self.id = "CommonButtonGeneric"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonGeneric = CoD.CommonButtonGenericInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ButtonGeneric.MiddleText:setText(LocalizeToUpperString(@"hash_A43B10D9DA121A"))
	ButtonGeneric.MiddleTextFocus:setText(LocalizeToUpperString(@"hash_A43B10D9DA121A"))
	self:addElement(ButtonGeneric)
	self.ButtonGeneric = ButtonGeneric
	ButtonGeneric.id = "ButtonGeneric"
	self.__defaultFocus = ButtonGeneric
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonButtonGeneric.__resetProperties = function(f2_arg0)
	f2_arg0.ButtonGeneric:completeAnimation()
	f2_arg0.ButtonGeneric:setScale(1, 1)
end
CoD.CommonButtonGeneric.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ButtonGeneric:completeAnimation()
			f4_arg0.ButtonGeneric:setScale(1.02, 1.02)
			f4_arg0.clipFinished(f4_arg0.ButtonGeneric)
		end,
		GainChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				f5_arg0.ButtonGeneric:beginAnimation(200)
				f5_arg0.ButtonGeneric:setScale(1.02, 1.02)
				f5_arg0.ButtonGeneric:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.ButtonGeneric:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.ButtonGeneric:completeAnimation()
			f5_arg0.ButtonGeneric:setScale(1, 1)
			f5_local0(f5_arg0.ButtonGeneric)
		end,
		LoseChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ButtonGeneric:beginAnimation(200)
				f7_arg0.ButtonGeneric:setScale(1, 1)
				f7_arg0.ButtonGeneric:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ButtonGeneric:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ButtonGeneric:completeAnimation()
			f7_arg0.ButtonGeneric:setScale(1.02, 1.02)
			f7_local0(f7_arg0.ButtonGeneric)
		end,
	},
}
CoD.CommonButtonGeneric.__onClose = function(f9_arg0)
	f9_arg0.ButtonGeneric:close()
end
