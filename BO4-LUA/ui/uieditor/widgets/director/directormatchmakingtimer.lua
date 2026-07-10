require("x64:a06bb8351e9354f")
CoD.DirectorMatchmakingTimer = InheritFrom(LUI.UIElement)
CoD.DirectorMatchmakingTimer.__defaultWidth = 286
CoD.DirectorMatchmakingTimer.__defaultHeight = 76
CoD.DirectorMatchmakingTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorMatchmakingTimer)
	self.id = "DirectorMatchmakingTimer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorMatchmakingTimerInternal = CoD.DirectorMatchmakingTimerInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 286, 0, 0, 0, 76)
	DirectorMatchmakingTimerInternal:mergeStateConditions({
		{
			stateName = "EstimatedTimeHidden",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShouldHideMatchmakingEstimatedTime()
			end,
		},
	})
	local MatchStartLabel = DirectorMatchmakingTimerInternal
	local MatchStartTime = DirectorMatchmakingTimerInternal.subscribeToModel
	local IntermissionTime = Engine[0x8DF2E5447F384B9]()
	MatchStartTime(MatchStartLabel, IntermissionTime["lobbyRoot.publicLobby.matchmakingElapsedTime"], function(f3_arg0)
		f1_arg0:updateElementState(DirectorMatchmakingTimerInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.publicLobby.matchmakingElapsedTime",
		})
	end, false)
	MatchStartLabel = DirectorMatchmakingTimerInternal
	MatchStartTime = DirectorMatchmakingTimerInternal.subscribeToModel
	IntermissionTime = Engine[0x8DF2E5447F384B9]()
	MatchStartTime(MatchStartLabel, IntermissionTime["lobbyRoot.publicLobby.matchmakingEstimatedTime"], function(f4_arg0)
		f1_arg0:updateElementState(DirectorMatchmakingTimerInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.publicLobby.matchmakingEstimatedTime",
		})
	end, false)
	self:addElement(DirectorMatchmakingTimerInternal)
	self.DirectorMatchmakingTimerInternal = DirectorMatchmakingTimerInternal
	MatchStartTime = LUI.UIText.new(0, 0, 10, 310, 0, 0, 10, 28)
	MatchStartTime:setAlpha(0)
	MatchStartTime:setTTF("ttmussels_demibold")
	MatchStartTime:setLetterSpacing(6)
	MatchStartTime:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MatchStartTime:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	MatchStartTime:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.matchmakingStartTime", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			MatchStartTime:setText(ToUpper(CoD.BaseUtility.LocalizeIfXHash(CoD.DirectorUtility.GetMatchMakingMatchStartTimeString(f5_local0))))
		end
	end)
	self:addElement(MatchStartTime)
	self.MatchStartTime = MatchStartTime
	MatchStartLabel = LUI.UIText.new(0, 0, 10, 310, 0, 0, 30, 48)
	MatchStartLabel:setAlpha(0)
	MatchStartLabel:setText(LocalizeToUpperString(0x55976A26B75E99D))
	MatchStartLabel:setTTF("ttmussels_demibold")
	MatchStartLabel:setLetterSpacing(6)
	MatchStartLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MatchStartLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(MatchStartLabel)
	self.MatchStartLabel = MatchStartLabel
	IntermissionTime = LUI.UIText.new(0, 0, 10, 310, 0, 0, 10, 28)
	IntermissionTime:setRGB(0.92, 0.92, 0.92)
	IntermissionTime:setAlpha(0)
	IntermissionTime:setTTF("ttmussels_demibold")
	IntermissionTime:setLetterSpacing(6)
	IntermissionTime:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	IntermissionTime:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	IntermissionTime:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.matchmakingIntermissionTime", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			IntermissionTime:setText(ToUpper(CoD.BaseUtility.LocalizeIfXHash(CoD.DirectorUtility.GetMatchMakingMatchStartTimeString(f6_local0))))
		end
	end)
	self:addElement(IntermissionTime)
	self.IntermissionTime = IntermissionTime
	local IntermissionLabel = LUI.UIText.new(0, 0, 10, 310, 0, 0, 30, 48)
	IntermissionLabel:setRGB(0.92, 0.92, 0.92)
	IntermissionLabel:setAlpha(0)
	IntermissionLabel:setText(LocalizeToUpperString(0xEF8850D6ECCE2FA))
	IntermissionLabel:setTTF("ttmussels_demibold")
	IntermissionLabel:setLetterSpacing(6)
	IntermissionLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	IntermissionLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(IntermissionLabel)
	self.IntermissionLabel = IntermissionLabel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorMatchmakingTimer.__resetProperties = function(f7_arg0)
	f7_arg0.MatchStartTime:completeAnimation()
	f7_arg0.MatchStartLabel:completeAnimation()
	f7_arg0.IntermissionLabel:completeAnimation()
	f7_arg0.IntermissionTime:completeAnimation()
	f7_arg0.DirectorMatchmakingTimerInternal:completeAnimation()
	f7_arg0.MatchStartTime:setAlpha(0)
	f7_arg0.MatchStartLabel:setAlpha(0)
	f7_arg0.IntermissionLabel:setAlpha(0)
	f7_arg0.IntermissionTime:setAlpha(0)
	f7_arg0.DirectorMatchmakingTimerInternal:setAlpha(1)
