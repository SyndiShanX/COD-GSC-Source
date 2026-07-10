require("x64:233e193bf9509f4")
CoD.PublicLobbyStageNotification = InheritFrom(LUI.UIElement)
CoD.PublicLobbyStageNotification.__defaultWidth = 1920
CoD.PublicLobbyStageNotification.__defaultHeight = 1080
CoD.PublicLobbyStageNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.DirectorUtility.InitPublicLobbyModels(self, f1_arg1, f1_arg0)
	self:setClass(CoD.PublicLobbyStageNotification)
	self.id = "PublicLobbyStageNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StageNotificationContainer = CoD.StageNotificationContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 120)
	StageNotificationContainer:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			StageNotificationContainer.CommonHeader.subtitle.StageTitle:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f2_local0))
		end
	end)
	StageNotificationContainer:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.stageDetails", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			StageNotificationContainer.CommonHeader.subtitle.subtitle:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f3_local0)))
		end
	end)
	self:addElement(StageNotificationContainer)
	self.StageNotificationContainer = StageNotificationContainer
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShowDirectorPublic(f1_arg1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PublicLobbyStageNotification.__resetProperties = function(f6_arg0)
	f6_arg0.StageNotificationContainer:completeAnimation()
	f6_arg0.StageNotificationContainer:setLeftRight(0, 0, 0, 1920)
	f6_arg0.StageNotificationContainer:setTopBottom(0, 0, 0, 120)
	f6_arg0.StageNotificationContainer:setAlpha(1)
end
CoD.PublicLobbyStageNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.StageNotificationContainer:completeAnimation()
			f7_arg0.StageNotificationContainer:setLeftRight(0, 0, 0, 1920)
			f7_arg0.StageNotificationContainer:setTopBottom(0, 0, -137, -17)
			f7_arg0.StageNotificationContainer:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.StageNotificationContainer)
		end,
		Visible = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.StageNotificationContainer:beginAnimation(300)
				f8_arg0.StageNotificationContainer:setTopBottom(0, 0, 0, 120)
				f8_arg0.StageNotificationContainer:setAlpha(1)
				f8_arg0.StageNotificationContainer:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.StageNotificationContainer:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.StageNotificationContainer:completeAnimation()
			f8_arg0.StageNotificationContainer:setLeftRight(0, 0, 0, 1920)
			f8_arg0.StageNotificationContainer:setTopBottom(0, 0, -137, -17)
			f8_arg0.StageNotificationContainer:setAlpha(0)
			f8_local0(f8_arg0.StageNotificationContainer)
		end,
	},
	Visible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.StageNotificationContainer:completeAnimation()
			f10_arg0.StageNotificationContainer:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.StageNotificationContainer)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				f11_arg0.StageNotificationContainer:beginAnimation(300)
				f11_arg0.StageNotificationContainer:setTopBottom(0, 0, -137, -17)
				f11_arg0.StageNotificationContainer:setAlpha(0)
				f11_arg0.StageNotificationContainer:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.StageNotificationContainer:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.StageNotificationContainer:completeAnimation()
			f11_arg0.StageNotificationContainer:setLeftRight(0, 0, 0, 1920)
			f11_arg0.StageNotificationContainer:setTopBottom(0, 0, 0, 120)
			f11_arg0.StageNotificationContainer:setAlpha(1)
			f11_local0(f11_arg0.StageNotificationContainer)
		end,
	},
}
CoD.PublicLobbyStageNotification.__onClose = function(f13_arg0)
	f13_arg0.StageNotificationContainer:close()
end
