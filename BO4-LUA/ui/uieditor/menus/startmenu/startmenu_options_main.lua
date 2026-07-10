require("x64:71d4e66447f837e")
require("x64:d6ecdf7755aeddc")
require("x64:a6e027ec2d1bee7")
require("x64:e41af73729601d6")
require("x64:7889ce1e3e2e8a")
require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.StartMenu_Options_Main = InheritFrom(CoD.Menu)
LUI.createMenu.StartMenu_Options_Main = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("StartMenu_Options_Main", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitControllerModelEnumIfNotSet(f1_arg0, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BLANK)
	self:setClass(CoD.StartMenu_Options_Main)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = CoD.StartMenuOptionsBackground.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local BGFrame = CoD.StartMenuOptionsMainFrame.new(f1_local1, f1_arg0, 0, 0, 834.5, 1861.5, 0, 0, 166, 974)
	BGFrame:setAlpha(0)
	self:addElement(BGFrame)
	self.BGFrame = BGFrame
	local BGCorner = CoD.StartMenuOptionsMainCorners.new(f1_local1, f1_arg0, 0, 0, 834.5, 1861.5, 0, 0, 166, 974)
	BGCorner:setAlpha(0)
	self:addElement(BGCorner)
	self.BGCorner = BGCorner
	local MenuFrame = CoD.MenuFrameIngame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	self:addElement(MenuFrame)
	self.MenuFrame = MenuFrame
	local Header = CoD.CommonHeader.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 67)
	Header.BGSceneBlur:setAlpha(0)
	Header.subtitle.subtitle:setAlpha(0)
	Header:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Header.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	Header:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(Header)
	self.Header = Header
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local OptionsFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	OptionsFrame:setLeftRight(0, 0, 0, 1920)
	OptionsFrame:setTopBottom(0, 0, 135, 1025)
	self:addElement(OptionsFrame)
	self.OptionsFrame = OptionsFrame
	local CategoryTabs = CoD.DirectorTabHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 98)
	CategoryTabs.TabBacking.TabBackingBlur:setAlpha(0)
	CategoryTabs.tabsList:setDataSource("PlayerOptionsTabs")
	CategoryTabs:registerEventHandler("menu_loaded", function(element, event)
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
	self:addElement(CategoryTabs)
	self.CategoryTabs = CategoryTabs
	Header:linkToElementModel(CategoryTabs.tabsList, "tabName", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Header.subtitle.StageTitle:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	OptionsFrame:linkToElementModel(CategoryTabs.tabsList, "frameWidget", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			OptionsFrame:changeFrameWidget(f7_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		UpdateGamerprofile(self, element, controller)
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if AlwaysFalse() then
			return true
		else
		end
	end, function(element, menu, controller)
		if AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
			return false
		else
			return false
		end
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
	MenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		MenuFrame.id = "MenuFrame"
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
	local f1_local10 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	CoD.BaseUtility.SelfShowsBuildInfo(self)
	return self
end
CoD.StartMenu_Options_Main.__onClose = function(f14_arg0)
	f14_arg0.Header:close()
	f14_arg0.OptionsFrame:close()
	f14_arg0.Background:close()
	f14_arg0.BGFrame:close()
	f14_arg0.BGCorner:close()
	f14_arg0.MenuFrame:close()
	f14_arg0.BackingGrayMediumLeft:close()
	f14_arg0.CategoryTabs:close()
end
