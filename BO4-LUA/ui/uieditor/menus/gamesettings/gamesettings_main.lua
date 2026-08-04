require("ui/uieditor/widgets/customgames/customgames_catgeorytabs")
require("ui/uieditor/widgets/gamesettings/gamesettings_background")
local PostLoadFunc = function(f1_arg0, f1_arg1)
	f1_arg0.originalOcclusionChange = f1_arg0.m_eventHandlers.occlusion_change
	f1_arg0:registerEventHandler("occlusion_change", function(element, event)
		if not event.occluded and event.occludedBy.id ~= "Menu.GameSettings_OptionsMenu" and event.occludedBy.id ~= "Menu.MessageDialogBox" then
			element:processEvent({
				name = "lose_focus",
				controller = f1_arg1,
			})
			element:restoreState(f1_arg1)
		end
		element:originalOcclusionChange(event)
	end)
	LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "close", function()
		local f3_local0 = Engine.GetPrimaryController()
		CoD.perController[f3_local0].gamesettingsUpdated = true
		ForceLobbyButtonUpdate(f3_local0)
		Engine.ForceNotifyModelSubscriptions(Engine.GetModel(Engine.GetGlobalModel(), "lobbyRoot.gameClient.update"))
	end)
end
CoD.GameSettings_Main = InheritFrom(CoD.Menu)
LUI.createMenu.GameSettings_Main = function(f4_arg0, f4_arg1)
	local self = CoD.Menu.NewForUIEditor("GameSettings_Main", f4_arg0)
	local f4_local1 = self
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Update", nil)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Reset", nil)
	CoD.BaseUtility.InitControllerModel(f4_arg0, "customGamesEdit", false)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.showSmallPreview", false)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.showLargePreview", false)
	MenuHidesFreeCursor(f4_local1, f4_arg0)
	self:setClass(CoD.GameSettings_Main)
	self.soundSet = "ChooseDecal"
	self:setOwner(f4_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f4_arg0)
	self.anyChildUsesUpdateState = true
	local GameSettingsBackground = CoD.GameSettings_Background.new(f4_local1, f4_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GameSettingsBackground.BackingBlur:setAlpha(0)
	GameSettingsBackground.MenuFrame.CommonHeader.BGSceneBlur:setAlpha(0)
	GameSettingsBackground.MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_BB7AA7A26F39DFA"))
	GameSettingsBackground:subscribeToGlobalModel(f4_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GameSettingsBackground.MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(GameSettingsBackground)
	self.GameSettingsBackground = GameSettingsBackground
	local f4_local3 = nil
	f4_local3 = LUI.UIElement.createFake()
	self.TabFrame = f4_local3
	local f4_local4 = nil
	local TabFramePC = LUI.UIFrame.new(f4_local1, f4_arg0, 0, 0, false)
	TabFramePC:setLeftRight(0.5, 0.5, -960, 960)
	TabFramePC:setTopBottom(0.5, 0.5, -408, 470)
	self:addElement(TabFramePC)
	self.TabFramePC = TabFramePC
	local CatgeoryTabs = CoD.CustomGames_CatgeoryTabs.new(f4_local1, f4_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 98)
	CatgeoryTabs.TabBacking.TabBackingBlur:setAlpha(0)
	CatgeoryTabs:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f4_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(CatgeoryTabs)
	self.CatgeoryTabs = CatgeoryTabs
	f4_local3:linkToElementModel(CatgeoryTabs.categoryTabsList, "tabWidget", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			f4_local3:changeFrameWidget(f7_local0)
		end
	end)
	TabFramePC:linkToElementModel(CatgeoryTabs.categoryTabsListPC, "tabWidget", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			TabFramePC:changeFrameWidget(f8_local0)
		end
	end)
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f4_local1
		CoD.Menu.UpdateButtonShownState(f9_arg0, f4_local1, f4_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f9_arg0, f4_local1, f4_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f9_arg0, f4_local1, f4_arg0, Enum.LUIButton[@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f9_arg0, f4_local1, f4_arg0, Enum.LUIButton[@"lui_key_rtrig"])
	end)
	local f4_local7 = self
	local f4_local8 = self.subscribeToModel
	local f4_local9 = Engine.GetModelForController(f4_arg0)
	f4_local8(f4_local7, f4_local9.LastInput, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f4_local1, f4_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f4_local1, f4_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f4_local1, f4_arg0, Enum.LUIButton[@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f4_local1, f4_arg0, Enum.LUIButton[@"lui_key_rtrig"])
	end, false)
	f4_local1:AddButtonCallbackFunction(self, f4_arg0, Enum.LUIButton[@"lui_key_xbb_pscircle"], nil, function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
		if IsGamepad(f11_arg2) and CoD.OptionsUtility.AreSpecialistOptionsValid(f11_arg2) then
			OpenSystemOverlay(self, f11_arg1, f11_arg2, "SaveCustomGameOptions", nil)
			return true
		elseif IsGamepad(f11_arg2) then
			CoD.OptionsUtility.ShowInvalidSpecialistOptionsDialog(f11_arg2)
			return true
		else
		end
	end, function(f12_arg0, f12_arg1, f12_arg2)
		if IsGamepad(f12_arg2) and CoD.OptionsUtility.AreSpecialistOptionsValid(f12_arg2) then
			CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsGamepad(f12_arg2) then
			CoD.Menu.SetButtonLabel(f12_arg1, Enum.LUIButton[@"lui_key_xbb_pscircle"], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f4_local1:AddButtonCallbackFunction(self, f4_arg0, Enum.LUIButton[@"lui_key_xbx_pssquare"], nil, function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		if IsGamepad(f13_arg2) then
			ResetGameSettings()
			PlaySoundAlias("uin_party_ease_slide")
			return true
		else
		end
	end, function(f14_arg0, f14_arg1, f14_arg2)
		if IsGamepad(f14_arg2) then
			CoD.Menu.SetButtonLabel(f14_arg1, Enum.LUIButton[@"lui_key_xbx_pssquare"], "menu/reset_to_default", Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f4_local1:AddButtonCallbackFunction(self, f4_arg0, Enum.LUIButton[@"hash_64D2505E19049444"], "ESCAPE", function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
		if IsMouseOrKeyboard(f15_arg2) and CoD.OptionsUtility.AreSpecialistOptionsValid(f15_arg2) then
			GoBack(self, f15_arg2)
			return true
		elseif IsMouseOrKeyboard(f15_arg2) then
			CoD.OptionsUtility.ShowInvalidSpecialistOptionsDialog(f15_arg2)
			return true
		else
		end
	end, function(f16_arg0, f16_arg1, f16_arg2)
		if IsMouseOrKeyboard(f16_arg2) and CoD.OptionsUtility.AreSpecialistOptionsValid(f16_arg2) then
			CoD.Menu.SetButtonLabel(f16_arg1, Enum.LUIButton[@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(f16_arg2) then
			CoD.Menu.SetButtonLabel(f16_arg1, Enum.LUIButton[@"hash_64D2505E19049444"], @"menu/back", nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f4_local1:AddButtonCallbackFunction(self, f4_arg0, Enum.LUIButton[@"lui_key_rtrig"], "ui_contextual_2", function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
		if IsMouseOrKeyboard(f17_arg2) then
			OpenResetGameSettingsPopup(self, f17_arg0, f17_arg2, "", f17_arg1)
			return true
		else
		end
	end, function(f18_arg0, f18_arg1, f18_arg2)
		if IsMouseOrKeyboard(f18_arg2) then
			CoD.Menu.SetButtonLabel(f18_arg1, Enum.LUIButton[@"lui_key_rtrig"], "menu/reset_to_default", nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
		local f19_local0 = self
		CoD.OptionsUtility.ClearInfoModels()
	end
	f4_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	GameSettingsBackground.MenuFrame:setModel(self.buttonModel, f4_arg0)
	if CoD.isPC then
		GameSettingsBackground.id = "GameSettingsBackground"
	end
	f4_local3.id = "TabFrame"
	TabFramePC.id = "TabFramePC"
	CatgeoryTabs.id = "CatgeoryTabs"
	self:processEvent({
		name = "menu_loaded",
		controller = f4_arg0,
	})
	self.__defaultFocus = f4_local3
	if CoD.isPC and (IsKeyboard(f4_arg0) or self.ignoreCursor) then
		self:restoreState(f4_arg0)
	end
	self.__on_close_removeOverrides = function()
		f4_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f4_arg0)
	end
	return self
end
CoD.GameSettings_Main.__onClose = function(f21_arg0)
	f21_arg0.__on_close_removeOverrides()
	f21_arg0.TabFrame:close()
	f21_arg0.TabFramePC:close()
	f21_arg0.GameSettingsBackground:close()
	f21_arg0.CatgeoryTabs:close()
end
