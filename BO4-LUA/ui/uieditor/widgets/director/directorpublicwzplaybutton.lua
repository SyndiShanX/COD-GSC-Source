require("x64:1f846296f1a1b81")
CoD.DirectorPublicWzPlayButton = InheritFrom(LUI.UIElement)
CoD.DirectorPublicWzPlayButton.__defaultWidth = 250
CoD.DirectorPublicWzPlayButton.__defaultHeight = 92
CoD.DirectorPublicWzPlayButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPublicWzPlayButton)
	self.id = "DirectorPublicWzPlayButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorSelectButtonMiniInternal = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorSelectButtonMiniInternal:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsLobbyPrivateHost()
			end,
		},
	})
	local f1_local2 = DirectorSelectButtonMiniInternal
	local f1_local3 = DirectorSelectButtonMiniInternal.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.privateClient.update"], function(f3_arg0)
		f1_arg0:updateElementState(DirectorSelectButtonMiniInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0xA43B10D9DA121A))
	DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0xA43B10D9DA121A))
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
CoD.DirectorPublicWzPlayButton.__resetProperties = function(f5_arg0)
	f5_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
	f5_arg0.DirectorSelectButtonMiniInternal:setAlpha(1)
	f5_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
end
CoD.DirectorPublicWzPlayButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f6_arg0.DirectorSelectButtonMiniInternal:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f8_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f8_arg0.clipFinished(f8_arg0.DirectorSelectButtonMiniInternal)
		end,
		GainChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			local f9_local0 = function(f10_arg0)
				f9_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f9_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
				f9_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f9_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
			f9_local0(f9_arg0.DirectorSelectButtonMiniInternal)
		end,
		LoseChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.DirectorSelectButtonMiniInternal:beginAnimation(200)
				f11_arg0.DirectorSelectButtonMiniInternal:setScale(1, 1)
				f11_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DirectorSelectButtonMiniInternal:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DirectorSelectButtonMiniInternal:completeAnimation()
			f11_arg0.DirectorSelectButtonMiniInternal:setScale(1.05, 1.05)
			f11_local0(f11_arg0.DirectorSelectButtonMiniInternal)
		end,
	},
}
CoD.DirectorPublicWzPlayButton.__onClose = function(f13_arg0)
	f13_arg0.DirectorSelectButtonMiniInternal:close()
end
