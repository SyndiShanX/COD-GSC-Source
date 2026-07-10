require("x64:3c489c2e8f56ee9")
require("x64:b083cf2b5832e0")
require("x64:971953d269ced4e")
require("x64:bf776923c7291f4")
CoD.PC_MultiItemPickup = InheritFrom(LUI.UIElement)
CoD.PC_MultiItemPickup.__defaultWidth = 877
CoD.PC_MultiItemPickup.__defaultHeight = 585
CoD.PC_MultiItemPickup.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_MultiItemPickup)
	self.id = "PC_MultiItemPickup"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local ItemPickupList = LUI.UIList.new(f1_arg0, f1_arg1, 11, 100, nil, false, false, false, false)
	ItemPickupList:setLeftRight(0.5, 0.5, -438.5, 438.5)
	ItemPickupList:setTopBottom(0, 0, 40.5, 584.5)
	ItemPickupList:setWidgetType(CoD.MultiItemPickupWaypointItemKBM)
	ItemPickupList:setHorizontalCount(8)
	ItemPickupList:setVerticalCount(5)
	ItemPickupList:setSpacing(11)
	ItemPickupList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ItemPickupList:setVerticalScrollbar(CoD.PC_MultiItemPickup_Scrollbar)
	ItemPickupList:setBackingWidget(CoD.PC_MultiItemPickupBacking)
	ItemPickupList:setBackingWidgetXPadding(5)
	ItemPickupList:setBackingWidgetYPadding(5)
	ItemPickupList:setDataSource("MultiItemPickup")
	ItemPickupList:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	local HeaderStash = ItemPickupList
	local StashLine = ItemPickupList.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	StashLine(HeaderStash, f1_local4.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	ItemPickupList:linkToElementModel(ItemPickupList, "id", true, function(model, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	HeaderStash = ItemPickupList
	StashLine = ItemPickupList.subscribeToModel
	f1_local4 = DataSources.HUDItems.getModel(f1_arg1)
	StashLine(HeaderStash, f1_local4.weapon3dHintState, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	HeaderStash = ItemPickupList
	StashLine = ItemPickupList.subscribeToModel
	f1_local4 = DataSources.WarzoneInventory.getModel(f1_arg1)
	StashLine(HeaderStash, f1_local4.canTransferFromStash, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	HeaderStash = ItemPickupList
	StashLine = ItemPickupList.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	StashLine(HeaderStash, f1_local4["hudItems.inventory.filledSlots"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	ItemPickupList:linkToElementModel(ItemPickupList, "itemtype", true, function(model, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	ItemPickupList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f9_local0 = nil
		if IsMouseOrKeyboard(f1_arg1) then
			CoD.HUDUtility.SetAsCurrentMultiItemPickup(f1_arg1, element)
			CoD.WZUtility.SendInventoryItemFocusNotify(f1_arg1, element)
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
			CoD.HUDUtility.UpdateFocusStashModel(self, f1_arg1, true)
		end
		return f9_local0
	end)
	ItemPickupList:registerEventHandler("lose_list_focus", function(element, event)
		local f10_local0 = nil
		if IsMouseOrKeyboard(f1_arg1) then
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(f1_arg1)
			CoD.HUDUtility.UpdateFocusStashModel(self, f1_arg1, false)
		end
		return f10_local0
	end)
	ItemPickupList:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ItemPickupList, f1_arg1, Enum[@"luibutton"][@"lui_key_ltrig"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) then
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.EQUIPS) then
			CoD.WZUtility.SendInventoryPickUpNotify(controller, element)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.SWAPS) then
			CoD.WZUtility.SendInventoryPickUpNotify(controller, element)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
			CoD.WZUtility.SendInventoryPickUpNotify(controller, element)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MOUSE1")
			return false
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.AMMO_FULL) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_0", nil, "MOUSE1")
			return false
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.EQUIPS) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"warzone/equip", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.SWAPS) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"warzone/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_ltrig"], @"hash_1339E923E692AD5E", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ItemPickupList, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "MOUSE3", function(element, menu, controller, model)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "WarzoneInventory", "canTransferFromStash") then
			CoD.WZUtility.SendInventoryPickUpStowedWeaponNotify(controller, element)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_WEAPON_ATTACHMENT_SWAP) then
			CoD.WZUtility.SendInventoryAttachmentPickUpNotify(controller)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(controller) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
			CoD.WZUtility.SendInventoryAttachmentPickUpNotify(controller)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(controller) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.SWAPS) and not CoD.WZUtility.InventoryItemDisplaysEquip(element, controller) then
			CoD.WZUtility.SendInventoryAttachmentPickUpNotify(controller)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "WarzoneInventory", "canTransferFromStash") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"wz/transfer_stowed", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.ALSO_ALLOW_WEAPON_ATTACHMENT_SWAP) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"hash_4928DC6C23119D85", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(controller) and CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"warzone/swap", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		elseif IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(controller) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.SWAPS) and not CoD.WZUtility.InventoryItemDisplaysEquip(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"warzone/equip", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(ItemPickupList, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and CoD.WZUtility.InventoryItemDisplaysPickup(element, controller) then
			CoD.WZUtility.SendInventoryAttachmentPickUpNotify(controller)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemtype", "weapon") then
			CoD.WZUtility.SendInventoryAttachmentPickUpNotify(controller)
			CoD.WZUtility.SendInventoryItemFocusNoneNotify(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and CoD.WZUtility.InventoryItemDisplaysPickup(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"hash_0", nil, "MOUSE2")
			return false
		elseif not CoD.WZUtility.IsDualWeaponMiddleClickAttachmentTransferDisabled() and IsMouseOrKeyboard(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.ModelUtility.IsGlobalDataSourceModelValueEnumBitSet(controller, "HUDItems", "weapon3dHintState", CoD.HUDUtility.Weapon3DHintStateFlags.INVENTORY_FULL) and not CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "itemtype", "weapon") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"hash_1339E923E692AD5E", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	ItemPickupList:subscribeToGlobalModel(f1_arg1, "MultiItemPickup", "status", function(model)
		local f18_local0 = ItemPickupList
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"]) and IsMouseOrKeyboard(f1_arg1) then
			CoD.BaseUtility.EnableNavigation(f18_local0)
		elseif IsMouseOrKeyboard(f1_arg1) then
			CoD.BaseUtility.DisableNavigation(f18_local0)
		end
	end)
	ItemPickupList:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f19_local0 = ItemPickupList
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_415EF5E7734C15F5") and IsMouseOrKeyboard(f1_arg1) then
			CoD.ScoreboardUtility.HideScoreboard(f1_arg0, f1_arg1)
		end
	end)
	self:addElement(ItemPickupList)
	self.ItemPickupList = ItemPickupList
	StashLine = LUI.UIImage.new(0.5, 0.5, -442, 440, 0, 0, -1, 8)
	StashLine:setRGB(0.55, 0.54, 0.49)
	StashLine:setAlpha(0)
	StashLine:setZRot(180)
	StashLine:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	StashLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	StashLine:setShaderVector(0, 0, 0, 0, 0)
	StashLine:setupNineSliceShader(16, 4)
	self:addElement(StashLine)
	self.StashLine = StashLine
	HeaderStash = LUI.UIText.new(0.5, 0.5, -101, 99, 0, 0, 3.5, 25.5)
	HeaderStash:setRGB(0, 0, 0)
	HeaderStash:setText(LocalizeToUpperString(@"wz/stash"))
	HeaderStash:setTTF("ttmussels_regular")
	HeaderStash:setLetterSpacing(4)
	HeaderStash:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	HeaderStash:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	HeaderStash:setBackingType(1)
	HeaderStash:setBackingWidget(CoD.WZBox9Slice, f1_arg0, f1_arg1)
	HeaderStash:setBackingColor(0.55, 0.54, 0.49)
	HeaderStash:setBackingXPadding(16)
	HeaderStash:setBackingYPadding(2)
	self:addElement(HeaderStash)
	self.HeaderStash = HeaderStash
	ItemPickupList.id = "ItemPickupList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	f1_local4 = ItemPickupList
	if IsPC() then
		CoD.PCUtility.ActivateListPCSelectionBehavior(f1_local4)
		CoD.GridAndListUtility.AddListUpDownNavigation(f1_arg0, f1_local4, f1_arg1)
		CoD.GridAndListUtility.AddListLeftRightNavigation(f1_arg0, f1_local4, f1_arg1)
		SetElementProperty(f1_local4, "__focusableBackingWidget", true)
		SetElementProperty(self.ItemPickupList, "__isForKBM", true)
	end
	return self
end
CoD.PC_MultiItemPickup.__onClose = function(f20_arg0)
	f20_arg0.ItemPickupList:close()
end
