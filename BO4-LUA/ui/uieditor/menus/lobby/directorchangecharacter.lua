require("x64:eda152e1d10147a")
require("x64:abbd658ce01510c")
require("x64:78d9663be3f826")
CoD.DirectorChangeCharacter = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorChangeCharacter = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorChangeCharacter", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitGlobalModel("hudItems.specialistSwitchIsLethal", false)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BaseUtility.CreateControllerModel(f1_arg0, "PositionDraft.ResetOnCloseCharacterSelection")
	self:setClass(CoD.DirectorChangeCharacter)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/select_character"))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local FrameWidget = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	FrameWidget:setLeftRight(0.5, 0.5, -853.5, 864.5)
	FrameWidget:setTopBottom(0.5, 0.5, -408, 392)
	self:addElement(FrameWidget)
	self.FrameWidget = FrameWidget
	local CategoryTabs = CoD.Common_Tabbar_Center.new(f1_local1, f1_arg0, 0.5, 0.5, 120, 828, 0.5, 0.5, -361.5, -300.5)
	CategoryTabs.Tabs.grid:setHorizontalCount(3)
	CategoryTabs.Tabs.grid:setDataSource("WZCharacterCategories")
	CategoryTabs:registerEventHandler("grid_item_changed", function(element, event)
		local f3_local0 = nil
		CloseContextualMenu(f1_local1, f1_arg0)
		return f3_local0
	end)
	self:addElement(CategoryTabs)
	self.CategoryTabs = CategoryTabs
	local TabBottomLine = LUI.UIImage.new(0.5, 0.5, 80, 900, 0.5, 0.5, -310.5, -306.5)
	TabBottomLine:setAlpha(0.08)
	TabBottomLine:setImage(RegisterImage(@"uie_ui_menu_common_tab_line_bottom"))
	self:addElement(TabBottomLine)
	self.TabBottomLine = TabBottomLine
	local WZCharacterInfoContainer = CoD.WZCharacterInfoContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -853.5, -50.5, 0.5, 0.5, 165, 325)
	WZCharacterInfoContainer.CharacterSelectionCharacterInfo.CharacterFullName:setAlpha(0)
	WZCharacterInfoContainer:subscribeToGlobalModel(f1_arg0, "WZCharacterInfo", "infoModel", function(model)
		CoD.WZUtility.SetElementModelToControllerModelValue(WZCharacterInfoContainer, f1_arg0, "WZCharacterInfo.infoModel")
	end)
	self:addElement(WZCharacterInfoContainer)
	self.WZCharacterInfoContainer = WZCharacterInfoContainer
	FrameWidget:linkToElementModel(CategoryTabs.Tabs.grid, nil, false, function(model)
		FrameWidget:setModel(model, f1_arg0)
	end)
	FrameWidget:linkToElementModel(CategoryTabs.Tabs.grid, "frameWidget", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			FrameWidget:changeFrameWidget(f6_local0)
		end
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.CharacterBreadcrumbs.getModel(f1_arg0)
	f1_local8(f1_local7, f1_local9.breadcrumbCount, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"])
	end, false)
	self:registerEventHandler("occlusion_change", function(self, event)
		local f8_local0 = nil
		if self.OcclusionChange then
			f8_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f8_local0 = self.super:OcclusionChange(event)
		end
		if IsEventPropertyEqualTo(event, "occluded", true) then
			MenuUnhideFreeCursor(f1_local1, f1_arg0)
		elseif not IsPC() then
			MenuHidesFreeCursor(f1_local1, f1_arg0)
		end
		if not f8_local0 then
			f8_local0 = self:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		PositionDraftOnFocusCharacterLost(self, element, controller)
		GoBack(self, controller)
		CoD.LobbyUtility.SetMenuControllerRestriction(self, controller, 0)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, "ESCAPE")
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_rstick_pressed"], "ui_contextual_2", function(element, menu, controller, model)
		if not IsPC() then
			CoD.BaseUtility.UINoAction()
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and IsPC() then
			CoD.BreadcrumbUtility.ClearAllPersonalizationBreadcrumbs(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_0", nil, "ui_contextual_2")
			return false
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rstick_pressed"], @"hash_65619D8212EDA599", nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_self = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
		local f13_local0 = self
		SendClientScriptMenuChangeNotify(f13_arg1, f13_arg2, true)
		PositionDraftOnChangingCharacter(f13_arg1)
		CoD.BaseUtility.CreateControllerModel(f13_arg1, "PositionDraft.CloseCharacterSelection")
		CoD.LobbyUtility.SetMenuControllerRestriction(self, f13_arg1, 1)
		SetControllerModelValue(f13_arg1, "PositionDraft.ResetOnCloseCharacterSelection", 0)
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		PositionDraftClearFocusedCharacter(f1_arg0)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		ClearMenuSavedState(f1_local1)
		PositionDraftOnCloseCharacterSelection(f1_arg0)
	end)
	GenericMenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	FrameWidget.id = "FrameWidget"
	CategoryTabs.id = "CategoryTabs"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FrameWidget
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
	f1_local8 = self
	if not IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	end
	return self
end
CoD.DirectorChangeCharacter.__onClose = function(f16_arg0)
	f16_arg0.__on_close_removeOverrides()
	f16_arg0.FrameWidget:close()
	f16_arg0.GenericMenuFrame:close()
	f16_arg0.CategoryTabs:close()
	f16_arg0.WZCharacterInfoContainer:close()
end
