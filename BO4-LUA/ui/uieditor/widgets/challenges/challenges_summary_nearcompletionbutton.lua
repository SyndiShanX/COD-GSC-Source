require("x64:379af6e9d2b74ff")
CoD.Challenges_Summary_NearCompletionButton = InheritFrom(LUI.UIElement)
CoD.Challenges_Summary_NearCompletionButton.__defaultWidth = 1175
CoD.Challenges_Summary_NearCompletionButton.__defaultHeight = 280
CoD.Challenges_Summary_NearCompletionButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_Summary_NearCompletionButton)
	self.id = "Challenges_Summary_NearCompletionButton"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NearCompletionButton = CoD.NearCompletionButton_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -587.5, 587.5, 0.5, 0.5, -140, 140)
	NearCompletionButton:linkToElementModel(self, nil, false, function(model)
		NearCompletionButton:setModel(model, f1_arg1)
	end)
	self:addElement(NearCompletionButton)
	self.NearCompletionButton = NearCompletionButton
	NearCompletionButton.id = "NearCompletionButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_Summary_NearCompletionButton.__resetProperties = function(f3_arg0)
	f3_arg0.NearCompletionButton:completeAnimation()
	f3_arg0.NearCompletionButton:setScale(1, 1)
end
CoD.Challenges_Summary_NearCompletionButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.NearCompletionButton:completeAnimation()
			f5_arg0.NearCompletionButton:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.NearCompletionButton)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.NearCompletionButton:beginAnimation(200)
				f6_arg0.NearCompletionButton:setScale(1.05, 1.05)
				f6_arg0.NearCompletionButton:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.NearCompletionButton:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.NearCompletionButton:completeAnimation()
			f6_arg0.NearCompletionButton:setScale(1, 1)
			f6_local0(f6_arg0.NearCompletionButton)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.NearCompletionButton:beginAnimation(200)
				f8_arg0.NearCompletionButton:setScale(1, 1)
				f8_arg0.NearCompletionButton:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.NearCompletionButton:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.NearCompletionButton:completeAnimation()
			f8_arg0.NearCompletionButton:setScale(1.05, 1.05)
			f8_local0(f8_arg0.NearCompletionButton)
		end,
	},
}
CoD.Challenges_Summary_NearCompletionButton.__onClose = function(f10_arg0)
	f10_arg0.NearCompletionButton:close()
end
