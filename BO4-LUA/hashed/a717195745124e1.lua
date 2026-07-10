require("x64:ffc2c7e4adad795")
require("x64:c0cb09f85132dc0")
require("x64:78d9663be3f826")
require("x64:ca1dc89b2aa714c")
require("x64:1744d99b88fcb45")
require("x64:c92e584d9cb1860")
require("x64:1b448221b1da982")
CoD.WZPersonalizeWeapon_WeaponListWidget = InheritFrom(LUI.UIElement)
CoD.WZPersonalizeWeapon_WeaponListWidget.__defaultWidth = 1920
CoD.WZPersonalizeWeapon_WeaponListWidget.__defaultHeight = 490
CoD.WZPersonalizeWeapon_WeaponListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZPersonalizeWeapon_WeaponListWidget)
	self.id = "WZPersonalizeWeapon_WeaponListWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local weaponCategoryList = CoD.Common_Tabbar_Center.new(f1_arg0, f1_arg1, 0.5, 0.5, -1650, 1650, 0, 0, -21, 40)
	weaponCategoryList.Tabs.grid:setWidgetType(CoD.CACTextTab)
	weaponCategoryList.Tabs.grid:setDataSource("WZPersonalizeWeaponGroups")
	weaponCategoryList:registerEventHandler("list_active_changed", function(element, event)
		local f2_local0 = nil
		if CoD.BaseUtility.IsWidgetVisible(element) then
			SetElementProperty(f1_arg0, "__itemGroup", element.category)
			SetElementProperty(f1_arg0, "__loadoutType", element.loadoutType)
			SetLoseFocusToElement(self, "weaponList", f1_arg1)
			UpdateDataSource(self, self.weaponList, f1_arg1)
			SetFocusToElement(self, "weaponList", f1_arg1)
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(self.weaponList)
			CoD.CACUtility.UpdateCommonCurrentActiveTabIndexValue(f1_arg1, self.weaponCategoryList)
			CoD.CACUtility.UpdateArmoryArrowState(f1_arg0, f1_arg1, self.ArrowR)
			CoD.CACUtility.UpdateArmoryArrowState(f1_arg0, f1_arg1, self.ArrowL)
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
	local weaponList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	weaponList:setLeftRight(0.5, 0.5, -750, 750)
	weaponList:setTopBottom(0, 0, 56, 202)
	weaponList:setWidgetType(CoD.WZPersonalizeWeapon_ItemGridButton)
	weaponList:setHorizontalCount(5)
	weaponList:setSpacing(10)
	weaponList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	weaponList:setHorizontalScrollbar(CoD.PC_GridHorizontalScrollbar)
	weaponList:setDataSource("Unlockables")
	weaponList:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end)
	local PCArrowR = weaponList
	local PCArrowL = weaponList.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	PCArrowL(PCArrowR, f1_local5.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
	end, false)
	weaponList:linkToElementModel(weaponList, "itemIndex", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	weaponList:linkToElementModel(weaponList, "globalItemIndex", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	weaponList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f8_local0 = nil
		CoD.CACUtility.UpdateWeaponNameInfoModel(f1_arg0, element, f1_arg1)
		CoD.WZUtility.UpdatePersonalizeWeaponModel(element, f1_arg1, f1_arg0)
		return f8_local0
	end)
	weaponList:registerEventHandler("list_active_changed", function(element, event)
		local f9_local0 = nil
		if not IsPC() then
			UpdateSelfElementState(f1_arg0, self.ArrowR, f1_arg1)
			UpdateSelfElementState(f1_arg0, self.ArrowL, f1_arg1)
		end
		return f9_local0
	end)
	weaponList:registerEventHandler("lose_list_focus", function(element, event)
		local f10_local0 = nil
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
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.WZUtility.IsPersonalizationLockedForWeapon(menu, element, controller) then
			CoD.CraftUtility.SetupPaintjobPersonalization(self, element, controller)
			CoD.CACUtility.OpenWeaponPersonalizationOverlay(self, menu, controller, element, element, "primary")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.WZUtility.IsPersonalizationLockedForWeapon(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09], 0x94122F68876E5D9, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], "ui_contextual_1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.WZUtility.IsPersonalizationLockedForWeapon(menu, element, controller) then
			CoD.CraftUtility.SetupPaintjobPersonalization(self, element, controller)
			CoD.CACUtility.OpenWeaponPersonalizationOverlay(self, menu, controller, element, element, "primary")
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.WZUtility.IsPersonalizationLockedForWeapon(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x94122F68876E5D9, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_contextual_1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.WZUtility.IsPersonalizationLockedForWeapon(menu, element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			PlaySoundAlias("uin_toggle_generic")
			CoD.CACUtility.ShowWeaponVariantList(menu, controller, self.WeaponVariantListWidget)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) and not CoD.WZUtility.IsPersonalizationLockedForWeapon(menu, element, controller) and CoD.CACUtility.HasSignatureWeapons(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MWHEELUP", function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollLeft(self.weaponList)
		CoD.GridAndListUtility.ValidateActiveItemVisibility(self.weaponList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MWHEELUP")
		return false
	end, false)
	f1_arg0:AddButtonCallbackFunction(weaponList, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MWHEELDOWN", function(element, menu, controller, model)
		CoD.GridAndListUtility.ScrollRight(self.weaponList)
		CoD.GridAndListUtility.ValidateActiveItemVisibility(self.weaponList)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0x0, nil, "MWHEELDOWN")
		return false
	end, false)
	self.__on_menuOpened_weaponList = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
		local f22_local0 = weaponList
		if IsPC() then
			CoD.GridAndListUtility.SetFocusToFirstSelectableItem(f22_local0)
			CoD.WZUtility.UpdatePersonalizeWeaponModel(f22_local0, f22_arg1, f22_arg2)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_weaponList)
	weaponList:subscribeToGlobalModel(f1_arg1, "PerController", "Unlockables.listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(weaponList, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	weaponList:subscribeToGlobalModel(f1_arg1, "WeaponPersonalization", "listUpdate", function(model)
		CoD.GridAndListUtility.UpdateDataSource(weaponList, true, false, true)
		UpdateSelfState(self, f1_arg1)
	end)
	weaponList:AddContextualMenuAction(f1_arg0, f1_arg1, 0xAFF37175F950D17, function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
		if IsMouseOrKeyboard(f25_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualTo(f25_arg0, f25_arg2, "itemIndex", CoDShared.EmptyItemIndex) and not CoD.CACUtility.IsCACItemLocked(f25_arg1, f25_arg0, f25_arg2) and not CoD.WZUtility.IsPersonalizationLockedForWeapon(f25_arg1, f25_arg0, f25_arg2) then
			return function(f26_arg0, f26_arg1, f26_arg2, f26_arg3)
				CoD.CraftUtility.SetupPaintjobPersonalization(self, f26_arg0, f26_arg2)
				CoD.CACUtility.OpenWeaponPersonalizationOverlay(self, f26_arg1, f26_arg2, f26_arg0, f26_arg0, "primary")
				PlaySoundAlias("uin_toggle_generic")
			end
		else
		end
	end)
	self:addElement(weaponList)
	self.weaponList = weaponList
	PCArrowL = nil
	PCArrowL = CoD.WarzoneContextualExtraItemsArrow.new(f1_arg0, f1_arg1, 0, 0, 177.5, 207.5, 0, 0, 111.5, 146.5)
	PCArrowL:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.WZUtility.IsQuickEquipListFirstItemVisible(self.weaponList)
			end,
		},
	})
	PCArrowL:setZRot(90)
	PCArrowL.Arrow:setImage(RegisterImage(0x5E74D00B45D12B6))
	PCArrowL.Arrow2:setImage(RegisterImage(0x5E74D00B45D12B6))
	PCArrowL:appendEventHandler("input_source_changed", function(f28_arg0, f28_arg1)
		f28_arg1.menu = f28_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f28_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local5 = PCArrowL
	PCArrowR = PCArrowL.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	PCArrowR(f1_local5, f1_local6.LastInput, function(f29_arg0, f29_arg1)
		CoD.Menu.UpdateButtonShownState(f29_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PCArrowL:registerEventHandler("gain_focus", function(element, event)
		local f30_local0 = nil
		if element.gainFocus then
			f30_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f30_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f30_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCArrowL, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.GridAndListUtility.ScrollLeft(self.weaponList)
			CoD.GridAndListUtility.ValidateActiveItemVisibility(self.weaponList)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
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
	PCArrowR:setZRot(270)
	PCArrowR.Arrow:setImage(RegisterImage(0x5E74D00B45D12B6))
	PCArrowR.Arrow2:setImage(RegisterImage(0x5E74D00B45D12B6))
	PCArrowR:appendEventHandler("input_source_changed", function(f34_arg0, f34_arg1)
		f34_arg1.menu = f34_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f34_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f1_local6 = PCArrowR
	f1_local5 = PCArrowR.subscribeToModel
	local WeaponVariantListWidget = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local6, WeaponVariantListWidget.LastInput, function(f35_arg0, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PCArrowR:registerEventHandler("gain_focus", function(element, event)
		local f36_local0 = nil
		if element.gainFocus then
			f36_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f36_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f36_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PCArrowR, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) then
			CoD.GridAndListUtility.ScrollRight(self.weaponList)
			CoD.GridAndListUtility.ValidateActiveItemVisibility(self.weaponList)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(PCArrowR)
	self.PCArrowR = PCArrowR
	f1_local5 = nil
	self.ArrowL = LUI.UIElement.createFake()
	f1_local6 = nil
	self.ArrowR = LUI.UIElement.createFake()
	WeaponVariantListWidget = CoD.WeaponVariantListWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 490)
	WeaponVariantListWidget.SignatureWeaponList:setWidgetType(CoD.WZPersonalizeWeapon_AttachmentSlot)
	WeaponVariantListWidget.SignatureWeaponList:setSpacing(10)
	WeaponVariantListWidget:registerEventHandler("gain_focus", function(element, event)
		local f39_local0 = nil
		if element.gainFocus then
			f39_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f39_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
		return f39_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WeaponVariantListWidget, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.CACUtility.HideWeaponVariantList(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
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
	self:appendEventHandler("grid_updated", function(f44_arg0, f44_arg1)
		f44_arg1.menu = f44_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f44_arg1)
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
	local f1_local8 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	f1_local8 = weaponCategoryList
	if IsPC() then
		DisableKeyboardNavigationByElement(f1_local8)
	end
	f1_local8 = weaponList
	if IsPC() then
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local8, f1_arg1, "displayName", "", "")
		CoD.GridAndListUtility.HideScrollbarsForGamepad(f1_arg0, f1_arg1, f1_local8)
	elseif not IsPC() then
		CoD.GridAndListUtility.RemoveHorizontalScrollbar(f1_arg0, f1_local8)
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
	f1_local8 = WeaponVariantListWidget
	HideWidget(self.WeaponVariantListWidget)
	SetElementProperty(f1_local8, "_forWZArmory", true)
	return self
end
CoD.WZPersonalizeWeapon_WeaponListWidget.__onClose = function(f46_arg0)
	f46_arg0.__on_close_removeOverrides()
	f46_arg0.WeaponVariantListWidget:close()
	f46_arg0.weaponCategoryList:close()
	f46_arg0.weaponList:close()
	f46_arg0.PCArrowL:close()
	f46_arg0.PCArrowR:close()
	f46_arg0.ArrowL:close()
	f46_arg0.ArrowR:close()
end
