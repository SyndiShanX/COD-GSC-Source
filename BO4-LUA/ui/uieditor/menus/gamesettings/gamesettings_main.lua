require("x64:20a59255e4b7506")
require("x64:8ca32636a90f3ee")
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
		local f3_local0 = Engine[0xA5B9C0111291A8B]()
		CoD.perController[f3_local0].gamesettingsUpdated = true
		ForceLobbyButtonUpdate(f3_local0)
		Engine[0x6A489878620F3BC](Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "lobbyRoot.gameClient.update"))
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
	GameSettingsBackground.MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xBB7AA7A26F39DFA))
	GameSettingsBackground:subscribeToGlobalModel(f4_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			GameSettingsBackground.MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f5_local0))
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
		CoD.Menu.UpdateButtonShownState(f9_arg0, f4_local1, f4_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f9_arg0, f4_local1, f4_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f9_arg0, f4_local1, f4_arg0, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f9_arg0, f4_local1, f4_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
	end)
	local f4_local7 = self
	local f4_local8 = self.subscribeToModel
	local f4_local9 = Engine[0x4DF5CFBC1771947](f4_arg0)
	f4_local8(f4_local7, f4_local9.LastInput, function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f4_local1, f4_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f4_local1, f4_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f4_local1, f4_arg0, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		CoD.Menu.UpdateButtonShownState(f10_arg1, f4_local1, f4_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
	end, false)
	f4_local1:AddButtonCallbackFunction(self, f4_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.OptionsUtility.AreSpecialistOptionsValid(controller) then
			OpenSystemOverlay(self, menu, controller, "SaveCustomGameOptions", nil)
			return true
		elseif IsGamepad(controller) then
			CoD.OptionsUtility.ShowInvalidSpecialistOptionsDialog(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.OptionsUtility.AreSpecialistOptionsValid(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
			return true
		elseif IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f4_local1:AddButtonCallbackFunction(self, f4_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if IsGamepad(controller) then
			ResetGameSettings()
			PlaySoundAlias("uin_party_ease_slide")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xFA987631536BD44, Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 1500 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], nil)
			return true
		else
			return false
		end
	end, false)
	f4_local1:AddButtonCallbackFunction(self, f4_arg0, Enum[0x3DD78803F918E9D][0x4D2505E19049444], "ESCAPE", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and CoD.OptionsUtility.AreSpecialistOptionsValid(controller) then
			GoBack(self, controller)
			return true
		elseif IsMouseOrKeyboard(controller) then
			CoD.OptionsUtility.ShowInvalidSpecialistOptionsDialog(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and CoD.OptionsUtility.AreSpecialistOptionsValid(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		elseif IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x4D2505E19049444], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f4_local1:AddButtonCallbackFunction(self, f4_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "ui_contextual_2", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			OpenResetGameSettingsPopup(self, element, controller, "", menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0xFA987631536BD44, nil, "ui_contextual_2")
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
