require("ui/uieditor/menus/startmenu/popups/startmenu_options_codaccount_cta")
require("ui/uieditor/menus/startmenu/popups/startmenu_options_codaccount_manageaccount")
require("ui/uieditor/menus/startmenu/popups/startmenu_options_privacysettings")
require("ui/uieditor/menus/startmenu/startmenu_options_main")
require("ui/uieditor/widgets/director/directorgenericbutton")
require("ui/uieditor/widgets/startmenu/options/startmenu_options_codaccountbutton")
require("ui/uieditor/widgets/startmenu/options/startmenu_options_privacysettingsbutton")
require("ui/uieditor/widgets/startmenu/startmenu_button_sm")
require("ui/uieditor/widgets/startmenu/startmenu_quitbuttonfitted")
CoD.StartMenu_Options = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options.__defaultWidth = 1920
CoD.StartMenu_Options.__defaultHeight = 1080
CoD.StartMenu_Options.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.hasStartedWZMatch", false)
	self:setClass(CoD.StartMenu_Options)
	self.id = "StartMenu_Options"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Credits = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0.5, 0.5, 270.5, 510.5, 0.5, 0.5, -69, 171)
	Credits:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.OptionsUtility.AreCreditsAvailable(f1_arg1)
			end,
		},
	})
	Credits.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage("ui_icon_startmenu_option_credits"))
	Credits.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString("menu/credits_caps"))
	Credits:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Credits, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		if IsInDefaultState(self.Credits) then
			OpenOverlay_NoDependency(self, "Credit_Fullscreen", f4_arg2, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f5_arg0, f5_arg1, f5_arg2)
		if IsInDefaultState(self.Credits) then
			CoD.Menu.SetButtonLabel(f5_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Credits)
	self.Credits = Credits
	local GraphicContent = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0.5, 0.5, 9, 249, 0.5, 0.5, -69, 171)
	GraphicContent:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.DisableForCurrentMilestone(f1_arg1) and not IsGameTrial()
			end,
		},
	})
	GraphicContent.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage("ui_icon_startmenu_option_graphiccontent"))
	GraphicContent.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString(@"menu/content_filter"))
	GraphicContent:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(GraphicContent, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
		if IsInDefaultState(self.GraphicContent) then
			CoD.ModelUtility.SetControllerModelValueToEnum(f8_arg2, "selectedPlayerOptionsTab", CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_CONTENT_FILTER)
			OpenOverlay(self, "StartMenu_Options_Main", f8_arg2, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f9_arg0, f9_arg1, f9_arg2)
		if IsInDefaultState(self.GraphicContent) then
			CoD.Menu.SetButtonLabel(f9_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(GraphicContent)
	self.GraphicContent = GraphicContent
	local Muting = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0.5, 0.5, -257, -17, 0.5, 0.5, -69, 171)
	Muting:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsOfflineDemo() and not IsGameTrial()
			end,
		},
	})
	Muting.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage("ui_icon_startmenu_option_muting"))
	Muting.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString(@"menu/muting"))
	Muting:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Muting, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
		if IsInDefaultState(self.Muting) then
			CoD.ModelUtility.SetControllerModelValueToEnum(f12_arg2, "selectedPlayerOptionsTab", CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_VOICE)
			OpenOverlay(self, "StartMenu_Options_Main", f12_arg2, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f13_arg0, f13_arg1, f13_arg2)
		if IsInDefaultState(self.Muting) then
			CoD.Menu.SetButtonLabel(f13_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Muting)
	self.Muting = Muting
	local Network = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0.5, 0.5, -521.5, -281.5, 0.5, 0.5, -69, 171)
	Network:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsOfflineDemo() and not IsGameTrial()
			end,
		},
	})
	Network.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage("ui_icon_startmenu_option_network"))
	Network.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString(@"menu/network"))
	Network:registerEventHandler("gain_focus", function(element, event)
		local f15_local0 = nil
		if element.gainFocus then
			f15_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f15_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f15_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Network, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if IsInDefaultState(self.Network) then
			CoD.ModelUtility.SetControllerModelValueToEnum(f16_arg2, "selectedPlayerOptionsTab", CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_NETWORK)
			OpenOverlay(self, "StartMenu_Options_Main", f16_arg2, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f17_arg0, f17_arg1, f17_arg2)
		if IsInDefaultState(self.Network) then
			CoD.Menu.SetButtonLabel(f17_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Network)
	self.Network = Network
	local Blackout = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0.5, 0.5, 270.5, 510.5, 0.5, 0.5, -336, -96)
	Blackout:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				local f18_local0
				if not IsWarzone() then
					f18_local0 = not IsMainModeInvalid()
				else
					f18_local0 = false
				end
				return f18_local0
			end,
		},
	})
	local Graphics = Blackout
	local Audio = Blackout.subscribeToModel
	local Controls = Engine.GetGlobalModel()
	Audio(Graphics, Controls["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(Blackout, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Graphics = Blackout
	Audio = Blackout.subscribeToModel
	Controls = Engine.GetGlobalModel()
	Audio(Graphics, Controls["lobbyRoot.lobbyMainMode"], function(f20_arg0)
		f1_arg0:updateElementState(Blackout, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "lobbyRoot.lobbyMainMode",
		})
	end, false)
	Blackout.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage("ui_icon_startmenu_option_music"))
	Blackout.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString("menu/warzone"))
	Blackout:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f21_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Blackout, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
		if IsInDefaultState(self.Blackout) then
			CoD.ModelUtility.SetControllerModelValueToEnum(f22_arg2, "selectedPlayerOptionsTab", CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_WARZONE)
			OpenOverlay(self, "StartMenu_Options_Main", f22_arg2, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f23_arg0, f23_arg1, f23_arg2)
		if IsInDefaultState(self.Blackout) then
			CoD.Menu.SetButtonLabel(f23_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Blackout)
	self.Blackout = Blackout
	Audio = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0.5, 0.5, 9, 249, 0.5, 0.5, -336, -96)
	Audio:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not ShouldOpenGraphicsAndSoundOptions()
			end,
		},
	})
	Audio.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage("uie_img_t7_menu_startmenu_option_audio"))
	Audio.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString(@"menu/audio"))
	Audio:registerEventHandler("gain_focus", function(element, event)
		local f25_local0 = nil
		if element.gainFocus then
			f25_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f25_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f25_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Audio, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
		if ShouldOpenGraphicsAndSoundOptions() then
			CoD.ModelUtility.SetControllerModelValueToEnum(f26_arg2, "selectedPlayerOptionsTab", CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_AUDIO)
			OpenOverlay(self, "StartMenu_Options_Main", f26_arg2, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f27_arg0, f27_arg1, f27_arg2)
		if ShouldOpenGraphicsAndSoundOptions() then
			CoD.Menu.SetButtonLabel(f27_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Audio)
	self.Audio = Audio
	Graphics = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0.5, 0.5, -257, -17, 0.5, 0.5, -336, -96)
	Graphics:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not ShouldOpenGraphicsAndSoundOptions()
			end,
		},
	})
	Graphics.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage("uie_ui_icon_startmenu_option_graphics"))
	Graphics.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString("menu/graphics"))
	Graphics:registerEventHandler("gain_focus", function(element, event)
		local f29_local0 = nil
		if element.gainFocus then
			f29_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f29_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f29_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Graphics, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
		if IsInDefaultState(self.Graphics) then
			CoD.ModelUtility.SetControllerModelValueToEnum(f30_arg2, "selectedPlayerOptionsTab", CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_GRAPHICS)
			OpenOverlay(self, "StartMenu_Options_Main", f30_arg2, nil)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(f31_arg0, f31_arg1, f31_arg2)
		if IsInDefaultState(self.Graphics) then
			CoD.Menu.SetButtonLabel(f31_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(Graphics)
	self.Graphics = Graphics
	Controls = CoD.StartMenu_Button_SM.new(f1_arg0, f1_arg1, 0.5, 0.5, -521.5, -281.5, 0.5, 0.5, -336, -96)
	Controls.StartMenuOptionsSubFrame.ButtonText:setText(LocalizeToUpperString(@"menu/controls"))
	Controls:subscribeToGlobalModel(f1_arg1, "PlatformControllerImage", "image", function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			Controls.StartMenuOptionsSubFrame.ImageContainer.ImageContainer:setImage(RegisterImage(f32_local0))
		end
	end)
	Controls:registerEventHandler("gain_focus", function(element, event)
		local f33_local0 = nil
		if element.gainFocus then
			f33_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f33_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f33_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Controls, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
		CoD.ModelUtility.SetControllerModelValueToEnum(f34_arg2, "selectedPlayerOptionsTab", CoD.OptionsUtility.PlayerOptionsTabIndex.OPTION_TAB_CONTROLS)
		OpenOverlay(self, "StartMenu_Options_Main", f34_arg2, nil)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(f35_arg0, f35_arg1, f35_arg2)
		CoD.Menu.SetButtonLabel(f35_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(Controls)
	self.Controls = Controls
	local QuitButtonCodcaster = CoD.StartMenu_QuitButtonFitted.new(f1_arg0, f1_arg1, 0.5, 0.5, 290.5, 490.5, 0.5, 0.5, 226, 295)
	QuitButtonCodcaster:appendEventHandler("input_source_changed", function(f36_arg0, f36_arg1)
		f36_arg1.menu = f36_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f36_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	local PrivacySettingsButton = QuitButtonCodcaster
	local CoDAccount = QuitButtonCodcaster.subscribeToModel
	local QuitButton = Engine.GetModelForController(f1_arg1)
	CoDAccount(PrivacySettingsButton, QuitButton.LastInput, function(f37_arg0, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	QuitButtonCodcaster:registerEventHandler("gain_focus", function(element, event)
		local f38_local0 = nil
		if element.gainFocus then
			f38_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f38_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f38_local0
	end)
	f1_arg0:AddButtonCallbackFunction(QuitButtonCodcaster, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f39_arg0, f39_arg1, f39_arg2, f39_arg3)
		if IsMouseOrKeyboard(f39_arg2) and IsPC() then
			QuitPCGame_MP(self, f39_arg2, false)
			return true
		else
		end
	end, function(f40_arg0, f40_arg1, f40_arg2)
		if IsMouseOrKeyboard(f40_arg2) and IsPC() then
			CoD.Menu.SetButtonLabel(f40_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(QuitButtonCodcaster, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f41_arg0, f41_arg1, f41_arg2, f41_arg3)
		if IsGamepad(f41_arg2) then
			CoD.StartMenuUtility.QuitGameWarningPrompt(f41_arg2, f41_arg1)
			return true
		else
		end
	end, function(f42_arg0, f42_arg1, f42_arg2)
		if IsGamepad(f42_arg2) then
			CoD.Menu.SetButtonLabel(f42_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(QuitButtonCodcaster)
	self.QuitButtonCodcaster = QuitButtonCodcaster
	CoDAccount = CoD.StartMenu_Options_CoDAccountButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -265, 249, 0.5, 0.5, 226, 295)
	CoDAccount.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString("menu/cod_account_caps"))
	CoDAccount.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString("menu/cod_account_caps"))
	CoDAccount:registerEventHandler("gain_focus", function(element, event)
		local f43_local0 = nil
		if element.gainFocus then
			f43_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f43_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f43_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CoDAccount, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
		if CoD.CoDAccountUtility.IsAccountFeatureEnabled(f44_arg2) and not IsSignedIntoUno(f44_arg2) then
			OpenOverlay(self, "StartMenu_Options_CoDAccount_CTA", f44_arg2)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.CoDAccountUtility.IsAccountFeatureEnabled(f44_arg2) and IsSignedIntoUno(f44_arg2) then
			OpenOverlay(self, "StartMenu_Options_CoDAccount_ManageAccount", f44_arg2)
			return true
		else
		end
	end, function(f45_arg0, f45_arg1, f45_arg2)
		if CoD.CoDAccountUtility.IsAccountFeatureEnabled(f45_arg2) and not IsSignedIntoUno(f45_arg2) then
			CoD.Menu.SetButtonLabel(f45_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.CoDAccountUtility.IsAccountFeatureEnabled(f45_arg2) and IsSignedIntoUno(f45_arg2) then
			CoD.Menu.SetButtonLabel(f45_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(CoDAccount)
	self.CoDAccount = CoDAccount
	PrivacySettingsButton = CoD.StartMenu_Options_PrivacySettingsButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -265, 249, 0.5, 0.5, 313, 382)
	PrivacySettingsButton.DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString("menu/privacy_settings"))
	PrivacySettingsButton.DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString("menu/privacy_settings"))
	PrivacySettingsButton:registerEventHandler("gain_focus", function(element, event)
		local f46_local0 = nil
		if element.gainFocus then
			f46_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f46_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f46_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PrivacySettingsButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
		OpenOverlay(self, "StartMenu_Options_PrivacySettings", f47_arg2)
		PlaySoundAlias("uin_toggle_generic")
		return true
	end, function(f48_arg0, f48_arg1, f48_arg2)
		CoD.Menu.SetButtonLabel(f48_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
		return true
	end, false)
	self:addElement(PrivacySettingsButton)
	self.PrivacySettingsButton = PrivacySettingsButton
	QuitButton = CoD.StartMenu_QuitButtonFitted.new(f1_arg0, f1_arg1, 0, 0, -20, 230, 1, 1, -162, -70)
	QuitButton:setScale(0.7, 0.7)
	QuitButton:appendEventHandler("input_source_changed", function(f49_arg0, f49_arg1)
		f49_arg1.menu = f49_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f49_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	local f1_local13 = QuitButton
	local DirectorGenericButton = QuitButton.subscribeToModel
	local f1_local15 = Engine.GetModelForController(f1_arg1)
	DirectorGenericButton(f1_local13, f1_local15.LastInput, function(f50_arg0, f50_arg1)
		CoD.Menu.UpdateButtonShownState(f50_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	QuitButton:registerEventHandler("gain_focus", function(element, event)
		local f51_local0 = nil
		if element.gainFocus then
			f51_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f51_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f51_local0
	end)
	f1_arg0:AddButtonCallbackFunction(QuitButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "MOUSE1", function(f52_arg0, f52_arg1, f52_arg2, f52_arg3)
		if IsMouseOrKeyboard(f52_arg2) and IsPC() then
			QuitPCGame_MP(self, f52_arg2, true)
			return true
		else
		end
	end, function(f53_arg0, f53_arg1, f53_arg2)
		if IsMouseOrKeyboard(f53_arg2) and IsPC() then
			CoD.Menu.SetButtonLabel(f53_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/quit", nil, "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(QuitButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f54_arg0, f54_arg1, f54_arg2, f54_arg3)
		if IsGamepad(f54_arg2) then
			CoD.StartMenuUtility.QuitGameWarningPrompt(f54_arg2, f54_arg1)
			return true
		else
		end
	end, function(f55_arg0, f55_arg1, f55_arg2)
		if IsGamepad(f55_arg2) then
			CoD.Menu.SetButtonLabel(f55_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], @"menu/quit", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(QuitButton)
	self.QuitButton = QuitButton
	DirectorGenericButton = CoD.DirectorGenericButton.new(f1_arg0, f1_arg1, 0, 0, 176, 426, 1, 1, -162, -70)
	DirectorGenericButton:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f56_local0 = CoD.HUDUtility.IsWarzone()
				if f56_local0 then
					f56_local0 = CoD.WZUtility.AllowWZOffline()
					if f56_local0 then
						f56_local0 = CoD.HUDUtility.IsWZCustomGame(f1_arg1)
						if f56_local0 then
							f56_local0 = IsLobbyHost()
							if f56_local0 then
								f56_local0 = not CoD.ModelUtility.IsControllerModelValueTrue(f1_arg1, "hudItems.hasStartedWZMatch")
							end
						end
					end
				end
				return f56_local0
			end,
		},
	})
	DirectorGenericButton:appendEventHandler("on_session_start", function(f57_arg0, f57_arg1)
		f57_arg1.menu = f57_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorGenericButton, f57_arg1)
	end)
	DirectorGenericButton:appendEventHandler("on_session_end", function(f58_arg0, f58_arg1)
		f58_arg1.menu = f58_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorGenericButton, f58_arg1)
	end)
	f1_local15 = DirectorGenericButton
	f1_local13 = DirectorGenericButton.subscribeToModel
	local f1_local16 = Engine.GetModelForController(f1_arg1)
	f1_local13(f1_local15, f1_local16["hudItems.hasStartedWZMatch"], function(f59_arg0)
		f1_arg0:updateElementState(DirectorGenericButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f59_arg0:get(),
			modelName = "hudItems.hasStartedWZMatch",
		})
	end, false)
	DirectorGenericButton:setScale(0.7, 0.7)
	DirectorGenericButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(@"warzone/start_warzone"))
	DirectorGenericButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(@"warzone/start_warzone"))
	DirectorGenericButton:appendEventHandler("on_session_start", function(f60_arg0, f60_arg1)
		f60_arg1.menu = f60_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f60_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	DirectorGenericButton:appendEventHandler("on_session_end", function(f61_arg0, f61_arg1)
		f61_arg1.menu = f61_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f61_arg0, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end)
	f1_local15 = DirectorGenericButton
	f1_local13 = DirectorGenericButton.subscribeToModel
	f1_local16 = Engine.GetModelForController(f1_arg1)
	f1_local13(f1_local15, f1_local16["hudItems.hasStartedWZMatch"], function(f62_arg0, f62_arg1)
		CoD.Menu.UpdateButtonShownState(f62_arg1, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
	end, false)
	DirectorGenericButton:registerEventHandler("gain_focus", function(element, event)
		local f63_local0 = nil
		if element.gainFocus then
			f63_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f63_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"])
		return f63_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorGenericButton, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], nil, function(f64_arg0, f64_arg1, f64_arg2, f64_arg3)
		if CoD.HUDUtility.IsWarzone() and CoD.WZUtility.AllowWZOffline() and IsLobbyHost() and CoD.HUDUtility.IsWZCustomGame(f64_arg2) and not CoD.ModelUtility.IsControllerModelValueTrue(f64_arg2, "hudItems.hasStartedWZMatch") then
			CoD.WZUtility.StartWarzone(f64_arg2)
			SetControllerModelValue(f64_arg2, "hudItems.hasStartedWZMatch", true)
			return true
		else
		end
	end, function(f65_arg0, f65_arg1, f65_arg2)
		if CoD.HUDUtility.IsWarzone() and CoD.WZUtility.AllowWZOffline() and IsLobbyHost() and CoD.HUDUtility.IsWZCustomGame(f65_arg2) and not CoD.ModelUtility.IsControllerModelValueTrue(f65_arg2, "hudItems.hasStartedWZMatch") then
			CoD.Menu.SetButtonLabel(f65_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(DirectorGenericButton)
	self.DirectorGenericButton = DirectorGenericButton
	self:mergeStateConditions({
		{
			stateName = "codcaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsWarzone() and not InFrontend()
			end,
		},
	})
	f1_local15 = self
	f1_local13 = self.subscribeToModel
	f1_local16 = Engine.GetModelForController(f1_arg1)
	f1_local13(f1_local15, f1_local16["factions.isCoDCaster"], function(f68_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f68_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local15 = self
	f1_local13 = self.subscribeToModel
	f1_local16 = Engine.GetGlobalModel()
	f1_local13(f1_local15, f1_local16["lobbyRoot.lobbyNav"], function(f69_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f69_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Credits.id = "Credits"
	GraphicContent.id = "GraphicContent"
	Muting.id = "Muting"
	Network.id = "Network"
	Blackout.id = "Blackout"
	Audio.id = "Audio"
	Graphics.id = "Graphics"
	Controls.id = "Controls"
	QuitButtonCodcaster:appendEventHandler("menu_loaded", function()
		QuitButtonCodcaster:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	QuitButtonCodcaster.id = "QuitButtonCodcaster"
	CoDAccount.id = "CoDAccount"
	PrivacySettingsButton.id = "PrivacySettingsButton"
	QuitButton:appendEventHandler("menu_loaded", function()
		QuitButton:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	QuitButton.id = "QuitButton"
	DirectorGenericButton.id = "DirectorGenericButton"
	self.__defaultFocus = Controls
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	CoD.FreeCursorUtility.RetriggerCursorPosition(self, f1_arg1)
	return self
end
CoD.StartMenu_Options.__resetProperties = function(f72_arg0)
	f72_arg0.CoDAccount:completeAnimation()
	f72_arg0.Controls:completeAnimation()
	f72_arg0.Graphics:completeAnimation()
	f72_arg0.Audio:completeAnimation()
	f72_arg0.Blackout:completeAnimation()
	f72_arg0.Network:completeAnimation()
	f72_arg0.Muting:completeAnimation()
	f72_arg0.GraphicContent:completeAnimation()
	f72_arg0.Credits:completeAnimation()
	f72_arg0.QuitButton:completeAnimation()
	f72_arg0.QuitButtonCodcaster:completeAnimation()
	f72_arg0.DirectorGenericButton:completeAnimation()
	f72_arg0.PrivacySettingsButton:completeAnimation()
	f72_arg0.CoDAccount:setAlpha(1)
	f72_arg0.Controls:setAlpha(1)
	f72_arg0.Graphics:setAlpha(1)
	f72_arg0.Audio:setAlpha(1)
	f72_arg0.Blackout:setAlpha(1)
	f72_arg0.Network:setAlpha(1)
	f72_arg0.Muting:setAlpha(1)
	f72_arg0.GraphicContent:setAlpha(1)
	f72_arg0.Credits:setAlpha(1)
	f72_arg0.QuitButton:setAlpha(1)
	f72_arg0.QuitButtonCodcaster:setLeftRight(0.5, 0.5, 290.5, 490.5)
	f72_arg0.QuitButtonCodcaster:setTopBottom(0.5, 0.5, 226, 295)
	f72_arg0.QuitButtonCodcaster:setAlpha(1)
	f72_arg0.DirectorGenericButton:setAlpha(1)
	f72_arg0.PrivacySettingsButton:setAlpha(1)
end
CoD.StartMenu_Options.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f73_arg0, f73_arg1)
			f73_arg0:__resetProperties()
			f73_arg0:setupElementClipCounter(13)
			local f73_local0 = function(f74_arg0)
				local f74_local0 = function(f75_arg0)
					f75_arg0:beginAnimation(150)
					f75_arg0:setAlpha(1)
					f75_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.Credits:beginAnimation(400)
				f73_arg0.Credits:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.Credits:registerEventHandler("transition_complete_keyframe", f74_local0)
			end
			f73_arg0.Credits:completeAnimation()
			f73_arg0.Credits:setAlpha(0)
			f73_local0(f73_arg0.Credits)
			local f73_local1 = function(f76_arg0)
				local f76_local0 = function(f77_arg0)
					f77_arg0:beginAnimation(149)
					f77_arg0:setAlpha(1)
					f77_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.GraphicContent:beginAnimation(230)
				f73_arg0.GraphicContent:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.GraphicContent:registerEventHandler("transition_complete_keyframe", f76_local0)
			end
			f73_arg0.GraphicContent:completeAnimation()
			f73_arg0.GraphicContent:setAlpha(0)
			f73_local1(f73_arg0.GraphicContent)
			local f73_local2 = function(f78_arg0)
				local f78_local0 = function(f79_arg0)
					f79_arg0:beginAnimation(150)
					f79_arg0:setAlpha(1)
					f79_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.Muting:beginAnimation(50)
				f73_arg0.Muting:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.Muting:registerEventHandler("transition_complete_keyframe", f78_local0)
			end
			f73_arg0.Muting:completeAnimation()
			f73_arg0.Muting:setAlpha(0)
			f73_local2(f73_arg0.Muting)
			local f73_local3 = function(f80_arg0)
				local f80_local0 = function(f81_arg0)
					f81_arg0:beginAnimation(150)
					f81_arg0:setAlpha(1)
					f81_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.Network:beginAnimation(50)
				f73_arg0.Network:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.Network:registerEventHandler("transition_complete_keyframe", f80_local0)
			end
			f73_arg0.Network:completeAnimation()
			f73_arg0.Network:setAlpha(0)
			f73_local3(f73_arg0.Network)
			local f73_local4 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					f83_arg0:beginAnimation(150)
					f83_arg0:setAlpha(1)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.Blackout:beginAnimation(400)
				f73_arg0.Blackout:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.Blackout:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f73_arg0.Blackout:completeAnimation()
			f73_arg0.Blackout:setAlpha(0)
			f73_local4(f73_arg0.Blackout)
			local f73_local5 = function(f84_arg0)
				local f84_local0 = function(f85_arg0)
					f85_arg0:beginAnimation(149)
					f85_arg0:setAlpha(1)
					f85_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.Audio:beginAnimation(230)
				f73_arg0.Audio:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.Audio:registerEventHandler("transition_complete_keyframe", f84_local0)
			end
			f73_arg0.Audio:completeAnimation()
			f73_arg0.Audio:setAlpha(0)
			f73_local5(f73_arg0.Audio)
			local f73_local6 = function(f86_arg0)
				local f86_local0 = function(f87_arg0)
					f87_arg0:beginAnimation(150)
					f87_arg0:setAlpha(1)
					f87_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.Graphics:beginAnimation(50)
				f73_arg0.Graphics:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.Graphics:registerEventHandler("transition_complete_keyframe", f86_local0)
			end
			f73_arg0.Graphics:completeAnimation()
			f73_arg0.Graphics:setAlpha(0)
			f73_local6(f73_arg0.Graphics)
			local f73_local7 = function(f88_arg0)
				local f88_local0 = function(f89_arg0)
					f89_arg0:beginAnimation(150)
					f89_arg0:setAlpha(1)
					f89_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.Controls:beginAnimation(50)
				f73_arg0.Controls:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.Controls:registerEventHandler("transition_complete_keyframe", f88_local0)
			end
			f73_arg0.Controls:completeAnimation()
			f73_arg0.Controls:setAlpha(0)
			f73_local7(f73_arg0.Controls)
			f73_arg0.QuitButtonCodcaster:completeAnimation()
			f73_arg0.QuitButtonCodcaster:setLeftRight(0.5, 0.5, 260.5, 510.5)
			f73_arg0.QuitButtonCodcaster:setTopBottom(1, 1, -337, -245)
			f73_arg0.QuitButtonCodcaster:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.QuitButtonCodcaster)
			local f73_local8 = function(f90_arg0)
				local f90_local0 = function(f91_arg0)
					f91_arg0:beginAnimation(150)
					f91_arg0:setAlpha(1)
					f91_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.CoDAccount:beginAnimation(400)
				f73_arg0.CoDAccount:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.CoDAccount:registerEventHandler("transition_complete_keyframe", f90_local0)
			end
			f73_arg0.CoDAccount:completeAnimation()
			f73_arg0.CoDAccount:setAlpha(0)
			f73_local8(f73_arg0.CoDAccount)
			local f73_local9 = function(f92_arg0)
				local f92_local0 = function(f93_arg0)
					f93_arg0:beginAnimation(150)
					f93_arg0:setAlpha(1)
					f93_arg0:registerEventHandler("transition_complete_keyframe", f73_arg0.clipFinished)
				end
				f73_arg0.PrivacySettingsButton:beginAnimation(400)
				f73_arg0.PrivacySettingsButton:registerEventHandler("interrupted_keyframe", f73_arg0.clipInterrupted)
				f73_arg0.PrivacySettingsButton:registerEventHandler("transition_complete_keyframe", f92_local0)
			end
			f73_arg0.PrivacySettingsButton:completeAnimation()
			f73_arg0.PrivacySettingsButton:setAlpha(0)
			f73_local9(f73_arg0.PrivacySettingsButton)
			f73_arg0.QuitButton:completeAnimation()
			f73_arg0.QuitButton:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.QuitButton)
			f73_arg0.DirectorGenericButton:completeAnimation()
			f73_arg0.DirectorGenericButton:setAlpha(0)
			f73_arg0.clipFinished(f73_arg0.DirectorGenericButton)
		end,
	},
	codcaster = {
		DefaultClip = function(f94_arg0, f94_arg1)
			f94_arg0:__resetProperties()
			f94_arg0:setupElementClipCounter(13)
			local f94_local0 = function(f95_arg0)
				f95_arg0:beginAnimation(149)
				f95_arg0:setAlpha(1)
				f95_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.Credits:beginAnimation(380)
			f94_arg0.Credits:setAlpha(0)
			f94_arg0.Credits:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
			f94_arg0.Credits:registerEventHandler("transition_complete_keyframe", f94_local0)
			local f94_local1 = function(f96_arg0)
				f96_arg0:beginAnimation(149)
				f96_arg0:setAlpha(1)
				f96_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.GraphicContent:beginAnimation(230)
			f94_arg0.GraphicContent:setAlpha(0)
			f94_arg0.GraphicContent:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
			f94_arg0.GraphicContent:registerEventHandler("transition_complete_keyframe", f94_local1)
			local f94_local2 = function(f97_arg0)
				f97_arg0:beginAnimation(150)
				f97_arg0:setAlpha(1)
				f97_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.Muting:beginAnimation(100)
			f94_arg0.Muting:setAlpha(0)
			f94_arg0.Muting:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
			f94_arg0.Muting:registerEventHandler("transition_complete_keyframe", f94_local2)
			local f94_local3 = function(f98_arg0)
				f94_arg0.Network:beginAnimation(150)
				f94_arg0.Network:setAlpha(1)
				f94_arg0.Network:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.Network:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.Network:completeAnimation()
			f94_arg0.Network:setAlpha(0)
			f94_local3(f94_arg0.Network)
			local f94_local4 = function(f99_arg0)
				f99_arg0:beginAnimation(149)
				f99_arg0:setAlpha(1)
				f99_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.Blackout:beginAnimation(380)
			f94_arg0.Blackout:setAlpha(0)
			f94_arg0.Blackout:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
			f94_arg0.Blackout:registerEventHandler("transition_complete_keyframe", f94_local4)
			local f94_local5 = function(f100_arg0)
				f100_arg0:beginAnimation(149)
				f100_arg0:setAlpha(1)
				f100_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.Audio:beginAnimation(230)
			f94_arg0.Audio:setAlpha(0)
			f94_arg0.Audio:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
			f94_arg0.Audio:registerEventHandler("transition_complete_keyframe", f94_local5)
			local f94_local6 = function(f101_arg0)
				f101_arg0:beginAnimation(150)
				f101_arg0:setAlpha(1)
				f101_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.Graphics:beginAnimation(100)
			f94_arg0.Graphics:setAlpha(0)
			f94_arg0.Graphics:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
			f94_arg0.Graphics:registerEventHandler("transition_complete_keyframe", f94_local6)
			local f94_local7 = function(f102_arg0)
				f94_arg0.Controls:beginAnimation(150)
				f94_arg0.Controls:setAlpha(1)
				f94_arg0.Controls:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.Controls:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.Controls:completeAnimation()
			f94_arg0.Controls:setAlpha(0)
			f94_local7(f94_arg0.Controls)
			local f94_local8 = function(f103_arg0)
				f103_arg0:beginAnimation(149)
				f103_arg0:setAlpha(1)
				f103_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.QuitButtonCodcaster:beginAnimation(380)
			f94_arg0.QuitButtonCodcaster:setAlpha(0)
			f94_arg0.QuitButtonCodcaster:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
			f94_arg0.QuitButtonCodcaster:registerEventHandler("transition_complete_keyframe", f94_local8)
			local f94_local9 = function(f104_arg0)
				f104_arg0:beginAnimation(150)
				f104_arg0:setAlpha(1)
				f104_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.CoDAccount:beginAnimation(400)
			f94_arg0.CoDAccount:setAlpha(0)
			f94_arg0.CoDAccount:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
			f94_arg0.CoDAccount:registerEventHandler("transition_complete_keyframe", f94_local9)
			local f94_local10 = function(f105_arg0)
				local f105_local0 = function(f106_arg0)
					f106_arg0:beginAnimation(150)
					f106_arg0:setAlpha(1)
					f106_arg0:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
				end
				f94_arg0.PrivacySettingsButton:beginAnimation(400)
				f94_arg0.PrivacySettingsButton:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.PrivacySettingsButton:registerEventHandler("transition_complete_keyframe", f105_local0)
			end
			f94_arg0.PrivacySettingsButton:completeAnimation()
			f94_arg0.PrivacySettingsButton:setAlpha(0)
			f94_local10(f94_arg0.PrivacySettingsButton)
			f94_arg0.QuitButton:completeAnimation()
			f94_arg0.QuitButton:setAlpha(0)
			f94_arg0.clipFinished(f94_arg0.QuitButton)
			f94_arg0.DirectorGenericButton:completeAnimation()
			f94_arg0.DirectorGenericButton:setAlpha(0)
			f94_arg0.clipFinished(f94_arg0.DirectorGenericButton)
		end,
	},
	Warzone = {
		DefaultClip = function(f107_arg0, f107_arg1)
			f107_arg0:__resetProperties()
			f107_arg0:setupElementClipCounter(11)
			local f107_local0 = function(f108_arg0)
				local f108_local0 = function(f109_arg0)
					f109_arg0:beginAnimation(150)
					f109_arg0:setAlpha(1)
					f109_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Credits:beginAnimation(400)
				f107_arg0.Credits:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Credits:registerEventHandler("transition_complete_keyframe", f108_local0)
			end
			f107_arg0.Credits:completeAnimation()
			f107_arg0.Credits:setAlpha(0)
			f107_local0(f107_arg0.Credits)
			local f107_local1 = function(f110_arg0)
				local f110_local0 = function(f111_arg0)
					f111_arg0:beginAnimation(149)
					f111_arg0:setAlpha(1)
					f111_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.GraphicContent:beginAnimation(230)
				f107_arg0.GraphicContent:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.GraphicContent:registerEventHandler("transition_complete_keyframe", f110_local0)
			end
			f107_arg0.GraphicContent:completeAnimation()
			f107_arg0.GraphicContent:setAlpha(0)
			f107_local1(f107_arg0.GraphicContent)
			local f107_local2 = function(f112_arg0)
				local f112_local0 = function(f113_arg0)
					f113_arg0:beginAnimation(150)
					f113_arg0:setAlpha(1)
					f113_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Muting:beginAnimation(50)
				f107_arg0.Muting:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Muting:registerEventHandler("transition_complete_keyframe", f112_local0)
			end
			f107_arg0.Muting:completeAnimation()
			f107_arg0.Muting:setAlpha(0)
			f107_local2(f107_arg0.Muting)
			local f107_local3 = function(f114_arg0)
				local f114_local0 = function(f115_arg0)
					f115_arg0:beginAnimation(150)
					f115_arg0:setAlpha(1)
					f115_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Network:beginAnimation(50)
				f107_arg0.Network:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Network:registerEventHandler("transition_complete_keyframe", f114_local0)
			end
			f107_arg0.Network:completeAnimation()
			f107_arg0.Network:setAlpha(0)
			f107_local3(f107_arg0.Network)
			local f107_local4 = function(f116_arg0)
				local f116_local0 = function(f117_arg0)
					f117_arg0:beginAnimation(150)
					f117_arg0:setAlpha(1)
					f117_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Blackout:beginAnimation(400)
				f107_arg0.Blackout:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Blackout:registerEventHandler("transition_complete_keyframe", f116_local0)
			end
			f107_arg0.Blackout:completeAnimation()
			f107_arg0.Blackout:setAlpha(0)
			f107_local4(f107_arg0.Blackout)
			local f107_local5 = function(f118_arg0)
				local f118_local0 = function(f119_arg0)
					f119_arg0:beginAnimation(149)
					f119_arg0:setAlpha(1)
					f119_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Audio:beginAnimation(230)
				f107_arg0.Audio:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Audio:registerEventHandler("transition_complete_keyframe", f118_local0)
			end
			f107_arg0.Audio:completeAnimation()
			f107_arg0.Audio:setAlpha(0)
			f107_local5(f107_arg0.Audio)
			local f107_local6 = function(f120_arg0)
				local f120_local0 = function(f121_arg0)
					f121_arg0:beginAnimation(150)
					f121_arg0:setAlpha(1)
					f121_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Graphics:beginAnimation(50)
				f107_arg0.Graphics:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Graphics:registerEventHandler("transition_complete_keyframe", f120_local0)
			end
			f107_arg0.Graphics:completeAnimation()
			f107_arg0.Graphics:setAlpha(0)
			f107_local6(f107_arg0.Graphics)
			local f107_local7 = function(f122_arg0)
				local f122_local0 = function(f123_arg0)
					f123_arg0:beginAnimation(150)
					f123_arg0:setAlpha(1)
					f123_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.Controls:beginAnimation(50)
				f107_arg0.Controls:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.Controls:registerEventHandler("transition_complete_keyframe", f122_local0)
			end
			f107_arg0.Controls:completeAnimation()
			f107_arg0.Controls:setAlpha(0)
			f107_local7(f107_arg0.Controls)
			f107_arg0.QuitButtonCodcaster:completeAnimation()
			f107_arg0.QuitButtonCodcaster:setAlpha(0)
			f107_arg0.clipFinished(f107_arg0.QuitButtonCodcaster)
			local f107_local8 = function(f124_arg0)
				local f124_local0 = function(f125_arg0)
					f125_arg0:beginAnimation(150)
					f125_arg0:setAlpha(1)
					f125_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.CoDAccount:beginAnimation(400)
				f107_arg0.CoDAccount:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.CoDAccount:registerEventHandler("transition_complete_keyframe", f124_local0)
			end
			f107_arg0.CoDAccount:completeAnimation()
			f107_arg0.CoDAccount:setAlpha(0)
			f107_local8(f107_arg0.CoDAccount)
			local f107_local9 = function(f126_arg0)
				local f126_local0 = function(f127_arg0)
					f127_arg0:beginAnimation(150)
					f127_arg0:setAlpha(1)
					f127_arg0:registerEventHandler("transition_complete_keyframe", f107_arg0.clipFinished)
				end
				f107_arg0.PrivacySettingsButton:beginAnimation(400)
				f107_arg0.PrivacySettingsButton:registerEventHandler("interrupted_keyframe", f107_arg0.clipInterrupted)
				f107_arg0.PrivacySettingsButton:registerEventHandler("transition_complete_keyframe", f126_local0)
			end
			f107_arg0.PrivacySettingsButton:completeAnimation()
			f107_arg0.PrivacySettingsButton:setAlpha(0)
			f107_local9(f107_arg0.PrivacySettingsButton)
		end,
	},
}
CoD.StartMenu_Options.__onClose = function(f128_arg0)
	f128_arg0.Credits:close()
	f128_arg0.GraphicContent:close()
	f128_arg0.Muting:close()
	f128_arg0.Network:close()
	f128_arg0.Blackout:close()
	f128_arg0.Audio:close()
	f128_arg0.Graphics:close()
	f128_arg0.Controls:close()
	f128_arg0.QuitButtonCodcaster:close()
	f128_arg0.CoDAccount:close()
	f128_arg0.PrivacySettingsButton:close()
	f128_arg0.QuitButton:close()
	f128_arg0.DirectorGenericButton:close()
end
