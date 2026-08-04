require("ui/uieditor/widgets/director/directorselectbuttonminiinternal")
CoD.DirectorGenericButton = InheritFrom(LUI.UIElement)
CoD.DirectorGenericButton.__defaultWidth = 250
CoD.DirectorGenericButton.__defaultHeight = 92
CoD.DirectorGenericButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorGenericButton)
	self.id = "DirectorGenericButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString("menu/waiting_caps"))
	DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString("menu/waiting_caps"))
	self:addElement(DirectorSelectButtonMiniInternal)
	self.DirectorSelectButtonMiniInternal = DirectorSelectButtonMiniInternal
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	DirectorSelectButtonMiniInternal.id = "DirectorSelectButtonMiniInternal"
	self.__defaultFocus = DirectorSelectButtonMiniInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorGenericButton.__resetProperties = function(f3_arg0)
	f3_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
	f3_arg0.DirectorSelectButtonMiniInternal:setAlpha(1)
	f3_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
end
CoD.DirectorGenericButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f4_arg0.DirectorSelectButtonMiniInternal:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
	Visible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f6_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f6_arg0.clipFinished(f6_arg0.DirectorSelectButtonMiniInternal)
		end,
		GainChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f7_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
				f7_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f7_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f7_local0(f7_arg0.DirectorSelectButtonMiniInternal)
		end,
		LoseChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f9_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
				f9_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f9_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f9_local0(f9_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
}
CoD.DirectorGenericButton.__onClose = function(f11_arg0)
	f11_arg0.DirectorSelectButtonMiniInternal:close()
end
