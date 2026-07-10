require("x64:78d9663be3f826")
require("x64:d6ecdf7755aeddc")
require("x64:d13d1dd926408a1")
require("x64:d6084d285dc1ae8")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
CoD.DirectorFindGameWZ = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorFindGameWZ = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorFindGameWZ", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.DirectorUtility.SetupDirectorFiltersCards(f1_local1, f1_arg0, self)
	self:setClass(CoD.DirectorFindGameWZ)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local TEMPBlackBGOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TEMPBlackBGOverlay:setRGB(0, 0, 0)
	TEMPBlackBGOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	TEMPBlackBGOverlay:setShaderVector(0, 0.01, 0.5, 0, 0)
	self:addElement(TEMPBlackBGOverlay)
	self.TEMPBlackBGOverlay = TEMPBlackBGOverlay
	local SelectedPlaylistInfo = CoD.DirectorFindGamePlaylistInfoMP.new(f1_local1, f1_arg0, 0.5, 0.5, 324, 864, 0.5, 0.5, -256, 256)
	SelectedPlaylistInfo.DoubleXPIcons.PlaylistInfo.warningText3:setAlpha(0)
	SelectedPlaylistInfo.DoubleXPIcons.PlaylistInfo.warningText:setAlpha(0)
	self:addElement(SelectedPlaylistInfo)
	self.SelectedPlaylistInfo = SelectedPlaylistInfo
	local OptionsList = LUI.UIList.new(f1_local1, f1_arg0, 20, 0, nil, false, false, false, false)
	OptionsList:setLeftRight(0.5, 0.5, -864, 292)
	OptionsList:setTopBottom(0.5, 0.5, -522, 522)
	OptionsList:setWidgetType(CoD.DirectorPlaylistOption)
	OptionsList:setHorizontalCount(3)
	OptionsList:setVerticalCount(4)
	OptionsList:setSpacing(20)
	OptionsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionsList:linkToElementModel(OptionsList, "locked", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	OptionsList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.DirectorUtility.PartyExceedsPlaylistMax(element) then
			return true
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			ProcessListAction(self, element, controller, menu)
			GoBack(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.DirectorUtility.PartyExceedsPlaylistMax(element) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_confirm")
			return false
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(OptionsList)
	self.OptionsList = OptionsList
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local CACHeader = CoD.CommonHeader.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CACHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x38A4FBEBCE1E6BE))
	CACHeader.subtitle.subtitle:setAlpha(0)
	CACHeader:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CACHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f7_local0))
		end
	end)
	CACHeader:registerEventHandler("menu_loaded", function(element, event)
		local f8_local0 = nil
		if element.menuLoaded then
			f8_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f8_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self:addElement(CACHeader)
	self.CACHeader = CACHeader
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local FETabBar = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0, 0, -262, 2412, 0.5, 0.5, -473, -406)
	FETabBar:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.DirectorUtility.MultiplePlaylistTabsAvailable(f1_arg0)
			end,
		},
	})
	FETabBar:appendEventHandler("grid_updated", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_local1
		f1_local1:updateElementState(FETabBar, f11_arg1)
	end)
	FETabBar:appendEventHandler("input_source_changed", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_local1
		f1_local1:updateElementState(FETabBar, f12_arg1)
	end)
	local f1_local9 = FETabBar
	local GridLayout = FETabBar.subscribeToModel
	local f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg0)
	GridLayout(f1_local9, f1_local11.LastInput, function(f13_arg0)
		f1_local1:updateElementState(FETabBar, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	FETabBar.Tabs.grid:setHorizontalCount(8)
	FETabBar.Tabs.grid:setDataSource("DirectorFilters")
	FETabBar:registerEventHandler("menu_loaded", function(element, event)
		local f14_local0 = nil
		if element.menuLoaded then
			f14_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f14_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f14_local0 then
			f14_local0 = element:dispatchEventToChildren(event)
		end
		return f14_local0
	end)
	FETabBar:registerEventHandler("list_active_changed", function(element, event)
		local f15_local0 = nil
		CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_local1, f1_local1, f1_arg0)
		return f15_local0
	end)
	self:addElement(FETabBar)
	self.FETabBar = FETabBar
	GridLayout = LUI.GridLayout.new(f1_local1, f1_arg0, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	GridLayout:setLeftRight(0, 0, 2541.5, 2541.5)
	GridLayout:setTopBottom(0, 0, -294, -294)
	GridLayout:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(GridLayout)
	self.GridLayout = GridLayout
	SelectedPlaylistInfo:linkToElementModel(OptionsList, nil, false, function(model)
		SelectedPlaylistInfo:setModel(model, f1_arg0)
	end)
	OptionsList:linkToElementModel(FETabBar.Tabs.grid, "dataSource", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			OptionsList:setDataSource(f17_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	OptionsList.id = "OptionsList"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	FETabBar.id = "FETabBar"
	GridLayout.id = "GridLayout"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = OptionsList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local9 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	SetElementProperty(OptionsList, "ignoreSavedActive", true)
	return self
end
CoD.DirectorFindGameWZ.__onClose = function(f21_arg0)
	f21_arg0.SelectedPlaylistInfo:close()
	f21_arg0.OptionsList:close()
	f21_arg0.FooterContainerFrontendRight:close()
	f21_arg0.CACHeader:close()
	f21_arg0.BackingGrayMediumLeft:close()
	f21_arg0.FETabBar:close()
	f21_arg0.GridLayout:close()
end
