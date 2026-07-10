require("x64:eda152e1d10147a")
require("x64:78d9663be3f826")
require("x64:9dc2d0c43534ce4")
require("x64:7889ce1e3e2e8a")
CoD.LeaguePlayLeaderboardMenu = InheritFrom(CoD.Menu)
LUI.createMenu.LeaguePlayLeaderboardMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LeaguePlayLeaderboardMenu", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.LeaguePlayLeaderboardMenu)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local TabFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	TabFrame:setLeftRight(0.5, 0.5, -960, 960)
	TabFrame:setTopBottom(0.5, 0.5, -540, 540)
	self:addElement(TabFrame)
	self.TabFrame = TabFrame
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x2E10828201D0AC))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local FETabBar = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0, 0, -377, 2297, 0.5, 0.5, -473, -424)
	FETabBar:setAlpha(0)
	FETabBar.Tabs.grid:setWidgetType(CoD.CommonTabButton)
	FETabBar.Tabs.grid:setHorizontalCount(4)
	FETabBar.Tabs.grid:setDataSource("LeaguePlayLeaderboardMenuTabs")
	FETabBar:registerEventHandler("menu_loaded", function(element, event)
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
	FETabBar:registerEventHandler("list_active_changed", function(element, event)
		local f4_local0 = nil
		CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, f1_local1, f1_arg0)
		return f4_local0
	end)
	self:addElement(FETabBar)
	self.FETabBar = FETabBar
	TabFrame:linkToElementModel(FETabBar.Tabs.grid, "tabWidget", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TabFrame:changeFrameWidget(f5_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	TabFrame.id = "TabFrame"
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	FETabBar.id = "FETabBar"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = TabFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local6 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.LeaguePlayLeaderboardMenu.__onClose = function(f8_arg0)
	f8_arg0.TabFrame:close()
	f8_arg0.Background:close()
	f8_arg0.GenericMenuFrame:close()
	f8_arg0.FETabBar:close()
end
