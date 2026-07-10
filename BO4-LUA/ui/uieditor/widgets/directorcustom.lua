require("x64:99852387867c4f4")
require("x64:54aa43a3632697a")
require("x64:20adbc63353ec37")
require("x64:47c727557c223b9")
require("x64:d6ecdf7755aeddc")
require("x64:8830a14f983c4c4")
require("x64:63f019e9d0f8956")
require("x64:8f92fe7a33600d7")
require("x64:260c7a8e3737127")
require("x64:51ef3a2adbd471e")
require("x64:fda45231af81f63")
require("x64:1ef651f35122631")
require("x64:c89d021ac8b3747")
require("x64:46270a4d7cafbc0")
require("x64:e18985ca0ef8cf8")
require("x64:dbdc73a4a6c0b46")
require("x64:445928c36e455a1")
CoD.directorCustom = InheritFrom(LUI.UIElement)
CoD.directorCustom.__defaultWidth = 1920
CoD.directorCustom.__defaultHeight = 1080
CoD.directorCustom.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitGlobalModel("lobbyRoot.selectedGameType")
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Update")
	CoD.BaseUtility.CreateGlobalModel("localZMDifficulty")
	CoD.BaseUtility.InitGlobalModel("lobbyRoot.selectedMapId")
	CoD.BaseUtility.InitGlobalModel("lobbyRoot.lobbyList.playerCount")
	CoD.BaseUtility.CreateGlobalModel("localZMTrialVariant")
	self:setClass(CoD.directorCustom)
	self.id = "directorCustom"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CustomGamePlayers = CoD.DirectorVerticalPartyListCustom.new(f1_arg0, f1_arg1, 0.5, 0.5, 397, 917, 0, 0, 90, 614)
	self:addElement(CustomGamePlayers)
	self.CustomGamePlayers = CustomGamePlayers
	local DirectorMapGameTypeAndDifficulty = CoD.DirectorMapGameTypeAndDifficulty.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -368, -188)
	DirectorMapGameTypeAndDifficulty:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0)
			end,
		},
	})
	local f1_local3 = DirectorMapGameTypeAndDifficulty
	local LeaderActivity = DirectorMapGameTypeAndDifficulty.subscribeToModel
	local HomeOrPlayListFullPC = Engine[0x8DF2E5447F384B9]()
	LeaderActivity(f1_local3, HomeOrPlayListFullPC["lobbyRoot.lobbyTimeRemaining"], function(f3_arg0)
		f1_arg0:updateElementState(DirectorMapGameTypeAndDifficulty, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyTimeRemaining",
		})
	end, false)
	DirectorMapGameTypeAndDifficulty:setAlpha(0)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setText(Engine[0xF9F1239CFD921FE](0xBC441E8EF98063C))
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setText(Engine[0xF9F1239CFD921FE](0xC95DCE378B96DFF))
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage:setImage(RegisterImage(MapNameToMapImage(f4_local0)))
		end
	end)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon:setImage(RegisterImage(CoD.ZombieUtility.GetLocalZMDifficultyImage(f5_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath = function()
		local f6_local0 = DataSources.MapVote.getModel(f1_arg1)
		f6_local0 = f6_local0.mapVoteGameModeNext
		if f6_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image(f6_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label:setText(CoD.ZombieUtility.MapNameToZMOfflineLocalizedMapName(f7_local0))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath = function()
		local f8_local0 = DataSources.MapVote.getModel(f1_arg1)
		f8_local0 = f8_local0.mapVoteMapNext
		if f8_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc(f8_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f9_local0))
		end
	end)
	DirectorMapGameTypeAndDifficulty:appendEventHandler("on_session_start", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f10_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DirectorMapGameTypeAndDifficulty:appendEventHandler("on_session_end", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f11_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local3 = DirectorMapGameTypeAndDifficulty
	LeaderActivity = DirectorMapGameTypeAndDifficulty.subscribeToModel
	HomeOrPlayListFullPC = Engine[0x8DF2E5447F384B9]()
	LeaderActivity(f1_local3, HomeOrPlayListFullPC["lobbyRoot.lobbyNav"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local3 = DirectorMapGameTypeAndDifficulty
	LeaderActivity = DirectorMapGameTypeAndDifficulty.subscribeToModel
	HomeOrPlayListFullPC = Engine[0x8DF2E5447F384B9]()
	LeaderActivity(f1_local3, HomeOrPlayListFullPC["lobbyRoot.gameClient.update"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local3 = DirectorMapGameTypeAndDifficulty
	LeaderActivity = DirectorMapGameTypeAndDifficulty.subscribeToModel
	HomeOrPlayListFullPC = Engine[0x8DF2E5447F384B9]()
	LeaderActivity(f1_local3, HomeOrPlayListFullPC["lobbyRoot.privateClient.update"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local3 = DirectorMapGameTypeAndDifficulty
	LeaderActivity = DirectorMapGameTypeAndDifficulty.subscribeToModel
	HomeOrPlayListFullPC = Engine[0x8DF2E5447F384B9]()
	LeaderActivity(f1_local3, HomeOrPlayListFullPC["lobbyRoot.lobbyTimeRemaining"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorMapGameTypeAndDifficulty:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorMapGameTypeAndDifficulty, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and not CoD.BaseUtility.IsSelfInState(self, "ZMOfflinePrivate") and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) then
			CoD.LobbyUtility.SetLeaderActivityAndOpenOverlay(self, controller, CoD.LobbyUtility.LeaderActivity.CHOOSING_MAP, "DirectorChooseMapAndGameType")
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.BaseUtility.IsSelfInState(self, "ZMOfflinePrivate") and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) then
			CoD.LobbyUtility.SetLeaderActivityAndOpenOverlay(self, controller, CoD.LobbyUtility.LeaderActivity.CHOOSING_MAP, "DirectorGamemodeSelectionZMOffline")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and not CoD.BaseUtility.IsSelfInState(self, "ZMOfflinePrivate") and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.BaseUtility.IsSelfInState(self, "ZMOfflinePrivate") and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(DirectorMapGameTypeAndDifficulty)
	self.DirectorMapGameTypeAndDifficulty = DirectorMapGameTypeAndDifficulty
	LeaderActivity = CoD.DirectorLeaderActivity.new(f1_arg0, f1_arg1, 0.5, 0.5, -896, -429, 1, 1, -247, -216)
	LeaderActivity:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.IsOfflineOnlyDemo()
			end,
		},
	})
	LeaderActivity:setAlpha(0)
	self:addElement(LeaderActivity)
	self.LeaderActivity = LeaderActivity
	f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.HomeOrPlayListFull = f1_local3
	HomeOrPlayListFullPC = nil
	HomeOrPlayListFullPC = CoD.DirectorPreGameButtonContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -505, 478, 1, 1, -178, -108)
	HomeOrPlayListFullPC.LobbyButtons:setDataSource("DirectorPregameButtons")
	self:addElement(HomeOrPlayListFullPC)
	self.HomeOrPlayListFullPC = HomeOrPlayListFullPC
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 0, 67)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyMainMode", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f20_local0)))
		end
	end)
	CommonHeader.subtitle.subtitle.__subtitle_SubtitleText = function(f21_arg0)
		local f21_local0 = f21_arg0:get()
		if f21_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(LocalizeToUpperString(CoD.ZombieUtility.GetLocalZMLobbyTitle(f21_local0)))
		end
	end
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", CommonHeader.subtitle.subtitle.__subtitle_SubtitleText)
	CommonHeader.subtitle.subtitle.__subtitle_SubtitleText_FullPath = function()
		local f22_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f22_local0 = f22_local0.lobbyTitle
		if f22_local0 then
			CommonHeader.subtitle.subtitle.__subtitle_SubtitleText(f22_local0)
		end
	end
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local DirectorLobbyPoseMembers = CoD.DirectorLobbyPoseMembers.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(DirectorLobbyPoseMembers)
	self.DirectorLobbyPoseMembers = DirectorLobbyPoseMembers
	local SetUpMatchButton = CoD.DirectorPreGameSetUpMatch.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -368, -188)
	SetUpMatchButton:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return not IsLobbyHostOfCurrentMenu()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	SetUpMatchButton:appendEventHandler("on_session_start", function(f25_arg0, f25_arg1)
		f25_arg1.menu = f25_arg1.menu or f1_arg0
		f1_arg0:updateElementState(SetUpMatchButton, f25_arg1)
	end)
	SetUpMatchButton:appendEventHandler("on_session_end", function(f26_arg0, f26_arg1)
		f26_arg1.menu = f26_arg1.menu or f1_arg0
		f1_arg0:updateElementState(SetUpMatchButton, f26_arg1)
	end)
	local ZMLoadoutPreviewInfo = SetUpMatchButton
	local StartButton = SetUpMatchButton.subscribeToModel
	local DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	StartButton(ZMLoadoutPreviewInfo, DirectorLobbyPoseMembersZM["lobbyRoot.lobbyNav"], function(f27_arg0)
		f1_arg0:updateElementState(SetUpMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ZMLoadoutPreviewInfo = SetUpMatchButton
	StartButton = SetUpMatchButton.subscribeToModel
	DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	StartButton(ZMLoadoutPreviewInfo, DirectorLobbyPoseMembersZM["lobbyRoot.gameClient.update"], function(f28_arg0)
		f1_arg0:updateElementState(SetUpMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	ZMLoadoutPreviewInfo = SetUpMatchButton
	StartButton = SetUpMatchButton.subscribeToModel
	DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	StartButton(ZMLoadoutPreviewInfo, DirectorLobbyPoseMembersZM["lobbyRoot.privateClient.update"], function(f29_arg0)
		f1_arg0:updateElementState(SetUpMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	SetUpMatchButton.MapImage.PlaylistHeader.GameModeText:setText(Engine[0xF9F1239CFD921FE](0x2FA47140D97F89D))
	SetUpMatchButton.MapImage.PlaylistHeader.GameModeText:setTTF("ttmussels_regular")
	ZMLoadoutPreviewInfo = SetUpMatchButton
	StartButton = SetUpMatchButton.subscribeToModel
	DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	StartButton(ZMLoadoutPreviewInfo, DirectorLobbyPoseMembersZM["lobbyRoot.lobbyNav"], function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ZMLoadoutPreviewInfo = SetUpMatchButton
	StartButton = SetUpMatchButton.subscribeToModel
	DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	StartButton(ZMLoadoutPreviewInfo, DirectorLobbyPoseMembersZM["lobbyRoot.lobbyTimeRemaining"], function(f31_arg0, f31_arg1)
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	SetUpMatchButton:appendEventHandler("on_session_start", function(f32_arg0, f32_arg1)
		f32_arg1.menu = f32_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	SetUpMatchButton:appendEventHandler("on_session_end", function(f33_arg0, f33_arg1)
		f33_arg1.menu = f33_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f33_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	ZMLoadoutPreviewInfo = SetUpMatchButton
	StartButton = SetUpMatchButton.subscribeToModel
	DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	StartButton(ZMLoadoutPreviewInfo, DirectorLobbyPoseMembersZM["lobbyRoot.gameClient.update"], function(f34_arg0, f34_arg1)
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ZMLoadoutPreviewInfo = SetUpMatchButton
	StartButton = SetUpMatchButton.subscribeToModel
	DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	StartButton(ZMLoadoutPreviewInfo, DirectorLobbyPoseMembersZM["lobbyRoot.privateClient.update"], function(f35_arg0, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	SetUpMatchButton:registerEventHandler("gain_focus", function(element, event)
		local f36_local0 = nil
		if element.gainFocus then
			f36_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f36_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f36_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SetUpMatchButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsWarzone() and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			SetFocusToElement(self, "StartButton", controller)
			SetLoseFocusToElement(self, "SetUpMatchButton", controller)
			CoD.DirectorUtility.DirectorOpenOverlayWithCurrentMenuMode(menu, controller, "DirectorCustomGameSetUpWZ")
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			SetFocusToElement(self, "StartButton", controller)
			SetLoseFocusToElement(self, "SetUpMatchButton", controller)
			CoD.DirectorUtility.DirectorOpenOverlayWithCurrentMenuMode(menu, controller, "DirectorCustomGameSetUp")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsWarzone() and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(SetUpMatchButton)
	self.SetUpMatchButton = SetUpMatchButton
	StartButton = CoD.DirectorCustomStartButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -178, -108)
	StartButton:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f40_local0
				if not IsLobbyHostOfCurrentMenu() then
					f40_local0 = not CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0)
				else
					f40_local0 = false
				end
				return f40_local0
			end,
		},
	})
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	local CustomGamesButton = DataSources.LobbyRoot.getModel(f1_arg1)
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton.hideMenusForGameStart, function(f41_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "hideMenusForGameStart",
		})
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.lobbyTimeRemaining"], function(f42_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "lobbyRoot.lobbyTimeRemaining",
		})
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.theaterDownloadPercent"], function(f43_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "lobbyRoot.theaterDownloadPercent",
		})
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.theaterDataDownloaded"], function(f44_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "lobbyRoot.theaterDataDownloaded",
		})
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.lobbyNav"], function(f45_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.privateClient.isHost"], function(f46_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "lobbyRoot.privateClient.isHost",
		})
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.gameClient.isHost"], function(f47_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "lobbyRoot.gameClient.isHost",
		})
	end, false)
	StartButton:appendEventHandler("on_session_start", function(f48_arg0, f48_arg1)
		f48_arg1.menu = f48_arg1.menu or f1_arg0
		f1_arg0:updateElementState(StartButton, f48_arg1)
	end)
	StartButton:appendEventHandler("on_session_end", function(f49_arg0, f49_arg1)
		f49_arg1.menu = f49_arg1.menu or f1_arg0
		f1_arg0:updateElementState(StartButton, f49_arg1)
	end)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.gameClient.update"], function(f50_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.privateClient.update"], function(f51_arg0)
		f1_arg0:updateElementState(StartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	StartButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(0x0))
	StartButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(0x0))
	StartButton.PlayText:setText(LocalizeToUpperString(0xDDDA371285672BD))
	StartButton.PlayTextFocus:setText(LocalizeToUpperString(0xDDDA371285672BD))
	StartButton:appendEventHandler("on_session_start", function(f52_arg0, f52_arg1)
		f52_arg1.menu = f52_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f52_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	StartButton:appendEventHandler("on_session_end", function(f53_arg0, f53_arg1)
		f53_arg1.menu = f53_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f53_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.lobbyNav"], function(f54_arg0, f54_arg1)
		CoD.Menu.UpdateButtonShownState(f54_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.gameClient.update"], function(f55_arg0, f55_arg1)
		CoD.Menu.UpdateButtonShownState(f55_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.privateClient.update"], function(f56_arg0, f56_arg1)
		CoD.Menu.UpdateButtonShownState(f56_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.selectedMapId"], function(f57_arg0, f57_arg1)
		CoD.Menu.UpdateButtonShownState(f57_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorLobbyPoseMembersZM = StartButton
	ZMLoadoutPreviewInfo = StartButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	ZMLoadoutPreviewInfo(DirectorLobbyPoseMembersZM, CustomGamesButton["lobbyRoot.lobbyList.playerCount"], function(f58_arg0, f58_arg1)
		CoD.Menu.UpdateButtonShownState(f58_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	StartButton:registerEventHandler("gain_focus", function(element, event)
		local f59_local0 = nil
		if element.gainFocus then
			f59_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f59_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f59_local0
	end)
	f1_arg0:AddButtonCallbackFunction(StartButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.AllClientsOwnDLCForMap(controller) then
			LaunchGamePrototype(self, element, controller)
			PlaySoundAlias("cac_open_wpn_cust")
			return true
		elseif IsLobbyHostOfCurrentMenu() and not CoD.DirectorUtility.AllClientsOwnDLCForMap(controller) then
			CoD.DirectorUtility.OpenMapsNotEnabledPopup(self, controller)
			PlaySoundAlias("cac_open_wpn_cust")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.AllClientsOwnDLCForMap(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and not CoD.DirectorUtility.AllClientsOwnDLCForMap(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(StartButton)
	self.StartButton = StartButton
	ZMLoadoutPreviewInfo = CoD.ZMLoadoutPreviewInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -506, 428, 1, 1, -333, -207)
	ZMLoadoutPreviewInfo:setAlpha(0)
	self:addElement(ZMLoadoutPreviewInfo)
	self.ZMLoadoutPreviewInfo = ZMLoadoutPreviewInfo
	DirectorLobbyPoseMembersZM = CoD.DirectorLobbyPoseMembersZM.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 30, 30)
	DirectorLobbyPoseMembersZM:mergeStateConditions({
		{
			stateName = "BotsAllowed",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	DirectorLobbyPoseMembersZM:setAlpha(0)
	DirectorLobbyPoseMembersZM:subscribeToGlobalModel(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewWidgetCustom", function(model)
		local f63_local0 = model:get()
		if f63_local0 ~= nil then
			DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:changeFrameWidget(f63_local0)
		end
	end)
	self:addElement(DirectorLobbyPoseMembersZM)
	self.DirectorLobbyPoseMembersZM = DirectorLobbyPoseMembersZM
	CustomGamesButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -434, -388)
	CustomGamesButton:mergeStateConditions({
		{
			stateName = "VisibleZmOffline",
			condition = function(menu, element, event)
				local f64_local0 = IsLobbyHostOfCurrentMenu()
				if f64_local0 then
					if not IsPublicOrLeagueGame(f1_arg1) then
						f64_local0 = IsZombies()
						if f64_local0 then
							f64_local0 = IsLobbyNetworkModeLAN()
							if f64_local0 then
								f64_local0 = not CoD.DirectorUtility.IsOfflineScreenStateCustomGame()
							end
						end
					else
						f64_local0 = false
					end
				end
				return f64_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f65_local0 = IsLobbyHostOfCurrentMenu()
				if f65_local0 then
					if not IsPublicOrLeagueGame(f1_arg1) then
						f65_local0 = CoD.DirectorUtility.ShowCustomGameButtonForCurrentLobby(f1_arg1)
					else
						f65_local0 = false
					end
				end
				return f65_local0
			end,
		},
	})
	CustomGamesButton:appendEventHandler("on_session_start", function(f66_arg0, f66_arg1)
		f66_arg1.menu = f66_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CustomGamesButton, f66_arg1)
	end)
	CustomGamesButton:appendEventHandler("on_session_end", function(f67_arg0, f67_arg1)
		f67_arg1.menu = f67_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CustomGamesButton, f67_arg1)
	end)
	local DirectorLaboratoryButton = CustomGamesButton
	local DirectorLobbySettingList = CustomGamesButton.subscribeToModel
	local f1_local15 = Engine[0x8DF2E5447F384B9]()
	DirectorLobbySettingList(DirectorLaboratoryButton, f1_local15["lobbyRoot.lobbyNav"], function(f68_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f68_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorLaboratoryButton = CustomGamesButton
	DirectorLobbySettingList = CustomGamesButton.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	DirectorLobbySettingList(DirectorLaboratoryButton, f1_local15["lobbyRoot.gameClient.update"], function(f69_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f69_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	DirectorLaboratoryButton = CustomGamesButton
	DirectorLobbySettingList = CustomGamesButton.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	DirectorLobbySettingList(DirectorLaboratoryButton, f1_local15["lobbyRoot.privateClient.update"], function(f70_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f70_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	DirectorLaboratoryButton = CustomGamesButton
	DirectorLobbySettingList = CustomGamesButton.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	DirectorLobbySettingList(DirectorLaboratoryButton, f1_local15.offlineScreenState, function(f71_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f71_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	CustomGamesButton:setAlpha(0)
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText.__MiddleText_StringReference = function()
		CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(CoD.DirectorUtility.GetCustomGamesName(0x85D9C7D7DDC8EE0)))
	end
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText.__MiddleText_StringReference()
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus.__MiddleTextFocus_String = function()
		CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(CoD.DirectorUtility.GetCustomGamesName(0x85D9C7D7DDC8EE0)))
	end
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus.__MiddleTextFocus_String()
	CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	DirectorLaboratoryButton = CustomGamesButton
	DirectorLobbySettingList = CustomGamesButton.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	DirectorLobbySettingList(DirectorLaboratoryButton, f1_local15["lobbyRoot.lobbyNav"], function(f74_arg0, f74_arg1)
		CoD.Menu.UpdateButtonShownState(f74_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamesButton:registerEventHandler("gain_focus", function(element, event)
		local f75_local0 = nil
		if element.gainFocus then
			f75_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f75_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f75_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CustomGamesButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsZombies() then
			PlaySoundAlias("uin_press_generic")
			OpenSystemOverlay(self, menu, controller, "CustomMutationsNotification")
			SetLoseFocusToSelf(self, controller)
			return true
		elseif not IsZombies() then
			PlaySoundAlias("uin_press_generic")
			OpenSystemOverlay(self, menu, controller, "CustomGamesNotification")
			SetLoseFocusToSelf(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsZombies() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif not IsZombies() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(CustomGamesButton)
	self.CustomGamesButton = CustomGamesButton
	DirectorLobbySettingList = CoD.DirectorZMLobbySettingList.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -508, -388)
	DirectorLobbySettingList:setAlpha(0)
	self:addElement(DirectorLobbySettingList)
	self.DirectorLobbySettingList = DirectorLobbySettingList
	DirectorLaboratoryButton = CoD.DirectorLaboratoryButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -896, -542, 1, 1, -218, -108)
	DirectorLaboratoryButton:setAlpha(0)
	self:addElement(DirectorLaboratoryButton)
	self.DirectorLaboratoryButton = DirectorLaboratoryButton
	local f1_local16 = DirectorMapGameTypeAndDifficulty
	f1_local15 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	local f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17.localZMDifficulty, DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath)
	f1_local16 = DirectorMapGameTypeAndDifficulty
	f1_local15 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17.offlineScreenState, DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath)
	f1_local16 = DirectorMapGameTypeAndDifficulty
	f1_local15 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17.localZMDifficulty, DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath)
	f1_local16 = DirectorMapGameTypeAndDifficulty
	f1_local15 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17.localZMTrialVariant, DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath)
	f1_local16 = DirectorMapGameTypeAndDifficulty
	f1_local15 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["MapVote.mapVoteGameModeNext"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath)
	CommonHeader:appendEventHandler("on_session_start", CommonHeader.subtitle.subtitle.__subtitle_SubtitleText_FullPath)
	CommonHeader:appendEventHandler("on_session_end", CommonHeader.subtitle.subtitle.__subtitle_SubtitleText_FullPath)
	f1_local16 = CommonHeader
	f1_local15 = CommonHeader.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["lobbyRoot.lobbyNav"], CommonHeader.subtitle.subtitle.__subtitle_SubtitleText_FullPath)
	f1_local16 = CommonHeader
	f1_local15 = CommonHeader.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["lobbyRoot.gameClient.update"], CommonHeader.subtitle.subtitle.__subtitle_SubtitleText_FullPath)
	f1_local16 = CommonHeader
	f1_local15 = CommonHeader.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["lobbyRoot.privateClient.update"], CommonHeader.subtitle.subtitle.__subtitle_SubtitleText_FullPath)
	f1_local16 = CommonHeader
	f1_local15 = CommonHeader.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17.offlineScreenState, CommonHeader.subtitle.subtitle.__subtitle_SubtitleText_FullPath)
	f1_local16 = CustomGamesButton
	f1_local15 = CustomGamesButton.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["lobbyRoot.lobbyNav"], CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText.__MiddleText_StringReference)
	f1_local16 = CustomGamesButton
	f1_local15 = CustomGamesButton.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["lobbyRoot.lobbyNav"], CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus.__MiddleTextFocus_String)
	self:mergeStateConditions({
		{
			stateName = "ZMOnline_isPC",
			condition = function(menu, element, event)
				local f78_local0 = IsZombies()
				if f78_local0 then
					f78_local0 = IsLobbyNetworkModeLive()
					if f78_local0 then
						f78_local0 = IsPC()
					end
				end
				return f78_local0
			end,
		},
		{
			stateName = "ZMOnline",
			condition = function(menu, element, event)
				return IsZombies() and IsLobbyNetworkModeLive()
			end,
		},
		{
			stateName = "ZMOfflinePrivate",
			condition = function(menu, element, event)
				local f80_local0 = IsZombies()
				if f80_local0 then
					f80_local0 = IsLobbyNetworkModeLAN()
					if f80_local0 then
						f80_local0 = IsLobbyHostOfCurrentMenu()
						if f80_local0 then
							f80_local0 = not CoD.DirectorUtility.IsOfflineScreenStateCustomGame()
						end
					end
				end
				return f80_local0
			end,
		},
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
		{
			stateName = "DefaultState_isPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["lobbyRoot.lobbyNav"], function(f85_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f85_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:appendEventHandler("on_session_start", function(f86_arg0, f86_arg1)
		f86_arg1.menu = f86_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f86_arg1)
	end)
	self:appendEventHandler("on_session_end", function(f87_arg0, f87_arg1)
		f87_arg1.menu = f87_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f87_arg1)
	end)
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["lobbyRoot.gameClient.update"], function(f88_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f88_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17["lobbyRoot.privateClient.update"], function(f89_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f89_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	f1_local16 = self
	f1_local15 = self.subscribeToModel
	f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local16, f1_local17.offlineScreenState, function(f90_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f90_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "gameClientDataUpdate", function(model)
		local f91_local0 = self
		if CoD.DirectorUtility.ShowDirectorCustom(f91_local0, f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		elseif CoD.DirectorUtility.ShowDirectorCustom(f91_local0, f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "clientUpdated", function(model)
		if CoD.DirectorUtility.ShowDirectorCustom(self, f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "lobbyRoot.lobbyNav", function(model)
		local f93_local0 = self
		if IsZombies() and IsCustomLobby() and IsLobbyHost() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.StartButton)
			CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg1, "ZMCustomGameIntroduction")
		elseif IsCustomLobby() and IsLobbyHost() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.StartButton)
		elseif IsZombies() and IsCustomLobby() and not IsLobbyHost() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.HomeOrPlayListFull)
			CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(self, f1_arg1, "ZMCustomGameIntroduction")
		end
	end)
	CustomGamePlayers.id = "CustomGamePlayers"
	DirectorMapGameTypeAndDifficulty.id = "DirectorMapGameTypeAndDifficulty"
	f1_local3.id = "HomeOrPlayListFull"
	if CoD.isPC then
		HomeOrPlayListFullPC.id = "HomeOrPlayListFullPC"
	end
	SetUpMatchButton.id = "SetUpMatchButton"
	StartButton.id = "StartButton"
	DirectorLobbyPoseMembersZM.id = "DirectorLobbyPoseMembersZM"
	CustomGamesButton.id = "CustomGamesButton"
	DirectorLobbySettingList.id = "DirectorLobbySettingList"
	DirectorLaboratoryButton.id = "DirectorLaboratoryButton"
	self.__defaultFocus = f1_local3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	if IsPC() then
		SetElementProperty(self.HomeOrPlayListFullPC, "_preGameType", "custom")
		ChangeDefaultFocus(self, self.StartButton)
	else
		SetElementProperty(self.HomeOrPlayListFull, "_preGameType", "custom")
	end
	return self
end
CoD.directorCustom.__resetProperties = function(f94_arg0)
	f94_arg0.HomeOrPlayListFullPC:completeAnimation()
	f94_arg0.HomeOrPlayListFull:completeAnimation()
	f94_arg0.DirectorLobbyPoseMembers:completeAnimation()
	f94_arg0.ZMLoadoutPreviewInfo:completeAnimation()
	f94_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
	f94_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
	f94_arg0.SetUpMatchButton:completeAnimation()
	f94_arg0.DirectorLobbySettingList:completeAnimation()
	f94_arg0.LeaderActivity:completeAnimation()
	f94_arg0.DirectorLaboratoryButton:completeAnimation()
	f94_arg0.CustomGamesButton:completeAnimation()
	f94_arg0.StartButton:completeAnimation()
	f94_arg0.HomeOrPlayListFullPC:setLeftRight(0.5, 0.5, -505, 478)
	f94_arg0.HomeOrPlayListFull:setLeftRight(0.5, 0.5, -505, 478)
	f94_arg0.DirectorLobbyPoseMembers:setAlpha(1)
	f94_arg0.ZMLoadoutPreviewInfo:setLeftRight(0.5, 0.5, -506, 428)
	f94_arg0.ZMLoadoutPreviewInfo:setAlpha(0)
	f94_arg0.DirectorLobbyPoseMembersZM:setAlpha(0)
	f94_arg0.DirectorMapGameTypeAndDifficulty:setLeftRight(0.5, 0.5, 514, 896)
	f94_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(1, 1, -368, -188)
	f94_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(0)
	f94_arg0.SetUpMatchButton:setLeftRight(0.5, 0.5, 514, 896)
	f94_arg0.SetUpMatchButton:setTopBottom(1, 1, -368, -188)
	f94_arg0.SetUpMatchButton:setAlpha(1)
	f94_arg0.DirectorLobbySettingList:setLeftRight(0.5, 0.5, 514, 896)
	f94_arg0.DirectorLobbySettingList:setTopBottom(1, 1, -508, -388)
	f94_arg0.DirectorLobbySettingList:setAlpha(0)
	f94_arg0.LeaderActivity:setLeftRight(0.5, 0.5, -896, -429)
	f94_arg0.LeaderActivity:setTopBottom(1, 1, -247, -216)
	f94_arg0.DirectorLaboratoryButton:setLeftRight(0.5, 0.5, -896, -542)
	f94_arg0.DirectorLaboratoryButton:setAlpha(0)
	f94_arg0.CustomGamesButton:setAlpha(0)
	f94_arg0.StartButton:setLeftRight(0.5, 0.5, 514, 896)
	f94_arg0.StartButton:setTopBottom(1, 1, -178, -108)
end
CoD.directorCustom.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f95_arg0, f95_arg1)
			f95_arg0:__resetProperties()
			f95_arg0:setupElementClipCounter(2)
			f95_arg0.HomeOrPlayListFull:completeAnimation()
			f95_arg0.HomeOrPlayListFull:setLeftRight(0.5, 0.5, -505, 478)
			f95_arg0.clipFinished(f95_arg0.HomeOrPlayListFull)
			f95_arg0.HomeOrPlayListFullPC:completeAnimation()
			f95_arg0.HomeOrPlayListFullPC:setLeftRight(0.5, 0.5, -505, 478)
			f95_arg0.clipFinished(f95_arg0.HomeOrPlayListFullPC)
			f95_arg0.CommonHeader:completeAnimation()
			f95_arg0.clipFinished(f95_arg0.CommonHeader)
		end,
	},
	ZMOnline_isPC = {
		DefaultClip = function(f96_arg0, f96_arg1)
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter(9)
			f96_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f96_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(1, 1, -368, -188)
			f96_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f96_arg0.clipFinished(f96_arg0.DirectorMapGameTypeAndDifficulty)
			f96_arg0.LeaderActivity:completeAnimation()
			f96_arg0.LeaderActivity:setTopBottom(1, 1, -559, -528)
			f96_arg0.clipFinished(f96_arg0.LeaderActivity)
			f96_arg0.CommonHeader:completeAnimation()
			f96_arg0.clipFinished(f96_arg0.CommonHeader)
			f96_arg0.DirectorLobbyPoseMembers:completeAnimation()
			f96_arg0.DirectorLobbyPoseMembers:setAlpha(0)
			f96_arg0.clipFinished(f96_arg0.DirectorLobbyPoseMembers)
			f96_arg0.SetUpMatchButton:completeAnimation()
			f96_arg0.SetUpMatchButton:setAlpha(0)
			f96_arg0.clipFinished(f96_arg0.SetUpMatchButton)
			f96_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f96_arg0.ZMLoadoutPreviewInfo:setLeftRight(0.5, 0.5, -891, 369)
			f96_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f96_arg0.clipFinished(f96_arg0.ZMLoadoutPreviewInfo)
			f96_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f96_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f96_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f96_arg0.clipFinished(f96_arg0.DirectorLobbyPoseMembersZM)
			f96_arg0.DirectorLobbySettingList:completeAnimation()
			f96_arg0.DirectorLobbySettingList:setAlpha(1)
			f96_arg0.clipFinished(f96_arg0.DirectorLobbySettingList)
			f96_arg0.DirectorLaboratoryButton:completeAnimation()
			f96_arg0.DirectorLaboratoryButton:setLeftRight(0.5, 0.5, -891, -537)
			f96_arg0.DirectorLaboratoryButton:setAlpha(1)
			f96_arg0.clipFinished(f96_arg0.DirectorLaboratoryButton)
		end,
	},
	ZMOnline = {
		DefaultClip = function(f97_arg0, f97_arg1)
			f97_arg0:__resetProperties()
			f97_arg0:setupElementClipCounter(9)
			f97_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f97_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(1, 1, -368, -188)
			f97_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f97_arg0.clipFinished(f97_arg0.DirectorMapGameTypeAndDifficulty)
			f97_arg0.LeaderActivity:completeAnimation()
			f97_arg0.LeaderActivity:setTopBottom(1, 1, -559, -528)
			f97_arg0.clipFinished(f97_arg0.LeaderActivity)
			f97_arg0.CommonHeader:completeAnimation()
			f97_arg0.clipFinished(f97_arg0.CommonHeader)
			f97_arg0.DirectorLobbyPoseMembers:completeAnimation()
			f97_arg0.DirectorLobbyPoseMembers:setAlpha(0)
			f97_arg0.clipFinished(f97_arg0.DirectorLobbyPoseMembers)
			f97_arg0.SetUpMatchButton:completeAnimation()
			f97_arg0.SetUpMatchButton:setAlpha(0)
			f97_arg0.clipFinished(f97_arg0.SetUpMatchButton)
			f97_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f97_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f97_arg0.clipFinished(f97_arg0.ZMLoadoutPreviewInfo)
			f97_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f97_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f97_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f97_arg0.clipFinished(f97_arg0.DirectorLobbyPoseMembersZM)
			f97_arg0.DirectorLobbySettingList:completeAnimation()
			f97_arg0.DirectorLobbySettingList:setAlpha(1)
			f97_arg0.clipFinished(f97_arg0.DirectorLobbySettingList)
			f97_arg0.DirectorLaboratoryButton:completeAnimation()
			f97_arg0.DirectorLaboratoryButton:setAlpha(1)
			f97_arg0.clipFinished(f97_arg0.DirectorLaboratoryButton)
		end,
	},
	ZMOfflinePrivate = {
		DefaultClip = function(f98_arg0, f98_arg1)
			f98_arg0:__resetProperties()
			f98_arg0:setupElementClipCounter(9)
			f98_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f98_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f98_arg0.clipFinished(f98_arg0.DirectorMapGameTypeAndDifficulty)
			f98_arg0.LeaderActivity:completeAnimation()
			f98_arg0.LeaderActivity:setTopBottom(1, 1, -449, -418)
			f98_arg0.clipFinished(f98_arg0.LeaderActivity)
			f98_arg0.CommonHeader:completeAnimation()
			f98_arg0.clipFinished(f98_arg0.CommonHeader)
			f98_arg0.DirectorLobbyPoseMembers:completeAnimation()
			f98_arg0.DirectorLobbyPoseMembers:setAlpha(0)
			f98_arg0.clipFinished(f98_arg0.DirectorLobbyPoseMembers)
			f98_arg0.SetUpMatchButton:completeAnimation()
			f98_arg0.SetUpMatchButton:setAlpha(0)
			f98_arg0.clipFinished(f98_arg0.SetUpMatchButton)
			f98_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f98_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f98_arg0.clipFinished(f98_arg0.ZMLoadoutPreviewInfo)
			f98_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f98_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f98_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f98_arg0.clipFinished(f98_arg0.DirectorLobbyPoseMembersZM)
			f98_arg0.CustomGamesButton:completeAnimation()
			f98_arg0.CustomGamesButton:setAlpha(1)
			f98_arg0.clipFinished(f98_arg0.CustomGamesButton)
			f98_arg0.DirectorLobbySettingList:completeAnimation()
			f98_arg0.DirectorLobbySettingList:setAlpha(0)
			f98_arg0.clipFinished(f98_arg0.DirectorLobbySettingList)
		end,
	},
	ZM_isPC = {
		DefaultClip = function(f99_arg0, f99_arg1)
			f99_arg0:__resetProperties()
			f99_arg0:setupElementClipCounter(9)
			f99_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f99_arg0.DirectorMapGameTypeAndDifficulty:setLeftRight(0.5, 0.5, 514, 896)
			f99_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(1, 1, -495, -315)
			f99_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f99_arg0.clipFinished(f99_arg0.DirectorMapGameTypeAndDifficulty)
			f99_arg0.LeaderActivity:completeAnimation()
			f99_arg0.LeaderActivity:setLeftRight(0.5, 0.5, 400, 867)
			f99_arg0.LeaderActivity:setTopBottom(1, 1, -532, -501)
			f99_arg0.clipFinished(f99_arg0.LeaderActivity)
			f99_arg0.CommonHeader:completeAnimation()
			f99_arg0.clipFinished(f99_arg0.CommonHeader)
			f99_arg0.DirectorLobbyPoseMembers:completeAnimation()
			f99_arg0.DirectorLobbyPoseMembers:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.DirectorLobbyPoseMembers)
			f99_arg0.SetUpMatchButton:completeAnimation()
			f99_arg0.SetUpMatchButton:setLeftRight(0.5, 0.5, 429, 896)
			f99_arg0.SetUpMatchButton:setTopBottom(1, 1, -369, -189)
			f99_arg0.SetUpMatchButton:setAlpha(0)
			f99_arg0.clipFinished(f99_arg0.SetUpMatchButton)
			f99_arg0.StartButton:completeAnimation()
			f99_arg0.StartButton:setLeftRight(0.5, 0.5, 514, 896)
			f99_arg0.StartButton:setTopBottom(1, 1, -180, -110)
			f99_arg0.clipFinished(f99_arg0.StartButton)
			f99_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f99_arg0.ZMLoadoutPreviewInfo:setLeftRight(0.5, 0.5, -891, 369)
			f99_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f99_arg0.clipFinished(f99_arg0.ZMLoadoutPreviewInfo)
			f99_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f99_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f99_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f99_arg0.clipFinished(f99_arg0.DirectorLobbyPoseMembersZM)
			f99_arg0.DirectorLobbySettingList:completeAnimation()
			f99_arg0.DirectorLobbySettingList:setLeftRight(0.5, 0.5, 514, 896)
			f99_arg0.DirectorLobbySettingList:setTopBottom(1, 1, -307, -187)
			f99_arg0.DirectorLobbySettingList:setAlpha(1)
			f99_arg0.clipFinished(f99_arg0.DirectorLobbySettingList)
		end,
	},
	ZM = {
		DefaultClip = function(f100_arg0, f100_arg1)
			f100_arg0:__resetProperties()
			f100_arg0:setupElementClipCounter(8)
			f100_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f100_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f100_arg0.clipFinished(f100_arg0.DirectorMapGameTypeAndDifficulty)
			f100_arg0.LeaderActivity:completeAnimation()
			f100_arg0.LeaderActivity:setTopBottom(1, 1, -559, -528)
			f100_arg0.clipFinished(f100_arg0.LeaderActivity)
			f100_arg0.CommonHeader:completeAnimation()
			f100_arg0.clipFinished(f100_arg0.CommonHeader)
			f100_arg0.DirectorLobbyPoseMembers:completeAnimation()
			f100_arg0.DirectorLobbyPoseMembers:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.DirectorLobbyPoseMembers)
			f100_arg0.SetUpMatchButton:completeAnimation()
			f100_arg0.SetUpMatchButton:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.SetUpMatchButton)
			f100_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f100_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f100_arg0.clipFinished(f100_arg0.ZMLoadoutPreviewInfo)
			f100_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f100_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f100_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f100_arg0.clipFinished(f100_arg0.DirectorLobbyPoseMembersZM)
			f100_arg0.DirectorLobbySettingList:completeAnimation()
			f100_arg0.DirectorLobbySettingList:setAlpha(1)
			f100_arg0.clipFinished(f100_arg0.DirectorLobbySettingList)
		end,
	},
	WZ = {
		DefaultClip = function(f101_arg0, f101_arg1)
			f101_arg0:__resetProperties()
			f101_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultState_isPC = {
		DefaultClip = function(f102_arg0, f102_arg1)
			f102_arg0:__resetProperties()
			f102_arg0:setupElementClipCounter(7)
			f102_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f102_arg0.DirectorMapGameTypeAndDifficulty:setLeftRight(0.5, 0.5, 514, 896)
			f102_arg0.DirectorMapGameTypeAndDifficulty:setTopBottom(1, 1, -368, -188)
			f102_arg0.clipFinished(f102_arg0.DirectorMapGameTypeAndDifficulty)
			f102_arg0.LeaderActivity:completeAnimation()
			f102_arg0.LeaderActivity:setLeftRight(0.5, 0.5, 400, 867)
			f102_arg0.LeaderActivity:setTopBottom(1, 1, -429, -398)
			f102_arg0.clipFinished(f102_arg0.LeaderActivity)
			f102_arg0.HomeOrPlayListFullPC:completeAnimation()
			f102_arg0.HomeOrPlayListFullPC:setLeftRight(0.5, 0.5, -505, 478)
			f102_arg0.clipFinished(f102_arg0.HomeOrPlayListFullPC)
			f102_arg0.CommonHeader:completeAnimation()
			f102_arg0.clipFinished(f102_arg0.CommonHeader)
			f102_arg0.SetUpMatchButton:completeAnimation()
			f102_arg0.SetUpMatchButton:setLeftRight(0.5, 0.5, 514, 896)
			f102_arg0.SetUpMatchButton:setTopBottom(1, 1, -368, -188)
			f102_arg0.clipFinished(f102_arg0.SetUpMatchButton)
			f102_arg0.StartButton:completeAnimation()
			f102_arg0.StartButton:setLeftRight(0.5, 0.5, 514, 896)
			f102_arg0.StartButton:setTopBottom(1, 1, -178, -108)
			f102_arg0.clipFinished(f102_arg0.StartButton)
			f102_arg0.DirectorLobbySettingList:completeAnimation()
			f102_arg0.DirectorLobbySettingList:setLeftRight(0.5, 0.5, 429, 896)
			f102_arg0.DirectorLobbySettingList:setTopBottom(1, 1, -308, -188)
			f102_arg0.clipFinished(f102_arg0.DirectorLobbySettingList)
		end,
	},
}
CoD.directorCustom.__onClose = function(f103_arg0)
	f103_arg0.CustomGamePlayers:close()
	f103_arg0.DirectorMapGameTypeAndDifficulty:close()
	f103_arg0.LeaderActivity:close()
	f103_arg0.HomeOrPlayListFull:close()
	f103_arg0.HomeOrPlayListFullPC:close()
	f103_arg0.CommonHeader:close()
	f103_arg0.DirectorLobbyPoseMembers:close()
	f103_arg0.SetUpMatchButton:close()
	f103_arg0.StartButton:close()
	f103_arg0.ZMLoadoutPreviewInfo:close()
	f103_arg0.DirectorLobbyPoseMembersZM:close()
	f103_arg0.CustomGamesButton:close()
	f103_arg0.DirectorLobbySettingList:close()
	f103_arg0.DirectorLaboratoryButton:close()
end
