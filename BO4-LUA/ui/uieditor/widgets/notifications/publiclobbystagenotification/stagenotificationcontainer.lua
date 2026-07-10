require("x64:d6ecdf7755aeddc")
require("x64:22e8e07934d5342")
require("x64:777135ab21d4ef5")
CoD.StageNotificationContainer = InheritFrom(LUI.UIElement)
CoD.StageNotificationContainer.__defaultWidth = 1920
CoD.StageNotificationContainer.__defaultHeight = 120
CoD.StageNotificationContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StageNotificationContainer)
	self.id = "StageNotificationContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](0x27307830087A401))
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local DirectorMatchmakingTimer = CoD.DirectorMatchmakingTimer.new(f1_arg0, f1_arg1, 0.95, 0.95, -286, 0, 0.9, 0.9, -90.5, -14.5)
	DirectorMatchmakingTimer:mergeStateConditions({
		{
			stateName = "MatchStarting",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.START_MATCH)
			end,
		},
		{
			stateName = "Intermission",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INTERMISSION)
			end,
		},
		{
			stateName = "Matchmaking",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueLessThanOrEqualToEnum(f1_arg1, "lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.SEARCH_STAGE_4) and not CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INVALID)
			end,
		},
	})
	local f1_local3 = DirectorMatchmakingTimer
	local DirectorStageIndicator = DirectorMatchmakingTimer.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	DirectorStageIndicator(f1_local3, f1_local5["lobbyRoot.publicLobby.stage"], function(f5_arg0)
		f1_arg0:updateElementState(DirectorMatchmakingTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	DirectorMatchmakingTimer:setAlpha(0)
	self:addElement(DirectorMatchmakingTimer)
	self.DirectorMatchmakingTimer = DirectorMatchmakingTimer
	DirectorStageIndicator = CoD.StageNotificationPositionContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 41, 81)
	self:addElement(DirectorStageIndicator)
	self.DirectorStageIndicator = DirectorStageIndicator
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[0x89C1455C5032969][0x78C124999125C42]) and CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INVALID)
			end,
		},
		{
			stateName = "Intermission",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INTERMISSION)
			end,
		},
	})
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local5, f1_local6["lobbyRoot.lobbyMainMode"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local5, f1_local6["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local5 = self
	f1_local3 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local5, f1_local6["lobbyRoot.publicLobby.stage"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StageNotificationContainer.__resetProperties = function(f11_arg0)
	f11_arg0.DirectorStageIndicator:completeAnimation()
	f11_arg0.DirectorMatchmakingTimer:completeAnimation()
	f11_arg0.DirectorStageIndicator:setAlpha(1)
	f11_arg0.DirectorMatchmakingTimer:setAlpha(0)
end
CoD.StageNotificationContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		Hidden = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.DirectorStageIndicator:beginAnimation(200)
				f13_arg0.DirectorStageIndicator:setAlpha(0)
				f13_arg0.DirectorStageIndicator:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.DirectorStageIndicator:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.DirectorStageIndicator:completeAnimation()
			f13_arg0.DirectorStageIndicator:setAlpha(1)
			f13_local0(f13_arg0.DirectorStageIndicator)
		end,
		Intermission = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.DirectorMatchmakingTimer:completeAnimation()
			f15_arg0.DirectorMatchmakingTimer:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.DirectorMatchmakingTimer)
			local f15_local0 = function(f16_arg0)
				f15_arg0.DirectorStageIndicator:beginAnimation(200)
				f15_arg0.DirectorStageIndicator:setAlpha(0)
				f15_arg0.DirectorStageIndicator:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.DirectorStageIndicator:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.DirectorStageIndicator:completeAnimation()
			f15_arg0.DirectorStageIndicator:setAlpha(1)
			f15_local0(f15_arg0.DirectorStageIndicator)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.DirectorStageIndicator:completeAnimation()
			f17_arg0.DirectorStageIndicator:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.DirectorStageIndicator)
		end,
		DefaultState = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.DirectorStageIndicator:beginAnimation(200)
				f18_arg0.DirectorStageIndicator:setAlpha(1)
				f18_arg0.DirectorStageIndicator:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.DirectorStageIndicator:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.DirectorStageIndicator:completeAnimation()
			f18_arg0.DirectorStageIndicator:setAlpha(0)
			f18_local0(f18_arg0.DirectorStageIndicator)
		end,
	},
	Intermission = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.DirectorMatchmakingTimer:completeAnimation()
			f20_arg0.DirectorMatchmakingTimer:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DirectorMatchmakingTimer)
			f20_arg0.DirectorStageIndicator:completeAnimation()
			f20_arg0.DirectorStageIndicator:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DirectorStageIndicator)
		end,
		DefaultState = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.DirectorMatchmakingTimer:completeAnimation()
			f21_arg0.DirectorMatchmakingTimer:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.DirectorMatchmakingTimer)
			local f21_local0 = function(f22_arg0)
				f21_arg0.DirectorStageIndicator:beginAnimation(200)
				f21_arg0.DirectorStageIndicator:setAlpha(1)
				f21_arg0.DirectorStageIndicator:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.DirectorStageIndicator:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.DirectorStageIndicator:completeAnimation()
			f21_arg0.DirectorStageIndicator:setAlpha(0)
			f21_local0(f21_arg0.DirectorStageIndicator)
		end,
	},
}
CoD.StageNotificationContainer.__onClose = function(f23_arg0)
	f23_arg0.CommonHeader:close()
	f23_arg0.DirectorMatchmakingTimer:close()
	f23_arg0.DirectorStageIndicator:close()
end
