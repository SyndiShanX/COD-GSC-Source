require("x64:b8e2ca68acca1fd")
require("x64:fbffc86e9a93477")
require("x64:9b604203d6c4ff6")
require("x64:71d2a0ed724628e")
require("x64:38c11a77e96e48c")
require("x64:353b9b389ee7deb")
require("x64:26a47811f4155e")
require("x64:d133f51b6524f7a")
require("x64:75e2a524b093c12")
CoD.PersonalizeCharacter = InheritFrom(CoD.Menu)
LUI.createMenu.PersonalizeCharacter = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PersonalizeCharacter", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetModelFromUserData(f1_arg0, f1_local1, f1_arg1.model)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1.properties)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	CoD.PlayerRoleUtility.LoadMenuCharacter(f1_local1, f1_arg0)
	self:setClass(CoD.PersonalizeCharacter)
	self.soundSet = "FrontendMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_local1, f1_arg0, 0.5, 0.5, 1, 961, 0.5, 0.5, -440, 160)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local InfoPanel = CoD.BM_ItemInfoPanel.new(f1_local1, f1_arg0, 0.5, 0.5, 273, 813, 0.5, 0.5, 270, 420)
	self:addElement(InfoPanel)
	self.InfoPanel = InfoPanel
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.outfits = f1_local4
	local f1_local5 = nil
	local outfitsPC = LUI.UIList.new(f1_local1, f1_arg0, 3, 0, nil, false, false, false, false)
	outfitsPC:setLeftRight(0.5, 0.5, -508, 1)
	outfitsPC:setTopBottom(0.5, 0.5, -315.5, 293.5)
	outfitsPC:setWidgetType(CoD.SpecialistOutfitEntry)
	outfitsPC:setHorizontalCount(4)
	outfitsPC:setVerticalCount(4)
	outfitsPC:setSpacing(3)
	outfitsPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	outfitsPC:linkToElementModel(outfitsPC, "owned", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	outfitsPC:linkToElementModel(outfitsPC, "itemType", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	local f1_local7 = outfitsPC
	local f1_local8 = outfitsPC.subscribeToModel
	local themesPC = DataSources.MPSpecialistThemes.getModel(f1_arg0)
	f1_local8(f1_local7, themesPC.update, function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	outfitsPC:linkToElementModel(outfitsPC, "itemIndex", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	outfitsPC:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f6_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	f1_local7 = outfitsPC
	f1_local8 = outfitsPC.subscribeToModel
	themesPC = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, themesPC.LastInput, function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	outfitsPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f8_local0 = nil
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "available") then
			CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistOutfitItem(f1_arg0, element)
			SetElementModelToFocusedElementModel(f1_arg0, self, element, "InfoPanel")
		else
			SetElementModelToFocusedElementModel(f1_arg0, self, element, "InfoPanel")
		end
		return f8_local0
	end)
	outfitsPC:registerEventHandler("list_item_lose_focus", function(element, event)
		local f9_local0 = nil
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg0, "available") then
			CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType(f1_arg0, element)
			CoD.BreadcrumbUtility.SetSpecialistOutfitItemAsOld(f1_local1, element, f1_arg0)
		else
			CoD.BreadcrumbUtility.SetSpecialistOutfitItemAsOld(f1_local1, element, f1_arg0)
		end
		return f9_local0
	end)
	outfitsPC:registerEventHandler("gain_focus", function(element, event)
		local f10_local0 = nil
		if element.gainFocus then
			f10_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f10_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		return f10_local0
	end)
	f1_local1:AddButtonCallbackFunction(outfitsPC, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			PlaySoundAlias("uin_cac_equip_base")
			CoD.PlayerRoleUtility.EquipOutfitItem(menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xBDF67DCF97EBC09, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(outfitsPC, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_remove", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "itemType", Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, controller) and IsGamepad(controller) then
			PlaySoundAlias("uin_cac_equip_remove")
			CoD.PlayerRoleUtility.UnequipOutfitItem(menu, controller, element)
			CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType(controller, element)
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "itemType", Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, controller) then
			PlaySoundAlias("uin_cac_equip_remove")
			CoD.PlayerRoleUtility.UnequipOutfitItem(menu, controller, element)
			CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "itemType", Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, nil, "ui_remove")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "itemType", Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x679ACA6FFC6C8F3, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	outfitsPC:subscribeToGlobalModel(f1_arg0, "MPOutfitCategories", "selectedCategory", function(model)
		UpdateSelfElementState(f1_local1, outfitsPC, f1_arg0)
	end)
	outfitsPC:AddContextualMenuAction(f1_local1, f1_arg0, 0x679ACA6FFC6C8F3, function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f16_arg0, f16_arg2, "itemType", Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B]) and CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex(f16_arg0, f16_arg2) then
			return function(f17_arg0, f17_arg1, f17_arg2, f17_arg3)
				PlaySoundAlias("uin_cac_equip_remove")
				CoD.PlayerRoleUtility.UnequipOutfitItem(f17_arg1, f17_arg2, f17_arg0)
				CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType(f17_arg2, f17_arg0)
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
	themesPC = LUI.UIList.new(f1_local1, f1_arg0, 8, 0, nil, false, false, false, false)
	themesPC:setLeftRight(0.5, 0.5, -813, -533)
	themesPC:setTopBottom(0.5, 0.5, -316.5, 291.5)
	themesPC:setWidgetType(CoD.SpecialistThemeButton)
	themesPC:setVerticalCount(8)
	themesPC:setSpacing(8)
	themesPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	themesPC:setDataSource("MPSpecialistThemes")
	themesPC:linkToElementModel(themesPC, "disabled", true, function(model, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	themesPC:registerEventHandler("list_item_gain_focus", function(element, event)
		local f19_local0 = nil
		CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistOutfit(f1_arg0, element)
		SetElementModelToFocusedElementModel(f1_arg0, self, element, "InfoPanel")
		return f19_local0
	end)
	themesPC:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f20_local0
	end)
	f1_local1:AddButtonCallbackFunction(themesPC, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") then
			PlaySoundAlias("uin_cac_equip_base")
			CoD.PlayerRoleUtility.EquipOutfit(menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "disabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(themesPC, "updateDataSource", function(element, controller, f23_arg2, f23_arg3)
		CoD.GridAndListUtility.HideSubListIfParentListIsEmpty(element, self.outfitsPC, f1_arg0)
	end)
	self:addElement(themesPC)
	self.themesPC = themesPC
	local CommonIdentityWidgetStreamlinedSafeAreaContainer = CoD.CommonIdentityWidgetStreamlinedSafeAreaContainer.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 1080)
	CommonIdentityWidgetStreamlinedSafeAreaContainer:setAlpha(0)
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
	local f1_local11 = nil
	f1_local11 = LUI.UIElement.createFake()
	self.outfitsVerticalCounter = f1_local11
	local outfitsVerticalCounterPC = nil
	outfitsVerticalCounterPC = CoD.verticalCounter.new(f1_local1, f1_arg0, 0.5, 0.5, -396, -96, 0.5, 0.5, 326.5, 363.5)
	self:addElement(outfitsVerticalCounterPC)
	self.outfitsVerticalCounterPC = outfitsVerticalCounterPC
	local f1_local13 = nil
	f1_local13 = LUI.UIElement.createFake()
	self.themeVerticalCounter = f1_local13
	local themeVerticalCounterPC = nil
	themeVerticalCounterPC = CoD.verticalCounter.new(f1_local1, f1_arg0, 0.5, 0.5, -823, -523, 0.5, 0.5, 326.5, 363.5)
	self:addElement(themeVerticalCounterPC)
	self.themeVerticalCounterPC = themeVerticalCounterPC
	local f1_local15 = nil
	f1_local15 = LUI.UIElement.createFake()
	self.SpecialistDecalSelector = f1_local15
	local SpecialistDecalSelectorPC = nil
	SpecialistDecalSelectorPC = CoD.SpecialistDecalSelector.new(f1_local1, f1_arg0, 0.5, 0.5, 273, 813, 0.5, 0.5, 104, 254)
	self:addElement(SpecialistDecalSelectorPC)
	self.SpecialistDecalSelectorPC = SpecialistDecalSelectorPC
	local SafeareaContainer = CoD.PersonalizeCharacter_SafeAreaContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	SafeareaContainer:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			SafeareaContainer.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f25_local0))
		end
	end)
	SafeareaContainer:linkToElementModel(self, "name", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			SafeareaContainer.CommonHeader.subtitle.StageTitle:setText(ToUpper(LocalizeIntoString(0x1D2B357848A1F60, f26_local0)))
		end
	end)
	SafeareaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f27_local0 = nil
		if element.menuLoaded then
			f27_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f27_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f27_local0 then
			f27_local0 = element:dispatchEventToChildren(event)
		end
		return f27_local0
	end)
	SafeareaContainer:registerEventHandler("list_active_changed", function(element, event)
		local f28_local0 = nil
		CoD.PlayerRoleUtility.ResetCurrentCharacterCustomization(f1_arg0)
		local f28_local1 = CoD.ModelUtility.SetGlobalDatasourceModelValue
		local f28_local2 = f1_arg0
		local f28_local3 = "MPOutfitCategories"
		local f28_local4 = "selectedCategory"
		local f28_local5 = element:getModel()
		f28_local1(f28_local2, f28_local3, f28_local4, f28_local5.category:get())
		SendClientScriptMenuExpressionStateChangeNotify(f1_arg0, f1_local1, true, CoD.SafeGetModelValue(element:getModel(), "camera") or "character")
		return f28_local0
	end)
	self:addElement(SafeareaContainer)
	self.SafeareaContainer = SafeareaContainer
	f1_local4:linkToElementModel(f1_local8, "datasourceName", true, function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			f1_local4:setDataSource(f29_local0)
		end
	end)
	outfitsPC:linkToElementModel(themesPC, "datasourceName", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			outfitsPC:setDataSource(f30_local0)
		end
	end)
	f1_local15:linkToElementModel(f1_local8, nil, false, function(model)
		f1_local15:setModel(model, f1_arg0)
	end)
	SpecialistDecalSelectorPC:linkToElementModel(themesPC, nil, false, function(model)
		SpecialistDecalSelectorPC:setModel(model, f1_arg0)
	end)
	self:linkToElementModel(self, "decalDataSourceName", true, function(model, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	self:linkToElementModel(self, "disabled", true, function(model, f34_arg1)
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	self:appendEventHandler("input_source_changed", function(f35_arg0, f35_arg1)
		f35_arg1.menu = f35_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f35_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f35_arg0, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	local f1_local18 = self
	local f1_local19 = self.subscribeToModel
	local f1_local20 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local19(f1_local18, f1_local20.LastInput, function(f36_arg0, f36_arg1)
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end, false)
	self:linkToElementModel(self, "previewEnabled", true, function(model, f37_arg1)
		CoD.Menu.UpdateButtonShownState(f37_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.SpecialistDecalSelector, controller, "decalDataSourceName") and not IsPC() then
			PlaySoundAlias("uin_cac_equip_base")
			CoD.PlayerRoleUtility.CycleOutfitDecalItem(menu, controller, self.SpecialistDecalSelector)
			return true
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.SpecialistDecalSelectorPC, controller, "decalDataSourceName") and not CoD.ModelUtility.IsSelfModelValueTrue(self.themesPC, controller, "disabled") and IsPC() and IsGamepad(controller) then
			PlaySoundAlias("uin_cac_equip_base")
			CoD.PlayerRoleUtility.CycleOutfitDecalItem(menu, controller, self.SpecialistDecalSelectorPC)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.SpecialistDecalSelector, controller, "decalDataSourceName") and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
			return false
		elseif CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.SpecialistDecalSelectorPC, controller, "decalDataSourceName") and not CoD.ModelUtility.IsSelfModelValueTrue(self.themesPC, controller, "disabled") and IsPC() and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.SpecialistDecalSelectorPC, controller, "decalDataSourceName") and not CoD.ModelUtility.IsSelfModelValueTrue(self.themesPC, controller, "disabled") and IsPC() and IsMouseOrKeyboard(controller) then
			PlaySoundAlias("uin_cac_equip_base")
			CoD.PlayerRoleUtility.CycleOutfitDecalItem(menu, controller, self.SpecialistDecalSelectorPC)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(self.SpecialistDecalSelectorPC, controller, "decalDataSourceName") and not CoD.ModelUtility.IsSelfModelValueTrue(self.themesPC, controller, "disabled") and IsPC() and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "ui_contextual_2")
			return false
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], "ui_contextual_1", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(self, controller, "previewEnabled") then
			PlaySoundAlias("uin_main_edit")
			OpenOverlay(self, "MPSpecialistHUBPreviewMoment", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(self, controller, "previewEnabled") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x52FB29ED3A3CA79, nil, "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if IsMultiplayer() then
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
			ClearMenuSavedState(f1_local1)
			CoD.PlayerRoleUtility.CleanupOutfitData(f1_arg0)
			CoD.BreadcrumbUtility.UploadBuffer(f1_arg0, Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA])
		elseif IsWarzone() then
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
			ClearMenuSavedState(f1_local1)
			CoD.PlayerRoleUtility.CleanupOutfitData(f1_arg0)
			CoD.BreadcrumbUtility.UploadBuffer(f1_arg0, Enum[0xBBD4F9E70101BA8][0xDF87425733853AE])
		elseif IsZombies() then
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
			ClearMenuSavedState(f1_local1)
			CoD.PlayerRoleUtility.CleanupOutfitData(f1_arg0)
			CoD.ZMStoryUtility.SetSelectedStoryToCurrentMapStory(f1_arg0)
		end
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	f1_local4.id = "outfits"
	outfitsPC.id = "outfitsPC"
	f1_local8.id = "themes"
	themesPC.id = "themesPC"
	f1_local11.id = "outfitsVerticalCounter"
	if CoD.isPC then
		outfitsVerticalCounterPC.id = "outfitsVerticalCounterPC"
	end
	f1_local13.id = "themeVerticalCounter"
	if CoD.isPC then
		themeVerticalCounterPC.id = "themeVerticalCounterPC"
	end
	f1_local15.id = "SpecialistDecalSelector"
	if CoD.isPC then
		SpecialistDecalSelectorPC.id = "SpecialistDecalSelectorPC"
	end
	SafeareaContainer.id = "SafeareaContainer"
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
	f1_local19 = self
	f1_local19 = f1_local4
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, self.themes, self.themesPC)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local19, f1_local19)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, f1_local19, self.themes)
	SetElementProperty(f1_local19, "_checkChildFocusForSelectability", true)
	f1_local19 = outfitsPC
	if IsPC() then
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, f1_local19, self.themesPC)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local19, f1_local19)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local19, f1_local19)
		SetElementProperty(f1_local19, "_checkChildFocusForSelectability", true)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local19, f1_arg0, "displayName", "", "")
	end
	f1_local19 = f1_local8
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local19, f1_local19)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local19, f1_local19)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local19, self.outfits)
	f1_local19 = themesPC
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f1_local19, f1_local19)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f1_local19, f1_local19)
	CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.right, f1_local19, self.outfitsPC)
	SetAsListVerticalCounter(self, f1_local11, "outfits")
	SetAsListVerticalCounter(self, outfitsVerticalCounterPC, "outfitsPC")
	SetAsListVerticalCounter(self, f1_local13, "themes")
	SetAsListVerticalCounter(self, themeVerticalCounterPC, "themesPC")
	return self
