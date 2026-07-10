require("x64:ffc2c7e4adad795")
require("x64:c0cb09f85132dc0")
require("x64:78d9663be3f826")
require("x64:ca1dc89b2aa714c")
require("x64:1744d99b88fcb45")
require("x64:eb8711f5087e974")
require("x64:2a456a4b0756328")
CoD.Armory_WeaponListWidget = InheritFrom(LUI.UIElement)
CoD.Armory_WeaponListWidget.__defaultWidth = 1920
CoD.Armory_WeaponListWidget.__defaultHeight = 490
CoD.Armory_WeaponListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Armory_WeaponListWidget)
	self.id = "Armory_WeaponListWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local weaponCategoryList = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, -19, 42)
	weaponCategoryList.Tabs.grid:setWidgetType(CoD.CACTextTab)
	weaponCategoryList.Tabs.grid:setDataSource("ArmoryWeaponGroups")
	weaponCategoryList:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		if CoD.BaseUtility.IsWidgetVisible(element) then
			SetElementProperty(f1_arg0, "__itemGroup", element.category)
			SetElementProperty(f1_arg0, "__loadoutType", element.loadoutType)
			UpdateDataSource(self, self.weaponList, f1_arg1)
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.weaponList)
			CoD.CACUtility.UpdateCommonCurrentActiveTabIndexValue(f1_arg1, self.weaponCategoryList)
			CoD.CACUtility.UpdateArmoryArrowState(f1_arg0, f1_arg1, self.PCArrowR)
			CoD.CACUtility.UpdateArmoryArrowState(f1_arg0, f1_arg1, self.PCArrowL)
		end
		return f2_local0
	end)
	self.__on_menuOpened_weaponCategoryList = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = weaponCategoryList
		if not IsElementPropertyValue(f3_local0, "_receivedMenuOpen", true) then
			SetElementProperty(f3_local0, "_receivedMenuOpen", true)
			CoD.CACUtility.SetActiveListItemForWeaponGroup(f3_arg2, f3_arg1, self.weaponCategoryList)
			UpdateDataSource(self, self.weaponList, f3_arg1)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_weaponCategoryList)
	self:addElement(weaponCategoryList)
	self.weaponCategoryList = weaponCategoryList
	local PCArrowL = nil
	PCArrowL = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 177.5, 207.5, 0, 0, 111.5, 146.5)
	PCArrowL:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.WZUtility.IsQuickEquipListFirstItemVisible(self.weaponList)
			end,
		},
	})
	PCArrowL:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PCArrowL:setZRot(90)
	PCArrowL:setScale(1.2, 1.2)
	PCArrowL.Arrow:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	PCArrowL.Arrow2:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	PCArrowL:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local weaponList = PCArrowL
	local PCArrowR = PCArrowL.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	PCArrowR(weaponList, f1_local5.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PCArrowL:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCArrowL, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.GridAndListUtility.ScrollLeft(self.weaponList)
			CoD.GridAndListUtility.ValidateActiveItemVisibility(self.weaponList)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(PCArrowL)
	self.PCArrowL = PCArrowL
	PCArrowR = nil
	PCArrowR = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 1714, 1744, 0, 0, 111.5, 146.5)
	PCArrowR:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.WZUtility.IsQuickEquipListLastItemVisible(self.weaponList)
			end,
		},
	})
	PCArrowR:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PCArrowR:setZRot(270)
	PCArrowR:setScale(1.2, 1.2)
	PCArrowR.Arrow:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	PCArrowR.Arrow2:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	PCArrowR:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f11_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local5 = PCArrowR
	weaponList = PCArrowR.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	weaponList(f1_local5, f1_local6.LastInput, function(f12_arg0, f12_arg1)
		CoD.Menu.UpdateButtonShownState(f12_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PCArrowR:registerEventHandler("gain_focus", function(element, event)
		local f13_local0 = nil
		if element.gainFocus then
			f13_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f13_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f13_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCArrowR, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.GridAndListUtility.ScrollRight(self.weaponList)
			CoD.GridAndListUtility.ValidateActiveItemVisibility(self.weaponList)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(PCArrowR)
	self.PCArrowR = PCArrowR
	weaponList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	weaponList:setLeftRight(0.5, 0.5, -750, 750)
	weaponList:setTopBottom(0, 0, 56, 202)
	weaponList:setWidgetType(CoD.ZMItemGridButton)
	weaponList:setHorizontalCount(5)
	weaponList:setSpacing(10)
	weaponList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	weaponList:setHorizontalScrollbar(CoD.PC_GridHorizontalScrollbar)
	weaponList:setDataSource("Unlockables")
	weaponList:linkToElementModel(weaponList, "globalItemIndex", true, function(model, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	weaponList:linkToElementModel(weaponList, "refHash", true, function(model, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	weaponList:linkToElementModel(weaponList, "itemIndex", true, function(model, f18_arg1)
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f18_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	weaponList:appendEventHandler("input_source_changed", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f19_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	f1_local6 = weaponList
	f1_local5 = weaponList.subscribeToModel
	local WeaponVariantListWidget = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local6, WeaponVariantListWidget.LastInput, function(f20_arg0, f20_arg1)
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f20_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	weaponList:linkToElementModel(weaponList, nil, false, function(model, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end)
	f1_local6 = weaponList
	f1_local5 = weaponList.subscribeToModel
	WeaponVariantListWidget = Engine[@"getglobalmodel"]()
	f1_local5(f1_local6, WeaponVariantListWidget["lobbyRoot.lobbyNetworkMode"], function(f22_arg0, f22_arg1)
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f22_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_back"])
	end, false)
	f1_local6 = weaponList
	f1_local5 = weaponList.subscribeToModel
	WeaponVariantListWidget = Engine[@"getglobalmodel"]()
	f1_local5(f1_local6, WeaponVariantListWidget["lobbyRoot.lobbyNav"], function(f23_arg0, f23_arg1)
		CoD.Menu.UpdateButtonShownState(f23_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f23_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_back"])
	end, false)
	weaponList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f24_local0 = nil
		CoD.CACUtility.UpdateWeaponNameInfoModel(f1_arg0, element, f1_arg1)
		CoD.ZMLoadoutUtility.UpdateArmoryWeaponModel(element, f1_arg1, f1_arg0)
		SetElementProperty(self.WeaponVariantListWidget, "_weaponListElement", element)
		return f24_local0
	end)
	weaponList:registerEventHandler("list_active_changed", function(element, event)
		local f25_local0 = nil
		if not IsPC() then
			UpdateSelfElementState(f1_arg0, self.ArrowR, f1_arg1)
			UpdateSelfElementState(f1_arg0, self.ArrowL, f1_arg1)
		end
		return f25_local0
	end)
	weaponList:registerEventHandler("lose_list_focus", function(element, event)
		local f26_local0 = nil
		CoD.CACUtility.UpdateWeaponModel(f1_arg0, element, f1_arg1)
		return f26_local0
	end)
	weaponList:registerEventHandler("gain_focus", function(element, event)
		local f27_local0 = nil
		if element.gainFocus then
			f27_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f27_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_back"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f27_local0
	end)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsElementPropertyValue(menu, "_loadoutSlot", CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName) and not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.CACUtility.EquipWeapon(self, element, menu, controller, false)
			UpdateSelfElementState(menu, self, controller)
			return true
		elseif IsElementPropertyValue(menu, "_loadoutSlot", CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName) and not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.CACUtility.ShowWeaponVariantList(menu, controller, self.WeaponVariantListWidget)
			return true
		elseif IsElementPropertyValue(menu, "_loadoutSlot", "armory") and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.DoesWeaponHaveAttachments(element, controller) and not CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.ZMLoadoutUtility.OpenArmoryAttachmentOverlay(self, element, controller, menu)
			return true
		elseif IsElementPropertyValue(menu, "_loadoutSlot", "armory") and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.DoesWeaponHaveAttachments(element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.CACUtility.ShowWeaponVariantList(menu, controller, self.WeaponVariantListWidget)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsElementPropertyValue(menu, "_loadoutSlot", CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName) and not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsElementPropertyValue(menu, "_loadoutSlot", CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName) and not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsElementPropertyValue(menu, "_loadoutSlot", "armory") and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.DoesWeaponHaveAttachments(element, controller) and not CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		elseif IsElementPropertyValue(menu, "_loadoutSlot", "armory") and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.DoesWeaponHaveAttachments(element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelNil(element, controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.BaseUtility.IsDvarEnabled("disableZMWeaponPersonalization") then
			CoD.CraftUtility.SetupPaintjobPersonalization(self, element, controller)
			CoD.CACUtility.OpenWeaponPersonalizationOverlay(self, menu, controller, element, element, "primary")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelNil(element, controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.BaseUtility.IsDvarEnabled("disableZMWeaponPersonalization") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_194122F68876E5D9", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "ui_contextual_1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelNil(element, controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.BaseUtility.IsDvarEnabled("disableZMWeaponPersonalization") then
			CoD.CraftUtility.SetupPaintjobPersonalization(self, element, controller)
			CoD.CACUtility.OpenWeaponPersonalizationOverlay(self, menu, controller, element, element, "primary")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelNil(element, controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.BaseUtility.IsDvarEnabled("disableZMWeaponPersonalization") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_194122F68876E5D9", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_contextual_2", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not IsLocal() and not IsCustomLobby() and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.ZMLoadoutUtility.SetShowcaseWeapon(element, controller, menu)
			PlaySoundAlias("cac_overload_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not IsLocal() and not IsCustomLobby() and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"hash_4E629850E7968A6E", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_back"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not IsLocal() and not IsCustomLobby() and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.ZMLoadoutUtility.SetShowcaseWeapon(element, controller, menu)
			PlaySoundAlias("cac_overload_select")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not IsLocal() and not IsCustomLobby() and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_4E629850E7968A6E", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelExists(menu, element, controller) and CoD.CACUtility.IsCACGunLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) then
			PrestigeWeapon(menu, element, controller)
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelExists(menu, element, controller) and CoD.CACUtility.IsCACGunLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"challenge/prestige", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "ui_contextual_3", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelExists(menu, element, controller) and CoD.CACUtility.IsCACGunLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) then
			PrestigeWeapon(menu, element, controller)
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelExists(menu, element, controller) and CoD.CACUtility.IsCACGunLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"hash_7DC436DD31790E72", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_3")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MWHEELUP", function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollLeft(self.weaponList)
		CoD.GridAndListUtility.ValidateActiveItemVisibility(self.weaponList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELUP")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_none"], "MWHEELDOWN", function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollRight(self.weaponList)
		CoD.GridAndListUtility.ValidateActiveItemVisibility(self.weaponList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_none"], @"hash_0", nil, "MWHEELDOWN")
		return false
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(weaponList, "updateDataSource", function(element, controller, f46_arg2, f46_arg3)
		if IsPC() then
			CoD.CACUtility.UpdateArmoryArrowState(f1_arg0, f1_arg1, self.PCArrowR)
			CoD.CACUtility.UpdateArmoryArrowState(f1_arg0, f1_arg1, self.PCArrowL)
		end
	end)
	weaponList:subscribeToGlobalModel(f1_arg1, "PerController", "Unlockables.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(weaponList, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	weaponList:subscribeToGlobalModel(f1_arg1, "WeaponPersonalization", "listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(weaponList, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	weaponList:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_4AFF37175F950D17", function(f49_arg0, f49_arg1, f49_arg2, f49_arg3)
		if IsMouseOrKeyboard(f49_arg2) and not CoD.ModelUtility.IsSelfModelNil(f49_arg0, f49_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualTo(f49_arg0, f49_arg2, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.BaseUtility.IsDvarEnabled("disableZMWeaponPersonalization") and not CoD.CACUtility.IsCACItemLocked(f49_arg1, f49_arg0, f49_arg2) and not CoD.CACUtility.IsCACBlackMarketItemLocked(f49_arg1, f49_arg0, f49_arg2) then
			return function(f50_arg0, f50_arg1, f50_arg2, f50_arg3)
				CoD.CraftUtility.SetupPaintjobPersonalization(self, f50_arg0, f50_arg2)
				CoD.CACUtility.OpenWeaponPersonalizationOverlay(self, f50_arg1, f50_arg2, f50_arg0, f50_arg0, "primary")
				PlaySoundAlias("uin_toggle_generic")
			end
		else
		end
	end)
	weaponList:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_E092C2BE5DD4778", function(f51_arg0, f51_arg1, f51_arg2, f51_arg3)
		if not IsLocal() and not IsCustomLobby() and not CoD.CACUtility.IsCACItemLocked(f51_arg1, f51_arg0, f51_arg2) then
			return function(f52_arg0, f52_arg1, f52_arg2, f52_arg3)
				CoD.ZMLoadoutUtility.SetShowcaseWeapon(f52_arg0, f52_arg2, f52_arg1)
				PlaySoundAlias("cac_overload_select")
			end
		else
		end
	end)
	weaponList:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_7DC436DD31790E72", function(f53_arg0, f53_arg1, f53_arg2, f53_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(f53_arg0, f53_arg2, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelExists(f53_arg1, f53_arg0, f53_arg2) and CoD.CACUtility.IsCACGunLevelMax(f53_arg1, f53_arg0, f53_arg2) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(f53_arg1, f53_arg0, f53_arg2) and not CoD.CACUtility.IsCACItemLocked(f53_arg1, f53_arg0, f53_arg2) and not CoD.CACUtility.IsCACBlackMarketItemLocked(f53_arg1, f53_arg0, f53_arg2) then
			return function(f54_arg0, f54_arg1, f54_arg2, f54_arg3)
				PrestigeWeapon(f54_arg1, f54_arg0, f54_arg2)
				PlaySoundAlias("uin_press_generic")
			end
		else
		end
	end)
	self:addElement(weaponList)
	self.weaponList = weaponList
	f1_local5 = nil
	self.ArrowL = LUI.UIElement.createFake()
	f1_local6 = nil
	self.ArrowR = LUI.UIElement.createFake()
	WeaponVariantListWidget = CoD.WeaponVariantListWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 490)
	WeaponVariantListWidget.SignatureWeaponList:setWidgetType(CoD.ZMSignatureWeaponItemGridButton)
	WeaponVariantListWidget.SignatureWeaponList:setSpacing(10)
	WeaponVariantListWidget:registerEventHandler("gain_focus", function(element, event)
		local f55_local0 = nil
		if element.gainFocus then
			f55_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f55_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f55_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponVariantListWidget, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		CoD.CACUtility.HideWeaponVariantList(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	self:addElement(WeaponVariantListWidget)
	self.WeaponVariantListWidget = WeaponVariantListWidget
	WeaponVariantListWidget:linkToElementModel(weaponList, nil, false, function(model)
		WeaponVariantListWidget:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "NoCategories",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.weaponCategoryList)
			end,
		},
		{
			stateName = "DefaultStatePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f61_arg0, f61_arg1)
		f61_arg1.menu = f61_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f61_arg1)
	end)
	weaponCategoryList.id = "weaponCategoryList"
	if CoD.isPC then
		PCArrowL.id = "PCArrowL"
	end
	if CoD.isPC then
		PCArrowR.id = "PCArrowR"
	end
	weaponList.id = "weaponList"
	WeaponVariantListWidget.id = "WeaponVariantListWidget"
	self.__defaultFocus = weaponList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_weaponCategoryList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	f1_local8 = weaponCategoryList
	if IsPC() then
		DisableKeyboardNavigationByElement(f1_local8)
	end
	f1_local8 = PCArrowL
	if IsPC() then
		CoD.GridAndListUtility.UpdateStateOnGridLayoutUpdate(f1_arg1, f1_local8, self.weaponList)
		SetElementCanBeNavigatedTo(f1_local8, false)
	end
	f1_local8 = PCArrowR
	if IsPC() then
		CoD.GridAndListUtility.UpdateStateOnGridLayoutUpdate(f1_arg1, f1_local8, self.weaponList)
		SetElementCanBeNavigatedTo(f1_local8, false)
	end
	f1_local8 = weaponList
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local8, f1_arg1, "displayName", "", "")
		CoD.GridAndListUtility.HideScrollbarsForGamepad(f1_arg0, f1_arg1, f1_local8)
	elseif not IsPC() then
		CoD.GridAndListUtility.RemoveHorizontalScrollbar(f1_arg0, f1_local8)
	end
	f1_local8 = WeaponVariantListWidget
	HideWidget(self.WeaponVariantListWidget)
	SetElementProperty(f1_local8, "_forZMArmory", true)
	return self
end
CoD.Armory_WeaponListWidget.__resetProperties = function(f63_arg0)
	f63_arg0.ArrowR:completeAnimation()
	f63_arg0.ArrowL:completeAnimation()
	f63_arg0.weaponList:completeAnimation()
	f63_arg0.PCArrowR:completeAnimation()
	f63_arg0.PCArrowL:completeAnimation()
	f63_arg0.ArrowR:setTopBottom(0, 0, 121, 137)
	f63_arg0.ArrowL:setTopBottom(0, 0, 121, 137)
	f63_arg0.weaponList:setTopBottom(0, 0, 56, 202)
	f63_arg0.PCArrowR:setTopBottom(0, 0, 111.5, 146.5)
	f63_arg0.PCArrowL:setTopBottom(0, 0, 111.5, 146.5)
end
CoD.Armory_WeaponListWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f64_arg0, f64_arg1)
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter(0)
		end,
	},
	NoCategories = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(3)
			f66_arg0.PCArrowL:completeAnimation()
			f66_arg0.PCArrowL:setTopBottom(0, 0, 135.5, 170.5)
			f66_arg0.clipFinished(f66_arg0.PCArrowL)
			f66_arg0.PCArrowR:completeAnimation()
			f66_arg0.PCArrowR:setTopBottom(0, 0, 135.5, 170.5)
			f66_arg0.clipFinished(f66_arg0.PCArrowR)
			f66_arg0.weaponList:completeAnimation()
			f66_arg0.weaponList:setTopBottom(0, 0, 80, 226)
			f66_arg0.clipFinished(f66_arg0.weaponList)
			f66_arg0.ArrowL:completeAnimation()
			f66_arg0.ArrowL:setTopBottom(0, 0, 145, 161)
			f66_arg0.clipFinished(f66_arg0.ArrowL)
			f66_arg0.ArrowR:completeAnimation()
			f66_arg0.ArrowR:setTopBottom(0, 0, 145, 161)
			f66_arg0.clipFinished(f66_arg0.ArrowR)
		end,
	},
}
CoD.Armory_WeaponListWidget.__onClose = function(f67_arg0)
	f67_arg0.__on_close_removeOverrides()
	f67_arg0.WeaponVariantListWidget:close()
	f67_arg0.weaponCategoryList:close()
	f67_arg0.PCArrowL:close()
	f67_arg0.PCArrowR:close()
	f67_arg0.weaponList:close()
	f67_arg0.ArrowL:close()
	f67_arg0.ArrowR:close()
end
