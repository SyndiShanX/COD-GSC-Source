require("ui/uieditor/widgets/pc/footer/footerbutton_persistent")
require("ui/uieditor/widgets/pc/footer/footerbutton_player")
CoD.FooterButton_PersistentLeftContainer = InheritFrom(LUI.UIElement)
CoD.FooterButton_PersistentLeftContainer.__defaultWidth = 480
CoD.FooterButton_PersistentLeftContainer.__defaultHeight = 54
CoD.FooterButton_PersistentLeftContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.FooterButton_PersistentLeftContainer)
	self.id = "FooterButton_PersistentLeftContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local FooterButtonChat = CoD.FooterButton_Persistent.new(f1_arg0, f1_arg1, 0, 0, 0, 120, 0, 1, 0, 0)
	FooterButtonChat:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1) and not CoD.PCUtility.MenuChatToggleShouldBeVisible(element, menu, f1_arg1)
			end,
		},
	})
	local FooterButtonSocial = FooterButtonChat
	local FooterButtonFriends = FooterButtonChat.subscribeToModel
	local FooterButtonStore = Engine.GetModelForController(f1_arg1)
	FooterButtonFriends(FooterButtonSocial, FooterButtonStore.LockUIShortcutInput, function(f3_arg0)
		f1_arg0:updateElementState(FooterButtonChat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	FooterButtonSocial = FooterButtonChat
	FooterButtonFriends = FooterButtonChat.subscribeToModel
	FooterButtonStore = Engine.GetModelForController(f1_arg1)
	FooterButtonFriends(FooterButtonSocial, FooterButtonStore["ChatGlobal.ChatAvailableInMenuEvent"], function(f4_arg0)
		f1_arg0:updateElementState(FooterButtonChat, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ChatGlobal.ChatAvailableInMenuEvent",
		})
	end, false)
	FooterButtonChat.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7EE439D162567C89"))
	FooterButtonChat.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_68266B58948F0859"))
	FooterButtonChat.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/chat_caps"))
	FooterButtonChat.footerTooltip.keyPrompt.keybind.__TooltipKeybind = function()
		FooterButtonChat.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_4925899529895C0B")))
	end
	FooterButtonChat.footerTooltip.keyPrompt.keybind.__TooltipKeybind()
	FooterButtonChat:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonChat, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		CoD.PCUtility.ToggleChatVisibility(f7_arg2)
		return true
	end, function(f8_arg0, f8_arg1, f8_arg2)
		CoD.Menu.SetButtonLabel(f8_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonChat, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f9_arg0, f9_arg1, f9_arg2, f9_arg3)
		CoD.PCUtility.ToggleChatVisibility(f9_arg2)
		return true
	end, function(f10_arg0, f10_arg1, f10_arg2)
		CoD.Menu.SetButtonLabel(f10_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(FooterButtonChat)
	self.FooterButtonChat = FooterButtonChat
	FooterButtonFriends = CoD.FooterButton_Persistent.new(f1_arg0, f1_arg1, 0, 0, 120, 240, 0, 1, 0, 0)
	FooterButtonFriends:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1) and not CoD.PCUtility.CanOpenFriends(f1_arg1, menu)
			end,
		},
	})
	FooterButtonStore = FooterButtonFriends
	FooterButtonSocial = FooterButtonFriends.subscribeToModel
	local FooterButtonSettings = Engine.GetModelForController(f1_arg1)
	FooterButtonSocial(FooterButtonStore, FooterButtonSettings.LockUIShortcutInput, function(f12_arg0)
		f1_arg0:updateElementState(FooterButtonFriends, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	FooterButtonFriends.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2139903360C0166C"))
	FooterButtonFriends.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](0x8345F92F6F5B30))
	FooterButtonFriends.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/friends_caps"))
	FooterButtonFriends.footerTooltip.keyPrompt.keybind.__TooltipKeybind = function()
		FooterButtonFriends.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_521CC88215B8CABE")))
	end
	FooterButtonFriends.footerTooltip.keyPrompt.keybind.__TooltipKeybind()
	FooterButtonFriends:registerEventHandler("gain_focus", function(element, event)
		local f14_local0 = nil
		if element.gainFocus then
			f14_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f14_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f14_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonFriends, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility(f15_arg0, f15_arg1, f15_arg2)
		return true
	end, function(f16_arg0, f16_arg1, f16_arg2)
		CoD.Menu.SetButtonLabel(f16_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonFriends, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
		CoD.PCBattlenetUtility.ToggleBattlenetMenuVisibility(f17_arg0, f17_arg1, f17_arg2)
		return true
	end, function(f18_arg0, f18_arg1, f18_arg2)
		CoD.Menu.SetButtonLabel(f18_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(FooterButtonFriends)
	self.FooterButtonFriends = FooterButtonFriends
	FooterButtonSocial = CoD.FooterButton_Persistent.new(f1_arg0, f1_arg1, 0, 0, 240, 360, 0, 1, 0, 0)
	FooterButtonSocial:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1) and not CoD.PCUtility.CanOpenSocialMenu(f1_arg1, menu)
			end,
		},
	})
	FooterButtonSettings = FooterButtonSocial
	FooterButtonStore = FooterButtonSocial.subscribeToModel
	local FooterButtonPlayerAccount = Engine.GetModelForController(f1_arg1)
	FooterButtonStore(FooterButtonSettings, FooterButtonPlayerAccount.LockUIShortcutInput, function(f20_arg0)
		f1_arg0:updateElementState(FooterButtonSocial, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	FooterButtonSettings = FooterButtonSocial
	FooterButtonStore = FooterButtonSocial.subscribeToModel
	FooterButtonPlayerAccount = Engine.GetGlobalModel()
	FooterButtonStore(FooterButtonSettings, FooterButtonPlayerAccount["lobbyRoot.lobbyNetworkMode"], function(f21_arg0)
		f1_arg0:updateElementState(FooterButtonSocial, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	FooterButtonSettings = FooterButtonSocial
	FooterButtonStore = FooterButtonSocial.subscribeToModel
	FooterButtonPlayerAccount = Engine.GetGlobalModel()
	FooterButtonStore(FooterButtonSettings, FooterButtonPlayerAccount["lobbyRoot.lobbyNav"], function(f22_arg0)
		f1_arg0:updateElementState(FooterButtonSocial, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	FooterButtonSocial.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_18E8C0862204180A"))
	FooterButtonSocial.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_A4F37A001911A0A"))
	FooterButtonSocial.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/social_caps"))
	FooterButtonSocial.footerTooltip.keyPrompt.keybind.__TooltipKeybind = function()
		FooterButtonSocial.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_3EB01F705FEE50EE")))
	end
	FooterButtonSocial.footerTooltip.keyPrompt.keybind.__TooltipKeybind()
	FooterButtonSettings = FooterButtonSocial
	FooterButtonStore = FooterButtonSocial.subscribeToModel
	FooterButtonPlayerAccount = Engine.GetGlobalModel()
	FooterButtonStore(FooterButtonSettings, FooterButtonPlayerAccount["lobbyRoot.lobbyNetworkMode"], function(f24_arg0, f24_arg1)
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f24_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
	end, false)
	FooterButtonSettings = FooterButtonSocial
	FooterButtonStore = FooterButtonSocial.subscribeToModel
	FooterButtonPlayerAccount = Engine.GetGlobalModel()
	FooterButtonStore(FooterButtonSettings, FooterButtonPlayerAccount["lobbyRoot.lobbyNav"], function(f25_arg0, f25_arg1)
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f25_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
	end, false)
	FooterButtonSocial:registerEventHandler("gain_focus", function(element, event)
		local f26_local0 = nil
		if element.gainFocus then
			f26_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f26_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f26_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonSocial, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
		if not IsLAN() and not IsPlayerAGuest(f27_arg2) and IsPlayerAllowedToPlayOnline(f27_arg2) then
			CoD.PCUtility.ToggleShortcutMenu(f27_arg1, f27_arg2, "ui_opensocial")
			return true
		else
		end
	end, function(f28_arg0, f28_arg1, f28_arg2)
		if not IsLAN() and not IsPlayerAGuest(f28_arg2) and IsPlayerAllowedToPlayOnline(f28_arg2) then
			CoD.Menu.SetButtonLabel(f28_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonSocial, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
		if not IsLAN() and not IsPlayerAGuest(f29_arg2) and IsPlayerAllowedToPlayOnline(f29_arg2) then
			CoD.PCUtility.ToggleShortcutMenu(f29_arg1, f29_arg2, "ui_opensocial")
			return true
		else
		end
	end, function(f30_arg0, f30_arg1, f30_arg2)
		if not IsLAN() and not IsPlayerAGuest(f30_arg2) and IsPlayerAllowedToPlayOnline(f30_arg2) then
			CoD.Menu.SetButtonLabel(f30_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(FooterButtonSocial)
	self.FooterButtonSocial = FooterButtonSocial
	FooterButtonStore = CoD.FooterButton_Persistent.new(f1_arg0, f1_arg1, 0, 0, 360, 480, 0, 1, 0, 0)
	FooterButtonStore:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1) and not CoD.PCUtility.CanOpenStore(f1_arg1, menu)
			end,
		},
	})
	FooterButtonPlayerAccount = FooterButtonStore
	FooterButtonSettings = FooterButtonStore.subscribeToModel
	local f1_local7 = Engine.GetModelForController(f1_arg1)
	FooterButtonSettings(FooterButtonPlayerAccount, f1_local7.LockUIShortcutInput, function(f32_arg0)
		f1_arg0:updateElementState(FooterButtonStore, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	FooterButtonStore:setAlpha(0)
	FooterButtonStore.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_111EC45AB3B0626"))
	FooterButtonStore.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4861ED6423EBD90E"))
	FooterButtonStore.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/store_caps"))
	FooterButtonStore.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_48EF09D289B2D63E"))
	FooterButtonStore:registerEventHandler("gain_focus", function(element, event)
		local f33_local0 = nil
		if element.gainFocus then
			f33_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f33_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f33_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonStore, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
		CoD.PCUtility.ToggleShortcutMenu(f34_arg1, f34_arg2, "ui_openstore")
		return true
	end, function(f35_arg0, f35_arg1, f35_arg2)
		CoD.Menu.SetButtonLabel(f35_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonStore, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f36_arg0, f36_arg1, f36_arg2, f36_arg3)
		CoD.PCUtility.ToggleShortcutMenu(f36_arg1, f36_arg2, "ui_openstore")
		return true
	end, function(f37_arg0, f37_arg1, f37_arg2)
		CoD.Menu.SetButtonLabel(f37_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(FooterButtonStore)
	self.FooterButtonStore = FooterButtonStore
	FooterButtonSettings = CoD.FooterButton_Persistent.new(f1_arg0, f1_arg1, 0, 0, 480, 600, 0, 1, 0, 0)
	FooterButtonSettings:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1) and not CoD.PCUtility.CanOpenSettings(f1_arg1, menu)
			end,
		},
	})
	f1_local7 = FooterButtonSettings
	FooterButtonPlayerAccount = FooterButtonSettings.subscribeToModel
	local f1_local8 = Engine.GetModelForController(f1_arg1)
	FooterButtonPlayerAccount(f1_local7, f1_local8.LockUIShortcutInput, function(f39_arg0)
		f1_arg0:updateElementState(FooterButtonSettings, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	FooterButtonSettings.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1FBCDFDF3FB70BDC"))
	FooterButtonSettings.label2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5110681AB84DEE00"))
	FooterButtonSettings.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/settings_caps"))
	FooterButtonSettings.footerTooltip.keyPrompt.keybind.__TooltipKeybind = function()
		FooterButtonSettings.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_4AE4ED13AED2E15C")))
	end
	FooterButtonSettings.footerTooltip.keyPrompt.keybind.__TooltipKeybind()
	FooterButtonSettings:registerEventHandler("gain_focus", function(element, event)
		local f41_local0 = nil
		if element.gainFocus then
			f41_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f41_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f41_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonSettings, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f42_arg0, f42_arg1, f42_arg2, f42_arg3)
		CoD.PCUtility.ToggleShortcutMenu(f42_arg1, f42_arg2, "ui_opensettings")
		return true
	end, function(f43_arg0, f43_arg1, f43_arg2)
		CoD.Menu.SetButtonLabel(f43_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonSettings, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
		CoD.PCUtility.ToggleShortcutMenu(f44_arg1, f44_arg2, "ui_opensettings")
		return true
	end, function(f45_arg0, f45_arg1, f45_arg2)
		CoD.Menu.SetButtonLabel(f45_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(FooterButtonSettings)
	self.FooterButtonSettings = FooterButtonSettings
	FooterButtonPlayerAccount = CoD.FooterButton_Player.new(f1_arg0, f1_arg1, 0, 0, 600, 720, 0, 1, 0, 0)
	FooterButtonPlayerAccount:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.PCUtility.AreUIShortcutInputLocked(f1_arg1) and not CoD.PCUtility.CanOpenPlayerAccount(f1_arg1, menu)
			end,
		},
	})
	f1_local8 = FooterButtonPlayerAccount
	f1_local7 = FooterButtonPlayerAccount.subscribeToModel
	local f1_local9 = Engine.GetModelForController(f1_arg1)
	f1_local7(f1_local8, f1_local9.LockUIShortcutInput, function(f47_arg0)
		f1_arg0:updateElementState(FooterButtonPlayerAccount, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "LockUIShortcutInput",
		})
	end, false)
	FooterButtonPlayerAccount.Internal.footerTooltip.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_B828992E638B17B"))
	FooterButtonPlayerAccount.Internal.footerTooltip.keyPrompt.keybind.__Internal_TooltipKeybind = function()
		FooterButtonPlayerAccount.Internal.footerTooltip.keyPrompt.keybind:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.PCUtility.ForceSetTextOnRebind(@"hash_2689F7EF9B424B")))
	end
	FooterButtonPlayerAccount.Internal.footerTooltip.keyPrompt.keybind.__Internal_TooltipKeybind()
	FooterButtonPlayerAccount:registerEventHandler("gain_focus", function(element, event)
		local f49_local0 = nil
		if element.gainFocus then
			f49_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f49_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_none"])
		return f49_local0
	end)
	f1_arg0:AddButtonCallbackFunction(FooterButtonPlayerAccount, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f50_arg0, f50_arg1, f50_arg2, f50_arg3)
		CoD.PCUtility.ToggleShortcutMenu(f50_arg1, f50_arg2, "ui_openPlayerAccount")
		return true
	end, function(f51_arg0, f51_arg1, f51_arg2)
		CoD.Menu.SetButtonLabel(f51_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "ui_confirm")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(FooterButtonPlayerAccount, f1_arg1, Enum.LUIButton[@"lui_key_none"], "MOUSE1", function(f52_arg0, f52_arg1, f52_arg2, f52_arg3)
		CoD.PCUtility.ToggleShortcutMenu(f52_arg1, f52_arg2, "ui_openPlayerAccount")
		return true
	end, function(f53_arg0, f53_arg1, f53_arg2)
		CoD.Menu.SetButtonLabel(f53_arg1, Enum.LUIButton[@"lui_key_none"], 0x0, nil, "MOUSE1")
		return false
	end, false)
	self:addElement(FooterButtonPlayerAccount)
	self.FooterButtonPlayerAccount = FooterButtonPlayerAccount
	f1_local8 = FooterButtonChat
	f1_local7 = FooterButtonChat.subscribeToModel
	f1_local9 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.isBindingKey, FooterButtonChat.footerTooltip.keyPrompt.keybind.__TooltipKeybind)
	f1_local8 = FooterButtonFriends
	f1_local7 = FooterButtonFriends.subscribeToModel
	f1_local9 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.isBindingKey, FooterButtonFriends.footerTooltip.keyPrompt.keybind.__TooltipKeybind)
	f1_local8 = FooterButtonSocial
	f1_local7 = FooterButtonSocial.subscribeToModel
	f1_local9 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.isBindingKey, FooterButtonSocial.footerTooltip.keyPrompt.keybind.__TooltipKeybind)
	f1_local8 = FooterButtonSettings
	f1_local7 = FooterButtonSettings.subscribeToModel
	f1_local9 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.isBindingKey, FooterButtonSettings.footerTooltip.keyPrompt.keybind.__TooltipKeybind)
	f1_local8 = FooterButtonPlayerAccount
	f1_local7 = FooterButtonPlayerAccount.subscribeToModel
	f1_local9 = DataSources.KeybindMessages.getModel(f1_arg1)
	f1_local7(f1_local8, f1_local9.isBindingKey, FooterButtonPlayerAccount.Internal.footerTooltip.keyPrompt.keybind.__Internal_TooltipKeybind)
	if CoD.isPC then
		FooterButtonChat.id = "FooterButtonChat"
	end
	if CoD.isPC then
		FooterButtonFriends.id = "FooterButtonFriends"
	end
	if CoD.isPC then
		FooterButtonSocial.id = "FooterButtonSocial"
	end
	if CoD.isPC then
		FooterButtonStore.id = "FooterButtonStore"
	end
	if CoD.isPC then
		FooterButtonSettings.id = "FooterButtonSettings"
	end
	if CoD.isPC then
		FooterButtonPlayerAccount.id = "FooterButtonPlayerAccount"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local7 = self
	SetElementProperty(FooterButtonChat, "__isChatToggleButton", true)
	SetElementProperty(FooterButtonFriends, "__isFrontendBattlenetToggleButton", true)
	f1_local7 = FooterButtonPlayerAccount
	if IsInGame() then
		HideWidget(f1_local7)
	end
	return self
end
CoD.FooterButton_PersistentLeftContainer.__onClose = function(f54_arg0)
	f54_arg0.FooterButtonChat:close()
	f54_arg0.FooterButtonFriends:close()
	f54_arg0.FooterButtonSocial:close()
	f54_arg0.FooterButtonStore:close()
	f54_arg0.FooterButtonSettings:close()
	f54_arg0.FooterButtonPlayerAccount:close()
end
