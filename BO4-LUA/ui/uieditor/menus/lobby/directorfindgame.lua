require("x64:d13d1dd926408a1")
require("x64:f6ae994925ce8e1")
require("x64:d6084d285dc1ae8")
require("x64:ce1e6b6549d478c")
require("x64:e41af73729601d6")
require("x64:38c11a77e96e48c")
require("x64:c5412d93b9c5c17")
CoD.DirectorFindGame = InheritFrom(CoD.Menu)
LUI.createMenu.DirectorFindGame = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("DirectorFindGame", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.DirectorUtility.SetupDirectorFiltersCards(f1_local1, f1_arg0, self)
	self:setClass(CoD.DirectorFindGame)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local TEMPBlackBGOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TEMPBlackBGOverlay:setRGB(0, 0, 0)
	TEMPBlackBGOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	TEMPBlackBGOverlay:setShaderVector(0, 0.01, 0.5, 0, 0)
	self:addElement(TEMPBlackBGOverlay)
	self.TEMPBlackBGOverlay = TEMPBlackBGOverlay
	local OptionsList = LUI.UIList.new(f1_local1, f1_arg0, 20, 0, nil, false, false, false, false)
	OptionsList:setLeftRight(0.5, 0.5, -864, 292)
	OptionsList:setTopBottom(0.5, 0.5, -522, 522)
	OptionsList:setWidgetType(CoD.DirectorPlaylistOption)
	OptionsList:setHorizontalCount(3)
	OptionsList:setVerticalCount(4)
	OptionsList:setSpacing(20)
	OptionsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionsList:setVerticalCounter(CoD.verticalCounter)
	OptionsList:linkToElementModel(OptionsList, "locked", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	OptionsList:linkToElementModel(OptionsList, "lockState", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	OptionsList:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		return f4_local0
	end)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			ProcessListAction(self, element, controller, menu)
			GoBack(self, controller)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"]) then
			OpenSystemOverlay(self, menu, controller, "DownloadDLC", {
				_model = element:getModel(),
			})
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"]) then
			OpenSystemOverlay(self, menu, controller, "SeasonPassUpsell", {
				_model = element:getModel(),
				_description = @"hash_475EE3FCE54AF260",
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "locked") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(OptionsList, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"]) then
			CoD.StoreUtility.OpenStoreToDLCPack(self, element, controller, "DirectorFindGame", menu)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"]) then
			CoD.StoreUtility.OpenStoreToDLCPack(self, element, controller, "DirectorFindGame", menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"pls_required_dlc_not_available"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, "ui_contextual_1")
			return false
		elseif CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "lockState", Enum[@"playlistlockstate"][@"hash_4BDEB566326AC98"]) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_0", nil, "ui_contextual_1")
			return false
		else
			return false
		end
	end, false)
	self:addElement(OptionsList)
	self.OptionsList = OptionsList
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local BackingGrayMediumLeft = CoD.header_container_frontend.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 42)
	BackingGrayMediumLeft:registerEventHandler("menu_loaded", function(element, event)
		local f10_local0 = nil
		if element.menuLoaded then
			f10_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f10_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f10_local0 then
			f10_local0 = element:dispatchEventToChildren(event)
		end
		return f10_local0
	end)
	self:addElement(BackingGrayMediumLeft)
	self.BackingGrayMediumLeft = BackingGrayMediumLeft
	local SelectedPlaylistInfo = CoD.DirectorFindGamePlaylistInfoMP.new(f1_local1, f1_arg0, 0.5, 0.5, 324, 864, 0.5, 0.5, -255, 257)
	self:addElement(SelectedPlaylistInfo)
	self.SelectedPlaylistInfo = SelectedPlaylistInfo
	local DirectorHeaderTabSafeArea = CoD.DirectorHeaderTabSafeArea.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	DirectorHeaderTabSafeArea.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_538A4FBEBCE1E6BE"))
	DirectorHeaderTabSafeArea.Tabs.customClasssList:setDataSource("DirectorFilters")
	DirectorHeaderTabSafeArea:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DirectorHeaderTabSafeArea.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f11_local0))
		end
	end)
	DirectorHeaderTabSafeArea:registerEventHandler("menu_loaded", function(element, event)
		local f12_local0 = nil
		if element.menuLoaded then
			f12_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f12_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f12_local0 then
			f12_local0 = element:dispatchEventToChildren(event)
		end
		return f12_local0
	end)
	self:addElement(DirectorHeaderTabSafeArea)
	self.DirectorHeaderTabSafeArea = DirectorHeaderTabSafeArea
	local UpsellBanner = CoD.UpsellBanner.new(f1_local1, f1_arg0, 0, 0, 1284, 1824, 0, 0, 823.5, 973.5)
	self:addElement(UpsellBanner)
	self.UpsellBanner = UpsellBanner
	OptionsList:linkToElementModel(DirectorHeaderTabSafeArea.Tabs.customClasssList, "dataSource", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			OptionsList:setDataSource(f13_local0)
		end
	end)
	SelectedPlaylistInfo:linkToElementModel(OptionsList, nil, false, function(model)
		SelectedPlaylistInfo:setModel(model, f1_arg0)
	end)
	UpsellBanner:linkToElementModel(OptionsList, nil, false, function(model)
		UpsellBanner:setModel(model, f1_arg0)
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
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
	DirectorHeaderTabSafeArea.id = "DirectorHeaderTabSafeArea"
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
	local f1_local9 = self
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, self)
	CoD.DoubleXPUtility.SetupPromotionalXPTimer(f1_arg0, f1_local1)
	return self
end
CoD.DirectorFindGame.__onClose = function(f19_arg0)
	f19_arg0.SelectedPlaylistInfo:close()
	f19_arg0.UpsellBanner:close()
	f19_arg0.OptionsList:close()
	f19_arg0.FooterContainerFrontendRight:close()
	f19_arg0.BackingGrayMediumLeft:close()
	f19_arg0.DirectorHeaderTabSafeArea:close()
end
