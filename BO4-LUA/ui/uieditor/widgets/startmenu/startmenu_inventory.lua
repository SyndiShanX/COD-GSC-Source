require("x64:a0ca55b30183dbe")
require("x64:ca18cd922a43cfe")
require("x64:454254f1f309175")
require("x64:afb0fdb9191a2d2")
require("x64:f0aafbf6db03300")
require("x64:b6a65293a391f98")
require("x64:79177e5d8aa2dec")
require("x64:e8dbd840828bc3")
require("x64:b710bc406e458bd")
require("x64:1fc064d090be5f5")
require("x64:633abb056df5b28")
require("x64:f06de25bce86377")
require("x64:7a7a2327a1d8657")
CoD.StartMenu_Inventory = InheritFrom(LUI.UIElement)
CoD.StartMenu_Inventory.__defaultWidth = 1920
CoD.StartMenu_Inventory.__defaultHeight = 1080
CoD.StartMenu_Inventory.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if IsInGame() then
		CoD.PlayerRoleUtility.SetPositionDraftSelectedCharacterIndex(f1_arg1)
	end
	self:setUseCylinderMapping(false)
	self:setClass(CoD.StartMenu_Inventory)
	self.id = "StartMenu_Inventory"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local f1_local1 = nil
	f1_local1 = LUI.UIElement.createFake()
	self.CurrentWeaponImage = f1_local1
	local CurrentWeaponImagePC = nil
	CurrentWeaponImagePC = CoD.StartMenu_Inventory_CurrentWeaponPC.new(f1_arg0, f1_arg1, 0.5, 0.5, 493, 943, 0.5, 0.5, -423, -210)
	CurrentWeaponImagePC:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", nil, function(model)
		CurrentWeaponImagePC:setModel(model, f1_arg1)
	end)
	CurrentWeaponImagePC:linkToElementModel(CurrentWeaponImagePC, "id", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end)
	CurrentWeaponImagePC:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f4_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
	end)
	local AmmoList = CurrentWeaponImagePC
	local InventoryList = CurrentWeaponImagePC.subscribeToModel
	local inventoryDescription = Engine[@"getmodelforcontroller"](f1_arg1)
	InventoryList(AmmoList, inventoryDescription.LastInput, function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	AmmoList = CurrentWeaponImagePC
	InventoryList = CurrentWeaponImagePC.subscribeToModel
	inventoryDescription = DataSources.WarzoneInventory.getModel(f1_arg1)
	InventoryList(AmmoList, inventoryDescription.currentWeaponIndex, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	AmmoList = CurrentWeaponImagePC
	InventoryList = CurrentWeaponImagePC.subscribeToModel
	inventoryDescription = DataSources.WarzoneInventory.getModel(f1_arg1)
	InventoryList(AmmoList, inventoryDescription["weapon0.hasAttachments"], function(f7_arg0, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	AmmoList = CurrentWeaponImagePC
	InventoryList = CurrentWeaponImagePC.subscribeToModel
	inventoryDescription = DataSources.WarzoneInventory.getModel(f1_arg1)
	InventoryList(AmmoList, inventoryDescription["weapon1.hasAttachments"], function(f8_arg0, f8_arg1)
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(f8_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
	end, false)
	CurrentWeaponImagePC:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"])
		return f9_local0
	end)
	f1_arg0:AddButtonCallbackFunction(CurrentWeaponImagePC, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_remove", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsGamepad(controller) then
			CoD.WZUtility.SendInventoryDropCurrentWeaponNotify(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CurrentWeaponImagePC, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropCurrentWeaponNotify(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CurrentWeaponImagePC, f1_arg1, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], "F", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 0) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon0.hasAttachments", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsGamepad(controller) then
			CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify(controller)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon1.hasAttachments", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsGamepad(controller) then
			CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 0) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon0.hasAttachments", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_294D6AF2F50BEFEF", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "F")
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon1.hasAttachments", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"hash_294D6AF2F50BEFEF", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "F")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(CurrentWeaponImagePC, f1_arg1, Enum[@"luibutton"][@"lui_key_rtrig"], "F", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 0) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon0.hasAttachments", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify(controller)
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon1.hasAttachments", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify(controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 0) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon0.hasAttachments", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_294D6AF2F50BEFEF", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "F")
			return true
		elseif CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "currentWeaponIndex", 1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(controller, "WarzoneInventory", "weapon1.hasAttachments", 1) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_rtrig"], @"hash_294D6AF2F50BEFEF", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "F")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(CurrentWeaponImagePC, "childFocusGained", function(element)
		CoD.WZUtility.SetElementModelToCurrentWeaponModel(f1_arg1, self.inventoryDescription)
		CoD.WZUtility.SetElementModelValueToCurrentWeaponModel(f1_arg1, element, "currentWeaponModel")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	LUI.OverrideFunction_CallOriginalFirst(CurrentWeaponImagePC, "childFocusLost", function(element)
		if IsPC() then
			CoD.BaseUtility.SetElementModelToNil(f1_arg1, self.inventoryDescription)
		end
	end)
	CurrentWeaponImagePC:subscribeToGlobalModel(f1_arg1, "WarzoneInventory", "currentWeaponIndex", function(model)
		local f20_local0 = CurrentWeaponImagePC
		if CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "CurrentWeaponImagePC") then
			CoD.WZUtility.SetElementModelToCurrentWeaponModel(f1_arg1, self.inventoryDescription)
			CoD.WZUtility.SetElementModelValueToCurrentWeaponModel(f1_arg1, f20_local0, "currentWeaponModel")
			CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, f20_local0)
		end
	end)
	CurrentWeaponImagePC:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f21_arg0, f21_arg1, f21_arg2, f21_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f21_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f21_arg0, f21_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			return function(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
				CoD.WZUtility.SendInventoryDropCurrentWeaponNotify(f22_arg2)
			end
		else
		end
	end)
	CurrentWeaponImagePC:AddContextualMenuAction(f1_arg0, f1_arg1, @"hash_294D6AF2F50BEFEF", function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f23_arg2) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f23_arg2, "WarzoneInventory", "currentWeaponIndex", 0) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f23_arg2, "WarzoneInventory", "weapon0.hasAttachments", 1) then
			return function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
				CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify(f24_arg2)
			end
		elseif not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f23_arg2) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f23_arg2, "WarzoneInventory", "currentWeaponIndex", 1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f23_arg2, "WarzoneInventory", "weapon1.hasAttachments", 1) then
			return function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
				CoD.WZUtility.SendInventoryDropCurrentWeaponAndDetachNotify(f25_arg2)
			end
		else
		end
	end)
	self:addElement(CurrentWeaponImagePC)
	self.CurrentWeaponImagePC = CurrentWeaponImagePC
	InventoryList = CoD.StartMenu_InventoryList.new(f1_arg0, f1_arg1, 0.5, 0.5, -270, 270, 1, 1, -330.5, -91.5)
	InventoryList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f26_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		return f26_local0
	end)
	InventoryList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f27_local0 = nil
		if IsPC() then
			CoD.BaseUtility.SetElementModelToNil(f1_arg1, self.inventoryDescription)
		end
		return f27_local0
	end)
	LUI.OverrideFunction_CallOriginalFirst(InventoryList, "setModel", function(element, controller)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	self:addElement(InventoryList)
	self.InventoryList = InventoryList
	AmmoList = CoD.StartMenu_AmmoList.new(f1_arg0, f1_arg1, 0, 0, 52, 272, 0.5, 0.5, -423, 51)
	AmmoList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f29_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		return f29_local0
	end)
	self:addElement(AmmoList)
	self.AmmoList = AmmoList
	inventoryDescription = CoD.StartMenu_InventoryDescription.new(f1_arg0, f1_arg1, 1, 1, -367, -55, 0.5, 0.5, -211, -11)
	self:addElement(inventoryDescription)
	self.inventoryDescription = inventoryDescription
	local WeaponAttachments = CoD.StartMenu_AttachmentList.new(f1_arg0, f1_arg1, 0.5, 0.5, -326, 326, 0.5, 0.5, -31, 93)
	WeaponAttachments:registerEventHandler("list_item_gain_focus", function(element, event)
		local f30_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		return f30_local0
	end)
	self:addElement(WeaponAttachments)
	self.WeaponAttachments = WeaponAttachments
	local Health = CoD.WarzoneInventoryMenuItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -626, -534, 1, 1, -227.5, -137.5)
	Health:setScale(1.3, 1.3)
	Health:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "health", function(model)
		Health:setModel(model, f1_arg1)
	end)
	Health:appendEventHandler("input_source_changed", function(f32_arg0, f32_arg1)
		f32_arg1.menu = f32_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f32_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	local Storage = Health
	local Gear = Health.subscribeToModel
	local Equipment = Engine[@"getmodelforcontroller"](f1_arg1)
	Gear(Storage, Equipment.LastInput, function(f33_arg0, f33_arg1)
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f33_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	Health:linkToElementModel(Health, "id", true, function(model, f34_arg1)
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f34_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	Health:linkToElementModel(Health, "stackCount", true, function(model, f35_arg1)
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f35_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	Health:registerEventHandler("list_active_changed", function(element, event)
		local f36_local0 = nil
		CoD.GridAndListUtility.AlignElementToListItem2D(f1_arg1, self.HealthInventorySplitter, element)
		return f36_local0
	end)
	Health:registerEventHandler("gain_focus", function(element, event)
		local f37_local0 = nil
		if element.gainFocus then
			f37_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f37_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		return f37_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Health, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		elseif not IsPC() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.SetupSplitCount(controller, element)
			MenuHidesFreeCursor(menu, controller)
			SetElementState(self, self.HealthInventorySplitter, controller, "Open")
			SetLoseFocusToElement(self, "Health", controller)
			SetFocusToElement(self, "HealthInventorySplitter", controller)
			return true
		elseif IsPC() and IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not IsPC() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsPC() and IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Health, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Health, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], "F", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "F")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Health, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Health, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "MOUSE3", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(Health, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	Health:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f49_arg0, f49_arg1, f49_arg2, f49_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f49_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f49_arg0, f49_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			return function(f50_arg0, f50_arg1, f50_arg2, f50_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f50_arg2, f50_arg0)
			end
		else
		end
	end)
	Health:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/split", function(f51_arg0, f51_arg1, f51_arg2, f51_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f51_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f51_arg0, f51_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(f51_arg0, f51_arg2, "stackCount", 1) then
			return function(f52_arg0, f52_arg1, f52_arg2, f52_arg3)
				CoD.WZUtility.OpenPCSplitterWidgetForElement(self, f52_arg1, f52_arg2, f52_arg0)
			end
		else
		end
	end)
	self:addElement(Health)
	self.Health = Health
	Gear = CoD.WarzoneInventoryMenuItem.new(f1_arg0, f1_arg1, 0.5, 0.5, -486, -394, 1, 1, -227.5, -137.5)
	Gear:setScale(1.3, 1.3)
	Gear:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "gear", function(model)
		Gear:setModel(model, f1_arg1)
	end)
	Gear:appendEventHandler("input_source_changed", function(f54_arg0, f54_arg1)
		f54_arg1.menu = f54_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f54_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f54_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f54_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	Equipment = Gear
	Storage = Gear.subscribeToModel
	local f1_local11 = Engine[@"getmodelforcontroller"](f1_arg1)
	Storage(Equipment, f1_local11.LastInput, function(f55_arg0, f55_arg1)
		CoD.Menu.UpdateButtonShownState(f55_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f55_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f55_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	Gear:linkToElementModel(Gear, "id", true, function(model, f56_arg1)
		CoD.Menu.UpdateButtonShownState(f56_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f56_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f56_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	Gear:registerEventHandler("gain_focus", function(element, event)
		local f57_local0 = nil
		if element.gainFocus then
			f57_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f57_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f57_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Gear, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Gear, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Gear, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(Gear, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	Gear:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f65_arg0, f65_arg1, f65_arg2, f65_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f65_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f65_arg0, f65_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			return function(f66_arg0, f66_arg1, f66_arg2, f66_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f66_arg2, f66_arg0)
			end
		else
		end
	end)
	self:addElement(Gear)
	self.Gear = Gear
	Storage = CoD.WarzoneInventoryMenuItem.new(f1_arg0, f1_arg1, 0.5, 0.5, 395, 487, 1, 1, -227.5, -137.5)
	Storage:setScale(1.3, 1.3)
	Storage:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "storage", function(model)
		Storage:setModel(model, f1_arg1)
	end)
	Storage:appendEventHandler("input_source_changed", function(f68_arg0, f68_arg1)
		f68_arg1.menu = f68_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f68_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f68_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f68_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	f1_local11 = Storage
	Equipment = Storage.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	Equipment(f1_local11, f1_local12.LastInput, function(f69_arg0, f69_arg1)
		CoD.Menu.UpdateButtonShownState(f69_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f69_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f69_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end, false)
	Storage:linkToElementModel(Storage, "id", true, function(model, f70_arg1)
		CoD.Menu.UpdateButtonShownState(f70_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f70_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f70_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
	end)
	Storage:registerEventHandler("gain_focus", function(element, event)
		local f71_local0 = nil
		if element.gainFocus then
			f71_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f71_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		return f71_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Storage, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Storage, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Storage, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(Storage, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	Storage:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f79_arg0, f79_arg1, f79_arg2, f79_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f79_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f79_arg0, f79_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			return function(f80_arg0, f80_arg1, f80_arg2, f80_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f80_arg2, f80_arg0)
			end
		else
		end
	end)
	self:addElement(Storage)
	self.Storage = Storage
	Equipment = CoD.WarzoneInventoryMenuItem.new(f1_arg0, f1_arg1, 0.5, 0.5, 534, 626, 1, 1, -227.5, -137.5)
	Equipment:setScale(1.3, 1.3)
	Equipment:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "equipment", function(model)
		Equipment:setModel(model, f1_arg1)
	end)
	Equipment:linkToElementModel(Equipment, "id", true, function(model, f82_arg1)
		CoD.Menu.UpdateButtonShownState(f82_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f82_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f82_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f82_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f82_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	Equipment:appendEventHandler("input_source_changed", function(f83_arg0, f83_arg1)
		f83_arg1.menu = f83_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f83_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f83_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f83_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f83_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f83_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	f1_local12 = Equipment
	f1_local11 = Equipment.subscribeToModel
	local ResourceList = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local11(f1_local12, ResourceList.LastInput, function(f84_arg0, f84_arg1)
		CoD.Menu.UpdateButtonShownState(f84_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f84_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(f84_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f84_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(f84_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end, false)
	Equipment:linkToElementModel(Equipment, "stackCount", true, function(model, f85_arg1)
		CoD.Menu.UpdateButtonShownState(f85_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f85_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f85_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
	end)
	Equipment:registerEventHandler("list_active_changed", function(element, event)
		local f86_local0 = nil
		CoD.GridAndListUtility.AlignElementToListItem2D(f1_arg1, self.EquipmentInventorySplitter, element)
		return f86_local0
	end)
	Equipment:registerEventHandler("gain_focus", function(element, event)
		local f87_local0 = nil
		if element.gainFocus then
			f87_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f87_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"])
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"])
		return f87_local0
	end)
	f1_arg0:AddButtonCallbackFunction(Equipment, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		elseif not IsPC() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.SetupSplitCount(controller, element)
			MenuHidesFreeCursor(menu, controller)
			SetElementState(self, self.EquipmentInventorySplitter, controller, "Open")
			SetLoseFocusToElement(self, "Equipment", controller)
			SetFocusToElement(self, "EquipmentInventorySplitter", controller)
			return true
		elseif IsPC() and IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and CoD.ModelUtility.IsSelfModelValueEqualTo(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif not IsPC() and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		elseif IsPC() and IsGamepad(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"] | Enum[@"luibuttonpromptflags"][@"hash_72919C98A7A845F0"] | 400 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Equipment, f1_arg1, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], "ui_remove", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "ui_remove")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Equipment, f1_arg1, Enum[@"luibutton"][@"lui_key_start"], "F", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and not CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "F")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Equipment, f1_arg1, Enum[@"luibutton"][@"hash_64D2505E19049444"], "MOUSE2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.SendInventoryDropNotify(controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"hash_64D2505E19049444"], @"warzone/drop", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(Equipment, f1_arg1, Enum[@"luibutton"][@"lui_key_pckey_2"], "MOUSE3", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.WZUtility.OpenPCSplitterWidgetForElement(self, menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, controller, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, controller, "stackCount", 1) and CoD.WZUtility.ScoreboardVisibilitySetAndPC(controller) and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_pckey_2"], @"warzone/split", Enum[@"luibuttonpromptflags"][@"bpf_contextual"], "MOUSE3")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(Equipment, "childFocusGained", function(element)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	Equipment:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/drop", function(f99_arg0, f99_arg1, f99_arg2, f99_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f99_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f99_arg0, f99_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) then
			return function(f100_arg0, f100_arg1, f100_arg2, f100_arg3)
				CoD.WZUtility.SendInventoryDropNotify(f100_arg2, f100_arg0)
			end
		else
		end
	end)
	Equipment:AddContextualMenuAction(f1_arg0, f1_arg1, @"warzone/split", function(f101_arg0, f101_arg1, f101_arg2, f101_arg3)
		if not CoD.WZUtility.ScoreboardVisibilitySetAndPC(f101_arg2) and not CoD.ModelUtility.IsSelfModelValueEqualToEnum(f101_arg0, f101_arg2, "id", CoD.WZUtility.InventoryItem.INVENTORY_ITEM_NONE) and CoD.ModelUtility.IsSelfModelValueGreaterThan(f101_arg0, f101_arg2, "stackCount", 1) then
			return function(f102_arg0, f102_arg1, f102_arg2, f102_arg3)
				CoD.WZUtility.OpenPCSplitterWidgetForElement(self, f102_arg1, f102_arg2, f102_arg0)
			end
		else
		end
	end)
	self:addElement(Equipment)
	self.Equipment = Equipment
	f1_local11 = nil
	f1_local11 = LUI.UIElement.createFake()
	self.EquipmentInventorySplitter = f1_local11
	f1_local12 = nil
	f1_local12 = LUI.UIElement.createFake()
	self.HealthInventorySplitter = f1_local12
	ResourceList = CoD.StartMenu_ResourceList.new(f1_arg0, f1_arg1, 1, 1, -367, -147, 0.5, 0.5, -423, -279)
	ResourceList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f103_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		return f103_local0
	end)
	self:addElement(ResourceList)
	self.ResourceList = ResourceList
	local PCKoreaContentDescriptorsContainer = nil
	PCKoreaContentDescriptorsContainer = CoD.PC_Korea_ContentDescriptors_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, 758, 947, 0.5, 0.5, 261, 597)
	self:addElement(PCKoreaContentDescriptorsContainer)
	self.PCKoreaContentDescriptorsContainer = PCKoreaContentDescriptorsContainer
	local ItemPickupList = nil
	ItemPickupList = CoD.PC_MultiItemPickup.new(f1_arg0, f1_arg1, 0.5, 0.5, -438.5, 438.5, 0.5, 0.5, -413.5, 171.5)
	ItemPickupList:setAlpha(0)
	self:addElement(ItemPickupList)
	self.ItemPickupList = ItemPickupList
	local WarzoneGameStatusIndicatorDisplayLeft = CoD.WarzoneGameStatusIndicatorDisplay.new(f1_arg0, f1_arg1, 0, 0, 52.5, 397.5, 0, 0, 33, 77)
	WarzoneGameStatusIndicatorDisplayLeft:mergeStateConditions({
		{
			stateName = "Right",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	WarzoneGameStatusIndicatorDisplayLeft.GameStatusIndicatorsRightSolo:setFilter(function(f106_arg0)
		return f106_arg0.type:get() == "gameInformation"
	end)
	WarzoneGameStatusIndicatorDisplayLeft.GameStatusIndicatorsRightSolo:setDataSource("WarzoneGameStatusIndicatorListInventoryLeft")
	WarzoneGameStatusIndicatorDisplayLeft.GameStatusIndicatorsLeftSolo:setFilter(function(f107_arg0)
		return f107_arg0.type:get() == "hudGameStat"
	end)
	WarzoneGameStatusIndicatorDisplayLeft.GameStatusIndicatorsLeftSolo:setDataSource("WarzoneGameStatusIndicatorListInventoryLeft")
	WarzoneGameStatusIndicatorDisplayLeft.GameStatusIndicators:setDataSource("WarzoneGameStatusIndicatorListInventoryLeft")
	self:addElement(WarzoneGameStatusIndicatorDisplayLeft)
	self.WarzoneGameStatusIndicatorDisplayLeft = WarzoneGameStatusIndicatorDisplayLeft
	local f1_local17 = nil
	f1_local17 = LUI.UIElement.createFake()
	self.QuitButton = f1_local17
	local WarzoneGameStatusIndicatorDisplayLeft2 = CoD.WarzoneGameStatusIndicatorDisplay.new(f1_arg0, f1_arg1, 0, 0, 1536.5, 1881.5, 0, 0, 33, 77)
	WarzoneGameStatusIndicatorDisplayLeft2:mergeStateConditions({
		{
			stateName = "Right",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	WarzoneGameStatusIndicatorDisplayLeft2.GameStatusIndicatorsRightSolo:setFilter(function(f110_arg0)
		return f110_arg0.type:get() == "gameInformation"
	end)
	WarzoneGameStatusIndicatorDisplayLeft2.GameStatusIndicatorsRightSolo:setDataSource("WarzoneGameStatusIndicatorListInventoryRight")
	WarzoneGameStatusIndicatorDisplayLeft2.GameStatusIndicatorsLeftSolo:setFilter(function(f111_arg0)
		return f111_arg0.type:get() == "hudGameStat"
	end)
	WarzoneGameStatusIndicatorDisplayLeft2.GameStatusIndicatorsLeftSolo:setDataSource("WarzoneGameStatusIndicatorListInventoryRight")
	WarzoneGameStatusIndicatorDisplayLeft2.GameStatusIndicators:setDataSource("WarzoneGameStatusIndicatorListInventoryRight")
	self:addElement(WarzoneGameStatusIndicatorDisplayLeft2)
	self.WarzoneGameStatusIndicatorDisplayLeft2 = WarzoneGameStatusIndicatorDisplayLeft2
	local StartMenuArmorPlatesList = CoD.StartMenu_ArmorPlatesList.new(f1_arg0, f1_arg1, 0, 0, 52, 267, 0.5, 0.5, -15, 117)
	StartMenuArmorPlatesList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f112_local0 = nil
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
		return f112_local0
	end)
	LUI.OverrideFunction_CallOriginalFirst(StartMenuArmorPlatesList, "setModel", function(element, controller)
		SetElementModelToFocusedElementModel(f1_arg1, self, element, "inventoryDescription")
		CoD.WZUtility.UpdateWZInventoryTooltipOnElementPC(f1_arg1, element)
	end)
	self:addElement(StartMenuArmorPlatesList)
	self.StartMenuArmorPlatesList = StartMenuArmorPlatesList
	local InventorySplitterPC = nil
	InventorySplitterPC = CoD.WarzoneSplitInventory_PC.new(f1_arg0, f1_arg1, 0, 0, 225, 325, 0, 0, 650, 750)
	self:addElement(InventorySplitterPC)
	self.InventorySplitterPC = InventorySplitterPC
	local StartMenuInventoryDualWeapons = nil
	StartMenuInventoryDualWeapons = CoD.StartMenu_InventoryDualWeapons.new(f1_arg0, f1_arg1, 0.5, 0.5, 493, 943, 0, 0, 96, 996)
	self:addElement(StartMenuInventoryDualWeapons)
	self.StartMenuInventoryDualWeapons = StartMenuInventoryDualWeapons
	self:mergeStateConditions({
		{
			stateName = "MultiPick_ShowAttachments",
			condition = function(menu, element, event)
				local f114_local0 = IsMouseOrKeyboard(f1_arg1)
				if f114_local0 then
					f114_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.showAttachments", true)
					if f114_local0 then
						f114_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
					end
				end
				return f114_local0
			end,
		},
		{
			stateName = "MultiPick",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "MultiItemPickup", "status", Enum[@"hash_163CDAE6010C493"][@"hash_5C9FADA56582F80F"])
			end,
		},
		{
			stateName = "PCShowAttachments",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.showAttachments", true) and IsPC()
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "ShowAttachments",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.inventory.showAttachments", true)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f119_arg0, f119_arg1)
		f119_arg1.menu = f119_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f119_arg1)
	end)
	local f1_local22 = self
	local f1_local23 = self.subscribeToModel
	local f1_local24 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local23(f1_local22, f1_local24.LastInput, function(f120_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f120_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local22 = self
	f1_local23 = self.subscribeToModel
	f1_local24 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local23(f1_local22, f1_local24["hudItems.inventory.showAttachments"], function(f121_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f121_arg0:get(),
			modelName = "hudItems.inventory.showAttachments",
		})
	end, false)
	f1_local22 = self
	f1_local23 = self.subscribeToModel
	f1_local24 = DataSources.MultiItemPickup.getModel(f1_arg1)
	f1_local23(f1_local22, f1_local24.status, function(f122_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f122_arg0:get(),
			modelName = "status",
		})
	end, false)
	self.__on_onStartMenuOpened_self = function(f123_arg0, f123_arg1)
		local f123_local0 = self
		CoD.WZUtility.SetInventoryIsOpen(f123_arg1, true)
		CoD.WZUtility.ClearInventoryNag(f123_arg1)
	end
	LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_self)
	self.__on_onStartMenuClosed_self = function(f124_arg0, f124_arg1)
		local f124_local0 = self
		CoD.WZUtility.SetInventoryIsOpen(f124_arg1, false)
	end
	LUI.OverrideFunction_CallOriginalFirst(f1_arg0, "onStartMenuClosed", self.__on_onStartMenuClosed_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		if IsPC() then
			CoD.WZUtility.SetPCSplitterWidgetElement(self, f1_arg0, f1_arg1, self.InventorySplitterPC)
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		CoD.WZUtility.SetInventoryIsOpen(f1_arg1, false)
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f127_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_2DDDF8559F5B304D") and CoD.ModelUtility.IsScriptNotifyDataArgEqualTo(model, 1, 1) then
			CoD.ModelUtility.SetScriptNotifyDataArg(model, 1, 0)
			StartMenuGoBack(f1_arg0, f1_arg1)
		end
	end)
	f1_local1.id = "CurrentWeaponImage"
	if CoD.isPC then
		CurrentWeaponImagePC.id = "CurrentWeaponImagePC"
	end
	InventoryList.id = "InventoryList"
	AmmoList.id = "AmmoList"
	WeaponAttachments.id = "WeaponAttachments"
	Health.id = "Health"
	Gear.id = "Gear"
	Storage.id = "Storage"
	Equipment.id = "Equipment"
	f1_local11.id = "EquipmentInventorySplitter"
	f1_local12.id = "HealthInventorySplitter"
	ResourceList.id = "ResourceList"
	if CoD.isPC then
		ItemPickupList.id = "ItemPickupList"
	end
	WarzoneGameStatusIndicatorDisplayLeft.id = "WarzoneGameStatusIndicatorDisplayLeft"
	f1_local17:appendEventHandler("menu_loaded", function()
		f1_local17:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	f1_local17.id = "QuitButton"
	WarzoneGameStatusIndicatorDisplayLeft2.id = "WarzoneGameStatusIndicatorDisplayLeft2"
	StartMenuArmorPlatesList.id = "StartMenuArmorPlatesList"
	if CoD.isPC then
		InventorySplitterPC.id = "InventorySplitterPC"
	end
	if CoD.isPC then
		StartMenuInventoryDualWeapons.id = "StartMenuInventoryDualWeapons"
	end
	self.__defaultFocus = InventoryList
	self.__on_close_removeOverrides = function()
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuOpened", self.__on_onStartMenuOpened_self)
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuClosed", self.__on_onStartMenuClosed_self)
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuClosed", self.__on_onStartMenuClosed_EquipmentInventorySplitter)
		LUI.OverrideFunction_Remove(f1_arg0, "onStartMenuClosed", self.__on_onStartMenuClosed_HealthInventorySplitter)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local23 = self
	f1_local23 = f1_local1
	if IsPC() then
		DisableAutoButtonCallback(f1_arg0, f1_local23, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local23, f1_arg1, "currentWeaponModel->name", "", "")
	end
	f1_local23 = CurrentWeaponImagePC
	if IsPC() then
		DisableAutoButtonCallback(f1_arg0, f1_local23, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local23, f1_arg1, "name", "", "")
	end
	f1_local23 = Health
	if IsPC() then
		DisableAutoButtonCallback(f1_arg0, f1_local23, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local23, f1_arg1, "name", "", "")
	end
	f1_local23 = Gear
	if IsPC() then
		DisableAutoButtonCallback(f1_arg0, f1_local23, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local23, f1_arg1, "name", "", "")
	end
	f1_local23 = Storage
	if IsPC() then
		DisableAutoButtonCallback(f1_arg0, f1_local23, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local23, f1_arg1, "name", "", "")
	end
	f1_local23 = Equipment
	if IsPC() then
		DisableAutoButtonCallback(f1_arg0, f1_local23, f1_arg1)
		CoD.PCWidgetUtility.SetupContextualMenu(f1_local23, f1_arg1, "name", "", "")
	end
	DisableKeyboardNavigationByElement(InventorySplitterPC)
	f1_local23 = StartMenuInventoryDualWeapons
	if CoD.WZUtility.IsDualWeaponUIDisabled() then
		ReplaceElementWithFake(self, "StartMenuInventoryDualWeapons")
	elseif not CoD.WZUtility.IsDualWeaponUIDisabled() then
		ReplaceElementWithFake(self, "CurrentWeaponImagePC")
		ReplaceElementWithFake(self, "WeaponAttachments")
	end
	return self
end
CoD.StartMenu_Inventory.__resetProperties = function(f130_arg0)
	f130_arg0.WeaponAttachments:completeAnimation()
	f130_arg0.CurrentWeaponImage:completeAnimation()
	f130_arg0.AmmoList:completeAnimation()
	f130_arg0.ResourceList:completeAnimation()
	f130_arg0.inventoryDescription:completeAnimation()
	f130_arg0.HealthInventorySplitter:completeAnimation()
	f130_arg0.EquipmentInventorySplitter:completeAnimation()
	f130_arg0.ItemPickupList:completeAnimation()
	f130_arg0.CurrentWeaponImagePC:completeAnimation()
	f130_arg0.StartMenuArmorPlatesList:completeAnimation()
	f130_arg0.WeaponAttachments:setLeftRight(0.5, 0.5, -326, 326)
	f130_arg0.WeaponAttachments:setTopBottom(0.5, 0.5, -31, 93)
	f130_arg0.WeaponAttachments:setAlpha(1)
	f130_arg0.CurrentWeaponImage:setTopBottom(0.5, 0.5, -423, -103)
	f130_arg0.CurrentWeaponImage:setAlpha(1)
	f130_arg0.AmmoList:setLeftRight(0, 0, 52, 272)
	f130_arg0.AmmoList:setTopBottom(0.5, 0.5, -423, 51)
	f130_arg0.ResourceList:setLeftRight(1, 1, -367, -147)
	f130_arg0.ResourceList:setTopBottom(0.5, 0.5, -423, -279)
	f130_arg0.inventoryDescription:setLeftRight(1, 1, -367, -55)
	f130_arg0.inventoryDescription:setTopBottom(0.5, 0.5, -211, -11)
	f130_arg0.inventoryDescription:setAlpha(1)
	f130_arg0.HealthInventorySplitter:setAlpha(1)
	f130_arg0.EquipmentInventorySplitter:setAlpha(1)
	f130_arg0.ItemPickupList:setTopBottom(0.5, 0.5, -413.5, 171.5)
	f130_arg0.ItemPickupList:setAlpha(0)
	f130_arg0.CurrentWeaponImagePC:setTopBottom(0.5, 0.5, -423, -210)
	f130_arg0.StartMenuArmorPlatesList:setLeftRight(0, 0, 52, 267)
	f130_arg0.StartMenuArmorPlatesList:setTopBottom(0.5, 0.5, -15, 117)
end
CoD.StartMenu_Inventory.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f131_arg0, f131_arg1)
			f131_arg0:__resetProperties()
			f131_arg0:setupElementClipCounter(1)
			f131_arg0.WeaponAttachments:completeAnimation()
			f131_arg0.WeaponAttachments:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.WeaponAttachments)
		end,
	},
	MultiPick_ShowAttachments = {
		DefaultClip = function(f132_arg0, f132_arg1)
			f132_arg0:__resetProperties()
			f132_arg0:setupElementClipCounter(7)
			f132_arg0.CurrentWeaponImage:completeAnimation()
			f132_arg0.CurrentWeaponImage:setTopBottom(0.5, 0.5, -540, -220)
			f132_arg0.CurrentWeaponImage:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.CurrentWeaponImage)
			f132_arg0.CurrentWeaponImagePC:completeAnimation()
			f132_arg0.CurrentWeaponImagePC:setTopBottom(0, 0, 96, 309)
			f132_arg0.clipFinished(f132_arg0.CurrentWeaponImagePC)
			f132_arg0.AmmoList:completeAnimation()
			f132_arg0.AmmoList:setLeftRight(0.5, 0.5, -908, -688)
			f132_arg0.AmmoList:setTopBottom(0, 0, 96, 848)
			f132_arg0.clipFinished(f132_arg0.AmmoList)
			f132_arg0.inventoryDescription:completeAnimation()
			f132_arg0.inventoryDescription:setLeftRight(1, 1, -1627, -1315)
			f132_arg0.inventoryDescription:setTopBottom(0.5, 0.5, -376, -176)
			f132_arg0.inventoryDescription:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.inventoryDescription)
			f132_arg0.WeaponAttachments:completeAnimation()
			f132_arg0.WeaponAttachments:setLeftRight(0.5, 0.5, 392, 1044)
			f132_arg0.WeaponAttachments:setTopBottom(0, 0, 340, 464)
			f132_arg0.WeaponAttachments:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.WeaponAttachments)
			f132_arg0.EquipmentInventorySplitter:completeAnimation()
			f132_arg0.EquipmentInventorySplitter:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.EquipmentInventorySplitter)
			f132_arg0.HealthInventorySplitter:completeAnimation()
			f132_arg0.HealthInventorySplitter:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.HealthInventorySplitter)
			f132_arg0.ResourceList:completeAnimation()
			f132_arg0.ResourceList:setLeftRight(0.5, 0.5, -908, -688)
			f132_arg0.ResourceList:setTopBottom(0.5, 0.5, 289, 431)
			f132_arg0.clipFinished(f132_arg0.ResourceList)
			f132_arg0.ItemPickupList:completeAnimation()
			f132_arg0.ItemPickupList:setTopBottom(0, 0, 96, 386)
			f132_arg0.ItemPickupList:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.ItemPickupList)
			f132_arg0.StartMenuArmorPlatesList:completeAnimation()
			f132_arg0.StartMenuArmorPlatesList:setLeftRight(0.5, 0.5, -908, -693)
			f132_arg0.StartMenuArmorPlatesList:setTopBottom(0.5, 0.5, 55, 187)
			f132_arg0.clipFinished(f132_arg0.StartMenuArmorPlatesList)
		end,
	},
	MultiPick = {
		DefaultClip = function(f133_arg0, f133_arg1)
			f133_arg0:__resetProperties()
			f133_arg0:setupElementClipCounter(7)
			f133_arg0.CurrentWeaponImage:completeAnimation()
			f133_arg0.CurrentWeaponImage:setTopBottom(0.5, 0.5, -540, -220)
			f133_arg0.CurrentWeaponImage:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.CurrentWeaponImage)
			f133_arg0.CurrentWeaponImagePC:completeAnimation()
			f133_arg0.CurrentWeaponImagePC:setTopBottom(0, 0, 96, 309)
			f133_arg0.clipFinished(f133_arg0.CurrentWeaponImagePC)
			f133_arg0.AmmoList:completeAnimation()
			f133_arg0.AmmoList:setLeftRight(0.5, 0.5, -908, -688)
			f133_arg0.AmmoList:setTopBottom(0, 0, 96, 848)
			f133_arg0.clipFinished(f133_arg0.AmmoList)
			f133_arg0.inventoryDescription:completeAnimation()
			f133_arg0.inventoryDescription:setLeftRight(1, 1, -1627, -1315)
			f133_arg0.inventoryDescription:setTopBottom(0.5, 0.5, -376, -176)
			f133_arg0.inventoryDescription:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.inventoryDescription)
			f133_arg0.WeaponAttachments:completeAnimation()
			f133_arg0.WeaponAttachments:setLeftRight(0.5, 0.5, 392, 1044)
			f133_arg0.WeaponAttachments:setTopBottom(0, 0, 340, 464)
			f133_arg0.WeaponAttachments:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.WeaponAttachments)
			f133_arg0.EquipmentInventorySplitter:completeAnimation()
			f133_arg0.EquipmentInventorySplitter:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.EquipmentInventorySplitter)
			f133_arg0.HealthInventorySplitter:completeAnimation()
			f133_arg0.HealthInventorySplitter:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.HealthInventorySplitter)
			f133_arg0.ResourceList:completeAnimation()
			f133_arg0.ResourceList:setLeftRight(0.5, 0.5, -908, -688)
			f133_arg0.ResourceList:setTopBottom(0.5, 0.5, 289, 431)
			f133_arg0.clipFinished(f133_arg0.ResourceList)
			f133_arg0.ItemPickupList:completeAnimation()
			f133_arg0.ItemPickupList:setTopBottom(0, 0, 96, 386)
			f133_arg0.ItemPickupList:setAlpha(1)
			f133_arg0.clipFinished(f133_arg0.ItemPickupList)
			f133_arg0.StartMenuArmorPlatesList:completeAnimation()
			f133_arg0.StartMenuArmorPlatesList:setLeftRight(0.5, 0.5, -908, -693)
			f133_arg0.StartMenuArmorPlatesList:setTopBottom(0.5, 0.5, 55, 187)
			f133_arg0.clipFinished(f133_arg0.StartMenuArmorPlatesList)
		end,
	},
	PCShowAttachments = {
		DefaultClip = function(f134_arg0, f134_arg1)
			f134_arg0:__resetProperties()
			f134_arg0:setupElementClipCounter(7)
			f134_arg0.CurrentWeaponImage:completeAnimation()
			f134_arg0.CurrentWeaponImage:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.CurrentWeaponImage)
			f134_arg0.CurrentWeaponImagePC:completeAnimation()
			f134_arg0.CurrentWeaponImagePC:setTopBottom(0, 0, 96, 309)
			f134_arg0.clipFinished(f134_arg0.CurrentWeaponImagePC)
			f134_arg0.AmmoList:completeAnimation()
			f134_arg0.AmmoList:setLeftRight(0.5, 0.5, -908, -688)
			f134_arg0.AmmoList:setTopBottom(0, 0, 96, 848)
			f134_arg0.clipFinished(f134_arg0.AmmoList)
			f134_arg0.inventoryDescription:completeAnimation()
			f134_arg0.inventoryDescription:setLeftRight(0.5, 0.5, -657, -345)
			f134_arg0.inventoryDescription:setTopBottom(0.5, 0.5, -376, -176)
			f134_arg0.inventoryDescription:setAlpha(1)
			f134_arg0.clipFinished(f134_arg0.inventoryDescription)
			f134_arg0.WeaponAttachments:completeAnimation()
			f134_arg0.WeaponAttachments:setLeftRight(0.5, 0.5, 392, 1044)
			f134_arg0.WeaponAttachments:setTopBottom(0, 0, 340, 464)
			f134_arg0.WeaponAttachments:setAlpha(1)
			f134_arg0.clipFinished(f134_arg0.WeaponAttachments)
			f134_arg0.EquipmentInventorySplitter:completeAnimation()
			f134_arg0.EquipmentInventorySplitter:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.EquipmentInventorySplitter)
			f134_arg0.HealthInventorySplitter:completeAnimation()
			f134_arg0.HealthInventorySplitter:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.HealthInventorySplitter)
			f134_arg0.ResourceList:completeAnimation()
			f134_arg0.ResourceList:setLeftRight(0.5, 0.5, -908, -688)
			f134_arg0.ResourceList:setTopBottom(0.5, 0.5, 289, 431)
			f134_arg0.clipFinished(f134_arg0.ResourceList)
			f134_arg0.ItemPickupList:completeAnimation()
			f134_arg0.ItemPickupList:setTopBottom(0, 0, 96, 386)
			f134_arg0.ItemPickupList:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.ItemPickupList)
			f134_arg0.StartMenuArmorPlatesList:completeAnimation()
			f134_arg0.StartMenuArmorPlatesList:setLeftRight(0.5, 0.5, -908, -693)
			f134_arg0.StartMenuArmorPlatesList:setTopBottom(0.5, 0.5, 55, 187)
			f134_arg0.clipFinished(f134_arg0.StartMenuArmorPlatesList)
		end,
	},
	PC = {
		DefaultClip = function(f135_arg0, f135_arg1)
			f135_arg0:__resetProperties()
			f135_arg0:setupElementClipCounter(7)
			f135_arg0.CurrentWeaponImage:completeAnimation()
			f135_arg0.CurrentWeaponImage:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.CurrentWeaponImage)
			f135_arg0.CurrentWeaponImagePC:completeAnimation()
			f135_arg0.CurrentWeaponImagePC:setTopBottom(0, 0, 96, 309)
			f135_arg0.clipFinished(f135_arg0.CurrentWeaponImagePC)
			f135_arg0.AmmoList:completeAnimation()
			f135_arg0.AmmoList:setLeftRight(0.5, 0.5, -908, -688)
			f135_arg0.AmmoList:setTopBottom(0, 0, 96, 848)
			f135_arg0.clipFinished(f135_arg0.AmmoList)
			f135_arg0.inventoryDescription:completeAnimation()
			f135_arg0.inventoryDescription:setLeftRight(0.5, 0.5, -657, -345)
			f135_arg0.inventoryDescription:setTopBottom(0.5, 0.5, -376, -176)
			f135_arg0.clipFinished(f135_arg0.inventoryDescription)
			f135_arg0.WeaponAttachments:completeAnimation()
			f135_arg0.WeaponAttachments:setLeftRight(0.5, 0.5, 392, 1044)
			f135_arg0.WeaponAttachments:setTopBottom(0, 0, 340, 464)
			f135_arg0.WeaponAttachments:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.WeaponAttachments)
			f135_arg0.EquipmentInventorySplitter:completeAnimation()
			f135_arg0.EquipmentInventorySplitter:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.EquipmentInventorySplitter)
			f135_arg0.HealthInventorySplitter:completeAnimation()
			f135_arg0.HealthInventorySplitter:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.HealthInventorySplitter)
			f135_arg0.ResourceList:completeAnimation()
			f135_arg0.ResourceList:setLeftRight(0.5, 0.5, -908, -688)
			f135_arg0.ResourceList:setTopBottom(0.5, 0.5, 289, 431)
			f135_arg0.clipFinished(f135_arg0.ResourceList)
			f135_arg0.ItemPickupList:completeAnimation()
			f135_arg0.ItemPickupList:setTopBottom(0, 0, 96, 386)
			f135_arg0.ItemPickupList:setAlpha(0)
			f135_arg0.clipFinished(f135_arg0.ItemPickupList)
			f135_arg0.StartMenuArmorPlatesList:completeAnimation()
			f135_arg0.StartMenuArmorPlatesList:setLeftRight(0.5, 0.5, -908, -693)
			f135_arg0.StartMenuArmorPlatesList:setTopBottom(0.5, 0.5, 55, 187)
			f135_arg0.clipFinished(f135_arg0.StartMenuArmorPlatesList)
		end,
	},
	ShowAttachments = {
		DefaultClip = function(f136_arg0, f136_arg1)
			f136_arg0:__resetProperties()
			f136_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.StartMenu_Inventory.__onClose = function(f137_arg0)
	f137_arg0.__on_close_removeOverrides()
	f137_arg0.CurrentWeaponImage:close()
	f137_arg0.CurrentWeaponImagePC:close()
	f137_arg0.InventoryList:close()
	f137_arg0.AmmoList:close()
	f137_arg0.inventoryDescription:close()
	f137_arg0.WeaponAttachments:close()
	f137_arg0.Health:close()
	f137_arg0.Gear:close()
	f137_arg0.Storage:close()
	f137_arg0.Equipment:close()
	f137_arg0.EquipmentInventorySplitter:close()
	f137_arg0.HealthInventorySplitter:close()
	f137_arg0.ResourceList:close()
	f137_arg0.PCKoreaContentDescriptorsContainer:close()
	f137_arg0.ItemPickupList:close()
	f137_arg0.WarzoneGameStatusIndicatorDisplayLeft:close()
	f137_arg0.QuitButton:close()
	f137_arg0.WarzoneGameStatusIndicatorDisplayLeft2:close()
	f137_arg0.StartMenuArmorPlatesList:close()
	f137_arg0.InventorySplitterPC:close()
	f137_arg0.StartMenuInventoryDualWeapons:close()
end
