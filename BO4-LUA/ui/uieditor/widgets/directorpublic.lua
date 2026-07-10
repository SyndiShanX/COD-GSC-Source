require("x64:4e00c58c379f1b0")
require("x64:260c7a8e3737127")
require("x64:51ef3a2adbd471e")
require("x64:d22d3654b78ec39")
require("x64:c89d021ac8b3747")
require("x64:e3efc70851381")
require("x64:7b2e5c29b34a47e")
require("x64:bfdd9a330518b28")
require("x64:46b093e7d34ea80")
require("x64:a155eac5398a2a3")
require("x64:d4ed3fd8d1fcc4a")
require("x64:e41af73729601d6")
require("x64:429ef25909713fe")
require("x64:4632a684587e313")
require("x64:233e193bf9509f4")
require("x64:445928c36e455a1")
CoD.directorPublic = InheritFrom(LUI.UIElement)
CoD.directorPublic.__defaultWidth = 1920
CoD.directorPublic.__defaultHeight = 1080
CoD.directorPublic.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.DirectorUtility.InitPublicLobbyModels(self, f1_arg1, f1_arg0)
	CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
	CoD.BaseUtility.CreateGlobalModel("MapVote.mapVoteMapPreviousGametype")
	self:setClass(CoD.directorPublic)
	self.id = "directorPublic"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HeaderWZ = CoD.StageNotificationContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 120)
	HeaderWZ:setAlpha(0)
	HeaderWZ.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xA2DD20750465431))
	HeaderWZ.CommonHeader.subtitle.subtitle:setAlpha(0)
	HeaderWZ:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.stageDetails", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			HeaderWZ.CommonHeader.subtitle.subtitle:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f2_local0)))
		end
	end)
	self:addElement(HeaderWZ)
	self.HeaderWZ = HeaderWZ
	local HeaderWZDeploying = CoD.StageNotificationContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 120)
	HeaderWZDeploying:setAlpha(0)
	HeaderWZDeploying.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			HeaderWZDeploying.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.PlaylistIDToPlaylistName(f3_local0)))
		end
	end
	HeaderWZDeploying:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", HeaderWZDeploying.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle)
	HeaderWZDeploying.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle_FullPath = function()
		local f4_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f4_local0 = f4_local0.playlistId
		if f4_local0 then
			HeaderWZDeploying.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle(f4_local0)
		end
	end
	HeaderWZDeploying:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.stageDetails", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			HeaderWZDeploying.CommonHeader.subtitle.subtitle:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f5_local0)))
		end
	end)
	self:addElement(HeaderWZDeploying)
	self.HeaderWZDeploying = HeaderWZDeploying
	local HeaderMP = CoD.StageNotificationContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 120)
	HeaderMP:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HeaderMP.CommonHeader.subtitle.StageTitle:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f6_local0))
		end
	end)
	HeaderMP:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.stageDetails", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			HeaderMP.CommonHeader.subtitle.subtitle:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f7_local0)))
		end
	end)
	self:addElement(HeaderMP)
	self.HeaderMP = HeaderMP
	local WarzoneHostPlayButton = CoD.DirectorPublicWzPlayButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -178, -108)
	WarzoneHostPlayButton:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f8_local0 = CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INVALID)
				if f8_local0 then
					f8_local0 = CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39])
					if f8_local0 then
						f8_local0 = IsLobbyPrivateHost()
						if f8_local0 then
							f8_local0 = IsWarzone()
							if f8_local0 then
								f8_local0 = CoD.DirectorUtility.ShowDirectorPublic(f1_arg1)
								if f8_local0 then
									f8_local0 = CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[0x89C1455C5032969][0x78C124999125C42])
									if f8_local0 then
										f8_local0 = CoD.LobbyUtility.AllMembersInFrontend()
									end
								end
							end
						end
					end
				end
				return f8_local0
			end,
		},
	})
	local DirectorTogglePartyFill = WarzoneHostPlayButton
	local WarzoneClientPlayButton = WarzoneHostPlayButton.subscribeToModel
	local CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	WarzoneClientPlayButton(DirectorTogglePartyFill, CustomGamesButton["lobbyRoot.publicLobby.stage"], function(f9_arg0)
		f1_arg0:updateElementState(WarzoneHostPlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	DirectorTogglePartyFill = WarzoneHostPlayButton
	WarzoneClientPlayButton = WarzoneHostPlayButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	WarzoneClientPlayButton(DirectorTogglePartyFill, CustomGamesButton["lobbyRoot.privateClient.update"], function(f10_arg0)
		f1_arg0:updateElementState(WarzoneHostPlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	DirectorTogglePartyFill = WarzoneHostPlayButton
	WarzoneClientPlayButton = WarzoneHostPlayButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	WarzoneClientPlayButton(DirectorTogglePartyFill, CustomGamesButton["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(WarzoneHostPlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorTogglePartyFill = WarzoneHostPlayButton
	WarzoneClientPlayButton = WarzoneHostPlayButton.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	WarzoneClientPlayButton(DirectorTogglePartyFill, CustomGamesButton["lobbyRoot.lobbyMainMode"], function(f12_arg0)
		f1_arg0:updateElementState(WarzoneHostPlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	WarzoneHostPlayButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0xA56BF6A96B02984))
	WarzoneHostPlayButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0xA56BF6A96B02984))
	WarzoneHostPlayButton:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WarzoneHostPlayButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		LobbyOnlineStartMatchMaking(menu, self, element, controller)
		PlaySoundAlias("uin_wz_deploy")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(WarzoneHostPlayButton)
	self.WarzoneHostPlayButton = WarzoneHostPlayButton
	WarzoneClientPlayButton = CoD.DirectorPublicWzPlayButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -178, -108)
	WarzoneClientPlayButton:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f16_local0 = CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INVALID)
				if f16_local0 then
					f16_local0 = CoD.BaseUtility.IsCurrentSessionModeEqualTo(Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39])
					if f16_local0 then
						if not IsLobbyPrivateHost() then
							f16_local0 = IsWarzone()
							if f16_local0 then
								f16_local0 = CoD.DirectorUtility.ShowDirectorPublic(f1_arg1)
								if f16_local0 then
									f16_local0 = CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[0x89C1455C5032969][0x78C124999125C42])
									if f16_local0 then
										f16_local0 = CoD.LobbyUtility.AllMembersInFrontend()
									end
								end
							end
						else
							f16_local0 = false
						end
					end
				end
				return f16_local0
			end,
		},
	})
	CustomGamesButton = WarzoneClientPlayButton
	DirectorTogglePartyFill = WarzoneClientPlayButton.subscribeToModel
	local DirectorWarningMessage = Engine[0x8DF2E5447F384B9]()
	DirectorTogglePartyFill(CustomGamesButton, DirectorWarningMessage["lobbyRoot.publicLobby.stage"], function(f17_arg0)
		f1_arg0:updateElementState(WarzoneClientPlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	CustomGamesButton = WarzoneClientPlayButton
	DirectorTogglePartyFill = WarzoneClientPlayButton.subscribeToModel
	DirectorWarningMessage = Engine[0x8DF2E5447F384B9]()
	DirectorTogglePartyFill(CustomGamesButton, DirectorWarningMessage["lobbyRoot.privateClient.update"], function(f18_arg0)
		f1_arg0:updateElementState(WarzoneClientPlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	CustomGamesButton = WarzoneClientPlayButton
	DirectorTogglePartyFill = WarzoneClientPlayButton.subscribeToModel
	DirectorWarningMessage = Engine[0x8DF2E5447F384B9]()
	DirectorTogglePartyFill(CustomGamesButton, DirectorWarningMessage["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(WarzoneClientPlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CustomGamesButton = WarzoneClientPlayButton
	DirectorTogglePartyFill = WarzoneClientPlayButton.subscribeToModel
	DirectorWarningMessage = Engine[0x8DF2E5447F384B9]()
	DirectorTogglePartyFill(CustomGamesButton, DirectorWarningMessage["lobbyRoot.lobbyMainMode"], function(f20_arg0)
		f1_arg0:updateElementState(WarzoneClientPlayButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	WarzoneClientPlayButton:subscribeToGlobalModel(f1_arg1, "LobbyRoot", nil, function(model)
		WarzoneClientPlayButton:setModel(model, f1_arg1)
	end)
	WarzoneClientPlayButton:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "leaderActivity", function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			WarzoneClientPlayButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(f22_local0))
		end
	end)
	WarzoneClientPlayButton:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "leaderActivity", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			WarzoneClientPlayButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(f23_local0))
		end
	end)
	self:addElement(WarzoneClientPlayButton)
	self.WarzoneClientPlayButton = WarzoneClientPlayButton
	DirectorTogglePartyFill = CoD.DirectorTogglePartyFill.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -434, -388)
	self:addElement(DirectorTogglePartyFill)
	self.DirectorTogglePartyFill = DirectorTogglePartyFill
	CustomGamesButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -500, -454)
	CustomGamesButton:mergeStateConditions({
		{
			stateName = "VisibleTrialLocked",
			condition = function(menu, element, event)
				return CoD.WZUtility.AllowWZOffline() and IsGameTrial()
			end,
		},
		{
			stateName = "VisibleZmOffline",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f26_local0 = CoD.WZUtility.AllowWZOffline()
				if f26_local0 then
					if not IsGameTrial() then
						f26_local0 = CoD.BaseUtility.IsDvarEnabled("ui_showWZCustomGameOption")
					else
						f26_local0 = false
					end
				end
				return f26_local0
			end,
		},
	})
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
	local TopBar = CustomGamesButton
	DirectorWarningMessage = CustomGamesButton.subscribeToModel
	local f1_local10 = Engine[0x8DF2E5447F384B9]()
	DirectorWarningMessage(TopBar, f1_local10["lobbyRoot.lobbyNav"], function(f29_arg0, f29_arg1)
		CoD.Menu.UpdateButtonShownState(f29_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamesButton:registerEventHandler("gain_focus", function(element, event)
		local f30_local0 = nil
		if element.gainFocus then
			f30_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f30_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f30_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CustomGamesButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.WZUtility.AllowWZOffline() and not IsGameTrial() and IsWarzone() and not IsPC() then
			PlaySoundAlias("uin_press_generic")
			OpenSystemOverlay(self, menu, controller, "CustomGamesNotification")
			SetLoseFocusToSelf(self, controller)
			return true
		elseif CoD.WZUtility.AllowWZOffline() and not IsGameTrial() and IsWarzone() and IsPC() then
			PlaySoundAlias("uin_press_generic")
			CoD.DirectorUtility.NavigateToCustomLobbyForCurrentMode(menu, controller)
			SetLoseFocusToSelf(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.WZUtility.AllowWZOffline() and not IsGameTrial() and IsWarzone() and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif CoD.WZUtility.AllowWZOffline() and not IsGameTrial() and IsWarzone() and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(CustomGamesButton)
	self.CustomGamesButton = CustomGamesButton
	DirectorWarningMessage = CoD.DirectorWarningMessage.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -575, -520)
	self:addElement(DirectorWarningMessage)
	self.DirectorWarningMessage = DirectorWarningMessage
	TopBar = CoD.header_container_frontend.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(TopBar)
	self.TopBar = TopBar
	f1_local10 = nil
	f1_local10 = LUI.UIElement.createFake()
	self.MapVote = f1_local10
	local MapVotePC = nil
	MapVotePC = CoD.MapVote.new(f1_arg0, f1_arg1, 0.5, 0.5, -505, 406, 1, 1, -399, -184)
	self:addElement(MapVotePC)
	self.MapVotePC = MapVotePC
	local MapVoteZM = CoD.MapVoteZM.new(f1_arg0, f1_arg1, 0.5, 0.5, 510, 904, 1, 1, -580, -225)
	self:addElement(MapVoteZM)
	self.MapVoteZM = MapVoteZM
	local MapAndGameType = CoD.DirectorMapAndGameTypeContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -368, -188)
	MapAndGameType.DirectorMapAndGameInternal.GamemodeIcon:setImage(RegisterImage(0x7615068F50B3D66))
	MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label:setText("")
	MapAndGameType.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setText(Engine[0xF9F1239CFD921FE](0x890976738B1D859))
	MapAndGameType.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setTTF("ttmussels_regular")
	MapAndGameType.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setText(Engine[0xF9F1239CFD921FE](0x890976738B1D859))
	MapAndGameType.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setTTF("ttmussels_regular")
	MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image = function(f33_arg0)
		local f33_local0 = f33_arg0:get()
		if f33_local0 ~= nil then
			MapAndGameType.DirectorMapAndGameInternal.MapImage:setImage(RegisterImage(CoD.DirectorUtility.PlaylistIDToPlaylistImageTileSideInfo(f33_local0)))
		end
	end
	MapAndGameType:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image)
	MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image_FullPath = function()
		local f34_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f34_local0 = f34_local0.playlistId
		if f34_local0 then
			MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image(f34_local0)
		end
	end
	MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title = function(f35_arg0)
		local f35_local0 = f35_arg0:get()
		if f35_local0 ~= nil then
			MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.PlaylistIDToPlaylistName(f35_local0)))
		end
	end
	MapAndGameType:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title)
	MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title_FullPath = function()
		local f36_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f36_local0 = f36_local0.playlistId
		if f36_local0 then
			MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title(f36_local0)
		end
	end
	local DirectorLobbyPoseMembers = MapAndGameType
	local DirectorReadyButton = MapAndGameType.subscribeToModel
	local DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	DirectorReadyButton(DirectorLobbyPoseMembers, DirectorLobbyPoseMembersZM["lobbyRoot.lobbyNav"], function(f37_arg0, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorLobbyPoseMembers = MapAndGameType
	DirectorReadyButton = MapAndGameType.subscribeToModel
	DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	DirectorReadyButton(DirectorLobbyPoseMembers, DirectorLobbyPoseMembersZM["lobbyRoot.privateClient.isHost"], function(f38_arg0, f38_arg1)
		CoD.Menu.UpdateButtonShownState(f38_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorLobbyPoseMembers = MapAndGameType
	DirectorReadyButton = MapAndGameType.subscribeToModel
	DirectorLobbyPoseMembersZM = Engine[0x8DF2E5447F384B9]()
	DirectorReadyButton(DirectorLobbyPoseMembers, DirectorLobbyPoseMembersZM["lobbyRoot.gameClient.isHost"], function(f39_arg0, f39_arg1)
		CoD.Menu.UpdateButtonShownState(f39_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	MapAndGameType:registerEventHandler("gain_focus", function(element, event)
		local f40_local0 = nil
		if element.gainFocus then
			f40_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f40_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f40_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapAndGameType, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsZombies() and IsPartyLeader(controller) then
			CoD.DirectorUtility.DirectorOpenOverlayWithCurrentMenuMode(menu, controller, "DirectorFindGameWZ")
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsZombies() and IsPartyLeader(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(MapAndGameType)
	self.MapAndGameType = MapAndGameType
	DirectorReadyButton = CoD.DirectorReadyButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -178, -108)
	DirectorReadyButton:setAlpha(0)
	DirectorReadyButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x7A9F166E7248D86))
	DirectorReadyButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x7A9F166E7248D86))
	DirectorReadyButton.PlayText:setText(LocalizeToUpperString(0xE6F6113B8B75F3E))
	DirectorReadyButton:subscribeToGlobalModel(f1_arg1, "PerController", "ButtonBits." .. Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], function(model)
		DirectorReadyButton:setModel(model, f1_arg1)
	end)
	self:addElement(DirectorReadyButton)
	self.DirectorReadyButton = DirectorReadyButton
	DirectorLobbyPoseMembers = CoD.DirectorLobbyPoseMembers.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(DirectorLobbyPoseMembers)
	self.DirectorLobbyPoseMembers = DirectorLobbyPoseMembers
	DirectorLobbyPoseMembersZM = CoD.DirectorLobbyPoseMembersZM.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 30, 30)
	DirectorLobbyPoseMembersZM:setAlpha(0)
	DirectorLobbyPoseMembersZM:subscribeToGlobalModel(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewWidgetPublic", function(model)
		local f44_local0 = model:get()
		if f44_local0 ~= nil then
			DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:changeFrameWidget(f44_local0)
		end
	end)
	self:addElement(DirectorLobbyPoseMembersZM)
	self.DirectorLobbyPoseMembersZM = DirectorLobbyPoseMembersZM
	local overheadNameContainer = CoD.DynamicContainerWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	self:addElement(overheadNameContainer)
	self.overheadNameContainer = overheadNameContainer
	local ZMLoadoutPreviewInfo = CoD.ZMLoadoutPreviewInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, -506, 428, 1, 1, -333, -207)
	self:addElement(ZMLoadoutPreviewInfo)
	self.ZMLoadoutPreviewInfo = ZMLoadoutPreviewInfo
	local TrialCountdown = CoD.TrialCountdownSmallWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -896, -614, 0, 0, 87, 132)
	self:addElement(TrialCountdown)
	self.TrialCountdown = TrialCountdown
	local f1_local20 = HeaderWZDeploying
	local f1_local21 = HeaderWZDeploying.subscribeToModel
	local f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.lobbyNetworkMode"], HeaderWZDeploying.CommonHeader.subtitle.StageTitle.__CommonHeader_subtitle_ScreenTitle_FullPath)
	f1_local20 = CustomGamesButton
	f1_local21 = CustomGamesButton.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.lobbyNav"], CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText.__MiddleText_StringReference)
	f1_local20 = CustomGamesButton
	f1_local21 = CustomGamesButton.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.lobbyNav"], CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus.__MiddleTextFocus_String)
	f1_local20 = MapAndGameType
	f1_local21 = MapAndGameType.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.lobbyNetworkMode"], MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image_FullPath)
	f1_local20 = MapAndGameType
	f1_local21 = MapAndGameType.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.lobbyNetworkMode"], MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title_FullPath)
	self:mergeStateConditions({
		{
			stateName = "WarzoneNotDeployed_isPC",
			condition = function(menu, element, event)
				local f45_local0 = IsPC()
				if f45_local0 then
					f45_local0 = CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[0x89C1455C5032969][0x78C124999125C42])
					if f45_local0 then
						f45_local0 = CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INVALID)
					end
				end
				return f45_local0
			end,
		},
		{
			stateName = "WarzoneNotDeployed",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[0x89C1455C5032969][0x78C124999125C42]) and CoD.ModelUtility.IsGlobalModelValueEqualToEnum("lobbyRoot.publicLobby.stage", LuaEnum.PUBLIC_LOBBY.INVALID)
			end,
		},
		{
			stateName = "WarzoneDeploying_isPC",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[0x89C1455C5032969][0x78C124999125C42]) and IsPC()
			end,
		},
		{
			stateName = "WarzoneDeploying",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsMainMode(f1_arg1, Enum[0x89C1455C5032969][0x78C124999125C42])
			end,
		},
		{
			stateName = "Zombies_isPC",
			condition = function(menu, element, event)
				return IsZombies() and IsPC()
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
		{
			stateName = "NotWarzone_isPC",
			condition = function(menu, element, event)
				return AlwaysTrue() and IsPC()
			end,
		},
		{
			stateName = "NotWarzone",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	f1_local20 = self
	f1_local21 = self.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.lobbyMainMode"], function(f53_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	f1_local20 = self
	f1_local21 = self.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.lobbyNav"], function(f54_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local20 = self
	f1_local21 = self.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.publicLobby.stage"], function(f55_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "lobbyRoot.publicLobby.stage",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f56_arg2, f56_arg3, f56_arg4)
		if CoD.BaseUtility.IsSelfInEitherState(self, "WarzoneNotDeployed", "WarzoneNotDeployed_isPC") and IsLobbyHost() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.WarzoneHostPlayButton)
			ForceCheckDefaultPCFocus(element, f1_arg0, controller)
		elseif not CoD.BaseUtility.IsSelfInEitherState(self, "WarzoneNotDeployed", "WarzoneNotDeployed_isPC") and IsLobbyHost() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.HomeOrPlayList)
			ForceCheckDefaultPCFocus(element, f1_arg0, controller)
		elseif not IsLobbyHost() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.HomeOrPlayList)
			ForceCheckDefaultPCFocus(element, f1_arg0, controller)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "gameClientDataUpdate", function(model)
		local f57_local0 = self
		if CoD.DirectorUtility.ShowDirectorPublic(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "clientUpdated", function(model)
		local f58_local0 = self
		if CoD.DirectorUtility.ShowDirectorPublic(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyNav", function(model)
		local f59_local0 = self
		if CoD.DirectorUtility.ShowDirectorPublic(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
			CoD.BlackMarketUtility.InitializeLootStreamTier(f1_arg1, f1_arg0)
		end
	end)
	WarzoneHostPlayButton.id = "WarzoneHostPlayButton"
	WarzoneClientPlayButton.id = "WarzoneClientPlayButton"
	DirectorTogglePartyFill.id = "DirectorTogglePartyFill"
	CustomGamesButton.id = "CustomGamesButton"
	f1_local10.id = "MapVote"
	if CoD.isPC then
		MapVotePC.id = "MapVotePC"
	end
	MapVoteZM.id = "MapVoteZM"
	MapAndGameType.id = "MapAndGameType"
	DirectorReadyButton.id = "DirectorReadyButton"
	DirectorLobbyPoseMembersZM.id = "DirectorLobbyPoseMembersZM"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local21 = self
	CoD.LobbyUtility.InitOverheadNamesPreLobby(f1_arg0, f1_arg1, overheadNameContainer)
	return self
end
CoD.directorPublic.__resetProperties = function(f60_arg0)
	f60_arg0.MapVote:completeAnimation()
	f60_arg0.MapVoteZM:completeAnimation()
	f60_arg0.HeaderMP:completeAnimation()
	f60_arg0.MapVotePC:completeAnimation()
	f60_arg0.CustomGamesButton:completeAnimation()
	f60_arg0.HeaderWZ:completeAnimation()
	f60_arg0.MapAndGameType:completeAnimation()
	f60_arg0.WarzoneHostPlayButton:completeAnimation()
	f60_arg0.DirectorTogglePartyFill:completeAnimation()
	f60_arg0.HeaderWZDeploying:completeAnimation()
	f60_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
	f60_arg0.ZMLoadoutPreviewInfo:completeAnimation()
	f60_arg0.TrialCountdown:completeAnimation()
	f60_arg0.DirectorReadyButton:completeAnimation()
	f60_arg0.overheadNameContainer:completeAnimation()
	f60_arg0.MapVote:setAlpha(1)
	f60_arg0.MapVoteZM:setAlpha(1)
	f60_arg0.HeaderMP:setAlpha(1)
	f60_arg0.HeaderMP.CommonHeader.subtitle.subtitle:setAlpha(1)
	f60_arg0.MapVotePC:setAlpha(1)
	f60_arg0.CustomGamesButton:setAlpha(0)
	f60_arg0.HeaderWZ:setAlpha(0)
	f60_arg0.MapAndGameType:setAlpha(1)
	f60_arg0.WarzoneHostPlayButton:setAlpha(1)
	f60_arg0.DirectorTogglePartyFill:setAlpha(1)
	f60_arg0.HeaderWZDeploying:setAlpha(0)
	f60_arg0.DirectorLobbyPoseMembersZM:setAlpha(0)
	f60_arg0.ZMLoadoutPreviewInfo:setLeftRight(0.5, 0.5, -506, 428)
	f60_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
	f60_arg0.TrialCountdown:setAlpha(1)
	f60_arg0.DirectorReadyButton:setAlpha(0)
	f60_arg0.overheadNameContainer:setAlpha(1)
end
CoD.directorPublic.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(0)
		end,
	},
	WarzoneNotDeployed_isPC = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(5)
			f62_arg0.HeaderWZ:completeAnimation()
			f62_arg0.HeaderWZ:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.HeaderWZ)
			f62_arg0.HeaderMP:completeAnimation()
			f62_arg0.HeaderMP.CommonHeader.subtitle.subtitle:completeAnimation()
			f62_arg0.HeaderMP:setAlpha(0)
			f62_arg0.HeaderMP.CommonHeader.subtitle.subtitle:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.HeaderMP)
			f62_arg0.CustomGamesButton:completeAnimation()
			f62_arg0.CustomGamesButton:setAlpha(1)
			f62_arg0.clipFinished(f62_arg0.CustomGamesButton)
			f62_arg0.MapVote:completeAnimation()
			f62_arg0.MapVote:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.MapVote)
			f62_arg0.MapVotePC:completeAnimation()
			f62_arg0.MapVotePC:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.MapVotePC)
			f62_arg0.MapVoteZM:completeAnimation()
			f62_arg0.MapVoteZM:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.MapVoteZM)
		end,
	},
	WarzoneNotDeployed = {
		DefaultClip = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(4)
			f63_arg0.HeaderWZ:completeAnimation()
			f63_arg0.HeaderWZ:setAlpha(1)
			f63_arg0.clipFinished(f63_arg0.HeaderWZ)
			f63_arg0.HeaderMP:completeAnimation()
			f63_arg0.HeaderMP.CommonHeader.subtitle.subtitle:completeAnimation()
			f63_arg0.HeaderMP:setAlpha(0)
			f63_arg0.HeaderMP.CommonHeader.subtitle.subtitle:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.HeaderMP)
			f63_arg0.CustomGamesButton:completeAnimation()
			f63_arg0.CustomGamesButton:setAlpha(1)
			f63_arg0.clipFinished(f63_arg0.CustomGamesButton)
			f63_arg0.MapVote:completeAnimation()
			f63_arg0.MapVote:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.MapVote)
			f63_arg0.MapVoteZM:completeAnimation()
			f63_arg0.MapVoteZM:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.MapVoteZM)
		end,
	},
	WarzoneDeploying_isPC = {
		DefaultClip = function(f64_arg0, f64_arg1)
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter(7)
			f64_arg0.HeaderWZDeploying:completeAnimation()
			f64_arg0.HeaderWZDeploying:setAlpha(1)
			f64_arg0.clipFinished(f64_arg0.HeaderWZDeploying)
			f64_arg0.HeaderMP:completeAnimation()
			f64_arg0.HeaderMP:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.HeaderMP)
			f64_arg0.WarzoneHostPlayButton:completeAnimation()
			f64_arg0.WarzoneHostPlayButton:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.WarzoneHostPlayButton)
			f64_arg0.DirectorTogglePartyFill:completeAnimation()
			f64_arg0.DirectorTogglePartyFill:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.DirectorTogglePartyFill)
			f64_arg0.MapVote:completeAnimation()
			f64_arg0.MapVote:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.MapVote)
			f64_arg0.MapVotePC:completeAnimation()
			f64_arg0.MapVotePC:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.MapVotePC)
			f64_arg0.MapVoteZM:completeAnimation()
			f64_arg0.MapVoteZM:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.MapVoteZM)
			f64_arg0.MapAndGameType:completeAnimation()
			f64_arg0.MapAndGameType:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.MapAndGameType)
		end,
	},
	WarzoneDeploying = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(7)
			f65_arg0.HeaderWZDeploying:completeAnimation()
			f65_arg0.HeaderWZDeploying:setAlpha(1)
			f65_arg0.clipFinished(f65_arg0.HeaderWZDeploying)
			f65_arg0.HeaderMP:completeAnimation()
			f65_arg0.HeaderMP:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.HeaderMP)
			f65_arg0.WarzoneHostPlayButton:completeAnimation()
			f65_arg0.WarzoneHostPlayButton:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.WarzoneHostPlayButton)
			f65_arg0.DirectorTogglePartyFill:completeAnimation()
			f65_arg0.DirectorTogglePartyFill:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.DirectorTogglePartyFill)
			f65_arg0.MapVote:completeAnimation()
			f65_arg0.MapVote:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.MapVote)
			f65_arg0.MapVotePC:completeAnimation()
			f65_arg0.MapVotePC:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.MapVotePC)
			f65_arg0.MapVoteZM:completeAnimation()
			f65_arg0.MapVoteZM:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.MapVoteZM)
			f65_arg0.MapAndGameType:completeAnimation()
			f65_arg0.MapAndGameType:setAlpha(0)
			f65_arg0.clipFinished(f65_arg0.MapAndGameType)
		end,
	},
	Zombies_isPC = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(9)
			f66_arg0.WarzoneHostPlayButton:completeAnimation()
			f66_arg0.WarzoneHostPlayButton:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.WarzoneHostPlayButton)
			f66_arg0.DirectorTogglePartyFill:completeAnimation()
			f66_arg0.DirectorTogglePartyFill:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.DirectorTogglePartyFill)
			f66_arg0.MapVote:completeAnimation()
			f66_arg0.MapVote:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.MapVote)
			f66_arg0.MapVotePC:completeAnimation()
			f66_arg0.MapVotePC:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.MapVotePC)
			f66_arg0.MapVoteZM:completeAnimation()
			f66_arg0.MapVoteZM:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.MapVoteZM)
			f66_arg0.MapAndGameType:completeAnimation()
			f66_arg0.MapAndGameType:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.MapAndGameType)
			f66_arg0.DirectorReadyButton:completeAnimation()
			f66_arg0.DirectorReadyButton:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.DirectorReadyButton)
			f66_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f66_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f66_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.DirectorLobbyPoseMembersZM)
			f66_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f66_arg0.ZMLoadoutPreviewInfo:setLeftRight(0.5, 0.5, -769, 491)
			f66_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.ZMLoadoutPreviewInfo)
			f66_arg0.TrialCountdown:completeAnimation()
			f66_arg0.TrialCountdown:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.TrialCountdown)
		end,
	},
	Zombies = {
		DefaultClip = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(9)
			f67_arg0.WarzoneHostPlayButton:completeAnimation()
			f67_arg0.WarzoneHostPlayButton:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.WarzoneHostPlayButton)
			f67_arg0.DirectorTogglePartyFill:completeAnimation()
			f67_arg0.DirectorTogglePartyFill:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.DirectorTogglePartyFill)
			f67_arg0.MapVote:completeAnimation()
			f67_arg0.MapVote:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.MapVote)
			f67_arg0.MapVotePC:completeAnimation()
			f67_arg0.MapVotePC:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.MapVotePC)
			f67_arg0.MapVoteZM:completeAnimation()
			f67_arg0.MapVoteZM:setAlpha(1)
			f67_arg0.clipFinished(f67_arg0.MapVoteZM)
			f67_arg0.MapAndGameType:completeAnimation()
			f67_arg0.MapAndGameType:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.MapAndGameType)
			f67_arg0.DirectorReadyButton:completeAnimation()
			f67_arg0.DirectorReadyButton:setAlpha(1)
			f67_arg0.clipFinished(f67_arg0.DirectorReadyButton)
			f67_arg0.DirectorLobbyPoseMembersZM:completeAnimation()
			f67_arg0.DirectorLobbyPoseMembersZM.ZMLoadoutPreviewFrame.ZMLoadoutPreviewFrame:completeAnimation()
			f67_arg0.DirectorLobbyPoseMembersZM:setAlpha(1)
			f67_arg0.clipFinished(f67_arg0.DirectorLobbyPoseMembersZM)
			f67_arg0.ZMLoadoutPreviewInfo:completeAnimation()
			f67_arg0.ZMLoadoutPreviewInfo:setAlpha(1)
			f67_arg0.clipFinished(f67_arg0.ZMLoadoutPreviewInfo)
			f67_arg0.TrialCountdown:completeAnimation()
			f67_arg0.TrialCountdown:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.TrialCountdown)
		end,
	},
	NotWarzone_isPC = {
		DefaultClip = function(f68_arg0, f68_arg1)
			f68_arg0:__resetProperties()
			f68_arg0:setupElementClipCounter(6)
			f68_arg0.WarzoneHostPlayButton:completeAnimation()
			f68_arg0.WarzoneHostPlayButton:setAlpha(0)
			f68_arg0.clipFinished(f68_arg0.WarzoneHostPlayButton)
			f68_arg0.DirectorTogglePartyFill:completeAnimation()
			f68_arg0.DirectorTogglePartyFill:setAlpha(0)
			f68_arg0.clipFinished(f68_arg0.DirectorTogglePartyFill)
			f68_arg0.MapVoteZM:completeAnimation()
			f68_arg0.MapVoteZM:setAlpha(0)
			f68_arg0.clipFinished(f68_arg0.MapVoteZM)
			f68_arg0.MapAndGameType:completeAnimation()
			f68_arg0.MapAndGameType:setAlpha(0)
			f68_arg0.clipFinished(f68_arg0.MapAndGameType)
			f68_arg0.overheadNameContainer:completeAnimation()
			f68_arg0.overheadNameContainer:setAlpha(0)
			f68_arg0.clipFinished(f68_arg0.overheadNameContainer)
			f68_arg0.TrialCountdown:completeAnimation()
			f68_arg0.TrialCountdown:setAlpha(0)
			f68_arg0.clipFinished(f68_arg0.TrialCountdown)
		end,
	},
	NotWarzone = {
		DefaultClip = function(f69_arg0, f69_arg1)
			f69_arg0:__resetProperties()
			f69_arg0:setupElementClipCounter(6)
			f69_arg0.WarzoneHostPlayButton:completeAnimation()
			f69_arg0.WarzoneHostPlayButton:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.WarzoneHostPlayButton)
			f69_arg0.DirectorTogglePartyFill:completeAnimation()
			f69_arg0.DirectorTogglePartyFill:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.DirectorTogglePartyFill)
			f69_arg0.MapVoteZM:completeAnimation()
			f69_arg0.MapVoteZM:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.MapVoteZM)
			f69_arg0.MapAndGameType:completeAnimation()
			f69_arg0.MapAndGameType:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.MapAndGameType)
			f69_arg0.overheadNameContainer:completeAnimation()
			f69_arg0.overheadNameContainer:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.overheadNameContainer)
			f69_arg0.TrialCountdown:completeAnimation()
			f69_arg0.TrialCountdown:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.TrialCountdown)
		end,
	},
}
CoD.directorPublic.__onClose = function(f70_arg0)
	f70_arg0.HeaderWZ:close()
	f70_arg0.HeaderWZDeploying:close()
	f70_arg0.HeaderMP:close()
	f70_arg0.WarzoneHostPlayButton:close()
	f70_arg0.WarzoneClientPlayButton:close()
	f70_arg0.DirectorTogglePartyFill:close()
	f70_arg0.CustomGamesButton:close()
	f70_arg0.DirectorWarningMessage:close()
	f70_arg0.TopBar:close()
	f70_arg0.MapVote:close()
	f70_arg0.MapVotePC:close()
	f70_arg0.MapVoteZM:close()
	f70_arg0.MapAndGameType:close()
	f70_arg0.DirectorReadyButton:close()
	f70_arg0.DirectorLobbyPoseMembers:close()
	f70_arg0.DirectorLobbyPoseMembersZM:close()
	f70_arg0.overheadNameContainer:close()
	f70_arg0.ZMLoadoutPreviewInfo:close()
	f70_arg0.TrialCountdown:close()
end
