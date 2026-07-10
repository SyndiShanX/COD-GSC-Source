require("x64:e656d7766a8b00a")
require("x64:b1c64f85af4ce49")
CoD.DirectorLobbySettingList = InheritFrom(LUI.UIElement)
CoD.DirectorLobbySettingList.__defaultWidth = 356
CoD.DirectorLobbySettingList.__defaultHeight = 200
CoD.DirectorLobbySettingList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLobbySettingList)
	self.id = "DirectorLobbySettingList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomCodcaster = CoD.DirectorConfigButton.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 40)
	DirectorCustomCodcaster:mergeStateConditions({
		{
			stateName = "invisible",
			condition = function(menu, element, event)
				return not CoD.CodCasterUtility.IsCodCasterEnabled()
			end,
		},
	})
	DirectorCustomCodcaster.ButtonName:setText(LocalizeToUpperString(0x700AE5902F5ECF7))
	DirectorCustomCodcaster:appendEventHandler("input_source_changed", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f3_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local BotSettingsButton = DirectorCustomCodcaster
	local DirectorCustomLobbySettings = DirectorCustomCodcaster.subscribeToModel
	local AddBotButton = Engine[0x4DF5CFBC1771947](f1_arg1)
	DirectorCustomLobbySettings(BotSettingsButton, AddBotButton.LastInput, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorCustomCodcaster:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorCustomCodcaster, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			SetCharacterModeToCurrentSessionMode(self, element, controller)
			CoD.DirectorUtility.ClearSelectedClient(controller)
			CoD.LobbyUtility.OpenDirectorCodcasterSettings(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
			SetCharacterModeToCurrentSessionMode(self, element, controller)
			CoD.DirectorUtility.ClearSelectedClient(controller)
			CoD.LobbyUtility.OpenDirectorCodcasterSettings(self, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x61333AE050EC552, nil, "ui_confirm")
			return true
		end
	end, false)
	self:addElement(DirectorCustomCodcaster)
	self.DirectorCustomCodcaster = DirectorCustomCodcaster
	DirectorCustomLobbySettings = CoD.DirectorConfigButton.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 48, 88)
	DirectorCustomLobbySettings:mergeStateConditions({
		{
			stateName = "invisible",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsLobbyMenu(f1_arg1, LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY)
			end,
		},
	})
	AddBotButton = DirectorCustomLobbySettings
	BotSettingsButton = DirectorCustomLobbySettings.subscribeToModel
	local RemoveBotButton = Engine[0x8DF2E5447F384B9]()
	BotSettingsButton(AddBotButton, RemoveBotButton["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(DirectorCustomLobbySettings, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorCustomLobbySettings.ButtonName:setText(LocalizeToUpperString(0xD4B192986909843))
	DirectorCustomLobbySettings:appendEventHandler("on_session_start", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f10_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	DirectorCustomLobbySettings:appendEventHandler("on_session_end", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f11_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AddBotButton = DirectorCustomLobbySettings
	BotSettingsButton = DirectorCustomLobbySettings.subscribeToModel
	RemoveBotButton = Engine[0x8DF2E5447F384B9]()
	BotSettingsButton(AddBotButton, RemoveBotButton["lobbyRoot.lobbyNav"], function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AddBotButton = DirectorCustomLobbySettings
	BotSettingsButton = DirectorCustomLobbySettings.subscribeToModel
	RemoveBotButton = Engine[0x8DF2E5447F384B9]()
	BotSettingsButton(AddBotButton, RemoveBotButton["lobbyRoot.gameClient.update"], function(f13_arg0, f13_arg1)
		CoD.Menu.UpdateButtonShownState(f13_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AddBotButton = DirectorCustomLobbySettings
	BotSettingsButton = DirectorCustomLobbySettings.subscribeToModel
	RemoveBotButton = Engine[0x8DF2E5447F384B9]()
	BotSettingsButton(AddBotButton, RemoveBotButton["lobbyRoot.privateClient.update"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorCustomLobbySettings:appendEventHandler("input_source_changed", function(f15_arg0, f15_arg1)
		f15_arg1.menu = f15_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f15_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AddBotButton = DirectorCustomLobbySettings
	BotSettingsButton = DirectorCustomLobbySettings.subscribeToModel
	RemoveBotButton = Engine[0x4DF5CFBC1771947](f1_arg1)
	BotSettingsButton(AddBotButton, RemoveBotButton.LastInput, function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	DirectorCustomLobbySettings:registerEventHandler("gain_focus", function(element, event)
		local f17_local0 = nil
		if element.gainFocus then
			f17_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f17_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f17_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorCustomLobbySettings, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			OpenPopup(self, "CustomGames_LobbySettings", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsLobbyHostOfCurrentMenu() then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			OpenPopup(self, "CustomGames_LobbySettings", controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x61333AE050EC552, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(DirectorCustomLobbySettings)
	self.DirectorCustomLobbySettings = DirectorCustomLobbySettings
	BotSettingsButton = CoD.DirectorConfigButton.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 96, 136)
	BotSettingsButton:mergeStateConditions({
		{
			stateName = "invisible",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.ShowDirectorCustomMatchBotButtons(f1_arg1)
			end,
		},
	})
	RemoveBotButton = BotSettingsButton
	AddBotButton = BotSettingsButton.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local6["lobbyRoot.lobbyNav"], function(f21_arg0)
		f1_arg0:updateElementState(BotSettingsButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	RemoveBotButton = BotSettingsButton
	AddBotButton = BotSettingsButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local6["MapVote.mapVoteGameModeNext"], function(f22_arg0)
		f1_arg0:updateElementState(BotSettingsButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "MapVote.mapVoteGameModeNext",
		})
	end, false)
	BotSettingsButton.ButtonName:setText(LocalizeToUpperString(0x5025AFE42DB30DC))
	BotSettingsButton:appendEventHandler("on_session_start", function(f23_arg0, f23_arg1)
		f23_arg1.menu = f23_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f23_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	BotSettingsButton:appendEventHandler("on_session_end", function(f24_arg0, f24_arg1)
		f24_arg1.menu = f24_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f24_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	RemoveBotButton = BotSettingsButton
	AddBotButton = BotSettingsButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local6["lobbyRoot.lobbyNav"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RemoveBotButton = BotSettingsButton
	AddBotButton = BotSettingsButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local6["lobbyRoot.gameClient.update"], function(f26_arg0, f26_arg1)
		CoD.Menu.UpdateButtonShownState(f26_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RemoveBotButton = BotSettingsButton
	AddBotButton = BotSettingsButton.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	AddBotButton(RemoveBotButton, f1_local6["lobbyRoot.privateClient.update"], function(f27_arg0, f27_arg1)
		CoD.Menu.UpdateButtonShownState(f27_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BotSettingsButton:appendEventHandler("input_source_changed", function(f28_arg0, f28_arg1)
		f28_arg1.menu = f28_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f28_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	RemoveBotButton = BotSettingsButton
	AddBotButton = BotSettingsButton.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	AddBotButton(RemoveBotButton, f1_local6.LastInput, function(f29_arg0, f29_arg1)
		CoD.Menu.UpdateButtonShownState(f29_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	BotSettingsButton:registerEventHandler("gain_focus", function(element, event)
		local f30_local0 = nil
		if element.gainFocus then
			f30_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f30_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f30_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BotSettingsButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			OpenBotSettings(menu, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif IsLobbyHostOfCurrentMenu() then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			OpenBotSettings(menu, controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsLobbyHostOfCurrentMenu() and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		elseif IsLobbyHostOfCurrentMenu() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x61333AE050EC552, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(BotSettingsButton)
	self.BotSettingsButton = BotSettingsButton
	AddBotButton = CoD.DirectorConfigButton.new(f1_arg0, f1_arg1, 0, 0.48, 0, 0, 0, 0, 144, 184)
	AddBotButton:mergeStateConditions({
		{
			stateName = "invisible",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.ShowDirectorCustomMatchBotButtons(f1_arg1)
			end,
		},
	})
	f1_local6 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local6, f1_local7["lobbyRoot.lobbyNav"], function(f34_arg0)
		f1_arg0:updateElementState(AddBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local6 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local7 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local6, f1_local7["MapVote.mapVoteGameModeNext"], function(f35_arg0)
		f1_arg0:updateElementState(AddBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "MapVote.mapVoteGameModeNext",
		})
	end, false)
	AddBotButton.ButtonName:setText(LocalizeToUpperString(0x41A80D9A928673E))
	AddBotButton:appendEventHandler("on_session_start", function(f36_arg0, f36_arg1)
		f36_arg1.menu = f36_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f36_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	AddBotButton:appendEventHandler("on_session_end", function(f37_arg0, f37_arg1)
		f37_arg1.menu = f37_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f37_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local6 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local7 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local6, f1_local7["lobbyRoot.lobbyNav"], function(f38_arg0, f38_arg1)
		CoD.Menu.UpdateButtonShownState(f38_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local6 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local7 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local6, f1_local7["lobbyRoot.gameClient.update"], function(f39_arg0, f39_arg1)
		CoD.Menu.UpdateButtonShownState(f39_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local6 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local7 = Engine[0x8DF2E5447F384B9]()
	RemoveBotButton(f1_local6, f1_local7["lobbyRoot.privateClient.update"], function(f40_arg0, f40_arg1)
		CoD.Menu.UpdateButtonShownState(f40_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AddBotButton:appendEventHandler("input_source_changed", function(f41_arg0, f41_arg1)
		f41_arg1.menu = f41_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f41_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local6 = AddBotButton
	RemoveBotButton = AddBotButton.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	RemoveBotButton(f1_local6, f1_local7.LastInput, function(f42_arg0, f42_arg1)
		CoD.Menu.UpdateButtonShownState(f42_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	AddBotButton:registerEventHandler("gain_focus", function(element, event)
		local f43_local0 = nil
		if element.gainFocus then
			f43_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f43_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f43_local0
	end)
	f1_arg0:AddButtonCallbackFunction(AddBotButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			AddLobbyBots(menu, controller)
			return true
		elseif IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			AddLobbyBots(menu, controller)
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
	self:addElement(AddBotButton)
	self.AddBotButton = AddBotButton
	RemoveBotButton = CoD.DirectorConfigButton.new(f1_arg0, f1_arg1, 0.52, 1, 0, 0, 0, 0, 144, 184)
	RemoveBotButton:mergeStateConditions({
		{
			stateName = "invisible",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.ShowDirectorCustomMatchBotButtons(f1_arg1)
			end,
		},
	})
	f1_local7 = RemoveBotButton
	f1_local6 = RemoveBotButton.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local7, f1_local8["lobbyRoot.lobbyNav"], function(f47_arg0)
		f1_arg0:updateElementState(RemoveBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local7 = RemoveBotButton
	f1_local6 = RemoveBotButton.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local7, f1_local8["MapVote.mapVoteGameModeNext"], function(f48_arg0)
		f1_arg0:updateElementState(RemoveBotButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "MapVote.mapVoteGameModeNext",
		})
	end, false)
	RemoveBotButton.ButtonName:setText(LocalizeToUpperString(0xFD88DBB329D1EC9))
	RemoveBotButton:appendEventHandler("on_session_start", function(f49_arg0, f49_arg1)
		f49_arg1.menu = f49_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f49_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	RemoveBotButton:appendEventHandler("on_session_end", function(f50_arg0, f50_arg1)
		f50_arg1.menu = f50_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f50_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local7 = RemoveBotButton
	f1_local6 = RemoveBotButton.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local7, f1_local8["lobbyRoot.lobbyNav"], function(f51_arg0, f51_arg1)
		CoD.Menu.UpdateButtonShownState(f51_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local7 = RemoveBotButton
	f1_local6 = RemoveBotButton.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local7, f1_local8["lobbyRoot.gameClient.update"], function(f52_arg0, f52_arg1)
		CoD.Menu.UpdateButtonShownState(f52_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local7 = RemoveBotButton
	f1_local6 = RemoveBotButton.subscribeToModel
	f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local6(f1_local7, f1_local8["lobbyRoot.privateClient.update"], function(f53_arg0, f53_arg1)
		CoD.Menu.UpdateButtonShownState(f53_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RemoveBotButton:appendEventHandler("input_source_changed", function(f54_arg0, f54_arg1)
		f54_arg1.menu = f54_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f54_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local7 = RemoveBotButton
	f1_local6 = RemoveBotButton.subscribeToModel
	f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local7, f1_local8.LastInput, function(f55_arg0, f55_arg1)
		CoD.Menu.UpdateButtonShownState(f55_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	RemoveBotButton:registerEventHandler("gain_focus", function(element, event)
		local f56_local0 = nil
		if element.gainFocus then
			f56_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f56_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f56_local0
	end)
	f1_arg0:AddButtonCallbackFunction(RemoveBotButton, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") and IsMouseOrKeyboard(controller) then
			CoD.DirectorUtility.ClearSelectedClient(controller)
			RemoveLobbyBots(self, element, controller, "", menu)
			return true
		elseif IsLobbyHostOfCurrentMenu() and IsBooleanDvarSet("lobby_hostBots") then
			CoD.DirectorUtility.ClearSelectedClient(controller)
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
			stateName = "NoCodCaster",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	DirectorCustomCodcaster.id = "DirectorCustomCodcaster"
	DirectorCustomLobbySettings.id = "DirectorCustomLobbySettings"
	BotSettingsButton.id = "BotSettingsButton"
	AddBotButton.id = "AddBotButton"
	RemoveBotButton.id = "RemoveBotButton"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLobbySettingList.__resetProperties = function(f60_arg0)
	f60_arg0.DirectorCustomCodcaster:completeAnimation()
	f60_arg0.RemoveBotButton:completeAnimation()
	f60_arg0.AddBotButton:completeAnimation()
	f60_arg0.DirectorCustomLobbySettings:completeAnimation()
	f60_arg0.BotSettingsButton:completeAnimation()
	f60_arg0.DirectorCustomCodcaster:setAlpha(1)
	f60_arg0.RemoveBotButton:setTopBottom(0, 0, 144, 184)
	f60_arg0.AddBotButton:setTopBottom(0, 0, 144, 184)
	f60_arg0.DirectorCustomLobbySettings:setTopBottom(0, 0, 48, 88)
	f60_arg0.BotSettingsButton:setTopBottom(0, 0, 96, 136)
end
CoD.DirectorLobbySettingList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f61_arg0, f61_arg1)
			f61_arg0:__resetProperties()
			f61_arg0:setupElementClipCounter(0)
		end,
	},
	NoCodCaster = {
		DefaultClip = function(f62_arg0, f62_arg1)
			f62_arg0:__resetProperties()
			f62_arg0:setupElementClipCounter(5)
			f62_arg0.DirectorCustomCodcaster:completeAnimation()
			f62_arg0.DirectorCustomCodcaster:setAlpha(0)
			f62_arg0.clipFinished(f62_arg0.DirectorCustomCodcaster)
			f62_arg0.DirectorCustomLobbySettings:completeAnimation()
			f62_arg0.DirectorCustomLobbySettings:setTopBottom(0, 0, 1, 41)
			f62_arg0.clipFinished(f62_arg0.DirectorCustomLobbySettings)
			f62_arg0.BotSettingsButton:completeAnimation()
			f62_arg0.BotSettingsButton:setTopBottom(0, 0, 48, 88)
			f62_arg0.clipFinished(f62_arg0.BotSettingsButton)
			f62_arg0.AddBotButton:completeAnimation()
			f62_arg0.AddBotButton:setTopBottom(0, 0, 96, 136)
			f62_arg0.clipFinished(f62_arg0.AddBotButton)
			f62_arg0.RemoveBotButton:completeAnimation()
			f62_arg0.RemoveBotButton:setTopBottom(0, 0, 96, 136)
			f62_arg0.clipFinished(f62_arg0.RemoveBotButton)
		end,
	},
}
CoD.DirectorLobbySettingList.__onClose = function(f63_arg0)
	f63_arg0.DirectorCustomCodcaster:close()
	f63_arg0.DirectorCustomLobbySettings:close()
	f63_arg0.BotSettingsButton:close()
	f63_arg0.AddBotButton:close()
	f63_arg0.RemoveBotButton:close()
end
