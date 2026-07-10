require("x64:20a59255e4b7506")
require("x64:8ca32636a90f3ee")
CoD.GameSettings_CACRestrictionSettings = InheritFrom(CoD.Menu)
LUI.createMenu.GameSettings_CACRestrictionSettings = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("GameSettings_CACRestrictionSettings", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.GameSettings_CACRestrictionSettings)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local GameSettingsBackground = CoD.GameSettings_Background.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GameSettingsBackground.BackingBlur:setAlpha(0)
	GameSettingsBackground.MenuFrame.CommonHeader.BGSceneBlur:setAlpha(0)
	GameSettingsBackground.MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x8B13CD4A57F560))
	GameSettingsBackground:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GameSettingsBackground.MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(GameSettingsBackground)
	self.GameSettingsBackground = GameSettingsBackground
	local f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.TabFrame = f1_local3
	local f1_local4 = nil
	local TabFramePC = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFramePC:setLeftRight(0.5, 0.5, -960, 960)
	TabFramePC:setTopBottom(0.5, 0.5, -408, 470)
	self:addElement(TabFramePC)
	self.TabFramePC = TabFramePC
	local CategoryTabs = CoD.CustomGames_CatgeoryTabs.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 98)
	CategoryTabs.TabBacking.TabBackingBlur:setAlpha(0)
	CategoryTabs.categoryTabsList:setHorizontalCount(6)
	CategoryTabs.categoryTabsList:setDataSource("CACRestrictionSettingsTabs")
	CategoryTabs.categoryTabsListPC:setHorizontalCount(6)
	CategoryTabs.categoryTabsListPC:setDataSource("CACRestrictionSettingsTabs")
	CategoryTabs:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(CategoryTabs)
	self.CategoryTabs = CategoryTabs
	f1_local3:linkToElementModel(CategoryTabs.categoryTabsList, "tabWidget", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			f1_local3:changeFrameWidget(f4_local0)
		end
	end)
	TabFramePC:linkToElementModel(CategoryTabs.categoryTabsListPC, "tabWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TabFramePC:changeFrameWidget(f5_local0)
		end
	end)
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
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
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "ui_contextual_2", function(element, menu, controller, model)
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
	self.__on_menuOpened_self = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		local f14_local0 = self
		CoD.OptionsUtility.SetCurrentCACCategoryTab(f14_arg2)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.OptionsUtility.ClearInfoModels()
		SetGlobalModelValueTrue("GametypeSettings.showLargePreview")
		SetGlobalModelValueFalse("GametypeSettings.showSmallPreview")
	end)
	GameSettingsBackground.MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		GameSettingsBackground.id = "GameSettingsBackground"
	end
	f1_local3.id = "TabFrame"
	TabFramePC.id = "TabFramePC"
	CategoryTabs.id = "CategoryTabs"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = f1_local3
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	self.__on_close_removeOverrides = function()
		f1_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.GameSettings_CACRestrictionSettings.__onClose = function(f17_arg0)
	f17_arg0.__on_close_removeOverrides()
	f17_arg0.TabFrame:close()
	f17_arg0.TabFramePC:close()
	f17_arg0.GameSettingsBackground:close()
	f17_arg0.CategoryTabs:close()
end
