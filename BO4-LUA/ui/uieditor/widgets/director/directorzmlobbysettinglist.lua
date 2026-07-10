require("x64:c89d021ac8b3747")
CoD.DirectorZMLobbySettingList = InheritFrom(LUI.UIElement)
CoD.DirectorZMLobbySettingList.__defaultWidth = 382
CoD.DirectorZMLobbySettingList.__defaultHeight = 120
CoD.DirectorZMLobbySettingList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorZMLobbySettingList)
	self.id = "DirectorZMLobbySettingList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomLobbySettings = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 64, 120)
	DirectorCustomLobbySettings:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	DirectorCustomLobbySettings:appendEventHandler("on_session_start", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorCustomLobbySettings, f3_arg1)
	end)
	DirectorCustomLobbySettings:appendEventHandler("on_session_end", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorCustomLobbySettings, f4_arg1)
	end)
	local RemoveBotButton = DirectorCustomLobbySettings
	local AddBotButton = DirectorCustomLobbySettings.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local4["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(DirectorCustomLobbySettings, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	RemoveBotButton = DirectorCustomLobbySettings
	AddBotButton = DirectorCustomLobbySettings.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local4["lobbyRoot.gameClient.update"], function(f6_arg0)
		f1_arg0:updateElementState(DirectorCustomLobbySettings, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	RemoveBotButton = DirectorCustomLobbySettings
	AddBotButton = DirectorCustomLobbySettings.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local4["lobbyRoot.privateClient.update"], function(f7_arg0)
		f1_arg0:updateElementState(DirectorCustomLobbySettings, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	RemoveBotButton = DirectorCustomLobbySettings
	AddBotButton = DirectorCustomLobbySettings.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local4.offlineScreenState, function(f8_arg0)
		f1_arg0:updateElementState(DirectorCustomLobbySettings, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	DirectorCustomLobbySettings.DirectorSelectButtonMiniInternal.MiddleText:setText(Engine[0xF9F1239CFD921FE](0xBB7AA7A26F39DFA))
	DirectorCustomLobbySettings.DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	DirectorCustomLobbySettings.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(Engine[0xF9F1239CFD921FE](0xBB7AA7A26F39DFA))
	DirectorCustomLobbySettings.DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	DirectorCustomLobbySettings:appendEventHandler("on_session_start", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f9_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DirectorCustomLobbySettings:appendEventHandler("on_session_end", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f10_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	RemoveBotButton = DirectorCustomLobbySettings
	AddBotButton = DirectorCustomLobbySettings.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local4["lobbyRoot.lobbyNav"], function(f11_arg0, f11_arg1)
		CoD.Menu.UpdateButtonShownState(f11_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RemoveBotButton = DirectorCustomLobbySettings
	AddBotButton = DirectorCustomLobbySettings.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local4["lobbyRoot.gameClient.update"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RemoveBotButton = DirectorCustomLobbySettings
	AddBotButton = DirectorCustomLobbySettings.subscribeToModel
	f1_local4 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local4["lobbyRoot.privateClient.update"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorCustomLobbySettings:appendEventHandler("input_source_changed", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f14_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	RemoveBotButton = DirectorCustomLobbySettings
	AddBotButton = DirectorCustomLobbySettings.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	AddBotButton(RemoveBotButton, f1_local4.LastInput, function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorCustomLobbySettings:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorCustomLobbySettings, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.LobbyUtility.OpenEditGameRules(self, controller)
			return true
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.LobbyUtility.OpenEditGameRules(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and IsMouseOrKeyboard(controller) and CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x61333AE050EC552, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(DirectorCustomLobbySettings)
	self.DirectorCustomLobbySettings = DirectorCustomLobbySettings
	AddBotButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0, 0.5, 0, -4, 0, 0, 0, 56)
	AddBotButton:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return IsLobbyHostOfCurrentMenu() and not CoD.LobbyUtility.CanAddMoreBotsToLobby()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.GameTypeAllowsBots() and IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	AddBotButton:appendEventHandler("on_session_start", function(f21_arg0, f21_arg1)
		f21_arg1.menu = f21_arg1.menu or f1_arg0
		f1_arg0:updateElementState(AddBotButton, f21_arg1)
	end)
	AddBotButton:appendEventHandler("on_session_end", function(f22_arg0, f22_arg1)
		f22_arg1.menu = f22_arg1.menu or f1_arg0
		f1_arg0:updateElementState(AddBotButton, f22_arg1)
	end)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f23_arg0)
		f1_arg0:updateElementState(AddBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["lobbyRoot.gameClient.update"], function(f24_arg0)
		f1_arg0:updateElementState(AddBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["lobbyRoot.privateClient.update"], function(f25_arg0)
		f1_arg0:updateElementState(AddBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["PartyPrivacy.maxPlayers"], function(f26_arg0)
		f1_arg0:updateElementState(AddBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "PartyPrivacy.maxPlayers",
		})
	end, false)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5.offlineScreenState, function(f27_arg0)
		f1_arg0:updateElementState(AddBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["MapVote.mapVoteGameModeNext"], function(f28_arg0)
		f1_arg0:updateElementState(AddBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "MapVote.mapVoteGameModeNext",
		})
	end, false)
	AddBotButton.DirectorSelectButtonMiniInternal.MiddleText:setText(Engine[0xF9F1239CFD921FE](0x41A80D9A928673E))
	AddBotButton.DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	AddBotButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(Engine[0xF9F1239CFD921FE](0x41A80D9A928673E))
	AddBotButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	AddBotButton:appendEventHandler("on_session_start", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AddBotButton:appendEventHandler("on_session_end", function(f30_arg0, f30_arg1)
		f30_arg1.menu = f30_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f30_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f31_arg0, f31_arg1)
		CoD.Menu.UpdateButtonShownState(f31_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["lobbyRoot.gameClient.update"], function(f32_arg0, f32_arg1)
		CoD.Menu.UpdateButtonShownState(f32_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["lobbyRoot.privateClient.update"], function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AddBotButton:appendEventHandler("input_source_changed", function(f34_arg0, f34_arg1)
		f34_arg1.menu = f34_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f34_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	RemoveBotButton(f1_local4, f1_local5.LastInput, function(f35_arg0, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local4 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local4, f1_local5["PartyPrivacy.maxPlayers"], function(f36_arg0, f36_arg1)
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AddBotButton:registerEventHandler("gain_focus", function(element, event)
		local f37_local0 = nil
		if element.gainFocus then
			f37_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f37_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f37_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AddBotButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") and IsMouseOrKeyboard(controller) and CoD.LobbyUtility.CanAddMoreBotsToLobby() then
			PlaySoundAlias("uin_toggle_generic")
			AddLobbyBots(menu, controller)
			return true
		elseif IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") and CoD.LobbyUtility.CanAddMoreBotsToLobby() then
			PlaySoundAlias("uin_toggle_generic")
			AddLobbyBots(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") and IsMouseOrKeyboard(controller) and CoD.LobbyUtility.CanAddMoreBotsToLobby() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") and CoD.LobbyUtility.CanAddMoreBotsToLobby() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x61333AE050EC552, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(AddBotButton)
	self.AddBotButton = AddBotButton
	RemoveBotButton = CoD.DirectorPreGameButtonOption.new(f1_arg0, f1_arg1, 0.5, 1, 6, 2, 0, 0, 0, 56)
	RemoveBotButton:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.GameTypeAllowsBots() and IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	RemoveBotButton:appendEventHandler("on_session_start", function(f41_arg0, f41_arg1)
		f41_arg1.menu = f41_arg1.menu or f1_arg0
		f1_arg0:updateElementState(RemoveBotButton, f41_arg1)
	end)
	RemoveBotButton:appendEventHandler("on_session_end", function(f42_arg0, f42_arg1)
		f42_arg1.menu = f42_arg1.menu or f1_arg0
		f1_arg0:updateElementState(RemoveBotButton, f42_arg1)
	end)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.lobbyNav"], function(f43_arg0)
		f1_arg0:updateElementState(RemoveBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.gameClient.update"], function(f44_arg0)
		f1_arg0:updateElementState(RemoveBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.privateClient.update"], function(f45_arg0)
		f1_arg0:updateElementState(RemoveBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6.offlineScreenState, function(f46_arg0)
		f1_arg0:updateElementState(RemoveBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "offlineScreenState",
		})
	end, false)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["MapVote.mapVoteGameModeNext"], function(f47_arg0)
		f1_arg0:updateElementState(RemoveBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "MapVote.mapVoteGameModeNext",
		})
	end, false)
	RemoveBotButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0xFD88DBB329D1EC9))
	RemoveBotButton.DirectorSelectButtonMiniInternal.MiddleText:setTTF("ttmussels_regular")
	RemoveBotButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0xFD88DBB329D1EC9))
	RemoveBotButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	RemoveBotButton:appendEventHandler("on_session_start", function(f48_arg0, f48_arg1)
		f48_arg1.menu = f48_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f48_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	RemoveBotButton:appendEventHandler("on_session_end", function(f49_arg0, f49_arg1)
		f49_arg1.menu = f49_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f49_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.lobbyNav"], function(f50_arg0, f50_arg1)
		CoD.Menu.UpdateButtonShownState(f50_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.gameClient.update"], function(f51_arg0, f51_arg1)
		CoD.Menu.UpdateButtonShownState(f51_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local5, f1_local6["lobbyRoot.privateClient.update"], function(f52_arg0, f52_arg1)
		CoD.Menu.UpdateButtonShownState(f52_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RemoveBotButton:appendEventHandler("input_source_changed", function(f53_arg0, f53_arg1)
		f53_arg1.menu = f53_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f53_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local5 = RemoveBotButton
	f1_local4 = RemoveBotButton.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local5, f1_local6.LastInput, function(f54_arg0, f54_arg1)
		CoD.Menu.UpdateButtonShownState(f54_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RemoveBotButton:registerEventHandler("gain_focus", function(element, event)
		local f55_local0 = nil
		if element.gainFocus then
			f55_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f55_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f55_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RemoveBotButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") and IsMouseOrKeyboard(controller) then
			PlaySoundAlias("uin_toggle_generic")
			RemoveLobbyBots(self, element, controller, "", menu)
			return true
		elseif IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") then
			PlaySoundAlias("uin_toggle_generic")
			RemoveLobbyBots(self, element, controller, "", menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x61333AE050EC552, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(RemoveBotButton)
	self.RemoveBotButton = RemoveBotButton
	self:mergeStateConditions({
		{
			stateName = "ShowGameRules",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "ShowAddRemoveBots",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	DirectorCustomLobbySettings.id = "DirectorCustomLobbySettings"
	AddBotButton.id = "AddBotButton"
	RemoveBotButton.id = "RemoveBotButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorZMLobbySettingList.__resetProperties = function(f60_arg0)
	f60_arg0.DirectorCustomLobbySettings:completeAnimation()
	f60_arg0.RemoveBotButton:completeAnimation()
	f60_arg0.AddBotButton:completeAnimation()
	f60_arg0.DirectorCustomLobbySettings:setAlpha(1)
	f60_arg0.RemoveBotButton:setAlpha(1)
	f60_arg0.AddBotButton:setAlpha(1)
end
CoD.DirectorZMLobbySettingList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(3)
			f61_arg0.DirectorCustomLobbySettings:completeAnimation()
			f61_arg0.DirectorCustomLobbySettings:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.DirectorCustomLobbySettings)
			f61_arg0.AddBotButton:completeAnimation()
			f61_arg0.AddBotButton:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.AddBotButton)
			f61_arg0.RemoveBotButton:completeAnimation()
			f61_arg0.RemoveBotButton:setAlpha(0)
			f61_arg0.clipFinished(f61_arg0.RemoveBotButton)
		end,
	},
	ShowGameRules = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(0)
		end,
	},
	ShowAddRemoveBots = {
		DefaultClip = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(1)
			f63_arg0.DirectorCustomLobbySettings:completeAnimation()
			f63_arg0.DirectorCustomLobbySettings:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.DirectorCustomLobbySettings)
		end,
	},
}
CoD.DirectorZMLobbySettingList.__onClose = function(f64_arg0)
	f64_arg0.DirectorCustomLobbySettings:close()
	f64_arg0.AddBotButton:close()
	f64_arg0.RemoveBotButton:close()
end
