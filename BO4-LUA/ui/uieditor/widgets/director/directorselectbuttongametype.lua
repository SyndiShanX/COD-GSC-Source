require("x64:dd720638a9c4700")
require("x64:1f846296f1a1b81")
CoD.DirectorSelectButtonGameType = InheritFrom(LUI.UIElement)
CoD.DirectorSelectButtonGameType.__defaultWidth = 300
CoD.DirectorSelectButtonGameType.__defaultHeight = 70
CoD.DirectorSelectButtonGameType.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorSelectButtonGameType)
	self.id = "DirectorSelectButtonGameType"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomStartButton = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorCustomStartButton:mergeStateConditions({
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsDirectorButtonOptionLocked(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Unselectable")
			end,
		},
	})
	DirectorCustomStartButton:linkToElementModel(DirectorCustomStartButton, "trialLocked", true, function(model)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	DirectorCustomStartButton:linkToElementModel(DirectorCustomStartButton, "locked", true, function(model)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	DirectorCustomStartButton:linkToElementModel(DirectorCustomStartButton, "featureItemIndex", true, function(model)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featureItemIndex",
		})
	end)
	local f1_local2 = DirectorCustomStartButton
	local DirectorPartyLeaderOnlyPrompt = DirectorCustomStartButton.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	DirectorPartyLeaderOnlyPrompt(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorCustomStartButton.Tint:setRGB(0.05, 0.08, 0.11)
	DirectorCustomStartButton.Tint:setAlpha(0.25)
	DirectorCustomStartButton.LeaderActivityText:setText("")
	DirectorCustomStartButton:linkToElementModel(self, nil, false, function(model)
		DirectorCustomStartButton:setModel(model, f1_arg1)
	end)
	DirectorCustomStartButton:linkToElementModel(self, "subtitle", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(f10_local0))
		end
	end)
	DirectorCustomStartButton:linkToElementModel(self, "subtitle", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(f11_local0))
		end
	end)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	DirectorPartyLeaderOnlyPrompt = CoD.DirectorPartyLeaderOnlyPrompt.new(f1_arg0, f1_arg1, 0, 0, 50.5, 250.5, 0, 0, 46.5, 70.5)
	DirectorPartyLeaderOnlyPrompt:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	DirectorPartyLeaderOnlyPrompt:appendEventHandler("on_session_start", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, f13_arg1)
	end)
	DirectorPartyLeaderOnlyPrompt:appendEventHandler("on_session_end", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, f14_arg1)
	end)
	f1_local4 = DirectorPartyLeaderOnlyPrompt
	f1_local2 = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local4 = DirectorPartyLeaderOnlyPrompt
	f1_local2 = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.gameClient.update"], function(f16_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local4 = DirectorPartyLeaderOnlyPrompt
	f1_local2 = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.privateClient.update"], function(f17_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	self:addElement(DirectorPartyLeaderOnlyPrompt)
	self.DirectorPartyLeaderOnlyPrompt = DirectorPartyLeaderOnlyPrompt
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsDirectorButtonOptionLocked(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "locked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	self:linkToElementModel(self, "featureItemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featureItemIndex",
		})
	end)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorCustomStartButton.id = "DirectorCustomStartButton"
	self.__defaultFocus = DirectorCustomStartButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorSelectButtonGameType.__resetProperties = function(f23_arg0)
	f23_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
	f23_arg0.DirectorCustomStartButton:completeAnimation()
	f23_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(1)
	f23_arg0.DirectorPartyLeaderOnlyPrompt:setScale(1, 1)
	f23_arg0.DirectorCustomStartButton:setZoom(0)
	f23_arg0.DirectorCustomStartButton:setScale(1, 1)
end
CoD.DirectorSelectButtonGameType.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f24_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			f25_arg0.DirectorCustomStartButton:completeAnimation()
			f25_arg0.DirectorCustomStartButton:setZoom(5)
			f25_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f25_arg0.clipFinished(f25_arg0.DirectorCustomStartButton)
			f25_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f25_arg0.DirectorPartyLeaderOnlyPrompt:setScale(1.05, 1.05)
			f25_arg0.clipFinished(f25_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		GainChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			local f26_local0 = function(f27_arg0)
				f26_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f26_arg0.DirectorCustomStartButton:setZoom(5)
				f26_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f26_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.DirectorCustomStartButton:completeAnimation()
			f26_arg0.DirectorCustomStartButton:setZoom(0)
			f26_arg0.DirectorCustomStartButton:setScale(1, 1)
			f26_local0(f26_arg0.DirectorCustomStartButton)
			local f26_local1 = function(f28_arg0)
				f26_arg0.DirectorPartyLeaderOnlyPrompt:beginAnimation(200)
				f26_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(1)
				f26_arg0.DirectorPartyLeaderOnlyPrompt:setScale(1.05, 1.05)
				f26_arg0.DirectorPartyLeaderOnlyPrompt:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.DirectorPartyLeaderOnlyPrompt:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f26_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f26_arg0.DirectorPartyLeaderOnlyPrompt:setScale(1, 1)
			f26_local1(f26_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		LoseChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			local f29_local0 = function(f30_arg0)
				f29_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f29_arg0.DirectorCustomStartButton:setZoom(0)
				f29_arg0.DirectorCustomStartButton:setScale(1, 1)
				f29_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DirectorCustomStartButton:completeAnimation()
			f29_arg0.DirectorCustomStartButton:setZoom(5)
			f29_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f29_local0(f29_arg0.DirectorCustomStartButton)
			local f29_local1 = function(f31_arg0)
				f29_arg0.DirectorPartyLeaderOnlyPrompt:beginAnimation(200)
				f29_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
				f29_arg0.DirectorPartyLeaderOnlyPrompt:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DirectorPartyLeaderOnlyPrompt:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f29_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(1)
			f29_local1(f29_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
	},
	Locked = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f32_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		ChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.DirectorCustomStartButton:completeAnimation()
			f33_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f33_arg0.clipFinished(f33_arg0.DirectorCustomStartButton)
			f33_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f33_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		GainChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			local f34_local0 = function(f35_arg0)
				f34_arg0.DirectorCustomStartButton:beginAnimation(200)
				f34_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f34_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.DirectorCustomStartButton:completeAnimation()
			f34_arg0.DirectorCustomStartButton:setScale(1, 1)
			f34_local0(f34_arg0.DirectorCustomStartButton)
			f34_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f34_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		LoseChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			local f36_local0 = function(f37_arg0)
				f36_arg0.DirectorCustomStartButton:beginAnimation(200)
				f36_arg0.DirectorCustomStartButton:setScale(1, 1)
				f36_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.DirectorCustomStartButton:completeAnimation()
			f36_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f36_local0(f36_arg0.DirectorCustomStartButton)
			f36_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f36_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f36_arg0.clipFinished(f36_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
	},
	Unselectable = {
		DefaultClip = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			f38_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f38_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f38_arg0.clipFinished(f38_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
	},
}
CoD.DirectorSelectButtonGameType.__onClose = function(f39_arg0)
	f39_arg0.DirectorCustomStartButton:close()
	f39_arg0.DirectorPartyLeaderOnlyPrompt:close()
end
