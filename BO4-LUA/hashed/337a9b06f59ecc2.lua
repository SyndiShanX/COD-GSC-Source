require("x64:7957e8c1c759221")
CoD.PositionDraft_ReadyButton = InheritFrom(LUI.UIElement)
CoD.PositionDraft_ReadyButton.__defaultWidth = 368
CoD.PositionDraft_ReadyButton.__defaultHeight = 75
CoD.PositionDraft_ReadyButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_ReadyButton)
	self.id = "PositionDraft_ReadyButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.PositionDraft_ReadyButtonContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 368, 0, 0, 0, 75)
	Background:linkToElementModel(self, nil, false, function(model)
		Background:setModel(model, f1_arg1)
	end)
	self:addElement(Background)
	self.Background = Background
	Background.id = "Background"
	self.__defaultFocus = Background
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_ReadyButton.__resetProperties = function(f3_arg0)
	f3_arg0.Background:completeAnimation()
	f3_arg0.Background:setAlpha(1)
	f3_arg0.Background:setScale(1, 1)
end
CoD.PositionDraft_ReadyButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Background:completeAnimation()
			f5_arg0.Background:setScale(1.05, 1.05)
			f5_arg0.clipFinished(f5_arg0.Background)
		end,
		GainChildFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Background:beginAnimation(100)
				f6_arg0.Background:setScale(1.05, 1.05)
				f6_arg0.Background:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Background:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Background:completeAnimation()
			f6_arg0.Background:setScale(1, 1)
			f6_local0(f6_arg0.Background)
		end,
		LoseChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.Background:beginAnimation(100)
				f8_arg0.Background:setScale(1, 1)
				f8_arg0.Background:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.Background:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.Background:completeAnimation()
			f8_arg0.Background:setScale(1.05, 1.05)
			f8_local0(f8_arg0.Background)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Background:completeAnimation()
			f10_arg0.Background:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Background)
		end,
	},
}
CoD.PositionDraft_ReadyButton.__onClose = function(f11_arg0)
	f11_arg0.Background:close()
end
