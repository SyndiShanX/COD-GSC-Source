require("x64:1827e15981384e2")
require("x64:341ce33d59fafd1")
require("x64:ce1e6b6549d478c")
require("x64:38c11a77e96e48c")
require("x64:1b3bebae5e3f953")
require("x64:e692aea0c6bf292")
CoD.ZMTalismanSelect = InheritFrom(CoD.Menu)
LUI.createMenu.ZMTalismanSelect = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ZMTalismanSelect", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg0, "TalismanSelect.Update", true)
	self:setClass(CoD.ZMTalismanSelect)
	self.soundSet = "ZCAC"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local selectionList = LUI.UIList.new(f1_local1, f1_arg0, 16, 0, nil, true, false, false, false)
	selectionList:setLeftRight(0.5, 0.5, -387, 387)
	selectionList:setTopBottom(0, 0, 203, 957)
	selectionList:setWidgetType(CoD.ZMTalismanListItem)
	selectionList:setHorizontalCount(5)
	selectionList:setVerticalCount(5)
	selectionList:setSpacing(16)
	selectionList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	selectionList:setVerticalCounter(CoD.verticalCounter)
	selectionList:setDataSource("Unlockables")
	selectionList:linkToElementModel(selectionList, "itemIndex", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local RestrictedText = selectionList
	local ItemInfo = selectionList.subscribeToModel
	local FooterContainerFrontendRight = Engine[@"getmodelforcontroller"](f1_arg0)
	ItemInfo(RestrictedText, FooterContainerFrontendRight["TalismanSelect.Update"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	selectionList:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_local1
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	RestrictedText = selectionList
	ItemInfo = selectionList.subscribeToModel
	FooterContainerFrontendRight = Engine[@"getmodelforcontroller"](f1_arg0)
	ItemInfo(RestrictedText, FooterContainerFrontendRight.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	selectionList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.ZMTalismanUtility.UpdateTalismanModel(self, element, f1_arg0)
		return f6_local0
	end)
	selectionList:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"])
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.CACUtility.DoesCACItemHaveConsumablesRemaining(menu, element, controller, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"]) and not CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, controller) then
			CoD.CACUtility.EquipWeapon(self, element, menu, controller, false)
			CoD.ZMTalismanUtility.UpdateEquippedSlot(controller)
			UpdateButtonPromptState(menu, element, controller, Enum[@"luibutton"][@"lui_key_xba_pscross"])
			return true
		elseif CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, controller) and IsPC() then
			CoD.ZMTalismanUtility.UnequipTalisman(menu, element, controller)
			CoD.ZMTalismanUtility.UpdateEquippedSlot(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.CACUtility.DoesCACItemHaveConsumablesRemaining(menu, element, controller, Enum[@"statindexoffset"][@"hash_15544C104CD15F10"]) and not CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, controller) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/remove", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, controller) then
			CoD.ZMTalismanUtility.UnequipTalisman(menu, element, controller)
			CoD.ZMTalismanUtility.UpdateEquippedSlot(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/remove", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(selectionList, f1_arg0, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_remove", function(element, menu, controller, model)
		if CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.ZMTalismanUtility.UnequipTalisman(menu, element, controller)
			CoD.ZMTalismanUtility.UpdateEquippedSlot(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ZMTalismanUtility.IsTalismanEqipped(menu, element, controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"menu/remove", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	selectionList:AddContextualMenuAction(f1_local1, f1_arg0, @"menu/remove", function(f14_arg0, f14_arg1, f14_arg2, f14_arg3)
		if CoD.ZMTalismanUtility.IsTalismanEqipped(f14_arg1, f14_arg0, f14_arg2) then
			return function(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
				CoD.ZMTalismanUtility.UnequipTalisman(f15_arg1, f15_arg0, f15_arg2)
				CoD.ZMTalismanUtility.UpdateEquippedSlot(f15_arg2)
			end
		else
		end
	end)
	self:addElement(selectionList)
	self.selectionList = selectionList
	ItemInfo = CoD.ItemNameDescUnlockText.new(f1_local1, f1_arg0, 0.5, 0.5, 411, 911, 0, 0, 616, 723)
	ItemInfo:mergeStateConditions({
		{
			stateName = "ZombieCompact",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ItemInfo)
	self.ItemInfo = ItemInfo
	RestrictedText = CoD.RestrictedItemWarningText.new(f1_local1, f1_arg0, 0.5, 0.5, -247, 247, 0.5, 0.5, 424, 454)
	self:addElement(RestrictedText)
	self.RestrictedText = RestrictedText
	FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f17_local0 = nil
		if element.menuLoaded then
			f17_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f17_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f17_local0 then
			f17_local0 = element:dispatchEventToChildren(event)
		end
		return f17_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local TopBar = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, 823, 826)
	TopBar:setRGB(0.58, 0.85, 1)
	TopBar:setAlpha(0.5)
	TopBar:setZoom(2)
	TopBar:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBar)
	self.TopBar = TopBar
	local hint = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 852, 870)
	hint:setRGB(0.58, 0.58, 0.58)
	hint:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E1C57D633148C5B"))
	hint:setTTF("ttmussels_regular")
	hint:setLetterSpacing(2)
	hint:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	hint:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(hint)
	self.hint = hint
	local TopBar2 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, 896, 899)
	TopBar2:setRGB(0.58, 0.85, 1)
	TopBar2:setAlpha(0.5)
	TopBar2:setZoom(2)
	TopBar2:setImage(RegisterImage(@"uie_ui_menu_cac_primary_button_top_bar"))
	TopBar2:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(TopBar2)
	self.TopBar2 = TopBar2
	local ZMTalismanSafeAreaContainer = CoD.ZMTalismanSafeAreaContainer.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	ZMTalismanSafeAreaContainer.CategoryTabs.Tabs.grid:setDataSource("TalismanCategories")
	ZMTalismanSafeAreaContainer:registerEventHandler("menu_loaded", function(element, event)
		local f18_local0 = nil
		if element.menuLoaded then
			f18_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f18_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg0)
		if not f18_local0 then
			f18_local0 = element:dispatchEventToChildren(event)
		end
		return f18_local0
	end)
	ZMTalismanSafeAreaContainer:registerEventHandler("list_active_changed", function(element, event)
		local f19_local0 = nil
		SetProperty(self, "__rarity", element.rarity)
		UpdateDataSource(self, self.selectionList, f1_arg0)
		return f19_local0
	end)
	self:addElement(ZMTalismanSafeAreaContainer)
	self.ZMTalismanSafeAreaContainer = ZMTalismanSafeAreaContainer
	ItemInfo:linkToElementModel(selectionList, nil, false, function(model)
		ItemInfo:setModel(model, f1_arg0)
	end)
	RestrictedText:linkToElementModel(selectionList, nil, false, function(model)
		RestrictedText:setModel(model, f1_arg0)
	end)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f22_local0 = nil
		if self.menuLoaded then
			f22_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f22_local0 = self.super:menuLoaded(event)
		end
		ShowHeaderIconOnly(f1_local1)
		SetElementStateByElementName(self, "GenericMenuFrame0", f1_arg0, "Update")
		PlayClipOnElement(self, {
			elementName = "GenericMenuFrame0",
			clipName = "intro",
		}, f1_arg0)
		PlayClip(self, "into", f1_arg0)
		if not f22_local0 then
			f22_local0 = self:dispatchEventToChildren(event)
		end
		return f22_local0
	end)
	self:registerEventHandler("list_active_changed", function(self, event)
		local f23_local0 = nil
		CoD.ZMTalismanUtility.UpdateTalismanModel(self, self.selectionList, f1_arg0)
		return f23_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		PlaySoundSetSound(self, "menu_no_selection")
		SendClientScriptMenuChangeNotify(controller, menu, false)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, true)
	self.__on_menuOpened_self = function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
		local f26_local0 = self
		SendClientScriptMenuChangeNotify(f26_arg1, f26_arg2, true)
		SetPerControllerTableProperty(f26_arg1, "weaponCategory", "talisman1")
	end
	f1_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.CACUtility.ClearClassWeaponModel(f1_local1, f1_arg0)
	end)
	selectionList.id = "selectionList"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	ZMTalismanSafeAreaContainer.id = "ZMTalismanSafeAreaContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = selectionList
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
	local f1_local10 = self
	CoD.BaseUtility.SetMenuSessionMode(f1_local1, Enum[@"emodes"][@"mode_zombies"])
	f1_local10 = selectionList
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local10, f1_arg0, "displayName", "", "")
	end
	return self
end
CoD.ZMTalismanSelect.__onClose = function(f29_arg0)
	f29_arg0.__on_close_removeOverrides()
	f29_arg0.ItemInfo:close()
	f29_arg0.RestrictedText:close()
	f29_arg0.selectionList:close()
	f29_arg0.FooterContainerFrontendRight:close()
	f29_arg0.ZMTalismanSafeAreaContainer:close()
end
