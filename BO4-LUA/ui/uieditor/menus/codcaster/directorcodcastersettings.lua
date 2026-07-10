require("x64:eda152e1d10147a")
require("x64:20a59255e4b7506")
require("x64:7889ce1e3e2e8a")
CoD.DirectorCodCasterSettings = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorCodCasterSettings = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorCodCasterSettings", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Update", nil)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.Reset", nil)
	CoD.BaseUtility.InitGlobalModel("GametypeSettings.ResetTeam", nil)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "customGamesEdit", false)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "PlayerSettingsUpdate", nil)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.DirectorCodCasterSettings)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local f1_local3 = nil
	f1_local3 = LUI.UIElement.createFake()
	self.TabFrame = f1_local3
	local f1_local4 = nil
	local TabFramePC = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFramePC:setLeftRight(0.5, 0.5, -935.5, 918.5)
	TabFramePC:setTopBottom(0.5, 0.5, -421, 459)
	self:addElement(TabFramePC)
	self.TabFramePC = TabFramePC
	local CatgeoryTabs = CoD.CustomGames_CatgeoryTabs.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 98)
	CatgeoryTabs.TabBacking.TabBackingBlur:setAlpha(0)
	CatgeoryTabs.categoryTabsList:setDataSource("CodCasterDirectorSettingsTabs")
	CatgeoryTabs.categoryTabsListPC:setDataSource("CodCasterDirectorSettingsTabs")
	CatgeoryTabs:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(CatgeoryTabs)
	self.CatgeoryTabs = CatgeoryTabs
	local MenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.BGSceneBlur:setAlpha(1)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x7F41D0B1EB0400))
	MenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	f1_local3:linkToElementModel(CatgeoryTabs.categoryTabsList, "tabWidget", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			f1_local3:changeFrameWidget(f4_local0)
		end
	end)
	TabFramePC:linkToElementModel(CatgeoryTabs.categoryTabsListPC, "tabWidget", true, function(model)
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
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local9(f1_local8, f1_local10.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_2", function(element, menu, controller, model)
		if IsGamepad(controller) then
			CoD.CodCasterUtility.ResetCodcasterSettingsGamepad(controller, menu)
			PlaySoundAlias("uin_party_ease_slide")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0xFA987631536BD44, Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 750 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "ui_contextual_2", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.CodCasterUtility.OpenResetCodCasterSettingsPopup(self, element, controller, "", menu)
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
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		SaveShoutcasterSettings(self, element, controller)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "Z", function(element, menu, controller, model)
		if CoD.CodCasterUtility.CodcasterTeamIdentityShowingTeamSetting(controller, self.CatgeoryTabs) and CoD.CodCasterUtility.UseCustomTeamIdentity(controller) then
			CoD.CodCasterUtility.SwapTeamIdentity(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CodCasterUtility.CodcasterTeamIdentityShowingTeamSetting(controller, self.CatgeoryTabs) and CoD.CodCasterUtility.UseCustomTeamIdentity(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0xDD938AAB1C2D899, Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 400 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], "Z")
			return true
		else
			return false
		end
	end, false)
	f1_local3.id = "TabFrame"
	TabFramePC.id = "TabFramePC"
	CatgeoryTabs.id = "CatgeoryTabs"
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = f1_local3
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local9 = self
	if IsPC() then
		ChangeDefaultFocus(self, self.TabFramePC)
		ForceCheckDefaultPCFocus(self.TabFramePC, f1_local1, f1_arg0)
	end
	return self
end
CoD.DirectorCodCasterSettings.__onClose = function(f16_arg0)
	f16_arg0.TabFrame:close()
	f16_arg0.TabFramePC:close()
	f16_arg0.Background:close()
	f16_arg0.CatgeoryTabs:close()
	f16_arg0.MenuFrame:close()
end
