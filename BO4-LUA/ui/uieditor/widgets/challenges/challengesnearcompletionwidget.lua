require("x64:2cac675ab462d9")
CoD.ChallengesNearCompletionWidget = InheritFrom(LUI.UIElement)
CoD.ChallengesNearCompletionWidget.__defaultWidth = 1100
CoD.ChallengesNearCompletionWidget.__defaultHeight = 80
CoD.ChallengesNearCompletionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesNearCompletionWidget)
	self.id = "ChallengesNearCompletionWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Button = CoD.NearCompletionButton.new(f1_arg0, f1_arg1, 0, 0, 0, 1100, 0, 0, 0, 80)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	Button.id = "Button"
	self.__defaultFocus = Button
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChallengesNearCompletionWidget.__resetProperties = function(f3_arg0)
	f3_arg0.Button:completeAnimation()
	f3_arg0.Button:setScale(1, 1)
end
CoD.ChallengesNearCompletionWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Button:completeAnimation()
			f5_arg0.Button:setScale(1.03, 1.03)
			f5_arg0.clipFinished(f5_arg0.Button)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Button:beginAnimation(200)
				f6_arg0.Button:setScale(1.03, 1.03)
				f6_arg0.Button:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Button:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Button:completeAnimation()
			f6_arg0.Button:setScale(1, 1)
			f6_local0(f6_arg0.Button)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Button:beginAnimation(200)
				f8_arg0.Button:setScale(1, 1)
				f8_arg0.Button:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Button:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Button:completeAnimation()
			f8_arg0.Button:setScale(1.03, 1.03)
			f8_local0(f8_arg0.Button)
		end,
	},
}
CoD.ChallengesNearCompletionWidget.__onClose = function(f10_arg0)
	f10_arg0.Button:close()
end
