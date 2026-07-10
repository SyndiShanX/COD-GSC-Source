require("x64:e76515f04a1ff80")
CoD.PerkTalentListWidget = InheritFrom(LUI.UIElement)
CoD.PerkTalentListWidget.__defaultWidth = 2200
CoD.PerkTalentListWidget.__defaultHeight = 500
CoD.PerkTalentListWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PerkTalentListWidget)
	self.id = "PerkTalentListWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local TempBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TempBackground:setRGB(0.18, 0.18, 0.18)
	TempBackground:setAlpha(0)
	self:addElement(TempBackground)
	self.TempBackground = TempBackground
	local itemList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	itemList:setLeftRight(0.5, 0.5, -370, 370)
	itemList:setTopBottom(0, 0, 248, 338)
	itemList:setScale(1.2, 1.2)
	itemList:setWidgetType(CoD.TalentSlotContainer)
	itemList:setHorizontalCount(5)
	itemList:setSpacing(10)
	itemList:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	itemList:setDataSource("Unlockables")
	itemList:linkToElementModel(itemList, "globalItemIndex", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	itemList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f3_local0 = nil
		CoD.BreadcrumbUtility.SetItemAsOld(f1_arg0, element, f1_arg1)
		CoD.CACUtility.UpdateWeaponModel(f1_arg0, element, f1_arg1)
		return f3_local0
	end)
	itemList:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(itemList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsPC() and not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.CACUtility.EquipWeapon(self, element, menu, controller, true)
			CoD.CACUtility.UpdateWeaponModel(menu, element, controller)
			UpdateSelfElementState(menu, self, controller)
			CoD.CACUtility.EquippedItemsChanged(menu, controller)
			return true
		elseif not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.CACUtility.EquipWeapon(self, element, menu, controller, true)
			CoD.CACUtility.EquippedItemsChanged(menu, controller)
			CoD.CACUtility.UpdateWeaponModel(menu, element, controller)
			UpdateSelfElementState(menu, self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() and not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		elseif not CoD.CACUtility.IsItemEquippedInCurrentLoadout(menu, element, controller) and not CoD.CACUtility.IsCACItemLocked(menu, element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self.__on_menuOpened_itemList = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
		local f7_local0 = itemList
		CoD.CACUtility.SetActiveListItemToEquippedItem(f7_arg2, f7_arg1, f7_local0)
		CoD.CACUtility.UpdateWeaponModel(f7_arg2, f7_local0, f7_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_itemList)
	LUI.OverrideFunction_CallOriginalFirst(itemList, "setModel", function(element, controller)
		if not CoD.ModelUtility.IsSelfModelNil(element, f1_arg1) then
			SetControllerModelValue(f1_arg1, "CACHasSelection", true)
		elseif CoD.ModelUtility.IsSelfModelNil(element, f1_arg1) then
			SetControllerModelValue(f1_arg1, "CACHasSelection", false)
		end
	end)
	self:addElement(itemList)
	self.itemList = itemList
	itemList.id = "itemList"
	self.__defaultFocus = itemList
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_itemList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	f1_local3 = itemList
	if IsPC() then
		CoD.CACUtility.UseEquippedItemAsDefaultFocus(f1_arg0, f1_arg1, f1_local3)
	end
	return self
end
CoD.PerkTalentListWidget.__onClose = function(f10_arg0)
	f10_arg0.__on_close_removeOverrides()
	f10_arg0.itemList:close()
end
