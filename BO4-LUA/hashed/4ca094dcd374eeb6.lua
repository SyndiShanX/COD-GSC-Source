require("x64:37246721e015e6b")
CoD.DirectorTheaterStartButton = InheritFrom(LUI.UIElement)
CoD.DirectorTheaterStartButton.__defaultWidth = 458
CoD.DirectorTheaterStartButton.__defaultHeight = 70
CoD.DirectorTheaterStartButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTheaterStartButton)
	self.id = "DirectorTheaterStartButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonContainer = CoD.DirectorCustomStartButtonContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 520, 0, 0, 0, 70)
	ButtonContainer:mergeStateConditions({
		{
			stateName = "MatchStartHide",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "LobbyRoot", "hideMenusForGameStart", 1)
			end,
		},
		{
			stateName = "MatchStarting",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsFreeCursorActive(f1_arg1)
			end,
		},
		{
			stateName = "Disabled_DownloadingTheater",
			condition = function(menu, element, event)
				local f4_local0
				if not HasFilmAndFilmDownloaded() then
					f4_local0 = CoD.DirectorUtility.ShowDirectorTheater(f1_arg1)
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
		{
			stateName = "Available",
			condition = function(menu, element, event)
				local f5_local0 = LobbyHasMatchStartButton()
				if f5_local0 then
					f5_local0 = IsPartyLeader(f1_arg1)
					if f5_local0 then
						f5_local0 = IsFreeCursorActive(f1_arg1)
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsPartyLeader(f1_arg1)
			end,
		},
	})
	local f1_local2 = ButtonContainer
	local f1_local3 = ButtonContainer.subscribeToModel
	local f1_local4 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.hideMenusForGameStart, function(f7_arg0)
		f1_arg0:updateElementState(ButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hideMenusForGameStart",
		})
	end, false)
	f1_local2 = ButtonContainer
	f1_local3 = ButtonContainer.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyTimeRemaining"], function(f8_arg0)
		f1_arg0:updateElementState(ButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyTimeRemaining",
		})
	end, false)
	f1_local2 = ButtonContainer
	f1_local3 = ButtonContainer.subscribeToModel
	f1_local4 = DataSources.FreeCursor.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.usingCursorInput, function(f9_arg0)
		f1_arg0:updateElementState(ButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	f1_local2 = ButtonContainer
	f1_local3 = ButtonContainer.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.theaterDownloadPercent"], function(f10_arg0)
		f1_arg0:updateElementState(ButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.theaterDownloadPercent",
		})
	end, false)
	f1_local2 = ButtonContainer
	f1_local3 = ButtonContainer.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.theaterDataDownloaded"], function(f11_arg0)
		f1_arg0:updateElementState(ButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.theaterDataDownloaded",
		})
	end, false)
	f1_local2 = ButtonContainer
	f1_local3 = ButtonContainer.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(ButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local2 = ButtonContainer
	f1_local3 = ButtonContainer.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.privateClient.isHost"], function(f13_arg0)
		f1_arg0:updateElementState(ButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.privateClient.isHost",
		})
	end, false)
	f1_local2 = ButtonContainer
	f1_local3 = ButtonContainer.subscribeToModel
	f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.gameClient.isHost"], function(f14_arg0)
		f1_arg0:updateElementState(ButtonContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "lobbyRoot.gameClient.isHost",
		})
	end, false)
	self:addElement(ButtonContainer)
	self.ButtonContainer = ButtonContainer
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ButtonContainer.id = "ButtonContainer"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTheaterStartButton.__resetProperties = function(f16_arg0)
	f16_arg0.ButtonContainer:completeAnimation()
	f16_arg0.ButtonContainer:setRGB(1, 1, 1)
	f16_arg0.ButtonContainer:setAlpha(1)
	f16_arg0.ButtonContainer:setScale(1, 1)
end
CoD.DirectorTheaterStartButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.ButtonContainer:completeAnimation()
			f18_arg0.ButtonContainer:setRGB(1, 1, 1)
			f18_arg0.ButtonContainer:setScale(1.05, 1.05)
			f18_arg0.clipFinished(f18_arg0.ButtonContainer)
		end,
		GainChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				f19_arg0.ButtonContainer:beginAnimation(100)
				f19_arg0.ButtonContainer:setScale(1.05, 1.05)
				f19_arg0.ButtonContainer:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ButtonContainer:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
			end
			f19_arg0.ButtonContainer:completeAnimation()
			f19_arg0.ButtonContainer:setScale(1, 1)
			f19_local0(f19_arg0.ButtonContainer)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.ButtonContainer:beginAnimation(100)
				f21_arg0.ButtonContainer:setScale(1, 1)
				f21_arg0.ButtonContainer:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.ButtonContainer:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.ButtonContainer:completeAnimation()
			f21_arg0.ButtonContainer:setScale(1.05, 1.05)
			f21_local0(f21_arg0.ButtonContainer)
		end,
	},
	Hidden = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.ButtonContainer:completeAnimation()
			f23_arg0.ButtonContainer:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ButtonContainer)
		end,
	},
}
CoD.DirectorTheaterStartButton.__onClose = function(f24_arg0)
	f24_arg0.ButtonContainer:close()
end
