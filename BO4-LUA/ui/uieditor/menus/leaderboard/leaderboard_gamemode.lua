require("x64:db806626fb64f10")
require("x64:78d9663be3f826")
require("x64:81a24c5340caa1e")
require("x64:26953ab49613c9")
require("x64:7889ce1e3e2e8a")
local PostLoadFunc = function(f1_arg0, f1_arg1)
	f1_arg0:subscribeToModel(Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "FilterInfo"), function(model)
		f1_arg0.CurrentFilterInfo:setText(Engine[0x614D394F6F9A18D](model) or "")
	end)
end
CoD.Leaderboard_GameMode = InheritFrom(CoD.Menu)
LUI.createMenu.Leaderboard_GameMode = function(f3_arg0, f3_arg1)
	local self = CoD.Menu.NewForUIEditor("Leaderboard_GameMode", f3_arg0)
	local f3_local1 = self
	self:setClass(CoD.Leaderboard_GameMode)
	self.soundSet = "CAC_PrimaryWeapon"
	self:setOwner(f3_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f3_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f3_local1, f3_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local TabFrame = LUI.UIFrame.new(f3_local1, f3_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -812.5, 912.5)
	TabFrame:setTopBottom(0.5, 0.5, -331.5, 448.5)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local MenuFrame = CoD.GenericMenuFrameIdentity.new(f3_local1, f3_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	MenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0xFE3665244ECF33B))
	MenuFrame:subscribeToGlobalModel(f3_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self.__on_menuOpened_MenuFrame = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3)
		local f5_local0 = MenuFrame
		ShowHeaderIconOnly(f5_arg2)
	end
	f3_local1:addMenuOpenedCallback(self.__on_menuOpened_MenuFrame)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local GameModeTabs = CoD.Common_Tabbar_Center.new(f3_local1, f3_arg0, 0.5, 0.5, -1650, 1650, 0, 0, 37, 98)
	GameModeTabs:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsOfflineOnlyDemo() and InFrontend()
			end,
		},
	})
	GameModeTabs:appendEventHandler("grid_updated", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f3_local1
		f3_local1:updateElementState(GameModeTabs, f7_arg1)
	end)
	GameModeTabs:appendEventHandler("input_source_changed", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f3_local1
		f3_local1:updateElementState(GameModeTabs, f8_arg1)
	end)
	local TabBacking = GameModeTabs
	local CurrentFilterInfo = GameModeTabs.subscribeToModel
	local LeaderboardWarningText = Engine[0x4DF5CFBC1771947](f3_arg0)
	CurrentFilterInfo(TabBacking, LeaderboardWarningText.LastInput, function(f9_arg0)
		f3_local1:updateElementState(GameModeTabs, {
			name = "model_validation",
			menu = f3_local1,
			controller = f3_arg0,
			modelValue = f9_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	GameModeTabs.Tabs.grid:setDataSource("LeaderboardGameModeTabs")
	GameModeTabs:registerEventHandler("list_active_changed", function(element, event)
		local f10_local0 = nil
		CoD.LeaderboardUtility.LeaderboardGameModeTabChanged(self, element, f3_arg0)
		return f10_local0
	end)
	self:addElement(GameModeTabs)
	self.GameModeTabs = GameModeTabs
	CurrentFilterInfo = LUI.UIText.new(0, 0, 1050, 1350, 0, 0, 172, 193)
	CurrentFilterInfo:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CurrentFilterInfo:setText(Engine[0xF9F1239CFD921FE](0x31CF0F51CCA3A27))
	CurrentFilterInfo:setTTF("ttmussels_regular")
	CurrentFilterInfo:setLetterSpacing(0.5)
	CurrentFilterInfo:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	CurrentFilterInfo:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CurrentFilterInfo)
	self.CurrentFilterInfo = CurrentFilterInfo
	TabBacking = CoD.CommonTabBarBacking.new(f3_local1, f3_arg0, 0, 1, 0, 0, 0, 0, 52, 89)
	TabBacking.TabBackingBlur:setAlpha(0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	LeaderboardWarningText = CoD.Leaderboard_WarningText.new(f3_local1, f3_arg0, 0, 1, 0, 0, 1, 1, -129, -54)
	LeaderboardWarningText:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	LeaderboardWarningText:registerEventHandler("menu_loaded", function(element, event)
		local f12_local0 = nil
		if element.menuLoaded then
			f12_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f12_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f3_arg0)
		if not f12_local0 then
			f12_local0 = element:dispatchEventToChildren(event)
		end
		return f12_local0
	end)
	self:addElement(LeaderboardWarningText)
	self.LeaderboardWarningText = LeaderboardWarningText
	TabFrame:linkToElementModel(GameModeTabs.Tabs.grid, "tabWidget", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			TabFrame:changeFrameWidget(f13_local0)
		end
	end)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f14_local0 = nil
		if self.menuLoaded then
			f14_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f14_local0 = self.super:menuLoaded(event)
		end
		if CoD.LeaderboardUtility.IsLobbyLeaderboard(f3_arg0) then
			ShowHeaderKickerAndIcon(f3_local1)
			SetHeadingKickerText(0xDE4B1936ABC08E4)
			MenuHidesFreeCursor(f3_local1, f3_arg0)
			PlaySoundAlias("uin_paint_decal_nav")
		else
			ShowHeaderKickerAndIcon(f3_local1)
			CombatRecordSetHeadingKickerTextToCombatRecordGameMode()
			MenuHidesFreeCursor(f3_local1, f3_arg0)
			PlaySoundAlias("uin_paint_decal_nav")
		end
		if not f14_local0 then
			f14_local0 = self:dispatchEventToChildren(event)
		end
		return f14_local0
	end)
	f3_local1:AddButtonCallbackFunction(self, f3_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		PlaySoundAlias("uin_paint_decal_nav")
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
		return true
	end, false)
	TabFrame.id = "TabFrame"
	MenuFrame:setModel(self.buttonModel, f3_arg0)
	MenuFrame.id = "MenuFrame"
	GameModeTabs.id = "GameModeTabs"
	self:processEvent({
		name = "menu_loaded",
		controller = f3_arg0,
	})
	self.__defaultFocus = TabFrame
	if CoD.isPC and (IsKeyboard(f3_arg0) or self.ignoreCursor) then
		self:restoreState(f3_arg0)
	end
	self.__on_close_removeOverrides = function()
		f3_local1:removeMenuOpenedCallback(self.__on_menuOpened_MenuFrame)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg0)
	end
	return self
end
CoD.Leaderboard_GameMode.__onClose = function(f18_arg0)
	f18_arg0.__on_close_removeOverrides()
	f18_arg0.TabFrame:close()
	f18_arg0.Background:close()
	f18_arg0.MenuFrame:close()
	f18_arg0.GameModeTabs:close()
	f18_arg0.TabBacking:close()
	f18_arg0.LeaderboardWarningText:close()
end
