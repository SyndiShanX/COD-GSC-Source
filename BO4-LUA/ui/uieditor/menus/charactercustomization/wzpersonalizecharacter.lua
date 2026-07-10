require("x64:eda152e1d10147a")
require("x64:71d2a0ed724628e")
require("x64:78f2de84a7ce73e")
require("x64:49eea36539ae3b3")
require("x64:75e2a524b093c12")
CoD.WZPersonalizeCharacter = InheritFrom(CoD.Menu)
LUI.createMenu.WZPersonalizeCharacter = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("WZPersonalizeCharacter", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, f1_local1, f1_arg1.model)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1.properties)
	SendClientScriptMenuExpressionStateChangeNotify(f1_arg0, f1_local1, true, f1_arg1.model.characterIndex:get())
	self:setClass(CoD.WZPersonalizeCharacter)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0.5, 0.5, 168, 918, 0.5, 0.5, -440, 160)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_246EFDF3FB2763B5"))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.outfits = f1_local4
	local f1_local5 = nil
	local outfitsPC = LUI.UIList.new(f1_local1, f1_arg0, 4, 0, nil, false, false, false, false)
	outfitsPC:setLeftRight(0.5, 0.5, -507, -219)
	outfitsPC:setTopBottom(0.5, 0.5, -347.5, 378.5)
	outfitsPC:setWidgetType(CoD.SpecialistOutfitItemEntry)
	outfitsPC:setHorizontalCount(4)
	outfitsPC:setVerticalCount(10)
	outfitsPC:setSpacing(4)
	outfitsPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	outfitsPC:linkToElementModel(outfitsPC, "owned", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	outfitsPC:linkToElementModel(outfitsPC, "itemType", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local f1_local7 = outfitsPC
	local f1_local8 = outfitsPC.subscribeToModel
	local themesPC = DataSources.MPSpecialistThemes.getModel(f1_arg0)
	f1_local8(f1_local7, themesPC.update, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	outfitsPC:linkToElementModel(outfitsPC, "itemIndex", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	outfitsPC:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	f1_local7 = outfitsPC
	f1_local8 = outfitsPC.subscribeToModel
	themesPC = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local8(f1_local7, themesPC.LastInput, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	outfitsPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "available") then
			CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistOutfitItem(f1_arg0, element)
		end
		return f9_local0
	end)
	outfitsPC:registerEventHandler("list_item_lose_focus", function(element, event)
		local f10_local0 = nil
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "available") then
			CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType(f1_arg0, element)
			CoD.BreadcrumbUtility.SetSpecialistOutfitItemAsOld(f1_local1, element, f1_arg0)
		else
			CoD.BreadcrumbUtility.SetSpecialistOutfitItemAsOld(f1_local1, element, f1_arg0)
		end
		return f10_local0
	end)
	outfitsPC:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
		return f11_local0
	end)
	f1_local1:AddButtonCallbackFunction(outfitsPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CoD.PlayerRoleUtility.EquipOutfitItem(menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/equip", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(outfitsPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "itemType", Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, controller) and IsGamepad(controller) then
			CoD.PlayerRoleUtility.UnequipOutfitItem(menu, controller, element)
			CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "itemType", Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(outfitsPC, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_remove", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "itemType", Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, controller) and IsMouseOrKeyboard(controller) then
			CoD.PlayerRoleUtility.UnequipOutfitItem(menu, controller, element)
			CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "itemType", Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"menu/remove", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	outfitsPC:AddContextualMenuAction(f1_local1, f1_arg0, @"menu/remove", function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f18_arg0, f18_arg2, "itemType", Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(f18_arg0, f18_arg2) then
			return function(f19_arg0, f19_arg1, f19_arg2, f19_arg3)
				PlaySoundAlias("uin_cac_equip_remove")
				CoD.PlayerRoleUtility.UnequipOutfitItem(f19_arg1, f19_arg2, f19_arg0)
				CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType(f19_arg2, f19_arg0)
			end
		else
		end
	end)
	self:addElement(outfitsPC)
	self.outfitsPC = outfitsPC
	f1_local8 = nil
	f1_local8 = LUI.UIElement.createFake()
	self.themes = f1_local8
	f1_local7 = nil
	themesPC = LUI.UIList.new(f1_local1, f1_arg0, 4, 0, nil, false, false, false, false)
	themesPC:setLeftRight(0.5, 0.5, -813, -533)
	themesPC:setTopBottom(0.5, 0.5, -347.5, 232.5)
	themesPC:setWidgetType(CoD.SpecialistOutfitCategory)
	themesPC:setVerticalCount(8)
	themesPC:setSpacing(4)
	themesPC:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	themesPC:setDataSource("ZMOutfitCategories")
	themesPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f20_local0 = nil
		CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistOutfit(f1_arg0, element)
		return f20_local0
	end)
	themesPC:registerEventHandler("gain_focus", function(element, event)
		local f21_local0 = nil
		if element.gainFocus then
			f21_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f21_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f21_local0
	end)
	f1_local1:AddButtonCallbackFunction(themesPC, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		CoD.PlayerRoleUtility.EquipOutfit(menu, controller, element)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
		return true
	end, false)
	self:addElement(themesPC)
	self.themesPC = themesPC
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f24_local0 = nil
		if element.menuLoaded then
			f24_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f24_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f24_local0 then
			f24_local0 = element:dispatchEventToChildren(event)
		end
		return f24_local0
	end)
	self:addElement(CommonIdentityWidgetStreamlinedSafeAreaContainer)
	self.CommonIdentityWidgetStreamlinedSafeAreaContainer = CommonIdentityWidgetStreamlinedSafeAreaContainer
	f1_local4:linkToElementModel(f1_local8, "datasourceName", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			f1_local4:setDataSource(f25_local0)
		end
	end)
	outfitsPC:linkToElementModel(themesPC, "datasourceName", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			outfitsPC:setDataSource(f26_local0)
		end
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		ClearMenuSavedState(f1_local1)
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	f1_local4.id = "outfits"
	outfitsPC.id = "outfitsPC"
	f1_local8.id = "themes"
	themesPC.id = "themesPC"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = f1_local8
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local11 = self
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, f1_local4, self.themesPC)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, outfitsPC, self.themesPC)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local8, self.outfitsPC)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, themesPC, self.outfitsPC)
	return self
end
CoD.WZPersonalizeCharacter.__onClose = function(f30_arg0)
	f30_arg0.outfits:close()
	f30_arg0.outfitsPC:close()
	f30_arg0.XCamMouseControl:close()
	f30_arg0.GenericMenuFrame:close()
	f30_arg0.themes:close()
	f30_arg0.themesPC:close()
	f30_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
end
