require("x64:ffc2c7e4adad795")
require("x64:a60f9dd8c2d255e")
require("x64:c0cb09f85132dc0")
require("x64:78d9663be3f826")
require("x64:ca1dc89b2aa714c")
require("x64:fba429cdc7392ca")
require("x64:1744d99b88fcb45")
CoD.WeaponListWidget = InheritFrom(LUI.UIElement)
CoD.WeaponListWidget.__defaultWidth = 1920
CoD.WeaponListWidget.__defaultHeight = 490
CoD.WeaponListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetControllerModelValue(f1_arg1, "Unlockables.listUpdate", 0)
	self:setClass(CoD.WeaponListWidget)
	self.id = "WeaponListWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local weaponCategoryList = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, -21, 40)
	weaponCategoryList.Tabs.grid:setWidgetType(CoD.CACTextTab)
	weaponCategoryList.Tabs.grid:setDataSource("WeaponGroups")
	weaponCategoryList:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		if CoD.BaseUtility.IsWidgetVisible(element) then
			SetStateByElementModel(self, element, f1_arg1, "state")
			SetElementProperty(f1_arg0, "__itemGroup", element.category)
			SetLoseFocusToElement(self, "weaponList", f1_arg1)
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f1_arg0, f1_arg0, f1_arg1)
			ForceCheckDefaultPCFocus(f1_arg0, f1_arg0, f1_arg1)
			ForceNotifyControllerModel(f1_arg1, "Unlockables.listUpdate")
		end
		return f2_local0
	end)
	self.__on_menuOpened_weaponCategoryList = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
		local f3_local0 = weaponCategoryList
		if not IsElementPropertyValue(f3_local0, "_receivedMenuOpen", true) and not CoD.CACUtility.IsCurrentGameTypeBarebones() then
			SetElementProperty(f3_local0, "_receivedMenuOpen", true)
			CoD.CACUtility.SetActiveListItemForWeaponGroup(f3_arg2, f3_arg1, self.weaponCategoryList)
			UpdateDataSource(self, self.weaponList, f3_arg1)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_weaponCategoryList)
	self:addElement(weaponCategoryList)
	self.weaponCategoryList = weaponCategoryList
	local weaponList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	weaponList:setLeftRight(0.5, 0.5, -705, 705)
	weaponList:setTopBottom(0, 0, 56, 182)
	weaponList:setZoom(85)
	weaponList:setWidgetType(CoD.WeaponSelectGridItem)
	weaponList:setHorizontalCount(5)
	weaponList:setSpacing(10)
	weaponList:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	weaponList:setHorizontalScrollbar(CoD.PC_GridHorizontalScrollbar)
	weaponList:setHorizontalCounter(CoD.horizontalCounterVerticalSpace)
	weaponList:setDataSource("Unlockables")
	weaponList:linkToElementModel(weaponList, "globalItemIndex", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	weaponList:linkToElementModel(weaponList, "refHash", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	weaponList:linkToElementModel(weaponList, "itemIndex", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	weaponList:appendEventHandler("input_source_changed", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f7_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local PCArrowR = weaponList
	local PCArrowL = weaponList.subscribeToModel
	local WeaponVariantListWidget = Engine[@"getmodelforcontroller"](f1_arg1)
	PCArrowL(PCArrowR, WeaponVariantListWidget.LastInput, function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	PCArrowR = weaponList
	PCArrowL = weaponList.subscribeToModel
	WeaponVariantListWidget = Engine[@"getglobalmodel"]()
	PCArrowL(PCArrowR, WeaponVariantListWidget["lobbyRoot.lobbyNav"], function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	weaponList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f10_local0 = nil
		CoD.BreadcrumbUtility.SetWeaponAsOld(f1_arg0, self, element, f1_arg1)
		CoD.CACUtility.UpdateWeaponNameInfoModel(f1_arg0, element, f1_arg1)
		CoD.CACUtility.UpdateWeaponModel(f1_arg0, element, f1_arg1)
		return f10_local0
	end)
	weaponList:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_none"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.CACUtility.ShowWeaponVariantList(menu, controller, self.WeaponVariantListWidget)
			return true
		elseif not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.CACUtility.EquipWeapon(self, element, menu, controller, true)
			UpdateSelfElementState(menu, self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		elseif not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, controller) and IsGamepad(controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not IsCustomLobby() then
			PrestigeWeapon(menu, element, controller)
			PlaySoundAlias("uin_press_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, controller) and IsGamepad(controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not IsCustomLobby() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"challenge/prestige", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "ui_contextual_1", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, controller) and IsMouseOrKeyboard(controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not IsCustomLobby() then
			PrestigeWeapon(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelMax(menu, element, controller) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, controller) and IsMouseOrKeyboard(controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, controller) and not IsCustomLobby() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"hash_7DC436DD31790E72", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_contextual_1")
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
	self.__on_menuOpened_weaponList = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
		local f22_local0 = weaponList
		if not CoD.CACUtility.IsCurrentGameTypeBarebones() then
			CoD.CACUtility.SetActiveListItemToEquippedItem(f22_arg2, f22_arg1, f22_local0)
			CoD.CACUtility.UpdateWeaponModel(f22_arg2, f22_local0, f22_arg1)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_weaponList)
	LUI.OverrideFunction_CallOriginalFirst(weaponList, "updateDataSource", function(element, controller, f23_arg2, f23_arg3) end)
	LUI.OverrideFunction_CallOriginalFirst(weaponList, "setDataSource", function(element, controller) end)
	weaponList:subscribeToGlobalModel(f1_arg1, "PerController", "Unlockables.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(weaponList, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	weaponList:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_7DC436DD31790E72", function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(f26_arg0, f26_arg2, "itemIndex", CoDShared.EmptyItemIndex) and CoD.CACUtility.IsCACGunLevelMax(f26_arg1, f26_arg0, f26_arg2) and not CoD.CACUtility.IsCACGunPrestigeLevelMax(f26_arg1, f26_arg0, f26_arg2) and not CoD.CACUtility.IsCACItemLocked(f26_arg1, f26_arg0, f26_arg2) and not CoD.CACUtility.IsCACBlackMarketItemLocked(f26_arg1, f26_arg0, f26_arg2) and not IsCustomLobby() then
			return function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
				PrestigeWeapon(f27_arg1, f27_arg0, f27_arg2)
			end
		else
		end
	end)
	self:addElement(weaponList)
	self.weaponList = weaponList
	PCArrowL = nil
	PCArrowL = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, -770, -740, 0, 0, 114.5, 149.5)
	PCArrowL:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.WZUtility.IsQuickEquipListFirstItemVisible(self.weaponList)
			end,
		},
	})
	PCArrowL:setZRot(90)
	PCArrowL.Arrow:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	PCArrowL.Arrow2:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	PCArrowL:appendEventHandler("input_source_changed", function(f29_arg0, f29_arg1)
		f29_arg1.menu = f29_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f29_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	WeaponVariantListWidget = PCArrowL
	PCArrowR = PCArrowL.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	PCArrowR(WeaponVariantListWidget, f1_local6.LastInput, function(f30_arg0, f30_arg1)
		CoD.Menu.UpdateButtonShownState(f30_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PCArrowL:registerEventHandler("gain_focus", function(element, event)
		local f31_local0 = nil
		if element.gainFocus then
			f31_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f31_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f31_local0
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
	PCArrowR = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0.5, 0.5, 740, 770, 0, 0, 114.5, 149.5)
	PCArrowR:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.WZUtility.IsQuickEquipListLastItemVisible(self.weaponList)
			end,
		},
	})
	PCArrowR:setZRot(270)
	PCArrowR.Arrow:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	PCArrowR.Arrow2:setImage(RegisterImage(@"uie_optionswidgets_arrow"))
	PCArrowR:appendEventHandler("input_source_changed", function(f35_arg0, f35_arg1)
		f35_arg1.menu = f35_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f35_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	f1_local6 = PCArrowR
	WeaponVariantListWidget = PCArrowR.subscribeToModel
	local f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	WeaponVariantListWidget(f1_local6, f1_local7.LastInput, function(f36_arg0, f36_arg1)
		CoD.Menu.UpdateButtonShownState(f36_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	PCArrowR:registerEventHandler("gain_focus", function(element, event)
		local f37_local0 = nil
		if element.gainFocus then
			f37_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f37_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f37_local0
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
	WeaponVariantListWidget = CoD.WeaponVariantListWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 490)
	WeaponVariantListWidget.SignatureWeaponList:setSpacing(20)
	WeaponVariantListWidget:registerEventHandler("gain_focus", function(element, event)
		local f40_local0 = nil
		if element.gainFocus then
			f40_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f40_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbb_pscircle"])
		return f40_local0
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
	})
	self:appendEventHandler("grid_updated", function(f45_arg0, f45_arg1)
		f45_arg1.menu = f45_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f45_arg1)
	end)
	weaponCategoryList.id = "weaponCategoryList"
	weaponList.id = "weaponList"
	if CoD.isPC then
		PCArrowL.id = "PCArrowL"
	end
	if CoD.isPC then
		PCArrowR.id = "PCArrowR"
	end
	WeaponVariantListWidget.id = "WeaponVariantListWidget"
	self.__defaultFocus = weaponList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_weaponCategoryList)
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_weaponList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	DisableKeyboardNavigationByElement(weaponCategoryList)
	f1_local6 = weaponList
	if IsPC() then
		CoD.GridAndListUtility.RemoveHorizontalCounter(f1_arg0, f1_local6)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local6, f1_arg1, "displayName", "", "")
		SetElementProperty(f1_local6, "ignoreSavedActive", true)
		CoD.CACUtility.UseEquippedItemAsDefaultFocus(f1_arg0, f1_arg1, f1_local6)
		CoD.GridAndListUtility.HideScrollbarsForGamepad(f1_arg0, f1_arg1, f1_local6)
	elseif not IsPC() then
		CoD.GridAndListUtility.RemoveHorizontalScrollbar(f1_arg0, f1_local6)
	end
	f1_local6 = PCArrowL
	if IsPC() then
		CoD.GridAndListUtility.UpdateStateOnGridLayoutUpdate(f1_arg1, f1_local6, self.weaponList)
		SetElementCanBeNavigatedTo(f1_local6, false)
	end
	f1_local6 = PCArrowR
	if IsPC() then
		CoD.GridAndListUtility.UpdateStateOnGridLayoutUpdate(f1_arg1, f1_local6, self.weaponList)
		SetElementCanBeNavigatedTo(f1_local6, false)
	end
	f1_local6 = WeaponVariantListWidget
	HideWidget(self.WeaponVariantListWidget)
	return self
end
CoD.WeaponListWidget.__onClose = function(f47_arg0)
	f47_arg0.__on_close_removeOverrides()
	f47_arg0.WeaponVariantListWidget:close()
	f47_arg0.weaponCategoryList:close()
	f47_arg0.weaponList:close()
	f47_arg0.PCArrowL:close()
	f47_arg0.PCArrowR:close()
end
