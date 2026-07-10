require("x64:d6ecdf7755aeddc")
require("x64:a6e027ec2d1bee7")
require("x64:ce1e6b6549d478c")
require("x64:7889ce1e3e2e8a")
CoD.DirectorChooseMapAndGameType = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorChooseMapAndGameType = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorChooseMapAndGameType", f1_arg0)
	local f1_local1 = self
	CoD.MapUtility.UpdateSelectedGametypeModel(f1_arg0)
	CoD.BaseUtility.InitControllerModel(f1_arg0, "mapModeSelection", false)
	self:setClass(CoD.DirectorChooseMapAndGameType)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CommonHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 67)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyMainMode", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(CoD.DirectorUtility.ConvertLobbyMainModeToModeString(f3_local0)))
		end
	end)
	CommonHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	CommonHeader:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local OptionsFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	OptionsFrame:setLeftRight(0.5, 0.5, -960, 960)
	OptionsFrame:setTopBottom(0.5, 0.5, -390, 414)
	self:addElement(OptionsFrame)
	self.OptionsFrame = OptionsFrame
	local CategoryTabs = CoD.DirectorTabHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 98)
	CategoryTabs.TabBacking.TabBackingBlur:setAlpha(0)
	CategoryTabs.tabsList:setHorizontalCount(2)
	CategoryTabs.tabsList:setDataSource("CustomGamesMapModeTabs")
	CategoryTabs:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(CategoryTabs)
	self.CategoryTabs = CategoryTabs
	OptionsFrame:linkToElementModel(CategoryTabs.tabsList, "frameWidget", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			OptionsFrame:changeFrameWidget(f7_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if AlwaysFalse() then
			return true
		else
		end
	end, function(element, menu, controller)
		if AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	OptionsFrame.id = "OptionsFrame"
	CategoryTabs.id = "CategoryTabs"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = OptionsFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local7 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	return self
end
CoD.DirectorChooseMapAndGameType.__onClose = function(f13_arg0)
	f13_arg0.OptionsFrame:close()
	f13_arg0.Background:close()
	f13_arg0.FooterContainerFrontendRight:close()
	f13_arg0.CommonHeader:close()
	f13_arg0.CategoryTabs:close()
end