end
CoD.PersonalizeCharacter.__resetProperties = function(f47_arg0)
	f47_arg0.outfitsPC:completeAnimation()
	f47_arg0.themes:completeAnimation()
	f47_arg0.outfits:completeAnimation()
	f47_arg0.themesPC:completeAnimation()
	f47_arg0.outfitsPC:setAlpha(1)
	f47_arg0.themes:setAlpha(1)
	f47_arg0.outfits:setAlpha(1)
	f47_arg0.themesPC:setAlpha(1)
end
CoD.PersonalizeCharacter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
			local f48_local0 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(150)
					f50_arg0:setAlpha(1)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f48_arg0.outfits:beginAnimation(250)
				f48_arg0.outfits:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.outfits:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f48_arg0.outfits:completeAnimation()
			f48_arg0.outfits:setAlpha(0)
			f48_local0(f48_arg0.outfits)
			local f48_local1 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(150)
					f52_arg0:setAlpha(1)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f48_arg0.outfitsPC:beginAnimation(250)
				f48_arg0.outfitsPC:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.outfitsPC:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f48_arg0.outfitsPC:completeAnimation()
			f48_arg0.outfitsPC:setAlpha(0)
			f48_local1(f48_arg0.outfitsPC)
			local f48_local2 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					f54_arg0:beginAnimation(150)
					f54_arg0:setAlpha(1)
					f54_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f48_arg0.themes:beginAnimation(50)
				f48_arg0.themes:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.themes:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f48_arg0.themes:completeAnimation()
			f48_arg0.themes:setAlpha(0)
			f48_local2(f48_arg0.themes)
			local f48_local3 = function(f55_arg0)
				f55_arg0:beginAnimation(150)
				f55_arg0:setAlpha(1)
				f55_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.themesPC:beginAnimation(50)
			f48_arg0.themesPC:setAlpha(0)
			f48_arg0.themesPC:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
			f48_arg0.themesPC:registerEventHandler("transition_complete_keyframe", f48_local3)
		end,
	},
}
CoD.PersonalizeCharacter.__onClose = function(f56_arg0)
	f56_arg0.outfits:close()
	f56_arg0.outfitsPC:close()
	f56_arg0.SpecialistDecalSelector:close()
	f56_arg0.SpecialistDecalSelectorPC:close()
	f56_arg0.XCamMouseControl:close()
	f56_arg0.InfoPanel:close()
	f56_arg0.themes:close()
	f56_arg0.themesPC:close()
	f56_arg0.CommonIdentityWidgetStreamlinedSafeAreaContainer:close()
	f56_arg0.outfitsVerticalCounter:close()
	f56_arg0.outfitsVerticalCounterPC:close()
	f56_arg0.themeVerticalCounter:close()
	f56_arg0.themeVerticalCounterPC:close()
	f56_arg0.SafeareaContainer:close()
end
