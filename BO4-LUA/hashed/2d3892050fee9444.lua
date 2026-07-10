require("x64:1f846296f1a1b81")
CoD.SurveyButton = InheritFrom(LUI.UIElement)
CoD.SurveyButton.__defaultWidth = 400
CoD.SurveyButton.__defaultHeight = 70
CoD.SurveyButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SurveyButton)
	self.id = "SurveyButton"
	self.soundSet = "default"
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
	local f1_local3 = DirectorCustomStartButton.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f8_arg0)
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
	DirectorCustomStartButton.MiddleText:setTTF("ttmussels_regular")
	DirectorCustomStartButton.MiddleTextFocus:setTTF("ttmussels_regular")
	DirectorCustomStartButton:linkToElementModel(self, nil, false, function(model)
		DirectorCustomStartButton:setModel(model, f1_arg1)
	end)
	DirectorCustomStartButton:linkToElementModel(self, "optionText", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(f10_local0))
		end
	end)
	DirectorCustomStartButton:linkToElementModel(self, "optionText", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(f11_local0))
		end
	end)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.SurveyQuestion.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.answered, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "SurveyQuestion", "answered") then
			CoD.SurveyUtility.SendSurveyDlogResponse(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "SurveyQuestion", "answered") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	DirectorCustomStartButton.id = "DirectorCustomStartButton"
	self.__defaultFocus = DirectorCustomStartButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SurveyButton.__resetProperties = function(f19_arg0)
	f19_arg0.DirectorCustomStartButton:completeAnimation()
	f19_arg0.DirectorCustomStartButton:setAlpha(1)
	f19_arg0.DirectorCustomStartButton:setZoom(0)
	f19_arg0.DirectorCustomStartButton:setScale(1, 1)
end
CoD.SurveyButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.DirectorCustomStartButton:completeAnimation()
			f21_arg0.DirectorCustomStartButton:setZoom(5)
			f21_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.DirectorCustomStartButton)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f22_arg0.DirectorCustomStartButton:setZoom(5)
				f22_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f22_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.DirectorCustomStartButton:completeAnimation()
			f22_arg0.DirectorCustomStartButton:setZoom(0)
			f22_arg0.DirectorCustomStartButton:setScale(1, 1)
			f22_local0(f22_arg0.DirectorCustomStartButton)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f24_arg0.DirectorCustomStartButton:setZoom(0)
				f24_arg0.DirectorCustomStartButton:setScale(1, 1)
				f24_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.DirectorCustomStartButton:completeAnimation()
			f24_arg0.DirectorCustomStartButton:setZoom(5)
			f24_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f24_local0(f24_arg0.DirectorCustomStartButton)
		end,
	},
	Hidden = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.DirectorCustomStartButton:completeAnimation()
			f26_arg0.DirectorCustomStartButton:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DirectorCustomStartButton)
		end,
	},
	Locked = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.DirectorCustomStartButton:completeAnimation()
			f28_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f28_arg0.clipFinished(f28_arg0.DirectorCustomStartButton)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.DirectorCustomStartButton:beginAnimation(200)
				f29_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f29_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DirectorCustomStartButton:completeAnimation()
			f29_arg0.DirectorCustomStartButton:setScale(1, 1)
			f29_local0(f29_arg0.DirectorCustomStartButton)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.DirectorCustomStartButton:beginAnimation(200)
				f31_arg0.DirectorCustomStartButton:setScale(1, 1)
				f31_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.DirectorCustomStartButton:completeAnimation()
			f31_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f31_local0(f31_arg0.DirectorCustomStartButton)
		end,
	},
	Unselectable = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.DirectorCustomStartButton:completeAnimation()
			f35_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f35_arg0.clipFinished(f35_arg0.DirectorCustomStartButton)
		end,
		GainChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			local f36_local0 = function(f37_arg0)
				f36_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f36_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f36_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.DirectorCustomStartButton:completeAnimation()
			f36_arg0.DirectorCustomStartButton:setScale(1, 1)
			f36_local0(f36_arg0.DirectorCustomStartButton)
		end,
		LoseChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			local f38_local0 = function(f39_arg0)
				f38_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f38_arg0.DirectorCustomStartButton:setScale(1, 1)
				f38_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.DirectorCustomStartButton:completeAnimation()
			f38_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f38_local0(f38_arg0.DirectorCustomStartButton)
		end,
	},
}
CoD.SurveyButton.__onClose = function(f40_arg0)
	f40_arg0.DirectorCustomStartButton:close()
end
