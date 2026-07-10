require("x64:7e2dfed89fa5719")
require("x64:d6ecdf7755aeddc")
require("x64:131b51676141877")
require("x64:260c7a8e3737127")
require("x64:d22d3654b78ec39")
require("x64:fda45231af81f63")
require("x64:c89d021ac8b3747")
require("x64:ea788cab9c8c2f2")
require("x64:daafb4764cb9e3")
require("x64:ac3ecac3599406b")
require("x64:2675595fa323085")
CoD.directorPregame = InheritFrom(LUI.UIElement)
CoD.directorPregame.__defaultWidth = 1920
CoD.directorPregame.__defaultHeight = 1080
CoD.directorPregame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.DirectorUtility.InitPublicLobbyModels(self, f1_arg1, f1_arg0)
	CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
	CoD.DirectorUtility.InitQuickPlayModel(f1_arg1)
	self:setClass(CoD.directorPregame)
	self.id = "directorPregame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Header = CoD.DirectorScreenHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -870, -227, 0, 0, 301, 401)
	Header:setAlpha(0)
	Header:setZoom(75)
	Header.Header:setText(LocalizeToUpperString(0x56CB4013028D74E))
	self:addElement(Header)
	self.Header = Header
	local pckeyboardNavigationRedirector2 = nil
	pckeyboardNavigationRedirector2 = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.8, 384, 384, 0.27, 0.32, 0, 0)
	self:addElement(pckeyboardNavigationRedirector2)
	self.pckeyboardNavigationRedirector2 = pckeyboardNavigationRedirector2
	local pckeyboardNavigationRedirector = nil
	pckeyboardNavigationRedirector = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.5, 0.8, 384, 384, 0.77, 0.82, 0, 0)
	self:addElement(pckeyboardNavigationRedirector)
	self.pckeyboardNavigationRedirector = pckeyboardNavigationRedirector
	local ZMLobbyButtons = CoD.ZMLobbyButtonsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 515, 896, 1, 1, -178, -108)
	ZMLobbyButtons:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	ZMLobbyButtons:appendEventHandler("on_session_start", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ZMLobbyButtons, f3_arg1)
	end)
	ZMLobbyButtons:appendEventHandler("on_session_end", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ZMLobbyButtons, f4_arg1)
	end)
	local FindMatchMissingDLCErrorTriangle = ZMLobbyButtons
	local FindMatchButton = ZMLobbyButtons.subscribeToModel
	local CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	FindMatchButton(FindMatchMissingDLCErrorTriangle, CustomGamesButton["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(ZMLobbyButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	FindMatchMissingDLCErrorTriangle = ZMLobbyButtons
	FindMatchButton = ZMLobbyButtons.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	FindMatchButton(FindMatchMissingDLCErrorTriangle, CustomGamesButton["lobbyRoot.gameClient.update"], function(f6_arg0)
		f1_arg0:updateElementState(ZMLobbyButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	FindMatchMissingDLCErrorTriangle = ZMLobbyButtons
	FindMatchButton = ZMLobbyButtons.subscribeToModel
	CustomGamesButton = Engine[0x8DF2E5447F384B9]()
	FindMatchButton(FindMatchMissingDLCErrorTriangle, CustomGamesButton["lobbyRoot.privateClient.update"], function(f7_arg0)
		f1_arg0:updateElementState(ZMLobbyButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	FindMatchMissingDLCErrorTriangle = ZMLobbyButtons
	FindMatchButton = ZMLobbyButtons.subscribeToModel
	CustomGamesButton = DataSources.ZMLobbyExclusions.getModel(f1_arg1)
	FindMatchButton(FindMatchMissingDLCErrorTriangle, CustomGamesButton.PublicMatchExcluded, function(f8_arg0)
		f1_arg0:updateElementState(ZMLobbyButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "PublicMatchExcluded",
		})
	end, false)
	FindMatchMissingDLCErrorTriangle = ZMLobbyButtons
	FindMatchButton = ZMLobbyButtons.subscribeToModel
	CustomGamesButton = DataSources.ZMLobbyExclusions.getModel(f1_arg1)
	FindMatchButton(FindMatchMissingDLCErrorTriangle, CustomGamesButton.PrivateMatchExcluded, function(f9_arg0)
		f1_arg0:updateElementState(ZMLobbyButtons, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "PrivateMatchExcluded",
		})
	end, false)
	ZMLobbyButtons:setAlpha(0)
	ZMLobbyButtons:subscribeToGlobalModel(f1_arg1, "ZMLobbyExclusions", nil, function(model)
		ZMLobbyButtons:setModel(model, f1_arg1)
	end)
	self:addElement(ZMLobbyButtons)
	self.ZMLobbyButtons = ZMLobbyButtons
	FindMatchButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -178, -108)
	FindMatchButton:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.ShouldLockFindMatchButton(f1_arg1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	local DirectorLobbyPoseMembers = DataSources.LobbyRoot.getModel(f1_arg1)
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers.playlistId, function(f13_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "playlistId",
		})
	end, false)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = DataSources.LobbyRoot.getModel(f1_arg1)
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers["privateClient.count"], function(f14_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "privateClient.count",
		})
	end, false)
	FindMatchButton:appendEventHandler("on_session_start", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FindMatchButton, f15_arg1)
	end)
	FindMatchButton:appendEventHandler("on_session_end", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(FindMatchButton, f16_arg1)
	end)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = Engine[0x8DF2E5447F384B9]()
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers["lobbyRoot.lobbyNav"], function(f17_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = Engine[0x8DF2E5447F384B9]()
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers["lobbyRoot.gameClient.update"], function(f18_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = Engine[0x8DF2E5447F384B9]()
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers["lobbyRoot.privateClient.update"], function(f19_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = Engine[0x8DF2E5447F384B9]()
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers.offlineScreenState, function(f20_arg0)
		f1_arg0:updateElementState(FindMatchButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	FindMatchButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0xA14B986BB3C650A))
	FindMatchButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0xA14B986BB3C650A))
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = Engine[0x8DF2E5447F384B9]()
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers["lobbyRoot.lobbyNav"], function(f21_arg0, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = Engine[0x8DF2E5447F384B9]()
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers["lobbyRoot.playlistId"], function(f22_arg0, f22_arg1)
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = Engine[0x8DF2E5447F384B9]()
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers["lobbyRoot.lobbyList.playerCount"], function(f23_arg0, f23_arg1)
		CoD.Menu.UpdateButtonShownState(f23_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = DataSources.LobbyRoot.getModel(f1_arg1)
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers.playlistId, function(f24_arg0, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamesButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = FindMatchButton.subscribeToModel
	DirectorLobbyPoseMembers = DataSources.LobbyRoot.getModel(f1_arg1)
	FindMatchMissingDLCErrorTriangle(CustomGamesButton, DirectorLobbyPoseMembers["privateClient.count"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	FindMatchButton:registerEventHandler("gain_focus", function(element, event)
		local f26_local0 = nil
		if element.gainFocus then
			f26_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f26_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f26_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FindMatchButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsZombies() and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and not CoD.DirectorUtility.ShouldLockFindMatchButton(controller) then
			CoD.DirectorUtility.NavigateToPublicLobbyForCurrentMenuMode(menu, controller)
			PlaySoundAlias("uin_press_generic")
			return true
		elseif not IsZombies() and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.DirectorUtility.OpenTooManyClientsPopup(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsZombies() and not CoD.DirectorUtility.IsNumClientsExceeded(controller) and not CoD.DirectorUtility.ShouldLockFindMatchButton(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif not IsZombies() and CoD.DirectorUtility.IsNumClientsExceeded(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(FindMatchButton)
	self.FindMatchButton = FindMatchButton
	FindMatchMissingDLCErrorTriangle = CoD.ErrorTriangle.new(f1_arg0, f1_arg1, 0.5, 0.5, 516, 894, 1, 1, -133, -108)
	FindMatchMissingDLCErrorTriangle:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.ShouldShowFindMatchError(f1_arg1)
			end,
		},
	})
	DirectorLobbyPoseMembers = FindMatchMissingDLCErrorTriangle
	CustomGamesButton = FindMatchMissingDLCErrorTriangle.subscribeToModel
	local CommonHeader = DataSources.LobbyRoot.getModel(f1_arg1)
	CustomGamesButton(DirectorLobbyPoseMembers, CommonHeader.playlistId, function(f30_arg0)
		f1_arg0:updateElementState(FindMatchMissingDLCErrorTriangle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "playlistId",
		})
	end, false)
	DirectorLobbyPoseMembers = FindMatchMissingDLCErrorTriangle
	CustomGamesButton = FindMatchMissingDLCErrorTriangle.subscribeToModel
	CommonHeader = DataSources.LobbyRoot.getModel(f1_arg1)
	CustomGamesButton(DirectorLobbyPoseMembers, CommonHeader["privateClient.count"], function(f31_arg0)
		f1_arg0:updateElementState(FindMatchMissingDLCErrorTriangle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "privateClient.count",
		})
	end, false)
	self:addElement(FindMatchMissingDLCErrorTriangle)
	self.FindMatchMissingDLCErrorTriangle = FindMatchMissingDLCErrorTriangle
	CustomGamesButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -433, -387)
	CustomGamesButton:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f32_local0 = IsLobbyHostOfCurrentMenu()
				if f32_local0 then
					if not IsPublicOrLeagueGame(f1_arg1) then
						f32_local0 = CoD.DirectorUtility.ShowCustomGameButtonForCurrentLobby(f1_arg1)
					else
						f32_local0 = false
					end
				end
				return f32_local0
			end,
		},
	})
	CustomGamesButton:appendEventHandler("on_session_start", function(f33_arg0, f33_arg1)
		f33_arg1.menu = f33_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CustomGamesButton, f33_arg1)
	end)
	CustomGamesButton:appendEventHandler("on_session_end", function(f34_arg0, f34_arg1)
		f34_arg1.menu = f34_arg1.menu or f1_arg0
		f1_arg0:updateElementState(CustomGamesButton, f34_arg1)
	end)
	CommonHeader = CustomGamesButton
	DirectorLobbyPoseMembers = CustomGamesButton.subscribeToModel
	local DirectorLeaderActivitySelect = Engine[0x8DF2E5447F384B9]()
	DirectorLobbyPoseMembers(CommonHeader, DirectorLeaderActivitySelect["lobbyRoot.lobbyNav"], function(f35_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CommonHeader = CustomGamesButton
	DirectorLobbyPoseMembers = CustomGamesButton.subscribeToModel
	DirectorLeaderActivitySelect = Engine[0x8DF2E5447F384B9]()
	DirectorLobbyPoseMembers(CommonHeader, DirectorLeaderActivitySelect["lobbyRoot.gameClient.update"], function(f36_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	CommonHeader = CustomGamesButton
	DirectorLobbyPoseMembers = CustomGamesButton.subscribeToModel
	DirectorLeaderActivitySelect = Engine[0x8DF2E5447F384B9]()
	DirectorLobbyPoseMembers(CommonHeader, DirectorLeaderActivitySelect["lobbyRoot.privateClient.update"], function(f37_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	CommonHeader = CustomGamesButton
	DirectorLobbyPoseMembers = CustomGamesButton.subscribeToModel
	DirectorLeaderActivitySelect = Engine[0x8DF2E5447F384B9]()
	DirectorLobbyPoseMembers(CommonHeader, DirectorLeaderActivitySelect.offlineScreenState, function(f38_arg0)
		f1_arg0:updateElementState(CustomGamesButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
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
	CommonHeader = CustomGamesButton
	DirectorLobbyPoseMembers = CustomGamesButton.subscribeToModel
	DirectorLeaderActivitySelect = Engine[0x8DF2E5447F384B9]()
	DirectorLobbyPoseMembers(CommonHeader, DirectorLeaderActivitySelect["lobbyRoot.lobbyNav"], function(f41_arg0, f41_arg1)
		CoD.Menu.UpdateButtonShownState(f41_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	CustomGamesButton:registerEventHandler("gain_focus", function(element, event)
		local f42_local0 = nil
		if element.gainFocus then
			f42_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f42_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f42_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CustomGamesButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsZombies() and IsPC() then
			PlaySoundAlias("uin_press_generic")
			CoD.DirectorUtility.NavigateToCustomLobbyForCurrentMode(menu, controller)
			SetLoseFocusToSelf(self, controller)
			return true
		elseif IsZombies() then
			PlaySoundAlias("uin_press_generic")
			OpenSystemOverlay(self, menu, controller, "CustomMutationsNotification")
			SetLoseFocusToSelf(self, controller)
			return true
		elseif IsPC() and not IsZombies() then
			PlaySoundAlias("uin_press_generic")
			OpenCustomGamesLobby(menu, controller)
			return true
		elseif not IsZombies() then
			PlaySoundAlias("uin_press_generic")
			OpenSystemOverlay(self, menu, controller, "CustomGamesNotification")
			SetLoseFocusToSelf(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsZombies() and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsZombies() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif IsPC() and not IsZombies() then
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
	DirectorLobbyPoseMembers = CoD.DirectorLobbyPoseMembers.new(f1_arg0, f1_arg1, 0.5, 1.5, -960, -960, 0, 1, 0, 0)
	self:addElement(DirectorLobbyPoseMembers)
	self.DirectorLobbyPoseMembers = DirectorLobbyPoseMembers
	CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 67)
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyMainMode", function(model)
		local f45_local0 = model:get()
		if f45_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f45_local0)))
		end
	end)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f46_local0 = model:get()
		if f46_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f46_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	DirectorLeaderActivitySelect = CoD.DirectorLeaderActivitySelect.new(f1_arg0, f1_arg1, 0.5, 0.5, 625, 930, 0, 0, 8, 57)
	DirectorLeaderActivitySelect:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	DirectorLeaderActivitySelect:appendEventHandler("on_session_start", function(f48_arg0, f48_arg1)
		f48_arg1.menu = f48_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, f48_arg1)
	end)
	DirectorLeaderActivitySelect:appendEventHandler("on_session_end", function(f49_arg0, f49_arg1)
		f49_arg1.menu = f49_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, f49_arg1)
	end)
	local QuickPlay = DirectorLeaderActivitySelect
	local DirectorMapGameTypeAndDifficulty = DirectorLeaderActivitySelect.subscribeToModel
	local MapAndGameType = Engine[0x8DF2E5447F384B9]()
	DirectorMapGameTypeAndDifficulty(QuickPlay, MapAndGameType["lobbyRoot.lobbyNav"], function(f50_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	QuickPlay = DirectorLeaderActivitySelect
	DirectorMapGameTypeAndDifficulty = DirectorLeaderActivitySelect.subscribeToModel
	MapAndGameType = Engine[0x8DF2E5447F384B9]()
	DirectorMapGameTypeAndDifficulty(QuickPlay, MapAndGameType["lobbyRoot.gameClient.update"], function(f51_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	QuickPlay = DirectorLeaderActivitySelect
	DirectorMapGameTypeAndDifficulty = DirectorLeaderActivitySelect.subscribeToModel
	MapAndGameType = Engine[0x8DF2E5447F384B9]()
	DirectorMapGameTypeAndDifficulty(QuickPlay, MapAndGameType["lobbyRoot.privateClient.update"], function(f52_arg0)
		f1_arg0:updateElementState(DirectorLeaderActivitySelect, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	DirectorLeaderActivitySelect:setAlpha(0)
	self:addElement(DirectorLeaderActivitySelect)
	self.DirectorLeaderActivitySelect = DirectorLeaderActivitySelect
	DirectorMapGameTypeAndDifficulty = CoD.DirectorMapGameTypeAndDifficulty.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -368, -188)
	DirectorMapGameTypeAndDifficulty:setAlpha(0)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setText(Engine[0xF9F1239CFD921FE](0xBC441E8EF98063C))
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setTTF("ttmussels_regular")
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setText(Engine[0xF9F1239CFD921FE](0xC95DCE378B96DFF))
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setTTF("ttmussels_regular")
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image = function(f53_arg0)
		local f53_local0 = f53_arg0:get()
		if f53_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage:setImage(RegisterImage(CoD.DirectorUtility.PlaylistIDToZMPlaylistImage(f53_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image_FullPath = function()
		local f54_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f54_local0 = f54_local0.playlistId
		if f54_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image(f54_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image = function(f55_arg0)
		local f55_local0 = f55_arg0:get()
		if f55_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon:setImage(RegisterImage(CoD.DirectorUtility.PlaylistIDToZMPlaylistDifficulty(f55_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath = function()
		local f56_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f56_local0 = f56_local0.playlistId
		if f56_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image(f56_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc = function(f57_arg0)
		local f57_local0 = f57_arg0:get()
		if f57_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label:setText(Engine[0xF9F1239CFD921FE](CoD.DirectorUtility.PlaylistIDToZMPlaylistSubtitle(f57_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath = function()
		local f58_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f58_local0 = f58_local0.playlistId
		if f58_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc(f58_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title = function(f59_arg0)
		local f59_local0 = f59_arg0:get()
		if f59_local0 ~= nil then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle:setText(Engine[0xF9F1239CFD921FE](CoD.DirectorUtility.PlaylistIDToZMPlaylistName(f59_local0)))
		end
	end
	DirectorMapGameTypeAndDifficulty:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title)
	DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title_FullPath = function()
		local f60_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f60_local0 = f60_local0.playlistId
		if f60_local0 then
			DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title(f60_local0)
		end
	end
	DirectorMapGameTypeAndDifficulty:appendEventHandler("on_session_start", function(f61_arg0, f61_arg1)
		f61_arg1.menu = f61_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f61_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DirectorMapGameTypeAndDifficulty:appendEventHandler("on_session_end", function(f62_arg0, f62_arg1)
		f62_arg1.menu = f62_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f62_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	MapAndGameType = DirectorMapGameTypeAndDifficulty
	QuickPlay = DirectorMapGameTypeAndDifficulty.subscribeToModel
	local f1_local14 = Engine[0x8DF2E5447F384B9]()
	QuickPlay(MapAndGameType, f1_local14["lobbyRoot.lobbyNav"], function(f63_arg0, f63_arg1)
		CoD.Menu.UpdateButtonShownState(f63_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	MapAndGameType = DirectorMapGameTypeAndDifficulty
	QuickPlay = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local14 = Engine[0x8DF2E5447F384B9]()
	QuickPlay(MapAndGameType, f1_local14["lobbyRoot.gameClient.update"], function(f64_arg0, f64_arg1)
		CoD.Menu.UpdateButtonShownState(f64_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	MapAndGameType = DirectorMapGameTypeAndDifficulty
	QuickPlay = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local14 = Engine[0x8DF2E5447F384B9]()
	QuickPlay(MapAndGameType, f1_local14["lobbyRoot.privateClient.update"], function(f65_arg0, f65_arg1)
		CoD.Menu.UpdateButtonShownState(f65_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorMapGameTypeAndDifficulty:registerEventHandler("gain_focus", function(element, event)
		local f66_local0 = nil
		if element.gainFocus then
			f66_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f66_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f66_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorMapGameTypeAndDifficulty, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and IsZombies() then
			CoD.LobbyUtility.SetLeaderActivityAndOpenOverlayNoDeps(self, controller, CoD.LobbyUtility.LeaderActivity.CHOOSING_MAP, "DirectorGamemodeSelectionZM")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and IsZombies() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(DirectorMapGameTypeAndDifficulty)
	self.DirectorMapGameTypeAndDifficulty = DirectorMapGameTypeAndDifficulty
	QuickPlay = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -512, -443)
	QuickPlay:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.lobbyList.playerCount", 1) and CoD.ModelUtility.IsGlobalModelValueTrue("ZMLobbyExclusions.ShowTutorialQuickPlay")
			end,
		},
	})
	QuickPlay:appendEventHandler("on_session_start", function(f70_arg0, f70_arg1)
		f70_arg1.menu = f70_arg1.menu or f1_arg0
		f1_arg0:updateElementState(QuickPlay, f70_arg1)
	end)
	QuickPlay:appendEventHandler("on_session_end", function(f71_arg0, f71_arg1)
		f71_arg1.menu = f71_arg1.menu or f1_arg0
		f1_arg0:updateElementState(QuickPlay, f71_arg1)
	end)
	f1_local14 = QuickPlay
	MapAndGameType = QuickPlay.subscribeToModel
	local f1_local15 = Engine[0x8DF2E5447F384B9]()
	MapAndGameType(f1_local14, f1_local15["lobbyRoot.lobbyNav"], function(f72_arg0)
		f1_arg0:updateElementState(QuickPlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f72_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local14 = QuickPlay
	MapAndGameType = QuickPlay.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	MapAndGameType(f1_local14, f1_local15["lobbyRoot.gameClient.update"], function(f73_arg0)
		f1_arg0:updateElementState(QuickPlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f73_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local14 = QuickPlay
	MapAndGameType = QuickPlay.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	MapAndGameType(f1_local14, f1_local15["lobbyRoot.privateClient.update"], function(f74_arg0)
		f1_arg0:updateElementState(QuickPlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f74_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	f1_local14 = QuickPlay
	MapAndGameType = QuickPlay.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	MapAndGameType(f1_local14, f1_local15.offlineScreenState, function(f75_arg0)
		f1_arg0:updateElementState(QuickPlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f75_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	f1_local14 = QuickPlay
	MapAndGameType = QuickPlay.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	MapAndGameType(f1_local14, f1_local15["lobbyRoot.lobbyList.playerCount"], function(f76_arg0)
		f1_arg0:updateElementState(QuickPlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f76_arg0:get(),
			modelName = "lobbyRoot.lobbyList.playerCount",
		})
	end, false)
	f1_local14 = QuickPlay
	MapAndGameType = QuickPlay.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	MapAndGameType(f1_local14, f1_local15["ZMLobbyExclusions.ShowTutorialQuickPlay"], function(f77_arg0)
		f1_arg0:updateElementState(QuickPlay, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f77_arg0:get(),
			modelName = "ZMLobbyExclusions.ShowTutorialQuickPlay",
		})
	end, false)
	QuickPlay:setAlpha(0)
	QuickPlay.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x6A52F3FB63F2F76))
	QuickPlay.DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	QuickPlay.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x6A52F3FB63F2F76))
	QuickPlay.DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	f1_local14 = QuickPlay
	MapAndGameType = QuickPlay.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	MapAndGameType(f1_local14, f1_local15["lobbyRoot.lobbyList.playerCount"], function(f78_arg0, f78_arg1)
		CoD.Menu.UpdateButtonShownState(f78_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local14 = QuickPlay
	MapAndGameType = QuickPlay.subscribeToModel
	f1_local15 = Engine[0x8DF2E5447F384B9]()
	MapAndGameType(f1_local14, f1_local15["ZMLobbyExclusions.ShowTutorialQuickPlay"], function(f79_arg0, f79_arg1)
		CoD.Menu.UpdateButtonShownState(f79_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	QuickPlay:registerEventHandler("gain_focus", function(element, event)
		local f80_local0 = nil
		if element.gainFocus then
			f80_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f80_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f80_local0
	end)
	f1_arg0:AddButtonCallbackFunction(QuickPlay, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.lobbyList.playerCount", 1) and CoD.ModelUtility.IsGlobalModelValueTrue("ZMLobbyExclusions.ShowTutorialQuickPlay") then
			PlaySoundAlias("uin_toggle_generic")
			CoD.ZombieUtility.QuickPlayPregame(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.lobbyList.playerCount", 1) and CoD.ModelUtility.IsGlobalModelValueTrue("ZMLobbyExclusions.ShowTutorialQuickPlay") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xAC3B80C833B60E1, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(QuickPlay)
	self.QuickPlay = QuickPlay
	MapAndGameType = CoD.DirectorMapAndGameTypeContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 514, 896, 1, 1, -368, -188)
	MapAndGameType:setAlpha(0)
	MapAndGameType.DirectorMapAndGameInternal.GamemodeIcon:setImage(RegisterImage(0x7615068F50B3D66))
	MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label:setText(Engine[0xF9F1239CFD921FE](0x2C79EA24AB1A2BA))
	MapAndGameType.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setText(Engine[0xF9F1239CFD921FE](0x890976738B1D859))
	MapAndGameType.DirectorMapAndGameInternal.PlaylistHeader.GameModeText:setTTF("ttmussels_regular")
	MapAndGameType.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setText(Engine[0xF9F1239CFD921FE](0x890976738B1D859))
	MapAndGameType.DirectorMapAndGameInternal.PlaylistHeaderNonHost.GameModeText:setTTF("ttmussels_regular")
	MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image = function(f83_arg0)
		local f83_local0 = f83_arg0:get()
		if f83_local0 ~= nil then
			MapAndGameType.DirectorMapAndGameInternal.MapImage:setImage(RegisterImage(CoD.DirectorUtility.PlaylistIDToPlaylistImageTileSideInfo(f83_local0)))
		end
	end
	MapAndGameType:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image)
	MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image_FullPath = function()
		local f84_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f84_local0 = f84_local0.playlistId
		if f84_local0 then
			MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image(f84_local0)
		end
	end
	MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title = function(f85_arg0)
		local f85_local0 = f85_arg0:get()
		if f85_local0 ~= nil then
			MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.PlaylistIDToPlaylistName(f85_local0)))
		end
	end
	MapAndGameType:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title)
	MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title_FullPath = function()
		local f86_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f86_local0 = f86_local0.playlistId
		if f86_local0 then
			MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title(f86_local0)
		end
	end
	f1_local15 = MapAndGameType
	f1_local14 = MapAndGameType.subscribeToModel
	local f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNav"], function(f87_arg0, f87_arg1)
		CoD.Menu.UpdateButtonShownState(f87_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local15 = MapAndGameType
	f1_local14 = MapAndGameType.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.privateClient.isHost"], function(f88_arg0, f88_arg1)
		CoD.Menu.UpdateButtonShownState(f88_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local15 = MapAndGameType
	f1_local14 = MapAndGameType.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.gameClient.isHost"], function(f89_arg0, f89_arg1)
		CoD.Menu.UpdateButtonShownState(f89_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	MapAndGameType:registerEventHandler("gain_focus", function(element, event)
		local f90_local0 = nil
		if element.gainFocus then
			f90_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f90_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f90_local0
	end)
	f1_arg0:AddButtonCallbackFunction(MapAndGameType, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsZombies() and IsPartyLeader(controller) then
			CoD.DirectorUtility.DirectorOpenOverlayWithCurrentMenuMode(menu, controller, "DirectorFindGame")
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
	f1_local15 = CustomGamesButton
	f1_local14 = CustomGamesButton.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNav"], CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleText.__MiddleText_StringReference)
	f1_local15 = CustomGamesButton
	f1_local14 = CustomGamesButton.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNav"], CustomGamesButton.DirectorSelectButtonMiniInternal.MiddleTextFocus.__MiddleTextFocus_String)
	f1_local15 = DirectorMapGameTypeAndDifficulty
	f1_local14 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNetworkMode"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image_FullPath)
	f1_local15 = DirectorMapGameTypeAndDifficulty
	f1_local14 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNetworkMode"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.GamemodeIcon.__GamemodeIcon_Image_FullPath)
	f1_local15 = DirectorMapGameTypeAndDifficulty
	f1_local14 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNetworkMode"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.Label.__Label_Desc_FullPath)
	f1_local15 = DirectorMapGameTypeAndDifficulty
	f1_local14 = DirectorMapGameTypeAndDifficulty.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNetworkMode"], DirectorMapGameTypeAndDifficulty.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title_FullPath)
	f1_local15 = MapAndGameType
	f1_local14 = MapAndGameType.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNetworkMode"], MapAndGameType.DirectorMapAndGameInternal.MapImage.__DirectorMapAndGameInternal_MapImage_Image_FullPath)
	f1_local15 = MapAndGameType
	f1_local14 = MapAndGameType.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNetworkMode"], MapAndGameType.DirectorMapAndGameInternal.DirectorMapAndGameTypeInternalTitles.SubTitle.__Label_Title_FullPath)
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
			stateName = "IsPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local15 = self
	f1_local14 = self.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local14(f1_local15, f1_local16["lobbyRoot.lobbyNav"], function(f96_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f96_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f97_arg2, f97_arg3, f97_arg4)
		if IsZombies() and IsLobbyHostOfCurrentMenu() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.ZMLobbyButtons)
			ForceCheckDefaultPCFocus(element, f1_arg0, controller)
		elseif IsLobbyHostOfCurrentMenu() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.FindMatchButton)
			ForceCheckDefaultPCFocus(element, f1_arg0, controller)
		elseif not IsLobbyHostOfCurrentMenu() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.HomeOrPlayList)
			ForceCheckDefaultPCFocus(element, f1_arg0, controller)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "gameClientDataUpdate", function(model)
		local f98_local0 = self
		if CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "CharacterSelection", "clientUpdated", function(model)
		local f99_local0 = self
		if CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyNav", function(model)
		local f100_local0 = self
		if CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsLobbyHostOfCurrentMenu() then
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.HomeOrPlayList)
			SetFocusToElement(self, "HomeOrPlayList", f1_arg1)
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
		elseif CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.lastNavigationAction", LuaEnum.UI.DIRECTOR_ONLINE_MP_PREGAME) and IsLobbyHostOfCurrentMenu() then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
			CoD.BaseUtility.SetDefaultFocusToElement(self, self.FindMatchButton)
		elseif CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f1_arg1)
			CoD.FreeCursorUtility.RetriggerCursorPosition(f1_arg0, f1_arg1)
		end
	end)
	if CoD.isPC then
		pckeyboardNavigationRedirector2.id = "pckeyboardNavigationRedirector2"
	end
	if CoD.isPC then
		pckeyboardNavigationRedirector.id = "pckeyboardNavigationRedirector"
	end
	ZMLobbyButtons.id = "ZMLobbyButtons"
	FindMatchButton.id = "FindMatchButton"
	CustomGamesButton.id = "CustomGamesButton"
	DirectorMapGameTypeAndDifficulty.id = "DirectorMapGameTypeAndDifficulty"
	QuickPlay.id = "QuickPlay"
	MapAndGameType.id = "MapAndGameType"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local14 = self
	f1_local14 = pckeyboardNavigationRedirector2
	if IsPC() then
		CoD.PCUtility.SetAsRedirectItem(f1_local14)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local14, self.Loadouts)
	end
	f1_local14 = pckeyboardNavigationRedirector
	if IsPC() then
		CoD.PCUtility.SetAsRedirectItem(f1_local14)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local14, self.Loadouts)
	end
	return self
end
CoD.directorPregame.__resetProperties = function(f101_arg0)
	f101_arg0.MapAndGameType:completeAnimation()
	f101_arg0.FindMatchButton:completeAnimation()
	f101_arg0.ZMLobbyButtons:completeAnimation()
	f101_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
	f101_arg0.DirectorLobbyPoseMembers:completeAnimation()
	f101_arg0.QuickPlay:completeAnimation()
	f101_arg0.MapAndGameType:setAlpha(0)
	f101_arg0.FindMatchButton:setAlpha(1)
	f101_arg0.ZMLobbyButtons:setAlpha(0)
	f101_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(0)
	f101_arg0.DirectorLobbyPoseMembers:setAlpha(1)
	f101_arg0.QuickPlay:setAlpha(0)
end
CoD.directorPregame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f102_arg0, f102_arg1)
			f102_arg0:__resetProperties()
			f102_arg0:setupElementClipCounter(1)
			f102_arg0.MapAndGameType:completeAnimation()
			f102_arg0.MapAndGameType:setAlpha(1)
			f102_arg0.clipFinished(f102_arg0.MapAndGameType)
		end,
	},
	ZM_isPC = {
		DefaultClip = function(f103_arg0, f103_arg1)
			f103_arg0:__resetProperties()
			f103_arg0:setupElementClipCounter(5)
			f103_arg0.ZMLobbyButtons:completeAnimation()
			f103_arg0.ZMLobbyButtons:setAlpha(1)
			f103_arg0.clipFinished(f103_arg0.ZMLobbyButtons)
			f103_arg0.FindMatchButton:completeAnimation()
			f103_arg0.FindMatchButton:setAlpha(0)
			f103_arg0.clipFinished(f103_arg0.FindMatchButton)
			f103_arg0.DirectorLobbyPoseMembers:completeAnimation()
			f103_arg0.DirectorLobbyPoseMembers:setAlpha(0)
			f103_arg0.clipFinished(f103_arg0.DirectorLobbyPoseMembers)
			f103_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f103_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f103_arg0.clipFinished(f103_arg0.DirectorMapGameTypeAndDifficulty)
			f103_arg0.QuickPlay:completeAnimation()
			f103_arg0.QuickPlay:setAlpha(1)
			f103_arg0.clipFinished(f103_arg0.QuickPlay)
		end,
	},
	ZM = {
		DefaultClip = function(f104_arg0, f104_arg1)
			f104_arg0:__resetProperties()
			f104_arg0:setupElementClipCounter(5)
			f104_arg0.ZMLobbyButtons:completeAnimation()
			f104_arg0.ZMLobbyButtons:setAlpha(1)
			f104_arg0.clipFinished(f104_arg0.ZMLobbyButtons)
			f104_arg0.FindMatchButton:completeAnimation()
			f104_arg0.FindMatchButton:setAlpha(0)
			f104_arg0.clipFinished(f104_arg0.FindMatchButton)
			f104_arg0.DirectorLobbyPoseMembers:completeAnimation()
			f104_arg0.DirectorLobbyPoseMembers:setAlpha(0)
			f104_arg0.clipFinished(f104_arg0.DirectorLobbyPoseMembers)
			f104_arg0.DirectorMapGameTypeAndDifficulty:completeAnimation()
			f104_arg0.DirectorMapGameTypeAndDifficulty:setAlpha(1)
			f104_arg0.clipFinished(f104_arg0.DirectorMapGameTypeAndDifficulty)
			f104_arg0.QuickPlay:completeAnimation()
			f104_arg0.QuickPlay:setAlpha(1)
			f104_arg0.clipFinished(f104_arg0.QuickPlay)
		end,
	},
	IsPC = {
		DefaultClip = function(f105_arg0, f105_arg1)
			f105_arg0:__resetProperties()
			f105_arg0:setupElementClipCounter(1)
			f105_arg0.MapAndGameType:completeAnimation()
			f105_arg0.MapAndGameType:setAlpha(1)
			f105_arg0.clipFinished(f105_arg0.MapAndGameType)
		end,
	},
}
CoD.directorPregame.__onClose = function(f106_arg0)
	f106_arg0.Header:close()
	f106_arg0.pckeyboardNavigationRedirector2:close()
	f106_arg0.pckeyboardNavigationRedirector:close()
	f106_arg0.ZMLobbyButtons:close()
	f106_arg0.FindMatchButton:close()
	f106_arg0.FindMatchMissingDLCErrorTriangle:close()
	f106_arg0.CustomGamesButton:close()
	f106_arg0.DirectorLobbyPoseMembers:close()
	f106_arg0.CommonHeader:close()
	f106_arg0.DirectorLeaderActivitySelect:close()
	f106_arg0.DirectorMapGameTypeAndDifficulty:close()
	f106_arg0.QuickPlay:close()
	f106_arg0.MapAndGameType:close()
end
