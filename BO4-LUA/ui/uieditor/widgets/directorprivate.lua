require("x64:d6ecdf7755aeddc")
require("x64:8f92fe7a33600d7")
require("x64:51ef3a2adbd471e")
require("x64:fda45231af81f63")
require("x64:7b2e5c29b34a47e")
require("x64:dbdc73a4a6c0b46")
require("x64:445928c36e455a1")
CoD.directorPrivate = InheritFrom(LUI.UIElement)
CoD.directorPrivate.__defaultWidth = 1920
CoD.directorPrivate.__defaultHeight = 1080
CoD.directorPrivate.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitGlobalModel("QuickPlay", false)
	CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
	self:setClass(CoD.directorPrivate)
	self.id = "directorPrivate"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeaderActivity = CoD.DirectorLeaderActivity.new(f1_arg0, f1_arg1, 0.5, 0.5, 470, 895, 1, 1, -525, -495)
	LeaderActivity:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.IsOfflineOnlyDemo()
			end,
		},
	})
	LeaderActivity:setAlpha(0)
	LeaderActivity:setScale(0.9, 0.9)
	self:addElement(LeaderActivity)
	self.LeaderActivity = LeaderActivity
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyMainMode", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f3_local0)))
		end
	end)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local DirectorReadyButton = CoD.DirectorReadyButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -178, -108)
	DirectorReadyButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x7A9F166E7248D86))
	DirectorReadyButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x7A9F166E7248D86))
	DirectorReadyButton.PlayText:setText(LocalizeToUpperString(0xE6F6113B8B75F3E))
	DirectorReadyButton:subscribeToGlobalModel(f1_arg1, "PerController", "ButtonBits." .. Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], function(model)
		DirectorReadyButton:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorReadyButton)
	self.DirectorReadyButton = DirectorReadyButton
	local DirectorMapGameTypeAndDifficulty = CoD.DirectorMapGameTypeAndDifficulty.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -368, -188)
	DirectorMapGameTypeAndDifficulty:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setText(Engine[0xF9F1239CFD921FE](0xC95DCE378B96DFF))
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setTTF("ttmussels_regular")
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setText(Engine[0xF9F1239CFD921FE](0xC95DCE378B96DFF))
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setTTF("ttmussels_regular")
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage:setImage(RegisterImage(CoD.DirectorUtility.PlaylistIDToZMPlaylistImage(f7_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image_FullPath = function()
		local f8_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f8_local0 = f8_local0.playlistId
		if f8_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image(f8_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image = function(f9_arg0)
		local f9_local0 = f9_arg0:get()
		if f9_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon:setImage(RegisterImage(CoD.DirectorUtility.PlaylistIDToZMPlaylistDifficulty(f9_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath = function()
		local f10_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f10_local0 = f10_local0.playlistId
		if f10_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image(f10_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc = function(f11_arg0)
		local f11_local0 = f11_arg0:get()
		if f11_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label:setText(Engine[0xF9F1239CFD921FE](CoD.DirectorUtility.PlaylistIDToZMPlaylistSubtitle(f11_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath = function()
		local f12_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f12_local0 = f12_local0.playlistId
		if f12_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc(f12_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title = function(f13_arg0)
		local f13_local0 = f13_arg0:get()
		if f13_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle:setText(Engine[0xF9F1239CFD921FE](CoD.DirectorUtility.PlaylistIDToZMPlaylistName(f13_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title_FullPath = function()
		local f14_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f14_local0 = f14_local0.playlistId
		if f14_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title(f14_local0)
		end
	end
	self:addElement(DirectorMapGameTypeAndDifficulty)
	self.DirectorMapGameTypeAndDifficulty = DirectorMapGameTypeAndDifficulty
	local DirectorLobbyPoseMembersZM = CoD.DirectorLobbyPoseMembersZM.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 30, 30)
	DirectorLobbyPoseMembersZM:mergeStateConditions({
		{
			stateName = "BotsAllowed",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	DirectorLobbyPoseMembersZM:setAlpha(0)
	DirectorLobbyPoseMembersZM:subscribeToGlobalModel(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewWidgetPrivate", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:changeFrameWidget(f16_local0)
		end
	end)
	self:addElement(DirectorLobbyPoseMembersZM)
	self.DirectorLobbyPoseMembersZM = DirectorLobbyPoseMembersZM
	local ZMLoadoutPreviewInfo = CoD.ZMLoadoutPreviewInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -508, 426, 1, 1, -333, -207)
	ZMLoadoutPreviewInfo:setAlpha(0)
	self:addElement(ZMLoadoutPreviewInfo)
	self.ZMLoadoutPreviewInfo = ZMLoadoutPreviewInfo
	local DirectorZMLobbySettingList = CoD.DirectorZMLobbySettingList.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -443, -323)
	DirectorZMLobbySettingList:mergeStateConditions({
		{
			stateName = "ShowGameRules",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ShowAddRemoveBots",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.GameTypeAllowsBots()
			end,
		},
	})
	local f1_local8 = DirectorZMLobbySettingList
	local f1_local9 = DirectorZMLobbySettingList.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["MapVote.mapVoteGameModeNext"], function(f19_arg0)
		f1_arg0:updateElementState(DirectorZMLobbySettingList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "MapVote.mapVoteGameModeNext",
		})
	end, false)
	self:addElement(DirectorZMLobbySettingList)
	self.DirectorZMLobbySettingList = DirectorZMLobbySettingList
	f1_local8 = DirectorMapGameTypeAndDifficulty
	f1_local9 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNetworkMode"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image_FullPath)
	f1_local8 = DirectorMapGameTypeAndDifficulty
	f1_local9 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNetworkMode"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath)
	f1_local8 = DirectorMapGameTypeAndDifficulty
	f1_local9 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNetworkMode"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath)
	f1_local8 = DirectorMapGameTypeAndDifficulty
	f1_local9 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNetworkMode"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title_FullPath)
	self:mergeStateConditions({
		{
			stateName = "ZM_isPC",
			condition = function(menu, element, event)
				return IsZombies() and IsPC()
			end,
		},
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "lobbyRoot.spinnerActive", function(model)
		if not CoD.ModelUtility.IsGlobalModelValueTrue("lobbyRoot.spinnerActive") and CoD.DirectorUtility.ShowDirectorPrivate(self, f1_arg1) and CoD.ModelUtility.IsGlobalModelValueTrue("QuickPlay") and CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.lobbyList.playerCount", 1) then
			CoD.ZombieUtility.QuickPlayPrivate(f1_arg0, f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "gameClientDataUpdate", function(model)
		if CoD.DirectorUtility.ShowDirectorPrivate(self, f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "clientUpdated", function(model)
		if CoD.DirectorUtility.ShowDirectorPrivate(self, f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyNav", function(model)
		if CoD.DirectorUtility.ShowDirectorPrivate(self, f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
			DelaySetFocusToElement(self, "DirectorReadyButton", f1_arg1, 0)
		end
	end)
	DirectorReadyButton.id = "DirectorReadyButton"
	DirectorMapGameTypeAndDifficulty.id = "DirectorMapGameTypeAndDifficulty"
	DirectorLobbyPoseMembersZM.id = "DirectorLobbyPoseMembersZM"
	DirectorZMLobbySettingList.id = "DirectorZMLobbySettingList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.HomeOrPlayListPC)
		CoD.DirectorUtility.SubscribeForSoloMatchLobbyTitle(self.CommonHeader)
	else
		CoD.DirectorUtility.SubscribeForSoloMatchLobbyTitle(self.CommonHeader)
	end
	return self
end
CoD.directorPrivate.__resetProperties = function(f28_arg0)
	f28_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
	f28_arg0.ZMLoadoutPreviewInfo:completeAnimation()
	f28_arg0.DirectorLobbyPoseMembersZM:setAlpha(0)
	f28_arg0.ZMLoadoutPreviewInfo:setAlpha(0)
end
CoD.directorPrivate.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.CommonHeader:completeAnimation()
			f29_arg0.clipFinished(f29_arg0.CommonHeader)
		end,
	},
	ZM_isPC = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f30_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f30_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.DirectorLobbyPoseMembersZM)
			f30_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f30_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.ZMLoadoutPreviewInfo)
		end,
	},
	ZM = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f31_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f31_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.DirectorLobbyPoseMembersZM)
			f31_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f31_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.ZMLoadoutPreviewInfo)
		end,
	},
	WZ = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.directorPrivate.__onClose = function(f33_arg0)
	f33_arg0.LeaderActivity:close()
	f33_arg0.CommonHeader:close()
	f33_arg0.DirectorReadyButton:close()
	f33_arg0.DirectorMapGameTypeAndDifficulty:close()
	f33_arg0.DirectorLobbyPoseMembersZM:close()
	f33_arg0.ZMLoadoutPreviewInfo:close()
	f33_arg0.DirectorZMLobbySettingList:close()
end
