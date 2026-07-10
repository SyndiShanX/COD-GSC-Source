require("x64:85bab6972d766d5")
require("x64:dd720638a9c4700")
require("x64:1f846296f1a1b81")
CoD.DirectorCustomStartButton = InheritFrom(LUI.UIElement)
CoD.DirectorCustomStartButton.__defaultWidth = 382
CoD.DirectorCustomStartButton.__defaultHeight = 70
CoD.DirectorCustomStartButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCustomStartButton)
	self.id = "DirectorCustomStartButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomStartButton = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorCustomStartButton:mergeStateConditions({
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
	local PlayTextFocus = DirectorCustomStartButton
	local PlayText = DirectorCustomStartButton.subscribeToModel
	local CountdownText = Engine[0x8DF2E5447F384B9]()
	PlayText(PlayTextFocus, CountdownText["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorCustomStartButton.Tint:setRGB(0.05, 0.08, 0.11)
	DirectorCustomStartButton.Tint:setAlpha(0.25)
	DirectorCustomStartButton.LeaderActivityText:setText("")
	DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x0))
	DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x0))
	DirectorCustomStartButton:linkToElementModel(self, nil, false, function(model)
		DirectorCustomStartButton:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	PlayText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -12, 12)
	PlayText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	PlayText:setText(LocalizeToUpperString(0xDDDA371285672BD))
	PlayText:setTTF("ttmussels_demibold")
	PlayText:setLetterSpacing(3)
	PlayText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlayText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PlayText)
	self.PlayText = PlayText
	PlayTextFocus = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -12, 12)
	PlayTextFocus:setRGB(0.28, 0.25, 0.24)
	PlayTextFocus:setAlpha(0)
	PlayTextFocus:setText(LocalizeToUpperString(0xDDDA371285672BD))
	PlayTextFocus:setTTF("ttmussels_demibold")
	PlayTextFocus:setMaterial(LUI.UIImage.GetCachedMaterial(0xAE166D9BA8C6907))
	PlayTextFocus:setShaderVector(0, 0.14, 0, 0, 0)
	PlayTextFocus:setShaderVector(1, 0.34, 0, 0, 0)
	PlayTextFocus:setShaderVector(2, 1, 0, 0, 0)
	PlayTextFocus:setLetterSpacing(3)
	PlayTextFocus:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PlayTextFocus:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PlayTextFocus)
	self.PlayTextFocus = PlayTextFocus
	CountdownText = CoD.DirectorCustomGameButtonCountdown.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, 180, 0.5, 0.5, -22.5, 22.5)
	CountdownText:setAlpha(0)
	self:addElement(CountdownText)
	self.CountdownText = CountdownText
	local DirectorPartyLeaderOnlyPrompt = CoD.DirectorPartyLeaderOnlyPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 0.5, 0.5, -12, 12)
	DirectorPartyLeaderOnlyPrompt:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	DirectorPartyLeaderOnlyPrompt:appendEventHandler("on_session_start", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, f9_arg1)
	end)
	DirectorPartyLeaderOnlyPrompt:appendEventHandler("on_session_end", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, f10_arg1)
	end)
	local f1_local6 = DirectorPartyLeaderOnlyPrompt
	local f1_local7 = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local6 = DirectorPartyLeaderOnlyPrompt
	f1_local7 = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.gameClient.update"], function(f12_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local6 = DirectorPartyLeaderOnlyPrompt
	f1_local7 = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.privateClient.update"], function(f13_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	self:addElement(DirectorPartyLeaderOnlyPrompt)
	self.DirectorPartyLeaderOnlyPrompt = DirectorPartyLeaderOnlyPrompt
	self:mergeStateConditions({
		{
			stateName = "MatchStartHide",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LobbyRoot", "hideMenusForGameStart", 1)
			end,
		},
		{
			stateName = "MatchStarting",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0)
			end,
		},
		{
			stateName = "DownloadingTheater",
			condition = function(menu, element, event)
				local f16_local0
				if not HasFilmAndFilmDownloaded() then
					f16_local0 = CoD.DirectorUtility.ShowDirectorTheater(f1_arg1)
				else
					f16_local0 = false
				end
				return f16_local0
			end,
		},
		{
			stateName = "Available",
			condition = function(menu, element, event)
				return LobbyHasMatchStartButton() and IsPartyLeader(f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsPartyLeader(f1_arg1)
			end,
		},
		{
			stateName = "Hidden",
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
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.hideMenusForGameStart, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "hideMenusForGameStart",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyTimeRemaining"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "lobbyRoot.lobbyTimeRemaining",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.theaterDownloadPercent"], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "lobbyRoot.theaterDownloadPercent",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.theaterDataDownloaded"], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "lobbyRoot.theaterDataDownloaded",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.privateClient.isHost"], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "lobbyRoot.privateClient.isHost",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.gameClient.isHost"], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "lobbyRoot.gameClient.isHost",
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
CoD.DirectorCustomStartButton.__resetProperties = function(f28_arg0)
	f28_arg0.PlayText:completeAnimation()
	f28_arg0.DirectorCustomStartButton:completeAnimation()
	f28_arg0.CountdownText:completeAnimation()
	f28_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
	f28_arg0.PlayTextFocus:completeAnimation()
	f28_arg0.PlayText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f28_arg0.PlayText:setAlpha(1)
	f28_arg0.PlayText:setScale(1, 1)
	f28_arg0.DirectorCustomStartButton:setScale(1, 1)
	f28_arg0.CountdownText:setAlpha(0)
	f28_arg0.CountdownText:setScale(1, 1)
	f28_arg0.CountdownText.timer:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f28_arg0.CountdownText.CountdownText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	f28_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(1)
	f28_arg0.PlayTextFocus:setAlpha(0)
	f28_arg0.PlayTextFocus:setScale(1, 1)
end
CoD.DirectorCustomStartButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.DirectorCustomStartButton:completeAnimation()
			f30_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f30_arg0.clipFinished(f30_arg0.DirectorCustomStartButton)
			f30_arg0.PlayText:completeAnimation()
			f30_arg0.PlayText:setRGB(0.28, 0.25, 0.24)
			f30_arg0.PlayText:setScale(1.05, 1.05)
			f30_arg0.clipFinished(f30_arg0.PlayText)
		end,
	},
	MatchStartHide = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			f31_arg0.PlayText:completeAnimation()
			f31_arg0.PlayText:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.PlayText)
			f31_arg0.CountdownText:completeAnimation()
			f31_arg0.CountdownText:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.CountdownText)
			f31_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f31_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		ChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(3)
			f32_arg0.PlayText:completeAnimation()
			f32_arg0.PlayText:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.PlayText)
			f32_arg0.CountdownText:completeAnimation()
			f32_arg0.CountdownText:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.CountdownText)
			f32_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f32_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
	},
	MatchStarting = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(3)
			f33_arg0.PlayText:completeAnimation()
			f33_arg0.PlayText:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.PlayText)
			f33_arg0.CountdownText:completeAnimation()
			f33_arg0.CountdownText:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.CountdownText)
			f33_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f33_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		ChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(4)
			f34_arg0.DirectorCustomStartButton:completeAnimation()
			f34_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f34_arg0.clipFinished(f34_arg0.DirectorCustomStartButton)
			f34_arg0.PlayText:completeAnimation()
			f34_arg0.PlayText:setRGB(1, 1, 1)
			f34_arg0.PlayText:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.PlayText)
			f34_arg0.CountdownText:completeAnimation()
			f34_arg0.CountdownText.timer:completeAnimation()
			f34_arg0.CountdownText.CountdownText:completeAnimation()
			f34_arg0.CountdownText:setAlpha(1)
			f34_arg0.CountdownText:setScale(1.05, 1.05)
			f34_arg0.CountdownText.timer:setRGB(0.28, 0.25, 0.24)
			f34_arg0.CountdownText.CountdownText:setRGB(0.28, 0.25, 0.24)
			f34_arg0.clipFinished(f34_arg0.CountdownText)
			f34_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f34_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
	},
	DownloadingTheater = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.PlayText:completeAnimation()
			f35_arg0.PlayText:setAlpha(0.5)
			f35_arg0.clipFinished(f35_arg0.PlayText)
		end,
	},
	Available = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(3)
			f37_arg0.DirectorCustomStartButton:completeAnimation()
			f37_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f37_arg0.clipFinished(f37_arg0.DirectorCustomStartButton)
			f37_arg0.PlayText:completeAnimation()
			f37_arg0.PlayText:setAlpha(0)
			f37_arg0.PlayText:setScale(1.05, 1.05)
			f37_arg0.clipFinished(f37_arg0.PlayText)
			f37_arg0.PlayTextFocus:completeAnimation()
			f37_arg0.PlayTextFocus:setAlpha(1)
			f37_arg0.PlayTextFocus:setScale(1.05, 1.05)
			f37_arg0.clipFinished(f37_arg0.PlayTextFocus)
		end,
		GainChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(3)
			local f38_local0 = function(f39_arg0)
				f38_arg0.DirectorCustomStartButton:beginAnimation(200)
				f38_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f38_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.DirectorCustomStartButton:completeAnimation()
			f38_arg0.DirectorCustomStartButton:setScale(1, 1)
			f38_local0(f38_arg0.DirectorCustomStartButton)
			local f38_local1 = function(f40_arg0)
				f38_arg0.PlayText:beginAnimation(200)
				f38_arg0.PlayText:setAlpha(0)
				f38_arg0.PlayText:setScale(1.05, 1.05)
				f38_arg0.PlayText:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.PlayText:completeAnimation()
			f38_arg0.PlayText:setAlpha(1)
			f38_arg0.PlayText:setScale(1, 1)
			f38_local1(f38_arg0.PlayText)
			local f38_local2 = function(f41_arg0)
				f38_arg0.PlayTextFocus:beginAnimation(200)
				f38_arg0.PlayTextFocus:setAlpha(1)
				f38_arg0.PlayTextFocus:setScale(1.05, 1.05)
				f38_arg0.PlayTextFocus:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.PlayTextFocus:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.PlayTextFocus:completeAnimation()
			f38_arg0.PlayTextFocus:setAlpha(0)
			f38_arg0.PlayTextFocus:setScale(1, 1)
			f38_local2(f38_arg0.PlayTextFocus)
		end,
		LoseChildFocus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(3)
			local f42_local0 = function(f43_arg0)
				f42_arg0.DirectorCustomStartButton:beginAnimation(200)
				f42_arg0.DirectorCustomStartButton:setScale(1, 1)
				f42_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.DirectorCustomStartButton:completeAnimation()
			f42_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f42_local0(f42_arg0.DirectorCustomStartButton)
			local f42_local1 = function(f44_arg0)
				f42_arg0.PlayText:beginAnimation(200)
				f42_arg0.PlayText:setAlpha(1)
				f42_arg0.PlayText:setScale(1, 1)
				f42_arg0.PlayText:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.PlayText:completeAnimation()
			f42_arg0.PlayText:setAlpha(0)
			f42_arg0.PlayText:setScale(1.05, 1.05)
			f42_local1(f42_arg0.PlayText)
			local f42_local2 = function(f45_arg0)
				f42_arg0.PlayTextFocus:beginAnimation(200)
				f42_arg0.PlayTextFocus:setAlpha(0)
				f42_arg0.PlayTextFocus:setScale(1, 1)
				f42_arg0.PlayTextFocus:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.PlayTextFocus:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.PlayTextFocus:completeAnimation()
			f42_arg0.PlayTextFocus:setAlpha(1)
			f42_arg0.PlayTextFocus:setScale(1.05, 1.05)
			f42_local2(f42_arg0.PlayTextFocus)
		end,
	},
	Disabled = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(1)
			f46_arg0.PlayText:completeAnimation()
			f46_arg0.PlayText:setRGB(0.59, 0.59, 0.59)
			f46_arg0.PlayText:setAlpha(0.15)
			f46_arg0.clipFinished(f46_arg0.PlayText)
		end,
	},
	Hidden = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(1)
			f47_arg0.PlayText:completeAnimation()
			f47_arg0.PlayText:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.PlayText)
		end,
	},
	Visible = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(3)
			f49_arg0.DirectorCustomStartButton:completeAnimation()
			f49_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f49_arg0.clipFinished(f49_arg0.DirectorCustomStartButton)
			f49_arg0.PlayText:completeAnimation()
			f49_arg0.PlayText:setAlpha(0)
			f49_arg0.PlayText:setScale(1.05, 1.05)
			f49_arg0.clipFinished(f49_arg0.PlayText)
			f49_arg0.PlayTextFocus:completeAnimation()
			f49_arg0.PlayTextFocus:setAlpha(1)
			f49_arg0.PlayTextFocus:setScale(1.05, 1.05)
			f49_arg0.clipFinished(f49_arg0.PlayTextFocus)
		end,
		GainChildFocus = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(3)
			local f50_local0 = function(f51_arg0)
				f50_arg0.DirectorCustomStartButton:beginAnimation(200)
				f50_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f50_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.DirectorCustomStartButton:completeAnimation()
			f50_arg0.DirectorCustomStartButton:setScale(1, 1)
			f50_local0(f50_arg0.DirectorCustomStartButton)
			local f50_local1 = function(f52_arg0)
				f50_arg0.PlayText:beginAnimation(200)
				f50_arg0.PlayText:setAlpha(0)
				f50_arg0.PlayText:setScale(1.05, 1.05)
				f50_arg0.PlayText:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.PlayText:completeAnimation()
			f50_arg0.PlayText:setAlpha(1)
			f50_arg0.PlayText:setScale(1, 1)
			f50_local1(f50_arg0.PlayText)
			local f50_local2 = function(f53_arg0)
				f50_arg0.PlayTextFocus:beginAnimation(200)
				f50_arg0.PlayTextFocus:setAlpha(1)
				f50_arg0.PlayTextFocus:setScale(1.05, 1.05)
				f50_arg0.PlayTextFocus:registerEventHandler("interrupted_keyframe", f50_arg0.clipInterrupted)
				f50_arg0.PlayTextFocus:registerEventHandler("transition_complete_keyframe", f50_arg0.clipFinished)
			end
			f50_arg0.PlayTextFocus:completeAnimation()
			f50_arg0.PlayTextFocus:setAlpha(0)
			f50_arg0.PlayTextFocus:setScale(1, 1)
			f50_local2(f50_arg0.PlayTextFocus)
		end,
		LoseChildFocus = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(3)
			local f54_local0 = function(f55_arg0)
				f54_arg0.DirectorCustomStartButton:beginAnimation(200)
				f54_arg0.DirectorCustomStartButton:setScale(1, 1)
				f54_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.DirectorCustomStartButton:completeAnimation()
			f54_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f54_local0(f54_arg0.DirectorCustomStartButton)
			local f54_local1 = function(f56_arg0)
				f54_arg0.PlayText:beginAnimation(200)
				f54_arg0.PlayText:setAlpha(1)
				f54_arg0.PlayText:setScale(1, 1)
				f54_arg0.PlayText:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.PlayText:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.PlayText:completeAnimation()
			f54_arg0.PlayText:setAlpha(0)
			f54_arg0.PlayText:setScale(1.05, 1.05)
			f54_local1(f54_arg0.PlayText)
			local f54_local2 = function(f57_arg0)
				f54_arg0.PlayTextFocus:beginAnimation(200)
				f54_arg0.PlayTextFocus:setAlpha(0)
				f54_arg0.PlayTextFocus:setScale(1, 1)
				f54_arg0.PlayTextFocus:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.PlayTextFocus:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.PlayTextFocus:completeAnimation()
			f54_arg0.PlayTextFocus:setAlpha(1)
			f54_arg0.PlayTextFocus:setScale(1.05, 1.05)
			f54_local2(f54_arg0.PlayTextFocus)
		end,
	},
}
CoD.DirectorCustomStartButton.__onClose = function(f58_arg0)
	f58_arg0.DirectorCustomStartButton:close()
	f58_arg0.CountdownText:close()
	f58_arg0.DirectorPartyLeaderOnlyPrompt:close()
end