end
CoD.DirectorMatchmakingTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(5)
			f8_arg0.DirectorMatchmakingTimerInternal:completeAnimation()
			f8_arg0.DirectorMatchmakingTimerInternal:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.DirectorMatchmakingTimerInternal)
			f8_arg0.MatchStartTime:completeAnimation()
			f8_arg0.MatchStartTime:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.MatchStartTime)
			f8_arg0.MatchStartLabel:completeAnimation()
			f8_arg0.MatchStartLabel:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.MatchStartLabel)
			f8_arg0.IntermissionTime:completeAnimation()
			f8_arg0.IntermissionTime:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.IntermissionTime)
			f8_arg0.IntermissionLabel:completeAnimation()
			f8_arg0.IntermissionLabel:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.IntermissionLabel)
		end,
	},
	MatchStarting = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.DirectorMatchmakingTimerInternal:completeAnimation()
			f9_arg0.DirectorMatchmakingTimerInternal:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DirectorMatchmakingTimerInternal)
			f9_arg0.MatchStartTime:completeAnimation()
			f9_arg0.MatchStartTime:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.MatchStartTime)
			f9_arg0.MatchStartLabel:completeAnimation()
			f9_arg0.MatchStartLabel:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.MatchStartLabel)
			f9_arg0.IntermissionTime:completeAnimation()
			f9_arg0.IntermissionTime:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.IntermissionTime)
			f9_arg0.IntermissionLabel:completeAnimation()
			f9_arg0.IntermissionLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.IntermissionLabel)
		end,
	},
	Intermission = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.DirectorMatchmakingTimerInternal:completeAnimation()
			f10_arg0.DirectorMatchmakingTimerInternal:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DirectorMatchmakingTimerInternal)
			f10_arg0.MatchStartTime:completeAnimation()
			f10_arg0.MatchStartTime:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.MatchStartTime)
			f10_arg0.MatchStartLabel:completeAnimation()
			f10_arg0.MatchStartLabel:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.MatchStartLabel)
			f10_arg0.IntermissionTime:completeAnimation()
			f10_arg0.IntermissionTime:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.IntermissionTime)
			f10_arg0.IntermissionLabel:completeAnimation()
			f10_arg0.IntermissionLabel:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.IntermissionLabel)
		end,
	},
	Matchmaking = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(5)
			f11_arg0.DirectorMatchmakingTimerInternal:completeAnimation()
			f11_arg0.DirectorMatchmakingTimerInternal:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.DirectorMatchmakingTimerInternal)
			f11_arg0.MatchStartTime:completeAnimation()
			f11_arg0.MatchStartTime:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.MatchStartTime)
			f11_arg0.MatchStartLabel:completeAnimation()
			f11_arg0.MatchStartLabel:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.MatchStartLabel)
			f11_arg0.IntermissionTime:completeAnimation()
			f11_arg0.IntermissionTime:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.IntermissionTime)
			f11_arg0.IntermissionLabel:completeAnimation()
			f11_arg0.IntermissionLabel:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.IntermissionLabel)
		end,
	},
}
CoD.DirectorMatchmakingTimer.__onClose = function(f12_arg0)
	f12_arg0.DirectorMatchmakingTimerInternal:close()
	f12_arg0.MatchStartTime:close()
	f12_arg0.IntermissionTime:close()
end
